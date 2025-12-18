<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>



<div class="modal fade" id="graRegionsReportModal" tabindex="-1" role="dialog"
	aria-labelledby="collectionModal" aria-hidden="true">
	<div class="modal-dialog modal-fullscreen ">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Reports on Stamp Duty</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
			
			<ul class="nav nav-tabs" id="myTab" role="tablist">
			  <li class="nav-item">
			    <a class="text-uppercase nav-link active" id="home-tab" data-toggle="tab" href="#tab_gra_payments" role="tab"
			     aria-controls="tab_gra_payments" aria-selected="true">STAMP DUTY PAYMENTS</a>
			  </li>
			  <li class="nav-item">
			    <a class="text-uppercase nav-link" id="profile-tab" data-toggle="tab" href="#tab_gra_received" 
			    role="tab" aria-controls="profile" aria-selected="false">Verified and Received Documents</a>
			  </li>
			 
			</ul>
			<div class="tab-content" id="myTabContent">
			  <div class="tab-pane fade show active" id="tab_gra_payments" role="tabpanel" aria-labelledby="payments-tab">
			  <br>
			  	<div class="row">
					<div class="col-lg-3">
						<div class="card">
							<div class="card-header bg-white">
								Filter
			
							</div>
							<div class="card-body">
								<form method="post" id="frmStampDutyFilter" >
								
			
										<div class="form-group">
											<label>Date</label>
											<div class="input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"><i
														class="fa fa-calendar-alt"></i></span>
												</div>
												<input type="date" class="form-control" required
													data-inputmask-alias="datetime"
													data-inputmask-inputformat="dd/mm/yyyy" data-mask name="md_date_from" id="md_date_from" >
											</div>
										</div>
										<div class="form-group ">
											<div class="input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"><i
														class="far fa-calendar-alt"></i></span>
												</div>
												<input type="date" class="form-control" required
													data-inputmask-alias="datetime"
													data-inputmask-inputformat="dd/mm/yyyy" data-mask name="md_date_to" id="md_date_to" >
											</div>
										</div>
										
										
					
										<br><br>
										<div class="form-group">
											<button type = "submit" class="btn btn-dark btn-block">Apply Filter</button>
										</div>
								</form>
							</div>
						</div>
					</div>
			
					<div class="col-lg-9">
			
			
						<div class="row">
							<div class="col col-6">
								<!-- Card -->
								<div class="card ">
									<div class="card-body">
			
										<h3 id="gra_tatal_amount">GHS 0.00</h3>
										<p>Total Amount</p>
			
									</div>
								</div>
							</div>
			
							<div class="col col-6">
								<!-- Card -->
								<div class="card ">
									<div class="card-body">
			
										<h3 id="gra_tatal_count">0</h3>
										<p>Total Payment Count</p>
			
									</div>
								</div>
							</div>
						</div>
						<!-- /.row -->
						<br>
						<div class="card">
							<div class="card-header bg-white">Stamp Duty Revenue</div>
							<div class="card-body">
								<!-- <div id="main-echart" style="width: 100%; height:500px;"></div> -->
								<div class="table-responsive" >
									<table class="table table-bordered table-hover table-sm data-table-" id="tbl_stamp_duty_result">
										<thead>
											<tr>
												<th>Payment Date</th>
												<th>Bill Number</th>
												<th>Payment Ref</th>
												<th>Applicant</th>
												<th>Amount</th>
												<th>Payment Mode </th>
												<th>Related Job</th>
											</tr>
										</thead>
										<tbody>
											
										</tbody>
									</table>
								</div>
							</div>
						</div>
						
			
			
					</div>
					<!-- col -->
				</div>
			  
			  
			  
			  </div>
			  <div class="tab-pane fade" id="tab_gra_received" role="tabpanel" aria-labelledby="confirm-tab">
			  
			  		<br>
				  	<div class="row">
						<div class="col-lg-3">
							<div class="card">
								<div class="card-header bg-white">
									Filter
				
								</div>
								<div class="card-body">
									<form method="post" id="frmStampDutyRecFilter" >
									
				
											<div class="form-group">
												<label>Date</label>
												<div class="input-group">
													<div class="input-group-prepend">
														<span class="input-group-text"><i
															class="fa fa-calendar-alt"></i></span>
													</div>
													<input type="date" class="form-control" required
														data-inputmask-alias="datetime"
														data-inputmask-inputformat="dd/mm/yyyy" data-mask name="mr_date_from" id="mr_date_from" >
												</div>
											</div>
											<div class="form-group ">
												<div class="input-group">
													<div class="input-group-prepend">
														<span class="input-group-text"><i
															class="far fa-calendar-alt"></i></span>
													</div>
													<input type="date" class="form-control" required
														data-inputmask-alias="datetime"
														data-inputmask-inputformat="dd/mm/yyyy" data-mask name="mr_date_to" id="mr_date_to" >
												</div>
											</div>
											
											
						
											<br><br>
											<div class="form-group">
												<button type = "submit" class="btn btn-dark btn-block">Apply Filter</button>
											</div>
									</form>
								</div>
							</div>
						</div>
				
						<div class="col-lg-9">
				
				
							<div class="row">
								<!-- <div class="col col-6">
									Card
									<div class="card ">
										<div class="card-body">
				
											<h3 id="gra_tatal_amount">GHS 0.00</h3>
											<p>Total Amount</p>
				
										</div>
									</div>
								</div> -->
				
								<div class="col col-6">
									<!-- Card -->
									<div class="card ">
										<div class="card-body">
				
											<h3 id="gra_tatal_rec_count">0</h3>
											<p>Total Documents Payment Confirmed</p>
				
										</div>
									</div>
								</div>
							</div>
							<!-- /.row -->
							<br>
							<div class="card">
								<div class="card-header bg-white">Stamp Duty Documents Confirmed after Payment</div>
								<div class="card-body">
									<!-- <div id="main-echart" style="width: 100%; height:500px;"></div> -->
									<div class="table-responsive" >
										<table class="table table-bordered table-hover table-sm data-table-" id="tbl_stamp_duty_confirmed_result">
											<thead>
												<tr>
													<th>Confirmed Date</th>
													<th>Bill Number</th>
													<th>Confirmed By</th>
													<th>Related Job</th>
												</tr>
											</thead>
											<tbody>
												
											</tbody>
										</table>
									</div>
								</div>
							</div>
							
				
				
						</div>
						<!-- col -->
					</div>
				  
			  
			  </div>
			</div>
			
			
			
			
			
			
	
			                 
		

			</div>
			   <div class="modal-footer">
							<button type="button" class="btn btn-google btn-user btn-block"
								data-dismiss="modal">Close</button>
							
						
		</div>
	</div>
</div>

</div>





<!-- COLLECTION DETAILS============================= -->

<div class="modal fade" id="createUserModal" tabindex="-1" role="dialog" 
	aria-labelledby="collectionModal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Create New Applicant Account</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
		
			<form method="post"   class="user" id="signUpForm" >
			<div class="modal-body">
                                 <!-- <div class="form-group">
                                    <label>Account Type</label>    
                                    <select class="custom-select mb-1" id="account" name="account">
                                       <option>Individual</option>
                                      

                                    </select>
                                 </div>    -->
                                 
                                 <!-- 
                                 <div class="form-group row">
                  
                					  <div class="col">
									  
									  </div>
									  
									   <div class="col">
									  
									  </div>
                  
              					  </div> -->

                                 <div class="form-group">
                                    <!-- <label>Name</label>
                                    <input class="form-control form-control-lg" type="text" id="cl_name" name="cl_name" placeholder="" required="">
                                    <small id="nameError" class="form-text text-danger "></small> -->
                                    
                                    
                                    <div class="row">
                                      <div class="col">
                                       <label>First Name *</label>
									    <input type="text" class="form-control" placeholder="First name" id="cl_first_name" required>
									  </div>
									  <div class="col">
									 <label>Last Name *</label>
									    <input type="text" class="form-control" placeholder="Last name" id="cl_last_name" required>
									 
									 
									  </div>
									  
									  
									</div>
                                 </div>
                                
                                
                                
                                
                                <div class="form-group row">
                  
                					  <div class="col">
									  <label>Other Names</label>
									    <input type="text" class="form-control" placeholder="Other name"  id="cl_other_names" >
									  </div>
                					  
                					  <div class="col">
									     <label>Gender</label>    
                                    <select class="form-control selectpicker " id="cl_gender" name="cl_gender" required>
                                       <option value="">Select Gender</option>
                                       <option value="Male">Male</option>
                                       <option value="Female">Female</option> 
                                       <option value="Couple">Couple</option>
                                       <option value="Multiple">Multiple</option>
                                       <option value="Company">Company</option>
                                    </select>
                                    <small id="genderError" class="form-text text-danger "></small>
									  </div>
                  
              					  </div>
                                
                              
                              
                            
              					  
                                 <div class="form-group">
                                    <label>TIN</label>
                                    <input class="form-control" type="text" id="cl_tin" name="tin" placeholder="tax identification number">
                                    <!--<small id="tinError" class="form-text text-danger "></small>-->
                                 </div>
                                
                                 <div class="form-group row">
                  
                					  <div class="col">
									      <label>ID Type*</label>    
                                    <select class="custom-select mb-1" id="cl_id_type" name="idType" required>
                                       <option></option>
                                       <option>National ID</option>
                                       <option>Ghana Card</option>
                                       <option>Passport</option>
                                       <option>Drivers License</option>
                                       <option>Voters ID</option>
                                       <option>NHIS</option>
                                    </select>
                                    <small id="idTypeError" class="form-text text-danger "></small>
									  </div>
									  
									   <div class="col">
									   <label>ID Number*</label>
                                    <input class="form-control" type="text" id="cl_id_number" name="idNum" placeholder="" required>
                                    <small id="idNumError" class="form-text text-danger "></small>
									  </div>
                  
              					  </div>
                                
                                
                                <div class="form-group row">
                  
                					  <div class="col">
											  <label>Email*</label>
		                                    <input class="form-control" type="text" id="cl_email" name="cl_email" placeholder="" required>
		                                    <small id="emailError" class="form-text text-danger "></small>
									  </div>
									  
									   <div class="col">
									  <label>Country</label>    
                                    <select class="custom-select mb-1" id="cl_country" name="cl_country" required>
                                       <option>Ghana</option>
                                       <option>Afghanistan</option>
                                       <option>Albania</option>
                                       <option>Algeria</option>
                                       <option>Andorra</option>
                                       <option>Angola</option>
                                       <option>Antigua and Barbuda</option>
                                       <option>Argentina</option>
                                       <option>Armenia</option>
                                       <option>Australia</option>
                                       <option>Austria</option>
                                       <option>Azerbaijan</option>
                                       <option>The Bahamas</option>
                                       <option>Bahrain</option>
                                       <option>Bangladesh</option>
                                       <option>Barbados</option>
                                       <option>Belarus</option>
                                       <option>Belgium</option>
                                       <option>Belize</option>
                                       <option>Benin</option>
                                       <option>Bhutan</option>
                                       <option>Bolivia</option>
                                       <option>Bosnia and Herzegovina</option>
                                       <option>Botswana</option>
                                       <option>Brazil</option>
                                       <option>Brunei</option>
                                       <option>Bulgaria</option>
                                       <option>Burkina Faso</option>
                                       <option>Burundi</option>
                                       <option>Cambodia</option>
                                       <option>Cameroon</option>
                                       <option>Canada</option>
                                       <option>Cape Verde</option>
                                       <option>Central African Republic</option>
                                       <option>Chad</option>
                                       <option>Chile</option>
                                       <option>China</option>
                                       <option>Colombia</option>
                                       <option>Comoros</option>
                                       <option>Congo, Republic of the</option>
                                       <option>Congo, Democratic Republic of the</option>
                                       <option>Costa Rica</option>
                                       <option>Cote d'Ivoire</option>
                                       <option>Croatia</option>
                                       <option>Cuba</option>
                                       <option>Cyprus</option>
                                       <option>Czech Republic</option>
                                       <option>Denmark</option>
                                       <option>Djibouti</option>
                                       <option>Dominica</option>
                                       <option>Dominican Republic</option>
                                       <option>East Timor (Timor-Leste)</option>
                                       <option>Ecuador</option>
                                       <option>Egypt</option>
                                       <option>El Salvador</option>
                                       <option>Equatorial Guinea</option>
                                       <option>Eritrea</option>
                                       <option>Estonia</option>
                                       <option>Ethiopia</option>
                                       <option>Fiji</option>
                                       <option>Finland</option>
                                       <option>France</option>
                                       <option>Gabon</option>
                                       <option>The Gambia</option>
                                       <option>Georgia</option>
                                       <option>Germany</option>
                                       <option>Ghana</option>
                                       <option>Greece</option>
                                       <option>Grenada</option>
                                       <option>Guatemala</option>
                                       <option>Guinea</option>
                                       <option>Guinea-Bissau</option>
                                       <option>Guyana</option>
                                       <option>Haiti</option>
                                       <option>Honduras</option>
                                       <option>Hungary</option>
                                       <option>Iceland</option>
                                       <option>India</option>
                                       <option>Indonesia</option>
                                       <option>Iran</option>
                                       <option>Iraq</option>
                                       <option>Ireland</option>
                                       <option>Israel</option>
                                       <option>Italy</option>
                                       <option>Jamaica</option>
                                       <option>Japan</option>
                                       <option>Jordan</option>
                                       <option>Kazakhstan</option>
                                       <option>Kenya</option>
                                       <option>Kiribati</option>
                                       <option>Korea, North</option>
                                       <option>Korea, South</option>
                                       <option>Kosovo</option>
                                       <option>Kuwait</option>
                                       <option>Kyrgyzstan</option>
                                       <option>Laos</option>
                                       <option>Latvia</option>
                                       <option>Lebanon</option>
                                       <option>Lesotho</option>
                                       <option>Liberia</option>
                                       <option>Libya</option>
                                       <option>Liechtenstein</option>
                                       <option>Lithuania</option>
                                       <option>Luxembourg</option>
                                       <option>Macedonia</option>
                                       <option>Madagascar</option>
                                       <option>Malawi</option>
                                       <option>Malaysia</option>
                                       <option>Maldives</option>
                                       <option>Mali</option>
                                       <option>Malta</option>
                                       <option>Marshall Islands</option>
                                       <option>Mauritania</option>
                                       <option>Mauritius</option>
                                       <option>Mexico</option>
                                       <option>Micronesia, Federated States of</option>
                                       <option>Moldova</option>
                                       <option>Monaco</option>
                                       <option>Mongolia</option>
                                       <option>Montenegro</option>
                                       <option>Morocco</option>
                                       <option>Mozambique</option>
                                       <option>Myanmar (Burma)</option>
                                       <option>Namibia</option>
                                       <option>Nauru</option>
                                       <option>Nepal</option>
                                       <option>Netherlands</option>
                                       <option>New Zealand</option>
                                       <option>Nicaragua</option>
                                       <option>Niger</option>
                                       <option>Nigeria</option>
                                       <option>Norway</option>
                                       <option>Oman</option>
                                       <option>Pakistan</option>
                                       <option>Palau</option>
                                       <option>Panama</option>
                                       <option>Papua New Guinea</option>
                                       <option>Paraguay</option>
                                       <option>Peru</option>
                                       <option>Philippines</option>
                                       <option>Poland</option>
                                       <option>Portugal</option>
                                       <option>Qatar</option>
                                       <option>Romania</option>
                                       <option>Russia</option>
                                       <option>Rwanda</option>
                                       <option>Saint Kitts and Nevis</option>
                                       <option>Saint Lucia</option>
                                       <option>Saint Vincent and the Grenadines</option>
                                       <option>Samoa</option>
                                       <option>San Marino</option>
                                       <option>Sao Tome and Principe</option>
                                       <option>Saudi Arabia</option>
                                       <option>Senegal</option>
                                       <option>Serbia</option>
                                       <option>Seychelles</option>
                                       <option>Sierra Leone</option>
                                       <option>Singapore</option>
                                       <option>Slovakia</option>
                                       <option>Slovenia</option>
                                       <option>Solomon Islands</option>
                                       <option>Somalia</option>
                                       <option>South Africa</option>
                                       <option>South Sudan</option>
                                       <option>Spain</option>
                                       <option>Sri Lanka</option>
                                       <option>Sudan</option>
                                       <option>Suriname</option>
                                       <option>Swaziland</option>
                                       <option>Sweden</option>
                                       <option>Switzerland</option>
                                       <option>Syria</option>
                                       <option>Taiwan</option>
                                       <option>Tajikistan</option>
                                       <option>Tanzania</option>
                                       <option>Thailand</option>
                                       <option>Togo</option>
                                       <option>Tonga</option>
                                       <option>Trinidad and Tobago</option>
                                       <option>Tunisia</option>
                                       <option>Turkey</option>
                                       <option>Turkmenistan</option>
                                       <option>Tuvalu</option>
                                       <option>Uganda</option>
                                       <option>Ukraine</option>
                                       <option>United Arab Emirates</option>
                                       <option>United Kingdom</option>
                                       <option>United States of America</option>
                                       <option>Uruguay</option>
                                       <option>Uzbekistan</option>
                                       <option>Vanuatu</option>
                                       <option>Vatican City (Holy See)</option>
                                       <option>Venezuela</option>
                                       <option>Vietnam</option>
                                       <option>Yemen</option>
                                       <option>Zambia</option>
                                       <option>Zimbabwe</option>

                                    </select>
                                    <small id="countryError" class="form-text text-danger "></small>
									  </div>
                  
              					  </div>
              					  
              					  
                                
                                 
                                 <div class="form-group row">
                  
                					  <div class="col">
									   <label>Address*</label>
                                    <input class="form-control" type="text" id="cl_address" name="cl_address" required>
									  </div>
									  
									   <div class="col">
									  <label>Phone*</label>
                                    <input class="form-control" type="text" id="cl_phone" name="cl_phone" placeholder="Eg. 233200000000" required>
                                    <small id="phoneError" class="form-text text-danger "></small>
									  </div>
                  
              					  </div>

                                 <div class="form-group row">
                  
                					  <div class="col">
									   <label>Contact Person</label>
                                   		 <input class="form-control" type="text" id="cl_contact_person" name="contactPerson" placeholder="">
									  </div>
									  
									   <div class="col">
									   <label>Contact Person's Phone</label>
                                    <input class="form-control" type="text" id="cl_contact_person_phone"  placeholder="Eg. 233200000000" required="">
                                    <small id="contactPersonPhoneError" class="form-text text-danger "></small>
									  </div>
                  
              					  </div>
                                 
                                
                                 
                              
		

			</div>
			   <div class="modal-footer">
							<button type="button" class="btn btn-google btn-user btn-block"
								data-dismiss="modal">Close</button>
							<button type="submit" id="btn_save_client_details"
								class="btn btn-primary btn-user btn-block">Save Account Details</button>
						</div>
						
			</form>
		</div>
	</div>
