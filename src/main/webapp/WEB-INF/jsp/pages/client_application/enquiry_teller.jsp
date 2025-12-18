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
	        <div class="col">
	          <!-- Example Bar Chart Card-->
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fa fa-bar-chart"></i>Search Applications   <%-- ${page_name == "page_enquiry_backoffice" ? "test value" : ""} --%> </div>
	            <div class="card-body">
	              	<!--  The Form starts here -->
	              	<form id="frmEnquiryJobSearch"  method="post">
						<div class="form-group">
					  	
					  		<label><b>Search By: </b></label>
					  	
					  </div>
					  
					    <div class="custom-control custom-radio custom-control-inline">
						  <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="custom-control-input" value="job_number" required>
						  <label class="custom-control-label" for="rbtn_search_type1">Job number</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
						  <input type="radio" id="rbtn_search_type2" name="rbtn_search_type" class="custom-control-input" value="case_number" required>
						  <label class="custom-control-label" for="rbtn_search_type2">Case Number</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
						  <input type="radio" id="rbtn_search_type3" name="rbtn_search_type" class="custom-control-input" value="regional_number" required>
						  <label class="custom-control-label" for="rbtn_search_type3">Regional Number</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
						  <input type="radio" id="rbtn_search_type4" name="rbtn_search_type" class="custom-control-input" value="glpin" required>
						  <label class="custom-control-label" for="rbtn_search_type4">GLPIN</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
						  <input type="radio" id="rbtn_search_type6" name="rbtn_search_type" class="custom-control-input" value="ref_number" required>
						  <label class="custom-control-label" for="rbtn_search_type6">Ref Number</label>
						</div>
						 <div class="custom-control custom-radio custom-control-inline">
						  <input type="radio" id="rbtn_search_type5" name="rbtn_search_type" class="custom-control-input" value="ar_name" required>
						  <label class="custom-control-label" for="rbtn_search_type5">Applicant Name</label>
						</div> 
					  
					  <br><br>
			          <div class="form-group">
			            <div class="form-row">
			            <!-- <label for="search_value">Search  by Case Number / Regional Number / Applicant Name / Job number /GLPIN</label> -->
			              <div class="col-md-8">
			                
			                <input class="form-control" id="enq_search_value"  name="enq_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
			              </div>
			              <div class="col-md-4">
			              	
			                <button type="submit" class="btn btn-primary btn-block" value="Search" id="btnEnquiryJobSearch" > Search </button>
			                
			              </div>
			            </div>
			          </div>
			        </form>
					<div class="alert alert-danger d-none" id="enquiry_alert" role="alert">
						No Results Found
					  </div>
	            <!-- The form Ends Hers -->
	
	            </div>
	           <!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
	          </div>
	
	          
	         
	        </div>
        
	      	<!--   Here is the right Table -->
	        <div class="col-sm-4">
	          <!-- Example Pie Chart Card-->
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fas fa-pie-chart"></i> Batchlist Preview</div>
	            <div class="card-body">
	            
	            	<form id="frmEnquiryBatchlist"  method="post">
	
			          <div class="form-group">
			          <label for="search_value">Batch Number <br> &nbsp;</label>
			            <div class="form-row">
			            
			              <div class="col-md-8">
			                
			                <input class="form-control" id="enq_batchlist"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
			              </div>
			              <div class="col-md-4">
			              	
			                <input type="submit" class="btn btn-primary btn-block" value="Find Batchlist" />  
			                
			              </div>
			            </div>
			          </div>
			        </form>
	            
	          </div>
	              <br>
	        </div>
	      <!--   Here is the end of right table -->
      
      
   
      </div>
       
      	  </div>
    
    
    <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3" style="display:none" id="enq-search-results-section">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Search Results</div>
            <div class="card-body">
            
         
            
	             <!--  Here is where the fee list comes -->
	             
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
             
              <!--  End Of Table -->
             </div>
            <!-- <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
          </div>
          
     <!-- Example Bar Chart Card-->
          
        
    
       </div>
        
      </div>
     </div>
     
     
    
 </div>
 
 
 
 
 
 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>