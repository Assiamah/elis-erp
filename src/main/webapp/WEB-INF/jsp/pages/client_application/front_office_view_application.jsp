
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>


<div class="main-content app-content">
    <div class="container-fluid page-container">
	<!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-18 mb-0">Application Details</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Application Details</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->


        <div class="row">
            <!-- Main Content Column -->
            <div class="col-lg-8">
                <!-- Case Summary Card -->
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">
                            <i class="bi bi-file-text me-2"></i>Case Summary
                        </h5>
                        <button class="btn btn-sm btn-outline-secondary" type="button" data-bs-toggle="collapse" 
                                data-bs-target="#caseSummaryCollapse" aria-expanded="true">
                            <i class="bi bi-chevron-down"></i>
                        </button>
                    </div>
                    
                    <div class="collapse show" id="caseSummaryCollapse">
                        <div class="card-body">
                            <!-- Parcel Attributes Section -->
                            <div class="mb-4">
                                <h6 class="section-title">
                                    <i class="bi bi-geo-alt me-2"></i>Parcel Attributes
                                </h6>
                                <div class="row g-3">
                                    <input type="hidden" id="cs_main_business_process_id" value="${business_process_id}">
                                    <input type="hidden" id="cs_main_business_process_name" value="${business_process_name}">
                                    <input type="hidden" id="cs_main_business_process_sub_id" value="${business_process_sub_id}">
                                    <input type="hidden" id="cs_main_business_process_sub_name" value="${business_process_sub_name}">
                                    <input type="hidden" id="cs_main_client_number" value="${phone_number}">
                                    
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small mb-1">Date Created</label>
                                        <div class="info-badge">${created_date}</div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small mb-1">Last Modified</label>
                                        <div class="info-badge">${modified_date}</div>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Case Number</label>
                                        <div class="info-badge">${case_number}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Regional Number</label>
                                        <div class="info-badge">${regional_number}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Locality</label>
                                        <div class="info-badge">${locality}</div>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">District</label>
                                        <div class="info-badge">${district}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Region</label>
                                        <div class="info-badge">${region}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Land Size (Acres)</label>
                                        <div class="info-badge">${size_of_land}</div>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">GLPIN</label>
                                        <div class="info-badge">${glpin}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">New Transaction Ready</label>
                                        <div class="info-badge ${need_for_new_transaction == 'Yes' ? 'bg-success text-white' : ''}">
                                            ${need_for_new_transaction}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Transaction Details Section -->
                            <div>
                                <h6 class="section-title">
                                    <i class="bi bi-receipt me-2"></i>Transaction Details
                                </h6>
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Transaction Number</label>
                                        <div class="info-badge">${transaction_number}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Applicant Name</label>
                                        <div class="info-badge">${ar_name}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Nature of Instrument</label>
                                        <div class="info-badge">${nature_of_instrument}</div>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Document Date</label>
                                        <div class="info-badge">${date_of_document}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Registration Date</label>
                                        <div class="info-badge">${date_of_registration}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Type of Interest</label>
                                        <div class="info-badge">${type_of_interest}</div>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Type of Use</label>
                                        <div class="info-badge">${type_of_use}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Term</label>
                                        <div class="info-badge">${term}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Commencement Date</label>
                                        <div class="info-badge">${commencement_date}</div>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Assessed Value</label>
                                        <div class="info-badge">${assessed_value}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Stamp Duty Payable</label>
                                        <div class="info-badge">${stamp_duty_payable}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small mb-1">Certificate Number</label>
                                        <div class="info-badge">${certificate_number}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar Column -->
            <div class="col-lg-4">
                <!-- Accordion for Sidebar Sections -->
                <div class="accordion" id="sidebarAccordion">
                    <!-- Related Jobs -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseJobs" aria-expanded="true">
                                <i class="bi bi-briefcase me-2"></i>
                                Related Jobs
                            </button>
                        </h2>
                        <div id="collapseJobs" class="accordion-collapse collapse show" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div class="d-grid gap-2 mb-3">
                                    <button class="btn btn-primary d-flex align-items-center justify-content-center gap-2"
                                            data-bs-toggle="modal" data-bs-target="#addExtraBillModal">
                                        <i class="bi bi-plus-circle"></i>
                                        Add Extra Bill
                                    </button>
                                </div>
                                <!-- Jobs table can be added here if needed -->
                            </div>
                        </div>
                    </div>

                    <!-- Parties -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseParties">
                                <i class="bi bi-people me-2"></i>
                                Parties
                                <span class="badge bg-primary ms-2">${parties.size()}</span>
                            </button>
                        </h2>
                        <div id="collapseParties" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div class="table-responsive">
                                    <table class="table table-sm table-hover">
                                        <thead>
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
                                                    <td class="fw-medium">${parties_row.ar_name}</td>
                                                    <td>
                                                        <span class="badge bg-light text-dark">
                                                            ${parties_row.ar_gender}
                                                        </span>
                                                    </td>
                                                    <td>${parties_row.ar_cell_phone}</td>
                                                    <td>
                                                        <span class="badge bg-info">
                                                            ${parties_row.type_of_party}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bills & Payments -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseBills">
                                <i class="bi bi-cash-coin me-2"></i>
                                Bills & Payments
                            </button>
                        </h2>
                        <div id="collapseBills" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div class="table-responsive">
                                    <table class="table table-sm table-hover">
                                        <thead>
                                            <tr>
                                                <th>Action</th>
                                                <th>Mode</th>
                                                <th>Amount</th>
                                                <th>Receipt</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${payment_invoice}" var="payment_bill_row">
                                                <tr>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-primary"
                                                                data-bs-toggle="modal" data-bs-target="#viewBillModal"
                                                                data-egcr_id="${payment_bill_row.payment_slip_number}"
                                                                data-ref_number="${payment_bill_row.ref_number}">
                                                            <i class="bi bi-eye"></i>
                                                        </button>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-light text-dark">
                                                            ${payment_bill_row.payment_mode}
                                                        </span>
                                                    </td>
                                                    <td class="fw-medium">${payment_bill_row.bill_amount}</td>
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

                    <!-- Application Minutes -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseMinutes">
                                <i class="bi bi-journal-text me-2"></i>
                                Application Minutes
                            </button>
                        </h2>
                        <div id="collapseMinutes" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div class="table-responsive">
                                    <table class="table table-sm table-hover">
                                        <thead>
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
                                                        <button class="btn btn-sm btn-outline-info"
                                                                data-bs-toggle="modal" data-bs-target="#viewMinutesModal"
                                                                data-target-id="${application_munites_row.am_id}">
                                                            <i class="bi bi-eye"></i>
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

                    <!-- Documents -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseDocuments">
                                <i class="bi bi-files me-2"></i>
                                Application Documents
                            </button>
                        </h2>
                        <div id="collapseDocuments" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div class="d-flex gap-2 mb-3">
                                    <button class="btn btn-sm btn-outline-primary" id="btn_load_scanned_documents">
                                        <i class="bi bi-eye"></i> Load Docs
                                    </button>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-sm table-hover">
                                        <thead>
                                            <tr>
                                                <th>Document Name</th>
                                                <th>Type</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${casescanneddocuments}" var="casescanneddocuments_row">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center gap-2">
                                                            <div class="document-icon">
                                                                <i class="bi bi-file-earmark"></i>
                                                            </div>
                                                            <span>${casescanneddocuments_row.document_name}</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-light text-dark">
                                                            ${casescanneddocuments_row.document_type}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <form action="open_pdffile" method="post">
                                                            <input type="hidden" name="document_path" 
                                                                   value="${casescanneddocuments_row.document_file}">
                                                            <button type="submit" class="btn btn-sm btn-outline-primary">
                                                                <i class="bi bi-folder2-open"></i>
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
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapsePublicDocs">
                                <i class="bi bi-globe me-2"></i>
                                Public Documents
                            </button>
                        </h2>
                        <div id="collapsePublicDocs" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div class="d-flex gap-2 mb-3">
                                    <button class="btn btn-sm btn-outline-primary" id="btn_load_scanned_documents_public">
                                        <i class="bi bi-eye"></i> Load Docs
                                    </button>
                                    <button class="btn btn-sm btn-primary" id="btn_add_public_document"
                                            data-bs-toggle="modal" data-bs-target="#publicFileUploadModal">
                                        <i class="bi bi-plus"></i> Add
                                    </button>
                                </div>
                                <!-- Similar document table structure as above -->
                            </div>
                        </div>
                    </div>

                    <!-- Queries -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseQueries">
                                <i class="bi bi-question-circle me-2"></i>
                                Queries
                                <span class="badge bg-danger ms-2">${case_query.size()}</span>
                            </button>
                        </h2>
                        <div id="collapseQueries" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div class="table-responsive">
                                    <table class="table table-sm table-hover">
                                        <thead>
                                            <tr>
                                                <th>Job #</th>
                                                <th>Reason</th>
                                                <th>Date</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${case_query}" var="case_query_row">
                                                <tr>
                                                    <td class="fw-medium">${case_query_row.job_number}</td>
                                                    <td>${case_query_row.reasons}</td>
                                                    <td>${case_query_row.created_date}</td>
                                                    <td>
                                                        <span class="status-badge ${case_query_row.status == 1 ? 'bg-warning text-dark' : 'bg-success text-white'}">
                                                            ${case_query_row.status == 1 ? 'Pending' : 'Resolved'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <button class="btn btn-sm ${case_query_row.status == 1 ? 'btn-warning' : 'btn-outline-info'}"
                                                                data-bs-toggle="modal" data-bs-target="#newQueryModal"
                                                                data-action="${case_query_row.status == 1 ? 'edit' : 'view'}"
                                                                data-id="${case_query_row.qid}"
                                                                data-job_number="${case_query_row.job_number}"
                                                                data-reasons="${case_query_row.reasons}"
                                                                data-remarks="${case_query_row.remarks}"
                                                                data-status="${case_query_row.status}">
                                                            <i class="bi ${case_query_row.status == 1 ? 'bi-pencil' : 'bi-eye'}"></i>
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

</div>

<script>
    // Initialize tooltips
	document.addEventListener('DOMContentLoaded', function() {
		var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
		var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
			return new bootstrap.Tooltip(tooltipTriggerEl);
		});
		
		// Accordion state persistence
		const accordionItems = document.querySelectorAll('.accordion-item');
		accordionItems.forEach(item => {
			const button = item.querySelector('.accordion-button');
			button.addEventListener('click', function() {
				const targetId = this.getAttribute('data-bs-target');
				localStorage.setItem('activeAccordion', targetId);
			});
		});
		
		// Restore accordion state
		const activeAccordion = localStorage.getItem('activeAccordion');
		if (activeAccordion) {
			const activeButton = document.querySelector(`[data-bs-target="${activeAccordion}"]`);
			if (activeButton) {
				const bsCollapse = new bootstrap.Collapse(activeAccordion.replace('#', ''));
				bsCollapse.show();
			}
		}
	});
	
	// Query modal data population
	document.querySelectorAll('[data-bs-target="#newQueryModal"]').forEach(button => {
		button.addEventListener('click', function() {
			const modal = document.querySelector('#newQueryModal');
			const action = this.getAttribute('data-action');
			const isEdit = action === 'edit';
			
			// Populate modal fields
			modal.querySelector('#queryId').value = this.getAttribute('data-id');
			modal.querySelector('#jobNumber').value = this.getAttribute('data-job_number');
			modal.querySelector('#queryReasons').value = this.getAttribute('data-reasons');
			modal.querySelector('#queryRemarks').value = this.getAttribute('data-remarks');
			modal.querySelector('#queryStatus').value = this.getAttribute('data-status');
			
			// Set modal title and button text
			modal.querySelector('.modal-title').textContent = 
				isEdit ? 'Edit Query' : 'View Query';
			modal.querySelector('#saveQueryBtn').textContent = 
				isEdit ? 'Update Query' : 'Close';
			
			// Disable fields for view mode
			const inputs = modal.querySelectorAll('input, textarea, select');
			inputs.forEach(input => {
				input.disabled = !isEdit;
			});
		});
	});
</script>

