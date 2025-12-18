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
  

    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">Title Plan Update SMD</a>
        </li>
        <li class="breadcrumb-item active">Process batch List</li>
      </ol>
           
        
				               <div class="form-group">
								<!-- <label for="main_service">Main Service</label> -->
								<input placeholder="Job Number" id="scm_job_number_search_plan_smd" class="form-control input-sm" data-style="btn-info" type="text" />
									
									
							</div>
							<div class="form-group">
								<div class="form-row">
									<div class="col">
										<button class="btn btn-secondary btn-icon-split float-left " id="btn_scm_job_number_search_plan_smd" data-backdrop="static" data-keyboard="false" >
												<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text"> Search </span>
											</button>
										
									</div>
									<div class="col">
										<!-- <button class="btn btn-success btn-icon-split float-right  btn-lg" id="btnFindClientDetails"  >
												<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">Search </span>
											</button>
											 -->
											
											
									</div>
								</div>
								
									
							</div>
     
         <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header bg-dark text-white">
              <i class="fa fa-bar-chart"></i>Application Details
              	<span class="col-md-3 float-right ">
              <button class="btn btn-success btn-icon-split float-right "  id="btnViewBatchlist">
					<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View Batch List</span>
				</button></span>
              
              </div>
              
            <div class="card-body">
            
         
            
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered data-table" id="tbl_search_for_job_details_datatable_smd" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                 
                 <th>Job Number</th>
                 <th>Applicant Name</th>
                 <th>Application Type</th>
               <!--   <th style="display:none">Status</th> -->
                 <!-- <th>Status</th> -->
                
                 <th>Status</th>
                
                 <th >Add to BatchList</th>
                  <th>Work</th>
              
                 
                 
            
                 
                 </tr>
              </thead>
              
                <tbody>
    
            		
             </tbody>
            
            
            </table>
          </div>
             
              <!--  End Of Table -->
            </div>
            
          </div>
          

        
      </div>
     </div>
     
    
    

     
     
     

 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
