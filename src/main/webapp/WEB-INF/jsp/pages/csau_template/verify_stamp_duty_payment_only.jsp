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
            
            <button class="btn btn-info btn-icon-split pull-right " id="btnViewBatchlist">
				<span class="icon text-white-50"> <i class="fas fa-eye"></i></span>
				<span class="text">View Batch List</span>
			</button>
<!--             <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Test Generate Report</a>
 -->          </div>
          
    
          <hr>
          
          
        
        

       <div class="row">
     
     
     
     
    <!--   Here is the right Table -->
        <div class="col-lg-7">
          <!-- Example Pie Chart Card-->          
		 <div class="card mb-3">
            <div class="card-header">
            	<h3 class="text-primary">Verify Land Commission Bills</h1>
            </div>
           
            <div class="card-body"> 				     
	               <div class="form-group">
							<div class="form-row">
								<div class="col-sm-7">
									<input class="form-control" id="txt_ref_number_for_payment_rec" type="text" aria-describedby="Ref Number" placeholder="Enter Reference/Job Number" required="">
								</div>
								<div class="col-sm-5">
									<button class="btn btn-success btn-icon-split float-right  btn-lg" id="btn_load_bill_details_after_payment_stamp_duty" >
											<span class="icon text-white-50"> <i class="fa fa-search"></i></span><span class="text">Search </span>
										</button>
								</div>
							</div>
					</div>
					<div  id="payment_details_section"></div>			          
      		</div>
      
      	</div>
      </div>
      <div class="col-sm-5" id="document-section" style="display:none">
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsedocs" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Documents On Application
		            </a>
		        </h5>
		        <div id="collapsedocs" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
			         		  <button type="button" class="btn btn-primary" id="btn_load_scanned_documents" data-placement="top"  title="Load Docs">
					            <i class="fas fa-eye"></i>
					        </button>
					        
					         <!-- <button type="button" class="btn btn-primary" id="btn_add_document" data-toggle="modal" data-target="#fileUploadModal" title="Add Documents">
					            <i class="fa fa-plus-circle"></i>
					        </button> -->
					        
					      
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable" width="100%" class="display" cellspacing="0">
				           
				              <thead>
				                <tr>
				
				                 <th>Document Name</th>
				                 <th>Document Type</th>
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
		     <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsepudocs" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Public Documents
		            </a>
		        </h5>
		        <div id="collapsepudocs" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
			         		  <button type="button" class="btn btn-primary" id="btn_load_scanned_documents_public" data-placement="top"  title="Load Docs">
					            <i class="fas fa-eye"></i>
					        </button>
					        
					        <!-- <button type="button" class="btn btn-primary" id="btn_add_public_document" data-toggle="modal" data-target="#publicFileUploadModal" title="Add Public Documents">
					            <i class="fa fa-plus-circle"></i>
					        </button>  -->
					        
					        
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm data-table" id="lc_public_documents_dataTable" width="100%" class="display" cellspacing="0">
				           
				              <thead>
				                <tr>
				
				                 <th>Document Name</th>
				                 <th>Document Type</th>
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
		    
		    <button class="btn btn-primary float-right" id="btnPrintEgcr2" ><i class="fas fa-print "></i>Print eGCR</button>
      </div>
      
      
     </div>
      
       

           
        

        </div>
        <!-- /.container-fluid -->

    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
  
  
  
  

