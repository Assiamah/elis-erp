<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
    #incomingLesseeUpdatesModal .nav-tabs .nav-link {
        color: var(--default-text-color);
        font-weight: 600;
    }

    #incomingLesseeUpdatesModal .nav-tabs .nav-link.active {
        color: rgb(var(--primary-rgb));
    }

    #incomingLesseeUpdatesModal .updates-table th {
        white-space: nowrap;
    }

    #incomingLesseeUpdatesModal .updates-table td {
        vertical-align: middle;
    }

    #incomingLesseeUpdateDetailsModal .detail-label {
        display: block;
        margin-bottom: .25rem;
        color: var(--text-muted);
        font-size: .75rem;
        font-weight: 600;
        letter-spacing: .03em;
        text-transform: uppercase;
    }

    #incomingLesseeUpdateDetailsModal .review-action-panel {
        border: 1px solid rgba(var(--primary-rgb), .18);
        background: rgba(var(--primary-rgb), .04);
    }

    #incomingLesseeUpdateDetailsModal .detail-value {
        min-height: 2.5rem;
        padding: .625rem .75rem;
        margin-bottom: 0;
        border: 1px solid var(--default-border);
        border-radius: .375rem;
        background: rgb(var(--light-rgb));
        overflow-wrap: anywhere;
    }
</style>

