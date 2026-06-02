  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
  <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

  <div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Manual Payment Capturing</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Account Manual Payment Capturing</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Manual Payment Capturing</a></li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

    <div class="row g-4">
        <!-- Main Content - Left Column -->
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-primary bg-gradient text-white py-3">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-credit-card me-2"></i>Payment Entry System
                    </h5>
                </div>
                
                <div class="card-body p-4">
                    <!-- Payment Entry Section -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-light py-3 d-flex justify-content-between align-items-center">
                            <h6 class="card-title mb-0 fw-semibold">
                                <i class="fas fa-file-invoice-dollar me-2 text-primary"></i>
                                <span>Entry For Payment</span>
                                <span class="badge bg-info ms-2 fs-6">Step 1: Search Bill</span>
                            </h6>
                            <button class="btn btn-link p-0 text-decoration-none" 
                                    type="button" 
                                    data-bs-toggle="collapse" 
                                    data-bs-target="#paymentEntryCollapse"
                                    aria-expanded="false">
                                <i class="fas fa-chevron-down"></i>
                            </button>
                        </div>
                        
                        <div class="collapse show" id="paymentEntryCollapse">
                            <div class="card-body">
                                <!-- Search Form -->
                                <div class="row g-3 align-items-end mb-4">
                                    <div class="col-md-8">
                                        <label for="txt_ref_number_for_payment_mre" class="form-label fw-medium">
                                            <i class="fas fa-search me-2 text-muted"></i>Search by Reference Number
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light border-end-0">
                                                <i class="fas fa-hashtag text-muted"></i>
                                            </span>
                                            <input type="text" 
                                                   class="form-control border-start-0" 
                                                   id="txt_ref_number_for_payment_mre" 
                                                   name="txt_ref_number_for_payment_mre"
                                                   placeholder="Enter reference number..."
                                                   aria-describedby="refNumberHelp"
                                                   required>
                                        </div>
                                        <div id="refNumberHelp" class="form-text mt-2">
                                            <i class="fas fa-info-circle me-1 text-info"></i>
                                            Enter the bill reference number to search for pending payments
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-4 mb-4">
                                        <button class="btn btn-primary btn-lg w-100" id="btn_load_bill_details_after_payment_mre">
                                            <i class="fas fa-search me-2"></i>Search Bill
                                        </button>
                                    </div>
                                </div>

                                <!-- Search Results -->
                                <div class="mt-4">
                                    <h6 class="fw-semibold mb-3 border-bottom pb-2">
                                        <i class="fas fa-list-alt me-2 text-muted"></i>Pending Bills for Payment
                                    </h6>
                                    
                                    <div class="table-responsive">
                                        <table class="table table-hover table-striped align-middle" id="bill_for_payment_list_dataTable_mre">
                                            <thead class="table-light">
                                                <tr>
                                                    <th class="py-2">
                                                        <i class="fas fa-hashtag me-2 text-muted"></i>Reference No.
                                                    </th>
                                                    <th class="py-2">
                                                        <i class="fas fa-user me-2 text-muted"></i>Client Name
                                                    </th>
                                                    <th class="py-2">
                                                        <i class="fas fa-money-bill-wave me-2 text-muted"></i>Amount
                                                    </th>
                                                    <th class="py-2 text-end">
                                                        <i class="fas fa-credit-card me-2 text-muted"></i>Actions
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Bills will be populated here -->
                                                <tr id="noBillsFound" class="d-none">
                                                    <td colspan="4" class="text-center py-5">
                                                        <div class="text-muted">
                                                            <i class="fas fa-search fa-2x mb-3"></i>
                                                            <p class="mb-1 fw-medium">No pending bills found</p>
                                                            <p class="small mb-0">Search for bills using the reference number above</p>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr id="searchPlaceholder" class="d-none">
                                                    <td colspan="4" class="text-center py-5">
                                                        <div class="text-muted">
                                                            <i class="fas fa-file-invoice fa-2x mb-3"></i>
                                                            <p class="mb-1 fw-medium">Search for bills to display</p>
                                                            <p class="small mb-0">Enter a reference number and click "Search Bill"</p>
                                                        </div>
                                                    </td>
                                                </tr>
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

        <!-- Sidebar - Right Column -->
        <div class="col-lg-4">
            <!-- Instructions Card -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-light py-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title mb-0 fw-semibold">
                            <i class="fas fa-info-circle me-2 text-primary"></i>Payment Instructions
                        </h5>
                        <button class="btn btn-link p-0 text-decoration-none" 
                                type="button" 
                                data-bs-toggle="collapse" 
                                data-bs-target="#instructionsCollapse"
                                aria-expanded="true">
                            <i class="fas fa-chevron-down"></i>
                        </button>
                    </div>
                </div>
                
                <div class="collapse show" id="instructionsCollapse">
                    <div class="card-body">
                        <div class="alert alert-info border-0 bg-info bg-opacity-10 mb-4">
                            <div class="d-flex">
                                <i class="fas fa-lightbulb fa-2x text-info mt-1 me-3"></i>
                                <div>
                                    <h6 class="alert-heading mb-2">How to Process Payments</h6>
                                    <ol class="mb-0 ps-3">
                                        <li class="mb-2">Enter the bill reference number in the search field</li>
                                        <li class="mb-2">Click "Search Bill" to find the pending payment</li>
                                        <li class="mb-2">Verify the client and amount details</li>
                                        <li>Click "Pay Bill" to process the payment</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h6 class="fw-semibold mb-3">Payment Guidelines</h6>
                            <div class="list-group list-group-flush">
                                <div class="list-group-item border-0 px-0 py-2">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    <span class="small">Always verify the reference number before processing</span>
                                </div>
                                <div class="list-group-item border-0 px-0 py-2">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    <span class="small">Double-check payment amounts and client details</span>
                                </div>
                                <div class="list-group-item border-0 px-0 py-2">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    <span class="small">Generate receipts for all processed payments</span>
                                </div>
                                <div class="list-group-item border-0 px-0 py-2">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    <span class="small">Maintain accurate payment records for auditing</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card bg-light border-0">
                            <div class="card-body">
                                <h6 class="fw-semibold mb-3">Need Help?</h6>
                                <div class="d-grid gap-2">
                                    <button class="btn btn-outline-secondary btn-sm">
                                        <i class="fas fa-question-circle me-2"></i>View Payment FAQ
                                    </button>
                                    <button class="btn btn-outline-secondary btn-sm">
                                        <i class="fas fa-file-pdf me-2"></i>Download Payment Guide
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    
 </div>
