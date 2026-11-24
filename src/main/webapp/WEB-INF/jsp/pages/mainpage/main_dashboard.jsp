<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:parseNumber value="${completion_rate}" integerOnly="true" var="completionRate" />
<fmt:parseNumber value="${avg_turnaround_days}" type="number" var="avgTurnaroundDays" />
<fmt:parseNumber value="${working_days_percentage}" type="number" var="workingDaysPercentage" />
<style>
.elis-dash-v2{--forest:#07543f;--green:#0b8a61;--mint:#e9f8f0;--ink:#163b30;--line:#dbece3;color:var(--ink)}
.elis-dash-v2 .dash-hero{background:linear-gradient(112deg,#064632,#087553 65%,#0ca473);color:#fff;border-radius:16px;box-shadow:0 12px 28px rgba(7,84,63,.17);padding:24px 28px;position:relative;overflow:hidden}
.elis-dash-v2 .dash-hero:after{content:'';position:absolute;right:-70px;top:-115px;width:320px;height:320px;border-radius:50%;border:55px solid rgba(255,255,255,.06);pointer-events:none}
.elis-dash-v2 .dash-hero h1,.elis-dash-v2 .dash-hero h2,.elis-dash-v2 .dash-hero p,.elis-dash-v2 .dash-hero a,.elis-dash-v2 .dash-hero .breadcrumb-item,.elis-dash-v2 .dash-hero .breadcrumb-item.active{color:#fff!important}
.elis-dash-v2 .dash-hero .breadcrumb-item+.breadcrumb-item:before{color:#d0f1df!important}
.elis-dash-v2 .dash-kicker{font-size:11px;letter-spacing:.14em;text-transform:uppercase;font-weight:700;color:#c3f3dc}
.elis-dash-v2 .dash-hero h2{font-size:clamp(20px,2.2vw,30px);font-weight:750;margin:8px 0}
.elis-dash-v2 .dash-date{display:inline-block;padding:7px 12px;background:rgba(255,255,255,.13);border:1px solid rgba(255,255,255,.2);border-radius:9px;font-size:12px}
.elis-dash-v2 .dash-section-heading{display:flex;align-items:center;gap:10px;font-size:16px;font-weight:750;color:var(--ink);margin:0 0 15px}
.elis-dash-v2 .dash-section-heading:before{content:'';height:19px;width:4px;border-radius:4px;background:var(--green)}
.elis-dash-v2 .dash-stat{height:100%;border:1px solid var(--line)!important;border-radius:14px;background:#fff;box-shadow:0 5px 18px rgba(9,79,56,.045);transition:box-shadow .2s,transform .2s}
.elis-dash-v2 .dash-stat:hover{transform:translateY(-3px);box-shadow:0 11px 25px rgba(9,79,56,.11)}
.elis-dash-v2 .dash-stat a{color:inherit!important;display:block;height:100%}
.elis-dash-v2 .dash-stat .card-body{padding:22px!important}
.elis-dash-v2 .dash-stat-label{color:#60796e;font-size:12px;font-weight:650}
.elis-dash-v2 .dash-stat-value{font-size:32px;font-weight:800;line-height:1.2;color:var(--forest);margin:10px 0 5px}
.elis-dash-v2 .dash-stat-note{color:#73877c;font-size:12px}
.elis-dash-v2 .dash-stat-icon{display:flex;align-items:center;justify-content:center;width:48px;height:48px;flex:0 0 48px;border-radius:13px;background:var(--mint);color:var(--green);font-size:23px}
.elis-dash-v2 .dash-stat.dash-danger{border-color:#f4d6d8!important}.elis-dash-v2 .dash-danger .dash-stat-icon{background:#fff0f0;color:#d43e49}.elis-dash-v2 .dash-danger .dash-stat-value{color:#bf3541}
.elis-dash-v2 .dash-stat.dash-amber{border-color:#f3e7c9!important}.elis-dash-v2 .dash-amber .dash-stat-icon{background:#fff8e5;color:#b78215}
.elis-dash-v2 .dash-panel{border:1px solid var(--line)!important;border-radius:15px;overflow:hidden;box-shadow:0 5px 18px rgba(9,79,56,.05);background:#fff}
.elis-dash-v2 .dash-panel-header{background:linear-gradient(110deg,#07543f,#0b8a61);padding:18px 22px}
.elis-dash-v2 .dash-panel-header h5,.elis-dash-v2 .dash-panel-header p{color:#fff!important;margin:0}.elis-dash-v2 .dash-panel-header h5{font-weight:750;font-size:17px}.elis-dash-v2 .dash-panel-header p{opacity:.84;font-size:12px;margin-top:4px}
.elis-dash-v2 .dash-metric{height:100%;border-radius:13px;padding:20px;background:#f0faf5;border:1px solid #d7eddf}
.elis-dash-v2 .dash-metric .metric-label{font-size:12px;font-weight:700;color:#416b58}.elis-dash-v2 .dash-metric .metric-value{font-size:27px;font-weight:800;color:var(--forest);margin:11px 0 4px}.elis-dash-v2 .dash-metric .metric-foot{font-size:12px;color:#658174}
.elis-dash-v2 .dash-metric .metric-icon{font-size:21px;color:var(--green)}
.elis-dash-v2 .dash-progress{height:7px;border-radius:8px;background:#d8eadf;overflow:hidden;margin-top:15px}.elis-dash-v2 .dash-progress span{display:block;height:100%;background:linear-gradient(90deg,#087451,#22ae7a);border-radius:8px}
.elis-dash-v2 .dash-insights{background:#f5fbf7;border:1px solid #dbeee3;border-radius:12px;padding:20px}.elis-dash-v2 .dash-insights h6{font-weight:750;color:var(--forest)}
.elis-dash-v2 .dash-insights .insight-item{display:flex;align-items:flex-start;gap:9px;font-size:13px;margin-top:10px}.elis-dash-v2 .dash-insights .insight-item i{font-size:17px;color:var(--green)}
.elis-dash-v2 .dash-shortcut{display:flex;align-items:center;gap:12px;border:1px solid var(--line);border-radius:12px;padding:15px;text-decoration:none!important;color:var(--ink)!important;background:#fff;transition:background .2s}.elis-dash-v2 .dash-shortcut:hover{background:#effaf4}.elis-dash-v2 .dash-shortcut i{color:var(--green);font-size:23px}.elis-dash-v2 .dash-shortcut strong{font-size:13px}.elis-dash-v2 .dash-shortcut small{display:block;color:#698075;font-size:11px}
@media(max-width:575px){.elis-dash-v2 .dash-hero{padding:19px}.elis-dash-v2 .dash-stat-value{font-size:27px}}
</style>
<div class="main-content app-content elis-dash-v2">
<div class="container-fluid page-container">
  <section class="dash-hero mb-4">
    <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 position-relative" style="z-index:1">
      <div>
        <div class="dash-kicker"><i class="ri-dashboard-3-line me-1"></i> ELIS · Staff workspace</div>
        <h1 class="fs-18 fw-semibold mt-2 mb-0">Dashboard</h1>
        <h2>Welcome back, ${fullname}</h2>
        <div class="dash-date"><i class="ri-calendar-line me-2"></i><fmt:formatDate value="${now}" pattern="EEEE, MMMM d, yyyy" /></div>
      </div>
      <ol class="breadcrumb mb-0"><li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li><li class="breadcrumb-item active" aria-current="page">Dashboard</li></ol>
    </div>
  </section>

  <h5 class="dash-section-heading">Application overview</h5>
  <div class="row g-3 mb-4">
    <div class="col-xl-3 col-md-6"><div class="card dash-stat mb-0"><a href="${pageContext.request.contextPath}/case_movement_module" class="text-decoration-none"><div class="card-body"><div class="d-flex justify-content-between align-items-start"><div class="dash-stat-label">Current Applications</div><div class="dash-stat-icon"><i class="ri-file-list-3-line"></i></div></div><div class="dash-stat-value">${apps_with_user}</div><div class="dash-stat-note"><i class="ri-calendar-event-line me-1"></i>Assigned to you</div></div></a></div></div>
    <div class="col-xl-3 col-md-6"><div class="card dash-stat dash-danger mb-0"><a href="javascript:void(0);" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#appsPassedDueModal"><div class="card-body"><div class="d-flex justify-content-between align-items-start"><div class="dash-stat-label">Requires Attention</div><div class="dash-stat-icon"><i class="ri-alarm-warning-line"></i></div></div><div class="dash-stat-value">${apps_past_due_dates}</div><div class="dash-stat-note">Overdue applications · View details <i class="ri-arrow-right-up-line"></i></div></div></a></div></div>
    <div class="col-xl-3 col-md-6"><div class="card dash-stat dash-amber mb-0"><a href="javascript:void(0);" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#appsReceivedMonthModal"><div class="card-body"><div class="d-flex justify-content-between align-items-start"><div class="dash-stat-label">This Month's Inflow</div><div class="dash-stat-icon"><i class="ri-download-2-line"></i></div></div><div class="dash-stat-value">${apps_rec_month}</div><div class="dash-stat-note"><fmt:formatDate value="${now}" pattern="MMMM" /> · Received applications</div></div></a></div></div>
    <div class="col-xl-3 col-md-6"><div class="card dash-stat mb-0"><a href="javascript:void(0);" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#appsCompletedMonthModal"><div class="card-body"><div class="d-flex justify-content-between align-items-start"><div class="dash-stat-label">Monthly Achievements</div><div class="dash-stat-icon"><i class="ri-checkbox-circle-line"></i></div></div><div class="dash-stat-value">${apps_comp_month}</div><div class="dash-stat-note">Completed this month · View details <i class="ri-arrow-right-up-line"></i></div></div></a></div></div>
  </div>

  <div class="row g-4 mb-4">
    <div class="col-xl-9">
      <div class="card dash-panel h-100 mb-0">
        <div class="dash-panel-header"><h5><i class="ri-line-chart-line me-2"></i>Performance Dashboard</h5><p>Performance metrics for <fmt:formatDate value="${now}" pattern="MMMM yyyy" /></p></div>
        <div class="card-body p-4">
          <div class="row g-3">
            <div class="col-lg-4"><div class="dash-metric"><div class="d-flex align-items-center justify-content-between"><span class="metric-label">Completion Rate</span><i class="ri-pie-chart-2-line metric-icon"></i></div><div class="metric-value">${completion_rate}</div><div class="metric-foot">Target: 85% · Year <fmt:formatDate value="${now}" pattern="yyyy" /></div><div class="dash-progress"><span style="width:${completionRate > 100 ? 100 : completionRate < 0 ? 0 : completionRate}%;"></span></div><div class="mt-2"><c:choose><c:when test="${completionRate >= 90}"><span class="badge bg-success">Excellent</span></c:when><c:when test="${completionRate >= 70}"><span class="badge bg-warning text-dark">Good</span></c:when><c:otherwise><span class="badge bg-danger">Needs Improvement</span></c:otherwise></c:choose></div></div></div>
            <div class="col-lg-4"><div class="dash-metric"><div class="d-flex align-items-center justify-content-between"><span class="metric-label">Turn-around Time</span><i class="ri-time-line metric-icon"></i></div><div class="metric-value">${avg_turnaround_days} <small class="fs-14 fw-normal">days</small></div><div class="metric-foot">Target: 2 days · Year <fmt:formatDate value="${now}" pattern="yyyy" /></div><div class="dash-progress"><span style="width:${avgTurnaroundDays <= 2 ? '100' : avgTurnaroundDays <= 3 ? '65' : avgTurnaroundDays <= 4 ? '40' : '20'}%;"></span></div><div class="mt-2"><span class="badge ${turnaround_performance == 'Excellent' ? 'bg-success' : turnaround_performance == 'Good' ? 'bg-info' : turnaround_performance == 'Average' ? 'bg-warning text-dark' : 'bg-danger'}">${turnaround_performance}</span></div></div></div>
            <div class="col-lg-4"><div class="dash-metric"><div class="d-flex align-items-center justify-content-between"><span class="metric-label">Working Days</span><i class="ri-calendar-check-line metric-icon"></i></div><div class="metric-value">${working_days}</div><div class="metric-foot">Target: 260 days · Year <fmt:formatDate value="${now}" pattern="yyyy" /></div><div class="dash-progress"><span style="width:${workingDaysPercentage > 100 ? 100 : workingDaysPercentage < 0 ? 0 : workingDaysPercentage}%;"></span></div><div class="mt-2"><span class="badge bg-success">${working_days_status}</span> <span class="small text-muted ms-1">${workingDaysPercentage}%</span></div></div></div>
          </div>
          <div class="dash-insights mt-4"><h6 class="mb-1"><i class="ri-lightbulb-flash-line me-2"></i>Performance Insights</h6><p class="small text-muted mb-2">Guidance based on your ${completion_rate} completion rate.</p><div class="row"><c:choose><c:when test="${completionRate >= 90}"><div class="col-md-6"><div class="insight-item"><i class="ri-check-line"></i><span>Continue leveraging efficient workflow patterns.</span></div></div><div class="col-md-6"><div class="insight-item"><i class="ri-team-line"></i><span>Share best practices with team members.</span></div></div></c:when><c:when test="${completionRate >= 70}"><div class="col-md-6"><div class="insight-item"><i class="ri-sort-asc"></i><span>Prioritize critical assignments.</span></div></div><div class="col-md-6"><div class="insight-item"><i class="ri-time-line"></i><span>Reserve focused time for complex cases.</span></div></div></c:when><c:otherwise><div class="col-md-6"><div class="insight-item"><i class="ri-focus-3-line"></i><span>Focus on 2–3 priority tasks each day.</span></div></div><div class="col-md-6"><div class="insight-item"><i class="ri-automation-line"></i><span>Use workflow automation for routine work.</span></div></div></c:otherwise></c:choose></div></div>
        </div>
      </div>
    </div>
    <div class="col-xl-3">
      <div class="card dash-panel h-100 mb-0"><div class="dash-panel-header"><h5><i class="ri-flashlight-line me-2"></i>Quick Access</h5><p>Frequently used actions</p></div><div class="card-body p-3 d-flex flex-column gap-3">
        <a class="dash-shortcut" href="${pageContext.request.contextPath}/case_movement_module"><i class="ri-folder-open-line"></i><span><strong>My Applications</strong><small>Open your assigned cases</small></span></a>
        <a class="dash-shortcut" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#appsPassedDueModal"><i class="ri-error-warning-line"></i><span><strong>Overdue Cases</strong><small>Review pending deadlines</small></span></a>
        <a class="dash-shortcut" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#appsReceivedMonthModal"><i class="ri-inbox-line"></i><span><strong>Monthly Inflow</strong><small>See applications received</small></span></a>
        <a class="dash-shortcut" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#appsCompletedMonthModal"><i class="ri-checkbox-multiple-line"></i><span><strong>Completed Cases</strong><small>Review monthly output</small></span></a>
      </div></div>
    </div>
  </div>
</div>
</div>