<div class="modal fade effect-scale modal-blur" id="incomingLesseeUpdatesModal" tabindex="-1"
     aria-labelledby="incomingLesseeUpdatesModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0">
            <div class="modal-header bg-danger text-white">
                <div>
                    <h5 class="modal-title text-white" id="incomingLesseeUpdatesModalLabel">
                        <i class="ri-download-2-line me-2"></i>Incoming Lessee Information Updates
                    </h5>
                    <p class="mb-0 mt-1 text-white-50 fs-12">
                        Review lessee information submitted for your region.
                    </p>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body p-0">
                <ul class="nav nav-tabs nav-justified px-3 pt-3" id="incomingLesseeUpdateTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="pending-lessee-updates-tab" data-bs-toggle="tab"
                                data-bs-target="#pending-lessee-updates" type="button" role="tab"
                                aria-controls="pending-lessee-updates" aria-selected="true">
                            Under Review
                            <span class="badge bg-warning-transparent ms-1">${pending_lessee_update_count}</span>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="approved-lessee-updates-tab" data-bs-toggle="tab"
                                data-bs-target="#approved-lessee-updates" type="button" role="tab"
                                aria-controls="approved-lessee-updates" aria-selected="false">
                            Approved
                            <span class="badge bg-success-transparent ms-1">${approved_lessee_update_count}</span>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="rejected-lessee-updates-tab" data-bs-toggle="tab"
                                data-bs-target="#rejected-lessee-updates" type="button" role="tab"
                                aria-controls="rejected-lessee-updates" aria-selected="false">
                            Rejected
                            <span class="badge bg-danger-transparent ms-1">${rejected_lessee_update_count}</span>
                        </button>
                    </li>
                </ul>

                <div class="tab-content p-3" id="incomingLesseeUpdateTabContent">
                    <div class="tab-pane fade show active" id="pending-lessee-updates" role="tabpanel"
                         aria-labelledby="pending-lessee-updates-tab" tabindex="0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle updates-table mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Submitted</th>
                                        <th>Plot Number</th>
                                        <th>Lessee / Company</th>
                                        <th>Phone Number</th>
                                        <th>Status</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${pending_lessee_updates}" var="update">
                                        <tr>
                                            <td class="js-format-lessee-date"><c:out value="${update.submitted_at}" default="—"/></td>
                                            <td><c:out value="${update.plot_number}" default="—"/></td>
                                            <td><c:out value="${update.lessee_name}" default="—"/></td>
                                            <td><c:out value="${update.phone_number}" default="—"/></td>
                                            <td><span class="badge bg-warning-transparent">Pending Review</span></td>
                                            <td class="text-end">
                                                <button type="button" class="btn btn-sm btn-primary-light btn-view-lessee-update"
                                                        data-submission-id="${update.submission_id}">
                                                    <i class="ri-eye-line me-1"></i>View Details
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${pending_lessee_update_count == 0}">
                                        <tr><td colspan="6" class="text-center text-muted py-5">No updates are awaiting review.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="approved-lessee-updates" role="tabpanel"
                         aria-labelledby="approved-lessee-updates-tab" tabindex="0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle updates-table mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Submitted</th>
                                        <th>Plot Number</th>
                                        <th>Lessee / Company</th>
                                        <th>Reviewed By</th>
                                        <th>Status</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${approved_lessee_updates}" var="update">
                                        <tr>
                                            <td class="js-format-lessee-date"><c:out value="${update.submitted_at}" default="—"/></td>
                                            <td><c:out value="${update.plot_number}" default="—"/></td>
                                            <td><c:out value="${update.lessee_name}" default="—"/></td>
                                            <td><c:out value="${update.reviewed_by}" default="—"/></td>
                                            <td><span class="badge bg-success-transparent">Approved</span></td>
                                            <td class="text-end">
                                                <button type="button" class="btn btn-sm btn-primary-light btn-view-lessee-update"
                                                        data-submission-id="${update.submission_id}">
                                                    <i class="ri-eye-line me-1"></i>View Details
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${approved_lessee_update_count == 0}">
                                        <tr><td colspan="6" class="text-center text-muted py-5">No approved updates were found.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="rejected-lessee-updates" role="tabpanel"
                         aria-labelledby="rejected-lessee-updates-tab" tabindex="0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle updates-table mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Submitted</th>
                                        <th>Plot Number</th>
                                        <th>Lessee / Company</th>
                                        <th>Reviewed By</th>
                                        <th>Status</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${rejected_lessee_updates}" var="update">
                                        <tr>
                                            <td class="js-format-lessee-date"><c:out value="${update.submitted_at}" default="—"/></td>
                                            <td><c:out value="${update.plot_number}" default="—"/></td>
                                            <td><c:out value="${update.lessee_name}" default="—"/></td>
                                            <td><c:out value="${update.reviewed_by}" default="—"/></td>
                                            <td><span class="badge bg-danger-transparent">Rejected</span></td>
                                            <td class="text-end">
                                                <button type="button" class="btn btn-sm btn-primary-light btn-view-lessee-update"
                                                        data-submission-id="${update.submission_id}">
                                                    <i class="ri-eye-line me-1"></i>View Details
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${rejected_lessee_update_count == 0}">
                                        <tr><td colspan="6" class="text-center text-muted py-5">No rejected updates were found.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="incomingLesseeUpdateDetailsModal" tabindex="-1"
     aria-labelledby="incomingLesseeUpdateDetailsModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <div>
                    <h5 class="modal-title text-white" id="incomingLesseeUpdateDetailsModalLabel">
                        <i class="ri-file-user-line me-2"></i>Lessee Update Details
                    </h5>
                    <span class="badge bg-light text-primary mt-1" id="incoming-detail-status">—</span>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <div class="card custom-card mb-3">
                    <div class="card-header"><div class="card-title">Property Identification</div></div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-4"><span class="detail-label">Region</span><p class="detail-value" id="incoming-detail-region">—</p></div>
                            <div class="col-md-4"><span class="detail-label">Plot Number</span><p class="detail-value" id="incoming-detail-plot_number">—</p></div>
                            <div class="col-md-4"><span class="detail-label">Area / Town</span><p class="detail-value" id="incoming-detail-area_town">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Street Name</span><p class="detail-value" id="incoming-detail-street_name">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Digital Address</span><p class="detail-value" id="incoming-detail-digital_address">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Landmark</span><p class="detail-value" id="incoming-detail-landmark">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Land Use</span><p class="detail-value" id="incoming-detail-land_use">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Development Status</span><p class="detail-value" id="incoming-detail-development_status">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Occupancy Status</span><p class="detail-value" id="incoming-detail-occupancy_status">—</p></div>
                        </div>
                    </div>
                </div>

                <div class="card custom-card mb-3">
                    <div class="card-header"><div class="card-title">Lessee / Landowner</div></div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6"><span class="detail-label">Full Name / Company</span><p class="detail-value" id="incoming-detail-lessee_name">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Type</span><p class="detail-value" id="incoming-detail-lessee_type">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Ghana Card / Registration No.</span><p class="detail-value" id="incoming-detail-identification_number">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Phone Number</span><p class="detail-value" id="incoming-detail-phone_number">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Email Address</span><p class="detail-value" id="incoming-detail-email_address">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Postal Address</span><p class="detail-value" id="incoming-detail-postal_address">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Lessee Contactable</span><p class="detail-value" id="incoming-detail-lessee_contactable">—</p></div>
                        </div>
                    </div>
                </div>

                <div class="card custom-card mb-3">
                    <div class="card-header"><div class="card-title">Payee Details</div></div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6"><span class="detail-label">Same as Lessee</span><p class="detail-value" id="incoming-detail-payee_same_as_lessee">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Payee Name</span><p class="detail-value" id="incoming-detail-payee_name">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Payee Phone Number</span><p class="detail-value" id="incoming-detail-payee_phone_number">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Payee Email Address</span><p class="detail-value" id="incoming-detail-payee_email_address">—</p></div>
                            <div class="col-12"><span class="detail-label">Payee Address</span><p class="detail-value" id="incoming-detail-payee_address">—</p></div>
                        </div>
                    </div>
                </div>

                <div class="card custom-card mb-3">
                    <div class="card-header"><div class="card-title">Current Occupier / User</div></div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6"><span class="detail-label">Name</span><p class="detail-value" id="incoming-detail-occupier_name">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Phone Number</span><p class="detail-value" id="incoming-detail-occupier_phone_number">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Relationship to Lessee</span><p class="detail-value" id="incoming-detail-relationship_to_lessee">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Nature of Use</span><p class="detail-value" id="incoming-detail-nature_of_use">—</p></div>
                        </div>
                    </div>
                </div>

                <div class="card custom-card mb-3">
                    <div class="card-header"><div class="card-title">Submission and Review</div></div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6"><span class="detail-label">Submitted By</span><p class="detail-value" id="incoming-detail-submitted_by">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Submitted At</span><p class="detail-value" id="incoming-detail-submitted_at">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Reviewed By</span><p class="detail-value" id="incoming-detail-reviewed_by">—</p></div>
                            <div class="col-md-6"><span class="detail-label">Reviewed At</span><p class="detail-value" id="incoming-detail-reviewed_at">—</p></div>
                            <div class="col-12"><span class="detail-label">Review Comment</span><p class="detail-value" id="incoming-detail-review_comment">—</p></div>
                        </div>
                    </div>
                </div>

                <div class="card custom-card mb-0 review-action-panel d-none" id="incoming-review-actions">
                    <div class="card-header">
                        <div class="card-title"><i class="ri-shield-check-line me-2"></i>Review Decision</div>
                    </div>
                    <div class="card-body">
                        <label for="incoming-review-comment" class="form-label fw-semibold">Review Comment</label>
                        <textarea class="form-control" id="incoming-review-comment" rows="3" maxlength="1000"
                                  placeholder="Add an optional approval note. A reason is required when rejecting."></textarea>
                        <div class="form-text">Confirm that the submitted details have been checked before approving.</div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Back to Updates</button>
                <button type="button" class="btn btn-danger d-none btn-review-lessee-update"
                        id="incoming-reject-update" data-decision="rejected">
                    <i class="ri-close-circle-line me-1"></i>Reject Update
                </button>
                <button type="button" class="btn btn-success d-none btn-review-lessee-update"
                        id="incoming-approve-update" data-decision="accepted">
                    <i class="ri-checkbox-circle-line me-1"></i>Approve Update
                </button>
            </div>
        </div>
    </div>
