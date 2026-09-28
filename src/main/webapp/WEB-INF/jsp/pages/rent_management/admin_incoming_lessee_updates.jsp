<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="main-content app-content">
    <div class="container-fluid page-container">
        <div class="page-header-breadcrumb mb-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div>
                <h1 class="page-title fw-medium fs-18 mb-1">Incoming Lessee Updates</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/rent_management_dashboard">Rent Management</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Regional review centre</li>
                </ol>
            </div>
            <div class="d-flex gap-2">
                <button class="btn btn-light" type="button" id="adminLesseeReset"><i class="ri-refresh-line me-1"></i>Reset filters</button>
                <button class="btn btn-primary" type="button" id="adminLesseeExport"><i class="ri-download-2-line me-1"></i>Export visible</button>
                <button class="btn btn-danger label-btn" type="button" data-bs-toggle="modal" data-bs-target="#incomingLesseeUpdatesModal">
                    <i class="ri-list-check-2 me-1"></i>Review queue
                </button>
            </div>
        </div>

        <div class="row g-3 mb-3">
            <div class="col-xl-3 col-md-6"><div class="card custom-card h-100"><div class="card-body d-flex align-items-center gap-3"><span class="avatar avatar-md bg-primary-transparent"><i class="ri-file-list-3-line fs-20"></i></span><div><span class="text-muted small d-block">All submissions</span><h4 class="mb-0" id="adminLesseeTotal">${total_incoming_lessee_update}</h4></div></div></div></div>
            <div class="col-xl-3 col-md-6"><div class="card custom-card h-100"><div class="card-body d-flex align-items-center gap-3"><span class="avatar avatar-md bg-warning-transparent"><i class="ri-time-line fs-20"></i></span><div><span class="text-muted small d-block">Pending review</span><h4 class="mb-0 text-warning" id="adminLesseePending">${pending_lessee_update_count}</h4></div></div></div></div>
            <div class="col-xl-3 col-md-6"><div class="card custom-card h-100"><div class="card-body d-flex align-items-center gap-3"><span class="avatar avatar-md bg-success-transparent"><i class="ri-checkbox-circle-line fs-20"></i></span><div><span class="text-muted small d-block">Approved</span><h4 class="mb-0 text-success" id="adminLesseeApproved">${approved_lessee_update_count}</h4></div></div></div></div>
            <div class="col-xl-3 col-md-6"><div class="card custom-card h-100"><div class="card-body d-flex align-items-center gap-3"><span class="avatar avatar-md bg-danger-transparent"><i class="ri-close-circle-line fs-20"></i></span><div><span class="text-muted small d-block">Rejected</span><h4 class="mb-0 text-danger" id="adminLesseeRejected">${rejected_lessee_update_count}</h4></div></div></div></div>
        </div>

        <div class="card custom-card">
            <div class="card-header d-flex justify-content-between align-items-center flex-wrap gap-2">
                <div><h5 class="card-title mb-1">Cross-region submission register</h5><p class="text-muted small mb-0">Review, compare and export incoming lessee changes across every authorised region.</p></div>
                <span class="badge bg-primary-transparent" id="adminLesseeResultCount">${total_incoming_lessee_update} shown</span>
            </div>
            <div class="card-body border-bottom">
                <div class="row g-2 align-items-end">
                    <div class="col-xl-4 col-lg-5"><label class="form-label small fw-semibold" for="adminLesseeSearch">Search</label><div class="input-group"><span class="input-group-text"><i class="ri-search-line"></i></span><input class="form-control" id="adminLesseeSearch" type="search" placeholder="Plot, lessee, submission or address"></div></div>
                    <div class="col-xl-2 col-lg-3"><label class="form-label small fw-semibold" for="adminLesseeStatus">Status</label><select class="form-select" id="adminLesseeStatus"><option value="all">All statuses</option><option value="pending">Pending review</option><option value="approved">Approved</option><option value="rejected">Rejected</option></select></div>
                    <div class="col-xl-2 col-lg-3"><label class="form-label small fw-semibold" for="adminLesseeRegion">Region</label><select class="form-select" id="adminLesseeRegion"><option value="all">All regions</option><c:forEach items="${admin_lessee_region_options}" var="region"><option value="${fn:escapeXml(region.key)}"><c:out value="${region.value}"/></option></c:forEach></select></div>
                    <div class="col-xl-2 col-lg-3"><label class="form-label small fw-semibold" for="adminLesseeFrom">From</label><input class="form-control" id="adminLesseeFrom" type="date"></div>
                    <div class="col-xl-2 col-lg-3"><label class="form-label small fw-semibold" for="adminLesseeTo">To</label><input class="form-control" id="adminLesseeTo" type="date"></div>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="adminLesseeUpdatesTable">
                    <thead class="table-light"><tr><th>Submitted</th><th>Region</th><th>Plot</th><th>Lessee / company</th><th>Contact</th><th>Status</th><th class="text-end">Action</th></tr></thead>
                    <tbody>
                    <c:forEach items="${incoming_lessee_updates}" var="update">
                        <c:set var="status" value="${fn:toLowerCase(fn:trim(update.review_status))}"/>
                        <c:set var="statusKey" value="${status == 'approved' || status == 'accepted' ? 'approved' : status == 'rejected' ? 'rejected' : 'pending'}"/>
                        <tr class="admin-lessee-row" data-status="${statusKey}" data-region="${fn:escapeXml(update.regional_code)}" data-date="${fn:escapeXml(update.submitted_at)}" data-search="${fn:escapeXml(update.plot_number)} ${fn:escapeXml(update.lessee_name)} ${fn:escapeXml(update.submission_id)} ${fn:escapeXml(update.phone_number)}">
                            <td class="js-admin-lessee-date"><c:out value="${update.submitted_at}" default="—"/></td>
                            <td><span class="fw-semibold"><c:out value="${update.region}" default="—"/></span><!--<small class="d-block text-muted"><c:out value="${update.regional_code}" default=""/></small>--></td>
                            <td><c:out value="${update.plot_number}" default="—"/></td>
                            <td><span class="fw-semibold"><c:out value="${update.lessee_name}" default="—"/></span><small class="d-block text-muted"><c:out value="${update.lessee_type}" default=""/></small></td>
                            <td><c:out value="${update.phone_number}" default="—"/></td>
                            <td><span class="badge ${statusKey == 'approved' ? 'bg-success-transparent' : statusKey == 'rejected' ? 'bg-danger-transparent' : 'bg-warning-transparent'}"><c:out value="${statusKey == 'approved' ? 'Approved' : statusKey == 'rejected' ? 'Rejected' : 'Pending review'}"/></span></td>
                            <td class="text-end"><button type="button" class="btn btn-sm btn-primary-light btn-view-lessee-update" data-submission-id="${update.submission_id}"><i class="ri-eye-line me-1"></i>Details</button></td>
                        </tr>
                    </c:forEach>
                    <tr id="adminLesseeEmpty" class="d-none"><td colspan="7" class="text-center text-muted py-5"><i class="ri-search-line fs-1 d-block mb-2"></i>No updates match the selected filters.</td></tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../components/_incoming_lessee_updates_modal.jsp"></jsp:include>

