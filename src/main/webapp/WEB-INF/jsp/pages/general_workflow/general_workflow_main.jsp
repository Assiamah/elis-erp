<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="d" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.*" %>
<jsp:include page="../includes/_header.jsp"></jsp:include>
<link href="../assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
<style>
   .workflow-dashboard {
        font-family: 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
        color: #3c4d62;
    }

    .dashboard-header {
        padding: 1rem 0;
        border-bottom: 1px solid #f0f2f5;
    }

    .btn-add-request {
        padding: 0.5rem 1.25rem;
        font-weight: 500;
        border-radius: 6px;
        box-shadow: 0 2px 8px rgba(0, 123, 255, 0.2);
        transition: all 0.3s ease;
    }

    .btn-add-request:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
    }

    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 1.5rem;
    }

    .stat-card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.03);
        transition: all 0.3s ease;
        border: 1px solid #f0f2f5;
        cursor: pointer;
        overflow: hidden;
        position: relative;
    }

    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
    }

    /* Active card styles */
    .stat-card.active {
        color: white;
    }

    .stat-card-info.active {
        background-color: #17a2b8;
        border-color: #17a2b8;
    }

    .stat-card-success.active {
        background-color: #28a745;
        border-color: #28a745;
    }

    .stat-card-warning.active {
        background-color: #ffc107;
        border-color: #ffc107;
    }

    .stat-card-danger.active {
        background-color: #dc3545;
        border-color: #dc3545;
    }

    .stat-card.active .stat-title,
    .stat-card.active .stat-value,
    .stat-card.active .stat-trend {
        color: white !important;
    }

    .stat-card-link {
        text-decoration: none !important;
        display: block;
        color: inherit;
    }

    /* Updated CSS for stat-icon */
    .stat-icon {
        width: 48px;
        height: 48px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        float: left;
        margin-right: 1rem;
        transition: all 0.3s ease;
    }

  /* Updated CSS for stat-icon */
    .stat-icon {
        width: 48px;
        height: 48px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        float: left;
        margin-right: 1rem;
        transition: all 0.3s ease;
    }

    /* Active state - white background */
    .stat-card.active .stat-icon {
        background-color: white !important;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .stat-card:not(.active) .stat-icon {
        background-color: rgba(0, 0, 0, 0.05);
    }

    .stat-card-info:not(.active) .stat-icon {
        background-color: rgba(23, 162, 184, 0.1);
    }

    .stat-card-success:not(.active) .stat-icon {
        background-color: rgba(40, 167, 69, 0.1);
    }

    .stat-card-warning:not(.active) .stat-icon {
        background-color: rgba(255, 193, 7, 0.1);
    }

    .stat-card-danger:not(.active) .stat-icon {
        background-color: rgba(220, 53, 69, 0.1);
    }

    .stat-content {
        overflow: hidden;
    }

    .stat-title {
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        color: #6c757d;
        margin-bottom: 0.25rem;
        font-weight: 600;
    }

    .stat-value {
        font-size: 1.75rem;
        font-weight: 600;
        margin-bottom: 0.25rem;
        color: #3c4d62;
    }

    .stat-trend {
        font-size: 0.75rem;
        font-weight: 500;
        color: #6c757d;
    }

    .main-card {
        border: none;
        background: white;
        overflow: hidden;
    }

    .card-header {
        padding: 1.25rem 1.5rem;
        background: white;
        border-bottom: 1px solid #f0f2f5;
    }

    .card-title {
        font-weight: 600;
        color: #3c4d62;
    }

    .modern-table {
        width: 100%;
        margin-bottom: 0;
    }

    .modern-table thead th {
        padding: 1rem 1.5rem;
        background-color: #f9fafc;
        color: #6c757d;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.75rem;
        letter-spacing: 0.5px;
        border-bottom: 1px solid #f0f2f5;
        white-space: nowrap;
    }

    .modern-table tbody td {
        padding: 1rem 1.5rem;
        vertical-align: middle;
        border-bottom: 1px solid #f0f2f5;
    }

    .no-data {
        background: #f9fafc;
    }

    .card-footer {
        background: white;
        border-top: 1px solid #f0f2f5;
        padding: 1rem 1.5rem;
    }

    .table-info {
        font-size: 0.875rem;
        color: #6c757d;
    }

    .pagination .page-item .page-link {
        border-radius: 4px;
        margin: 0 2px;
        border: none;
        color: #6c757d;
    }

    .pagination .page-item.active .page-link {
        background-color: #3a7bd5;
        color: white;
    }

     /* Custom Modal Styling */
    #jobsListModal .modal-content {
        border-radius: 0.5rem;
        overflow: hidden;
    }
    
    #jobsListModal .modal-header {
        padding: 1.25rem 2rem;
        border-bottom: none;
    }
    
    #jobsListModal .modal-body {
        padding: 0;
    }
    
    #jobsListModal .modal-footer {
        border-top: 1px solid #e9ecef;
        padding: 1.25rem 2rem;
    }
    
    /* Tab Styling */
    #jobsListModal .nav-tabs {
        border-bottom: 2px solid #dee2e6;
    }
    
    #jobsListModal .nav-tabs .nav-link {
        border: none;
        color: #6c757d;
        font-weight: 500;
        padding: 0.75rem 1.5rem;
        border-radius: 0;
    }
    
    #jobsListModal .nav-tabs .nav-link.active {
        color: #3a7bd5;
        background-color: transparent;
        border-bottom: 3px solid #3a7bd5;
    }
    
    /* Table Styling */
    #jobsListModal #selectedJobsTable thead th {
        border-top: none;
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    #jobsListModal #selectedJobsTable tbody tr {
        transition: all 0.2s ease;
    }
    
    #jobsListModal #selectedJobsTable tbody tr:hover {
        background-color: #f8f9fa;
    }
    
    /* Button Styling */
    #jobsListModal .btn {
        font-weight: 500;
        padding: 0.5rem 1.25rem;
        border-radius: 0.25rem;
    }
    
    /* Input Styling */
    #jobsListModal .form-control {
        border-radius: 0.25rem;
        padding: 0.5rem 0.75rem;
    }
    
    /* Empty State */
    #jobsListModal .no-jobs {
        background-color: #f8f9fa;
    }
</style>

