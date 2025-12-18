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
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="">
					<!-- <div class="form-group">
						<label for="pr_title">Title</label> 
						<input type="text" id="pr_title" class="form-control">
					</div> -->
					
					
					<div class="form-group">
						<div class="form-row">
							<div class="col">
								<label for="pr_fullname">Full name</label> 
								<textarea id="pr_fullname" class="form-control " rows=2  readonly disabled></textarea>
							</div>
	
							<div class="col">
								<label for="pr_address">Address</label> 
								<textarea id="pr_address" class="form-control " rows=2 ></textarea>
							</div>
						</div>
					</div>
					
					
					<div class="form-group">
						<div class="form-row">
							<div class="col">
								<label for="pr_job_number">Phone #</label> 
								<input class="form-control " type="text" id="pr_phone">
							</div>
	
							<div class="col">
								<label for="pr_job_number">Phone # 2</label> 
								<input class="form-control " type="text"  id="pr_mobile">
							</div>
							<div class="col">
								<label for="">E-Mail Address</label> 
								<input type="text" class="form-control" id="pr_emailaddress"  readonly disabled>
							</div>
						</div>
					</div>
					
					
					
					<div class="form-group">
						<div class="form-row">
							<div class="col">
								<label for="">Staff Number</label> 
								<input type="text" class="form-control" id="pr_staffnumber"  readonly disabled>
							</div>
	
							<div class="col">
								<label for="">Designation</label> 
								<input type="text" class="form-control" id="pr_designation" readonly disabled >
							</div>
							<div class="col">
								<label for="">Department</label> 
								<input type="text" class="form-control" id="pr_department"  readonly disabled>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<div class="form-row">
							<div class="col">
								<label for="">Region</label> 
								<input type="text" class="form-control" id="pr_region"  readonly disabled>
							</div>
	
							<div class="col">
								<label for="">Office District</label> 
								<input type="text" class="form-control" id="pr_district"  readonly disabled>
							</div>
							<div class="col">
								<label for="">Division</label> 
								<input type="text" class="form-control" id="pr_division"  readonly disabled>
							</div>
						</div>
					</div>
					
					
					
					
					<div class="form-group">
						<div class="form-row">
							<div class="col">
								<label for="">Username</label> 
								<input type="text" class="form-control" id="pr_username" readonly disabled>
							</div>
							<div class="col">
								<label for="">Password</label> 
								<input type="text" class="form-control" id="pr_web_pass" required>
							</div>
	
							<div class="col">
								<label for="">Confirm Password</label> 
								<input type="text" class="form-control" id="pr_web_pass_confirm" required>
							</div>
						</div>
					</div>
					
				</form>
					
			
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				<a class="btn btn-primary"
					href="${pageContext.request.contextPath}/Logout"
					onclick="doLogoutClearing()">Logout</a>
			</div>
		</div>
	</div>
</div>