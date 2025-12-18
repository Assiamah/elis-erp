<div class="gcsez-application-workspace">
    <!-- Header Section -->
    <div class="workspace-header">
        <div class="header-content">
            <div class="header-main">
                <h1 class="workspace-title"></h1>
                <p class="workspace-subtitle"></p>
                <div class="application-badge mt-2"></div>
            </div>
            <div class="header-status">
                <div class="status-pill status-submitted">
                    
                </div>
                <!-- <div class="priority-tag priority-medium">
                    <i class="mdi mdi-clock-alert"></i>
                    Standard Priority
                </div> -->
            </div>
        </div>
        
        <!-- <div class="action-toolbar">
            <button class="btn-action btn-success" onclick="approveApplication()">
                <i class="mdi mdi-check-circle-outline"></i>
                <span>Approve Application</span>
            </button>
            <button class="btn-action btn-warning" onclick="requestInformation()">
                <i class="mdi mdi-message-text-outline"></i>
                <span>Request Info</span>
            </button>
            <button class="btn-action btn-danger" onclick="rejectApplication()">
                <i class="mdi mdi-close-circle-outline"></i>
                <span>Reject</span>
            </button>
            <button class="btn-action btn-secondary" onclick="downloadApplication()">
                <i class="mdi mdi-download"></i>
                <span>Export PDF</span>
            </button>
        </div> -->
    </div>

    <!-- Main Content Grid -->
    <div class="workspace-grid">
        <!-- Left Column - Main Content -->
        <div class="main-content">
            <!-- Key Metrics Cards -->
            <div class="metrics-grid">
                <div class="metric-card financial">
                    <div class="metric-icon">
                        <i class="mdi mdi-cash-multiple"></i>
                    </div>
                    <div class="metric-content">
                        <div class="metric-value"></div>
                        <div class="metric-label">Total Lease Value</div>
                        <div class="metric-subtext">100% Paid</div>
                    </div>
                </div>
                
                <div class="metric-card land">
                    <div class="metric-icon">
                        <i class="mdi mdi-map-marker-distance"></i>
                    </div>
                    <div class="metric-content">
                        <div class="metric-value"></div>
                        <div class="metric-label">Total Land Area</div>
                        <div class="metric-subtext">4 parcels</div>
                    </div>
                </div>
                
                <div class="metric-card app-progress">
                    <div class="metric-icon">
                        <i class="mdi mdi-progress-check"></i>
                    </div>
                    <div class="metric-content">
                        <div class="metric-value">Step 1/5</div>
                        <div class="metric-label">Application Progress</div>
                        <div class="metric-subtext">20% Complete</div>
                    </div>
                </div>
                
                <div class="metric-card documents">
                    <div class="metric-icon">
                        <i class="mdi mdi-file-document-multiple"></i>
                    </div>
                    <div class="metric-content">
                        <div class="metric-value"></div>
                        <div class="metric-label">Documents</div>
                        <div class="metric-subtext">Uploaded</div>
                    </div>
                </div>
            </div>

            <!-- Application Details Sections -->
            <div class="content-sections">
                <!-- Applicant Information -->
                <section class="content-section">
                    <div class="section-header">
                        <div class="section-icon applicant">
                            <i class="mdi mdi-account"></i>
                        </div>
                        <div class="section-title">
                            <h3>Applicant Information</h3>
                            <p style="font-weight: 100;">Company registration details and contact information</p>
                        </div>
                    </div>
                    <div class="section-content">
                        <div class="info-grid">
                            
                        </div>
                    </div>
                </section>

                <!-- Property Portfolio -->
                <section class="content-section">
                    <div class="section-header">
                        <div class="section-icon property">
                            <i class="mdi mdi-land-plots"></i>
                        </div>
                        <div class="section-title">
                            <h3>Property Portfolio</h3>
                            <p style="font-weight: 100;" id="portfolioStatus"></p>
                        </div>
                    </div>
                    <div class="section-content">
                        <div class="parcels-grid">
                            
                        </div>
                        
                        <div class="portfolio-summary">
                            <div class="summary-item">
                                <span class="summary-label">Total Parcels</span>
                                <span class="summary-value"></span>
                            </div>
                            <div class="summary-item">
                                <span class="summary-label">Average Size</span>
                                <span class="summary-value"></span>
                            </div>
                            <div class="summary-item">
                                <span class="summary-label">Total Area</span>
                                <span class="summary-value"></span>
                            </div>
                            <div class="summary-item">
                                <span class="summary-label">Total Value</span>
                                <span class="summary-value"></span>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Application Progress -->
                <section class="content-section">
                    <div class="section-header">
                        <div class="section-icon progress">
                            <i class="mdi mdi-progress-wrench"></i>
                        </div>
                        <div class="section-title">
                            <h3>Application Progress</h3>
                            <p>Current status: Step 1 of 5 - Application Submitted</p>
                        </div>
                    </div>
                    <div class="section-content">
                        
                    </div>
                </section>
            </div>
        </div>

        <!-- Right Column - Sidebar -->
        <div class="sidebar">
            <!-- Application Timeline -->
            <div class="sidebar-card">
                <div class="card-header">
                    <i class="mdi mdi-timeline-clock"></i>
                    <h4>Application Timeline</h4>
                </div>
                <div class="card-content">
                    <div class="timeline-app">
                        
                    </div>
                </div>
            </div>

            <!-- Documents -->
            <div class="sidebar-card">
                <div class="card-header">
                    <i class="mdi mdi-file-document-multiple"></i>
                    <h4>Application Documents</h4>
                </div>
                <div class="card-content">
                    <div class="documents-list">
                       
                    </div>
                    <button class="btn-upload" onclick="uploadDocument()">
                        <i class="mdi mdi-plus"></i>
                        Upload New Document
                    </button>
                </div>
            </div>

            <!-- Payment Status -->
            <div class="sidebar-card">
                <div class="card-header">
                    <i class="mdi mdi-credit-card-check"></i>
                    <h4>Payment Status</h4>
                </div>
                <div class="card-content">
                    <div class="payment-status">
                        <div class="payment-badge paid">
                            <i class="mdi mdi-check-circle"></i>
                            Fully Paid
                        </div>
                        <div class="payment-details">
                            <div class="payment-item">
                                <span>Total Amount:</span>
                                <span class="payment-value">GHS 6,000,000</span>
                            </div>
                            <div class="payment-item">
                                <span>Amount Paid:</span>
                                <span class="payment-value paid">GHS 6,000,000</span>
                            </div>
                            <div class="payment-item">
                                <span>Balance:</span>
                                <span class="payment-value">GHS 0.00</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Internal Notes -->
            <div class="sidebar-card">
                <div class="card-header">
                    <i class="mdi mdi-notebook-edit"></i>
                    <h4>Internal Notes</h4>
                </div>
                <div class="card-content">
                    <div class="notes-list">
                        <div class="note-item">
                            <div class="note-content">
                                Application submitted for 4 industrial parcels. All documents appear to be in order. Awaiting site inspection scheduling.
                            </div>
                            <div class="note-meta">
                                <span class="note-author">Review Officer</span>
                                <span class="note-date">Today, 10:30 AM</span>
                            </div>
                        </div>
                    </div>
                    <div class="note-input">
                        <textarea placeholder="Add internal note..."></textarea>
                        <button class="btn-add-note">
                            <i class="mdi mdi-send"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Document Viewer Overlay -->