</div>

<div class="modal fade effect-scale modal-blur" id="manualBillPayment" tabindex="-1" aria-labelledby="manualBillPaymentLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title fw-semibold" id="manualBillPaymentLabel">
                    <i class="fas fa-credit-card me-2"></i>Manual Receipt Entry
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4">
                <div class="row g-4">
                    <!-- Bill Information Section -->
                    <div class="col-md-6">
                        <div class="card border-0 shadow-sm h-100">
                            <div class="card-header bg-light py-3">
                                <h6 class="card-title mb-0 fw-medium">
                                    <i class="fas fa-file-invoice me-2 text-primary"></i>Bill Information
                                </h6>
                            </div>
                            <div class="card-body">
                                <!-- Bill Number -->
                                <div class="mb-3">
                                    <label for="mre_bill_number" class="form-label fw-medium small">
                                        <i class="fas fa-hashtag me-1 text-muted"></i>Bill Number
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="fas fa-file-invoice text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control border-start-0 bg-light" 
                                               id="mre_bill_number" readonly>
                                    </div>
                                </div>

                                <!-- Applicant Name -->
                                <div class="mb-3">
                                    <label for="mre_ar_name" class="form-label fw-medium small">
                                        <i class="fas fa-user me-1 text-muted"></i>Applicant Name
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="fas fa-user text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control border-start-0 bg-light" 
                                               id="mre_ar_name" readonly>
                                    </div>
                                </div>

                                <!-- Amount Due -->
                                <div class="mb-3">
                                    <label for="mre_amount_due" class="form-label fw-medium small">
                                        <i class="fas fa-money-bill-wave me-1 text-muted"></i>Amount Due
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="fas fa-money-bill-wave text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control border-start-0 bg-light fw-bold text-danger" 
                                               id="mre_amount_due" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Details Section -->
                    <div class="col-md-6">
                        <div class="card border-0 shadow-sm h-100">
                            <div class="card-header bg-light py-3">
                                <h6 class="card-title mb-0 fw-medium">
                                    <i class="fas fa-credit-card me-2 text-primary"></i>Payment Details
                                </h6>
                            </div>
                            <div class="card-body">
                                <!-- Amount Paid -->
                                <div class="mb-3">
                                    <label for="mre_amount_paid" class="form-label fw-medium small">
                                        <i class="fas fa-money-check-alt me-1 text-muted"></i>Amount Paid
                                        <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="fas fa-money-bill-wave text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control border-start-0" 
                                               id="mre_amount_paid" 
                                               placeholder="Enter amount paid"
                                               required>
                                    </div>
                                    <div class="form-text">Enter the actual amount received</div>
                                </div>

                                <!-- Receipt Number -->
                                <div class="mb-3">
                                    <label for="mre_receipt_number" class="form-label fw-medium small">
                                        <i class="fas fa-receipt me-1 text-muted"></i>Receipt Number
                                        <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="fas fa-hashtag text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control border-start-0" 
                                               id="mre_receipt_number" 
                                               placeholder="Enter receipt number"
                                               required>
                                    </div>
                                    <div class="form-text">Official receipt number from payment</div>
                                </div>

                                <!-- Payment Mode -->
                                <div class="mb-3">
                                    <label for="mre_payment_mode" class="form-label fw-medium small">
                                        <i class="fas fa-credit-card me-1 text-muted"></i>Payment Mode
                                        <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" id="mre_payment_mode" required>
                                        <option value="" disabled selected>Select payment mode...</option>
                                        <option value="Cash">Cash</option>
                                        <option value="Bank Advise(Swift)">Bank Advise (Swift)</option>
                                        <option value="Bank Draft">Bank Draft</option>
                                        <option value="Mobile Money">Mobile Money</option>
                                        <option value="Cheque">Cheque</option>
                                        <option value="Bank Transfer">Bank Transfer</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Information -->
                    <div class="col-12">
                        <div class="card border-0 shadow-sm">
                            <div class="card-header bg-light py-3">
                                <h6 class="card-title mb-0 fw-medium">
                                    <i class="fas fa-sticky-note me-2 text-primary"></i>Additional Information
                                </h6>
                            </div>
                            <div class="card-body">
                                <!-- Payment Remarks -->
                                <div class="mb-4">
                                    <label for="mre_payment_remarks" class="form-label fw-medium small">
                                        <i class="fas fa-comment-dots me-1 text-muted"></i>Payment Remarks
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="fas fa-edit text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control border-start-0" 
                                               id="mre_payment_remarks" 
                                               value="Full Payment"
                                               placeholder="Enter payment remarks">
                                    </div>
                                    <div class="form-text">Additional notes about this payment</div>
                                </div>

                                <!-- Document Preview -->
                                <div class="mb-3">
                                    <label class="form-label fw-medium small">
                                        <i class="fas fa-file-pdf me-1 text-muted"></i>Document Preview
                                    </label>
                                    <div class="card border">
                                        <div class="card-body p-0">
                                            <iframe src="" id="mreblobfile" width="100%" height="300" 
                                                    class="border-0" title="Document Preview"></iframe>
                                        </div>
                                        <div class="card-footer bg-light py-2">
                                            <small class="text-muted">
                                                <i class="fas fa-info-circle me-1"></i>
                                                Preview of attached document
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer border-top-0 bg-light p-4">
                <div class="d-flex justify-content-between w-100">
                    <!-- Left Side Actions -->
                    <div>
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Cancel
                        </button>
                    </div>
                    
                    <!-- Right Side Actions -->
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                            <i class="fas fa-times-circle me-2"></i>Close
                        </button>
                        
                        <button type="button" id="btn_mre_save_payment" class="btn btn-primary btn-lg px-4">
                            <i class="fas fa-save me-2"></i>Save Payment
                        </button>
                    </div>
                </div>
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
    padding: 1rem 0.75rem;
}

