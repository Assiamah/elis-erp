<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="main-content app-content">
    <div class="container-fluid page-container">
        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-18 mb-0">Rent Management Dashboard</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Rent Management Dashboard</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <div class="row">
            <div class="col-xxl-9">
                <div class="row">
                    <div class="col-xl-3">
                        <div class="card custom-card dashboard-main-card primary">
                            <div class="card-body">
                                <div class="d-flex align-items-start gap-3">
                                    <div class="lh-1">
                                        <span class="avatar avatar-md bg-primary-transparent svg-primary">
                                            <i class="bi bi-people fa-2x"></i>
                                        </span>
                                    </div>
                                    <div>
                                        <span class="d-block text-muted mb-1">Total Lessees/Assignees</span>
                                        <h6 class="fw-semibold mb-0">${total_leasee}</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3">
                        <div class="card custom-card dashboard-main-card danger">
                            <div class="card-body">
                                <div class="d-flex align-items-start gap-3">
                                    <div class="lh-1">
                                        <span class="avatar avatar-md bg-danger-transparent svg-danger">
                                            <i class="bi bi-exclamation-circle fa-2x"></i>
                                        </span>
                                    </div>
                                    <div>
                                        <span class="d-block text-muted mb-1">Total Rent Outstanding</span>
                                        <h6 class="fw-semibold mb-0"><small class="fw-light">GHS</small> ${total_rent_oustanding}</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3">
                        <div class="card custom-card dashboard-main-card info">
                            <div class="card-body">
                                <div class="d-flex align-items-start gap-3">
                                    <div class="lh-1">
                                        <span class="avatar avatar-md bg-info-transparent svg-info">
                                            <i class="bi bi-currency-exchange fa-2x"></i>
                                        </span>
                                    </div>
                                    <div>
                                        <span class="d-block text-muted mb-1">Total Rents Paid (This Year)</span>
                                        <h6 class="fw-semibold mb-0"><small class="fw-light">GHS</small> 0.00</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3">
                        <div class="card custom-card dashboard-main-card warning">
                            <div class="card-body">
                                <div class="d-flex align-items-start gap-3">
                                    <div class="lh-1">
                                        <span class="avatar avatar-md bg-warning-transparent svg-warning">
                                            <i class="bi bi-person-check fa-2x"></i>
                                        </span>
                                    </div>
                                    <div>
                                        <span class="d-block text-muted mb-1">Accounts Linked</span>
                                        <h6 class="fw-semibold mb-0">0</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-12">
                        <div class="card custom-card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div class="card-title">
                                    Lessee & Rent Records
                                </div>
                                <button class="btn btn-warning label-btn" data-bs-toggle="modal" data-bs-target="#addlegder">
                                    <i class="ri-add-line label-btn-icon me-2"></i>Add Lessee
                                </button>
                            </div>
                           <div class="card-body">
                                <!-- Search Panel -->
                                <div class="row mb-4">
                                    <div class="col-lg-5">
                                        <label class="form-label fw-semibold">Search By</label>
                                        <select class="form-select" id="rts_select_type" data-trigger>
                                            <option disabled selected>-- Select Type --</option>
                                            <option value="Plot Number">Plot Number</option>
                                            <option value="Estate">Estate</option>
                                            <option value="Name of Leasee/Assignee">Name of Lessee</option>
                                        </select>

                                        <div class="d-none mb-3" id="div_rent_estate">
                                            <select class="form-select" id="rts_estate" data-trigger>
                                                <!-- <option selected disabled>-- Select Estate --</option> -->
                                                <c:forEach items="${estate_list}" var="estateList">
                                                    <option value="${estateList.ge_id}">${estateList.ge_location_name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="d-none mb-3" id="div_rent_keyword">
                                            <input type="text" class="form-control" id="rts_keyword" placeholder="Enter keyword...">
                                        </div>

                                        <button class="btn btn-success w-100" id="btn_rt_search">
                                            <i class="fas fa-search me-2"></i>Search
                                        </button>
                                    </div>
                                </div>

                                <!-- Table -->
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle" id="tbl_rent_records">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Action</th>
                                                <th>Account Number</th>
                                                <th>Plot Number</th>
                                                <th>Name of Lessee</th>
                                                <th>File Number</th>
                                                <th>Commencement Date</th>
                                                <th>Term</th>
                                                <th>Plot Size</th>
                                                <th>Last Review Date</th>
                                                <th>Last Payment Period</th>
                                                <th>Rent Outstanding</th>
                                                <th>Unexpired Term</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Populated by DataTables -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xxl-3">
                <div class="card custom-card overflow-hidden">
                    <div class="card-header">
                        <div class="card-title">
                            Task Activity
                        </div>
                    </div>
                   
                    
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../components/_rent_management_modals.jsp"></jsp:include>