<div id="documentViewer" class="document-viewer">
  <div class="viewer-header">
    <span id="viewerTitle"></span>
    <div class="viewer-actions">
      <button id="prevPage" class="viewer-btn"><i class="ri-arrow-left-line"></i></button>
      <span id="pageIndicator">Page <span id="currentPage">1</span> / <span id="totalPages">1</span></span>
      <button id="nextPage" class="viewer-btn"><i class="ri-arrow-right-line"></i></button>
      
      <!-- Zoom Controls -->
      <!-- <div class="zoom-controls"> -->
        <button class="zoom-btn" id="zoomOut" title="Zoom Out">
          <i class="ri-zoom-out-line"></i>
        </button>
        <span class="zoom-level" id="zoomLevel">100%</span>
        <button class="zoom-btn" id="zoomIn" title="Zoom In">
          <i class="ri-zoom-in-line"></i>
        </button>
        <button class="zoom-btn" id="resetZoom" title="Reset Zoom">
          <i class="ri-refresh-line"></i>
        </button>
      <!-- </div> -->
      
      <button id="printFile" class="viewer-btn" title="Print">
        <i class="ri-printer-line"></i>
      </button>
      <button id="downloadFile" class="viewer-btn"><i class="ri-download-line"></i></button>
      <button id="closeViewer" class="viewer-btn"><i class="ri-close-line"></i></button>
    </div>
  </div>
  <div id="documentPreview" class="viewer-body"></div>
  <div class="mobile-zoom-hint" style="display: none;">
    Double-tap to zoom • Pinch to zoom
  </div>