<script>
(function () {
    'use strict';
    var rows = Array.prototype.slice.call(document.querySelectorAll('.admin-lessee-row'));
    var search = document.getElementById('adminLesseeSearch'), status = document.getElementById('adminLesseeStatus'), region = document.getElementById('adminLesseeRegion'), from = document.getElementById('adminLesseeFrom'), to = document.getElementById('adminLesseeTo');
    var result = document.getElementById('adminLesseeResultCount'), empty = document.getElementById('adminLesseeEmpty');
    function dateValue(row) { var raw = row.getAttribute('data-date') || ''; var date = new Date(raw); return Number.isNaN(date.getTime()) ? '' : date.toISOString().slice(0, 10); }
    document.querySelectorAll('.js-admin-lessee-date').forEach(function (cell) { var date = new Date(cell.textContent.trim()); if (!Number.isNaN(date.getTime())) cell.textContent = new Intl.DateTimeFormat('en-GH', {day:'2-digit', month:'short', year:'numeric', hour:'2-digit', minute:'2-digit'}).format(date); });
    function apply() {
        var query = (search.value || '').trim().toLowerCase(), wantedStatus = status.value, wantedRegion = region.value, start = from.value, end = to.value, count = 0;
        rows.forEach(function (row) { var matches = (!query || (row.getAttribute('data-search') || '').toLowerCase().indexOf(query) >= 0) && (wantedStatus === 'all' || row.getAttribute('data-status') === wantedStatus) && (wantedRegion === 'all' || row.getAttribute('data-region') === wantedRegion); var date = dateValue(row); if (start && date && date < start) matches = false; if (end && date && date > end) matches = false; row.classList.toggle('d-none', !matches); if (matches) count++; });
        empty.classList.toggle('d-none', count !== 0); result.textContent = count + (count === 1 ? ' shown' : ' shown');
    }
    [search, status, region, from, to].forEach(function (control) { control.addEventListener(control.type === 'search' ? 'input' : 'change', apply); });
    document.getElementById('adminLesseeReset').addEventListener('click', function () { search.value = ''; status.value = 'all'; region.value = 'all'; from.value = ''; to.value = ''; apply(); });
    document.getElementById('adminLesseeExport').addEventListener('click', function () { var visible = rows.filter(function (row) { return !row.classList.contains('d-none'); }); var csv = [['Submitted','Region','Plot','Lessee / company','Contact','Status']].concat(visible.map(function (row) { return Array.prototype.slice.call(row.querySelectorAll('td')).slice(0, 6).map(function (cell) { return '"' + cell.textContent.trim().replace(/"/g, '""') + '"'; }); })).map(function (line) { return line.join(','); }).join('\n'); var link = document.createElement('a'); link.href = URL.createObjectURL(new Blob([csv], {type:'text/csv;charset=utf-8;'})); link.download = 'incoming-lessee-updates.csv'; link.click(); URL.revokeObjectURL(link.href); });
    apply();
}());
</script>