.input-group-text {
    background-color: #f8f9fa;
    border-color: #dee2e6;
    transition: all 0.3s ease;
}

.form-control:focus + .input-group-text {
    border-color: #86b7fe;
    background-color: #fff;
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
    border-radius: 8px;
}

.list-group-item:hover {
    background-color: #f8f9fa;
}

.badge {
    font-weight: 500;
    letter-spacing: 0.5px;
}

.collapsing {
    transition: height 0.35s ease;
}

/* Custom scrollbar for table */
.table-responsive {
    max-height: 400px;
    border-radius: 8px;
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
.btn-outline-primary:hover, .btn-outline-success:hover {
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

/* Progress bar styling */
.progress {
    border-radius: 10px;
    overflow: hidden;
}

.progress-bar {
    border-radius: 10px;
}

/* Payment status colors */
.text-amount {
    font-family: 'Courier New', monospace;
    font-weight: bold;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .btn-lg {
        padding: 0.5rem 1rem;
        font-size: 0.9rem;
    }
    
    .card-body {
        padding: 1rem !important;
    }
}
</style>

<script>
// Initialize tooltips and functionality
document.addEventListener('DOMContentLoaded', function() {
    // Initialize Bootstrap tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    // Collapse toggle with icon change
    const collapseElements = document.querySelectorAll('[data-bs-toggle="collapse"]');
    collapseElements.forEach(element => {
        element.addEventListener('click', function() {
            const icon = this.querySelector('i.fa-chevron-down, i.fa-chevron-up');
            if (icon) {
                icon.classList.toggle('fa-chevron-down');
                icon.classList.toggle('fa-chevron-up');
            }
        });
    });
    
    // // Search functionality
    // const searchBtn = document.getElementById('btn_load_bill_details_after_payment_mre');
    // const searchInput = document.getElementById('txt_ref_number_for_payment_mre');
    
    // if (searchBtn && searchInput) {
    //     // Enable search on Enter key
    //     searchInput.addEventListener('keypress', function(e) {
    //         if (e.key === 'Enter') {
    //             e.preventDefault();
    //             searchBtn.click();
    //         }
    //     });
        
    //     // Add loading state to search button
    //     searchBtn.addEventListener('click', function() {
    //         const refNumber = searchInput.value.trim();
            
    //         if (!refNumber) {
    //             showNotification('Please enter a reference number', 'warning');
    //             searchInput.focus();
    //             return;
    //         }
            
    //         const originalHTML = this.innerHTML;
    //         this.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Searching...';
    //         this.disabled = true;
            
    //         // Show placeholder rows
    //         const placeholder = document.getElementById('searchPlaceholder');
    //         const noResults = document.getElementById('noBillsFound');
            
    //         if (placeholder) placeholder.classList.add('d-none');
    //         if (noResults) noResults.classList.add('d-none');
            
    //         // Simulate API call (replace with actual AJAX call)
    //         setTimeout(() => {
    //             this.innerHTML = originalHTML;
    //             this.disabled = false;
                
    //             // Simulate search results (replace with actual response handling)
    //             const hasResults = Math.random() > 0.3; // Simulated response
                
    //             if (hasResults) {
    //                 // In real implementation, populate table with actual data
    //                 if (noResults) noResults.classList.add('d-none');
    //                 showNotification('Found 3 pending bills', 'success');
    //             } else {
    //                 if (noResults) noResults.classList.remove('d-none');
    //                 showNotification('No bills found for this reference number', 'info');
    //             }
    //         }, 1500);
    //     });
    // }
    
    // Payment processing simulation
    document.addEventListener('click', function(e) {
        if (e.target.closest('.process-payment-btn')) {
            const button = e.target.closest('.process-payment-btn');
            const refNumber = button.dataset.ref;
            const amount = button.dataset.amount;
            
            // Show confirmation modal or process directly
            if (confirm(`Process payment of ₵${amount} for reference ${refNumber}?`)) {
                const originalHTML = button.innerHTML;
                button.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Processing...';
                button.disabled = true;
                
                setTimeout(() => {
                    button.innerHTML = '<i class="fas fa-check me-2"></i>Paid';
                    button.classList.remove('btn-primary');
                    button.classList.add('btn-success');
                    showNotification(`Payment of ₵${amount} processed successfully`, 'success');
                }, 2000);
            }
        }
    });
    
    // Helper function for notifications
    function showNotification(message, type = 'info') {
        // You can integrate with Toastr or SweetAlert2 here
        alert(`${type.toUpperCase()}: ${message}`);
    }
    
    // Initialize empty table state
    const placeholder = document.getElementById('searchPlaceholder');
    if (placeholder) {
        placeholder.classList.remove('d-none');
    }

   
});
</script>
  
  

