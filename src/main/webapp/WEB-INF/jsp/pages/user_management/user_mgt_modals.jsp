<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>




<!--===============================================NEW UPDATE JUDE ========================================================================  -->
<div class="modal fade effect-scale modal-blur" id="addupdateuserdatails" tabindex="-1" aria-labelledby="addupdateuserdatailsLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="addupdateuserdatailsLabel">
                    <i class="fas fa-user-edit me-2"></i>Add/Edit User
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <form id="frmAddEditUser">
                <div class="modal-body">
                    <input id="ur_userid" name="ur_userid" type="hidden" value="0">
                    <input id="ur_id" name="ur_id" type="hidden" value="0">
                    <input id="ur_regional_code" name="ur_regional_code" type="hidden" value="">

                    <!-- Personal Information Section -->
                    <div class="mb-4">
                        <h6 class="border-bottom pb-2 mb-3">
                            <i class="fas fa-user-circle me-2"></i>Personal Information
                        </h6>
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="ur_title" class="form-label">Title</label>
                                <select id="ur_title" class="form-select" required >
                                    <option value="Mr">Mr</option>
                                    <option value="Ms">Ms</option>
                                    <option value="Mrs">Mrs</option>
                                    <option value="Dr">Dr</option>
                                    <option value="Rev">Rev</option>
                                    <option value="Prof">Prof</option>
                                    <option value="Surv">Surv</option>
                                    <option value="Eng">Eng</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_fullname" class="form-label">Full Name</label>
                                <input class="form-control" id="ur_fullname" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_address" class="form-label">Address</label>
                                <textarea rows="2" class="form-control" id="ur_address"></textarea>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_emailaddress" class="form-label">E-Mail Address</label>
                                <input type="email" class="form-control" id="ur_emailaddress" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_phone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="ur_phone" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_mobile" class="form-label">Mobile Number</label>
                                <input type="tel" class="form-control" id="ur_mobile">
                            </div>
                        </div>
                    </div>

                    <!-- Employment Information Section -->
                    <div class="mb-4">
                        <h6 class="border-bottom pb-2 mb-3">
                            <i class="fas fa-briefcase me-2"></i>Employment Information
                        </h6>
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="ur_staffnumber" class="form-label">Staff Number</label>
                                <input type="text" class="form-control" id="ur_staffnumber" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_designation" class="form-label">Designation</label>
                                <select id="ur_designation" class="form-select">
                                    <option value="">Select Designation</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Office Information Section -->
                    <div class="mb-4">
                        <h6 class="border-bottom pb-2 mb-3">
                            <i class="fas fa-building me-2"></i>Office Information
                        </h6>
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="ur_region" class="form-label">Region</label>
                                <select id="ur_region" class="form-select" required>
                                    <option value="">Select Region</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_district" class="form-label">Office Location</label>
                                <select id="ur_district" class="form-select" required>
                                    <option value="">Select Office Location</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_division" class="form-label">Division</label>
                                <select id="ur_division" class="form-select">
                                    <option value="">Select Division</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_department" class="form-label">Department/Unit</label>
                                <input class="form-control" list="listofunits" id="ur_department" placeholder="Select or type department" required>
                                <datalist id="listofunits"></datalist>
                            </div>
                        </div>
                    </div>

                    <!-- Account Information Section -->
                    <div class="mb-4">
                        <h6 class="border-bottom pb-2 mb-3">
                            <i class="fas fa-user-lock me-2"></i>Account Information
                        </h6>
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="ur_username" class="form-label">Username</label>
                                <input type="text" class="form-control" id="ur_username" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_userprofile" class="form-label">User Profile</label>
                                <select id="ur_userprofile" class="form-select">
                                    <option value="Admin">Administrator</option>
                                    <option value="User" selected>User</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_user_level" class="form-label">User Level</label>
                                <select id="ur_user_level" class="form-select" required>
                                    <option value="1">Level 1</option>
                                    <option value="2">Level 2</option>
                                    <option value="3">Level 3</option>
                                    <option value="4">Level 4</option>
                                    <option value="5">Level 5</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="usr_access_level" class="form-label">User Access Level</label>
                                <select id="usr_access_level" class="form-select" required>
                                    <option value="" disabled selected>-- select --</option>
                                    <c:forEach items="${elis_app_levels_list}" var="applevellist">
                                        <option value="${applevellist.eal_name}">${applevellist.eal_description}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Security Settings Section -->
                    <div class="mb-4">
                        <h6 class="border-bottom pb-2 mb-3">
                            <i class="fas fa-shield-alt me-2"></i>Security Settings
                        </h6>
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="ur_web_pass" class="form-label">Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="ur_web_pass">
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_web_pass_confirm" class="form-label">Confirm Password</label>
                                <input type="password" class="form-control" id="ur_web_pass_confirm">
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_isdisabled" class="form-label">Account Status</label>
                                <select id="ur_isdisabled" class="form-select" required>
                                    <option value="No">Active</option>
                                    <option value="Yes">Disabled</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_passwordchanged" class="form-label">Force Password Change</label>
                                <select id="ur_passwordchanged" class="form-select">
                                    <option value="NO">Yes (Force Change)</option>
                                    <option value="YES">No</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_canpasswordexpire" class="form-label">Password Expiry</label>
                                <select id="ur_canpasswordexpire" class="form-select">
                                    <option value="Yes">Yes (Password Expires)</option>
                                    <option value="No">No (Never Expires)</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="ur_passwordexpirydate" class="form-label">Password Expiry Date</label>
                                <input type="date" class="form-control" id="ur_passwordexpirydate">
                            </div>
                            
                            <div class="col-md-12">
                                <label for="ur_view_all_offices" class="form-label">Cross-Office Access</label>
                                <select id="ur_view_all_offices" class="form-select">
                                    <option value="No">No (Only Assigned Office)</option>
                                    <option value="Yes">Yes (All Offices)</option>
                                </select>
                                <div class="form-text">
                                    Allow user to view applications in all office regions
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>Close
                    </button>
                    <button type="submit" id="btnsaveuserdetails" class="btn btn-primary">
                        <i class="fas fa-save me-1"></i>Save User
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>




