-- Based on the original full function supplied by the user.
-- Apply before deploying the ERP change. Omitted section returns the full response.
CREATE OR REPLACE FUNCTION vas.select_review_digital_workflow_short(
    application_details TEXT
)
RETURNS TEXT
LANGUAGE plpgsql
VOLATILE
PARALLEL UNSAFE
AS $BODY$

DECLARE
    v_input JSONB;
    v_section TEXT;

    json_result_obj JSONB := '{}'::JSONB;

    new_p_transaction_number TEXT;
    new_business_process_id INTEGER := 0;
    new_business_process_sub_id INTEGER := 0;

    vr_interest_number TEXT;

    vr_new_baby_step_milestone JSONB := '[]'::JSONB;

    vr_application_stage_baby_step INTEGER := 0;
    vr_application_stage_main_step INTEGER := 0;

    vr_application_stage_main_step_code TEXT;
    vr_application_stage_baby_step_code TEXT;

    p_transaction_number TEXT;
    p_job_number TEXT;

    vr_ms_id_m INTEGER;

    v_job csau.lrd_registration_sub_process%ROWTYPE;

    v_parcel_details JSONB;
    v_parcel_wkt TEXT;

BEGIN

    ------------------------------------------------------------------
    -- 1. PARSE INPUT ONCE
    ------------------------------------------------------------------

    v_input := application_details::JSONB;
    v_section := COALESCE(v_input ->> 'section', 'all');
    IF v_section NOT IN ('all', 'initial', 'workflow', 'jobs', 'parties', 'payments', 'minutes', 'records', 'queries', 'encumbrances', 'links', 'objections', 'letters') THEN
        RETURN jsonb_build_object('success', FALSE, 'message', 'Unknown section')::TEXT;
    END IF;

    p_transaction_number := v_input ->> 'case_number';
    p_job_number := v_input ->> 'job_number';

    IF p_job_number IS NULL OR BTRIM(p_job_number) = '' THEN
        RETURN jsonb_build_object(
            'success', FALSE,
            'message', 'job_number is required'
        )::TEXT;
    END IF;


    ------------------------------------------------------------------
    -- 2. LOAD MAIN JOB RECORD ONCE
    ------------------------------------------------------------------

    SELECT *
    INTO v_job
    FROM csau.lrd_registration_sub_process
    WHERE job_number = p_job_number
    ORDER BY jn_id DESC
    LIMIT 1;

    IF NOT FOUND THEN
        RETURN jsonb_build_object(
            'success', FALSE,
            'message', 'Job number not found',
            'job_number', p_job_number
        )::TEXT;
    END IF;


    new_p_transaction_number := v_job.case_number;
    p_transaction_number := v_job.transaction_number;

    new_business_process_id := v_job.business_process_id;
    new_business_process_sub_id := v_job.business_process_sub_id;

    vr_application_stage_baby_step :=
        COALESCE(v_job.application_stage_baby_step, 0);

    vr_application_stage_main_step :=
        COALESCE(v_job.application_stage_main_step, 0);

    vr_application_stage_main_step_code :=
        v_job.application_stage_main_step_code;

    vr_application_stage_baby_step_code :=
        v_job.application_stage_baby_step_code;


    -- Section requests read only their original query and never initialize workflow.
    IF v_section NOT IN ('all', 'initial', 'workflow') THEN
        RETURN jsonb_build_object('success', TRUE, 'data', CASE v_section
            WHEN 'jobs' THEN COALESCE(((SELECT array_to_json(array_agg(row_to_json(q)))

from (SELECT jn_id, transaction_number, job_number, business_process_id, business_process_name,
job_purpose, job_status, job_datesend, job_recieved_by, job_forwarded_by,
job_recieved_by_id, job_forwarded_by_id, current_division_of_application,
current_application_status,  remark_or_comment, is_filed,
file_number, filed_by_id, filed_by_name, filed_date, is_completed,
completed_date, completed_by_id, completed_by_name, is_collected,
collected_by, collected_by_id_type, collected_by_id_number, collected_date,
collection_issued_by_id, collection_issued_by_name, created_by,
created_by_id, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, 
    modified_by, modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date,
year_created, record_inbox_status, isbatched, isreadyforbatch,
batch_number, batch_date, batched_by, batched_by_id, business_process_sub_id,
business_process_sub_name, divisional_registry_unit, old_file_record_numbers,
application_priority_level, application_stage, created_date
FROM csau.lrd_registration_sub_process Where transaction_number=p_transaction_number) q))::JSONB, '[]'::JSONB)
            WHEN 'parties' THEN COALESCE(((SELECT array_to_json(array_agg(row_to_json(l)))

from (SELECT a.ar_id, a.ar_client_id, a.ar_name, a.ar_gender, a.ar_cell_phone, a.ar_cell_phone2,
a.ar_fax, a.ar_email, a.ar_nationality, a.ar_address, a.ar_tin_no, a.ar_id_type,
a.ar_id_number, a.ar_location, a.ar_district, a.ar_region, a.ar_person_type,
a.ar_non_natural_person_type, a.ar_contact_person_name, a.ar_ownership_identifier,
a.created_by, a.created_by_id, a.created_date, a.modified_by,a. modified_by_id, p.p_uid,
a.modified_date, a.year_created, p.type_of_party FROM csau.party p INNER JOIN csau.address_register a ON p.ar_client_id = a.ar_client_id where p.case_number = p_transaction_number) l))::JSONB, '[]'::JSONB)
            WHEN 'payments' THEN COALESCE(((SELECT array_to_json(array_agg(row_to_json(g)))

from (SELECT  bill_amount, payment_slip_number, payment_mode, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, ref_number, payment_status,
payment_amount, (to_char(payment_date, 'DD Mon YYYY | HH12:MI:SS')) AS payment_date
FROM csau.lrd_registration_sub_process_dashboard Where job_number=p_job_number ORDER BY created_date) g))::JSONB, '[]'::JSONB)
            WHEN 'minutes' THEN COALESCE(((SELECT array_to_json(array_agg(row_to_json(k)))

from (SELECT am_id, am_case_number, am_job_number, am_description, am_from_officer,
am_from_position, am_to_officer, am_to_position, am_activity_date,
am_status, created_by, created_by_id, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date , modified_by,
modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date , year_created
FROM csau.lc_application_minutes Where am_case_number=new_p_transaction_number) k))::JSONB, '[]'::JSONB)
            WHEN 'records' THEN COALESCE(((SELECT array_to_json(array_agg(row_to_json(k)))

from (SELECT an_id, an_status, an_description,  created_by, an_division as division, an_type as type, 
	  (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date , modified_by,
	  (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date
FROM csau.lc_application_notes Where an_case_number=new_p_transaction_number) k))::JSONB, '[]'::JSONB)
            WHEN 'queries' THEN COALESCE(((SELECT array_to_json(array_agg(row_to_json(g)))

from (SELECT qid, job_number, case_number, status, reasons, query_response, remarks, created_by,
created_by_id, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, modified_by, 
    modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date,
year_created, query_general_reason, query_response, attachment_required
FROM csau.lc_case_query Where case_number=new_p_transaction_number  ORDER BY created_date DESC) g))::JSONB, '[]'::JSONB)
            WHEN 'encumbrances' THEN COALESCE(((SELECT array_to_json(array_agg(row_to_json(e)))

from (SELECT es_id, case_number, es_date_of_instrument, (to_char(es_date_of_registration, 'YYYY-mm-dd')) AS es_date_of_registration,
es_registered_number, es_memorials, es_back, es_forward, es_remarks,
es_signature, created_by, created_by_id, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, modified_by,
modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date, year_created, es_entry_number
FROM csau.lrd_encumbrances_section Where case_number=new_p_transaction_number) e))::JSONB, '[]'::JSONB)
            WHEN 'links' THEN COALESCE(((SELECT array_to_json(array_agg(row_to_json(h)))

from (SELECT id, job_number, case_number, mc_job_number, mc_case_number, mc_type_of_relationship, created_by, created_by_id, created_date, modified_by, modified_by_id, modified_date, year_created
	FROM csau.lc_mother_child_relation_details Where case_number=new_p_transaction_number ORDER BY created_date DESC) h))::JSONB, '[]'::JSONB)
            WHEN 'objections' THEN COALESCE(((SELECT array_to_json(array_agg(row_to_json(g)))

from (SELECT id, job_number, case_number, objector_name, objector_address,
objector_contact, status, reasons, remarks, created_by, created_by_id,
(to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, modified_by, 
    modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date, year_created
FROM csau.lc_case_objection Where case_number=new_p_transaction_number ORDER BY created_date DESC) g))::JSONB, '[]'::JSONB)
            WHEN 'letters' THEN COALESCE(((SELECT array_to_json(array_agg(row_to_json(g)))

from (SELECT id, job_number, case_number, letter_type, letter_template, carbon_copy, created_by, 
            created_by_id, 
(to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date
FROM csau.lc_case_letters Where job_number=p_job_number ORDER BY created_date DESC) g))::JSONB, '[]'::JSONB)
        END)::TEXT;
    END IF;

    ------------------------------------------------------------------
    -- 3. INITIALIZE WORKFLOW IF MISSING
    ------------------------------------------------------------------

    IF v_section IN ('all', 'initial') AND NOT EXISTS (
        SELECT 1
        FROM csau.lc_application_mile_stone_baby_steps_each
        WHERE job_number = p_job_number
          AND workflow_type = 'main_application_workflow'
    )
    THEN

        --------------------------------------------------------------
        -- Prevent duplicate initialization if two requests hit
        -- same job at the same time
        --------------------------------------------------------------

        PERFORM pg_advisory_xact_lock(
            hashtext(p_job_number)
        );

        --------------------------------------------------------------
        -- Recheck after acquiring lock
        --------------------------------------------------------------

        IF NOT EXISTS (
            SELECT 1
            FROM csau.lc_application_mile_stone_baby_steps_each
            WHERE job_number = p_job_number
              AND workflow_type = 'main_application_workflow'
        )
        THEN

            UPDATE csau.lrd_registration_sub_process
            SET
                application_stage_baby_step = 1,
                application_stage_main_step = 1
            WHERE job_number = p_job_number;


            vr_application_stage_baby_step := 1;
            vr_application_stage_main_step := 1;


            ----------------------------------------------------------
            -- MAIN MILESTONES
            ----------------------------------------------------------

            INSERT INTO csau.lc_application_mile_stone_each
            (
                ms_id_m,
                milestone_description,
                mile_stone_status,
                mile_stone_option,
                job_number,
                working_day_required,
                milestone_app_link,
                milestone_link,
                priority_value,
                milestone_text_message,
                milestone_app_message,
                workflow_type
            )
            SELECT
                ms_id,
                milestone_description,
                mile_stone_status,
                mile_stone_option,
                p_job_number,
                working_day_required,
                milestone_app_link,
                milestone_link,
                priority_value,
                milestone_text_message,
                milestone_app_message,
                'main_application_workflow'
            FROM csau.lc_application_mile_stone
            WHERE business_process_id =
                  new_business_process_id
              AND business_process_sub_id =
                  new_business_process_sub_id;


            ----------------------------------------------------------
            -- BABY STEPS
            ----------------------------------------------------------

            INSERT INTO csau.lc_application_mile_stone_baby_steps_each
            (
                bse_description,
                bse_status,
                bse_option,
                bse_priority_value,
                bse_working_day_required,
                job_number,
                ms_id_m,
                bse_description_key,
                bse_process_priority_level,
                bse_access_level,
                workflow_type
            )
            SELECT
                bs_description,
                bs_status,
                bs_option,
                bs_priority_value,
                bs_working_day_required,
                p_job_number,
                ms_id,
                bs_description_key,
                bs_process_priority_level,
                bs_access_level,
                'main_application_workflow'
            FROM csau.lc_application_mile_stone_baby_steps
            WHERE business_process_id =
                  new_business_process_id
              AND business_process_sub_id =
                  new_business_process_sub_id;


            ----------------------------------------------------------
            -- SET FIRST STEP ONGOING
            ----------------------------------------------------------

            UPDATE csau.lc_application_mile_stone_baby_steps_each
            SET
                bse_status = 'Ongoing',
                bse_option = FALSE
            WHERE job_number = p_job_number
              AND workflow_type =
                  'main_application_workflow'
              AND bse_process_priority_level = 1;

        END IF;

    END IF;


    ------------------------------------------------------------------
    -- 4. GET CURRENT ACTIVE MILESTONE
    --
    -- Do this AFTER initialization.
    ------------------------------------------------------------------

    SELECT a.ms_id_m
    INTO vr_ms_id_m
    FROM csau.lc_application_mile_stone_baby_steps_each a
    WHERE a.job_number = p_job_number
      AND a.workflow_type =
          'main_application_workflow'
      AND a.bse_status = 'Ongoing'
      AND a.bse_option = FALSE
    ORDER BY
        a.bse_process_priority_level,
        a.bse_id
    LIMIT 1;


    ------------------------------------------------------------------
    -- 5. BUILD WORKFLOW TREE
    ------------------------------------------------------------------

    IF v_section IN ('all', 'workflow') THEN
    SELECT
        COALESCE(
            jsonb_agg(
                jsonb_build_object(
                    'mile_stone_status',
                    x.mile_stone_status,

                    'ms_id',
                    x.priority_value,

                    'milestone_description',
                    x.milestone_description,

                    'baby_steps',
                    x.baby_steps
                )
                ORDER BY x.priority_value
            ),
            '[]'::JSONB
        )
    INTO vr_new_baby_step_milestone

    FROM (
        SELECT
            s.ms_id_m,
            s.priority_value,

            CASE
                WHEN s.priority_value >
                     vr_application_stage_main_step
                    THEN 'Pending'

                WHEN s.priority_value =
                     vr_application_stage_main_step
                    THEN 'Ongoing'

                ELSE 'Completed'
            END AS mile_stone_status,

            s.milestone_description,

            jsonb_agg(
                jsonb_build_object(
                    'start_date',
                    a.start_date,

                    'completed_by',
                    a.completed_by,

                    'complete_by_date',
                    a.complete_by_date,

                    'bse_description_key',
                    a.bse_description_key,

                    'bse_description',
                    a.bse_description,

                    'bs_id',
                    a.bse_process_priority_level,

                    'bse_id',
                    a.bse_id,

                    'bse_status',
                    a.bse_status
                )
                ORDER BY
                    a.bse_id
            ) AS baby_steps

        FROM csau.lc_application_mile_stone_each s

        INNER JOIN
            csau.lc_application_mile_stone_baby_steps_each a

            ON a.ms_id_m = s.priority_value
            AND a.job_number = s.job_number
            AND a.workflow_type = s.workflow_type

        WHERE s.job_number = p_job_number
          AND s.workflow_type =
              'main_application_workflow'

        GROUP BY
            s.ms_id_m,
            s.priority_value,
            s.milestone_description

    ) x;


    ELSE
        SELECT COALESCE(jsonb_agg(jsonb_build_object(
            'mile_stone_status', 'Ongoing',
            'milestone_description', milestone_description,
            'baby_steps', '[]'::JSONB)), '[]'::JSONB)
        INTO vr_new_baby_step_milestone
        FROM csau.lc_application_mile_stone_each
        WHERE job_number = p_job_number AND priority_value = vr_ms_id_m
          AND workflow_type = 'main_application_workflow';
    END IF;

    IF v_section = 'workflow' THEN
        RETURN jsonb_build_object('success', TRUE,
            'baby_step_milestone', vr_new_baby_step_milestone)::TEXT;
    END IF;

    ------------------------------------------------------------------
    -- 6. GET INTEREST NUMBER
    ------------------------------------------------------------------

    SELECT interest_number
    INTO vr_interest_number
    FROM csau.lrd_registration_processing
    WHERE case_number =
          new_p_transaction_number
    ORDER BY loid DESC
    LIMIT 1;


    ------------------------------------------------------------------
    -- 7. LOAD PARCEL ONCE
    ------------------------------------------------------------------

    SELECT
        to_jsonb(p),
        ST_AsText(p.geom)

    INTO
        v_parcel_details,
        v_parcel_wkt

    FROM (
        SELECT
            gid,
            geom,
            job_number,
            case_number,
            glpin,
            regional_number,
            locality,
            remarks,
            licensed_no,
            registry_mapref,
            plan_no,
            cc_no,
            ltr_plan_no,
            registration_district_number,
            registration_section_number,
            registration_block_number,
            date_approved,
            date_plotted,
            plotted_by,
            g_status,
            id_deleted,
            extent,
            district,
            region,
            land_size,
            locality_class,
            need_for_new_transaction,
            smd_reference_number,
            smd_type_of_plotting

        FROM csau_geospatial.lc_plan_approval_plottings

        WHERE case_number =
              new_p_transaction_number

        LIMIT 1
    ) p;


    ------------------------------------------------------------------
    -- 8. BUILD FINAL RESPONSE
    ------------------------------------------------------------------

    json_result_obj := jsonb_build_object(
        'success', true,

        'parcel_details', v_parcel_details,

        'transaction_details', (SELECT row_to_json(z)

 from (SELECT loid, ar_name, is_certificate_number_generated, case_number, 
       transaction_number, (to_char(date_of_document, 'YYYY-mm-dd')) AS date_of_document, nature_of_instrument, certificate_number, 
       type_of_interest, type_of_use, volume_number, folio_number, term, 
       (to_char(commencement_date, 'YYYY-mm-dd')) AS commencement_date, renewal_term, consideration_fee, consideration_fee_adopted_rate,
	   consideration_fee_currency, stamp_duty_payable, 
       assessed_value, parcel_description, plot_number, publicity_date::DATE, 
       family_of_grantor, rent_review_period, annual_rent, rent_period_covered, 
       rent_review_date, date_of_first_payment, outstanding_rent, remark_or_comment, 
       (SELECT created_date::DATE FROM csau.lrd_registration_sub_process Where job_number=p_job_number LIMIT 1) AS date_of_registration, 
	   (SELECT created_date::TIME FROM csau.lrd_registration_sub_process Where job_number=p_job_number LIMIT 1) AS time_of_registration,
	   case_status, created_by, created_by_id, 
       (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, modified_by, modified_by_id, 
     (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date, year_created, 
       stool_family_name, is_part_of_gelis_area, ar_address, grantors_name, 
       grantors_address, stamp_duty_description, certificate_type, case_file_number, 
       case_process_stage,considertion_fee_adopted_rate, (to_char(date_of_issue, 'YYYY-mm-dd')) AS date_of_issue, registered_number, interest_number,sub_interest_number,type_of_transfer,intended_interest,intended_parcel,
	   deed_number,file_number,ls_number,ground_rent
  FROM csau.lrd_registration_processing
  Where transaction_number=p_transaction_number LIMIT 1) z),

        'job_detail', (SELECT row_to_json(q)

from (SELECT jn_id, transaction_number, job_number, business_process_id, business_process_name,
job_purpose, job_status, job_datesend, job_recieved_by, job_forwarded_by,
job_recieved_by_id, job_forwarded_by_id, current_division_of_application,
current_application_status,  remark_or_comment, is_filed,
file_number, filed_by_id, filed_by_name, filed_date, is_completed,
completed_date, completed_by_id, completed_by_name, is_collected,
collected_by, collected_by_id_type, collected_by_id_number, collected_date,
collection_issued_by_id, collection_issued_by_name, created_by,
created_by_id, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, 
    modified_by, modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date,
year_created, record_inbox_status, isbatched, isreadyforbatch,
batch_number, batch_date, batched_by, batched_by_id, business_process_sub_id,
business_process_sub_name, divisional_registry_unit, old_file_record_numbers,
application_priority_level, application_stage,embossed,smd_region,smd_licensed_surveyor_name
FROM csau.lrd_registration_sub_process Where job_number=p_job_number LIMIT 1) q),

        'job_details', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(q)))

from (SELECT jn_id, transaction_number, job_number, business_process_id, business_process_name,
job_purpose, job_status, job_datesend, job_recieved_by, job_forwarded_by,
job_recieved_by_id, job_forwarded_by_id, current_division_of_application,
current_application_status,  remark_or_comment, is_filed,
file_number, filed_by_id, filed_by_name, filed_date, is_completed,
completed_date, completed_by_id, completed_by_name, is_collected,
collected_by, collected_by_id_type, collected_by_id_number, collected_date,
collection_issued_by_id, collection_issued_by_name, created_by,
created_by_id, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, 
    modified_by, modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date,
year_created, record_inbox_status, isbatched, isreadyforbatch,
batch_number, batch_date, batched_by, batched_by_id, business_process_sub_id,
business_process_sub_name, divisional_registry_unit, old_file_record_numbers,
application_priority_level, application_stage, created_date
FROM csau.lrd_registration_sub_process Where transaction_number=p_transaction_number) q))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'parcels_coordinates', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(v)))

from (SELECT vs_id, case_number, vs_date_of_valuation, vs_amount, vs_remarks,
created_by, created_by_id, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, 
    modified_by, modified_by_id,
(to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date, year_created
	  
FROM csau.lrd_valuation_section Where case_number=p_transaction_number) v))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'lrd_valuation_section', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(v)))

