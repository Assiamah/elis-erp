 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


  <jsp:include page="../includes/_header.jsp"></jsp:include>
  

  <% 


	  
%>

  
  

 <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.html">Case Management</a>
        </li>
        <li class="breadcrumb-item active">Create New case</li>
      </ol>
           
          <div class="row">
        <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Service Selection</div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/tab_page"  method="post">

   
	     <div class="form-group">
          <label for="main_service">Main Service</label>
                  <select name="main_service" id="main_service" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                  <option value="-1">Select Main Service</option>
                  <% 
                  try {
                	  
                	  Ws_client_application user_web_service = new Ws_client_application();
              		
              		String jsonArrayContent =null;
              		jsonArrayContent =user_web_service.get_list_of_services();			
              		//response.setContentType("application/json");
              		//response.getWriter().print(jsonArrayContent);
              		JSONArray jArr;
            		
            			jArr = new JSONArray(jsonArrayContent);
            			for (int i=0; i < jArr.length(); i++) {
                          JSONObject jsonObject = jArr.getJSONObject(i);
                          
                          String business_process_id = (String) jsonObject.getString("business_process_id");
                          String business_process_name = (String) jsonObject.getString("business_process_name");
                          %>
                     <%--  <option value="<%=business_process_id%>"><%=business_process_name%></option>--%>
 
   <option value="<%=business_process_id + "-" + business_process_name%>"><%=business_process_name%></option> 
 
                          <% 
                          
                          
            			}
                  }
                  catch (Exception e){
                	  e.printStackTrace();
                  }
                  
                  %>
                </select>
          </div>
           <div class="form-group">
          <label for="sub_service">Sub Service</label>
                  <select name="sub_service" id="sub_service" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                    <option value="-1">Select Sub Service</option>
                  <% 
                  try {
                	 // String userName = request.getParameter("business_process_id");
                	  
                	  Ws_client_application user_web_service = new Ws_client_application();
              		
              		String jsonArrayContent =null;
              		jsonArrayContent =user_web_service.get_list_of_sub_services_new();			
              		//response.setContentType("application/json");
              		//response.getWriter().print(jsonArrayContent);
              		JSONArray jArr;
            		
            			jArr = new JSONArray(jsonArrayContent);
            			for (int i=0; i < jArr.length(); i++) {
                          JSONObject jsonObject = jArr.getJSONObject(i);
                          
                          String business_process_sub_id = (String) jsonObject.getString("business_process_sub_id");
                          String business_process_sub_name = (String) jsonObject.getString("business_process_sub_name");
                          %>
                          
                         <option value="<%=business_process_sub_id + "-" + business_process_sub_name %>"><%=business_process_sub_name%></option> 
     					 <%-- <option value="<%=business_process_sub_id %>"><%=business_process_sub_name%></option> --%>
     
                          <% 
                          
                          
            			}
                  }
                  catch (Exception e){
                	  e.printStackTrace();
                  }
                  
                  %>
                </select>
         	 </div>
	          
    		<input type="submit" name="save" class="next btn btn-info" value="Proceed" />

   </form>

            </div>
           <!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
          </div>

          
         
        </div>
        
      <!--   Here is the right Table -->
        <div class="col-lg-4">
          <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i> Pie Chart Example</div>
            <div class="card-body">
              <canvas id="myPieChart" width="100%" height="100"></canvas>
            </div>
           <!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
          </div>
         
        </div>
      <!--   Here is the end of right table -->
        
        
        
       
        
        
      </div>
      
      
    </div>
 </div>
 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
