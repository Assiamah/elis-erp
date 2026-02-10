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

<style>
.stat-card {
    transition: all 0.3s ease;
    border: 2px solid transparent;
    border-radius: 12px;
}

.stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
}

.stat-card.active-card {
    border-color: var(--active-border-color);
    background-color: var(--active-bg-color);
    box-shadow: 0 5px 15px var(--active-shadow-color);
}

.stat-card.active-card .icon-wrapper {
    background-color: var(--active-icon-bg) !important;
}

.stat-card.active-card .icon-wrapper i {
    color: var(--active-icon-color) !important;
}

.stat-card.active-card .badge {
    background-color: var(--active-badge-bg) !important;
    color: var(--active-badge-color) !important;
}

.stat-card.active-card h2 {
    color: var(--active-text-color) !important;
}

.stat-card.active-card .card-subtitle {
    color: var(--active-text-color) !important;
}

.stat-card.active-card .text-muted {
    color: var(--active-text-color) !important;
}

/* Color variables for different card types */
.stat-card[data-card-type="primary"] {
    --active-border-color: var(--primary-color);
    --active-bg-color: var(--primary-color);
    --active-shadow-color: rgba(21, 253, 13, 0.15);
    --active-icon-bg: white;
    --active-icon-color: var(--primary-color);
    --active-badge-bg: var(--primary-color);
    --active-badge-color: white;
    --active-text-color: white;
}

.stat-card[data-card-type="warning"] {
    --active-border-color: #ffc107;
    --active-bg-color: #ffc107;
    --active-shadow-color: rgba(255, 193, 7, 0.15);
    --active-icon-bg: white;
    --active-icon-color: #ffc107;
    --active-badge-bg: #ffc107;
    --active-badge-color: white;
    --active-text-color: white;
}

.stat-card[data-card-type="danger"] {
    --active-border-color: #dc3545;
    --active-bg-color: #dc3545;
    --active-shadow-color: rgba(220, 53, 69, 0.15);
    --active-icon-bg: white;
    --active-icon-color: #dc3545;
    --active-badge-bg: #dc3545;
    --active-badge-color: white;
    --active-text-color: white;
}

.stat-card[data-card-type="success"] {
    --active-border-color: #198754;
    --active-bg-color: #198754;
    --active-shadow-color: rgba(25, 135, 84, 0.15);
    --active-icon-bg: white;
    --active-icon-color: #198754;
    --active-badge-bg: #198754;
    --active-badge-color: white;
    --active-text-color: white;
}

.icon-wrapper {
    width: 60px;
    height: 60px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
}
</style>


<input type="text" name="regional_code" value="${sessionScope.regional_code}"  hidden/> 
				 