</div>



<div class="modal fade" id="linkaccounttoJobsModal" tabindex="-1" role="dialog"
	aria-labelledby="collectionModal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Link Job to Account</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
		
		<form method="post" class="user" >
                                
						<h5 class="border-bottom border-gray pb-2">Account Details</h5>
                                 <div class="form-group">
                              
                                    <div class="row">
                                      <div class="col">
                                       <label>Applicant Name</label>
									    <input type="text" class="form-control" placeholder="Applicant name" id="lja_applicant_name" required>
									  </div>
									  <div class="col">
									 <label>Applicant E-mail/Phone</label>
									    <input type="text" class="form-control" placeholder="Client ID" id="lja_applicant_id" required>
									 
									 
									  </div>
									  
									  
									</div>
                                 </div>
                                
                                
                                
                                
                                <h5 class="border-bottom border-gray pb-2">Job Details</h5>
                                <div class="form-group row">
                  
                					  <div class="col">
									  <label>Job Number</label>
									    <input type="text" class="form-control" placeholder="Job Number"  id="lja_job_number" >
									  </div>
                					  
                					  <div class="col">
									   <button type="button"
												id="btn_lja_search_for_job_number_details"
												class="btn btn-primary"
											>Search</button>
                                   		 
									  </div>
                  
              					  </div>
                                
                                 <div class="form-group">
                                 
                                    
                                    <div class="row">
                                      <div class="col">
                                       <label>Job Number</label>
									    <input type="text" readonly class="form-control" placeholder="Job Number" id="lja_job_number_result" required>
									  </div>
									  <div class="col">
									 <label>Case Number</label>
									    <input type="text" readonly class="form-control" placeholder="Case Number" id="lja_case_number" required>

									  </div>
									  
									  
									</div>
                                 </div>
                                
                                
                                 <div class="form-group">
                                 
                                    
                                    <div class="row">
                                      <div class="col">
                                       <label>Transaction Number</label>
									    <input type="text" class="form-control" placeholder="Transaction Number" id="lja_transaction_number" required readonly>
									  </div>
									  <div class="col">
									 <label>Transaction Applicant Name</label>
									    <input type="text" class="form-control" placeholder="Applicant Name" id="lja_ar_name" required readonly>

									  </div>
									  
									  
									</div>
                                 </div>
                                
                         
                                 
                              </form>
		

			</div>
			   <div class="modal-footer">
							<button type="button" class="btn btn-google btn-user btn-block"
								data-dismiss="modal">Close</button>
							<button type="button" id="btn_save_link_job_to_account"
								class="btn btn-primary btn-user btn-block">Link Job</button>
						</div>
		</div>
	</div>
</div>




<div class="modal fade" id="generateTransitionalBillModal" tabindex="-1" role="dialog"
	aria-labelledby="collectionModal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Generate Transitional Bill</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
		
		<form method="post"   class="user" >
                               

                                 <div class="form-group">
                                 
                                    
                                    <div class="row">
                                      <div class="col">
                                       <label>Job Number</label>
									    <input type="text" class="form-control" placeholder="Job Number" id="tb_job_number" required>
									  </div>
									  <div class="col">
									 <label>Case Number</label>
									    <input type="text" class="form-control" placeholder="Case Number" id="tb_case_number" required>
									 
									 
									  </div>
									  
									  
									</div>
                                 </div>
                                
                                
                                
                                
                                <div class="form-group row">
                  
                					  <div class="col">
									  <label>Applicant Name</label>
									    <input type="text" class="form-control" placeholder="Other name"  id="tb_applicant_name" >
									  </div>
                					  
                					  <div class="col">
									     <label>Bill Type</label>    
                                    <select class="form-control selectpicker " id="tb_bill_type" name="tb_bill_type">
                                       <option>Select Bill Type</option>
                                      
                                       <option>Supplementary Lodgement</option>
                                       <option>Normal Publication</option>
                                       <option>Special Publication</option>
                                       <option>Official Cadastral Plan Preparation</option>
                                       <option>Title Search (Registration)</option>
                                       
                                    </select>
                                    <small id="genderError" class="form-text text-danger "></small>
									  </div>
                  
              					  </div>
                                
                              
                                <div class="form-group row">
                  
                  
                					  <div class="col">
									   <label>Bill Amount</label>
                                    <input class="form-control" type="text" id="tb_bill_amount" name="tb_bill_amount" placeholder="">
									  </div>
									  
									    <div class="col">
									   <label>Client E-mail/Phone</label>
                                    <input class="form-control" type="text" id="tb_created_for_id" name="tb_created_for_id" placeholder="">
									  </div>
									  
									   <div class="col">
									   <button type="button"
												id="btn_generate_transitional_bill"
												class="btn btn-primary"
											>Generate Transitional Bills</button>
									  </div>
                  
              					  </div>
                            
											<div class="form-group">
												
												<iframe src=""  id="transitionalbillblobfile" width="100%" height="300"></iframe>
							
											</div>
                                
                                
                                
                                
                              
                                
                                 
                              </form>
		

			</div>
			   <div class="modal-footer">
							<button type="button" class="btn btn-google btn-user btn-block"
								data-dismiss="modal">Close</button>
							
						</div>
		</div>
	</div>
</div>




<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="reSubmissionAppModal" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Receive Hard Copy</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


				<div class="container">
					<div class="row">
						<div class="col-lg-6">
							<h6 class="mb-2">Job Details</h6>
							<div class="card">
								<div class="card-body">
									<div class="form-row">
										<div class="col">
											<label for="bl_business_process_sub_name">Job Number</label> <input
												class="form-control " type="text" placeholder=""
												id="res_job_number" readonly
											>
										</div>
										
										<div class="col">
											<label for="bl_job_number">Case Number</label> <input
														class="form-control " type="text" placeholder=""
														id="res_case_number" readonly
													>
										</div>
										
										
									</div>

									<input id="res_business_process_name" type="hidden" class="form-control" />
		
									<div class="form-group mt-3">
										<label for="bl_job_number">Applicant Name</label> <input
											class="form-control " type="text" placeholder=""
											id="res_applicant_name"
										>
									</div>
		
		
									<div class="form-group mt-3">
										<label for="bl_ar_name">Type of Re-Submission</label>   <select class="form-control selectpicker " id="res_bill_type" name="res_bill_type">
											<option>Select Re-Submission Type</option>
										   
											<option>First Time Hard Copy Submission</option>
											<option>Resolved Query</option>
											<option>Payment</option>
											<option>Correction</option>
											<option>Other</option>
									   
											
										 </select>
									</div>
								</div>
							</div>
							<br><br>
							<div class="mb-1 mt-1" id="required_alert"></div>
							<h6 class="mb-2">Details of Depositor</h6>
							<div class="card">
								<div class="card-body">
									<div class="form-group">
										<label for="bl_business_process_sub_name">Name of Depositor<span class="text-danger">*</span></label> <input
											class="form-control " type="text" placeholder=""
											id="res_name_of_depositor"
										>
									</div>
		
		
									<div class="form-group">
										<label for="bl_job_number">ID Type<span class="text-danger">*</span></label>
										<select id="res_id_type" required  class="form-control" >
											<option value="-1">--Slect ID Type--</option>
											<option value="NATIONAL ID">NATIONAL ID</option>
											<option value="PASSPORT">PASSPORT</option>
											<option value="DRIVERS LICENSE">DRIVERS LICENSE</option>
											<option value="NHIS CARD">NHIS CARD</option>
											<option value="VOTERS ID">VOTERS ID</option>
											<option value="SSNIT ID CARD">SSNIT ID CARD</option>
										</select>
									</div>
		
		
									<div class="form-group">
										<label for="bl_ar_name">ID Number<span class="text-danger">*</span></label> <input
											class="form-control " type="text" placeholder=""
											id="res_id_number"
										>
									</div>

									<div class="form-group">
										<label for="bl_business_process_sub_name">Telephone<span class="text-danger">*</span></label> <input
											class="form-control " type="text" placeholder=""
											id="res_depositor_tel"
										>
									</div>
									<div class="form-group">
										<label for="bl_business_process_sub_name">Email<span class="text-danger">*</span></label> <input
											class="form-control " type="text" placeholder=""
											id="res_depositor_email"
										>
									</div>
								</div>
							</div>

							<div class="mt-5">
								<h6>Purpose<span class="text-danger">*</span></h6>
								<textarea id="res_purpose" class="form-control"></textarea>
							</div>

						</div>
						<div class="col-lg-6">
							<div class="form-group">
								<h6 class="mb-2">Public Documents
								
								</h6>
								<button type="button" class="btn btn-primary mr-1" id="btn_load_scanned_documents_public" data-placement="top"  title="Load Docs">
									<i class="fas fa-eye"></i>
								</button>
								<button type="button" class="btn btn-success" id="resumbit_public_document" data-placement="top"  title="Load Docs" data-toggle="modal" data-target="#publicFileUploadModal">
									<i class="fas fa-plus"></i>
								</button>
							</div>
							
							<div class="card">
								<div class="card-body">
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
					</div>

				</div>



			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

				<button type="button" class="btn btn-primary to_hide_on_level_1"  id="btnresumbitapplication">
					<span class="glyphicon glyphicon-remove"></span>Add to Batch
				</button>

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
				<input type="hidden" id="lrd_ps_fid" name="lrd_ps_fid">
			</div>

		</div>
	</div>
</div>




