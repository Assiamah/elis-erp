<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<main class="container-fluid py-4">

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Rent Management Dashboard - ${fullname}</li>
        </ol>
    </nav>

    <!-- Statistics Cards -->
    <div class="row g-4 mb-5">
        <div class="col-md-4 col-lg-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="flex-shrink-0 me-3">
                        <i class="fas fa-users fa-2x text-primary"></i>
                    </div>
                    <div>
                        <h6 class="text-muted mb-1">Total Lessees/Assignees</h6>
                        <h4 class="mb-0" id="total_leasee">${total_leasee}</h4>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4 col-lg-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="flex-shrink-0 me-3">
                        <i class="fas fa-money-bill-wave fa-2x text-danger"></i>
                    </div>
                    <div>
                        <h6 class="text-muted mb-1">Total Rent Outstanding</h6>
                        <h4 class="mb-0 text-danger" id="rentOutstanding">GHS ${total_rent_oustanding}</h4>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4 col-lg-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="flex-shrink-0 me-3">
                        <i class="fas fa-check-circle fa-2x text-success"></i>
                    </div>
                    <div>
                        <h6 class="text-muted mb-1">Total Rents Paid (This Year)</h6>
                        <h4 class="mb-0 text-success">GHS 0.00</h4>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Lessee & Rent Records Section -->
    <section class="card shadow-sm border-0 mb-5">
        <div class="card-header bg-white border-bottom d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Lessee & Rent Records</h5>
            <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#addlegder">
                <i class="fas fa-plus-circle me-2"></i>Add Lessee
            </button>
        </div>

        <div class="card-body">
            <!-- Search Panel -->
            <div class="row mb-4">
                <div class="col-lg-5">
                    <label class="form-label fw-semibold">Search By</label>
                    <select class="form-select mb-3" id="rts_select_type">
                        <option disabled selected>-- Select Type --</option>
                        <option value="Plot Number">Plot Number</option>
                        <option value="Estate">Estate</option>
                        <option value="Name of Leasee/Assignee">Name of Lessee</option>
                    </select>

                    <div class="d-none" id="div_rent_estate">
                        <select class="form-select mb-3" id="rts_estate">
                            <option selected disabled>-- Select Estate --</option>
                            <c:forEach items="${estate_list}" var="estateList">
                                <option value="${estateList.ge_id}">${estateList.ge_location_name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="d-none" id="div_rent_keyword">
                        <input type="text" class="form-control mb-3" id="rts_keyword" placeholder="Enter keyword...">
                    </div>

                    <button class="btn btn-success w-100" id="btn_rt_search">
                        <i class="fas fa-search me-2"></i>Search
                    </button>
                </div>
            </div>

            <!-- Table -->
            <div class="table-responsive">
                <table class="table table-hover align-middle" id="job_casemgtdetailsdataTable">
                    <thead class="table-light">
                        <tr>
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
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Populated by DataTables -->
                    </tbody>
                </table>
            </div>
        </div>
    </section>

</main>