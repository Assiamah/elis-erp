<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
       <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="d" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.*" %>
<jsp:include page="../legal/includes/header.jsp"></jsp:include>
<!-- Begin Page Content -->
   <div class="container-fluid">
	<section class="section dashboard">
	
			 <!-- Page Heading -->
                <div class="row mb-4">
                	 <div class="col-md-12">
		                <div class=" ">
		                   
					         <nav>
				                <ol class="breadcrumb">
				                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
				                  <li class="breadcrumb-item active">Head Legal</li>
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div>
	
	
     	<div class="row mb-4">
      		<!-- Left side columns -->
        <div class="col-lg-12">
          <div class="row">
          <div class="col-xl-3 col-md-6" id="incoming">
              <div class="card border-left-primary shadow h-100 py-2" id="body-bg-1">

                <div class="card-body">
	                  		<h5 class="card-title">Cases <span>| Secretariat</span></h5>
							
							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<i class="fa fa-tasks fa-2x text-primary"></i>
								</div>
								 <div class="">	
		                     	 	<h4 id="incoming_count"><c:out value="${incoming}"></c:out></h4>
								 </div>
		                    </div>
                </div>

              </div>
            </div>

            <!-- Unit Cases Card -->
            <div class="col-xl-3 col-md-6" id="unit_cases">
              <div class="card border-left-success shadow h-100 py-2" id="body-bg-2">

                <div class="card-body">
	                  		<h5 class="card-title">Cases <span>| Unit</span></h5>
					
							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<i class="fas fa-list fa-2x text-success"></i>
								</div>
								 <div class="">	
		                     	 	<h4 id="unit_count"><c:out value="${unit_count}"></c:out></h4>
								 </div>
		                    </div>
                </div>

              </div>
            </div><!-- Assigned Cases Card -->

            <!-- Unit Cases Card -->
            <div class="col-xl-3 col-md-6" id="assigned_cases">
              <div class="card border-left-info shadow h-100 py-2" id="body-bg-3">

               <div class="card-body">
                  <h5 class="card-title">Cases <span>| Assigned</span></h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="fas fa-calendar fa-2x text-info"></i>
                    </div>
                    <div class="">
                      <h4 id="assigned_count"><c:out value="${assigned_count}"></c:out></h4>

                    </div>
                  </div>
                </div>

              </div>
            </div><!-- Unit Cases Card -->

            <!-- Archived Cases Card -->
            <div class="col-xl-3 col-md-6" id="pending">
			 
              <div class="card border-left-warning shadow h-100 py-2" id="body-bg-4">

                <div class="card-body">
                    <h5 class="card-title">Cases <span>| Pending Action</span></h5>

                <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="fas fa-calendar fa-2x text-warning"></i>
                    </div>
                    <div class="ps-3">
                      <h4 id="total_count"><c:out value="${pending_count}"></c:out></h4>

                    </div>
                  </div>

                </div>
              </div>
			 
            </div><!-- Archived Cases Card -->
            
            
             <!-- Archived Cases Card -->
            <div class="col-xl-3 col-md-6 mt-4" id="archive_cases">
			 
              <div class="card border-left-danger shadow h-100 py-2" id="body-bg-5">

                <div class="card-body">
                    <h5 class="card-title">Cases <span>| Dormant Cases</span></h5>

                <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="fas fa-archive fa-2x text-danger"></i>
                    </div>
                    <div class="ps-3">
                      <h4 id="total_count"><c:out value="${archive_count}"></c:out></h4>

                    </div>
                  </div>

                </div>
              </div>
			 
            </div><!-- Archived Cases Card -->
     	
     
     </div>
    </div>
  </div>
  
  <div class="row mb-4" id="archived_search">
		 		<div class="col-md-9">
								 	
							    
								    <%-- <div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="client_name" required>
									  <label class="custom-control-label" for="rbtn_search_type1">Name</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type2" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="ticket_id" required>
									  <label class="custom-control-label" for="rbtn_search_type2">Ticket No.</label>
									</div>
									<br><br> --%>
						          <div class="form-group">
						            <div class="form-row mb-4">
						              <div class="col-md-5">
						                
						                <input class="form-control" id="search_case_value"  type="text" aria-describedby="" placeholder="Enter suit number" required >
						              </div>
						              <div class="col-md-3">
						              	
						                <button type="button" class="btn btn-warning" value="Search" id="btnCCJobSearch" ><i class="fas fa-search"></i> Search </button>
						                
						              </div>
						            </div>
						            </div>
						            
						            </div>
		 </div>	
	
	
	<div class="row">
	<h6>Table Background Indicators</h6>
		<span class="mb-2 small"><i class="fas fa-dot-circle text-white" style="border: 1px solid black; border-radius: 50%"></i>Case without both further entries and uploaded document.</span>
		<span class="mb-2 small"><i class="fas fa-dot-circle text-danger"></i>Case with only uploaded document.</span>
		<span class="mb-2 small"><i class="fas fa-dot-circle text-warning"></i>Case with only further entries.</span>
		<span class="mb-2 small"><i class="fas fa-dot-circle text-success"></i>Case with both further entries and uploaded document.</span>
	</div>
	
	      <div class="row">
	            <div class="col-md-12">
	              <div class="card">
	              	<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i>Process Details <span
						class="col-md-3 float-right ">
						<button class="btn btn-success btn-icon-split float-right"
							id="btnViewUpcomingCases" disabled>
							<span class="icon text-white-50"> <i class="fas fa-calendar"></i></span><span
								class="text">View Calendar</span>
						</button>
						<!-- <button class="btn btn-success btn-icon-split float-right "
							id="btnViewStatistics" disabled>
							<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span
								class="text">View Statistics</span>
						</button> -->
					</span>
					</div>
	                <div class="card-body">
	                	  <h5 class="card-title">Cases | <span id="card_title"></span></h5>
	                  <div class="tab-content">
					            <div id="" class="table-responsive">
					                <table class="table " id="table_list"  width="100%" cellspacing="0" >
	              						<thead>
										    <tr>
										        <th>#</th>
										        <th>Suit Number</th>
										        <th>Nature of Case</th>
										        <th>Court Process</th>
										        <th>Court</th>
										        <th>Court Region</th>
										        <th>Plaintiff(s)</th>
										        <th>Defendant(s)</th>
										        <th>Date of Filing</th>
										        <th>Date Received</th>
										        <th>Assigned To</th>
										        <th>Reminder</th>
												<th>Actions</th>
										    </tr>
										  </thead>
										  <tbody id="table_body">
										    
										  </tbody>
		                   	        </table>
					            </div>
					    </div>
	                </div>
	              </div>
	            </div>
	          </div>

     </section>

	</div>
