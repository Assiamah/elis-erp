
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>


<jsp:include
	page="../client_application/_application_process_header.jsp"
></jsp:include>




<!-- wizard start wizard end -->


<!-- smartwizardfirstregistration html -->
<div id="smartwizardfirstregistration">
	<ul class="d-none">

		
		<li><a href="#link-1">Assessment<br /> <small>Assessment</small></a></li>
		<li><a href="#link-2">Embossment after Payment<br /> <small>Embossment after Payment</small></a></li>

	</ul>
	<div>






		<div id="link-1" class="">
			<br>
			<h3 class="border-bottom border-gray pb-2">Stamp Duty Assessment</h3>
			<div class="row">




				<!--   Here is the right Table -->
				

				<!--   Here is the right Table -->
				<div class="col-lg-12">
					<!-- Example Pie Chart Card-->
					<div class="card mb-10">
						<div class="card-header">
							<i class="fa fa-pie-chart"></i>Stamp Duty
						</div>
						<div class="card-body">
							<!--  The Form starts here -->
							<div id="alert-display-space"></div>
							<form action="" method="post" id="form_assessment">


								<div id="alert-display-space1"></div>
								 <div class="form-group row">

									<label for="adopted_value" class="col-sm-4 col-form-label"
										style="text-align: right"
									>Number of Copies <span class="text-danger">*</span>:</label>
									<div class="col-sm-5">

										<div class="input-group mb-2">
											
											<input value="" step="1" type="text" id="number_of_copies"
												name="number_of_copies" class=" form-control  " 
												required placeholder="Number of Copies Presented" disabled
											>
										</div>


									</div>
								</div> 
								<div class="form-group row">
									<label for="assessed_value" class="col-sm-4 col-form-label"
										style="text-align: right"
									>Assessed Value <span class="text-danger">*</span>:</label>
									<div class="col-sm-5">
										<div class="input-group mb-2">
											<div class="input-group-prepend">
												<div class="input-group-text">GHS</div>
											</div>
											<input value="${assessed_value}" step="0.1" type="text"
												name="assessed_value" id="assessed_value"
												class=" form-control  "  required
												placeholder="Assessed Value" 
												
											>
										</div>


									</div>
								</div>

								<div class="form-group row">
									<label for="stamp_duty" class="col-sm-4 col-form-label"
										style="text-align: right"
									>Stamp Duty Payable <span class="text-danger">*</span>:</label>
									<div class="col-sm-5">

										<div class="input-group mb-2">
											<div class="input-group-prepend">
												<div class="input-group-text">GHS</div>
											</div>
											<input value="2.00"  type="text"
												id="stamp_duty" name="stamp_duty" class=" form-control  "
												 required placeholder="Stamp Duty Payable"
											>
										</div>


									</div>
								</div>
								<div class="form-group row">
									<label for="assessed_comment" class="col-sm-4 col-form-label "
										style="text-align: right"
									>Comments <span class="text-danger">*</span>:</label>
									<div class="col-sm-5">
										<textarea name="assessed_comment" id="assessed_comment"
											class=" form-control  " required
										>   </textarea>
									</div>
								</div>
								<div class="form-group row">
									<label for="assessed_value" class="col-sm-5 col-form-label">
									</label>
									<div class="form-row ">
										<div class="col-sm-6">
											<button type="submit" name="submit_assessment"
												id="submit_assessment"
												class="btn  btn-primary btn-icon-split"
											>
												<span class="icon text-white-50"> <i
													class="fas fa-check col-sm-12"
												></i></span><span class="text">Save</span>
											</button>
										</div>
										<div class="col-sm-6">
											<button type="button" name="submit_print_stamp_bill"
												id="submit_print_stamp_bill"
												class="btn  btn-warning btn-icon-split"
											>
												<span class="icon text-white-50"> <i
													class="fas fa-print col-sm-12"
												></i></span><span class="text">Print</span>
											</button>


										</div>

									</div>
								</div>



							</form>

							<!-- The form Ends Hers -->

						</div>

					</div>
					<!--   Here is the end of right table -->

				</div>

			</div>
		</div>

		<div id="link-2" class="">
			<br>
			<h3 class="border-bottom border-gray pb-2">Embossment after
				Payment</h3>

			<div class="row">

				<!--   Here is the right Table -->
				<div class="col-lg-8">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">
						<div class="card-header">
							<i class="fa fa-pie-chart"></i>Embossment after Payment
						</div>
						<div class="card-body">
							<div id="alert-display-space2"></div>
							<!--  The Form starts here -->
							<!--   <form   method="post" class="form-inline" id="form_embossment">
										<input type="hidden" id="case_number" name="case_number" value="LCGARGAPCN716053920190" >
										<input type="hidden" id="request_type" name="request_type" value="request_to_generate_inspection_letter">
								          
								              
								              
								              	<input type="text"  class="form-control form-control-plaintext" id="staticEmail" value="Is document embossed?">
								                <button type="submit" name="submit_embossment" id="submit_embossment" class="btn  btn-primary btn-icon-split form-control"  >
									    			<span class="icon text-white-50"> <i class="fas fa-check col-sm-12"></i></span><span class="text">Confirmed</span>
									    		</button>
									    		
								             
								            
								        </form>
								         -->


							<button type="button" name="btn_submit_embossment"
								id="btn_submit_embossment"
								class="btn  btn-primary btn-icon-split form-control"
							>
								<span class="icon text-white-50"> <i
									class="fas fa-check col-sm-12"
								></i></span><span class="text">Confirmed</span>
							</button>

							<!-- The form Ends Hers -->

						</div>

					</div>
					<!--   Here is the end of right table -->

				</div>


				<!--   Here is the right Table -->


				<!--   Here is the right Table -->


			</div>

		</div>






	</div>

</div>



<jsp:include
	page="../client_application/_application_process_footer.jsp"
></jsp:include>

<!-- <script>
	$(document).ready(function() {
		let stepper = `
		<ul class="d-none">

		
		<li><a href="#link-1">Assessment<br /> <small>Assessment</small></a></li>
		<li><a href="#link-2">Embossment after Payment<br /> <small>Embossment after Payment</small></a></li>

	</ul>
		`
		document.getElementById('stepper_div').innerHTML = stepper;
	})
</script> -->