<!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Compliance Advisory Center</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Manage client tickets and monitor ticket status</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">CAC</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Tickets</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->
	
	
    
    <!-- Stats Cards Section -->
    <div class="row mb-5">
		<div class="col-12">
			<h2 class="h4 mb-4 text-dark fw-semibold">Ticket Dashboard</h2>
			<div class="row g-4">
				<!-- Open Tickets Card -->
				<div class="col-xl-3 col-md-6">
					<div class="card stat-card border-0 shadow-sm h-100 overflow-hidden active-card" style="cursor: pointer;" id="tickets_open" data-card-type="primary">
						<div class="card-body p-4">
							<div class="d-flex justify-content-between align-items-start">
								<div>
									<h6 class="card-subtitle text-muted mb-2">Tickets</h6>
									<h2 class="fw-bold text-primary mb-0" id="incoming_count">${open}</h2>
									<p class="text-muted small mb-0">Open</p>
								</div>
								<div class="icon-wrapper bg-primary bg-opacity-10 rounded-circle p-3">
									<i class="fas fa-folder-open fa-lg text-primary"></i>
								</div>
							</div>
							<div class="mt-3 pt-3 border-top">
								<span class="badge bg-primary bg-opacity-10 text-primary">
									<i class="fas fa-arrow-up me-1"></i> Current
								</span>
							</div>
						</div>
					</div>
				</div>

				<!-- Pending Tickets Card -->
				<div class="col-xl-3 col-md-6">
					<div class="card stat-card border-0 shadow-sm h-100 overflow-hidden" style="cursor: pointer;" id="tickets_pending" data-card-type="warning">
						<div class="card-body p-4">
							<div class="d-flex justify-content-between align-items-start">
								<div>
									<h6 class="card-subtitle text-muted mb-2">Tickets</h6>
									<h2 class="fw-bold text-warning mb-0" id="total_count">${pending}</h2>
									<p class="text-muted small mb-0">Pending</p>
								</div>
								<div class="icon-wrapper bg-warning bg-opacity-10 rounded-circle p-3">
									<i class="fas fa-clock fa-lg text-warning"></i>
								</div>
							</div>
							<div class="mt-3 pt-3 border-top">
								<span class="badge bg-warning bg-opacity-10 text-warning">
									<i class="fas fa-pause me-1"></i> Awaiting Response
								</span>
							</div>
						</div>
					</div>
				</div>

				<!-- Hold Tickets Card -->
				<div class="col-xl-3 col-md-6">
					<div class="card stat-card border-0 shadow-sm h-100 overflow-hidden" style="cursor: pointer;" id="tickets_hold" data-card-type="danger">
						<div class="card-body p-4">
							<div class="d-flex justify-content-between align-items-start">
								<div>
									<h6 class="card-subtitle text-muted mb-2">Tickets</h6>
									<h2 class="fw-bold text-danger mb-0" id="unit_count">${hold}</h2>
									<p class="text-muted small mb-0">On Hold</p>
								</div>
								<div class="icon-wrapper bg-danger bg-opacity-10 rounded-circle p-3">
									<i class="fas fa-hand-holding-heart fa-lg text-danger"></i>
								</div>
							</div>
							<div class="mt-3 pt-3 border-top">
								<span class="badge bg-danger bg-opacity-10 text-danger">
									<i class="fas fa-hand-paper me-1"></i> Blocked
								</span>
							</div>
						</div>
					</div>
				</div>

				<!-- Resolved Tickets Card -->
				<div class="col-xl-3 col-md-6">
					<div class="card stat-card border-0 shadow-sm h-100 overflow-hidden" style="cursor: pointer;" id="tickets_resolved" data-card-type="success">
						<div class="card-body p-4">
							<div class="d-flex justify-content-between align-items-start">
								<div>
									<h6 class="card-subtitle text-muted mb-2">Tickets</h6>
									<h2 class="fw-bold text-success mb-0">${resolved}</h2>
									<p class="text-muted small mb-0">Resolved</p>
								</div>
								<div class="icon-wrapper bg-success bg-opacity-10 rounded-circle p-3">
									<i class="fas fa-smile fa-lg text-success"></i>
								</div>
							</div>
							<div class="mt-3 pt-3 border-top">
								<span class="badge bg-success bg-opacity-10 text-success">
									<i class="fas fa-check me-1"></i> Completed
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

    <!-- Search Section -->
    <div class="row mb-5" id="archived_search">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-body p-4">
                    <h5 class="card-title mb-4">Search Tickets</h5>
                    
                    <div class="row align-items-end">
                        <div class="col-md-8">
                            <div class="mb-3">
                                <label class="form-label fw-medium">Search By</label>
                                <div class="d-flex flex-wrap gap-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="rbtn_search_type" id="rbtn_search_type1" value="client_name" checked>
                                        <label class="form-check-label" for="rbtn_search_type1">
                                            Client Name
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="rbtn_search_type" id="rbtn_search_type2" value="ticket_id">
                                        <label class="form-check-label" for="rbtn_search_type2">
                                            Ticket Number
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="rbtn_search_type" id="rbtn_search_type3" value="job_no">
                                        <label class="form-check-label" for="rbtn_search_type3">
                                            Job Number
                                        </label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="input-group">
                                <input type="text" class="form-control border-end-0" id="cc_search_value" placeholder="Enter search term..." aria-label="Search">
                                <button class="btn btn-outline-secondary border-start-0" type="button" id="clearSearch">
                                    <i class="fas fa-times"></i>
                                </button>
                                <button class="btn btn-primary" type="button" id="btnCCJobSearch">
                                    <i class="fas fa-search me-2"></i>Search
                                </button>
                            </div>
                        </div>
                        
                        <!-- <div class="col-md-4 text-md-end mt-3 mt-md-0">
                            <button class="btn btn-success" id="btnViewBatchlist">
                                <i class="fas fa-paper-plane me-2"></i>Forward Selected
                            </button>
                        </div> -->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Tickets Table Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header py-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <i class="ri-table-line me-2"></i>
                            <span class="h5 mb-0">Ticket Details</span>
                        </div>
                        <!-- <div class="dropdown">
                            <button class="btn btn-outline-light btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                <i class="fas fa-cog me-2"></i>Options
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="#"><i class="fas fa-download me-2"></i>Export</a></li>
                                <li><a class="dropdown-item" href="#"><i class="fas fa-filter me-2"></i>Filter</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#"><i class="fas fa-sync me-2"></i>Refresh</a></li>
                            </ul>
                        </div> -->
						<button class="btn btn-success" id="btnViewBatchlist">
							<i class="fas fa-paper-plane me-2"></i>Forward Selected
						</button>
                    </div>
                </div>
                
                <div class="card-body p-4">
                    <!-- Status Legend -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="d-flex flex-wrap gap-3 align-items-center">
                                <span class="text-muted small">Status Indicators:</span>
                                <span class="badge status-indicator bg-white text-dark border">
                                    <i class="fas fa-dot-circle me-1"></i>No Replies
                                </span>
                                <span class="badge status-indicator bg-info bg-opacity-10 text-info border border-info">
                                    <i class="fas fa-dot-circle me-1"></i>At CAC Center
                                </span>
                                <span class="badge status-indicator bg-warning bg-opacity-10 text-warning border border-warning">
                                    <i class="fas fa-dot-circle me-1"></i>At DCU
                                </span>
                                <span class="badge status-indicator bg-success bg-opacity-10 text-success border border-success">
                                    <i class="fas fa-dot-circle me-1"></i>Replied to Client
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Table -->
                    <div class="table-responsive">
                        <table class="table table-hover align-middle" id="table_list" style="width:100%">
                            <thead class="table-light">
                                <tr>
                                    <th width="50" class="ps-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="selectAll">
                                        </div>
                                    </th>
                                    <th>Ticket #</th>
                                    <th>Client</th>
                                    <th>Purpose</th>
                                    <th>Subject</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-center">Priority</th>
                                    <th>Division</th>
                                    <th>Reference #</th>
                                    <th>Created</th>
                                    <th class="text-end pe-3">Actions</th>
                                </tr>
                            </thead>
                            <tbody id="table_body">
                                <!-- Data will be populated here -->
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Table Footer -->
                    <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
                        <div class="text-muted small">
                            Showing <span id="rowCount">0</span> tickets
                        </div>
                        <nav aria-label="Page navigation">
                            <ul class="pagination pagination-sm mb-0">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">Previous</a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>




    

	</div>
