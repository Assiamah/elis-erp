-- Copy an existing job's plotting and registration records and initialize its
-- milestone, comment, and TAT rows under a new job number. The source transaction_number is retained.
CREATE OR REPLACE FUNCTION csau.online_select_process_acknowledgement_not_on_case_exist_cj_copy(
    application_details text)
RETURNS text
LANGUAGE plpgsql
VOLATILE
AS $BODY$
DECLARE
    request_rows json DEFAULT application_details;
    request_row RECORD;
    source_transaction_number text;
    source_business_process_id integer;
    source_business_process_sub_id integer;
    insert_columns text;
    select_columns text;
    inserted_rows integer;
    new_job_number text;
    existing_job_number text;
    existing_case_number text;
BEGIN
    FOR request_row IN
        SELECT *
          FROM json_to_recordset(request_rows) AS x(
              job_number text,
              case_number text,
              source_job_number text,
              business_process_id integer,
              business_process_sub_id integer,
              fullname text,
              userid text
          )
    LOOP
        new_job_number := NULLIF(BTRIM(request_row.job_number), '');
        existing_case_number := NULLIF(BTRIM(request_row.case_number), '');
        existing_job_number := NULLIF(BTRIM(request_row.source_job_number), '');

        IF new_job_number IS NULL OR existing_case_number IS NULL OR existing_job_number IS NULL THEN
            RAISE EXCEPTION 'Copying a job requires job_number, case_number, and source_job_number';
        END IF;

        SELECT transaction_number,
               business_process_id,
               business_process_sub_id
          INTO source_transaction_number,
               source_business_process_id,
               source_business_process_sub_id
          FROM csau.lrd_registration_sub_process
         WHERE case_number = existing_case_number
           AND job_number = existing_job_number;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'No registration row found for case % and job %',
                existing_case_number, existing_job_number;
        END IF;

        -- Plotting details are indexed by case_number in the review workflow;
        -- the source plotting row may not carry the registration job_number.
        -- Clone all plotting rows for the case and replace only job_number.
        -- Omit generated columns and default-backed primary-key columns.
        -- DECLARE
        --     plotting_columns text;
        --     plotting_select text;
        -- BEGIN
        --     SELECT string_agg(format('%I', a.attname), ', ' ORDER BY a.attnum),
        --            string_agg(
        --                CASE WHEN a.attname = 'job_number'
        --                     THEN '$2::text'
        --                     ELSE format('source_row.%I', a.attname)
        --                END,
        --                ', ' ORDER BY a.attnum)
        --       INTO plotting_columns, plotting_select
        --       FROM pg_attribute a
        --      WHERE a.attrelid = 'csau_geospatial.lc_plan_approval_plottings'::regclass
        --        AND a.attnum > 0
        --        AND NOT a.attisdropped
        --        AND a.attgenerated = ''
        --        AND a.attidentity = ''
        --        AND NOT (
        --            EXISTS (
        --                SELECT 1
        --                  FROM pg_index i,
        --                       unnest(i.indkey) AS primary_key_column(attnum)
        --                 WHERE i.indrelid = a.attrelid
        --                   AND i.indisprimary
        --                   AND primary_key_column.attnum = a.attnum
        --            )
        --            AND a.atthasdef
        --        );

        --     IF plotting_columns IS NULL THEN
        --         RAISE EXCEPTION 'No insertable columns found for csau_geospatial.lc_plan_approval_plottings';
        --     END IF;

        --     EXECUTE format(
        --         'INSERT INTO csau_geospatial.lc_plan_approval_plottings (%s) '
        --         'SELECT %s FROM csau_geospatial.lc_plan_approval_plottings source_row '
        --         'WHERE source_row.case_number = $1',
        --         plotting_columns, plotting_select
        --     ) USING existing_case_number, new_job_number;
        --     GET DIAGNOSTICS inserted_rows = ROW_COUNT;

        --     IF inserted_rows = 0 THEN
        --         RAISE EXCEPTION 'No source plotting row found for case %', existing_case_number;
        --     END IF;
        -- END;

        -- Clone the registration record and replace only job_number. Its
        -- transaction_number remains the original job's transaction number.
        SELECT string_agg(format('%I', a.attname), ', ' ORDER BY a.attnum),
               string_agg(
                   CASE WHEN a.attname = 'job_number'
                        THEN '$3::text'
                        ELSE format('source_row.%I', a.attname)
                   END,
                   ', ' ORDER BY a.attnum)
          INTO insert_columns, select_columns
          FROM pg_attribute a
         WHERE a.attrelid = 'csau.lrd_registration_sub_process'::regclass
           AND a.attnum > 0
           AND NOT a.attisdropped
           AND a.attgenerated = ''
           AND a.attidentity = ''
           AND NOT (
               EXISTS (
                   SELECT 1
                     FROM pg_index i,
                          unnest(i.indkey) AS primary_key_column(attnum)
                    WHERE i.indrelid = a.attrelid
                      AND i.indisprimary
                      AND primary_key_column.attnum = a.attnum
               )
               AND a.atthasdef
           );

        IF insert_columns IS NULL THEN
            RAISE EXCEPTION 'No insertable columns found for csau.lrd_registration_sub_process';
        END IF;

        EXECUTE format(
            'INSERT INTO csau.lrd_registration_sub_process (%s) '
            'SELECT %s FROM csau.lrd_registration_sub_process source_row '
            'WHERE source_row.case_number = $1 AND source_row.job_number = $2',
            insert_columns, select_columns
        ) USING existing_case_number, existing_job_number, new_job_number;
        GET DIAGNOSTICS inserted_rows = ROW_COUNT;

        IF inserted_rows <> 1 THEN
            RAISE EXCEPTION 'Expected one source registration row for case % and job %, found %',
                existing_case_number, existing_job_number, inserted_rows;
        END IF;

        INSERT INTO csau.lc_application_mile_stone_each
            (milestone_description,
             mile_stone_status,
             mile_stone_option,
             job_number,
             sent_by,
             sent_by_id,
             start_date,
             received_by,
             received_by_id,
             end_date,
             working_day_required,
             milestone_app_link,
             milestone_link,
             priority_value)
        SELECT milestone_description,
               mile_stone_status,
               mile_stone_option,
               new_job_number,
               request_row.fullname,
               request_row.userid,
               CURRENT_DATE,
               request_row.fullname,
               request_row.userid,
               CURRENT_DATE,
               working_day_required,
               milestone_app_link,
               milestone_link,
               priority_value
          FROM csau.lc_application_mile_stone
         WHERE business_process_id = source_business_process_id
           AND business_process_sub_id = source_business_process_sub_id;

        INSERT INTO csau.lc_comments_on_application
            (jn_id,
             job_number,
             officers_general_comments,
             officers_recommendation,
             officers_remarks,
             division,
             divisional_registry_unit,
             created_by,
             created_by_id,
             created_date,
             modified_by,
             modified_by_id,
             modified_date,
             year_created)
        VALUES
            (0,
             new_job_number,
             'Application was recieved by ' || request_row.fullname || ' on ' || CURRENT_DATE,
             '',
             'Pending',
             'CSAU',
             'CSAU Front Office',
             request_row.fullname,
             request_row.userid,
             CURRENT_DATE,
             request_row.fullname,
             request_row.userid,
             CURRENT_DATE,
             EXTRACT(YEAR FROM CURRENT_DATE));

        INSERT INTO csau.lc_tat_details
            (tat_case_number,
             tat_job_number,
             tat_description,
             tat_activity_date,
             tat_type,
             created_by,
             created_by_id,
             created_date,
             modified_by,
             modified_by_id,
             modified_date,
             year_created)
        VALUES
            (source_transaction_number,
             new_job_number,
             'Job has been created/started',
             CURRENT_DATE,
             'In',
             request_row.fullname,
             request_row.userid,
             CURRENT_DATE,
             request_row.fullname,
             request_row.userid,
             CURRENT_DATE,
             EXTRACT(YEAR FROM CURRENT_DATE));
    END LOOP;

    RETURN json_build_object(
        'case_number', existing_case_number,
        'job_number', new_job_number,
        'transaction_number', source_transaction_number,
        'msg', 'Existing application copied successfully'
    );
