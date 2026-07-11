<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>




<!-- Modal 1: LVD Compensation Claim -->
<div class="modal fade effect-scale modal-blur" tabindex="-1" 
id="compparcelinformation" tabindex="-1" aria-labelledby="compparcelinformationLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <!-- Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title fw-semibold" id="compparcelinformationLabel">
                    <i class="fas fa-file-invoice me-2"></i>LVD Compensation Claim
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <form method="POST" action="Maps" target="_blank" id="downloadForm">
                    <input type="hidden" name="cc_id" id="cc_id">
                    
                    <div class="row g-3">
                        <!-- Row 1: Claim No & Claimant -->
                        <div class="col-md-6">
                            <label for="cc_claim_no" class="form-label fw-semibold">Claim No</label>
                            <input class="form-control" type="text" placeholder="Enter Claim No" id="cc_claim_no">
                        </div>
                        <div class="col-md-6">
                            <label for="cc_claimant" class="form-label fw-semibold">Claimant</label>
                            <input class="form-control" type="text" placeholder="Enter Claimant Name" id="cc_claimant">
                        </div>
                        
                        <!-- Row 2: File No & Plan No -->
                        <div class="col-md-6">
                            <label for="cc_file_no" class="form-label fw-semibold">File No</label>
                            <input class="form-control" type="text" placeholder="Enter File No" id="cc_file_no">
                        </div>
                        <div class="col-md-6">
                            <label for="cc_plan_no" class="form-label fw-semibold">Plan No</label>
                            <input class="form-control" type="text" placeholder="Enter Plan No" id="cc_plan_no">
                        </div>
                        
                        <!-- Row 3: Locality & Land Size -->
                        <div class="col-md-6">
                            <label for="cc_locality" class="form-label fw-semibold">Locality</label>
                            <input class="form-control" type="text" placeholder="Enter Locality" id="cc_locality">
                        </div>
                        <div class="col-md-6">
                            <label for="cc_land_size" class="form-label fw-semibold">Land Size</label>
                            <input class="form-control" type="text" placeholder="Enter Land Size" id="cc_land_size">
                        </div>
                        
                        <!-- Row 4: Remarks -->
                        <div class="col-12">
                            <label for="cc_remarks" class="form-label fw-semibold">Remarks</label>
                            <textarea class="form-control" rows="3" placeholder="Enter Remarks" id="cc_remarks"></textarea>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Modal 2: LVD Constructional Details -->