from (SELECT vs_id, case_number, (to_char(vs_date_of_valuation, 'YYYY-mm-dd')) AS vs_date_of_valuation , vs_amount, vs_remarks,
created_by, created_by_id, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, 
    modified_by, modified_by_id,
(to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date, year_created
FROM csau.lrd_valuation_section Where case_number=new_p_transaction_number) v))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'lrd_memorials_section', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(m)))

from (SELECT mid, case_number, m_registered_no, m_memorials, (to_char(m_date_of_instrument, 'YYYY-mm-dd')) as m_date_of_instrument,
m_date_of_registration::DATE, 
m_back, m_forward, m_remarks, created_by,
created_by_id, created_date::DATE, 
    modified_by, modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date,
year_created,m_entry_number
FROM csau.lrd_memorials_section Where case_number=new_p_transaction_number) m))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'lrd_encumbrances_section', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(e)))

from (SELECT es_id, case_number, es_date_of_instrument, (to_char(es_date_of_registration, 'YYYY-mm-dd')) AS es_date_of_registration,
es_registered_number, es_memorials, es_back, es_forward, es_remarks,
es_signature, created_by, created_by_id, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, modified_by,
modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date, year_created, es_entry_number
FROM csau.lrd_encumbrances_section Where case_number=new_p_transaction_number) e))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'lrd_certificate_section', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(c)))

