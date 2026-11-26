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
