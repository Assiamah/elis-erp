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
                            
                            <!-- <div class="col-md-6">
                                <label for="ur_department" class="form-label">Department/Unit</label>
                                <input class="form-control" list="listofunits" id="ur_department" placeholder="Select or type department" required>
                                <datalist id="listofunits"></datalist>
                            </div> -->
							<div class="col-md-6">
								<label for="ur_department" class="form-label">Department/Unit</label>
								<select id="ur_department" class="form-select select2-dropdown" required>
									<option value="">Select Department/Unit</option>
								</select>
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


<!-- Assign Milestone Modal -->
<div class="modal fade effect-fade modal-blur" id="assignMilestoneUserProfile" tabindex="-1" 
     aria-labelledby="assignMilestoneUserProfileLabel" aria-hidden="true"  data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content shadow border-0">
            
            <!-- Modal Header -->
            <div class="modal-header bg-light border-0 pt-4">
                <div class="d-flex align-items-center">
                    <div class="rounded-circle bg-primary bg-opacity-10 p-3 me-3">
                        <i class="fa fa-tasks text-primary fa-fw"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-bold" id="assignMilestoneUserProfileLabel">
                            Assign Milestone
                        </h5>
                        <p class="text-muted small mb-0">Configure milestone assignments for user</p>
                    </div>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body pt-4">
                
                <!-- Hidden User ID -->
                <input id="ms_userid" name="ms_userid" type="hidden" value="">
                
                <!-- Service Selection Section -->
                <div class="card bg-light border-0 mb-4">
                    <div class="card-body">
                        <h6 class="fw-bold mb-3">
                            <i class="fa fa-cog me-2 text-primary"></i>Service Configuration
                        </h6>
                        
                        <div class="row g-3">
                            <!-- Main Service -->
                            <div class="col-md-6">
                                <label for="main_service_assign_milestone" class="form-label fw-semibold">
                                    <i class="fa fa-dashboard me-2 text-muted"></i>Main Service
                                </label>
                                <select name="main_service_on_case" id="main_service_assign_milestone" 
                                        class="form-select selectpicker" data-live-search="true">
                                    <option value="" selected disabled>-- Select Main Service --</option>
                                    <!-- Options will be populated dynamically -->
                                </select>
                            </div>
                            
                            <!-- Sub Service -->
                            <div class="col-md-6">
                                <label for="sub_service_assign_milestone" class="form-label fw-semibold">
                                    <i class="fa fa-sitemap me-2 text-muted"></i>Sub Service
                                </label>
                                <select name="sub_service_on_case" id="sub_service_assign_milestone" 
                                        class="form-select" data-live-search="true">
                                    <option value="" selected disabled>-- Select Sub Service --</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Checklist Section -->
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white border-0 pt-3 pb-0">
                        <div class="d-flex align-items-center">
                            <i class="fa fa-check-circle text-success me-2"></i>
                            <h6 class="fw-bold mb-0">Milestone Checklist</h6>
                            <!-- <span class="badge bg-info ms-2" id="selected-count">0 selected</span> -->
                        </div>
                    </div>
                    
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="tbl_user_milestone_list_dataTable">
                                <thead class="table-light">
                                    <tr>
                                        <th width="50%">
                                            <i class="fa fa-align-left me-2 text-muted"></i>Description
                                        </th>
                                        <th width="30%">
                                            <i class="fa fa-toggle-on me-2 text-muted"></i>Option
                                        </th>
                                        <th width="20%" class="text-start">
                                            <i class="fa fa-cog me-2 text-muted"></i>MID
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Dynamic content will be loaded here -->
                                    <tr class="text-muted">
                                        <td colspan="3" class="text-center py-4">
                                            <i class="fa fa-info-circle me-2"></i>
                                            Select a service to view milestones
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Hidden Fields -->
                <input type="hidden" id="bl_jn_id" name="jn_id">
                <input type="hidden" id="bl_send_by_id" name="send_by_id">
                <input type="hidden" id="bl_userid" name="userid">
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-0 pt-3 pb-3">
                <div class="d-flex gap-2 w-100 justify-content-end">
                    <!-- Close Button -->
                    <button type="button" class="btn btn-outline-danger px-4" data-bs-dismiss="modal">
                        <i class="fa fa-times me-2"></i>Close
                    </button>
                    
                    <!-- Assign Button -->
                    <button type="button" class="btn btn-success px-4" id="btn_save_user_assigned_milestone_details">
                        <i class="fa fa-check-circle me-2"></i>Assign Milestone
                    </button>
                </div>
            </div>
            
        </div>
    </div>
</div>


