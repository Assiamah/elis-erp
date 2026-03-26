  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
  <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


  <!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Manual Bills</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Create and manage manual bills</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Manual Bills</a></li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

    <div class="row g-4">
        <!-- Main Content - Left Column -->
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-primary bg-gradient text-white py-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-file-invoice-dollar me-2"></i>Create Manual Bills
                        </h5>
                        <span class="badge bg-light text-primary">Step 1: Find Client</span>
                    </div>
                </div>
                
                <div class="card-body p-4">
                    <!-- Client Search Section -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-light py-3">
                            <h6 class="card-title mb-0">
                                <i class="fas fa-search me-2 text-primary"></i>Search for Clients
                            </h6>
                        </div>
                        
                        <div class="card-body">
                            <!-- Search Form -->
                            <div class="row g-3 align-items-end mb-4">
                                <div class="col-md-8">
                                    <label for="client_by_email_phone_search_mb" class="form-label fw-medium">
                                        <i class="fas fa-user-circle me-2 text-muted"></i>Client Search
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="fas fa-search text-muted"></i>
                                        </span>
                                        <input type="text" 
                                               class="form-control border-start-0" 
                                               id="client_by_email_phone_search_mb" 
                                               placeholder="Enter email, phone number, or job number...">
                                    </div>
                                    <div class="form-text mt-2">
                                        <i class="fas fa-info-circle me-1 text-info"></i>
                                        Search by any of the client's contact details
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <button class="btn btn-primary btn-lg w-100" id="btnFindClientDetailsManualBill">
                                        <i class="fas fa-search me-2"></i>Search
                                    </button>
                                </div>
                            </div>

                            <!-- Search Results Table -->
                            <div class="table-responsive">
                                <table class="table table-hover table-striped table-sm align-middle" id="clientsearchlistManualBills_dataTable">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="py-2">
                                                <i class="fas fa-user me-2 text-muted"></i>Name
                                            </th>
                                            <th class="py-2">
                                                <i class="fas fa-envelope me-2 text-muted"></i>Email
                                            </th>
                                            <th class="py-2">
                                                <i class="fas fa-user-tag me-2 text-muted"></i>Account Type
                                            </th>
                                            <th class="py-2">
                                                <i class="fas fa-phone me-2 text-muted"></i>Phone
                                            </th>
                                            <th class="py-2">
                                                <i class="fas fa-map-marker-alt me-2 text-muted"></i>Address
                                            </th>
                                            <th class="py-2 text-center">
                                                <i class="fas fa-file-invoice me-2 text-muted"></i>Action
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Search results will be populated here -->
                                        <tr id="noResultsRow" class="d-none">
                                            <td colspan="6" class="text-center py-5">
                                                <div class="text-muted">
                                                    <i class="fas fa-search fa-2x mb-3"></i>
                                                    <p class="mb-0">No clients found. Try a different search term.</p>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="card border-primary border-2 h-100">
                                <div class="card-body text-center">
                                    <div class="mb-3">
                                        <i class="fas fa-user-plus fa-2x text-primary"></i>
                                    </div>
                                    <h6 class="card-title mb-3">Add New Client</h6>
                                    <p class="card-text text-muted small mb-3">
                                        Can't find the client? Add a new client to the system.
                                    </p>
                                    <button class="btn btn-outline-primary w-100" id="btnAddNewUser" data-bs-toggle="modal" data-bs-target="#createUserModal">
                                        <i class="fas fa-plus me-2"></i>Add New Client
                                    </button>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="card border-success border-2 h-100">
                                <div class="card-body text-center">
                                    <div class="mb-3">
                                        <i class="fas fa-file-invoice fa-2x text-success"></i>
                                    </div>
                                    <h6 class="card-title mb-3">Create Manual Bill</h6>
                                    <p class="card-text text-muted small mb-3">
                                        Create a custom bill without searching for a client.
                                    </p>
                                    <button class="btn btn-outline-success w-100" id="btnAddNewManualBill" data-bs-toggle="modal" data-bs-target="#generateManualBillModal">
                                        <i class="fas fa-plus me-2"></i>Create Manual Bill
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sidebar - Right Column -->
        <div class="col-lg-4">
            <!-- Instructions Card -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-light py-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-info-circle me-2 text-primary"></i>Instructions
                        </h5>
                        <button class="btn btn-link p-0 text-decoration-none" 
                                type="button" 
                                data-bs-toggle="collapse" 
                                data-bs-target="#instructionsCollapse">
                            <i class="fas fa-chevron-down"></i>
                        </button>
                    </div>
                </div>
                
                <div class="collapse show" id="instructionsCollapse">
                    <div class="card-body">
                        <div class="alert alert-info border-0 bg-info bg-opacity-10">
                            <div class="d-flex">
                                <i class="fas fa-lightbulb fa-2x text-info mt-1 me-3"></i>
                                <div>
                                    <h6 class="alert-heading mb-2">How to Create a Manual Bill</h6>
                                    <ol class="mb-0 ps-3">
                                        <li class="mb-2">Search for an existing client using their email, phone, or job number</li>
                                        <li class="mb-2">Select the client from the search results</li>
                                        <li class="mb-2">Click "Create New Bill" to generate a manual invoice</li>
                                        <li>Fill in the bill details and submit</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mt-3">
                            <h6 class="fw-semibold mb-3">Quick Tips</h6>
                            <div class="list-group list-group-flush">
                                <div class="list-group-item border-0 px-0 py-2">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    <span class="small">Ensure client information is up-to-date</span>
                                </div>
                                <div class="list-group-item border-0 px-0 py-2">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    <span class="small">Double-check bill amounts before submission</span>
                                </div>
                                <div class="list-group-item border-0 px-0 py-2">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    <span class="small">Save draft bills for future reference</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Reports Card -->
            <!-- <div class="card border-0 shadow-sm">
                <div class="card-header bg-light py-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-chart-bar me-2 text-primary"></i>Reports & Analytics
                        </h5>
                        <button class="btn btn-link p-0 text-decoration-none" 
                                type="button" 
                                data-bs-toggle="collapse" 
                                data-bs-target="#reportsCollapse">
                            <i class="fas fa-chevron-down"></i>
                        </button>
                    </div>
                </div>
                
                <div class="collapse" id="reportsCollapse">
                    <div class="card-body">
                        <div class="mb-4">
                            <h6 class="fw-semibold mb-3">Quick Reports</h6>
                            <div class="row g-2">
                                <div class="col-6">
                                    <button class="btn btn-outline-primary w-100 btn-sm">
                                        <i class="fas fa-file-pdf me-1"></i>Daily Bills
                                    </button>
                                </div>
                                <div class="col-6">
                                    <button class="btn btn-outline-primary w-100 btn-sm">
                                        <i class="fas fa-file-excel me-1"></i>Monthly Summary
                                    </button>
                                </div>
                            </div>
                        </div>
                        
                        <div>
                            <h6 class="fw-semibold mb-3">Statistics</h6>
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="small text-muted">Today's Bills</span>
                                <span class="badge bg-primary rounded-pill">12</span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="small text-muted">This Month</span>
                                <span class="badge bg-success rounded-pill">247</span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="small text-muted">Pending Bills</span>
                                <span class="badge bg-warning rounded-pill">8</span>
                            </div>
                        </div>
                        
                        <hr class="my-3">
                        
                        <div class="text-center">
                            <button class="btn btn-outline-secondary btn-sm">
                                <i class="fas fa-cog me-2"></i>Report Settings
                            </button>
                        </div>
                    </div>
                </div>
            </div> -->

            <!-- Recent Activity -->
            <!-- <div class="card border-0 shadow-sm mt-4">
                <div class="card-header bg-light py-3">
                    <h6 class="card-title mb-0">
                        <i class="fas fa-history me-2 text-primary"></i>Recent Activity
                    </h6>
                </div>
                <div class="card-body">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item border-0 px-0 py-2">
                            <div class="d-flex w-100 justify-content-between">
                                <span class="small">Bill #INV-2023-001</span>
                                <span class="small text-muted">2 min ago</span>
                            </div>
                            <span class="small text-muted">John Doe - ₵1,500.00</span>
                        </div>
                        <div class="list-group-item border-0 px-0 py-2">
                            <div class="d-flex w-100 justify-content-between">
                                <span class="small">Bill #INV-2023-002</span>
                                <span class="small text-muted">15 min ago</span>
                            </div>
                            <span class="small text-muted">Jane Smith - ₵2,300.00</span>
                        </div>
                        <div class="list-group-item border-0 px-0 py-2">
                            <div class="d-flex w-100 justify-content-between">
                                <span class="small">Bill #INV-2023-003</span>
                                <span class="small text-muted">1 hour ago</span>
                            </div>
                            <span class="small text-muted">Acme Corp - ₵5,600.00</span>
                        </div>
                    </div>
                </div>
            </div> -->
        </div>
    </div>


      
       
	</div>
