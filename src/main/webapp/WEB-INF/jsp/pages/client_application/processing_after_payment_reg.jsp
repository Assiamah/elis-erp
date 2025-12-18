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
   
   Ws_client_application casemgt_cl = new Ws_client_application();
   
	String web_service_response =null;
	//String job_number = request.getParameter("job_number");
	
	String jobdetails_bf = "";
		String  payments = "";
		String  clients = "";
		  
		
		
		
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
		
	
	String job_number = request.getParameter("job_number");
	 System.out.println(job_number);
   web_service_response =casemgt_cl.select_load_details_for_payment(job_number);


// web_service_response = (String)jsonobj.getString("data");	

	 if(web_service_response!=null)
        {
			System.out.println(web_service_response);
        }else{
        	System.out.println(web_service_response);
        } 
	
	
	

	try {
		
		JSONObject jsonobj = new JSONObject(web_service_response);
		 jobdetails_bf = (String)jsonobj.getString("jobdetails");
		  payments = (String)jsonobj.getString("payments");	
		  clients = (String)jsonobj.getString("parties");	
		  
		System.out.println(jobdetails_bf);
		System.out.println(payments);
		System.out.println(clients);
		
		 JSONObject jsonObject_jn = new JSONObject(jobdetails_bf);
		   jn_id =(String) jsonObject_jn.getString("jn_id");
	       licensed_surveyor_uid = (String) jsonObject_jn.getString("licensed_surveyor_uid");
	      licensed_surveyor_number  =(String) jsonObject_jn.getString("licensed_surveyor_number");
	       licensed_surveyor_name = (String) jsonObject_jn.getString("licensed_surveyor_name");	            
	      regional_number  = (String) jsonObject_jn.getString("regional_number");
	      nature_of_instrument  = (String) jsonObject_jn.getString("nature_of_instrument");
	       lessees_name = (String) jsonObject_jn.getString("lessees_name");	            
	      lessees_address  = (String) jsonObject_jn.getString("lessees_address");
	       lessees_phone_number = (String) jsonObject_jn.getString("lessees_phone_number");
	      grantors_name  = (String) jsonObject_jn.getString("grantors_name");
	       certificate_number = (String) jsonObject_jn.getString("certificate_number");	            
	      extent  = (String) jsonObject_jn.getString("extent");
	       locality = (String) jsonObject_jn.getString("locality");
	       type_of_interest = (String) jsonObject_jn.getString("type_of_interest"); 
	      type_of_use = (String) jsonObject_jn.getString("type_of_use");
	      business_process_id = (String) jsonObject_jn.getString("business_process_id");
	     business_process_name = (String) jsonObject_jn.getString("business_process_name");
	      business_process_sub_id = (String) jsonObject_jn.getString("business_process_sub_id");
	      business_process_sub_name = (String) jsonObject_jn.getString("business_process_sub_name"); 
	     isprocesstomainstream = (String) jsonObject_jn.getString("isprocesstomainstream");
	     gender = (String) jsonObject_jn.getString("gender"); 
	      district = (String) jsonObject_jn.getString("district"); 
	      region = (String) jsonObject_jn.getString("region"); 
	  
		// TODO Auto-generated catch block
	} catch (JSONException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}	

	 
	
   
/* String id =request.getParameter("lsid");
System.out.println("Surveyor id " + id); */
//String jobdetails = request.getParameter("jobdetails");
//String payments = request.getParameter("payments");
//String clients = request.getParameter("clients");