<section class="container-fluid">
        <!-- Header with Logo -->
        <div class="workflow-dashboard">
            <!-- Modern Breadcrumb with Icon -->
            <div class="dashboard-header d-flex justify-content-between align-items-center mb-4">
                <div class="d-flex align-items-center">
                    <i class="fas fa-project-diagram text-primary mr-3 fa-lg"></i>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item active" aria-current="page">
                                <span class="fw-semibold">General Workflow</span>
                            </li>
                        </ol>
                    </nav>
                </div>
                <button class="btn btn-primary btn-add-request" data-toggle="modal" data-target="#addRequestModal">
                    <i class="fas fa-plus-circle mr-2"></i>New Request
                </button>
            </div>

            <!-- Minimal Stat Cards with Improved Layout -->
            <div class="stats-grid mb-5">
                <div class="stat-card stat-card-info" id="card-incoming">
                    <a href="#" class="stat-card-link btnLoadData btnLoadDataIncoming" data-status="incoming" data-id="1">
                        <div class="card-body">
                            <div class="stat-icon">
                                <i class="fas fa-inbox text-info pl-2"></i>
                            </div>
                            <div class="stat-content">
                                <h6 class="stat-title">INCOMING</h6>
                                <h3 class="stat-value">${incoming}</h3>
                                <!-- <div class="stat-trend">
                                    <i class="fas fa-arrow-up"></i> 0%
                                </div> -->
                            </div>
                        </div>
                    </a>
                </div>
                
                <div class="stat-card stat-card-success" id="card-completed">
                    <a href="#" class="stat-card-link btnLoadData btnLoadDataCompleted" data-status="completed" data-id="3">
                        <div class="card-body">
                            <div class="stat-icon">
                                <i class="fas fa-check-circle text-success pl-2"></i>
                            </div>
                            <div class="stat-content">
                                <h6 class="stat-title">COMPLETED</h6>
                                <h3 class="stat-value">${completed}</h3>
                                <!-- <div class="stat-trend">
                                    <i class="fas fa-arrow-up"></i> 0%
                                </div> -->
                            </div>
                        </div>
                    </a>
                </div>
                
                <div class="stat-card stat-card-warning" id="card-pending">
                    <a href="#" class="stat-card-link btnLoadData btnLoadDataPending" data-status="pending" data-id="4">
                        <div class="card-body">
                            <div class="stat-icon">
                                <i class="fas fa-hourglass-half text-warning pl-2"></i>
                            </div>
                            <div class="stat-content">
                                <h6 class="stat-title">PENDING</h6>
                                <h3 class="stat-value">${awaiting}</h3>
                                <!-- <div class="stat-trend">
                                    <i class="fas fa-arrow-down"></i> 0%
                                </div> -->
                            </div>
                        </div>
                    </a>
                </div>
                
                <div class="stat-card stat-card-danger" id="card-queried">
                    <a href="#" class="stat-card-link btnLoadData btnLoadDataQueried" data-status="queried" data-id="5">
                        <div class="card-body">
                            <div class="stat-icon">
                                <i class="fas fa-exclamation-triangle text-danger pl-2"></i>
                            </div>
                            <div class="stat-content">
                                <h6 class="stat-title">QUERIED</h6>
                                <h3 class="stat-value">${queried}</h3>
                                <!-- <div class="stat-trend">
                                    <i class="fas fa-arrow-up"></i> 0%
                                </div> -->
                            </div>
                        </div>
                    </a>
                </div>
            </div>

            <!-- Modern Table Card -->
            <div class="main-card shadow-sm rounded-lg">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0">Request Details <small class="text-muted filter-status"></small></h5>
                    <div class="table-actions">
                        <button class="btn btn-sm btn-outline-secondary d-none" id="btn_add_request_all">
                            <i class="fas fa-check-circle"></i> Add All To Request List
                        </button>
                        <button class="btn btn-sm btn-outline-secondary d-none" id="btn_add_archive_all">
                            <i class="fas fa-trash"></i> Add All To Archive List
                        </button>
                        <button class="btn btn-sm btn-info btnLoadData mr-2" data-id="2">
                            <i class="fas fa-users"></i> Request With Officers [ <span class="font-weight-bold">${with_officers}</span> ]
                        </button>
                        <!-- <button class="btn btn-sm btn-outline-secondary">
                            <i class="fas fa-list"></i> View Batch List
                        </button> -->
                    </div>
                </div>
                <div class="card-body p-4">
                    <div class="table-responsive">
                        <table id="requestsTable" class="modern-table table-hover table-striped">
                            <thead>
                                <tr>
                                    <th>
                                        <div class="form-check d-flex justify-content-center align-items-center">
                                            <input class="form-check-input" type="checkbox" id="selectAll">
                                        </div>
                                    </th>
                                    <th>Requested Date</th>
                                    <th>Job Number</th>
                                    <th>Application</th>
                                    <th>Type</th>
                                    <th>Purpose</th>
                                    <th>Comment</th>
                                    <th id="inbox_text">Requested By</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-right" width="120px">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="small">
                                
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- <div class="card-footer d-flex justify-content-between align-items-center">
                    <div class="table-info">
                        Showing 0 of 0 entries
                    </div>
                    <nav>
                        <ul class="pagination pagination-sm mb-0">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" tabindex="-1">Previous</a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item disabled">
                                <a class="page-link" href="#">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div> -->
            </div>
        </div>



        <!-- Modal for Adding New Request -->
        <div class="modal fade" id="addRequestModal" tabindex="-1" role="dialog" aria-labelledby="addRequestModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addRequestModalLabel">Add New Request</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="itemName">Request Purpose:</label>
                                <select class="form-control" id="gwf_request_purpose">
                                    
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="itemName">Reference Type:</label>
                                <select class="form-control" id="gwf_request_reference_type">
                                    <option value="">-- Select Reference Type --</option>
                                    <option value="Job Number">Job Number</option>
                                    <option value="Certificate Number">Certificate Number</option>
                                    <option value="Parcel ID">Parcel ID</option>
                                    <option value="GLPIN">GLPIN</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="itemName">Keyword:</label>
                                <input type="text" class="form-control" id="gwf_request_keyword" placeholder="Enter item name">
                            </div>
                            <!-- <div class="form-group">
                                <label for="category">Category</label>
                                <select class="form-control" id="category">
                                    <option value="">-- Select Category --</option>
                                    <option value="Mandatory">Mandatory</option>
                                    <option value="Optional">Optional</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="amount">Amount</label>
                                <input type="number" class="form-control" id="amount" placeholder="Enter amount">
                            </div> -->
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-dismiss="modal">Close</button>
                        <button type="button" id="btn_check_request" class="btn btn-success btn-pulse">Check</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

<jsp:include page="../includes/_footer.jsp"></jsp:include>
<link rel="stylesheet" href="../legal/includes/bootstrap/css/toastr.min.css">
<script src="../legal/includes/bootstrap/js/toastr.min.js"></script>
<script src="../assets/libs/sweetalert2/sweetalert2.all.min.js"></script>

