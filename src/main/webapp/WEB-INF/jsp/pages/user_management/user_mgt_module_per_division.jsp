 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


<div class="main-content app-content">
    <div class="container-fluid page-container">
        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-18 mb-0">Divisional User Management ::  <span class="text-danger">${division}</span></h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">User Management</li>
                </ol>
            </div>
            <small>
                <i class="ri-information-line me-2"></i>
                Manage system users, roles, and access permissions.
            </small>
        </div>

		<input type="hidden" id="user_regional_code_xx" value="${regional_code}" />
        <input type="hidden" id="user_division_code_xx" value="${division}" />
        <!-- End::page-header -->
        <div class="row">
          <div class="col-xxl-4 col-xl-6">
              <div class="row">
                  <div class="col-xl-12">
                      <div class="card custom-card overflow-hidden custom-hrm-list">
                          <div class="card-body p-0">
                              <div class="row g-0">
                                  <div class="col-xl-6 ">
                                      <div class="card custom-card dashboard-main-card primary school-card border-0 shadow-none border-lg-end border-bottom mb-0 rounded-0">
                                          <div class="card-body">
                                              <div class="mb-3">
                                                  <span class="avatar avatar-lg avatar-rounded bg-primary-transparent svg-primary">
                                                      <i class="bi bi-people fa-2x"></i>
                                                  </span>
                                              </div>
                                              <div class="text-muted mb-2">
                                                  Total Users
                                              </div>
                                              <div class="d-flex align-items-end gap-2 flex-wrap">
                                                  <h5 class="fw-semibold mb-0 lh-1">${fn:length(users_list)}</h5>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="col-xl-6">
                                      <div class="card custom-card dashboard-main-card success school-card border-0 shadow-none border-bottom mb-0 rounded-0">
                                          <div class="card-body">
                                              <div class="mb-3">
                                                  <span class="avatar avatar-lg avatar-rounded bg-success-transparent svg-success">
                                                      <i class="bi bi-person-check fa-2x"></i>
                                                  </span>
                                              </div>
                                              <div class="text-muted mb-2">
                                                  Active Users
                                              </div>
                                              <div class="d-flex align-items-end gap-2 flex-wrap">
                                                  <h5 class="fw-semibold mb-0 lh-1"><c:set var="activeCount" value="0" />
                                                    <c:forEach items="${users_list}" var="user">
                                                        <c:if test="${not user.isdisabled}">
                                                            <c:set var="activeCount" value="${activeCount + 1}" />
                                                        </c:if>
                                                    </c:forEach>
                                                    ${activeCount}
                                                  </h5>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="col-xl-6">
                                      <div class="card custom-card dashboard-main-card secondary school-card dashboard-main-border border-0 shadow-none border-lg-end mb-0 rounded-0">
                                          <div class="card-body">
                                              <div class="mb-3">
                                                  <span class="avatar avatar-lg avatar-rounded bg-secondary-transparent svg-secondary">
                                                      <i class="bi bi-person-lock fa-2x"></i>
                                                  </span>
                                              </div>
                                              <div class="text-muted mb-2">
                                                  Pending Password Reset
                                              </div>
                                              <div class="d-flex align-items-end gap-2 flex-wrap">
                                                  <h5 class="fw-semibold mb-0 lh-1">
                                                    <c:set var="passwordResetCount" value="0" />
                                                    <c:forEach items="${users_list}" var="user">
                                                        <fmt:parseNumber var="passwordvaliditydays" integerOnly="true" type="number" value="${user.passwordvaliditydays}" />
                                                        <c:if test="${passwordvaliditydays <= 7 and passwordvaliditydays > 0}">
                                                            <c:set var="passwordResetCount" value="${passwordResetCount + 1}" />
                                                        </c:if>
                                                    </c:forEach>
                                                    ${passwordResetCount}
                                                  </h5>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="col-xl-6">
                                      <div class="card custom-card dashboard-main-card warning school-card border-0 shadow-none mb-0 rounded-0">
                                          <div class="card-body">
                                              <div class="mb-3">
                                                  <span class="avatar avatar-lg avatar-rounded bg-warning-transparent svg-warning">
                                                      <i class="bi bi-person-slash fa-2x"></i>
                                                  </span>
                                              </div>
                                              <div class="text-muted mb-2">
                                                  Disabled Accounts
                                              </div>
                                              <div class="d-flex align-items-end gap-2 flex-wrap">
                                                  <h5 class="fw-semibold mb-0 lh-1">
                                                    <c:set var="disabledCount" value="0" />
                                                      <c:forEach items="${users_list}" var="user">
                                                          <c:if test="${user.isdisabled}">
                                                              <c:set var="disabledCount" value="${disabledCount + 1}" />
                                                          </c:if>
                                                      </c:forEach>
                                                      ${disabledCount}
                                                  </h5>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>

                       <div class="card custom-card overflow-hidden">
                          <div class="card-header">
                              <div class="card-title">
                                  User Distribution by Region
                              </div>
                          </div>
                        <div class="card-body py-0">
                              <div id="user-region-statistics"></div>
                          </div>
                          
                      </div>
                  </div>
                  
              </div>
          </div>
          <div class="col-xxl-8 col-xl-6">
            <div class="card custom-card">
              <div class="card-header justify-content-between">
                  <div> 
                    <h5 class="card-title mb-0">User List</h5>
                  </div> 
                  <div class="d-flex flex-wrap gap-2">
                    <button class="btn btn-danger label-btn" data-bs-toggle="modal" data-bs-target="#checkstepassignment">
                        <i class="ri-list-check-2 label-btn-icon fs-13"></i>
                        Check Step Assignment
                    </button>
                
                </div>
              </div>
              <div class="card-body p-3 position-relative" id="todo-content">
                  <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0" id="userTable">
                        <thead class="table-light">
                            <tr>
                                <!-- <th class="ps-4" width="40">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="selectAll">
                                    </div>
                                </th> -->
                                <th>User Details</th>
                                <th>Region</th>
                                <th>Division</th>
                                <th>Unit/Department</th>
                                <th>Status</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${users_list}" var="user" varStatus="loop">
                              <fmt:parseNumber var="passwordvaliditydays" integerOnly="true" type="number" value="${user.passwordvaliditydays}" />
                              <fmt:parseNumber var="user_level_single" integerOnly="true" type="number" value="${user.user_level}" />
                              <tr class="${user.isdisabled ? 'table-danger' : ''} ${passwordvaliditydays <= 7 and passwordvaliditydays > 0 ? 'table-warning' : ''}"
                                    data-status="${user.isdisabled ? 'disabled' : 'active'}"
                                    data-region="${user.region}">

                                  <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle me-2">
                                            <i class="ri-user-line text-muted"></i>
                                        </div>
                                        <div>
                                            <div class="fw-medium text-primary small">${user.fullname}</div>
                                            <small class="text-muted small">${user.emailaddress}</small>
                                        </div>
                                    </div>
                                  </td>

                                  <td><span class="small text-dark">${user.region}</span></td>
                                  <td><span class="badge bg-light text-dark">${user.division}</span></td>
                                  <td><span class="small text-dark">${fn:length(user.unit_name) >20 ? fn:substring(user.unit_name, 0, 20) : user.unit_name}</span></td>
                                  <td>
                                    <span class="badge ${user.isdisabled ? 'bg-danger' : 'bg-success'}">${user.isdisabled ? 'Disabled' : 'Active'}</span><br>
                                    <c:if test="${passwordvaliditydays <= 7 and passwordvaliditydays > 0}">
                                        <small class="text-warning">
                                            <i class="fas fa-exclamation-triangle me-1"></i>
                                            Password expires in ${passwordvaliditydays} days
                                        </small>
                                    </c:if>
                                  </td>
                                  <td>
                                    <div class="d-flex justify-content-center gap-2">
                                        <div class="btn-group">
                                            <!-- <button class="btn btn-sm btn-outline-primary"
                                                data-bs-toggle="modal" 
                                                data-bs-target="#addupdateuserdatails"
                                                data-userid="${user.userid}" 
                                                data-username="${user.username}" 
                                                data-fullname="${user.fullname}"  
                                                data-userprofile="${user.userprofile}" 
                                                data-isdisabled="${user.isdisabled}" 
                                                data-staffnumber="${user.staffnumber}"  
                                                data-title="${user.title}" 
                                                data-designation="${user.designation}" 
                                                data-division="${user.division}"  
                                                data-address="${user.address}" 
                                                data-phone="${user.phone}" 
                                                data-mobile="${user.mobile}" 
                                                data-emailaddress="${user.emailaddress}"  
                                                data-department="${user.department}" 
                                                data-department_id="${user.department_code}"
                                                data-department_name="${user.department}"
                                                data-district="${user.district}"
                                                data-district_code="${user.regional_code}"
                                                data-district_name="${user.regional_name}"
                                                data-region="${user.region}"
                                                data-region_id="${user.region_id}"
                                                data-id="${user.id}" 
                                                data-passwordchanged="${user.passwordchanged}"  
                                                data-canpasswordexpire="${user.canpasswordexpire}" 
                                                data-passwordvaliditydays="${passwordvaliditydays}" 
                                                data-passwordexpirydate="${user.passwordexpirydate}" 
                                                data-user_level="${user.user_level}"
                                                data-usr_access_level="${user.usr_access_level}"
                                                data-view_all_offices="${user.view_all_offices}">
                                                <i class="fas fa-edit"></i>
                                            </button> -->
                                            
                                            <button class="btn btn-sm btn-outline-success"
                                                data-bs-toggle="modal"
                                                data-bs-target="#assignReassignUserProfile"
                                                data-userid="${user.userid}"
                                                data-username="${user.username}"
                                                data-fullname="${user.fullname}"
                                                data-division="${user.division}">
                                                <i class="fas fa-user-shield"></i>
                                            </button>

                                            <button class="btn btn-sm btn-outline-danger"
                                                data-bs-toggle="modal"
                                                data-bs-target="#assignMilestoneUserProfile"
                                                data-userid="${user.userid}"
                                                data-username="${user.username}"
                                                data-fullname="${user.fullname}"
                                                data-division="${user.division}">
                                                <i class="fas fa-list"></i>
                                            </button>
                                            
                                        </div>
                                        </div>
                                  </td>

                              </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                  </div>
              </div>
          
          </div>
          </div>
      </div>
    </div>    