<!-- <div class="modal fade" id="addupdateuserdatails-old" tabindex="-1"
	role="dialog" aria-labelledby="addupdateuserdatails" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true" >
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Add New User</h4>
			</div>
			<div class="modal-body">
				
				<input id="ur_userid" name="ur_userid" type="hidden" value="0">
				<div class="form-group">
					<label for="bl_job_number">Title</label> 
							<select
								name="ur_title" id="ur_title"
								data-live-search="true"
								data-none-results-text="I found no results"
								title="Please select fruit" class="form-control selectpicker"
							>
								<option value="Mr.">Mr.</option>
								<option value="Mrs.">Mrs.</option>
							</select>
				</div>
				

				<div class="form-group">
					<label for="bl_ar_name_gen">Full Name</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="ur_fullname"
					></textarea>
				</div>
				
				<div class="form-group">
					<label for="bl_ar_name_gen">Address</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="ur_address"
					></textarea>
				</div>
				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="bl_job_number">Phone #</label> <input
								class="form-control " type="text"
								placeholder="" id="ur_phone"
							>
						</div>

						<div class="col">
							<label for="bl_job_number">Phone # 2</label> <input
								class="form-control " type="text"
								placeholder="" id="ur_mobile"
							>
						</div>
					</div>
				</div>
				
				
				<div class="form-group">
					<label for="">E-Mail Address</label> <input type="text"
						class="form-control" id="ur_emailaddress"
						placeholder="" required
					>
				</div>

				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="">staffnumber</label> <input type="text"
						class="form-control" id="ur_staffnumber"
						placeholder="" required
					>
						</div>

						<div class="col">
							<label for="bl_job_number">Designation</label> 
							<select
								name="ur_designation" id="ur_designation"
								data-live-search="true"
								data-none-results-text="I found no results"
								title="Please select fruit" class="form-control selectpicker"
							>
								<option value="Front Officer Task">Front Officer</option>
								<option value="Back Office Task">Back Office Task</option>
							</select>
						</div>
					</div>
				</div>
				
				
				
				
				
				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="bl_job_number">Region</label> <select
								name="ur_region" id="ur_region"
								data-live-search="true" class="form-control selectpicker"
							>
								<option value="Greater Accra">Greater Accra</option>
								<option value="Ashanti">Ashanti</option>
								<option value="Eastern">Eastern</option>
								<option value="Ahafo">Ahafo</option>

							</select>
						</div>

						<div class="col">
							<label for="bl_job_number">Office District</label> <select
								name="ur_district" id="ur_district"
								data-live-search="true" class="form-control selectpicker"
							>
								<option value="11">Tema</option>
								<option value="Accra">Accra</option>
								<option value="Amasaman">Amasaman</option>
								<option value="Winneba">Winneba</option>

							</select>
						</div>
					</div>
				</div>
				
				
				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="bl_job_number">Division</label> 
							<select
								name="ur_designation" id="ur_division"
								data-live-search="true"
								data-none-results-text="I found no results"
								title="Please select fruit" class="form-control selectpicker"
							>
								<option value="LRD">LRD</option>
								<option value="PVLMD">PVLMD</option>
								<option value="LVD">LVD</option>
								<option value="SMD">SMD</option>
								 <option value="RLO">RLO</option>
							</select>
						</div>

						<div class="col">
							<label for="bl_job_number">Department</label> 
							<select
								name="ur_designation" id="ur_department"
								data-live-search="true"
								data-none-results-text="I found no results"
								title="Please select fruit" class="form-control selectpicker"
							>
								<option value="Stampping Unit">Stampping Unit</option>
								<option value="Assessment Unit">Assessment Unit</option>
								<option value="Technical Unit">Technical Unit</option>
								<option value="Technical Unit">Technical Unit</option>
							</select>
						</div>
					</div>
				</div>
				
				
				
			
				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="bl_job_number">Location</label> <select
								name="ur_location" id="ur_location"
								data-live-search="true" class="form-control selectpicker"
							>
								<option value="Accra">Accra</option>
								

							</select>
						</div>


						
					</div>
					
					
				</div>
				
				
					<div class="form-group">
					<label for="">Username</label> <input type="text"
						class="form-control" id="ur_username"
						placeholder="" required
					>
				</div>
				
				
					
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="">Password</label> <input type="text"
						class="form-control" id="ur_web_pass"
						placeholder="" required
					>
						</div>

						<div class="col">
							<label for="">Confirm Password</label> <input type="text"
						class="form-control" id="ur_web_pass_confirm"
						placeholder="" required
					>
						</div>
					</div>
				</div>
				
				
				
			
				
				
					<div class="form-group">
					
				</div>
				
				<div class="form-group">
					<label for="bl_job_number">User Profile</label> 
							<select
								name="ur_userprofile" id="ur_userprofile"
								data-live-search="true"
								data-none-results-text="I found no results"
								title="Please select fruit" class="form-control selectpicker"
							>
								<option value="Admin">Administrator</option>
								<option value="User">User</option>
							</select>
				</div>
				
				<div class="form-group">
					<label for="bl_job_number">Is User Disabled</label> 
							<select
								name="ur_isdisabled" id="ur_isdisabled"
								data-live-search="true"
								data-none-results-text="I found no results"
								title="Please select fruit" class="form-control selectpicker"
							>
								<option value="True">True</option>
								<option value="False">False</option>
							</select>
				</div>
			
				
				<div class="form-group">
					<div class="form-row">
						
						
						<div class="col">
							<label for="party_ar_nationality_gen">passwordchanged</label> <select
								id="ur_passwordchanged"
								data-live-search="true" class="form-control selectpicker"
							>
								<option value="YES">YES</option>
								<option value="NO">NO</option>

							</select>
						</div>
						
						<div class="col">
							<label for="party_ar_nationality_gen">Can Password Expire</label> <select
								id="ur_canpasswordexpire"
								data-live-search="true" class="form-control selectpicker"
							>
								<option value="True">True</option>
								<option value="False">False</option>

							</select>
						</div>
				
					</div>
				</div>
				
				
				<div class="form-group">
					<div class="form-row">
						
						
						<div class="col">
							<label for="">Password Validity Days</label> <input type="number"
						class="form-control" id="ur_passwordvaliditydays"
						placeholder="" required
					>
						</div>
						
						<div class="col">
							<label for="">Password Expiry Date</label> <input type="date"
						class="form-control" id="ur_passwordexpirydate"
						placeholder="" required
					>
						</div>
				
					</div>
				</div>


				
				<div class="form-group">
					<label for="bl_job_number">User Level</label> <select
						name="ur_user_level" id="ur_user_level"
						data-live-search="true" class="form-control selectpicker"
					>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</div>
				
				
				




			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btnsaveuserdetails"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Save</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				 <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
      



			</div>
		</div>
		/.modal-content
	</div>
	/.modal-dialog
