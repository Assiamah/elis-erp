<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../includes/_header.jsp"></jsp:include>

<style>
    /* Modern UI Styles */
    :root {
        --primary-color: #3498db;
        --secondary-color: #2c3e50;
        --accent-color: #e74c3c;
        --light-gray: #f8f9fa;
        --dark-gray: #343a40;
        --success-color: #28a745;
        --warning-color: #ffc107;
        --info-color: #17a2b8;
    }
    
    .card {
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        border: none;
        margin-bottom: 20px;
    }
    
    .card-header {
        background-color: var(--secondary-color);
        color: white;
        border-radius: 8px 8px 0 0 !important;
        padding: 15px 20px;
    }
    
    .card-header h5 {
        font-weight: 600;
        margin-bottom: 0;
    }
    
    .card-header a {
        color: white;
        text-decoration: none;
    }
    
    .card-body {
        padding: 20px;
    }
    
    .badge {
        font-weight: 500;
        padding: 5px 10px;
        border-radius: 4px;
    }
    
    .form-control:read-only {
        background-color: #f8f9fa;
    }
    
    .table {
        font-size: 14px;
    }
    
    .table th {
        background-color: var(--light-gray);
        font-weight: 600;
    }
    
    .btn-icon-split {
        padding: 8px 12px;
    }
    
    .section-title {
        font-size: 1.2rem;
        color: var(--secondary-color);
        margin-bottom: 15px;
        font-weight: 600;
        border-bottom: 2px solid var(--light-gray);
        padding-bottom: 8px;
    }
    
    .case-header {
        background-color: var(--secondary-color);
        color: white;
        padding: 15px;
        border-radius: 8px;
        margin-bottom: 20px;
    }
    
    .case-header h4 {
        margin-bottom: 0;
    }
    
    .accordion-toggle::after {
        font-family: 'Font Awesome 5 Free';
        content: '\f078';
        float: right;
        transition: transform 0.3s;
    }
    
    .accordion-toggle.collapsed::after {
        content: '\f054';
    }
    
    .status-badge {
        font-size: 12px;
        padding: 4px 8px;
        border-radius: 12px;
    }
    
    .action-buttons .btn {
        margin-right: 5px;
        margin-bottom: 5px;
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .card-body {
            padding: 15px;
        }
        
        .form-row > div {
            margin-bottom: 15px;
        }
    }
</style>

