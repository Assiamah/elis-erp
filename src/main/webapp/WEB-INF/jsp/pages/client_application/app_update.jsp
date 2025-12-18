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
      
           
          <div class="row">
	        <div class="col-sm-6">
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fa fa-bar-chart"></i>Search for Application</div>
	            <div class="card-body">
	              	<form id="frmTempBarcodingFind"  method="get">
	
			          <div class="form-group">
			            <div class="form-row">
			            <label for="search_value">Enter Job Number for Update</label>
			              <div class="col-md-8">
			                
			                <input class="form-control" id="job_search_value"  type="text" required >
			              </div>
			              <div class="col-md-4">
			              	
			                <button type="submit" class="btn btn-primary btn-block" value="Search" id="" > Search </button>
			                
			              </div>
			            </div>
			          </div>
			        </form>
	            
	
	            </div>
	          </div>
	
	        </div>
	        
	        <div class="col-sm-6">
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fa fa-bar-chart"></i>Application Details</div>
	            <div class="card-body">
	              	<form id="frmTempBarcoding"  method="get">
	              		<input  id="fe_job_number"  type="hidden" >
	              		<input  id="fe_client_name"  type="hidden" >
	              		<input  id="febusiness_process_sub_name"  type="hidden" >
	              		<input  id="main_service_id_fe"  type="hidden" >
	              		<input  id="main_service_sub_id_fe"  type="hidden" >
	              	
			          <div class="form-group">
			            <div class="form-row">
			            <label for="search_value">Name</label>
         
			                <input class="form-control" id="rs_ar_name"  type="text" required readonly>
			              
			            </div>
			            <br>
			            
			            
			            <div class="form-row">
			             
			              <div class="col-md-6">
			                <label for="search_value">Job number</label>
			                <input class="form-control" id="rs_job_number"  type="text" required readonly >
			              </div>
			              <div class="col-md-6">
			              	<label for="search_value">Case Number</label>
			                <input class="form-control" id="rs_case_number"  type="text"  readonly>
			                
			              </div>
			            </div>
			            <BR />
			            
			         
			             <div class="form-row">
			             
			              <div class="col-md-6">
			                <label for="search_value">Locality</label>
			                <input class="form-control" id="rs_locality"  type="text" readonly>
			              </div>
			              <div class="col-md-6">
			              <br>
			              		<button type="button" 
			              		
										class="btn btn-secondary btn-block btn-xl  make-hidden"
										data-toggle="modal" 
										data-target="#applicationStatusupdate"  style="display:none !important"
										>Update Milestone</button> 
			              </div>
			              
			              
			              <div class="col-md-6">
			              <br>
			              		<button style="display:none" type="button" class="btn btn-info btn-block btn-xl make-hidden" id="btnUncomplete" > Set as Uncompleted </button>
			              		
			              </div>
			              <div class="col-md-6">
			              <br>
			              		<button style="display:none" type="button" class="btn btn-primary btn-block btn-xl make-hidden" id="btnCopyName" > Fix Name not showing </button>
			              		
			              </div>
			            </div>

			          </div>
			        </form>
	            </div>
	          </div>
	        </div>
      	  </div>
     </div>
     
     
    
 </div> 
 
 
 
 
 
 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>