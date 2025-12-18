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
	              <i class="fa fa-bar-chart"></i>Search Section</div>
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

						
					  <br><br>
			          
					 
					 
					  <div class="form-group">
			            <div class="form-row">
			            
			              <div class="col-md-8 mb-4">
			                
			                <input class="form-control" id="enq_search_value"  name="enq_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
			              </div>
			              <div class="col-md-4">
			              	
			                <button type="submit" class="btn btn-primary btn-block" value="Search" id="btnEnquiryJobSearch" > Search </button>
			                
			              </div>
			            </div>
			          </div>


			        </form>
	            
	            <!-- The form Ends Hers -->

				<div class="alert alert-danger d-none" id="enquiry_alert" role="alert">
					No Results Found
				  </div>
	
	            </div>
	           <!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
	          </div>
	
	          
	         
	        </div>
            <div class="col-sm-6">
            <div class="form-row" id="unit-batching" style="background-color: rgb(33, 152, 87); padding: 15px;">
                <div class="col-12"><h4 style="" class="text-white">Batching to a Regional Unit</h4></div>
                <div class="col-12">
                    <div class="form-row">
                        <div class="col">
                            <label for="" class="col-form-label">Select Region :</label>
                            <select id="get_change_region_compliance_crb" class="form-control input-sm" data-style="btn-info" data-live-search="true" required>
                  <!-- <option selected disabled value="-1">-- select --</option>					 -->
                  <option selected disabled>Please Select</option>						
                  <c:forEach items="${officeregionlist}" var="officeregion">
                    <option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                </c:forEach>
                    </select>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <label for="" class="col-form-label">Division :</label>
                    <select id="unit_division_to_send_to_crb" class="form-control">
                        <option value="none">---Select Division---</option>
                    <!-- <option value='LVD'>LVD</option>
                        <option value='LRD'>LRD</option>
                        <option value='PVLMD'>PVLMD</option>
                        <option value='SMD'>SMD</option>
                        <option value='RLO'>RLO</option>
                        -->
                        <option value="LVD">LVD</option>
                        <option value="LRD">LRD</option>
                        <option value="PVLMD">PVLMD</option>
                    <option value="SMD">SMD</option>
                        <option value="RLO">RLO</option>
                        <option value="CORPORATE">CORPORATE</option>
                    </select>
                    
                </div>
                <div class="col mb-3">
                <label for="" class="col-form-label">Unit :</label>
                    <input autocomplete="off" class="form-control" id="unit_to_send_to_crb" type="text" list="listofunitsbatching" placeholder="Select/Enter Unit" required="">
                    <datalist id="listofunitsbatching"></datalist>
                </div>
                <div class="col-12">
                <div class="form-group">
					<label for="bl_job_purpose">Sent Purpose</label>
				<select name="bl_job_purpose_new" id="bl_job_purpose_new" class="form-control selectpicker"
					>
						<!-- <option value="Male">Male</option>
						<option value="Female">Female</option> -->
				</select>
					
				</div>
                </div>
<div class="col-12">
<div class="form-group">
					<label for="bl_application_stage_name_baby_step">Remarks/Notes</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_remarks_notes"
					></textarea>
				</div>
</div>
				
                <div class="col-12">
                    <button type="submit" style="display: none;" class="btn btn-warning btn-block" value="Batch" id="btn_process_batchlist_crb" > Process </button>
                </div>
            </div>
            
            
            
            
        
	      	
	      <!--   Here is the end of right table -->
      
      
   
      </div>
       
      	  </div>
    
    
    <div class="row mt-2">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3" style="" id="enq-search-results-section">
            <div class="card-header">
            <i class="fa fa-bar-chart"></i>
            Search Results (The result is only 10 records)
            <button type="button" id="btn-remove-all" class="btn btn-danger mb-2 float-right ms-2">Remove All</button>
            </div>
            <div class="card-body">
            
         
            
	             <!--  Here is where the fee list comes -->
	             
	             <div class="table-responsive" >
			           <table class="table table-bordered " id="tbl-appData_tranfer" style="min-height:500px">
			              <thead>
			                <tr>
			                 <th>Applicant Name</th>
			                  <th>Case Number</th>
			                  <th>Job Number</th>
			                  <th>Application Type</th>
			                  
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