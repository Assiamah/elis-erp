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
      <ol class="breadcrumb ">
        <li class="breadcrumb-item">
          <a href="#">Staff Case Management</a>
        </li>
        <li class="breadcrumb-item active">All applications batched to ${fullname}</li>
        
      </ol>
          
           
       <!--      <div class="row">
        <div class="panel-body-map">
                <div id="map" style="height:380px;"></div>
                
              </div>
              
              
                </div>
        -->
         <%-- <div class="row">
          <!--   Here is the right Table -->
        <div class="col">
          <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header bg-dark text-white">
              <i class="fas fa-users"></i>LC Officers list</div>
            <div class="card-body">
               <!--  The Form starts here -->
              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">

		      
          
          
            <div class="form-group">
          <label for="main_service">Officers</label>
                
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
        <div class="col">
          <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header bg-dark text-white">
              <i class="fas fa-search"></i> Search By Job Number</div>
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
      
      
       
      
      
      
    </div> --%>
    
<!--          </div> -->
         
         
         
         
             
     
     
         <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header bg-dark text-white">
            <%--   <button class="btn btn-info btn-icon-split" id="btnViewApplicationsList">
              	<span class="icon text-white-50"> <i class="fas fa-list"></i></span>
              	<span class="text"> (Click to load) Total Application in account <span class="badge text-danger"> ${applicationlistcount}</span></span>
              </button> --%>
              <span class="col-auto float-right ">
               
              	<button class="btn btn-success btn-icon-split float-right "  id="btnViewCompetedQueriedList">
					<span class="icon text-white-50"> <i class="fas fa-eye"></i></span>
					<span class="text">View Completed/Queried List</span>
				</button>
			  </span>
				
				
				
              
              </div>
              
            <div class="card-body">
             <!--<div class="row">
            	<div class="col-sm-6 form-row">
            		<div class="col-sm-6">
            			<label for="search_btn">Purpose</label> 
            			<input type="text" class="form-control col" id="txt_general_job_purpose"  value="" placeholder="Purpose for Bactching" /> 
	            	</div>
	            	<div class="col-sm-6">
	            	<label for="search_btn">&nbsp;</label> 
	            		<button class="btn btn-primary btn-icon-split"  id="btnAddAlltoBatchlist">
							<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text">Add All to Batch List</span>
						</button>
	            	</div>
            	</div>
            	<div class="col-sm-6">
            	 &nbsp;
            	</div>
            	
            </div><br><br> -->
         	    
            
				
				
				
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered table-hover " id="job_batchedtouserlistdataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                <th><input type="checkbox" id="selectAll"/></th> 
                 <th>Job Number</th>
                 <th>Applicant Name</th>
                 <th>Application Type</th>
               <!--   <th style="display:none">Status</th> -->
                 <!-- <th>Created On</th>  -->
                
                 <th>Status</th>
                 <th>Date Received</th>
                 <th>Sent By</th>
                
                 <!-- <th >Add to BatchList</th> -->
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
                <tr ${appfiles.objections > 0 ? "class='bg-danger text-white red-tooltip' title='Application has pending Objections'  data-toggle='tooltip' data-placement='left' ":""}>
                    
                    <td><input type="checkbox" /><%-- ${appfiles.index + 1} --%></td>
                    <td >${appfiles.job_number}</td>
                    

                    <td    data-toggle="tooltip" data-placement="top" title="${fn:length(appfiles.ar_name) >20 ? appfiles.ar_name : ''}"> ${fn:substring(appfiles.ar_name, 0, 20)}
                    	${fn:length(appfiles.ar_name) >20 ? "..." : ""}
                    </td>
                    
                     <td >${appfiles.business_process_sub_name}</td>
                    <%--  <td >${appfiles.created_date}</td> --%>
                     
                    <td data-toggle="tooltip" data-placement="top"  title="${fn:length(appfiles.current_application_status) >20 ? appfiles.current_application_status : ''}">${fn:substring(appfiles.current_application_status, 0, 20)} 
                    	${fn:length(appfiles.current_application_status) >20 ? "..." : ""}
                    </td>
                    
                      <td >${appfiles.job_datesend}</td>
                      
                        <td >${appfiles.job_forwarded_by}</td>
                    
                <%--     <td>
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
                    	
                    	
                    </td> --%>
                
                
               <%--     <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details" method="post"><input type="hidden" name="case_number" id="case_number" value="${appfiles.case_number}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                    
                      <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"  target="_blank"><input type="hidden" name="case_number" id="case_number" value="${appfiles.case_number}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                    
                 	 --%>
                    
                    <td>
						<form action="registration_application_progress_details_simple" method="post">
							<input type="hidden" name="case_number" id="case_number" value="${appfiles.case_number}">
							<input type="hidden" name="transaction_number" id="transaction_number" value="${appfiles.transaction_number}">
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
     
    
    

     
     
     

 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