from (SELECT cs_id, case_number, (to_char(cs_date_of_registration, 'YYYY-mm-dd')) AS cs_date_of_registration, cs_to_whom_issued,
cs_serial_number, cs_official_notes, created_by, created_by_id,
(to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, modified_by, 
    modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date, year_created
FROM csau.lrd_certificate_section Where case_number=new_p_transaction_number) c))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'lrd_proprietorship_section', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(p)))

from (SELECT 0 AS approval_status,  c.ps_id, c.case_number, c.ps_registration_number, c.ps_proprietor, (to_char(c.ps_date_of_instrument, 'YYYY-mm-dd')) AS ps_date_of_instrument,
c.ps_nature_of_instrument, (to_char(c.ps_date_of_registration, 'YYYY-mm-dd')) AS ps_date_of_registration, c.ps_transferor,
c.ps_transferee, c.ps_price_paid, c.ps_remarks, c.ps_signature, c.created_by,
c.created_by_id, (to_char(c.created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, c.modified_by, 
    c.modified_by_id, (to_char(c.modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date,
c.year_created, c.ps_term
FROM csau.lrd_proprietorship_section c
	   

	  Where c.interest_number=vr_interest_number
	  ORDER BY c.ps_date_of_registration ASC
	
	 ) p))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'lrd_reservation_section', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(r)))
