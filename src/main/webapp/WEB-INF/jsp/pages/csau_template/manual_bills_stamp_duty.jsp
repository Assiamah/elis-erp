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
            <h1 class="h3 mb-0 text-gray-800">LC ELIS - ${fullname}</h1>
            <button class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"
             data-backdrop="static" data-keyboard="false" 
             class="receiveDocument btn btn-danger btn-block  p-3 col"
             data-title="Generate Report" data-toggle="modal" data-target="#graRegionsReportModal" 
																			
            
            >
            <i class="fas fa-list fa-sm text-white-50"></i> Generate Report </button>
           </div>
          
    
          <hr>
          
          
        
        

       <div class="row">
     
     
     
     <div class="col-lg-7">
     
     
     
          <!-- Example Bar Chart Card-->
          
          
          <div class="card mb-3">
           
           
            <div class="card-body">
					<div class="card mb-3">
				           <div class="card-header">
				            <h1 class="text-primary">Create Stamp Duty Bills</h1>
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
				            
							<div class="form-group">
								<div class="form-row">
								
									<div class="col">
										
											
											
											<form method="post" id="generateManualStampDutyBillForm"  >
                               

				                                
				                                
				                                
				                                
				                                 <div class="form-group row d-none">
				                  
				                					  <div class="col">
													  <label>Service Type</label> 
													  <select class="form-control input-sm" readonly  id="stp_main_service_cp" name="stp_main_service_cp">
													  	<option value="411-APPLICATION FOR STAMP DUTY PAYMENT" selected>APPLICATION FOR STAMPING</option>
													  </select> 
													  
													  </div>
				                					  
				                					  <div class="col">
													     <label>Sub Service</label>  
													      <select class="form-control input-sm" readonly  name="stp_sub_service_cp" id="stp_sub_service_cp" >
													  	<option value="411-STAMP DUTY PAYMENT" selected>STAMP DUTY PAYMENT</option>
													  </select>   
																	
													  </div>
				                  
				              					  </div>
				                                
				                                
				                                <div class="form-group row">
				                  
				                					  <div class="col">
													  <label>Applicant Name</label>
													    <input type="text" class="form-control" placeholder="Applicant Name"  id="stp_applicant_name" >
													  </div>
				                					  
				                					  <div class="col">
													     <label>Stamp Duty Amount</label>
				                                    <input class="form-control" type="text" id="stp_bill_amount" name="stp_bill_amount" placeholder="0.00">
													  </div>
				                  
				              					  </div>
				                                
				                              
				                                <div class="form-group row">
				                  
				                  
				                					
													  
													    <div class="col">
													   <label>Document/Job Number</label>
				                                    <input class="form-control" type="text" id="stp_bill_description" name="stp_bill_description" placeholder="">
													  </div>
													  
													   <div class="col">
													   <label>&nbsp;&nbsp;</label><br>
													   <button type="button"
																id="btn_generate_stamp_duty_bill"
																class="btn btn-block btn-primary "
															>Generate Stamp Duty Bills</button>
													  </div>
				                  
				              					  </div>
				                            
															<div class="form-group">
																
																<iframe src=""  id="stpbillblobfile" width="100%" height="300"></iframe>
											
															</div>
				                                
				                                
				                                
				                                
				                              
				                                
				                                 
				                              </form>
										
									</div>
									<!-- <div class="col">
										<button class="btn btn-success btn-icon-split float-right  btn-lg" id="btnFindClientDetails"  >
												<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">Search </span>
											</button>
											
											
											
									</div> -->
								</div>
								
									
							</div>
				             
				             
						         
						               
				    
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>

	 
	    
      
				  

 
      

      
            
          
            </div>
          
          </div>
          
         
        
    
   
        
      </div>
      
      
      
      
    <!--   Here is the right Table -->
        <div class="col-lg-5">
          <!-- Example Pie Chart Card-->
          
          
          
          	    
		  
		 <div class="card mb-3">
           
           
            <div class="card-body"> 
		  
		  
		  
	
		  
		  
		   
          
          
          
          <div id="accordion" role="tablist" aria-multiselectable="true">
		   
		   
		   
		 
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsedocs" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <h2><i class="fas fa-check"></i>Verify Payments</h2>
		            </a>
		        </h5>
		        <div id="collapsedocs" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               <div class="form-group">
								<div class="form-row">
									<div class="col">
										
										<input class="form-control" id="txt_ref_number_for_payment" name="txt_ref_number_for_payment" type="text" aria-describedby="nameHelp" placeholder="Enter Reference Number" required="">

									</div>
									<div class="col">
										<button class="btn btn-success btn-icon-split float-right  btn-lg" id="btn_load_bill_details_after_payment_stamp_duty_csau" >
												<span class="icon text-white-50"> <i class="fa fa-search"></i></span><span class="text">Search </span>
											</button>
											
											
									</div>
								</div>
								
									
							</div>
							
							<div  id="payment_details_section">
					           
					            
					            
				          	
				          	
						</div>
		        
		            </div>
		            
		            
		            
		        </div>
		    </div>
		    <br>
		    
		    
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
		    
		    
		    
		    
		    
		      
		    
	

		    
		</div>

      </div>
      
      </div></div>
      
     </div>
      
       

           
        

        </div>
        <!-- /.container-fluid -->

    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
  
  
  
  

