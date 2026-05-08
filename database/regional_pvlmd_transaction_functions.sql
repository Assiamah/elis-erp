-- ============================================================================
-- Regional PVLMD Transaction Management - PostgreSQL Functions
-- Schema: csau_geospatial
-- Table: regional_pvlmd_transactions_all
-- ============================================================================

-- Drop existing functions if they exist
DROP FUNCTION IF EXISTS csau_geospatial.get_regional_pvlmd_transactions_list(TEXT);
DROP FUNCTION IF EXISTS csau_geospatial.get_regional_pvlmd_transaction_by_id(TEXT);
DROP FUNCTION IF EXISTS csau_geospatial.create_regional_pvlmd_transaction(TEXT);
DROP FUNCTION IF EXISTS csau_geospatial.update_regional_pvlmd_transaction(TEXT);
DROP FUNCTION IF EXISTS csau_geospatial.delete_regional_pvlmd_transaction(TEXT);
DROP FUNCTION IF EXISTS csau_geospatial.get_qc_pending_pvlmd_transactions(TEXT);
DROP FUNCTION IF EXISTS csau_geospatial.approve_pvlmd_transaction_qc(TEXT);
DROP FUNCTION IF EXISTS csau_geospatial.decline_pvlmd_transaction_qc(TEXT);
DROP FUNCTION IF EXISTS csau_geospatial.batch_approve_pvlmd_transaction_qc(TEXT);
DROP FUNCTION IF EXISTS csau_geospatial.search_regional_pvlmd_transactions(TEXT);

-- ============================================================================
-- 1. Get Regional Transactions List (with pagination and search)
-- ============================================================================
CREATE OR REPLACE FUNCTION csau_geospatial.get_regional_pvlmd_transactions_list(
    p_json_request TEXT
)
RETURNS TEXT AS $$
DECLARE
    v_search_reference TEXT;
    v_search_file TEXT;
    v_search_jacket TEXT;
    v_search_status TEXT;
    v_draw INTEGER;
    v_start INTEGER;
    v_length INTEGER;
    v_total_records INTEGER;
    v_filtered_records INTEGER;
    v_result JSON;
    v_data JSON[];
    v_record RECORD;
    v_offset INTEGER;
BEGIN
    -- Parse JSON input
    v_search_reference := COALESCE(NULLIF((p_json_request::json->>'search_reference')::TEXT, ''), NULL);
    v_search_file := COALESCE(NULLIF((p_json_request::json->>'search_file')::TEXT, ''), NULL);
    v_search_jacket := COALESCE(NULLIF((p_json_request::json->>'search_jacket')::TEXT, ''), NULL);
    v_search_status := COALESCE(NULLIF((p_json_request::json->>'search_status')::TEXT, ''), NULL);
    v_draw := COALESCE((p_json_request::json->>'draw')::INTEGER, 1);
    v_start := COALESCE((p_json_request::json->>'start')::INTEGER, 0);
    v_length := COALESCE((p_json_request::json->>'length')::INTEGER, 10);
    v_offset := v_start;

    -- Get total records count
    SELECT COUNT(*) INTO v_total_records
    FROM csau_geospatial.regional_pvlmd_transactions_all
    WHERE is_deleted = FALSE;

    -- Build dynamic query for filtered data
    WITH filtered_data AS (
        SELECT *
        FROM csau_geospatial.regional_pvlmd_transactions_all
        WHERE is_deleted = FALSE
          AND (v_search_reference IS NULL OR reference_number ILIKE '%' || v_search_reference || '%')
          AND (v_search_file IS NULL OR file_number ILIKE '%' || v_search_file || '%')
          AND (v_search_jacket IS NULL OR jacket_name ILIKE '%' || v_search_jacket || '%')
          AND (v_search_status IS NULL OR status = v_search_status)
        ORDER BY created_date DESC
        LIMIT v_length OFFSET v_offset
    )
    SELECT COUNT(*) INTO v_filtered_records FROM filtered_data;

    -- Build JSON array of records
    SELECT ARRAY_AGG(
        json_build_object(
            't_id', fd.t_id,
            'reference_number', fd.reference_number,
            'jacket_name', fd.jacket_name,
            'file_number', fd.file_number,
            'instrument_type', fd.instrument_type,
            'instrument_date', fd.instrument_date,
            'party1_plaintiff', fd.party1_plaintiff,
            'party2_defendant', fd.party2_defendant,
            'status', fd.status,
            'created_date', fd.created_date,
            'modified_date', fd.modified_date
        )
    ) INTO v_data
    FROM filtered_data fd;

    -- Build final response
    v_result := json_build_object(
        'draw', v_draw,
        'recordsTotal', v_total_records,
        'recordsFiltered', v_filtered_records,
        'data', COALESCE(v_data, '[]'::JSON[])
    );

    RETURN v_result::TEXT;

EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object(
        'success', FALSE,
        'message', SQLERRM
    )::TEXT;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- 2. Get Regional Transaction By ID
-- ============================================================================
CREATE OR REPLACE FUNCTION csau_geospatial.get_regional_pvlmd_transaction_by_id(
    p_json_request TEXT
)
RETURNS TEXT AS $$
DECLARE
    v_t_id INTEGER;
    v_result JSON;
    v_record RECORD;
BEGIN
    -- Parse JSON input
    v_t_id := (p_json_request::json->>'t_id')::INTEGER;

    -- Get transaction by ID
    SELECT * INTO v_record
    FROM csau_geospatial.regional_pvlmd_transactions_all
    WHERE t_id = v_t_id
      AND is_deleted = FALSE;

    IF NOT FOUND THEN
        RETURN json_build_object(
            'success', FALSE,
            'message', 'Transaction not found'
        )::TEXT;
    END IF;

    -- Build response
    v_result := json_build_object(
        'success', TRUE,
        'data', json_build_object(
            't_id', v_record.t_id,
            'region', v_record.region,
            'district', v_record.district,
            'locality', v_record.locality,
            'reference_number', v_record.reference_number,
            'file_number', v_record.file_number,
            'property_number', v_record.property_number,
            'jacket_name', v_record.jacket_name,
            'submission_date', v_record.submission_date,
            'mutation_number', v_record.mutation_number,
            'deed_number', v_record.deed_number,
            'serial_number', v_record.serial_number,
            'sheet_number', v_record.sheet_number,
            'plan_number', v_record.plan_number,
            'plot_number', v_record.plot_number,
            'lvb_number', v_record.lvb_number,
            'instrument_date', v_record.instrument_date,
            'instrument_type', v_record.instrument_type,
            'doc_number', v_record.doc_number,
            'party1_plaintiff', v_record.party1_plaintiff,
            'party1_plaintiff_tel_no', v_record.party1_plaintiff_tel_no,
            'party1_plaintiff_email', v_record.party1_plaintiff_email,
            'party1_plantiff_add', v_record.party1_plantiff_add,
            'party2_defendant', v_record.party2_defendant,
            'party2_defendant_tel_no', v_record.party2_defendant_tel_no,
            'party2_defendant_email', v_record.party2_defendant_email,
            'party2_defendant_add', v_record.party2_defendant_add,
            'consideration', v_record.consideration,
            'consideration_currency', v_record.consideration_currency,
            'premium', v_record.premium,
            'premium_currency', v_record.premium_currency,
            'rent', v_record.rent,
            'compensation_status', v_record.compensation_status,
            'term', v_record.term,
            'commencement_date', v_record.commencement_date,
            'purpose', v_record.purpose,
            'entered_date', v_record.entered_date,
            'consent_date', v_record.consent_date,
            'suit_number', v_record.suit_number,
            'judgement_in_favour_of', v_record.judgement_in_favour_of,
            'floor_level', v_record.floor_level,
            'apartment_number', v_record.apartment_number,
            'remarks', v_record.remarks,
            'status', v_record.status,
            'qc_approved', v_record.qc_approved,
            'qc_approved_by', v_record.qc_approved_by,
            'qc_approved_date', v_record.qc_approved_date,
            'created_by', v_record.created_by,
            'created_date', v_record.created_date,
            'modified_by', v_record.modified_by,
            'modified_date', v_record.modified_date
        )
    );

    RETURN v_result::TEXT;

EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object(
        'success', FALSE,
        'message', SQLERRM
    )::TEXT;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- 3. Create Regional Transaction
-- ============================================================================
CREATE OR REPLACE FUNCTION csau_geospatial.create_regional_pvlmd_transaction(
    p_json_request TEXT
)
RETURNS TEXT AS $$
DECLARE
    v_new_id INTEGER;
    v_modified_by TEXT;
    v_modified_by_id TEXT;
    v_mac_address TEXT;
    v_ip_address TEXT;
BEGIN
    -- Parse JSON input
    v_modified_by := p_json_request::json->>'modified_by';
    v_modified_by_id := p_json_request::json->>'modified_by_id';
    v_mac_address := p_json_request::json->>'mac_address';
    v_ip_address := p_json_request::json->>'ip_address';

    -- Insert new transaction
    INSERT INTO csau_geospatial.regional_pvlmd_transactions_all (
        region, district, locality, reference_number, file_number, property_number,
        jacket_name, submission_date, mutation_number, deed_number, serial_number,
        sheet_number, plan_number, plot_number, lvb_number, instrument_date,
        instrument_type, doc_number, party1_plaintiff, party1_plaintiff_tel_no,
        party1_plaintiff_email, party1_plantiff_add, party2_defendant,
        party2_defendant_tel_no, party2_defendant_email, party2_defendant_add,
        consideration, consideration_currency, premium, premium_currency, rent,
        compensation_status, term, commencement_date, purpose, entered_date,
        consent_date, suit_number, judgement_in_favour_of, floor_level,
        apartment_number, remarks, status, created_by, modified_by,
        mac_address, ip_address
    ) VALUES (
        p_json_request::json->>'region',
        p_json_request::json->>'district',
        p_json_request::json->>'locality',
        p_json_request::json->>'reference_number',
        p_json_request::json->>'file_number',
        p_json_request::json->>'property_number',
        p_json_request::json->>'jacket_name',
        NULLIF(p_json_request::json->>'submission_date', '')::DATE,
        p_json_request::json->>'mutation_number',
        p_json_request::json->>'deed_number',
        p_json_request::json->>'serial_number',
        p_json_request::json->>'sheet_number',
        p_json_request::json->>'plan_number',
        p_json_request::json->>'plot_number',
        p_json_request::json->>'lvb_number',
        NULLIF(p_json_request::json->>'instrument_date', '')::DATE,
        p_json_request::json->>'instrument_type',
        p_json_request::json->>'doc_number',
        p_json_request::json->>'party1_plaintiff',
        p_json_request::json->>'party1_plaintiff_tel_no',
        p_json_request::json->>'party1_plaintiff_email',
        p_json_request::json->>'party1_plantiff_add',
        p_json_request::json->>'party2_defendant',
        p_json_request::json->>'party2_defendant_tel_no',
        p_json_request::json->>'party2_defendant_email',
        p_json_request::json->>'party2_defendant_add',
        NULLIF(p_json_request::json->>'consideration', '')::NUMERIC,
        p_json_request::json->>'consideration_currency',
        NULLIF(p_json_request::json->>'premium', '')::NUMERIC,
        p_json_request::json->>'premium_currency',
        p_json_request::json->>'rent',
        p_json_request::json->>'compensation_status',
        p_json_request::json->>'term',
        NULLIF(p_json_request::json->>'commencement_date', '')::DATE,
        p_json_request::json->>'purpose',
        NULLIF(p_json_request::json->>'entered_date', '')::DATE,
        NULLIF(p_json_request::json->>'consent_date', '')::DATE,
        p_json_request::json->>'suit_number',
        p_json_request::json->>'judgement_in_favour_of',
        p_json_request::json->>'floor_level',
        p_json_request::json->>'apartment_number',
        p_json_request::json->>'remarks',
        COALESCE(p_json_request::json->>'status', 'pending'),
        v_modified_by_id,
        v_modified_by,
        v_mac_address,
        v_ip_address
    ) RETURNING t_id INTO v_new_id;

    RETURN json_build_object(
        'success', TRUE,
        'message', 'Transaction created successfully',
        't_id', v_new_id
    )::TEXT;

EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object(
        'success', FALSE,
        'message', SQLERRM
    )::TEXT;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- 4. Update Regional Transaction
