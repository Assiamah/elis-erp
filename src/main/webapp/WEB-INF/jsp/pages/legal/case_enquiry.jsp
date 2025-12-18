<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="d" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.*" %>
<jsp:include page="../legal/includes/header.jsp"></jsp:include>
<!-- Begin Page Content -->
   <div class="container-fluid">
	<section class="section dashboard">
		 <!-- Page Heading -->
                <div class="row mb-4">
                	 <div class="col-md-12">
		                <div class=" ">
		                   
					         <nav>
				                <ol class="breadcrumb">
				                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
				                  <li class="breadcrumb-item active">All Cases</li>
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div>
	
	

	      <div class="row mb-4">
	            <div class="col-md-12">
	              <div class="card">
	              <div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i>Writs Details <span
						class="col-md-3 float-right ">
					</span>
					</div>
	                <div class="card-body">
	                	  <h5 class="card-title">Cases | <span id="card_title">All</span></h5>
	                  <div class="tab-content">
					            <div id="" class="table-responsive">
					                <table class="table" id="table_list" >
	              						<thead>
	              							 <tr>									
										        <th>Suit Number</th>
										        <th>Nature of Case</th>
										        <th>Court</th>
										        <th>Court Region</th>
										        <th>Plaintiff(s)</th>
										        <th>Defendant(s)</th>
										        <th>Date of Document</th>
										        <th>Date Received</th>
										        <th>Assigned To</th>
												<th>Actions</th>
										    </tr>
	              						</thead>
	              						<tbody>
	              						<c:forEach items="${cases}" var="assigned_case"  varStatus="appfiles_loop"> 
	              							<tr><td><strong>${assigned_case.suit_number}</strong></td>
	              							    <td>${assigned_case.nature_of_case}</td>
	              							    <td>${assigned_case.court_name}</td>
	              							    <td>${assigned_case.region}</td>
	              							   
	              							    <td>
		              								<d:forEach items="${assigned_case.plaintiffs}" var="plaintiffs" varStatus="appfiles_loop" >
		              									${plaintiffs.plaintiffs_name}, 
		              								</d:forEach>
	              							    </td>
	              							    
	              							     <td>
		              								<d:forEach items="${assigned_case.defendants}" var="defendants" varStatus="appfiles_loop" >
		              									${defendants.defendants_name}, 
		              								</d:forEach>
	              							    </td>
	              								<td>${assigned_case.date_of_document}</td>
	              								<td>${assigned_case.date_received}</td>
	              								<td class="text-primary">${assigned_case.assigned_to}</td>
	              								<td>
	              									<div class="dropdown no-arrow">
									              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
												                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
												              </svg>
									              	  </a>
									              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
									              	  	<form  action="case_details" method="post">
									              	  		<input type="hidden" name="case_id" value="${assigned_case.id}">
															<input type="hidden"  name="suit_number" value="${assigned_case.suit_number}">
															<input type="hidden"  name="request_type" value="case_details">
									              	    	<button type="submit" class="dropdown-item" href="#">Case Details</button>
									              	    </form>
					
									              	  </div>
		              								</div>
	              								</td>
	              						</c:forEach>
	              						</tbody>
		                   	        </table>
					            </div>
					    </div>
	                </div>
	              </div>
	            </div>
	           </div>
     </section>

	</div>
<!-- End Page Content -->


<jsp:include page="../legal/includes/footer.jsp"></jsp:include>
<script>
document.addEventListener('DOMContentLoaded', function() {
	$('#table_list').DataTable();
})


  
</script>