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



<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-4 text-gray-800">Compliance Unit Request Monitoring Dashboard</h1>


    <input type="hidden" id="user_unit_id" value="" />



     <!-- <select id="sel_change_bank" class="">
            <option value="null">-- select --</option>
                           
             <c:forEach items="${org_list}" var="org">
               <option  value="${org.emailaddress}" data-fullname="${org.fullname}">${org.fullname}</option>
               </c:forEach>
         
           </select> -->




           <div class="row">
            <div class="col-sm-4">
              <div class="card">
                <div class="card-body">
                    <label for="">Office Region</label> 
                    <select id="ur_district" class="form-control selectpicker"  required>
                        <!-- <option value="10">Tema</option>
                        <option value="11">Accra</option>
                        <option value="Amasaman">Amasaman</option> -->
                        <option value>Select</option> 
                        
                        
                        
                        

                    </select>
                </div>
              </div>
            </div>
            <div class="col-sm-4">
              <div class="card">
                <div class="card-body">
                    <label for="">Division</label> 
                    <select id="ur_division" class="form-control selectpicker">
                        <!-- <option value=none>Select</option> -->
                        <!-- <option value="LRD">LRD</option>
                        <option value="PVLMD">PVLMD</option>
                        <option value="LVD">LVD</option>
                        <option value="SMD">SMD</option>
                        <option value="RLO">RLO</option>
                        <option value="CORPORATE">CORPORATE</option> -->
                        
                        <!-- <option value="CSAU">CSAU</option> -->
                    </select>
                </div>
              </div>
            </div>

            <div class="col-sm-4">
                <div class="card">
                  <div class="card-body">
                    <label for="">Unit</label> 
                    <select id="ur_units" class="form-control selectpicker">
                        <!-- <option value=none>Select</option> -->
                      
                    </select>
                  </div>
                </div>
              </div>

          </div>


    <ol class="breadcrumb">
		<!-- <li class="breadcrumb-item text-uppercase text-gray-800">Tellers</li> -->
		<!-- <li class="breadcrumb-item active">${unit_name}</li> -->
	</ol>

	<!-- <input type="hidden" id="csau_manager_regional_code" value="${regional_code}" /> -->

	<div class="row">
		<!-- Application Received (Today) -->
		<div class="col-xl-3 col-md-6 mb-4" id="incoming_apps">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> Applications
								Incoming</div>
							<!-- <div class="text-xs  text-dark text-uppercase">today (
								<fmt:formatDate value="${now}" type="date" />)</div> -->
							<div id="incoming_count" class="h5 mb-0 font-weight-bold text-gray-800">
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>

		</div>

		
		<!-- Application Completed (Today) -->
		<div class="col-xl-3 col-md-6 mb-4" id="apps_with_officers" data-inbox="2">
			<div class="card border-left-info shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-info text-uppercase mb-1">Applications With Officers
							</div>
							<!-- <div class="text-xs  text-dark text-uppercase">this WEEK</div> -->

							<div class="row no-gutters align-items-center">
								<div class="col-auto">
									<div id="officers_count" class="h5 mb-0 mr-3 font-weight-bold text-gray-800"></div>
								</div>

							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clock fa-2x text-gray-300"></i>
						</div>
						</a>
					</div>
				</div>
			</div>
		</div>


        <!-- Application Received (Monthly) -->
		<div class="col-xl-3 col-md-6 mb-4" id="apps_completed_within_unit" data-inbox="3">
			<div class="card border-left-success shadow h-100 py-2">

				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-success text-uppercase mb-1">Completed
								Within Unit</div>
							<!-- <div class="text-xs  text-dark text-uppercase">this month (
								<fmt:formatDate value="${now}" pattern="MMMM" />)</div> -->
							<div id="withinunit_count" class="h5 mb-0 font-weight-bold text-gray-800"></div>
						</div>
						<div class="col-auto">
							<i class="fas fa-file fa-2x text-gray-300"></i>
						</div>
			
						</a>
					</div>
				</div>

			</div>
		</div>


		<!-- Application Completed (Monthly) -->
		<div class="col-xl-3 col-md-6 mb-4"   id="apps_queried" data-inbox="5">
			<div class="card border-left-danger shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Applications
								Queried</div>
                                <!-- <div class="text-xs  text-dark text-uppercase">this Year (
                                    <fmt:formatDate value="${now}" pattern="YYYY" />)</div> -->
							<div id="queried_count" class="h5 mb-0 font-weight-bold text-gray-800"></div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clock fa-2x text-gray-300"></i>
						</div>

						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
   


    <hr>

    <ol class="breadcrumb">
		<li class="breadcrumb-item text-uppercase text-gray-800">Legal Officers</li>
		<!-- <li class="breadcrumb-item active">${unit_name}</li> -->
	</ol>





    <div class="row mb-4">
        <div class="col col-12">
            <div class="card shadow">
                <div class="card-body">
                    <!-- Table Header -->
                    <div class="row">
                        <div class="col">
                            <div class="font-weight-bold text-primary text-uppercase mb-1">Officer</div>
                        </div>
                        <div class="col">
                            <div class="font-weight-bold text-info text-uppercase mb-1">Total Count</div>
                        </div>

                        <div class="col">
                            <div class="font-weight-bold text-success text-uppercase mb-1">Status Count</div>
                        </div>


                        <div class="col">
                            <div class="font-weight-bold text-success text-uppercase mb-1">Performance</div>
                        </div>

                        <div class="col">
                            <div class="font-weight-bold text-success text-uppercase mb-1">Action</div>
                        </div>
                    </div>
                    <hr>
    
                    <!-- List of Officers with Count and Percentage -->
                   

                  <div id="finish_btn1"></div>


                  


                    <!-- Add more rows for officers here -->
                </div>
            </div>
        </div>
    </div>
   

    			
		
		
		</div>
		

		
		</div>

		
	</div>

	</div>
