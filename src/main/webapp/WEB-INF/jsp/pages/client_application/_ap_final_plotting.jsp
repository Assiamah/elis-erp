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


   <jsp:include page="../client_application/_application_process_header.jsp"></jsp:include>
   <h3 class="border-bottom border-gray pb-2">Final Approval of Registration</h3>
               

   <div class="row">

	   <!--   Here is the right Table -->
						  <div class="col-lg-12">
							<!-- Example Pie Chart Card-->
							<div class="card mb-3">
							  <div class="card-header">
								<i class="fa fa-pie-chart"></i>Final Approvals</div>
							  <div class="card-body">
								 <!--  The Form starts here -->
								 <input class="form-control" id="txt_certificete_approval_status"  name="txt_certificete_approval_status"  type="hidden" aria-describedby="nameHelp" readonly value="${certificete_approval_status}" >
								 <input class="form-control" id="txt_final_approval_status"  name="txt_final_approval_status"  type="hidden" aria-describedby="nameHelp" readonly value="${final_approval_status}" >
		 
								  <div class="form-row">
											   <div class="col-md-3">
												   <input type="button" id="lc_btn_approve_certicate_for_signature" class="btn btn-danger btn-block" value="Approve Certificate" />  
			 
											   </div>
											   <div class="col-md-3">
												   <input type="button" id="lc_btn_generate_activation_code" class="btn btn-danger btn-block" value="Final Approval of Title" />  
			 
											   </div>
											   
											   <div class="col-md-3">

												   <input type="button" id="lc_btn_activate_final_certificate" class="btn btn-primary btn-block" value="Generate Final Certificate" />  
			
												   <!-- 																	 
												   <input type="button" id="lc_btn_activate_provisional_certificate" class="btn btn-warning btn-block" value="Generate Provisional Certificate" />  
													-->
											   </div>
											   <div class="col-md-3">
												   <input type="button" id="lc_btn_activate_final_register" class="btn btn-primary btn-block" value="Generate Final Register" />  
		
											   </div>
							   
							  </div>
							  
							  <!-- The form Ends Hers -->
							  
							</div>
						   
						  </div>
						<!--   Here is the end of right table -->
					
						</div>
  
   </div>


	 
	 <div class="row">
	<!--   Here is the right Table -->
	   <div class="col-lg-12">
		 <!-- Example Pie Chart Card-->
		 <div class="card mb-3">
		   <div class="card-header">
			 <i class="fa fa-pie-chart"></i>Final Approval of Registration</div>
		   <div class="card-body">
			  <!--  The Form starts here -->
			 <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
	  
<!-- Maps Details Starts Here  -->
<div class="bs-example">





<div class="btn-group mr-2">
<button type="button" class="btn btn-primary"  id="btn_lcfrfa_lc_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-map"></i>
</button>

<!--  
<button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
<i class="fa fa-save"></i>
</button>
-->

<button type="button" class="btn btn-primary" id="btn_lcfrfa_lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
<i class="fa fa-object-ungroup"></i>
</button>


<button type="button" class="btn btn-primary" id="btn_lcfrfa_lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-print"></i>
</button>
</div>


</div>

<div id="lcfrfa-map" ></div>


				 
			 </form>
		   
		   <!-- The form Ends Hers -->
		   
		 </div>
		
	   </div>
	 <!--   Here is the end of right table -->
 
	 </div>
	 
   
	</div>

	<input type="hidden" id="ars_job_purpose" class="form-control" value="${job_purpose}">

	<div class="mt-5">
		<button class="btn btn-success btn-icon-split float-left "  data-job_number="${job_number}" id="btnApproveJob">
			<span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Approve Request</span>
		</button>

		<button class="btn btn-danger btn-icon-split float-left ml-3"  data-job_number="${job_number}" id="btnQueryJob">
			<span class="icon text-white-50"> <i class="fas fa-times fa-2x"></i></span><span class="text">Query Request</span>
		</button>
	 </div>
            
		<jsp:include page="../client_application/_application_process_footer_ar.jsp"></jsp:include>
  
  