<div class="modal fade effect-fade modal-blur" id="checkstepassignment" tabindex="-1" 
     aria-labelledby="checkstepassignmentLabel" aria-hidden="true"  data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content shadow border-0">
            
            <!-- Modal Header -->
            <div class="modal-header bg-light border-0 pt-4">
                <div class="d-flex align-items-center">
                    <div class="rounded-circle bg-primary bg-opacity-10 p-3 me-3">
                        <i class="fa fa-tasks text-primary fa-fw"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-bold" id="checkstepassignmentLabel">
                            Check Step Assignment
                        </h5>
                        <p class="text-muted small mb-0">Check users assigned to each baby step</p>
                    </div>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body pt-4">
                
                <!-- Hidden User ID -->
                <input id="ms_userid" name="ms_userid" type="hidden" value="${userid}">
                
                <!-- Service Selection Section -->
                <div class="card bg-light border-0 mb-4">
                    <div class="card-body">
                        <h6 class="fw-bold mb-3">
                            <i class="fa fa-cog me-2 text-primary"></i>Service Configuration
                        </h6>
                        
                        <div class="row g-3">
                            <!-- Main Service -->
                            <div class="col-md-6">
                                <label for="main_service_check_assignment" class="form-label fw-semibold">
                                    <i class="fa fa-dashboard me-2 text-muted"></i>Main Service
                                </label>
                                <select name="main_service_on_case" id="main_service_check_assignment" 
                                        class="form-select selectpicker" data-live-search="true">
                                    <option value="" selected disabled>-- Select Main Service --</option>
                                    <!-- Options will be populated dynamically -->
                                </select>
                            </div>
                            
                            <!-- Sub Service -->
                            <div class="col-md-6">
                                <label for="sub_service_check_assignment" class="form-label fw-semibold">
                                    <i class="fa fa-sitemap me-2 text-muted"></i>Sub Service
                                </label>
                                <select name="sub_service_on_case" id="sub_service_check_assignment" 
                                        class="form-select" data-live-search="true">
                                    <option value="" selected disabled>-- Select Sub Service --</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Checklist Section -->
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white border-0 pt-3 pb-0">
                        <div class="d-flex align-items-center">
                            <i class="fa fa-list text-success me-2"></i>
                            <h6 class="fw-bold mb-0">Milestone List</h6>
                            <!-- <span class="badge bg-info ms-2" id="selected-count">0 selected</span> -->
                        </div>
                    </div>
                    
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="tbl_user_check_assignment_list_dataTable">
                                <thead class="table-light">
                                    <tr>
                                        <th width="70%">
                                            <i class="fa fa-align-left me-2 text-muted"></i>Description
                                        </th>
                                        <th width="20%" class="text-start">
                                            <i class="fa fa-cog me-2 text-muted"></i>Action
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Dynamic content will be loaded here -->
                                    <tr class="text-muted">
                                        <td colspan="3" class="text-center py-4">
                                            <i class="fa fa-info-circle me-2"></i>
                                            Select a service to view milestones
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Hidden Fields -->
                <!-- <input type="hidden" id="bl_jn_id" name="jn_id">
                <input type="hidden" id="bl_send_by_id" name="send_by_id">
                <input type="hidden" id="bl_userid" name="userid">
                 -->
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-0 pt-3 pb-3">
                <div class="d-flex gap-2 w-100 justify-content-end">
                    <!-- Close Button -->
                    <button type="button" class="btn btn-outline-danger px-4" data-bs-dismiss="modal">
                        <i class="fa fa-times me-2"></i>Close
                    </button>
                    
                    <!-- Assign Button -->
                    <!-- <button type="button" class="btn btn-success px-4" id="btn_save_user_assigned_milestone_details">
                        <i class="fa fa-check-circle me-2"></i>Assign Milestone
                    </button> -->
                </div>
            </div>
            
        </div>
    </div>
</div>


