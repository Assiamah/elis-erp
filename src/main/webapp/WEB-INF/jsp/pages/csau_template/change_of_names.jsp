  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
  <%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
  <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
  <jsp:include page="../includes/_header.jsp"></jsp:include>
       

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Editing of Application Details by - ${fullname}</h1>
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
            <div class="card-body">
				<!-- <div class="card">

		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsepocessingoncase" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i> Generate Bills for changing Application details
		            </a>
		        </h5>
		        <div id="collapsepocessingoncase" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

			   
				      
				                   <div class="col-lg-12">
				          Example Pie Chart Card
				          <div class="card mb-3">
				           <div class="card-header">
				          Processing on Case
				            </div>
				            <div class="card-body">
				                The Form starts here
				             
						      <div class="form-group">
								<div class="form-row">
									<div class="col">
										<button class="btn btn-secondary btn-icon-split float-left " id="btnAddNewUser"  data-toggle="modal" data-target="#createUserModal">
												<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text"> Add New </span>
											</button>
											
												<input  style="text-transform: uppercase;" class="form-control" id="txt_job_number_for_adding_case_and_status" name="txt_job_number_for_adding_case_and_status" type="text" aria-describedby="nameHelp" placeholder="Enter Job Number" required="">
									
										
									</div>
									<div class="col">
										<button class="btn btn-success btn-icon-split float-right  btn-lg" id="btn_job_number_for_adding_name_change_bill" >
												<span class="icon text-white-50"> <i class="fa fa-search"></i></span><span class="text">Search </span>
											</button>
											
											
									</div>
								</div>
								
									
							</div>
						         
						         
						         
						    <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm" id="tbl_job_detail_dataTable_nameChange" >
				           
				              <thead>
				                <tr>
				
				                 <th>Job Number</th>
				                 <th>Case Number</th>
				                 <th>Applicant Name</th>
				                 <th>Locality</th>
				                 <th>Regional Number</th>
				                 <th>Status</th>
				             
				                 <th>Action</th>
				                 <th>New Bill</th>
				                  <th>Transitional Bill</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
								    
				  				</tbody>
				    
				    
				            
				            </table>
				          </div>
				    
				            
				            The form Ends Hers
				            
				          </div>
				         
				        </div>
				        Here is the end of right table
				  
				      </div>
				      
				      
				      
				      
		                
		            </div>
		        </div>
 </div>	<br> -->

			<div class="card">

		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseacknowledgeofterPayment" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Acknowledge after Payment
		            </a>
		        </h5>
		        <div id="collapseacknowledgeofterPayment" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

			   	          
				          <div class="form-row">
				      
				     
				     
				      		      
				              <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				           <div class="card-header">
				           Initiate Payment for a Bill
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
						      <div class="form-group">
								<div class="form-row">
									<div class="col">
										<!-- <button class="btn btn-secondary btn-icon-split float-left " id="btnAddNewUser"  data-toggle="modal" data-target="#createUserModal">
												<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text"> Add New </span>
											</button> -->
											
												<input class="form-control" id="chng_ref_number_for_payment" name="chng_ref_number_for_payment" type="text" aria-describedby="nameHelp" placeholder="Enter Reference Number" required="">

									</div>
									<div class="col">
										<button class="btn btn-success btn-icon-split float-right  btn-lg" id="btn_load_bill_details_after_payment_change_of_names" >
												<span class="icon text-white-50"> <i class="fa fa-search"></i></span><span class="text">Search </span>
											</button>
											
											
									</div>
								</div>
								
									
							</div>
						         
						         
						         
						   <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm" id="bill_for_payment_list_dataTable_change_of_name" >
				           
				              <thead>
				                <tr>
				                
				                 <th>Ref No.</th>
				                 <th>Name</th>
				                 <th>Amount</th>
				          		<!-- <th>Pay Bill</th> --> 
				                 <th>Acknowledge</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
								
				  				</tbody>
				    
								  
				            </table>
				          </div>
				          
				          <form id="frmChangeofNames" method="post">
				               <div class="row bg-light" style="padding:40px 20px">
				               
				                <input type="hidden" id="new_bill_application_transaction">
				                  <div class="col-sm-6 col-xs-6">
				                     <div class="form-group">
				                     	<label>Applicant Name(s)</label>
				                       <textarea class="form-control" id="ch_ar_name" rows="8" required></textarea>
				                     </div>
					              </div>
					              <div class="col-sm-6 col-xs-6">
					                    <!-- <div class="row">
					                    	<div class=""></div>
					                    </div> -->
					                  <div class="form-group">
						                    <label for="region">Region</label> 
						                    <select id="new_bill_application_region" class="form-control input-sm">
												<option value="-1">Select Region</option>
												<c:forEach items="${regionlist}" var="region">
													<option  value="${region.region_id}">${region.region_name}</option>
										  </c:forEach>
										  <!-- <c:forEach items="${officeregionlist}" var="officeregion">
											<option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
										</c:forEach> -->
						 
											</select>
				                     </div>
				                     <div class="form-group">
				                     	<label for="disitrict">District</label> 
				                     	<select id="new_bill_application_district" class="form-control input-sm" >
											<option value="-1">Select District</option>
										</select>
				                     </div>
				                     <div class="form-group">
				                     	<label for="locality">Locality</label> 
				                     	<select id="new_bill_application_locality" class="form-control input-sm" >
											<option value="-1">Select Locality</option>
											<c:forEach items="${localitylist}" var="locality">
												<option  value="${locality.location_name}">${locality.location_name}</option>
									 </c:forEach>
					 
										</select>
				                     </div>
				                  </div>
				                  <br>
				                  <button class="btn btn-primary btn-block btn-lg float-right" id="btnSaveChangeOfNames" style='display:none'>Save Changes</button>
				               </div>
		                </form>
		               
				    
				    
				            
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
		                
		               
		               
		               
		               
		               
		               
		       <!--   <form action="http://localhost:8080/lccorporate/Login" method="post">
				
				
				  <input type="hidden" id="username" name="username"  value="jecd@gmail.com">
				    <input type="hidden" id="password" name="password"  value="win">
				<button type="submit"  class="btn btn-primary btn-icon-split float-right" >
				<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Back</span>
				</button>
				</form> -->
		               

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
  
  
  
  
  

