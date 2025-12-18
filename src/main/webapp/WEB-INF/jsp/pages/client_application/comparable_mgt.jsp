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

  <jsp:include page="../includes/_header.jsp"></jsp:include>
  

  <% 


	  
%>

  
  


    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">Comparable</a>
        </li>
        <li class="breadcrumb-item active">List of Unapproved Comparables</li>
      </ol>
           

         <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header bg-dark text-white">
              <i class="fa fa-bar-chart"></i>Application Details
              	<span class="col-md-3 float-right ">
              <button class="btn btn-success btn-icon-split float-right "  id="btnViewBatchlist">
					<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">Refresh List</span>
				</button></span>
              
              </div>
              
            <div class="card-body">
            
         
         
         
         
         
         <div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-6">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>List of Comparables</div>
				              
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
				                <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered data-table" id="job_detailsdataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                 
                 <th>Ref Number</th>
                 <th>Transaction Date</th>
                 <th>Lands Size</th>
               <!--   <th style="display:none">Status</th> -->
                 <!-- <th>Status</th> -->
                
                 <th>Property Value</th>
                

                 <th >View</th>
                 <th >Approve</th>
                
                 
                 
                 
                 
                 <!-- 	<th data-field="customer.name" data-align="center" data-sortable="true">customer</th>
                    <th data-field="type" data-align="center" data-sortable="true">type</th>
                    <th data-field="description" data-align="center" data-sortable="true">description</th>
                    <th data-field="cutter" data-align="center" data-sortable="true">cutter</th> 
                    <th data-field="valid_s" data-align="center" data-sortable="true">valid</th>
                  -->
                 
                 </tr>
              </thead>
              
                <tbody>
    
            		
                  <c:forEach items="${applicationlist}" var="appfiles">
                <tr >
                    <td >${appfiles.job_no}</td>

                    <td >${appfiles.transaction_date}</td>
                    
                     <td >${appfiles.accreage_size_of_land}</td>
                    
                     <td >${appfiles.value_of_property}</td>
                    
                    <td>
                    	<button 
                    		class="btn btn-info btn-icon-split" 
                    		data-title="Delete" 
                    		id="btn_view_comparable_on_map-${appfiles.job_no}" 
                    		data-id="${appfiles.id}" 
                    		data-job_no="${appfiles.job_no}" 
                    		data-property_owner="${appfiles.property_owner}"  
                    		data-wkt="${appfiles.wkt}" 
                    		 data-target="#comparablepopup" data-toggle="modal" >
                    		<span class="icon text-white-50"> <i class="fas fa-list"></i></span>
                    		<span class="text">View</span>
                    	</button>
                    </td>
                
                  <td>
                    	<button 
                    		class="btn btn-info btn-icon-split" 
                    		data-title="Delete" 
                    		id="btn_approval_comparable_on_map-${appfiles.job_no}" 
                    		data-id="${appfiles.id}" 
                    		data-job_no="${appfiles.job_no}" 
                    		data-property_owner="${appfiles.property_owner}"  
                    		data-wkt="${appfiles.wkt}" 
                    		 data-target="#comparableapprovalpopup" data-toggle="modal" >
                    		<span class="icon text-white-50"> <i class="fas fa-list"></i></span>
                    		<span class="text">Approve</span>
                    	</button>
                    </td>
                
			
			
                
                 <td>
                    	<button 
                    		class="btn btn-info btn-icon-split" 
                    		data-title="Delete" 
                    		id="btn_approval_comparable_on_map-${appfiles.job_no}" 
                    		data-id="${appfiles.id}" 
                    		data-job_no="${appfiles.job_no}" 
                    		data-property_owner="${appfiles.property_owner}"  
                    		data-wkt="${appfiles.wkt}" 
                    		 data-target="#comparableapprovalpopup" data-toggle="modal" >
                    		<span class="icon text-white-50"> <i class="fas fa-list"></i></span>
                    		<span class="text">Approve</span>
                    	</button>
                    </td>
                
                     
                    
                    </tr>
            </c:forEach>
            
            
             </tbody>
            
            
            </table>
          </div>
             
            
					        
             
         <!--     <button class="btn btn-success"  id="btn_map_comparable_report_rpt">
						<span class="icon text-white-50"> <i class="fas fa-eye"></i><span class="text">Comparable Report</span>
			</button>
				      -->       
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      
				       <div class="col-lg-6">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Map View</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				                    <div id="lvd-map" ></div>
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				     </div>
         

            </div>
            
            
            
            
          </div>
          
     
     
    
    
          
     <div class="modal fade" id="comparablepopup" tabindex="-1" role="dialog"
	aria-labelledby="comparablepopup" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Comporable details</h4>
			</div>
			<div class="modal-body">

				<div class="alert alert-danger">
					<span class="glyphicon glyphicon-warning-sign"></span> Are you sure
					you want to delete this Record?
				</div>

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success">
					<span class="glyphicon glyphicon-ok-sign"></span> Yes
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span> No
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
       
    
   

    


 <div class="modal fade" id="comparableapprovalpopup" tabindex="-1" role="dialog"
	aria-labelledby="comparableapprovalpopup" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Comparable Approval</h4>
			</div>
			<div class="modal-body">

				<div class="alert alert-success">
					<span class="glyphicon glyphicon-warning-sign"></span> Are you sure
					you want to approve this comparable?
				</div>
				
				
				<input type="hidden" name="cbl_parcel_uuid_ca" id="cbl_parcel_uuid_ca">
			
				
				<div class="form-group">
									<label for="bl_job_number">Job Number </label> <input
										class="form-control " type="text" placeholder=""
										id="cbl_job_no_ca" readonly
									>
								</div>
				
				
								<div class="form-group">
									<label for="bl_ar_name">Owner's Name</label>
							
									<input
										class="form-control " type="text" placeholder=""
										id="cbl_owners_name_ca" readonly
									>
								</div>

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success" id="btn_approve_comparable">
					<span class="glyphicon glyphicon-ok-sign"></span> Approve
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span> No
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
       
    

     
   
          
     <div class="modal fade" id="comparablepopup" tabindex="-1" role="dialog"
	aria-labelledby="comparablepopup" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Comporable details</h4>
			</div>
			<div class="modal-body">

				<div class="alert alert-danger">
					<span class="glyphicon glyphicon-warning-sign"></span> Are you sure
					you want to delete this Record?
				</div>

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success">
					<span class="glyphicon glyphicon-ok-sign"></span> Yes
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span> No
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>



+

 <div class="modal fade" id="comparableapprovalpopup" tabindex="-1" role="dialog"
	aria-labelledby="comparableapprovalpopup" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Comparable Approval</h4>
			</div>
			<div class="modal-body">

				<div class="alert alert-success">
					<span class="glyphicon glyphicon-warning-sign"></span> Are you sure
					you want to approve this comparable?
				</div>
				
				
				<input type="hidden" name="cbl_parcel_uuid_ca" id="cbl_parcel_uuid_ca">
			
				
				<div class="form-group">
									<label for="bl_job_number">Job Number </label> <input
										class="form-control " type="text" placeholder=""
										id="cbl_job_no_ca" readonly
									>
								</div>
				
				
								<div class="form-group">
									<label for="bl_ar_name">Owner's Name</label>
							
									<input
										class="form-control " type="text" placeholder=""
										id="cbl_owners_name_ca" readonly
									>
								</div>

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success" id="btn_approve_comparable">
					<span class="glyphicon glyphicon-ok-sign"></span> Approve
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span> No
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
       
 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