<div class="modal fade" id="generateManualBillModal" tabindex="-1" role="dialog"
	aria-labelledby="generateManualBillModal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Generate Manual Bill</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
		
		<form method="post"  id="generateManualBillModalForm" class="user" >
                               

                <div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="client_name_mb">Client Name</label> <input class="form-control" id="new_bill_application_client_name_mb" name="new_bill_application_client_name_mb" type="text" aria-describedby="" placeholder="Enter Client Name" required readonly>
						</div>
							
							<div class="col-md-6">

								<label for="client_name">Client Ref</label> 
								<input class="form-control" id="new_bill_application_client_id_mb" name="new_bill_application_client_id_mb" type="text" aria-describedby="" placeholder="Enter Client email" required readonly>
							</div>
					</div>
				</div>
                                
                                
                                 <div class="form-group row">
                  
                					  <div class="col">
									  <label>Service Type</label>    
									  <select name="mbm_main_service_cp" id="mbm_main_service_cp"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true">
									
									
									<option value="-1">Select Main Service</option>
															
						                <c:forEach items="${main_services}" var="main_service">
						                  
						               
						                   <c:if test="${main_service.business_process_on_case == 'No'}"> 
						                          <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option> 
									                  
									                    </c:if>  

			                     
			                  </c:forEach>
									
								</select>
									  </div>
                					  
                					  <div class="col">
									     <label>Sub Service</label>    
				                       <select name="mbm_sub_service_cp" id="mbm_sub_service_cp"
													class="form-control input-sm">
													<option value="-1">Select Sub Service</option>
													
										</select>
									  </div>
                  
              					  </div>
                                
                                
                                <div class="form-group row">
                  				  
                					  <div class="col">
									     <label>Bill Amount</label>
                                    <input class="form-control" type="text" id="mbm_bill_amount" name="mbm_bill_amount" placeholder="0.00">
									  </div>
                  					<div class="col">
									   <label>Description</label>
                                    	<input class="form-control" type="text" id="mbm_bill_description" name="mbm_bill_description" placeholder="">
									</div>
              					  </div>
                                
                              
                                <div class="form-group row">
                  				  
									   <div class="col">
									   <button type="button"
												id="btn_generate_manual_bill"
												class="btn btn-primary btn-lg btn-block"
											>Generate Manual Bills</button>
									  </div>
                  
              					  </div>
                            
											<div class="form-group">
												
												<iframe src=""  id="manualbillblobfile" width="100%" height="300"></iframe>
							
											</div>
                                
                                
                                
                                
                              
                                
                                 
                              </form>
		

			</div>
			   <div class="modal-footer">
							<button type="button" class="btn btn-google btn-user btn-block"
								data-dismiss="modal">Close</button>
							
						</div>
		</div>
	</div>
</div>

<div class="modal fade" id="generateRegionalTransitionalBillModal" tabindex="-1" role="dialog"
	aria-labelledby="generateRegionalTransitionalBillModal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Generate Regional Transititonal Bill</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
		
		<form method="post" id="generateRegionalTransitionalBillModalForm" class="user" >
                               

                <div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="client_name_mb">Client Name</label> <input class="form-control" id="new_bill_application_client_name_rtb" name="new_bill_application_client_name_rtb" type="text" aria-describedby="" placeholder="Enter Client Name" required readonly>
						</div>
							
							<div class="col-md-6">

								<label for="client_name">Client Ref</label> 
								<input class="form-control" id="new_bill_application_client_id_rtb" name="new_bill_application_client_id_rtb" type="text" aria-describedby="" placeholder="Enter Client email" required readonly>
							</div>
					</div>
				</div>
				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="client_name_mb">Bill Number:</label> 
							<input class="form-control" id="old_bill_number_rtb" name="old_bill_number_rtb" type="text" aria-describedby="" placeholder="Enter Bill Number" required>
						</div>

							<div class="col-md-6">
								<label for="locality">Office Region</label> <select
									name="new_bill_application_office_region_on_case_rtb"
									id="new_bill_application_office_region_on_case_rtb"
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
								<!-- <label for="client_name_mb"></label>  -->
								<button type="button" class="btn btn-success mt-4" id="btn_search_old_bill_number_rtb"><i class="fas fa-search ml-2"></i>Search</button>
							</div>
					</div>
				</div>    

				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="client_name_mb">Name on Previous Bill:</label> 
							<input class="form-control" id="rtb_previous_client_name" name="rtb_previous_client_name" type="text" aria-describedby="" readonly>
						</div>
						<div class="col-md-6">
							<label for="client_name_mb">Service on Previous Bill:</label> 
							<input class="form-control" id="rtb_previous_sub_service" name="rtb_previous_sub_service" type="text" aria-describedby="" readonly>
						</div>
					</div>
				</div> 

				<div class="form-group row">
                  				  
					<div class="col">
					   <label>Bill Amount</label>
				  <input class="form-control" type="text" id="rtb_bill_amount" name="rtb_bill_amount" readonly placeholder="0.00">
					</div>
					<div class="col">
					 <label>Description</label>
					  <input class="form-control" type="text" id="rtb_bill_description" name="rtb_bill_description" placeholder="">
				  </div>
				  </div>
                                
                                 <div class="form-group row">
                  
                					  <div class="col">
									  <label>Service Type</label>    
									  <select name="rtb_main_service_cp" id="rtb_main_service_cp"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true">
									
									
									<option value="-1">Select Main Service</option>
															
						                <c:forEach items="${main_services}" var="main_service">
						                  
						               
						                   <c:if test="${main_service.business_process_on_case == 'No'}"> 
						                          <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option> 
									                  
									                    </c:if>  

			                     
			                  </c:forEach>
									
								</select>
									  </div>
                					  
                					  <div class="col">
									     <label>Sub Service</label>    
				                       <select name="rtb_sub_service_cp" id="rtb_sub_service_cp"
													class="form-control input-sm">
													<option value="-1">Select Sub Service</option>
													
										</select>
									  </div>
                  
              					  </div>
                                
                                <div class="form-group row">
                  				  
									   <div class="col">
									   <button type="button"
												id="btn_generate_manual_bill_rtb"
												class="btn btn-primary btn-lg btn-block"
											>Generate Manual Bills</button>
									  </div>
                  
              					  </div>
                            
											<div class="form-group">
												
												<iframe src=""  id="manualbillblobfile_rtb" width="100%" height="300"></iframe>
							
											</div>
                                
                                
                                
                                
                              
                                
                                 
                              </form>
		

			</div>
			   <div class="modal-footer">
							<button type="button" class="btn btn-google btn-user btn-block"
								data-dismiss="modal">Close</button>
							
						</div>
		</div>
	</div>
</div>



<div class="modal fade" id="accountDetailsModal" tabindex="-1" role="dialog"
	aria-labelledby="" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header card-header bg-dark text-white">
				<h5 class="modal-title" id="addMinutesModalLabel">Account Details Found</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-5">
						<div class="card">
							<div class="card-body">
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Applicant Name</label>

											<textarea readonly class="form-control"
												id="fn_applicant_name">Jude Odoom yamoah</textarea>

										</div>

										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Account Type</label> 
											<input type="text" readonly class="form-control" id="fn_account_type" value="Individual">

										</div>
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Country</label> 
											<input type="text" readonly class="form-control" id="fn_country" value="Ghana">
										</div>
										<div class="form-group ">
										    <label for="staticEmail" class=" col-form-label">Address</label>
										      <input type="text" readonly class="form-control" id="fn_address" value="Test Adsress">
										 </div>
										
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Phone Number</label> 
											<input type="text" readonly class="form-control" id="fn_phone" value="233249009887">
										</div>


							</div>
						</div>
					</div>
					<div class="col-md-7">
						
								<div class="card mb-3">
								<div class="card-header bg-dark text-white">
									<i class="fa fa-bar-chart"></i>Service Selection
								</div>
								<div class="card-body">
									<form action="${pageContext.request.contextPath}/bill_switcher"
										method="post">
			
			
										<div class="form-group">
											<!-- <label for="main_service">Main Service</label> -->
											<select name="main_service_cp" id="main_service_cp"
												class="form-control input-sm" data-style="btn-info"
												data-live-search="true">
												
												
												<option value="-1">Select Main Service</option>
												
								                <c:forEach items="${main_services}" var="main_service">
								                  
								               
								                   <c:if test="${main_service.business_process_on_case == 'No'}"> 
								                          <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option> 
								                    </c:if>  
								                   
								                </c:forEach>
												
											</select>
										</div>
										<div class="form-group">
											<!--  <label for="sub_service">Sub Service</label> -->
											<select name="sub_service_cp" id="sub_service_cp"
												class="form-control input-sm">
												<option value="-1">Select Sub Service</option>
												
											</select>
										</div>
			
										
			
									</form>
			
								</div>
							</div>
						<br><br>
						<form action="${pageContext.request.contextPath}/front_office_case_add_on" method="post">
							<div class="card mb-3">
								<div class="card-header bg-dark text-white">
									<i class="fa fa-pie-chart"></i> Processing Job on Existing Case
								</div>
								<div class="card-body">
									<div class="form-group">
									
												<input class="form-control" id="search_text"
													name="search_text" type="text" aria-describedby="nameHelp"
													placeholder="Enter Case Number/Job Number/Regional Number" required>
											</div>						
											<div class="form-group">
											
												<button type="submit" class="btn btn-info  btn-block"
													id="btn_load_job_details_after_payment">
													<span
														class="text">Search</span>
												</button>
											</div>
								</div>
							</div>
			
						</form>
						<!--   </form> -->

						<!-- The form Ends Hers -->





					</div>
					

				</div>


			</div>
		</div>
	</div>
</div>





 	   <!--  Service Bill============================= -->
	<div class="modal fade" id="addNewserviceBillModalonCase" tabindex="-1" role="dialog" aria-labelledby="newValuationModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="addNewserviceBillModal">New Service Bill (On Case)</h5>
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
                 <!--  <option value="-1">Select Main Service</option> -->
                  
                  <%--  <c:forEach items="${main_services}" var="main_service">
                   --%>
                  
                  <%--  <c:if test="${(${main_service.business_process_id} == 'No')}" --%>
                          <%-- <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option>  --%>
                    <%-- <p>Welcome, <c:out value="${nm }"/></p> --%>
                  <%--  </c:if> --%>
                  
                    
                 <%--  </c:forEach> --%>
                </select>
          </div>
           <div class="form-group">
          <label for="sub_service">Sub Service</label>
                  <select name="sub_service_on_case" id="sub_service_on_case" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                    <option value="-1">Select Sub Service</option>
                  
                </select>
         	 </div>
	         
	         
	         
	               <div id="oncasereg-no-div" style="display: none">

     
     
     
     
     
     
       <div class="form-group">
            
            
            
 			 <div class="form-group">
       <!--      <div class="form-row">
              <div class="col-md-3">
                <label for="new_bill_application_ls_number">Surveyor's Number</label>
                <input class="form-control" id="new_bill_application_ls_number" name="ls_number" type="number" aria-describedby="nameHelp" placeholder="Enter Surveyor's Number" required>
              </div>
              <div class="col-md-1">
                <label for="new_bill_application_ls_number">-</label>
                <input type="button" id="lc_btn_check_status_of_lincense_surveyor" class="btn btn-primary btn-block" value="C" />
              </div>
              <div class="col-md-8">
                <label for="qty">Surveyor's Name</label>
                <input class="form-control" id="new_bill_application_surveyors_name" name="new_bill_application_surveyors_name"  type="text" aria-describedby="nameHelp" placeholder="Surveyor's Name" required>
              </div>
            </div> -->
            
            
              <div class="form-row">
              <div class="col-md-3">
                <label for="new_bill_application_ls_number">Surveyor's Number</label>
                <input class="form-control" id="new_bill_application_ls_number_oncase" name="ls_number" type="text" aria-describedby="nameHelp" value="${licensed_surveyor_number}" readonly>
              </div>
              
              <div class="col-md-8">
                <label for="qty">Surveyor's Name</label>
                <input class="form-control" id="new_bill_application_surveyors_name_oncase" name="new_bill_application_surveyors_name_oncase"  type="text" aria-describedby="nameHelp" value=""   readonly>
              </div>
            </div>
            
          </div>
          
          
          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="new_bill_application_ls_number">Surveyor's Status</label>
                <input class="form-control" id="new_bill_application_surveyors_status_oncase" name="new_bill_application_surveyors_status_oncase" type="text" aria-describedby="nameHelp" placeholder="" readonly>
              </div>
              <div class="col-md-1">
                <label for="new_bill_application_ls_number">-</label>
               <!--  <input type="button" id="lc_btn_check_status_of_lincense_surveyor" class="btn btn-primary btn-block" value="C" /> -->
                <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" id="lc_btn_check_status_of_lincense_surveyor_oncase" data-placement="top"  data-toggle="tooltip" title="Search for Surveyor">
		            <i class="fa fa-search"></i>
		        </button>
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
            <div class="card-footer small text-muted"></div>
          </div>
          
      
      </div>
     </div>
          
          
          <div class="form-group">
		            <div class="form-row">
		              
		            
		            
		            <div class="col-md-6">

					  <label for="client_name">Client Name</label>
		                <input readonly class="form-control" id="on_application_client_name"  name="on_application_client_name"  type="text" aria-describedby="nameHelp" placeholder="Enter Client Name" value="${ar_name}" readonly>
		            
			 </div>
		            
		            <div class="col-md-6">

					<label for="client_name">Transaction Number</label> <input
						class="form-control" id="new_bill_case_number_on_case"
						name="new_bill_case_number" type="text"
						aria-describedby="nameHelp"
						readonly >
			 </div>
			 
			 
			 
			  <div class="col-md-6">

					<label for="client_name">Client E-mail/Phone</label> <input
						class="form-control" id="new_bill_client_id_on_case"
						name="new_bill_client_id" type="text"
						 placeholder="Enter Client ID"
						required>
			 </div>
			 
			   <%-- <div class="col-md-6">

					<label for="client_name">Land Size</label> <input
						class="form-control" id="new_bill_land_size"
						name="new_bill_land_size" type="text"
						aria-describedby="nameHelp"
						readonly value="${case_number}">
			 </div> --%>
		            </div>
         	 </div>
         	 
         	  
         	  
         	  			<div class="form-group">
						<div class="form-row">

							<div class="col-md-6">
								<label for="locality">Office Region</label> <select
									name="new_bill_application_office_region_on_case"
									id="new_bill_application_office_region_on_case"
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
					</div>
				
         	  
      <!-- <div id="oncasereglandsize-no-div" style="display: none"> -->
	  <div id="oncasereglandsize-" style="">
       <div class="form-group">
            
            
            
 			 
          
          
          <div class="form-group">
            <div class="form-row">
             
              <div class="col-md-6">

					<label for="client_name">Land Size (Acre(s))</label> <input
						class="form-control" id="new_bill_land_size_on_case"
						name="new_bill_land_size" type="text"
						aria-describedby="nameHelp" placeholder="Enter land Size"
						required>
			 </div>
			 <div class="col-md-6">

					<label for="client_name">Locality</label> 
					<input type="text" class="form-control" id="new_bill_locality_on_case_1">
			 </div>
			 
			 
            </div>
          </div>
          
            
           
          </div>
          
      </div>



					
		<div id="oncasestp-no-div" style="display: none">
						<div class="form-group">
						<div class="form-row">
							<div class="col-md-4">

								<label for="client_name">Number of Copies</label> <input
									class="form-control" id="new_number_of_copies_on_case"
									name="new_number_of_copies" type="number"
									aria-describedby="nameHelp" value="0"
									required>
							</div>
							
								
							<div class="col-md-4">
								<label for="new_bill_type_of_use">Type of Use</label> <select
									name="type_of_use" id="new_bill_type_of_use_on_case"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true">
									<option value="-1">Select Type of Use</option>

								</select>

							</div>
							
							<div class="col-md-4">
								<label for="new_type_of_revenue_item">Nature of Instrument</label> <select
									name="new_type_of_revenue_item_on_case" id="new_type_of_revenue_item_on_case"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true">
									<option value="-1">Select Nature of Interest</option>

								</select>

							</div>
						</div>
					</div>
			</div>		
					
				
				
					<div id="oncasefreg-no-div" style="display: none">
					
				
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="registration_forms">Forms</label> <select
									name="new_bill_registration_forms_on_case"
									id="new_bill_registration_forms_on_case" class="form-control input-sm"
									data-style="btn-info" data-live-search="true">
									<option value="-1">Select Registration Forms</option>

								</select>

							</div>
							
						</div>
					</div>
		</div>
		
		
		<div id="oncasefpublication-no-div" style="display: none">
					
				
					<div class="form-group">
						<div class="form-row">
							
							<div class="col-md-6">

								<label for="publication_type">Publication Type</label> <select
									name="new_bill_publication_type_on_case" id="new_bill_publication_type_on_case"
									data-live-search="true"
									data-none-results-text="I found no results"
									title="Please select fruit" class="form-control selectpicker">
									<option value="normal_publication">Normal Publication</option>
									<option value="special_publication">Special
										Publication</option>
								</select>

							</div>
						</div>
					</div>
				</div>
				
				
				
				
						
         	
	           </form>
	           <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" id="btn_save_to_generate_on_application" class="btn btn-primary">Generate Bill</button>
		      </div>
	      
	      </div>
	    </div>
	  </div>
	</div>
	
	



