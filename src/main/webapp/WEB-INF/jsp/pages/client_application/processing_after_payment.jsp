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
 
 -  <% 
String job_number = request.getParameter("job_number");
 
 String jn_id ="";
 String  licensed_surveyor_uid = "";
 String licensed_surveyor_number  ="";
 String  licensed_surveyor_name = "";	            
 String regional_number  = "";

 String nature_of_instrument  = "";
 String  lessees_name = "";	            
 String lessees_address  = "";
 String  lessees_phone_number ="";
 String grantors_name  ="";
 String  certificate_number = "";	            
 String extent  = "";
 String  locality ="";
 String  type_of_interest =""; 
String  type_of_use = "";
String  business_process_id ="";
String  business_process_name = "";
String  business_process_sub_id = "";
String  business_process_sub_name = ""; 
String  isprocesstomainstream = "";
String  gender =""; 
String  district =""; 
String  region = ""; 
String  payment_id = ""; 
String  bill_date = ""; 
String  bill_amount = ""; 
String  bill_number = ""; 
String  payment_date =""; 
String	  payment_status = ""; 
String  payment_amount = ""; 
String  payment_slip_number =""; 
String  payment_remarks = ""; 
String  payment_mode = ""; 
//String  type_of_revenue = (String) jsonObject.getString("type_of_revenue"); 
//  String  revenue_group = (String) jsonObject.getString("revenue_group"); 
String  payment_bank = ""; 
String  payment_bank_branch = ""; 
String  payment_confiration_status = ""; 
String  division = ""; 
String  account_number = "";
 
 Ws_client_application user_web_service = new Ws_client_application();
 try{

	
	String jsonArrayContent =null;
	jsonArrayContent =user_web_service.get_details_of_job_after_payment(job_number);			
	JSONArray jArr;
	
		jArr = new JSONArray(jsonArrayContent);
		for (int i=0; i < jArr.length(); i++) {
       JSONObject jsonObject = jArr.getJSONObject(i);
       
           
        jn_id =(String) jsonObject.getString("jn_id");
         licensed_surveyor_uid = (String) jsonObject.getString("licensed_surveyor_uid");
        licensed_surveyor_number  =(String) jsonObject.getString("licensed_surveyor_number");
         licensed_surveyor_name = (String) jsonObject.getString("licensed_surveyor_name");	            
        regional_number  = (String) jsonObject.getString("regional_number");
        nature_of_instrument  = (String) jsonObject.getString("nature_of_instrument");
         lessees_name = (String) jsonObject.getString("lessees_name");	            
        lessees_address  = (String) jsonObject.getString("lessees_address");
         lessees_phone_number = (String) jsonObject.getString("lessees_phone_number");
        grantors_name  = (String) jsonObject.getString("grantors_name");
         certificate_number = (String) jsonObject.getString("certificate_number");	            
        extent  = (String) jsonObject.getString("extent");
         locality = (String) jsonObject.getString("locality");
         type_of_interest = (String) jsonObject.getString("type_of_interest"); 
        type_of_use = (String) jsonObject.getString("type_of_use");
        business_process_id = (String) jsonObject.getString("business_process_id");
       business_process_name = (String) jsonObject.getString("business_process_name");
        business_process_sub_id = (String) jsonObject.getString("business_process_sub_id");
        business_process_sub_name = (String) jsonObject.getString("business_process_sub_name"); 
       isprocesstomainstream = (String) jsonObject.getString("isprocesstomainstream");
       gender = (String) jsonObject.getString("gender"); 
        district = (String) jsonObject.getString("district"); 
        region = (String) jsonObject.getString("region"); 
       payment_id = (String) jsonObject.getString("payment_id"); 
      bill_date = (String) jsonObject.getString("bill_date"); 
     bill_amount = (String) jsonObject.getString("bill_amount"); 
     bill_number = (String) jsonObject.getString("bill_number"); 
     payment_date = (String) jsonObject.getString("payment_date"); 
   	  payment_status = (String) jsonObject.getString("payment_status"); 
     payment_amount = (String) jsonObject.getString("payment_amount"); 
     payment_slip_number = (String) jsonObject.getString("payment_slip_number"); 
     payment_remarks = (String) jsonObject.getString("payment_remarks"); 
     payment_mode = (String) jsonObject.getString("payment_mode"); 
   //String  type_of_revenue = (String) jsonObject.getString("type_of_revenue"); 
 //  String  revenue_group = (String) jsonObject.getString("revenue_group"); 
     payment_bank = (String) jsonObject.getString("payment_bank"); 
    payment_bank_branch = (String) jsonObject.getString("payment_bank_branch"); 
    payment_confiration_status = (String) jsonObject.getString("payment_confiration_status"); 
     division = (String) jsonObject.getString("division"); 
     account_number = (String) jsonObject.getString("account_number");
      
		}
  }
  catch (Exception e){
	  e.printStackTrace();
  }