</div>

<style>
.gcsez-application-workspace {
    background: #f8fafc;
    min-height: calc(100vh - 70px);
    margin-top: 70px;
    margin-left: 260px;
    padding: 24px;
    font-family: 'Rubik', sans-serif;
}

/* Header Styles */
.workspace-header {
    background: white;
    border-radius: 16px;
    padding: 24px;
    margin-bottom: 24px;
    box-shadow: 0 4px 6px -1px rgba(33, 34, 35, 0.1), 0 2px 4px -1px rgba(33, 34, 35, 0.06);
    border: 1px solid #e5e7eb;
}

.header-content {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 0;
}

.header-main {
    flex: 1;
}

.application-badge {
    background: linear-gradient(135deg, #326573, #57a394);
    color: white;
    padding: 6px 12px;
    border-radius: 8px;
    font-size: 12px;
    font-weight: 600;
    display: inline-block;
    margin-bottom: 8px;
}

.workspace-title {
    font-size: 24px;
    font-weight: 700;
    color: #212223;
    margin: 0 0 4px 0;
    line-height: 1.2;
}

.workspace-subtitle {
    color: #8f8c89;
    font-size: 14px;
    margin: 0;
    font-weight: 400;
}

.header-status {
    display: flex;
    flex-direction: column;
    gap: 8px;
    align-items: flex-end;
}

.status-pill {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 8px 16px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.status-submitted {
    background: rgba(197, 187, 133, 0.1);
    color: #c5bb85;
    border: 1px solid rgba(197, 187, 133, 0.3);
}

.status-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background: currentColor;
}

.priority-tag {
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 6px 12px;
    border-radius: 12px;
    font-size: 11px;
    font-weight: 600;
}

.priority-medium {
    background: rgba(235, 132, 113, 0.1);
    color: #eb8471;
    border: 1px solid rgba(235, 132, 113, 0.3);
}

/* Action Toolbar */
.action-toolbar {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
}

.btn-action {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 12px 20px;
    border: none;
    border-radius: 10px;
    font-weight: 600;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.2s ease;
    font-family: 'Rubik', sans-serif;
}

.btn-success { 
    background: #57a394; 
    color: white; 
}
.btn-warning { 
    background: #c5bb85; 
    color: #212223; 
}
.btn-danger { 
    background: #b48478; 
    color: white; 
}
.btn-secondary { 
    background: #928d89; 
    color: white; 
}

.btn-action:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(33, 34, 35, 0.15);
}

/* Grid Layout */
.workspace-grid {
    display: grid;
    grid-template-columns: 1fr 400px;
    gap: 24px;
}

/* Metrics Grid */
.metrics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 16px;
    margin-bottom: 24px;
}