/* System.out.println("Surveyor id " + jobdetails);
System.out.println("payments id " + payments);
System.out.println("clients " + clients); */
%>
 
 
 <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.html">Case Management</a>
        </li>
        <li class="breadcrumb-item active">Service Bill for Regional Number</li>
      </ol>
           
          <div class="row">
        <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Service Selection</div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/Case_Management_Serv"  target="_blank"  method="post">

	   	<input type="hidden" id="main_service_id" name="main_service_id" value="<%= business_process_id %>">
          <input type="hidden" id="main_service_sub_id" name="main_service_sub_id" value="<%= business_process_sub_id %>">
           <input type="hidden" id="jn_id" name="jn_id" value="jn_id">
            <input type="hidden" id="userid" name="userid" value="${userid}">
            <input type="hidden" id="user_fullname" name="user_fullname" value="${fullname}">
           
         
           <input type="hidden" id="request_type" name="request_type" value="process_online_select_acknowledgement_for_registration">
        

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
                <label for="client_name">Client Name</label>
                <input class="form-control" id="client_name"  name="client_name"  type="text" aria-describedby="nameHelp" value="<%= lessees_name%>" readonly>
              </div>
              <div class="col-md-6">
                <label for="main_service_sub_desc">Land Size</label>
                <input class="form-control" id="land_size" name="land_size" type="text" aria-describedby="nameHelp" value="<%= extent%>" readonly>
              </div>
            </div>
          </div>
         <!--  
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
		String  region = "";  -->
		
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
              <!-- <tfoot>
                <tr>
                  <th>uid</th>
                  <th>User Name</th>
                </tr>
              </tfoot> -->
             <tbody>
               
                 <% 	
            	if (business_process_id !=null){
           		 Ws_client_application user_web_service = new Ws_client_application();
           			
           			String jsonArrayContent =null;
           			jsonArrayContent =user_web_service.get_check_list_for_a_service(business_process_id,business_process_id);
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
     
     
     
          
          
          
             <div class="row">
     <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Flat Fee(s)</div>
            <div class="card-body">
            
         
            
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
              <thead>
                <tr>
                 <th>Bill Number</th>
                  <th>Bill Description</th>
                   <th>Bill Amount</th>
                  <th>Payment Amount</th>
                   <th>Division</th>
                 
                
                 </tr>
              </thead>
              
             <tbody>
               
                 <% 	
            	if (payments !=null){
           		 Ws_client_application user_web_service = new Ws_client_application();
           			
           			String jsonArrayContent =null;
           			jsonArrayContent =payments;
           			//System.out.println(jsonArrayContent);
           			
           			
           		    JSONArray jArr;
           			try {
           				jArr = new JSONArray(jsonArrayContent);
           				for (int i=0; i < jArr.length(); i++) {
           	              JSONObject jsonObject = jArr.getJSONObject(i);
           	              
           	              String bill_number = (String) jsonObject.getString("bill_number");
           	              String customer_id = (String) jsonObject.getString("customer_id");
           	             String bill_amount = (String) jsonObject.getString("bill_amount");
           	            String payment_amount = (String) jsonObject.getString("payment_amount");
           	             String division = (String) jsonObject.getString("division");
           	             
           	              %>
           	               <tr>
           	                <td><%=bill_number %></td>
           	                <td><%=customer_id %></td>
           	               <td><%=bill_amount %></td>
           	               <td><%=payment_amount %></td>
           	               <td><%=division %></td>
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
          
          
          
               <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Parties to Transaction</div>
            <div class="card-body">
            
        
				            <div class="form-row">
				              <div class="col-md-3">
				                <label for="search_value">ID Card Number</label>
								   <input class="form-control" id="id_card_number_search"  name="id_card_number_search"  type="text" aria-describedby="nameHelp" placeholder="Enter ID Card Number" value="${case_number}" >
        												
				                </div>
				               
				                <div class="col-md-1">
				                <label for="search_value">-</label>
					               <button class="form-control" type="button" id="btn_card_number_search" class="btn btn-primary">
							            <i class="fa fa-object-group"></i>
							        </button>				
				                </div>
				               
				                 <div class="col-md-8">
				                <label for="search_value">Client Name</label>
				                <input class="form-control" id="client_name_search"  name="client_name_search"  type="text" aria-describedby="nameHelp"  >
				              </div>
				               
				             
				            </div>
				            
				            
				            
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Client ID</label>
								   <input class="form-control" id="client_id_search"  name="client_id_search"  type="text" aria-describedby="nameHelp"  value="${case_number}" >
        													
				                </div>
				                <div class="col-md-4">
				                <label for="search_value">Party Type</label>
				              
								<select name="client_type_search" id="client_type_search" data-live-search="true" data-none-results-text="I found no results" title="Please select fruit" class="form-control selectpicker">
									<option value="Applicant">Applicant</option>
									<option value="Grantor">Grantor</option>
									<option value="Depositor">Depositor</option>
									
								</select>
								</div>
								
								 <div class="col-md-4">
				                <label for="search_value">Add to Case</label>
								   		<button class="form-control" class="btn"><i class="fa fa-home"></i> Add to Case</button>				
				                </div>
				             
				            </div>
				            
         
            
            
           					 <div class="form-row">
				              <div class="col-md-4">
				                LIst of Parties						
				                </div>
				            
				            
				             
				            </div>
				            
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered" id="client_details_datatable" width="100%" cellspacing="0">
              <thead>
                <tr>
                 <th>ar_client_id</th>
                 <th>ar_name</th>
                 <th>ar_gender</th>
                 <th>ar_cell_phone</th>
                <th>type_of_party</th>
              
                 
                 </tr>
              </thead>
              
             <tbody>
               
                 <% 	
            	if (clients !=null){
           		 Ws_client_application user_web_service = new Ws_client_application();
           			
           			String jsonArrayContent =null;
           			jsonArrayContent =clients ;
           			//System.out.println(jsonArrayContent);
           			
           			
           		    JSONArray jArr;
           			try {
           				jArr = new JSONArray(jsonArrayContent);
           				for (int i=0; i < jArr.length(); i++) {
           	              JSONObject jsonObject = jArr.getJSONObject(i);
           	              
           	              String ar_client_id = (String) jsonObject.getString("ar_client_id");
           	              String ar_name = (String) jsonObject.getString("ar_name");
           	          	String ar_gender = (String) jsonObject.getString("ar_gender");
        	              String ar_cell_phone = (String) jsonObject.getString("ar_cell_phone");
        	              String type_of_party = (String) jsonObject.getString("type_of_party");
           	             
        	              
        	              
        	              
           	              %>
           	               <tr>
           	                <td><%=ar_client_id %></td>
           	                <td><%=ar_name %></td>
           	               <td><%=ar_gender %></td>
           	                <td><%=ar_cell_phone %></td>
           	               
           	                <td><%=type_of_party %></td>
           	              
           	             <!--   <td>
           	                  Default unchecked
						        <div class="custom-control custom-checkbox">
						          <input type="checkbox" class="custom-control-input" id="tableDefaultCheck1">
						          <label class="custom-control-label" for="tableDefaultCheck1">Check 1</label>
						        </div>
           	               </td> -->
           	               
           	               
           	               

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
              <div class="col-md-6">
           
                 <label for="client_name">locality</label>
                <input class="form-control" id="locality_of_parcel"  name="locality_of_parcel"  type="text" aria-describedby="nameHelp" placeholder="Enter locality_of_parcel" required>
            </div>
              <div class="col-md-6">
     				 <label for="type_of_interest">Type of Use</label>
                  <select name="type_of_interest" id="type_of_interest" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                  <option value="-1">Select Type of Interest</option>
                  <% 
                  try {
                	  
                	  Ws_client_application user_web_service = new Ws_client_application();
              		
              		String jsonArrayContent =null;
              		jsonArrayContent =user_web_service.get_list_of_typeofinterest();			
              	  JSONArray jArr;
            		
            			jArr = new JSONArray(jsonArrayContent);
            			for (int i=0; i < jArr.length(); i++) {
                          JSONObject jsonObject = jArr.getJSONObject(i);
                          
                          String typeofinterest_id = (String) jsonObject.getString("typeofinterest_id");
                          String typeofinterest_name = (String) jsonObject.getString("typeofinterest_name");
                          %>
             
   							<option value="<%=typeofinterest_id + "-" + typeofinterest_name%>"><%=typeofinterest_name%></option> 
 
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
     				 
             	<label for="application_type">Application Type</label>
						<select name="application_type" id="application_type" data-live-search="true" data-none-results-text="I found no results" title="Please select fruit" class="form-control selectpicker">
							<option value="Individual">Individual</option>
							<option value="Joint">Joint</option>
							<option value="Company">Company</option>
							
						</select>
                
              </div>

               <div class="col-md-6">
                <label for="job_number">Client Name</label>
                <input class="form-control" id="job_number"  name="job_number"  type="text" aria-describedby="nameHelp" value="<%= job_number%>" readonly>
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
