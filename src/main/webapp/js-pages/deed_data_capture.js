(function ($) {
    const state = {
        loadedJob: null,
        modalOptionsLoaded: false
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

        console.log('syncJobContextToModals', record);

        const jobNumber = firstNonEmpty(record.job_number, $('#deed_job_number').val());
        const caseNumber = firstNonEmpty(record.case_number);
        const applicant = firstNonEmpty(record.ar_name, record.client_name, record.applicant_name);
        const subService = firstNonEmpty(record.business_process_sub_name, record.sub_service_name);

        window.currentDeedCaptureContext = {
            job_number: jobNumber,
            case_number: caseNumber,
            ar_name: applicant,
            business_process_sub_name: subService,
            locality: firstNonEmpty(record.locality, record.location_name),
            data: record
        };

        $('#fe_job_number').val(jobNumber);
        $('#fe_case_number').val(caseNumber);
        $('#fe_client_name').val(applicant);
        $('#fe_business_process_sub_name').val(subService);
        $('#fe_transaction_number').val(firstNonEmpty(record.transaction_number, ''));
        $('#fe_locality').val(firstNonEmpty(record.locality, record.location_name));
        $('#fe_land_size').val(firstNonEmpty(record.land_size, ''));

        $('#cs_main_transaction_number').val(firstNonEmpty(record.transaction_number, ''));
        $('#cs_main_case_number').val(firstNonEmpty(record.case_number, ''));
        $('#cs_main_job_number').val(firstNonEmpty(record.job_number, ''));

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
                    applyLoadedJob(record);
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
                if (!config.silent) {
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