</div> -->




<div class="modal fade effect-scale modal-blur" id="assignReassignUserProfile" tabindex="-1" aria-labelledby="assignReassignUserProfileLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="assignReassignUserProfileLabel">
                    <i class="fas fa-user-shield me-2"></i>Assign Roles
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input id="up_userid" name="up_userid" type="hidden">

                <!-- User Information -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input class="form-control bg-light" type="text" id="up_fullname" readonly style="cursor: not-allowed;">
                            <label for="up_fullname">Full Name</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input class="form-control bg-light" type="text" id="up_username" readonly style="cursor: not-allowed;">
                            <label for="up_username">Username</label>
                        </div>
                    </div>
                </div>

                <!-- Roles/Profiles Section -->
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-light">
                        <h6 class="mb-0">
                            <i class="fas fa-list-check me-2"></i>Available Roles/Profiles
                        </h6>
                        <small class="text-muted">Select the roles to assign to this user</small>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0" id="tbl_user_profile_list_dataTable">
                                <thead class="table-light">
                                    <tr>
                                        <th width="60%">Role/Profile Description</th>
                                        <th width="30%">Status</th>
                                        <th width="10%" class="text-center">Select</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Data will be populated via JavaScript -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Summary Section -->
                <div class="alert alert-info mt-3 mb-0" id="selectionSummary">
                    <i class="fas fa-info-circle me-2"></i>
                    <span id="selectedCount">0</span> role(s) selected
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Close
                </button>
                <button type="button" class="btn btn-primary" id="btn_save_user_profile_details">
                    <i class="fas fa-check me-1"></i>Assign Selected Roles
                </button>
            </div>
        </div>
    </div>