<!-- Load Users Assigned Steps Modal -->
<div class="modal fade effect-fade modal-blur" id="loaduserassignedsteps" tabindex="-1" 
     aria-labelledby="loaduserassignedstepsLabel" aria-hidden="true"  data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content shadow border-0">
            
            <!-- Modal Header -->
            <div class="modal-header bg-light text-success border-0" >
                <div class="d-flex align-items-center">
                    <div class="rounded-circle bg-success bg-opacity-25 p-2 me-3">
                        <i class="fa fa-users text-success fa-fw"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-bold text-dark mb-0" id="loaduserassignedstepsLabel">
                            Users Assigned to Step
                        </h5>
                        <p class="text-muted small mb-0" id="stepInfo">
                            Loading step information...
                        </p>
                    </div>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body p-4">
                
                <!-- Summary Cards -->
                <div class="row g-3 mb-4" id="summaryCards">
                    <div class="col-md-3">
                        <div class="card bg-primary bg-opacity-10 border-0">
                            <div class="card-body p-3">
                                <div class="d-flex align-items-center">
                                    <div class="flex-shrink-0">
                                        <i class="fa fa-users fa-2x text-primary"></i>
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <h6 class="mb-0 fw-bold" id="totalUsers">0</h6>
                                        <small class="text-muted">Total Users</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-success bg-opacity-10 border-0">
                            <div class="card-body p-3">
                                <div class="d-flex align-items-center">
                                    <div class="flex-shrink-0">
                                        <i class="fa fa-check-circle fa-2x text-success"></i>
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <h6 class="mb-0 fw-bold" id="activeUsers">0</h6>
                                        <small class="text-muted">Active Users</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-info bg-opacity-10 border-0">
                            <div class="card-body p-3">
                                <div class="d-flex align-items-center">
                                    <div class="flex-shrink-0">
                                        <i class="fa fa-building fa-2x text-info"></i>
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <h6 class="mb-0 fw-bold" id="totalUnits">0</h6>
                                        <small class="text-muted">Units</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-warning bg-opacity-10 border-0">
                            <div class="card-body p-3">
                                <div class="d-flex align-items-center">
                                    <div class="flex-shrink-0">
                                        <i class="fa fa-calendar fa-2x text-warning"></i>
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <h6 class="mb-0 fw-bold" id="assignedDate">-</h6>
                                        <small class="text-muted">Latest Assignment</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Filters and Search -->
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="fa fa-search text-muted"></i>
                            </span>
                            <input type="text" class="form-control border-start-0" 
                                   id="searchUserInput" placeholder="Search by name, designation, unit...">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" id="filterUnit">
                            <option value="">All Units</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" id="filterStatus">
                            <option value="">All Status</option>
                            <option value="active">Active Only</option>
                            <option value="inactive">Inactive Only</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-outline-secondary w-100" id="resetFilters">
                            <i class="fa fa-undo me-2"></i>Reset
                        </button>
                    </div>
                </div>
                
                <!-- Users Table -->
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white border-0 pt-3 pb-0">
                        <div class="d-flex align-items-center justify-content-between">
                            <div>
                                <i class="fa fa-list-alt text-primary me-2"></i>
                                <span class="fw-bold">Assigned Users List</span>
                            </div>
                            <span class="badge bg-primary" id="tableRowCount">0 records</span>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="tbl_users_assigned_steps_list_dataTable">
                                <thead class="table-light">
                                    <tr>
                                        <th width="5%">#</th>
                                        <th width="20%">
                                            <i class="fa fa-user me-2 text-muted"></i>User
                                        </th>
                                        <th width="15%">
                                            <i class="fa fa-id-card me-2 text-muted"></i>Staff No.
                                        </th>
                                        <th width="15%">
                                            <i class="fa fa-briefcase me-2 text-muted"></i>Designation
                                        </th>
                                        <th width="15%">
                                            <i class="fa fa-building me-2 text-muted"></i>Unit
                                        </th>
                                        <th width="10%">
                                            <i class="fa fa-phone me-2 text-muted"></i>Contact
                                        </th>
                                        <th width="10%">
                                            <i class="fa fa-check-circle me-2 text-muted"></i>Status
                                        </th>
                                        <th width="10%">
                                            <i class="fa fa-cog me-2 text-muted"></i>Actions
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="text-muted">
                                        <td colspan="8" class="text-center py-5">
                                            <i class="fa fa-users fa-3x mb-3 opacity-50"></i>
                                            <p class="mb-0">No users assigned to this step</p>
                                            <small>Click the load button to refresh</small>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Hidden Fields -->
                <input type="hidden" id="currentBsId" value="">
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-top p-3">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <div class="small text-muted">
                        <i class="fa fa-info-circle me-1"></i>
                        <span id="footerInfo">Select a user to view details</span>
                    </div>
                    <div>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fa fa-times me-2"></i>Close
                        </button>
                        <button type="button" class="btn btn-primary" id="refreshAssignedUsers">
                            <i class="fa fa-sync-alt me-2"></i>Refresh
                        </button>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<!-- User Details Modal (for view action) -->
<div class="modal fade effect-fade modal-blur" id="userDetailsModal" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header bg-info text-white">
                <h5 class="modal-title">
                    <i class="fa fa-user-circle me-2"></i>User Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="userDetailsContent">
                <!-- Dynamic content will be loaded here -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
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