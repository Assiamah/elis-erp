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
 
 
  <%--  <% 
/* String id =request.getParameter("lsid");
System.out.println("Surveyor id " + id); */
String main_service = request.getParameter("main_service_id");
String sub_service = request.getParameter("main_service_sub_id");
System.out.println("Surveyor id " + main_service);
%>
 --%> 
 
 <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.html">Case Management</a>
        </li>
        <li class="breadcrumb-item active">Service Bill for First Registration</li>
      </ol>
           
          <div class="row">
        <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Service Selected</div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/Case_Management_Serv"  target="_blank"  method="post">

		<input type="hidden" id="main_service_id" name="main_service_id" value="${main_service_id}">
          <input type="hidden" id="main_service_sub_id" name="main_service_sub_id" value="${main_service_sub_id}">
          
           <input type="hidden" id="request_type" name="request_type" value="process_online_select_bill_for_registration">
        

          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="main_service_desc">Main Service</label>
                <input class="form-control" id="main_service_desc"  name="main_service_desc"  type="text" aria-describedby="nameHelp" value="${main_service_desc}" readonly>
              </div>
              <div class="col-md-6">
                <label for="main_service_sub_desc">Sub Service</label>
                <input class="form-control" id="main_service_sub_desc" name="main_service_sub_desc" type="text" aria-describedby="nameHelp" value="${main_service_sub_desc}" readonly>
              </div>
            </div>
          </div>
          
                       <div class="row">
     <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>${main_service_desc}  Check List</div>
            <div class="card-body">
            
         
            
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
              <thead>
                <tr>
                 <th>Description</th>
                  <th>Option</th>
                
                 </tr>
              </thead>
              <tfoot>
                <tr>
                  <th>Description</th>
                  <th>Option</th>
                </tr>
              </tfoot>
             <tbody>
               
                 <% 	
            	if (request.getAttribute("main_service_id") !=null){
           		 Ws_client_application user_web_service = new Ws_client_application();
           			
           			String jsonArrayContent =null;
           			jsonArrayContent =user_web_service.get_check_list_for_a_service(request.getAttribute("main_service_id").toString(),request.getAttribute("main_service_sub_id").toString());
           			//System.out.println(jsonArrayContent);
           			
           			
           		    JSONArray jArr;
           			try {
           				jArr = new JSONArray(jsonArrayContent);
           				for (int i=0; i < jArr.length(); i++) {
           	              JSONObject jsonObject = jArr.getJSONObject(i);
           	              
           	              String business_process_checklist_name = (String) jsonObject.getString("business_process_checklist_name");
           	              String business_process_checklist_option = (String) jsonObject.getString("business_process_checklist_option");
           	             
           	              %>
           	               <tr>
           	                <td><%=business_process_checklist_name %></td>
           	              
           	              
           	              
           	              
           	               <td>
           	                  <!-- Default unchecked -->
						         <div class="custom-control custom-checkbox">
					                  <input type="checkbox" class="select-item checkbox" name="select-item" value="1002" />
					                  
					              </div>
           	               </td>
           	               
           	               
           	               

           	                </tr>
           	              <%
           				 }
           			           		
           			} catch (JSONException e) {
           				// TODO Auto-generated catch block
           				e.printStackTrace();
           			}
           			
           	} 

           	%>
			     
              </tbody> 
            </table>
          </div>
             
              <!--  End Of Table -->
            </div>
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
          </div>
          
      
      </div>
     </div>
          
          

          
          <div class="form-group">
            <div class="form-row">
                <label for="client_name">Client Name</label>
                <input class="form-control" id="client_name"  name="client_name"  type="text" aria-describedby="nameHelp" placeholder="Enter Client Name" required>
            </div>
          </div>
          
          
          
            <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
           
                  <label for="client_name">Land Size</label>
                <input class="form-control" id="land_size"  name="land_size"  type="text" aria-describedby="nameHelp" placeholder="Enter land Size" required>
                </div>
              <div class="col-md-6">
     				 <label for="type_of_use">Type of Use</label>
                  <select name="type_of_use" id="type_of_use" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                  <option value="-1">Select Type of Use</option>
                  <% 
                  try {
                	  
                	  Ws_client_application user_web_service = new Ws_client_application();
              		
              		String jsonArrayContent =null;
              		jsonArrayContent =user_web_service.get_list_of_typeofuse();			
              	  JSONArray jArr;
            		
            			jArr = new JSONArray(jsonArrayContent);
            			for (int i=0; i < jArr.length(); i++) {
                          JSONObject jsonObject = jArr.getJSONObject(i);
                          
                          String typeofuse_id = (String) jsonObject.getString("typeofuse_id");
                          String typeofuse_name = (String) jsonObject.getString("typeofuse_name");
                          %>
             
   							<option value="<%=typeofuse_id + "-" + typeofuse_name%>"><%=typeofuse_name%></option> 
 
                          <% 
                          
                          
            			}
                  }
                  catch (Exception e){
                	  e.printStackTrace();
                  }
                  
                  %>
                </select>
                
                 </div>
            </div>
          </div>
          
          
          
           <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
             <label for="registration_forms">Forms</label>
                  <select name="registration_forms" id="registration_forms" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                  <option value="-1">Select Registration Forms</option>
                  <% 
                  try {
                	  
                	  Ws_client_application user_web_service = new Ws_client_application();
              		
              		String jsonArrayContent =null;
              		jsonArrayContent =user_web_service.get_lrd_form_for_application(request.getAttribute("main_service_id").toString(),request.getAttribute("main_service_sub_id").toString());			
              		//response.setContentType("application/json");
              		//response.getWriter().print(jsonArrayContent);
              		JSONArray jArr;
            		
            			jArr = new JSONArray(jsonArrayContent);
            			for (int i=0; i < jArr.length(); i++) {
                          JSONObject jsonObject = jArr.getJSONObject(i);
                          
                          String form_number = (String) jsonObject.getString("form_number");
                          String form_name = (String) jsonObject.getString("form_name");
                          %>
             
   					<option value="<%=form_number + "-" + form_name%>"><%=form_name%></option> 
 
                          <% 
                          
                          
            			}
                  }
                  catch (Exception e){
                	  e.printStackTrace();
                  }
                  
                  %>
                </select>          
                
                </div>
              <div class="col-md-6">
     				 
             	<label for="publication_type">Publication Type</label>
						<select name="publication_type" id="publication_type" data-live-search="true" data-none-results-text="I found no results" title="Please select fruit" class="form-control selectpicker">
							<option value="normal_publication">Normal Publication</option>
							<option value="special_publication">Special Publication</option>
						</select>
                
              </div>
            </div>
          </div>
          
          
                     <div class="form-group">
            <div class="form-row">
        
              <div class="col-md-6">
     			 <input type="submit" class="btn btn-primary btn-block" value="Generate Bill" />  
                
                 </div>
            </div>
          </div>
          
       
            
            
            
          </div>
         
        
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
              <i class="fa fa-pie-chart"></i>Instructions for generating regional number</div>
            <div class="card-body">
             Instructions for generating regional numbers
             Enter Regional Number
            </div>
           <!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
          </div>
         
        </div>
      <!--   Here is the end of right table -->
        
      
      
    </div>
    

    
     
    
 </div>
 
 
  
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
