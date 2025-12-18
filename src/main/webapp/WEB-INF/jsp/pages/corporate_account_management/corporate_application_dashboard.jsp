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





<style>
    /* Card Style */

    /* Chart Container */
    #pieChart {
      width: 400%;
      height: 250px;
    }
    #barChart {
    width: 1400%;
    height: 550px; /* Adjust the height as needed */
}


    body {
                margin-top: 20px;
        background: #FAFAFA;
    }
    
    .order-card {
        color: #fff;
    }
    
    .card {
    
        border-radius: 15px !important; /* Ensures rounded edges */
        overflow: hidden; /* Ensures child elements follow the border-radius */
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    
    
        
        /* border-radius: 15px; Increased for smoother rounded edges */
        /* border-radius: 5px; */
        -webkit-box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
        box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
        border: none;
        margin-bottom: 30px;
        -webkit-transition: all 0.3s ease-in
    }
    
    
    .card .card-block {
        padding: 25px;
    }
    
    /* Softer Gradients */
    
    .bg-c-blue {
        background: linear-gradient(135deg, #3a7bd5, #3a6073);
        color: white;
    }
    
    .bg-c-green {
        background: linear-gradient(135deg, #A8E063, #56AB2F); /* Lime green to deep leaf green */
        color: white;
    }
    
    .bg-c-yellow {
        background: linear-gradient(135deg, #ffb347, #ffcc33);
        color: white;
    }
    
    .bg-c-pink {
        background: linear-gradient(135deg, #4CAF50, #2E8B57); /* Lighter to deeper green */
        color: white;
    }
    
    /* Card Styling */
    .order-card {
        border-radius: 10px;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    }
    
    .card-block {
        padding: 20px;
    }
    
    /* Float helpers */
    .f-left {
        float: left;
    }
    
    .f-right {
        float: right;
    }
    .card:hover {
        transform: translateY(-10px); /* Moves the card slightly up */
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); /* Stronger shadow on hover */
    }
   
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .stat-card {
            transition: all 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .stat-title {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        .stat-value {
            font-weight: 600;
            margin: 5px 0;
        }
        .table thead th {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
            z-index: 10;
        }
    </style>
    

    

<!-- Begin Page Content -->
<div class="container-fluid">

    <h1 class="h3 mb-4 text-gray-800">Corporate Application Center Dashboard 
        
    </h1>
    <input type="hidden" id="bank_id">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#tab1" role="tab">Overview Per Individual Bank</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#tab2" role="tab">General Overview For All Banks</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#tab3" role="tab">Detailed Reporting</a>
            </li>
        </ul>
    
        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane active" id="tab1" role="tabpanel">


               <br>


               <h1 class="h3 mb-4 text-gray-800">


                <select id="sel_change_bank" class="form-control input-lg" style="width: 40%; max-width: 500px;">
    
                <!-- <select id="sel_change_bank" class=""> -->
                    <option value="info@">Select Bank</option>
                     <c:forEach items="${org_list}" var="org">
                       <option  value="${org.emailaddress}" data-fullname="${org.fullname}">${org.fullname}</option>
                       </c:forEach>
                 
                   </select>
                
                
                </h1>


                <input type="hidden" id="bank_id">
    


                <div class="row">
                    <!-- Application Received (Today) -->
                    <div class="col-xl-3 col-md-6 mb-4" id="recieved_apps_today" data-id="Today">
                        <div class="card border-left shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> Applications
                                            Received</div>
                                        <div class="text-xs  text-dark text-uppercase">today (
                                            <fmt:formatDate value="${now}" type="date" />)</div>
                                        <div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">0
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-file fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            
                    <!-- Application Received (Monthly) -->
                    <div class="col-xl-3 col-md-6 mb-4" id="recieved_apps_month" data-id="Month">
                        <div class="card border-left shadow h-100 py-2">
            
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Applications
                                            Received</div>
                                        <div class="text-xs  text-dark text-uppercase">this month (
                                            <fmt:formatDate value="${now}" pattern="MMMM" />)</div>
                                        <div id="app-received-month" class="h5 mb-0 font-weight-bold text-gray-800">0</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-file fa-2x text-gray-300"></i>
                                    </div>
                                    <!-- <a href="#" data-method="summary_created" data-period="month" data-url="Corporate_DashboardDivisionSummary" data-icon="fa-file" data-title="Applications Received" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
                                    </a> -->
                                </div>
                            </div>
            
                        </div>
                    </div>
            
                    <!-- Application Completed (Today) -->
                    <div class="col-xl-3 col-md-6 mb-4" id="completed_apps_today" data-id="Today" >
                        <div class="card border-left shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Applications Completed
                                        </div>
                                        <div class="text-xs  text-dark text-uppercase">today (
                                            <fmt:formatDate value="${now}" type="date" />)</div>
            
                                        <div class="row no-gutters align-items-center">
                                            <div class="col-auto">
                                                <div id="app-completed-today" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">0</div>
                                            </div>
            
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-clock fa-2x text-gray-300"></i>
                                    </div>
                                    <!-- <a href="#" data-method="summary_completed" data-period="day" data-url="Corporate_DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" class="showDivisionModal text-decoration-none stretched-link">
                                    </a> -->
                                </div>
                            </div>
                        </div>
                    </div>
            
                    <!-- Application Completed (Monthly) -->
                    <div class="col-xl-3 col-md-6 mb-4" id="completed_apps_month" data-id="Month">
                        <div class="card border-left shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Applications
                                            Completed</div>
                                        <div class="text-xs  text-dark text-uppercase">this month (
                                            <fmt:formatDate value="${now}" pattern="MMMM" />)</div>
                                        <div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">0</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-clock fa-2x text-gray-300"></i>
                                    </div>
                                    <!-- <a href="#" data-method="summary_completed" data-period="month" data-url="Corporate_DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
                                    </a> -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="row">
                    <!-- Application Received (Today) -->
                    <div class="col-xl-3 col-md-6 mb-4" id="lrd_applications" data-id="LRD">
                        <div class="card border-left shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> LRD APPLICATIONS
                                            </div>
                                        <!-- <div class="text-xs  text-dark text-uppercase">today (
                                            <fmt:formatDate value="${now}" type="date" />)</div> -->
                                        <div id="lrd-apps-rec" class="h5 mb-0 font-weight-bold text-gray-800">0
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-file fa-2x text-gray-300"></i>
                                    </div>
                                    <!-- <a href="#" data-method="summary_created" data-period="day" 
                                    data-url="DashboardDivisionSummary" data-icon="fa-file" 
                                    data-title="Applications Received" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" 
                                    class="showDivisionModal text-decoration-none stretched-link">
                                    </a> -->
                                </div>
                            </div>
                        </div>
                    </div>
            
                    <!-- Application Received (Monthly) -->
                    <div class="col-xl-3 col-md-6 mb-4" id="smd_applications" data-id="SMD">
                        <div class="card border-left shadow h-100 py-2">
            
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">SMD APPLICATIONS
                                            </div>
                                        <!-- <div class="text-xs  text-dark text-uppercase">this month (
                                            <fmt:formatDate value="${now}" pattern="MMMM" />)</div> -->
                                        <div id="smd-apps-rec" class="h5 mb-0 font-weight-bold text-gray-800">0</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-file fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
            
                        </div>
                    </div>
            
                    <!-- Application Completed (Today) -->
                    <div class="col-xl-3 col-md-6 mb-4" id="pvlmd_applications" data-id="PVLMD">
                        <div class="card border-left shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">PVLMD APPLICATIONS
                                        </div>
                                        <!-- <div class="text-xs  text-dark text-uppercase">today (
                                            <fmt:formatDate value="${now}" type="date" />)</div> -->
            
                                        <div class="row no-gutters align-items-center">
                                            <div class="col-auto">
                                                <div id="pvlmd-apps-rec" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">0</div>
                                            </div>
            
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-clock fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            
                    <!-- Application Completed (Monthly) -->
                    <div class="col-xl-3 col-md-6 mb-4" id="lvd_applications" data-id="LVD">
                        <div class="card border-left shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">LVD APPLICATIONS
                                            </div>
                                        <!-- <div class="text-xs  text-dark text-uppercase">this month (
                                            <fmt:formatDate value="${now}" pattern="MMMM" />)</div> -->
                                        <div id="lvd-apps-rec" class="h5 mb-0 font-weight-bold text-gray-800">0</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-clock fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="row">


                    <div id="app-received-year" class="col-lg-4 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black">Applications Received</h6>
                                <span class="small text-primary"><span class="count">0</span> Applications for
                                    <fmt:formatDate value="${now}" pattern="Y" /></span>
                            </div>
                            <div data-method="apps_created" data-period="year" data-url="Corporate_DashboardAppsRecieved" data-next-level-modal="showServiceTypeModal" data-title="Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
                        </div>
                        </div>
                   

                        <div id="app-received-completed-year" class="col-lg-4 mb-4">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-black">Applications Received and Completed in
                                        <fmt:formatDate value="${now}" pattern="Y" />
                                    </h6>
                                    <span class="small text-primary"><span class="count">0</span> Applications
                                        <!-- <fmt:formatDate value="${now}" pattern="Y" /> -->
                                    </span>
                                    <span class="small text-primary float-right" id="pec_id">0%</span>
                                </div>
                                <div data-method="apps_received_completed" data-period="year" data-url="Corporate_DashboardAppsRecieved" data-next-level-modal="showServiceTypeModal" data-title="Received and Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
                            </div>
                            </div>



                            <div id="app-completed-year" class="col-lg-4 mb-4">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-black">Applications Completed</h6>
                                        <span class="small text-primary"><span class="count">0</span> Applications for
                                            <fmt:formatDate value="${now}" pattern="Y" /></span>
                                    </div>
                                    <div data-method="apps_completed" data-period="year" data-url="Corporate_DashboardAppsRecieved" data-next-level-modal="showServiceTypeModal" data-title="Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
                                </div>
                            </div>
  

                </div>



                <ol class="breadcrumb">
                    <li class="breadcrumb-item text-uppercase text-gray-800">Reporting By Dates</li>
                    <!-- <li class="breadcrumb-item active">${unit_name}</li> -->
                </ol>
              <!-- Signout Monitoring -->
            
              <div class="row">
                  <!-- Application Received (Today) -->
                  <div class="col-xl-4 col-md-6 mb-2" id="apps_recieved_within_dates">
                      <div class="card border-left shadow h-100 py-2">
                          <div class="card-body">
                              <div class="row no-gutters align-items-center">
                                  <div class="col mr-2">
                                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> Applications
                                           Received</div>
                                      <div class="text-xs  text-dark text-uppercase"> By Dates</div>
                                      <!-- <div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">${signedout_today}
                                      </div> -->
                                  </div>
                                  <div class="col-auto">
                                      <i class="fas fa-file fa-2x text-gray-300"></i>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>
            
            
                  <div class="col-xl-4 col-md-6 mb-2" id="apps_recieved_completed_within_dates">
                    <div class="card border-left shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-warning text-uppercase mb-1"> Applications
                                         Recieved and Completed</div>
                                    <div class="text-xs  text-dark text-uppercase"> By Dates</div>
                                    <!-- <div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">${signedout_today}
                                    </div> -->
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-file fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            
            
            
                <div class="col-xl-4 col-md-6 mb-2" id="apps_completed_within_dates">
                    <div class="card border-left shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-info text-uppercase mb-1"> Applications
                                         Completed</div>
                                    <div class="text-xs  text-dark text-uppercase"> By Dates</div>
                                    <!-- <div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">${signedout_today}
                                    </div> -->
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-file fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            
              
                  <!-- Application Completed (Today) -->
              </div>
            

                
                
            
                
                
            </div>
            <div class="tab-pane" id="tab2" role="tabpanel">


                <br>


               
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
                


                <br>

                 <input type="hidden" id="bank_id">

                 
                 <input type="hidden" id="start_date">
                 <input type="hidden" id="startdate">
                 <input type="hidden" id="end_date">
                 <input type="hidden" id="enddate">
 
 
                 <div class="row">
                     <!-- Application Received (Today) -->
                     <div class="col-xl-3 col-md-6 mb-4" id="recieved_apps" data-id="Today">
                         <div class="card border-left shadow h-100 py-2">
                             <div class="card-body">
                                 <div class="row no-gutters align-items-center">
                                     <div class="col mr-2">
                                         <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> Applications
                                             Received</div>
                                         <div id="app-received" class="h5 mb-0 font-weight-bold text-gray-800">0
                                         </div>
                                     </div>
                                     <div class="col-auto">
                                         <i class="fas fa-file fa-2x text-gray-300"></i>
                                     </div>
                                     <!-- <a href="#" data-method="summary_created" data-period="day" 
                                     data-url="Corporate_DashboardDivisionSummary" data-icon="fa-file" 
                                     data-title="Applications Received" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" 
                                     class="showDivisionModal text-decoration-none stretched-link">
                                     </a> -->
                                 </div>
                             </div>
                         </div>
                     </div>
             
                     <!-- Application Received (Monthly) -->
                     <div class="col-xl-3 col-md-6 mb-4" id="completed_apps" data-id="Month">
                         <div class="card border-left shadow h-100 py-2">
             
                             <div class="card-body">
                                 <div class="row no-gutters align-items-center">
                                     <div class="col mr-2">
                                         <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Applications
                                             Completed</div>
                                         <div id="app-completed" class="h5 mb-0 font-weight-bold text-gray-800">0</div>
                                     </div>
                                     <div class="col-auto">
                                         <i class="fas fa-file fa-2x text-gray-300"></i>
                                     </div>
                                     <!-- <a href="#" data-method="summary_created" data-period="month" data-url="Corporate_DashboardDivisionSummary" data-icon="fa-file" data-title="Applications Received" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
                                     </a> -->
                                 </div>
                             </div>
             
                         </div>
                     </div>
             
                     <!-- Application Completed (Today) -->
                     <div class="col-xl-3 col-md-6 mb-4" id="pending_apps" data-id="Today" >
                         <div class="card border-left shadow h-100 py-2">
                             <div class="card-body">
                                 <div class="row no-gutters align-items-center">
                                     <div class="col mr-2">
                                         <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Applications Pending
                                         </div>
             
                                         <div class="row no-gutters align-items-center">
                                             <div class="col-auto">
                                                 <div id="app-pending" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">0</div>
                                             </div>
             
                                         </div>
                                     </div>
                                     <div class="col-auto">
                                         <i class="fas fa-clock fa-2x text-gray-300"></i>
                                     </div>
                                     <!-- <a href="#" data-method="summary_completed" data-period="day" data-url="Corporate_DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" class="showDivisionModal text-decoration-none stretched-link">
                                     </a> -->
                                 </div>
                             </div>
                         </div>
                     </div>
             
                     <!-- Application Completed (Monthly) -->
                     <div class="col-xl-3 col-md-6 mb-4" id="queried_apps" data-id="Month">
                         <div class="card border-left shadow h-100 py-2">
                             <div class="card-body">
                                 <div class="row no-gutters align-items-center">
                                     <div class="col mr-2">
                                         <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Applications
                                             Queried</div>
                                         <div id="app-queried" class="h5 mb-0 font-weight-bold text-gray-800">0</div>
                                     </div>
                                     <div class="col-auto">
                                         <i class="fas fa-clock fa-2x text-gray-300"></i>
                                     </div>
                                     <!-- <a href="#" data-method="summary_completed" data-period="month" data-url="Corporate_DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
                                     </a> -->
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>

                  <div class="row">
                     <!-- Application Received (Today) -->
                     <div class="col-xl-4 col-md-6 mb-4" id="recieved_apps_today" data-id="Today">
                        <div class="card border shadow h-100 py-2">
                            <!-- Card Header -->
                            <div class="card-header">
                                <h5 class="m-0 text-dark">Top 5 Banks With Highest Submissions</h5>
                            </div>
                            <!-- Card Body -->
                            <div class="card-body">
                                                              <div id="pieChart"></div>

                            </div>
                        </div>
                    </div>
                    
             
                     <!-- Application Received (Monthly) -->
                     <div class="col-xl-8 col-md-6 mb-4" id="recieved_apps_today" data-id="Today">
                        <div class="card border shadow h-100 py-2">
                            <!-- Card Header -->
                            <div class="card-header">

                                <h5 class="m-0 text-dark">Application Submissions Top 5 Banks</h5>
                            </div>
                            <!-- Card Body -->
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover" id="recent_submissions" width="100%" cellspacing="0">
                                        <!-- <table id="bills_paid_and_acknlowledged_Table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                                           <thead>
                                                <th>Bank Name</th>
                                                <th>Count</th>
                                                <th>Action</th>
                                          </thead>
                                              <tbody>        
                                              </tbody>
                                        </table>
                                </div> 

                            </div>
                        </div>
                    </div>
                    
                 </div>
 
                 <div class="row">
                    <!-- Application Received (Today) -->
                   
                    <!-- Application Received (Monthly) -->
                    <div class="col-xl-12 col-md-6 mb-4" id="recieved_apps_today" data-id="Today">
                        <div class="card border shadow h-100 py-2">
                            <!-- Card Header -->
                            <div class="card-header">
                                <h5 class="m-0 text-dark">Application Status Overview by Banks</h5>
                            </div>
                            <!-- Card Body -->
                            <div class="card-body">
                                <div class="pagination">
                                    <!-- <button id="prevPage" onclick="changePage(-1)">Previous</button> &nbsp; &nbsp;
                                    <button id="nextPage" onclick="changePage(1)">Next</button>-->
                                    <span>Slide: <span id="pageNum">1</span></span> 
                                </div>
                                
                                <!-- Chart container -->                            
                                <div id="barChart"></div>
                            </div>
                            
                            <!-- Card Footer with Button Controls -->
                            <div class="card-footer d-flex justify-content-between">
                                <!-- Left Side: Previous, Next buttons -->
                                <div class="d-flex">
                                    <button id="prevPage" onclick="changePage(-1)" class="btn btn-primary"><i class="fa fa-arrow-left"></i></button>&nbsp; &nbsp;
                                    <button id="nextPage" onclick="changePage(1)" class="btn btn-primary"><i class="fa fa-arrow-right"></i></button>
                                </div>
                                
                                <!-- Right Side: Start, Stop Auto Scroll buttons -->
                                <div class="d-flex">
                                    <button id="startAutoScroll" onclick="startAutoScroll()" class="btn btn-danger rounded-circle"><i class="fas fa-play"></i></button>&nbsp; &nbsp;
                                    <button id="stopAutoScroll" onclick="stopAutoScroll()" class="btn btn-primary rounded-pill" disabled><i class="fas fa-pause"></i></i></button>
                                </div>
                            </div>

                            <!-- <div id="paginationControls"></div> -->
                            <div id="paginationControls" class="d-flex justify-content-between w-100"></div>

                        </div>
                    </div>
                    
                </div>
                             </div>









                             <div class="tab-pane" id="tab3" role="tabpanel">


                                <br>
                
                
                               
                                <div class="col-lg-6">

                                    <div class="card mb-3">
           
                                        <div class="card-header">
                                             <h4 class='float-left'>
                                             <i class="fas fa-database"></i>CORPORATE APPLICATIONS REPORT</h4>
                                             
                                     </div>


                                    

                                    <div class="card-body">

                                <div class="card">
			    
			
                                    <div id="collapsedrinksn" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                                      <div class="card-body">
                                        
                            
                                        <!-- <input type="text" value="${region_id}" id="region_id"> -->
                    
                    
                                        <input type="hidden" value="${userid}" id="user_id" >
                                        <input type="hidden" value="${unit_id}" id="user_unit" >
                                        <input type="hidden" value="${division}" id="user_division">
                                        <input type="hidden" value="${unit_name}" id="unit_name">
                                        <input type="hidden" value="${region_id}" id="region_id">
                                        <input type="hidden" id = "select-user">
                    
                    
                    
                                        <input type="hidden" id = "startdate">
                                        <input type="hidden" id = "enddate">
                    
                    
                                        
                    
                    



                                        <input type="hidden" id = "getRegioname">
                                        <input type="hidden" id="sub_service_name_input" class="form-control" readonly>
                                       
                                     
                    
                    
                                        
                                        
                    
                    
                                        <!-- System.out.println(userid);
                                        System.out.println(unit_id);
                                        System.out.println(division); -->
                    
                                        
                    
                    
                                                   
                            <div class="form-group">
                              <label for="type_of_report_name">Status Type</label>
                              <select name="status_type"  id="status_type" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                                <option value="All" selected>All</option>
                                <option value="Completed">Completed</option>
                                <option value="Received and Completed">Received and Completed</option>
                                 <option value="Pending">Pending</option>
                                 <option value="KEEP IN VIEW">Keep In View</option>
                                 <!-- <option value="lrd_plotting_report">LRD Plotting Report</option> -->
                                <!-- <option value="TAT">TAT</option> -->
                             </select>
                             </div>
                    
                    
                    
                    

                             <input type="hidden" value="${region_id}" id="ur_district">
                
                               <div class="form-group">                         
                                <label for="region">Select Region</label>
                                <select id="selchangeregioncompliance" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                                  <!-- <option selected disabled value="-1">-- select --</option>					 -->
                                  <option selected value="0">All Regions</option>						
                                  <c:forEach items="${officeregionlist}" var="officeregion">
                                    <option  value="${officeregion.ord_region_code}" data-name="${officeregion.ord_region_name}">${officeregion.ord_region_name}</option>
                                </c:forEach>
                                    </select>

                               </div>
                    

                               <input type="hidden" id="bankNAme">
                    
            
                    
                               <div class="form-group">
                                <label for="region">Banks</label><br>
                                <select id="selchangebank" class="form-control selectpicker" multiple="multiple" style="width: 100%; max-width: 500px;">
                                    <option value="info@" disabled>Select Bank</option>
                                    <option value="All" >All Banks</option>
                                    <c:forEach items="${org_list}" var="org">
                                        <option value="${org.emailaddress}" data-bankname="${org.fullname}"  data-fullname="${org.fullname}">
                                            ${org.fullname}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                      
                    
                    
                               <div class="form-group">
                                <label for="main_service">Main Service</label>
                                        <select name="main_service_rpt" id="main_service_rpt"   class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                                        <option selected value="-1">Select Main Service</option>
                                        <option  value="0">ALL SERVICES</option>						
                                       <c:forEach items="${main_services}" var="main_service">
                                         
                                        
                                        <%--  <c:if test="${(${main_service.business_process_id} == 'No')}" --%>
                                               <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option>  
                                          <%-- <p>Welcome, <c:out value="${nm }"/></p> --%>
                                        <%--  </c:if> --%>
                                        
                                          
                                         </c:forEach> 
                                       
                                      </select>
                                </div>
                                 <div class="form-group" id="subServ">
                                <label for="sub_service">Sub Service</label>
                                        <select name="sub_service_rpt" id="sub_service_rpt" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                                          <option value="-1">Select Sub Service</option>
                                        
                                      </select>
                                 </div>

                    
                    
                    
                    
                    
                                  <div class="form-group">
                                      <label for="region">Select Date From</label>
                                      <input type="text" id="datefrom" class="form-control"  placeholder="Select Date Range" required>
                                  </div>
                    
                    
                    
                                  <div class="form-group">
                                    <label for="region">Select Date To</label>
                                    <input type="text" id="dateto" class="form-control"  placeholder="Select Date Range" required>
                                  </div>
                    
                    
                    
                    <input type="hidden" id="start_date" name="start_date">
                    <input type="hidden" id="end_date" name="end_date">
                    
                    <input type="hidden" id="survey_select" name="survey_select">
                    
                    <hr><br>
                    
                    <button type="button" class="d-none d-sm-inline-block btn btn-md btn-info shadow-sm" 
                    id="btn_generate_details_reports_new" data-placement="top" data-toggle="tooltip" title="Generate">
                    <i class="fas fa-chart-line fa-sm text-white-50"></i>Generate Report</button>
                    
                               
                                <!-- <div class="form-group">
                           <label >Date</label>
                           <input type="text" class="form-control input-sm"  id="daterange" />      
                                
                        </div> -->
                                
                    
                                
                                     
                                      </div>
                                    </div>
                                  </div>

                                  </div>
                
                                </div>
                              
                
                                 
                 
                                </div>
                 
                                
                                             </div>






                             </div>
  
                 </div>
        </div>

</div>





<jsp:include page="../includes/_footer.jsp"></jsp:include>
<jsp:include page="../includes/_corporate_modals.jsp"></jsp:include>	

<!-- For capturing HTML as images -->
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>

<!-- For creating zip files -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.7.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>


<script>
    $(document).ready(function () {
        $('#selchangebank').select2({
            placeholder: "Select Bank(s)",
            width: '100%',
            theme: 'bootstrap4' // or 'bootstrap5' depending on your version
        });

        const selectedOption = $('#selchangeregioncompliance').find(':selected');

// Retrieve the data-name attribute of the selected option
const surveyorName = selectedOption.data('name') || 'All Regions';

// Set the surveyorName value in the #survey_select input
$('#getRegioname').val(surveyorName);




                               

                               


const selectedOptionbnks = $('#selchangebank').find(':selected');

// Retrieve the data-name attribute of the selected option
const institutionNAme = selectedOptionbnks.data('bankname') || 'All Banks';

// Set the surveyorName value in the #survey_select input
$('#bankNAme').val(institutionNAme);


        

        
    });
</script>

<link rel="stylesheet" href="https://cdn.datatables.net/rowgroup/1.3.1/css/rowGroup.dataTables.min.css"/>
<script src="https://cdn.datatables.net/rowgroup/1.3.1/js/dataTables.rowGroup.min.js"></script>



<script type="text/javascript" src="../js_includes/corporate_application.js"></script>

<script src='js/echarts/echarts.min.js'></script> 

<script>

$('#main_service_rpt')
							.change(
									function() {
										// alert($(this).val());
										var select_id = document
												.getElementById("main_service_rpt");
										var main_service = select_id.options[select_id.selectedIndex].value;

										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										// console.log(main_service_name);

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_sub_service_all',
													},
													cache : false,
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt=""
														// width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {

														// console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#sub_service_rpt");

														// var options =
														// $("#selector");
														options.empty();
														options
																.append(new Option(
																		"-- Select --",
																		0));

														$(json_p)
																.each(
																		function() {

																			// console.log(select_id);
																			// console.log(this.business_process_id);

																			if (main_service_id == this.business_process_id) {
																				$(
																						'#sub_service_rpt')
																						.append(
																								'<option value="'
																										+ this.business_process_sub_id
																										+ '-'
																										+ this.business_process_sub_name
																										+ '">'
																										+ this.business_process_sub_name
																										+ '</option>');


                                                                                                        // $('#sub_service_name_input').val(this.business_process_sub_name); 


																			}

																		});
														
													}
												});

										
									});



                                    $('#sub_service_rpt').on('change', function () {
    var selectedValue = $(this).val(); // e.g., "23-Environmental Compliance"

    if (selectedValue && selectedValue.includes('-')) {
        var subServiceName = selectedValue.split('-')[1]; // Get the name
        $('#sub_service_name_input').val(subServiceName); // Set it in the input
    } else {
        $('#sub_service_name_input').val('');
    }
});



</script>
<!-- <script src="https://cdn.jsdelivr.net/npm/echarts@5.3.3/dist/echarts.min.js"></script> -->

<script type="text/javascript" src="../js_includes/corporate_applications_two.js"></script>



<script>

  </script>