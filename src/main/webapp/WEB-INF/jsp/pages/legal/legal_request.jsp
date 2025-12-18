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
				                  <li class="breadcrumb-item active">Legal Request </li>
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div>
	
	
     	<div class="row mb-4">
      		<!-- Left side columns -->
        <div class="col-lg-12">
          <div class="row">
            <!-- Assigned Cases Card -->
            <div class="col-xl-4 col-md-6" id="incoming">
              <div class="card border-left-info shadow h-100 py-2" id="body-bg-1">

                <div class="card-body">
	                  		<h5 class="card-title">Request <span>| Incoming</span></h5>
							
							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<i class="fa fa-tasks fa-2x text-info"></i>
								</div>
								 <div class="">	
		                     	 	<h4 id="incoming_count"><c:out value="${incoming_count}"></c:out></h4>
								 </div>
		                    </div>
                </div>

              </div>
            </div><!-- Assigned Cases Card -->

            <!-- Unit Cases Card -->
            <div class="col-xl-4 col-md-6" id="outgoing">
              <div class="card border-left-success shadow h-100 py-2" id="body-bg-2">

               <div class="card-body">
               	
                  <h5 class="card-title">Request <span>| Outgoing</span></h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="fas fa-list fa-2x text-success"></i>
                    </div>
                    <div class="">
                      <h4 id="unit_count"><c:out value="${outgoing_count}"></c:out></h4>

                    </div>
                  </div>
                </div>

              </div>
            </div><!-- Unit Cases Card --> 	
     
     </div>
    </div>
  </div>

	      <div class="row mb-4">
	            <div class="col-md-12">
	              <div class="card">
	              	<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i>Request Details <span
						class="col-md-3 float-right ">
					</span>
					</div>
	                <div class="card-body">
	                	  <h5 class="card-title">Request | <span id="card_title"> </span></h5>
	                  <div class="tab-content">
					            <div id="" class="table-responsive">
					                <table class="table " id="table_list"  width="100%" cellspacing="0" >
	              						<thead>
										    <tr>
										        <th>#</th>
										        <!-- <th>ID</th> -->
										        <th>Suit Number</th>
										        <!-- <th>Case Number</th> -->
										        <th>Subject</th>
										        <th>Description</th>
										        <th>Requested By</th>
										        <th>Deadline</th>
										        <th id="request_date">Date</th>
												<th>Actions</th>
										    </tr>
										  </thead>
										  <tbody id="table_body">
										    
										  </tbody>
		                   	        </table>
					            </div>
					    </div>
	                </div>
	              </div>
	            </div>
	          </div>

     </section>
	
	 <input type="text" hidden="" name="userid" value="${sessionScope.userid}"  />
	 <input type="text" hidden="" name="fullname" value="${sessionScope.fullname}"  />
	 <input type="text" hidden="" name="division" value="${sessionScope.division}"  />
	 <input type="text" hidden="" name="unit_name" value="${sessionScope.unit_name}"  />
	 <input type="text" hidden="" name="unit_id" value="${sessionScope.unit_id}"  />
	 <input type="text" hidden="" name="regional_code" value="${sessionScope.regional_code}"  />
	 <input type="text" hidden="" name="regional_name" value="${sessionScope.regional_name}"  />
	</div>
<!-- End Page Content -->

<jsp:include page="../legal/includes/footer.jsp"></jsp:include>
<script type="text/javascript" src="legal/includes/pages_script/legal_request.js"></script>