<div class="modal fade" id="SampleModal" tabindex="-1" role="dialog"
	aria-labelledby="SampleModal" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Collection of Completed Application</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card">

							<div class="card-body">
								
							</div>
						</div>
					</div>
					
					
					<div class="col-md-12">
						<div class="card">

							<div class="card-body">
								<div id="smartwizardcollection">
									<ul>

										<li><a href="#step-1">Application Details<br /> </a></li>
										
										<li><a href="#step-2">Identity Verification<br /></a></li>
										<!-- <li><a href="#step-2">Checklist<br /></a></li> -->
										<li><a href="#step-3">Details Confirmation<br /></a></li>
										
									     <li><a href="#step-4">File Upload<br /></a></li>
											
									   <li><a href="#step-5">Acknowledgement<br /></a></li>
										
										<!-- <li><a href="#step-5">Acknowledgment Slip<br /></a></li> -->

									</ul>

									<div>

										<div id="step-1" class="">
											<br>
											<h3 class="border-bottom border-gray pb-2">Check List</h3>
											<br><br>
								
										</div>
										
										
										<div id="step-2" class="">
											<br>
											<h3 class="border-bottom border-gray pb-2">Bills Details</h3>
											
										</div>
										
										<div id="step-3" class="">
											<br>
											<h3 class="border-bottom border-gray pb-2">Details Confirmation</h3>
											
										</div>
										
										
										
										<div id="step-4" class="">
											<br>
											<h3 class="border-bottom border-gray pb-2">File Upload</h3>
											
										</div>
										
										
										<div id="step-5" class="">
											<br>
											<h3 class="border-bottom border-gray pb-2">Acknowledgement</h3>
											
										</div>
										
										
										
										
									</div>
								</div>
							</div>
						</div>




					</div>
					
					



				</div>


			</div>
		</div>
	</div>
</div>


	
<div class="modal fade" id="NotoncaseafterPaymentModalonCase" tabindex="-1" role="dialog"
	aria-labelledby="NotoncaseafterPaymentModalonCase" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">After
					Payment(New Case)</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card">

							<div class="card-body">
								
										 <input type="hidden" id="txt_not_on_case_ap_main_service_id"
					name="txt_not_on_case_ap_main_service_id"
				> <input type="hidden" id="txt_not_on_case_ap_main_service_sub_id"
					name="txt_not_main_service_sub_id"
				> <input type="hidden" id="txt_not_on_case_ap_jn_id"
					name="txt_not_on_case_ap_jn_id" value="jn_id"
				> <input type="hidden" id="txt_not_on_case_ap_userid"
					name="txt_not_on_case_ap_userid" value="${userid}"
				> <input type="hidden" id="txt_not_on_case_ap_user_fullname"
					name="user_fullname" value="${fullname}"
				>






				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="main_service_desc">Main Service</label> <input
								class="form-control" id="txt_not_on_case_ap_main_service_desc"
								name="txt_not_on_case_ap_main_service_desc" type="text"
								aria-describedby="nameHelp" readonly
							>
						</div>
						<div class="col-md-6">
							<label for="main_service_sub_desc">Sub Service</label> <input
								class="form-control"
								id="txt_not_on_case_ap_main_service_sub_desc"
								name="txt_not_on_case_ap_main_service_sub_desc" type="text"
								aria-describedby="nameHelp" readonly
							>
						</div>
					</div>
				</div>


				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="client_name">Client Name</label> <input
								class="form-control" id="txt_not_on_case_ap_client_name"
								name="txt_not_on_case_ap_client_name" type="text"
								aria-describedby="nameHelp" readonly
							>
						</div>
						<div class="col-md-6">
							<label for="main_service_sub_desc">Land Size</label> <input
								class="form-control" id="txt_not_on_case_ap_land_size"
								name="txt_not_on_case_ap_land_size" type="text"
								aria-describedby="nameHelp" readonly
							>
						</div>
					</div>
				</div>


		<div id="checksigs-no-div_afp" style="display: none">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-3">
								<label for="new_bill_application_ls_number">Surveyor's
									Number</label> <input class="form-control"
									id="new_bill_application_ls_number_afp" name="ls_number"
									type="text" aria-describedby="nameHelp" readonly
								>
							</div>
							<div class="col-md-1">
								<label for="new_bill_application_ls_number">-</label>
								<!--  <input type="button" id="lc_btn_check_status_of_lincense_surveyor" class="btn btn-primary btn-block" value="C" /> -->
								<button type="button" class="btn btn-primary pull-right"
									style="margin-bottom: 5px"
									id="lc_btn_check_status_of_lincense_surveyor_afp"
									data-placement="top" data-toggle="tooltip"
									title="Search for Surveyor"
								>
									<i class="fa fa-search"></i>
								</button>
							</div>
							<div class="col-md-8">
								<label for="qty">Surveyor's Name</label> <input
									class="form-control" id="new_bill_application_surveyors_name_afp"
									name="new_bill_application_surveyors_name" type="text"
									aria-describedby="nameHelp" readonly
								>
							</div>
						</div>
					</div>


					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="new_bill_application_ls_number">Surveyor's
									Status</label> <input class="form-control"
									id="new_bill_application_surveyors_status_afp"
									name="new_bill_application_surveyors_status_afp" type="text"
									aria-describedby="nameHelp" readonly
								>
							</div>
							<!-- <div class="col-md-6">
                <label for="qty">Quantity Required</label>
                <input class="form-control" id="new_bill_application_qty" name="new_bill_application_qty"  type="number" min="0" step="1"aria-describedby="nameHelp" placeholder="Enter Quantity" required>
              </div> -->
						</div>
					</div>

				</div>
								<!-- </form> -->
							</div>
						</div>
					</div>
					
					
					<div class="col-md-12">
						<div class="card">

							<div class="card-body">
								<div id="smartwizardCSAUModal">
									<ul>

										<li><a href="#step-1">Check List<br /> </a></li>
										
										<li><a href="#step-2">Bills Details<br /></a></li>
										<!-- <li><a href="#step-2">Checklist<br /></a></li> -->
										<li><a href="#step-3">Details Confirmation<br /></a></li>
										<!-- <li><a href="#step-5">Acknowledgment Slip<br /></a></li> -->
										
										<li><a href="#step-4">File Upload<br /></a></li>
										
										<li><a href="#step-5">Acknowledgement Slip<br /></a></li>

									</ul>

									<div>

										<div id="step-1" class="">
											<br>
											<h3 class="border-bottom border-gray pb-2">Check List</h3>
											<br><br>
								
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
										width="100%" cellspacing="0"
									>
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
							<div class="card-footer small text-muted"></div>
						</div>


					</div>
				</div>
								
								
										</div>
										
										
										<div id="step-2" class="">
											<br>
											<h3 class="border-bottom border-gray pb-2">Bills Details</h3>
											<div class="row">
					<div class="col-lg-12">
						<!-- Example Bar Chart Card-->
						<div class="card mb-3">
							<div class="card-header">
								<i class="fas fa-money-bill-alt"></i>Bill And Payments
								<button class="btn btn-primary float-right" id="btnPrintEgcr"><i class="fas fa-print  "></i>Print eGCR</button>
							</div>
							<div class="card-body">



								<!--  Here is where the fee list comes -->

								<div class="table-responsive">
									<table class="table table-bordered"
										id="tbl_not_on_case_ap_bills_payments_dataTable" width="100%"
										cellspacing="0"
									>
										<thead>
											<tr>
												<th>Bill Number</th>
												<th>Bill Description</th>
												<th>Bill Amount</th>
												<th>Amount Paid</th>
												<th>Payment Mode</th>
												<th>Division</th>


											</tr>
										</thead>

										<tbody>


										</tbody>
									</table>
								</div>

								<!--  End Of Table -->
							</div>
							<div class="card-footer small text-muted"></div>
						</div>


					</div>
				</div>
										</div>
										
										<div id="step-3" class="">
											<br>
											<h3 class="border-bottom border-gray pb-2">Details Confirmation</h3>
											
				<div class="row">
					<div class="col-lg-12">
						<!-- Example Bar Chart Card-->
						<div class="card mb-3">
							<div class="card-header">
								<i class="fa fa-bar-chart"></i>Parties to Transaction
							</div>
							<div class="card-body">










								<div class="form-row">
									<div class="col-md-8">
										<label for="search_value">Client Name</label> <input readonly
											class="form-control" id="txt_not_on_case_bl_txt_ar_name"
											name="txt_not_on_case_bl_txt_ar_name" type="text"
											aria-describedby="nameHelp"
										>
									</div>





									<div class="col-md-4">
										<label for="job_number">Ref No</label> <input
											class="form-control" id="txt_not_on_case_ap_job_number"
											name="txt_not_on_case_ap_job_number" type="text"
											aria-describedby="nameHelp" readonly
										>
									</div>

								</div>







								<div class="form-row">
									<!-- <div class="col-md-4">
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
									</div> -->
									<!-- 	<div class="col-md-4">
										<label for="search_value">Save New Party</label>
										<button id="btn_not_on_case_add_new_party"
											class="form-control" class="btn">
											<i class="fa fa-home"></i>Save New Party
										</button>
									</div> -->
									<!-- 	<div class="col-md-4">
											<label for="job_number">Ref No</label> <input
												class="form-control" id="txt_not_on_case_ap_job_number"
												name="txt_not_on_case_ap_job_number" type="text"
												aria-describedby="nameHelp" readonly>
										</div>
										
										<div class="col-md-4">
											<label for="job_number">LS Number</label> <input
												class="form-control" id="txt_not_on_case_ap_licensed_surveyor_number"
												name="txt_not_on_case_ap_licensed_surveyor_number" type="text"
												aria-describedby="nameHelp" readonly>
										</div> -->
								</div>





								<div class="form-group"></div>







								<!--  End Of Table -->
							</div>
							<div class="card-footer small text-muted"></div>
						</div>


					</div>
				</div>


				<div id="ap-typeofuse-no-div" style="display: none">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">

								<label for="client_name">Type of Use</label> 
								
								
								<select
									name="type_of_use" id="txt_not_on_case_ap_type_of_use"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true">
									<option value="-1">Select Type of Use</option>

								</select>
								
								
							</div>

						</div>
					</div>
				</div>

				<div id="ap-selectlocality-no-div" style="display: none">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<br> <label for="client_name">locality</label> <input
									class="form-control" id="txt_not_on_case_ap_locality_of_parcel"
									name="txt_not_on_case_ap_locality_of_parcel" type="text"
									aria-describedby="nameHelp"
									placeholder="Enter locality_of_parcel" required 
								>
							</div>

						</div>
					</div>
				</div>


				<div id="ap-reg-no-div" style="display: none">

					<div class="form-row">
						<div class="col-md-4">
							<label for="region">Region</label> <input class="form-control"
								id="txt_not_on_case_ap_region" name="txt_not_on_case_ap_region"
								type="text" aria-describedby="nameHelp" readonly
							>
						</div>
						<div class="col-md-8">
							<label for="district">District</label> <input
								class="form-control" id="txt_not_on_case_ap_district"
								name="txt_not_on_case_ap_district" type="text"
								aria-describedby="nameHelp" readonly
							> <br>
							<br>
						</div>


					</div>



					<div class="form-group">
						<div class="form-row">

							<div class="col-md-2">
								<label for="job_number">LS Number</label> <input
									class="form-control"
									id="txt_not_on_case_ap_licensed_surveyor_number"
									name="txt_not_on_case_ap_licensed_surveyor_number" type="text"
									aria-describedby="nameHelp" readonly
								>
							</div>

							<div class="col-md-10">
								<label for="job_number">Surveyor's Name</label> <input
									class="form-control"
									id="txt_not_on_case_ap_licensed_surveyor_name"
									name="txt_not_on_case_ap_licensed_surveyor_name" type="text"
									aria-describedby="nameHelp" readonly
								>
							</div>


						</div>

					</div>

					<div class="form-group">
						<div class="form-row">

							<div class="col-md-6">

								<label for="application_type">Application Type</label> 
								<select
									name="txt_not_on_case_ap_application_type"
									id="txt_not_on_case_ap_application_type"
									data-live-search="true"
									data-none-results-text="I found no results"
									title="Please select fruit" class="form-control selectpicker"
								>
									<option value="Individual">Individual</option>
									<option value="Joint">Joint</option>
									<option value="Company">Company</option>

								</select>

							</div>

						</div>
					</div>

				</div>


				<div id="ap-stp-no-div" style="display: none">
					<div class="form-group">
						<div class="form-row">



							<div class="col-md-6">
								<label for="type_of_interest">Type of Instrument</label> <select
									name="txt_not_on_case_ap_type_of_instrument"
									id="txt_not_on_case_ap_type_of_instrument"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">Select Type of Instrument</option>
									<option value="LEASEHOLD">LEASEHOLD</option>
									<option value="FREEHOLD">FREEHOLD</option>

								</select>

							</div>



						</div>
					</div>
				</div>
										</div>
										
										
										
										<div id="step-4" class="">
											<br>
											<h3 class="border-bottom border-gray pb-2">File Upload</h3>
																			
											 <form class="form-horizontal" method="POST" enctype="multipart/form-data" id="id_formatCSAU_">
											   
											   
											  
											   
															
															
															
													<div class="form-group">
													<div class="form-row">
							
							
							
														<div class="col-md-12">
														 <label for="file">File:</label>
											    			<input id="fileUploadFormatCSAU" type="file" name="UploadFileFile"  accept="application/pdf"/>
							
														</div>
														
							
							
													</div>
												</div>		
															
											</form>
			
										</div>
										
										
										<div id="step-5" class="">
											<br>
											<h3 class="border-bottom border-gray pb-2">Acknowledgement</h3>
											<button type="button"
												id="btn_not_on_case_ap_generate_acknowledgement"
												class="btn btn-primary"
											>Generate Acknowledgement Slip</button>
											
											
											<div class="form-group">
												
												<iframe src=""  id="notoncaseakblobfile" width="100%" height="300"></iframe>
							
											</div>
											
											
										</div>
										
										
									</div>
								</div>
							</div>
						</div>




					</div>
					
					



				</div>


			</div>
			 	<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div>



	