</div>
<!-- /.container-fluid -->
<!-- End of Main Content -->




<!-- applications received today -->







<div class="modal fade" id="view_applications_with_monitoring_unit_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">APPLICATIONS WITH <span id="staffname"></span> </h5>
                &nbsp;  &nbsp;  &nbsp;
                <div id="messageBt"></div>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="view_applications_with_monitoring_unit_table" width="100%" cellspacing="0">
                    <!-- <table id="csau_staff_yearly_apps_view" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Date Created</th>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
                            <th>Job Status</th>
                            <th>Job Purpose</th>
                            <th>Days Spent</th>
                            <th>Batch</th>
							
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
</div>





<div class="modal fade" id="askForPurposeOfBatchingnew" tabindex="-1" role="dialog" data-position="10"
	aria-labelledby="askForPurposeOfBatchingnew" aria-hidden="true" style="z-index:10000000000"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Add To Batch List</h4>
			</div>
			<div class="modal-body">
				<input type="hidden" id="bl_application_stage" name="bl_application_stage">
				<input type="hidden" id="bl_application_stage_baby_step" name="bl_application_stage_baby_step">

				<div class="form-group">
					<label for="bl_job_number">Job Number</label> <input
						class="form-control " type="text" placeholder=""
						id="bl_job_number" readonly
					>
				</div>





				<div class="form-group">
					<label for="bl_ar_name">Applicant Name</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_ar_name" readonly
					></textarea>
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Application Type</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_business_process_sub_name" readonly
					></textarea>
				</div>


				<div class="form-group">
					<label for="bl_application_stage_name">Main Milestone</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_application_stage_name" readonly
					></textarea>
				</div>

				<div class="form-group">
					<label for="bl_application_stage_name_baby_step">Baby Step</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_application_stage_name_baby_step" readonly
					></textarea>
				</div>




				<div class="form-group">
					<label for="bl_job_purpose">Sent Purpose</label>
				<select name="bl_job_purpose_new" id="bl_job_purpose_new" class="form-control selectpicker"
					>
						<!-- <option value="Male">Male</option>
						<option value="Female">Female</option> -->
				</select>
					
				</div>


				

				
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btnaddjobtolistFinal"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Add to List</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->


				<input type="hidden" id="bl_jn_id" name="jn_id"> <input
					type="hidden" id="bl_send_by_id" name="send_by_id"
				> <input type="hidden" id="bl_userid" name="userid">
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>