<div class="modal fade" id="newcomparableconstructionaldetails" tabindex="-1" aria-labelledby="newcomparableconstructionaldetailsLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <!-- Header -->
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title fw-semibold" id="newcomparableconstructionaldetailsLabel">
                    <i class="fas fa-building me-2"></i>LVD Constructional Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <form method="POST" action="Maps" target="_blank" id="constructionForm">
                    <input type="hidden" name="cbl_parcel_uuid" id="cbl_parcel_uuid">
                    
                    <div class="row g-3">
                        <!-- Left Column -->
                        <div class="col-md-6">
                            <!-- Job Number -->
                            <div class="mb-3">
                                <label for="cbl_job_no" class="form-label fw-semibold">Job Number</label>
                                <input class="form-control" type="text" placeholder="Enter Job Number" id="cbl_job_no">
                            </div>
                            
                            <!-- Floor Details -->
                            <div class="mb-3">
                                <label for="cbl_accreage_size_of_land" class="form-label fw-semibold">Floor Details</label>
                                <input class="form-control" type="text" placeholder="Enter Floor Details" id="cbl_accreage_size_of_land">
                            </div>
                            
                            <!-- Doors Details -->
                            <div class="mb-3">
                                <label for="cbl_unexpired_term" class="form-label fw-semibold">Doors Details</label>
                                <input class="form-control" type="text" placeholder="Enter Doors Details" id="cbl_unexpired_term">
                            </div>
                            
                            <!-- Ceiling Details -->
                            <div class="mb-3">
                                <label for="cbl_prominent_landmarks" class="form-label fw-semibold">Ceiling Details</label>
                                <textarea class="form-control" rows="3" placeholder="Enter Ceiling Details" id="cbl_prominent_landmarks"></textarea>
                            </div>
                            
                            <!-- Roof Details -->
                            <div class="mb-3">
                                <label for="cbl_value_of_property" class="form-label fw-semibold">Roof Details</label>
                                <input class="form-control" type="text" placeholder="Enter Roof Details" id="cbl_value_of_property">
                            </div>
                            
                            <!-- Other Details -->
                            <div class="mb-3">
                                <label for="cbl_type_of_house" class="form-label fw-semibold">Other Details</label>
                                <input class="form-control" type="text" placeholder="Enter Other Details" id="cbl_type_of_house">
                            </div>
                        </div>
                        
                        <!-- Right Column -->
                        <div class="col-md-6">
                            <!-- Walls Details -->
                            <div class="mb-3">
                                <label for="cbl_confirmed_acre_size" class="form-label fw-semibold">Walls Details</label>
                                <input class="form-control" type="text" placeholder="Enter Walls Details" id="cbl_confirmed_acre_size">
                            </div>
                            
                            <!-- Windows Details -->
                            <div class="mb-3">
                                <label for="cbl_source_data" class="form-label fw-semibold">Windows Details</label>
                                <input class="form-control" type="text" placeholder="Enter Windows Details" id="cbl_source_data">
                            </div>
                            
                            <!-- House Type -->
                            <div class="mb-3">
                                <label for="cbl_locality" class="form-label fw-semibold">House Type</label>
                                <input class="form-control" type="text" placeholder="Enter House Type" id="cbl_locality">
                            </div>
                            
                            <!-- External Works -->
                            <div class="mb-3">
                                <label for="cbl_type_of_use" class="form-label fw-semibold">External Works</label>
                                <input class="form-control" type="text" placeholder="Enter External Works" id="cbl_type_of_use">
                            </div>
                            
                            <!-- Gross External Area -->
                            <div class="mb-3">
                                <label for="cbl_property_owner" class="form-label fw-semibold">Gross External Area</label>
                                <textarea class="form-control" rows="3" placeholder="Enter Gross External Area" id="cbl_property_owner"></textarea>
                            </div>
                            
                            <!-- General Comment -->
                            <div class="mb-3">
                                <label for="cbl_general_omment" class="form-label fw-semibold">General Comment</label>
                                <textarea class="form-control" rows="3" placeholder="Enter General Comment" id="cbl_general_omment"></textarea>
                            </div>
                            
                            <!-- Save Button -->
                            <div class="mt-3">
                                <button type="button" id="btn_save_constructional_comparable_main_changes" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i>Save Changes
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Modal 3: LVD Constructional Details (Point Data) -->
<div class="modal fade" id="newcomparabledatapoint" tabindex="-1" aria-labelledby="newcomparabledatapointLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <!-- Header -->
            <div class="modal-header bg-info text-white">
                <h5 class="modal-title fw-semibold" id="newcomparabledatapointLabel">
                    <i class="fas fa-map-pin me-2"></i>LVD Constructional Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <form method="POST" action="Maps" target="_blank" id="pointForm">
                    <input type="hidden" name="cbl_parcel_uuid_point" id="cbl_parcel_uuid_point">
                    
                    <div class="row g-3">
                        <!-- Left Column -->
                        <div class="col-md-6">
                            <!-- Job Number -->
                            <div class="mb-3">
                                <label for="cbl_job_no_point" class="form-label fw-semibold">Job Number</label>
                                <input class="form-control" type="text" placeholder="Enter Job Number" id="cbl_job_no_point">
                            </div>
                            
                            <!-- Transaction Date -->
                            <div class="mb-3">
                                <label for="cbl_transaction_date_point" class="form-label fw-semibold">Transaction Date</label>
                                <input class="form-control" type="date" id="cbl_transaction_date_point">
                            </div>
                            
                            <!-- Land Size -->
                            <div class="mb-3">
                                <label for="cbl_accreage_size_of_land_point" class="form-label fw-semibold">Land Size</label>
                                <input class="form-control" type="text" placeholder="Enter Land Size" id="cbl_accreage_size_of_land_point">
                            </div>
                            
                            <!-- Confirmed Land Size -->
                            <div class="mb-3">
                                <label for="cbl_confirmed_acre_size_point" class="form-label fw-semibold">Confirmed Land Size</label>
                                <input class="form-control" type="text" placeholder="Enter Confirmed Land Size" id="cbl_confirmed_acre_size_point">
                            </div>
                            
                            <!-- Unexpired Term -->
                            <div class="mb-3">
                                <label for="cbl_unexpired_term_point" class="form-label fw-semibold">Unexpired Term</label>
                                <input class="form-control" type="text" placeholder="Enter Unexpired Term" id="cbl_unexpired_term_point">
                            </div>
                            
                            <!-- Data Source -->
                            <div class="mb-3">
                                <label for="cbl_source_data_point" class="form-label fw-semibold">Data Source</label>
                                <input class="form-control" type="text" placeholder="Enter Data Source" id="cbl_source_data_point">
                            </div>
                            
                            <!-- Property Value -->
                            <div class="mb-3">
                                <label for="cbl_value_of_property_point" class="form-label fw-semibold">Property Value</label>
                                <input class="form-control" type="text" placeholder="Enter Property Value" id="cbl_value_of_property_point">
                            </div>
                            
                            <!-- Prominent Landmarks -->
                            <div class="mb-3">
                                <label for="cbl_prominent_landmarks_point" class="form-label fw-semibold">Prominent Landmarks</label>
                                <textarea class="form-control" rows="3" placeholder="Enter Prominent Landmarks" id="cbl_prominent_landmarks_point"></textarea>
                            </div>
                        </div>
                        
                        <!-- Right Column -->
                        <div class="col-md-6">
                            <!-- Type of House -->
                            <div class="mb-3">
                                <label for="cbl_type_of_house_point" class="form-label fw-semibold">Type of House</label>
                                <input class="form-control" type="text" placeholder="Enter Type of House" id="cbl_type_of_house_point">
                            </div>
                            
                            <!-- Locality -->
                            <div class="mb-3">
                                <label for="cbl_locality_point" class="form-label fw-semibold">Locality</label>
                                <input class="form-control" type="text" placeholder="Enter Locality" id="cbl_locality_point">
                            </div>
                            
                            <!-- Type of Use -->
                            <div class="mb-3">
                                <label for="cbl_type_of_use_point" class="form-label fw-semibold">Type of Use</label>
                                <input class="form-control" type="text" placeholder="Enter Type of Use" id="cbl_type_of_use_point">
                            </div>
                            
                            <!-- Property Owner -->
                            <div class="mb-3">
                                <label for="cbl_property_owner_point" class="form-label fw-semibold">Property Owner</label>
                                <textarea class="form-control" rows="3" placeholder="Enter Property Owner" id="cbl_property_owner_point"></textarea>
                            </div>
                            
                            <!-- Constructional Details Button -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Constructional Details</label>
                                <button type="button" class="btn btn-primary" id="add_new_constructional_details_point" 
                                        data-bs-toggle="modal" data-bs-target="#newcomparabledata" 
                                        data-bs-tooltip="tooltip" title="Add Constructional Details">
                                    <i class="fas fa-map-marker-alt me-1"></i>Add Details
                                </button>
                            </div>
                            
                            <!-- Constructional Details Table -->
                            <div class="mb-3">
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm" id="lvd_construcctional_details_dataTable" width="100%">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Floor Details</th>
                                                <th>Walls Details</th>
                                                <th>Doors Details</th>
                                                <th>Windows Details</th>
                                                <th class="text-center">Details</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Dynamic content -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            
                            <!-- Save Button -->
                            <div class="mt-3">
                                <button type="button" id="btn_save_comparable_main_changes_point" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i>Save Changes
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 & Font Awesome Dependencies -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Initialize Bootstrap tooltips
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-tooltip="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
</script>