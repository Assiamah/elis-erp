<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>








<!--  Service Bill============================= -->
<div class="modal fade" id="CreateJobNumberModal" tabindex="-1"
	role="dialog" aria-labelledby="newValuationModalLabel"
	aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="CreateJobNumberModal">Create New Job and Case Number</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<!-- <form id="from_add_valuation"> -->

			


				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="main_service">Main Service</label>
                  <select name="main_service_on_case" id="main_service_on_tc" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
   
                </select>
						</div>
						<div class="col-md-6">
							  <label for="sub_service">Sub Service</label>
                  <select name="sub_service_on_case" id="sub_service_on_tc" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                    <option value="-1">Select Sub Service</option>
                  
                </select>
						</div>
						
						
						
		
					</div>
				</div>
				
				
				
				
				


				<div class="form-group">
					<div class="form-row">
						<label for="client_name">Client Name</label> <input
							class="form-control" id="applicant_name_on_tc"
							name="applicant_name_on_tc" type="text"
							aria-describedby="nameHelp" placeholder="Enter Client Name"
							required
						>
					</div>
				</div>



				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="client_name">Office Region</label> 
							<select class="form-control" id="office_region_on_tc"  required>
								<option value="-1">Select Office Region</option>
									
								<c:forEach items="${officeregionlist}" var="officeregion">
									<option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
						  </c:forEach>
		 
							</select>
						</div>
						<div class="col-md-6">
						<label for="locality">Locality</label> <select
									name="locality_on_tc"
									id="locality_on_tc"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">-- Select --</option>
									
								</select>
						</div>
						
						
						
		
					</div>
				</div>
				
				
				
				<div class="form-group">
					<div class="form-row">
					<div class="col-md-4">
						<label for="client_name">Land Size (Acre(s))</label> <input
						class="form-control" id="land_size_on_tc"
						name="land_size_on_tcland_size_on_tc" type="text"
						aria-describedby="nameHelp" placeholder="Enter land Size"
						required>
						</div>
						<div class="col-md-4">
						<label for="new_bill_type_of_use">Type of Use</label> <select
									name="type_of_use" id="type_of_use_on_tc"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">-- Select --</option>

								</select>

						</div>
						<div class="col-md-4">
						<label for="">Type of Interest</label> <select
												class="form-control" id="type_of_interest_on_tc" required
											>
												<option>Select Type of Interest</option>
												<option>LEASEHOLD</option>
												<option>FREEHOLD</option>
											</select>
						</div>
						
						
						
		
					</div>
				</div>
				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
						<label for="">Nature of Instrument</label> <select
												class="form-control" id="nature_of_instrument_on_tc" required
											>
												<option>Nature of Instrument</option>
												<option>Leasehold</option>
												<option>Assignment</option>
												<option>Sub-Lease</option>
												<option>Conveyance</option>
												
											</select>
						</div>
						<div class="col-md-6">
							<label for="client_name">File Number</label> <input
						class="form-control" id="file_number_on_tc"
						name="file_number_on_tc" type="text"
						aria-describedby="nameHelp" placeholder="Enter File Number"
						required>
						</div>
						
						
						
		
					</div>
				</div>
				
	
				
				

				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="client_name">Job Number</label> <input
							class="form-control" id="job_number_on_tc"
							name="applicant_name_on_tc" type="text"
							aria-describedby="nameHelp" placeholder=""
							readonly
						>
						</div>
						<div class="col-md-6">
						<label for="client_name">Case Name</label> <input
							class="form-control" id="case_number_on_tc"
							name="applicant_name_on_tc" type="text"
							aria-describedby="nameHelp" placeholder=""
							readonly
						>
						</div>
						
						
						
		
					</div>
				</div>
				

			
				
				
									<div class="form-group">
						<div class="form-row">

						
						</div>
					</div>


				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal"
					>Close</button>
					<button type="button"
						id="btn_create_new_job_and_case_number"
						class="btn btn-primary"
					>Generate Job Number</button>
				</div>
				<!-- </form> -->
			</div>
		</div>
	</div>