<div class="modal fade" id="elisDocumentPreview" tabindex="-1" role="dialog"
	aria-labelledby="elisDocumentPreview" aria-hidden="true" style="z-index: 1060;">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Document Preview</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
												
												<iframe src=""  id="elisdovumentpreviewblobfile" width="100%" height="600"></iframe>
							
				</div>

			</div>
			 	<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				
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
                     <label for="job_number">Ref Number</label>
                     <input class="form-control" id="txt_on_case_ap_job_number"  name="txt_on_case_ap_job_number"  type="text" aria-describedby="nameHelp" placeholder="Enter Ref Number" readonly >
                  </div>
                  <!--    <div class="col-md-4">
                     <label for="search_btn">-</label>
                       <input type="button" id="btn_process_after_payment_on_case" class="btn btn-primary btn-block" value="Load Details" />  
                       
                       </div> -->
                  <div class="col-md-4">
                     <label for="job_number">Case Number</label>
                     <input class="form-control" id="txt_on_case_ap_case_number"  name="txt_on_case_ap_case_number"  type="text" aria-describedby="nameHelp" value="${case_number}" readonly >
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
            
            <div class="form-row">
                  <div class="col-md-6">
                     <label for="client_name">Client Name</label>
                     <input class="form-control" id="txt_on_case_ap_client_name"  name="txt_on_case_ap_client_name"  type="text" aria-describedby="nameHelp"  readonly>
                  </div>
                  <div class="col-md-6">
                     <label for="job_number">Transaction Number</label>
                     <input class="form-control" id="txt_on_case_ap_transaction_number"  name="txt_on_case_ap_transaction_number"  type="text" aria-describedby="nameHelp" value="${transaction_number}" readonly >
                  </div>
               </div>
            <!-- ------------------------------------------------------------------------------------------- -->
            <div class="col-md-12">
			   <div class="card">
			      <div class="card-body">
			         <div id="smartwizardCSAUModalOnCase">
			            <ul>
			               <li><a href="#step-1">Check List<br /> </a></li>
			               <li><a href="#step-2">Bills Details<br /></a></li>
			               <!-- <li><a href="#step-2">Checklist<br /></a></li> -->
			               <li><a href="#step-3">Details Confirmation<br /></a></li>
			               <!-- <li><a href="#step-5">Acknowledgment Slip<br /></a></li> -->
			               <li><a href="#step-4">File Upload<br /></a></li>
			               <li><a href="#step-5">Acknowledgement Slip<br /></a></li>
			            </ul>
			            <div>
			               <div id="step-1" class="">
			                  <br>
			                  <h3 class="border-bottom border-gray pb-2">Check List</h3>
			                  <br><br>
			                  <div class="row">
					                  <div class="col-lg-12">
					                     <!-- Example Bar Chart Card-->
					                     <div class="card mb-3">
					                        <div class="card-header">
					                           <i class="fa fa-bar-chart"></i>${main_service_desc}  Check List
					                        </div>
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
					                        <div class="card-footer small text-muted"></div>
					                     </div>
					                  </div>
					               </div>
			               </div>
			               <div id="step-2" class="">
			                  <br>
			                   <h3 class="border-bottom border-gray pb-2">Bills Details</h3>
							                     <div class="row">
				                  <div class="col-lg-12">
				                     <!-- Example Bar Chart Card-->
				                     <div class="card mb-3">
				                        <div class="card-header">
				                           <i class="fa fa-bar-chart"></i>Bill And Payments
				                           <button class="btn btn-primary float-right" id="btnPrintEgcr2"><i class="fas fa-print "></i>Print eGCR</button>
				                        </div>
				                        <div class="card-body">
				                           <!--  Here is where the fee list comes -->
				                           <div class="table-responsive">
				                              <table class="table table-bordered" id="tbl_on_case_ap_bills_payments_dataTable" width="100%" cellspacing="0">
				                                 <thead>
				                                    <tr>
				                                       <th>Bill Number</th>
				                                       <th>Bill Description</th>
				                                       <th>Bill Amount</th>
				                                       <th>Amount Paid</th>
				                                       <th>Payment Mode</th>
				                                       <th>Division</th>
				                                    </tr>
				                                 </thead>
				                                 <tbody>
				                                 </tbody>
				                              </table>
				                           </div>
				                           <!--  End Of Table -->
				                        </div>
				                        <div class="card-footer small text-muted"></div>
				                     </div>
				                  </div>
				               </div>
			               </div>
			               <div id="step-3" class="">
			                 <br>
			                   <h3 class="border-bottom border-gray pb-2">Details Confirmation</h3>
			                   
								                    <div class="row">
					                  <div class="col-lg-12">
					                     <!-- Example Bar Chart Card-->
					                     <div class="card mb-3">
					                        <div class="card-header">
					                           <i class="fa fa-bar-chart"></i>
					                        </div>
					                        <div class="card-body">
					                           <div class="form-group">
					                              <label for="bl_ar_name">Name</label>
					                              <textarea readonly rows="2" class="form-control" placeholder="" id="txt_on_case_ap_ar_name"></textarea>
					                           </div>
					                           <div id="oncaseparty-no-div" style="display: none">
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
					                                       <option value="Applicant">Applicant</option>
					                                       <option value="Motgagor">Motgagor</option>
					                                       <option value="Grantor">Grantor</option>
					                                       <option value="Objector">Objector</option>
					                                       <option value="Depositor">Depositor</option>
					                                    </select>
					                                 </div>
					                              </div>
					                              <div class="form-group">
					                                 <div class="form-row">
					                                 </div>
					                              </div>
					                           </div>
					                           <div id="oncasepaap-no-div" style="display: none">
					                              <div class="form-group">
					                                 <div class="form-row">
					                                    <div class="col-md-6">
					                                       <label for="main_service_sub_desc">Land Size (Acre(s))</label>
					                                       <input class="form-control" id="txt_on_case_ap_land_size" name="txt_on_case_ap_land_size" type="text" aria-describedby="nameHelp"  readonly>
					                                    </div>
					                                    <div class="col-md-6" style="display: none">
					                                       <label for="qty">Surveyor's Name</label>
					                                       <input class="form-control" id="new_ap_application_surveyors_name_oncase" name="new_ap_application_surveyors_name_oncase"  type="text" aria-describedby="nameHelp" value=""   readonly>
					                                    </div>
					                                    <div class="col-md-6" style="">
					                                       <label for="qty">Locality </label>
					                                       <input class="form-control" id="new_ap_locality_oncase" type="text"   readonly>
					                                    </div>
					                                 </div>
					                              </div>
					                           </div>
					                           <div id="oncaseregap-no-div" style="display: none">
					                              <div class="form-group">
					                                 <div class="form-row">
					                                    <div class="col-md-6">
					                                       <label for="application_type">Application Type</label> 
					                                       <select
					                                          name="txt_not_on_case_ap_application_type"
					                                          id="txt_not_on_case_ap_application_type" data-live-search="true"
					                                          data-none-results-text="I found no results"
					                                          title="Please select fruit" class="form-control selectpicker">
					                                          <option value="Individual">Individual</option>
					                                          <option value="Joint">Joint</option>
					                                          <option value="Company">Company</option>
					                                       </select>
					                                    </div>
					                                 </div>
					                              </div>
					                           </div>
					                           <div id="oncasestpap-no-div" style="display: none">
					                              <div class="form-group">
					                                 <div class="form-row">
					                                    <!-- <div class="col-md-6">
					                                       <label for="type_of_interest">Type of Instrument</label> <select
					                                       	name="txt_on_case_ap_type_of_instrument"
					                                       	id="txt_on_case_ap_type_of_instrument"
					                                       	class="form-control input-sm" data-style="btn-info"
					                                       	data-live-search="true">
					                                       	<option value="-1">Select Type of Instrument</option>
					                                       
					                                       </select>
					                                       
					                                       </div> -->
					                                    <div class="col-md-6" style="display: none;">
					                                       <label for="qty">Nature of Instrument</label>
					                                       <input class="form-control" id="txt_on_case_ap_type_of_instrument" name="txt_on_case_ap_type_of_instrument"  type="text" aria-describedby="nameHelp" value=""   readonly>
					                                    </div>
					                                    <div class="col-md-6" style="display: none;">
					                                       <label for="qty">Type of Use</label>
					                                       <input class="form-control" id="txt_on_case_ap_type_of_use" name="txt_on_case_ap_type_of_use"  type="text" aria-describedby="nameHelp" value=""   readonly>
					                                    </div>
					                                 </div>
					                              </div>
					                           </div>
					                          
					                        </div>
					                        <div class="card-footer small text-muted"></div>
					                     </div>
					                  </div>
					               </div>
			               </div>
			               <div id="step-4" class="">
			                  <br>
			                   <h3 class="border-bottom border-gray pb-2">File Upload</h3>
			                  <form class="form-horizontal" method="POST" enctype="multipart/form-data" id="id_formatCSAU">
											   
											   		
													<div class="form-group">
													<div class="form-row">
							
							
							
														<div class="col-md-12">
														 <label for="file">File:</label>
											    			<input id="fileUploadFormatCSAUonCase" type="file" name="fileUploadFormatCSAUonCase"  accept="application/pdf"/>
							
														</div>
														
							
							
													</div>
												</div>		
															
											</form>
			               </div>
			               <div id="step-5" class="">
			                  <br>
			                  <h3 class="border-bottom border-gray pb-2">Acknowledgement</h3>
			                <br>
			                  <button type="button" id="btn_on_case_ap_generate_acknowledgement" class="btn btn-primary">Generate Acknowledgement Slip</button>
			                  <div class="form-group">
			                     <iframe src=""  id="oncaseakblobfile" width="100%" height="300"></iframe>
			                  </div>
			               </div>
			            </div>
			         </div>
			      </div>
			   </div>
			</div>

			<!-- -------------------------------------------------------------------------------------- -->

         </div>
          <div class="modal-footer">
               <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
             
            </div>
      </div>
   </div>
</div>	






<div class="modal fade" id="servicePayment" tabindex="-1" role="dialog"
	aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Pay For Service</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Reference Number</label> <input
						class="form-control " type="text" placeholder=""
						id="sp_job_number"
					>
				</div>


				<div class="form-group">
					<label for="bl_ar_name">Applicant Name</label>
					
					<input
						class="form-control " type="text" placeholder=""
						id="sp_ar_name"
					>
					
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Amount Due</label>
					 <input
						class="form-control " type="text" placeholder=""
						id="sp_amount_due"
					>
				</div>
				
		



				



				<div class="form-group">
					
					<iframe src=""  id="paymentcheckoutUrl" width="100%" height="300"> </iframe>

				</div>



			</div>
			<div class="modal-footer ">

				<!-- <div class="my-2"></div>
				<a href="#" id="btnaddjobtolist"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Save Payment</span>
				</a> -->

				
		
			<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>
				





				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->


				<input type="hidden" id="bl_jn_id" name="jn_id"> <input
					type="hidden" id="bl_send_by_id" name="send_by_id"
				> <input type="hidden" id="bl_userid" name="userid">
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>




