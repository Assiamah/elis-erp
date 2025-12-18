<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
  <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
  <jsp:include page="../includes/_header.jsp"></jsp:include>
       

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Editing Application Service - ${fullname}</h1>
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
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsepocessingoncase" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i> Change of Service
		            </a>
		        </h5>
		        <div id="collapsepocessingoncase" class="show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

			   
				      
				                   <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				           <div class="card-header">
                            Change of Service
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
						      <div class="form-group">
								<div class="form-row">
									<div class="col">
										<!-- <button class="btn btn-secondary btn-icon-split float-left " id="btnAddNewUser"  data-toggle="modal" data-target="#createUserModal">
												<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text"> Add New </span>
											</button> -->
											
												<input  style="text-transform: uppercase;" class="form-control" id="txt_job_number_for_adding_case_and_status" name="txt_job_number_for_adding_case_and_status" type="text" aria-describedby="nameHelp" placeholder="Enter Job Number" required="">
									
										
									</div>
									<div class="col">
										<button class="btn btn-success btn-icon-split float-right  btn-lg" id="btn_job_number_for_change_of_job_service" >
												<span class="icon text-white-50"> <i class="fa fa-search"></i></span><span class="text">Search </span>
											</button>
											
											
									</div>
								</div>
								
									
							</div> 
						         
						         
						         
						    <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm" id="tbl_job_detail_dataTable" >
				           
				              <thead>
				                <tr>
				
				                 <th>Job Number</th>
				                 <th>Case Number</th>
				                 <th>Applicant Name</th>
				                 <!-- <th>Status</th> -->
				             
				               <!--   <th>Action</th> -->
				                 <th>Action</th>
								<!-- <th>Re-Submit</th> -->
				                </tr>
				              </thead>
				              
				                <tbody>
								    
				  				</tbody>
				    
								  
				            
				            </table>
				          </div>

                          <br>
                          <form id="frmChangeofService" method="post">
                          <div class="mt-2 row">

                            <div class="col-6 mt-2">
                                <label>Job Number:</label>
                                <input type="text" class="form-control" name="chs_job_number" id="chs_job_number" readonly />
                            </div>
                            <div class="col-6 mt-2">
                                <label>Applicant Name:</label>
                                <input type="text" class="form-control" name="chs_ar_name" id="chs_ar_name" readonly />
                            </div>
                            <br>
                            <div class="col-6 mt-2">
                                <label>Main Service:</label>
                                <input type="text" class="form-control" name="chs_business_process_name" id="chs_business_process_name" readonly />
                            </div>
                            <div class="col-6 mt-2">
                                <label>Sub Service:</label>
                                <select class="form-control" name="chs_business_process_sub_name" id="chs_business_process_sub_name">

                                </select>
                            </div>
                            <div class="col-6 mt-2">
                              <label>Comment: <span class="text-danger">*</span></label>
                              <!-- <select class="form-control" name="chs_comment" id="chs_business_process_sub_name" required>

                              </select> -->
                              <textarea class="form-control" name="chs_comment" id="chs_comment" required ></textarea>
                          </div>

                          </div>
                          <br>
                          <button class="btn btn-primary btn-block btn-lg float-right" id="btnSaveChangeOfService" style='display:none'>Save Changes</button>
				            
				            <!-- The form Ends Hers -->
				            </form>
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
		   
		   
		   
		 
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsedocs" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Reports
		            </a>
		        </h5>
		        <div id="collapsedocs" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
		        
		            </div>
		        </div>
		    </div>
		    <br>
		    
		    
		    
		    
		    
		      
		    
	

		    
		</div>

      </div>
      
     </div>
      
       

           
        

        </div>
        <!-- /.container-fluid -->

    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
  
  
  
  

