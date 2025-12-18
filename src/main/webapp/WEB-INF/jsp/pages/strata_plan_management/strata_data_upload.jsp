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
            <h1 class="h3 mb-0 text-gray-800">Rent Management Upload- ${fullname}</h1>
          </div>
          
          <hr>
          
          
        
        

       <div class="row">
     
     
     
     <div class="col-lg-12">
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
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Bulk Rent Data
		            </a>
		        </h5>
		        <div id="collapseacknowledgeofterPayment" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

			   	          
						<div class="form-group">


							<div class="form-row">

								<div class="col-md-6">
									<label for="locality">Office Region</label> <select
										name="rnt_upload_office_region"
										id="rnt_upload_office_region"
										class="form-control input-sm" data-style="btn-info"
										data-live-search="true"
									>
										<option value="-1">Select Office Region</option>
									
										<c:forEach items="${officeregionlist}" var="officeregion">
											<option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
								  </c:forEach>
				 
									</select>
	
								</div>

								<div class="col-md-6">
									<label for="locality">Estate</label> <select
										name="rnt_upload_eatate"
										id="rnt_upload_eatate"
										class="form-control input-sm" data-style="btn-info"
										data-live-search="true"
									>
									<option selected disabled value="">-- select --</option>
																
									<c:forEach items="${estate_list}" var="estateList">
										<option  value="${estateList.ge_id}">${estateList.ge_location_name}</option>
									  </c:forEach>
									</select>
	
								</div>
							</div>
								


								
							<div class="form-row">
							
							  
				                <div class="col-md-6">
									<!-- <label for="locality">--</label> -->
									<button type="button" class="btn btn-icon-split btn-info btn-lg"  id="btn_upload_rent_by_csv" data-placement="top" data-toggle="modal" data-target="#fileRentUploadModal" data-toggle="tooltip" title="Upload CSV">
										<span class="icon text-white-14"> <i class="fas fa-file-upload"></i></span>
										<!-- <span class="text">Upload Data</span> --> Upload CSV
									 </button>
				              </div>

							  <div class="col-md-6">
								<!-- <label for="locality">--</label> -->
								<button type="button" class="btn btn-icon-split btn-info btn-lg"  id="btn_process_rent_data_by_csv"  title="Process Rent Data">
									<span class="icon text-white-14"> <i class="fas fa-file-upload"></i></span>
									<!-- <span class="text">Upload Data</span> --> Process Rent Data
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
				           <table class="table table-bordered table-hover table-sm" id="bulk_rent_data_list_dataTable_smd" >
				           


				              <thead>
				                <tr>
				                <th>owners_name</th>
				                <th>address</th>
				                <th>file_number</th>
				                <th>ledger</th>
				          		<th>folio</th> 
				          		<th>plot_number</th> 
								<th>plot_size</th>
				                <th>covenanted_user</th>
				          		<th>current_use</th> 
				          		<th>nature_of_devt</th> 
								<th>ls_number</th>
				                <th>nature_of_instrument</th>
				          		<th>comm_date</th> 
				          		<th>term</th> 
                                <th>consent_date</th>
				                <th>rent_review_clause</th>
				          		<th>rent_passing</th> 
				          		<th>period_in_arrears</th> 
								<th>previous_rent_review_clause</th> 
				                 
				            </tr>
				              </thead>
				              
				                <tbody>
								
				  				</tbody>
				    
				            
				            </table>
				          </div>
				    
				    
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
     
     </div>
      
       

           
        

        </div>
        <!-- /.container-fluid -->

    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
  
  
  
  

