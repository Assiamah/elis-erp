<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


  <jsp:include page="../includes/_header.jsp"></jsp:include>
  

  <% 


	  
%>

  
  

 <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="all_settings">All Settings</a>
        </li>
        <li class="breadcrumb-item active"></li> 
      </ol>
           
          <div class="row">
	        <div class="col-md-6">
	          <!-- Example Bar Chart Card-->
	          <div class="card mb-3">
	            <div class="card-header  bg-secondary text-light ">
              		<div class= "row">
	              		<div class="col-auto"><h3>Locations </h3></div>
	              			<div class="col">
	              				<div class="form-row float-right">
				        	  		<label class="col-auto">Region: </label> 
				        	  		<select
												id="district_region_office" class="form-control input-sm col"
											>
												<option value="-1">Select Office Region</option>
									
												<c:forEach items="${officeregionlist}" var="officeregion">
													<option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
										  </c:forEach>
						 

											</select>
				        	  	</div>
				        	</div>
	              		<div class="col-sm-3"><a href="" class="float-right text-light" data-loc_id="0" data-loc_name=""  data-target="#editLocalityModal" data-toggle="modal" >
	              		<i class="fas fa-plus"></i> Add New</a><br></div>
              		</div>
              	</div>
	            <div class="card-body "  >
	            	
	            	<div class="table-responsive"  >
	            		<table class="table " id="tblLocations">
	            			<thead>
	            				<tr><th>Location Name</th><th>Action</th></tr>
	            			</thead>
	            			<tbody>
	            			
	            				
	            			</tbody>
	            		
	            		</table>
		              	
					</div>
					
	            </div>
	           <div class="card-footer small text-muted">Locations</div> 
	          </div>
	
	          
	         
	        </div>
	        
	        
	        <div class="col-md-6">
	          <!-- Example Bar Chart Card-->
	          <div class="card mb-3">
	            <div class="card-header bg-secondary text-light">
              		<div class= "row">
	              		<div class="col-auto"><h3>Districts </h3></div>
	              		<div class="col">
              		
			              		<div class="form-row float-right">
				        	  		<label class="col-auto">Region: </label> 
				        	  		<select
												id="district_region" class="form-control input-sm col"
											>
												<option value="-1">Select Region</option>
												<c:forEach items="${regionlist}" var="region">
													<option  value="${region.region_id}">${region.region_name}</option>
										  </c:forEach>
						 
											</select>
				        	  	</div>
		        	  	</div>
		        	  	<div class="col-sm-3"><a href="" class="float-right text-right decoration-none" data-dis_id="0" data-dis_name=""  data-target="#editDistrictModal" data-toggle="modal" >
              		<i class="fas fa-plus"></i> Add New</a></div>
		        	  	</div>
              		
              		</div>
	            <div class="card-body row">
	            	
	            	<div class="table-responsive"  >
	            		<table class="table" id="tblDistricts">
	            			<thead>
	            				<tr><th>District Name</th><th>Action</th></tr>
	            			</thead>
	            			<tbody>
	            				<!-- <tr>
	            					
	            					<td>test</td>
	            					<td>
	            					<button class="btn btn-info btn-icon-split" 
			                    		data-loc_id="" 
			                    		data-loc_name=""  
			                    		data-target="#editLocalityModal" 
			                    		data-toggle="modal" >
			                    		<span class="icon text-white-50"> <i class="fas fa-edit"></i></span>
			                    		<span class="text">Edit</span>
			                    	</button>
                    			</td>
	            				</tr> -->
	            			</tbody>
	            		
	            		</table>
		              	
					</div>
					
	            </div>
	           <div class="card-footer small text-muted">Districts</div> 
	          </div>
			</div>
       	</div>
    </div>
 </div>
 
 <div class="modal fade" id="editLocalityModal" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Add/Edit Locality</h4>
			</div>
			<form id="frmEditLocality">
					<div class="modal-body">
							<input type="hidden" id="loc_locality_id" value="0">
							<input type="hidden" id="loc_office_id" value="0">
						<div class="form-group">
							<label for="">Office/Region</label>
							<input type="text" class="form-control" placeholder="" disabled
								id="loc_office_name"
							>
						</div>
						<div class="form-group">
							<label for="bl_job_purpose">Locality Name</label>
							<textarea rows="2" class="form-control" placeholder=""
								id="loc_locality_name"
							></textarea>
						</div>
		
					</div>
					<div class="modal-footer ">
		
						<div class="my-2"></div>
						<button   class="btn btn-success btn-icon-split" > 
							<span class="icon text-white-50"> <i class="fas fa-check"></i></span> 
							<span class="text">Save</span>
						</button>
		
						<div class="my-2"></div>
						<a href="#" data-dismiss="modal"
							class="btn btn-danger btn-icon-split"
						> <span class="icon text-white-50"> <i class="fas fa-times"></i>
						</span> <span class="text">Close</span>
		
						</a>
		
					</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="editDistrictModal" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Add/Edit District</h4>
			</div>
			<form id="frmEditDistrict">
					<div class="modal-body">
							<input type="hidden" id="district_id" value="0">
							<input  class="form-control" id="vregion_id"  type="hidden">
							
						<div class="form-group">
							<label for="">Region </label>
							<input  class="form-control" id="region_name" readonly>
							<input  class="form-control" id="region_id" type="hidden">
						</div>
						<div class="form-group">
							<label for="">District Name</label>
							<textarea rows="2" class="form-control" placeholder=""
								id="district_name"
							></textarea>
						</div>
		
					</div>
					<div class="modal-footer ">
		
						<div class="my-2"></div>
						<button   class="btn btn-success btn-icon-split" > 
							<span class="icon text-white-50"> <i class="fas fa-check"></i></span> 
							<span class="text">Save</span>
						</button>
		
						<div class="my-2"></div>
						<a href="#" data-dismiss="modal"
							class="btn btn-danger btn-icon-split"
						> <span class="icon text-white-50"> <i class="fas fa-times"></i>
						</span> <span class="text">Close</span>
		
						</a>
		
					</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
 
 
 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>