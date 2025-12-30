<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>



<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
    .modal-content { border-radius: 12px; border: 1px solid #e5e7eb; overflow: hidden; }
    .modal-header { background: #326573; color: white; border-bottom: none; }
    .modal-header .btn-close { filter: invert(1); }
    .form-label { font-weight: 500; color: #374151; }
    .form-control, textarea.form-control { border-radius: 8px; }
    .btn-primary-custom { background-color: #326573; border: none; border-radius: 8px; }
    .btn-primary-custom:hover { background-color: #2a5561; }
    .table th { background: #f3f4f6; font-weight: 600; color: #374151; }
    .table-hover tbody tr:hover { background-color: #f9fafb; }
</style>

<!-- 1. Main LRD Parcel Information Modal -->
<div class="modal fade" id="lrdparcelIndormation" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">LRD Transaction Information</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row g-4">
                    <!-- Left Column: Parcel Details -->
                    <div class="col-lg-6">
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label">Reference Number</label>
                                <input type="text" class="form-control" id="lrd_ps_reference_number">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Locality</label>
                                <input type="text" class="form-control" id="lrd_ps_locality">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Plotted By</label>
                                <input type="text" class="form-control" id="lrd_ps_plotted_by">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Date Plotted</label>
                                <input type="text" class="form-control" id="lrd_ps_date_plott">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Checked By</label>
                                <input type="text" class="form-control" id="lrd_ps_checked_by">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Type of Plotting</label>
                                <input type="text" class="form-control" id="lrd_ps_type_of_plotting">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Last Update By</label>
                                <input type="text" class="form-control" id="lrd_ps_modified_by" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Date Last Updated</label>
                                <input type="text" class="form-control" id="lrd_ps_modified_date" readonly>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: Transactions & Encumbrances -->
                    <div class="col-lg-6">
                        <!-- Add Transaction Button -->
                        <div class="mb-3">
                            <button type="button" class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#addlrdtransaction">
                                <i class="fas fa-plus-circle me-2"></i>Add New Transaction
                            </button>
                        </div>

                        <!-- Transactions Table -->
                        <h6 class="mb-3">Transactions</h6>
                        <div class="table-responsive mb-4">
                            <table class="table table-striped table-hover" id="lrd_transaction_dataTable">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Grantor</th>
                                        <th>Certificate Number</th>
                                        <th>Instrument Type</th>
                                        <th>Details</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Filled dynamically -->
                                </tbody>
                            </table>
                        </div>

                        <!-- Encumbrance & Caveat Section -->
                        <h6 class="mb-3">Encumbrance and Caveat</h6>
                        <div class="mb-3">
                            <button type="button" class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#lrdpEncumbranceModal">
                                <i class="fas fa-plus-circle me-2"></i>Add New Encumbrance or Caveat
                            </button>
                        </div>
                        <div class="table-responsive mb-4">
                            <table class="table table-striped table-hover" id="lrd_memorial_encumbrance_details_dataTable">
                                <thead>
                                    <tr>
                                        <th>Registered No</th>
                                        <th>Memorials</th>
                                        <th>Date of Instrument</th>
                                        <th>Date of Registration</th>
                                        <th>Details</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${lrd_memorials_section}" var="memorials_section">
                                        <tr>
                                            <td>${memorials_section.m_registered_no}</td>
                                            <td>${memorials_section.m_memorials}</td>
                                            <td>${memorials_section.m_date_of_instrument}</td>
                                            <td>${memorials_section.m_date_of_registration}</td>
                                            <td>
                                                <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#edit">
                                                    <i class="fas fa-edit"></i> Edit
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Scanned Documents Table -->
                        <h6 class="mb-3">Scanned Documents</h6>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover" id="lrd_scanned_documents_dataTable">
                                <thead>
                                    <tr>
                                        <th>Document Name</th>
                                        <th>Document Type</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Filled dynamically -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="lrd_ps_fid" name="lrd_ps_fid">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- 2. Add LRD Transaction Modal -->
<div class="modal fade" id="addlrdtransaction" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add / Edit LRD Transaction</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Hidden Fields -->
                <input type="hidden" id="lrd_td_gid">
                <input type="hidden" id="lrd_td_fid_id_fk">
                <input type="hidden" id="lrd_td_plotted_by_reg">
                <input type="hidden" id="lrd_td_checked_by">
                <input type="hidden" id="lrd_td_plott_date_reg">

                <div class="row g-3">
                    <!-- Column 1 -->
                    <div class="col-lg-4">
                        <div class="mb-3">
                            <label class="form-label">Nature of Instrument</label>
                            <input type="text" class="form-control" id="lrd_td_nature_of_instument">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Date of Registration</label>
                            <input type="text" class="form-control" id="lrd_td_date_of_registration">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Volume</label>
                            <input type="text" class="form-control" id="lrd_td_volume">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Folio</label>
                            <input type="text" class="form-control" id="lrd_td_folio">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Date of Issue Certificate No</label>
                            <input type="text" class="form-control" id="lrd_td_date_of_issued_cert_no">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Type of Certificate</label>
                            <input type="text" class="form-control" id="lrd_td_type_of_certificate">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Registered No</label>
                            <input type="text" class="form-control" id="lrd_td_registered_number">
                        </div>
                    </div>

                    <!-- Column 2 -->
                    <div class="col-lg-4">
                        <div class="mb-3">
                            <label class="form-label">CC Number</label>
                            <input type="text" class="form-control" id="lrd_td_cc_number">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Certificate Number</label>
                            <input type="text" class="form-control" id="lrd_td_certicate_number">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Applicant Name</label>
                            <input type="text" class="form-control" id="lrd_td_applicant_name">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Grantor Name</label>
                            <input type="text" class="form-control" id="lrd_td_grantor_name">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Job Number</label>
                            <input type="text" class="form-control" id="lrd_td_job_number">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Type of Instrument</label>
                            <input type="text" class="form-control" id="lrd_td_type_instrument">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Date of Instrument</label>
                            <input type="text" class="form-control" id="lrd_td_date_of_instument">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Consideration</label>
                            <input type="text" class="form-control" id="lrd_td_consideration">
                        </div>
                    </div>

                    <!-- Column 3 -->
                    <div class="col-lg-4">
                        <div class="mb-3">
                            <label class="form-label">Purpose</label>
                            <input type="text" class="form-control" id="lrd_td_purpose">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Date Commencement</label>
                            <input type="text" class="form-control" id="lrd_td_date_commencement">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Term</label>
                            <input type="text" class="form-control" id="lrd_td_term">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Remarks</label>
                            <input type="text" class="form-control" id="lrd_td_remarks">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Type of Registration</label>
                            <input type="text" class="form-control" id="lrd_td_type_of_registration">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Land Size</label>
                            <input type="text" class="form-control" id="lrd_td_land_size">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Reference Number</label>
                            <input type="text" class="form-control" id="lrd_td_reference_number" readonly>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Last Update By</label>
                                <input type="text" class="form-control" id="lrd_td_modified_by" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Date Last Updated</label>
                                <input type="text" class="form-control" id="lrd_td_modified_date" readonly>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="button" class="btn btn-primary-custom btn-lg px-5" id="btn_save_lrd_transaction">
                        Save Data
                    </button>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- 3. Add Coordinates / Parcel WKT Modal -->
<div class="modal fade" id="lrdparcelinformationdetailsmain" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">LRD Parcel Info - Coordinates</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label">Point Name 1</label>
                        <input type="text" class="form-control" id="bl_coordiante_name1">
                    </div>
                    <div class="col-12">
                        <label class="form-label">X-Coordinate</label>
                        <textarea rows="3" class="form-control" id="bl_X_coordinate"></textarea>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Y-Coordinate</label>
                        <textarea rows="3" class="form-control" id="bl_y_coordinate"></textarea>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Point Name 2</label>
                        <input type="text" class="form-control" id="bl_coordiante_name2">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Parcel WKT</label>
                        <input type="text" class="form-control" id="lrd_parcel_wkt_main">
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-center">
                <button type="button" class="btn btn-success me-3" id="btnsavelrdparcelmain">
                    <i class="fas fa-check me-2"></i>Save
                </button>
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

