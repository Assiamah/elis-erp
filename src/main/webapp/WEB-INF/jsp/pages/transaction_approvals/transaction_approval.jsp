<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


    <style>
        .table-responsive {
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.075);
        }
        
        .table thead th {
            background-color: #0d6efd;
            color: white;
            border-bottom: none;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }
        
        .table tbody tr:hover {
            background-color: rgba(13, 110, 253, 0.05);
            transition: background-color 0.2s ease;
        }
        
        .red-alert-row {
            background-color: #f8d7da !important;
            color: #842029 !important;
        }
        
        .red-alert-row:hover {
            background-color: #f5c6cb !important;
        }
        
        .tooltip-inner {
            max-width: 300px;
        }
        
        .card-header {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            padding: 1rem 1.5rem;
        }
        
        .card-header h5 {
            font-weight: 600;
            letter-spacing: 0.3px;
        }
        
        .badge-status {
            font-size: 0.75rem;
            padding: 0.35rem 0.75rem;
        }
        
        .breadcrumb {
            background: transparent;
            padding: 0.75rem 0;
        }
        
        .breadcrumb-item a {
            text-decoration: none;
            color: #0d6efd;
            font-weight: 500;
        }
        
        .breadcrumb-item a:hover {
            color: #0a58ca;
            text-decoration: underline;
        }
        
        .breadcrumb-item.active {
            color: #6c757d;
            font-weight: 500;
        }
        
        .table-actions .btn {
            border-radius: 0.375rem;
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
        }
        
        .table-actions .btn i {
            margin-right: 0.25rem;
        }
        
        .dataTables_wrapper .dataTables_filter input {
            border-radius: 0.375rem;
            border: 1px solid #ced4da;
            padding: 0.375rem 0.75rem;
        }
        
        .dataTables_wrapper .dataTables_filter input:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        
        .dataTables_wrapper .dataTables_length select {
            border-radius: 0.375rem;
            border: 1px solid #ced4da;
            padding: 0.375rem 0.75rem;
        }
        
        .page-item.active .page-link {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }
        
        .page-link {
            color: #0d6efd;
        }
        
        .page-link:hover {
            color: #0a58ca;
        }
        
        @media (max-width: 768px) {
            .table-responsive {
                border-radius: 0.25rem;
            }
            
            .table thead th {
                font-size: 0.75rem;
                white-space: nowrap;
            }
            
            .table tbody td {
                font-size: 0.875rem;
            }
        }
    </style>
