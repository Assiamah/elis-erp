$(document).ready(function() {
    var specialPublicationEditorId = 'lc_search_report_summary_details_pp';
    var specialPublicationQuill = null;

    function initSpecialPublicationEditor() {
        var editorSelector = '#' + specialPublicationEditorId;
        var $editor = $(editorSelector);

        if (!$editor.length) {
            return;
        }

        var $tabPane = $editor.closest('.tab-pane');
        if ($tabPane.length && !$tabPane.hasClass('active') && !$tabPane.is(':visible')) {
            return;
        }

        if (window.hugerte && hugerte.get(specialPublicationEditorId)) {
            return;
        }

        if (specialPublicationQuill) {
            return;
        }

        if (window.Quill) {
            initSpecialPublicationQuill();
            return;
        }

        if (window.hugerte && !hugerte.get(specialPublicationEditorId)) {
            // var hugeRteInit = hugerte.init({
            //     selector: editorSelector,
            //     height: 300,
            //     menubar: false,
            //     toolbar: 'undo redo | blocks | bold italic underline | ' +
            //         'alignleft aligncenter alignright alignjustify | ' +
            //         'bullist numlist outdent indent | removeformat',
            //     toolbar_mode: 'floating',
            //     content_style: [
            //         'body { font-family: "Times New Roman", Times, serif; font-size: 14px; line-height: 1.6; padding: 16px; }',
            //         'p { margin: 0 0 10px; }'
            //     ].join(' '),
            //     setup: function(editor) {
            //         editor.on('change keyup setcontent', function() {
            //             editor.save();
            //         });
            //     }
            // });

            var hugeRteInit = hugerte.init({
                selector: editorSelector,
                height: 300,
                menubar: true,
                plugins: [
                    'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview',
                    'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
                    'insertdatetime', 'media', 'table', 'help', 'wordcount', 'emoticons'
                ],
                toolbar: 'undo redo | blocks | ' +
                    'bold italic underline strikethrough | ' +
                    'alignleft aligncenter alignright alignjustify | ' +
                    'bullist numlist outdent indent | ' +
                    'link image media table | ' +
                    'forecolor backcolor emoticons | ' +
                    'removeformat | help',
                toolbar_mode: 'floating',
                content_style: `
                    body { 
                        font-family: 'Times New Roman', Times, serif; 
                        font-size: 14px; 
                        line-height: 1.6;
                        padding: 20px;
                    }
                    h1 { font-size: 24px; }
                    h2 { font-size: 20px; }
                    h3 { font-size: 18px; }
                `,
                
                // Image upload handling (optional)
                images_upload_url: 'upload.php', // Add your upload endpoint
                images_upload_handler: function (blobInfo, success, failure) {
                    // Handle image uploads
                    setTimeout(function() {
                        success('data:' + blobInfo.blob().type + ';base64,' + blobInfo.base64());
                    }, 1000);
                },
                
                // Make it feel more like Word
                setup: function(editor) {
                    editor.on('init', function() {
                        console.log('Editor initialized - ready to use!');
                    });
                    
                    // Add keyboard shortcuts like Word
                    editor.addShortcut('meta+s', 'Save', function() {
                        alert('Save content: ' + editor.getContent());
                        return false;
                    });
                }
            });

            if (hugeRteInit && hugeRteInit.catch) {
                hugeRteInit.catch(function() {
                    initSpecialPublicationQuill();
                });
            }

            setTimeout(function() {
                if (!hugerte.get(specialPublicationEditorId)) {
                    initSpecialPublicationQuill();
                }
            }, 1200);

            return;
        }

        if (!window.hugerte && !window.Quill && !$.fn.summernote) {
            setTimeout(function() {
                initSpecialPublicationQuill();
            }, 250);
            return;
        }

        initSpecialPublicationQuill();
    }

    function initSpecialPublicationQuill() {
        var editorSelector = '#' + specialPublicationEditorId;
        var $editor = $(editorSelector);

        if (!$editor.length || specialPublicationQuill) {
            return;
        }

        if (window.Quill) {
            var quillContainerId = specialPublicationEditorId + '_quill';

            if (!$('#' + quillContainerId).length) {
                $editor.after('<div id="' + quillContainerId + '" style="height: 420px;"></div>');
                $editor.hide();
            }

            specialPublicationQuill = new Quill('#' + quillContainerId, {
                theme: 'snow',
                modules: {
                    toolbar: [
                        [{ header: [1, 2, 3, false] }],
                        ['bold', 'italic', 'underline'],
                        [{ list: 'ordered' }, { list: 'bullet' }],
                        [{ align: [] }],
                        ['clean']
                    ]
                }
            });

            if ($editor.val()) {
                specialPublicationQuill.root.innerHTML = $editor.val();
            }

            specialPublicationQuill.on('text-change', function() {
                $editor.val(specialPublicationQuill.root.innerHTML);
            });
            return;
        }

        if ($.fn.summernote && !$(editorSelector).next('.note-editor').length) {
            $(editorSelector).summernote({
                minHeight: 400,
                placeholder: 'Write here ...',
                focus: false,
                fontName: 'Times New Roman',
                fontNames: ['Times New Roman'],
                dialogsInBody: true,
                toolbar: [
                    ['style', ['bold', 'italic', 'underline', 'clear']],
                    ['fontname', ['fontname']],
                    ['color', ['color']],
                    ['para', ['style', 'ul', 'ol', 'paragraph']],
                    ['fontsize', ['fontsize']],
                    ['height', ['height']],
                    ['misc', ['undo', 'redo', 'fullscreen', 'help']]
                ]
            });
        }
    }

    function getSpecialPublicationContent() {
        var editor = window.hugerte ? hugerte.get(specialPublicationEditorId) : null;

        if (editor) {
            editor.save();
            return editor.getContent().trim();
        }

        if (specialPublicationQuill) {
            var quillContent = specialPublicationQuill.root.innerHTML.trim();
            $('#' + specialPublicationEditorId).val(quillContent);
            return quillContent;
        }

        if ($.fn.summernote && $('#' + specialPublicationEditorId).next('.note-editor').length) {
            return $('#' + specialPublicationEditorId).summernote('code').trim();
        }

        return $('#' + specialPublicationEditorId).val().trim();
    }

    function getSpecialPublicationListPayload() {
        return JSON.stringify([{
            "client_number": $("#sp_job_number").val().trim(),
            "case_number": $("#sp_case_number").val().trim(),
            "business_process_sub_name": '',
            "glpin": '',
            "ar_name": $("#sp_ar_name").val().trim(),
            "location": $("#sp_locality").val().trim(),
            "grantor": $("#sp_grantor_name").val().trim(),
            "extent": $("#sp_extent").val().trim(),
            "interest": $("#sp_type_of_interest").val().trim(),
            "registry_map": $("#sp_registry_mapref").val().trim(),
            "description": ''
        }]);
    }

    window.getSpecialPublicationContent = getSpecialPublicationContent;

    initSpecialPublicationEditor();
    $(window).on('load', initSpecialPublicationEditor);
    $('#special-tab, button[data-bs-target="#specialPublicationList"]').on('shown.bs.tab click', function() {
        setTimeout(initSpecialPublicationEditor, 50);
    });

    function parseExtentValue(extentText) {
        if (!extentText) {
            return 0;
        }

        var sanitizedExtent = String(extentText).replace(/,/g, '');
        var extentMatch = sanitizedExtent.match(/-?\d+(\.\d+)?/);
        return extentMatch ? parseFloat(extentMatch[0]) : 0;
    }

    function showSpecialPublicationTab() {
        var specialTabButton = document.querySelector('#special-tab');

        if (specialTabButton && window.bootstrap && bootstrap.Tab) {
            bootstrap.Tab.getOrCreateInstance(specialTabButton).show();
            return;
        }

        $('#special-tab').trigger('click');
    }

    function populateSpecialPublicationForm(applicationData) {
        $("#sp_ar_name").val(applicationData.ar_name || '');
        $("#sp_grantor_name").val(applicationData.grantor_name || '');
        $("#sp_case_number").val(applicationData.case_number || '');
        $("#sp_locality").val(applicationData.locality || '');
        $("#sp_job_number").val(applicationData.job_number || '');
        $("#sp_type_of_interest").val(applicationData.type_of_interest || '');
        $("#sp_extent").val(applicationData.extent || '');
        $("#sp_registry_mapref").val(applicationData.registry_mapref || '');
        $('#btnActionsSP').show();
        showSpecialPublicationTab();
    }

    $('.btn-load-special-publication').each(function() {
        var extentValue = parseExtentValue($(this).data('extent'));
        if (extentValue > 5) {
            $(this).removeClass('d-none');
        }
    });

    $(document).on('click', '.btn-load-special-publication', function() {
        var $button = $(this);
        var extentText = $button.data('extent');
        var extentValue = parseExtentValue(extentText);

        if (extentValue <= 5) {
            Swal.fire({
                icon: 'info',
                title: 'Special Publication Not Required',
                text: 'Only applications with extent greater than 5 acres can be sent to Special Publication.',
                confirmButtonColor: '#3085d6'
            });
            return;
        }

        populateSpecialPublicationForm({
            ar_name: $button.data('ar-name'),
            grantor_name: $button.data('grantor-name'),
            case_number: $button.data('case-number'),
            locality: $button.data('locality'),
            job_number: $button.data('job-number'),
            type_of_interest: $button.data('type-of-interest'),
            extent: extentText,
            registry_mapref: $button.data('registry-mapref')
        });

        Swal.fire({
            icon: 'success',
            title: 'Loaded!',
            text: 'Application details loaded into Special Publication.',
            timer: 2000,
            showConfirmButton: false
        });
    });
    
    $('#frmFindJobForPublication').on('submit', function(e) {
        e.preventDefault();

        var job_search_value = $("#job_search_value").val().toUpperCase();
        console.log('Search Value: ' + job_search_value);

        if (!(job_search_value.length >= 10)) {
            Swal.fire({
                icon: 'error',
                title: 'Invalid Job Number',
                text: 'Please enter a valid Job Number (minimum 10 characters)',
                confirmButtonColor: '#d33'
            });
            return;
        }

        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'load_application_details_by_job_number',
                job_number: job_search_value
            },
            success: function(jobdetails) {
                try {
                    var result = JSON.parse(jobdetails);
                    
                    if (result.job_detail !== null) {
                        $("#rs_ar_name").val(result.transaction_details.ar_name);
                        $("#rs_grantor_name").val(result.transaction_details.party_grantors_name);
                        $("#rs_case_number").val(result.parcel_details.case_number);
                        $("#rs_locality").val(result.parcel_details.locality);
                        $("#rs_job_number").val(result.job_detail.job_number);
                        $("#rs_type_of_interest").val(result.transaction_details.type_of_interest);
                        $("#rs_extent").val(result.parcel_details.extent);
                        $("#rs_registry_mapref").val(result.parcel_details.registry_mapref);
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Not Found',
                            text: 'Job number not found',
                            confirmButtonColor: '#d33'
                        });
                    }
                } catch (e) {
                    console.log(e);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'An error occurred while processing your request',
                        confirmButtonColor: '#d33'
                    });
                }
            },
            error: function() {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Failed to connect to server',
                    confirmButtonColor: '#d33'
                });
            }
        });
    });
    
    $('#frmAddToPublicationList').on('submit', function(e) {
        e.preventDefault();

        var v_case_number = $("#rs_case_number").val().toUpperCase();

        if (!(v_case_number.length >= 10)) {
            Swal.fire({
                icon: 'error',
                title: 'Invalid Case Number',
                text: 'Please enter a valid Case Number (minimum 10 characters)',
                confirmButtonColor: '#d33'
            });
            return;
        }

        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'add_application_to_publication_list',
                case_number: v_case_number
            },
            success: function(data) {
                console.log(data)
                try {
                    if (parseInt(data) === 1) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Added!',
                            text: 'Application Added',
                            confirmButtonColor: '#3085d6'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                location.reload(true);
                            }
                        });
                    }
                } catch (e) {
                    console.log(e);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'An error occurred while processing your request',
                        confirmButtonColor: '#d33'
                    });
                }
            },
            error: function() {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Failed to connect to server',
                    confirmButtonColor: '#d33'
                });
            }
        });
    });
    
    $('#unpublishedDataTable').DataTable();
    
    // Helper function to group by location using native JavaScript
    function groupByLocation(dataArray) {
        return dataArray.reduce(function(acc, current) {
            if (!current || !current.location) {
                return acc;
            }
            var location = current.location;
            if (!acc[location]) {
                acc[location] = [];
            }
            acc[location].push(current);
            return acc;
        }, {});
    }
    
    $("#btnViewPublicationList").click(function(event) {
        var send_to_address = "test";
        var publication_list = storeTblValues();
        
        function storeTblValues() {
            var TableData = new Array();
            $('#unpublishedDataTable tr').each(function(row, tr) {
                var extentText = $(tr).find('td:eq(9)').text().trim();
                var extentValue = parseExtentValue(extentText);

                if (row !== 0 && extentValue >= 5) {
                    return;
                }

                TableData.push({
                    "client_number": $(tr).find('td:eq(1)').text().trim(),
                    "case_number": $(tr).find('td:eq(3)').text().trim(),
                    "business_process_sub_name": $(tr).find('td:eq(4)').text().trim(),
                    "glpin": $(tr).find('td:eq(5)').text().trim(),
                    "ar_name": $(tr).find('td:eq(6)').text().trim(),
                    "location": $(tr).find('td:eq(7)').text().trim(),
                    "grantor": $(tr).find('td:eq(8)').text().trim(),
                    "extent": extentText,
                    "interest": $(tr).find('td:eq(10)').text().trim(),
                    "registry_map": $(tr).find('td:eq(11)').text().trim(),
                    "description": $(tr).find('td:eq(12)').text().trim()
                });
            });
            TableData.shift();
            return TableData;
        }

        // Replace _.groupBy with native JavaScript
        var groupedByLocation = groupByLocation(publication_list);
        
        // Sort keys alphabetically
        const ordered = {};
        Object.keys(groupedByLocation).sort().forEach(function(key) {
            ordered[key] = groupedByLocation[key];
        });

        $.ajax({
            type: "POST",
            url: "GenerateCaseReports",
            target: '_blank',
            data: {
                request_type: 'request_to_generate_publication_list',
                publication_list: JSON.stringify(ordered),
                to_email_address: send_to_address
            },
            cache: false,
            xhrFields: {
                responseType: 'blob'
            },
            // success: function(data) {
            //     $('#elisDocumentPreview').modal({
            //         backdrop: 'static',
            //     });
            //     var blob = new Blob([data], { type: "application/pdf" });
            //     var objectUrl = URL.createObjectURL(blob);
            //     $('#elisdovumentpreviewblobfile').attr('src', objectUrl);
            // }
			beforeSend: function() {
                // Show loading indicator
                showLoadingIndicator();
            },
            success: function(pdfBlob) {
                // Create file object from blob
                const file = new File([pdfBlob], `Publication_list_${Date.now()}.pdf`, {
                    type: "application/pdf",
                    lastModified: Date.now()
                });
                
                // Create object URL
                const fileURL = URL.createObjectURL(file);
                
                // Open PDF in modal
                openPDFModal(file, fileURL);
                
                // Hide loading indicator
                hideLoadingIndicator();

                // var blob = new Blob([pdfBlob], {type: "application/pdf"});
                // var objectUrl = URL.createObjectURL(blob);
                // window.open(objectUrl);
            },
            error: function(xhr, status, error) {
                console.error('Error generating PDF:', error);
                hideLoadingIndicator();
                
                // Show error message
                Swal.fire({
                    title: 'Error',
                    text: 'Failed to generate PDF document. Please try again.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
            }
        });
    });
    
    $("#btnPreviewSP").click(function(e) {
        let send_to_address = "test";
        let publication_list = getSpecialPublicationContent();

        $.ajax({
            type: "POST",
            url: "GenerateCaseReports",
            target: '_blank',
            data: {
                request_type: 'request_to_generate_special_publication',
                publication_list: publication_list,
                to_email_address: send_to_address
            },
            cache: false,
            xhrFields: {
                responseType: 'blob'
            },
            // success: function(data) {
            //     $('#elisDocumentPreview').modal({
            //         backdrop: 'static',
            //     });
            //     var blob = new Blob([data], { type: "application/pdf" });
            //     var objectUrl = URL.createObjectURL(blob);
            //     $('#elisdovumentpreviewblobfile').attr('src', objectUrl);
            // }
			beforeSend: function() {
                // Show loading indicator
                showLoadingIndicator();
            },
            success: function(pdfBlob) {
                // Create file object from blob
                const file = new File([pdfBlob], `Publication_list_${Date.now()}.pdf`, {
                    type: "application/pdf",
                    lastModified: Date.now()
                });
                
                // Create object URL
                const fileURL = URL.createObjectURL(file);
                
                // Open PDF in modal
                openPDFModal(file, fileURL);
                
                // Hide loading indicator
                hideLoadingIndicator();

                // var blob = new Blob([pdfBlob], {type: "application/pdf"});
                // var objectUrl = URL.createObjectURL(blob);
                // window.open(objectUrl);
            },
            error: function(xhr, status, error) {
                console.error('Error generating PDF:', error);
                hideLoadingIndicator();
                
                // Show error message
                Swal.fire({
                    title: 'Error',
                    text: 'Failed to generate PDF document. Please try again.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
            }
        });
    });
    
    $("#btnAddToSP").click(function(event) {
        var confirmText = "<br><br><h5> You have requested to add this application details to the Special Publication list. </h5>  <br> <span style='color:red'>Pls Confirm</span> <br><br>";

        Swal.fire({
            title: "Adding applications to Special Publication!",
            html: confirmText,
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '<i class="fa fa-check"></i> Confirm',
            cancelButtonText: '<i class="fa fa-times"></i> Cancel'
        }).then((result) => {
            console.log('This was logged in the callback: ' + result.value);
            if (result.isConfirmed) {
                $("#addOldCaseModal").modal("hide");
                
                populateSpecialPublicationForm({
                    ar_name: $("#rs_ar_name").val(),
                    grantor_name: $("#rs_grantor_name").val(),
                    case_number: $("#rs_case_number").val(),
                    locality: $("#rs_locality").val(),
                    job_number: $("#rs_job_number").val(),
                    type_of_interest: $("#rs_type_of_interest").val(),
                    extent: $("#rs_extent").val(),
                    registry_mapref: $("#rs_registry_mapref").val()
                });
                
                Swal.fire({
                    icon: 'success',
                    title: 'Added!',
                    text: 'Application added to Special Publication list',
                    timer: 2000,
                    showConfirmButton: false
                });
            }
        });
    });
    
    // $("#btnSaveSP").click(function() {
    //     var confirmText = "<br><br><h5> Pls select the publication agency to sent list to</h5>  <br> <span style='color:red'>Note that this cannot be undone!</span> <br><br>";

    //     Swal.fire({
    //         title: "Sending applications for Publication!",
    //         html: confirmText,
    //         icon: 'warning',
    //         input: 'select',
    //         inputOptions: {
    //             '': 'Choose agency...',
    //             'judeyamoah@gmail.com': 'Daily Graphic',
    //             'judeyamoah@gmail.com': 'The Spectator',
    //             'judeyamoah@gmail.com': 'The Ghanaian Times'
    //         },
    //         inputPlaceholder: 'Select agency',
    //         inputValidator: (value) => {
    //             if (!value) {
    //                 return 'You need to select an agency!';
    //             }
    //         },
    //         showCancelButton: true,
    //         confirmButtonColor: '#3085d6',
    //         cancelButtonColor: '#d33',
    //         confirmButtonText: '<i class="fa fa-check"></i> Send',
    //         cancelButtonText: '<i class="fa fa-times"></i> Cancel',
    //         allowOutsideClick: false
    //     }).then((result) => {
    //         if (result.isConfirmed && result.value) {
    //             try {
    //                 let send_to_address = result.value;
    //                 let publication_list = $("#lc_search_report_summary_details_pp").val();
                    
    //                 Swal.fire({
    //                     title: 'Generating...',
    //                     text: 'Please wait while we generate the document',
    //                     allowOutsideClick: false,
    //                     didOpen: () => {
    //                         Swal.showLoading();
    //                     }
    //                 });
                    
    //                 $.ajax({
    //                     type: "POST",
    //                     url: "GenerateCaseReports",
    //                     target: '_blank',
    //                     data: {
    //                         request_type: 'request_to_generate_special_publication_on_case',
    //                         publication_list: publication_list,
    //                         case_number: $('#sp_case_number').val(),
    //                         to_email_address: send_to_address
    //                     },
    //                     cache: false,
    //                     xhrFields: {
    //                         responseType: 'blob'
    //                     },
    //                     success: function(data) {
    //                         Swal.close();
    //                         $('#pdfModal').modal({
    //                             backdrop: 'static',
    //                         });
                            
    //                         var blob = new Blob([data], { type: "application/pdf" });
    //                         var objectUrl = URL.createObjectURL(blob);
    //                         $('#pdfPreviewFrame').attr('src', objectUrl);
                            
    //                         Swal.fire({
    //                             icon: 'success',
    //                             title: 'Success!',
    //                             text: 'Document generated successfully',
    //                             timer: 2000,
    //                             showConfirmButton: false
    //                         });
    //                     },
    //                     error: function() {
    //                         Swal.close();
    //                         Swal.fire({
    //                             icon: 'error',
    //                             title: 'Error',
    //                             text: 'Failed to generate document',
    //                             confirmButtonColor: '#d33'
    //                         });
    //                     }
    //                 });
    //             } catch (e) {
    //                 Swal.fire({
    //                     icon: 'error',
    //                     title: 'Error',
    //                     text: 'An error occurred',
    //                     confirmButtonColor: '#d33'
    //                 });
    //             }
    //         }
    //     });
    // });

	$("#btnSaveSP").click(function() {
    // First, check if there's a case number
    var caseNumber = $('#sp_case_number').val();
    if (!caseNumber) {
        Swal.fire({
            icon: 'warning',
            title: 'No Case Selected',
            text: 'Please select a case first.',
            confirmButtonColor: '#d33'
        });
        return;
    }
    
    // Get the list of agencies
     var agencies = [
        { email: '', name: 'Email', icon: '@' },
        // { email: '', name: 'The Spectator', icon: '📰' },
        // { email: '', name: 'Ghanaian Times', icon: '📰' },
    ];
    
    // Build agency options for the modal
    var agencyOptions = '';
    agencies.forEach(function(agency, index) {
        agencyOptions += `
            <div class="col-md-6">
                <div class="agency-card" data-email="${agency.email}" data-name="${agency.name}">
                    <div class="form-check">
                        <input class="form-check-input agency-radio" type="radio" name="agencySelection" 
                               id="agency_${index}" value="${agency.name}">
                        <label class="form-check-label" for="agency_${index}">
                            <div class="agency-content">
                                <!--<span class="agency-icon">${agency.icon}</span>-->
                                <div class="agency-details">
                                    <span class="agency-name">${agency.name}</span>
                                    <!--<small class="agency-email text-muted">${agency.email}</small>
                                    <small class="agency-desc text-muted">${agency.description}</small>-->
                                </div>
                            </div>
                        </label>
                    </div>
                </div>
            </div>
        `;
    });
    
    // Create the modal HTML
    var modalHTML = `
        <div class="modal fade modal-blur" id="specialPublicationAgencyModal" tabindex="-1" aria-labelledby="specialPublicationAgencyModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content border-0">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title text-white" id="specialPublicationAgencyModalLabel">
                            <i class="fas fa-paper-plane me-2"></i>Send Special Publication
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    
                    <div class="modal-body">
                        <!-- Case Information Card -->
                        <div class="card bg-light border-0 mb-4">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="d-flex align-items-center mb-2">
                                            <i class="fas fa-gavel text-primary me-2"></i>
                                            <span class="fw-bold">Job Number:</span>
                                            <span class="ms-2 text-primary">${$('#sp_job_number').val()}</span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-user text-success me-2"></i>
                                            <span class="fw-bold">Applicant:</span>
                                            <span class="ms-2">${$('#sp_ar_name').val() || 'N/A'}</span>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="d-flex align-items-center mb-2">
                                            <i class="fas fa-map-marker-alt text-info me-2"></i>
                                            <span class="fw-bold">Location:</span>
                                            <span class="ms-2">${$('#sp_locality').val() || 'N/A'}</span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-ruler text-warning me-2"></i>
                                            <span class="fw-bold">Extent:</span>
                                            <span class="ms-2">${$('#sp_extent').val() || 'N/A'}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Info Alert -->
                        <div class="alert alert-info d-flex align-items-center mb-4">
                            <i class="fas fa-info-circle fa-2x me-3"></i>
                            <div>
                                <strong>Select Publication Agency</strong><br>
                                Choose where to send this special publication notice.
                            </div>
                        </div>
                        
                        <!-- Agency Selection Grid -->
                        <div class="agency-selection-container mb-4">
                            <!--<label class="form-label fw-bold mb-3">
                                <i class="fas fa-building me-2"></i>Available Agencies
                            </label>-->
                            <div class="row g-3">
                                ${agencyOptions}
                            </div>
                        </div>
                        
                        <!-- Publication Details Card -->
                        <div class="card border-0 bg-light">
                            <div class="card-body">
                                <h6 class="card-title mb-3">
                                    <i class="fas fa-file-alt me-2 text-primary"></i>Publication Details
                                </h6>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-2">
                                            <small class="text-muted d-block">Type of Interest</small>
                                            <span class="fw-bold">${$('#sp_type_of_interest').val() || 'N/A'}</span>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-2">
                                            <small class="text-muted d-block">Registry Map Ref</small>
                                            <span class="fw-bold">${$('#sp_registry_mapref').val() || 'N/A'}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Warning Alert -->
                        <div class="alert alert-warning d-flex align-items-center mt-4">
                            <i class="fas fa-exclamation-triangle fa-2x me-3"></i>
                            <div>
                                <strong>Important Note</strong><br>
                                Once sent, this publication cannot be modified. Please verify all details.
                            </div>
                        </div>
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Cancel
                        </button>
                        <button type="button" class="btn btn-primary" id="confirmSpecialPublicationBtn" disabled>
                            <i class="fas fa-send me-2"></i>Send for Publication
                        </button>
                    </div>
                </div>
            </div>
        </div>
    `;
    
    // Add custom styles for the modal
    const style = document.createElement('style');
    style.innerHTML = `
        .agency-card {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 15px;
            transition: all 0.3s ease;
            cursor: pointer;
            background: white;
            height: 100%;
        }
        .agency-card:hover {
            border-color:rgb(4, 79, 11);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,123,255,0.15);
        }
        .agency-card.selected {
            border-color: #28a745;
            background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
            box-shadow: 0 5px 15px rgba(40,167,69,0.2);
        }
        .agency-card .form-check {
            margin: 0;
            padding: 0;
        }
        .agency-card .form-check-input {
            position: absolute;
            opacity: 0;
        }
        .agency-card .form-check-label {
            cursor: pointer;
            width: 100%;
            margin: 0;
            padding: 0;
        }
        .agency-content {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .agency-icon {
            font-size: 32px;
            min-width: 50px;
            text-align: center;
            background: #f8f9fa;
            padding: 10px;
            border-radius: 10px;
        }
        .agency-details {
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        .agency-name {
            font-weight: 600;
            color: #2c3e50;
            font-size: 16px;
            margin-bottom: 4px;
        }
        .agency-email {
            font-size: 12px;
            color: #6c757d;
            margin-bottom: 2px;
        }
        .agency-desc {
            font-size: 11px;
            color: #adb5bd;
        }
        .agency-card.selected .agency-icon {
            background: #28a745;
            color: white;
        }
        .modal-content {
            border-radius: 16px;
            overflow: hidden;
        }
        .modal-header {
            border-bottom: none;
            padding: 20px 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .modal-body {
            padding: 25px;
            max-height: 70vh;
            overflow-y: auto;
        }
        .modal-footer {
            border-top: 1px solid #e9ecef;
            padding: 20px 25px;
        }
        .btn {
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 500;
        }
        .btn-primary {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border: none;
        }
        .btn-primary:hover:not(:disabled) {
            transform: translateY(-1px);
            box-shadow: 0 8px 15px rgba(40,167,69,0.3);
        }
        .btn-primary:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }
        .btn-secondary {
            background: #6c757d;
            border: none;
        }
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-1px);
        }
        .alert {
            border-radius: 12px;
        }
        .card {
            border-radius: 12px;
        }
        .agency-selection-container {
            max-height: 300px;
            overflow-y: auto;
            padding: 5px;
        }
        .agency-selection-container::-webkit-scrollbar {
            width: 5px;
        }
        .agency-selection-container::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
        .agency-selection-container::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 10px;
        }
        .agency-selection-container::-webkit-scrollbar-thumb:hover {
            background: #555;
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        .selected .agency-icon {
            animation: pulse 0.5s ease;
        }
    `;
    document.head.appendChild(style);
    
    // Remove existing modal if present
    $('#specialPublicationAgencyModal').remove();
    
    // Append modal to body
    $('body').append(modalHTML);
    
    // Show the modal
    $('#specialPublicationAgencyModal').modal('show');
    
    // Handle agency card selection
    $('.agency-card').click(function(e) {
        // Don't trigger if clicking directly on radio button
        if ($(e.target).is('.form-check-input')) {
            return;
        }
        
        // Find and check the radio button
        var radio = $(this).find('.agency-radio');
        radio.prop('checked', true);
        
        // Update selected state
        $('.agency-card').removeClass('selected');
        $(this).addClass('selected');
        
        // Enable confirm button
        $('#confirmSpecialPublicationBtn').prop('disabled', false);
    });
    
    // Handle radio button change
    $('.agency-radio').change(function() {
        $('.agency-card').removeClass('selected');
        $(this).closest('.agency-card').addClass('selected');
        $('#confirmSpecialPublicationBtn').prop('disabled', false);
    });
    
    // Handle confirm button click
    $('#confirmSpecialPublicationBtn').off('click').on('click', function() {
        var selectedEmail = $('input[name="agencySelection"]:checked').val();
        var selectedAgency = $('input[name="agencySelection"]:checked').closest('.agency-card').find('.agency-name').text();
        
        if (!selectedEmail) {
            Swal.fire({
                icon: 'warning',
                title: 'No Selection',
                text: 'Please select a publication agency',
                confirmButtonColor: '#d33'
            });
            return;
        }
        
        // Close the modal
        $('#specialPublicationAgencyModal').modal('hide');
        
        // Proceed with the selected agency
        processSpecialPublication(selectedEmail, selectedAgency);
    });
});

function processSpecialPublication(send_to_address, agencyName) {
    let publication_list = window.getSpecialPublicationContent ? window.getSpecialPublicationContent() : $("#lc_search_report_summary_details_pp").val().trim();
    let specialPublicationList = getSpecialPublicationListPayload();
    let caseNumber = $('#sp_case_number').val();
    
    if (!publication_list) {
        Swal.fire({
            icon: 'warning',
            title: 'No Publication Data',
            text: 'Publication details are missing.',
            confirmButtonColor: '#d33'
        });
        return;
    }
    
    // Show processing modal with enhanced styling
    Swal.fire({
        title: 'Processing Special Publication',
        html: `
            <div style="text-align: center; padding: 20px;">
                <!-- Animated Icon -->
                <div class="mb-4">
                    <div class="spinner-grow text-primary" role="status" style="width: 4rem; height: 4rem;">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
                
                <!-- Status Card -->
                <div class="card border-0 bg-light mb-4">
                    <div class="card-body">
                        <h5 class="card-title mb-3">
                            <i class="fas fa-paper-plane text-primary me-2"></i>
                            Sending to: <span class="text-primary">${agencyName}</span>
                        </h5>
                        
                        <div class="publication-details text-start mt-3">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Case Number:</span>
                                <span class="fw-bold">${caseNumber}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Agency Email:</span>
                                <span class="fw-bold">${send_to_address}</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Progress Bar -->
                <div class="progress mb-3" style="height: 8px;">
                    <div class="progress-bar progress-bar-striped progress-bar-animated bg-success" 
                         role="progressbar" style="width: 100%"></div>
                </div>
                
                <p class="text-muted mt-3">
                    <i class="fas fa-clock me-2"></i>
                    Please wait while we generate and send the document...
                </p>
            </div>
        `,
        allowOutsideClick: false,
        showConfirmButton: false,
        showCancelButton: false
    });
    
    $.ajax({
        type: "POST",
        url: "Case_Management_Serv",
        data: {
            request_type: 'select_set_cases_published',
            publication_list: specialPublicationList,
            to_email_address: send_to_address
        },
        cache: false,
        timeout: 30000,
        success: function() {
            $.ajax({
                type: "POST",
                url: "GenerateCaseReports",
                target: '_blank',
                data: {
                    request_type: 'request_to_generate_special_publication_on_case',
                    publication_list: publication_list,
                    case_number: caseNumber,
                    to_email_address: send_to_address
                },
                cache: false,
                xhrFields: {
                    responseType: 'blob'
                },
                success: function(data) {
                    Swal.close();
                    
                    // Create blob and object URL
                    var blob = new Blob([data], { type: "application/pdf" });
                    var objectUrl = URL.createObjectURL(blob);
                    
                    // Show success modal with enhanced options
                    Swal.fire({
                title: 'Document Generated Successfully!',
                html: `
                    <div style="text-align: center;">
                        <!-- Success Animation -->
                        <div class="mb-4">
                            <i class="fas fa-check-circle text-success" style="font-size: 80px;"></i>
                        </div>
                        
                        <!-- Success Message Card -->
                        <div class="card border-0 bg-light mb-4">
                            <div class="card-body">
                                <h5 class="text-success mb-3">Publication Sent!</h5>
                                <p class="mb-3">The special publication has been sent to <strong>${agencyName}</strong></p>
                                
                                <div class="alert alert-success d-flex align-items-center text-start">
                                    <i class="fas fa-info-circle me-3"></i>
                                    <div>
                                        <strong>Case: ${caseNumber}</strong><br>
                                        <small>Agency: ${send_to_address}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="d-flex justify-content-center gap-3 mb-4">
                            <a href="${objectUrl}" target="_blank" class="btn btn-primary">
                                <i class="fas fa-eye me-2"></i>Preview
                            </a>
                            <a href="${objectUrl}" download="special_publication_${caseNumber}.pdf" class="btn btn-success">
                                <i class="fas fa-download me-2"></i>Download
                            </a>
                            <button onclick="window.open('${objectUrl}', '_blank').print()" class="btn btn-info">
                                <i class="fas fa-print me-2"></i>Print
                            </button>
                        </div>
                        
                        <!-- Additional Info -->
                        <div class="text-muted small">
                            <i class="fas fa-clock me-1"></i>
                            Document will open in a new tab automatically
                        </div>
                    </div>
                `,
                showConfirmButton: true,
                confirmButtonText: '<i class="fas fa-check me-2"></i>Done',
                confirmButtonColor: '#28a745',
                showCancelButton: true,
                cancelButtonText: '<i class="fas fa-redo me-2"></i>Send Another',
                cancelButtonColor: '#007bff',
                reverseButtons: true,
                didOpen: () => {
                    // Open PDF in new tab automatically
                   // window.open(objectUrl, '_blank');
                }
                    }).then((result) => {
                        if (result.dismiss === Swal.DismissReason.cancel) {
                            // Reset form for another publication
                            $("#sp_ar_name").val('');
                            $("#sp_grantor_name").val('');
                            $("#sp_case_number").val('');
                            $("#sp_locality").val('');
                            $("#sp_job_number").val('');
                            $("#sp_type_of_interest").val('');
                            $("#sp_extent").val('');
                            $("#sp_registry_mapref").val('');
                            
                            // Show the modal again
                            $("#btnSaveSP").click();
                        }
                    });
                },
                error: function(xhr, status, error) {
                    Swal.close();
                    
                    // Parse error response if available
                    let errorMessage = 'Unknown error occurred';
                    let errorDetails = '';
                    
                    if (xhr.responseJSON) {
                        errorMessage = xhr.responseJSON.message || errorMessage;
                        errorDetails = xhr.responseJSON.details || '';
                    } else if (xhr.responseText) {
                        try {
                            var response = JSON.parse(xhr.responseText);
                            errorMessage = response.message || errorMessage;
                            errorDetails = response.details || '';
                        } catch(e) {
                            errorMessage = xhr.responseText.substring(0, 100) + '...';
                        }
                    }
                    
                    Swal.fire({
                        title: 'Error Generating Document',
                        html: `
                            <div style="text-align: center;">
                                <i class="fas fa-exclamation-circle text-danger" style="font-size: 64px; margin-bottom: 20px;"></i>
                                
                                <div class="card border-0 bg-light mb-4">
                                    <div class="card-body">
                                        <h5 class="text-danger mb-3">Failed to Generate Document</h5>
                                        <p class="text-danger mb-3">${errorMessage}</p>
                                        
                                        <div class="alert alert-danger text-start">
                                            <strong>Error Details:</strong><br>
                                            <small>${errorDetails || 'No additional details available'}</small><br>
                                            <small class="mt-2 d-block">Status: ${status} (${xhr.status})</small>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="d-flex justify-content-center gap-3">
                                    <button class="btn btn-primary" onclick="$('#btnSaveSP').click()">
                                        <i class="fas fa-redo me-2"></i>Try Again
                                    </button>
                                    <button class="btn btn-secondary" onclick="Swal.close()">
                                        <i class="fas fa-times me-2"></i>Close
                                    </button>
                                </div>
                            </div>
                        `,
                        showConfirmButton: false,
                        showCancelButton: false,
                        allowOutsideClick: false
                    });
                }
            });
        },
        error: function(xhr, status, error) {
            Swal.close();
            Swal.fire({
                title: 'Error Processing Publication',
                html: `
                    <div style="text-align: center;">
                        <i class="fas fa-exclamation-circle text-danger" style="font-size: 64px; margin-bottom: 20px;"></i>
                        
                        <div class="card border-0 bg-light mb-4">
                            <div class="card-body">
                                <h5 class="text-danger mb-3">Failed to Mark Case for Publication</h5>
                                <p class="text-danger mb-3">${error || 'Unable to process special publication.'}</p>
                                
                                <div class="alert alert-danger text-start">
                                    <small class="mt-2 d-block">Status: ${status} (${xhr.status})</small>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-center gap-3">
                            <button class="btn btn-primary" onclick="$('#btnSaveSP').click()">
                                <i class="fas fa-redo me-2"></i>Try Again
                            </button>
                            <button class="btn btn-secondary" onclick="Swal.close()">
                                <i class="fas fa-times me-2"></i>Close
                            </button>
                        </div>
                    </div>
                `,
                showConfirmButton: false,
                showCancelButton: false,
                allowOutsideClick: false
            });
        }
    });
}
    
    // $("#btnSendPublicationList").click(function(event) {
    //     var confirmText = "<br><br><h5> Pls select the publication agency to sent list to</h5>  <br> <span style='color:red'>Note that this cannot be undone!</span> <br><br>";

    //     Swal.fire({
    //         title: "Sending applications for Publication!",
    //         html: confirmText,
    //         icon: 'warning',
    //         input: 'select',
    //         inputOptions: {
    //             '': 'Choose agency...',
    //             'judeyamoah@gmail.com': 'Daily Graphic',
    //             'judeyamoah@gmail.com': 'The Spectator',
    //             'judeyamoah@gmail.com': 'The Ghanaian Times'
    //         },
    //         inputPlaceholder: 'Select agency',
    //         inputValidator: (value) => {
    //             if (!value) {
    //                 return 'You need to select an agency!';
    //             }
    //         },
    //         showCancelButton: true,
    //         confirmButtonColor: '#3085d6',
    //         cancelButtonColor: '#d33',
    //         confirmButtonText: '<i class="fa fa-check"></i> Send',
    //         cancelButtonText: '<i class="fa fa-times"></i> Cancel',
    //         allowOutsideClick: false
    //     }).then((result) => {
    //         if (result.isConfirmed && result.value) {
    //             try {
    //                 var send_to_address = result.value;
    //                 var publication_list = storeTblValues();
    //                 publication_list = JSON.stringify(publication_list);

    //                 function storeTblValues() {
    //                     var TableData = new Array();
    //                     $('#unpublishedDataTable tr').each(function(row, tr) {
    //                         TableData[row] = {
    //                             "client_number": $(tr).find('td:eq(1)').text().trim(),
    //                             "case_number": $(tr).find('td:eq(3)').text().trim(),
    //                             "business_process_sub_name": $(tr).find('td:eq(4)').text().trim(),
    //                             "glpin": $(tr).find('td:eq(5)').text().trim(),
    //                             "ar_name": $(tr).find('td:eq(6)').text().trim(),
    //                             "location": $(tr).find('td:eq(7)').text().trim(),
    //                             "grantor": $(tr).find('td:eq(8)').text().trim(),
    //                             "extent": $(tr).find('td:eq(9)').text().trim(),
    //                             "interest": $(tr).find('td:eq(10)').text().trim(),
    //                             "registry_map": $(tr).find('td:eq(11)').text().trim(),
    //                             "description": $(tr).find('td:eq(12)').text().trim()
    //                         }
    //                     });
    //                     TableData.shift();
    //                     return TableData;
    //                 }

    //                 Swal.fire({
    //                     title: 'Processing...',
    //                     text: 'Please wait while we process your request',
    //                     allowOutsideClick: false,
    //                     didOpen: () => {
    //                         Swal.showLoading();
    //                     }
    //                 });

    //                 $.ajax({
    //                     type: "POST",
    //                     url: "Case_Management_Serv",
    //                     data: {
    //                         request_type: 'select_set_cases_published',
    //                         publication_list: publication_list,
    //                         to_email_address: send_to_address
    //                     },
    //                     cache: false,
    //                     success: function(jobdetails) {
    //                         Swal.close();
    //                         $("#general_message_dialog").modal();
    //                         $('#general_message_dialog #general_message_dialog_msg_new').val("All Applications sent for Publication, Awaiting Date of Publication");

    //                         var json_p = JSON.parse(publication_list);
                            
    //                         // Replace _.groupBy with native JavaScript
    //                         var groupedByLocation = json_p.reduce(function(acc, current) {
    //                             var location = current.location;
    //                             if (!acc[location]) {
    //                                 acc[location] = [];
    //                             }
    //                             acc[location].push(current);
    //                             return acc;
    //                         }, {});
                            
    //                         const ordered = {};
    //                         Object.keys(groupedByLocation).sort().forEach(function(key) {
    //                             ordered[key] = groupedByLocation[key];
    //                         });

    //                         $.ajax({
    //                             type: "POST",
    //                             url: "GenerateCaseReports",
    //                             target: '_blank',
    //                             data: {
    //                                 request_type: 'request_to_generate_publication_list',
    //                                 publication_list: JSON.stringify(ordered),
    //                                 to_email_address: send_to_address
    //                             },
    //                             cache: false,
    //                             xhrFields: {
    //                                 responseType: 'blob'
    //                             },
    //                             success: function(data) {
    //                                 $('#pdfModal').modal({
    //                                     backdrop: 'static',
    //                                 });
                                    
    //                                 var blob = new Blob([data], { type: "application/pdf" });
    //                                 var objectUrl = URL.createObjectURL(blob);
    //                                 $('#pdfPreviewFrame').attr('src', objectUrl);
                                    
    //                                 Swal.fire({
    //                                     icon: 'success',
    //                                     title: 'Success!',
    //                                     text: 'Publication list sent successfully',
    //                                     timer: 2000,
    //                                     showConfirmButton: false
    //                                 });
    //                             },
    //                             error: function() {
    //                                 Swal.fire({
    //                                     icon: 'error',
    //                                     title: 'Error',
    //                                     text: 'Failed to generate PDF',
    //                                     confirmButtonColor: '#d33'
    //                                 });
    //                             }
    //                         });
    //                     },
    //                     error: function() {
    //                         Swal.close();
    //                         Swal.fire({
    //                             icon: 'error',
    //                             title: 'Error',
    //                             text: 'Failed to process request',
    //                             confirmButtonColor: '#d33'
    //                         });
    //                     }
    //                 });
    //             } catch (e) {
    //                 Swal.fire({
    //                     icon: 'error',
    //                     title: 'Error',
    //                     text: 'An error occurred',
    //                     confirmButtonColor: '#d33'
    //                 });
    //             }
    //         }
    //     });
    // });

	$("#btnSendPublicationList").click(function(event) {
    // First, check if there are applications to send
    var applicationCount = $('#unpublishedDataTable tbody tr').length;
    
    if (applicationCount === 0) {
        Swal.fire({
            icon: 'warning',
            title: 'No Applications',
            text: 'There are no applications to send for publication.',
            confirmButtonColor: '#d33'
        });
        return;
    }
    
    // Get the list of agencies (you can populate this from a database or keep static)
    var agencies = [
        { email: '', name: 'Email', icon: '@' },
        // { email: '', name: 'The Spectator', icon: '📰' },
        // { email: '', name: 'Ghanaian Times', icon: '📰' },
    ];
    
    // Build agency options for the modal
    var agencyOptions = '';
    agencies.forEach(function(agency) {
        agencyOptions += `
            <div class="agency-option" data-email="${agency.email}" data-name="${agency.name}">
                <div class="form-check">
                    <input class="form-check-input agency-radio" type="radio" name="agencySelection" 
                           id="agency_${agency.email.replace(/[@.]/g, '_')}" value="${agency.name}">
                    <label class="form-check-label" for="agency_${agency.email.replace(/[@.]/g, '_')}">
                       <!-- <span class="agency-icon">${agency.icon}</span> -->
                        <span class="agency-name">${agency.name}</span>
                        <small class="agency-email text-muted">${agency.email}</small>
                    </label>
                </div>
            </div>
        `;
    });
    
    // Create the modal HTML
    var modalHTML = `
        <div class="modal fade modal-blur" id="publicationAgencyModal" tabindex="-1" aria-labelledby="publicationAgencyModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content border-0">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title text-white" id="publicationAgencyModalLabel">
                            <i class="fas fa-paper-plane me-2"></i>Send Publication List
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    
                    <div class="modal-body">
                        <!-- Summary Cards -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="card bg-light border-0">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0">
                                                <i class="fas fa-file-alt fa-2x text-primary"></i>
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h6 class="mb-0">Total Applications</h6>
                                                <h3 class="mb-0">${applicationCount}</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card bg-light border-0">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0">
                                                <i class="fas fa-map-marker-alt fa-2x text-success"></i>
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h6 class="mb-0">Unique Locations</h6>
                                                <h3 class="mb-0">
                                                    ${new Set($('#unpublishedDataTable tbody tr').map(function() { 
                                                        return $(this).find('td:eq(7)').text().trim(); 
                                                    }).get()).size}
                                                </h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Info Alert -->
                        <div class="alert alert-info d-flex align-items-center mb-4">
                            <i class="fas fa-info-circle fa-2x me-3"></i>
                            <div>
                                <strong>Select Publication Agency</strong><br>
                                Choose where to send the publication list. This action cannot be undone.
                            </div>
                        </div>
                        
                        <!-- Agency Selection -->
                        <div class="agency-selection-container mb-4">
                            <!--<label class="form-label fw-bold mb-3">
                                <i class="fas fa-building me-2"></i>Available Agencies
                            </label>-->
                            <div class="row g-3">
                                ${agencyOptions}
                            </div>
                        </div>
                        
                        <!-- Warning Alert -->
                        <div class="alert alert-warning d-flex align-items-center">
                            <i class="fas fa-exclamation-triangle fa-2x me-3"></i>
                            <div>
                                <strong>Important Note</strong><br>
                                Once sent, the applications will be moved to awaiting publication date and cannot be modified.
                            </div>
                        </div>
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Cancel
                        </button>
                        <button type="button" class="btn btn-primary" id="confirmSendPublicationBtn" disabled>
                            <i class="fas fa-send me-2"></i>Send Publication List
                        </button>
                    </div>
                </div>
            </div>
        </div>
    `;
    
    // Remove existing modal if present
    $('#publicationAgencyModal').remove();
    
    // Append modal to body
    $('body').append(modalHTML);
    
    // Add custom styles for the modal
    const style = document.createElement('style');
    style.innerHTML = `
        .agency-option {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 15px;
            transition: all 0.3s ease;
            cursor: pointer;
            background: white;
        }
        .agency-option:hover {
            border-color:rgb(7, 96, 5);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,123,255,0.1);
        }
        .agency-option.selected {
            border-color: #28a745;
            background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
        }
        .agency-option .form-check {
            margin: 0;
        }
        .agency-option .form-check-input {
            cursor: pointer;
        }
        .agency-option .form-check-input:checked {
            background-color: #28a745;
            border-color: #28a745;
        }
        .agency-option .form-check-label {
            display: flex;
            align-items: center;
            gap: 12px;
            cursor: pointer;
            width: 100%;
            margin-left: 10px;
        }
        .agency-icon {
            font-size: 24px;
            min-width: 40px;
            text-align: center;
        }
        .agency-name {
            font-weight: 600;
            color: #2c3e50;
            flex: 1;
        }
        .agency-email {
            font-size: 12px;
            color: #6c757d;
            margin-left: 5px;
        }
        .modal-content {
            border-radius: 16px;
            overflow: hidden;
        }
        .modal-header {
            border-bottom: none;
            padding: 20px 25px;
        }
        .modal-body {
            padding: 25px;
        }
        .modal-footer {
            border-top: 1px solid #e9ecef;
            padding: 20px 25px;
        }
        .btn {
            padding: 10px 25px;
            border-radius: 8px;
        }
        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border: none;
        }
        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(0,123,255,0.3);
        }
        .btn-secondary {
            background: #6c757d;
            border: none;
        }
        .btn-secondary:hover {
            background: #5a6268;
        }
        .alert {
            border-radius: 12px;
        }
    `;
    document.head.appendChild(style);
    
    // Show the modal
    $('#publicationAgencyModal').modal('show');
    
    // Handle agency selection
    $('.agency-option').click(function(e) {
        // Don't trigger if clicking directly on radio button
        if ($(e.target).is('.form-check-input')) {
            return;
        }
        
        // Find and check the radio button
        var radio = $(this).find('.agency-radio');
        radio.prop('checked', true);
        
        // Update selected state
        $('.agency-option').removeClass('selected');
        $(this).addClass('selected');
        
        // Enable confirm button
        $('#confirmSendPublicationBtn').prop('disabled', false);
    });
    
    // Handle radio button change
    $('.agency-radio').change(function() {
        $('.agency-option').removeClass('selected');
        $(this).closest('.agency-option').addClass('selected');
        $('#confirmSendPublicationBtn').prop('disabled', false);
    });
    
    // Handle confirm button click
    $('#confirmSendPublicationBtn').off('click').on('click', function() {
        var selectedEmail = $('input[name="agencySelection"]:checked').val();
        var selectedAgency = $('input[name="agencySelection"]:checked').closest('.agency-option').find('.agency-name').text();
        
        if (!selectedEmail) {
            Swal.fire({
                icon: 'warning',
                title: 'No Selection',
                text: 'Please select a publication agency',
                confirmButtonColor: '#d33'
            });
            return;
        }
        
        // Close the modal
        $('#publicationAgencyModal').modal('hide');
        
        // Proceed with the selected agency
        proceedWithPublication(selectedEmail, selectedAgency);
    });
});

function proceedWithPublication(send_to_address, agencyName) {
    try {
        var publication_list = storeTblValues();
        publication_list = JSON.stringify(publication_list);

        function storeTblValues() {
            var TableData = new Array();
            $('#unpublishedDataTable tbody tr').each(function(row, tr) {
                var extentText = $(tr).find('td:eq(9)').text().trim();
                var extentValue = parseExtentValue(extentText);

                if (extentValue >= 5) {
                    return;
                }

                TableData.push({
                    "client_number": $(tr).find('td:eq(1)').text().trim(),
                    "case_number": $(tr).find('td:eq(3)').text().trim(),
                    "business_process_sub_name": $(tr).find('td:eq(4)').text().trim(),
                    "glpin": $(tr).find('td:eq(5)').text().trim(),
                    "ar_name": $(tr).find('td:eq(6)').text().trim(),
                    "location": $(tr).find('td:eq(7)').text().trim(),
                    "grantor": $(tr).find('td:eq(8)').text().trim(),
                    "extent": extentText,
                    "interest": $(tr).find('td:eq(10)').text().trim(),
                    "registry_map": $(tr).find('td:eq(11)').text().trim(),
                    "description": $(tr).find('td:eq(12)').text().trim()
                });
            });
            return TableData;
        }

        // Show processing modal
        Swal.fire({
            title: 'Processing Publication List',
            html: `
                <div style="text-align: center; padding: 20px;">
                    <div class="mb-4">
                        <div class="spinner-border text-primary" role="status" style="width: 4rem; height: 4rem;">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                    <h5>Sending to: <span class="text-primary">${agencyName}</span></h5>
                    <p class="text-muted mt-3">Please wait while we process your request...</p>
                    <div class="progress mt-3" style="height: 8px;">
                        <div class="progress-bar progress-bar-striped progress-bar-animated bg-success" 
                             role="progressbar" style="width: 100%"></div>
                    </div>
                </div>
            `,
            allowOutsideClick: false,
            showConfirmButton: false,
            showCancelButton: false
        });

        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'select_set_cases_published',
                publication_list: publication_list,
                to_email_address: send_to_address
            },
            cache: false,
            timeout: 30000,
            success: function(jobdetails) {
                $("#general_message_dialog").modal();
                $('#general_message_dialog #general_message_dialog_msg_new').val("All Applications sent for Publication, Awaiting Date of Publication");

                var json_p = JSON.parse(publication_list);
                
                // Group by location
                var groupedByLocation = json_p.reduce(function(acc, current) {
                    if (!current || !current.location) {
                        return acc;
                    }
                    var location = current.location;
                    if (!acc[location]) {
                        acc[location] = [];
                    }
                    acc[location].push(current);
                    return acc;
                }, {});
                
                const ordered = {};
                Object.keys(groupedByLocation).sort().forEach(function(key) {
                    ordered[key] = groupedByLocation[key];
                });

                // Update progress text
                Swal.update({
                    html: `
                        <div style="text-align: center; padding: 20px;">
                            <div class="mb-4">
                                <div class="spinner-border text-primary" role="status" style="width: 4rem; height: 4rem;">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>
                            <h5>Generating PDF document...</h5>
                            <p class="text-muted mt-3">Preparing publication list for ${agencyName}</p>
                        </div>
                    `
                });

                $.ajax({
                    type: "POST",
                    url: "GenerateCaseReports",
                    target: '_blank',
                    data: {
                        request_type: 'request_to_generate_publication_list',
                        publication_list: JSON.stringify(ordered),
                        to_email_address: send_to_address
                    },
                    cache: false,
                    xhrFields: {
                        responseType: 'blob'
                    },
                    success: function(data) {
                        Swal.close();
                        
                        var blob = new Blob([data], { type: "application/pdf" });
                        var objectUrl = URL.createObjectURL(blob);
                        
                        // Show success modal with options
                        Swal.fire({
                            title: 'Success!',
                            html: `
                                <div style="text-align: center;">
                                    <i class="fas fa-check-circle text-success" style="font-size: 64px; margin-bottom: 20px;"></i>
                                    <h4 class="text-success mb-3">Publication List Sent!</h4>
                                    <p class="mb-4">All applications have been sent to <strong>${agencyName}</strong> successfully.</p>
                                    <div class="d-flex justify-content-center gap-3">
                                        <a href="${objectUrl}" target="_blank" class="btn btn-primary">
                                            <i class="fas fa-eye me-2"></i>Preview List
                                        </a>
                                        <a href="${objectUrl}" download="publication_list.pdf" class="btn btn-success">
                                            <i class="fas fa-download me-2"></i>Download PDF
                                        </a>
                                    </div>
                                    <p class="text-muted mt-3">
                                        <i class="fas fa-clock me-2"></i>
                                        Awaiting publication date confirmation from agency.
                                    </p>
                                </div>
                            `,
                            showConfirmButton: true,
                            confirmButtonText: 'Done',
                            confirmButtonColor: '#28a745',
                            showCancelButton: true,
                            cancelButtonText: '<i class="fas fa-print me-2"></i>Print',
                            cancelButtonColor: '#007bff',
                            reverseButtons: true
                        }).then((finalResult) => {
                            if (finalResult.dismiss === Swal.DismissReason.cancel) {
                                window.open(objectUrl, '_blank').print();
                            }
                        });
                    },
                    error: function(xhr, status, error) {
                        Swal.close();
                        Swal.fire({
                            icon: 'error',
                            title: 'PDF Generation Failed',
                            html: `
                                <div style="text-align: center;">
                                    <i class="fas fa-exclamation-circle text-danger" style="font-size: 64px; margin-bottom: 20px;"></i>
                                    <p>The applications have been sent, but PDF generation failed.</p>
                                    <p class="text-danger">Error: ${error || 'Unknown error'}</p>
                                </div>
                            `,
                            confirmButtonText: 'Close',
                            confirmButtonColor: '#dc3545'
                        });
                    }
                });
            },
            error: function(xhr, status, error) {
                Swal.close();
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    html: `
                        <div style="text-align: center;">
                            <i class="fas fa-exclamation-triangle text-danger" style="font-size: 64px; margin-bottom: 20px;"></i>
                            <p>Failed to process your request.</p>
                            <p class="text-danger">${error || 'Please try again'}</p>
                        </div>
                    `,
                    confirmButtonText: 'Close',
                    confirmButtonColor: '#dc3545',
                    showCancelButton: true,
                    cancelButtonText: 'Retry',
                    cancelButtonColor: '#007bff'
                }).then((retryResult) => {
                    if (retryResult.dismiss === Swal.DismissReason.cancel) {
                        $("#btnSendPublicationList").click();
                    }
                });
            }
        });
    } catch (e) {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'An error occurred: ' + e.message,
            confirmButtonColor: '#d33'
        });
    }
}
    
    $("#btnPublishedListDateUpdate").click(function(event) {
        var confirmText = "Are you sure you set publication date for all selected applications?";
        
        Swal.fire({
            title: 'Confirm Date Update',
            text: confirmText,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, update it!',
            cancelButtonText: 'Cancel'
        }).then((result) => {
            if (result.isConfirmed) {
                var published_date = $("#date_sent_for_publication").val();
                
                if (published_date) {
                    var publication_list1 = storeTblValues();
                    publication_list1 = JSON.stringify(publication_list1);

                    function storeTblValues() {
                        var TableData = new Array();
                        $('#publishedDataTable tbody tr.selected').each(function(row, tr) {
                            TableData[row] = {
                                "case_number": $(tr).find('td:eq(3)').text().trim(),
                                "job_number": $(tr).find('td:eq(1)').text().trim(),
                                "ar_name": $(tr).find('td:eq(5)').text().trim(),
                                "client_number": $(tr).find('td:eq(0)').text().trim(),
                                "business_process_sub_name": $(tr).find('td:eq(4)').text().trim()
                            }
                        });
                        return TableData;
                    }

                    Swal.fire({
                        title: 'Updating...',
                        text: 'Please wait',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });

                    $.ajax({
                        type: "POST",
                        url: "Case_Management_Serv",
                        data: {
                            request_type: 'select_udate_published_date_on_case',
                            publication_list1: publication_list1,
                            published_date: published_date
                        },
                        cache: false,
                        success: function(jobdetails) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Updated!',
                                text: 'Publication dates have been updated',
                                confirmButtonColor: '#3085d6'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    location.reload(true);
                                }
                            });
                        },
                        error: function() {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Failed to update publication dates',
                                confirmButtonColor: '#d33'
                            });
                        }
                    });
                } else {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Date Required',
                        text: 'Publication date field is required',
                        confirmButtonColor: '#d33'
                    });
                }
            }
        });
        return false;
    });
    
    $("#publishedButNotWorkedOnModal").on("show.bs.modal", function(e) {
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'select_load_published_but_not_worked_on',
            },
            cache: false,
            success: function(response) {
                if (response == '{"success" : true, "data" : null}') {
                    return;
                } else {
                    try {
                        var json_p = JSON.parse(response);
                        var table = $('#jobs_publishedButNotWorkedOnTable');
                        table.find("tbody tr").remove();
                        
                        $(json_p.data).each(function() {
                            table.append("<tr><td>" + this.job_number + "</td><td>" + this.ar_name + "</td><td>" + this.business_process_name + "</td><td>" + this.publicity_date + "</td>"
                                + ' <td> '
                                + ' <button ' 
                                + ' class="btn btn-info btn-icon-split" ' 
                                + ' data-title="Add to Batch List" ' 
                                + ' data-job_number="' + this.job_number + '" '
                                + ' data-ar_name="' + this.ar_name + '"  '
                                + ' data-business_process_sub_name="' + this.business_process_sub_name + '" '
                                + ' data-target="#askForPurposeOfBatching" data-toggle="modal" >'
                                + ' <span class="icon text-white-50"> <i class="fas fa-list"></i></span>'
                                + ' <span class="text">Add to Batch</span>'
                                + ' </button>'
                                + "</tr>");
                        });
                    } catch (e) {
                        console.log(e);
                    }
                }
            },
            error: function() {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Failed to load data',
                    confirmButtonColor: '#d33'
                });
            }
        });
    });

    $('#edit_application_for_publication').on('shown.bs.modal', function(e) {
        e.preventDefault();
        
        //var job_number = $("#job_search_value").val().toUpperCase();
        var job_number = $(e.relatedTarget).data('job_number') == undefined ? $("#job_search_value").val().toUpperCase() : $(e.relatedTarget).data('job_number');
        //console.log(job_number)

        if (!(job_number.length >= 10)) {
            Swal.fire({
                icon: 'error',
                title: 'Invalid Job Number',
                text: 'Please enter a valid Job Number (minimum 10 characters)',
                confirmButtonColor: '#d33'
            });
            $('#edit_application_for_publication').modal('hide');
            return;
        }

        Swal.fire({
            title: 'Loading...',
            text: 'Please wait while we load application details',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            }
        });

        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'load_application_details_by_job_number',
                job_number: job_number
            },
            cache: false,
            success: function(jobdetails) {
                Swal.close();
                
                var result = JSON.parse(jobdetails);

                if (result.job_detail !== null) {
                    $("job_number_placeholder").append(result.job_detail.job_number);
                    
                    $("#fe_client_name").val(result.transaction_details.ar_name);
                    $("#febusiness_process_sub_name").val(result.job_detail.business_process_sub_name);
                    $("#fe_job_number").val(result.job_detail.job_number);
                    $("#fe_nature_of_instrument").val(result.transaction_details.nature_of_instrument);
                    $("#fe_type_of_interest").val(result.transaction_details.type_of_interest);
                    $("#fe_type_of_use").val(result.transaction_details.type_of_use);
                    $("#fe_consideration_fee").val(result.transaction_details.consideration_fee);
                    $("#fe_date_of_document").val(result.transaction_details.date_of_document);
                    $("#fe_commencement_date").val(result.transaction_details.commencement_date);
                    $("#fe_transaction_number").val(result.transaction_details.transaction_number);
                    $("#fe_term").val(result.transaction_details.term);
                    $("#fe_renewal_term").val(result.transaction_details.renewal_term);
                    $("#fe_family_name").val(result.transaction_details.stool_family_name);
                    $("#fe_grantor_family").val(result.transaction_details.family_of_grantor);
                    $("#fe_annual_rent").val(result.transaction_details.annual_rent);
                    $("#fe_file_number").val(result.transaction_details.case_file_number);
                    $("#fe_surveyor_number").val(result.parcel_details.licensed_no);
                    $("#fe_regional_number").val(result.parcel_details.regional_number);
                    $("#fe_land_size").val(result.parcel_details.land_size);
                    $("#fe_case_number").val(result.transaction_details.case_number);
                    $("#fe_locality").val(result.parcel_details.locality);
                    $("#fe_district").val(result.parcel_details.district);
                    $("#fe_region").val(result.parcel_details.region);
                    $("#fe_extent").val(result.parcel_details.extent);
                    $("#fe_registry_mapref").val(result.parcel_details.registry_mapref);
                    $("#main_service_id_fe").val(result.job_detail.business_process_id);
                    $("#main_service_sub_id_fe").val(result.job_detail.business_process_sub_id);

                    var fe_case_number_new = result.transaction_details.transaction_number;

                    $.ajax({
                        type: "POST",
                        url: "Case_Management_Serv",
                        data: {
                            request_type: 'select_get_parties_by_case',
                            case_number: fe_case_number_new
                        },
                        cache: false,
                        success: function(jobdetails) {
                            if (!jobdetails.includes("Data Not Received")) {
                                var result = JSON.parse(jobdetails);
                                var table = $('#party_details_datatable');
                                table.find("tbody tr").remove();
                                
                                var json_p = JSON.parse(jobdetails);
                                
                                $(json_p).each(function() {
                                    table.append("<tr><td>" + this.ar_name + "</td><td>" + this.ar_gender + "</td><td>" + this.ar_cell_phone + "</td><td>" + this.type_of_party + "</td>"
                                        + '<td>'
                                        + '<button class="btn btn-sm btn-danger addeditpartyGeneralBtn"'
                                        + 'data-target-id="' + this.ar_client_id
                                        + '" data-ar_name="' + this.ar_name
                                        + '" data-ar_gender="' + this.ar_gender
                                        + '" data-ar_address="' + this.ar_address
                                        + '" data-ar_cell_phone="' + this.ar_cell_phone
                                        + '" data-ar_cell_phone2="' + this.ar_cell_phone2
                                        + '" data-ar_tin_no="' + this.ar_tin_no
                                        + '" data-ar_id_type="' + this.ar_id_type
                                        + '" data-ar_id_number="' + this.ar_id_number
                                        + '" data-ar_location="' + this.ar_location
                                        + '" data-ar_district="' + this.ar_district
                                        + '" data-type_of_party="' + this.type_of_party
                                        + '" data-ar_region="' + this.ar_region
                                        + '" data-ar_person_type="' + this.ar_person_type
                                        + '"> '
                                        + '<i class="ri-edit-box-line"></i></button></td>'
                                        + "</tr>");
                                });
                            }
                        }
                    });
                    
                    Swal.fire({
                        icon: 'success',
                        title: 'Loaded!',
                        text: 'Application details loaded successfully',
                        timer: 2000,
                        showConfirmButton: false
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Not Found',
                        text: 'Job number not found',
                        confirmButtonColor: '#d33'
                    });
                }
            },
            error: function() {
                Swal.close();
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Failed to load application details',
                    confirmButtonColor: '#d33'
                });
            }
        });
    });

    $('#frmFurtherEntries_pm').on('submit', function(e) {
        e.preventDefault();

        var registry_mapref = $("#fe_registry_mapref").val();
        var job_number = $("#fe_job_number").val();
        var locality = $("#fe_locality").val();
        var case_number = $("#fe_case_number").val();
        var transaction_number = $("#fe_transaction_number").val();
        var extent = $("#fe_extent").val();
        var type_of_interest = $("#fe_type_of_interest").val();
        var modified_by = localStorage.getItem("fullname");
        var modified_by_id = localStorage.getItem("userid");

        Swal.fire({
            title: 'Saving...',
            text: 'Please wait while we save the changes',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            }
        });

        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'further_entries_update_case_for_publication',
                job_number: job_number,
                locality: locality,
                registry_mapref: registry_mapref,
                case_number: case_number,
                transaction_number: transaction_number,
                extent: extent,
                type_of_interest: type_of_interest,
                modified_by: modified_by,
                modified_by_id: modified_by_id
            },
            cache: false,
            success: function(jobdetails) {
                Swal.close();
                
                var result = JSON.parse(jobdetails);
                if (result.data.includes('Success')) {
                    document.getElementById('frmFindJobForPublication').submit();

                    $("#rs_locality").val(locality);
                    $("#rs_registry_mapref").val(registry_mapref);
                    $("#rs_extent").val(extent);
                    $("#rs_type_of_interest").val(type_of_interest);

                    $('#edit_application_for_publication').modal('hide');

                    Swal.fire({
                        icon: 'success',
                        title: 'Saved!',
                        text: 'Case details saved successfully.',
                        timer: 2000,
                        showConfirmButton: false
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Error. Contact IT for support.',
                        confirmButtonColor: '#d33'
                    });
                }
            },
            error: function() {
                Swal.close();
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Failed to save changes',
                    confirmButtonColor: '#d33'
                });
            }
        });
    });

	 // Function to open PDF modal
    function openPDFModal(file, fileURL) {
        // Create modal HTML
        const modalHTML = `
            <div class="modal fade effect-fade modal-blur" id="pdfViewerModal" tabindex="-1" aria-labelledby="pdfViewerModalLabel" aria-hidden="true" data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered modal-xl">
                    <div class="modal-content">
                        <div class="modal-header d-flex justify-content-between">
                            <h6 class="modal-title" id="pdfViewerModalLabel">
                                <i class="fas fa-file-pdf me-2"></i>
                                ${file.name}
                            </h6>
                            <div>
                                <span class="badge bg-light text-dark ms-2">${formatFileSize(file.size)}</span>
                                <button type="button" class="btn btn-sm btn-outline-light me-2" id="btnDownloadPDF">
                                    <i class="fas fa-download me-1"></i>Download
                                </button>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                        </div>
                        <div class="modal-body p-0" style="min-height: 70vh;">
                            <div id="pdfViewerContainer">
                                <!--<div id="pdfLoading" class="d-flex flex-column align-items-center justify-content-center h-100 p-5">
                                    <div class="spinner-border text-primary mb-3" role="status">
                                        <span class="visually-hidden">Loading PDF...</span>
                                    </div>
                                    <p class="text-muted">Loading PDF document...</p>
                                </div>-->
                                <div id="pdfViewer" style="display: none;">
                                    <div class="pdf-toolbar bg-light p-2 border-bottom">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <button class="btn btn-sm btn-outline-dark me-2" id="btnPrevPage">
                                                    <i class="fas fa-chevron-left"></i>
                                                </button>
                                                <span class="mx-2">
                                                    Page: <span id="currentPage">1</span> / <span id="totalPages">0</span>
                                                </span>
                                                <button class="btn btn-sm btn-outline-dark ms-2" id="btnNextPage">
                                                    <i class="fas fa-chevron-right"></i>
                                                </button>
                                            </div>
                                            <div>
                                                <div class="input-group input-group-sm" style="width: 150px;">
                                                    <span class="input-group-text">Zoom</span>
                                                    <select class="form-select" id="zoomSelect">
                                                        <option value="0.5">50%</option>
                                                        <option value="0.75">75%</option>
                                                        <option value="1" selected>100%</option>
                                                        <option value="1.25">125%</option>
                                                        <option value="1.5">150%</option>
                                                        <option value="2">200%</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="pdf-container p-3">
                                        <canvas id="pdfCanvas" class="mx-auto d-block shadow-sm"></canvas>
                                    </div>
                                </div>
                                <div id="pdfError" class="d-none text-center p-5">
                                    <i class="fas fa-exclamation-triangle fa-3x text-danger mb-3"></i>
                                    <h5>Unable to load PDF</h5>
                                    <p class="text-muted">There was an error loading the PDF document.</p>
                                    <button class="btn btn-primary" onclick="location.reload()">
                                        <i class="fas fa-redo me-2"></i>Try Again
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer d-flex justify-content-between">
                            <div class="text-muted small">
                                <i class="fas fa-info-circle me-1"></i>
                                Use arrow keys to navigate between pages
                            </div>
                            <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                                <i class="fas fa-times me-2"></i>Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        // Add modal to body if not exists
        if (!document.getElementById('pdfViewerModal')) {
            document.body.insertAdjacentHTML('beforeend', modalHTML);
        } else {
            // Remove existing modal
            const existingModal = document.getElementById('pdfViewerModal');
            if (existingModal) {
                existingModal.remove();
            }
            document.body.insertAdjacentHTML('beforeend', modalHTML);
        }
        
        // Get modal instance
        const modal = new bootstrap.Modal(document.getElementById('pdfViewerModal'));
        
        // Show modal
        modal.show();
        
        // Initialize PDF.js when modal is shown
        document.getElementById('pdfViewerModal').addEventListener('shown.bs.modal', function() {
            initializePDFViewer(fileURL);
        });
        
        // Clean up object URL when modal is closed
        document.getElementById('pdfViewerModal').addEventListener('hidden.bs.modal', function() {
            URL.revokeObjectURL(fileURL);
            this.remove();
        });
        
        // Download button handler
        document.getElementById('pdfViewerModal').addEventListener('click', function(e) {
            if (e.target.id === 'btnDownloadPDF' || e.target.closest('#btnDownloadPDF')) {
                downloadPDF(file);
            }
        });
    }

    // Function to initialize PDF.js viewer
    function initializePDFViewer(fileURL) {
        // Check if PDF.js is loaded
        if (typeof pdfjsLib === 'undefined') {
            // Load PDF.js dynamically
            loadPDFJS().then(() => {
                renderPDF(fileURL);
            }).catch(error => {
                console.error('Failed to load PDF.js:', error);
                showPDFError();
            });
        } else {
            renderPDF(fileURL);
        }
    }

    // Function to load PDF.js library dynamically
    function loadPDFJS() {
        return new Promise((resolve, reject) => {
            if (typeof pdfjsLib !== 'undefined') {
                resolve();
                return;
            }
            
            // Create script element
            const script = document.createElement('script');
            script.src = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js';
            script.integrity = 'sha512-9o9W6Vg9Q9W6XjP0lL8y4E5qX1G8M8q2+5Q6J5q5v5z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z';
            script.crossOrigin = 'anonymous';
            script.onload = resolve;
            script.onerror = reject;
            document.head.appendChild(script);
            
            // Also load the worker
            const workerScript = document.createElement('script');
            workerScript.src = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js';
            workerScript.integrity = 'sha512-9o9W6Vg9Q9W6XjP0lL8y4E5qX1G8M8q2+5Q6J5q5v5z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z';
            workerScript.crossOrigin = 'anonymous';
            document.head.appendChild(workerScript);
        });
    }

    // Function to render PDF using PDF.js
    async function renderPDF(fileURL) {
        try {
            const pdfContainer = document.getElementById('pdfViewerContainer');
            //const pdfLoading = document.getElementById('pdfLoading');
            const pdfViewer = document.getElementById('pdfViewer');
            const pdfCanvas = document.getElementById('pdfCanvas');
            const currentPageSpan = document.getElementById('currentPage');
            const totalPagesSpan = document.getElementById('totalPages');
            const zoomSelect = document.getElementById('zoomSelect');
            
            // Set PDF.js worker path
            pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.4.120/pdf.worker.min.js';
            
            // Load the PDF
            const loadingTask = pdfjsLib.getDocument(fileURL);
            const pdf = await loadingTask.promise;
            
            // Get total pages
            const totalPages = pdf.numPages;
            totalPagesSpan.textContent = totalPages;
            
            // Set initial page
            let currentPage = 1;
            let scale = parseFloat(zoomSelect.value);
            
            // Function to render a specific page
            async function renderPage(pageNum) {
                try {
                    //pdfLoading.style.display = 'flex';
                    pdfViewer.style.display = 'none';
                    
                    const page = await pdf.getPage(pageNum);
                    
                    // Get viewport
                    const viewport = page.getViewport({ scale: scale });
                    
                    // Set canvas dimensions
                    const canvas = pdfCanvas;
                    const context = canvas.getContext('2d');
                    canvas.height = viewport.height;
                    canvas.width = viewport.width;
                    
                    // Render PDF page
                    const renderContext = {
                        canvasContext: context,
                        viewport: viewport
                    };
                    
                    await page.render(renderContext).promise;
                    
                    // Update UI
                    currentPageSpan.textContent = currentPage;
                    //pdfLoading.style.display = 'none';
                    pdfViewer.style.display = 'block';
                    
                } catch (error) {
                    console.error('Error rendering page:', error);
                    showPDFError();
                }
            }
            
            // Render first page
            await renderPage(currentPage);
            
            // Navigation handlers
            document.getElementById('btnPrevPage').addEventListener('click', async () => {
                if (currentPage > 1) {
                    currentPage--;
                    await renderPage(currentPage);
                }
            });
            
            document.getElementById('btnNextPage').addEventListener('click', async () => {
                if (currentPage < totalPages) {
                    currentPage++;
                    await renderPage(currentPage);
                }
            });
            
            // Zoom handler
            zoomSelect.addEventListener('change', async () => {
                scale = parseFloat(zoomSelect.value);
                await renderPage(currentPage);
            });
            
            // Keyboard navigation
            document.addEventListener('keydown', async (e) => {
                if (document.getElementById('pdfViewerModal').classList.contains('show')) {
                    switch(e.key) {
                        case 'ArrowLeft':
                            if (currentPage > 1) {
                                currentPage--;
                                await renderPage(currentPage);
                            }
                            break;
                        case 'ArrowRight':
                            if (currentPage < totalPages) {
                                currentPage++;
                                await renderPage(currentPage);
                            }
                            break;
                        case '+':
                        case '=':
                            e.preventDefault();
                            if (scale < 3) {
                                scale += 0.25;
                                zoomSelect.value = scale.toFixed(2);
                                await renderPage(currentPage);
                            }
                            break;
                        case '-':
                            e.preventDefault();
                            if (scale > 0.25) {
                                scale -= 0.25;
                                zoomSelect.value = scale.toFixed(2);
                                await renderPage(currentPage);
                            }
                            break;
                    }
                }
            });
            
        } catch (error) {
            console.error('Error loading PDF:', error);
            showPDFError();
        }
    }

    // Function to download PDF
    function downloadPDF(file) {
        const downloadURL = URL.createObjectURL(file);
        const a = document.createElement('a');
        a.href = downloadURL;
        a.download = file.name;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(downloadURL);
        
        // Show success message
        Swal.fire({
            title: 'Download Started',
            text: `Downloading ${file.name}`,
            icon: 'success',
            timer: 2000,
            showConfirmButton: false
        });
    }

    // Helper function to format file size
    function formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    // Helper function to show loading indicator
    function showLoadingIndicator() {
        // You can customize this based on your UI
        Swal.fire({
            title: 'Generating PDF',
            text: 'Please wait while we generate the register document...',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            }
        });
    }

    // Helper function to hide loading indicator
    function hideLoadingIndicator() {
        Swal.close();
    }

    // Helper function to show PDF error
    function showPDFError() {
        //const pdfLoading = document.getElementById('pdfLoading');
        const pdfViewer = document.getElementById('pdfViewer');
        const pdfError = document.getElementById('pdfError');
        
        //if (pdfLoading) pdfLoading.style.display = 'none';
        if (pdfViewer) pdfViewer.style.display = 'none';
        if (pdfError) {
            pdfError.classList.remove('d-none');
            pdfError.classList.add('d-flex', 'flex-column', 'align-items-center', 'justify-content-center');
        }
    }

    // Add CSS for PDF viewer
    const pdfViewerCSS = `
        #pdfCanvas {
            max-width: 100%;
            border: 1px solid #dee2e6;
            border-radius: 4px;
        }
        
        .pdf-container {
            overflow: auto;
            max-height: calc(70vh - 100px);
            background: beige;
        }
        
        .pdf-toolbar {
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        #btnViewFile:hover {
            transform: translateY(-1px);
            transition: transform 0.2s;
        }
        
        #pdfViewerModal .modal-dialog {
            max-width: 90%;
            max-height: 90vh;
        }
        
        .modal {
            background: rgba(0, 0, 0, 0.42) !important;
        }
        
        #pdfViewerModal .modal-body {
            min-height: 70vh;
            max-height: 80vh;
            overflow: hidden;
        }
        
        @media (max-width: 768px) {
            #pdfViewerModal .modal-dialog {
                max-width: 95%;
                margin: 0.5rem;
            }
            
            .pdf-toolbar {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .pdf-toolbar > div {
                width: 100%;
                justify-content: center;
            }
        }
    `;

    // Add CSS to document
    if (!document.getElementById('pdf-viewer-css')) {
        const style = document.createElement('style');
        style.id = 'pdf-viewer-css';
        style.textContent = pdfViewerCSS;
        document.head.appendChild(style);
    }

	// Select row table
					$('#publishedDataTable tbody, #job_detailsdataTable tbody')
							.on(
									'click',
									'tr',
									function() {
										var $row = $(this), isSelected = $row
												.hasClass('selected')
										$row.toggleClass('selected').find(
												':checkbox').prop('checked',
												!isSelected);

										$('#selectAll').prop('checked', false);

									});
					// select all in table
					$("#selectAll")
							.on(
									"click",
									function() {
										if ($(this).prop("checked") == true) {
											$(
													'#job_casemgtdetailsdataTableCS tbody tr, #job_batchedtouserlistdataTable tbody tr, #job_casemgtdetailsdataTable tbody tr, #job_casemgtdetailsdataTableCSAU tbody tr, #job_casemgtdetailsdataTable_cst tbody tr, #job_casemgtdetailsdataTable_frrv tbody tr, #job_casemgtdetailsdataTable_elis_reports tbody tr, #job_casemgtdetailsdataTable__supervisor_cst tbody tr, #job_casemgtdetailsdataTable__supervisor_frrv tbody tr, #job_casemgtdetailsdataTable_tpp tbody tr, #job_casemgtdetailsdataTable__supervisor_tpp tbody tr, #job_detailsdataTable tbody tr, #publishedDataTable tbody tr, #job_casemgtdetailsdataTable_frrv_cst tbody tr, #job_casemgtdetailsdataTable__supervisor_frrv_cst tbody tr')
													.addClass('selected');
										} else {
											$(
													'#job_casemgtdetailsdataTableCS tbody tr, #job_batchedtouserlistdataTable tbody tr, #job_casemgtdetailsdataTable tbody tr, #job_casemgtdetailsdataTableCSAU tbody tr, #job_casemgtdetailsdataTable_cst tbody tr, #job_casemgtdetailsdataTable_frrv tbody tr, #job_casemgtdetailsdataTable_elis_reports tbody tr, #job_casemgtdetailsdataTable__supervisor_cst tbody tr, #job_casemgtdetailsdataTable__supervisor_frrv tbody tr, #job_casemgtdetailsdataTable_tpp tbody tr, #job_casemgtdetailsdataTable__supervisor_tpp tbody tr, #job_detailsdataTable tbody tr, #publishedDataTable tbody tr, #job_casemgtdetailsdataTable_frrv_cst tbody tr, #job_casemgtdetailsdataTable__supervisor_frrv_cst tbody tr')
													.removeClass('selected');
										}

										$(
												"#job_casemgtdetailsdataTableCS tbody tr, #job_batchedtouserlistdataTable tbody tr, #job_casemgtdetailsdataTable tbody tr, #job_casemgtdetailsdataTableCSAU tbody tr, #job_casemgtdetailsdataTable_cst tbody tr, #job_casemgtdetailsdataTable_frrv tbody tr, #job_casemgtdetailsdataTable_elis_reports tbody tr, #job_casemgtdetailsdataTable__supervisor_cst tbody tr, #job_casemgtdetailsdataTable__supervisor_frrv tbody tr, #job_casemgtdetailsdataTable_tpp tbody tr, #job_casemgtdetailsdataTable__supervisor_tpp tbody tr, #job_detailsdataTable tbody tr, #publishedDataTable tbody tr, #job_casemgtdetailsdataTable_frrv_cst tbody tr, #job_casemgtdetailsdataTable__supervisor_frrv_cst tbody tr")
												.find(":checkbox")
												.prop('checked',
														$(this).prop('checked'));

									});


    $('.addeditpartyGeneralBtn').on('click', function(e) {
        var party_id ='';
        //get data-id attribute of the clicked element
        var party_id = $(this).data('target-id');
        //console.log("party_id=" + party_id); 
        //populate the textbox
        $('#party_id_gen').val(party_id);
        
        $("#party_ar_name_gen").val($(this).data('ar_name')); 
        $("#party_ar_gender_gen").find('option[value="' + $(this).data('ar_gender') + '"]').prop('selected', true); 
        $("#party_ar_cell_phone_gen").val($(this).data('ar_cell_phone'));
        $("#party_ar_cell_phone2_gen").val($(this).data('ar_cell_phone2'));
        $("#party_ar_nationality_gen").find('option[value="' + $(this).data('ar_nationality') + '"]').prop('selected', true); 
        $("#party_ar_address_gen").val($(this).data('ar_address'));
        $("#party_ar_tin_no_gen").val($(this).data('ar_tin_no')); 
        $("#party_ar_id_type_gen").find('option[value="' + $(this).data('ar_id_type') + '"]').prop('selected', true); 
        $("#party_ar_id_number_gen").val($(this).data('ar_id_number'));
        $("#party_ar_type_of_party_gen").find('option[value="' + $(this).data('type_of_party') + '"]').prop('selected', true);  
        $("#party_ar_location_gen").val($(this).data('ar_location')); 
        $("#party_ar_district_gen").val($(this).data('ar_district'));
        $("#party_ar_region_gen_gen").val($(this).data('ar_region')); 
        $("#party_ar_person_type_gen").find('option[value="' + $(this).data('ar_person_type') + '"]').prop('selected', true); 

        $('#addeditpartyGeneral').modal('show');
        
    });
});