<div class="modal fade" id="egcrReceipt" tabindex="-1" role="dialog"
	aria-labelledby="egcrReceipt" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Generate EGCR</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Reference Number</label> <input
						class="form-control " type="text" placeholder=""
						id="egcr_job_number"
					>
				</div>


				<div class="form-group">
					<label for="bl_ar_name">Applicant Name</label>
					
					<input
						class="form-control " type="text" placeholder=""
						id="egcr_ar_name"
					>
					
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Amount Due</label>
					 <input
						class="form-control " type="text" placeholder=""
						id="egcr_amount_due"
					>
				</div>
				
			
				


				<div class="form-group">
					
					<iframe src=""  id="egcrblobfile" width="100%" height="300"></iframe>

				</div>

				


			</div>
			<div class="modal-footer ">

					
			<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

	
	
	<div class="modal fade" id="manualBillPayment" tabindex="-1" role="dialog"
	aria-labelledby="egcrReceipt" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Manual Receipt Entry</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Bill Number</label> <input
						class="form-control " type="text" placeholder=""
						id="mre_bill_number" readonly
					>
				</div>


				<div class="form-group">
					<label for="bl_ar_name">Applicant Name</label>
					
					<input
						class="form-control " type="text" placeholder=""
						id="mre_ar_name" readonly
					>
					
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Amount Due</label>
					 <input
						class="form-control " type="text" placeholder=""
						id="mre_amount_due" readonly
					>
				</div>
				
				
				
				<div class="form-group">
					<label for="bl_business_process_sub_name">Amount Paid</label>
					 <input
						class="form-control " type="text" placeholder=""
						id="mre_amount_paid"
					>
				</div>
				
				
				<div class="form-group">
					<label for="bl_business_process_sub_name">Receipt Number</label>
					 <input
						class="form-control " type="text" placeholder=""
						id="mre_receipt_number"
					>
					
					
				</div>
				
					
				<div class="form-group">
					<label for="bl_business_process_sub_name">Payment Mode</label>
				
					
					<select name="mre_payment_mode" id="mre_payment_mode" data-live-search="true" data-none-results-text="I found no results" title="Please select fruit" class="form-control selectpicker">
                        <option value="Cash">Cash</option>
                        <option value="Bank Advise(Swift)">Bank Advise(Swift)</option>
                        <option value="Bank Draft">Bank Draft</option>
                      
                     </select>
					
				</div>
				
				
			
			<div class="form-group">
					<label for="bl_business_process_sub_name">Payment Remarks</label>
					 <input
						class="form-control " type="text" placeholder=""
						id="mre_payment_remarks" value="Full Payment"
					>
				</div>
			
				


				<div class="form-group">
					
					<iframe src=""  id="mreblobfile" width="100%" height="300"></iframe>

				</div>

				


			</div>
			<div class="modal-footer ">

					
			<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>
				
						
			<div class="my-2"></div>
				
				<button type="button" id="btn_mre_save_payment" class="btn btn-primary">Save Payment</button>
				
			<!-- 	<a href="#" data-dismiss="modal"
					class="btn btn-info btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-save"></i>
				</span> <span class="text">Save</span>

				</a> -->

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

	

	
	<!-- Add Coordinates Modal -->

<div class="modal fade" id="uploadregionalnumbercsv" tabindex="-1"
	role="dialog" aria-labelledby="uploadregionalnumbercsv" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Upload
					REgional NUmber CSV</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<fieldset>
						<input type="file" name="File Upload"
							id="txtFileUploaduploadregionalnumbercsv" accept=".csv"
						/>
					</fieldset>
				</div>







			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btn-uploadregionalnumbercsv"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Upload </span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>




			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

	
	
	
	<!-- Add File Upload============================= -->
<div class="modal fade" id="filefileRegionalNumberUploadModal" tabindex="-1" role="dialog"
	aria-labelledby="filefileRegionalNumberUploadModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="fileRegionalNumberUploadModalLabel">Upload New File</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
			
			
			
			 <form class="form-horizontal" method="POST" enctype="multipart/form-data" id="id_formeb">
			    <label for="file">File:</label>
			    <input id="fileUploadFormregionalnumber" type="file" name="fileUploadFormregionalnumber" />
			   
			  <%--  <label for="query_case_number" class="col-form-label">Case
									Number</label> <input type="text" name="file_upload_case_number"
									id="file_upload_case_number" class="form-control" required readonly value="${case_number}"
								> --%>
			    <input type="button" id="btn_upload_rn_file"
								class="btn btn-primary" value="Click to upload"
							>
			</form>
			
	
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal"
						>Close</button>
					</div>
				
				
				
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="linkjobtoTransactionModal" tabindex="-1" role="dialog"
	aria-labelledby="collectionModal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Link Job to Transaction</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
		
		<form method="post"   class="user" >
                                
						<h5 class="border-bottom border-gray pb-2">Job Details</h5>
                                 <div class="form-group">
                              
                                    <div class="row">
                                      <div class="col">
                                       <label>Transaction Number</label>
									    <input type="text" class="form-control" placeholder="Transaction Number" id="ljt_new_transaction_number" required>
									  </div>
									  <div class="col">
									 <label>New Job Number to Link</label>
									    <input type="text" class="form-control" placeholder="Client ID" id="ljt_new_job_number" required>
									 
									 
									  </div>
									  
									  
									</div>
                                 </div>
                                
                                
                                
                                
                                <h5 class="border-bottom border-gray pb-2">Job Details</h5>
                                <div class="form-group row">
                  
                					  <div class="col">
									  <label>Job Number</label>
									    <input type="text" class="form-control" placeholder="Job Number"  id="ljt_job_number" >
									  </div>
                					  
                					  <div class="col">
									   <button type="button"
												id="btn_ljt_search_for_job_number_details"
												class="btn btn-primary"
											>Search</button>
                                   		 
									  </div>
                  
              					  </div>
                                
                                 <div class="form-group">
                                 
                                    
                                    <div class="row">
                                      <div class="col">
                                       <label>Job Number</label>
									    <input type="text" readonly class="form-control" placeholder="Job Number" id="ljt_job_number_result" required>
									  </div>
									  <div class="col">
									 <label>Case Number</label>
									    <input type="text" readonly class="form-control" placeholder="Case Number" id="ljt_case_number" required>

									  </div>
									  
									  
									</div>
                                 </div>
                                
                                
                                 <div class="form-group">
                                 
                                    
                                    <div class="row">
                                      <div class="col">
                                       <label>Transaction Number</label>
									    <input type="text" class="form-control" placeholder="Transaction Number" id="ljt_transaction_number" required readonly>
									  </div>
									  <div class="col">
									 <label>Transaction Applicant Name</label>
									    <input type="text" class="form-control" placeholder="Applicant Name" id="ljt_ar_name" required readonly>

									  </div>
									  
									  
									</div>
                                 </div>
                                
                         
                                 
                              </form>
		

			</div>
			   <div class="modal-footer">
							<button type="button" class="btn btn-google btn-user btn-block"
								data-dismiss="modal">Close</button>
							<button type="button" id="btn_save_link_job_to_transaction"
								class="btn btn-primary btn-user btn-block">Link Job</button>
						</div>
		</div>
	</div>
</div>