END;
$BODY$;

ALTER FUNCTION csau.online_select_process_acknowledgement_not_on_case_exist_cj_copy(text)
    OWNER TO postgres;


-- FUNCTION: csau.select_create_job_number(integer)

-- DROP FUNCTION IF EXISTS csau.select_create_job_number(integer);

CREATE OR REPLACE FUNCTION csau.select_create_job_number_for_transition(
	pid_business_process_id integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

-- <<l_Last_Line>>

DECLARE 
  
 parcel_rec   RECORD;
 job_number_gen TEXT DEFAULT '';
 job_settings_rec   RECORD;

 job_settings_cur CURSOR FOR SELECT * FROM csau.lc_job_number_generation_settings WHERE id_business_process_id = pid_business_process_id ;
BEGIN

   -- Open the cursor
   OPEN job_settings_cur;
 
   LOOP
    -- fetch row into the film
      FETCH job_settings_cur INTO job_settings_rec;
    -- exit when no more row to fetch
      EXIT WHEN NOT FOUND;
 
    -- build the output
      --IF job_settings_rec.job_settings_number LIKE '%ful%' THEN 
    job_number_gen = job_settings_rec.id_region_prefix || job_settings_rec.id_district_prefix || job_settings_rec.id_service_type_prefix || 'T' || job_settings_rec.id_current_counter_value || floor(random()*(5-1+1))+1 || floor(random()*(9-6+1))+6 || job_settings_rec.id_year_of_creation;
      

   IF EXISTS (SELECT * FROM csau.lrd_registration_sub_process WHERE job_number = job_number_gen) THEN
      UPDATE csau.lc_job_number_generation_settings SET  id_current_counter_value= job_settings_rec.id_current_counter_value + 1 WHERE id_business_process_id=pid_business_process_id;
  -- GOTO l_Last_Line;
  ELSE
  UPDATE csau.lc_job_number_generation_settings SET  id_current_counter_value= job_settings_rec.id_current_counter_value + 1 WHERE id_business_process_id=pid_business_process_id;

END IF;
               
  END LOOP;
  
   -- Close the cursor
   CLOSE job_settings_cur;

   --result_to_process= job_number_gen;
   RETURN job_number_gen;
END; 

$BODY$;

ALTER FUNCTION csau.select_create_job_number_for_transition(integer)
    OWNER TO postgres;

-- FUNCTION: csau.online_select_process_acknowledgement_not_on_case_exist(text)

-- DROP FUNCTION IF EXISTS csau.online_select_process_acknowledgement_not_on_case_exist(text);

CREATE OR REPLACE FUNCTION csau.online_select_process_acknowledgement_not_on_case_exist_gjn(
	application_details text)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
new_jason json DEFAULT application_details;
new_case_number TEXT DEFAULT '';
new_job_number TEXT DEFAULT '';
new_regional_number TEXT DEFAULT '';
new_transaction_number TEXT DEFAULT '';
new_client_id TEXT DEFAULT '';
--new_start_number INTEGER := 0 ;
new_division TEXT DEFAULT '';

new_batch_number TEXT DEFAULT '';
--new_client_email TEXT DEFAULT '';
--new_ref_number TEXT DEFAULT '';

--new_created_for TEXT DEFAULT '';
  --new_created_for_id TEXT DEFAULT '';
  --new_application_required_additional_bill TEXT DEFAULT '';

application_details_rec RECORD;

application_details_cur CURSOR FOR select * from json_to_recordset(new_jason) as
x (
"ar_name"text,
"locality_of_parcel"text,
"type_of_interest"text,
"business_process_id" int,
"business_process_sub_id" int,
"business_process_name"text,
"business_process_sub_name"text,
"land_size"text,
"type_of_instrument"text,
"type_of_use"text,
"fullname"text,
"userid"text
);

BEGIN

-- Open the cursor
OPEN application_details_cur;

LOOP
-- fetch row into the film
FETCH application_details_cur INTO application_details_rec;
-- exit when no more row to fetch
EXIT WHEN NOT FOUND;

-- build the output

new_case_number = csau.select_create_case_number();
new_job_number = csau.select_create_job_number_for_transition(application_details_rec.business_process_id);

new_client_id = csau.select_create_client_id();

new_transaction_number= csau.select_create_transaction_number();
new_division = csau.select_division_by_business_process(application_details_rec.business_process_id);

-- SELECT ref_number, created_for_id, created_for,
--   created_for_id,
--   application_required_additional_bill 
-- 
--   into new_ref_number,new_client_email ,new_created_for,
--   new_created_for_id,
--   new_application_required_additional_bill  FROM csau.lrd_registration_sub_process_dashboard
--   WHERE ref_number=application_details_rec.job_number LIMIT 1 ;

INSERT INTO csau_geospatial.lc_plan_approval_plottings(

job_number,
case_number,
regional_number,
locality,
licensed_no,
district,
region,
extent,
land_size
)
VALUES (
new_job_number,
new_case_number,
new_regional_number,
application_details_rec.locality_of_parcel,
'',
'',
'',
application_details_rec.land_size,
application_details_rec.land_size
);

INSERT INTO csau.lrd_registration_sub_process (
transaction_number,
job_number,
ar_name,
	case_number,
business_process_id,
business_process_name,
job_purpose,
job_status,
job_datesend,
job_recieved_by,
job_forwarded_by,
job_recieved_by_id,
job_forwarded_by_id,

current_division_of_application,
current_application_status,
remark_or_comment,
is_filed,
file_number,
filed_by_id,
filed_by_name,
filed_date,
is_completed,
completed_date,
completed_by_id,
completed_by_name,
is_collected,
collected_by,
collected_by_id_type,
collected_by_id_number,
collected_date,
collection_issued_by_id,
collection_issued_by_name,
record_inbox_status,
created_by,
created_by_id,
created_date,
modified_by,
modified_by_id,
modified_date,
year_created,
isbatched,
isreadyforbatch,
batch_number,
batch_date,
batched_by,
batched_by_id,
business_process_sub_id,
business_process_sub_name,
divisional_registry_unit,
old_file_record_numbers,
 created_for,
  created_for_id,
  application_required_additional_bill,
  application_stage,
	locality,
is_process_at_division_registry)

VALUES (
new_transaction_number,
new_job_number,
	application_details_rec.ar_name,
new_case_number,
application_details_rec.business_process_id,
application_details_rec.business_process_name,
'',
'',
CURRENT_DATE,
application_details_rec.fullname,
application_details_rec.fullname,
application_details_rec.userid,
application_details_rec.userid,

new_division,
'Pending',
'',
false,
'',
'',
application_details_rec.userid,
CURRENT_DATE,
false,
CURRENT_DATE,
application_details_rec.userid,
application_details_rec.userid,
false,
application_details_rec.userid,
'',
'',
CURRENT_DATE,
application_details_rec.userid,
application_details_rec.userid,
0,
application_details_rec.fullname,
application_details_rec.userid,
CURRENT_DATE,
application_details_rec.fullname,
application_details_rec.userid,
CURRENT_DATE,
EXTRACT(YEAR FROM CURRENT_DATE),
false,
false,
'',
CURRENT_DATE,
application_details_rec.userid,
0,
application_details_rec.business_process_sub_id,
application_details_rec.business_process_sub_name,
new_division,
'',
 application_details_rec.fullname,
 application_details_rec.userid,
  'No',
  0, application_details_rec.locality_of_parcel,
false);

INSERT INTO csau.lrd_registration_processing (
ar_name,
is_certificate_number_generated,
case_number,
transaction_number,
date_of_document,
nature_of_instrument,
certificate_number,
type_of_interest,
type_of_use,
volume_number,
folio_number,
term,
commencement_date,
renewal_term,
consideration_fee,
stamp_duty_payable,
assessed_value,
parcel_description,
plot_number,
publicity_date,
family_of_grantor,
rent_review_period,
annual_rent,
rent_period_covered,
rent_review_date,
date_of_first_payment,
outstanding_rent,
remark_or_comment,
date_of_registration,
case_status,

created_by,
created_by_id,
created_date,
modified_by,
modified_by_id,
modified_date,
year_created,
certificate_type,
case_process_stage)

VALUES (
application_details_rec.ar_name,
0,
new_case_number,
new_transaction_number,
NULL,
application_details_rec.type_of_instrument,
'',
-- application_details_rec.land_size,
-- '',
'',
application_details_rec.type_of_use,
'',
'',
'0',
NULL,
'0',
'0',
0,
0,
'',
'',
NULL,

-- '',
'',
0,
0,
'',
NULL,
NULL,
0,
'',
NULL,
'CaseStatus.1',
application_details_rec.fullname,
application_details_rec.userid,
CURRENT_TIMESTAMP,
application_details_rec.fullname,
application_details_rec.userid,
CURRENT_DATE,
EXTRACT(YEAR FROM CURRENT_DATE),
'',
1);

INSERT INTO csau.lc_application_mile_stone_each
(milestone_description
,mile_stone_status
,mile_stone_option
,job_number
,sent_by
,sent_by_id
,start_date
,received_by
,received_by_id
,end_date
,working_day_required
,milestone_app_link
,milestone_link
,priority_value)

SELECT
milestone_description
,mile_stone_status
,mile_stone_option
, new_job_number,
application_details_rec.fullname,
application_details_rec.userid,
CURRENT_DATE ,
application_details_rec.fullname,
application_details_rec.userid,
CURRENT_DATE,
working_day_required,
milestone_app_link,
milestone_link,
priority_value

FROM csau.lc_application_mile_stone

WHERE business_process_id=application_details_rec.business_process_id AND business_process_sub_id=application_details_rec.business_process_sub_id;

INSERT INTO csau.lc_comments_on_application(
jn_id,
job_number,
officers_general_comments,
officers_recommendation,
officers_remarks,
division,
divisional_registry_unit,
created_by,
created_by_id,
created_date,
modified_by,
modified_by_id,
modified_date,
year_created)
VALUES (
0,
new_job_number,
'Application was recieved by ' || application_details_rec.fullname || ' on ' || CURRENT_DATE,
'',
'Pending',
'CSAU',
'CSAU Front Office',
application_details_rec.fullname,
application_details_rec.userid,
CURRENT_DATE ,
application_details_rec.fullname,
application_details_rec.userid,
CURRENT_DATE,
EXTRACT(YEAR FROM CURRENT_DATE));

INSERT INTO csau.lc_tat_details(
tat_case_number,
tat_job_number,
tat_description,
tat_activity_date,
tat_type,
created_by,
created_by_id,
created_date,
modified_by,
modified_by_id,
modified_date,
year_created)
VALUES (
new_transaction_number,
new_job_number,
'Job has been created/started',
CURRENT_DATE,
'In',
application_details_rec.fullname,
application_details_rec.userid,
CURRENT_DATE ,
application_details_rec.fullname,
application_details_rec.userid,
CURRENT_DATE ,
EXTRACT(YEAR FROM CURRENT_DATE));

INSERT INTO csau.address_register(
ar_client_id,
job_number,
ar_name,
ar_gender,
ar_cell_phone,
ar_email,
ar_fax,
ar_nationality,
ar_address,
ar_tin_no,
ar_id_type,
ar_id_number,
ar_location,
ar_district,
ar_region,
ar_person_type,
ar_non_natural_person_type,
ar_cell_phone2,
ar_contact_person_name,
ar_ownership_identifier,
created_by, created_by_id,
created_date,
modified_by,
modified_by_id,
modified_date,
year_created
)
VALUES(
new_client_id,
new_transaction_number,
application_details_rec.ar_name,
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'',
application_details_rec.userid ,
application_details_rec.userid,
CURRENT_DATE ,
application_details_rec.userid ,
application_details_rec.userid,
CURRENT_DATE,
EXTRACT(YEAR FROM CURRENT_DATE));

--WHERE email=new_client_email;

--UPDATE csau.party SET case_number=new_case_number,
-- modified_by=application_details_rec.userid,modified_by_id=application_details_rec.userid,modified_date=CURRENT_DATE
-- where case_number=new_job_number;

INSERT INTO csau.party(case_number, ar_client_id, type_of_party, created_by,
created_by_id, created_date, modified_by, modified_by_id, modified_date,
year_created)
VALUES (new_transaction_number, new_client_id, 'Applicant', application_details_rec.userid ,
application_details_rec.userid,
CURRENT_DATE ,
application_details_rec.userid ,
application_details_rec.userid,
CURRENT_DATE,
EXTRACT(YEAR FROM CURRENT_DATE));

--UPDATE csau.lrd_registration_sub_process_dashboard SET isprocesstomainstream= 't' where job_number=new_job_number;

--UPDATE csau.lc_job_number_payment_bill SET job_number= new_job_number WHERE job_number=application_details_rec.job_number;

-- INSERT INTO csau.lc_outgoing_sms(
-- sms_message,
-- sms_receiver_number,
-- sms_sent_status,
-- sms_job_number,
-- sms_client_name,
-- sms_milestone_number,
-- sms_created_by,
-- sms_created_by_id)
-- VALUES (
-- vr_milestone_text_message,
-- vr_client_number,
-- 0,
-- vr_job_number,
-- vr_client_name,
-- vr_current_step_number,
-- vr_created_by,
-- vr_created_by_id);

END LOOP;

--UPDATE csau.online_agent_accounts SET oaa_account_amount= oaa_account_amount-32.00 WHERE oaa_id=1;

-- Close the cursor
CLOSE application_details_cur;

RETURN json_build_object(
'case_number',new_case_number ,
'job_number',new_job_number ,
'msg', 'Request has been processed successfully');

END;
$BODY$;

ALTER FUNCTION csau.online_select_process_acknowledgement_not_on_case_exist_gjn(text)
    OWNER TO postgres;

-- FUNCTION: csau.load_application_details_by_job_number_all(text)

-- DROP FUNCTION IF EXISTS csau.load_application_details_by_job_number_all(text);

CREATE OR REPLACE FUNCTION csau.load_application_details_by_job_number_all(
	vr_job_number text)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE 

   json_result_obj TEXT DEFAULT '';
 
 
BEGIN

  json_result_obj= json_build_object('success',true,'data',array_to_json(array_agg(row_to_json(t))))

 from (
	 
	 SELECT 
	m.case_number,
    l.transaction_number,
    l.job_number,
    l.business_process_id,
    l.business_process_name,
	l.current_application_status,
	l.created_for,
    l.created_for_id,
	l.business_process_sub_id,
    l.business_process_sub_name,
	m.ar_name,	 
    l.job_purpose,
    l.job_status,
    to_char(l.job_datesend, 'mm/dd/yyyy'::text)::date AS job_datesend,
    l.job_recieved_by,
    l.job_forwarded_by,
    l.job_recieved_by_id,
    l.job_forwarded_by_id,
    l.current_division_of_application,
	c.land_size,
    c.licensed_no,
	c.regional_number,
    c.locality,
	l.region_code,
	l.regional_name
	 
   FROM csau.lrd_registration_sub_process l
     JOIN csau.lrd_registration_processing m ON l.transaction_number = m.transaction_number::text
     JOIN csau_geospatial.lc_plan_approval_plottings c ON c.case_number::text = m.case_number::text

 WHERE l.job_number=vr_job_number OR 
	   m.case_number=vr_job_number OR 
	   l.transaction_number=vr_job_number OR 
	   c.regional_number=vr_job_number OR 
	   c.glpin=vr_job_number OR
	   m.file_number = vr_job_number) t;

IF  json_result_obj IS NULL THEN
     json_result_obj = 'Error in loading Data';
 
END IF;
   
  
  RETURN json_result_obj;
END;
$BODY$;

ALTER FUNCTION csau.load_application_details_by_job_number_all(text)
    OWNER TO postgres;