</div>



<div class="modal fade" id="assignMilestoneUserProfile" tabindex="-1" role="dialog"
	aria-labelledby="assignMilestoneUserProfile" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Assign Milestone</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
			</div>
			<div class="modal-body">


				<input id="ms_userid" name="ms_userid" type="hidden" value="${userid}">


				<!-- <div class="form-group">
					<label for="bl_job_number">Full Name</label> <input
						class="form-control " type="text" placeholder=""
						id="up_fullname" readonly
					>
				</div> -->

				<div class="form-group">
					<label for="main_service">Main Service</label>
							<select name="main_service_on_case" id="main_service_assign_milestone" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
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
							<select name="sub_service_on_case" id="sub_service_assign_milestone" class="form-control input-sm" data-style="btn-info" data-live-search="true">
							  <option value="-1">Select Sub Service</option>
							
						  </select>
						</div>


				<div class="row">
					<div class="col-lg-12">
						<!-- Example Bar Chart Card-->
						<div class="card mb-3">
							<div class="card-header">
								<i class="fa fa-bar-chart"></i>Check List
							</div>
							<div class="card-body">



								<!--  Here is where the fee list comes -->

								<div class="table-responsive">
								
									
									<table class="table table-bordered table-hover" id="tbl_user_milestone_list_dataTable"
										width="100%"
									>
									
										<thead>
											<tr>
												<th>Description</th>
												<th>Option</th>
												<th>id</th>

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
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btn_save_user_assigned_milestone_details"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Assign</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>



				<input type="hidden" id="bl_jn_id" name="jn_id"> <input
					type="hidden" id="bl_send_by_id" name="send_by_id"
				> <input type="hidden" id="bl_userid" name="userid">
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- ============================================END NEW UPDATE=============================================================================== -->



