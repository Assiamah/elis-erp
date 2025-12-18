<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- <%@ page import="com.report_class.cls_reports" %> --%>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<jsp:include page="../includes/_header.jsp"></jsp:include>
<jsp:useBean id="now" class="java.util.Date" />

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-4 text-gray-800 ml-4">View Tickets</h1>
	<!-- buttons -->
	<div class="row ml-4">
		<ul class="nav nav-pills ">
		  <li class="pull-right"><a href="ticket"><button class="btn btn-danger">Open Ticket <i class="fa fa-folder-open" aria-hidden="true"></i></button></a></li>
		</ul>
	</div>
	<hr>

<!--List of Opened Tickets -->
<div class="row">
	<div class="col-md-12">
		<!-- TODO LIST -->
		<div class="card">
			<div class="card-body">
				<div class="tab-content">
				    <div id="" class="table-responsive">
				        <table class="table table-striped" id="table_list" >
	                   		<thead class="thead-dark">
	                   			<th width="5%">Ref. No</th>
	                   			<th width="10%">Date</th>
	                   			<th width="30%">Subject</th>
	                   			<th width="20%">Related Service</th>
	                   			<th width="15%">Unit</th>
	                   			<th width="10%"></th>
	                   			<th width="10%">Actions</th>
	                   		</thead>
	                   		<tbody id="">
	                   		<c:forEach items="${tickets}" var="ticket">
	                   		 <tr>
	                   		 	<td>${ticket.refereneceNumber}</td>
	                   		 	<td>${ticket.date}</td>
	                   		 	<td>${ticket.subject}</td>
	                   		 	<td>${ticket.relatedService}</td>
	                   		 	<td>${ticket.unit}</td>
	                   		 	<td>Opened</td>
	                   		 	<td> 
	                                <button class="btn btn-primary update_data" id="${ticket.refereneceNumber}" data-toggle="modal" data-target="#replyModal"><i class="fas fa-edit"></i></button> 
	                   		 	</td>
	                   		 </tr>
	                   		</c:forEach>  	
	                   		               		              
	        
	                   		</tbody>
	                   	</table>
				    </div>
				</div>
			</div>
		</div>
		<!-- END TODO LIST -->
	</div>
</div>

</div>
<!-- /.container-fluid -->



<!-- End of Main Content -->

<jsp:include page="../includes/_ticket_footer.jsp"></jsp:include>
