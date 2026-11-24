<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="modal fade effect-scale modal-blur" id="addNewserviceBillModalonCase" tabindex="-1" aria-labelledby="addNewserviceBillModalLabel" data-bs-keyboard="false" data-bs-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow">
      <!-- Modal Header -->
      <div class="modal-header bg-gradient-primary text-white rounded-top">
        <div class="d-flex align-items-center w-100">
          <div class="flex-grow-1">
            <h5 class="modal-title fw-semibold mb-0" id="addNewserviceBillModalLabel">
              <i class="fas fa-file-invoice me-2"></i>New Service Bill
            </h5>
          </div>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
      </div>

      <!-- Modal Body -->
      <div class="modal-body p-4">
        <!-- Service Selection Section -->
        <div class="card border-0 shadow-sm mb-4">
          <div class="card-header bg-light py-3">
            <h6 class="mb-0 fw-semibold"><i class="fas fa-cog me-2 text-primary"></i>Service Selection</h6>
          </div>
          <div class="card-body">
            <form id="from_add_valuation">
              <input id="action_on_form_valuation" type="hidden">
              <div class="row g-3">
                <div class="col-md-6">
                  <label for="main_service_on_case" class="form-label fw-medium">Main Service <span class="text-danger">*</span></label>
                  <select name="main_service_on_case" id="main_service_on_case" class="form-select form-select-sm" data-style="btn-info" data-live-search="true">
                    <!-- Options will be populated dynamically -->
                  </select>
                </div>
                <div class="col-md-6">
                  <label for="sub_service_on_case" class="form-label fw-medium">Sub Service <span class="text-danger">*</span></label>
                  <select name="sub_service_on_case" id="sub_service_on_case" class="form-select form-select-sm" data-style="btn-info" data-live-search="true">
                    <option value="-1">Select Sub Service</option>
                  </select>
                </div>
              </div>
            </form>
          </div>
        </div>

        <!-- Surveyor Information Section -->
        <div class="card border-0 shadow-sm mb-4" id="oncasereg-no-div" style="display: none;">
          <div class="card-header bg-light py-3">
            <h6 class="mb-0 fw-semibold"><i class="fas fa-user-tie me-2 text-warning"></i>Surveyor Information</h6>
          </div>
          <div class="card-body">
            <div class="row g-3">
              <div class="col-md-6">
                <label for="new_bill_application_ls_number_oncase" class="form-label fw-medium">Surveyor's Number</label>
                <div class="input-group">
                  <input class="form-control" id="new_bill_application_ls_number_oncase" name="ls_number" type="text" value="${licensed_surveyor_number}" readonly>
                  <button type="button" class="btn btn-primary" id="lc_btn_check_status_of_lincense_surveyor_oncase" data-bs-toggle="tooltip" title="Search Surveyor">
                    <i class="fas fa-search"></i>
                  </button>
                </div>
              </div>
              <div class="col-md-6">
                <label for="new_bill_application_surveyors_name_oncase" class="form-label fw-medium">Surveyor's Name</label>
                <input class="form-control" id="new_bill_application_surveyors_name_oncase" name="new_bill_application_surveyors_name_oncase" type="text" readonly>
              </div>
              <div class="col-md-6">
                <label for="new_bill_application_surveyors_status_oncase" class="form-label fw-medium">Surveyor's Status</label>
                <input class="form-control" id="new_bill_application_surveyors_status_oncase" name="new_bill_application_surveyors_status_oncase" type="text" readonly>
              </div>
            </div>
          </div>
        </div>

        <!-- Checklist Section -->
        <div class="card border-0 shadow-sm mb-4">
          <div class="card-header bg-light py-3 d-flex justify-content-between align-items-center">
            <h6 class="mb-0 fw-semibold"><i class="fas fa-tasks me-2 text-success"></i>Service Checklist</h6>
            <span class="badge bg-primary">${main_service_desc}</span>
          </div>
          <div class="card-body p-0">
            <div class="table-responsive">
              <table class="table table-hover mb-0" id="on_case_checlist_table_billdataTable">
                <thead class="table-light">
                  <tr>
                    <th class="py-3 px-4 fw-medium">Description</th>
                    <th class="py-3 px-4 fw-medium text-center">Options</th>
                  </tr>
                </thead>
                <tbody>
                  <!-- Checklist items will be populated here -->
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <!-- Client and Case Information -->
        <div class="card border-0 shadow-sm mb-4">
          <div class="card-header bg-light py-3">
            <h6 class="mb-0 fw-semibold"><i class="fas fa-users me-2 text-info"></i>Applicant Information</h6>
          </div>
          <div class="card-body">
            <div class="row g-3">
              <div class="col-md-6">
                <label for="on_application_client_name" class="form-label fw-medium">Client Name</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="fas fa-user"></i></span>
                  <input class="form-control" id="on_application_client_name" name="on_application_client_name" type="text" value="${ar_name}" readonly>
                </div>
              </div>
              <div class="col-md-6">
                <label for="new_bill_case_number_on_case" class="form-label fw-medium">Transaction Number</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                  <input class="form-control" id="new_bill_case_number_on_case" name="new_bill_case_number" type="text" value="${case_number}" readonly>
                </div>
              </div>
            </div>
            <div class="mt-4">
              <div class="d-flex justify-content-between align-items-center mb-2 gap-3">
                <div>
                  <!-- <h6 class="mb-1 fw-semibold"><i class="fas fa-users me-2 text-info"></i>Applicant Information</h6> -->
                  <small class="text-muted">Yellow rows need a valid Ghana Card and complete details. Case applicant names cannot be changed or removed.</small>
                </div>
                <div class="d-flex align-items-center gap-2 flex-shrink-0">
                  <span class="badge bg-light text-dark" id="onCaseServiceBillApplicantCount">Loading</span>
                  <button type="button" class="btn btn-primary btn-sm" id="onCaseAddApplicant"><i class="fas fa-user-plus me-1"></i>Add applicant</button>
                </div>
              </div>
              <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="onCaseServiceBillApplicantsTable">
                  <thead class="table-light"><tr><th>Applicant</th><th>Type / Gender</th><th>Address</th><th>Phone</th><th class="text-end">Action</th></tr></thead>
                  <tbody id="onCaseServiceBillApplicantsBody">
                    <tr><td colspan="5" class="text-center text-muted py-3">Applicant names will appear here.</td></tr>
                  </tbody>
                </table>
              </div>
              <input type="hidden" id="onCaseApplicantsJson" value="[]">
            </div>
          </div>
        </div>

        <!-- Additional Details Section -->
        <div class="card border-0 shadow-sm mb-4">
          <div class="card-header bg-light py-3">
            <h6 class="mb-0 fw-semibold"><i class="fas fa-info-circle me-2 text-secondary"></i>Additional Details</h6>
          </div>
          <div class="card-body">
            <!-- Office Region -->
            <div class="row g-3">
              <div class="col-md-6">
                <label for="new_bill_application_office_region_on_case" class="form-label fw-medium">Office Region</label>
                <select name="new_bill_application_office_region_on_case" id="new_bill_application_office_region_on_case" class="form-select form-select-sm" data-style="btn-info" data-live-search="true">
                  <option value="-1">Select Office Region</option>
                  <c:forEach items="${officeregionlist}" var="officeregion">
                    <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                  </c:forEach>
                </select>
              </div>
            </div>

            <!-- Land Size & Locality -->
            <div class="row g-3 mt-2" id="oncasereglandsize-no-div">
              <div class="col-md-6">
                <label for="new_bill_land_size_on_case" class="form-label fw-medium">Land Size (Acres)</label>
                <div class="input-group">
                  <input class="form-control" id="new_bill_land_size_on_case" name="new_bill_land_size_on_case" type="text" placeholder="Enter land size">
                  <span class="input-group-text">acres</span>
                </div>
              </div>
              <div class="col-md-6">
                <label for="new_bill_locality_on_case_1" class="form-label fw-medium">Locality</label>
                <input class="form-control" id="new_bill_locality_on_case_1" name="new_bill_locality_on_case_1" type="text" placeholder="Enter locality">
              </div>
            </div>

            <!-- Stamping Details -->
            <div class="row g-3 mt-2" id="oncasestp-no-div" style="display: none;">
              <div class="col-md-6">
                <label for="new_number_of_copies_on_case" class="form-label fw-medium">Number of Copies</label>
                <input class="form-control" id="new_number_of_copies_on_case" name="new_number_of_copies_on_case" type="number" placeholder="Enter No of Copies" min="1">
              </div>
              <div class="col-md-6">
                <label for="new_bill_type_of_use_on_case" class="form-label fw-medium">Type of Use</label>
                <select name="type_of_use" id="new_bill_type_of_use_on_case" class="form-select form-select-sm" data-live-search="true">
                  <option value="-1">Select Type of Use</option>
                </select>
              </div>
              <div class="col-md-6">
                <label for="new_type_of_revenue_item_on_case" class="form-label fw-medium">Nature of Instrument</label>
                <select name="new_type_of_revenue_item_on_case" id="new_type_of_revenue_item_on_case" class="form-select form-select-sm" data-live-search="true">
                  <option value="-1">Select Nature of Interest</option>
                </select>
              </div>
            </div>

            <!-- Registration Forms -->
            <div class="row g-3 mt-2" id="oncasefreg-no-div" style="display: none;">
              <div class="col-md-6">
                <label for="new_bill_registration_forms_on_case" class="form-label fw-medium">Forms</label>
                <select name="new_bill_registration_forms_on_case" id="new_bill_registration_forms_on_case" class="form-select form-select-sm" data-live-search="true">
                  <option value="-1">Select Registration Forms</option>
                </select>
              </div>
            </div>

            <!-- Publication Type -->
            <div class="row g-3 mt-2" id="oncasefpublication-no-div" style="display: none;">
              <div class="col-md-6">
                <label for="new_bill_publication_type_on_case" class="form-label fw-medium">Publication Type</label>
                <select name="new_bill_publication_type_on_case" id="new_bill_publication_type_on_case" class="form-select form-select-sm">
                  <option value="normal_publication">Normal Publication</option>
                  <option value="special_publication">Special Publication</option>
                </select>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Modal Footer -->
      <div class="modal-footer bg-light rounded-bottom p-3">
        <div class="d-flex justify-content-between w-100">
          <div>
            <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
              <i class="fas fa-times me-2"></i>Close
            </button>
          </div>
          <div>
            <button type="button" class="btn btn-primary px-4" id="btn_save_to_generate_on_application">
              <i class="fas fa-arrow-right me-2"></i>Generate Bill
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="onCaseApplicantDetailsModal" tabindex="-1" aria-labelledby="onCaseApplicantDetailsTitle" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow">
      <div class="modal-header bg-light">
        <div class="d-flex align-items-center gap-3">
          <span class="d-inline-flex align-items-center justify-content-center rounded-circle bg-primary-subtle text-primary" style="width:40px;height:40px"><i class="fas fa-user-edit"></i></span>
          <div><small class="text-muted text-uppercase">Applicant details</small><h5 class="modal-title mb-0" id="onCaseApplicantDetailsTitle">Update applicant</h5></div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p class="text-muted small" id="onCaseApplicantEditorHelp">Update this applicant's contact and identity details. The applicant name is fixed from the case.</p>
        <input type="hidden" id="onCaseApplicantEditIndex">
        <div class="mb-3"><label class="form-label" for="onCaseApplicantName">Full name <span class="text-danger" id="onCaseApplicantNameRequired" style="display:none">*</span></label><input class="form-control bg-light" id="onCaseApplicantName" maxlength="160" readonly></div>
        <div class="mb-3"><label class="form-label" for="onCaseApplicantGhanaCard">Ghana Card number <span class="text-danger">*</span></label><input class="form-control" id="onCaseApplicantGhanaCard" maxlength="15" placeholder="GHA-123456789-0" autocomplete="off"></div>
        <div class="mb-3"><label class="form-label" for="onCaseApplicantGender">Applicant type / gender <span class="text-danger">*</span></label><select class="form-select" id="onCaseApplicantGender"><option value="">Select applicant type or gender</option><option>Male</option><option>Female</option><option>Couple</option><option>Company</option><option>Multiple</option></select></div>
        <div class="mb-3"><label class="form-label" for="onCaseApplicantAddress">Address <span class="text-danger">*</span></label><input class="form-control" id="onCaseApplicantAddress" maxlength="300" placeholder="Enter residential or postal address"></div>
        <div><label class="form-label" for="onCaseApplicantPhone">Phone number <span class="text-danger">*</span></label><input class="form-control" id="onCaseApplicantPhone" type="tel" maxlength="40" placeholder="Enter contact phone number"></div>
      </div>
      <div class="modal-footer"><button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button><button type="button" class="btn btn-primary" id="saveOnCaseApplicantDetails"><i class="fas fa-save me-1"></i><span>Save details</span></button></div>
    </div>
  </div>
</div>

