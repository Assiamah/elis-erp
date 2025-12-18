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
          <a href="index.jsp">User Account Management</a>
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
              <button class="btn btn-success btn-icon-split float-right "  id="addnewuser" data-toggle="modal" data-target="#addupdateuserdatails">
					<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">Add New User</span>
				</button></span>
              
              </div>
              
            <div class="card-body">
            
         
            
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered data-table" id="tbl_user_list_dataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 <th>User Name</th>
                 <th>Full Name</th>
				 <th>Region</th>
                 <th>Division</th>
                 <th>Unit/Department</th>
                 <th >Edit</th>
                  <th>Template</th>
                 <!-- <th>Milestone</th> -->
                 </tr>
              </thead>
              
                <tbody>
    
            		
                  <c:forEach items="${users_list}" var="user">
                <tr ${user.isdisabled = TRUE ? "class='bg-danger text-white red-tooltip' title='Application has pending Objections'  data-toggle='tooltip' data-placement='left' ":""}>
                    
                    <td >${user.username}</td>
                    
                             <fmt:parseNumber var="passwordvaliditydays" integerOnly="true" type="number" value="${user.passwordvaliditydays}" />
                        <fmt:parseNumber var="user_level_single" integerOnly="true" type="number" value="${user.user_level}" />  
                              
                    
                    <td    data-toggle="tooltip" data-placement="top" title="${fn:length(user.fullname) >20 ? user.fullname : ''}"> ${fn:substring(user.fullname, 0, 20)}
                    	${fn:length(user.fullname) >20 ? "..." : ""}
                    </td>

					<td >${user.region} </td>
                    
                     <td >${user.division} </td>
                     
                    <td data-toggle="tooltip" data-placement="top"  title="${fn:length(user.department) >20 ? user.department : ''}">${fn:substring(user.department, 0, 20)} 
                    	${fn:length(user.unit_name) >20 ? "..." : ""}
                    </td>
                    
                    <td>
                        
                    
                    <button 
                        class="btn btn-info btn-icon-split" 
                        id="btn_edit_user-${user.username}" 
                        data-userid="${user.userid}" 
                        data-username="${user.username}" 
                        data-fullname="${user.fullname}"  
                        data-userprofile="${user.userprofile}" 
                        data-isdisabled="${user.isdisabled}" 
                        data-staffnumber="${user.staffnumber}"  
                        data-title="${user.title}" 
                        data-designation="${user.designation}" 
                        data-division="${user.division}"  
                        data-address="${user.address}" 
                        data-phone="${user.phone}" 
                        data-mobile="${user.mobile}" 
                        data-emailaddress="${user.emailaddress}"  
                        data-department="${user.department}" 
                        data-department_id="${user.department_code}"
                        data-department_name="${user.department}"
                        data-district="${user.district}"
                        data-district_code="${user.regional_code}"
                        data-district_name="${user.regional_name}"
                        data-region="${user.region}"
                        data-region_id="${user.region_id}"
                        data-id="${user.id}" 
                        data-passwordchanged="${user.passwordchanged}"  
                        data-canpasswordexpire="${user.canpasswordexpire}" 
                        data-passwordvaliditydays="${passwordvaliditydays}" 
                        data-passwordexpirydate="${user.passwordexpirydate}" 
                        data-user_level="${user.user_level}"
                        data-usr_access_level="${user.usr_access_level}"
                        data-view_all_offices="${user.view_all_offices}"
                        data-target="#addupdateuserdatails" 
                        data-toggle="modal">
                        <span class="icon text-white-50"><i class="fas fa-eye"></i></span>
                        <span class="text">View/Edit</span>
                    </button>

                    </td>
                    
                    
                       <td>
                    	<button 
                    		class="btn btn-danger btn-icon-split" 
                    		data-title="Delete" 
                    		id="btn_assign_user_right-${user.username}" 
                    		data-userid="${user.userid}" 
                    		data-username="${user.username}" 
                    		data-fullname="${user.fullname}"  
                    		data-division="${user.division}" 
                    		data-target="#assignReassignUserProfile" data-toggle="modal" >
                    		<span class="icon text-white-50"> <i class="fas fa-plus"></i></span>
                    		<span class="text">Assign</span>
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
                    
					  <!-- <td>
                    	<button 
                    		class="btn btn-success btn-icon-split" 
                    		data-title="Delete" 
                    		id="btn_re_assign_user_right-${user.username}" 
                    		data-userid="${user.userid}" 
                    		data-username="${user.username}" 
                    		data-fullname="${user.fullname}"  
                    		data-division="${user.division}" 
                    		data-target="#assignMilestoneUserProfile" data-toggle="modal" >
                    		<span class="icon text-white-50"> <i class="fas fa-check-circle"></i></span>
                    		<span class="text">Assign</span>
                    	</button>

                    </td>  -->
                    
                
                
         
                     
                    
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
  