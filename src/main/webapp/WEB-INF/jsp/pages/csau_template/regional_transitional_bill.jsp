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
<!--             <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Test Generate Report</a>
 -->          </div>
          
    
          <hr>
          
          
        
        

       <div class="row">
     
     
     
     <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           
            <div class="card-body">
				<div class="card mb-3">
				           <div class="card-header">
				            Create Regional Transitional Bills
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
				            
							<div class="form-group">
								<div class="form-row">
									<div class="col">
									
									
									<div class="card mb-3">
				           <div class="card-header">
				            Search for Clients
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
				             
				               <div class="form-group">
								<!-- <label for="main_service">Main Service</label> -->
								<input placeholder="Email/Phone Number" id="client_by_email_phone_search_mb" class="form-control input-sm" data-style="btn-info" type="text" />
									
									
							</div>
							<div class="form-group">
								<div class="form-row">
									<div class="col">
										<!-- <button class="btn btn-secondary btn-icon-split float-left " id="btnAddNewUser" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#createUserModal">
												<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text"> Add New </span>
											</button>							 -->
									</div>
									<div class="col">
										<button class="btn btn-success btn-icon-split float-right  btn-lg" id="btnFindClientDetailsRegionalTransitionalBill"  >
												<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">Search </span>
											</button>
									</div>
								</div>									
							</div>
				             
				             
						         
						   <div  class="table-responsive">
				           	<table class="table table-bordered table-hover table-sm" id="clientsearchlistRegionalTransitionalBill_dataTable" >
				           
				              <thead>
				                <tr>
				                 <th>Name</th>
				                 <th>Email</th>
				                 <th>Account Type</th>
				                 <th>Phone</th>
				                 <th>Address</th>
				                 <th>New Bill</th>
				                </tr>
				              </thead>
				              <tbody></tbody>
				    		</table>
				          </div>
				            
				          </div>
				         
				        </div>
			
										<!-- <button class="btn btn-secondary btn-icon-split float-left " id="btnAddNewManualBill" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#generateManualBillModal">
												<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text"> Add New Manual Bill </span>
											</button> -->
										
									</div>
								</div>
								
									
							</div>
				             
				             
						         
						               
				    
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>

	 
	    
      
				  

 
      

      
            
          
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
  
  
  
  
  

