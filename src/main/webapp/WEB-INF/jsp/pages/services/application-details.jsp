<style>
    :root {
        --primary: #435ebe;
        --primary-light: #eef2ff;
        --secondary: #6c757d;
        --success: #198754;
        --warning: #ffc107;
        --danger: #dc3545;
        --info: #0dcaf0;
        --light: #f8f9fa;
        --dark: #212529;
        --card-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        --gradient-primary: linear-gradient(120deg, var(--primary), #6278df);
    }
    
    .app-wrapper {
        padding: 20px 0;
    }
    
    .workspace-header {
        /* background: var(--pe-card-color); */
        border-radius: 16px;
        padding: 20px;
        box-shadow: var(--card-shadow);
        margin-bottom: 25px;
    }
    
    .card {
        border: none;
        border-radius: 16px;
        box-shadow: var(--card-shadow);
        margin-bottom: 25px;
    }
    
    .card-header {
        background-color: #fff;
        border-bottom: 1px solid #eaeaea;
        padding: 20px 25px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .card-title {
        font-weight: 600;
        margin-bottom: 0;
        color: var(--dark);
    }
    
    .info-card {
        background-color: white;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
    }
    
    .info-card-header {
        font-weight: 600;
        color: var(--primary);
        margin-bottom: 15px;
        padding-bottom: 10px;
        border-bottom: 1px solid #eaeaea;
        display: flex;
        align-items: center;
    }
    
    .info-card-header i {
        margin-right: 10px;
    }
    
    .info-item {
        display: flex;
        margin-bottom: 12px;
    }
    
    .info-label {
        font-weight: 600;
        min-width: 150px;
        color: #495057;
    }
    
    .info-value {
        color: #6c757d;
    }
    
    .badge {
        padding: 8px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
    }
    
    .tracking-timeline {
        position: relative;
        padding-left: 30px;
        margin: 20px 0;
    }
    
    .timeline-progress {
        position: absolute;
        left: 11px;
        top: 10px;
        bottom: 1px;
        width: 4px;
        height: 930px;
        background-color: #e9ecef;
        border-radius: 2px;
        overflow: hidden;
    }
    
    .progress-bar {
        background: var(--gradient-primary);
        width: 100%;
        border-radius: 2px;
        transition: height 0.5s ease;
    }
    
    .timeline-item {
        position: relative;
        margin-bottom: 25px;
    }
    
    .timeline-item:last-child {
        margin-bottom: 0;
    }
    
    .timeline-icon {
        position: absolute;
        left: -30px;
        top: 0;
        width: 26px;
        height: 26px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: white;
        border: 2px solid #e9ecef;
        z-index: 2;
    }
    
    .timeline-item.completed .timeline-icon {
        background-color: var(--success);
        border-color: var(--success);
        color: white;
    }
    
    .timeline-item.active .timeline-icon {
        background-color: var(--primary);
        border-color: var(--primary);
        color: white;
    }
    
    .timeline-content {
        background-color: #f8f9fa;
        border-radius: 10px;
        padding: 15px;
        border-left: 3px solid #e9ecef;
    }
    
    .timeline-item.completed .timeline-content {
        border-left-color: var(--success);
    }
    
    .timeline-item.active .timeline-content {
        border-left-color: var(--primary);
    }
    
    .timeline-title {
        font-weight: 600;
        margin-bottom: 5px;
        color: var(--dark);
    }
    
    .timeline-item.completed .timeline-title {
        color: var(--success);
    }
    
    .timeline-item.active .timeline-title {
        color: var(--primary);
    }
    
    .timeline-date {
        font-size: 12px;
        color: var(--secondary);
        margin-bottom: 8px;
    }
    
    .timeline-description {
        font-size: 14px;
        color: var(--secondary);
        margin-bottom: 0;
    }
    
    .action-buttons {
        display: flex;
        gap: 10px;
        margin-top: 20px;
    }
    
    /* .btn {
        border-radius: 10px;
        padding: 10px 20px;
        font-weight: 500;
        transition: all 0.3s ease;
    } */
    
    .btn-primary {
        background: var(--gradient-primary);
        border: none;
    }
    
    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(67, 94, 190, 0.3);
    }
    
    .btn-success {
        background: linear-gradient(120deg, var(--success), #20c374);
        border: none;
    }
    
    .btn-danger {
        background: linear-gradient(120deg, var(--danger), #e35d6a);
        border: none;
    }
    
    .btn-warning {
        background: linear-gradient(120deg, var(--warning), #ffd54f);
        border: none;
        color: #212529;
    }
    
    .document-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .document-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 15px;
        border-bottom: 1px solid #eaeaea;
    }
    
    .document-item:last-child {
        border-bottom: none;
    }
    
    .document-info {
        display: flex;
        align-items: center;
    }
    
    .document-icon {
        width: 40px;
        height: 40px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: var(--primary-light);
        color: var(--primary);
        margin-right: 15px;
    }
    
    .document-name {
        font-weight: 500;
    }
    
    .document-size {
        font-size: 12px;
        color: var(--secondary);
    }
    
    .comments-section {
        margin-top: 25px;
    }
    
    .comment {
        padding: 15px;
        border-radius: 12px;
        background-color: #f8f9fa;
        margin-bottom: 15px;
    }
    
    .comment-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }
    
    .comment-author {
        font-weight: 600;
        color: var(--primary);
    }
    
    .comment-date {
        font-size: 12px;
        color: var(--secondary);
    }
    
    .comment-text {
        margin-bottom: 0;
        color: #495057;
    }
    
    .application-status {
        display: inline-flex;
        align-items: center;
        padding: 8px 16px;
        border-radius: 20px;
        font-weight: 600;
        background-color: var(--primary-light);
        color: var(--primary);
    }
    
    .status-indicator {
        width: 10px;
        height: 10px;
        border-radius: 50%;
        margin-right: 8px;
    }
    
    .status-pending {
        background-color: var(--warning);
    }
    
    .status-approved {
        background-color: var(--success);
    }
    
    .status-rejected {
        background-color: var(--danger);
    }
    
    .status-review {
        background-color: var(--info);
    }
    
    .map-container {
        height: 300px;
        border-radius: 12px;
        overflow: hidden;
        /* background-color: #eaeaea; */
        /* display: flex;
        align-items: center;
        justify-content: center;
        color: var(--secondary); */
    }
    
    .workspace-actions {
        display: flex;
        gap: 10px;
        margin-bottom: 20px;
    }
    
    @media (max-width: 768px) {
        .info-item {
            flex-direction: column;
            margin-bottom: 15px;
        }
        
        .info-label {
            min-width: auto;
            margin-bottom: 5px;
        }
        
        .action-buttons {
            flex-wrap: wrap;
        }
        
        .btn {
            flex: 1;
            min-width: 120px;
        }
    }

    .step-title {
        font-weight: 600;
        color: var(--dark);
        margin-bottom: 5px;
    }
    
    .step-description {
        color: var(--secondary);
        margin-bottom: 25px;
    }
    
    .checklist-card {
        border-left: 4px solid var(--primary);
        transition: all 0.3s ease;
        margin-bottom: 15px;
    }
    
    .checklist-card.completed {
        border-left-color: var(--success);
        opacity: 0.8;
    }
    
    .checklist-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }
    
    .checklist-title {
        font-weight: 600;
        color: var(--dark);
        margin-bottom: 0;
    }
    
    .checklist-items {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .checklist-item {
        display: flex;
        align-items: center;
        padding: 10px 15px;
        border-bottom: 1px solid #eaeaea;
    }
    
    .checklist-item:last-child {
        border-bottom: none;
    }
    
    .form-check-input {
        margin-right: 12px;
    }
    
    .form-check-label {
        color: #495057;
    }
    
    .checklist-item.completed .form-check-label {
        text-decoration: line-through;
        color: var(--secondary);
    }

    .reservation-badge {
            position: absolute;
            top: 10px;
            right: 10px;
        }
        
        .alert {
            border-radius: 12px;
            border: none;
        }
        
        .document-preview {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #f8f9fa;
        }
        
        .verification-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            margin-right: 8px;
            margin-bottom: 8px;
        }
        
        .badge-verified {
            background-color: #d4edda;
            color: #155724;
        }
        
        .badge-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        
        .document-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .document-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 15px;
            border-bottom: 1px solid #eaeaea;
        }
        
        .document-item:last-child {
            border-bottom: none;
        }
        
        .document-info {
            display: flex;
            align-items: center;
        }
        
        .document-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--primary-light);
            color: var(--primary);
            margin-right: 15px;
        }
        
        .document-name {
            font-weight: 500;
        }
        
        .document-size {
            font-size: 12px;
            color: var(--secondary);
        }
        
        @media (max-width: 768px) {
            .nav-pills {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .nav-item {
                margin-bottom: 15px;
                flex: 0 0 33.333%;
            }
            
            .progress {
                display: none;
            }
            
            .action-buttons {
                flex-wrap: wrap;
            }
            
            .btn {
                flex: 1;
                min-width: 120px;
            }
        }
</style>

<main class="app-wrapper">
    <div class="container-fluid">
        <!-- Workspace Header -->
        <div class="card workspace-header">
            <div class="d-flex justify-content-between align-items-center flex-wrap">
                <div>
                    <h2 class="mb-1">Lease Application Workspace</h2>
                    <p class="text-muted mb-0">Manage and review lease applications</p>
                </div>
                <div class="application-status">
                    <span class="status-indicator status-review"></span>
                    Under Review
                </div>
            </div>
            
            <div class="workspace-actions mt-3">
                <!-- <button class="btn btn-primary">
                    <i class="ri-save-line me-2"></i>Save Changes
                </button> -->
                <button class="btn btn-success">
                    <i class="ri-check-line me-2"></i>Approve Application
                </button>
                <button class="btn btn-warning">
                    <i class="ri-chat-forward-line me-2"></i>Request Information
                </button>
                <button class="btn btn-danger">
                    <i class="ri-close-line me-2"></i>Reject Application
                </button>
            </div>
        </div>
        
        <div class="row">
            <!-- Left Column - Application Details -->
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-body">
                        <div class="accordion accordion-with-plus accordion-with-left-icon" id="demo_accordion_main_07">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#demo_accordion_item_71" aria-expanded="true" aria-controls="demo_accordion_item_71">
                                        Application Information
                                    </button>
                                </h2>
                                <div id="demo_accordion_item_71" class="accordion-collapse collapse" data-bs-parent="#demo_accordion_main_07">
                                    <div class="accordion-body">
                                        <div class="info-card">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="info-item">
                                                        <span class="info-label">Application ID:</span>
                                                        <span class="info-value">LA-1025</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Submitted Date:</span>
                                                        <span class="info-value">September 18, 2023</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Current Status:</span>
                                                        <span class="info-value"><span class="badge bg-info">Under Review</span></span>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="info-item">
                                                        <span class="info-label">Last Updated:</span>
                                                        <span class="info-value">September 25, 2023</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Assigned To:</span>
                                                        <span class="info-value">John Doe (Zoning Department)</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Priority:</span>
                                                        <span class="info-value"><span class="badge bg-warning">Medium</span></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#demo_accordion_item_72" aria-expanded="false" aria-controls="demo_accordion_item_72">
                                        Applicant Information
                                    </button>
                                </h2>
                                <div id="demo_accordion_item_72" class="accordion-collapse collapse" data-bs-parent="#demo_accordion_main_07">
                                    <div class="accordion-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="info-card">
                                                    <div class="info-card-header">
                                                        <i class="ri-user-line"></i> Personal Details
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Full Name:</span>
                                                        <span class="info-value">Emmanuel Oppong</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Email:</span>
                                                        <span class="info-value">emma.oppong@smarterem.com</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Phone:</span>
                                                        <span class="info-value">+233 5467900123</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Date of Birth:</span>
                                                        <span class="info-value">March 31, 1990</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="info-card">
                                                    <div class="info-card-header">
                                                        <i class="ri-map-pin-line"></i> Address Details
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Address:</span>
                                                        <span class="info-value">P. O. Box 5623, Accra</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">City:</span>
                                                        <span class="info-value">Accra</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Country:</span>
                                                        <span class="info-value">Ghana</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Postal Code:</span>
                                                        <span class="info-value">00233</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#demo_accordion_item_73" aria-expanded="false" aria-controls="demo_accordion_item_73">
                                        Parcel Information
                                    </button>
                                </h2>
                                <div id="demo_accordion_item_73" class="accordion-collapse show collapse" data-bs-parent="#demo_accordion_main_07">
                                    <div class="accordion-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="info-card">
                                                    <div class="info-card-header">
                                                        <i class="ri-map-2-line"></i> Parcel Details
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Parcel ID:</span>
                                                        <span class="info-value">R3013</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Land Use:</span>
                                                        <span class="info-value">Residential</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Size:</span>
                                                        <span class="info-value">0.161 acres</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Location:</span>
                                                        <span class="info-value">East Region, Block R</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="info-card">
                                                    <div class="info-card-header">
                                                        <i class="ri-information-line"></i> Additional Details
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Zoning Type:</span>
                                                        <span class="info-value">Residential R2</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Current Owner:</span>
                                                        <span class="info-value">Ghana Lands Commission</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Allocation Status:</span>
                                                        <span class="info-value">Available</span>
                                                    </div>
                                                    <div class="info-item">
                                                        <span class="info-label">Survey Number:</span>
                                                        <span class="info-value">GH-ACC-2023-3013</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="map-container mt-4">
                                            <div id="map"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Registration Process</h5>
                    </div>
                    <div class="card-body">
                        <p class="text-muted mb-5">Create a basic date picker by initializing Flatpickr with
                            <code>flatpickr("#basic-picker")</code> to allow users to select a single date from a
                            calendar.
                        </p><br>

                        <div class="stepper-container">
                            <form action="#" class="form-steps" autocomplete="off" id="leaseForm">
                                <div class="custom-stepper">
                                    <div class="progress progress-xs">
                                        <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
                                    </div>

                                    <ul class="nav nav-pills mb-5" role="tablist">
                                        <li class="nav-item" role="presentation">
                                            <button class="nav-link rounded-circle p-0 avatar-md completed" type="button" data-bs-target="#step1" data-bs-toggle="tab">1</button>
                                            <!-- <div class="step-label">Application Review</div> -->
                                        </li>
                                        <li class="nav-item" role="presentation">
                                            <button class="nav-link rounded-circle p-0 avatar-md completed" type="button" data-bs-target="#step2" data-bs-toggle="tab">2</button>
                                            <!-- <div class="step-label">Payment Verification</div> -->
                                        </li>
                                        <li class="nav-item" role="presentation">
                                            <button class="nav-link rounded-circle p-0 avatar-md active" type="button" data-bs-target="#step3" data-bs-toggle="tab">3</button>
                                            <!-- <div class="step-label">Title Plan</div> -->
                                        </li>
                                        <li class="nav-item" role="presentation">
                                            <button class="nav-link rounded-circle p-0 avatar-md" type="button" data-bs-target="#step4" data-bs-toggle="tab">4</button>
                                            <!-- <div class="step-label">Lease Document</div> -->
                                        </li>
                                        <li class="nav-item" role="presentation">
                                            <button class="nav-link rounded-circle p-0 avatar-md" type="button" data-bs-target="#step5" data-bs-toggle="tab">5</button>
                                            <!-- <div class="step-label">Finalize</div> -->
                                        </li>
                                        <li class="nav-item" role="presentation">
                                            <button class="nav-link rounded-circle p-0 avatar-md" type="button" data-bs-target="#step6" data-bs-toggle="tab">6</button>
                                            <!-- <div class="step-label">Collection</div> -->
                                        </li>
                                    </ul>
                                </div>

                                <div class="tab-content">
                                    <!-- Step 1: Application Review -->
                                    <div class="tab-pane fade" id="step1">
                                        <h4 class="step-title">Application Review</h4>
                                        <p class="step-description">Documents and application details reviewed for completeness and accuracy.</p>
                                        
                                        <div class="alert alert-info d-flex align-items-center">
                                            <i class="ri-information-line me-2"></i>
                                            <span>This step has been completed. Documents were verified by Michael Chen on Sept 20, 2023.</span>
                                        </div>
                                        
                                        <div class="card checklist-card completed">
                                            <div class="card-body">
                                                <div class="checklist-header">
                                                    <h5 class="checklist-title">Check/Review Documents</h5>
                                                    <span class="badge bg-success">Completed</span>
                                                </div>
                                                <ul class="checklist-items">
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Verify application form completeness</label>
                                                    </li>
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Check all required signatures</label>
                                                    </li>
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Validate supporting documents</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <div class="card checklist-card completed">
                                            <div class="card-body">
                                                <div class="checklist-header">
                                                    <h5 class="checklist-title">Check/Review Applications</h5>
                                                    <span class="badge bg-success">Completed</span>
                                                </div>
                                                <ul class="checklist-items">
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Verify applicant eligibility</label>
                                                    </li>
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Check compliance with regulations</label>
                                                    </li>
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Confirm property details accuracy</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <div class="action-buttons">
                                            <button type="button" class="btn btn-primary nexttab" data-next="2">Save Changes</button>
                                        </div>
                                    </div>

                                    <!-- Step 2: Verification of Payment & Application Process -->
                                    <div class="tab-pane fade" id="step2">
                                        <h4 class="step-title">Verification of Payment & Application Process</h4>
                                        <p class="step-description">Payments verified, parties added/updated, details entered, and OTP approval requested.</p>
                                        
                                        <div class="alert alert-info d-flex align-items-center">
                                            <i class="ri-information-line me-2"></i>
                                            <span>This step has been completed. Payment was verified by Sarah Johnson on Sept 25, 2023.</span>
                                        </div>
                                        
                                        <div class="card checklist-card completed">
                                            <div class="card-body">
                                                <div class="checklist-header">
                                                    <h5 class="checklist-title">Check for Payments</h5>
                                                    <span class="badge bg-success">Completed</span>
                                                </div>
                                                <ul class="checklist-items">
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Verify payment receipt</label>
                                                    </li>
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Confirm payment amount</label>
                                                    </li>
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Record payment details</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <div class="card checklist-card completed">
                                            <div class="card-body">
                                                <div class="checklist-header">
                                                    <h5 class="checklist-title">Add/Edit Parties</h5>
                                                    <span class="badge bg-success">Completed</span>
                                                </div>
                                                <ul class="checklist-items">
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Add primary applicant</label>
                                                    </li>
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Add co-applicants if any</label>
                                                    </li>
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Verify party identification</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <div class="card checklist-card completed">
                                            <div class="card-body">
                                                <div class="checklist-header">
                                                    <h5 class="checklist-title">Further Entry (Enter Details)</h5>
                                                    <span class="badge bg-success">Completed</span>
                                                </div>
                                                <ul class="checklist-items">
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Enter property details</label>
                                                    </li>
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Input lease terms</label>
                                                    </li>
                                                    <li class="checklist-item completed">
                                                        <input class="form-check-input" type="checkbox" checked disabled>
                                                        <label class="form-check-label">Record special conditions</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <div class="action-buttons">
                                            <!-- <button type="button" class="btn btn-outline-secondary previestab" data-prev="1">Previous</button>
                                            <button type="button" class="btn btn-primary nexttab" data-next="3">Next Step</button> -->
                                            <button type="button" class="btn btn-primary nexttab" data-next="2">Save Changes</button>
                                        </div>
                                    </div>

                                    <!-- Step 3: Preparation of Title Plan -->
                                    <div class="tab-pane fade show active" id="step3">
                                        <h4 class="step-title">Preparation of Title Plan</h4>
                                        <p class="step-description">Title plan generation in progress, awaiting zoning compliance verification.</p>
                                        
                                        <div class="alert alert-warning">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <i class="ri-alert-line me-2"></i>
                                                    <span>This step is currently assigned to you. Please complete the required actions.</span>
                                                </div>
                                                <span class="badge bg-warning">Reserved for you</span>
                                            </div>
                                        </div>
                                        
                                        <div class="card checklist-card">
                                            <div class="card-body">
                                                <div class="checklist-header">
                                                    <h5 class="checklist-title">Generate Title Plan</h5>
                                                    <span class="badge bg-warning">In Progress</span>
                                                </div>
                                                <ul class="checklist-items">
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" id="check1">
                                                        <label class="form-check-label" for="check1">Create preliminary title plan</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" id="check2">
                                                        <label class="form-check-label" for="check2">Verify zoning compliance</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" id="check3">
                                                        <label class="form-check-label" for="check3">Confirm boundary accuracy</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" id="check4">
                                                        <label class="form-check-label" for="check4">Add survey references</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" id="check5">
                                                        <label class="form-check-label" for="check5">Finalize title plan document</label>
                                                    </li>
                                                </ul>
                                                
                                                <div class="mt-3">
                                                    <label class="form-label">Upload Title Plan Document</label>
                                                    <input type="file" class="form-control" accept=".pdf,.doc,.docx">
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="action-buttons">
                                            <!-- <button type="button" class="btn btn-outline-secondary previestab" data-prev="2">Previous</button>
                                            <button type="button" class="btn btn-success" id="completeStep3">Complete Step</button> -->
                                            <button type="button" class="btn btn-primary nexttab" data-next="2">Save Changes</button>
                                        </div>
                                    </div>

                                    <!-- Step 4: Preparation of Lease Document -->
                                    <div class="tab-pane fade" id="step4">
                                        <h4 class="step-title">Preparation of Lease Document</h4>
                                        <p class="step-description">Lease document generation pending, subject to environmental impact assessment.</p>
                                        
                                        <div class="alert alert-secondary">
                                            <i class="ri-time-line me-2"></i>
                                            <span>This step is not yet available. It will become accessible after the previous step is completed.</span>
                                        </div>
                                        
                                        <div class="card checklist-card">
                                            <div class="card-body">
                                                <div class="checklist-header">
                                                    <h5 class="checklist-title">Generate Lease</h5>
                                                    <span class="badge bg-secondary">Pending</span>
                                                </div>
                                                <ul class="checklist-items">
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Prepare lease agreement draft</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Include all terms and conditions</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Add special clauses if needed</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Verify legal compliance</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Finalize lease document</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <div class="action-buttons">
                                            <!-- <button type="button" class="btn btn-outline-secondary previestab" data-prev="3">Previous</button>
                                            <button type="button" class="btn btn-primary nexttab" data-next="5" disabled>Next Step</button> -->
                                            <button type="button" class="btn btn-primary nexttab" data-next="2">Save Changes</button>
                                        </div>
                                    </div>

                                    <!-- Step 5: Finalise Transaction -->
                                    <div class="tab-pane fade" id="step5">
                                        <h4 class="step-title">Finalise Transaction</h4>
                                        <p class="step-description">Review and confirm parcel/transaction details, preview title plan, and lease before sign-off.</p>
                                        
                                        <div class="alert alert-secondary">
                                            <i class="ri-time-line me-2"></i>
                                            <span>This step is not yet available. It will become accessible after the previous step is completed.</span>
                                        </div>
                                        
                                        <div class="card checklist-card">
                                            <div class="card-body">
                                                <div class="checklist-header">
                                                    <h5 class="checklist-title">View and Confirm Parcel and Transaction</h5>
                                                    <span class="badge bg-secondary">Pending</span>
                                                </div>
                                                <ul class="checklist-items">
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Verify parcel details</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Confirm transaction amounts</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Validate parties information</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <div class="card checklist-card">
                                            <div class="card-body">
                                                <div class="checklist-header">
                                                    <h5 class="checklist-title">Preview Title Plan</h5>
                                                    <span class="badge bg-secondary">Pending</span>
                                                </div>
                                                <ul class="checklist-items">
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Review title plan accuracy</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Confirm boundaries and measurements</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <div class="card checklist-card">
                                            <div class="card-body">
                                                <div class="checklist-header">
                                                    <h5 class="checklist-title">Preview Lease</h5>
                                                    <span class="badge bg-secondary">Pending</span>
                                                </div>
                                                <ul class="checklist-items">
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Review lease terms</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Verify all conditions</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Confirm parties' obligations</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <div class="action-buttons">
                                            <!-- <button type="button" class="btn btn-outline-secondary previestab" data-prev="4">Previous</button>
                                            <button type="button" class="btn btn-success" disabled>Finalize Transaction</button> -->
                                            <button type="button" class="btn btn-primary nexttab" data-next="2">Save Changes</button>
                                        </div>
                                    </div>

                                    <!-- Step 6: Collection of Application -->
                                    <div class="tab-pane fade" id="step6">
                                        <h4 class="step-title">Collection of Application</h4>
                                        <p class="step-description">Cabinet application, notify client, record collector details, and archive completed application.</p>
                                        
                                        <div class="alert alert-secondary">
                                            <i class="ri-time-line me-2"></i>
                                            <span>This step is not yet available. It will become accessible after the previous step is completed.</span>
                                        </div>
                                        
                                        <div class="card checklist-card">
                                            <div class="card-body">
                                                <div class="checklist-header">
                                                    <h5 class="checklist-title">Cabinet and Send Message to Client</h5>
                                                    <span class="badge bg-secondary">Pending</span>
                                                </div>
                                                <ul class="checklist-items">
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Prepare application for cabinet</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Draft notification message</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Send notification to client</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <div class="card checklist-card">
                                            <div class="card-body">
                                                <div class="checklist-header">
                                                    <h5 class="checklist-title">Enter Details for Collector and Archive Application</h5>
                                                    <span class="badge bg-secondary">Pending</span>
                                                </div>
                                                <ul class="checklist-items">
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Record collector information</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Verify identification</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Archive completed application</label>
                                                    </li>
                                                    <li class="checklist-item">
                                                        <input class="form-check-input" type="checkbox" disabled>
                                                        <label class="form-check-label">Update system records</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <div class="action-buttons">
                                            <!-- <button type="button" class="btn btn-outline-secondary previestab" data-prev="5">Previous</button>
                                            <button type="button" class="btn btn-success" disabled>Complete Process</button> -->
                                            <button type="button" class="btn btn-primary nexttab" data-next="2">Save Changes</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
            
            <!-- Right Column - Tracking and Documents -->
            <div class="col-lg-4">
                <!-- Application Tracking -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Application Milestone</h5>
                    </div>
                    <div class="card-body">
                        <div class="tracking-timeline small" style="max-height: 500px; overflow: auto;">
                            <div class="timeline-progress">
                                <div class="progress-bar" style="height: 50%;"></div>
                            </div>
                            
                            <!-- Milestone 1 -->
                            <div class="timeline-item completed">
                                <div class="timeline-icon">
                                    <i class="ri-check-line"></i>
                                </div>
                                <div class="timeline-content">
                                    <h6 class="timeline-title">Application Submitted</h6>
                                    <div class="timeline-date">Sept 18, 2023 - 10:30 AM</div>
                                    <p class="timeline-description">Application received and logged into the system.</p>
                                </div>
                            </div>

                            <!-- Milestone 2 -->
                            <div class="timeline-item completed">
                                <div class="timeline-icon">
                                    <i class="ri-check-line"></i>
                                </div>
                                <div class="timeline-content">
                                    <h6 class="timeline-title">Application Review</h6>
                                    <div class="timeline-date">Sept 20, 2023 - 2:15 PM</div>
                                    <p class="timeline-description">Documents and application details reviewed for completeness and accuracy.</p>
                                </div>
                            </div>

                            <!-- Milestone 3 -->
                            <div class="timeline-item completed">
                                <div class="timeline-icon">
                                    <i class="ri-check-line"></i>
                                </div>
                                <div class="timeline-content">
                                    <h6 class="timeline-title">Verification of Payment & Application Process</h6>
                                    <div class="timeline-date">Sept 25, 2023 - 9:45 AM</div>
                                    <p class="timeline-description">Payments verified, parties added/updated and details entered.</p>
                                </div>
                            </div>

                            <!-- Milestone 4 -->
                            <div class="timeline-item active">
                                <div class="timeline-icon">
                                    <i class="ri-loader-4-line"></i>
                                </div>
                                <div class="timeline-content">
                                    <h6 class="timeline-title">Preparation of Title Plan</h6>
                                    <div class="timeline-date">In progress</div>
                                    <p class="timeline-description">Title plan generation in progress, awaiting zoning compliance verification.</p>
                                </div>
                            </div>

                            <!-- Milestone 5 -->
                            <div class="timeline-item">
                                <div class="timeline-icon">
                                    <i class="ri-time-line"></i>
                                </div>
                                <div class="timeline-content">
                                    <h6 class="timeline-title">Preparation of Lease Document</h6>
                                    <div class="timeline-date">Pending</div>
                                    <p class="timeline-description">Lease document generation pending, subject to environmental impact assessment.</p>
                                </div>
                            </div>

                            <!-- Milestone 6 -->
                            <div class="timeline-item">
                                <div class="timeline-icon">
                                    <i class="ri-time-line"></i>
                                </div>
                                <div class="timeline-content">
                                    <h6 class="timeline-title">Finalise Transaction</h6>
                                    <div class="timeline-date">Pending</div>
                                    <p class="timeline-description">Review and confirm parcel/transaction details, preview title plan, and lease before sign-off.</p>
                                </div>
                            </div>

                            <!-- Milestone 7 -->
                            <div class="timeline-item">
                                <div class="timeline-icon">
                                    <i class="ri-time-line"></i>
                                </div>
                                <div class="timeline-content">
                                    <h6 class="timeline-title">Collection of Application</h6>
                                    <div class="timeline-date">Pending</div>
                                    <p class="timeline-description">Cabinet application, notify client, record collector details, and archive completed application.</p>
                                </div>
                            </div>
                            
                        </div>
                        
                        <div class="action-buttons">
                            <button class="btn btn-outline-primary btn-sm w-100">
                                <i class="ri-history-line me-2"></i>View Full History
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Documents -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Application Documents</h5>
                    </div>
                    <div class="card-body small">
                        <ul class="document-list" style="max-height: 300px; overflow: auto;">
                            <li class="document-item">
                                <div class="document-info">
                                    <div class="document-icon">
                                        <i class="ri-file-text-line"></i>
                                    </div>
                                    <div>
                                        <div class="document-name">Application Form.pdf</div>
                                        <div class="document-size">2.4 MB</div>
                                    </div>
                                </div>
                                <div class="btn-group">
                                    <button class="btn btn-sm btn-outline-primary">
                                        <i class="ri-eye-line"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-primary">
                                        <i class="ri-download-line"></i>
                                    </button>
                                </div>
                            </li>
                            <li class="document-item">
                                <div class="document-info">
                                    <div class="document-icon">
                                        <i class="ri-image-line"></i>
                                    </div>
                                    <div>
                                        <div class="document-name">Site Plan.jpg</div>
                                        <div class="document-size">4.7 MB</div>
                                    </div>
                                </div>
                                <div class="btn-group">
                                    <button class="btn btn-sm btn-outline-primary">
                                        <i class="ri-eye-line"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-primary">
                                        <i class="ri-download-line"></i>
                                    </button>
                                </div>
                            </li>
                            <li class="document-item">
                                <div class="document-info">
                                    <div class="document-icon">
                                        <i class="ri-file-paper-line"></i>
                                    </div>
                                    <div>
                                        <div class="document-name">ID Verification.pdf</div>
                                        <div class="document-size">1.2 MB</div>
                                    </div>
                                </div>
                                <div class="btn-group">
                                    <button class="btn btn-sm btn-outline-primary">
                                        <i class="ri-eye-line"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-primary">
                                        <i class="ri-download-line"></i>
                                    </button>
                                </div>
                            </li>
                            <li class="document-item">
                                <div class="document-info">
                                    <div class="document-icon">
                                        <i class="ri-bill-line"></i>
                                    </div>
                                    <div>
                                        <div class="document-name">Payment Receipt.pdf</div>
                                        <div class="document-size">0.8 MB</div>
                                    </div>
                                </div>
                                <div class="btn-group">
                                    <button class="btn btn-sm btn-outline-primary">
                                        <i class="ri-eye-line"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-primary">
                                        <i class="ri-download-line"></i>
                                    </button>
                                </div>
                            </li>
                        </ul>
                        
                        <div class="action-buttons">
                            <button class="btn btn-outline-primary btn-sm w-100">
                                <i class="ri-upload-cloud-line me-2"></i>Upload Document
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Internal Comments -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Internal Comments</h5>
                    </div>
                    <div class="card-body small">
                        <div class="comments-section" style="max-height: 500px; overflow: auto;">
                            <div class="comment">
                                <div class="comment-header">
                                    <span class="comment-author">John Doe (Zoning Dept.)</span>
                                    <span class="comment-date">Sept 25, 2023</span>
                                </div>
                                <p class="comment-text">Site inspection completed. No issues found with the property. Waiting for zoning compliance verification.</p>
                            </div>
                            
                            <div class="comment">
                                <div class="comment-header">
                                    <span class="comment-author">Sarah Smith (Initial Screening)</span>
                                    <span class="comment-date">Sept 20, 2023</span>
                                </div>
                                <p class="comment-text">Application documents are complete and meet initial requirements. Moving to site evaluation phase.</p>
                            </div>
                            
                            <div class="comment">
                                <div class="comment-header">
                                    <span class="comment-author">Me </span>
                                    <span class="comment-date">Sept 18, 2023</span>
                                </div>
                                <p class="comment-text">Application received and logged into the system. Assigned to screening team.</p>
                                <div class="btn-group mt-3">
                                    <button class="btn btn-sm btn-light-warning">
                                        <i class="mdi mdi-pencil"></i>
                                    </button>
                                    <button class="btn btn-sm btn-light-danger">
                                        <i class="mdi mdi-trash-can-outline"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mt-3">
                            <textarea class="form-control" rows="3" placeholder="Add a comment..."></textarea>
                            <div class="d-flex justify-content-end mt-2">
                                <button class="btn btn-primary btn-sm">
                                    <i class="ri-chat-new-line me-2"></i>Post Comment
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.8.0/proj4.js"></script>
<script src="https://unpkg.com/terraformer@1.0.12"></script>
<script src="https://unpkg.com/terraformer-wkt-parser@1.2.1"></script>
<script src="https://cdn.jsdelivr.net/npm/wellknown@0.5.0/wellknown.min.js"></script>

<script>
    // Function to update progress bar based on current step
    function updateProgress() {
        const progressBar = document.querySelector('.progress-bar');
        // For demo purposes, set to 60% (step 4 of 6)
        progressBar.style.height = '60%';
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        updateProgress();
        
        // Add click handlers for action buttons
        document.querySelectorAll('.action-buttons .btn').forEach(button => {
            button.addEventListener('click', function() {
                const buttonText = this.textContent.trim();
                alert(`Action: `+buttonText);
            });
        });
        
        // Add functionality to document download buttons
        document.querySelectorAll('.document-item .btn').forEach(button => {
            button.addEventListener('click', function() {
                const documentName = this.closest('.document-item').querySelector('.document-name').textContent;
                alert(`Downloading: `+documentName);
            });
        });

        // Example: highlight parcel with ID 1794
        fetchAndDisplayParcelById(2);
    });

    document.querySelectorAll('.stepper, .form-steps-vertical').forEach(stepper => {
        const nextButtons = stepper.querySelectorAll('.nexttab');
        const prevButtons = stepper.querySelectorAll('.previestab');
        const tabs = stepper.querySelectorAll('.tab-pane');
        const progressBar = stepper.querySelector('.progress-bar');
        const tabButtons = stepper.querySelectorAll('.nav-link'); // Get all tab buttons
        let currentTab = 0;

        function updateTabs() {
            tabs.forEach((tab, index) => {
                tab.classList.remove('show', 'active');
                if (index === currentTab) {
                    tab.classList.add('show', 'active');
                }
            });

            // Determine if the stepper is vertical or horizontal
            const isVertical = stepper.classList.contains('form-steps-vertical');

            if (isVertical) {
                // Update progress bar height based on completed steps for vertical stepper
                const completedSteps = Math.min(currentTab, tabs.length - 1);
                const totalSteps = tabs.length - 2; // Excluding the last "Thank You" step
                const progressHeight = (completedSteps / totalSteps) * 100;
                progressBar.style.height = progressHeight+'%';
                progressBar.style.width = '100%'; // Ensure width is full
            } else {
                // Update progress bar width based on currentTab for horizontal stepper
                const progressPercentage = (currentTab / (tabs.length - 2)) * 100; // Excluding last step
                progressBar.style.width = progressPercentage+'%';
                progressBar.style.height = '5px'; // Default height for horizontal
            }

            // Update the active tab button
            tabButtons.forEach((button, index) => {
                button.classList.remove('active', 'activeComplete');
                if (index === currentTab) {
                    button.classList.add('active');
                } else if (index < currentTab) {
                    button.classList.add('activeComplete');
                    button.innerHTML = `<i class="ri-check-line"></i>`; // Add check icon
                }
            });
        }

        nextButtons.forEach(button => {
            button.addEventListener('click', () => {
                if (currentTab < tabs.length - 1) {
                    currentTab++;
                    updateTabs();
                }
            });
        });

        prevButtons.forEach(button => {
            button.addEventListener('click', () => {
                if (currentTab > 0) {
                    currentTab--;
                    updateTabs();
                }
            });
        });

        // Initial setup
        updateTabs();
    });

    // ----------------- MAP -------------------------------------------------------

    let map;
    let highlightedParcel = null;
    let parcelLayer = null;

    // Define source (EPSG:2136) and destination (EPSG:4326)
    proj4.defs("EPSG:2136", "+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.736 +y_0=0 +ellps=clrk80 +units=m +no_defs");

    // Example point in EPSG:2136
    let point2136 = [264970, 1015339]; // [x, y]

    // Convert to EPSG:4326
    let point4326 = proj4("EPSG:2136", "EPSG:4326", point2136);

    // Leaflet expects [lat, lon]
    let leafletCenter = [point4326[1], point4326[0]];

    const geoserverBaseUrl = 'http://localhost:2020/geoserver';

    // Base Layers
    const osmLayer = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors'
    });

    const satelliteLayer = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
        attribution: '© Esri'
    });

    const topoLayer = L.tileLayer('https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenTopoMap contributors'
    });

    // Initialize map with default base layer
    map = L.map('map', {
        center: [5.385786, -0.679827],
        zoom: 16,
        layers: [osmLayer]
    });

    // Improved WKT parser that handles double parentheses
    function parseCoordinateString(coordString) {
        console.log('Parsing coordinate string:', coordString);
        
        // Remove any extra parentheses from the beginning and end
        let cleanedString = coordString.trim();
        
        // Remove outer parentheses if they exist
        if (cleanedString.startsWith('(') && cleanedString.endsWith(')')) {
            cleanedString = cleanedString.substring(1, cleanedString.length - 1).trim();
        }
        
        // Remove inner parentheses if they exist (for double parentheses case)
        if (cleanedString.startsWith('(') && cleanedString.endsWith(')')) {
            cleanedString = cleanedString.substring(1, cleanedString.length - 1).trim();
        }
        
        console.log('Cleaned coordinate string:', cleanedString);
        
        return cleanedString.split(',').map(coordPair => {
            const trimmed = coordPair.trim();
            if (!trimmed) return null;
            
            const coords = trimmed.split(/\s+/); // Split by any whitespace
            if (coords.length < 2) {
                throw new Error('Invalid coordinate pair: ' + coordPair);
            }
            
            const x = parseFloat(coords[0]);
            const y = parseFloat(coords[1]);
            
            if (isNaN(x) || isNaN(y)) {
                throw new Error('Invalid coordinates: ' + coordPair);
            }
            
            console.log('Parsed coordinate:', [x, y]);
            return [x, y];
        }).filter(coord => coord !== null);
    }

    // Enhanced MULTIPOLYGON parser that handles various WKT formats
    function parseMultiPolygonWKT(wkt) {
        console.log('Parsing MULTIPOLYGON WKT:', wkt);
        
        try {
            // Try different WKT patterns to handle various formats
            let coordinates = [];
            
            // Pattern 1: Standard MULTIPOLYGON with double parentheses
            const pattern1 = wkt.match(/MULTIPOLYGON\s*\(\s*\(\s*\(\s*([^)]+)\s*\)\s*\)\s*\)/);
            if (pattern1) {
                console.log('Found pattern 1 (double parentheses)');
                coordinates = parseCoordinateString(pattern1[1]);
            } 
            // Pattern 2: MULTIPOLYGON with single parentheses
            else if (wkt.match(/MULTIPOLYGON\s*\(\s*\(\s*([^)]+)\s*\)\s*\)/)) {
                const pattern2 = wkt.match(/MULTIPOLYGON\s*\(\s*\(\s*([^)]+)\s*\)\s*\)/);
                console.log('Found pattern 2 (single parentheses)');
                coordinates = parseCoordinateString(pattern2[1]);
            }
            // Pattern 3: Extract coordinates between the innermost parentheses
            else {
                console.log('Trying pattern 3 (extract innermost parentheses)');
                // Find the innermost parentheses content
                const innermostMatch = wkt.match(/\(([^()]+)\)/);
                if (innermostMatch) {
                    coordinates = parseCoordinateString(innermostMatch[1]);
                } else {
                    throw new Error('Could not extract coordinates from WKT');
                }
            }
            
            console.log('Parsed coordinates:', coordinates);
            
            if (coordinates.length === 0) {
                throw new Error('No coordinates parsed');
            }

            // Test if coordinates are in Ghana bounds to determine the correct order
            const asLngLat = coordinates; // [lng, lat] order
            const asLatLng = coordinates.map(coord => [coord[1], coord[0]]); // [lat, lng] order
            
            const inGhanaLngLat = areCoordinatesInGhana(asLngLat);
            const inGhanaLatLng = areCoordinatesInGhana(asLatLng);
            
            console.log('Coordinates in Ghana as [lng, lat]:', inGhanaLngLat);
            console.log('Coordinates in Ghana as [lat, lng]:', inGhanaLatLng);
            
            // Use the coordinate order that places points in Ghana
            let finalCoordinates;
            if (inGhanaLngLat) {
                console.log('Using [lng, lat] order');
                finalCoordinates = asLngLat;
            } else if (inGhanaLatLng) {
                console.log('Using [lat, lng] order');
                finalCoordinates = asLatLng;
            } else {
                console.log('Neither order places in Ghana, using [lng, lat] as default');
                finalCoordinates = asLngLat;
            }
            
            // Close the ring if needed
            if (finalCoordinates.length > 0) {
                const first = finalCoordinates[0];
                const last = finalCoordinates[finalCoordinates.length - 1];
                
                if (first[0] !== last[0] || first[1] !== last[1]) {
                    finalCoordinates.push([first[0], first[1]]);
                    console.log('Closed polygon ring');
                }
            }

            console.log('Final Leaflet coordinates:', finalCoordinates);

            return {
                type: 'Feature',
                geometry: {
                    type: 'MultiPolygon',
                    coordinates: [[finalCoordinates]]
                },
                properties: {}
            };
            
        } catch (error) {
            console.error('Error parsing MULTIPOLYGON:', error);
            throw error;
        }
    }

    // Simple function to check if coordinates are in Ghana
    function areCoordinatesInGhana(coordinates) {
        if (!coordinates || coordinates.length === 0) return false;
        
        // Ghana approximate bounds (wider range to be safe)
        const ghanaBounds = {
            minLng: -4.0, maxLng: 2.0,   // Longitude range
            minLat: 4.0, maxLat: 12.0    // Latitude range
        };
        
        // Check a few sample points to avoid checking all coordinates
        const samplePoints = [
            coordinates[0], // First point
            coordinates[Math.floor(coordinates.length / 2)], // Middle point
            coordinates[coordinates.length - 1] // Last point
        ];
        
        for (const coord of samplePoints) {
            const lng = coord[0];
            const lat = coord[1];
            
            // Check if this is a valid Ghana coordinate
            if (lat < ghanaBounds.minLat || lat > ghanaBounds.maxLat ||
                lng < ghanaBounds.minLng || lng > ghanaBounds.maxLng) {
                return false;
            }
        }
        return true;
    }

    // Enhanced fetch function with better error handling
    function fetchAndDisplayParcelById(parcelId) {
        if (!parcelId) {
            console.error('No parcel ID provided');
            showNotification('No parcel ID provided', 'error');
            return;
        }

        showNotification('Loading parcel data...', 'info');

        fetch(`api/maps/map/` + parcelId)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                console.log('API Response:', data);
                
                if (data.success && data.data && data.data.length > 0) {
                    const parcelData = data.data[0];
                    console.log('Parcel Data:', parcelData);
                    
                    if (!parcelData.polygon && !parcelData.geom_ghana_grid) {
                        throw new Error('No geometry data found in response');
                    }

                    const wktPolygon = parcelData.polygon || parcelData.geom_ghana_grid;
                    console.log('WKT Geometry:', wktPolygon);
                    
                    const geoJsonFeature = parseMultiPolygonWKT(wktPolygon);
                    
                    if (geoJsonFeature) {
                        console.log('GeoJSON feature:', geoJsonFeature);
                        highlightParcel(geoJsonFeature);
                        
                        const bounds = parcelLayer.getBounds();
                        if (bounds.isValid()) {
                            map.fitBounds(bounds, { padding: [50, 50], maxZoom: 18 });
                        }
                        
                        showNotification('Parcel loaded successfully', 'success');
                        localStorage.setItem("selectedParcel", JSON.stringify(parcelData));
                    } else {
                        throw new Error('Failed to convert parcel geometry.');
                    }
                } else {
                    throw new Error(data.message || 'No parcel data found in response');
                }
            })
            .catch(error => {
                console.error('Error fetching parcel data:', error);
                showNotification('Error loading parcel: ' + error.message, 'error');
            });
    }

    // Function to get parcel info by coordinates (existing functionality)
    function getParcelInfo(latlng) {
        const wmsUrl = geoserverBaseUrl + '/wms';
        const wmsParams = {
            service: 'WMS',
            version: '1.1.1',
            request: 'GetFeatureInfo',
            layers: 'smarterem:gcsez_parceldata_02',
            query_layers: 'smarterem:gcsez_parceldata_02',
            feature_count: 1,
            info_format: 'application/json',
            srs: 'EPSG:4326',
            bbox: map.getBounds().getSouthWest().lng+`,`+map.getBounds().getSouthWest().lat+`,`+map.getBounds().getNorthEast().lng+`,`+map.getBounds().getNorthEast().lat+``,
            width: map.getSize().x,
            height: map.getSize().y,
            x: Math.floor(map.latLngToContainerPoint(latlng).x),
            y: Math.floor(map.latLngToContainerPoint(latlng).y)
        };

        fetch(wmsUrl + '?' + new URLSearchParams(wmsParams))
            .then(response => response.json())
            .then(data => {
                if (data.features && data.features.length > 0) {
                    const feature = data.features[0];
                    
                    // Highlight the clicked parcel
                    highlightParcel(feature);
                    
                    // Store parcel data
                    localStorage.setItem("selectedParcel", JSON.stringify(feature.properties));
                    
                    // Show parcel info (you can customize this part)
                    showParcelInfo(feature.properties);
                }
            })
            .catch(error => {
                console.error('Error getting parcel info:', error);
            });
    }

    // Function to show parcel information (customize as needed)
    function showParcelInfo(properties) {
        // You can display this information in a sidebar, popup, or modal
        // console.log('Parcel Properties:', properties);
        
        // Example: Show in a popup
        const popupContent = `
            <div class="parcel-info">
                <h5>Parcel Information</h5>
                <p><strong>Serial No:</strong> `+properties.serial_no || 'N/A'+`</p>
                <p><strong>Land Use:</strong> `+properties.land_use || 'N/A'+`</p>
                <p><strong>Acreage:</strong> `+properties.acreage || 'N/A'+`</p>
                <p><strong>Status:</strong> `+properties.status || 'N/A'+`</p>
            </div>
        `;
        
        // You can create a custom popup or update a sidebar element
        // For now, just log to console
    }

    // GeoServer WMS Layer with error handling
    try {
        var gcsez_boundary = L.tileLayer.wms(geoserverBaseUrl + '/wms', {
            layers: 'smarterem:gcsez_boundary',
            format: 'image/png',
            transparent: true,
            version: '1.1.0',
            attribution: 'GeoServer Data'
        }).addTo(map);

        var gcsez_parceldata_02 = L.tileLayer.wms(geoserverBaseUrl + '/wms', {
            layers: 'smarterem:gcsez_parceldata_02',
            format: 'image/png',
            transparent: true,
            version: '1.1.0',
            attribution: 'GeoServer Data'
        }).addTo(map);

        var gcsez_stline = L.tileLayer.wms(geoserverBaseUrl + '/wms', {
            layers: 'smarterem:gcsez_stline',
            format: 'image/png',
            transparent: true,
            version: '1.1.0',
            attribution: 'GeoServer Data'
        }).addTo(map);

        var gcsez_accessroad = L.tileLayer.wms(geoserverBaseUrl + '/wms', {
            layers: 'smarterem:gcsez_accessroad',
            format: 'image/png',
            transparent: true,
            version: '1.1.0',
            attribution: 'GeoServer Data'
        }).addTo(map);
        
        // Optional: Add layer control
        const baseLayers = {
            'OpenStreetMap': osmLayer,
            'Satellite': satelliteLayer,
            'Topographic': topoLayer
        };
        
        const overlays = {
            "Boundary": gcsez_boundary,
            "Parcel Data": gcsez_parceldata_02,
            "Street Line": gcsez_stline,
            "Access Road": gcsez_accessroad
        };

        console.log(gcsez_parceldata_02)

        // Call this function after map initialization
        initParcelHighlightLayer();

        // Modify the click handler
        // map.on('click', function(e) {
        //     // Only process clicks if parcel layer is visible
        //     if (map.hasLayer(gcsez_parceldata_02)) {
        //         // Clear previous highlight
        //         clearParcelHighlight();
                
        //         // Get parcel info and highlight
        //         getParcelInfo(e.latlng);
                
        //         // Center map on click position
        //         map.panTo(e.latlng);
        //     }
        // });
        
        L.control.layers(baseLayers, overlays, { collapsed: false }).addTo(map);
        
    } catch (error) {
        console.error('Error loading GeoServer layer:', error);
        showNotification('Could not connect to GeoServer. Make sure it\'s running on localhost:2020', 'error');
    }

    // Initialize a GeoJSON layer for highlighting
    function initParcelHighlightLayer() {
        try {
            parcelLayer = L.geoJSON(null, {
                style: function(feature) {
                    return {
                        color: '#ff0000',
                        weight: 3,
                        opacity: 0.8,
                        fillColor: '#ff0000',
                        fillOpacity: 0.2
                    };
                },
                onEachFeature: function(feature, layer) {
                    // Add popup with parcel information
                    if (feature.properties) {
                        const props = feature.properties;
                        const popupContent = `
                            <div class="parcel-popup">
                                <h6>Parcel Details</h6>
                                <p><strong>ID:</strong> ${props.id || props.fid_1 || 'N/A'}</p>
                                <p><strong>Serial:</strong> ${props.serial_no || 'N/A'}</p>
                                <p><strong>Land Use:</strong> ${props.land_use || 'N/A'}</p>
                            </div>
                        `;
                        
                        // Bind popup but don't open it automatically
                        layer.bindPopup(popupContent);
                    }
                }
            }).addTo(map);
            
            // console.log('Parcel highlight layer initialized successfully');
        } catch (error) {
            console.error('Error initializing parcel layer:', error);
        }
    }

    // Function to clear parcel highlight
    function clearParcelHighlight() {
        if (parcelLayer) {
            parcelLayer.clearLayers();
        }
        highlightedParcel = null;
    }

    // Function to highlight a specific parcel
    function highlightParcel(geojsonData) {
        if (!parcelLayer || !geojsonData) {
            console.error('Invalid parameters for highlightParcel');
            return;
        }
        
        try {
            // Validate GeoJSON structure
            if (!geojsonData.geometry || !geojsonData.geometry.coordinates) {
                throw new Error('Invalid GeoJSON structure: missing geometry or coordinates');
            }
            
            // console.log('Highlighting parcel with geometry:', geojsonData.geometry);
            
            // Clear previous highlights
            clearParcelHighlight();
            
            // Add the new parcel to highlight layer
            parcelLayer.addData(geojsonData);
            
            // Store reference to highlighted parcel
            highlightedParcel = geojsonData;
            
            // Try to fit bounds, but handle errors
            try {
                const bounds = parcelLayer.getBounds();
                if (bounds && bounds.isValid && bounds.isValid()) {
                    map.fitBounds(bounds, { padding: [50, 50], maxZoom: 15 });
                    // console.log('Map bounds fitted to parcel');
                } else {
                    console.warn('Invalid bounds, skipping fitBounds');
                }
            } catch (boundsError) {
                console.warn('Error fitting bounds:', boundsError);
            }
            
            // Open popup with error handling
            try {
                parcelLayer.eachLayer(function(layer) {
                    if (layer.getBounds && layer.getBounds().isValid()) {
                        layer.openPopup();
                    } else {
                        console.warn('Layer has invalid bounds, skipping popup');
                    }
                });
            } catch (popupError) {
                console.warn('Error opening popup:', popupError);
            }
            
        } catch (error) {
            console.error('Error highlighting parcel:', error);
            throw error;
        }
    }


    window.showNotification = function(message, type = 'success') {
        // You can implement a toast notification system here
        Toastify({
            text: message,
            duration: 10000,
            close: true,
            gravity: "top",
            position: "right",
            stopOnFocus: true,
            avatar: type === 'success' ? '../assets/images/notification/ok-48.png' : '../assets/images/notification/high_priority-48.png', // small icon image
            style: {
                background: type === 'success' ? 'linear-gradient(to right, #00b09b, #96c93d)' : 'linear-gradient(to right, #ff5f6d, #ffc371)',
                fontSize: "13px",
            },
        }).showToast();
    }

    // Export function for global access (if needed)
    window.fetchAndDisplayParcelById = fetchAndDisplayParcelById;
    window.clearParcelHighlight = clearParcelHighlight;

</script>