<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- <%@ page import="com.report_class.cls_reports" %> --%>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


<jsp:include page="../includes/_header.jsp"></jsp:include>
<jsp:useBean id="now" class="java.util.Date" />

<link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>

<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script> -->

  <style>
    .card {
            border-radius: 15px !important;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
            margin-bottom: 30px;
            -webkit-transition: all 0.3s ease-in-out;
            transition: all 0.3s ease-in-out;
        }
        
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }
        
        .card-header {
            background-color: white;
            border-bottom: 1px solid #eee;
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .stat-card {
            text-align: center;
            padding: 15px;
        }
        
        .stat-card .value {
            font-size: 2rem;
            font-weight: 700;
        }
        
        .stat-card .label {
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        .bg-c-blue {
            background: linear-gradient(135deg, #3a7bd5, #3a6073);
            color: white;
        }
        
        .bg-c-green {
            background: linear-gradient(135deg, #A8E063, #56AB2F);
            color: white;
        }
        
        .bg-c-yellow {
            background: linear-gradient(135deg, #ffb347, #ffcc33);
            color: white;
        }
        
        .bg-c-pink {
            background: linear-gradient(135deg, #ff4d4d, #b30000);
            color: white;
        }
        
        .bg-c-completed {
            background: linear-gradient(135deg, #4CAF50, #2E8B57);
            color: white;
        }
        
        .user-activity-table tr:hover {
            background-color: rgba(0,0,0,0.02);
        }
        
        .badge-online {
            background-color: var(--success-color);
        }
        
        .badge-offline {
            background-color: #95a5a6;
        }
        
        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }
        
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            background: linear-gradient(135deg, var(--primary-color), #008552);
            color: white;
        }
        
        .navbar a {
            color: white !important;
        }
        
        .division-badge {
            font-size: 0.75rem;
            padding: 0.3em 0.6em;
        }
        
        .activity-log {
            max-height: 400px;
            overflow-y: auto;
        }
        
        .change-highlight {
            background-color: #fff9e6;
            border-left: 3px solid var(--secondary-color);
            padding: 8px 12px;
            margin: 5px 0;
            border-radius: 4px;
        }
        
        .login-log {
            background-color: #e8f4fd;
            border-left: 3px solid var(--primary-color);
            padding: 8px 12px;
            margin: 5px 0;
            border-radius: 4px;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
        
        .tab-content {
            border-left: 1px solid #dee2e6;
            border-right: 1px solid #dee2e6;
            border-bottom: 1px solid #dee2e6;
            padding: 15px;
            border-radius: 0 0 4px 4px;
        }
        
        .division-card {
            border-top: 4px solid;
        }
        
        .division-pvlmd {
            border-top-color: var(--primary-color);
        }
        
        .division-lrd {
            border-top-color: var(--secondary-color);
        }
        
        .division-lvd {
            border-top-color: var(--accent-color);
        }
        
        .division-smd {
            border-top-color: #9b59b6;
        }
        
        .ghana-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color), var(--accent-color));
            color: white;
            padding: 15px 0;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .logo-container {
            display: flex;
            align-items: center;
        }
        
        .logo {
            width: 60px;
            height: 60px;
            background-color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-weight: bold;
            color: var(--primary-color);
        }
        
        .header-text h1 {
            font-size: 1.8rem;
            margin: 0;
            font-weight: 700;
        }
        
        .header-text p {
            margin: 0;
            opacity: 0.9;
        }
        
        .dashboard-subtitle {
            color: #6c757d;
            font-size: 1.0rem;
        }
        
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e3e6f0;
        }
        
        @media (max-width: 768px) {
            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .quick-actions {
                flex-direction: column;
            }
        }
        
        .text-success {
            color: #2E8B57 !important;
        }
  #logsContainer .rounded {
    transition: transform 0.2s, background 0.3s;
  }
  #logsContainer .rounded:hover {
    transform: translateY(-4px);
    background: #f8f9fa;
  }


  /* Add these styles to your CSS file */
.modal-glass {
  backdrop-filter: blur(10px);
  background: rgba(255, 255, 255, 0.95);
}

.bg-light-gray {
  background-color: #f8f9fa;
}

.font-weight-600 {
  font-weight: 600;
}

.font-weight-700 {
  font-weight: 700;
}

.activity-badge {
  padding: 0.35em 0.65em;
  font-size: 0.75em;
  font-weight: 600;
  border-radius: 0.375rem;
}

.activity-row:hover {
  background-color: #f8f9fa;
  transform: translateY(-1px);
  transition: all 0.2s ease;
}

.empty-state {
  padding: 2rem;
  text-align: center;
}

.summary-card {
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.summary-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.1) !important;
}

.bg-opacity-20 {
  background-color: rgba(255, 255, 255, 0.2);
}

.text-opacity-80 {
  opacity: 0.8;
}

.hover-bg-opacity-30:hover {
  background-color: rgba(255, 255, 255, 0.3);
}

.transition-all {
  transition: all 0.3s ease;
}

.rounded-top-lg {
  border-top-left-radius: 0.75rem !important;
  border-top-right-radius: 0.75rem !important;
}

.icon-container {
  width: 48px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* .bg-c-green { background: #28a745; } */
/* .bg-c-blue { background: #007bff; } */
/* .bg-c-yellow { background: #ffc107; } */
.bg-c-orange { background: #fd7e14; }
.bg-c-purple { background: #6f42c1; }
/* .bg-c-pink { background: #e83e8c; } */
.bg-c-teal { background: #20c997; }
.bg-c-red {
     background: linear-gradient(135deg, #ff4d4d, #b30000);
            color: white;
    
    }

.data-section {
    background: white;
    border-radius: 8px;
    padding: 0;
}

.data-row:hover {
    background-color: #f8f9fa;
    transition: background-color 0.2s ease;
}

.section-title {
    font-weight: 600;
    font-size: 0.9rem;
    color: #495057;
}

.data-grid {
    font-size: 0.85rem;
}

.modal-xl {
    max-width: 1200px;
}

.card {
    border: none;
    box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    border-radius: 0.5rem;
}

.card-header {
    border-radius: 0.5rem 0.5rem 0 0 !important;
    font-weight: 600;
}
#activityMap {
  width: 100%;
  height: 400px;
}

#activityMap_1 {
  width: 100%;
  height: 400px;
}



.professional-data-view {
    background: #fff;
    border-radius: 0 0 8px 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.data-header {
    border-radius: 8px 8px 0 0 !important;
}

.section-title {
    font-size: 0.9rem;
    font-weight: 600;
    color: #495057;
    border-bottom: 2px solid #e9ecef;
    padding-bottom: 0.5rem;
}

.value-display {
    font-weight: 500;
    color: #212529;
    padding: 0.25rem 0;
}

.change-comparison {
    display: flex;
    align-items: center;
}

.original-value {
    color: #6c757d;
    text-decoration: line-through;
    background: #f8f9fa;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    font-size: 0.875rem;
}

.new-value {
    background: #d4edda;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    font-size: 0.875rem;
}

.remarks-box {
    background: linear-gradient(135deg, #17a2b8, #138496) !important;
    border: none;
}

.technical-display {
    font-size: 0.75rem;
    line-height: 1.4;
    max-height: 60px;
    overflow: hidden;
}

.change-item {
    transition: all 0.3s ease;
}

.change-item:hover {
    transform: translateX(5px);
}

.badge {
    font-size: 0.7rem;
    padding: 0.25em 0.6em;
}

.data-section {
    transition: background-color 0.2s ease;
}

.data-section:hover {
    background-color: #f8f9fa;
}


    </style>



    <!-- Sidebar -->
   
    <!-- Main Content -->
     <div class="container-fluid">
        <!-- Ghana Lands Commission Header -->

          <input type="hidden" id = "startdate">
			  <input type="hidden" id = "start_date">
			  <input type="hidden" id = "enddate">
			  <input type="hidden" id = "end_date">


       

        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <div>
                <h1 class="h3 mb-1 text-gray-800 dashboard-title">User Activity Dashboard</h1>
                <p class="dashboard-subtitle">
                    This Dashboard provides comprehensive visibility into user activities across all divisions. 
                    Monitor staff login patterns, track changes made to land records, and analyze operational trends.
                </p>
            </div>
        </div>



           <div class="row">
                    
				
                    <div class="col-sm-4">
                        <div class="card">
                          <div class="card-body">
                              <label for="">Date From</label> 
                              <input type="text" id="datefrom" class="form-control"  placeholder="Select Date Range">
                              <!-- <div id="reportrange" style="background: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 80%">
                                <i class="fa fa-calendar"></i>&nbsp;
                                <span></span> <i class="fa fa-caret-down"></i>
                            </div> -->
                          </div>
                        </div>
                      </div>


                      <div class="col-sm-4">
                        <div class="card">
                          <div class="card-body">
                              <label for="">Date To</label> 
                              <input type="text" id="dateto" class="form-control"  placeholder="Select Date Range">
                              <!-- <div id="reportrange" style="background: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 80%">
                                <i class="fa fa-calendar"></i>&nbsp;
                                <span></span> <i class="fa fa-caret-down"></i>
                            </div> -->
                          </div>
                        </div>
                      </div>

                  </div>



        <!-- User Activity Summary Cards -->
        <div class="row mb-4">
  <!-- New Transaction Added -->
  <div class="col-md-3 mb-3">
    <div class="card bg-c-green shadow h-100 py-2 advanced-activity-logs-card" 
         data-activity="New Transaction Added" style="cursor:pointer;">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <div class="text-xs font-weight-bold text-white text-uppercase mb-1">New Transaction Added</div>
            <div class="h5 mb-0 font-weight-bold text-white-800">0</div>
          </div>
          <i class="fas fa-file-invoice-dollar fa-2x text-white-300"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- New Parcel Added -->
  <div class="col-md-3 mb-3">
    <div class="card bg-c-blue shadow h-100 py-2 advanced-activity-logs-card" 
         data-activity="New Parcel Added" style="cursor:pointer;">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <div class="text-xs font-weight-bold text-white text-uppercase mb-1">New Parcel Added</div>
            <div class="h5 mb-0 font-weight-bold text-white-800">0</div>
          </div>
          <i class="fas fa-box-open fa-2x text-white-300"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- Parcel Update -->
  <div class="col-md-3 mb-3">
    <div class="card bg-c-yellow shadow h-100 py-2 advanced-activity-logs-card"
         data-activity="Parcel Update" style="cursor:pointer;">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Parcel Update</div>
            <div class="h5 mb-0 font-weight-bold text-white-800">0</div>
          </div>
          <i class="fas fa-sync fa-2x text-white-300"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- Transaction Update -->
  <div class="col-md-3 mb-3">
    <div class="card bg-c-orange shadow h-100 py-2 advanced-activity-logs-card"
         data-activity="Transaction Update" style="cursor:pointer;">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Transaction Update</div>
            <div class="h5 mb-0 font-weight-bold text-white-800">0</div>
          </div>
          <i class="fas fa-exchange-alt fa-2x text-white-300"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- New Plotting Created -->
  <div class="col-md-3 mb-3">
    <div class="card bg-c-purple shadow h-100 py-2 advanced-activity-logs-card"
         data-activity="New Plotting Created" style="cursor:pointer;">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <div class="text-xs font-weight-bold text-white text-uppercase mb-1">New Plotting Created</div>
            <div class="h5 mb-0 font-weight-bold text-white-800">0</div>
          </div>
          <i class="fas fa-drafting-compass fa-2x text-white-300"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- User Update -->
  <div class="col-md-3 mb-3">
    <div class="card bg-c-pink shadow h-100 py-2 advanced-activity-logs-card"
         data-activity="User Update" style="cursor:pointer;">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <div class="text-xs font-weight-bold text-white text-uppercase mb-1">User Update</div>
            <div class="h5 mb-0 font-weight-bold text-white-800">0</div>
          </div>
          <i class="fas fa-user-edit fa-2x text-white-300"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- New User Added -->
  <div class="col-md-3 mb-3">
    <div class="card bg-c-teal shadow h-100 py-2 advanced-activity-logs-card"
         data-activity="New User Added" style="cursor:pointer;">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <div class="text-xs font-weight-bold text-white text-uppercase mb-1">New User Added</div>
            <div class="h5 mb-0 font-weight-bold text-white-800">0</div>
          </div>
          <i class="fas fa-user-plus fa-2x text-white-300"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- Parcel Deleted -->
  <div class="col-md-3 mb-3">
    <div class="card bg-c-red shadow h-100 py-2 advanced-activity-logs-card"
         data-activity="Parcel Deleted" style="cursor:pointer;">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Parcel Deleted</div>
            <div class="h5 mb-0 font-weight-bold text-white-800">0</div>
          </div>
          <i class="fas fa-trash-alt fa-2x text-white-300"></i>
        </div>
      </div>
    </div>
  </div>
</div>

        
        

       
    </div>

    <!-- Bootstrap & jQuery Scripts
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script> -->



<!-- Advanced Activity Logs Modal -->
<!-- <div class="modal fade" id="activityLogsModal" tabindex="-1" role="dialog" aria-labelledby="activityLogsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
    <div class="modal-content modal-glass shadow-lg border-0">
      
      <div class="modal-header bg-gradient-primary text-white d-flex justify-content-between align-items-center rounded-top-lg py-3">
        <div class="d-flex align-items-center">
          <div class="icon-container bg-white bg-opacity-20 rounded-circle p-2 mr-3">
            <i class="fas fa-chart-line fa-lg text-white"></i>
          </div>
          <div>
            <h5 class="modal-title font-weight-700 mb-0">Activity Logs Summary</h5>
            <small class="text-white text-opacity-80">Comprehensive overview of system activities</small>
          </div>
        </div>
        <button type="button" class="close text-white bg-opacity-20 hover-bg-opacity-30 rounded-circle p-1 transition-all" data-dismiss="modal" aria-label="Close" style="width: 32px; height: 32px;">
          <span aria-hidden="true" style="font-size: 1.2rem; line-height: 1;">&times;</span>
        </button>
      </div>

      <div class="modal-body bg-light-gray py-4">


        <div class="card border-0 shadow-sm">
          <div class="card-header bg-white border-0 py-3">
            <h6 class="card-title mb-0 text-dark font-weight-600">
              <i class="fas fa-list-ul mr-2 text-primary"></i>
              Activity Breakdown
            </h6>
          </div>
          <div class="card-body p-0">
            <div class="table-responsive">
              <table class="table table-hover align-middle mb-0" id="activityLogsTable">
                <thead class="bg-light text-dark">
                  <tr>
                    <th class="border-0 font-weight-600 text-muted" style="width: 8%">#</th>
                    <th class="border-0 font-weight-600 text-muted">Activity Type</th>
                    <th class="border-0 font-weight-600 text-muted text-right">Count</th>
                    <th class="border-0 font-weight-600 text-muted text-center">Actions</th>
                  </tr>
                </thead>
                <tbody>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>

      <div class="modal-footer bg-white border-top py-3">
        <button type="button" class="btn btn-outline-secondary rounded-pill px-4" data-dismiss="modal">
          <i class="fas fa-times mr-2"></i> Close
        </button>
        <button type="button" class="btn btn-outline-primary rounded-pill px-4">
          <i class="fas fa-filter mr-2"></i> Filter
        </button>
        <button type="button" class="btn btn-primary rounded-pill px-4 shadow-sm">
          <i class="fas fa-download mr-2"></i> Export Report
        </button>
      </div>
    </div>
  </div>
</div> -->




<!-- Advanced Activity Logs Modal -->
<!-- <div class="modal fade" id="activityLogsModal" tabindex="-1" role="dialog" aria-labelledby="activityLogsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="activityLogsModalLabel">Advanced Activity Logs</h5>
        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table id="activityLogsTable" class="table table-striped table-bordered" style="width:100%">
          <thead>
            <tr>
              <th>User Name</th>
              <th>User ID</th>
              <th>Department</th>
              <th>Region</th>
              <th>Designation</th>
              <th>Total Activities</th>
            </tr>
          </thead>
          <tbody>
            <tr><td colspan="6" class="text-center">Loading...</td></tr>
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div> -->




<!-- Advanced Activity Logs Modal -->
<div class="modal fade" id="activityLogsModal" tabindex="-1" role="dialog" aria-labelledby="activityLogsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content modal-glass shadow-lg border-0">
      
      <div class="modal-header bg-gradient-primary text-white d-flex justify-content-between align-items-center rounded-top-lg py-3">
        <div class="d-flex align-items-center">
          <div class="icon-container bg-white bg-opacity-20 rounded-circle p-2 mr-3">
            <i class="fas fa-chart-line fa-lg text-white"></i>
          </div>
          <div>
            <h5 class="modal-title font-weight-700 mb-0" id="audit_title"></h5>
            <small class="text-white text-opacity-80">Comprehensive overview of system activities</small>
          </div>
        </div>
        <button type="button" class="close text-white bg-opacity-20 hover-bg-opacity-30 rounded-circle p-1 transition-all" data-dismiss="modal" aria-label="Close" style="width: 32px; height: 32px;">
          <span aria-hidden="true" style="font-size: 1.2rem; line-height: 1;">&times;</span>
        </button>
      </div>

      <div class="modal-body bg-light-gray py-4">


        <div class="table-responsive">
						<table class="table table-bordered table-hover" id="activityLogsTable" width="100%" cellspacing="0" data-order='[[ 1, "desc" ]]'>
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Officer</th>
                        <th>Division</th>
						<th>Designation</th>
						<th>Department</th>
						<th>Region</th>
                        <th>Count</th>
                        <th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
					</div> 


        

      </div>
      <div class="modal-footer bg-white border-top py-3">
        <button type="button" class="btn btn-outline-secondary rounded-pill px-4" data-dismiss="modal">
          <i class="fas fa-times mr-2"></i> Close
        </button>
        <!-- <button type="button" class="btn btn-outline-primary rounded-pill px-4">
          <i class="fas fa-filter mr-2"></i> Filter
        </button>
        <button type="button" class="btn btn-primary rounded-pill px-4 shadow-sm">
          <i class="fas fa-download mr-2"></i> Export Report
        </button> -->
      </div>
    </div>
  </div>
</div>




<div class="modal fade" id="USERactivityLogsModal" tabindex="-1" role="dialog" aria-labelledby="USERactivityLogsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content modal-glass shadow-lg border-0">
      
      <div class="modal-header bg-gradient-primary text-white d-flex justify-content-between align-items-center rounded-top-lg py-3">
        <div class="d-flex align-items-center">
          <div class="icon-container bg-white bg-opacity-20 rounded-circle p-2 mr-3">
            <i class="fas fa-chart-line fa-lg text-white"></i>
          </div>
          <div>
            <h5 class="modal-title font-weight-700 mb-0" id="user_audit_title"></h5>
            <small class="text-white text-opacity-80">Comprehensive overview of system activities</small>
          </div>
        </div>
        <button type="button" class="close text-white bg-opacity-20 hover-bg-opacity-30 rounded-circle p-1 transition-all" data-dismiss="modal" aria-label="Close" style="width: 32px; height: 32px;">
          <span aria-hidden="true" style="font-size: 1.2rem; line-height: 1;">&times;</span>
        </button>
      </div>

      <div class="modal-body bg-light-gray py-4">


        <div class="table-responsive">
						<table class="table table-bordered table-hover" id="useractivityLogsTable" width="100%" cellspacing="0" data-order='[[ 1, "desc" ]]'>
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Description</th>
                        <th>Date</th>
                        <th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
					</div> 


        

      </div>
      <div class="modal-footer bg-white border-top py-3">
        <button type="button" class="btn btn-outline-secondary rounded-pill px-4" data-dismiss="modal">
          <i class="fas fa-times mr-2"></i> Close
        </button>
        <!-- <button type="button" class="btn btn-outline-primary rounded-pill px-4">
          <i class="fas fa-filter mr-2"></i> Filter
        </button>
        <button type="button" class="btn btn-primary rounded-pill px-4 shadow-sm">
          <i class="fas fa-download mr-2"></i> Export Report
        </button> -->
      </div>
    </div>
  </div>
</div>


 <!-- <div class="modal fade" id="activityLogsModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="recieved_applications_title"><span id="reportheading"></span> </h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"> <i class="fa fa-times"></i></span>
					</button>
				</div>
				<div class="modal-body">
				
					<div class="table-responsive">
						<table class="table table-bordered table-hover" id="activityLogsTable" width="100%" cellspacing="0" data-order='[[ 1, "desc" ]]'>
				 <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
				   <thead>
						<th>Service Name</th>
						<th>Count</th>
						<th>Percentage</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
					</div> 
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
				</div>
			</div>
		</div>
		</div>  -->




        <!-- Detailed Activity Changes Modal -->
<div class="modal fade" id="activityChangesModal" tabindex="-1" role="dialog" aria-labelledby="activityChangesModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="activityChangesModalLabel">
                    <i class="fas fa-history"></i> Activity Change Details
                </h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Summary Card -->
                <div class="card mb-4">
                    <div class="card-header bg-light">
                        <h6 class="mb-0"><i class="fas fa-info-circle"></i> Change Summary</h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <strong>Change Date:</strong>
                                <span id="changeDateSummary" class="text-primary"></span>
                            </div>
                            <div class="col-md-4">
                                <strong>User:</strong>
                                <span id="userSummary" class="text-primary"></span>
                            </div>
                            <div class="col-md-4">
                                <strong>IP Address:</strong>
                                <span id="ipSummary" class="text-primary"></span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Original Data -->
                    <div class="col-md-6">
                        <div class="card h-100">
                            <div class="card-header bg-secondary text-white">
                                <h6 class="mb-0"><i class="fas fa-database"></i> Original Data</h6>
                            </div>
                            <div class="card-body p-0">
                                <div id="originalDataContent" class="p-3" style="max-height: 400px; overflow-y: auto;"></div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Changes Requested -->
                    <div class="col-md-6">
                        <div class="card h-100">
                            <div class="card-header bg-warning text-dark">
                                <h6 class="mb-0"><i class="fas fa-edit"></i> Modifications Made</h6>
                            </div>
                            <div class="card-body p-0">
                                <div id="changesRequestedContent" class="p-3" style="max-height: 400px; overflow-y: auto;"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- WKT Polygon Section -->
                <div class="card mt-4">
                    <div class="card-header bg-info text-white">
                        <h6 class="mb-0"><i class="fas fa-map-marker-alt"></i> Spatial Data (WKT Polygon)</h6>
                    </div>
                    <div class="card-body">
                        <div id="wktPolygonContent" style="font-family: 'Courier New', monospace; background: #f8f9fa; padding: 15px; border-radius: 5px; max-height: 200px; overflow-y: auto;"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">
                    <i class="fas fa-times"></i> Close
                </button>
                <button type="button" class="btn btn-primary" onclick="exportChangeDetails()">
                    <i class="fas fa-download"></i> Export Details
                </button>
            </div>
        </div>
    </div>
</div>



<!-- Activity Details Modal -->


<div class="modal fade" id="activityDetailsModal" tabindex="-1" role="dialog" aria-labelledby="activityDetailsLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
        <div class="modal-header bg-gradient-primary text-white d-flex justify-content-between align-items-center rounded-top-lg py-3">
        <div class="d-flex align-items-center">
          <div class="icon-container bg-white bg-opacity-20 rounded-circle p-2 mr-3">
            <i class="fas fa-chart-line fa-lg text-white"></i>
          </div>
          <div>
            <h5 class="modal-title font-weight-700 mb-0" id="t_audit_title_update_parcel"></h5>
            <small class="text-white text-opacity-80">Comprehensive overview of system activities</small>
          </div>
        </div>
        <button type="button" class="close text-white bg-opacity-20 hover-bg-opacity-30 rounded-circle p-1 transition-all" data-dismiss="modal" aria-label="Close" style="width: 32px; height: 32px;">
          <span aria-hidden="true" style="font-size: 1.2rem; line-height: 1;">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <div class="row mb-3">
            <div class="col-md-6">
                <strong><i class="fas fa-calendar"></i> Log Date:</strong> 
                <span id="logDateDisplay" class="text-primary font-weight-bold"></span>
            </div>
            <div class="col-md-6 text-right">
                <!-- <div class="map-legend">
                    <span class="legend-item mr-3">
                        <span class="legend-color" style="background: #0066cc; width: 15px; height: 8px; display: inline-block; vertical-align: middle; border-radius: 2px;"></span>
                        <small class="ml-1">Original</small>
                    </span>
                    <span class="legend-item">
                        <span class="legend-color" style="background: #cc0000; width: 15px; height: 8px; display: inline-block; vertical-align: middle; border: 1px dashed #000; border-radius: 2px;"></span>
                        <small class="ml-1">Updated</small>
                    </span>
                </div> -->
            </div>
        </div>

        <div class="row mb-4">
          <div class="col-md-6">
            <div class="card h-100">
                <div class="card-header bg-primary text-white py-2">
                    <h6 class="mb-0"><i class="fas fa-database"></i> Original Data</h6>
                </div>
                <div class="card-body p-0">
                    <div id="originalData" style="max-height: 400px; overflow-y: auto;"></div>
                </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="card h-100">
                <div class="card-header bg-warning text-dark py-2">
                    <h6 class="mb-0"><i class="fas fa-edit"></i> Modifications Made</h6>
                </div>
                <div class="card-body p-0">
                    <div id="changesRequested" style="max-height: 400px; overflow-y: auto;"></div>
                </div>
            </div>
          </div>
        </div>

        <div class="card">
            <div class="card-header bg-success text-white py-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0"><i class="fas fa-map"></i> Spatial Comparison</h6>
                <small class="badge badge-light">
                    <i class="fas fa-layer-group"></i> Switch maps using top-right controls
                </small>
            </div>
            <div class="card-body p-0 position-relative">
                <div id="activityMap" style="height: 450px; width: 100%;"></div>
                <div id="mapStatus" class="p-2 bg-light border-top small text-muted">
                    <i class="fas fa-sync fa-spin"></i> Initializing map with layer controls...
                </div>
            </div>
        </div>
      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" data-dismiss="modal">
            <i class="fas fa-times"></i> Close
        </button>
        
      </div>
    </div>
  </div>
</div>






<div class="modal fade" id="newactivityDetailsModal" tabindex="-1" role="dialog" aria-labelledby="activityDetailsLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
        <div class="modal-header bg-gradient-primary text-white d-flex justify-content-between align-items-center rounded-top-lg py-3">
        <div class="d-flex align-items-center">
          <div class="icon-container bg-white bg-opacity-20 rounded-circle p-2 mr-3">
            <i class="fas fa-chart-line fa-lg text-white"></i>
          </div>
          <div>
            <h5 class="modal-title font-weight-700 mb-0" id="t_audit_title"></h5>
            <small class="text-white text-opacity-80">Comprehensive overview of system activities</small>
          </div>
        </div>
        <button type="button" class="close text-white bg-opacity-20 hover-bg-opacity-30 rounded-circle p-1 transition-all" data-dismiss="modal" aria-label="Close" style="width: 32px; height: 32px;">
          <span aria-hidden="true" style="font-size: 1.2rem; line-height: 1;">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <div class="row mb-3">
            <div class="col-md-6">
                <strong><i class="fas fa-calendar"></i> Log Date:</strong> 
                <span id="logDateDisplay_6" class="text-primary font-weight-bold"></span>
            </div>
            
        </div>

        <div class="row mb-4">
          
          <div class="col-md-12">
            <div class="card h-100">
                <div class="card-header bg-warning text-dark py-2">
                    <h6 class="mb-0"><i class="fas fa-edit"></i> Data Added</h6>
                </div>
                <div class="card-body p-0">
                    <div id="changesRequestedd" style="max-height: 400px; overflow-y: auto;"></div>
                </div>
            </div>
          </div>
        </div>

    
      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" data-dismiss="modal">
            <i class="fas fa-times"></i> Close
        </button>
        
      </div>
    </div>
  </div>
</div>







<div class="modal fade" id="addParcelDetailsModal" tabindex="-1" role="dialog" aria-labelledby="activityDetailsLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
        <div class="modal-header bg-gradient-primary text-white d-flex justify-content-between align-items-center rounded-top-lg py-3">
        <div class="d-flex align-items-center">
          <div class="icon-container bg-white bg-opacity-20 rounded-circle p-2 mr-3">
            <i class="fas fa-chart-line fa-lg text-white"></i>
          </div>
          <div>
            <h5 class="modal-title font-weight-700 mb-0" id="t_audit_title1"></h5>
            <small class="text-white text-opacity-80">Comprehensive overview of system activities</small>
          </div>
        </div>
        <button type="button" class="close text-white bg-opacity-20 hover-bg-opacity-30 rounded-circle p-1 transition-all" data-dismiss="modal" aria-label="Close" style="width: 32px; height: 32px;">
          <span aria-hidden="true" style="font-size: 1.2rem; line-height: 1;">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <div class="row mb-3">
            <div class="col-md-6">
                <strong><i class="fas fa-calendar"></i> Log Date:</strong> 
                <span id="logDateDisplay_2" class="text-primary font-weight-bold"></span>
            </div>
            
        </div>

        <div class="row mb-4">
          <div class="col-md-12">
            <div class="card h-100">
                <div class="card-header bg-warning text-dark py-2">
                    <h6 class="mb-0"><i class="fas fa-edit"></i> Plotting Info</h6>
                </div>
                <div class="card-body p-0">
                    <div id="AddParcelchangesRequested" style="max-height: 400px; overflow-y: auto;"></div>
                </div>
            </div>
          </div>
        </div>

        <div class="card">
            <div class="card-header bg-success text-white py-2 d-flex justify-content-between align-items-center">
                <h6 class="mb-0"><i class="fas fa-map"></i> Spatial Component</h6>
                <!-- <small class="badge badge-light">
                    <i class="fas fa-layer-group"></i> Switch maps using top-right controls
                </small> -->
            </div>
            <div class="card-body p-0 position-relative">
                <div id="addParcelActivityMap" style="height: 450px; width: 100%;"></div>
                <div id="addParcelMapStatus" class="p-2 bg-light border-top small text-muted">
                    <i class="fas fa-sync fa-spin"></i> Initializing map with layer controls...
                </div>
            </div>
        </div>
      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" data-dismiss="modal">
            <i class="fas fa-times"></i> Close
        </button>
        <!-- <button class="btn btn-info" onclick="resetMapView()">
            <i class="fas fa-crosshairs"></i> Reset View
        </button> -->
      </div>
    </div>
  </div>
</div>




<div class="modal fade" id="transactionUpdateModal" tabindex="-1" role="dialog" aria-labelledby="transactionUpdateModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
        <div class="modal-header bg-gradient-primary text-white d-flex justify-content-between align-items-center rounded-top-lg py-3">
        <div class="d-flex align-items-center">
          <div class="icon-container bg-white bg-opacity-20 rounded-circle p-2 mr-3">
            <i class="fas fa-chart-line fa-lg text-white"></i>
          </div>
          <div>
            <h5 class="modal-title font-weight-700 mb-0" id="t_audit_title_update_transaction"></h5>
            <small class="text-white text-opacity-80">Comprehensive overview of system activities</small>
          </div>
        </div>
        <button type="button" class="close text-white bg-opacity-20 hover-bg-opacity-30 rounded-circle p-1 transition-all" data-dismiss="modal" aria-label="Close" style="width: 32px; height: 32px;">
          <span aria-hidden="true" style="font-size: 1.2rem; line-height: 1;">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <div class="row mb-3">
            <div class="col-md-6">
                <strong><i class="fas fa-calendar"></i> Log Date:</strong> 
                <span id="logDateDisplay_3" class="text-primary font-weight-bold"></span>
            </div>
           <div class="col-md-6 text-right">
  <div class="map-legend d-inline-flex align-items-center justify-content-end flex-wrap">
    <span class="legend-item mr-3 d-flex align-items-center">
     
    <span class="legend-item mr-3 d-flex align-items-center">
      <span class="legend-color" 
            style="background: #ffc107; width: 15px; height: 8px; display: inline-block; vertical-align: middle; border-radius: 2px;"></span>
      <small class="ml-1">🟨 Changed</small>
    </span>

    <span class="legend-item mr-3 d-flex align-items-center">
      <span class="legend-color" 
            style="background: #28a745; width: 15px; height: 8px; display: inline-block; vertical-align: middle; border-radius: 2px;"></span>
      <small class="ml-1">🟩 Added</small>
    </span>

    <span class="legend-item d-flex align-items-center">
      <span class="legend-color" 
            style="background: #dee2e6; width: 15px; height: 8px; display: inline-block; vertical-align: middle; border-radius: 2px;"></span>
      <small class="ml-1">⬜ Unchanged</small>
    </span>
  </div>
</div>
        </div>

        <div class="row mb-4">
          <div class="col-md-6">
            <div class="card h-100">
                <div class="card-header bg-primary text-white py-2">
                    <h6 class="mb-0"><i class="fas fa-database"></i> Original Data</h6>
                </div>
                <div class="card-body p-0">
                    <div id="UpdateTransactionoriginalData" style="max-height: 400px; overflow-y: auto;"></div>
                </div>
            </div>
          </div>
        
          <div class="col-md-6">
            <div class="card h-100">
                <div class="card-header bg-warning text-dark py-2">
                    <h6 class="mb-0"><i class="fas fa-edit"></i> Modifications Made</h6>
                </div>
                <div class="card-body p-0">
                    <div id="UpdateTransactionchangesRequested" style="max-height: 400px; overflow-y: auto;"></div>
                </div>
            </div>
          </div>
        </div>

      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" data-dismiss="modal">
            <i class="fas fa-times"></i> Close
        </button>
        
      </div>
    </div>
  </div>
</div>









<div class="modal fade" id="transactionDeleteModal" tabindex="-1" role="dialog" aria-labelledby="transactionDeleteeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
        <div class="modal-header bg-gradient-primary text-white d-flex justify-content-between align-items-center rounded-top-lg py-3">
        <div class="d-flex align-items-center">
          <div class="icon-container bg-white bg-opacity-20 rounded-circle p-2 mr-3">
            <i class="fas fa-chart-line fa-lg text-white"></i>
          </div>
          <div>
            <h5 class="modal-title font-weight-700 mb-0" id="t_audit_title_delete_transaction"></h5>
            <small class="text-white text-opacity-80">Comprehensive overview of system activities</small>
          </div>
        </div>
        <button type="button" class="close text-white bg-opacity-20 hover-bg-opacity-30 rounded-circle p-1 transition-all" data-dismiss="modal" aria-label="Close" style="width: 32px; height: 32px;">
          <span aria-hidden="true" style="font-size: 1.2rem; line-height: 1;">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <div class="row mb-3">
            <div class="col-md-6">
                <strong><i class="fas fa-calendar"></i> Log Date:</strong> 
                <span id="logDateDisplay_4" class="text-primary font-weight-bold"></span>
            </div>
           <div class="col-md-6 text-right">
</div>
        </div>

        <div class="row mb-4">
          <div class="col-md-12">
            <div class="card h-100">
                <div class="card-header bg-primary text-white py-2">
                    <h6 class="mb-0"><i class="fas fa-database"></i> Deleted Data</h6>
                </div>
                <div class="card-body p-0">
                    <div id="deleteTransactionoriginalData" style="max-height: 400px; overflow-y: auto;"></div>
                </div>
            </div>
          </div>
        
          
        </div>

      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" data-dismiss="modal">
            <i class="fas fa-times"></i> Close
        </button>
        
      </div>
    </div>
  </div>
</div>




<script>
  // Enable Bootstrap tooltips
  $(function () {
    $('[data-toggle="tooltip"]').tooltip();
  });
</script>


   

<jsp:include page="../includes/_footer.jsp"></jsp:include>

<script type="text/javascript" src="client_application/audit_report_dashboard.js"></script>
