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
            <h1 class="h3 mb-0 text-gray-800">GRA Dashboard - ${fullname}</h1>
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
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Stamp Duty Payment-New
		            </a>
		        </h5>
		        <div id="collapseacknowledgeofterPayment" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

			   	          
				          <div class="form-row">
				      
				     
				     
				      		      
				              <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				           <div class="card-header">
				          Stamp Duty Payment-New
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
						      <div class="form-group">
								<div class="form-row">
									<div class="col">
										<!-- <button class="btn btn-secondary btn-icon-split float-left " id="btnAddNewUser"  data-toggle="modal" data-target="#createUserModal">
												<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text"> Add New </span>
											</button> -->
											
												<input class="form-control" id="txt_ref_number_for_payment_gra" name="txt_ref_number_for_payment_gra" type="text" aria-describedby="nameHelp" placeholder="Enter Reference Number" required="">

									</div>
									<div class="col">
										<button class="btn btn-success btn-icon-split float-right  btn-lg" id="btn_load_bill_details_after_payment_gra" >
												<span class="icon text-white-50"> <i class="fa fa-search"></i></span><span class="text">Search </span>
											</button>
											
											
									</div>
								</div>
								
									
							</div>
						         
						         
						         
						   <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm" id="bill_for_payment_list_dataTable_gra" >
				           
				              <thead>
				                <tr>
				                
				                 <th>Ref No.</th>
				                 <th>Name</th>
				                 <th>Amount</th>
				          		<th>Pay Bill</th> 
				                 
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
				      
				      
				      
				        <div class="form-row">
				      
				     
				     
				      		      
				              <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				           <div class="card-header">
				         Stamp Duty Payment-Old
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
						      <div class="form-group">
								<div class="form-row">
									<div class="col">
										<!-- <button class="btn btn-secondary btn-icon-split float-left " id="btnAddNewUser"  data-toggle="modal" data-target="#createUserModal">
												<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text"> Add New </span>
											</button> -->
											
												<input class="form-control" id="txt_ref_number_for_payment_gra_old" name="txt_ref_number_for_payment_gra_old" type="text" aria-describedby="nameHelp" placeholder="Enter Job Number" >

									</div>
									<div class="col">
										<button class="btn btn-success btn-icon-split float-right  btn-lg" id="btn_load_bill_details_after_payment_gra_old" >
												<span class="icon text-white-50"> <i class="fa fa-search"></i></span><span class="text">Search </span>
											</button>
											
											
									</div>
								</div>
								
									
							</div>
						         
						         
						         
						   <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm" id="bill_for_payment_list_dataTable_gra_old" >
				           
				              <thead>
				                <tr>
				                
				                 <th>Ref No.</th>
				                 <th>Name</th>
				                 <th>Amount</th>
				          		<th>Pay Bill</th> 
				                 
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
  
  
  
  
  