<%-- <div class="modal fade bd-example-modal-xl" tabindex="-1" id="elisapplicationdetailsmodal" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Details of Case</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


			   <div class="row">
     
     
     
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
          
            <div class="card-body">


	    <div class="card">

		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsemaincase" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Case Details
		            </a>
		        </h5>
		        <div id="collapsemaincase" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		           <div class="card-body">

				      
				     	          <div class="form-group">
				            
				            <input type="hidden" id="cs_main_business_process_id_ed"  value="${business_process_id}">
				           <input type="hidden" id="cs_main_business_process_name_ed"  value="${business_process_name}">
				           <input type="hidden" id="cs_main_business_process_sub_id_ed"  value="${business_process_sub_id}">
				           <input type="hidden" id="cs_main_business_process_sub_name_ed"  value="${business_process_sub_name}">
				            <input type="hidden" id="cs_main_client_number_ed"  value="${phone_number}">
				            <input type="hidden" id="cs_main_application_stage_ed"  value="${application_stage}">
				           
				          
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Case Number</label>
								   <input   class="form-control" id="cs_main_case_number_ed"  name="cs_main_case_number"  type="text" aria-describedby="nameHelp"  value="${case_number}" >
        													
				                </div>
				                 <div class="col-md-4">
				                <label for="search_value">Regional Number</label>
				                <input   class="form-control"  id="cs_main_regional_number_ed"  type="text" aria-describedby="nameHelp"  value="${regional_number}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Locality</label>
				                <input   class="form-control"  id="cs_main_locality_ed" type="text" aria-describedby="nameHelp"  value="${locality}" >
				              </div>
				             
				            </div>
				            
				            
				      
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Registration District</label>
				                <input   class="form-control" id="cs_main_registration_district_number_ed" type="text" aria-describedby="nameHelp"  value="${registration_district_number}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Registration Section</label>
				                <input   class="form-control"  id="cs_main_registration_section_number_ed" type="text" aria-describedby="nameHelp"  value="${registration_section_number}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Registration Block</label>
				                <input   class="form-control" id="cs_main_registration_block_number_ed"  type="text" aria-describedby="nameHelp"  value="${registration_block_number}" >
				              </div>
				             
				            </div>
				            
				            
				               <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">District</label>
				                <input   class="form-control" id="cs_main_district_ed" type="text" aria-describedby="nameHelp"  value="${district}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Region</label>
				                <input   class="form-control" id="cs_main_region_ed" type="text" aria-describedby="nameHelp"  value="${region}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Size of Land</label>
				                <input   class="form-control" id="cs_main_size_of_land_ed"  type="text" aria-describedby="nameHelp"  value="${size_of_land}" >
				              </div>
				             
				            </div>
				            
				              <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Date of Document</label>
				                <input   class="form-control  date-picker" id="cs_main_date_of_document_ed" type="text" aria-describedby="nameHelp"  value="${date_of_document}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Nature of Instrument</label>
				                <input   class="form-control" id="cs_main_nature_of_instrument_ed" type="text" aria-describedby="nameHelp" value="${nature_of_instrument}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Type of Interest</label>
				                <input   class="form-control"  id="cs_main_type_of_interest_ed" type="text" aria-describedby="nameHelp" value="${type_of_interest}" >
				              </div>
				             
				            </div>
				            
				            
				             <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Type of Use</label>
				                <input   class="form-control" id="cs_main_type_of_use_ed" type="text" aria-describedby="nameHelp"  value="${type_of_use}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Term</label>
				                <input  class="form-control" id="cs_main_term_ed" type="text" aria-describedby="nameHelp"  value="${term}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Commencement Date</label>
				                <input  class="form-control"  id="cs_main_commencement_date_ed" type="text" aria-describedby="nameHelp"  value="${commencement_date}" >
				              </div>
				             
				            </div>
				            
				           
				             
				            
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Date of Registration</label>
								  <input  type="text" id="cs_main_date_of_registration_ed" class="form-control" aria-describedby="nameHelp"  value="">
        													
				                </div>
				                <div class="col-md-4">
				                <label for="search_value">Job Number</label>
								   <input  class="form-control" id="cs_main_job_numbe_ed"  name="cs_main_job_number"  type="text" value="${job_number}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Applicant Name</label>
								   <input  class="form-control" id="cs_main_ar_name_ed"  name="cs_main_ar_name"  type="text" aria-describedby="nameHelp"  value="${ar_name}" >
        													
				                </div>
				                
				                
				                
				                
				                
				               
				             
				            </div>
				            
				            <div class="form-row">
				            
				                <div class="col-md-4">
				                <label for="search_value">Transaction Number</label>
								   <input  class="form-control" id="cs_main_transaction_number_ed"  name="cs_main_transaction_number"  type="text" value="${transaction_number}" >
        													
				                </div>
				                
				                  <div class="col-md-4">
				                <label for="search_value">GLPIN</label>
								   <input  class="form-control" id="cs_main_glpin_ed"  name="cs_main_glpin"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				               
				                
				                
				                  <div class="col-md-4">
				                <label for="search_value">licensed_no</label>
								   <input  class="form-control" id="cs_main_licensed_no_ed"  name="cs_main_licensed_no"  type="text"  value="${licensed_no}" >
        													
				                </div>
				                
				               
				             
				             
				            </div>
				             
				             
				             
				                <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Assessed Value</label>
				                <input   class="form-control" id="cs_main_assessed_value_ed" type="text" aria-describedby="nameHelp"  value="${assessed_value}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Stamp Duty Payable</label>
				                <input  class="form-control"  id="cs_main_stamp_duty_payable_ed" type="text" aria-describedby="nameHelp"  value="${stamp_duty_payable}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Certificate Number</label>
				                <input  class="form-control" id="cs_main_certificate_number_ed" type="text" aria-describedby="nameHelp"  value="${certificate_number}" >
				              </div>
				             
				            </div>
				            
				            
				            
				            <div class="form-row">
				              <div class="col-md-3">
				                <label for="search_value">cs_main_registry_mapref</label>
				                <input   class="form-control" id="cs_main_registry_mapref_ed" type="text" aria-describedby="nameHelp"  value="${registry_mapref}" >
				              </div>
				              
				              <div class="col-md-3">
				                <label for="search_value">cs_main_plan_no</label>
				                <input   class="form-control" id="cs_main_plan_no_ed" type="text" aria-describedby="nameHelp"  value="${registry_mapref}" >
				              </div>
				              
				              <div class="col-md-3">
				                <label for="search_value">cs_main_cc_no</label>
				                <input   class="form-control" id="cs_main_cc_no_ed" type="text" aria-describedby="nameHelp"  value="${registry_mapref}" >
				              </div>
				              
				              <div class="col-md-3">
				                <label for="search_value">cs_main_ltr_plan_no</label>
				                <input   class="form-control" id="cs_main_ltr_plan_no_ed" type="text" aria-describedby="nameHelp"  value="${registry_mapref}" >
				              </div>
				               
				              
				             
				            </div>
				            
				             <div class="form-row">
				             
				              <div class="col-md-4">
				                <label for="search_value">Locality Class</label>
				                <input   class="form-control" id="cs_main_locality_class_ed" type="text" aria-describedby="nameHelp"  value="${registry_mapref}" >
				              </div>
				              
				              
				               <div class="col-md-4">
				             <label for="search_value">-</label>
				              <button class="btn btn-secondary btn-icon-split float-left " id="btn_update_case_of_old_application_ed" >
												<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text"> Save Changes </span>
											</button>
										
								 </div>
				              
				              
				              
				             
				            </div>
				            
				           
				            
				          </div>
				          
					        
		                
		            </div>
		        </div>
		    </div>
      
				  
				     

 		     
 <br>
          
	  <div id="accordion" role="tablist" aria-multiselectable="true">
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingOne">
		            <a data-toggle="collapse" data-parent="#accordion" href="#collapsejobs" aria-expanded="true" aria-controls="collapseOne" class="d-block">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-info-circle"></i>Jobs Related to Case
		            </a>
		        </h5>
		
		        <div id="collapsejobs" class="collapse" role="tabpanel" aria-labelledby="headingOne">
		            <div class="card-body">
		               
		               <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#addNewserviceBillModal" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Add New Service</span>
                    	</button>
                    	
                    	 
		               <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#afterPaymentModalonCase" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Acknowledge</span>
                    	</button>
                    	
                    	
                    	
		                <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm " id="lc_jobs_related_dataTable" >
				              <thead  class="table-success">
				                <tr >
				                 <th>Job Number</th>
				                 <th>Application Type</th>
				                <!--  <th>Current Status</th> -->
				                
				                  </tr>
				              </thead>
				              
				                <tbody>
								     <c:forEach items="${job_details}" var="job_row">
								                <tr>
								                    <td>${job_row.job_number}</td>
								                    <td>${job_row.business_process_sub_name}</td>
								                    <td>${job_row.current_application_status}</td>
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
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fa fa-users"></i>Parties
		            </a>
		        </h5>
		        <div id="collapseparties" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		                
							<button type="button" class=" float-right btn btn-primary"
								id="lrd_btn_add_grantor" data-placement="top"
								data-toggle="modal" data-target="#addeditpartyGeneral"
								data-toggle="tooltip" title="Add party"
							>
								<i class="fa fa-plus-circle"></i>Add Grantor
							</button>
							
							<button type="button" class=" float-left btn btn-primary"
								id="lrd_btn_add_grantee" data-placement="top"
								data-toggle="modal" data-target="#addeditpartyGeneral"
								data-toggle="tooltip" title="Add party"
							>
								<i class="fa fa-plus-circle"></i>Add Applicant
							</button>
		                
		                 
					         <!-- <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addeditparty" data-toggle="tooltip" title="Draw a Line">
					            <i class="fa fa-plus-circle"></i>
					        </button> -->
		                
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lc_parties_details_dataTable" >
				           
				              <thead>
				                <tr>
				
				                <th>Name</th>
				                <th>Sex</th>
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
						                    <td class="to_hide_on_level_1">
						                    
						                    <p data-placement="top"  title="Edit Party">  
			          							<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
			          								 data-target="#addeditpartyGeneral"
			          								 data-target-id="${parties_row.ar_client_id}"  
			          								 data-ar_name="${parties_row.ar_name}"
			          								 data-ar_gender="${parties_row.ar_gender}"
			          								 data-ar_address="${parties_row.ar_address}"
			          								 data-ar_cell_phone="${parties_row.ar_cell_phone}"
			          								 data-ar_cell_phone2="${parties_row.ar_cell_phone2}"
			          								 data-ar_tin_no="${parties_row.ar_tin_no}"
			          								 data-ar_id_type="${parties_row.ar_id_type}"
			          								 data-ar_id_number="${parties_row.ar_id_number}"
			          								 data-ar_location="${parties_row.ar_location}"
			          								 data-ar_district="${parties_row.ar_district}"
			          								 data-type_of_party="${parties_row.type_of_party}"
			          								 data-ar_region="${parties_row.ar_region}"
			          								 data-ar_person_type="${parties_row.ar_person_type}"
			          								 > 
			          								    	 
			          								    	 
			          								<span class="icon text-white-50"> 
			          								<i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>
			          						</p>
						                    
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
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingTwo">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseminutes" aria-expanded="false" aria-controls="collapseTwo">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-clipboard"></i>Minutes On Application
		            </a>
		        </h5>
		        <div id="collapseminutes" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
		            <div class="card-body">
		                
		                 <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" 
		                 data-target="#addMinutesModal" data-toggle="tooltip" >
		            		<i class="fa fa-plus-circle"></i>
		       			 </button>
		                <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm data-table" id="lrd_scanned_documents_dataTable" >
				           
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
								                    <td>${application_munites_row.am_from_officer}</td>
								                    <td>${application_munites_row.am_to_officer}</td>
								                    <td>${application_munites_row.am_activity_date}</td>
								                    <td><p data-placement="top" data-toggle="tooltip" title="View">
								                    	<button class="btn btn-info btn-icon-split"  data-toggle="modal" data-target="#addMinutesModal" 
								                    	data-target-id="${application_munites_row.am_id}" 
								                    	data-am_description="${application_munites_row.am_description}" 
								                    	data-am_from_officer="${application_munites_row.am_from_officer}" 
								                    	data-am_to_officer="${application_munites_row.am_to_officer}" 
								                    	data-am_activity_date="${application_munites_row.am_activity_date}"
								                    	
								                    	
								                    	>
								                    	<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">View</span>
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
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Documents On Application
		            </a>
		        </h5>
		        <div id="collapsedocs" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		              	  <button type="button" class="btn btn-primary" id="btn_load_scanned_documents_ed" data-placement="top"  title="Load Docs">
					            <i class="fas fa-eye"></i>
					        </button>
					        
					        <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-toggle="modal" data-target="#transitional_certificate_template" title="Add Documents">
					            <i class="fa fa-plus-circle"></i>
					        </button> 
					        
					        
					        
					      
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable_ed" width="100%" class="display" cellspacing="0">
				           
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
											<form action="registration_application_progress_details" method="post">
												<input type="hidden" name="document_path" id="document_path" value="${casescanneddocuments_row.document_file}">
													<button type="submit" name="save" class="btn btn-info btn-icon-split" >
													<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>
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
					        
					        <button type="button" class="btn btn-primary" id="lrd_btn_add_new_public_document"  title="Add Documents">
					            <i class="fa fa-plus-circle"></i>
					        </button> 
					        
					        
					        
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lc_public_documents_dataTable" width="100%" class="display" cellspacing="0">
				           
				              <thead>
				                <tr>
				
				                 <th>Document Name</th>
				                 <th>Document Type</th>
				               </tr>
				              </thead>
				              
				                <tbody>				
							    <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
				                <tr>
				                    <td>${casescanneddocuments_row.document_name}</td>
				                    <td>${casescanneddocuments_row.document_type}</td>
					                    <td>
											<form action="registration_application_progress_details" method="post">
												<input type="hidden" name="document_path" id="document_path" value="${casescanneddocuments_row.document_file}">
													<button type="submit" name="save" class="btn btn-info btn-icon-split" >
													<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>
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
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsenotes" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-comment-dots"></i>Notes Or Reports
		            </a>
		        </h5>
		        <div id="collapsenotes" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		            	<button type="button" class="btn btn-primary" id="lc_btn_add_note_on_application_all" data-placement="top"  data-toggle="tooltip" >
		            		<i class="fa fa-plus-circle"></i>
		       			 </button>
		                
		                 <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Note Or Reports Information</div>
				            <div class="card-body">
				         
		                
		                 
		                
		                
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lrd_scanned_documents_dataTable" >
				           
				              <thead>
				                <tr>
				
				                 <th>Note</th>
				                 <th>Note By</th>
				                 <th>Note Date</th>
				                 <th>Action</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							      <c:forEach items="${application_notes}" var="application_notes_row">
						                <tr>
								                    <td class="text-truncate" style="max-width:100px;">${application_notes_row.an_description}</td>
								                    <td>${application_notes_row.created_by}</td>
								                    <td>${application_notes_row.created_date}</td>
								                    
								                    <td><p data-placement="top" data-toggle="tooltip" title="View/Edit">
								                    	<button class="btn btn-info btn-icon-split"  data-toggle="modal" data-target="#addNotesModal" 
								                    	data-target-id="${application_notes_row.an_id}" 
								                    	data-an_description="${application_notes_row.an_description}" 
								                    	data-created_by="${application_notes_row.created_by}"  
								                    	data-created_date="${application_notes_row.created_date}" 
								                    	data-modified_by="${application_notes_row.created_by}"  
								                    	data-modified_date="${application_notes_row.created_date}" 
								                    	
								                    	
								                    	
								                    	>
								                    	<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">View</span>
								                    	</button></p></td>
								                 </tr>
						            </c:forEach> 
			  					</tbody>
				  			</table>
				          </div>
		            </div>
		        </div>
		    </div>
		  </div>
		    <br>
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsecomments" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-comment-dots"></i>History Or Tracking Information
		            </a>
		        </h5>
		        <div id="collapsecomments" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		                 <div class="card-header">
				              <i class="fa fa-pie-chart"></i> Comments Or Tracking Information</div>
				            <div class="card-body">
				         
		                
		                 
		                
		                
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lrd_scanned_documents_dataTable" >
				           
				              <thead>
				                <tr>
				
				                 <th>Comment</th>
				                 <th>Comment By</th>
				                 <th>Comment Date</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							     <c:forEach items="${comments_on_application}" var="comments_on_application_row">
						                <tr>
						                    <td>${comments_on_application_row.officers_general_comments}</td>
						                    <td>${comments_on_application_row.created_by}</td>
						                    <td>${comments_on_application_row.created_date}</td>
						                 </tr>
						            </c:forEach>
			  					</tbody>
				  			</table>
				          </div>
		            </div>
		        </div>
		    </div>
		  </div>
		    <br>
		    
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsebills" aria-expanded="false" aria-controls="collapseFour">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-money-bill-alt"></i>Bill and  Payments
		            </a>
		        </h5>
		        <div id="collapsebills" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		              
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="bill_payment_dataTable">
				           
				              <thead>
				                <tr>
				
				                 <th>Bill No</th>
				                 <th>Amount</th>
				                 <th>Receipt Number</th>
				                 <th>Payment Date</th>
				                 <th>Division</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							     <c:forEach items="${payment_bill}" var="payment_bill_row">
					                <tr>
					                    <td>${payment_bill_row.bill_number}</td>
					                    <td>${payment_bill_row.bill_amount}</td>
					                    <td>${payment_bill_row.payment_slip_number}</td>
					                    <td>${payment_bill_row.payment_date}</td>
					                    <td>${payment_bill_row.division}</td>
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
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseencumbrance" aria-expanded="false" aria-controls="collapseencumbrance">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-money-bill-alt"></i>Encumbrances
		            </a>
		        </h5>
		        <div id="collapseencumbrance" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		              
		                <button type="button" class="btn btn-primary" id="lrd_btn_add_encumbrance" data-placement="top" data-toggle="modal" data-target="#newEncumberancesModal" data-toggle="tooltip" title="Draw a Line">
					            <i class="fa fa-plus-circle"></i>
					        </button>
					        
					     <!--    <a href="#myModal" class="btn btn-lg btn-primary" data-toggle="modal">Launch Demo Modal</a> -->
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lrd_registration_encumbrance_dataTable">
				           
				              <thead>
								<tr>
									<!-- 	es_id -->
														 <th>Registered Number</th>
														 <th>Date of Instrument</th>
														 <th>Date of Registration</th>
														 <th>Memorials</th>
														 <th>Remarks</th>
														 <th>Entry No.</th>
														 <th>Action</th>
														  </tr>
													  </thead>
													  
				
														<tbody>
														 <c:forEach items="${lrd_encumbrances_section}" var="lrd_encumbrances_section_row">
															<tr>
																<td>${lrd_encumbrances_section_row.es_registered_number}</td>
																<td>${lrd_encumbrances_section_row.es_date_of_instrument}</td>
																<td>${lrd_encumbrances_section_row.es_date_of_registration}</td>
																<td>${lrd_encumbrances_section_row.es_memorials}</td>
																<td>${lrd_encumbrances_section_row.es_remarks}</td>
																<td>${lrd_encumbrances_section_row.es_entry_number}</td>
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
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseobjections" aria-expanded="false" aria-controls="collapseobjections">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-money-bill-alt"></i>Objections
		            </a>
		        </h5>
		        <div id="collapseobjections" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		               <button type="button" class="btn btn-primary" id="lrd_btn_add_objections" data-placement="top" data-toggle="modal" data-target="#newObjectionModal" data-toggle="tooltip" title="Draw a Line">
					            <i class="fa fa-plus-circle"></i>
					    </button>
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm">
								      		<thead>
								      			<tr>
								      				<th>Objector </th>
								      				<th>Address</th>
								      				<th>Contact</th>
								      				<th>Reasons </th>
								      				<th>Remarks </th>
								      				<th>Action</th>
								      			</tr>
								      		</thead>
								      		
								      		<tbody>
											     <c:forEach items="${case_objection}" var="case_objection_row">
									                <tr>
									                    <td>${case_objection_row.objector_name}</td>
									                    <td>${case_objection_row.objector_address}</td>
									                    <td>${case_objection_row.objector_contact}</td>
									                    <td>${case_objection_row.reasons}</td>
									                    <td>${case_objection_row.remarks}</td>
									                    
									                    <td>
										      					<button type="button" 
										      					
										      					id="editOjectionModal"  
										      					data-toggle="modal" 
										      					data-target="#newObjectionModal"  
										      					data-action="edit"  
    								    						data-target-id= ${case_objection_row.id} 
      								    	 					data-objector_name= ${case_objection_row.objector_name}  
      								    	  					data-objector_address=${case_objection_row.objector_address} 
      								    	  					data-objector_contact=${case_objection_row.objector_contact} 
      								    	  					data-reasons= ${case_objection_row.reasons} 
      								    	 					data-remarks=${case_objection_row.remarks} 
      								    	 					data-status=${case_objection_row.status} 
      								    	 					

										      					class="btn btn-danger btn-icon-split "  
										      					title="edit objection" >
													    			<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
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
		    
		    
		      <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsequeries" aria-expanded="false" aria-controls="collapseFour">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-money-bill-alt"></i>Queries
		            </a>
		        </h5>
		        <div id="collapsequeries" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		               <button type="button" class="btn btn-primary" id="lrd_btn_add_querys" data-placement="top" data-toggle="modal" data-target="#newQueryModal" data-toggle="tooltip" title="Draw a Line">
					            <i class="fa fa-plus-circle"></i>
					        </button>
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lc_case_query_dataTable">
				           
				              <thead>
								      			<tr>
								      				<th>Job Number </th>
								      				<th>Reasons</th>
								      				<th>Remarks</th>
								      				<th>Created_date </th>
								      				<th>Action </th>
								      			
								      			</tr>
								      		</thead>
								      		
								      		<tbody>
											     <c:forEach items="${case_query}" var="case_query_row">
									                <tr>
									                    <td>${case_query_row.job_number}</td>
									                    <td>${case_query_row.reasons}</td>
									                    <td>${case_query_row.remarks}</td>
									                    <td>${case_query_row.created_date}</td>
									                    
									                    
									                    <td>
										      					<button type="button" id="editQueryModal"  data-toggle="modal" 
										      					data-target="#newQueryModal"  data-action="edit"  
										      					class="btn btn-icon-split  ${case_query_row.status == 1 ? 'btn-danger' : 'btn-info'}"  title="Edit Query" 
										      					
										      					data-id="${case_query_row.qid}" 
										                    	data-job_number="${case_query_row.am_description}" 
										                    	data-reasons="${case_query_row.reasons}" 
										                    	data-remarks="${case_query_row.remarks}" 
										                    	data-status="${case_query_row.status}" 
										                    	data-created_by="${case_query_row.created_by}" 
										                    	data-created_date="${case_query_row.created_date}" 
										                    	data-modified_by="${case_query_row.modified_by}" 
										                    	data-modified_date="${case_query_row.modified_date}" 

								                    	
										      					
										      					>
													    			<span class="icon text-white-50"> 
													    			
													    			
													    			${case_query_row.status == 1 ? '<i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>' : '<i class="fas fa-eye"></i></span><span class="text">View</span>'}
													    			
													    			
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
		    
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collainspections" aria-expanded="false" aria-controls="collapseFour">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-money-bill-alt"></i>Inspection Reports
		            </a>
		        </h5>
		        <div id="collainspections" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		               <button type="button" class="btn btn-primary" id="lrd_btn_add_querys" data-placement="top" data-toggle="modal" data-target="#newInspection" data-toggle="tooltip" title="Draw a Line">
					            <i class="fa fa-plus-circle"></i>
					        </button>
		              
		                <div  class="table-responsive">
				           <table class="table">
								<thead>
									<tr>
										<th>Date</th>
										<th>Officer (Requested)</th>
										<th>Officer (Inspection)</th>
										<th>Purpose</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${case_inspections}" var="case_inspections_row">
									                <tr>
									                    <td>${case_inspections_row.inspection_date}</td>
									                    <td>${case_inspections_row.requested_by}</td>
									                    <td>${case_inspections_row.created_by}</td>
									                    <td>${case_inspections_row.inspection_purpose}</td>
									                    
									                    <td>
										      					<button type="button" id="btn-view-inpection-report"  data-toggle="modal" data-target="#viewInspectionReportModal"  class="btn btn-primary btn-icon-split "  title="View Inspection Report" >
													    			<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>
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
		    
 
      

      
            
          
            </div>
          
          </div>
          
         
        
    
   
        
      </div>
      
      
      
      

      
     </div>
      
			
			

			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
				<input type="hidden" id="lrd_ps_fid" name="lrd_ps_fid">
			</div>

		</div>
	</div>
