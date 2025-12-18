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
          <a href="">TPP Coordinator Management</a>
        </li>
        <li class="breadcrumb-item active">${unit_name}</li>
      </ol>
           
           
       
         
            <!-- Content Row -->
          <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-2 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2"  id="body-dg-1">
                <div class="card-body">
                <a href="#"  class="text-decoration-none btnLoadUnitApplicationsTpp" data-id="1">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Incoming Files</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"  id="number-text-1">${incoming}</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-sign-in-alt fa-2x text-gray-300"></i>
                    </div>
                  </div>
                  </a>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-2 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2"  id="body-dg-2">
                <div class="card-body">
                 <a href="#"  class="text-decoration-none btnLoadUnitApplicationsTpp" data-id="2">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Completed within unit</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"  id="number-text-2">${completed}</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-check-double fa-2x text-gray-300"></i>
                    </div>
                  </div>
                  </a>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-2 col-md-3 mb-4">
              <div class="card border-left-info shadow h-100 py-2"  id="body-dg-3">
                <div class="card-body">
                <a href="#"  class="text-decoration-none btnLoadUnitApplicationsTpp" data-id="3"> 
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Awaiting Title Plans</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" id="number-text-3">${awaiting_tpp}</div>
                        </div>
                        
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-map fa-2x text-gray-300"></i>
                    </div>
                  </div>
                  </a>
                </div>
              </div>
            </div>
            
            
               <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-2 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2"  id="body-dg-5">
                <div class="card-body">
                <a href="#"  class="text-decoration-none btnLoadUnitApplicationsTpp" data-id="5"> 
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Awaiting Signing</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" id="number-text-5">${awaiting_signing}</div>
                        </div>
                        <!-- <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                        </div> -->
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-tasks fa-2x text-gray-300"></i>
                    </div>
                  </div>
                  </a>
                </div>
              </div>
            </div>
            
            
            
            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-2 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2"  id="body-dg-7">
                <div class="card-body">
                <a href="#"  class="text-decoration-none btnLoadUnitApplicationsTpp" data-id="7"> 
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Waiting for Sealing and Scanning</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" id="number-text-7">${awaiting_scanning}</div>
                        </div>
                        <!-- <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                        </div> -->
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-tasks fa-2x text-gray-300"></i>
                    </div>
                  </div>
                  </a>
                </div>
              </div>
            </div>
            
            
          
            
                    <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-2 col-md-6 mb-4">
              <div class="card border-left-danger shadow h-100 py-2"  id="body-dg-4">
                <div class="card-body">
                <a href="#"  class="text-decoration-none btnLoadUnitApplicationsTpp" data-id="4"> 
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Queried</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" id="number-text-4">${queried}</div>
                        </div>
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
                  </div>
                  </a>
                </div>
              </div>
            </div>
            
            
          

           
          </div>

          <!-- Content Row -->
             
     
     
         <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header bg-dark text-white">
              <i class="fa fa-bar-chart"></i>Application Details
              	<span class="col-md-3 float-right ">
              <button class="btn btn-success btn-icon-split float-right show-for-tab-2" style="display:none" id="btnViewBatchlist" style="display:none">
					<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View Batch List</span>
				</button></span>
				
				
				
              
              </div>
              
            <div class="card-body">
            
         
           <div class="row">
            	<div class="col-sm-12 form-row">
            		<div class="col-sm-4 show-for-tab-2" style="display:none">
            			<!-- <label for="search_btn">Purpose</label>  -->
            			<input type="text" class="form-control col" id="txt_general_job_purpose"  value="" placeholder="Purpose for Batching" /> 
	            	</div>
	            	<div class="col-sm-4 show-for-tab-2" style="display:none" >
	            	<label for="search_btn">&nbsp;</label> 
	            		<button class="btn btn-primary btn-icon-split "  id="btnAddAlltoBatchlist">
							<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text">Add all to Batchlist</span>
						</button>
	            	</div>
	            	<div class="col-sm-4 show-for-tab-1" style="display:none">
	            	<label for="search_btn">&nbsp;</label> 
	            		<button class="btn btn-primary btn-icon-split"  id="btnSendAllForTpp">
							<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text">Move Selected for Title Plan Preparation</span>
						</button>
	            	</div>
	            	<div class="col-sm-4 show-for-tab-2" style="display:none">
	            	<label for="search_btn">&nbsp;</label> 
	            		<button class="btn btn-danger btn-icon-split"  id="btnAddAlltofinishedList">
							<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text">Finish TPP Step for Selected</span>
						</button>
	            	</div>
            	</div>
            	<div class="col-sm-6">
            	 &nbsp;
            	</div>
            	
            </div><br><br>
                
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered table-hover" id="job_casemgtdetailsdataTable_tpp" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 <th style="">&nbsp;</th>
                 <th><input type="checkbox" id="selectAll"/></th>
                 
                 <th>Job Number</th>
                 <th>Applicant Name</th>
                 <th>Application Type</th>
               <!--   <th style="display:none">Status</th> -->
                 <th>Received By</th> 
                <th>Date Received</th>
                 
                
                 <!-- <th >Add to BatchList</th>
                 <th>View</th> -->
                 <th class="to_hide_on_level_1">View</th>
                 
                 
                 
                 
                 <!-- 	<th data-field="customer.name" data-align="center" data-sortable="true">customer</th>
                    <th data-field="type" data-align="center" data-sortable="true">type</th>
                    <th data-field="description" data-align="center" data-sortable="true">description</th>
                    <th data-field="cutter" data-align="center" data-sortable="true">cutter</th> 
                    <th data-field="valid_s" data-align="center" data-sortable="true">valid</th>
                  -->
                 
                 </tr>
              </thead>
              
                <tbody>
    
            		
                 <%--  <c:forEach items="${applicationlist}" var="appfiles">
                <tr ${appfiles.objections > 0 ? "class='bg-danger text-white red-tooltip' title='Application has pending Objections'  data-toggle='tooltip' data-placement='left' ":""}>
                    
                    <td><input type="checkbox" />${applicationLoop.index + 1}</td>
                    <td >${appfiles.job_number}</td>
                    
                    
                    
                    
                    <td    data-toggle="tooltip" data-placement="top" title="${fn:length(appfiles.ar_name) >20 ? appfiles.ar_name : ''}"> ${fn:substring(appfiles.ar_name, 0, 20)}
                    	${fn:length(appfiles.ar_name) >20 ? "..." : ""}
                    </td>
                    
                     <td >${appfiles.business_process_sub_name}</td>
                     
                    <td data-toggle="tooltip" data-placement="top"  title="${fn:length(appfiles.current_application_status) >20 ? appfiles.current_application_status : ''}">${fn:substring(appfiles.current_application_status, 0, 20)} 
                    	${fn:length(appfiles.current_application_status) >20 ? "..." : ""}
                    </td>
                    
                    <td>
                    	<button 
                    		class="btn btn-info btn-icon-split" 
                    		data-title="Delete" 
                    		id="btnAddToBatchlist-${appfiles.job_number}" 
                    		data-job_number="${appfiles.job_number}" 
                    		data-ar_name="${appfiles.ar_name}"  
                    		data-business_process_sub_name="${appfiles.business_process_sub_name}" 
                    		data-target="#askForPurposeOfBatching" data-toggle="modal" >
                    		<span class="icon text-white-50"> <i class="fas fa-list"></i></span>
                    		<span class="text">Add to Batch</span>
                    	</button>
                    	
                    	
                    </td>
                
                
                   <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details" method="post"><input type="hidden" name="case_number" id="case_number" value="${appfiles.case_number}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                    
                      <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"  target="_blank"><input type="hidden" name="case_number" id="case_number" value="${appfiles.case_number}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                    
                 	
                    
                    <td>
						<form action="registration_application_progress_details" method="post">
							<input type="hidden" name="case_number" id="case_number" value="${appfiles.transaction_number}">
							<input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}">
							<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="${appfiles.business_process_sub_name}">
							
								<button type="submit" name="save" class="btn btn-info btn-icon-split" >
								<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>
								</button>
						</form>
						
					</td>
                     
                    
                    </tr>
            </c:forEach> --%>
            
            
             </tbody>
            
            
            </table>
          </div>
             
              <!--  End Of Table -->
            </div>
            
          </div>
          
     
     
    
       
    
   
        
      </div>
     </div>
     
    
    