<!-- End Page Content -->

 <!-- Pending Modal-->
   <div class="modal fade" id="pendingModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Pending | Cases</h5>
           
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>

          </div>
          <div class="modal-body">
	            <div class="row">
	                   <div id="" class="table-responsive">
		                  <table class="table" id="pending_list">
		                  
		                  </table>
	                  </div>
	            </div>

          	</div>
          	<div class="modal-footer">
            	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          	</div>
        </div>
      </div>
    </div>
<!-- Pending Modal-->
<!-- Assign Modal -->
  <div class="modal fade" id="assignCaseModal" tabindex="-1" data-focus-on="input:first">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Assign Cases</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="assign_one" method="post">
        <div class="modal-body">
         <input type="text" name="suit_number" id="suit_number" hidden>
         <input type="text" name="case_id" id="case_id" hidden>
          <div class="row mb-3">
            <label for="inputNumber" class="col-sm-4 col-form-label">Select Legal Officer:</label>
            <div class="col-sm-8">
               <input class="form-control" id="user_to_send_to"  name="user_to_send_to" type="text" autocomplete="off" 
		                                 list="listofusersbatching" class="autocomplat"  placeholder="Enter Username" required  onmousedown="value = '';" >
		        <datalist id="listofusersbatching"></datalist>
            </div>
            <label for="inputNumber" class="col-sm-4 col-form-label">Remarks:</label>
            <div class="col-sm-8">
               <textarea class="form-control" id="assigned_reasons" required=""></textarea>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Assign</button>
        </div>
        </form>
      </div>
    </div>
  </div>
  <!-- Assign -->
  
  
  <!-- Assign Modal -->
  <div class="modal fade" id="archiveCaseModal" tabindex="-1" data-focus-on="input:first">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Archive Case</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="archive_one" method="post">
        <div class="modal-body">
         <input type="text" name="suit_number" id="a_suit_number" hidden>
         <input type="text" name="case_id" id="a_case_id" hidden>
          <div class="row mb-3">
            <label for="inputNumber" class="col-sm-4 col-form-label">Reasons:</label>
            <div class="col-sm-8">
               <textarea class="form-control" id="archive_reasons" required=""></textarea>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Confirm</button>
        </div>
        </form>
      </div>
    </div>
  </div>
  <!-- Assign -->
  
  
    <!-- Assign Modal -->
  <div class="modal fade" id="restoreCaseModal" tabindex="-1" data-focus-on="input:first">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Restore Case</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="restore_one" method="post">
        <div class="modal-body">
         <input type="text" name="suit_number" id="a_suit_number" hidden>
         <input type="text" name="case_id" id="a_case_id" hidden>
          <div class="row mb-3">
            <label for="inputNumber" class="col-sm-12 col-form-label">Are you sure to restore the case?</label>
           <%--  <div class="col-sm-8">
               <textarea class="form-control" id="archive_reasons" required=""></textarea>
            </div> --%>
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-success">Yes</button>
          <button  type="button" data-dismiss="modal" aria-label="Close"  class="btn btn-danger">No</button>
        </div>
        </form>
      </div>
    </div>
  </div>
  <!-- Assign -->
  
  
  
  <!-- Assigned Modal-->
			<div class="modal fade" id="assignedCasesModal" tabindex="-1">
                <div class="modal-dialog modal-lg">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">Cases | Assigned</h5>
                      <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      	<div class="row">
                      		   <div id="" class="table-responsive">
			                      	<table class="table" id="assigned_table">
						                    <thead>
						                      <tr>
						                        <th scope="col">Officer Name</th>
						                         <th scope="col">Count</th>
						                         <th scope="col">Actions</th>
						                      </tr>
						                    </thead>
						                    <tbody>
						                    
						                    </tbody>
						             </table>
                      			</div>
                      	</div>
                      	<div class="row">
                      		<div class="col-lg-12">
						          <div class="card">
						            <div class="card-body">
						              <h5 class="card-title">Donut Chart</h5>
						
						              <!-- Donut Chart -->
						              <div id="donutChart"></div>
						
						             <!--  <script>
						                document.addEventListener("DOMContentLoaded", () => {
						                  new ApexCharts(document.querySelector("#donutChart"), {
						                    series: [44, 55, 13, 43, 22],
						                    chart: {
						                      height: 350,
						                      type: 'donut',
						                      toolbar: {
						                        show: true
						                      }
						                    },
						                    labels: ['Team A', 'Team B', 'Team C', 'Team D', 'Team E'],
						                  }).render();
						                });
						              </script> -->
						              <!-- End Donut Chart -->
						
						            </div>
						          </div>
						        </div>
				        </div>
                      	
                      	</div>
 
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
<!-- Assigned Modal-->
 <!-- Assigned user Modal-->
			<div class="modal fade" id="assignedCasesUserModal" tabindex="-1">
                <div class="modal-dialog modal-lg">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">Cases | Assigned</h5>
                      <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      	<div class="row">
                      		   <div id="" class="table-responsive">
			                      	<table class="table" id="assigned_user_table">
						                    <thead>
						                      <tr>
						                        <th>#</th>
										        <th>Suit Number</th>
										        <th>Nature of Case</th>
										        <th>Court</th>
										        <th>Court Region</th>
										        <th>Plaintiff(s)</th>
										        <th>Defendant(s)</th>
										        <th>Date of Document</th>
										        <th>Date Received</th>
										        <th>Received By / Assigned To</th>
												<th>Actions</th>
						                      </tr>
						                    </thead>
						                    <tbody>
						                    
						                    </tbody>
						             </table>
                      			</div>
                      	</div>
                      	
                      	
                      	</div>
 
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
<!-- Assigned user Modal-->


 <!-- Assigned user Modal-->
			<div class="modal fade" id="upcomingcasesModal" tabindex="-1">
                <div class="modal-dialog modal-xl">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">Upcoming Cases</h5>
                      <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      	<%-- <div class="row">
                      		<div class="col-"> --%>
                      			<div id="calendar" class="full-calendar"></div>
                      		<%-- </div>
                      		<div class="col-3 nav-stacked timeline-scroll">
                      			<div class="card">
          
					            <div class="card-body">
					              <h5 class="card-title">Upcoming <span>| Timeline </span></h5>
									<ul class="timeline-3" id="upcoming">
								       
								       
								      </ul>
					            </div>
					          </div><!-- End Recent Activity -->
					
					         <!-- Recent Activity -->
					          <div class="card mt-4">
					            <div class="filter">
					              <a class="icon" href="#" ><i class="bi bi-three-dots"></i></a>
					            </div>
					
					            <div class="card-body">
					              <h5 class="card-title">Past <span>| Timeline</span></h5>
									<ul class="timeline-3" id="past">
								       
								      </ul>
					           
					
					            </div>
					          </div>
                      		</div>
                      	</div>--%>
                    </div> 
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                    </div>
                  </div>
                </div>
