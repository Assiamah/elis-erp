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
    <!-- <div class="row">
    <span class="col-auto float-right ">
              <button class="btn btn-success btn-icon-split float-right "  id="btnViewFilesList">
					<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View Prepared File List</span>
				</button></span>
				</div><br> -->
      <!-- Breadcrumbs-->
      <!-- <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.html">Case Management</a>
        </li>
        <li class="breadcrumb-item active">Create New case</li>
        
      </ol> -->
           
          <div class="row">
	        <div class="col">
	          <!-- Example Bar Chart Card-->
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fa fa-bar-chart"></i>Search For File</div>
	            <div class="card-body">
	              	<!--  The Form starts here -->
	              	<form id="frmFileJobSearch"  method="post">
	
			          <div class="form-group">
			          <label for="">Search Job number</label>
			            <div class="form-row">
			            
			              <div class="col-md-8">
			                
			                <input class="form-control" id="file_search_value"  type="text"  placeholder="Enter search inputs" required >
			              </div>
			              <div class="col-md-4">
			              	
			                <button type="submit" class="btn btn-primary btn-block" value="Search" id="btnFileJobSearch" > Search </button>
			                
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
	        <div class="col">
	          <!-- Example Pie Chart Card-->
	          <!-- <div class="card mb-3">
	            <div class="card-header">
	              <i class="fas fa-pie-chart"></i> File List Preview</div>
	            <div class="card-body">
	            
	            	<form id="frmEnquiryBatchlist"  method="post">
	
			          <div class="form-group">
			          <label for="search_value">File Batch Number &nbsp;</label>
			            <div class="form-row">
			            
			              <div class="col-md-8">
			                
			                <input class="form-control" id="enq_batchlist"  type="text" placeholder="Enter search inputs" required >
			              </div>
			              <div class="col-md-4">
			              	
			                <input type="submit" class="btn btn-primary btn-block" value="Find File list" />  
			                
			              </div>
			            </div>
			          </div>
			        </form>
	            
	          </div>
	              
	        </div> -->
	      <!--   Here is the end of right table -->
      
      
   
      </div>
       
      	  </div>
    
    
    <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3"  id="file-search-results-section">
            <div class="card-header">
                <i class="fa fa-bar-chart"></i>Search Results <span
                    class="col-md-3 float-right ">
                    <button class="btn btn-success btn-icon-split float-right "  id="btnViewFilesList">
                        <span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View Prepared File List</span>
                    </button>
                </span>




            </div>
            <div class="card-body">
            
         
            
	             <!--  Here is where the fee list comes -->
	             
	             <div class="table-responsive" >
			           <table class="table table-bordered " id="file-search-results-table" >
			              <thead>
			                <tr>
			                 <th>Applicant Name</th>
			                  <th>Case Number</th>
			                  <th>Job Number</th>
			                  <th>Application Type</th>
			                  <th>Locality</th>
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
 