</head>
<body>
    <div class="main-content app-content">
        <div class="container-fluid page-container">
            <!-- Breadcrumbs -->
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="#"><i class="fas fa-check-double me-1"></i>Transaction Approval Management</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">
                        <i class="fas fa-user me-1"></i>All Transaction Approval by ${fullname}
                    </li>
                </ol>
            </nav>

            <!-- Statistics Cards Row -->
            <div class="row g-4 mb-4">
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-primary text-white shadow h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small text-uppercase fw-bold text-white-50">Total Transactions</div>
                                    <div class="h3 fw-bold mt-2">${fn:length(transactionlist)}</div>
                                </div>
                                <div class="bg-white bg-opacity-25 rounded-circle p-3">
                                    <i class="fas fa-exchange-alt fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6">
                    <div class="card bg-warning text-dark shadow h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small text-uppercase fw-bold text-dark">Pending Approval</div>
                                  
                                </div>
                                <div class="bg-white bg-opacity-25 rounded-circle p-3">
                                    <i class="fas fa-clock fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6">
                    <div class="card bg-success text-white shadow h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small text-uppercase fw-bold text-white-50">Approved</div>
                                   
                                </div>
                                <div class="bg-white bg-opacity-25 rounded-circle p-3">
                                    <i class="fas fa-check-circle fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6">
                    <div class="card bg-danger text-white shadow h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small text-uppercase fw-bold text-white-50">Rejected</div>
                                  
                                </div>
                                <div class="bg-white bg-opacity-25 rounded-circle p-3">
                                    <i class="fas fa-times-circle fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Table Section -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="card mb-4 shadow-sm">
                        <div class="card-header text-white">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">
                                    <i class="fas fa-list me-2"></i>Transaction Approval List
                                </h5>
                                <div>
                                    <span class="badge bg-light text-dark me-2">
                                        <i class="fas fa-file me-1"></i>Total: ${fn:length(transactionlist)}
                                    </span>
                                    <button class="btn btn-light btn-sm" onclick="window.location.reload()">
                                        <i class="fas fa-sync-alt"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover display" id="transactionDataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Job Number</th>
                                            <th>Application Type</th>
                                            <th>Transaction Details</th>
                                            <!-- <th>Status</th> -->
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${transactionlist}" var="appfiles">
                                            <tr class="${appfiles.objections > 0 ? 'red-alert-row' : ''}"
                                                ${appfiles.objections > 0 ? "data-bs-toggle='tooltip' title='Application has pending Objections'" : ""}>
                                                
                                                <td>
                                                    <span class="badge bg-secondary">${appfiles.job_number}</span>
                                                </td>
                                                
                                                <td>
                                                    <span class="badge bg-info">${appfiles.business_process_sub_name}</span>
                                                </td>
                                                
                                                <td data-bs-toggle="tooltip" data-bs-placement="top" 
                                                    title="${fn:length(appfiles.transaction_details) > 50 ? appfiles.transaction_details : ''}">
                                                    ${fn:substring(appfiles.transaction_details, 0, 50)}
                                                    ${fn:length(appfiles.transaction_details) > 50 ? "..." : ""}
                                                </td>
                                                
                                                <td class="table-actions">
                                                    <button class="btn btn-success btn-sm approve-btn"
                                                            data-job_number="${appfiles.job_number}"
                                                            data-case_number="${appfiles.case_number}"
                                                            data-ta_id="${appfiles.ta_id}"
                                                            data-type_of_transaction="${appfiles.type_of_transaction}"
                                                            data-transaction_details="${appfiles.transaction_details}"
                                                            data-approval_status="${appfiles.approval_status}"
                                                            data-business_process_name="${appfiles.business_process_name}"
                                                            data-business_process_sub_name="${appfiles.business_process_sub_name}"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#final_registration_approval_dialog"
                                                            title="Approve Transaction">
                                                        <i class="fas fa-check-circle me-1"></i>Approve
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Initialize DataTable
            $('#transactionDataTable').DataTable({
                pageLength: 10,
                lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
                responsive: true,
                order: [[0, 'desc']],
                columnDefs: [
                    { orderable: false, targets: [4] } // Disable sorting on Action column
                ],
                language: {
                    search: "<i class='fas fa-search me-1'></i>Search:",
                    searchPlaceholder: "Search transactions...",
                    lengthMenu: "Show _MENU_ entries",
                    info: "Showing _START_ to _END_ of _TOTAL_ transactions",
                    infoEmpty: "No transactions available",
                    infoFiltered: "(filtered from _MAX_ total transactions)",
                    zeroRecords: "No matching transactions found"
                }
            });

            // Initialize tooltips
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });

            // Approve button click handler
            $('.approve-btn').on('click', function() {
                var jobNumber = $(this).data('job_number');
                var caseNumber = $(this).data('case_number');
                var taId = $(this).data('ta_id');
                var transactionDetails = $(this).data('transaction_details');
                var approvalStatus = $(this).data('approval_status');
                
                console.log('Approving transaction:', {
                    jobNumber: jobNumber,
                    caseNumber: caseNumber,
                    taId: taId,
                    transactionDetails: transactionDetails,
                    approvalStatus: approvalStatus
                });
            });

            // Add any additional custom functionality here
            console.log('Transaction Approval Management page loaded successfully.');
        });
    </script>