</div>

<div class="d-none" id="incomingLesseeUpdateDataStore" aria-hidden="true">
    <c:forEach items="${incoming_lessee_updates}" var="update">
        <div class="incoming-lessee-update-data" data-submission-id="${update.submission_id}">
            <span data-field="region"><c:out value="${update.region_name}"/></span>
            <span data-field="plot_number"><c:out value="${update.plot_number}"/></span>
            <span data-field="street_name"><c:out value="${update.street_name}"/></span>
            <span data-field="area_town"><c:out value="${update.area_town}"/></span>
            <span data-field="digital_address"><c:out value="${update.digital_address}"/></span>
            <span data-field="landmark"><c:out value="${update.landmark}"/></span>
            <span data-field="land_use"><c:out value="${update.land_use}"/></span>
            <span data-field="development_status"><c:out value="${update.development_status}"/></span>
            <span data-field="occupancy_status"><c:out value="${update.occupancy_status}"/></span>
            <span data-field="lessee_name"><c:out value="${update.lessee_name}"/></span>
            <span data-field="lessee_type"><c:out value="${update.lessee_type}"/></span>
            <span data-field="identification_number"><c:out value="${update.identification_number}"/></span>
            <span data-field="phone_number"><c:out value="${update.phone_number}"/></span>
            <span data-field="email_address"><c:out value="${update.email_address}"/></span>
            <span data-field="postal_address"><c:out value="${update.postal_address}"/></span>
            <span data-field="lessee_contactable"><c:out value="${update.lessee_contactable}"/></span>
            <span data-field="payee_same_as_lessee"><c:out value="${update.payee_same_as_lessee}"/></span>
            <span data-field="payee_name"><c:out value="${update.payee_name}"/></span>
            <span data-field="payee_phone_number"><c:out value="${update.payee_phone_number}"/></span>
            <span data-field="payee_email_address"><c:out value="${update.payee_email_address}"/></span>
            <span data-field="payee_address"><c:out value="${update.payee_address}"/></span>
            <span data-field="occupier_name"><c:out value="${update.occupier_name}"/></span>
            <span data-field="occupier_phone_number"><c:out value="${update.occupier_phone_number}"/></span>
            <span data-field="relationship_to_lessee"><c:out value="${update.relationship_to_lessee}"/></span>
            <span data-field="nature_of_use"><c:out value="${update.nature_of_use}"/></span>
            <span data-field="submitted_by"><c:out value="${update.submitted_by}"/></span>
            <span data-field="submitted_at"><c:out value="${update.submitted_at}"/></span>
            <span data-field="review_status"><c:out value="${update.review_status}"/></span>
            <span data-field="reviewed_by"><c:out value="${update.reviewed_by}"/></span>
            <span data-field="reviewed_at"><c:out value="${update.reviewed_at}"/></span>
            <span data-field="review_comment"><c:out value="${update.review_comment}"/></span>
        </div>
    </c:forEach>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var updatesModalElement = document.getElementById('incomingLesseeUpdatesModal');
        var detailsModalElement = document.getElementById('incomingLesseeUpdateDetailsModal');
        var savedReviewMessage = null;

        try {
            savedReviewMessage = window.sessionStorage.getItem('lesseeReviewSuccessMessage');
            window.sessionStorage.removeItem('lesseeReviewSuccessMessage');
        } catch (storageError) {
            savedReviewMessage = null;
        }

        if (savedReviewMessage && typeof notifier !== 'undefined') {
            notifier.show(
                'Success',
                savedReviewMessage,
                'success',
                '../assets/images/notification/ok-48.png',
                20000
            );
        }

        if (!updatesModalElement || !detailsModalElement || typeof bootstrap === 'undefined') {
            return;
        }

        var updatesModal = bootstrap.Modal.getOrCreateInstance(updatesModalElement);
        var detailsModal = bootstrap.Modal.getOrCreateInstance(detailsModalElement);
        var reviewActions = document.getElementById('incoming-review-actions');
        var reviewComment = document.getElementById('incoming-review-comment');
        var reviewButtons = document.querySelectorAll('.btn-review-lessee-update');
        var reviewUrl = '<c:url value="/review_ground_rent_lessee_information_update"/>';
        var detailFields = [
            'region', 'plot_number', 'street_name', 'area_town', 'digital_address', 'landmark',
            'land_use', 'development_status', 'occupancy_status', 'lessee_name', 'lessee_type',
            'identification_number', 'phone_number', 'email_address', 'postal_address',
            'lessee_contactable', 'payee_same_as_lessee', 'payee_name', 'payee_phone_number',
            'payee_email_address', 'payee_address', 'occupier_name', 'occupier_phone_number',
            'relationship_to_lessee', 'nature_of_use', 'submitted_by', 'submitted_at',
            'reviewed_by', 'reviewed_at', 'review_comment'
        ];
        var returnToUpdates = false;
        var currentSubmissionId = null;

        function getRecordValue(record, field) {
            var valueElement = record.querySelector('[data-field="' + field + '"]');
            var value = valueElement ? valueElement.textContent.trim() : '';
            return value || '—';
        }

        function formatLesseeDate(value) {
            if (!value || value === '—') {
                return '—';
            }

            var parsedDate = new Date(value);
            if (Number.isNaN(parsedDate.getTime())) {
                return value;
            }

            return new Intl.DateTimeFormat('en-GH', {
                day: '2-digit',
                month: 'short',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                hour12: true,
                timeZone: 'Africa/Accra'
            }).format(parsedDate);
        }

        document.querySelectorAll('.js-format-lessee-date').forEach(function (dateCell) {
            dateCell.textContent = formatLesseeDate(dateCell.textContent.trim());
        });

        document.addEventListener('click', function (event) {
            var button = event.target.closest('.btn-view-lessee-update');
            if (!button) {
                return;
            }

            var submissionId = button.getAttribute('data-submission-id');
            var record = document.querySelector('.incoming-lessee-update-data[data-submission-id="' + submissionId + '"]');
            if (!record) {
                return;
            }

            detailFields.forEach(function (field) {
                var destination = document.getElementById('incoming-detail-' + field);
                if (destination) {
                    var value = getRecordValue(record, field);
                    if (field === 'lessee_contactable' || field === 'payee_same_as_lessee') {
                        value = value === 'true' ? 'Yes' : (value === 'false' ? 'No' : value);
                    }
                    if (field === 'submitted_at' || field === 'reviewed_at') {
                        value = formatLesseeDate(value);
                    }
                    destination.textContent = value;
                }
            });

            var status = getRecordValue(record, 'review_status');
            status = status.toLowerCase();
            var statusLabel = status === 'pending_review' ? 'Pending Review'
                : (status === 'accepted' || status === 'approved' ? 'Approved' : 'Rejected');
            document.getElementById('incoming-detail-status').textContent = statusLabel;

            currentSubmissionId = submissionId;
            reviewComment.value = '';
            var canReview = status === 'pending_review' || status === 'pending' || status === '—';
            reviewActions.classList.toggle('d-none', !canReview);
            reviewButtons.forEach(function (reviewButton) {
                reviewButton.classList.toggle('d-none', !canReview);
                reviewButton.disabled = false;
            });

            returnToUpdates = true;
            updatesModalElement.addEventListener('hidden.bs.modal', function showDetails() {
                detailsModal.show();
            }, {once: true});
            updatesModal.hide();
        });

        function showReviewError(message) {
            if (typeof Swal !== 'undefined') {
                Swal.fire({
                    icon: 'error',
                    title: 'Review not completed',
                    text: message
                });
            } else {
                window.alert(message);
            }
        }

        function sendReviewDecision(decision) {
            var comment = reviewComment.value.trim();
            if (!currentSubmissionId) {
                showReviewError('A valid submission is required.');
                return;
            }
            if (decision === 'rejected' && !comment) {
                reviewComment.focus();
                showReviewError('Please provide a reason before rejecting this update.');
                return;
            }

            reviewButtons.forEach(function (button) {
                button.disabled = true;
            });

            var requestData = new URLSearchParams();
            requestData.append('submission_id', currentSubmissionId);
            requestData.append('decision', decision);
            requestData.append('review_comment', comment);

            fetch(reviewUrl, {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
                body: requestData.toString()
            })
                .then(function (response) {
                    if (!response.ok) {
                        throw new Error('The server could not process the review.');
                    }
                    return response.json();
                })
                .then(function (result) {
                    if (!result.success) {
                        throw new Error(result.message || 'The review could not be completed.');
                    }

                    returnToUpdates = false;
                    detailsModal.hide();
                    var successMessage = decision === 'accepted'
                        ? 'Lessee update approved successfully.'
                        : 'Lessee update rejected successfully.';
                    var messageStored = false;
                    try {
                        window.sessionStorage.setItem('lesseeReviewSuccessMessage', successMessage);
                        messageStored = true;
                    } catch (storageError) {
                        messageStored = false;
                    }
                    if (!messageStored && typeof notifier !== 'undefined') {
                        notifier.show(
                            'Success',
                            successMessage,
                            'success',
                            '../assets/images/notification/ok-48.png',
                            20000
                        );
                    }
                    window.setTimeout(function () {
                        window.location.reload();
                    }, messageStored ? 350 : 1500);
                })
                .catch(function (error) {
                    reviewButtons.forEach(function (button) {
                        button.disabled = false;
                    });
                    showReviewError(error.message || 'The review could not be completed.');
                });
        }

        reviewButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                var decision = button.getAttribute('data-decision');
                var actionLabel = decision === 'accepted' ? 'approve' : 'reject';
                var proceed = function () {
                    sendReviewDecision(decision);
                };

                if (typeof Swal !== 'undefined') {
                    Swal.fire({
                        title: decision === 'accepted' ? 'Approve this update?' : 'Reject this update?',
                        text: 'This decision will be recorded against your user account.',
                        icon: 'question',
                        showCancelButton: true,
                        confirmButtonColor: decision === 'accepted' ? '#198754' : '#dc3545',
                        confirmButtonText: decision === 'accepted' ? 'Yes, approve' : 'Yes, reject'
                    }).then(function (result) {
                        if (result.isConfirmed) {
                            proceed();
                        }
                    });
                } else if (window.confirm('Are you sure you want to ' + actionLabel + ' this update?')) {
                    proceed();
                }
            });
        });

        detailsModalElement.addEventListener('hidden.bs.modal', function () {
            if (returnToUpdates) {
                returnToUpdates = false;
                updatesModal.show();
            }
        });
    });
</script>