from (SELECT rs_id, case_number, reservation_description, modified_by, modified_by_id, (to_char(created_date, 'YYYY-mm-dd')) AS created_date
FROM csau.lrd_reservation_section Where case_number=new_p_transaction_number) r))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'collection_checklist', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(c)))

from (SELECT collection_of_application_checklist_id, collection_of_application_checklist_name,
collection_of_application_checklist_option, business_process_id,
business_process_sub_id
FROM csau.collection_of_application_checklist) c))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'recieving_checklist', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(c)))

from (SELECT business_process_checklist_id, business_process_checklist_name, business_process_checklist_option, business_process_id, business_process_sub_id, priority_value
	
FROM csau.business_process_checklist WHERE business_process_id=new_business_process_id AND business_process_sub_id=new_business_process_sub_id) c))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'application_munites', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(k)))

from (SELECT am_id, am_case_number, am_job_number, am_description, am_from_officer,
am_from_position, am_to_officer, am_to_position, am_activity_date,
am_status, created_by, created_by_id, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date , modified_by,
modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date , year_created
FROM csau.lc_application_minutes Where am_case_number=new_p_transaction_number) k))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'application_notes', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(k)))

from (SELECT an_id, an_status, an_description,  created_by, an_division as division, an_type as type, 
	  (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date , modified_by,
	  (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date
FROM csau.lc_application_notes Where an_case_number=new_p_transaction_number) k))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'payment_bill', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(g)))