<!-- Send Message Modal-->
<div class="modal fade" data-position="0" id="sendMessageModal" tabindex="-1" role="dialog"
	aria-labelledby="sendMessageModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="sendMessageModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<form method="post" id="message-form" action="SendComplianceMessage">
					<input id="officer_id" name="officer_id" type="hidden"/>
					<input id="request_type" value="send_compliance_focal_person_message" type="hidden">
					<input id="officer_name" name="officer_name" type="hidden"/>
					<input id="job_numbers" name="job_numbers[]" type="hidden"/>
				  <div class="mb-3">
				    <label for="message_type" class="form-label">Message Type</label>
				    <select required class="form-control" name="message_type" id="message_type">
				    	<option value="">Select One</option>
				    	<option value="query">Query</option>
				    	<option value="Warning">Warning</option>
				    </select>
				  </div>
				  <div class="mb-3">
				    <label for="message" class="form-label">Message</label>
				    <textarea required class="form-control" name="message" id="message"></textarea>
				  </div>
				  <button type="submit" class="btn btn-primary">Submit</button>
				</form>
			</div>
		</div>
	</div>
</div>






<div class="modal fade" id="view_applications_incoming_with_monitoring_unit_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel"><span id="staffname1"></span> </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
                <div class="row">
                    <!-- Application Received -->
                    
                </div>
                <div class="table-responsive">
					<table class="table table-bordered table-hover" id="view_applications_incoming_with_monitoring_unit_table" width="100%" cellspacing="0">
                    <!-- <table id="csau_staff_yearly_apps_view" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                       <thead>
                            <th>Date Created</th>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Application Type</th>
                            <th>Job Status</th>
                            <th>Job Purpose</th>
                            <th>Days with officer</th>
                            <th>Batch</th>
							
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
</div>



<!-- Send Message Modal-->
<div class="modal fade" data-position="0" id="sendMessageModal" tabindex="-1" role="dialog"
	aria-labelledby="sendMessageModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="sendMessageModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<form method="post" id="message-form" action="SendComplianceMessage">
					<input id="officer_id" name="officer_id" type="hidden"/>
					<input id="request_type" value="send_compliance_focal_person_message" type="hidden">
					<input id="officer_name" name="officer_name" type="hidden"/>
					<input id="job_numbers" name="job_numbers[]" type="hidden"/>
				  <div class="mb-3">
				    <label for="message_type" class="form-label">Message Type</label>
				    <select required class="form-control" name="message_type" id="message_type">
				    	<option value="">Select One</option>
				    	<option value="query">Query</option>
				    	<option value="Warning">Warning</option>
				    </select>
				  </div>
				  <div class="mb-3">
				    <label for="message" class="form-label">Message</label>
				    <textarea required class="form-control" name="message" id="message"></textarea>
				  </div>
				  <button type="submit" class="btn btn-primary">Submit</button>
				</form>
			</div>
		</div>
	</div>
</div>





<div class="modal fade" data-position="0" id="sendMessageModal" tabindex="-1" role="dialog"
	aria-labelledby="sendMessageModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="sendMessageModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<form method="post" id="allmessageform" action="SendComplianceMessage">
					<input id="officer_id" name="officer_id" type="hidden"/>
					<input id="request_type" value="send_compliance_focal_person_message" type="hidden">
					<input id="officer_name" name="officer_name" type="hidden"/>
					<input id="job_numbers" name="job_numbers[]" type="hidden"/>
				  <div class="mb-3">
				    <label for="message_type" class="form-label">Message Type</label>
				    <select required class="form-control" name="message_type" id="message_type">
				    	<option value="">Select One</option>
				    	<option value="query">Query</option>
				    	<option value="Warning">Warning</option>
				    </select>
				  </div>
				  <div class="mb-3">
				    <label for="message" class="form-label">Message</label>
				    <textarea required class="form-control" name="message" id="message"></textarea>
				  </div>
				  <button type="submit" class="btn btn-primary">Submit</button>
				</form>
			</div>
		</div>
	</div>
</div>








<jsp:include page="../includes/_footer.jsp"></jsp:include>

<script type="text/javascript" src="client_application/compliance_request_monitoring.js"></script>