-- ============================================================================
CREATE OR REPLACE FUNCTION csau_geospatial.update_regional_pvlmd_transaction(
    p_json_request TEXT
)
RETURNS TEXT AS $$
DECLARE
    v_t_id INTEGER;
    v_modified_by TEXT;
    v_modified_by_id TEXT;
    v_mac_address TEXT;
    v_ip_address TEXT;
BEGIN
    -- Parse JSON input
    v_t_id := (p_json_request::json->>'t_id')::INTEGER;
    v_modified_by := p_json_request::json->>'modified_by';
    v_modified_by_id := p_json_request::json->>'modified_by_id';
    v_mac_address := p_json_request::json->>'mac_address';
    v_ip_address := p_json_request::json->>'ip_address';

    -- Check if transaction exists
    IF NOT EXISTS (SELECT 1 FROM csau_geospatial.regional_pvlmd_transactions_all WHERE t_id = v_t_id AND is_deleted = FALSE) THEN
        RETURN json_build_object(
            'success', FALSE,
            'message', 'Transaction not found'
        )::TEXT;
    END IF;

    -- Update transaction
    UPDATE csau_geospatial.regional_pvlmd_transactions_all
    SET
        region = p_json_request::json->>'region',
        district = p_json_request::json->>'district',
        locality = p_json_request::json->>'locality',
        reference_number = p_json_request::json->>'reference_number',
        file_number = p_json_request::json->>'file_number',
        property_number = p_json_request::json->>'property_number',
        jacket_name = p_json_request::json->>'jacket_name',
        submission_date = NULLIF(p_json_request::json->>'submission_date', '')::DATE,
        mutation_number = p_json_request::json->>'mutation_number',
        deed_number = p_json_request::json->>'deed_number',
        serial_number = p_json_request::json->>'serial_number',
        sheet_number = p_json_request::json->>'sheet_number',
        plan_number = p_json_request::json->>'plan_number',
        plot_number = p_json_request::json->>'plot_number',
        lvb_number = p_json_request::json->>'lvb_number',
        instrument_date = NULLIF(p_json_request::json->>'instrument_date', '')::DATE,
        instrument_type = p_json_request::json->>'instrument_type',
        doc_number = p_json_request::json->>'doc_number',
        party1_plaintiff = p_json_request::json->>'party1_plaintiff',
        party1_plaintiff_tel_no = p_json_request::json->>'party1_plaintiff_tel_no',
        party1_plaintiff_email = p_json_request::json->>'party1_plaintiff_email',
        party1_plantiff_add = p_json_request::json->>'party1_plantiff_add',
        party2_defendant = p_json_request::json->>'party2_defendant',
        party2_defendant_tel_no = p_json_request::json->>'party2_defendant_tel_no',
        party2_defendant_email = p_json_request::json->>'party2_defendant_email',
        party2_defendant_add = p_json_request::json->>'party2_defendant_add',
        consideration = NULLIF(p_json_request::json->>'consideration', '')::NUMERIC,
        consideration_currency = p_json_request::json->>'consideration_currency',
        premium = NULLIF(p_json_request::json->>'premium', '')::NUMERIC,
        premium_currency = p_json_request::json->>'premium_currency',
        rent = p_json_request::json->>'rent',
        compensation_status = p_json_request::json->>'compensation_status',
        term = p_json_request::json->>'term',
        commencement_date = NULLIF(p_json_request::json->>'commencement_date', '')::DATE,
        purpose = p_json_request::json->>'purpose',
        entered_date = NULLIF(p_json_request::json->>'entered_date', '')::DATE,
        consent_date = NULLIF(p_json_request::json->>'consent_date', '')::DATE,
        suit_number = p_json_request::json->>'suit_number',
        judgement_in_favour_of = p_json_request::json->>'judgement_in_favour_of',
        floor_level = p_json_request::json->>'floor_level',
        apartment_number = p_json_request::json->>'apartment_number',
        remarks = p_json_request::json->>'remarks',
        status = p_json_request::json->>'status',
        modified_by = v_modified_by,
        modified_date = NOW(),
        mac_address = v_mac_address,
        ip_address = v_ip_address
    WHERE t_id = v_t_id;

    RETURN json_build_object(
        'success', TRUE,
        'message', 'Transaction updated successfully',
        't_id', v_t_id
    )::TEXT;

EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object(
        'success', FALSE,
        'message', SQLERRM
    )::TEXT;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- 5. Delete Regional Transaction (Soft Delete)
-- ============================================================================
CREATE OR REPLACE FUNCTION csau_geospatial.delete_regional_pvlmd_transaction(
    p_json_request TEXT
)
RETURNS TEXT AS $$
DECLARE
    v_t_id INTEGER;
    v_modified_by TEXT;
    v_modified_by_id TEXT;
BEGIN
    -- Parse JSON input
    v_t_id := (p_json_request::json->>'t_id')::INTEGER;
    v_modified_by := p_json_request::json->>'modified_by';
    v_modified_by_id := p_json_request::json->>'modified_by_id';

    -- Check if transaction exists
    IF NOT EXISTS (SELECT 1 FROM csau_geospatial.regional_pvlmd_transactions_all WHERE t_id = v_t_id AND is_deleted = FALSE) THEN
        RETURN json_build_object(
            'success', FALSE,
            'message', 'Transaction not found'
        )::TEXT;
    END IF;

    -- Soft delete
    UPDATE csau_geospatial.regional_pvlmd_transactions_all
    SET
        is_deleted = TRUE,
        modified_by = v_modified_by,
        modified_date = NOW()
    WHERE t_id = v_t_id;

    RETURN json_build_object(
        'success', TRUE,
        'message', 'Transaction deleted successfully'
    )::TEXT;

EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object(
        'success', FALSE,
        'message', SQLERRM
    )::TEXT;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- 6. Get QC Pending Transactions
-- ============================================================================
CREATE OR REPLACE FUNCTION csau_geospatial.get_qc_pending_pvlmd_transactions(
    p_json_request TEXT
)
RETURNS TEXT AS $$
DECLARE
    v_draw INTEGER;
    v_start INTEGER;
    v_length INTEGER;
    v_total_records INTEGER;
    v_offset INTEGER;
    v_data JSON[];
    v_result JSON;
BEGIN
    -- Parse JSON input
    v_draw := COALESCE((p_json_request::json->>'draw')::INTEGER, 1);
    v_start := COALESCE((p_json_request::json->>'start')::INTEGER, 0);
    v_length := COALESCE((p_json_request::json->>'length')::INTEGER, 10);
    v_offset := v_start;

    -- Get total pending count
    SELECT COUNT(*) INTO v_total_records
    FROM csau_geospatial.regional_pvlmd_transactions_all
    WHERE is_deleted = FALSE
      AND status = 'pending'
      AND qc_approved = FALSE;

    -- Get pending transactions with pagination
    SELECT ARRAY_AGG(
        json_build_object(
            't_id', t.t_id,
            'reference_number', t.reference_number,
            'jacket_name', t.jacket_name,
            'file_number', t.file_number,
            'instrument_type', t.instrument_type,
            'instrument_date', t.instrument_date,
            'party1_plaintiff', t.party1_plaintiff,
            'party2_defendant', t.party2_defendant,
            'created_by', t.created_by,
            'created_date', t.created_date,
            'status', t.status,
            'qc_approved', t.qc_approved
        )
    ) INTO v_data
    FROM csau_geospatial.regional_pvlmd_transactions_all t
    WHERE t.is_deleted = FALSE
      AND t.status = 'pending'
      AND t.qc_approved = FALSE
    ORDER BY t.created_date ASC
    LIMIT v_length OFFSET v_offset;

    -- Build response
    v_result := json_build_object(
        'draw', v_draw,
        'recordsTotal', v_total_records,
        'recordsFiltered', v_total_records,
        'data', COALESCE(v_data, '[]'::JSON[])
    );

    RETURN v_result::TEXT;

EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object(
        'success', FALSE,
        'message', SQLERRM
    )::TEXT;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- 7. Approve Transaction QC
