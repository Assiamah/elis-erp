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
   <h3 class="border-bottom border-gray pb-2">Coordinate Entry</h3>
			 
   

   <div class="row">
	<!--   Here is the right Table -->
	   <div class="col-lg-12">
		 <!-- Example Pie Chart Card-->
		 <div class="card mb-3">
		   <div class="card-header">
			 <i class="fa fa-pie-chart"></i>Title Plan Update</div>
		   <div class="card-body">
	
	
						 <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
	
		   <div class="form-group">
		  
		   <div class="form-row">  <label for="bl_job_purpose">WKT Polygon</label>
			
			<!-- <input class="form-control" id="lc_fr_bl_wkt_polygon"  name="lc_fr_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
			 -->
		   </div>
			</div>
			 
			<div class="form-row">
			   
			   <div class="col-md-4">
				  <label for="search_value">GLPIN</label>
				  <input class="form-control" id="txt_glpin"    type="text" aria-describedby="nameHelp" placeholder="GLPIN" value="${glpin}" readonly>
				</div>
			  
				  
				<div class="col-md-4">
				  <label for="search_value">Type of Plotting</label>
				  <input class="form-control" id="txt_lc_smd_type_of_plotting"  name="txt_lc_smd_type_of_plotting"  type="text" aria-describedby="nameHelp"  value="${smd_type_of_plotting}" readonly>
				</div>
	
				  <div class="col-md-4">
				  <label for="search_value">SMD Reference Number</label>
				  <input class="form-control" id="txt_lc_smd_reference_number"  name="txt_lc_smd_reference_number"  type="text" aria-describedby="nameHelp"  value="${smd_reference_number}" readonly>
				  </div>
	
			</div>
		   
		   
		   <div class="form-row">
		   
		 
	
			  <div class="col-md-4">
			  <label for="search_value">Registration District</label>
			  <input class="form-control" id="txt_lc_registration_district_number"  name="txt_lc_registration_district_number"  type="text" aria-describedby="nameHelp" value="${registration_district_number}" readonly >
			</div>
	
			<div class="col-md-4">
			  <label for="search_value">Section Number</label>
			  <input class="form-control" id="txt_lc_registration_section_number"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registration_section_number}" readonly>
			</div>
			  <div class="col-md-4">
			  <label for="search_value">Block Number</label>
			  <input class="form-control" id="txt_lc_registration_block_number"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registration_block_number}" readonly>
			</div>
		   
		  </div>
		  
			
			   <div class="form-row">
		  
				  <div class="col-md-4">
					  <label for="search_value">Land size</label>
					  <input class="form-control" id="txt_lc_size_of_land"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${size_of_land}" readonly>
					</div>
					  <div class="col-md-4">
					  <label for="search_value">Plan Number</label>
					  <input class="form-control" id="txt_lc_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp" value="${plan_no}" readonly>
					</div>
			 <div class="col-md-4">
				 <label for="search_value">LTR Plan Number</label>
			  <input class="form-control" id="ltr_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${ltr_plan_no}" readonly>
			
			   
			 </div>
		   
		  </div>
		  
		  <div class="form-row">
			<div class="col-md-4">
			  <label for="search_value">Registry Map No</label>
			  <input class="form-control" id="txt_lc_registry_mapref"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registry_mapref}" readonly>
			</div>
			
			<div class="col-md-4">
			  <label for="search_value">CC No</label>
			  <input class="form-control" id="txt_lc_cc_no"  name="search_value"  type="text" aria-describedby="nameHelp" value="${cc_no}" readonly>
			</div> 
			
		   
		   
		  </div>
	
		   
				
			   
	   </form>
	
		   
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
		   <i class="fa fa-pie-chart"></i>Coordinate Entry</div>
		 <div class="card-body">
			<!--  The Form starts here -->
		   <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
	
<!-- Maps Details Starts Here  -->

<div class="form-group">
					 <div class="form-row">  <label for="lc_bl_wkt_polygon">WKT Polygon</label>
						   <input class="form-control" id="lc_bl_wkt_polygon"  name="lc_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" readonly >

						 <!-- <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" ></textarea> -->
					 </div>
					 
			   
				  </div>



<div class="bs-example">






	 <div class="btn-group mr-2">
	 


<button type="button" class="btn btn-primary"  id="lc_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-map"></i>
</button>
<!--  
<button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
<i class="fa fa-save"></i>
</button>
-->

<button type="button" class="btn btn-primary" id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
<i class="fa fa-object-ungroup"></i>
</button>



<!--        
<button type="button" class="btn btn-primary" id="lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-print"></i>
</button> -->






</div> 








</div>






<div id="lc-map"></div>

<!--  Here is where the fee list comes -->


			   
		   </form>
		 
		 <!-- The form Ends Hers -->
		 
	   </div>
	   
	   
		  <!--  Scanned Maps -->








<div class="bs-example">

	 <div class="btn-group mr-2">
	  <button type="button" class="btn btn-primary" id="lc_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addcoordinatetoplot" data-toggle="tooltip" title="Add Coordinate">
		 <i class="fa fa-plus-circle"></i>
	 </button>
	 
	 
		 <button type="button" class="btn btn-primary"  id="lrd_btn_add_coordinate_by_csv" data-placement="top" data-toggle="modal" data-target="#uploadcoordiantecsv" data-toggle="tooltip" title="Upload CSV">
	 <i class="fa fa-upload"></i>
 </button>
	 
	   <button type="button" class="btn btn-primary"  id="lc_btn_visualise_coordinate" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
		 <i class="fa fa-eye"></i>
	 </button>
	 
	  <button type="button" class="btn btn-primary" id="btn_lc_save_parcel_for_general_noting" data-placement="top" data-toggle="tooltip" title="Save">
		 <i class="fa fa-save"></i>
	 </button>

</div> 

</div>







<!--  Here is where the fee list comes -->

<div  class="table w-auto small">
	<table class="table table-bordered" id="coordinatelis_Table" width="100%" cellspacing="0">
	
	   <thead>
		 <tr>
		  
		  
		  
		  <th>name</th>
		  <th>x_coordinate</th>
		  <th>y_coordinate</th>
		  <th>Remove</th>
		   </tr>
	   </thead>
	   
		 <tbody>

</tbody>
	  <!--  <tfoot>
		 <tr>
		   <th>Job Number</th>
		   <th>Applicant Name</th>
		   <th>Status</th>
		   <th>Case Details</th>
			   
				<th>Add To List</th>
		 </tr>
	   </tfoot> -->
	 
	 </table>
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
  
  
