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
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../includes/_header.jsp"></jsp:include>
  

  <% 


	  
%>

  
  


    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">Corporate Account Management</a>
        </li>
        <li class="breadcrumb-item active">User List</li>
      </ol>
           
           
     
         
         
             
     
     
         <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header bg-dark text-white">
              <i class="fa fa-bar-chart"></i>User Details
              <span class="col-md-3 float-right ">
                <button class="btn btn-success btn-icon-split float-right "  id="addnewuser" data-toggle="modal" data-target="#addupdatecorporateuserdatails">
            <span class="icon text-white-50"> <i class="fas fa-user-plus"></i></span><span class="text">Add New User</span>
          </button></span>
              	<span class="col-md-3 float-right ">
              <button class="btn btn-warning btn-icon-split float-right " style="margin-right: -50px;"  id="addnewuser" data-toggle="modal" data-target="#addupdatecorporatedatails">
					<span class="icon text-white-50"> <i class="fas fa-building"></i></span><span class="text">Add New Organization</span>
				</button></span>
              </div>
              
            <div class="card-body">
            
            <div class="row mb-5 mt-5">
              <div class="col-lg-6">
                <label class="">Select Organiztion:</label>
                <!-- <select class="form-control" id="select_corporate_users" name="">
                  <option value="" disabled selected>-- Select --</option>
                  <option></option>
                </select> -->

                <select class="form-control"  id="select_corporate_users" class="">
                 <option value="-1">-- select --</option>
                                
                  <c:forEach items="${org_list}" var="org">
                    <option  value="${org.emailaddress}">${org.fullname}</option>
                    </c:forEach>
              
                </select>
              </div>
            </div>
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered data-table" id="tbl_corp_user_list_dataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 <th>User Name</th>
                 <th>Full Name</th>
                 <th>Staff Number</th>
                 <th>Designation</th>
                 <th>Org. Name</th>
                 <th >Action</th>
                  <!-- <th>Assign</th> -->
                 <!-- <th>Re-Assign</th> -->
                 </tr>
              </thead>
              
                <tbody>
    
            		
                  <!-- <c:forEach items="${users_list}" var="user">
                <tr ${user.isdisabled = TRUE ? "class='bg-danger text-white red-tooltip' title='Application has pending Objections'  data-toggle='tooltip' data-placement='left' ":""}>
                    
                    <td >${user.username}</td>
                    
                             <fmt:parseNumber var="passwordvaliditydays" integerOnly="true" type="number" value="${user.passwordvaliditydays}" />
                        <fmt:parseNumber var="user_level_single" integerOnly="true" type="number" value="${user.user_level}" />  
                              
                    
                    <td    data-toggle="tooltip" data-placement="top" title="${fn:length(user.fullname) >20 ? user.fullname : ''}"> ${fn:substring(user.fullname, 0, 20)}
                    	${fn:length(user.fullname) >20 ? "..." : ""}
                    </td>
                    
                     <td >${user.staffnumber} </td>
                     <td >${user.designation} </td>
                     
                    <td data-toggle="tooltip" data-placement="top"  title="${fn:length(user.org_name) >20 ? user.org_name : ''}">${fn:substring(user.org_name, 0, 20)} 
                    
                    </td>
                    
                    <td>
                        
                    
                    	<button 
                    		class="btn btn-info btn-icon-split" 
                    		
                    		id="btn_edit_user-${user.username}" 
                    		data-userid="${user.userid}" 
                    		
                    		data-username="${user.username}" 
                    		data-fullname="${user.fullname}"  
                    		data-isdisabled="${user.isdisabled}" 
                    		data-staffnumber="${user.staffnumber}"  
                    		data-title="${user.title}" 
                    		data-designation="${user.designation}" 
                    		data-address="${user.address}" 
                    		data-phone="${user.phone}" 
                    		data-mobile="${user.mobile}" 
                    		data-emailaddress="${user.emailaddress}"  
                    		data-loglocation="${user.loglocation}" 
                    		data-id="${user.id}" 
                    		data-passwordchanged="${user.passwordchanged}"  
                    		data-canpasswordexpire="${user.canpasswordexpire}" 
                    		data-passwordvaliditydays="${passwordvaliditydays}" 
                    		data-passwordexpirydate="${user.passwordexpirydate}" 
                    		data-user_level="${user.user_level}"  
                    		data-org_name="${user.org_name}" 
                    		data-org_id="${user.org_id}" 
                    		data-target="#addupdatecorporateuserdatails" data-toggle="modal" >
                    		<span class="icon text-white-50"> <i class="fas fa-eye"></i></span>
                    		<span class="text">View/Edit</span>
                    	</button>

                    </td>
                    
                    
                    
                        <%--  <td>
                    	<button 
                    		class="btn btn-info btn-icon-split" 
                    		data-title="Delete" 
                    		id="btn_re_assign_user_right-${user.username}" 
                    		data-userid="${user.userid}" 
                    		data-username="${user.username}" 
                    		data-fullname="${user.fullname}"  
                    		data-division="${user.division}" 
                    		data-target="#assignReassignUserProfile" data-toggle="modal" >
                    		<span class="icon text-white-50"> <i class="fas fa-sync-alt"></i></span>
                    		<span class="text">Re-Assign</span>
                    	</button>

                    </td> --%>
                    
                    
                    
                
                
         
                     
                    
                    </tr>
            </c:forEach> -->
            
            
             </tbody>
            
            
            </table>
          </div>
             
              <!--  End Of Table -->
            </div>
            
          </div>
          
     
     
    
       
    
   
        
      </div>
     </div>
    </div>
     
    
    

     
     
     

 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