<!-- Assigned user Modal-->


<div class="modal fade" id="eventDetails" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Case Details</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form  action="case_details_post" method="post">
        
        <div class="modal-body" style="font-size: small;">
         <input class="form-control" type="text" id="case_id" name="case_id" hidden="" required>
          <div class="row mb-3">
			<label for="inputNumber">Suit Number:</label>
			<div class="col-sm-12">
              <input class="form-control" type="text" id="suit_number" name="suit_number" readonly required>
            </div>
		  </div>
		  	
		  <div class="row mb-3">
		  <label for="inputNumber" class="col-sm-4 col-form-label">Start Date</label>
			<div class="col-sm-12">
              <input class="form-control" type="text" id="start_date">
            </div>
		  </div>
		  
		  <div class="row mb-3">
		  <label for="inputNumber" class="col-sm-4 col-form-label">End Date</label>
			<div class="col-sm-12">
              <input class="form-control" type="text" id="end_date">
            </div>
		  </div>
		 
		   <div class="row mb-3">
		    <label for="inputNumber" class="col-sm-4 col-form-label">Description</label>
            <div class="col-sm-12">
              <textarea class="form-control" id="description"></textarea>
            </div>
          </div>
          <input type="hidden"  name="request_type" value="case_details">
			<%-- <input type="text" name="created_by" id="created_by" value="${sessionScope.userid}" hidden> --%>
        </div>
        <div class="modal-footer">
          <button type="submit" id="save_note" class="btn btn-primary">View Case</button>
        </div>
       </form>
      </div>
    </div>
  </div>
<jsp:include page="../legal/includes/footer.jsp"></jsp:include>
<script src="legal/includes/apexcharts/apexcharts.min.js"></script>
<script type="text/javascript" src="legal/includes/pages_script/head_legal.js"></script> 