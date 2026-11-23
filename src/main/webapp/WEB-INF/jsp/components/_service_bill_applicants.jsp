<!-- Client Information -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-light py-3 d-flex justify-content-between align-items-center gap-3">
                        <div>
                            <h6 class="mb-1 fw-semibold"><i class="fas fa-users me-2 text-info"></i>Applicant Information</h6>
                            <small class="text-muted">Add the people included in this application.</small>
                        </div>
                        <button type="button" class="btn btn-primary btn-sm" data-open-applicant-modal>
                            <i class="fas fa-user-plus me-1"></i>Add applicant
                        </button>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="checklistApplicantsTable">
                                <thead class="table-light">
                                    <tr><th>Applicant</th><th>Type / Gender</th><th>Address</th><th>Phone</th><th class="text-end">Action</th></tr>
                                </thead>
                                <tbody id="checklistApplicantsBody">
                                    <tr class="lc-applicant-empty-row"><td colspan="5" class="text-center text-muted py-4"><i class="fas fa-users me-2"></i><strong>No applicants added yet</strong><div class="small mt-1">Add the first applicant to continue.</div></td></tr>
                                </tbody>
                            </table>
                        </div>
                        <input type="hidden" id="checklistApplicantsJson" name="applicants_json" value="[]">
                        <input type="hidden" id="new_bill_application_client_name">
                        <input type="hidden" id="new_bill_application_client_gender">
                        <input type="hidden" id="new_bill_application_client_address">
                        <input type="hidden" id="new_bill_application_client_phone_number">
                        <div class="px-3 py-2 border-top bg-light">
                            <label for="new_bill_application_client_id" class="form-label small fw-semibold mb-1">Client Reference</label>
                            <input type="text" class="form-control form-control-sm bg-light" style="cursor: not-allowed;" id="new_bill_application_client_id" readonly>
                        </div>
                    </div>
                </div>

<div class="modal fade" id="checklistApplicantModal" tabindex="-1" aria-labelledby="checklistApplicantModalTitle" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content border-0 shadow">
                            <div class="modal-header bg-light">
                                <div class="d-flex align-items-center gap-3">
                                    <span class="d-inline-flex align-items-center justify-content-center rounded-circle bg-primary-subtle text-primary" style="width: 40px; height: 40px;"><i class="fas fa-user-plus"></i></span>
                                    <div><small class="text-muted text-uppercase">Application contact</small><h5 class="modal-title mb-0" id="checklistApplicantModalTitle">Add applicant</h5></div>
                                </div>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p class="text-muted small">Enter the applicant's details. Each person added here can be included in the application.</p>
                                <input type="hidden" id="checklistApplicantEditId">
                                <div class="mb-3"><label class="form-label" for="checklistApplicantName">Full name <span class="text-danger">*</span></label><input class="form-control" id="checklistApplicantName" placeholder="Enter applicant's full name" maxlength="160" autocomplete="name"></div>
                                <div class="mb-3"><label class="form-label" for="checklistApplicantGhanaCard">Ghana Card number <span class="text-danger">*</span></label><input class="form-control" id="checklistApplicantGhanaCard" placeholder="GHA-123456789-0" maxlength="15" autocomplete="off"><small class="text-muted">Enter the applicant's Ghana Card number.</small></div>
                                <div class="mb-3"><label class="form-label" for="checklistApplicantGender">Applicant type / gender <span class="text-danger">*</span></label><select class="form-select" id="checklistApplicantGender"><option value="">Select applicant type or gender</option><option>Male</option><option>Female</option><option>Couple</option><option>Company</option><option>Multiple</option></select></div>
                                <div class="mb-3"><label class="form-label" for="checklistApplicantAddress">Address <span class="text-danger">*</span></label><input class="form-control" id="checklistApplicantAddress" placeholder="Enter residential or postal address" maxlength="300" autocomplete="street-address"></div>
                                <div><label class="form-label" for="checklistApplicantPhone">Phone number <span class="text-danger">*</span></label><input class="form-control" id="checklistApplicantPhone" type="tel" placeholder="Enter contact phone number" maxlength="40" autocomplete="tel"></div>
                            </div>
                            <div class="modal-footer"><button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button><button type="button" class="btn btn-primary" id="saveChecklistApplicant"><i class="fas fa-user-plus me-1"></i><span>Add to applicant list</span></button></div>
                        </div>
                    </div>
                </div>