</div>

<jsp:include page="user_mgt_modals.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/assets/libs/apexcharts/dist/apexcharts.min.js"></script>
<script>
    $(document).ready(function() {
        const table = $('#userTable').DataTable({
            stateSave: true,
            pageLength: 10
        });

        const regionMap = {};

        // Loop through ALL rows (not just visible ones)
        table.rows().every(function () {
            const row = this.node();
            const region = row.dataset.region?.trim();

            if (!region) return;

            regionMap[region] = (regionMap[region] || 0) + 1;
        });

        // Convert grouped data to arrays
        let categories = Object.keys(regionMap);
        let seriesData = Object.values(regionMap);

        // Sort descending
        const combined = categories.map((r, i) => ({
            region: r,
            count: seriesData[i]
        })).sort((a, b) => b.count - a.count);

        categories = combined.map(x => x.region);
        seriesData = combined.map(x => x.count);

        // Ensure minimum rows
        const MIN_ROWS = 10;
        while (categories.length < MIN_ROWS) {
            categories.push('—');
            seriesData.push(0);
        }

        renderRegionChart(categories, seriesData);

        function renderRegionChart(categories, seriesData) {

          const options = {
              series: [{
                  name: 'Users',
                  data: seriesData
              }],
              chart: {
                  type: 'bar',
                  height: 351,
                  fontFamily: 'Poppins, Arial, sans-serif',
                  toolbar: { show: false }
              },
              grid: {
                  borderColor: '#f2f6f7'
              },
              plotOptions: {
                  bar: {
                      horizontal: true,
                      barHeight: "30%",
                      borderRadius: 2
                  }
              },
              colors: ["var(--primary-color)"],
              dataLabels: {
                  enabled: false
              },
              xaxis: {
                  categories: categories,
                  labels: {
                      formatter: function (val) {
                          if (val >= 1_000) return (val / 1_000).toFixed(1).replace(/\.0$/, '') + 'K';
                          return val;
                      }
                  }
              },
              tooltip: {
                  y: {
                      formatter: val => val+` users`
                  }
              }
          };

          const chart = new ApexCharts(
              document.querySelector("#user-region-statistics"),
              options
          );

          chart.render();
      }

    });
</script>
  