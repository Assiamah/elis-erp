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
      <ol class="breadcrumb ">
        <li class="breadcrumb-item">
          <a href="#">Transaction Approval Management</a>
        </li>
        <li class="breadcrumb-item active">All Transaction Approval by ${fullname}</li>
        
      </ol>
          
           
       <!--      <div class="row">
        <div class="panel-body-map">
                <div id="map" style="height:380px;"></div>
                
              </div>
              
              
                </div>
        -->
       
         
         
         
             
     
     
         <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header bg-dark text-white">

              
              </div>
              
            <div class="card-body">
            
             
             <div class="table-responsive">
           <table class="table table-bordered table-hover " id="job_batchedtouserlistdataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                <!-- <th><input type="checkbox" id="selectAll"/></th>  -->
                <!-- <th>Created Date</th> -->
                 <th>Job Number</th>
                 <th>Application Type</th>
                 <th>Transaction Details</th>
               <!--   <th style="display:none">Status</th> -->
                 <!-- <th>Created On</th>  -->
                
           
                  <th>Approve</th>
                 
                 
                 
                 </tr>
              </thead>
              
                <tbody>
    
            		
                   <c:forEach items="${transactionlist}" var="appfiles">
                <tr ${appfiles.objections > 0 ? "class='bg-danger text-white red-tooltip' title='Application has pending Objections'  data-toggle='tooltip' data-placement='left' ":""}>
                    
                    <!-- <td><input type="checkbox" /></td> -->
                    <!-- <td >${appfiles.created_date}</td> -->
                     <td >${appfiles.job_number}</td>

                  
                     <td >${appfiles.business_process_sub_name}</td>

                     <td   data-toggle="tooltip" data-placement="top" title="${fn:length(appfiles.transaction_details) >20 ? appfiles.transaction_details : ''}"> ${fn:substring(appfiles.transaction_details, 0, 20)}
                    	${fn:length(appfiles.transaction_details) >20 ? "..." : ""}
                    </td>
                
             
                        <td>
                          <button 
                            class="btn btn-info btn-icon-split" 
                            data-title="Delete" 
                            id="btnAddToBatchlist-${appfiles.job_number}" 
                            data-job_number="${appfiles.job_number}" 
                            data-case_number="${appfiles.case_number}"
                            data-ta_id="${appfiles.ta_id}"   
                            data-type_of_transaction="${appfiles.type_of_transaction}"  
                            data-transaction_details="${appfiles.transaction_details}"  
                            data-approval_status="${appfiles.approval_status}"  
                            data-business_process_name="${appfiles.business_process_name}"
                            data-business_process_sub_name="${appfiles.business_process_sub_name}" 
                            data-target="#final_registration_approval_dialog" data-toggle="modal" >
                            <span class="icon text-white-50"> <i class="fas fa-list"></i></span>
                            <span class="text">Approve</span>
                          </button>
                          
                          
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
  