-- ============================================================================
CREATE OR REPLACE FUNCTION csau_geospatial.approve_pvlmd_transaction_qc(
    p_json_request TEXT
)
RETURNS TEXT AS $$
DECLARE
    v_t_id INTEGER;
    v_approved_by TEXT;
    v_approved_by_name TEXT;
    v_approval_remarks TEXT;
BEGIN
    -- Parse JSON input
    v_t_id := (p_json_request::json->>'t_id')::INTEGER;
    v_approved_by := p_json_request::json->>'approved_by';
    v_approved_by_name := p_json_request::json->>'approved_by_name';
    v_approval_remarks := p_json_request::json->>'approval_remarks';

    -- Check if transaction exists and is pending
    IF NOT EXISTS (
        SELECT 1 FROM csau_geospatial.regional_pvlmd_transactions_all 
        WHERE t_id = v_t_id 
          AND is_deleted = FALSE 
          AND status = 'pending'
    ) THEN
        RETURN json_build_object(
            'success', FALSE,
            'message', 'Transaction not found or already processed'
        )::TEXT;
    END IF;

    -- Approve transaction
    UPDATE csau_geospatial.regional_pvlmd_transactions_all
    SET
        status = 'approved',
        qc_approved = TRUE,
        qc_approved_by = v_approved_by_name,
        qc_approved_date = NOW(),
        modified_by = v_approved_by_name,
        modified_date = NOW(),
        remarks = CASE 
            WHEN v_approval_remarks IS NOT NULL AND v_approval_remarks != '' 
            THEN COALESCE(remarks || ' | QC Note: ' || v_approval_remarks, 'QC Note: ' || v_approval_remarks)
            ELSE remarks
        END
    WHERE t_id = v_t_id;

    RETURN json_build_object(
        'success', TRUE,
        'message', 'Transaction approved successfully',
        't_id', v_t_id
    )::TEXT;

EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object(
        'success', FALSE,
        'message', SQLERRM
    )::TEXT;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- 8. Decline Transaction QC
-- ============================================================================
CREATE OR REPLACE FUNCTION csau_geospatial.decline_pvlmd_transaction_qc(
    p_json_request TEXT
)
RETURNS TEXT AS $$
DECLARE
    v_t_id INTEGER;
    v_declined_by TEXT;
    v_declined_by_name TEXT;
    v_decline_reason TEXT;
BEGIN
    -- Parse JSON input
    v_t_id := (p_json_request::json->>'t_id')::INTEGER;
    v_declined_by := p_json_request::json->>'declined_by';
    v_declined_by_name := p_json_request::json->>'declined_by_name';
    v_decline_reason := p_json_request::json->>'decline_reason';

    -- Validate decline reason
    IF v_decline_reason IS NULL OR v_decline_reason = '' THEN
        RETURN json_build_object(
            'success', FALSE,
            'message', 'Decline reason is required'
        )::TEXT;
    END IF;

    -- Check if transaction exists and is pending
    IF NOT EXISTS (
        SELECT 1 FROM csau_geospatial.regional_pvlmd_transactions_all 
        WHERE t_id = v_t_id 
          AND is_deleted = FALSE 
          AND status = 'pending'
    ) THEN
        RETURN json_build_object(
            'success', FALSE,
            'message', 'Transaction not found or already processed'
        )::TEXT;
    END IF;

    -- Decline transaction
    UPDATE csau_geospatial.regional_pvlmd_transactions_all
    SET
        status = 'rejected',
        qc_approved = FALSE,
        modified_by = v_declined_by_name,
        modified_date = NOW(),
        remarks = COALESCE(remarks || ' | QC Rejected: ' || v_decline_reason, 'QC Rejected: ' || v_decline_reason)
    WHERE t_id = v_t_id;

    RETURN json_build_object(
        'success', TRUE,
        'message', 'Transaction declined successfully',
        't_id', v_t_id
    )::TEXT;

EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object(
        'success', FALSE,
        'message', SQLERRM
    )::TEXT;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- 9. Batch Approve QC Transactions
-- ============================================================================
CREATE OR REPLACE FUNCTION csau_geospatial.batch_approve_pvlmd_transaction_qc(
    p_json_request TEXT
)
RETURNS TEXT AS $$
DECLARE
    v_transaction_ids TEXT;
    v_approved_by TEXT;
    v_approved_by_name TEXT;
    v_approval_remarks TEXT;
    v_ids_array INTEGER[];
    v_success_count INTEGER := 0;
    v_failed_count INTEGER := 0;
    v_id INTEGER;
