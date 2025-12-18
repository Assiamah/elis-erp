  <jsp:include page="../includes/_header.jsp"></jsp:include>
       

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Test Dashboard I</h1>
            <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Test Generate Report</a>
          </div>

        

       

           
        

        </div>
        <!-- /.container-fluid -->

    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
  
  
  
  
<!-- After Payment Summary============================= -->
<div class="modal fade" id="NotoncaseafterPaymentModalonCase"
	tabindex="-1" role="dialog" aria-labelledby="afterPaymentModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="afterPaymentModalLabel">After
					Payment(New Case)</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">

				<input type="hidden" id="txt_not_on_case_ap_main_service_id"
					name="txt_not_on_case_ap_main_service_id"> <input
					type="hidden" id="txt_not_on_case_ap_main_service_sub_id"
					name="txt_not_main_service_sub_id"> <input type="hidden"
					id="txt_not_on_case_ap_jn_id" name="txt_not_on_case_ap_jn_id"
					value="jn_id"> <input type="hidden"
					id="txt_not_on_case_ap_userid" name="txt_not_on_case_ap_userid"
					value="${userid}"> <input type="hidden"
					id="txt_not_on_case_ap_user_fullname" name="user_fullname"
					value="${fullname}">


				<div class="form-group">
					<div class="form-row">



						<div class="col-md-4">
							<label for="job_number">Case Number</label> <input
								class="form-control" id="txt_not_on_case_ap_case_number"
								name="txt_on_case_ap_case_number" type="text"
								aria-describedby="nameHelp" value="${case_number}" required>
						</div>
					</div>
				</div>



				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="main_service_desc">Main Service</label> <input
								class="form-control" id="txt_not_on_case_ap_main_service_desc"
								name="txt_not_on_case_ap_main_service_desc" type="text"
								aria-describedby="nameHelp" readonly>
						</div>
						<div class="col-md-6">
							<label for="main_service_sub_desc">Sub Service</label> <input
								class="form-control"
								id="txt_not_on_case_ap_main_service_sub_desc"
								name="txt_not_on_case_ap_main_service_sub_desc" type="text"
								aria-describedby="nameHelp" readonly>
						</div>
					</div>
				</div>


				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="client_name">Client Name</label> <input
								class="form-control" id="txt_not_on_case_ap_client_name"
								name="txt_not_on_case_ap_client_name" type="text"
								aria-describedby="nameHelp" readonly>
						</div>
						<div class="col-md-6">
							<label for="main_service_sub_desc">Land Size</label> <input
								class="form-control" id="txt_not_on_case_ap_land_size"
								name="txt_not_on_case_ap_land_size" type="text"
								aria-describedby="nameHelp" readonly>
						</div>
					</div>
				</div>


				<div class="row">
					<div class="col-lg-12">
						<!-- Example Bar Chart Card-->
						<div class="card mb-3">
							<div class="card-header">
								<i class="fa fa-bar-chart"></i>${main_service_desc} Check List
							</div>
							<div class="card-body">



								<!--  Here is where the fee list comes -->

								<div class="table-responsive">
									<table class="table table-bordered"
										id="tbl_not_on_case_after_payment_ap_checklist_dataTable"
										width="100%" cellspacing="0">
										<thead>
											<tr>
												<th>Description</th>
												<th>Option</th>

											</tr>
										</thead>
										<!-- <tfoot>
                <tr>
                  <th>uid</th>
                  <th>User Name</th>
                </tr>
              </tfoot> -->
										<tbody>



										</tbody>
									</table>
								</div>

								<!--  End Of Table -->
							</div>
							<div class="card-footer small text-muted">Updated yesterday
								at 11:59 PM</div>
						</div>


					</div>
				</div>






				<div class="row">
					<div class="col-lg-12">
						<!-- Example Bar Chart Card-->
						<div class="card mb-3">
							<div class="card-header">
								<i class="fa fa-bar-chart"></i>Bill And Payments
							</div>
							<div class="card-body">



								<!--  Here is where the fee list comes -->

								<div class="table-responsive">
									<table class="table table-bordered"
										id="tbl_not_on_case_ap_bills_payments_dataTable" width="100%"
										cellspacing="0">
										<thead>
											<tr>
												<th>Bill Number</th>
												<th>Bill Description</th>
												<th>Bill Amount</th>
												<th>Payment Amount</th>
												<th>Division</th>


											</tr>
										</thead>

										<tbody>


										</tbody>
									</table>
								</div>

								<!--  End Of Table -->
							</div>
							<div class="card-footer small text-muted">Updated yesterday
								at 11:59 PM</div>
						</div>


					</div>
				</div>



				<div class="row">
					<div class="col-lg-12">
						<!-- Example Bar Chart Card-->
						<div class="card mb-3">
							<div class="card-header">
								<i class="fa fa-bar-chart"></i>Parties to Transaction
							</div>
							<div class="card-body">








								<div class="form-row">
									<div class="col-md-3">
										<label for="search_value">ID Card Number</label> <input
											class="form-control" id="id_card_number_search"
											name="id_card_number_search" type="text"
											aria-describedby="nameHelp"
											placeholder="Enter ID Card Number" value="${case_number}">

									</div>

									<div class="col-md-1">
										<label for="search_value">-</label>
										<button class="form-control" type="button"
											id="btn_card_number_search" class="btn btn-primary">
											<i class="fa fa-object-group"></i>
										</button>
									</div>




								</div>


								<div class="form-row">
									<div class="col-md-4">
										<label for="search_value">Client ID</label> <input
											class="form-control" id="client_id_search"
											name="client_id_search" type="text"
											aria-describedby="nameHelp" value="${case_number}">
									</div>
									<div class="col-md-4">
										<label for="search_value">Party Type</label> <select
											name="client_type_search" id="client_type_search"
											data-live-search="true"
											data-none-results-text="I found no results"
											title="Please select fruit" class="form-control selectpicker">
											<option value="Applicant">Applicant</option>
											<option value="Grantor">Grantor</option>
											<option value="Depositor">Depositor</option>

										</select>
									</div>

									<div class="col-md-4">
										<label for="search_value">Add to Case</label>
										<button class="form-control" class="btn">
											<i class="fa fa-home"></i> Add to Case
										</button>
									</div>

								</div>

								<div class="form-row">
									<div class="col-md-8">
										<label for="search_value">Client Name</label> <input
											class="form-control" id="txt_not_on_case_bl_txt_ar_name"
											name="txt_not_on_case_bl_txt_ar_name" type="text"
											aria-describedby="nameHelp">
									</div>


									<div class="col-md-4">
										<label for="bl_job_number">Gender</label> <select
											name="txt_not_on_case_bl_txt_ar_gender"
											id="txt_not_on_case_bl_cbo_ar_gender" data-live-search="true"
											data-none-results-text="I found no results"
											title="Please select fruit" class="form-control selectpicker">
											<option value="Male">Male</option>
											<option value="Female">Female</option>
										</select>
									</div>

								</div>


								<div class="form-row">
									<div class="col-md-4">
										<label for="bl_job_number">Phone #</label> <input
											class="form-control " type="text"
											placeholder="Enter Phone Number"
											id="txt_not_on_case_bl_txt_ar_cell_phone">
									</div>
									<div class="col-md-4">
										<label for="bl_job_number">ID Type</label> <select
											name="txt_not_on_case_bl_cbo_ar_id_type"
											id="txt_not_on_case_bl_cbo_ar_id_type"
											data-live-search="true"
											data-none-results-text="I found no results"
											title="Please select fruit" class="form-control selectpicker">
											<option value="National ID">National ID</option>
											<option value="Drivers License">Drivers License</option>
											<option value="NHIS">NHIS</option>
											<option value="Passport">Passport</option>

										</select>
									</div>

									<div class="col-md-4">
										<label for="bl_job_number">ID Number</label> <input
											class="form-control " type="text" placeholder=""
											id="txt_not_on_case_bl_txt_ar_id_number">
									</div>

								</div>



								<div class="form-row">
									<div class="col-md-4">
										<label for="bl_job_number">Type of Party</label> <select
											name="txt_not_on_case_bl_cbo_type_of_party"
											id="txt_not_on_case_bl_cbo_type_of_party"
											data-live-search="true"
											data-none-results-text="I found no results"
											title="Please select fruit" class="form-control selectpicker">
											<option value="Applicant">Applicant</option>
											<option value="Grantor">Grantor</option>
											<option value="Depositor">Depositor</option>
										</select>
									</div>
									<div class="col-md-4">
										<label for="search_value">Save New Party</label>
										<button id="btn_not_on_case_add_new_party"
											class="form-control" class="btn">
											<i class="fa fa-home"></i>Save New Party
										</button>
									</div>

								</div>





								<div class="form-group"></div>





								<div class="form-row">
									<div class="col-md-4">LIst of Parties</div>



								</div>

								<!--  Here is where the fee list comes -->

								<div class="table-responsive">
									<table class="table table-bordered"
										id="tbl_not_on_case_client_details_datatable" width="100%"
										cellspacing="0">
										<thead>
											<tr>
												<th>ar_client_id</th>
												<th>ar_name</th>
												<th>ar_gender</th>
												<th>ar_cell_phone</th>
												<th>type_of_party</th>


											</tr>
										</thead>

										<tbody>



										</tbody>
									</table>
								</div>

								<!--  End Of Table -->
							</div>
							<div class="card-footer small text-muted">Updated yesterday
								at 11:59 PM</div>
						</div>


					</div>
				</div>




				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">

							<label for="client_name">locality</label> <input
								class="form-control" id="txt_not_on_case_ap_locality_of_parcel"
								name="txt_not_on_case_ap_locality_of_parcel" type="text"
								aria-describedby="nameHelp"
								placeholder="Enter locality_of_parcel" required>
						</div>
						<div class="col-md-6">
							<label for="type_of_interest">Type of Instrument</label> <select
								name="txt_not_on_case_ap_type_of_instrument"
								id="txt_not_on_case_ap_type_of_instrument"
								class="form-control input-sm" data-style="btn-info"
								data-live-search="true">
								<option value="-1">Select Type of Instrument</option>

							</select>

						</div>
					</div>
				</div>



				<div class="form-group">
					<div class="form-row">

						<div class="col-md-6">

							<label for="application_type">Application Type</label> <select
								name="txt_not_on_case_ap_application_type"
								id="txt_not_on_case_ap_application_type" data-live-search="true"
								data-none-results-text="I found no results"
								title="Please select fruit" class="form-control selectpicker">
								<option value="Individual">Individual</option>
								<option value="Joint">Joint</option>
								<option value="Company">Company</option>

							</select>

						</div>

						<div class="col-md-6">
							<label for="job_number">Ref No</label> <input
								class="form-control" id="txt_not_on_case_ap_job_number"
								name="txt_not_on_case_ap_job_number" type="text"
								aria-describedby="nameHelp" readonly>
						</div>

					</div>
				</div>



			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="button"
					id="btn_not_on_case_ap_generate_acknowledgement"
					class="btn btn-primary">Generate Acknowledgement Slip</button>
			</div>

		</div>
	</div>