</div>





<!--  Service Bill============================= -->
<div class="modal fade" id="CreateJobNumberModalExisting" tabindex="-1"
	role="dialog" aria-labelledby="newValuationModalLabel"
	aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="CreateJobNumberModalExisting">Insert Existing Job and New Case Number</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<!-- <form id="from_add_valuation"> -->

			


				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="main_service">Main Service</label>
                  <select name="main_service_on_tc_e" id="main_service_on_tc_e" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
   
                </select>
						</div>
						<div class="col-md-6">
							  <label for="sub_service">Sub Service</label>
                  <select name="sub_service_on_tc_e" id="sub_service_on_tc_e" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                    <option value="-1">Select Sub Service</option>
                  
                </select>
						</div>
						
						
						
		
					</div>
				</div>
				
				
				
				
				


				<div class="form-group">
					<div class="form-row">
						<label for="client_name">Client Name</label> <input
							class="form-control" id="applicant_name_on_tc_e"
							name="applicant_name_on_tc_e" type="text"
							aria-describedby="nameHelp" placeholder="Enter Client Name"
							required
						>
					</div>
				</div>



				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="client_name">Office Region</label> 
							<select class="form-control" id="office_region_on_tc_e"  required>
								<option value="-1">Select Office Region</option>
								<c:forEach items="${officeregionlist}" var="officeregion">
									<option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
						  </c:forEach>
							</select>
						</div>
						
						<div class="col-md-6">
						<label for="locality">Locality</label> <select
									name="locality_on_tc_e"
									id="locality_on_tc_e"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1"> -- Select Locality --</option>
									
								</select>
						</div>
						
						
						
		
					</div>
				</div>
				
				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col-md-4">
							<label for="client_name">Land Size (Acre(s))</label> <input
							class="form-control" id="land_size_on_tc_e"
							name="land_size_on_tcland_size_on_tc_e" type="text"
							aria-describedby="nameHelp" placeholder="Enter land Size"
							required>
						</div>
						<div class="col-md-4">
						<label for="new_bill_type_of_use">Type of Use</label> <select
									name="type_of_use_e" id="type_of_use_on_tc_e"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1"> -- Select --</option>

								</select>

						</div>
						<div class="col-md-4">
						<label for="">Type of Interest</label> <select
												class="form-control" id="type_of_interest_on_tc_e" required
											>
												<option>Select Type of Interest</option>
												<option>LEASEHOLD</option>
												<option>FREEHOLD</option>
											</select>
						</div>
						
						
						
		
					</div>
				</div>
				
				
				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
						<label for="">Nature of Instrument</label> <select
												class="form-control" id="nature_of_instrument_on_tc_e" required
											>
												<option>Nature of Instrument</option>
												<option>Leasehold</option>
												<option>Assignment</option>
												<option>Sub-Lease</option>
												<option>Conveyance</option>
												
											</select>
						</div>
						<div class="col-md-6">
							<label for="client_name">File Number</label> <input
						class="form-control" id="file_number_on_tc_e"
						name="file_number_on_tc" type="text"
						aria-describedby="nameHelp" placeholder="Enter File number"
						required>
						</div>
						
						
						
		
					</div>
				</div>
				
	
				
				

				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="client_name">Job Number</label> <input
							class="form-control" id="job_number_on_tc_e"
							name="applicant_name_on_tc_e" type="text"
							aria-describedby="nameHelp" placeholder=""
							
						>
						</div>
						<div class="col-md-6">
						<label for="client_name">Case Number</label> <input
							class="form-control" id="case_number_on_tc_e"
						>
						</div>
						
						
						
		
					</div>
				</div>
				

			
				
				
									<div class="form-group">
						<div class="form-row">

						
						</div>
					</div>


				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal"
					>Close</button>
					<button type="button"
						id="btn_create_new_job_and_case_number_e"
						class="btn btn-primary"
					>Generate Existing Application</button>
				</div>
				<!-- </form> -->
			</div>
		</div>
	</div>
</div>



