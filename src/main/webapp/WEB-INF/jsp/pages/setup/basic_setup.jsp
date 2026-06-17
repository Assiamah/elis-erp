<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


<!-- Begin Page Content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

		<!-- <input type="text" id="page_name" value="${page_name}"> -->

        <!-- Page Header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-items-center justify-content-between flex-wrap">
                <div class="d-flex align-items-center gap-2">
                    <div>
                        <h1 class="page-title fw-medium fs-20 mb-1">
                            <i class="ri-settings-3-line me-2 text-primary"></i>Basic Setup
                        </h1>
                        <p class="text-muted mb-0 fs-13">Manage locations and districts</p>
                    </div>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="all_settings">All Settings</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Basic Setup</li>
                </ol>
            </div>
        </div>

        <div class="row">

            <!-- Locations Card -->
            <div class="col-md-6 mb-4">
                <div class="card custom-card">
                    <div class="card-header">
                        <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
                            <div class="card-title mb-0">
                                <i class="ri-map-pin-2-line me-2 text-primary"></i>Locations
                            </div>
                            <div class="d-flex align-items-center gap-2 flex-wrap">
                                <div class="d-flex align-items-center gap-1">
                                    <label class="form-label mb-0 text-muted small">Region:</label>
                                    <select id="district_region_office" class="form-select form-select-sm" style="min-width:180px;">
                                        <option value="-1">Select Office Region</option>
                                        <c:forEach items="${officeregionlist}" var="officeregion">
                                            <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <button type="button"
                                    class="btn btn-primary btn-sm"
                                    data-loc_id="0" data-loc_name=""
                                    data-bs-target="#editLocalityModal"
                                    data-bs-toggle="modal">
                                    <i class="ri-add-line me-1"></i>Add New
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="tblLocations">
                                <thead class="table-light">
                                    <tr>
                                        <th>Location Name</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer text-muted small">Locations</div>
                </div>
            </div>

            <!-- Districts Card -->
            <div class="col-md-6 mb-4">
                <div class="card custom-card">
                    <div class="card-header">
                        <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
                            <div class="card-title mb-0">
                                <i class="ri-road-map-line me-2 text-success"></i>Districts
                            </div>
                            <div class="d-flex align-items-center gap-2 flex-wrap">
                                <div class="d-flex align-items-center gap-1">
                                    <label class="form-label mb-0 text-muted small">Region:</label>
                                    <select id="district_region" class="form-select form-select-sm" style="min-width:180px;">
                                        <option value="-1">Select Region</option>
                                        <c:forEach items="${regionlist}" var="region">
                                            <option value="${region.region_id}">${region.region_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <button type="button"
                                    class="btn btn-success btn-sm"
                                    data-dis_id="0" data-dis_name=""
                                    data-bs-target="#editDistrictModal"
                                    data-bs-toggle="modal">
                                    <i class="ri-add-line me-1"></i>Add New
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="tblDistricts">
                                <thead class="table-light">
                                    <tr>
                                        <th>District Name</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer text-muted small">Districts</div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Add/Edit Locality Modal -->
<div class="modal fade" id="editLocalityModal" tabindex="-1" aria-labelledby="editLocalityModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <div class="d-flex align-items-center gap-3">
                    <div class="avatar avatar-md bg-primary-transparent rounded-circle d-flex align-items-center justify-content-center">
                        <i class="ri-map-pin-2-line text-primary fs-5"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-semibold mb-0" id="editLocalityModalLabel">Add / Edit Locality</h5>
                        <p class="text-muted mb-0 fs-12">Manage location details</p>
                    </div>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="frmEditLocality">
                <div class="modal-body">
                    <input type="hidden" id="loc_locality_id" value="0">
                    <input type="hidden" id="loc_office_id" value="0">
                    <div class="mb-3">
                        <label class="form-label fw-medium">Office / Region</label>
                        <input type="text" class="form-control" id="loc_office_name" disabled placeholder="">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-medium">Locality Name</label>
                        <textarea rows="2" class="form-control" id="loc_locality_name" placeholder="Enter locality name"></textarea>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-between align-items-center">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                        <i class="ri-close-line me-1"></i>Cancel
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="ri-save-line me-1"></i>Save
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Add/Edit District Modal -->
<div class="modal fade" id="editDistrictModal" tabindex="-1" aria-labelledby="editDistrictModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <div class="d-flex align-items-center gap-3">
                    <div class="avatar avatar-md bg-success-transparent rounded-circle d-flex align-items-center justify-content-center">
                        <i class="ri-road-map-line text-success fs-5"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-semibold mb-0" id="editDistrictModalLabel">Add / Edit District</h5>
                        <p class="text-muted mb-0 fs-12">Manage district details</p>
                    </div>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="frmEditDistrict">
                <div class="modal-body">
                    <input type="hidden" id="district_id" value="0">
                    <input type="hidden" id="vregion_id">
                    <div class="mb-3">
                        <label class="form-label fw-medium">Region</label>
                        <input type="hidden" id="region_id">
                        <input class="form-control" id="region_name" readonly placeholder="">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-medium">District Name</label>
                        <textarea rows="2" class="form-control" id="district_name" placeholder="Enter district name"></textarea>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-between align-items-center">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                        <i class="ri-close-line me-1"></i>Cancel
                    </button>
                    <button type="submit" class="btn btn-success">
                        <i class="ri-save-line me-1"></i>Save
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- <jsp:include page="../includes/_footer.jsp"></jsp:include> -->