</div> --%>


<!-- Add File Upload============================= -->
<div class="modal fade" id="fileUploadModalPublic" tabindex="-1" role="dialog"
	aria-labelledby="fileUploadModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="fileUploadModalLabel">Upload File</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
			
			
			
			 <form class="form-horizontal" method="POST" enctype="multipart/form-data" id="id_form_pu">
			    <label for="file">File:</label>
			    <input id="fileUploadForm_pu" class="form-control" type="file" name="fileUploadForm_pu" />
			   
			   <label for="query_case_number" class="col-form-label">Case
									Number</label> 
									<input type="text" name="file_upload_case_number_pu"
									id="file_upload_case_number_pu" class="form-control mb-2" required readonly value="${case_number}"
								>
			    <input type="button" id="btn_upload_case_file_pu"
								class="btn btn-primary" value="Click to upload"
							>
			</form>
			
		
					
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal"
						>Close</button>
					</div>
				
				
				
			</div>
		</div>
	</div>






<div class="modal fade" id="clientAttentionRequiredModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Update Application as Client Attention Required</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">



				<div class="form-group">              
					<div class="row">
						<div class="col">
						<label>Job Number</label>
							<input type="text" class="form-control" placeholder="Job Number" id="cat_job_number" required>
						</div>
						<div class="col">
							<label>Service Type</label>
							<input type="text" class="form-control" placeholder="Case Number" id="cat_business_process_sub_name" required>
						</div>
					</div>
				</div>
				
				
				
				
				<div class="form-group row">
					  <div class="col">
					  <label>Applicant Name</label>
						<input type="text" class="form-control" placeholder="Other name"  id="cat_applicant_name" >
					  </div>
					  <div class="col">
						  
						<button type="button"id="btn_process_job_for_cat" class="btn btn-primary">Update</button>
					
					  </div>
  
					</div>
				
			  


			</div>
			   <div class="modal-footer"><button type="button" class="btn btn-google btn-user btn-block" data-dismiss="modal">Close</button></div>
	     </div>
	</div>
</div>


<div class="modal fade" id="incoming_advanced_search" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Advanced Filter</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="adv_inbox_type" class="form-control" />

				<div class="form-group">
					  	
					<label><b>Filter By: </b></label>
			
					<div class="custom-control custom-radio custom-control-inline">
					  <input type="radio" id="adv_filter_type_1" name="adv_search_type" class="custom-control-input" value="f_job_number" checked required>
					  <label class="custom-control-label" for="adv_filter_type_1">Job number</label>
					</div>
					<div class="custom-control custom-radio custom-control-inline exclude_all">
					  <input type="radio" id="adv_filter_type_2" name="adv_search_type" class="custom-control-input" value="f_app_type" required>
					  <label class="custom-control-label" for="adv_filter_type_2">Applicantion Type</label>
					</div>
					<div class="custom-control custom-radio custom-control-inline exclude_all">
						<input type="radio" id="adv_filter_type_3" name="adv_search_type" class="custom-control-input" value="f_date_range" required>
						<label class="custom-control-label" for="adv_filter_type_3">Date Range</label>
					  </div>
					  <div class="custom-control custom-radio custom-control-inline exclude_all">
						<input type="radio" id="adv_filter_type_4" name="adv_search_type" class="custom-control-input" value="f_job_purpose" required>
						<label class="custom-control-label" for="adv_filter_type_4">Job Purpose</label>
					  </div>
					  <div class="custom-control custom-radio custom-control-inline exclude_all">
						<input type="radio" id="adv_filter_type_5" name="adv_search_type" class="custom-control-input" value="f_limit" required>
						<label class="custom-control-label" for="adv_filter_type_5">Set Limit</label>
					  </div>
				
				</div>

				<div class="form-group mt-2">    
					<label><b>status: </b></label>          
					<div class="row">
						<div class="col">

							<input class="form-control" id="adv_status" readonly />
						</div>
					</div>
				</div>

				<!-- <div class="form-group ">
					  	
					<label><b>Filter By: </b></label>
			
					<div class="custom-control custom-radio custom-control-inline">
					  <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="custom-control-input" value="job_number" checked required>
					  <label class="custom-control-label" for="rbtn_search_type1">Job number</label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
					  <input type="radio" id="rbtn_search_type2" name="rbtn_search_type" class="custom-control-input" value="ar_name" required>
					  <label class="custom-control-label" for="rbtn_search_type2">Applicant Name</label>
					</div>
				
				</div> -->

				<div class="form-group mt-2 include_job_search exclude_job_purpose exclude_app_type exclude_date_range exclude_limit">    
					<label><b>Job Number: </b></label>             
					<div class="row">
						<div class="col">
							<input type="text" class="form-control" placeholder="Enter Job Number" id="adv_job_number" required>
						</div>
					</div>
				</div>
				
				<div class="form-group mt-2 include_app_type exclude_job_purpose exclude_job_search exclude_date_range exclude_limit">    
					<label><b>Application Type: </b></label>          
					<div class="row">
						<div class="col">
							<select class="form-control" id="adv_application_type">

							</select>
						</div>
					</div>
				</div>

				<div class="form-group mt-2 include_job_purpose include_app_type exclude_job_search exclude_date_range exclude_limit">
					<label for="bl_job_purpose"><b>Job Purpose</b></label>
					<select name="adv_job_purpose" id="adv_job_purpose" class="form-control selectpicker">
						
					</select>
				</div>

				<div class="form-group mt-2 include_app_type include_job_purpose include_date_range exclude_job_search include_limit">    
					<label><b>Limit (Not More Than 1000): </b></label>          
					<div class="row">
						<div class="col">
							<input type="number" class="form-control" placeholder="" max="1000" id="adv_limit" required>
						</div>
					</div>
				</div>

				<div class="form-group mt-2 include_app_type include_job_purpose exclude_job_search exclude_date_range include_limit">    
					<label><b>Sorting: </b></label>          
					<div class="row">
						<div class="col">
							<!-- <input type="date" class="form-control" placeholder="" id="adv_from_date" required> -->
							 <select class="form-control" id="adv_sorting">
								<option value="">-- select --</option>
								<option value="asc">Ascending</option>
								<option value="desc">Descending</option>
							 </select>
						</div>
					</div>
				</div>

				<div class="form-group mt-2 include_date_range exclude_job_search exclude_job_purpose exclude_app_type exclude_limit">    
					<label><b>From Date: </b></label>          
					<div class="row">
						<div class="col">
							<input type="date" class="form-control" placeholder="" id="adv_from_date" required>
						</div>
					</div>
				</div>

				<div class="form-group mt-2 include_date_range exclude_job_search exclude_job_purpose exclude_app_type exclude_limit">    
					<label><b>To Date: </b></label>          
					<div class="row">
						<div class="col">
							<input type="date" class="form-control" placeholder="" id="adv_to_date" required>
						</div>
					</div>
				</div>
				
			</div>
			   <div class="modal-footer"><button type="button" class="btn btn-google btn-user btn-block" data-id="1" id="btn_load_adv_filter">Load</button></div>
	     </div>
	</div>
</div>


<div class="modal fade" id="incoming_advanced_search_fr" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Advanced Filter</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<input type="hidden" value="6_false" id="adv_inbox_typefr" class="form-control" />

				<div class="form-group">
					  	
					<label><b>Filter By: </b></label>
			
					<div class="custom-control custom-radio custom-control-inline">
					  <input type="radio" id="adv_filter_type_1fr" name="adv_search_type" class="custom-control-input" value="f_job_number" checked required>
					  <label class="custom-control-label" for="adv_filter_type_1fr">Job number</label>
					</div>
					<div class="custom-control custom-radio custom-control-inline exclude_all">
					  <input type="radio" id="adv_filter_type_2fr" name="adv_search_type" class="custom-control-input" value="f_app_type" required>
					  <label class="custom-control-label" for="adv_filter_type_2fr">Applicantion Type</label>
					</div>
					<div class="custom-control custom-radio custom-control-inline exclude_all">
						<input type="radio" id="adv_filter_type_3fr" name="adv_search_type" class="custom-control-input" value="f_date_range" required>
						<label class="custom-control-label" for="adv_filter_type_3fr">Date Range</label>
					  </div>
					  <!-- <div class="custom-control custom-radio custom-control-inline exclude_all">
						<input type="radio" id="adv_filter_type_4fr" name="adv_search_type" class="custom-control-input" value="f_job_purpose" required>
						<label class="custom-control-label" for="adv_filter_type_4fr">Job Purpose</label>
					  </div> -->
					  <div class="custom-control custom-radio custom-control-inline exclude_all">
						<input type="radio" id="adv_filter_type_5fr" name="adv_search_type" class="custom-control-input" value="f_limit" required>
						<label class="custom-control-label" for="adv_filter_type_5fr">Set Limit</label>
					  </div>
				
				</div>

				<div class="form-group mt-2 include_job_search exclude_job_purpose exclude_app_type exclude_date_range exclude_limit">    
					<label><b>Job Number: </b></label>             
					<div class="row">
						<div class="col">
							<input type="text" class="form-control" placeholder="Enter Job Number" id="adv_job_numberfr" required>
						</div>
					</div>
				</div>
				
				<div class="form-group mt-2 include_app_type exclude_job_purpose exclude_job_search exclude_date_range exclude_limit">    
					<label><b>Application Type: </b></label>          
					<div class="row">
						<div class="col">
							<select class="form-control" id="adv_application_typefr">

							</select>
						</div>
					</div>
				</div>

				<!-- <div class="form-group mt-2 include_job_purpose include_app_type exclude_job_search exclude_date_range exclude_limit">
					<label for="bl_job_purpose"><b>Job Purpose</b></label>
					<select name="adv_job_purpose" id="adv_job_purposefr" class="form-control selectpicker">
						
					</select>
				</div> -->

				<div class="form-group mt-2 include_app_type include_job_purpose include_date_range exclude_job_search include_limit">    
					<label><b>Limit (Not More Than 1000): </b></label>          
					<div class="row">
						<div class="col">
							<input type="number" class="form-control" placeholder="" max="1000" id="adv_limitfr" required>
						</div>
					</div>
				</div>

				<div class="form-group mt-2 include_app_type include_job_purpose exclude_job_search exclude_date_range include_limit">    
					<label><b>Sorting: </b></label>          
					<div class="row">
						<div class="col">
							<!-- <input type="date" class="form-control" placeholder="" id="adv_from_date" required> -->
							 <select class="form-control" id="adv_sortingfr">
								<option value="">-- select --</option>
								<option value="asc">Ascending</option>
								<option value="desc">Descending</option>
							 </select>
						</div>
					</div>
				</div>

				<div class="form-group mt-2 include_date_range exclude_job_search exclude_job_purpose exclude_app_type exclude_limit">    
					<label><b>From Date: </b></label>          
					<div class="row">
						<div class="col">
							<input type="date" class="form-control" placeholder="" id="adv_from_datefr" required>
						</div>
					</div>
				</div>

				<div class="form-group mt-2 include_date_range exclude_job_search exclude_job_purpose exclude_app_type exclude_limit">    
					<label><b>To Date: </b></label>          
					<div class="row">
						<div class="col">
							<input type="date" class="form-control" placeholder="" id="adv_to_datefr" required>
						</div>
					</div>
				</div>
				
			</div>
			   <div class="modal-footer"><button type="button" class="btn btn-google btn-user btn-block" data-id="1" id="btn_load_adv_filterfr">Load</button></div>
	     </div>
	</div>
</div>





	
	
