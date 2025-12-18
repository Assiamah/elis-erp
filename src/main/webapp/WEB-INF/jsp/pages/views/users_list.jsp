<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
  <jsp:include page="../includes/_header.jsp"></jsp:include>
 
  <% 
String id =request.getParameter("cafeId");
System.out.println("working " + id);
%>
 
<script>
	function editRecord(id){
		window.location.href="./user_management/edit.jsp?id="+id;
	}
	function deleteThis(){
		
		var values;
		values = document.getElementsByName("rdValues");
		var selVal="";
		for(var c=0;c<values.length;c++){
			if(values[c].checked == true){
				selVal+=values[c].value;
			break;		
			}
		}
		window.location.href="delete.jsp?userid="+selVal;
		
	}
	</script>
 
 <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="#">System Administration</a>
        </li>
        <li class="breadcrumb-item active">List of Users</li>
      </ol>
      <!-- Icon Cards-->
      <div class="row">
        <div class="col-xl-3 col-sm-6 mb-3">
          <div class="card text-white bg-primary o-hidden h-100">
            <div class="card-body">
              <div class="card-body-icon">
                <i class="fa fa-fw fa-comments"></i>
              </div>
              <div class="mr-5">26 New Messages!</div>
            </div>
            <a class="card-footer text-white clearfix small z-1" href="#">
              <span class="float-left">View Details</span>
              <span class="float-right">
                <i class="fa fa-angle-right"></i>
              </span>
            </a>
          </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-3">
          <div class="card text-white bg-warning o-hidden h-100">
            <div class="card-body">
              <div class="card-body-icon">
                <i class="fa fa-fw fa-list"></i>
              </div>
              <div class="mr-5">11 New Tasks!</div>
            </div>
            <a class="card-footer text-white clearfix small z-1" href="#">
              <span class="float-left">View Details</span>
              <span class="float-right">
                <i class="fa fa-angle-right"></i>
              </span>
            </a>
          </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-3">
          <div class="card text-white bg-success o-hidden h-100">
            <div class="card-body">
              <div class="card-body-icon">
                <i class="fa fa-fw fa-shopping-cart"></i>
              </div>
              <div class="mr-5">123 New Orders!</div>
            </div>
            <a class="card-footer text-white clearfix small z-1" href="#">
              <span class="float-left">View Details</span>
              <span class="float-right">
                <i class="fa fa-angle-right"></i>
              </span>
            </a>
          </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-3">
          <div class="card text-white bg-danger o-hidden h-100">
            <div class="card-body">
              <div class="card-body-icon">
                <i class="fa fa-fw fa-support"></i>
              </div>
              <div class="mr-5">13 New Tickets!</div>
            </div>
            <a class="card-footer text-white clearfix small z-1" href="#">
              <span class="float-left">View Details</span>
              <span class="float-right">
                <i class="fa fa-angle-right"></i>
              </span>
            </a>
            
            
            
            
            
            
          </div>
        </div>
      </div>
     
  
    <!-- /.container-fluid-->
    <!-- /.content-wrapper-->
      
      
                  <!-- Example DataTables Card-->
      <div class="card mb-3">
        <div class="card-header">
          <i class="fa fa-table"></i> List of Users on the System
          <button type="button" class="btn btn-xs  btn-primary" data-toggle="modal" data-target="#myModal" />Add</button> 
          
          <button type="button" class="btn btn-xs  btn-primary" data-toggle="modal" data-target="#requestModal" />Form</button> 
          
          
          <form action="${pageContext.request.contextPath}/ReportServlet">
            <button type="submit" class="btn btn-xs  btn-primary"/>Generate PDF report</button> 
          </form>
        
          </div>
        <div class="card-body">
          <div class="table-responsive">
           <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
              <thead>
                <tr>
                 <th>uid</th>
                  <th>user_name</th>
                  <th>Gender</th>
                  <th>Password</th>
                  <th>Edit</th>
                  <th>User profile</th>
                  <th>Delete</th>
                 </tr>
              </thead>
              <tfoot>
                <tr>
                  <th>uid</th>
                  <th>User Name</th>
                  <th>Gender</th>
                  <th>Password</th>
                  <th>Edit</th>
                  <th>User Profile</th>
                  <th>Delete</th>
                </tr>
              </tfoot>
             <tbody>
                 <c:forEach var="user" items="${users_list}">
				       <tr>
				             <td>${user.userid}</td>
				             <td>${user.username}</td>
				             <td>${user.fullname}</td>
				              <td>${user.password}</td>
				            
                             <td>
                              <button type="button" class="btn btn-xs  btn-primary" data-toggle="modal" data-target="#updateModal" data-id="${user.userid}"  <c:set var="id" value="${user.userid}" />>Edit</button> 
                             </td>
                             
                              <td>
                              
                              
                               <%-- <button type="button" class="btn btn-xs  btn-primary" data-toggle="modal" data-target="#UserProfileModal" data-id="${user.uid}"  <c:set var="id" value="${user.uid}" />>User Profile</button> 
                              --%>
                                    <form action="" method="get">
						             <input type="hidden" name="cafeId" id="cafeId" value="${user.userid}"/>
						            <button type="submit" class="btn btn-xs  btn-primary"/>Allow Edit</button> 
						          </form>
                               <button class="btn btn-xs  btn-primary" data-toggle='modal' data-target='#updateModal'>Details</button>
                              
                             </td>
                              
                             <td>                   
         						<%-- <button type="button" class="btn btn-xs  btn-primary" name="edit" value="edit"  data-toggle="modal" data-target="#UserProfileModal" onclick="editRecord(${user.uid});"/>Details</button> 
         						 --%>
         						
         						 <form method="POST" action="${pageContext.request.contextPath}/Update_User">
         						 <input type="hidden" name="new_id" value="${user.userid}">
                                 <button type="submit" class="btn btn-xs  btn-primary"/>Generate PDF report</button> 
                                 </form>
                             </td>     
				          
				          </tr>
			     </c:forEach>
              </tbody> 
            </table>
          </div>
        </div>
        <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
      </div>
      
          
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog ">
    <div class="modal-content">
      <div class="modal-header" id="bg">Add New User</h4>
      </div>
      <div class="modal-body" id="bg">
     <form method="POST" action="${pageContext.request.contextPath}/Save_User"> 
          
          <div class="row">
            <div class="col-md-12">
              <div class="form-group">
                <div class="row">
                	<div class="col-md-6">
                		<label for="username">User Name</label>
                		<input type="text" class="form-control input-sm" id="username" placeholder="Enter username &hellip;" name="username">
                	</div>
                	<div class="col-md-6">
                		<label for="password">Password</label>
                		<input type="text" class="form-control input-sm" id="password" placeholder="Enter password &hellip;" name="password">
                	</div>
                </div>
            </div>
            
            	
            
            <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="gender">Gender</label>
                        <select name="gender" class="form-control input-sm">
                          <option value="Male">Male</option>
                          <option value="Female">Female</option>
                      </select>
            </div>
           </div>
          </div>
          
         <div class="well modal-footer" id="bg">
            <input type="submit" class="btn btn-xs  btn-primary" name="submit" value="Add User" />
        </div>
            </div>
          </div>
                   
        </form>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
    
    
    
    <!-- for the update modal -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
  <div class="modal-dialog ">
    <div class="modal-content">
    
  			<%--  <jsp:include page="../user_management/edit.jsp"><jsp:param name="id" value="${id}" /></jsp:include> --%>
  			 
  			  <jsp:include page="../client_application/regional_number_modal.jsp"> <jsp:param name="cafeId"  value="<%= id %>"/></jsp:include>
    
    </div>
  </div>
</div>



   <!-- for the update modal -->
<div class="modal fade" id="requestModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
  <div class="modal-dialog ">
    <div class="modal-content">
    
<%--   			 <jsp:include page="../user_management/application_form.jsp"><jsp:param name="id" value="${id}" /></jsp:include>
 --%>    
    </div>
  </div>
</div>


  <jsp:include page="../includes/_footer.jsp"></jsp:include>
