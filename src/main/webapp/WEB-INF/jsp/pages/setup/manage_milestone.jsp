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
        <!-- <li class="breadcrumb-item">
          <a href="index.html">Case Management</a>
        </li>
        <li class="breadcrumb-item active">Create New case</li> -->
      </ol>
           
          <div class="row">
	        <div class="col-sm-6">
	          <!-- Example Bar Chart Card-->
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fa fa-bar-chart"></i>Business Process</div>
	            <div class="card-body">
	              	<!--  The Form starts here -->
	              	<form id="frmTempBarcodingFind"  method="get">
	
			          <div class="form-group">
			            <div class="form-row">
			            <label for="search_value">Main Service</label>
			              <div class="col-md-8">
			                
			                <select name="main_service_on_case" id="mls_main_service" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
               			
							</select>
			              </div>
			              <div class="col-md-4">
			              	
			                <button type="submit" class="btn btn-primary btn-block" value="Search" id="" > Search </button>
			                
			              </div>
			            </div>
			          </div>
			        </form>
	            
	            <!-- The form Ends Hers -->
	
	            </div>
	           <!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
	          </div>
	
	          
	         
	        </div>
	        
	        
	        <div class="col-sm-6">
	          <!-- Example Bar Chart Card-->
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fa fa-bar-chart"></i>Application Details</div>
	            <div class="card-body">
	              	<!--  The Form starts here -->
	              	<form id="frmTempBarcoding"  method="get">
	
			          <div class="form-group">
			            <div class="form-row">
			            <label for="search_value">Name</label>
			                
			                <input class="form-control" id="rs_ar_name"  type="text" required >
			              
			            </div>
			            <br>
			            
			            
			            <div class="form-row">
			             
			              <div class="col-md-6">
			                <label for="search_value">Job number</label>
			                <input class="form-control" id="rs_job_number"  type="text" required >
			              </div>
			              <div class="col-md-6">
			              	<label for="search_value">Case Number</label>
			                <input class="form-control" id="rs_case_number"  type="text"  >
			                
			              </div>
			            </div>
			            <BR />
			            
			            
			             <div class="form-row">
			             
			              <div class="col-md-6">
			                <label for="search_value">Locality</label>
			                <input class="form-control" id="rs_locality"  type="text"  >
			              </div>
			              <div class="col-md-6">
			              <br>
			              		<button type="submit" class="btn btn-success btn-block btn-xl" value="Search" id="btnBarcoder" > Print Barcode </button>
			              		
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
	        
       
      	  </div>
    
    
    <div class="row">
     <!-- <div class="col-lg-12">
          Example Bar Chart Card
          <div class="card mb-3" style="display:none" id="enq-search-results-section">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Search Results</div>
            <div class="card-body">
            
         
            
	              Here is where the fee list comes
	             
	             <div class="table-responsive" >
			           <table class="table table-bordered " id="enq-search-results-table" style="min-height:500px">
			              <thead>
			                <tr>
			                 <th>Applicant Name</th>
			                  <th>Case Number</th>
			                  <th>Job Number</th>
			                  <th>GLPIN</th>
			                  
			                  <th>Locality</th>
			                  <th>Regional Number</th>
			                  
			                  <th>Actions</th>
			                  
			                  
			                
			                 </tr>
			              </thead>
			              
			              <tbody>
			               	
			                              
						     
			              </tbody> 
			            </table>
	          	</div>
             
               End Of Table
             </div>
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
          </div>
          
     Example Bar Chart Card
          
        
    
       </div> -->
        
      </div>
     </div>
     
     
    
 </div>
 
 
 
 
 
 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>