%>
 
 
 <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.html">Case Management</a>
        </li>
        <li class="breadcrumb-item active">Details of a Job</li>
      </ol>
           
          <div class="row">
        <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>After Payment Processing for a Job</div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/download_pdf"  method="post">

		<input type="hidden" id="main_service_id" name="main_service_id" value="<%=business_process_id %>">
          <input type="hidden" id="main_service_sub_id" name="main_service_sub_id" value=<%=business_process_sub_id %>">
        

          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="main_service_desc">Main Service</label>
                <input class="form-control" id="main_service_desc"  name="main_service_desc"  type="text" aria-describedby="nameHelp" value="<%=business_process_name %>" readonly>
              </div>
              <div class="col-md-6">
                <label for="main_service_sub_desc">Sub Service</label>
                <input class="form-control" id="main_service_sub_desc" name="main_service_sub_desc" type="text" aria-describedby="nameHelp" value="<%=business_process_sub_name %>" readonly>
              </div>
            </div>
          </div>
          
      
          
          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="main_service_desc">Job Number</label>
                <input class="form-control" id="main_service_desc"  name="main_service_desc"  type="text" aria-describedby="nameHelp" value="<%=job_number %>" readonly>
              </div>
              <div class="col-md-6">
                <label for="main_service_sub_desc">Bill Number</label>
                <input class="form-control" id="main_service_sub_desc" name="main_service_sub_desc" type="text" aria-describedby="nameHelp" value="<%=bill_number %>" readonly>
              </div>
            </div>
          </div>
          
                
              <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="main_service_desc">Licensed Surveyor Number</label>
                <input class="form-control" id="licensed_surveyor_number"  name="licensed_surveyor_number"  type="text" aria-describedby="nameHelp" value="<%=licensed_surveyor_number %>" readonly>
              </div>
              <div class="col-md-6">
                <label for="licensed_surveyor_name">Licensed Surveyor Name</label>
                <input class="form-control" id="licensed_surveyor_name" name="licensed_surveyor_name" type="text" aria-describedby="nameHelp" value="<%=licensed_surveyor_name %>" readonly>
              </div>
            </div>
          </div>
          
          
          
              <div class="form-group">
            <div class="form-row">
                <label for="lessees_name">Client Name</label>
                <input class="form-control" id="lessees_name"  name="lessees_name"  type="text" aria-describedby="nameHelp" value="<%=lessees_name %>" readonly>
            </div>
          </div>
          
          
          
              <div class="form-group">
            <div class="form-row">
             <div class="col-md-6">
                <label for="gender">Gender</label>
                <input class="form-control" id="gender" name="gender" type="text" aria-describedby="nameHelp" value="<%=gender %>" readonly>
              </div>
              <div class="col-md-6">
                <label for="locality">Sub Service</label>
                <input class="form-control" id="locality" name="locality" type="text" aria-describedby="nameHelp" value="<%=locality %>" readonly>
              </div>
            </div>
          </div>
        
              <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="district">District</label>
                <input class="form-control" id="district"  name="district"  type="text" aria-describedby="nameHelp" value="<%=district %>" readonly>
              </div>
              <div class="col-md-6">
                <label for="region">Region</label>
                <input class="form-control" id="region" name="region" type="text" aria-describedby="nameHelp" value="<%=region %>" readonly>
              </div>
            </div>
          </div>
          
          
          Bill and Payment Details
          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="bill_amount">Bill Amount</label>
                <input class="form-control" id="main_service_desc"  name="main_service_desc"  type="text" aria-describedby="nameHelp" value="<%=bill_amount %>" readonly>
              </div>
              <div class="col-md-6">
                <label for="payment_status">Payment Status</label>
                <input class="form-control" id="payment_status" name="payment_status" type="text" aria-describedby="nameHelp" value="<%=payment_status %>" readonly>
              </div>
            </div>
          </div>
          
        Payment_date:  			<%=payment_status %><br>
        Payment_amount:  		<%=payment_amount %><br>
        Payment_slip_number:  <%=payment_slip_number %><br>
        payment_remarks:  <%=payment_status %><br>
        Payment Mode:  <%=payment_status %><br>
          
          
  
          
          
         
            <div class="form-group">
                 <div class="form-row">
              <input type="submit" class="btn btn-primary btn-block" value="Generate Acknoeledgement Slip" /> 
              
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