from (SELECT payment_id, customer_uid, customer_id, customer_name, job_number,
business_process_id, business_process_name, (to_char(bill_date, 'DD Mon YYYY | HH12:MI:SS')) AS bill_date, bill_amount,
payment_slip_number, payment_remarks, payment_mode, catgory_identifier,
type_of_revenue, revenue_group, division, created_by, created_by_id,
(to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, modified_by, 
    modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date, year_created,
nature_of_instrument, bill_number, payment_status, payment_bank,
payment_bank_branch, payment_confiration_status, account_number,
payment_amount,(to_char(payment_date, 'DD Mon YYYY | HH12:MI:SS')) AS  payment_date, business_process_sub_id, business_process_sub_name
FROM csau.lc_job_number_payment_bill Where job_number=p_job_number ORDER BY created_date) g))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'payment_invoice', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(g)))

from (SELECT  bill_amount, payment_slip_number, payment_mode, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, ref_number, payment_status,
payment_amount, (to_char(payment_date, 'DD Mon YYYY | HH12:MI:SS')) AS payment_date
FROM csau.lrd_registration_sub_process_dashboard Where job_number=p_job_number ORDER BY created_date) g))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'case_query', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(g)))

from (SELECT qid, job_number, case_number, status, reasons, query_response, remarks, created_by,
created_by_id, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, modified_by, 
    modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date,
year_created, query_general_reason, query_response, attachment_required
FROM csau.lc_case_query Where case_number=new_p_transaction_number  ORDER BY created_date DESC) g))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'active_case_query', (SELECT COUNT(*) 
FROM csau.lc_case_query Where case_number=new_p_transaction_number AND status='1'),

        'case_objection', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(g)))