</div>

<style>
/* Custom Styles */
.card {
    border-radius: 12px;
    border: 1px solid #e9ecef;
    transition: all 0.3s ease;
}

.card:hover {
    box-shadow: 0 5px 20px rgba(0,0,0,0.08) !important;
}

.card-header {
    border-radius: 12px 12px 0 0 !important;
    border-bottom: 1px solid #e9ecef;
}

.table th {
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.8rem;
    letter-spacing: 0.5px;
    color: #6c757d;
}

.table td {
    vertical-align: middle;
    padding: 0.75rem 0.5rem;
}

.input-group-text {
    background-color: #f8f9fa;
    border-color: #dee2e6;
}

.btn {
    border-radius: 8px;
    font-weight: 500;
    transition: all 0.3s ease;
}

.btn-lg {
    padding: 0.75rem 1.5rem;
}

.list-group-item {
    transition: background-color 0.3s ease;
}

.list-group-item:hover {
    background-color: #f8f9fa;
}

.badge {
    font-weight: 500;
    padding: 0.35em 0.65em;
}

.collapsing {
    transition: height 0.35s ease;
}

/* Custom scrollbar for table */
.table-responsive {
    max-height: 400px;
}

.table-responsive::-webkit-scrollbar {
    width: 6px;
    height: 6px;
}

