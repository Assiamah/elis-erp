<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.gcsez-quality-control {
    background: #f8fafc;
    min-height: calc(100vh - 70px);
    margin-top: 70px;
    margin-left: 260px;
    padding: 24px;
    font-family: 'Rubik', sans-serif;
}

.gcsez-breadcrumb {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 24px;
}

.gcsez-breadcrumb-title {
    color: #212121;
    font-size: 1.5rem;
    font-weight: 600;
    margin: 0;
}

.gcsez-breadcrumb-nav {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 0.875rem;
    color: #928d89;
}

.gcsez-breadcrumb-nav a {
    color: #928d89;
    text-decoration: none;
}

.gcsez-breadcrumb-nav a:hover {
    color: #326573;
}

.gcsez-action-buttons {
    display: flex;
    gap: 12px;
    margin-bottom: 24px;
    flex-wrap: wrap;
}

.gcsez-btn {
    background: #326573;
    color: white;
    border: none;
    border-radius: 8px;
    padding: 10px 20px;
    font-size: 0.875rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
    gap: 6px;
    text-decoration: none;
}

.gcsez-btn:hover {
    background: #2a5561;
    transform: translateY(-1px);
    color: white;
    text-decoration: none;
}

.gcsez-btn.success {
    background: #57a394;
}

.gcsez-btn.success:hover {
    background: #4a8c7e;
}

.gcsez-btn.warning {
    background: #c5bb85;
    color: #212121;
}

.gcsez-btn.warning:hover {
    background: #b4a972;
}

.gcsez-main-card {
    background: #ffffff;
    border: 1px solid #e5e7eb;
    border-radius: 12px;
    overflow: hidden;
}

.gcsez-card-header {
    padding: 24px;
    border-bottom: 1px solid #e5e7eb;
}

.gcsez-card-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #212121;
    margin: 0 0 8px 0;
}

.gcsez-card-description {
    color: #928d89;
    font-size: 0.875rem;
    margin: 0;
    line-height: 1.5;
    font-weight: 100;
}

.gcsez-card-body {
    padding: 24px;
}

/* DataTable Customization */
#application-datatable_wrapper {
    font-family: 'Rubik', sans-serif;
}

#application-datatable {
    border: 1px solid #e5e7eb;
    border-radius: 8px;
    overflow: hidden;
}

#application-datatable thead th {
    background: #f9fafb;
    border-bottom: 1px solid #e5e7eb;
    padding: 12px 16px;
    font-weight: 600;
    color: #374151;
    font-size: 0.875rem;
}

#application-datatable tbody td {
    padding: 12px 16px;
    border-bottom: 1px solid #f3f4f6;
    font-size: 0.875rem;
    color: #6b7280;
}

#application-datatable tbody tr:hover {
    background: #f9fafb;
}

/* Status Badges */
.gcsez-badge {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    text-transform: capitalize;
}

.gcsez-badge.success { 
    background: rgba(87, 163, 148, 0.1); 
    color: #57a394; 
    border: 1px solid rgba(87, 163, 148, 0.3);
}

.gcsez-badge.warning { 
    background: rgba(197, 187, 133, 0.1); 
    color: #c5bb85; 
    border: 1px solid rgba(197, 187, 133, 0.3);
}

.gcsez-badge.danger { 
    background: rgba(180, 132, 120, 0.1); 
    color: #b48478; 
    border: 1px solid rgba(180, 132, 120, 0.3);
}

.gcsez-badge.info { 
    background: rgba(235, 132, 113, 0.1); 
    color: #eb8471; 
    border: 1px solid rgba(235, 132, 113, 0.3);
}

/* Action Buttons */
.gcsez-btn-group {
    display: flex;
    gap: 6px;
    justify-content: flex-end;
}

.gcsez-btn-icon {
    width: 32px;
    height: 32px;
    border: 1px solid #e5e7eb;
    border-radius: 6px;
    background: white;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.2s ease;
    font-size: 0.875rem;
}

.gcsez-btn-icon:hover {
    background: #f9fafb;
    border-color: #d1d5db;
    transform: translateY(-1px);
}

.gcsez-btn-icon.view { 
    color: #326573; 
    border-color: rgba(50, 101, 115, 0.2);
    background: rgba(50, 101, 115, 0.1);
}

.gcsez-btn-icon.edit { 
    color: #57a394; 
    border-color: rgba(87, 163, 148, 0.2);
    background: rgba(87, 163, 148, 0.1);
}

.gcsez-btn-icon.cancel { 
    color: #b48478; 
    border-color: rgba(180, 132, 120, 0.2);
    background: rgba(180, 132, 120, 0.1);
}

/* DataTable Controls */
.dt-buttons {
    margin-bottom: 16px;
}

.dt-buttons .btn {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 12px;
    font-size: 0.875rem;
    margin-right: 8px;
    margin-bottom: 8px;
    transition: all 0.2s ease;
}

.dt-buttons .btn-outline-danger {
    border-color: #b48478;
    color: #b48478;
}

.dt-buttons .btn-outline-danger:hover {
    background: #b48478;
    border-color: #b48478;
    color: white;
}

.dt-buttons .btn-outline-success {
    border-color: #57a394;
    color: #57a394;
}

.dt-buttons .btn-outline-success:hover {
    background: #57a394;
    border-color: #57a394;
    color: white;
}

.dt-buttons .btn-outline-info {
    border-color: #326573;
    color: #326573;
}

.dt-buttons .btn-outline-info:hover {
    background: #326573;
    border-color: #326573;
    color: white;
}

