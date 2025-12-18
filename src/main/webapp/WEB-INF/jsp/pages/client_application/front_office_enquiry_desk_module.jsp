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
          <a href="index.html">Case Management</a>
        </li>
        <li class="breadcrumb-item active">Create New case</li>
      </ol>
           
          <div class="row">
	        <div class="col-lg-8">
	          <!-- Example Bar Chart Card-->
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fa fa-bar-chart"></i>Service Selection</div>
	            <div class="card-body">
	              	<!--  The Form starts here -->
	              	<form action=""  method="post">
	
			          <div class="form-group">
			            <div class="form-row">
			            <label for="search_value">Search  by Case Number / Regional Number / Applicant Name / Job number /GLPIN</label>
			              <div class="col-md-8">
			                
			                <input class="form-control" id="enq_search_value"  name="enq_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
			              </div>
			              <div class="col-md-4">
			              	
			                <input type="submit" class="btn btn-primary btn-block" value="Search" />  
			                
			              </div>
			            </div>
			          </div>
			        </form>
	            
	            <!-- The form Ends Hers -->
	
	            </div>
	           <!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
	          </div>
	
	          
	         
	        </div>
        
	      	<!--   Here is the right Table -->
	        <div class="col-lg-4">
	          <!-- Example Pie Chart Card-->
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fas fa-pie-chart"></i> Multiple Enquiry Desk</div>
	            <div class="card-body">
	            
	            	<button type="button" class="btn btn-secondary btn-lg  " id="btn_load_scanned_documents" data-placement="top"  data-toggle="tooltip" title="File Number">
		            	<span class="icon text-white"> <i class="fas fa-hands"></i> </span><span  class="text text-white-50">Multiple Collections </span>
		        	</button>
		        	<br><br>
		        	<button type="button" class="btn btn-secondary btn-lg " id="btn_load_scanned_documents" data-placement="top"  data-toggle="tooltip" title="File Number">
		            	<span class="icon text-white"> <i class="fas fa-shopping-cart"></i> </span><span  class="text text-white-50">Multiple for Payments</span>
		        	</button>
	            
	          </div>
	              
	        </div>
	      <!--   Here is the end of right table -->
      
      
   
      </div>
       
      	  </div>
    
    
    <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Search Results</div>
            <div class="card-body">
            
         
            
	             <!--  Here is where the fee list comes -->
	             
	             <div class="table-responsive">
			           <table class="table table-bordered" id="" >
			              <thead>
			                <tr>
			                 <th>Applicant Name</th>
			                  <th>Case Number</th>
			                  <th>Job Number</th>
			                  <th>GLPIN</th>
			                  <th>Status</th>
			                  <th>Locality</th>
			                  <th>Regional Number</th>
			                  <th>Cabinet</th>
			                  <th>Details</th>
			                  <th>Collection</th>
			                  <th>Complete</th>
			                  <th>File Number</th>
			                  <th>Add Fees</th>
			                  
			                
			                 </tr>
			              </thead>
			              
			              <tbody>
			               	<tr>
			                 <td>test</td>
			                 <td>test</td>
			                 <td>test</td>
			                 <td>test</td>
			                 <td>test</td>
			                 <td>test</td>
			                 <td>test</td>
			                 <td>
			                 	<button type="button" class="btn btn-primary " id="btn_load_scanned_documents" data-placement="top"  
			                 	 title="View Application Progress" data-toggle="modal" data-target="#cabinetModal"  ><i class="fas fa-hdd"></i></button>
			                 </td>
			                 <td>
			                 	<button type="button" class="btn btn-primary" id="btn_load_scanned_documents" data-placement="top"  data-toggle="tooltip" title="View Application Details"><i class="fas fa-info-circle"></i></button>
			                 </td>
			                 <td>
			                 	<button type="button" class="btn btn-primary " id="btn_load_scanned_documents" data-placement="top"  data-toggle="tooltip" title="Issue out Application"><i class="fas fa-hand-holding"></i></button>
			                 </td>
			                 <td>
			                 	<button type="button" class="btn btn-primary " id="btn_load_scanned_documents" data-placement="top"  data-toggle="tooltip" title="Complete Application"><i class="fas fa-calendar-check"></i> 
					        	</button>
			                 </td>
			                 <td>
			                 	<button type="button" class="btn btn-primary " id="btn_load_scanned_documents" data-placement="top"  data-toggle="tooltip" title="File Number">
					            	<span class="icon text-white-50"> <i class="fas fa-file-import"></i> </span><span  class="text">LRD565 </span>
					        	</button>
	
							 </td>
			                 <td>
			                 	<button type="button" class="btn btn-primary  " id="btn_load_scanned_documents" data-placement="top"  data-toggle="tooltip" title="Add Fees"><i class="fa fa-dollar-sign"></i></button>
					        </td>
			                              
						     
			              </tbody> 
			            </table>
	          	</div>
             
              <!--  End Of Table -->
             </div>
            <!-- <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
          </div>
          
     
        
    
       </div>
        
      </div>
     </div>
     
     
    
 </div>
 
 
 
 <!-- Add Inspection Reports============================= -->
	<div class="modal fade" id="cabinetModal" tabindex="-1" role="dialog" aria-labelledby="addInspectionModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="addMinutesModalLabel">Application Tracking History</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	       <div class="row">
	       		<div class="col-md-8">
	       			<div class="card" >
					  <div class="card-header">
					    History
					  </div>
					  <div class="card-body">
					  		<table class="table table-bordered" id="">
					      		<thead>
					                <tr>
					                 <th>Comments</th>
					                  <th>Division/Unit</th>
					                  <th>Division</th>
					                  <th>Officer</th>
					                  <th>Date</th>
					                 </tr>
					              </thead>
					              
					      	</table>
					  </div>
					</div>
	       		
	       		
	       		
	       			
	       		</div>
	       		<div class="col-md-4">
	       			<div class="card" >
					  <div class="card-header">
					    Details
					  </div>
	       				<div class="card-body">
					  		<form >
					  			<div class="form-group ">
								    <label for="staticEmail" class=" col-form-label">Email</label>
								    <div class="col-sm-12">
								      <input type="text" readonly class="form-control" id="staticEmail" value="email@example.com">
								    </div>
								 </div>
								 
								 
				          		
					  		
					  		</form>
					  	</div>
					  </div>
	       		</div>
	       
	       </div>
	      	
	        <form id="form_inspection" method=get >
	        	
	        	<input type="hidden" id="in_job_number" value="${job_number}">
	        	<input type="hidden" id="in_case_number" value="${case_number}">
	        	
	        	
	        	
	        	
	          <div class="row">
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="inspection_date" class="col-form-label">Date of Inspection</label>
	            		<input type="date" name="in_inspection_date" id="in_inspection_date" value="" class="form-control" required >
	          		</div>
	          		<div class="form-group">
	            		<label for="in_inspection_purpose" class="col-form-label">Purpose of Inspection</label>
	            		<textarea name="in_inspection_purpose" id="in_inspection_purpose" class="form-control" required></textarea>
	            		
	          		</div>
	          		<div class="form-group">
	            		<label for="in_development_level" class="col-form-label">Level of Development</label>
	            		<textarea name="in_development_level" id="in_development_level" class="form-control" required></textarea>
	            		
	          		</div>
	          		<div class="form-group">
	            		<label for="in_ground_opinion" class="col-form-label">Opinion on the Ground</label>
	            		<textarea name="in_ground_opinion" id="in_ground_opinion" class="form-control" required></textarea>
	            		
	          		</div>
	          		
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		
	          		<div class="form-group">
	            		<label for="mt_to" class="col-form-label">Inspection Requested by</label>
	            		     <input class="form-control" id="requested_by"  name="requested_by"  type="text" aria-describedby="nameHelp" list="listofusers"  class="autocomplat" placeholder="Enter Username" required >
				                <datalist id="listofusers">
							
				                  
				               </datalist>
                
	          		</div>
	          		<div class="form-group">
	            		<label for="in_possession_person" class="col-form-label">Person in Possession</label>
	            		<textarea name="in_possession_person" id="in_possession_person" class="form-control" required></textarea>
	            		
	          		</div>
	          		<div class="form-group">
	            		<label for="in_neighborhood_description" class="col-form-label">Brief Description of Neighborhood</label>
	            		<textarea name="in_neighborhood_description" id="in_neighborhood_description" class="form-control" required></textarea>
	            		
	          		</div>
	          		<div class="form-group">
	            		<label for="in_neighbor_names" class="col-form-label">Name(s) of Neighbor(s)</label>
	            		<textarea name="in_neighbor_names" id="in_neighbor_names" class="form-control" required></textarea>
	            		
	          		</div>
	          	</div>
	          	
	          	
	          </div>
	           <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="submit" id="btn_add_inspection" class="btn btn-primary">Save Changes</button>
		      </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
 
 
 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