from (SELECT id, job_number, case_number, objector_name, objector_address,
objector_contact, status, reasons, remarks, created_by, created_by_id,
(to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, modified_by, 
    modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date, year_created
FROM csau.lc_case_objection Where case_number=new_p_transaction_number ORDER BY created_date DESC) g))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'case_letters', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(g)))

from (SELECT id, job_number, case_number, letter_type, letter_template, carbon_copy, created_by, 
            created_by_id, 
(to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date
FROM csau.lc_case_letters Where job_number=p_job_number ORDER BY created_date DESC) g))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'active_case_objection', (SELECT COUNT(*) 
FROM csau.lc_case_objection Where case_number=new_p_transaction_number AND status=true),

        'comments_on_application', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(h)))

from (SELECT coa_id, jn_id, job_number, officers_general_comments, officers_recommendation,
officers_remarks, division, divisional_registry_unit, created_by,
created_by_id, (to_char(created_date, 'DD Mon YYYY | HH12:MI:SS')) AS created_date, 
    modified_by, modified_by_id, (to_char(modified_date, 'DD Mon YYYY | HH12:MI:SS')) AS modified_date,
year_created
FROM csau.lc_comments_on_application Where job_number=p_job_number ORDER BY created_date DESC) h))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'outgoing_sms', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(sm)))