<script>

    $("#addRequestModal").on('shown.bs.modal', function (e) {
        var type_of_request = $(e.relatedTarget).data('bs-desc');
        //console.log(type_of_request);

        $.ajax({
                type : "POST",
                url : "Case_Management_Serv",
                data : {
                    request_type : 'get_request_purpose',
                },
                cache : false,
                beforeSend : function() {
                },
                success : function(jobdetails) {
                    //console.log(jobdetails);
                    var json_p = JSON.parse(jobdetails);
                    var options = $("#gwf_request_purpose");
                    options.empty();
                    options.append(new Option("-- Select Purpose --", ""));
                    $(json_p).each(function() {

                        $('#gwf_request_purpose').append('<option value="'+ this.request_name+ '">'+ this.request_name+ '</option>');
                        
                    });
                }
            });
    });

    $("#btn_check_request").on('click', function (e) {
        const request_purpose = $("#gwf_request_purpose").val();
        const request_reference_type = $("#gwf_request_reference_type").val();
        const request_keyword = $("#gwf_request_keyword").val();

        const btnCheckRequest = $("#btn_check_request");

        if (request_purpose == "") {
            //alert("Please select Request Purpose");
            toastr['warning']("Please select Request Purpose");
            $("#gwf_request_purpose").focus();
            return;
        }
        if (request_reference_type == "") {
            //alert("Please select Reference Type");
            toastr['warning']("Please select Reference Type");
            $("#gwf_request_reference_type").focus();
            return;
        }
        if (request_keyword == "") {
            //alert("Please enter Keyword");
            toastr['warning']("Please enter Keyword");
            $("#gwf_request_keyword").focus();
            return;
        }

        btnCheckRequest.attr('disabled', true);
        btnCheckRequest.html('Checking...');

        $.ajax({
            type : "POST",
            url : "Case_Management_Serv",
            data : {
                request_type : 'check_request_purpose_validation',
                request_purpose : request_purpose,
                request_reference_type : request_reference_type,
                request_keyword : request_keyword,
            },
            cache : false,
            beforeSend : function() {
            },
            success : function(jobdetails) {
                console.log(jobdetails);
                var json_p = JSON.parse(jobdetails);
                if(json_p.success){
                    toastr['success']('Request already exists');
                    $("#addRequestModal").modal("hide");
                    Swal.fire({
                        title: 'Add Job to Request List?',
                        text: 'This will add selected jobs to request to list.',
                        icon: 'question',
                        html: `
                            <!-- <p>This will add selected jobs to request to list.</p> -->
                            <div class="form-group text-start mt-2">
                                <label for="txt_general_remarks_notes">Remarks: <span class="text-danger">*</span></label>
                                <textarea class="form-control mt-1" id="txt_general_remarks_notes" rows="3"></textarea>
                            </div>
                        `,
                        showCancelButton: true,
                        confirmButtonText: 'Yes, Add',
                        cancelButtonText: 'Cancel',
                        confirmButtonColor: '#28a745',
                        cancelButtonColor: '#d33'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            var remarks_notes = $("#txt_general_remarks_notes").val();
                            if (!remarks_notes) {
                                Swal.fire({
                                    title: 'Remarks is required!',
                                    icon: 'warning',
                                    confirmButtonText: 'OK',
                                });
                                return;
                            }
                            const jobData = json_p.data;
                            const exists = selectedJobsList.some(job => job.job_number === jobData.job_number);
        
                            if (exists) {
                                Swal.fire({
                                    title: 'Duplicate Job',
                                    text: `Job ${jobData.job_number} is already in the list.`,
                                    icon: 'warning',
                                    confirmButtonText: 'OK'
                                });

                                return;
                            }
                            
                            // Add job to list
                            selectedJobsList.push({
                                job_number: jobData.job_number,
                                ar_name: jobData.ar_name,
                                business_process_sub_name: jobData.business_process_sub_name,
                                job_purpose: request_purpose,
                                remarks_notes: remarks_notes,
                                // created_on: jobData.created_on,
                                // job_status: jobData.job_status
                            });

                            // Update localStorage
                            localStorage.setItem('requestBatchingListData', JSON.stringify(selectedJobsList));
                            
                            // Update the table
                            updateSelectedJobsTable();

                            showAddRequestModal();
                        }
                    });
                }else{
                    toastr['warning']('Request does not exist');
                }
                btnCheckRequest.attr('disabled', false);
                btnCheckRequest.html('Check');
            },
            error : function(jobdetails) {
                //console.log(jobdetails);
                btnCheckRequest.attr('disabled', false);
                btnCheckRequest.html('Check');
                var json_p = JSON.parse(jobdetails);
                toastr['error'](json_p.message);
            }
        });

    });

   $(document).ready(function () {
        // Initialize DataTable if not already initialized
        if (!$.fn.DataTable.isDataTable('#requestsTable')) {
            $('#requestsTable').DataTable({
                pageLength: 10,
                lengthChange: false,
                searching: true,
                ordering: true,
                info: true,
                buttons: [
                    {
                        extend: 'copy',
                        className: 'btn btn-sm btn-secondary',
                        text: '<i class="fas fa-copy"></i> Copy'
                    },
                    {
                        extend: 'excel',
                        className: 'btn btn-sm btn-outline-secondary',
                        text: '<i class="fas fa-file-excel"></i> Excel'
                    },
                    // {
                    //     extend: 'pdf',
                    //     className: 'btn btn-sm btn-outline-secondary',
                    //     text: '<i class="fas fa-file-pdf text-danger"></i> PDF'
                    // },
                    // {
                    //     extend: 'print',
                    //     className: 'btn btn-sm btn-outline-secondary',
                    //     text: '<i class="fas fa-print text-warning"></i> Print'
                    // }
                ],
                dom: 'lBfrtip',
            });

            $(".buttons-copy").removeClass("dt-button buttons-html5 btn btn-sm btn-secondary");
            $(".buttons-copy").addClass("btn btn-sm btn-info");
            $(".buttons-excel").removeClass("dt-button buttons-html5 btn btn-sm btn-outline-secondary");
            $(".buttons-excel").addClass("btn btn-sm btn-success");

            $(".dataTables_info").css("font-size", "15px");

            $('.modern-table tbody').html(`
                <tr class="no-data">
                    <td colspan="10" class="text-center py-4">
                        <i class="fas fa-database fa-2x text-muted mb-2"></i>
                        <p class="text-muted">No requests found</p>
                        <!-- <button class="btn btn-sm btn-primary" data-toggle="modal" data-target="#addRequestModal">
                            <i class="fas fa-plus mr-1"></i> Create Request
                        </button> -->
                    </td>
                </tr>
            `);
        }

        $('.btnLoadData').click(function (e) {
            e.preventDefault();
            const data_id = $(this).data('id');
            const card = $(this).closest('.stat-card');

            $('.stat-card, .stat-card-link').removeClass('active');
            card.addClass('active');
            $(this).addClass('active');

            // Update "Requested By" text based on type
            switch (data_id) {
                case 1:
                case 2:
                    $("#inbox_text").text('Officer/Unit');
                    break;
                case 3:
                    $("#inbox_text").text('Requested By');
                    break;
                case 5:
                    $("#inbox_text").text('Queried By');
                    break;
                case 4:
                    $("#inbox_text").text('Forwarded To');
                    break;
            }

            //console.log(data_id)

            data_id === 1
                ? $("#btn_add_request_all").removeClass('d-none')
                : $("#btn_add_request_all").addClass('d-none');
            
            data_id === 4
                ? $("#btn_add_archive_all").removeClass('d-none')
                : $("#btn_add_archive_all").addClass('d-none');

            data_id === 2 ? $('.filter-status').text('[Showing: REQUESTS WITH OFFICERS]') : $('.filter-status').text('[Showing: ' + $(this).find('.stat-title').text() + ']');

            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                    request_type: 'load_app_request_at_unit_by_inbox_type',
                    inbox_type: data_id + '_false',
                },
                success: function (jobdetails) {
                    if (!jobdetails || jobdetails === '[]') {
                        return showNoDataMessage();
                    }

                    let response = JSON.parse(jobdetails);

                    if (!response.data) {
                        return showNoDataMessage();
                    }

                    //console.log(response.data);

                    updateTable(response.data, data_id);
                }
            });
        });

        function showNoDataMessage() {
            const datatable = $('#requestsTable').DataTable();
            datatable.clear().draw();

            $('.modern-table tbody').html(`
                <tr class="no-data">
                    <td colspan="10" class="text-center py-4">
                        <i class="fas fa-database fa-2x text-muted mb-2"></i>
                        <p class="text-muted">No requests found</p>
                        <!-- <button class="btn btn-sm btn-primary" data-toggle="modal" data-target="#addRequestModal">
                            <i class="fas fa-plus mr-1"></i> Create Request
                        </button> -->
                    </td>
                </tr>
            `);
            toastr['warning']('No requests found');
        }

        function updateTable(data, inbox_type) {
            const datatable = $('#requestsTable').DataTable();
            datatable.clear();

            data.forEach(function(item) {
                const rowNode = datatable.row.add([
                    '<div class="form-check d-flex justify-content-center align-items-center"><input class="form-check-input" type="checkbox"><input class="form-control rq_id" type="hidden" value="'+item.rq_id+'"></div>',
                    item.created_on,
                    item.job_number,
                    item.ar_name,
                    item.business_process_sub_name,
                    item.job_purpose,
                    (inbox_type == 2 ? item.officer_comments : item.remarks),
                    ([4,2].includes(inbox_type) ? item.job_recieved_by : item.job_forwarded_by),
                    `<div class="text-center"><h6><span class="badge badge-pill badge-`+getStatusClass(item.job_status)+`">`+item.job_status+`</span></h6></div>`,
                    inbox_type == 1 ?
                    `<div class="d-flex justify-content-end align-items-end">
                        <div class="btn-group" role="group">
                            <button class="btn btn-sm btn-info btn-view-job" data-id="`+item.case_number+`">
                                <i class="fas fa-eye ml-2"></i>
                            </button>
                            <button class="btn btn-sm btn-warning btn-add-to-list" data-id="`+item.job_number+`">
                                <i class="fas fa-paper-plane ml-2"></i>
                            </button>
                        </div>
                    </div>` : inbox_type == 3 ?
                    `<div class="d-flex justify-content-end align-items-end">
                        <div class="btn-group" role="group">
                            <button class="btn btn-sm btn-info btn-view-job" data-id="`+item.case_number+`">
                                <i class="fas fa-eye ml-2"></i>
                            </button>
                            <button class="btn btn-sm btn-warning btn-add-to-list" data-id="`+item.job_number+`">
                                <i class="fas fa-paper-plane ml-2"></i>
                            </button>
                            <button class="btn btn-sm btn-success btn-work-job" 
                                data-job_number="`+item.job_number+`" 
                                data-case_number="`+item.case_number+`" 
                                data-transaction_number="`+item.transaction_number+`"
                                data-job_purpose="`+item.job_purpose+`"
                                data-business_process_sub_name="`+item.business_process_sub_name+`"
                                data-review_instruction="`+item.review_instruction+`"
                            >
                                <i class="fas fa-edit ml-2"></i>
                            </button>
                        </div>
                    </div>` : inbox_type == 4 ?
                    `<div class="d-flex justify-content-end align-items-end">
                        <div class="btn-group" role="group">
                            <button class="btn btn-sm btn-info btn-view-job" data-id="`+item.case_number+`">
                                <i class="fas fa-eye ml-2"></i>
                            </button>
                            <button class="btn btn-sm btn-danger btn-archive-job" data-id="`+item.rq_id+`">
                                <i class="fas fa-archive ml-2"></i>
                            </button>
                        </div>
                    </div>` : inbox_type == 2 ?
                    `<div class="d-flex justify-content-end align-items-end">
                        <div class="btn-group" role="group">
                            <button class="btn btn-sm btn-info btn-view-job" data-id="`+item.case_number+`">
                                <i class="fas fa-eye ml-2"></i>
                            </button>
                            <button class="btn btn-sm btn-warning btn-add-to-list" data-id="`+item.job_number+`">
                                <i class="fas fa-paper-plane ml-2"></i>
                            </button>
                        </div>
                    </div>` : inbox_type == 5 ?
                    `<div class="d-flex justify-content-end align-items-end">
                        <div class="btn-group" role="group">
                            <button class="btn btn-sm btn-info btn-view-job" data-id="`+item.case_number+`">
                                <i class="fas fa-eye ml-2"></i>
                            </button>
                            <button class="btn btn-sm btn-warning btn-add-to-list" data-id="`+item.job_number+`">
                                <i class="fas fa-paper-plane ml-2"></i>
                            </button>
                            <button class="btn btn-sm btn-success btn-work-job" 
                                data-job_number="`+item.job_number+`" 
                                data-case_number="`+item.case_number+`" 
                                data-transaction_number="`+item.transaction_number+`"
                                data-job_purpose="`+item.job_purpose+`"
                                data-business_process_sub_name="`+item.business_process_sub_name+`"
                                data-review_instruction="`+item.review_instruction+`"
                            >
                                <i class="fas fa-edit ml-2"></i>
                            </button>
                        </div>
                    </div>` : ''
                    
                ]).draw(false).node();
                
                // Store the full item data in the row for later access
                $(rowNode).data('job-data', item);
            });

            // Add click handler for paper-plane buttons
            $('#requestsTable').off('click', '.btn-add-to-list').on('click', '.btn-add-to-list', function() {
                const row = $(this).closest('tr');
                const jobData = row.data('job-data');
                handlePaperPlaneClick(jobData);
            });

            // Add click handler for view buttons if needed
            $('#requestsTable').off('click', '.btn-view-job').on('click', '.btn-view-job', function() {
                const caseNumber = $(this).data('id');
                //console.log('View job:', caseNumber);
                
                // Create a form dynamically
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'view_application_details';
                form.style.display = 'none'; // Hide the form
                
                // Add the case number as an input field
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'search_text';
                input.value = caseNumber;
                form.appendChild(input);
                
                // Add the form to the body and submit it
                document.body.appendChild(form);
                form.submit();
            });

            // Add click handler for work buttons if needed
            $('#requestsTable').off('click', '.btn-work-job').on('click', '.btn-work-job', function() {
                const caseNumber = $(this).data('case_number');
                const jobNumber = $(this).data('job_number');
                const transactionNumber = $(this).data('transaction_number');
                const jobPurpose = $(this).data('job_purpose');
                const businessProcessSubName = $(this).data('business_process_sub_name');
                const reviewInstruction = $(this).data('review_instruction');
                
                // Create a form dynamically
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'new_request_application_progress_details';
                form.style.display = 'none'; // Hide the form
                
                // Add the case number as an input field
                const inputCaseNumber = document.createElement('input');
                inputCaseNumber.type = 'hidden';
                inputCaseNumber.name = 'search_text';
                inputCaseNumber.value = caseNumber;
                form.appendChild(inputCaseNumber);
                
                // Add the job number as an input field
                const inputJobNumber = document.createElement('input');
                inputJobNumber.type = 'hidden';
                inputJobNumber.name = 'job_number';
                inputJobNumber.value = jobNumber;
                form.appendChild(inputJobNumber);

                // Add the transaction number as an input field
                const inputTransactionNumber = document.createElement('input');
                inputTransactionNumber.type = 'hidden';
                inputTransactionNumber.name = 'transaction_number';
                inputTransactionNumber.value = transactionNumber;
                form.appendChild(inputTransactionNumber);

                // Add the job purpose as an input field
                const inputJobPurpose = document.createElement('input');
                inputJobPurpose.type = 'hidden';
                inputJobPurpose.name = 'job_purpose';
                inputJobPurpose.value = jobPurpose;
                form.appendChild(inputJobPurpose);

                // Add the business process sub name as an input field
                const inputBusinessProcessSubName = document.createElement('input');
                inputBusinessProcessSubName.type = 'hidden';
                inputBusinessProcessSubName.name = 'business_process_sub_name';
                inputBusinessProcessSubName.value = businessProcessSubName;
                form.appendChild(inputBusinessProcessSubName);

                // Add the review instruction as an input field
                const inputReviewInstruction = document.createElement('input');
                inputReviewInstruction.type = 'hidden';
                inputReviewInstruction.name = 'review_instruction';
                inputReviewInstruction.value = reviewInstruction;
                form.appendChild(inputReviewInstruction);

                // Add the form to the body and submit it
                document.body.appendChild(form);
                form.submit();
            });

            $('#requestsTable').off('click', '.btn-archive-job').on('click', '.btn-archive-job', function() {
                const row = $(this).closest('tr');
                const jobData = row.data('job-data');
                const rq_id = $(this).data('id');
                handleArchiveJobClick(jobData, rq_id);
            });
        }
    });

    // Helper function for status badge classes
    function getStatusClass(status) {
        switch(status.toLowerCase()) {
            case 'approved': return 'success';
            case 'pending': return 'warning';
            case 'queried': return 'danger';
            default: return 'info';
        }
    }

    $("#selectAll").on("click", function() {
        if ($(this).prop("checked") == true) {
            $('#requestsTable tbody tr').addClass('selected');
        } else {
            $('#requestsTable tbody tr').removeClass('selected');
        }

        $("#requestsTable tbody tr").find(":checkbox").prop('checked',
        $(this).prop('checked'));
    });

    $('#btn_add_request_all').on('click', function(e) {

         // Check if any checkboxes are selected
        const selectedCount = $('#requestsTable input[type=checkbox]:checked').length;
        
        if (selectedCount === 0) {
            Swal.fire({
                title: 'No Jobs Selected',
                text: 'Please select at least one job to add to the request list.',
                icon: 'warning',
                confirmButtonText: 'OK',
                confirmButtonColor: '#3085d6'
            });
            return; // Exit the function early
        }

        Swal.fire({
            title: 'Add Selected Jobs to Request List?',
            text: 'This will add selected jobs to request to list.',
            icon: 'question',
            html: `
                <!-- <p>This will add selected jobs to request to list.</p> -->
                <div class="form-group text-start mt-2">
                    <label for="txt_general_remarks_notes">Remarks: <span class="text-danger">*</span></label>
                    <textarea class="form-control mt-1" id="txt_general_remarks_notes" rows="3"></textarea>
                </div>
            `,
            showCancelButton: true,
            confirmButtonText: 'Yes, Add',
            cancelButtonText: 'Cancel',
            confirmButtonColor: '#28a745',
            cancelButtonColor: '#d33'
        }).then((result) => {
            if (result.isConfirmed) {
                var remarks_notes = $("#txt_general_remarks_notes").val();
                if (!remarks_notes) {
                    Swal.fire({
                        title: 'Remarks is required!',
                        icon: 'warning',
                        confirmButtonText: 'OK',
                    });
                    return;
                }

                $("#requestsTable input[type=checkbox]:checked").each(function() {
                    var row = $(this).closest("tr")[0];
                    var job_number = row.cells[2].innerHTML;
                    var ar_name = row.cells[3].innerHTML;
                    var business_process_sub_name = row.cells[4].innerHTML;
                    var job_purpose = row.cells[5].innerHTML;
                    addRequestToListxx(
                        job_number,
                        ar_name,
                        business_process_sub_name,
                        "",
                        job_purpose,
                        remarks_notes
                    );

                    // Show the jobs list modal
                    showJobsListModal();
                    updateRequestListCount();
                });
            }
        });
    });

    // Global variable to store selected jobs
    var selectedJobsList = [];

    // Function to show the jobs list modal
    function showJobsListModal() {
        // Create modal HTML
        var modalHTML = `
        <div class="modal fade" id="jobsListModal" tabindex="-1" role="dialog" aria-labelledby="jobsListModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                <div class="modal-content border-0 shadow-lg">
                    <!-- Modal Header -->
                    <div class="modal-header bg-gradient-primary text-white">
                        <h5 class="modal-title font-weight-bold" id="jobsListModalLabel">
                            <i class="fas fa-tasks mr-2"></i>Request List Processing
                        </h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    
                    <!-- Modal Body -->
                    <div class="modal-body p-4">
                        <!-- Distribution Options -->
                        <div class="card mb-4 border-0 shadow-sm">
                            <div class="card-body p-3">
                                <ul class="nav nav-tabs nav-fill" id="distributionTab" role="tablist">
                                    <!-- <li class="nav-item">
                                        <a class="nav-link active" id="unit-tab" data-toggle="tab" href="#unit-distribution" role="tab">
                                            <i class="fas fa-building mr-2"></i>Send to Unit
                                        </a>
                                    </li> -->
                                    <li class="nav-item">
                                        <a class="nav-link active text-left" id="individual-tab" data-toggle="tab" href="#individual-distribution" role="tab">
                                            <i class="fas fa-user mr-2"></i>Send to Individual
                                        </a>
                                    </li>
                                </ul>
                                
                                <div class="tab-content mt-3" id="distributionTabContent">
                                    <!-- Unit Distribution -->
                                    <!-- <div class="tab-pane fade show active" id="unit-distribution" role="tabpanel">
                                        <div class="form-row">
                                            <div class="col-md-6 mb-3">
                                                <label class="font-weight-bold text-muted small">Division</label>
                                                <select id="req_unit_division_to_send_to" class="form-control selectpicker" data-live-search="true">
                                                    <option value="none" selected disabled>Select Division</option>
                                                    <option value="LVD">LVD</option>
                                                    <option value="LRD">LRD</option>
                                                    <option value="PVLMD">PVLMD</option>
                                                    <option value="SMD">SMD</option>
                                                    <option value="RLO">RLO</option>
                                                    <option value="CORPORATE">CORPORATE</option>
                                                </select>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="font-weight-bold text-muted small">Unit</label>
                                                <div class="input-group">
                                                    <input class="form-control" id="req_unit_to_send_to" type="text" list="listofunitsbatching" placeholder="Select Unit">
                                                    <datalist id="listofunitsbatching"></datalist>
                                                    <div class="input-group-append">
                                                        <button class="btn btn-outline-secondary" type="button" id="refreshUnits">
                                                            <i class="fas fa-sync-alt"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div> -->
                                    
                                    <!-- Individual Distribution -->
                                    <div class="tab-pane fade show active" id="individual-distribution" role="tabpanel">
                                        <div class="form-row">
                                            <div class="col-md-4 mb-3">
                                                <label class="font-weight-bold text-muted small">Division/Unit</label>
                                                <input class="form-control bg-light" id="user_divsion" type="text" value="${unit_name}" readonly>
                                            </div>
                                            <div class="col-md-8 mb-3">
                                                <label class="font-weight-bold text-muted small">User</label>
                                                <div class="input-group">
                                                    <input class="form-control" id="req_user_to_send_to" type="text" list="listofusersbatching" placeholder="Search user...">
                                                    <datalist id="listofusersbatching">
                                                        <!-- User options will be populated here -->
                                                    </datalist>
                                                    <div class="input-group-append">
                                                        <button class="btn btn-outline-secondary" type="button" id="refreshUsers">
                                                            <i class="fas fa-sync-alt"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Jobs Table -->
                        <div class="card border-0 shadow-sm">
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0 small" id="selectedJobsTable">
                                        <thead class="thead-light">
                                            <tr>
                                                <th class="py-3">Job Number</th>
                                                <th class="py-3">Application</th>
                                                <th class="py-3">Type</th>
                                                <th class="py-3">Purpose</th>
                                                <th class="py-3">Remarks</th>
                                                <th class="py-3 text-center" width="120px">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Jobs will be added here dynamically -->
                                            <tr class="no-jobs">
                                                <td colspan="6" class="text-center py-4 text-muted">
                                                    <i class="fas fa-inbox fa-2x mb-3"></i>
                                                    <p class="mb-0">No jobs selected</p>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Modal Footer -->
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-outline-danger" id="btnRemoveAllJobs">
                            <i class="fas fa-trash-alt mr-2"></i>Clear All
                        </button>
                        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">
                            <i class="fas fa-times mr-2"></i>Cancel
                        </button>
                        <button type="button" class="btn btn-primary" id="btnSubmitJobs">
                            <i class="fas fa-paper-plane mr-2"></i>Submit Request
                        </button>
                    </div>
                </div>
            </div>
        </div>
        `;
        
        // Add modal to DOM if not already there
        if ($('#jobsListModal').length === 0) {
            $('body').append(modalHTML);
        }
        
        // Initialize event handlers
        initJobsListModalHandlers();

        // After modal is shown, update the table
        $('#jobsListModal').on('shown.bs.modal', function() {
            updateSelectedJobsTable();
        });
        
        // Show modal
        $('#jobsListModal').modal('show');

        $('#req_unit_division_to_send_to').change(function() {
            var selected_division = $(this).val();
            console.log(selected_division);

            $("#req_unit_to_send_to").val("");

            $.ajax({
                type : "POST",
                url : "Case_Management_Serv",
                data : {
                    request_type : 'get_lc_list_of_units',
                },
                cache : false,
                success : function(jobdetails) {
                    //console.log(jobdetails);
                    var json_p = JSON.parse(jobdetails);
                    var datalist = $("#listofunitsbatching");
                    datalist.empty();

                    $(json_p.data).each(function() {
                        if (this.unit_division.includes(selected_division)) {
                            datalist.append('<option data-name="' + this.unit_name + '" data-id="' + this.unit_id + '" value="' + this.unit_name + '" ></option>');
                        }
                    });
                }
            });

        });

        // Load users via AJAX
        function loadUsers() {
            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                    request_type: 'get_lc_list_of_users',
                },
                cache: false,
                beforeSend: function() {
                    $('#refreshUsers i').addClass('fa-spin');
                },
                success : function(jobdetails) {
                    let regional_code_general = $("#regional_code_general").text();
                    //console.log(jobdetails);
                    var json_p = JSON.parse(jobdetails);
                    var datalist = $("#listofusersbatching");
                    datalist.empty();

                    let selected_division = $("#user_divsion").val();

                    $(json_p).each(function() {
                        if (selected_division == this.unit_name && regional_code_general == this.regional_code) {
                            datalist.append('<option data-name="' + this.fullname + '" data-id="' + this.userid + '" value="' + this.fullname + '" ></option>');
                        }
                    });
                },
                complete: function() {
                    $('#refreshUsers i').removeClass('fa-spin');
                }
            });
        }

        // Initial load of users
        loadUsers();

        // Refresh users button
        $('#refreshUsers').on('click', function() {
            loadUsers();
        });


        $("#btnSubmitJobs").click(function(event) {
            // Get the selected user from Select2
            const selectedUser = $("#req_user_to_send_to").val();

            console.log(selectedUser)
            
            // Validate selection
            if (!selectedUser) {
                Swal.fire({
                    title: 'Selection Required',
                    text: 'Please select a user to send the request to',
                    icon: 'warning',
                    confirmButtonText: 'OK'
                });

                return;
            }

            // const send_to_id = selectedUser[0].id;
            // const send_to_name = selectedUser[0].text;
            const  send_to_id  = $('#listofusersbatching option').filter(function() {return this.value == selectedUser; }).data('id');
			const  send_to_name= $('#listofusersbatching option').filter(function() {return this.value == selectedUser; }).data('name');

            // Prepare the request data
            const tableData = [];
            $('#selectedJobsTable tbody tr').not('.no-jobs').each(function() {
                const row = $(this);
                tableData.push({
                    "job_number": row.find('td:eq(0)').text().trim(),
                    "ar_name": row.find('td:eq(1)').text().trim(),
                    "business_process_sub_name": row.find('td:eq(2)').text().trim(),
                    "job_purpose": row.find('td:eq(3)').text().trim(),
                    "remarks": row.find('td:eq(4)').text().trim()
                });
            });

            if (tableData.length === 0) {
                Swal.fire({
                    title: 'No Jobs Selected',
                    text: 'Please add at least one job to submit',
                    icon: 'warning',
                    confirmButtonText: 'OK'
                });
                return;
            }

            const list_of_application_new = JSON.stringify(tableData);
            const request_type = 'process_request_list_to_user';

            // Show loading state
            const submitBtn = $(this);
            submitBtn.prop('disabled', true);
            submitBtn.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Processing...');

            // Submit the request
            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                    request_type: request_type,
                    division: localStorage.getItem('division'),
                    list_of_application: list_of_application_new,
                    send_to_name: send_to_name,
                    send_to_id: send_to_id,
                },
                cache: false,
                success: function(response) {
                    try {
                        const json_p = JSON.parse(response);
                        
                        if (json_p.success === true) {
                            // Generate and show PDF report
                             generateRequestListPDF(list_of_application_new, json_p.batch_number, send_to_name, send_to_id);
                            // Swal.fire({
                            //     title: 'Success',
                            //     text: 'Request submitted successfully',
                            //     icon: 'success',
                            //     confirmButtonText: 'OK'
                            // });
                        } else {
                            Swal.fire({
                                title: 'Action Not Completed',
                                html: `The selected officer has `+json_p.user_count+` case(s) and cannot accept more requests at this time.`,
                                icon: 'error',
                                confirmButtonText: 'OK'
                            });
                        }
                    } catch (e) {
                        console.error("Error parsing response:", e);
                        Swal.fire({
                            title: 'Error',
                            text: 'An error occurred while processing your request',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                    }
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        title: 'Request Failed',
                        text: 'An error occurred while submitting your request. Please try again.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                },
                complete: function() {
                    submitBtn.prop('disabled', false);
                    submitBtn.html('<i class="fas fa-paper-plane mr-2"></i>Submit Request');
                }
            });
        });

        function generateRequestListPDF(list_of_application, batch_number, send_to_name, send_to_id) {
            $.ajax({
                type: "POST",
                url: "GenerateCaseReports",
                data: {
                    request_type: 'request_to_generate_request_list',
                    list_of_application: list_of_application,
                    batch_number: batch_number,
                    modified_by: localStorage.getItem('fullname'),
                    modified_by_id: localStorage.getItem('userid'),
                    send_to_name: send_to_name,
                    send_to_id: send_to_id
                },
                cache: false,
                xhrFields: {
                    responseType: 'blob'
                },
                beforeSend: function() {
                    Swal.fire({
                        title: 'Generating Report',
                        html: 'Please wait while we prepare your request list...',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });
                },
                success: function(data) {
                    Swal.close();
                    
                    const blob = new Blob([data], { type: "application/pdf" });
                    const objectUrl = URL.createObjectURL(blob);
                    
                    // Show PDF in modal preview
                    $('#elisDocumentPreview').modal({
                        backdrop: 'static',
                    });
                    $('#elisdovumentpreviewblobfile').attr('src', objectUrl);
                    
                    // Close the jobs list modal
                    $('#jobsListModal').modal('hide');
                    
                    // Clear the selected jobs list
                    selectedJobsList = [];
                    updateSelectedJobsTable();
                    
                    // Clear local storage if needed
                    localStorage.setItem('requestBatchingListData', '');
                },
                error: function() {
                    Swal.fire({
                        title: 'Error',
                        text: 'Failed to generate the request list PDF',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                }
            });
        }
    }
    
    function showAddRequestModal() {
        // Create modal HTML
        var modalHTML = `
        <div class="modal fade" id="jobsListModal" tabindex="-1" role="dialog" aria-labelledby="jobsListModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                <div class="modal-content border-0 shadow-lg">
                    <!-- Modal Header -->
                    <div class="modal-header bg-gradient-primary text-white">
                        <h5 class="modal-title font-weight-bold" id="jobsListModalLabel">
                            <i class="fas fa-tasks mr-2"></i>Request List Processing
                        </h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    
                    <!-- Modal Body -->
                    <div class="modal-body p-4">
                        <!-- Distribution Options -->
                        <div class="card mb-4 border-0 shadow-sm">
                            <div class="card-body p-3">
                                <ul class="nav nav-tabs nav-fill" id="distributionTab" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" id="unit-tab" data-toggle="tab" href="#unit-distribution" role="tab">
                                            <i class="fas fa-building mr-2"></i>Send to Unit
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link text-left" id="individual-tab" data-toggle="tab" href="#individual-distribution" role="tab">
                                            <i class="fas fa-user mr-2"></i>Send to Individual
                                        </a>
                                    </li>
                                </ul>
                                
                                <div class="tab-content mt-3" id="distributionTabContent">
                                    <!-- Unit Distribution -->
                                    <div class="tab-pane fade show active" id="unit-distribution" role="tabpanel">
                                        <div class="form-row">
                                            <div class="col-md-6 mb-3">
                                                <label class="font-weight-bold text-muted small">Division</label>
                                                <select id="req_unit_division_to_send_to" class="form-control selectpicker" data-live-search="true">
                                                    <option value="none" selected disabled>Select Division</option>
                                                    <option value="LVD">LVD</option>
                                                    <option value="LRD">LRD</option>
                                                    <option value="PVLMD">PVLMD</option>
                                                    <option value="SMD">SMD</option>
                                                    <option value="RLO">RLO</option>
                                                    <option value="CORPORATE">CORPORATE</option>
                                                </select>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="font-weight-bold text-muted small">Unit</label>
                                                <div class="input-group">
                                                    <input class="form-control" id="req_unit_to_send_to" type="text" list="listofunitsbatching" placeholder="Select Unit">
                                                    <datalist id="listofunitsbatching"></datalist>
                                                    <div class="input-group-append">
                                                        <button class="btn btn-outline-secondary" type="button" id="refreshUnits">
                                                            <i class="fas fa-sync-alt"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Individual Distribution -->
                                    <div class="tab-pane fade" id="individual-distribution" role="tabpanel">
                                        <div class="form-row">
                                            <div class="col-md-4 mb-3">
                                                <label class="font-weight-bold text-muted small">Division/Unit</label>
                                                <input class="form-control bg-light" id="user_divsion" type="text" value="${unit_name}" readonly>
                                            </div>
                                            <div class="col-md-8 mb-3">
                                                <label class="font-weight-bold text-muted small">User</label>
                                                <div class="input-group">
                                                    <input class="form-control" id="req_user_to_send_to" type="text" list="listofusersbatching" placeholder="Search user...">
                                                    <datalist id="listofusersbatching">
                                                        <!-- User options will be populated here -->
                                                    </datalist>
                                                    <div class="input-group-append">
                                                        <button class="btn btn-outline-secondary" type="button" id="refreshUsers">
                                                            <i class="fas fa-sync-alt"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Jobs Table -->
                        <div class="card border-0 shadow-sm">
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0 small" id="selectedJobsTable">
                                        <thead class="thead-light">
                                            <tr>
                                                <th class="py-3">Job Number</th>
                                                <th class="py-3">Application</th>
                                                <th class="py-3">Type</th>
                                                <th class="py-3">Purpose</th>
                                                <th class="py-3">Remarks</th>
                                                <th class="py-3 text-center" width="120px">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Jobs will be added here dynamically -->
                                            <tr class="no-jobs">
                                                <td colspan="6" class="text-center py-4 text-muted">
                                                    <i class="fas fa-inbox fa-2x mb-3"></i>
                                                    <p class="mb-0">No jobs selected</p>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Modal Footer -->
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-outline-danger" id="btnRemoveAllJobs">
                            <i class="fas fa-trash-alt mr-2"></i>Clear All
                        </button>
                        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">
                            <i class="fas fa-times mr-2"></i>Cancel
                        </button>
                        <button type="button" class="btn btn-primary" id="btnSubmitJobs">
                            <i class="fas fa-paper-plane mr-2"></i>Submit Request
                        </button>
                    </div>
                </div>
            </div>
        </div>
        `;
        
        // Add modal to DOM if not already there
        if ($('#jobsListModal').length === 0) {
            $('body').append(modalHTML);
        }
        
        // Initialize event handlers
        initJobsListModalHandlers();

        // After modal is shown, update the table
        $('#jobsListModal').on('shown.bs.modal', function() {
            updateSelectedJobsTable();
        });
        
        // Show modal
        $('#jobsListModal').modal('show');

        $('#req_unit_division_to_send_to').change(function() {
            var selected_division = $(this).val();
            console.log(selected_division);

            $("#req_unit_to_send_to").val("");

            $.ajax({
                type : "POST",
                url : "Case_Management_Serv",
                data : {
                    request_type : 'get_lc_list_of_units',
                },
                cache : false,
                success : function(jobdetails) {
                    //console.log(jobdetails);
                    var json_p = JSON.parse(jobdetails);
                    var datalist = $("#listofunitsbatching");
                    datalist.empty();

                    $(json_p.data).each(function() {
                        if (this.unit_division.includes(selected_division)) {
                            datalist.append('<option data-name="' + this.unit_name + '" data-id="' + this.unit_id + '" value="' + this.unit_name + '" ></option>');
                        }
                    });
                }
            });

        });

        // Load users via AJAX
        function loadUsers() {
            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                    request_type: 'get_lc_list_of_users',
                },
                cache: false,
                beforeSend: function() {
                    $('#refreshUsers i').addClass('fa-spin');
                },
                success : function(jobdetails) {
                    let regional_code_general = $("#regional_code_general").text();
                    //console.log(jobdetails);
                    var json_p = JSON.parse(jobdetails);
                    var datalist = $("#listofusersbatching");
                    datalist.empty();

                    let selected_division = $("#user_divsion").val();

                    $(json_p).each(function() {
                        if (selected_division == this.unit_name && regional_code_general == this.regional_code) {
                            datalist.append('<option data-name="' + this.fullname + '" data-id="' + this.userid + '" value="' + this.fullname + '" ></option>');
                        }
                    });
                },
                complete: function() {
                    $('#refreshUsers i').removeClass('fa-spin');
                }
            });
        }

        // Initial load of users
        loadUsers();

        // Refresh users button
        $('#refreshUsers').on('click', function() {
            loadUsers();
        });


        $("#btnSubmitJobs").click(function(event) {

            let activeTabId = $('#distributionTab .nav-link.active').attr('id');

            // Get the selected user from Select2
            const selectedUser =  activeTabId == "unit-tab" ? $("#req_unit_to_send_to").val() : $("#req_user_to_send_to").val();

            console.log(selectedUser)
            
            // Validate selection
            if (!selectedUser) {
                Swal.fire({
                    title: 'Selection Required',
                    text: 'Please select a user to send the request to',
                    icon: 'warning',
                    confirmButtonText: 'OK'
                });

                return;
            }

            // const send_to_id = selectedUser[0].id;
            // const send_to_name = selectedUser[0].text;
            const  send_to_id  = activeTabId == "unit-tab" ? $('#listofunitsbatching option').filter(function() {return this.value == selectedUser; }).data('id') : $('#listofusersbatching option').filter(function() {return this.value == selectedUser; }).data('id');
			const  send_to_name= activeTabId == "unit-tab" ? $('#listofunitsbatching option').filter(function() {return this.value == selectedUser; }).data('name') : $('#listofusersbatching option').filter(function() {return this.value == selectedUser; }).data('name');

            // Prepare the request data
            const tableData = [];
            $('#selectedJobsTable tbody tr').not('.no-jobs').each(function() {
                const row = $(this);
                tableData.push({
                    "job_number": row.find('td:eq(0)').text().trim(),
                    "ar_name": row.find('td:eq(1)').text().trim(),
                    "business_process_sub_name": row.find('td:eq(2)').text().trim(),
                    "job_purpose": row.find('td:eq(3)').text().trim(),
                    "remarks": row.find('td:eq(4)').text().trim()
                });
            });

            if (tableData.length === 0) {
                Swal.fire({
                    title: 'No Jobs Selected',
                    text: 'Please add at least one job to submit',
                    icon: 'warning',
                    confirmButtonText: 'OK'
                });
                return;
            }

            const list_of_application_new = JSON.stringify(tableData);
            const request_type = "process_request_list";
            const batch_type = activeTabId == "unit-tab" ? "Unit" : "User";

            // Show loading state
            const submitBtn = $(this);
            submitBtn.prop('disabled', true);
            submitBtn.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Processing...');

            // Submit the request
            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                    request_type: request_type,
                    division: localStorage.getItem('division'),
                    list_of_application: list_of_application_new,
                    send_to_name: send_to_name,
                    send_to_id: send_to_id,
                    batch_type: batch_type
                },
                cache: false,
                success: function(response) {
                    try {
                        const json_p = JSON.parse(response);
                        
                        if (json_p.success === true) {
                            // Generate and show PDF report
                            generateRequestListPDF(list_of_application_new, json_p.batch_number, send_to_name, send_to_id);
                            // Swal.fire({
                            //     title: 'Success',
                            //     text: 'Request submitted successfully',
                            //     icon: 'success',
                            //     confirmButtonText: 'OK'
                            // });
                        } else {
                            Swal.fire({
                                title: 'Action Not Completed',
                                html: `The selected officer has `+json_p.user_count+` case(s) and cannot accept more requests at this time.`,
                                icon: 'error',
                                confirmButtonText: 'OK'
                            });
                        }
                    } catch (e) {
                        console.error("Error parsing response:", e);
                        Swal.fire({
                            title: 'Error',
                            text: 'An error occurred while processing your request',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                    }
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        title: 'Request Failed',
                        text: 'An error occurred while submitting your request. Please try again.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                },
                complete: function() {
                    submitBtn.prop('disabled', false);
                    submitBtn.html('<i class="fas fa-paper-plane mr-2"></i>Submit Request');
                }
            });
        });

        function generateRequestListPDF(list_of_application, batch_number, send_to_name, send_to_id) {
            $.ajax({
                type: "POST",
                url: "GenerateCaseReports",
                data: {
                    request_type: 'request_to_generate_request_list',
                    list_of_application: list_of_application,
                    batch_number: batch_number,
                    modified_by: localStorage.getItem('fullname'),
                    modified_by_id: localStorage.getItem('userid'),
                    send_to_name: send_to_name,
                    send_to_id: send_to_id
                },
                cache: false,
                xhrFields: {
                    responseType: 'blob'
                },
                beforeSend: function() {
                    Swal.fire({
                        title: 'Generating Report',
                        html: 'Please wait while we prepare your request list...',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });
                },
                success: function(data) {
                    Swal.close();
                    
                    const blob = new Blob([data], { type: "application/pdf" });
                    const objectUrl = URL.createObjectURL(blob);
                    
                    // Show PDF in modal preview
                    $('#elisDocumentPreview').modal({
                        backdrop: 'static',
                    });
                    $('#elisdovumentpreviewblobfile').attr('src', objectUrl);
                    
                    // Close the jobs list modal
                    $('#jobsListModal').modal('hide');
                    
                    // Clear the selected jobs list
                    selectedJobsList = [];
                    updateSelectedJobsTable();
                    
                    // Clear local storage if needed
                    localStorage.setItem('requestBatchingListData', '');
                },
                error: function() {
                    Swal.fire({
                        title: 'Error',
                        text: 'Failed to generate the request list PDF',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                }
            });
        }
    }

    // Function to initialize modal event handlers
    function initJobsListModalHandlers() {
        // Remove single job
        $('#selectedJobsTable').off('click', '.btn-remove-job').on('click', '.btn-remove-job', function() {
            var jobNumber = $(this).data('job-number');
            selectedJobsList = selectedJobsList.filter(job => job.job_number !== jobNumber);
            updateSelectedJobsTable();
            updateRequestListCount();
        });
        
        // Remove all jobs
        $('#btnRemoveAllJobs').off('click').on('click', function() {
            Swal.fire({
                title: 'Remove All Jobs?',
                text: 'Are you sure you want to remove all jobs from the list?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes, Remove All',
                cancelButtonText: 'Cancel',
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6'
            }).then((result) => {
                if (result.isConfirmed) {
                    selectedJobsList = [];
                    updateSelectedJobsTable();
                    $('#requestListCount').text('0');
                    $('#btnViewRequestList').hide();
                }
            });
        });
    }

    // Function to handle paper-plane button click
    function handlePaperPlaneClick(jobData) {
        // Check if job already exists in the list
        const exists = selectedJobsList.some(job => job.job_number === jobData.job_number);
        
        if (exists) {
            Swal.fire({
                title: 'Duplicate Job',
                text: `Job ${jobData.job_number} is already in your request list.`,
                icon: 'warning',
                confirmButtonText: 'OK'
            });
            return;
        }
        
        Swal.fire({
            title: 'Add to Request List',
            html: `
                <div class="form-group text-start mt-2">
                    <label for="jobRemarks">Remarks:</label>
                    <textarea class="form-control" id="jobRemarks" rows="3" placeholder="Enter remarks for this job"></textarea>
                </div>
            `,
            showCancelButton: true,
            confirmButtonText: 'Add to List',
            cancelButtonText: 'Cancel',
            confirmButtonColor: '#28a745',
            cancelButtonColor: '#d33',
            preConfirm: () => {
                const remarks = $('#jobRemarks').val();
                if (!remarks) {
                    Swal.showValidationMessage('Remarks are required');
                    return false;
                }
                return remarks;
            }
        }).then((result) => {
            if (result.isConfirmed) {
                // Add job to list with remarks
                selectedJobsList.push({
                    job_number: jobData.job_number,
                    ar_name: jobData.ar_name,
                    business_process_sub_name: jobData.business_process_sub_name,
                    job_purpose: jobData.job_purpose,
                    remarks_notes: result.value,
                    created_on: jobData.created_on,
                    job_status: jobData.job_status
                });
                
                // Update localStorage
                localStorage.setItem('requestBatchingListData', JSON.stringify(selectedJobsList));
                
                // Update UI
                updateRequestListCount();
                
                Swal.fire({
                    title: 'Added!',
                    text: `Job ${jobData.job_number} has been added to your request list.`,
                    icon: 'success',
                    confirmButtonText: 'OK'
                });
            }
        });
    }

    // Function to update the request list count display
    function updateRequestListCount() {
        const count = selectedJobsList.length;
        $('#requestListCount').text(count);
        
        if (count > 0) {
            $('#btnViewRequestList').show();
            $('#btnViewRequestList').removeClass('d-none');
        } else {
            $('#btnViewRequestList').hide();
        }
    }

    // Add click handler for the new button
    // $('#btnViewRequestList').click(function() {
    //     showJobsListModal();
    // });

    // Function to update the selected jobs table
    function updateSelectedJobsTable() {
        var tableBody = $('#selectedJobsTable tbody');
        tableBody.empty();
        
        if (selectedJobsList.length === 0) {
            tableBody.append(`
                <tr>
                    <td colspan="6" class="text-center py-4 text-muted">
                        <i class="fas fa-inbox fa-2x mb-2"></i>
                        <p>No jobs selected</p>
                    </td>
                </tr>
            `);
            return;
        }
        
        selectedJobsList.forEach(job => {
            tableBody.append(`
                <tr>
                    <td>`+job.job_number+`</td>
                    <td>`+job.ar_name+`</td>
                    <td>`+job.business_process_sub_name+`</td>
                    <td>`+job.job_purpose+`</td>
                    <td>`+job.remarks_notes+`</td>
                    <td>
                        <button class="btn btn-sm btn-danger btn-remove-job" data-job-number="`+job.job_number+`">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
            `);
        });
    }

    // Function to handle archive when click
    function handleArchiveJobClick(jobData, rq_id){
        Swal.fire({
            title: 'Archive Job',
            //text: `Are you sure you want to archive job `+jobData.job_number+`?`,
            html: `
                <p>Job Number: `+jobData.job_number+`</p>
                <div class="form-group text-start mt-2">
                    <!-- <label for="jobRemarks">Remarks:</label> -->
                    <textarea class="form-control" id="jobRemarks" rows="3" placeholder="Enter remarks for this job"></textarea>
                </div>
            `,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes, Archive',
            cancelButtonText: 'Cancel',
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6'
        }).then((result) => {
            if (result.isConfirmed) {

                if($('#jobRemarks').val() == ''){
                    Swal.fire({
                        title: 'Error',
                        text: 'Remarks is required',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                    return;
                }
               
                $.ajax({
                    url: 'Case_Management_Serv',
                    type: 'POST',
                    data: {
                        request_type: 'select_archive_application_request',
                        job_number: jobData.job_number,
                        note: $('#jobRemarks').val(),
                        rq_id: rq_id
                    },
                    success: function(response) {
                        let res = JSON.parse(response);
                        if (res.success) {
                            Swal.fire({
                                title: 'Success',
                                text: 'Job archived successfully',
                                icon: 'success',
                                confirmButtonText: 'OK'
                            }).then(() => {
                                // Refresh the page or update the UI
                                location.reload();
                            });
                        } else {
                            Swal.fire({
                                title: 'Error',
                                text: 'Failed to archive job',
                                icon: 'error',
                                confirmButtonText: 'OK'
                            });
                        }
                    }
                });
            }
        });
    }

    // Function to add job to list (with duplicate check)
    window.addRequestToListxx = function(job_number, ar_name, business_process_sub_name, job_recieved_by, job_purpose, remarks_notes) {
        // Check if job already exists in the list
        const exists = selectedJobsList.some(job => job.job_number === job_number);
        
        if (exists) {
            Swal.fire({
                title: 'Duplicate Job',
                text: `Job ${job_number} is already in the list.`,
                icon: 'warning',
                confirmButtonText: 'OK'
            });
            return;
        }
        
        // Add job to list
        selectedJobsList.push({
            job_number,
            ar_name,
            business_process_sub_name,
            job_recieved_by,
            job_purpose,
            remarks_notes
        });
        
        // Update the table
        updateSelectedJobsTable();
    }

    $(document).ready(function() {
        // Initialize Bootstrap Selectpicker if needed
        if ($.fn.selectpicker) {
            $('.selectpicker').selectpicker();
        }
        
        // Tab functionality
        $('#distributionTab a').on('click', function (e) {
            e.preventDefault();
            $(this).tab('show');
        });
        
        // Refresh buttons
        $('#refreshUnits, #refreshUsers').on('click', function() {
            // Add your refresh logic here
            $(this).find('i').addClass('fa-spin');
            setTimeout(() => {
                $(this).find('i').removeClass('fa-spin');
            }, 800);
        });

        // $('.table-actions').prepend(`
        //     <button class="btn btn-sm btn-primary mr-2 btnViewRequestList" id="btnViewRequestList" style="display: none;">
        //         <!-- <i class="fas fa-list-check mr-2"></i> -->
        //         <span class="badge badge-light mr-2" id="requestListCount">0</span> Jobs in List
        //     </button>
        // `);

        // 1. Add the button to your table actions (only once)
        if ($('#btnViewRequestList').length === 0) {
            $('.table-actions').prepend(`
                <button class="btn btn-sm btn-primary mr-2" id="btnViewRequestList" style="display: none;">
                    <!-- <i class="fas fa-list-check mr-2"></i> -->
                    <span class="badge badge-light mr-2" id="requestListCount">0</span> Jobs in List
                </button>
            `);
        }

        // 2. Update the button click handler (use event delegation)
        $(document).off('click', '#btnViewRequestList').on('click', '#btnViewRequestList', function() {
            showJobsListModal();
        });

        $('#jobsListModal').on('hidden.bs.modal', function() {
            // Save the current list to localStorage
            localStorage.setItem('requestBatchingListData', JSON.stringify(selectedJobsList));
        });
    });

    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer);
            toast.addEventListener('mouseleave', Swal.resumeTimer);
        }
    });
    
    // Add click handler for the archive all button
    $('#btn_add_archive_all').on('click', function(e) {
        // Check if any checkboxes are selected
        const selectedCount = $('#requestsTable input[type=checkbox]:checked').length;
        
        if (selectedCount === 0) {
            Swal.fire({
                title: 'No Jobs Selected',
                text: 'Please select at least one job to archive.',
                icon: 'warning',
                confirmButtonText: 'OK',
                confirmButtonColor: '#3085d6'
            });
            return;
        }

        Swal.fire({
            title: 'Archive Selected Jobs?',
            text: 'This will move all selected jobs to the archive.',
            icon: 'question',
            html: `
                <div class="form-group text-start mt-2">
                    <label for="txt_archive_remarks">Remarks: <span class="text-danger">*</span></label>
                    <textarea class="form-control mt-1" id="txt_archive_remarks" rows="3" placeholder="Enter archive remarks"></textarea>
                </div>
            `,
            showCancelButton: true,
            confirmButtonText: 'Yes, Archive',
            cancelButtonText: 'Cancel',
            confirmButtonColor: '#28a745',
            cancelButtonColor: '#d33',
            preConfirm: () => {
                const remarks = $('#txt_archive_remarks').val();
                if (!remarks) {
                    Swal.showValidationMessage('Remarks are required for archiving');
                    return false;
                }
                return remarks;
            }
        }).then((result) => {
            if (result.isConfirmed) {
                const archiveRemarks = result.value;
                const archiveBtn = $('#btn_add_archive_all');
                
                // Disable button during processing
                archiveBtn.prop('disabled', true);
                archiveBtn.html('<i class="fas fa-spinner fa-spin"></i> Archiving...');
                
                // Collect all selected jobs data
                const jobsToArchive = [];
                $('#requestsTable input[type=checkbox]:checked').each(function() {
                    const row = $(this).closest('tr');
                    const jobData = $(row).data('job-data');
                    
                    if (jobData) {
                        jobsToArchive.push({
                            job_number: jobData.job_number,
                            ar_name: jobData.ar_name,
                            business_process_sub_name: jobData.business_process_sub_name,
                            job_purpose: jobData.job_purpose,
                            remarks: archiveRemarks
                        });
                    }
                });
                
                if (jobsToArchive.length === 0) {
                     console.log('2')
                    Swal.fire({
                        title: 'Error',
                        text: 'No valid job data found for archiving',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                    archiveBtn.prop('disabled', false);
                    archiveBtn.html('<i class="fas fa-trash"></i> Add All To Archive List');
                    return;
                }
                
                const progressToast = Swal.fire({
                    title: 'Archiving Jobs',
                    html: `Processing ${jobsToArchive.length} jobs...`,
                    timerProgressBar: true,
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                        
                        // Process archiving
                        $.ajax({
                            type: "POST",
                            url: "Case_Management_Serv",
                            data: {
                                request_type: 'process_request_list_to_archive',
                                list_of_application: JSON.stringify(jobsToArchive),
                                remarks: archiveRemarks
                            },
                            success: function(response) {
                                Swal.close();
                                
                                try {
                                    const jsonResponse = JSON.parse(response);
                                    if (jsonResponse.success) {
                                        Swal.fire({
                                            title: 'Success',
                                            text: `Archived ${jobsToArchive.length} jobs successfully`,
                                            icon: 'success',
                                            confirmButtonText: 'OK'
                                        }).then(() => {
                                            // Reload the table to reflect changes
                                            //$('.btnLoadDataPending').click();
                                            window.location.reload();
                                        });
                                    } else {
                                        throw new Error(jsonResponse.message || 'Failed to archive jobs');
                                    }
                                } catch (e) {
                                    Swal.fire({
                                        title: 'Archive Failed',
                                        text: e.message,
                                        icon: 'error',
                                        confirmButtonText: 'OK'
                                    });
                                }
                            },
                            error: function(xhr, status, error) {
                                Swal.fire({
                                    title: 'Archive Failed',
                                    text: 'Server error: ' + error,
                                    icon: 'error',
                                    confirmButtonText: 'OK'
                                });
                            },
                            complete: function() {
                                // Reset button state
                                archiveBtn.prop('disabled', false);
                                archiveBtn.html('<i class="fas fa-trash"></i> Add All To Archive List');
                            }
                        });
                    }
                });
            }
        });
    });

</script>