</div>



 
 	   <!--  Service Bill============================= -->
	<div class="modal fade" id="addNewserviceBillModal" tabindex="-1" role="dialog" aria-labelledby="newValuationModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="addNewserviceBillModal">New Service Bill</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form id="from_add_valuation">
	        
	        	<input id="action_on_form_valuation" type="hidden" >
	        	
	        	
	        	  <div class="form-group">
          <label for="main_service">Main Service</label>
                  <select name="main_service_on_case" id="main_service_on_case" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                  <option value="-1">Select Main Service</option>
                <%--   <% 
                  try {
                	  
                	  Ws_client_application user_web_service = new Ws_client_application();
              		
              		String jsonArrayContent =null;
              		jsonArrayContent =user_web_service.get_list_of_services();			
              		//response.setContentType("application/json");
              		//response.getWriter().print(jsonArrayContent);
              		JSONArray jArr;
            		
            			jArr = new JSONArray(jsonArrayContent);
            			for (int i=0; i < jArr.length(); i++) {
                          JSONObject jsonObject = jArr.getJSONObject(i);
                          
                          String business_process_id = (String) jsonObject.getString("business_process_id");
                          String business_process_name = (String) jsonObject.getString("business_process_name");
                          %>
                      <option value="<%=business_process_id%>"><%=business_process_name%></option>
 
   <option value="<%=business_process_id + "-" + business_process_name%>"><%=business_process_name%></option> 
 
                          <% 
                          
                          
            			}
                  }
                  catch (Exception e){
                	  e.printStackTrace();
                  }
                  
                  %> --%>
                </select>
          </div>
           <div class="form-group">
          <label for="sub_service">Sub Service</label>
                  <select name="sub_service_on_case" id="sub_service_on_case" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                    <option value="-1">Select Sub Service</option>
               <%--    <% 
                  try {
                	 // String userName = request.getParameter("business_process_id");
                	  
                	  Ws_client_application user_web_service = new Ws_client_application();
              		
              		String jsonArrayContent =null;
              		jsonArrayContent =user_web_service.get_list_of_sub_services_new();			
              		//response.setContentType("application/json");
              		//response.getWriter().print(jsonArrayContent);
              		JSONArray jArr;
            		
            			jArr = new JSONArray(jsonArrayContent);
            			for (int i=0; i < jArr.length(); i++) {
                          JSONObject jsonObject = jArr.getJSONObject(i);
                          
                          String business_process_sub_id = (String) jsonObject.getString("business_process_sub_id");
                          String business_process_sub_name = (String) jsonObject.getString("business_process_sub_name");
                          %>
                          
                         <option value="<%=business_process_sub_id + "-" + business_process_sub_name %>"><%=business_process_sub_name%></option> 
     					 <option value="<%=business_process_sub_id %>"><%=business_process_sub_name%></option>
     
                          <% 
                          
                          
            			}
                  }
                  catch (Exception e){
                	  e.printStackTrace();
                  }
                  
                  %> --%>
                </select>
         	 </div>
	         
	           
         	 
        <div class="row">
		     <div class="col-lg-8">
		          <!-- Example Bar Chart Card-->
		          <div class="card mb-3">
		            <div class="card-header">
		              <i class="fa fa-bar-chart"></i>${main_service_desc}  Check List</div>
		            <div class="card-body">
		            
		         
		            
		             <!--  Here is where the fee list comes -->
		             
		             <div class="table-responsive">
		           <table class="table table-bordered" id="on_case_checlist_table_billdataTable" width="100%" cellspacing="0">
		              <thead>
		                <tr>
		                 <th>Description</th>
		                  <th>Option</th>
		                
		                 </tr>
		              </thead>
		              <tfoot>
		                <tr>
		                  <th>Description</th>
		                  <th>Option</th>
		                </tr>
		              </tfoot>
		             <tbody>
		               
		               
					     
		              </tbody> 
		            </table>
		          </div>
             
              <!--  End Of Table -->
            </div>
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
          </div>
          
      
      </div>
     </div>
          
          
          <div class="form-group">
		            <div class="form-row">
		                <label for="client_name">Client Name</label>
		                <input class="form-control" id="on_application_client_name"  name="on_application_client_name"  type="text" aria-describedby="nameHelp" placeholder="Enter Client Name" required>
		            </div>
         	 </div>
         	 
	         
	           <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" id="btn_save_to_generate_on_application" class="btn btn-primary">Save Changes</button>
		      </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	
		
	 <!-- After Payment Summary============================= -->
	<div class="modal fade" id="afterPaymentModalonCase" tabindex="-1" role="dialog" aria-labelledby="afterPaymentModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="afterPaymentModalLabel">After Payment Summary</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
					
					  	<input type="hidden" id="txt_on_case_ap_main_service_id" name="txt_on_case_ap_main_service_id" >
          <input type="hidden" id="txt_on_case_ap_main_service_sub_id" name="main_service_sub_id" >
           <input type="hidden" id="txt_on_case_ap_jn_id" name="txt_on_case_ap_jn_id" value="jn_id">
            <input type="hidden" id="txt_on_case_ap_userid" name="txt_on_case_ap_userid" value="${userid}">
            <input type="hidden" id="txt_on_case_ap_user_fullname" name="user_fullname" value="${fullname}">
            
            
             <div class="form-group">
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="job_number">Job Number</label>
				                <input class="form-control" id="txt_on_case_ap_job_number"  name="txt_on_case_ap_job_number"  type="text" aria-describedby="nameHelp" placeholder="Enter Job Number" required >
				              </div>
				              <div class="col-md-4">
				              <label for="search_btn">-</label>
				                <input type="button" id="btn_process_after_payment_on_case" class="btn btn-primary btn-block" value="Load Detais" />  
				                
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="job_number">Case Number</label>
				                <input class="form-control" id="txt_on_case_ap_case_number"  name="txt_on_case_ap_case_number"  type="text" aria-describedby="nameHelp" value="${case_number}" required >
				              </div>
				            </div>
					  </div>
					  
					  
           
		<div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="main_service_desc">Main Service</label>
                <input class="form-control" id="txt_on_case_ap_main_service_desc"  name="txt_on_case_ap_main_service_desc"  type="text" aria-describedby="nameHelp"  readonly>
              </div>
              <div class="col-md-6">
                <label for="main_service_sub_desc">Sub Service</label>
                <input class="form-control" id="txt_on_case_ap_main_service_sub_desc" name="txt_on_case_ap_main_service_sub_desc" type="text" aria-describedby="nameHelp"  readonly>
              </div>
            </div>
          </div>
          
          
           <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="client_name">Client Name</label>
                <input class="form-control" id="txt_on_case_ap_client_name"  name="txt_on_case_ap_client_name"  type="text" aria-describedby="nameHelp"  readonly>
              </div>
            <!--   <div class="col-md-6">
                <label for="main_service_sub_desc">Land Size</label>
                <input class="form-control" id="txt_on_case_ap_land_size" name="txt_on_case_ap_land_size" type="text" aria-describedby="nameHelp"  readonly>
              </div> -->
            </div>
          </div>
					
					
					    <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>${main_service_desc}  Check List</div>
            <div class="card-body">
            
         
            
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered" id="tbl_on_case_ap_checklist_dataTable" width="100%" cellspacing="0">
              <thead>
                <tr>
                 <th>Description</th>
                  <th>Option</th>
                
                 </tr>
              </thead>
              <!-- <tfoot>
                <tr>
                  <th>uid</th>
                  <th>User Name</th>
                </tr>
              </tfoot> -->
             <tbody>
               
  
			     
              </tbody> 
            </table>
          </div>
             
              <!--  End Of Table -->
            </div>
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
          </div>
          
      
      </div>
     </div>
     
     
     
          
          
          
             <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Bill And Payments</div>
            <div class="card-body">
            
         
            
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered" id="tbl_on_case_ap_bills_payments_dataTable" width="100%" cellspacing="0">
              <thead>
                <tr>
                 <th>Bill Number</th>
                  <th>Bill Description</th>
                   <th>Bill Amount</th>
                  <th>Payment Amount</th>
                   <th>Division</th>
                 
                
                 </tr>
              </thead>
              
             <tbody>
               
               
              </tbody> 
            </table>
          </div>
             
              <!--  End Of Table -->
            </div>
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
          </div>
          
      
      </div>
     </div>
          
          
          
               <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>New Parties to Transaction</div>
            <div class="card-body">
            
        
        
        		        <div class="form-group">
			        <label for="bl_ar_name">Name</label>
			        <textarea rows="2" class="form-control" placeholder="" id="txt_on_case_ap_ar_name"></textarea>
			        </div>
			        
			       
       
        
				            <div class="form-row">
				              <div class="col-md-6">
				                	  <label for="bl_job_number">Gender</label>
							        <select name="txt_on_case_ap_ar_gender" id="txt_on_case_ap_bl_cbo_ar_gender" data-live-search="true" data-none-results-text="I found no results" title="Please select fruit" class="form-control selectpicker">
										<option value="Male">Male</option>
										<option value="Female">Female</option>
									</select>				
				                </div>
				               
				              				               
				                 <div class="col-md-6">
				                <label for="bl_job_number">Phone #</label>
			     				<input class="form-control " type="text" placeholder="Enter Phone Number" id="txt_on_case_ap_ar_cell_phone">
			       
				               </div>
				               
				             
				            </div>
				            
				            
				            
				            <div class="form-row">
				              <div class="col-md-4">
				              			 <label for="bl_job_number">ID Type</label>
			       				 <select name="cbo_on_case_ap_ar_id_type" id="cbo_on_case_ap_ar_id_type" data-live-search="true" data-none-results-text="I found no results" title="Please select fruit" class="form-control selectpicker">
									<option value="National ID">National ID</option>
									<option value="Drivers License">Drivers License</option>
									<option value="NHIS">NHIS</option>
									<option value="Passport">Passport</option>
									
								</select>				
				                </div>
				                <div class="col-md-4">
				                <label for="bl_job_number">ID Number</label>
			       				 <input class="form-control " type="text" placeholder="" id="txt_on_case_ap_ar_id_number">
			      
								</div>
								
								 <div class="col-md-4">
								  <label for="bl_job_number">Type of Party</label>
							        <select name="cbo_on_case_ap_type_of_party" id="cbo_on_case_ap_type_of_party" data-live-search="true" data-none-results-text="I found no results" title="Please select fruit" class="form-control selectpicker">
										<option value="Motgagor">Motgagor</option>
										<option value="Objector">Objector</option>
										<option value="Depositor">Depositor</option>
									</select>
				                 </div>
				             
				            </div>
				            
         
            
            
           				<!-- 	 <div class="form-row">
				              <div class="col-md-4">
				                LIst of Parties						
				                </div>
				            
				            
				             
				            </div> -->
				            
             <!--  Here is where the fee list comes -->
          <!--    
             <div class="table-responsive">
           <table class="table table-bordered" id="client_details_datatable" width="100%" cellspacing="0">
              <thead>
                <tr>
                 <th>ar_client_id</th>
                 <th>ar_name</th>
                 <th>ar_gender</th>
                 <th>ar_cell_phone</th>
                <th>type_of_party</th>
              
                 
                 </tr>
              </thead>
              
             <tbody>
              
			     
              </tbody> 
            </table>
          </div> -->
             
              <!--  End Of Table -->
            </div>
          <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
          </div>
          
      
      </div>
     </div>
          
					  
	      </div>
	       <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" id="btn_on_case_ap_generate_acknowledgement" class="btn btn-primary">Generate Acknowledgement Slip</button>
		      </div>
	      
	    </div>
	  </div>
	</div>
	