from (SELECT sms_id, sms_message, sms_receiver_number, sms_sent_status, sms_job_number,
sms_client_name, sms_milestone_number, sms_date_sent, sms_created_by,
sms_created_by_id, (to_char(sms_created_date, 'DD Mon YYYY | HH12:MI:SS')) AS sms_created_date
FROM csau.lc_outgoing_sms Where sms_job_number=p_job_number ORDER BY sms_created_date DESC) sm))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'mother_to_child_link', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(h)))

from (SELECT id, job_number, case_number, mc_job_number, mc_case_number, mc_type_of_relationship, created_by, created_by_id, created_date, modified_by, modified_by_id, modified_date, year_created
	FROM csau.lc_mother_child_relation_details Where case_number=new_p_transaction_number ORDER BY created_date DESC) h))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'inspection_reports_on_appliction', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(v1)))

from (SELECT * FROM csau.lc_inspection_reports  Where job_number=p_job_number) v1))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'parcel_wkt', v_parcel_wkt,

        'certificete_approval_status', CASE WHEN v_section = 'all' THEN to_jsonb((SELECT approval_status
FROM csau.lc_transaction_approvals_certificate Where case_number=new_p_transaction_number LIMIT 1)) ELSE NULL::JSONB END,

        'final_approval_status', CASE WHEN v_section = 'all' THEN to_jsonb((SELECT final_approval_status
FROM csau.lc_transaction_approvals_certificate Where case_number=new_p_transaction_number LIMIT 1)) ELSE NULL::JSONB END,

        'compliance_query_status', CASE WHEN v_section = 'all' THEN to_jsonb((SELECT (case when count(*) > 0 then 'yes' else 'no' end) as status
FROM csau.compliance_application_notice Where status='active' and (notice_type = 'query' or notice_type = 'Query') and job_number=p_job_number LIMIT 1)) ELSE NULL::JSONB END,

        'baby_step_milestone', vr_new_baby_step_milestone,

        'digital_workflow_steps', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(r)))