BEGIN
    -- Parse JSON input
    v_transaction_ids := p_json_request::json->>'transaction_ids';
    v_approved_by := p_json_request::json->>'approved_by';
    v_approved_by_name := p_json_request::json->>'approved_by_name';
    v_approval_remarks := p_json_request::json->>'approval_remarks';

    -- Convert comma-separated IDs to array
    v_ids_array := string_to_array(v_transaction_ids, ',')::INTEGER[];

    -- Process each transaction
    FOREACH v_id IN ARRAY v_ids_array
    LOOP
        BEGIN
            -- Check if transaction exists and is pending
            IF EXISTS (
                SELECT 1 FROM csau_geospatial.regional_pvlmd_transactions_all 
                WHERE t_id = v_id 
                  AND is_deleted = FALSE 
                  AND status = 'pending'
            ) THEN
                -- Approve transaction
                UPDATE csau_geospatial.regional_pvlmd_transactions_all
                SET
                    status = 'approved',
                    qc_approved = TRUE,
                    qc_approved_by = v_approved_by_name,
                    qc_approved_date = NOW(),
                    modified_by = v_approved_by_name,
                    modified_date = NOW(),
                    remarks = CASE 
                        WHEN v_approval_remarks IS NOT NULL AND v_approval_remarks != '' 
                        THEN COALESCE(remarks || ' | Batch QC Note: ' || v_approval_remarks, 'Batch QC Note: ' || v_approval_remarks)
                        ELSE remarks
                    END
                WHERE t_id = v_id;
                
                v_success_count := v_success_count + 1;
            ELSE
                v_failed_count := v_failed_count + 1;
            END IF;
        EXCEPTION WHEN OTHERS THEN
            v_failed_count := v_failed_count + 1;
        END;
    END LOOP;

    RETURN json_build_object(
        'success', TRUE,
        'message', format('Batch approval completed: %s approved, %s failed', v_success_count, v_failed_count),
        'approved_count', v_success_count,
        'failed_count', v_failed_count
    )::TEXT;

EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object(
        'success', FALSE,
        'message', SQLERRM
    )::TEXT;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- 10. Search Regional Transactions
-- ============================================================================
CREATE OR REPLACE FUNCTION csau_geospatial.search_regional_pvlmd_transactions(
    p_json_request TEXT
)
RETURNS TEXT AS $$
DECLARE
    v_search_text TEXT;
    v_draw INTEGER;
    v_start INTEGER;
    v_length INTEGER;
    v_total_records INTEGER;
    v_offset INTEGER;
    v_data JSON[];
    v_result JSON;
BEGIN
    -- Parse JSON input - simple search across multiple fields
    v_search_text := COALESCE(NULLIF(p_json_request::json->>'search_text', ''), NULL);
    v_draw := COALESCE((p_json_request::json->>'draw')::INTEGER, 1);
    v_start := COALESCE((p_json_request::json->>'start')::INTEGER, 0);
    v_length := COALESCE((p_json_request::json->>'length')::INTEGER, 10);
    v_offset := v_start;

    -- Get total records count
    SELECT COUNT(*) INTO v_total_records
    FROM csau_geospatial.regional_pvlmd_transactions_all
    WHERE is_deleted = FALSE
      AND qc_approved = TRUE
      AND status = 'approved';

    -- Search with pagination (only approved and QC approved transactions)
    SELECT ARRAY_AGG(
        json_build_object(
            't_id', t.t_id,
            'reference_number', t.reference_number,
            'jacket_name', t.jacket_name,
            'file_number', t.file_number,
            'instrument_type', t.instrument_type,
            'instrument_date', t.instrument_date,
            'party1_plaintiff', t.party1_plaintiff,
            'party2_defendant', t.party2_defendant,
            'consideration', t.consideration,
            'status', t.status,
            'qc_approved', t.qc_approved,
            'created_date', t.created_date
        )
    ) INTO v_data
    FROM csau_geospatial.regional_pvlmd_transactions_all t
    WHERE t.is_deleted = FALSE
      AND t.qc_approved = TRUE
      AND t.status = 'approved'
      AND (
          v_search_text IS NULL 
          OR t.reference_number ILIKE '%' || v_search_text || '%'
          OR t.file_number ILIKE '%' || v_search_text || '%'
          OR t.jacket_name ILIKE '%' || v_search_text || '%'
          OR t.party1_plaintiff ILIKE '%' || v_search_text || '%'
          OR t.party2_defendant ILIKE '%' || v_search_text || '%'
      )
    ORDER BY t.created_date DESC
    LIMIT v_length OFFSET v_offset;

    -- Build response
    v_result := json_build_object(
        'draw', v_draw,
        'recordsTotal', v_total_records,
        'recordsFiltered', COALESCE(array_length(v_data, 1), 0),
        'data', COALESCE(v_data, '[]'::JSON[])
    );

    RETURN v_result::TEXT;

EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object(
        'success', FALSE,
        'message', SQLERRM
    )::TEXT;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- Grant execute permissions
-- ============================================================================
GRANT EXECUTE ON FUNCTION csau_geospatial.get_regional_pvlmd_transactions_list(TEXT) TO PUBLIC;
GRANT EXECUTE ON FUNCTION csau_geospatial.get_regional_pvlmd_transaction_by_id(TEXT) TO PUBLIC;
GRANT EXECUTE ON FUNCTION csau_geospatial.create_regional_pvlmd_transaction(TEXT) TO PUBLIC;
GRANT EXECUTE ON FUNCTION csau_geospatial.update_regional_pvlmd_transaction(TEXT) TO PUBLIC;
GRANT EXECUTE ON FUNCTION csau_geospatial.delete_regional_pvlmd_transaction(TEXT) TO PUBLIC;
GRANT EXECUTE ON FUNCTION csau_geospatial.get_qc_pending_pvlmd_transactions(TEXT) TO PUBLIC;
GRANT EXECUTE ON FUNCTION csau_geospatial.approve_pvlmd_transaction_qc(TEXT) TO PUBLIC;
GRANT EXECUTE ON FUNCTION csau_geospatial.decline_pvlmd_transaction_qc(TEXT) TO PUBLIC;
GRANT EXECUTE ON FUNCTION csau_geospatial.batch_approve_pvlmd_transaction_qc(TEXT) TO PUBLIC;
GRANT EXECUTE ON FUNCTION csau_geospatial.search_regional_pvlmd_transactions(TEXT) TO PUBLIC;

-- ============================================================================
-- Comments for documentation
-- ============================================================================
COMMENT ON FUNCTION csau_geospatial.get_regional_pvlmd_transactions_list(TEXT) IS 'Get paginated list of regional PVLMD transactions with optional filters';
COMMENT ON FUNCTION csau_geospatial.get_regional_pvlmd_transaction_by_id(TEXT) IS 'Get single transaction details by ID';
COMMENT ON FUNCTION csau_geospatial.create_regional_pvlmd_transaction(TEXT) IS 'Create new regional PVLMD transaction';
COMMENT ON FUNCTION csau_geospatial.update_regional_pvlmd_transaction(TEXT) IS 'Update existing regional PVLMD transaction';
COMMENT ON FUNCTION csau_geospatial.delete_regional_pvlmd_transaction(TEXT) IS 'Soft delete regional PVLMD transaction';
COMMENT ON FUNCTION csau_geospatial.get_qc_pending_pvlmd_transactions(TEXT) IS 'Get transactions pending QC approval';
COMMENT ON FUNCTION csau_geospatial.approve_pvlmd_transaction_qc(TEXT) IS 'Approve single transaction through QC';
COMMENT ON FUNCTION csau_geospatial.decline_pvlmd_transaction_qc(TEXT) IS 'Decline/reject transaction through QC';
COMMENT ON FUNCTION csau_geospatial.batch_approve_pvlmd_transaction_qc(TEXT) IS 'Batch approve multiple transactions through QC';
COMMENT ON FUNCTION csau_geospatial.search_regional_pvlmd_transactions(TEXT) IS 'Search approved and QC-approved transactions';