.table-responsive::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
}

.table-responsive::-webkit-scrollbar-thumb {
    background: #c1c1c1;
    border-radius: 10px;
}

.table-responsive::-webkit-scrollbar-thumb:hover {
    background: #a8a8a8;
}

/* Animation for search button */
@keyframes pulse {
    0% {
        box-shadow: 0 0 0 0 rgba(13, 110, 253, 0.4);
    }
    70% {
        box-shadow: 0 0 0 10px rgba(13, 110, 253, 0);
    }
    100% {
        box-shadow: 0 0 0 0 rgba(13, 110, 253, 0);
    }
}

.btn-primary {
    animation: pulse 2s infinite;
}

/* Hover effects */
.btn-outline-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(13, 110, 253, 0.2);
}

.card.border-primary:hover {
    border-color: #0d6efd !important;
    transform: translateY(-2px);
}

.card.border-success:hover {
    border-color: #198754 !important;
    transform: translateY(-2px);
}
</style>

<script>
// Initialize tooltips
document.addEventListener('DOMContentLoaded', function() {
    // Tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    // Collapse functionality
    const collapseElements = document.querySelectorAll('[data-bs-toggle="collapse"]');
    collapseElements.forEach(element => {
        element.addEventListener('click', function() {
            const icon = this.querySelector('i.fa-chevron-down, i.fa-chevron-up');
            if (icon) {
                if (icon.classList.contains('fa-chevron-down')) {
                    icon.classList.replace('fa-chevron-down', 'fa-chevron-up');
                } else {
                    icon.classList.replace('fa-chevron-up', 'fa-chevron-down');
                }
            }
        });
    });
    
    // Search button functionality
    const searchBtn = document.getElementById('btnFindClientDetailsManualBill');
    const searchInput = document.getElementById('client_by_email_phone_search_mb');
    
    if (searchBtn && searchInput) {
        // Enable search on Enter key
        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                searchBtn.click();
            }
        });
        
        // Add loading state to search button
        searchBtn.addEventListener('click', function() {
            const originalHTML = this.innerHTML;
            this.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Searching...';
            this.disabled = true;
            
            // Simulate search delay (replace with actual search logic)
            setTimeout(() => {
                this.innerHTML = originalHTML;
                this.disabled = false;
                
                // Show/hide no results row based on actual search results
                const noResultsRow = document.getElementById('noResultsRow');
                if (noResultsRow) {
                    // Replace this with actual search result logic
                    const hasResults = true; // This should come from your actual search
                    if (hasResults) {
                        noResultsRow.classList.add('d-none');
                    } else {
                        noResultsRow.classList.remove('d-none');
                    }
                }
            }, 1500);
        });
    }
});
</script>