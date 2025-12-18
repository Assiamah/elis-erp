<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- <%@ page import="com.report_class.cls_reports" %> --%>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<jsp:include page="../includes/_header.jsp"></jsp:include>
<jsp:useBean id="now" class="java.util.Date" />


<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-4 text-gray-800">Ticket Management</h1>
	
	 <!-- Summary -->
      <div class="row">
        <!-- Urgent -->
          <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-danger shadow h-100 py-2">
             <div class="card-body">
             	<div class="row no-gutters align-items-center">
                   <div class="col mr-2">
                   	<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                         High</div>
                     <div class="h5 mb-0 font-weight-bold text-gray-800">12</div>
                    </div>
                    <div class="col-auto">
                       <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                 </div>
              </div>
             </div>
            </div>
            
            <!-- Medium -->
          <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
             <div class="card-body">
             	<div class="row no-gutters align-items-center">
                   <div class="col mr-2">
                   	<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                          Medium</div>
                     <div class="h5 mb-0 font-weight-bold text-gray-800">14</div>
                    </div>
                    <div class="col-auto">
                       <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                 </div>
              </div>
             </div>
            </div>
            
            <!-- Low -->
          <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
             <div class="card-body">
             	<div class="row no-gutters align-items-center">
                   <div class="col mr-2">
                   	<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                          Low</div>
                     <div class="h5 mb-0 font-weight-bold text-gray-800">5</div>
                    </div>
                    <div class="col-auto">
                       <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                 </div>
              </div>
             </div>
            </div>
            
            <!-- Urgent -->
          <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2">
             <div class="card-body">
             	<div class="row no-gutters align-items-center">
                   <div class="col mr-2">
                   	<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                          Closed</div>
                     <div class="h5 mb-0 font-weight-bold text-gray-800">80</div>
                    </div>
                    <div class="col-auto">
                       <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                 </div>
              </div>
             </div>
            </div>
        
        </div>

    <!-- /.Summary -->


	<div class="row">


							<div class="table-responsive">
								<table class="table" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th width="10px"></th>
											<th>ID</th>
											<th>Subject</th>
											<th>Sender Name</th>
											<th>Related Service</th>
											<th>Priority</th>
											<th>Last Reply</th>
											<th>Replies</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><input class="mr-3 ml-3" type="checkbox" name=""
												id="" value="check"></td>
											<td>01</td>
											<td>Just another topic</td>
											<td>Tiger Nixon</td>
											<td>Billing</td>
											<td>High</td>
											<td>2 days ago</td>
											<td>3</td>
											<td><a class="badge badge-success" data-toggle="modal" data-target="#ticketAdminModal" data-subject="Issue 1" href=""><i
													class="fas fa-eye py-1 px-1"></i></a></td>
										</tr>
										<tr>
											<a href=""></a>
											<td><input class="mr-3 ml-3" type="checkbox" name=""
												id="" value="check"></td>
											<td>02</td>
											<td>Just another topic</td>
											<td>John Doe</td>
											<td>Support</td>
											<td>Medium</td>
											<td>27 days ago</td>
											<td>31</td>
											<td><a class="badge badge-success" data-toggle="modal" data-target="#ticketAdminModal" data-subject="Issue 2" href=""><i
													class="fas fa-eye py-1 px-1"></i></a></td>
										</tr>
										<tr>
											<a href=""></a>
											<td><input class="mr-3 ml-3" type="checkbox" name=""
												id="" value="check"></td>
											<td>03</td>
											<td>Just another topic</td>
											<td>Ashton Cox</td>
											<td>General</td>
											<td>Low</td>
											<td>22 days ago</td>
											<td>7</td>
											<td><a class="badge badge-success" data-toggle="modal" data-target="#ticketAdminModal" data-subject="Issue 2" href=""><i
													class="fas fa-eye py-1 px-1"></i></a></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
						</div>
	</div>
</div>
<!-- /.container-fluid -->
<!-- End of Main Content -->

<jsp:include page="../includes/_footer.jsp"></jsp:include>