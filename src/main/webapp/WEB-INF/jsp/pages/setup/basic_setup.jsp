<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<div class="main-content app-content">
    <div class="container-fluid page-container">

  
   <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Basic Settings</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Manage application setup</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Basic Settings</li>
                </ol>
            </div>
        </div>

		<div class="row g-4">
			<!-- Locations Card -->
			<div class="col-md-6">
				<div class="card h-100 border-0 shadow-sm">
					<!-- Card Header -->
					<div class="card-header border-0 rounded-top-4 py-3">
						<div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
							<div class="d-flex align-items-center gap-2">
								<i class="fas fa-map-marker-alt text-danger fa-lg"></i>
								<h3 class="h5 mb-0 fw-semibold">Locations</h3>
							</div>
							<div class="d-flex align-items-center gap-3 flex-grow-1 justify-content-end">
								<div class="d-flex align-items-center gap-2">
									<label class="text-white-50 small mb-0">Filter by Region:</label>
									<select id="district_region_office" class="form-select" style="min-width: 150px;">
										<option value="-1" class="text-dark">All Regions</option>
										<!-- JSP content will populate options -->
										<c:forEach items="${officeregionlist}" var="officeregion">
											<option value="${officeregion.ord_region_code}" class="text-dark">
												${officeregion.ord_region_name}
											</option>
										</c:forEach>
									</select>
								</div>
								<a href="#" class="btn btn-sm btn-primary" 
								data-loc_id="0" data-loc_name="" 
								data-bs-target="#editLocalityModal" data-bs-toggle="modal">
									<i class="fas fa-plus me-1"></i> Add Location
								</a>
							</div>
						</div>
					</div>
					
					<!-- Card Body -->
					<div class="card-body p-0">
						<div class="table-responsive">
							<table class="table table-hover align-middle mb-0" id="tblLocations">
								<thead class="table-light">
									<tr>
										<th class="py-3 ps-4">Location Name</th>
										<th class="py-3 text-center" style="width: 100px">Actions</th>
									</tr>
								</thead>
								<tbody>
									<!-- Dynamic content will be populated here -->
								</tbody>
							</table>
						</div>
					</div>
					
					<!-- Card Footer -->
					<div class="card-footer bg-light border-0 rounded-bottom-4 py-2">
						<small class="text-muted">
							<i class="fas fa-database me-1"></i> Manage office locations
						</small>
					</div>
				</div>
			</div>
			
			<!-- Districts Card -->
			<div class="col-md-6">
				<div class="card h-100 border-0 shadow-sm">
					<!-- Card Header -->
					<div class="card-header border-0 rounded-top-4 py-3">
						<div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
							<div class="d-flex align-items-center gap-2">
								<i class="fas fa-building text-danger fa-lg"></i>
								<h3 class="h5 mb-0 fw-semibold">Districts</h3>
							</div>
							<div class="d-flex align-items-center gap-3 flex-grow-1 justify-content-end">
								<div class="d-flex align-items-center gap-2">
									<label class="text-white-50 small mb-0">Filter by Region:</label>
									<select id="district_region" class="form-select" style="min-width: 150px;">
										<option value="-1" class="text-dark">All Regions</option>
										<!-- JSP content will populate options -->
										<c:forEach items="${regionlist}" var="region">
											<option value="${region.region_id}" class="text-dark">
												${region.region_name}
											</option>
										</c:forEach>
									</select>
								</div>
								<a href="#" class="btn btn-sm btn-primary" 
								data-dis_id="0" data-dis_name="" 
								data-bs-target="#editDistrictModal" data-bs-toggle="modal">
									<i class="fas fa-plus me-1"></i> Add District
								</a>
							</div>
						</div>
					</div>
					
					<!-- Card Body -->
					<div class="card-body p-0">
						<div class="table-responsive">
							<table class="table table-hover align-middle mb-0" id="tblDistricts">
								<thead class="table-light">
									<tr>
										<th class="py-3 ps-4">District Name</th>
										<th class="py-3 text-center" style="width: 100px">Actions</th>
									</tr>
								</thead>
								<tbody>
									<!-- Dynamic content will be populated here -->
								</tbody>
							</table>
						</div>
					</div>
					
					<!-- Card Footer -->
					<div class="card-footer bg-light border-0 rounded-bottom-4 py-2">
						<small class="text-muted">
							<i class="fas fa-database me-1"></i> Manage regional districts
						</small>
					</div>
				</div>
			</div>
		</div>

 </div>
 </div>

 
<!-- Edit Locality Modal - Bootstrap 5 -->
<div class="modal fade modal-blur" id="editLocalityModal" tabindex="-1" aria-labelledby="editLocalityModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header bg-gradient-primary text-white border-0 rounded-top-4">
                <h4 class="modal-title fw-semibold" id="editLocalityModalLabel">
                    <i class="fas fa-map-marker-alt me-2"></i>Add / Edit Locality
                </h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <form id="frmEditLocality">
                <div class="modal-body p-4">
                    <input type="hidden" id="loc_locality_id" value="0">
                    <input type="hidden" id="loc_office_id" value="0">
                    
                    <!-- Office/Region Field -->
                    <div class="mb-4">
                        <label class="form-label fw-semibold text-secondary">
                            <i class="fas fa-building me-1"></i> Office / Region
                        </label>
                        <input type="text" class="form-control bg-light" 
                               id="loc_office_name" disabled>
                        <small class="text-muted">Region is automatically assigned</small>
                    </div>
                    
                    <!-- Locality Name Field -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-secondary">
                            <i class="fas fa-location-dot me-1"></i> Locality Name <span class="text-danger">*</span>
                        </label>
                        <textarea rows="3" class="form-control" 
                                  id="loc_locality_name" 
                                  placeholder="Enter locality name..."></textarea>
                    </div>
                </div>
                
                <div class="modal-footer bg-light border-0 rounded-bottom-4 p-3">
                    <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Cancel
                    </button>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="fas fa-save me-2"></i>Save Locality
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit District Modal - Bootstrap 5 -->
<div class="modal fade modal-blur" id="editDistrictModal" tabindex="-1" aria-labelledby="editDistrictModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header bg-gradient-primary text-white border-0 rounded-top-4">
                <h4 class="modal-title fw-semibold" id="editDistrictModalLabel">
                    <i class="fas fa-building me-2"></i>Add / Edit District
                </h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <form id="frmEditDistrict">
                <div class="modal-body p-4">
                    <input type="hidden" id="district_id" value="0">
                    <input type="hidden" id="vregion_id" value="">
                    
                    <!-- Region Field -->
                    <div class="mb-4">
                        <label class="form-label fw-semibold text-secondary">
                            <i class="fas fa-globe me-1"></i> Region
                        </label>
                        <input type="text" class="form-control bg-light" 
                               id="region_name" readonly>
                        <input type="hidden" id="region_id">
                        <small class="text-muted">Select region from the main panel</small>
                    </div>
                    
                    <!-- District Name Field -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-secondary">
                            <i class="fas fa-city me-1"></i> District Name <span class="text-danger">*</span>
                        </label>
                        <textarea rows="3" class="form-control" 
                                  id="district_name" 
                                  placeholder="Enter district name..."></textarea>
                    </div>
                </div>
                
                <div class="modal-footer bg-light border-0 rounded-bottom-4 p-3">
                    <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Cancel
                    </button>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="fas fa-save me-2"></i>Save District
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

