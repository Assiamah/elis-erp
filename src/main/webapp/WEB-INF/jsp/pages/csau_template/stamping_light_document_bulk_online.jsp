  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
  <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
  <jsp:include page="../includes/_header.jsp"></jsp:include>
       

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Bulk Stamping Light Documents Dashboard - ${fullname}</h1>
<!--             <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Test Generate Report</a>
 -->          </div>
          
    <!--       <div class="row">

           
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Total Job Processed Today</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">0</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

           
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Bills Processed Today</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">9</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

           
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Paid Bills ready for Processing</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">0</div>
                        </div>
                       
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">8</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            
             
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-danger shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Accounts Created Today</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">0</div>
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

            
          </div> -->
          <hr>
          
          
        
        

       <div class="row">
     
     
     
     <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           <%-- <div class="card-header">
				<h4 class='float-left'>
				<i class="fas fa-stamp"></i>Front Desk Templates - ${fullname}</h4>
				<form action="${pageContext.request.contextPath}/client_application" >
				
				<button type="submit"  class="btn btn-primary btn-icon-split float-right" >
				<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Back</span>
				</button>
				</form>
		</div> --%>
            <div class="card-body">


	   
  
  
   <div class="card">

		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseacknowledgeofterPayment" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Bulk Stamping Light Document
		            </a>
		        </h5>
		        <div id="collapseacknowledgeofterPayment" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

			   	          
				          <div class="form-row">
				      
				     
				     
				      		      
				              <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				           <div class="card-header">
				           Regional Number
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
				                       
						      <div class="form-group">
								
								<div class="row">
			<div class="col-lg-6">
				<!-- Example Bar Chart Card-->
				<div class="card mb-3">
					<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i>Service Selection
					</div>
					<div class="card-body">
						<form action="${pageContext.request.contextPath}/bill_switcher"
							method="post">


							<div class="form-group">
								<!-- <label for="main_service">Main Service</label> -->
								<select id="main_service_cp" class="form-control input-sm" readonly>
									
									<option value="4.0-APPLICATION FOR STAMPING" selected>APPLICATION FOR STAMPING</option>
									<!-- <option value="-1">Select Main Service</option> -->
									
               <%--  <c:forEach items="${main_services}" var="main_service">
                  
               
                   <c:if test="${main_service.business_process_on_case == 'No'}"> 
                          <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option> 
			                  
			                    </c:if>  

			                     
			                  </c:forEach> --%>
									
								</select>
							</div>
							<div class="form-group">
								<!--  <label for="sub_service">Sub Service</label> -->
								<select name="sub_service_cp" id="sub_service_cp"
									class="form-control input-sm" readonly>
									<option value="16-APPLICATION FOR STAMPING(NON LANDED DOCUMENTS)">APPLICATION FOR STAMPING(NON LANDED DOCUMENTS)</option>
									<!-- <option value="-1">Select Sub Service</option> -->
									
								</select>
							</div>

							
						</form>

					</div>
					<!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
				</div>



			</div>




	<!--   Here is the right Table -->
			<div class="col-lg-6">
				<!-- Example Pie Chart Card-->
				<div class="card mb-3">
					<div class="card-header bg-dark text-white">
						<i class="fa fa-pie-chart"></i>Bill Generations
					</div>
					<div class="card-body">
						<!--  The Form starts here -->
						<%--  <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
 --%>
						<div class="form-group">
									<!--   <label for="job_number">Job Number</label> -->
									
								
								
							<div class="form-row">
				              <div class="col-md-6">
				               <input class="form-control" id="txt_brn_bill_application_qty"
										name="job_number" type="text" aria-describedby="nameHelp"
										placeholder="Quantity" required>
										
				              </div>
				                <div class="col-md-6">
				               <button class="btn btn-primary btn-block"
										id="btn_brn_generate_bill">
										<span
											class="text" >Generate Bill</span>
									</button>
				              </div>
				              
				             
				            </div>
								
								
									<div class="form-row">

							<div class="col-md-12">
								<label for="locality">Office Region</label> <select
									name="new_bill_application_office_region_reg_no"
									id="new_bill_application_office_region_reg_no"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">Select Office Region</option>
									
									<c:forEach items="${officeregionlist}" var="officeregion">
										<option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
							  </c:forEach>
			 
								</select>

							</div>
						</div>
						
						
						
						<div class="form-row">

							<div class="col-md-12">
			
									<label for="new_type_of_revenue_item">Type of Revenue
									Item</label> <select name="new_type_of_revenue_item_t"
									id="new_type_of_revenue_item_t" class="form-control input-sm"
									data-style="btn-info" data-live-search="true"
								>
									<option value="-1">Select Type of Use</option>
									<c:forEach items="${lvdrevenuelist}" var="lvdrevenue">
										<option  value="${lvdrevenue.rv_item_id}-${lvdrevenue.revenue_items_name}">${lvdrevenue.revenue_items_name}</option>
							 		</c:forEach>
			 
								</select>

							</div>
						</div>
							
							
								
					</div>
				</div>
				<!--   Here is the end of right table -->

			</div>
		
				

			</div>
			
			
			
			<!--   Here is the right Table -->
			<div class="col-lg-6">
				<!-- Example Pie Chart Card-->
				<div class="card mb-3">
					<div class="card-header bg-dark text-white">
						<i class="fa fa-pie-chart"></i>Client's Details
					</div>
					<div class="card-body">
						<!--  The Form starts here -->
						<%--  <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
 --%>
						<div class="form-group">
									<!--   <label for="job_number">Job Number</label> -->
									
								
								
							<div class="form-row">
				              <div class="col-md-8">
				               <input class="form-control" id="txt_brn_licenced_number"
										name="job_number" type="text" aria-describedby="nameHelp"
										placeholder="Enter  Number" required>
										
				              </div>
				                <div class="col-md-4">
				               <button class="btn btn-primary btn-block"
										id="btn_brn_client_number_search">
										<span
											class="text" >Search</span>
									</button>
				              </div>
				              
				             
				            </div>
								
								
								
								
								   <div class="form-row">
				              <div class="col-md-6">
				                <label for="txt_brn_licenced_name">Name </label>
				                <input  id="txt_brn_licenced_name" class="form-control" type="text" aria-describedby="nameHelp"   >
				              </div>
				                
				                <div class="col-md-6">
				                <label for="search_value">Client</label>
				                <input  class="form-control" id="txt_brn_client_status_new"  type="text" aria-describedby="nameHelp"  readonly >
				              </div>
				             
				            </div>
								
					</div>
				</div>
				<!--   Here is the end of right table -->

			</div>
		
				

			</div>
			
			
				<!--   Here is the right Table -->
			<div class="col-lg-6">
				<!-- Example Pie Chart Card-->
				<div class="card mb-3">
					<div class="card-header bg-dark text-white">
						<i class="fa fa-pie-chart"></i>Process Acknowledgement
					</div>
					<div class="card-body">
						<!--  The Form starts here -->
						<%--  <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
 --%>
						<div class="form-group">
									<!--   <label for="job_number">Job Number</label> -->
									
								
								
							<div class="form-row">
				              <div class="col-md-8">
				               <input class="form-control" id="txt_ref_number_for_brn"
										name="txt_ref_number_for_brn" type="text" aria-describedby="nameHelp"
										placeholder="Enter Reference Number" required>
										
				              </div>
				               
				               <div class="col-md-4">
				                <button type="button" class="btn btn-primary"  id="btn_load_bill_details_after_payment_bulk_regional_number"  data-toggle="tooltip" title="CHECK BILL Status">
										            <i class="fa fa-search-dollar"></i>
										        </button>
				              </div>
				             
				            </div><br><br>
								
								
								
								
								   <div class="form-row">
				              
				               <div class="col-auto">
				                <button type="button" class="btn btn-icon-split btn-info btn-lg"  id="btn_upload_regional_by_csv" data-placement="top" data-toggle="modal" data-target="#filefileRegionalNumberUploadModal" data-toggle="tooltip" title="Upload CSV">
										           <span class="icon text-white-50"> <i class="fas fa-file-upload"></i></span>
										           <!-- <span class="text">Upload Data</span> -->
										        </button>
				              </div>
				              
				              <div class="col">
				               <button class="btn btn-success btn-icon-split float-right  btn-lg" id="btn_process_bulk_regional_number" >
												<span class="icon text-white-50"> <i class="fas fa-search"></i></span><span class="text">Process Data</span>
								</button>
				              </div>
				                
				                
				             
				            </div>
								
					</div>
				</div>
				<!--   Here is the end of right table -->

			</div>
		
				

			</div>
						
							
									
							</div>
				             
						
						         
						         
						         
						   <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm" id="bulk_regional_number_list_dataTable_smd" >
				           
				              <thead>
				                <tr>
				                <th>ID</th>
				                <th>Applicant Name</th>
				                <th>Locality</th>
				                <th>Gender</th>
				          		<th>District</th> 
				          		<th>Region</th> 
				                 
				                  </tr>
				              </thead>
				              
				                <tbody>
								
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
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fa fa-users"></i>Instructions
		            </a>
		        </h5>
		        <div id="collapselistofservices" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		               
		       
		            </div>
		        </div>
		    </div>
		  
		  
		  
		  
		  
	
		  
		  
		    <br>
          
          
          
          <div id="accordion" role="tablist" aria-multiselectable="true">
		   
		   
		   
		 
		    
		    <br>
		    
		    
		    
		    
		    
		      
		    
	

		    
		</div>

      </div>
      
     </div>
      
       

           
        

        </div>
        <!-- /.container-fluid -->

    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
  
  
  
  

