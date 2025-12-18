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


   <jsp:include page="../client_application/_application_process_header.jsp"></jsp:include>
					          
   <h3 class="border-bottom border-gray pb-2">Update Publication Details</h3>
   
 	  
   <div class="row">
    <div class="col-8">

        <input type="date" class="form-control" value="${publicity_date}" id="lc_txt_publicity_date" />
        
        <!-- <c:if test="${empty publicity_date}">
           <input type="date" class="form-control" value="${publicity_date}" id="lc_txt_publicity_date" />
        </c:if> -->
    </div>
    <div class="col-4">
        <button class="btn btn-warning w-100" id="lc_btn_update_publication_date"
        ><i class="fas fa-save mr-1"></i>Update</button>
    </div>
</div>

<input type="hidden" id="ars_job_purpose" class="form-control" value="${job_purpose}">


<div class="mt-5">
	<button class="btn btn-success btn-icon-split float-left "  data-job_number="${job_number}" id="btnApproveJob">
		<span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Approve Request</span>
	</button>

	<button class="btn btn-danger btn-icon-split float-left ml-3"  data-job_number="${job_number}" id="btnQueryJob">
		<span class="icon text-white-50"> <i class="fas fa-times fa-2x"></i></span><span class="text">Query Request</span>
	</button>
 </div>
 
 

          
            
		<jsp:include page="../client_application/_application_process_footer_ar.jsp"></jsp:include>
  
  
