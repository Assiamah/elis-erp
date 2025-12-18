
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="../includes/_header.jsp"></jsp:include>







    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">Professional Memebership</a>
        </li>
        <li class="breadcrumb-item active">Dashboard - ${fullname}</li>
         
             
      </ol>
     
           
      
       <!-- Content Row -->
          <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Total Job</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">${job_available_count}</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Bills Unpaid</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">${bills_unpaid_count}</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Paid Bills ready foor Processing</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${bills_paid_count}</div>
                        </div>
                        <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            
              <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Request From Clients</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${bills_paid_count}</div>
                        </div>
                       
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pending Requests Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Pending Requests</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">${fullname}</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
      
      
        
      
       <div class="row">
     
     
     
     <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           <div class="card-header">
				<h4 class='float-left'>
				<i class="fas fa-stamp"></i>Professional Templates - ${fullname}</h4>
				<%-- <form action="${pageContext.request.contextPath}/client_application" >
				
				<button type="submit"  class="btn btn-primary btn-icon-split float-right" >
				<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Back</span>
				</button>
				</form> --%>
		</div>
            <div class="card-body">


   <div class="card">

		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseclientservicerequest" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Service Request from Client (${bills_unpaid_count})
		            </a>
		        </h5>
		        <div id="collapseclientservicerequest" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

				      
				          
				      
				      
				      
				      
				      
				      		      
				              <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				           <div class="card-header">
				            Bills Yet to be Paid
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
						         
						                  <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm" id="bills_unpaidlist_dataTable" >
				           
				              <thead>
				                <tr>
				
				                 <th>Ref Number</th>
				                 <th>Applicant Name</th>
				                 <th>Service Type</th>
				                 <th>Bill Amount</th>
				                 <th>Application Region</th>
				                 <th>Action</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
								     <c:forEach items="${bills_unpaidlist}" var="application_munites_row">
								                <tr>
								                    <td>${application_munites_row.ref_number}</td>
								                  <td    data-toggle="tooltip" data-placement="top" title="${fn:length(application_munites_row.lessees_name) >20 ? application_munites_row.lessees_name : ''}"> ${fn:substring(application_munites_row.lessees_name, 0, 20)}
								                    	${fn:length(application_munites_row.lessees_name) >20 ? "..." : ""}
								                    </td>
								                    <td    data-toggle="tooltip" data-placement="top" title="${fn:length(application_munites_row.business_process_sub_name) >20 ? application_munites_row.business_process_sub_name : ''}"> ${fn:substring(application_munites_row.business_process_sub_name, 0, 20)}
								                    	${fn:length(application_munites_row.business_process_sub_name) >20 ? "..." : ""}
								                    </td>
								                    <td>${application_munites_row.bill_amount}</td>
								                     <td>${application_munites_row.regional_name}</td>
								                   <td><p data-placement="top" data-toggle="tooltip" title="Batch">
								                    	<button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${application_munites_row.am_id}">
								                    	<span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span>
								                    	</button></p></td>
								                 </tr>
								            </c:forEach>
				  				</tbody>
				    
				            
				            </table>
				          </div>
				    
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      
				      
				      
				     <!--    </div>
				      
				       -->
				      
				      
				          
					        
		                
		            </div>
		        </div>
		    </div>
      
				  
				     


 <br>   

 
      	    <div class="card">

		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsemaincase" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Unpaid Bills (${bills_unpaid_count})
		            </a>
		        </h5>
		        <div id="collapsemaincase" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

				      
				          
				      
				      
				      
				      
				      
				      		      
				              <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				           <div class="card-header">
				            Bills Yet to be Paid
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
						         
						                  <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm" id="bills_unpaidlist_dataTable" >
				           
				              <thead>
				                <tr>
				
				                 <th>Ref Number</th>
				                 <th>Applicant Name</th>
				                 <th>Service Type</th>
				                 <th>Bill Amount</th>
				                 <th>Application Region</th>
				                 <th>Action</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
								     <c:forEach items="${bills_unpaidlist}" var="application_munites_row">
								                <tr>
								                    <td>${application_munites_row.ref_number}</td>
								                  <td    data-toggle="tooltip" data-placement="top" title="${fn:length(application_munites_row.lessees_name) >20 ? application_munites_row.lessees_name : ''}"> ${fn:substring(application_munites_row.lessees_name, 0, 20)}
								                    	${fn:length(application_munites_row.lessees_name) >20 ? "..." : ""}
								                    </td>
								                    <td    data-toggle="tooltip" data-placement="top" title="${fn:length(application_munites_row.business_process_sub_name) >20 ? application_munites_row.business_process_sub_name : ''}"> ${fn:substring(application_munites_row.business_process_sub_name, 0, 20)}
								                    	${fn:length(application_munites_row.business_process_sub_name) >20 ? "..." : ""}
								                    </td>
								                    <td>${application_munites_row.bill_amount}</td>
								                     <td>${application_munites_row.regional_name}</td>
								                   <td><p data-placement="top" data-toggle="tooltip" title="Batch">
								                    	<button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${application_munites_row.am_id}">
								                    	<span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span>
								                    	</button></p></td>
								                 </tr>
								            </c:forEach>
				  				</tbody>
				    
				            
				            </table>
				          </div>
				    
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      
				      
				      
				     <!--    </div>
				      
				       -->
				      
				      
				          
					        
		                
		            </div>
		        </div>
		    </div>
      
				  
				     


 <br>   


    
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingTwo">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseprocessedbills" aria-expanded="false" aria-controls="collapseTwo">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-clipboard"></i>Bills Ready to be Processed (${bills_paid_count})
		            </a>
		        </h5>
		        <div id="collapseprocessedbills" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
		            <div class="card-body">
		                
		              
		                  
				      		      
				              <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				           <div class="card-header">
				            Bills Ready to be Processed
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
						         
						                  <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm" id="lrd_scanned_documents_dataTable" >
				           
				              <thead>
				                <tr>
				
				                 <th>Ref Number</th>
				                 <th>Applicant Name</th>
				                 <th>Service Type</th>
				                 <th>Bill Amount</th>
				                 <th>Application Region</th>
				                 <th>Action</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
								     <c:forEach items="${bills_paidlist}" var="application_munites_row">
								                <tr>
								                    <td>${application_munites_row.ref_number}</td>
								                    
													<td    data-toggle="tooltip" data-placement="top" title="${fn:length(application_munites_row.lessees_name) >20 ? application_munites_row.lessees_name : ''}"> ${fn:substring(application_munites_row.lessees_name, 0, 20)}
								                    	${fn:length(application_munites_row.lessees_name) >20 ? "..." : ""}
								                    </td>
								                    <td    data-toggle="tooltip" data-placement="top" title="${fn:length(application_munites_row.business_process_sub_name) >20 ? application_munites_row.business_process_sub_name : ''}"> ${fn:substring(application_munites_row.business_process_sub_name, 0, 20)}
								                    	${fn:length(application_munites_row.business_process_sub_name) >20 ? "..." : ""}
								                    </td>
								                 
								                    <td>${application_munites_row.bill_amount}</td>
								                     <td>${application_munites_row.regional_name}</td>
								                   <td><p data-placement="top" data-toggle="tooltip" title="Batch">
								                    	<button 
								                    	class="btn btn-info btn-icon-split" 
								                    	data-title="Delete" data-toggle="modal" 
								                    	data-target="#NotoncaseafterPaymentModalonCaseProfessional" 
								                    	data-target-id="${application_munites_row.ref_number}"
								                    	data-ref_number="${application_munites_row.ref_number}">
								                    	<span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span>
								                    	</button></p></td>
								                 </tr>
								            </c:forEach>
				  				</tbody>
				    
				    
				            
				            </table>
				          </div>
				    
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      
		            </div>
		        </div>
		    </div>
		    <br>



          
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingTwo">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseappdetails" aria-expanded="false" aria-controls="collapseTwo">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-clipboard"></i>Job Available (${job_available_count})
		            </a>
		        </h5>
		        <div id="collapseappdetails" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
		            <div class="card-body">
		                
		             
				      		      
				              <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				           <div class="card-header">
				            Jobs Available
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
						         
					          <div class="table-responsive">
           <table class="table table-bordered data-table" id="job_detailsdataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                 
                 <th>Job Number</th>
                 <th>Applicant Name</th>
                 <th>Application Type</th>
               <!--   <th style="display:none">Status</th> -->
                 <!-- <th>Status</th> -->
                
                 <th>Status</th>
                
                 <th>Track</th>
               

                 
                 </tr>
              </thead>
              
                <tbody>
    
            		
                  <c:forEach items="${applicationlist}" var="appfiles">
                <tr ${appfiles.objections > 0 ? "class='bg-danger text-white red-tooltip' title='Application has pending Objections'  data-toggle='tooltip' data-placement='left' ":""}>
                    <td >${appfiles.job_number}</td>
                    
                    
                    
                    
                    <td    data-toggle="tooltip" data-placement="top" title="${fn:length(appfiles.ar_name) >20 ? appfiles.ar_name : ''}"> ${fn:substring(appfiles.ar_name, 0, 20)}
                    	${fn:length(appfiles.ar_name) >20 ? "..." : ""}
                    </td>
                    
                     <td >${appfiles.business_process_sub_name}</td>
                     
                    <td data-toggle="tooltip" data-placement="top"  title="${fn:length(appfiles.current_application_status) >20 ? appfiles.current_application_status : ''}">${fn:substring(appfiles.current_application_status, 0, 20)} 
                    	${fn:length(appfiles.current_application_status) >20 ? "..." : ""}
                    </td>
                    
                    <td>
                    	<button 
                    		class="btn btn-info btn-icon-split" 
                    		data-title="Delete" 
                    		id="btnAddToBatchlist-${appfiles.job_number}" 
                    		data-job_number="${appfiles.job_number}" 
                    		data-ar_name="${appfiles.ar_name}"  
                    		data-business_process_id="${appfiles.business_process_id}"
                    		data-business_process_sub_id="${appfiles.business_process_sub_id}"
                    		data-business_process_sub_name="${appfiles.business_process_sub_name}" 
                    		data-target="#applicationStatusChecking" data-toggle="modal" >
                    		<span class="icon text-white-50"> <i class="fas fa-list"></i></span>
                    		<span class="text">Track</span>
                    	</button>
                    	
                    	
                    </td>
                
           
                    
                   
                     
                    
                    </tr>
            </c:forEach>
            
            
             </tbody>
            
            
            </table>
          </div>
				    
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      
		            </div>
		        </div>
		    </div>
		    <br>
          
					          
					   

      
            
          
            </div>
          
          </div>
          
         
        
    
   
        
      </div>
      
      
      
      
    <!--   Here is the right Table -->
        <div class="col-lg-4">
          <!-- Example Pie Chart Card-->
          
          
          
          	    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapselistofservices" aria-expanded="false" aria-controls="collapseFive">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fa fa-users"></i>List Of Services
		            </a>
		        </h5>
		        <div id="collapselistofservices" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		               
		                
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="list_of_main_service_dataTable" >
				           
				              <thead>
				                <tr>
				
				                <th>Main Service</th>
				              
				                </tr>
				              </thead>
				              
				                <tbody>
							        <c:forEach items="${professional_main_service_list}" var="parties_row">
						                <tr>
						                   
						                  <td>
						                    	<button 
						                    		class="btn btn-info btn-icon-split" 
						                    		data-title="Delete" 
						                    		id="AddNewServiceProfessional-${appfiles.job_number}" 
				
						                    		data-business_process_id="${parties_row.business_process_id}"  
						                    		data-business_process_name="${parties_row.business_process_name}" 
						                    		data-target="#addNewserviceBillModalProfessional" data-toggle="modal" >
						                    		<span class="icon text-white-50"> <i class="fas fa-list"></i></span>
						                    		<span class="text">${parties_row.business_process_name}</span>
						                    	</button>
						                    	
						                    	
						                    </td>
						                 
						                 </tr>
						            </c:forEach>
				  				</tbody>
				    
				            
				            </table>
				          </div>
		            </div>
		        </div>
		    </div>
		     <br>
          
          
          
          
          
          <div id="accordion" role="tablist" aria-multiselectable="true">
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingOne">
		            <a data-toggle="collapse" data-parent="#accordion" href="#collapsejobs" aria-expanded="true" aria-controls="collapseOne" class="d-block">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-info-circle"></i>Search By Jobs and Cases
		            </a>
		        </h5>
		
		        <div id="collapsejobs" class="collapse" role="tabpanel" aria-labelledby="headingOne">
		            <div class="card-body">
		               
		               <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#addNewserviceBillModalonCase" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit" data-backdrop="static" data-keyboard="false">
                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Add New Service</span>
                    	</button>
                    	
                    	 
		               <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#afterPaymentModalonCase" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit" data-backdrop="static" data-keyboard="false">
                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Acknowledge</span>
                    	</button>
                    	
                    	
                    	
		                <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm " data-group-by="true" data-group-by-field="job_number" id="lrd_scanned_documents_dataTable" >
				              <thead  class="table-success">
				                <tr >
				                 <th>Transaction Number</th>
				                 <th>Applicant Name</th>
				                <!--  <th>Current Status</th> -->
				                
				                  </tr>
				              </thead>
				              
				                <tbody>
								     <c:forEach items="${case_details}" var="case_row">
								                <tr>
								                    <td>${case_row.transaction_number}</td>
								                    <td>${case_row.ar_name}</td>
								                   <%--  <td>${job_row.current_application_status}</td> --%>
								                </tr>
								     </c:forEach>
				  				</tbody>
				    		 </table>
				        </div>
		            </div>
		        </div>
		    </div>
		    <br>
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseparties" aria-expanded="false" aria-controls="collapseFive">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fa fa-users"></i>Payment History
		            </a>
		        </h5>
		        <div id="collapseparties" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		                 
					         <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addeditparty" data-toggle="tooltip" title="Add New Party">
					            <i class="fa fa-plus-circle"></i>
					        </button>
		                
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lrd_scanned_documents_dataTable" >
				           
				              <thead>
				                <tr>
				
				                <th>Name</th>
				                <th>Gender</th>
				                <th>Contact</th>
				                <th>Role</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							        <c:forEach items="${parties}" var="parties_row">
						                <tr>
						                    <td>${parties_row.ar_name}</td>
						                    <td>${parties_row.ar_gender}</td>
						                    <td>${parties_row.ar_cell_phone}</td>
						                    <td>${parties_row.type_of_party}</td>
						                 </tr>
						            </c:forEach>
				  				</tbody>
				    
				            
				            </table>
				          </div>
		            </div>
		        </div>
		    </div>
		     <br>
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingTwo">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseminutes" aria-expanded="false" aria-controls="collapseTwo">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-clipboard"></i>Subscription History
		            </a>
		        </h5>
		        <div id="collapseminutes" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
		            <div class="card-body">
		                
		                 <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addMinutesModal" data-toggle="tooltip" title="Add Minutes" data-backdrop="static" data-keyboard="false">
		            		<i class="fa fa-plus-circle"></i>
		       			 </button>
		                <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm" id="lrd_scanned_documents_dataTable" >
				           
				              <thead>
				                <tr>
				
				                 <th>Description</th>
				                 <th>From</th>
				                 <th>To</th>
				                 <th>Date</th>
				                 <th>Action</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
								     <c:forEach items="${application_munites}" var="application_munites_row">
								                <tr>
								                    <td>${application_munites_row.am_description}</td>
								                    <td>${application_munites_row.ar_name}</td>
								                    <td>${application_munites_row.am_to_officer}</td>
								                    <td>${application_munites_row.am_activity_date}</td>
								                    <td><p data-placement="top" data-toggle="tooltip" title="Batch">
								                    	<button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${application_munites_row.am_id}">
								                    	<span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Batch</span>
								                    	</button></p></td>
								                 </tr>
								            </c:forEach>
				  				</tbody>
				    
				            
				            </table>
				          </div>
		            </div>
		        </div>
		    </div>
		    <br>
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsedocs" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Reports
		            </a>
		        </h5>
		        <div id="collapsedocs" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
			         		  <button type="button" class="btn btn-primary" id="btn_load_scanned_documents" data-placement="top"  data-toggle="tooltip" title="Load Docs">
					            <i class="fa fa-eye"></i>
					        </button>
					        
					         <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#fileUploadModal" data-toggle="tooltip" title="Upload New Documents" data-backdrop="static" data-keyboard="false">
					            <i class="fa fa-plus-circle"></i>
					        </button>
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable" width="100%" cellspacing="0">
				           
				              <thead>
				                <tr>
				
				                 <th>Document Name</th>
				                 <th>Document Type</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							    <c:forEach items="${casescanneddocuments}" var="casescanneddocuments_row">
				                <tr>
				                    <td>${casescanneddocuments_row.document_name}</td>
				                    <td>${casescanneddocuments_row.document_type}</td>
				                 
					                    <td>
											<form action="open_pdffile" method="post">
												<input type="hidden" name="document_path" id="document_path" value="${casescanneddocuments_row.document_file}">
													<button type="submit" name="save" class="btn btn-info btn-icon-split" >
													<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Opn</span>
													</button>
											</form>
										</td>
	
				                    </tr>
			           			 </c:forEach>
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