.dataTables_filter {
    margin-bottom: 16px;
}

.dataTables_filter label {
    font-size: 0.875rem;
    color: #928d89;
}

.dataTables_filter input {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 12px;
    font-size: 0.875rem;
    margin-left: 8px;
    transition: all 0.2s ease;
}

.dataTables_filter input:focus {
    border-color: #326573;
    box-shadow: 0 0 0 2px rgba(50, 101, 115, 0.1);
    outline: none;
}

.dataTables_info {
    font-size: 0.875rem;
    color: #928d89;
    padding-top: 12px;
}

.dataTables_paginate {
    padding-top: 12px;
}

.dataTables_paginate .paginate_button {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 12px;
    margin-left: 4px;
    font-size: 0.875rem;
    color: #374151;
    text-decoration: none;
    transition: all 0.2s ease;
}

.dataTables_paginate .paginate_button.current {
    background: #326573;
    color: white;
    border-color: #326573;
}

.dataTables_paginate .paginate_button:hover {
    background: #57a394;
    border-color: #57a394;
    color: white;
}

/* Mobile Responsiveness */
@media (max-width: 768px) {
    .gcsez-quality-control {
        margin-left: 0;
        padding: 16px;
    }
    
    .gcsez-breadcrumb {
        flex-direction: column;
        align-items: flex-start;
        gap: 12px;
    }
    
    .gcsez-action-buttons {
        flex-direction: column;
        align-items: stretch;
    }
    
    .gcsez-btn {
        justify-content: center;
    }
    
    .gcsez-btn-group {
        justify-content: center;
    }
    
    #application-datatable_wrapper {
        overflow-x: auto;
    }
}

/* Loading State */
.gcsez-loading {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px;
    color: #928d89;
    font-size: 0.875rem;
}

/* Empty State */
.gcsez-empty-state {
    text-align: center;
    padding: 40px;
    color: #928d89;
}

.gcsez-empty-state i {
    font-size: 3rem;
    margin-bottom: 16px;
    color: #d1d5db;
}

.gcsez-empty-state h4 {
    color: #928d89;
    margin-bottom: 8px;
}

/* Tooltip Customization */
.tooltip-white .tooltip-inner {
    background: white;
    color: #374151;
    border: 1px solid #e5e7eb;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

/* Tracking Timeline Styles */
.gcsez-tracking-timeline {
    position: relative;
    padding-left: 30px;
    margin: 20px 0;
}

.gcsez-timeline-progress {
    position: absolute;
    left: 11px;
    top: 10px;
    bottom: 10px;
    width: 4px;
    background-color: #e9ecef;
    border-radius: 2px;
    overflow: hidden;
}

.gcsez-progress-bar {
    background: linear-gradient(to bottom, #326573, #57a394);
    width: 100%;
    border-radius: 2px;
    transition: height 0.5s ease;
}

.gcsez-timeline-item {
    position: relative;
    margin-bottom: 25px;
}

.gcsez-timeline-item:last-child {
    margin-bottom: 0;
}

.gcsez-timeline-icon {
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
    font-size: 0.75rem;
}

.gcsez-timeline-item.completed .gcsez-timeline-icon {
    background-color: #57a394;
    border-color: #57a394;
    color: white;
}

.gcsez-timeline-item.active .gcsez-timeline-icon {
    background-color: #326573;
    border-color: #326573;
    color: white;
}

.gcsez-timeline-content {
    background-color: #f8f9fa;
    border-radius: 10px;
    padding: 15px;
    border-left: 3px solid #e9ecef;
}

.gcsez-timeline-item.completed .gcsez-timeline-content {
    border-left-color: #57a394;
}

.gcsez-timeline-item.active .gcsez-timeline-content {
    border-left-color: #326573;
}

.gcsez-timeline-title {
    font-weight: 600;
    margin-bottom: 5px;
    color: #212121;
    font-size: 0.875rem;
}

.gcsez-timeline-item.completed .gcsez-timeline-title {
    color: #57a394;
}

.gcsez-timeline-item.active .gcsez-timeline-title {
    color: #326573;
}

.gcsez-timeline-date {
    font-size: 0.75rem;
    color: #928d89;
    margin-bottom: 8px;
}

.gcsez-timeline-description {
    font-size: 0.75rem;
    color: #928d89;
    margin-bottom: 0;
}

</style>

<main class="gcsez-quality-control">
    <div class="gcsez-breadcrumb">
        <h1 class="gcsez-breadcrumb-title">Quality Control</h1>
        <nav class="gcsez-breadcrumb-nav">
            <a href="javascript:void(0)">Lease Application</a>
            <span>/</span>
            <span>Quality Control</span>
        </nav>
    </div>

    <div class="gcsez-main-card">
        <div class="gcsez-card-header">
            <h2 class="gcsez-card-title">Lease Applications</h2>
            <p class="gcsez-card-description">
                Monitor and review submitted lease applications with this interactive table.  
                Perform quality checks on applicant details, parcel information, land use, and application status to ensure accuracy and compliance.
            </p>
        </div>
        <div class="gcsez-card-body">
            <div class="table-responsive">
                <table id="application-datatable" class="table table-striped dt-responsive w-100">
                    <thead>
                        <tr>
                            <th>Lodgement Number</th>
                            <th>Applicant</th>
                            <th>Parcel Details</th>
                            <th>Land Use</th>
                            <th>Size</th>
                            <th>Submitted Date</th>
                            <th class="text-center">Status</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

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


<script src="${pageContext.request.contextPath}/assets/page-js/quality-control.js"></script>