<!-- Assign Inspection ============================ -->
<div class="modal fade" id="viewRecordsInfoModal" tabindex="-1"
	role="dialog" aria-labelledby="viewRecordsInfoModal" aria-hidden="true"
>
	<div class="modal-dialog ">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="viewBatchlistModalLabel">View Records Information for <b><span id="notes_job_number_label"></span></b></h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" id="note_records_section">
				<div id="accordion">
				  <!-- <div class="card">
				    <div class="card-header" id="headingOne">
				      <h5 class="mb-0">
				        <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
				          SMD by MHAMMED ADBULLA on 12-04-2020
				        </button>
				      </h5>
				    </div>
				
				    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
				      <div class="card-body">
				        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
				      </div>
				    </div>
				  </div> -->
				  <!-- <div class="card">
				    <div class="card-header" id="headingTwo">
				      <h5 class="mb-0">
				        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
				          PVLMD by JAMES MONA on 12-04-2020
				        </button>
				      </h5>
				    </div>
				    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
				      <div class="card-body">
				        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
				      </div>
				    </div>
				  </div> -->
				  <!-- <div class="card">
				    <div class="card-header" id="headingThree">
				      <h5 class="mb-0">
				        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
				          LVD by SOM NAME on 12-04-2020
				        </button>
				      </h5>
				    </div>
				    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
				      <div class="card-body">
				        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
				      </div>
				    </div>
				  </div> -->
				</div>
			</div>
		</div>
	</div>
</div>
     
     
     

 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
