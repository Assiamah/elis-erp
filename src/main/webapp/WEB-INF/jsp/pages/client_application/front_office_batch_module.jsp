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


  <jsp:include page="../includes/_header.jsp"></jsp:include>
  

  <% 


	  
%>

  
  


    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">App Database Update</a>
        </li>
        <li class="breadcrumb-item active">Process batch List</li>
      </ol>
           
           
       <!--      <div class="row">
        <div class="panel-body-map">
                <div id="map" style="height:380px;"></div>
                
              </div>
              
              
                </div>
        -->
         <div class="row">
          <!--   Here is the right Table -->
        <div class="col-lg-4">
          <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i> Processing After Payment</div>
            <div class="card-body">
               <!--  The Form starts here -->
              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">

		      
          
          
            <div class="form-group">
          <label for="main_service">User Service</label>
                
                    <input class="form-control" id="user_to_send_to"  name="user_to_send_to"  type="text" aria-describedby="nameHelp" list="listofusers"  class="autocomplat" placeholder="Enter Username" required >
                <datalist id="listofusers">
			
                  <c:forEach items="${userlist}" var="user">
                    <option data-value="${user.userid}" value="${user.fullname}"></option>
                 </c:forEach>
          
               </datalist>
                
                
              
 
			
          </div>
          
          
        </form>
        
        
        
        
      
            
            <!-- The form Ends Hers -->
            
          </div>
         
        </div>
      <!--   Here is the end of right table -->
  
      </div>
      
      
        <!--   Here is the right Table -->
        <div class="col-lg-4">
          <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i> Search By Case Number</div>
            <div class="card-body">
               <!--  The Form starts here -->
              <form action="${pageContext.request.contextPath}/download_pdf"  method="post">

		          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="job_number">Job Number</label>
                <input class="form-control" id="job_number"  name="job_number"  type="text" aria-describedby="nameHelp" placeholder="Enter Job Number" required >
              </div>
              <div class="col-md-6">
              <label for="search_btn">-</label>
                <input type="button" id="btnjob_numbersearch" class="btn btn-primary btn-block" value="Search" />  
               
                </div>
            </div>
          </div>
        </form>
            
            <!-- The form Ends Hers -->
            
          </div>
         
        </div>
      <!--   Here is the end of right table -->
  
      </div>
      
      
       <!--   Here is the right Table -->
        <div class="col-lg-4">
          <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i> Instructions on Web Portal</div>
            <div class="card-body">
            
          <form method="POST" action="GenerateCaseReports" target="_blank" id="downloadForm">
			    <input type="hidden" name="request_type" id="request_type">
			    <input type="hidden" name="list_of_application" id="list_of_application">
			    <input type="hidden" name="batch_number" id="batch_number">
			    
			    

			</form>
			
          </div>
              
        </div>
      <!--   Here is the end of right table -->
  
      </div>
      
      
      
    </div>
    
<!--          </div> -->
         
         
         
         
             
     
     
         <div class="row">
     <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Application Details</div>
            <div class="card-body">
            
         
            
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered" id="job_detailsdataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                 
                 <th>Job Number</th>
                 <th>Applicant Name</th>
               <!--   <th style="display:none">Status</th> -->
                 <!-- <th>Status</th> -->
                
                 <th>Milestones</th>
                 <th>Case Number</th>
                 <th>Batch</th>
                 <th>Work</th>
                 
                 
                 
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
                <tr>
                    <td>${appfiles.job_number}</td>
                    <td>${appfiles.ar_name}</td>
                    <td>${appfiles.current_application_status}</td>
                    <td>${appfiles.case_number}</td>
                    <td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${appfiles.job_number}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Batch</span></button></p></td>
                
                
                <%--    <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details" method="post"><input type="hidden" name="case_number" id="case_number" value="${appfiles.case_number}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                 --%>    
                  <%--     <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"  target="_blank"><input type="hidden" name="case_number" id="case_number" value="${appfiles.case_number}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                    
                  --%>	
                    
                    <td>
						<form action="registration_application_progress_details" method="post">
							<input type="hidden" name="case_number" id="case_number" value="${appfiles.case_number}">
							<input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}">
							<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="${appfiles.business_process_sub_name}">
							
								<button type="submit" name="save" class="btn btn-info btn-icon-split" >
								<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>
								</button>
						</form>
					</td>
                     
                    
                    </tr>
            </c:forEach>
            
            
             </tbody>
            
            
            </table>
          </div>
             
              <!--  End Of Table -->
            </div>
            
          </div>
          
     
     
    
       
    
   
        
      </div>
     </div>
     
    
    
                 
    <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Batch List</div>
            <div class="card-body">
            
         
          <form action="${pageContext.request.contextPath}/#"  method="post" target="_blank">

		     <div class="form-group">
            <div class="form-row">
              <div class="col-md-2">
                
                <input type="button" id="btnclearlist" class="btn btn-primary btn-block" value="Clear List" />  
              </div>
              <div class="col-md-2">
             
                <input type="button" id="btnprocessbatchlis" class="btn btn-primary btn-block" value="Process Batch" />  
               
                </div> 
            </div>
          </div>
        </form>
         
            
             <!--  Here is where the fee list comes -->
             
             
             <div class="table-responsive">
           <table class="table table-bordered" id="batchlistdataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>
               
          <!--      style="display:none" -->
               
               <th data-field="jn_id" data-align="center" data-sortable="true" >jn_id</th>
               <th data-field="mss_id" data-align="center" data-sortable="true" >mss_id</th>
               <th data-field="job_number" data-align="center" data-sortable="true">Job Number</th>
               <th data-field="ar_name" data-align="center" data-sortable="true">Applicant Name</th>
               <th data-field="business_process_sub_name" data-align="center" data-sortable="true">Application Type</th>
               <th data-field="job_purpose" data-align="center" data-sortable="true">Job Purpose</th>
               <th data-field="job_status" data-align="center" data-sortable="true">Job Status</th>
               <th data-field="send_by_id" data-align="center" data-sortable="true" >send_by_id</th>
               <th data-field="send_by_name" data-align="center" data-sortable="true" >send_by_name</th>
               <th data-field="userid" data-align="center" data-sortable="true">userid</th>
                <th data-field="remove" data-align="center" data-sortable="true">Remove</th>
                
              
                
             <!--     <th>jn_id</th>
                 <th>mss_id</th>
                  <th>job_number</th>
                  <th>ar_name</th>
                   <th>business_process_sub_name</th>
                  
                  <th>job_purpose</th>
                <th>job_status</th>
                <th>send_by_id</th>
                <th>send_by_name</th>
                  <th>userid</th>     
                  <th>remove</th> -->
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
  