<div class="container-fluid">
    <!-- Breadcrumbs-->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="index.jsp">Application Processing</a></li>
        <li class="breadcrumb-item active">Case Details</li>
    </ol>

    <div class="row">
        <div class="col-lg-8">
            <!-- Main Case Card -->
            <div class="card">
                <div class="card-header bg-info d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">
                        <i class="fas fa-file-alt mr-2"></i>${case_number} - ${ar_name}
                    </h6>
                    <button type="button" onclick="javascript:history.go(-1)"
                        class="btn btn-light btn-icon-split">
                        <span class="icon text-dark"> 
                            <i class="fas fa-arrow-left"></i>
                        </span>
                        <span class="text">Back</span>
                    </button>
                </div>
                
                <div class="card-body">
                    <!-- Case Summary Section -->
                    <div class="card mb-4">
                        <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapsemaincase">
                            <h5 class="mb-0">
                                <i class="fas fa-file-alt mr-2"></i>Case Summary
                            </h5>
                        </div>
                        <div id="collapsemaincase" class="collapse show">
                            <div class="card-body">
                                <input type="hidden" id="cs_main_business_process_id" value="${business_process_id}">
                                <input type="hidden" id="cs_main_business_process_name" value="${business_process_name}">
                                <input type="hidden" id="cs_main_business_process_sub_id" value="${business_process_sub_id}">
                                <input type="hidden" id="cs_main_business_process_sub_name" value="${business_process_sub_name}">
                                <input type="hidden" id="cs_main_client_number" value="${phone_number}">
                                
                                <div class="section-title">Parcel Information</div>
                                <div class="form-row">
                                    <div class="col-md-6">
                                        <label>Date Created</label>
                                        <input readonly class="form-control" type="text" value="${created_date}">       
                                    </div>
                                    <div class="col-md-6">
                                        <label>Last Modified Date</label>
                                        <input readonly class="form-control" type="text" value="${modified_date}">
                                    </div>             
                                </div>
                                
                                <div class="form-row mt-3">
                                    <div class="col-md-4">
                                        <label>Case Number</label>
                                        <input readonly class="form-control" id="cs_main_case_number" value="${case_number}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>Regional Number</label>
                                        <input readonly class="form-control" type="text" value="${regional_number}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>Locality</label>
                                        <input readonly class="form-control" value="${locality}">
                                    </div>
                                </div>
                                
                                <div class="form-row mt-3">
                                    <div class="col-md-4">
                                        <label>District</label>
                                        <input readonly class="form-control" value="${district}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>Region</label>
                                        <input readonly class="form-control" value="${region}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>Size of Land (Acres)</label>
                                        <input readonly class="form-control" value="${size_of_land}">
                                    </div>
                                </div>
                                
                                <div class="form-row mt-3">
                                    <div class="col-md-4">
                                        <label>GLPIN</label>
                                        <input readonly class="form-control" value="${glpin}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>New Transaction Ready</label>
                                        <input readonly class="form-control" value="${need_for_new_transaction}">
                                    </div>
                                </div>
                                
                                <div class="section-title mt-4">Transaction Details</div>
                                <div class="form-row">
                                    <div class="col-md-4">
                                        <label>Transaction Number</label>
                                        <input readonly class="form-control" value="${transaction_number}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>Applicant Name</label>
                                        <input readonly class="form-control" value="${ar_name}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>Nature of Instrument</label>
                                        <input readonly class="form-control" value="${nature_of_instrument}">
                                    </div>
                                </div>
                                
                                <div class="form-row mt-3">
                                    <div class="col-md-4">
                                        <label>Date of Document</label>
                                        <input readonly class="form-control" value="${date_of_document}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>Date of Registration</label>
                                        <input readonly class="form-control" value="${date_of_registration}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>Type of Interest</label>
                                        <input readonly class="form-control" value="${type_of_interest}">
                                    </div>
                                </div>
                                
                                <div class="form-row mt-3">
                                    <div class="col-md-4">
                                        <label>Type of Use</label>
                                        <input readonly class="form-control" value="${type_of_use}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>Term</label>
                                        <input readonly class="form-control" value="${term}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>Commencement Date</label>
                                        <input readonly class="form-control" value="${commencement_date}">
                                    </div>
                                </div>
                                
                                <div class="form-row mt-3">
                                    <div class="col-md-4">
                                        <label>Assessed Value</label>
                                        <input readonly class="form-control" value="${assessed_value}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>Stamp Duty Payable</label>
                                        <input readonly class="form-control" value="${stamp_duty_payable}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>Certificate Number</label>
                                        <input readonly class="form-control" value="${certificate_number}">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Sidebar -->
        <div class="col-lg-4">
            <div id="accordion">
                <!-- Related Jobs -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapsejobs">
                        <h5 class="mb-0">
                            <i class="fas fa-tasks mr-2"></i>Related Jobs
                        </h5>
                    </div>
                    <div id="collapsejobs" class="collapse show">
                        <div class="card-body">
                            <div class="action-buttons mb-3">
                                <button class="btn btn-primary btn-icon-split" data-toggle="modal" data-target="#addNewserviceBillModalonCase">
                                    <span class="icon text-white-50">
                                        <i class="fas fa-plus"></i>
                                    </span>
                                    <span class="text">Add Extra Bill</span>
                                </button>
                            </div>
                            <!-- Jobs table would go here -->
                        </div>
                    </div>
                </div>

                <!-- Parties Involved -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapseparties">
                        <h5 class="mb-0">
                            <i class="fas fa-users mr-2"></i>Parties Involved
                        </h5>
                    </div>
                    <div id="collapseparties" class="collapse">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Name</th>
                                            <th>Gender</th>
                                            <th>Contact</th>
                                            <th>Role</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${parties}" var="parties_row">
                                            <tr>
                                                <td>${parties_row.ar_name}</td>
                                                <td>${parties_row.ar_gender}</td>
                                                <td>${parties_row.ar_cell_phone}</td>
                                                <td>${parties_row.type_of_party}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bills and Payments -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapsebills">
                        <h5 class="mb-0">
                            <i class="fas fa-receipt mr-2"></i>Bills & Payments
                        </h5>
                    </div>
                    <div id="collapsebills" class="collapse">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Action</th>
                                            <th>Payment Mode</th>
                                            <th>Amount</th>
                                            <th>Receipt #</th>
                                            <th>Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${payment_invoice}" var="payment_bill_row">
                                            <tr>
                                                <td>
                                                    <button class="btn btn-sm btn-success" 
                                                        data-toggle="modal" 
                                                        data-target="#viewBillModal"
                                                        data-egcr_id="${payment_bill_row.payment_slip_number}"
                                                        data-ref_number="${payment_bill_row.ref_number}">
                                                        View
                                                    </button>
                                                </td>
                                                <td>${payment_bill_row.payment_mode}</td>
                                                <td>${payment_bill_row.bill_amount}</td>
                                                <td>${payment_bill_row.payment_slip_number}</td>
                                                <td>${payment_bill_row.payment_date}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Case Minutes -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapseminutes">
                        <h5 class="mb-0">
                            <i class="fas fa-clipboard-list mr-2"></i>Case Minutes
                        </h5>
                    </div>
                    <div id="collapseminutes" class="collapse">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Description</th>
                                            <th>From</th>
                                            <th>To</th>
                                            <th>Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${application_munites}" var="application_munites_row">
                                            <tr>
                                                <td>${application_munites_row.am_description}</td>
                                                <td>${application_munites_row.ar_name}</td>
                                                <td>${application_munites_row.am_to_officer}</td>
                                                <td>${application_munites_row.am_activity_date}</td>
                                                <td>
                                                    <button class="btn btn-sm btn-info" 
                                                        data-toggle="modal"
                                                        data-target="#addMinutesModal"
                                                        data-target-id="${application_munites_row.am_id}">
                                                        <i class="fas fa-eye"></i> View
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

                <!-- Case Documents -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapsedocs">
                        <h5 class="mb-0">
                            <i class="fas fa-file-contract mr-2"></i>Case Documents
                        </h5>
                    </div>
                    <div id="collapsedocs" class="collapse">
                        <div class="card-body">
                            <div class="action-buttons mb-3">
                                <button class="btn btn-primary btn-sm mr-2" id="btn_load_scanned_documents">
                                    <i class="fas fa-sync-alt mr-1"></i> Refresh
                                </button>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Document Name</th>
                                            <th>Type</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${casescanneddocuments}" var="casescanneddocuments_row">
                                            <tr>
                                                <td>${casescanneddocuments_row.document_name}</td>
                                                <td>${casescanneddocuments_row.document_type}</td>
                                                <td>
                                                    <form action="open_pdffile" method="post">
                                                        <input type="hidden" name="document_path" value="${casescanneddocuments_row.document_file}">
                                                        <button type="submit" class="btn btn-sm btn-success">
                                                            <i class="fas fa-file-download mr-1"></i> Download
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Public Documents -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapsepudocs">
                        <h5 class="mb-0">
                            <i class="fas fa-file-alt mr-2"></i>Public Documents
                        </h5>
                    </div>
                    <div id="collapsepudocs" class="collapse">
                        <div class="card-body">
                            <div class="action-buttons mb-3">
                                <button class="btn btn-primary btn-sm mr-2" id="btn_load_scanned_documents_public">
                                    <i class="fas fa-sync-alt mr-1"></i> Refresh
                                </button>
                                <button class="btn btn-success btn-sm" id="btn_add_public_document" data-toggle="modal" data-target="#publicFileUploadModal">
                                    <i class="fas fa-plus mr-1"></i> Add Document
                                </button>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Document Name</th>
                                            <th>Type</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_row">
                                            <tr>
                                                <td>${casescanneddocuments_row.document_name}</td>
                                                <td>${casescanneddocuments_row.document_type}</td>
                                                <td>
                                                    <form action="registration_application_progress_details" method="post">
                                                        <input type="hidden" name="document_path" value="${casescanneddocuments_row.document_file}">
                                                        <button type="submit" class="btn btn-sm btn-success">
                                                            <i class="fas fa-file-download mr-1"></i> Download
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Case Queries -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapsequeries">
                        <h5 class="mb-0">
                            <i class="fas fa-question-circle mr-2"></i>Case Queries
                        </h5>
                    </div>
                    <div id="collapsequeries" class="collapse">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Job #</th>
                                            <th>Reasons</th>
                                            <th>Remarks</th>
                                            <th>Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${case_query}" var="case_query_row">
                                            <tr>
                                                <td>${case_query_row.job_number}</td>
                                                <td>${case_query_row.reasons}</td>
                                                <td>${case_query_row.remarks}</td>
                                                <td>${case_query_row.created_date}</td>
                                                <td>
                                                    <button class="btn btn-sm ${case_query_row.status == 1 ? 'btn-warning' : 'btn-info'}" 
                                                        data-toggle="modal" 
                                                        data-target="#newQueryModal"
                                                        data-id="${case_query_row.qid}"
                                                        data-job_number="${case_query_row.am_description}"
                                                        data-reasons="${case_query_row.reasons}"
                                                        data-remarks="${case_query_row.remarks}"
                                                        data-status="${case_query_row.status}">
                                                        ${case_query_row.status == 1 ? '<i class="fas fa-edit mr-1"></i> Edit' : '<i class="fas fa-eye mr-1"></i> View'}
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
</div>

<jsp:include page="../includes/_footer.jsp"></jsp:include>