</div>
<!-- End Page Content -->

<!-- Reply Modal -->
<div class="modal fade effect-scale modal-blur" id="replyModal" tabindex="-1" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Replies</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="replyForm">
                <div class="modal-body">
                    <div class="replies-container mb-4" id="all_replies"></div>
                    
                    <div class="mb-3">
                        <label for="reply_input" class="form-label">Reply</label>
                        <textarea class="form-control" id="reply_input" name="reply_input" rows="5" required></textarea>
                    </div>
                    
                    <input type="hidden" name="ticket_id" />
                    <input type="hidden" name="userid" value="${sessionScope.userid}" />
                    <input type="hidden" name="fullname" value="${sessionScope.fullname}" />
                    <input type="hidden" name="unit_name" value="${sessionScope.unit_name}" />
                    <input type="hidden" name="unit_id" value="${sessionScope.unit_id}" />
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success" id="reply_ticket">Reply</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Forward Batch Modal -->
<div class="modal fade effect-scale modal-blur" id="showBatchlist" tabindex="-1" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Forward Tickets</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="ft_division" class="form-label">Division <span class="text-danger">*</span></label>
                    </div>
                    <div class="col-md-8">
                        <select class="form-select" id="ft_division" name="ft_division" required>
                            <option value="" disabled selected>-- select --</option>
                            <option value="PVLMD">PVLMD</option>
                            <option value="LRD">LRD</option>
                            <option value="LVD">LVD</option>
                            <option value="SMD">SMD</option>
                            <option value="CORPORATE">CORPORATE</option>
                        </select>
                    </div>
                </div>
                
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="ft_region" class="form-label">Region <span class="text-danger">*</span></label>
                    </div>
                    <div class="col-md-8">
                        <select class="form-select" id="ft_region" name="ft_region" required>
                            <option value="" selected>-- select --</option>
                            <option value="11">Greater Accra</option>
                            <option value="14">Western</option>
                            <option value="19">Volta</option>
                            <option value="12">Eastern</option>
                            <option value="13">Ashanti</option>
                            <option value="15">Central</option>
                            <option value="18">Northern</option>
                            <option value="16">Upper East</option>
                            <option value="17">Upper West</option>
                            <option value="10">Tema</option>
                            <option value="22">Oti</option>
                            <option value="23">Bono East</option>
                            <option value="24">Ahafo</option>
                            <option value="20">Bono</option>
                            <option value="25">North East</option>
                            <option value="26">Savannah</option>
                            <option value="21">Western North</option>
                        </select>
                    </div>
                </div>
                
                <div class="card mt-4">
                    <div class="card-body">
                        <h6 class="card-title mb-3">Selected Tickets</h6>
                        <div id="batch_list"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btn_print">Forward</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Reply Client Modal -->
