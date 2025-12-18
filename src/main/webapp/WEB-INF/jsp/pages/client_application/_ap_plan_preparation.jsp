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
					          
   <h3 class="border-bottom border-gray pb-2">Parcel Plan Preparation</h3>
						          
		
						 
						 
   <!--  <div class="col-md-12">
			 <div class="card mb-3">
			   <div class="card-header">
				 <i class="fa fa-pie-chart"></i>Objections List</div>
			   <div class="card-body">
					 <table class="table table-bordered table-hover table-sm">
						 <thead>
							 <tr>
								 <th>Objector </th>
								 <th>Address</th>
								 <th>Contact</th>
								 <th>Date </th>
								 <th>Action </th>
							 </tr>
						 </thead>
						 <tbody>	
							 <tr>
								 <td>Objector </td>
								 <td>Address</td>
								 <td>Contact</td>
								 <td>Date </td>
								 <td>
									 
									 <button type="button" id="editOjectionModal"  data-toggle="modal" data-target="#newObjectionModal"  data-action="edit"  class="btn btn-danger btn-icon-split "  title="edit objection" >
									   <span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
								   </button> 
								   
							   </td>
							 </tr>	
						 </tbody>
					 </table>
				 </div>
				 </div>
		 </div> -->
		 
		 
		 
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
		
		<input class="form-control" id="lc_fr_bl_wkt_polygon"  name="lc_fr_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
		
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
		 <i class="fa fa-pie-chart"></i>Title Plan Preparation</div>
	   <div class="card-body">
		  <!--  The Form starts here -->
		 <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
  
<!-- Maps Details Starts Here  -->
<div class="bs-example">





<div class="btn-group mr-2">
<button type="button" class="btn btn-primary"  id="smdfrtp_lc_btn_fr_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-map"></i>
</button>


<button type="button" class="btn btn-primary" id="btn_print_new_title_plan" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-print"></i>
</button>
</div>


<!--  Zoom to cooedinate -->
<div class="row">
													   
<div class="col-md-5">
<div class="form-group">

<input class="form-control" type="text" name="name"  id="smd_x_coordinate_mak" placeholder="Eastings"> 
</div>
</div>


<div class="col-md-5">
<div class="form-group">

<input class="form-control" type="text" name="name" id="smd_y_coordinate_mak" placeholder="Northings"> 


</div>
</div>

<div class="col-md-2">
<div class="form-group">
<button type="button" class="btn btn-primary" id="smd_btn_show_location" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-map-marker"></i> </button>

</div>
</div>


<div class="col-md-2">
<div class="form-group">
<button type="button" class="btn btn-primary" id="smd_btn_load_for_scanned_maps_by_point" data-placement="top" data-toggle="tooltip" title="Search Scanned Map"><i class="fa fa-check-circle"></i> </button>

</div>
</div>

</div>



<!--  Scanned Maps -->

<div class="row">
													   
<div class="col-md-8">
<div class="form-group">

		   

<select name="geoserverscannedimages_list" id="geoserverscannedimages_list" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
<option value="-1">No Scanned Image</option>
</select> 
</div>
</div>

<div class="col-md-2">
<div class="form-group">
<button type="button" class="btn btn-primary" id="smd_btn_search_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="search_for_scanned_maps"><i class="fa fa-search"></i> </button>

</div>
</div>
<div class="col-md-2">
<div class="form-group">
<button type="button" class="btn btn-primary" id="smd_btn_load_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-check-circle"></i> </button>

</div>
</div>

</div>









</div>






<div id="smdfrtp-map" ></div>


			 
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
  
  
