<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<jsp:include page="../includes/_header.jsp"></jsp:include>
<jsp:useBean id="now" class="java.util.Date" />

<!-- Begin Page Content -->
 <div class="container-fluid">

		<!-- Page Heading -->
		<h2 class="h3 mb-4 text-gray-800">Open Ticket</h2>
		<hr>
			<p>
				If you can't find a solution to your problems in our knowledgebase, you can submit a ticket by selecting the appropriate department below.
			</p>
	 <c:forEach items="${issues}" var="issue">  
  		
	  <div class="row newTicket" title="${issue}">
		<div class="col-xl-12 col-md-12 mb-2">
			<div class="card border-left-primary shadow h-100 py-2">
					<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-md font-weight-bold text-primary text-uppercase">
							${issue}	
							</div>
							<div class="text-xs text-uppercase text-dark openmodal">
								${issue} and more
							</div>
						</div>
					</div>
				</div>
			</div>
		</div> 
		</div>
	</c:forEach>	
	


</div>

<!-- /.container-fluid -->
<!-- End of Main Content -->
<jsp:include page="../includes/_ticket_footer.jsp"></jsp:include>