<div class="modal fade effect-scale modal-blur" id="replyClientModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Replies To Client</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="clientReplyForm">
                <div class="modal-body">
                    <div class="replies-container mb-4" id="all_client_replies"></div>
                    
                    <div class="mb-3">
                        <label for="reply_input_client" class="form-label">Message to Client</label>
                        <textarea class="form-control" id="reply_input_client" name="reply_input_client" rows="5" required></textarea>
                    </div>
                    
                    <input type="hidden" name="ticket_id_client" />
                    <input type="hidden" name="userid_client" value="${sessionScope.userid}" />
                    <input type="hidden" name="fullname_client" value="${sessionScope.fullname}" />
                    <input type="hidden" name="unit_name_client" value="${sessionScope.unit_name}" />
                    <input type="hidden" name="unit_id_client" value="${sessionScope.unit_id}" />
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success" id="client_reply_ticket">Send</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Forward Single Ticket Modal -->
<div class="modal fade effect-scale modal-blur" id="forwardModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Forward Ticket</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="forwardForm">
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="forward_ticket_id" class="form-label">Ticket No.</label>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="forward_ticket_id" name="forward_ticket_id" readonly>
                        </div>
                    </div>
                    
                    <hr>
                    
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="division" class="form-label">Division <span class="text-danger">*</span></label>
                        </div>
                        <div class="col-md-8">
                            <select class="form-select" id="division" name="division" required>
                                <option value="" disabled selected>-- select --</option>
                                <option value="PVLMD">PVLMD</option>
                                <option value="LRD">LRD</option>
                                <option value="LVD">LVD</option>
                                <option value="SMD">SMD</option>
                                <option value="CORPORATE">CORPORATE</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="region" class="form-label">Region <span class="text-danger">*</span></label>
                        </div>
                        <div class="col-md-8">
                            <select class="form-select" id="region" name="region" required>
                                <option value="" disabled selected>-- select --</option>
                                <option value="11">Greater Accra</option>
                                <option value="14">Western</option>
                                <option value="19">Volta</option>
                                <option value="12">Eastern</option>
                                <option value="13">Ashanti</option>
                                <option value="15">Central</option>
                                <option value="18">Northern</option>
                                <option value="16">Upper East</option>
                                <option value="17">Upper West</option>
                                <option value="10">Tema</option>
                                <option value="22">Oti</option>
                                <option value="23">Bono East</option>
                                <option value="24">Ahafo</option>
                                <option value="20">Bono</option>
                                <option value="25">North East</option>
                                <option value="26">Savannah</option>
                                <option value="21">Western North</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="unit" class="form-label">Unit <span class="text-danger">*</span></label>
                        </div>
                        <div class="col-md-8">
                            <input class="form-control" list="listofunits" id="unit" name="unit" 
                                   placeholder="Type to search units..." autocomplete="off" required>
                            <datalist id="listofunits"></datalist>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success" id="forward_ticket">Update</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Update Status Modal -->
<div class="modal fade effect-scale modal-blur" id="updateStatusModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Update Status</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="updateStatusForm">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="status_ticket_id" class="form-label">Ticket No.</label>
                        <input type="text" class="form-control" id="status_ticket_id" name="status_ticket_id" readonly>
                    </div>
                    
                    <div class="mb-3">
                        <label for="status_select" class="form-label">Status</label>
                        <select class="form-select" id="status_select" name="status_select" required>
                            <option value="" disabled selected>-- select --</option>
                            <option value="open">Open</option>
                            <option value="hold">Hold</option>
                            <option value="pending">Pending</option>
                            <option value="resolved">Resolved</option>
                        </select>
                    </div>
                    
                    <input type="hidden" name="userid_client" value="${sessionScope.userid}" />
                    <input type="hidden" name="fullname_client" value="${sessionScope.fullname}" />
                    <input type="hidden" name="unit_name_client" value="${sessionScope.unit_name}" />
                    <input type="hidden" name="unit_id_client" value="${sessionScope.unit_id}" />
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success" id="update_status">Update</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
	function deleteRow(r) {
	  var i = r.parentNode.parentNode.rowIndex;
	  document.getElementById("batchTable").deleteRow(i);
	}
</script>
