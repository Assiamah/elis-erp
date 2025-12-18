<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>


<!-- Logout Modal-->
<div class="modal fade" id="profileUpdate" tabindex="-1" role="dialog"
	aria-labelledby="profileUpdate" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">My Profile</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"></span>
				</button>
			</div>
			<form id="frmUdateProfile">
			<div class="modal-body">
				
					<!-- <div class="form-group">
						<label for="pr_title">Title</label> 
						<input type="hidden" id="pr_userid" class="form-control">
					</div> -->
					
<%-- 					<input type="hidden" id="pr_userid" value="${userid}">
 --%>					
					<div class="form-group">
						<div class="form-row">
							<div class="col">
								<label for="pr_fullname">Full name</label> 
								<textarea id="pr_fullname" class="form-control " rows=2  readonly disabled >${fullname}</textarea>
							</div>
	
							<!-- <div class="col">
								<label for="pr_address">Address</label> 
								<textarea id="pr_address" class="form-control " rows=2 ></textarea>
							</div> -->
						</div>
					</div>
					
					
					<div class="form-group">
						<div class="form-row">
							<div class="col">
								<label for="pr_job_number">Phone #</label> 
								<input class="form-control " type="text" id="pr_phone" value="${user_phone}">
							</div>
	
							<div class="col">
								<label for="pr_job_number">Phone # 2</label> 
								<input class="form-control " type="text"  id="pr_mobile" value="${user_phone2}">
							</div>
							<div class="col">
								<label for="">E-Mail Address</label> 
								<input type="text" class="form-control" id="pr_emailaddress"  readonly disabled  value="${emailaddress}">
							</div>
						</div>
					</div>
					
					
					
					<div class="form-group">
						<div class="form-row">
							<div class="col">
								<label for="">Staff Number</label> 
								<input type="text" class="form-control" id="pr_staffnumber"  readonly disabled value="${staffnumber}">
							</div>
	
							<div class="col">
								<label for="">Designation</label> 
								<input type="text" class="form-control" id="pr_designation" readonly disabled value="${designation}">
							</div>
							<div class="col">
								<label for="">Department</label> 
								<input type="text" class="form-control" id="pr_department"  readonly disabled value="${unit_name}">
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<div class="form-row">
							<div class="col">
								<label for="">Region</label> 
								<input type="text" class="form-control" id="pr_region"  readonly disabled value="${region_name}">
							</div>
	
							<div class="col">
								<label for="">Office District</label> 
								<input type="text" class="form-control" id="pr_district"  readonly disabled value="${regional_name}">
							</div>
							<div class="col">
								<label for="">Division</label> 
								<input type="text" class="form-control" id="pr_division"  readonly disabled value="${division}">
							</div>
						</div>
					</div>
					
					
					
					
					<div class="form-group">
						<div class="form-row">
							<div class="col">
								<label for="">Username</label> 
								<input type="text" class="form-control" id="pr_username" readonly disabled value="${username}">
							</div>
							<div class="col">
								<label for="">User Level</label> 
								<input type="text" class="form-control" readonly disabled value="${user_level}">
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="form-row">
							<div class="col">
								<label for="">Password</label> 
								<input type="password" class="form-control" id="pr_web_pass" required  autocomplete="off">
							</div>
	
							<div class="col">
								<label for="">Confirm Password</label> 
								<input type="password" class="form-control" id="pr_web_pass_confirm" required autocomplete ="off"> 
							</div>
						</div>
					</div>
					
				
					
			
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				<button class="btn btn-primary" type="submit"  id="pr_save_updates">Save Changes</button>
			</div>
			</form>
		</div>
	</div>
</div>