.metric-card {
    background: white;
    border-radius: 12px;
    padding: 20px;
    display: flex;
    align-items: center;
    gap: 16px;
    box-shadow: 0 2px 4px rgba(33, 34, 35, 0.05);
    border: 1px solid #e5e7eb;
    transition: transform 0.2s ease;
}

.metric-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(33, 34, 35, 0.1);
}

/* .metric-card.financial { border-left: 4px solid #57a394; }
.metric-card.land { border-left: 4px solid #326573; }
.metric-card.app-progress { border-left: 4px solid #c5bb85; }
.metric-card.documents { border-left: 4px solid #eb8471; } */

.metric-icon {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    color: white;
}

.metric-card.financial .metric-icon { background: #57a394; }
.metric-card.land .metric-icon { background: #326573; }
.metric-card.app-progress .metric-icon { background: #c5bb85; }
.metric-card.documents .metric-icon { background: #eb8471; }

.metric-value {
    font-size: 15px;
    font-weight: 500;
    color: #212223;
    margin-bottom: 4px;
}

.metric-label {
    font-size: 13px;
    color: #8f8c89;
    font-weight: 500;
    margin-bottom: 2px;
}

.metric-subtext {
    font-size: 12px;
    color: #928d89;
    font-weight: 100;
}

/* Content Sections */
.content-sections {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.content-section {
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 2px 4px rgba(33, 34, 35, 0.05);
    border: 1px solid #e5e7eb;
}

.section-header {
    background: linear-gradient(135deg, #f8fafc, #f1f5f9);
    padding: 20px 24px;
    border-bottom: 1px solid #e5e7eb;
    display: flex;
    align-items: center;
    gap: 16px;
}

.section-icon {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    color: white;
    flex-shrink: 0;
}

.section-icon.applicant { background: #326573; }
.section-icon.property { background: #57a394; }
.section-icon.progress { background: #c5bb85; }

.section-title h3 {
    margin: 0;
    font-size: 18px;
    font-weight: 600;
    color: #212223;
}

.section-title p {
    margin: 4px 0 0 0;
    font-size: 14px;
    color: #8f8c89;
}

.section-content {
    padding: 24px;
}

/* Info Grid */
.info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 24px;
}

.info-group h4 {
    margin: 0 0 16px 0;
    font-size: 16px;
    font-weight: 600;
    color: #212223;
    padding-bottom: 8px;
    border-bottom: 1px solid #f1f5f9;
}

.info-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 0;
    border-bottom: 1px solid #f8fafc;
}

.info-label {
    font-size: 14px;
    color: #8f8c89;
    font-weight: 500;
}

.info-value {
    font-size: 14px;
    color: #212223;
    font-weight: 400;
    text-align: right;
}

.status-badge {
    padding: 4px 8px;
    border-radius: 6px;
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
}

.status-badge.active {
    background: rgba(87, 163, 148, 0.1);
    color: #57a394;
}

/* Parcels Grid */
.parcels-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 16px;
    margin-bottom: 24px;
}

.parcel-card {
    background: #f8fafc;
    border-radius: 12px;
    padding: 16px;
    border: 1px solid #e5e7eb;
    transition: all 0.2s ease;
}

.parcel-card:hover {
    border-color: #326573;
    box-shadow: 0 2px 8px rgba(50, 101, 115, 0.1);
}

.parcel-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12px;
}

.parcel-header h4 {
    margin: 0;
    font-size: 14px;
    font-weight: 600;
    color: #212223;
}

.parcel-status {
    padding: 4px 8px;
    border-radius: 6px;
    font-size: 10px;
    font-weight: 600;
    text-transform: uppercase;
}

.parcel-status.reserved {
    background: rgba(197, 187, 133, 0.1);
    color: #c5bb85;
}

.parcel-details {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.parcel-info {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 12px;
    color: #8f8c89;
}

.parcel-info i {
    color: #326573;
    width: 16px;
}

/* Portfolio Summary */
.portfolio-summary {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 16px;
    padding: 16px;
    background: #f8fafc;
    border-radius: 12px;
    border: 1px solid #e5e7eb;
}

.summary-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
}

.summary-label {
    font-size: 12px;
    color: #8f8c89;
    margin-bottom: 4px;
}

.summary-value {
    font-size: 16px;
    font-weight: 400;
    color: #212223;
}

/* Progress Tracker */
.progress-tracker {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.progress-step {
    display: flex;
    align-items: flex-start;
    gap: 16px;
    padding: 16px;
    background: #f8fafc;
    border-radius: 12px;
    border: 1px solid #e5e7eb;
    transition: all 0.2s ease;
}

.progress-step.completed {
    background: rgba(87, 163, 148, 0.05);
    border-color: rgba(87, 163, 148, 0.2);
}

.progress-step.current {
    background: rgba(50, 101, 115, 0.05);
    border-color: rgba(50, 101, 115, 0.3);
    border-left: 4px solid #326573;
}

.step-indicator {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    flex-shrink: 0;
}

.progress-step.completed .step-indicator {
    background: #57a394;
    color: white;
}

.progress-step.current .step-indicator {
    background: #326573;
    color: white;
}

.progress-step.pending .step-indicator {
    background: #e5e7eb;
    color: #8f8c89;
    font-weight: 600;
}

.step-content {
    flex: 1;
}

.step-title {
    font-weight: 600;
    color: #212223;
    margin-bottom: 4px;
}

.step-description {
    font-size: 14px;
    color: #8f8c89;
    margin-bottom: 4px;
}

.step-date, .step-status {
    font-size: 12px;
    color: #928d89;
    font-weight: 500;
}

/* Sidebar Cards */
.sidebar-card {
    background: white;
    border-radius: 16px;
    margin-bottom: 20px;
    box-shadow: 0 2px 4px rgba(33, 34, 35, 0.05);
    border: 1px solid #e5e7eb;
    overflow: hidden;
}

.card-header {
    background: linear-gradient(135deg, #f8fafc, #f1f5f9);
    padding: 16px 20px;
    border-bottom: 1px solid #e5e7eb;
    display: flex;
    align-items: center;
    gap: 12px;
}

.card-header i {
    color: #326573;
    font-size: 20px;
}

.card-header h4 {
    margin: 0;
    font-size: 16px;
    font-weight: 600;
    color: #212223;
}

.card-content {
    padding: 20px;
}

/* Timeline */
.timeline-app{
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.timeline-item {
    display: flex;
    gap: 12px;
    padding-bottom: 16px;
    border-left: 2px solid #e5e7eb;
    margin-left: 11px;
    padding-left: 20px;
    position: relative;
}

.timeline-item:last-child {
    padding-bottom: 0;
}

.timeline-marker {
    width: 20px;
    height: 20px;
    border-radius: 50%;
    position: absolute;
    left: -11px;
    top: 0;
    border: 3px solid white;
}

.timeline-marker.submitted { background: #57a394; }
.timeline-marker.created { background: #326573; }

.timeline-content {
    flex: 1;
}

.timeline-title {
    font-size: 14px;
    font-weight: 600;
    color: #212223;
    margin-bottom: 2px;
}

.timeline-date {
    font-size: 12px;
    color: #8f8c89;
    margin-bottom: 4px;
}

.timeline-description {
    font-size: 12px;
    color: #928d89;
    line-height: 1.4;
}

/* Documents List */
.documents-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
    margin-bottom: 16px;
}

.document-item {
    display: flex;
    align-items: flex-start;
    gap: 12px;
    padding: 12px;
    background: #f8fafc;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
}

.document-icon {
    width: 32px;
    height: 32px;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
    color: white;
    flex-shrink: 0;
}

.document-icon.signed { background: #57a394; }
.document-icon.supporting { background: #326573; }

.document-info {
    flex: 1;
}

.document-name {
    font-size: 12px;
    font-weight: 600;
    color: #212223;
    margin-bottom: 4px;
    word-break: break-word;
}

.document-meta {
    display: flex;
    gap: 8px;
    margin-bottom: 4px;
}

.document-type, .document-size {
    font-size: 10px;
    padding: 2px 6px;
    border-radius: 4px;
    font-weight: 500;
}

.document-type {
    background: rgba(50, 101, 115, 0.1);
    color: #326573;
}

.document-size {
    background: rgba(146, 141, 137, 0.1);
    color: #928d89;
}

.document-uploader {
    font-size: 10px;
    color: #8f8c89;
}

.btn-download {
    padding: 8px;
    background: transparent;
    border: 1px solid #e5e7eb;
    border-radius: 6px;
    color: #326573;
    cursor: pointer;
    transition: all 0.2s ease;
    flex-shrink: 0;
}

.btn-download:hover {
    background: #326573;
    color: white;
}

.btn-view {
    padding: 8px;
    background: transparent;
    border: 1px solid #e5e7eb;
    border-radius: 6px;
    color: #eb8471;
    cursor: pointer;
    transition: all 0.2s ease;
    flex-shrink: 0;
}

.btn-view:hover {
    background: #eb8471;
    color: white;
}

.btn-upload {
    width: 100%;
    padding: 12px;
    background: rgba(50, 101, 115, 0.1);
    color: #326573;
    border: 1px dashed #326573;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s ease;
    font-family: 'Rubik', sans-serif;
}

.btn-upload:hover {
    background: rgba(50, 101, 115, 0.2);
}

/* Payment Status */
.payment-status {
    text-align: center;
}

.payment-badge {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 8px 16px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    margin-bottom: 16px;
}

.payment-badge.paid {
    background: rgba(87, 163, 148, 0.1);
    color: #57a394;
    border: 1px solid rgba(87, 163, 148, 0.3);
}

.payment-details {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.payment-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 8px 0;
    border-bottom: 1px solid #f1f5f9;
}

.payment-item:last-child {
    border-bottom: none;
}

.payment-value {
    font-weight: 600;
    color: #212223;
}

.payment-value.paid {
    color: #57a394;
}

/* Notes */
.notes-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
    margin-bottom: 16px;
    max-height: 200px;
    overflow-y: auto;
}

.note-item {
    padding: 12px;
    background: #f8fafc;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
}

.note-content {
    font-size: 12px;
    color: #6b7280;
    line-height: 1.4;
    margin-bottom: 8px;
}

.note-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.note-author {
    font-size: 10px;
    font-weight: 600;
    color: #212223;
}

.note-date {
    font-size: 10px;
    color: #8f8c89;
}

.note-input {
    display: flex;
    gap: 8px;
}

.note-input textarea {
    flex: 1;
    padding: 12px;
    border: 1px solid #e5e7eb;
    border-radius: 8px;
    resize: none;
    font-size: 12px;
    font-family: 'Rubik', sans-serif;
    min-height: 60px;
}

.note-input textarea:focus {
    outline: none;
    background: #ffffff;
    border-color: #326573;
    box-shadow: 0 0 0 3px rgba(50, 101, 115, 0.1);
}
.btn-add-note {
    padding: 12px;
    background: #57a394;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.2s ease;
    align-self: flex-end;
}

.btn-add-note:hover {
    background: #2a5561;
}

/* Responsive Design */
@media (max-width: 1200px) {
    .workspace-grid {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 768px) {
    .gcsez-application-workspace {
        margin-left: 0;
        padding: 16px;
    }
    
    .header-content {
        flex-direction: column;
        gap: 16px;
    }
    
    .header-status {
        align-items: flex-start;
    }
    
    .action-toolbar {
        justify-content: center;
    }
    
    .metrics-grid {
        grid-template-columns: 1fr 1fr;
    }
    
    .info-grid {
        grid-template-columns: 1fr;
    }
    
    .parcels-grid {
        grid-template-columns: 1fr;
    }
}
</style>

<script src="${pageContext.request.contextPath}/assets/page-js/quality-check.js"></script>
