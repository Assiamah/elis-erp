 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
  <jsp:include page="../includes/_header.jsp"></jsp:include>
 
   
  <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">ELIS Report</a>
        </li>
        <li class="breadcrumb-item active">Stamping Report User - ${fullname}</li>
         
             
      </ol>
     
           

        
      
       <div class="row">
     
     
     
     <div class="col-lg-6">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
			
           <div class="card-header">
				<h4 class='float-left'>
				<i class="fas fa-database"></i>Type of Report Selection</h4>
				
		</div>
            <div class="card-body">

			
			<div class="accordion" id="accordionExample">
			  <div class="card">
			    
			
			    <div id="collapsedrinksn" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
			      <div class="card-body">
			         
			         
					           
		<div class="form-group">
          <label for="type_of_report_name">Application Status</label>
			<select name="type_of_report_name_stpc"  id="type_of_report_name_stpc" class="form-control input-sm" data-style="btn-info" data-live-search="true">
        <option value="-1">Select Report Type</option>
        <option value="All">All Job Recieved</option>
				<option value="Completed">Completed Jobs</option>
				<option value="Pending">Pending Jobs</option>
        <option value="by_invoice_number">Invoice Number</option>
        <option value="assessed_but_not_paid">Assessed But Not Paid</option>
				<option value="assessed_and_paid">Assessed and Paid</option>     
        <option value="assessed_but_not_paid_by_applicant_name">Assessed But Not Paid By Applicant</option>
				<option value="assessed_and_paid_by_applicant_name">Assessed and Paid By Applicant</option>     
			</select>
         </div>

		
       <div class="form-group">
          <label for="main_service">Main Service</label>
                  <select name="main_service_rpt_stpc" id="main_service_rpt_stpc"   class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                  <option value="-1">Select Main Service</option>
                 
                  <c:forEach items="${main_services}" var="main_service">
                       
                   <c:if test="${main_service.business_process_id == '4'}">
                    <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option>  
                   </c:if> 
                   </c:forEach>


                 
                </select>
          </div>
           <div class="form-group">
          <label for="sub_service">Sub Service</label>
                  <select name="sub_service_rpt_stpc" id="sub_service_rpt_stpc" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                    <option value="-1">Select Sub Service</option>
                  
                </select>
           </div>
           
           

       <!--  <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
          -->
			
			     
			      </div>
			    </div>
			  </div>
			 
			 
			
			  
			 
			  
			  
			 
			</div>
			

            </div>
          
          </div>
          
         
        
    
   
        
      </div>
      
      
      
        <div class="col-lg-6">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           <div class="card-header">
				<h4 class='float-left'>
				<i class="fas fa-table"></i>Report Date Range</h4>
			
		</div>
            <div class="card-body">




			<div class="accordion" id="accordionExample">
			  <div class="card">
			    
			
			    <div id="collapsedrinksn" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
			      <div class="card-body">
			         
			         
					
					 
    <div class="form-group">
		<label >Date From</label>
		<input type="date" name="date_from_stpc" id="date_from_stpc" min="1000-01-01"   max="3000-12-31" class="form-control">
	 </div>
			 
		 <div class="form-group">
		<label >Date To</label>
		<input type="date" name="date_to_stpc" id="date_to_stpc" min="1000-01-01"   max="3000-12-31" class="form-control">
		 </div>


     	 
		 <div class="form-group">
      <label >Seach Value</label>
      <input type="text" name="ar_name_search_stpc" id="ar_name_search_stpc" class="form-control">
       </div>
		 <!-- <input type="submit" name="save" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"  value="Generate Report" />
  -->
			  <!-- 	<button type="button" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" 
				  id="btn_generate_details_reports" data-placement="top" data-toggle="tooltip" 
				  title="Search"><i class="fas fa-download fa-sm text-white-50"></i>Download Report Result</button> -->
				
				
				 <button type="button" class="d-none d-sm-inline-block btn btn-sm btn-info shadow-sm" 
				 id="btn_generate_details_reports_new_stpc" data-placement="top" data-toggle="tooltip" title="Search">
				 <i class="fas fa-download fa-sm text-white-50"></i>View Report Result</button>
				   
				   
				  
				  
     	  
         
			     
			      </div>
			    </div>
			  </div>
			  

			</div>
			

            </div>
          
          </div>
          
         
        
    
   
        
      </div>
      
      
  
      
     </div>
      
      
   
   
    <div class="row">
     
     
     
   
      
      
      
    <!--   Here is the right Table -->
        <div class="col-lg-12">
          <!-- Example Pie Chart Card-->
          
          
          
          
          <div id="accordion" role="tablist" aria-multiselectable="true">
		    
		  
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseparties" aria-expanded="false" aria-controls="collapseFive">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fa fa-cube"></i>Review
		            </a>
		        </h5>
		        <div id="collapseparties" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		                 
		                            <div class="table-responsive">
           <table class="table table-bordered table-hover datatable" id="job_casemgtdetailsdataTable_elis_reports_stpc" width="100%" cellspacing="0">
			<thead>
                <tr>
              <!--    <th style="">&nbsp;</th>
                 <th><input type="checkbox" id="selectAll"/></th> -->
                 <th>Job Number</th>
                 <th>Applicant Name</th>
                 <th>Application Type</th>
               	 <th>Date Received</th>
                 <th>Job Status</th>
                 <th>Assessed Value</th>
                 <th>Stamp Duty Payable</th>
                 <th>Ref Number</th>
       
                 <th>Bill Amount</th>
                 <th>Payment Date</th>
                 <th>Invoice Number</th>
                 <th>Payment Amount</th>
            
      

                
<!--           
                 <th class="to_hide_on_level_1">View</th> -->
                 
                 
                 
                 
                 <!-- 	<th data-field="customer.name" data-align="center" data-sortable="true">customer</th>
                    <th data-field="type" data-align="center" data-sortable="true">type</th>
                    <th data-field="description" data-align="center" data-sortable="true">description</th>
                    <th data-field="cutter" data-align="center" data-sortable="true">cutter</th> 
                    <th data-field="valid_s" data-align="center" data-sortable="true">valid</th>
                  -->
                 
                 </tr>
              </thead>
              
                <tbody>
    
            
             </tbody>
            
            
            </table>
          </div>
             
		                 
		              
		            </div>
		        </div>
		    </div>
		     <br>
		   
				 
		 
		    
		      
		    
	

		    
		</div>

      </div>
      
     </div>
      
   
   
   
      
    </div>
  


     
     
     
  
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