<div class="modal fade" id="addupdatecorporateuserdatails" tabindex="-1"
	role="dialog" aria-labelledby="addupdatecorporateuserdatails" aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Add/Edit User</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"><i class="fas fa-times"></i></span>
				</button>
			</div>
			<form id="frmAddEditCorpUser" >
			<div class="modal-body">
				
				<input id="corp_userid" name="corp_userid" type="hidden" value="0">
				
				
				<div class="form-group">	
					<div class="form-row">
						<div class="col-sm-2">
							<label for="bl_job_number">Title</label> 
							<select  id="corp_title" class="form-control selectpicker" required>
								<option value="Mr">Mr</option>
								<option value="Ms">Ms</option>
								<option value="Mrs">Mrs</option>
								<option value="Dr">Dr</option>
								<option value="Rev">Rev</option>
								<option value="Prof">Prof</option>
								
								<option value="Surv">Surv</option>
								<option value="Eng">Eng</option>
								
								
							</select>
						</div>

						<div class="col">
							<label for="bl_ar_name_gen">Full Name</label>
							<input class="form-control" placeholder="" id="corp_fullname" required/>
						</div>
					</div>
				</div>
				<br>
				<hr>

				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="bl_ar_name_gen">Address</label>
							<textarea rows="2" class="form-control" placeholder=""
								id="corp_address"
							></textarea>
						</div>
					
						<div class="col">
							<label for="">E-Mail Address</label>
								<textarea rows="2" class="form-control" placeholder=""
								id="corp_emailaddress"
							required></textarea>
							 
						</div>
					</div>
				</div>
				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="bl_job_number">Phone #</label> <input
								class="form-control " type="text"
								placeholder="" id="corp_phone"  required
							>
						</div>

						<div class="col">
							<label for="bl_job_number">Phone # 2</label> <input
								class="form-control " type="text"
								placeholder="" id="corp_mobile"
							>
						</div>
					</div>
				</div>
				<br>
				<hr>
				
				
				<div class="form-group">
					<div class="form-row">

						<!-- <div class="col">
							<label for="bl_job_number">Organization Name</label> 
							<input type="text" class="form-control" id="corp_org_name"  required  >
						</div> -->

						<label class="">Select Organiztion:</label>
                <!-- <select class="form-control" id="select_corporate_users" name="">
                  <option value="" disabled selected>-- Select --</option>
                  <option></option>
                </select> -->

                <select class="form-control"  id="corp_org_name" class="">
                 <option value="-1">-- select --</option>
                                
                  <c:forEach items="${org_list}" var="org">
                    <option  value="${org.emailaddress}" data-fullname="${org.fullname}">${org.fullname}</option>
                    </c:forEach>
              
                </select>
					</div>
				</div>
				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="">Staff Number</label> <input type="text"
						class="form-control" id="corp_staffnumber"
						placeholder="" required
					>
						</div>

						<div class="col">
							<label for="bl_job_number">Designation</label> 
							<input type="text"
						class="form-control" id="corp_designation"
						placeholder="" required
					>
						</div>
					</div>
				</div>

				
				
				<br>
				<hr>

				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="">Username</label> 
							<input type="text" class="form-control" id="corp_username"  required>
						</div>
					
						<div class="col">
							<label for="bl_job_number">User Profile</label> 
							<select id="corp_userprofile" class="form-control selectpicker" >
								<option value="Admin">Administrator</option>
								<option value="User" selected>User</option>
							</select>
						</div>
					</div>
					
				</div>
				
				
					
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="">Password</label> 
							<input type="text" class="form-control" id="corp_web_pass"  >
						</div>
						<div class="col">
							<label for="">Confirm Password</label> 
							<input type="text" class="form-control" id="corp_web_pass_confirm" placeholder=""  >
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label for="bl_job_number">Is User Disabled</label> 
					<select  id="corp_isdisabled" class="form-control selectpicker"  required>
						<option value="Yes">Yes</option>
						<option value="No">No</option>
					</select>
					<!-- <input id="testiii"/> -->
				</div>
			
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="party_ar_nationality_gen">Force Password Change</label> 
							<select id="corp_passwordchanged" class="form-control selectpicker" >
								<option value="YES">No</option>
								<option value="NO">Yes</option>
							</select>
						</div>
						
						<div class="col">
							<label for="party_ar_nationality_gen">Can Password Expire</label> <select
								id="corp_canpasswordexpire"
								data-live-search="true" class="form-control selectpicker"
							>
								<option value="Yes">Yes</option>
								<option value="No">No</option>

							</select>
							<!-- <input id="ur_canpasswordexpire22"/> -->
						</div>
				
					</div>
				</div>
				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<!-- <label for="">Password Validity Days</label> <input type="number"
						class="form-control" id="ur_passwordvaliditydays"
						placeholder="" required
					> -->	
								<label for="">Password Expire Date</label> 
								<input type="date" class="form-control" id="corp_passwordexpirydate"  required>
						</div>
						
						<div class="col">
							<label for="bl_job_number">User Level</label> 
							<select  id="corp_user_level" class="form-control selectpicker"  required>
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
							</select>
						</div>
				
					</div>
				</div> <br>

				<input type="hidden" id="org_fullname" class="form-control" />


				<br>
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<button type="button" id="btnsavecorpuserdetails" class="btn btn-success btn-icon-split" > 
					<span class="icon text-white-50"> <i class="fas fa-check"></i> </span> 
					<span class="text">Save</span>
				</button>

				<div class="my-2"></div>
					<a href="#" data-dismiss="modal" class="btn btn-danger btn-icon-split" > 
					<span class="icon text-white-50"> <i class="fas fa-trash"></i></span> 
					<span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->



			</div>
			</form>
		</div>
		
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="addupdatecorporatedatails" tabindex="-1"
	role="dialog" aria-labelledby="addupdatecorporatedatails" aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Add/Edit Organization</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"><i class="fas fa-times"></i></span>
				</button>
			</div>
			<form id="frmAddEditCorp" >
			<div class="modal-body">
				
				<input id="org_id" name="org_id" type="hidden" value="0">
				
				
				<div class="form-group">	
					<div class="form-row">

						<div class="col">
							<label for="bl_ar_name_gen">Organization Name</label>
							<input class="form-control" placeholder="" id="org_fullname" required/>
						</div>
					</div>
				</div>
				<br>
				<hr>

				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="bl_ar_name_gen">Address</label>
							<textarea rows="2" class="form-control" placeholder=""
								id="org_address"
							></textarea>
						</div>
					
						<div class="col">
							<label for="">E-Mail Address</label>
								<textarea rows="2" class="form-control" placeholder=""
								id="org_emailaddress"
							required></textarea>
							 
						</div>
					</div>
				</div>
				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="bl_job_number">Phone #</label> <input
								class="form-control " type="text"
								placeholder="" id="org_phone"  required
							>
						</div>

						<div class="col">
							<label for="bl_job_number">Phone # 2</label> <input
								class="form-control " type="text"
								placeholder="" id="org_mobile"
							>
						</div>
					</div>
				</div>
				<br>
				<hr>
				
				

				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="">Industry</label> 
							<select class="form-control" id="org_industry">
								<option value="" disabled selected>--select--</option>
								<option value="Bank">Bank</option>
								<option value="GIS">GIS</option>
								<option value="Law Firm">Law Firm</option>
							</select>
						</div>
						<div class="col">
							<label for="bl_job_number">Registration No.</label> 
							<input type="text"
						class="form-control" id="org_registration_no"
						placeholder="" required
					>
						</div>
					</div>
				</div>

				<div class="form-group">
					<div class="form-row">

						<div class="col">
							<label for="bl_job_number">Subscription Paid</label> 
							<input type="text" class="form-control" id="org_subscription_paid"  required  >
		                    <!-- <datalist id="listofunits"></datalist> -->
						</div>

						<div class="col">
							<label for="bl_job_number">Subscription Due</label> 
							<input type="date" class="form-control" id="org_subscription_due"  required  >
		                    <!-- <datalist id="listofunits"></datalist> -->
						</div>
					</div>
				</div>
				
				<br>
				<hr>

				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="">Account Number</label> 
							<input type="text"
						class="form-control" id="org_account_number"
						placeholder="" required
					>
					</div>
						<div class="col">
							<label for="bl_job_number">In Good Standing</label> 
							<select class="form-control" id="org_good_standing">
								<option value="" disabled selected>--select--</option>
								<option value="1">Yes</option>
								<option value="0">No</option>
							</select>
						</div>
					</div>
				</div>

				<div class="form-group">
					<div class="form-row">

						<div class="col">
							<label for="bl_job_number">Contact Person Name</label> 
							<input type="text" class="form-control" id="org_contact_person_name"  required  >
		                    <!-- <datalist id="listofunits"></datalist> -->
						</div>

						<div class="col">
							<label for="bl_job_number">Contact Person Phone</label> 
							<input type="tel" class="form-control" id="org_contact_person_phone"  required  >
		                    <!-- <datalist id="listofunits"></datalist> -->
						</div>
					</div>
				</div>

				<!-- <br>
				<hr>
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="">Username</label> 
							<input type="text" class="form-control" id="org_username"  required>
						</div>
					
						<div class="col">
							<label for="bl_job_number">Is User Disabled</label> 
							<select  id="org_isdisabled" class="form-control selectpicker"  required>
								<option value="Yes">Yes</option>
								<option value="No">No</option>
							</select>
						</div>
					</div>
					
				</div>
				
				
					
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="">Password</label> 
							<input type="text" class="form-control" id="org_web_pass"  >
						</div>
						<div class="col">
							<label for="">Confirm Password</label> 
							<input type="text" class="form-control" id="org_web_pass_confirm" placeholder=""  >
						</div>
					</div>
				</div>
				

				<br>
				<hr>
			
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="party_ar_nationality_gen">Force Password Change</label> 
							<select id="org_passwordchanged" class="form-control selectpicker" >
								<option value="YES">No</option>
								<option value="NO">Yes</option>
							</select>
						</div>
						
						<div class="col">
							<label for="party_ar_nationality_gen">Can Password Expire</label> <select
								id="org_canpasswordexpire"
								data-live-search="true" class="form-control selectpicker"
							>
								<option value="Yes">Yes</option>
								<option value="No">No</option>

							</select>
						</div>
				
					</div>
				</div>
				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
								<label for="">Password Expire Date</label> 
								<input type="date" class="form-control" id="org_passwordexpirydate"  required>
						</div>
						
						<div class="col">
							<label for="bl_job_number">User Level</label> 
							<select  id="org_user_level" class="form-control selectpicker"  required>
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
							</select>
						</div>
				
					</div>
				</div> <br> -->
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<button type="button" id="btnsavecorpdetails" class="btn btn-success btn-icon-split" > 
					<span class="icon text-white-50"> <i class="fas fa-check"></i> </span> 
					<span class="text">Save</span>
				</button>

				<div class="my-2"></div>
					<a href="#" data-dismiss="modal" class="btn btn-danger btn-icon-split" > 
					<span class="icon text-white-50"> <i class="fas fa-trash"></i></span> 
					<span class="text">Close</span>

				</a>




			</div>
			</form>
		</div>
		
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>



</body>

</html>