from (SELECT 
               a.start_date,
             
               (to_char(a.complete_by_date, 'DD Mon YYYY | HH12:MI:SS')) AS complete_by_date,
               a.bse_description_key,
               a.bse_description,
               a.completed_by,
               a.bse_process_priority_level,
               a.bse_id,
               a.bse_status
    FROM 
        csau.lc_application_mile_stone_baby_steps_each a
		
		  WHERE  a.job_number = p_job_number AND a.workflow_type='main_application_workflow'
   
		 ORDER BY a.bse_id ASC
	  
	  
	  
   ) r))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'active_digital_workflow_step', COALESCE(((SELECT array_to_json(array_agg(row_to_json(v)))
from (SELECT 
               a.start_date,
               
               (to_char(a.complete_by_date, 'DD Mon YYYY | HH12:MI:SS')) AS complete_by_date,
               a.bse_description_key,
               a.bse_description,
               a.completed_by,
               a.bse_process_priority_level,
               a.bse_id,
               a.bse_status
    FROM 
        csau.lc_application_mile_stone_baby_steps_each a
		
		  WHERE a.ms_id_m = vr_ms_id_m AND a.job_number = p_job_number AND a.workflow_type='main_application_workflow' 
	  
   
		 ORDER BY a.bse_id ASC
   ) v))::JSONB, '[]'::JSONB),

        'certificate_search_relation', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(r)))
from (SELECT job_number, mc_job_number, mc_job_number, modified_by, modified_by_id, (to_char(created_date, 'YYYY-mm-dd')) AS created_date
FROM csau.lc_certificate_search_relation_details Where case_number=new_p_transaction_number) r))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'parties', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(l)))

from (SELECT a.ar_id, a.ar_client_id, a.ar_name, a.ar_gender, a.ar_cell_phone, a.ar_cell_phone2,
a.ar_fax, a.ar_email, a.ar_nationality, a.ar_address, a.ar_tin_no, a.ar_id_type,
a.ar_id_number, a.ar_location, a.ar_district, a.ar_region, a.ar_person_type,
a.ar_non_natural_person_type, a.ar_contact_person_name, a.ar_ownership_identifier,
a.created_by, a.created_by_id, a.created_date, a.modified_by,a. modified_by_id, p.p_uid,
a.modified_date, a.year_created, p.type_of_party FROM csau.party p INNER JOIN csau.address_register a ON p.ar_client_id = a.ar_client_id where p.case_number = p_transaction_number) l))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END,

        'application_requests', CASE WHEN v_section = 'all' THEN to_jsonb(COALESCE(((SELECT array_to_json(array_agg(row_to_json(rl)))

from (SELECT r.rq_id, r.job_purpose, r.job_recieved_by, r.job_recieved_by_id, r.created_on::DATE, r.is_completed, r.request_inbox FROM csau.lc_application_request r WHERE r.job_number = p_job_number) rl))::JSONB, '[]'::JSONB)) ELSE '[]'::JSONB END
    );

    ------------------------------------------------------------------
    -- 9. RETURN
    ------------------------------------------------------------------

    RETURN json_result_obj::TEXT;


EXCEPTION

    WHEN invalid_text_representation THEN

        RETURN jsonb_build_object(
            'success', FALSE,
            'message', 'Invalid JSON input',
            'job_number', p_job_number
        )::TEXT;


    WHEN OTHERS THEN

        RETURN jsonb_build_object(
            'success', FALSE,
            'message', SQLERRM,
            'job_number', p_job_number
        )::TEXT;
		
		
		
		

END;

$BODY$;


