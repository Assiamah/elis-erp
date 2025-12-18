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
	              <i class="fa fa-bar-chart"></i>Barcoding</div>
	            <div class="card-body">
	              	<form id="frmTempBarcodingFind"  method="get">
	
			          <div class="form-group">
			            <div class="form-row">
			            <label for="search_value">Enter Job Number for Barcode</label>
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
			          <div class="form-group">
			            <div class="form-row">
			            <label for="search_value">Name</label>
         
			                <input class="form-control" id="rs_ar_name"  type="text" required >
			              
			            </div>
			            <br>
			            
			            
			            <div class="form-row">
			             
			              <div class="col-md-6">
			                <label for="search_value">Job number</label>
			                <input class="form-control" id="rs_job_number"  type="text" required >
			              </div>
			              <div class="col-md-6">
			              	<label for="search_value">Case Number</label>
			                <input class="form-control" id="rs_case_number"  type="text"  >
			                
			              </div>
			            </div>
			            <BR />
			            
			         
			             <div class="form-row">
			             
			              <div class="col-md-6">
			                <label for="search_value">Locality</label>
			                <input class="form-control" id="rs_locality"  type="text"  >
			              </div>
			              <div class="col-md-6">
			              <br>
			              		<button type="submit" class="btn btn-success btn-block btn-xl" value="Search" id="btnBarcoder" > Print Barcode </button>
			              		
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