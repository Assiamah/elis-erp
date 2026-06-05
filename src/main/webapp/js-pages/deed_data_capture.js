(function ($) {
    const state = {
        loadedJob: null,
        modalOptionsLoaded: false,
        loadingFullCase: false
    };

    function parseJsonSafely(raw) {
        if (raw == null) {
            return null;
        }

        if (typeof raw === 'object') {
            return raw;
        }

        try {
            return JSON.parse(raw);
        } catch (error) {
            return null;
        }
    }

    function firstNonEmpty() {
        for (let i = 0; i < arguments.length; i += 1) {
            const value = arguments[i];

            if (value !== undefined && value !== null && String(value).trim() !== '') {
                return value;
            }
        }

        return '';
    }

    function extractRecord(payload) {
        if (!payload) {
            return null;
        }

        if (Array.isArray(payload.data) && payload.data.length > 0) {
            return payload.data[0];
        }

        if (payload.data && !Array.isArray(payload.data) && typeof payload.data === 'object') {
            return payload.data;
        }

        if (Array.isArray(payload) && payload.length > 0) {
            return payload[0];
        }

        if (payload.job_number || payload.case_number || payload.ar_name) {
            return payload;
        }

        return null;
    }

    function parseSection(payload, key) {
        if (!payload || payload[key] == null) {
            return null;
        }

        return parseJsonSafely(payload[key]) || payload[key];
    }

    function firstRow(section) {
        if (!section) {
            return {};
        }

        if (Array.isArray(section)) {
            return section[0] || {};
        }

        return section;
    }

    function normalizeDate(value) {
        if (!value || value === 'null') {
            return '';
        }

        const text = String(value).trim();
        if (/^\d{4}-\d{2}-\d{2}/.test(text)) {
            return text.substring(0, 10);
        }

        return text;
    }

    function setFieldValue(selector, value) {
        const $field = $(selector);
        if (!$field.length) {
            return;
        }

        $field.val(value == null || value === 'null' ? '' : value);
    }

    function hasWktPolygon(value) {
        return /\b(MULTI)?POLYGON\s*\(/i.test($.trim(value || ''));
    }

    function updateDeedPolygonConfirmButton() {
        const showButton = hasWktPolygon($('#deed_check_wkt_polygon').val());
        $('#deed_check_polygon [data-deed-polygon-confirm="true"]').toggleClass('d-none', !showButton);
    }

    function openDeedNotingRequestModal() {
        const context = window.currentDeedCaptureContext || {};
        const jobNumber = firstNonEmpty(context.job_number, $('#cs_main_job_number').val(), $('#deed_job_number').val());

        if (!jobNumber) {
            setLookupStatus('warning', 'Load a job first before sending a noting request.');
            return;
        }

        const purpose = 'Noting of Parcels';
        const $purpose = $('#req_job_purpose');

        $('#deed_check_polygon').modal('hide');
        $('#askForPurposeOfSendingRequest').modal('show');
        $('#askForPurposeOfSendingRequest').data('deed-noting-request', true);
        $('#askForPurposeOfSendingRequest').data('deed-noting-purpose-html', $purpose.html());
        $('#askForPurposeOfSendingRequest').data('deed-noting-purpose-value', $purpose.val());

        $('#req_job_number').val(jobNumber);
        $('#req_ar_name').val(firstNonEmpty(context.ar_name, $('#cs_main_ar_name').val()));
        $('#req_business_process_sub_name').val(firstNonEmpty(context.business_process_sub_name, $('#cs_main_business_process_sub_name').val()));
        $('#req_locality').val(firstNonEmpty(context.locality, $('#deedLoadedLocality').text()));
        $('#req_remarks').val('');

        $purpose
            .empty()
            .append(new Option(purpose, purpose))
            .val(purpose)
            .prop('disabled', true)
            .trigger('change');

        $('#btnaddreqtolistFinal').removeClass('d-none');
    }

    function resetDeedNotingRequestModal() {
        const $modal = $('#askForPurposeOfSendingRequest');

        if (!$modal.data('deed-noting-request')) {
            return;
        }

        $modal.removeData('deed-noting-request');
        $('#req_job_purpose')
            .prop('disabled', false)
            .html($modal.data('deed-noting-purpose-html') || '<option value="">-- select Purpose --</option>')
            .val($modal.data('deed-noting-purpose-value') || '');
        $modal.removeData('deed-noting-purpose-html');
        $modal.removeData('deed-noting-purpose-value');
        $('#req_remarks').val('');
    }

    function setSelectValue(selector, value) {
        const $select = $(selector);
        if (!$select.length || value == null || value === 'null' || value === '') {
            return;
        }

        const text = String(value);
        if (!$select.find('option').filter(function () {
            return $(this).val() === text;
        }).length) {
            $select.append(new Option(text, text));
        }

        $select.val(text).trigger('change');
    }

    function pick(record, keys) {
        for (let i = 0; i < keys.length; i += 1) {
            const value = record && record[keys[i]];
            if (value !== undefined && value !== null && String(value).trim() !== '' && value !== 'null') {
                return value;
            }
        }

        return '';
    }

    function normalizeParties(rawParties) {
        const parsedParties = parseJsonSafely(rawParties) || rawParties;

        if (Array.isArray(parsedParties)) {
            return parsedParties;
        }

        if (parsedParties && Array.isArray(parsedParties.data)) {
            return parsedParties.data;
        }

        if (parsedParties && Array.isArray(parsedParties.parties)) {
            return parsedParties.parties;
        }

        return [];
    }

    function escapeHtml(value) {
        return String(value == null || value === 'null' ? '' : value)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#039;');
    }

    function partyField(party, keys) {
        return pick(party, keys);
    }

    function partyBadgeClass(typeOfParty) {
        if (typeOfParty === 'Grantor') {
            return 'bg-success';
        }

        if (typeOfParty === 'Applicant') {
            return 'bg-warning';
        }

        return 'bg-info';
    }

    function genderBadge(gender) {
        const normalizedGender = String(gender || '').toUpperCase();

        if (normalizedGender === 'MALE') {
            return '<span class="badge bg-info">Male</span>';
        }

        if (normalizedGender === 'FEMALE') {
            return '<span class="badge bg-pink">Female</span>';
        }

        return '<span class="badge bg-secondary">' + escapeHtml(gender || 'Other') + '</span>';
    }

    function partyDataAttributes(party) {
        const fields = {
            'target-id': partyField(party, ['ar_client_id', 'client_id', 'target_id']),
            ar_name: partyField(party, ['ar_name', 'party_name', 'name']),
            ar_gender: partyField(party, ['ar_gender', 'gender']),
            ar_address: partyField(party, ['ar_address', 'address']),
            ar_cell_phone: partyField(party, ['ar_cell_phone', 'phone_number', 'mobile_number']),
            ar_cell_phone2: partyField(party, ['ar_cell_phone2', 'phone_number2']),
            ar_nationality: partyField(party, ['ar_nationality', 'nationality']),
            ar_tin_no: partyField(party, ['ar_tin_no', 'tin_number']),
            ar_id_type: partyField(party, ['ar_id_type', 'id_type']),
            ar_id_number: partyField(party, ['ar_id_number', 'id_number']),
            ar_location: partyField(party, ['ar_location', 'location', 'residential_address']),
            ar_district: partyField(party, ['ar_district', 'district']),
            ar_region: partyField(party, ['ar_region', 'region']),
            type_of_party: partyField(party, ['type_of_party', 'ar_type_of_party', 'party_type']),
            ar_person_type: partyField(party, ['ar_person_type', 'person_type']),
            p_uid: partyField(party, ['p_uid']),
            ar_id: partyField(party, ['ar_id'])
        };

        return $.map(fields, function (value, key) {
            return 'data-' + key + '="' + escapeHtml(value) + '"';
        }).join(' ');
    }

    function buildPartyTableRow(party) {
        const name = partyField(party, ['ar_name', 'party_name', 'name']);
        const gender = partyField(party, ['ar_gender', 'gender']);
        const phone = partyField(party, ['ar_cell_phone', 'phone_number', 'mobile_number']);
        const phone2 = partyField(party, ['ar_cell_phone2', 'phone_number2']);
        const typeOfParty = partyField(party, ['type_of_party', 'ar_type_of_party', 'party_type']);
        const attributes = partyDataAttributes(party);

        return '<tr>' +
            '<td class="align-middle"><div class="fw-semibold">' + escapeHtml(name || '--') + '</div></td>' +
            '<td class="align-middle">' + genderBadge(gender) + '</td>' +
            '<td class="align-middle">' +
                '<div class="contact-info">' +
                    '<div class="d-flex align-items-center mb-1">' +
                        '<i class="bi bi-phone text-primary me-2"></i>' +
                        '<small>' + escapeHtml(phone || '--') + '</small>' +
                    '</div>' +
                    (phone2 ? '<div class="d-flex align-items-center"><i class="bi bi-telephone-plus text-secondary me-2"></i><small>' + escapeHtml(phone2) + '</small></div>' : '') +
                '</div>' +
            '</td>' +
            '<td class="align-middle"><span class="badge ' + partyBadgeClass(typeOfParty) + '">' + escapeHtml(typeOfParty || '--') + '</span></td>' +
            '<td class="align-middle text-center">' +
                '<div class="d-flex justify-content-center gap-2">' +
                    '<button type="button" class="btn btn-outline-primary btn-sm addeditpartyGeneralBtn" data-bs-toggle="modal" data-bs-target="#addeditpartyGeneral" data-bs-placement="top" data-bs-title="Edit Party" ' + attributes + '>' +
                        '<i class="bi bi-pencil"></i> Edit' +
                    '</button>' +
                    '<button type="button" class="btn btn-outline-danger btn-sm deletepartyGeneralBtn" data-bs-toggle="modal" data-bs-target="#deletepartyGeneral" data-bs-placement="top" data-bs-title="Delete Party" ' + attributes + '>' +
                        '<i class="bi bi-trash"></i> Delete' +
                    '</button>' +
                '</div>' +
            '</td>' +
        '</tr>';
    }

    function renderPartyTable(parties) {
        const $table = $('#party_details_datatable');
        const $tbody = $table.find('tbody');
        const partyList = normalizeParties(parties);

        if (!$tbody.length) {
            return;
        }

        if (!partyList.length) {
            $tbody.html(
                '<tr>' +
                    '<td colspan="5" class="text-center py-4">' +
                        '<div class="text-muted">' +
                            '<i class="bi bi-people fs-1 mb-2 d-block"></i>' +
                            '<p class="mb-0">No parties added yet</p>' +
                            '<small>Click "Add Grantor" or "Add Applicant" to get started</small>' +
                        '</div>' +
                    '</td>' +
                '</tr>'
            );
            return;
        }

        $tbody.html($.map(partyList, buildPartyTableRow).join(''));
    }

    function extractFullDetailsRecord(fullPayload, fallbackRecord) {
        const payload = fullPayload && fullPayload.data && typeof fullPayload.data === 'object'
            ? fullPayload.data
            : fullPayload;

        const parcelDetails = firstRow(parseSection(payload, 'parcel_details'));
        const transactionDetails = firstRow(parseSection(payload, 'transaction_details') || parseSection(payload, 'main_details'));
        const jobDetail = firstRow(parseSection(payload, 'job_detail') || parseSection(payload, 'job_details'));
        const parties = parseSection(payload, 'parties') || [];
        const partyList = normalizeParties(parties);
        const primaryParty = partyList[0] || {};

        return $.extend(
            {},
            fallbackRecord || {},
            parcelDetails,
            transactionDetails,
            jobDetail,
            {
                job_number: firstNonEmpty(jobDetail.job_number, fallbackRecord && fallbackRecord.job_number),
                case_number: firstNonEmpty(transactionDetails.case_number, parcelDetails.case_number, fallbackRecord && fallbackRecord.case_number),
                transaction_number: firstNonEmpty(transactionDetails.transaction_number, fallbackRecord && fallbackRecord.transaction_number),
                ar_name: firstNonEmpty(transactionDetails.ar_name, primaryParty.ar_name, fallbackRecord && fallbackRecord.ar_name),
                business_process_sub_name: firstNonEmpty(jobDetail.business_process_sub_name, fallbackRecord && fallbackRecord.business_process_sub_name),
                locality: firstNonEmpty(parcelDetails.locality, fallbackRecord && fallbackRecord.locality),
                district: firstNonEmpty(parcelDetails.district, fallbackRecord && fallbackRecord.district),
                region: firstNonEmpty(parcelDetails.region, fallbackRecord && fallbackRecord.region),
                land_size: firstNonEmpty(parcelDetails.land_size, transactionDetails.size_of_land, fallbackRecord && fallbackRecord.land_size),
                parcel_wkt: firstNonEmpty(payload && payload.parcel_wkt, parcelDetails.parcel_wkt, parcelDetails.wkt_polygon, fallbackRecord && fallbackRecord.parcel_wkt),
                parties: partyList,
                full_details: payload
            }
        );
    }

    function setLookupStatus(type, message) {
        const $status = $('#deedLookupStatus');
        const classMap = {
            info: 'alert alert-info border',
            success: 'alert alert-success border',
            warning: 'alert alert-warning border',
            danger: 'alert alert-danger border'
        };

        $status.removeClass().addClass(classMap[type] || classMap.info).html(message).removeClass('d-none');
    }

    function clearLookupStatus() {
        $('#deedLookupStatus').addClass('d-none').empty();
    }

    function setLookupLoading(loading) {
        const $button = $('#deedLookupButton');

        $button.prop('disabled', loading);
        $button.html(loading
            ? '<span class="spinner-border spinner-border-sm me-1" role="status" aria-hidden="true"></span>Checking...'
            : '<i class="bi bi-search me-1"></i>Check Job');
    }

    function markStepTwoReady(isReady) {
        $('#deedStepOneIndicator')
            .toggleClass('complete', isReady)
            .toggleClass('active', !isReady);

        $('#deedStepTwoIndicator')
            .toggleClass('active', isReady)
            .toggleClass('complete', false);

        $('#deedStepTwoSection').toggleClass('is-visible', isReady);
    }

    function updateLoadedSummary(record) {
        const jobNumber = firstNonEmpty(record.job_number, record.jobNumber, $('#deed_job_number').val(), '--');
        const caseNumber = firstNonEmpty(record.case_number, record.caseNumber, '--');
        const applicant = firstNonEmpty(record.ar_name, record.client_name, record.applicant_name, '--');
        const subService = firstNonEmpty(record.business_process_sub_name, record.sub_service_name, '--');
        const locality = firstNonEmpty(record.locality, record.location_name, record.land_location, '--');
        const status = firstNonEmpty(record.current_application_status, record.job_status, 'Loaded');

        $('#deedLoadedJobNumber').text(jobNumber);
        $('#deedLoadedCaseNumber').text(caseNumber);
        $('#deedLoadedApplicant').text(applicant);
        $('#deedLoadedSubService').text(subService);
        $('#deedLoadedLocality').text(locality);
        $('#deedLoadedStatus').text(status);
        $('#deedCurrentJobPill').text(jobNumber + (caseNumber !== '--' ? ' / ' + caseNumber : ''));


    }

    function syncJobContextToModals(record) {

        //console.log('syncJobContextToModals', record);

        const jobNumber = firstNonEmpty(record.job_number, $('#deed_job_number').val());
        const caseNumber = firstNonEmpty(record.case_number);
        const applicant = firstNonEmpty(record.ar_name, record.client_name, record.applicant_name);
        const subService = firstNonEmpty(record.business_process_sub_name, record.sub_service_name);
        const transactionNumber = firstNonEmpty(record.transaction_number, '');
        const fileNumber = firstNonEmpty(record.file_number, record.case_file_number);
        const serialNumber = firstNonEmpty(record.ls_number, record.serial_number);
        const deedNumber = firstNonEmpty(record.deed_number);
        const publicationDate = normalizeDate(firstNonEmpty(record.publicity_date, record.publication_date));
        const parcelWkt = firstNonEmpty(record.parcel_wkt, record.wkt_polygon);
        const parties = normalizeParties(record.parties);
        const primaryParty = parties[0] || {};

        renderPartyTable(parties);

        window.currentDeedCaptureContext = {
            job_number: jobNumber,
            case_number: caseNumber,
            transaction_number: transactionNumber,
            ar_name: applicant,
            business_process_sub_name: subService,
            locality: firstNonEmpty(record.locality, record.location_name),
            data: record
        };

        const formFieldMap = {
            job_number: jobNumber,
            case_number: caseNumber,
            client_name: applicant,
            business_process_sub_name: subService,
            transaction_number: transactionNumber,
            locality: firstNonEmpty(record.locality, record.location_name),
            district: firstNonEmpty(record.district),
            region: firstNonEmpty(record.region),
            land_size: firstNonEmpty(record.land_size, record.size_of_land),
            surveyor_number: firstNonEmpty(record.licensed_no, record.licensed_surveyor_number),
            regional_number: firstNonEmpty(record.regional_number),
            nature_of_instrument: firstNonEmpty(record.nature_of_instrument),
            type_of_use: firstNonEmpty(record.type_of_use),
            type_of_interest: firstNonEmpty(record.type_of_interest),
            consideration_currency: firstNonEmpty(record.consideration_fee_currency, record.consideration_currency),
            date_of_document: normalizeDate(firstNonEmpty(record.date_of_document)),
            commencement_date: normalizeDate(firstNonEmpty(record.commencement_date)),
            publication_date: publicationDate,
            date_of_registration: normalizeDate(firstNonEmpty(record.date_of_registration)),
            term: firstNonEmpty(record.term),
            renewal_term: firstNonEmpty(record.renewal_term),
            family_name: firstNonEmpty(record.stool_family_name),
            grantor_family: firstNonEmpty(record.family_of_grantor),
            extent: firstNonEmpty(record.extent),
            consideration_fee: firstNonEmpty(record.consideration_fee),
            annual_rent: firstNonEmpty(record.annual_rent),
            file_number: fileNumber,
            serial_number: serialNumber,
            deed_number: deedNumber,
            registry_mapref: firstNonEmpty(record.registry_mapref),
            date_of_issue: normalizeDate(firstNonEmpty(record.date_of_issue)),
            registered_number: firstNonEmpty(record.registered_number),
            certificate_type: firstNonEmpty(record.certificate_type)
        };

        $.each(formFieldMap, function (field, value) {
            setFieldValue('#fe_' + field, value);
            setFieldValue('#dfe_' + field, value);
        });

        setSelectValue('#fe_type_of_interest', formFieldMap.type_of_interest);
        setSelectValue('#dfe_type_of_interest', formFieldMap.type_of_interest);
        setSelectValue('#fe_consideration_currency', formFieldMap.consideration_currency);
        setSelectValue('#dfe_consideration_currency', formFieldMap.consideration_currency);

        const renewalValue = parseFloat(formFieldMap.renewal_term || 0) > 0 ? 'yes' : 'no';
        $('input[name="fe_renewal_term_check"][value="' + renewalValue + '"]').prop('checked', true).trigger('change');
        $('input[name="dfe_renewal_term_check"][value="' + renewalValue + '"]').prop('checked', true).trigger('change');

        setFieldValue('#party_ar_name_gen', firstNonEmpty(primaryParty.ar_name, primaryParty.party_name, applicant));
        setFieldValue('#party_ar_address_gen', firstNonEmpty(primaryParty.ar_address, primaryParty.address));
        setFieldValue('#party_ar_cell_phone_gen', firstNonEmpty(primaryParty.ar_cell_phone, primaryParty.phone_number, primaryParty.mobile_number));
        setFieldValue('#party_ar_cell_phone2_gen', firstNonEmpty(primaryParty.ar_cell_phone2, primaryParty.phone_number2));
        setFieldValue('#party_ar_tin_no_gen', firstNonEmpty(primaryParty.ar_tin_no, primaryParty.tin_number));
        setFieldValue('#party_ar_id_number_gen', firstNonEmpty(primaryParty.ar_id_number, primaryParty.id_number));
        setFieldValue('#party_ar_location_gen', firstNonEmpty(primaryParty.ar_location, primaryParty.location, primaryParty.residential_address));
        setFieldValue('#party_ar_district_gen', firstNonEmpty(primaryParty.ar_district, primaryParty.district));
        setFieldValue('#party_ar_region_gen', firstNonEmpty(primaryParty.ar_region, primaryParty.region));
        setFieldValue('#family_name_gen', firstNonEmpty(record.stool_family_name));
        setFieldValue('#grantor_family_gen', firstNonEmpty(record.family_of_grantor));

        setSelectValue('#party_ar_gender_gen', firstNonEmpty(primaryParty.ar_gender, primaryParty.gender));
        setSelectValue('#party_ar_nationality_gen', firstNonEmpty(primaryParty.ar_nationality, primaryParty.nationality, 'Ghanaian'));
        setSelectValue('#party_ar_id_type_gen', firstNonEmpty(primaryParty.ar_id_type, primaryParty.id_type));
        setSelectValue('#party_ar_type_of_party_gen', firstNonEmpty(primaryParty.type_of_party, primaryParty.ar_type_of_party, primaryParty.party_type));
        setSelectValue('#party_ar_person_type_gen', firstNonEmpty(primaryParty.ar_person_type, primaryParty.person_type, 'Natural Person'));

        $('#cs_main_transaction_number').val(transactionNumber);
        $('#cs_main_case_number').val(caseNumber);
        $('#cs_main_job_number').val(jobNumber);
        $('#cs_main_business_process_id').val(firstNonEmpty(record.business_process_id, ''));
        $('#cs_main_business_process_name').val(firstNonEmpty(record.business_process_name, ''));
        $('#cs_main_business_process_sub_id').val(firstNonEmpty(record.business_process_sub_id, ''));
        $('#cs_main_business_process_sub_name').val(subService);

        setFieldValue('#lc_txt_file_number', fileNumber);
        setFieldValue('#lc_txt_file_number_up', fileNumber);
        setFieldValue('#lc_txt_deed_number', deedNumber);
        setFieldValue('#lc_txt_deed_number_up', deedNumber);
        setFieldValue('#lc_txt_serial_number', serialNumber);
        setFieldValue('#lc_txt_serial_number_up', serialNumber);
        setFieldValue('#lc_txt_publicity_date', publicationDate);
        setFieldValue('#lc_bl_wkt_polygon', parcelWkt);
        setFieldValue('#lc_fr_bl_wkt_polygon', parcelWkt);
        setFieldValue('#deed_check_wkt_polygon', parcelWkt);
        updateDeedPolygonConfirmButton();

        if ($('#job_number_on_tc_e').length && !$('#job_number_on_tc_e').val()) {
            $('#job_number_on_tc_e').val(jobNumber);
        }

        if ($('#case_number_on_tc_e').length && !$('#case_number_on_tc_e').val()) {
            $('#case_number_on_tc_e').val(caseNumber);
        }

        $('#application_file_upload_case_number').val(caseNumber);
        $('#public_file_upload_case_number').val(caseNumber);
    }

    function applyLoadedJob(record) {
        state.loadedJob = record;
        updateLoadedSummary(record);
        syncJobContextToModals(record);
        markStepTwoReady(true);

        setLookupStatus(
            'success',
            '<strong>Application loaded.</strong> Step two is now ready for Upload Documents, Add/Edit Parties, and Further Entry Details.'
        );

        showAddToBatchButton(record);
    }

    function showAddToBatchButton(record) {

        const jobNumber = firstNonEmpty(record.job_number, record.jobNumber, $('#deed_job_number').val(), '--');
        // const caseNumber = firstNonEmpty(record.case_number, record.caseNumber, '--');
        const applicant = firstNonEmpty(record.ar_name, record.client_name, record.applicant_name, '--');
        const subService = firstNonEmpty(record.business_process_sub_name, record.sub_service_name, '--');
        // const locality = firstNonEmpty(record.locality, record.location_name, record.land_location, '--');
        // const status = firstNonEmpty(record.current_application_status, record.job_status, 'Loaded');
        const applicationStage = firstNonEmpty(record.application_stage, '--');
        const applicationStageName = firstNonEmpty(record.application_stage_name, '--');
        const applicationStageBabyStep = firstNonEmpty(record.application_stage_baby_step, '--');
        const applicationStageNameBabyStep = firstNonEmpty(record.application_stage_name_baby_step, '--');

        const btnHTML = '<button class="btn me-1 btn-warning btn-wave waves-effect waves-light btn-add-batch" ' +
                            'id="btnAddToBatchlist-' + jobNumber + '" ' +
                            'data-job_number="' + jobNumber + '" ' +
                            'data-ar_name="' + applicant + '" ' +
                            'data-business_process_sub_name="' + subService + '" ' +
                            'data-application_stage="' + applicationStage + '" ' +
                            'data-application_stage_name="' + applicationStageName + '" ' +
                            'data-application_stage_baby_step="' + applicationStageBabyStep + '" ' +
                            'data-application_stage_name_baby_step="' + applicationStageNameBabyStep + '" ' +
                            'data-bs-target="#askForPurposeOfBatching" data-bs-toggle="modal">' +
                            '<i class="fas fa-plus"></i> Add to Batch' +
                        '</button>';

        $('#addToBatchBtn').html(btnHTML);
    }

    function loadFullCaseDetails(record, config) {
        const jobNumber = firstNonEmpty(record.job_number, $('#deed_job_number').val());
        const caseNumber = firstNonEmpty(record.case_number);
        const transactionNumber = firstNonEmpty(record.transaction_number);

        if (!jobNumber || !caseNumber) {
            applyLoadedJob(record);
            return;
        }

        setLookupStatus('info', '<strong>Application found.</strong> Loading full case details...');
        state.loadingFullCase = true;

        $.ajax({
            type: 'POST',
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_general_case_details',
                job_number: jobNumber,
                case_number: caseNumber,
                transaction_number: transactionNumber
            },
            cache: false,
            success: function (response) {
                const payload = parseJsonSafely(response);

                if (payload) {
                    const fullRecord = extractFullDetailsRecord(payload, record);
                    applyLoadedJob(fullRecord);
                    return;
                }

                applyLoadedJob(record);
                setLookupStatus(
                    'warning',
                    '<strong>Application loaded partially.</strong> Full case details could not be parsed, so the initial job details were used.'
                );
            },
            error: function () {
                applyLoadedJob(record);
                setLookupStatus(
                    'warning',
                    '<strong>Application loaded partially.</strong> Full case details could not be loaded right now.'
                );
            },
            complete: function () {
                state.loadingFullCase = false;
                if (!config.silent) {
                    setLookupLoading(false);
                }
            }
        });
    }

    function openCreateExistingJobModal() {
        const typedJobNumber = $.trim($('#deed_job_number').val());

        if (!typedJobNumber) {
            setLookupStatus('warning', 'Enter a job number first before opening the creation modal.');
            $('#deed_job_number').focus();
            return;
        }

        $('#job_number_on_tc_e').val(typedJobNumber);
        $('#case_number_on_tc_e').val('');

        const modalElement = document.getElementById('CreateJobNumberModalExisting');

        if (modalElement && window.bootstrap && bootstrap.Modal) {
            bootstrap.Modal.getOrCreateInstance(modalElement).show();
        }
    }

    function loadApplicationByJobNumber(jobNumber, options) {
        const config = $.extend({ silent: false }, options);

        if (!jobNumber) {
            setLookupStatus('warning', 'Enter a valid job number to continue.');
            return;
        }

        if (!config.silent) {
            clearLookupStatus();
            setLookupLoading(true);
        }

        $.ajax({
            type: 'POST',
            url: 'Case_Management_Serv',
            data: {
                request_type: 'load_application_details_by_job_number_all',
                job_number: jobNumber
            },
            cache: false,
            success: function (response) {
                const payload = parseJsonSafely(response);
                const record = extractRecord(payload);

                if (record) {
                    loadFullCaseDetails(record, config);
                    return;
                }

                state.loadedJob = null;
                markStepTwoReady(false);
                updateLoadedSummary({});
                $('#deedLoadedStatus').text('Application not found');
                setLookupStatus(
                    'warning',
                    '<strong>No application was found for this job number.</strong> Use the existing-job modal to create it, then the page will reload the new job automatically.'
                );

                //swal fire to confirm and open the openCreateExistingJobModal;
                swal.fire({
                    title: 'No application was found',
                    text: 'Creating a new job will open the existing-job modal. Are you sure you want to create a new job instead?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Yes',
                    cancelButtonText: 'No'
                }).then((result) => {
                    if (result.isConfirmed) {
                        openCreateExistingJobModal();
                    }
                });
            },
            error: function () {
                setLookupStatus('danger', 'We could not verify the job number right now. Please try again.');
            },
            complete: function () {
                if (!config.silent && !state.loadingFullCase) {
                    setLookupLoading(false);
                }
            }
        });
    }

    function populateSelect($select, defaultLabel, rows, valueBuilder, labelBuilder) {
        $select.empty().append(new Option(defaultLabel, '0'));

        $.each(rows || [], function () {
            $select.append(new Option(labelBuilder(this), valueBuilder(this)));
        });
    }

    function loadExistingJobModalOptions() {
        if (state.modalOptionsLoaded) {
            return;
        }

        $.ajax({
            type: 'POST',
            url: 'Case_Management_Serv',
            data: { request_type: 'get_lc_main_service' },
            cache: false,
            success: function (response) {
                const rows = parseJsonSafely(response) || [];
                populateSelect(
                    $('#main_service_on_tc_e'),
                    '-- Select --',
                    rows,
                    function (row) {
                        return row.business_process_id + '-' + row.business_process_name;
                    },
                    function (row) {
                        return row.business_process_name;
                    }
                );
            }
        });

        $.ajax({
            type: 'POST',
            url: 'Case_Management_Serv',
            data: { request_type: 'get_type_of_use_list' },
            cache: false,
            success: function (response) {
                const rows = parseJsonSafely(response) || [];
                populateSelect(
                    $('#type_of_use_on_tc_e'),
                    '-- Select --',
                    rows,
                    function (row) {
                        return row.typeofuse_id + '_' + row.typeofuse_name;
                    },
                    function (row) {
                        return row.typeofuse_name;
                    }
                );
            }
        });

        $.ajax({
            type: 'POST',
            url: 'app_modal_fills_serv',
            data: { request_type: 'get_all_office_region' },
            cache: false,
            success: function (response) {
                const rows = parseJsonSafely(response) || [];
                populateSelect(
                    $('#office_region_on_tc_e'),
                    '-- Select --',
                    rows,
                    function (row) {
                        return row.ord_region_code + '_' + row.ord_region_name;
                    },
                    function (row) {
                        return row.ord_region_name;
                    }
                );
            }
        });

        state.modalOptionsLoaded = true;
    }

    function loadSubServices(mainServiceValue) {
        const parts = String(mainServiceValue || '').split('-');
        const mainServiceId = parts[0];

        if (!mainServiceId || mainServiceId === '0' || mainServiceId === '-1') {
            $('#sub_service_on_tc_e').empty().append(new Option('Select Sub Service', '-1'));
            return;
        }

        $.ajax({
            type: 'POST',
            url: 'Case_Management_Serv',
            data: { request_type: 'get_lc_sub_service' },
            cache: false,
            success: function (response) {
                const rows = parseJsonSafely(response) || [];
                const matchingRows = $.grep(rows, function (row) {
                    return String(row.business_process_id) === String(mainServiceId);
                });

                $('#sub_service_on_tc_e').empty().append(new Option('-- Select --', '0'));
                $.each(matchingRows, function () {
                    $('#sub_service_on_tc_e').append(
                        new Option(this.business_process_sub_name, this.business_process_sub_id + '-' + this.business_process_sub_name)
                    );
                });
            }
        });
    }

    function loadLocalities(regionValue) {
        const parts = String(regionValue || '').split('_');
        const regionId = parts[0];

        if (!regionId || regionId === '0' || regionId === '-1') {
            $('#locality_on_tc_e').empty().append(new Option('-- Select --', '0'));
            return;
        }

        $.ajax({
            type: 'POST',
            url: 'Case_Management_Serv',
            data: {
                request_type: 'get_list_of_locality',
                region_id: regionId
            },
            cache: false,
            success: function (response) {
                const rows = parseJsonSafely(response) || [];

                $('#locality_on_tc_e').empty().append(new Option('-- Select --', '0'));
                $.each(rows, function () {
                    $('#locality_on_tc_e').append(new Option(this.location_name, this.location_name));
                });
            }
        });
    }

    function createExistingJobApplication() {
        const mainService = $('#main_service_on_tc_e').val();
        const subService = $('#sub_service_on_tc_e').val();
        const officeRegion = $('#office_region_on_tc_e').val();
        const mainServiceParts = String(mainService || '').split('-');
        const subServiceParts = String(subService || '').split('-');
        const officeRegionParts = String(officeRegion || '').split('_');
        const jobNumber = $.trim($('#job_number_on_tc_e').val());
        const caseNumber = $.trim($('#case_number_on_tc_e').val());

        if (!jobNumber) {
            Swal.fire({
                icon: 'warning',
                title: 'Job Number Required',
                text: 'Enter the job number you want to create before continuing.'
            });
            return;
        }

        $.ajax({
            type: 'POST',
            url: 'Case_Management_Serv',
            data: {
                request_type: 'online_select_process_acknowledgement_not_on_case_exist_cj',
                main_service_id: firstNonEmpty(mainServiceParts[0], ''),
                main_service_sub_id: firstNonEmpty(subServiceParts[0], ''),
                main_service_desc: firstNonEmpty(mainServiceParts[1], ''),
                main_service_sub_desc: firstNonEmpty(subServiceParts[1], ''),
                client_name: $.trim($('#applicant_name_on_tc_e').val()),
                land_size: $.trim($('#land_size_on_tc_e').val()),
                locality: $.trim($('#locality_on_tc_e').val()),
                type_of_use: $('#type_of_use_on_tc_e').val(),
                type_of_interest: $('#type_of_interest_on_tc_e').val(),
                job_number: jobNumber,
                case_number: caseNumber,
                nature_of_instrument: $('#nature_of_instrument_on_tc_e').val(),
                office_region_id: firstNonEmpty(officeRegionParts[0], ''),
                office_region_name: firstNonEmpty(officeRegionParts[1], '')
            },
            cache: false,
            beforeSend: function () {
                $('#btn_create_new_job_and_case_number_e')
                    .prop('disabled', true)
                    .html('<span class="spinner-border spinner-border-sm me-1" role="status" aria-hidden="true"></span>Generating...');
            },
            success: function (response) {
                const payload = parseJsonSafely(response);

                if (payload && payload.job_number) {
                    $('#job_number_on_tc_e').val(payload.job_number);
                }

                if (payload && payload.case_number) {
                    $('#case_number_on_tc_e').val(payload.case_number);
                }

                const createdJobNumber = firstNonEmpty(
                    payload && payload.job_number,
                    $('#job_number_on_tc_e').val(),
                    jobNumber
                );

                Swal.fire({
                    icon: 'success',
                    title: 'Application Created',
                    text: 'The job has been created. Loading the new application now.',
                    timer: 1800,
                    showConfirmButton: false
                });

                const modalElement = document.getElementById('CreateJobNumberModalExisting');
                if (modalElement && window.bootstrap && bootstrap.Modal) {
                    const instance = bootstrap.Modal.getInstance(modalElement);
                    if (instance) {
                        instance.hide();
                    }
                }

                $('#deed_job_number').val(createdJobNumber);
                loadApplicationByJobNumber(createdJobNumber);
            },
            error: function () {
                Swal.fire({
                    icon: 'error',
                    title: 'Creation Failed',
                    text: 'We could not create the application. Please review the modal fields and try again.'
                });
            },
            complete: function () {
                $('#btn_create_new_job_and_case_number_e')
                    .prop('disabled', false)
                    .html('<i class="bi bi-arrow-repeat me-1"></i>Generate Existing Application');
            }
        });
    }

    $(function () {
        markStepTwoReady(false);
        updateDeedPolygonConfirmButton();

        $('#deedJobLookupForm').on('submit', function (event) {
            event.preventDefault();
            loadApplicationByJobNumber($.trim($('#deed_job_number').val()));
        });

        $('#deedCreateMissingJobButton').on('click', function () {
            openCreateExistingJobModal();
        });

        $('#CreateJobNumberModalExisting').on('show.bs.modal', function () {
            loadExistingJobModalOptions();
            $('#job_number_on_tc_e').val($.trim($('#deed_job_number').val()));
        });

        $('#main_service_on_tc_e').on('change', function () {
            loadSubServices($(this).val());
        });

        $('#office_region_on_tc_e').on('change', function () {
            loadLocalities($(this).val());
        });

        $('#btn_create_new_job_and_case_number_e').on('click', function () {
            createExistingJobApplication();
        });

        $('#further_entry').on('show.bs.modal', function () {
            if (state.loadedJob) {
                syncJobContextToModals(state.loadedJob);
            }
        });

        $('#deed_check_polygon').on('shown.bs.modal', updateDeedPolygonConfirmButton);

        $('#deed_check_wkt_polygon').on('input change', updateDeedPolygonConfirmButton);

        $('#btn_send_deed_noting_request').on('click', openDeedNotingRequestModal);

        $('#askForPurposeOfSendingRequest').on('hidden.bs.modal', resetDeedNotingRequestModal);

        $('.deed-action-launch').on('click', function () {
            if (!state.loadedJob) {
                setLookupStatus('warning', 'Load a job first before opening step two actions.');
                return false;
            }

            syncJobContextToModals(state.loadedJob);
            return true;
        });
    });
}(jQuery));