<!-- View Batchlist============================= -->
<div class="modal fade" id="viewFileListModal" tabindex="-1"
   role="dialog" aria-labelledby="viewFileListModal" aria-hidden="true">
   <div class="modal-dialog modal-xl">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="">File List Processing</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
         </div>
         <div class="modal-body">
            <form >
               <%-- <input id="bl_modified_by" name="bl_modified_by" type="hidden" value="${fullname}"> 
               <input id="bl_modified_by_id" name="bl_modified_by_id" type="hidden" value="${userid}"> --%>
               <div class="container">
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                     
                     	<div class="form-group row">
							
							<div class="col-sm-4">
							<label class="col-form-label" style="text-align: right"><h2>Batch To :</h2></label>
								<div class="input-group">
									<div id="radioBtnBatching" class="btn-group ">
										<a class="btn btn-primary btn-sm notActive" data-toggle="batch_type" data-title="Unit"><h2>A Unit</h2></a> 
										<a class="btn btn-primary btn-sm notActive" data-toggle="batch_type" data-title="Individual"><h2>An Individual</h2></a>
									</div>
									<input type="hidden" name="batch_type" id="batch_type">
								</div>
							</div>
							<div class="col">
								<div class="form-row" id="unit-batching" style="background-color:#123456; padding:15px; display:none">
									<div class="col-12"><h4 style="" class="text-white">Batching to a Unit</h4></div>
								    <div class="col">
								      <label for="" class="col-form-label">Division :</label>
		                              <select id="unit_division_to_send_to" class="form-control" >
		                                 <option value="none">---Select Division---</option>
		                                <!-- ${division == "CORPORATE" ? "" : "<option value='LVD'>LVD</option>"}
		                                 ${division == "CORPORATE" ? "" : "<option value='LRD'>LRD</option>"}
		                                 ${division == "CORPORATE" ? "" : "<option value='PVLMD'>PVLMD</option>"}
		                                 ${division == "CORPORATE" ? "" : "<option value='SMD'>SMD</option>"}
		                                 ${division == "CORPORATE" ? "" : "<option value='RLO'>RLO</option>"}
										 ${division == "CORPORATE" ? "<option value='CORPORATE'>CORPORATE</option>" : ""} -->
										 <option value='LVD'>LVD</option>
		                                 <option value='LRD'>LRD</option>
		                                 <option value='PVLMD'>PVLMD</option>
		                                <option value='SMD'>SMD</option>
		                                 <option value='RLO'>RLO</option>
										 <option value='CORPORATE'>CORPORATE</option>
		                              </select>
								      
								    </div>
								    <div class="col">
								    <label for="" class="col-form-label">Unit :</label>
								      <input autocomplete="off" class="form-control" id="unit_to_send_to"  type="text"  list="listofunitsbatching" class=""  placeholder="Select/Enter Unit" required  >
		                              <datalist id="listofunitsbatching"></datalist>
								    </div>
								</div>
								
								<div class="form-row"  style="background-color:#654321; padding:15px; display:none" id="individual-batching" >
                                    <div class="col-12"><h5 style="" class="text-white">Batching to an Individual</h5></div>
                                    <div class="col-sm-3">
                                       <label for="" class="col-form-label text-light">Division/Unit :</label>
                                       <!-- <select id="division_to_send_to" class="form-control" >
                                          <option value="none">---Select Division---</option>
                                          <option value="CSAU">CSAU</option>
                                          <option value="LVD">LVD</option>
                                          <option value="LRD">LRD</option>
                                          <option value="PVLMD">PVLMD</option>
                                          <option value="SMD">SMD</option>
                                            <option value="RLO">RLO</option>
                                       </select> -->
                                       <input class="form-control" type="text" value="${unit_name}" id="division_to_send_to" readonly>
                                    </div>
                                    <div class="col-sm-9">
                                       <label for="" class="col-form-label text-light">User :</label>
                                       <!-- <select id="user_to_send_to" class="form-control" >
                                          </select> -->
                                       <input class="form-control" id="user_to_send_to"  name="user_to_send_to" type="text" autocomplete="off" 
                                          list="listofusersbatching" class="autocomplat"  placeholder="Enter Username" required  onmousedown="value = '';" >
                                       <datalist id="listofusersbatching"></datalist>
                                    </div>
                                 </div>
								
								
							  &nbsp;
							</div>
						</div>
                     	
                        
                        
                     </div>
                  </div>
               </div>
               <BR>
               <div class="container">
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                        <table id="FileListdataTable"
                           class="table table-bordered table-hover"></table>
                     </div>
                  </div>
               </div>
               <br> <br> <br>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary d-none"
                     data-dismiss="modal">Close</button>
                  <button type="button" id="btn_process_file_movement_list"  class="btn btn-primary" >Process List</button>
               </div>
            </form>
         </div>
      </div>
   </div>
</div>
 
 
 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>