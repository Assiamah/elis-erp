<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


  <jsp:include page="../CICA/includes/header.jsp"></jsp:include>
  

 <div class="content-wrapper">
    <div class="container-fluid">
       <div class="row">
	      <div class="col">
	        <div class="card mb-3 mt-3">
	        	<div class="card-header">
		        	<div class="row">
		        		<div class="col-md-9">
		        			<div class="h5 text-uppercase text-bold text-secondary col-sm-4">TICKETS</div>
		        		</div>
		        			<div class="col-md-3 text-end">
			        			<!-- <button type="button" id="prevBtn" class="btn-sm" onclick="nextPrev(-1)"><i class="fas fa-arrow-circle-left me-2"></i>Previous</button> -->
								<!-- <button type="button" id="submitBtn" class="btn-sm btn-success" onclick="submitForm()"><span id="submit_text">Submit </span><i class="fas fa-arrow-circle-right ms-5"></i></button> -->
		        			</div> 
		        	</div>
	        	</div>
	          
		          <div class="card-body">
		          
		         	 	<!-- Tab 1 -->  
		            	<div class="row">
			            <div class="row col-md-6 mt-3">
			            <h5 class="text-bold text-secondary mb-3">Open Ticket</h5>
			            
				     
				         <div class="row mb-5">
				           <label for="inputText" class="col-sm-3 col-form-label"><b>Purpose</b><span class="text-danger">*</span>:</label>
				           <div class="col-sm-6">
				             <select class="form-control required-input" aria-label="Default select example" name="purpose" id="purpose" required>
				               	<option disabled selected>-- select --</option>
				               	<option value="1">Service Enquiry</option>
								<option value="2">Other Enquiry</option>
								<option value="3">Service Complaint</option>
								<option value="4">Non Service Complaint</option>	
					         </select>
				           </div>
				           <div class="col-sm-3">
				           		<button type="button" id="purposeBtn" class="btn btn-success" onclick="openForm()"> Open <i class="fas fa-play-circle"></i></button> 
				           </div>
				         </div>
				         	<!-- <input type="text" name="request_type" value="clients_details" hidden />
							<input type="text" name="request_by_id" value="${sessionScope.userid}" hidden />
				         	<input type="text" name="request_by" value="${sessionScope.fullname}" hidden /> -->
			          </div>
			          
			         
			          </div>

		        	
		     	</div>
		     	<div class="card-footer">
		     		<button type="button" id="showEnquiryTab" class="btn btn-sm" onclick="showEnquiryTab()"><i class="fas fa-arrow-circle-down me-2"></i>Enquiry</button>
		     	</div>
	       </div>
	    </div>
   	  </div>
   	  
   	  <!-- Enquiry -->
   	  	<div class="row tab">
	      <div class="col">
	        <div class="card mb-3 mt-3">
	        	<div class="card-header">
		        	<div class="row">
		        		<div class="col-md-9">
		        			<div class="h5 text-uppercase text-bold text-secondary col-sm-4">ENQUIRY</div>
		        		</div>
		        	</div>
	        	</div>
	          
		          <div class="card-body">
			          
			          		<!-- enquiry -->
			          		<div id="contents_enquiry">
			          			<div class="row">
								 <div class="col-md-9">
								 	
							            <div class="form-group">
						            	<label><b>Search By: </b></label>
								  	</div>
								    <div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="job_number" required>
									  <label class="custom-control-label" for="rbtn_search_type1">Job number</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type2" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="case_number" required>
									  <label class="custom-control-label" for="rbtn_search_type2">Case Number</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type3" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="regional_number" required>
									  <label class="custom-control-label" for="rbtn_search_type3">Regional Number</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type4" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="glpin" required>
									  <label class="custom-control-label" for="rbtn_search_type4">GLPIN</label>
									</div>
									<br><br>
						          <div class="form-group">
						            <div class="form-row mb-4">
						            <!-- <label for="search_value">Search  by Case Number / Regional Number / Applicant Name / Job number /GLPIN</label> -->
						              <div class="col-md-5">
						                
						                <input class="form-control" id="cc_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
						              </div>
						              <div class="col-md-3">
						              	
						                <button type="button" class="btn btn-warning" value="Search" id="btnCCJobSearch" ><i class="fas fa-search"></i> Search </button>
						                
						              </div>
						            </div>
						            </div>
						            
						            </div>
						            <div class="col-md-3">
						            
						
						        	</div>
						        </div>
						
						            <!-- Search Results -->
						            <div class="row mb-4">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3" style="display:none" id="cc-search-results-section">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Search Results</div>
            <div class="card-body">
            
         
            
	             <!--  Here is where the fee list comes -->
	             
	             <div class="table-responsive" >
			           <table class="table table-bordered " id="cc-search-results-table" style="min-height:500px">
			              <thead>
			                <tr>
			                 <th>Applicant Name</th>
			                  <!-- <th>Case Number</th> -->
			                  <th>Job Number</th>
			                  <!-- <th>GLPIN</th> -->
			                  
			                  <th>Locality</th>
			                  <th>Regional Number</th>
			                  <th>Case Status</th>
			                  
			                  <th>Actions</th>
			                  
			                  
			                
			                 </tr>
			              </thead>
			              
			              <tbody>
			               	
			                              
						     
			              </tbody> 
			            </table>
	          	</div>
             
              <!--  End Of Table -->
             </div>
            <!-- <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
          </div>
          
     <!-- Example Bar Chart Card-->
          
        
    
       </div>
        
      </div>
      <!-- End search results -->
						            
						          </div>
			          		
			         		<!-- end enquiry -->
			         	
			         
			  </div>
			  <div class="card-footer">
			  
			  </div>
			</div>
		</div>
	</div>
   	  
   	  <!-- Enquiry -->
   </div>   
</div>
 <!-- ServiceEnquiryTicketModal -->
 <div class="modal fade" id="ServiceEnquiryTicketModal" tabindex="-1">
   <div class="modal-dialog modal-lg">
     <div class="modal-content">
       <div class="modal-header">
         <h5 class="modal-title text-uppercase">Service Enquiry</h5>
         <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">&times;</button>
       </div>
       <form method="post" id="ServiceEnquiryForm">
       <div class="modal-body" >
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Complainant Name</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="text" class="form-control" name="se_ticket_name" id="se_ticket_name" required>
           </div>
         </div>
           <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Email:</b></label>
           <div class="col-sm-8">
             <input type="email" class="form-control" name="se_ticket_email" id="se_ticket_email">
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Telephone</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="number" class="form-control" name="se_ticket_tel" id="se_ticket_tel" required>
           </div>
         </div>
         <hr />
         <div class="row mb-3" id="withinDiv">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Within Time Frame?</b>:</label>
	           <div class="col-sm-8">
	             <select class="form-control required-input" aria-label="Default select example" name="se_within_time_frame" id="se_within_time_frame">
	               	<option disabled selected>-- select --</option>
	               	<option value="1">Yes</option>
					<option value="0">No</option>	
		         </select>
	           </div>
     	</div>
         <div id="se_div">
           
         </div>
       </div>
       <div class="modal-footer">
       <button type="reset" id="clear_btn" class="btn btn-danger"><i class="fas fa-times-circle"></i>Clear</button>
         <button type="submit" id="" class="btn btn-success save_btn"><i class="fas fa-check-circle"></i>Save</button>
       </div>
       </form>
     </div>
   </div>
 </div>
 <!-- ServiceEnquiryTicketModal  -->
 <!-- Other Enquiry -->
 <div class="modal fade" id="OtherEnquiryTicketModal" tabindex="-1">
   <div class="modal-dialog modal-lg">
     <div class="modal-content">
       <div class="modal-header">
         <h5 class="modal-title text-uppercase">Other Enquiry</h5>
         <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">&times;</button>
       </div>
       <form method="post" id="OtherEnquiryForm">
       <div class="modal-body" >
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Complainant Name</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="text" class="form-control" name="oe_ticket_name" id="oe_ticket_name" required>
           </div>
         </div>
           <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Email:</b></label>
           <div class="col-sm-8">
             <input type="email" class="form-control" name="oe_ticket_email" id="oe_ticket_email">
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Telephone</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="number" class="form-control" name="oe_ticket_tel" id="oe_ticket_tel" required>
           </div>
         </div>
         <hr />
         <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>REFER ENQUIRER TO 
	           APPROPRIATE ONLINE 
	           SOURCES FOR 
	           FURTHER 
	           INFORMATION</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <textarea class="form-control" name="reference_source" id="reference_source" required></textarea>
	           </div>
	     </div>
       </div>
       <div class="modal-footer">
       <button type="reset" id="clear_btn" class="btn btn-danger"><i class="fas fa-times-circle"></i>Clear</button>
         <button type="submit" id="save_btn" class="btn btn-success"><i class="fas fa-check-circle"></i>Save</button>
       </div>
       </form>
     </div>
   </div>
 </div>
 <!-- Other Enquiry -->
 <!-- Service Complaint -->
 <div class="modal fade" id="ServiceComplaintTicketModal" tabindex="-1">
   <div class="modal-dialog modal-lg">
     <div class="modal-content">
       <div class="modal-header">
         <h5 class="modal-title text-uppercase">Service Complaint</h5>
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
       </div>
       <form method="post" id="ServiceComplaintForm">
       <div class="modal-body" >
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Complainant Name</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="text" class="form-control" name="sc_ticket_name" id="sc_ticket_name" required>
           </div>
         </div>
           <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Email:</b></label>
           <div class="col-sm-8">
             <input type="email" class="form-control" name="sc_ticket_email" id="sc_ticket_email">
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Telephone</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="number" class="form-control" name="sc_ticket_tel" id="sc_ticket_tel" required>
           </div>
         </div>
         <hr />
         <div class="row mb-3" id="withinDiv">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Within Time Frame?</b>:</label>
	           <div class="col-sm-8">
	             <select class="form-control required-input" aria-label="Default select example" name="sc_within_time_frame" id="sc_within_time_frame">
	               	<option disabled selected>-- select --</option>
	               	<option value="1">Yes</option>
					<option value="0">No</option>	
		         </select>
	           </div>
     	</div>
         <div id="sc_div">
           
         </div>
       </div>
       <div class="modal-footer">
       <button type="reset" id="clear_btn" class="btn btn-danger"><i class="fas fa-times-circle"></i>Clear</button>
         <button type="submit" id="save_btn" class="btn btn-success"><i class="fas fa-check-circle"></i>Save</button>
       </div>
       </form>
     </div>
   </div>
 </div>
 <!-- Service Complaint -->
 <!-- Non Service Complaint -->
 <div class="modal fade" id="NonServiceComplaintTicketModal" tabindex="-1">
   <div class="modal-dialog modal-lg">
     <div class="modal-content">
       <div class="modal-header">
         <h5 class="modal-title text-uppercase">Non Service Complaint</h5>
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
       </div>
       <form method="post" id="NonServiceComplaintForm">
       <div class="modal-body" >
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Complainant Name</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="text" class="form-control" name="ns_ticket_name" id="se_ticket_name" required>
           </div>
         </div>
           <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Email:</b></label>
           <div class="col-sm-8">
             <input type="email" class="form-control" name="ns_ticket_email" id="se_ticket_email">
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Telephone</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="number" class="form-control" name="ns_ticket_tel" id="se_ticket_tel" required>
           </div>
         </div>
         <hr />
         <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <input  class="form-control" name="ns_subject" id="ns_subject" list="datalistOptions"  placeholder="Type to search..." required>        
				  <datalist id="datalistOptions">
				    <option value="Abuse"></option>
				    <option value="Fraud"></option>
				  </datalist>
	           </div>
	         </div>
	         <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <textarea class="form-control" name="ns_description" id="ns_description" required></textarea>
	           </div>
	         </div>
	         <div class="row mb-3">
	              <label for="inputText" class="col-sm-4 col-form-label"><b>Division</b><span class="text-danger">*</span>:</label>	
				<div class="col-sm-8">
					<select class="form-control" aria-label="Default select example" name="division" id="division" required>
		                <option value="" disabled selected>-- select --</option>
		                <option value="PVLMD">PVLMD</option>
						<option value="LRD">LRD</option>
						<option value="LVD">LVD</option>	
						<option value="SMD">SMD</option>	
						<option value="CORPORATE">CORPORATE</option>		
		              </select>
				</div>
			</div>
			
			<div class="row mb-3">
			    <label for="inputText" class="col-sm-4 col-form-label"><b>Region</b><span class="text-danger">*</span>:</label>
				<div class="col-sm-8">
					<select class="form-control" aria-label="Default select example" name="region" id="region" onchange="regionChange()" required>
		                <option disabled selected>-- select --</option>
		                <option value="11">Greater Accra</option>
						<option value="14">Western</option>
						<option value="19">Volta</option>	
						<option value="12">Eastern</option>	
						<option value="13">Ashanti</option>	
						<option value="15">Central</option>	
						<option value="18">Northern</option>	
						<option value="16">Upper East</option>	
						<option value="17">Upper West</option>	
						<option value="11">Tema</option>
						<option value="10">Oti</option>	
						<option value="11">Bono East</option>	
						<option value="12">Ahafo</option>	
						<option value="13">Bono</option>	
						<option value="14">North East </option>	
						<option value="15">Savannah</option>
						<option value="16">Western North</option>	
		              </select>
				</div>
			</div>
			
		
			
			<div class="row mb-3">
		    	<label for="inputText" class="col-sm-4 col-form-label"><b>Unit</b><span class="text-danger">*</span>:</label>
				<div class="col-sm-8">
					   <input class="form-control" id="unit"  name="unit" type="text" autocomplete="off" 
              list="listofunits" class="autocomplat"  placeholder="Enter Username" required  onmousedown="value = '';" >
				<datalist id="listofunits"></datalist>
				</div>
			</div>
        
         
       </div>
       <div class="modal-footer">
       <button type="reset" id="clear_btn" class="btn btn-danger"><i class="fas fa-times-circle"></i>Clear</button>
         <button type="submit" id="save_btn" class="btn btn-success"><i class="fas fa-check-circle"></i>Save</button>
       </div>
       </form>
     </div>
   </div>
 </div>
 <!-- Non Service Complaint -->
 <!-- Track Job Modal -->
 <div class="modal fade" id="trackingModal" tabindex="-1" role="dialog"
	aria-labelledby="addInspectionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addMinutesModalLabel">Application
					Tracking History</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container px-5">
					<h3>Details</h3>
					
					</div>
					<hr class="mt-2 mb-3">
					<div class="row  px-5">
					<br>
					
					
								<div class="col-sm-4"><b>Date Created</b><br><div id="date_created_text"></div>
								
								</div>
								<div class="col-sm-4"><b>Job Number</b><br><div id="job_number_text"></div>
								</div>
								<div class="col-sm-4"><b>Submitted By</b><br><div id="submitted_by_text"></div>
								</div>
							</div>
							<br>
					<div class="row  px-5">
							
								<div class="col-sm-4"><b>Main Service</b><br><div id="main_service_text"></div>
								</div>
								<div class="col-sm-4"><b>Sub Service</b><br><div id="sub_service_text"></div>
								</div>
								<div class="col-sm-4"><b>Status</b><br><div id="status_text"></div>
								</div>
							
						
				</div>
				<br><br>
				<hr class="mt-2 mb-3">
				<div class="row  px-2">
					<div class="col-md-6">
						<div class="card">
							<div class="card-header">Milestones</div>
							<div class="card-body">
								<table class="table table-bordered" id="cabinet-tracking">
									<thead>
										<tr>
											<th>SN</th>
											<th>Milestone Status</th>
											<!-- <th>status</th> -->
											<!-- <th>Date</th> -->
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							</div>
						</div>




					</div>
					<div class="col-md-6">
						<div class="card">
							<div class="card-header">SMS Messages/ Notifications</div>
							<div class="card-body">
								<table class="table table-bordered" id="sms-tracking">
									<thead>
										<tr>
											<th>SN</th>
											<th>Message</th>
											<th>Date Sent</th>
											<!-- <th>Date</th> -->
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							</div>
						</div>
					</div>

				</div>


			</div>
		</div>
	</div>
</div>
 <!-- End Job Modal -->

<script type="text/javascript" src="CICA/includes/pages_script/clients_new.js"></script>

    
 <jsp:include page="../CICA/includes/footer.jsp"></jsp:include>
 <script src="CICA/includes/bootstrap/js/bootstrap.bundle.js"></script>
  
<script>
function openForm(){
	let purpose=$("#purpose").val();
	if(purpose==null){
		toastr["error"]("Select Purpose ", "New Ticket");
		$("#purpose").focus()
        return false;
	}
	
	switch(purpose) {
	  case '1':
	    // code block	    
	    $("#ServiceEnquiryTicketModal").modal('show');
	    break;
	  case '2':
	    // code block
	    $("#OtherEnquiryTicketModal").modal('show');
	    break;
	  case '3':
		    // code block
		 $("#ServiceComplaintTicketModal").modal('show');
		 break;
	  case '4':
	    // code block
	      $('#NonServiceComplaintTicketModal').modal('show');
	    break;  
	    
	  default:
	    // code block
	}
}

 
function regionChange(){
	 let x=region.value;
	 let division=$('#division').find(":selected").val();
	
	 if(division == ""){
		 toastr["warning"]("Select Division", "LEGAL");
		 $('#division').focus();
	 }
	 else{
		 
		 $.ajax({
				url:"Case_Management_Serv",
				method:"POST",
				data:{
						request_type:"get_lc_list_of_units"
				},
				success:function(response){
					//console.log(response);
					let json_p = JSON.parse(response);
					var datalist = $("#listofunits");
					datalist.empty();
					
					$(json_p.data).each(
									function() {
												
													if(this.unit_division ==division){
													datalist
															.append('<option data-name="'
																	+ this.unit_name
																	+ '" data-id="'
																	+ this.unit_id
																	+ '" value="'
																	+ this.unit_name
																	+ '" ></option>');
													}
									
											});
				}
					
				})
	 }
}

function showEnquiryTab(){
	let x=document.getElementsByClassName("tab");
	 x[0].style.display ="block";
}	
/*let currentTab =0;
//showTab(currentTab);
$("#submitBtn").prop('disabled', true);
let purpose=document.getElementById("purpose");
let tab_extra=document.getElementById("tab-extra");
let cicaClientForm=document.getElementById("cicaClientForm");

//Divs


purpose.addEventListener("change",function () {
	 tab_extra.innerHTML ="";
	 document.getElementById("tab_extra2").innerHTML ="";
	 let x=purpose.value;
	 let html="";
	if(x=="1" || x=="3"){
		html=`
			<div class="row mb-3" id="withinDiv">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Within Time Frame?</b>:</label>
	           <div class="col-sm-8">
	             <select class="form-control required-input" aria-label="Default select example" name="within_time_frame" id="within_time_frame" onchange="within_time_frame_change()">
	               	<option disabled selected>-- select --</option>
	               	<option value="1">Yes</option>
					<option value="2">No</option>	
		         </select>
	           </div>
     		</div>`;
     		tab_extra.innerHTML =html;
     		$("#submitBtn").prop('disabled', true);
     		$("#submit_text").text("Submit");
		
	}
	else if(x=="2"){
		html=`
			 <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>REFER ENQUIRER TO 
	           APPROPRIATE ONLINE 
	           SOURCES FOR 
	           FURTHER 
	           INFORMATION</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <textarea class="form-control" name="reference_source" id="reference_source" required></textarea>
	           </div>
	         </div>`;
		tab_extra.innerHTML =html;
		$("#submitBtn").prop('disabled', false);
		$("#submit_text").text("Submit");
		
	}
	else{
		html=`
			 <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <input  class="form-control" name="subject" id="subject" list="datalistOptions"  placeholder="Type to search..." required>        
				  <datalist id="datalistOptions">
				    <option value="Abuse"></option>
				    <option value="Fraud"></option>
				  </datalist>
	           </div>
	         </div>
	         <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <textarea class="form-control" name="description" id="description" required></textarea>
	           </div>
	         </div>
	         <div class="row mb-3">
	              <label for="inputText" class="col-sm-4 col-form-label"><b>Division</b><span class="text-danger">*</span>:</label>	
				<div class="col-sm-8">
					<select class="form-control" aria-label="Default select example" name="division" id="division" required>
		                <option value="" disabled selected>-- select --</option>
		                <option value="PVLMD">PVLMD</option>
						<option value="LRD">LRD</option>
						<option value="LVD">LVD</option>	
						<option value="SMD">SMD</option>	
						<option value="CORPORATE">CORPORATE</option>		
		              </select>
				</div>
			</div>
			
			<div class="row mb-3">
			    <label for="inputText" class="col-sm-4 col-form-label"><b>Region</b><span class="text-danger">*</span>:</label>
				<div class="col-sm-8">
					<select class="form-control" aria-label="Default select example" name="region" id="region" onchange="regionChange()" required>
		                <option disabled selected>-- select --</option>
		                <option value="11">Greater Accra</option>
						<option value="14">Western</option>
						<option value="19">Volta</option>	
						<option value="12">Eastern</option>	
						<option value="13">Ashanti</option>	
						<option value="15">Central</option>	
						<option value="18">Northern</option>	
						<option value="16">Upper East</option>	
						<option value="17">Upper West</option>	
						<option value="11">Tema</option>
						<option value="10">Oti</option>	
						<option value="11">Bono East</option>	
						<option value="12">Ahafo</option>	
						<option value="13">Bono</option>	
						<option value="14">North East </option>	
						<option value="15">Savannah</option>
						<option value="16">Western North</option>	
		              </select>
				</div>
			</div>
			
		
			
			<div class="row mb-3">
		    	<label for="inputText" class="col-sm-4 col-form-label"><b>Unit</b><span class="text-danger">*</span>:</label>
				<div class="col-sm-8">
					   <input class="form-control" id="unit"  name="unit" type="text" autocomplete="off" 
              list="listofunits" class="autocomplat"  placeholder="Enter Username" required  onmousedown="value = '';" >
<datalist id="listofunits"></datalist>
				</div>
			</div>
	         `;
		tab_extra.innerHTML =html;
		$("#submitBtn").prop('disabled', false);
		$("#submit_text").text("Submit");
		
	}
	
		
	})


			document.getElementById("btnCCJobSearch").addEventListener("click", function () {
			  // Check if radio button and input field filled
			  if(checkInput()){
				  // Submit Search
				  var enq_search_type = "";
					var selected_rbtn = $("input[name='rbtn_search_type']:checked");
					if (selected_rbtn.length > 0) {
						enq_search_type = selected_rbtn.val();
						//console.log("selected " + enq_search_type);
					}

					var enq_search_value = $(
							"#cc_search_value").val();
					console.log('Search Value: '
							+ enq_search_value);
					
					if (!(enq_search_value.length >= 8)) {
						$
								.notify(
										{
											message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 8 or more characters to search </span>',
										}, {
											type : 'danger' , z_index: 9999 
										});
					}else if (enq_search_type.length <= 0){
						$.notify({
							message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
						}, { type : 'danger' , z_index: 9999  });
						
					} else {

						$("#cc-search-results-section")
								.hide();
						
						$.ajax({
				            type : "POST",
				            url : "Case_Management_Serv",
				            data : {
				                request_type : 'load_application_details_for_enquiries',
				                job_number : enq_search_value,
				                search_type: enq_search_type
				            },
				            cache : false,
				                    success : function(
				                            jobdetails) {

				                        // console.log(jobdetails);
				                        $(
				                                "#cc-search-results-section")
				                                .show();

				                        var table = $('#cc-search-results-table');
				                        table.find(
				                                "tbody tr")
				                                .remove();

				                        // console.log(jobdetails);
				                        var json_p = JSON
				                                .parse(jobdetails);

				                        $(json_p)
				                                .each(
				                                        function() {
				                                            //console.log(this);
				                                            table
				                                                    .append("<tr><td>"
				                                                            + this.ar_name
				                                                            + "</td><td>"
				                                                            /*+ this.case_number
				                                                            + "</td><td>"*
				                                                            + this.job_number
				                                                            + "</td><td>"
				                                                            /*+ this.glpin
				                                                            + "</td><td>"*/
				                                                            /*
				                                                            
				                                                            + this.locality
				                                                            + "</td><td>"
				                                                            + this.regional_number
				                                                            + "</td><td>"
				                                                            + this.current_application_status
				                                                            + "</td>"

				                                                            + '<td> <div class="dropdown"> <button class="btn btn-secondary dropdown-toggle" type="button"'
				                                                            + ' id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Actions</button>'
				                                                            + ' <div class="dropdown-menu" aria-labelledby="dropdownMenu2">'

				                                                            + '<button type="button" class="btn btn-primary dropdown-item" id="btn_cabinet" title="View Application Progress" data-toggle="modal" data-target="#trackingModal"'
				                                                            + ' data-target-id="'
				                                                            + this.job_number
				                                                            + '"> '
				                                                            + '<span class="icon text-black-50"> <i class="fas fa-hdd"></i> </span><span  class="text">Track Application</span> </button><div class="dropdown-divider"></div>'

				                                                            /*+ '<button type="button" class="btn btn-primary dropdown-item" id="track_file" title="Physical File History" data-toggle="modal" data-target="#filelistModal"'
				                                                            + ' data-target-id="'
				                                                            + this.job_number
				                                                            + '"> '*/
				                                                            /*+ '<span class="icon text-black-50"> <i class="fas fa-archive"></i> </span><span  class="text">Track Physical File </span> </button><div class="dropdown-divider"></div>'

				                                

				                                                            */
				                                                            /*
				                                                            + '<form action="front_office_view_application" method="post">'
				                                                            + '<input type="hidden" name="case_number" id="case_number" value="'+ this.transaction_number +'">'
				                                                            + '<input type="hidden" name="job_number" id="job_number" value="'+ this.job_number +'">'
				                                                            + '<input id="search_text" name="search_text" type="hidden" value="'+ this.case_number +'">'
				                                                            + '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'+ this.case_number +'}">'
				                                                            
				                                                            
				                                                            + '<button type="submit" class="btn btn-primary dropdown-item" id="btn_application_details" title="View Application Details" > '
				                                                            + '<span class="icon text-black-50"> <i class="fas fa-info-circle"></i>  </span><span  class="text">Application Details</span></button>'
				                                                            
				                                                            
				                                                            
				                                                            
				                                                            + '</form>'
				                                                            
				                                                            /*+ '<div class="dropdown-divider"></div>'

				                                                            + '<button type="button" class="btn btn-primary dropdown-item" id="btn_collection"  title="Issue out Application" data-toggle="modal" data-target="#collectionModal" '
				                                                            + ' data-target-id="'
				                                                            + this.job_number
				                                                            + '"> '
				                                                            + '<span class="icon text-black-50"> <i class="fas fa-hand-holding"></i> </span><span  class="text">Collection</span></button>'
				                                                            + '<div class="dropdown-divider"></div>'*/

				                                                            /*
				                                                                * + '<button
				                                                                * type="button"
				                                                                * class="btn
				                                                                * btn-primary
				                                                                * dropdown-item"
				                                                                * id="btn_file_number"
				                                                                * title="File
				                                                                * Number" ' + '
				                                                                * data-target-id="' +
				                                                                * this.job_number +
				                                                                * '"> ' + '
				                                                                * <span
				                                                                * class="icon
				                                                                * text-black-50">
				                                                                * <i
				                                                                * class="fas
				                                                                * fa-file-alt"></i>
				                                                                * </span><span
				                                                                * class="text">File
				                                                                * number :
				                                                                * LRD565
				                                                                * </span></button>' + '
				                                                                * <div
				                                                                * class="dropdown-divider"></div>'
				                                                                */

				                                                            /*+ '<button type="button" class="btn btn-primary  dropdown-item" id="btn_add_fees"   title="Add Fees">'
				                                                            + '<span class="icon text-black"> <i class="fa fa-dollar-sign"></i>  </span> <span  class="text">Add Fees</span></button>'
				*/
				
				/* + '</div></div></td></tr>'); 

				                                        });

				                    }
				                });
	
                        }
                        
                       }

                       })
			 
function within_time_frame_change(){
	let x= document.getElementById("within_time_frame").value;
	 let html="";
		if(x=="1"){
			html=`<div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>PROVIDE 
		           MILESTONE STATUS 
		           TO ENQUIRER</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <textarea class="form-control" name="milestone_status" id="milestone_status" required></textarea>
		           </div>
		         </div>`;
			
			document.getElementById("tab_extra2").innerHTML =html;
			$("#submitBtn").prop('disabled', false);
			
		}
		else{
			html=`<div class="row">
	        	<h6 class="text-bold text-secondary ">Make Complaint</h6>
		        </div>
	           	<hr />
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <input  class="form-control" name="subject" id="subject" list="datalistOptions"  placeholder="Type to search..." required>        
					  <datalist id="datalistOptions">
					    <option value="Can not upload site plan"></option>
					    <option value="Document can not be found"></option>
					    <option value="Can not acknowledge bill"></option>
					    <option value="Did not get acknowledgement slip"></option>
					  </datalist>
		           </div>
		         </div>
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <textarea class="form-control" name="description" id="description" required></textarea>
		           </div>
		         </div>
		       
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Contact Client by</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <select class="form-control" aria-label="Default select example" name="contact_type" id="contact_type" required>
		               <option disabled selected>-- select --</option>
		               <option value="telephone">Telephone</option>
						<option value="email">Email</option>
						<option value="both">Both</option>		
		             </select>
		           </div>
		         </div>
		        
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Priority</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <select class="form-control" aria-label="Default select example" name="priority" id="priority" required>
		               <option disabled selected>-- select --</option>
		               <option value="1">Low</option>
						<option value="2">Medium</option>
						<option value="3">High</option>
						<option value="4">Urgent</option>
		             </select>
		           </div>
		         </div>
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Related Service</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <select class="form-control" id="related_service" name="related_service" onChange="get_related_service(this.value);" required>
					    <option value="" disabled selected>-- select --</option>
					    <option value="Job Number">Job Number</option>
					    <option value="Bill Number">Bill Number</option>
					    <option value="Bill Number">Case Number</option>
					    <option value="Bill Number">Regional Number</option>
				    </select>
		           </div>
		         </div>
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Reference ID</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <input type="text" class="form-control required-input" name="reference_id" id="reference_id" >
		           </div>
		         </div>`;
		         
			document.getElementById("tab_extra2").innerHTML =html;
			$("#submitBtn").prop('disabled', false);
		}

}
		

function get_related_service(val){
    var related_service = val;
    let html = '';
    if (related_service == 'Job Number'){
        html = "<div class='row mb-3'><label for='inputText' class='col-sm-4 col-form-label'><b>Job Number</b><span class='text-danger'>*</span>:</label><div class='col-sm-8'><input type='text' class='form-control' name='service_number' required></div></div>";
    }
    
    else if (related_service == 'Bill Number'){
        html = "<div class='row mb-3'><label for='inputText' class='col-sm-4 col-form-label'><b>Bill Number</b><span class='text-danger'>*</span>:</label><div class='col-sm-8'><input type='number' class='form-control' name='service_number' required></div></div>";
    }
    else if(related_service == 'Name'){
        html = "<div class='row mb-3'><label for='inputText' class='col-sm-4 col-form-label'><b>Name of Applicant</b><span class='text-danger'>*</span>:</label><div class='col-sm-8'><input type='text' class='form-control' name='service_number' required></div></div>";
    }

    document.getElementById('related_services').innerHTML = html;        
}

//Function Checks if radio button and input field filled
function checkInput(){
	 let checkedList=[];
    let checkBoxes =document.getElementsByClassName('rbtn_search_type');
    for (let i=0;i<checkBoxes.length;i++){
        if(checkBoxes[i].checked){
            checkedValue=checkBoxes[i].value;
            checkedList.push(checkedValue);
        }
    }
    
    if(checkedList.length === 0){
        toastr["error"]("Nothing selected ", "Job Search");
        return false;
    }
    else{
   	 
   	 
   	 return true;
    }
}

function submitForm(){

	$("#submitBtn").prop('disabled', true);
	$("#submit_text").text("Please wait ...");

	
	let complainant_name=$('input[name="complainant_name"]').val();
	let complainant_phone=$('input[name="complainant_phone"]').val();
	let complainant_email=$('input[name="complainant_email"]').val();
	let complainant_add=$('#complainant_add').val();
	let selected_purpose=$('#purpose').find(":selected").val();
	let request_by=$('input[name="request_by"]').val();
	let request_by_id=$('input[name="request_by_id"]').val();
	let within_time_frame="";
	let milestone_status="";
	if(complainant_name !="" || complainant_phone !="" ){
		
	switch(selected_purpose){
	  case "1":
		  	
		  		within_time_frame=$('#within_time_frame').find(":selected").val();
		  		milestone_status=$('#milestone_status').val();
		  		console.log(milestone_status);
		  		if(within_time_frame !="" ){
		  			
		  			$("#submitBtn").prop('disabled', false);
		  			$("#submit_text").text("Submit");
		  			cicaClientForm.submit();
		  			
		  		}else{
			  		 toastr["error"]("There are empty required fields ", "CICA");
			  	}
		  
		  	
		  break;
	  case "2":
	  		let reference_source=$('#reference_source').val();
	  		if(reference_source !=""){
	  			$("#submitBtn").prop('disabled', false);
	  			$("#submit_text").text("Submit");
	  			cicaClientForm.submit();		
	  		}else{
		  		 toastr["error"]("There are empty required fields ", "CICA");
		  	}
		  break;
	  case "3":
		    within_time_frame=$('#within_time_frame').find(":selected").val();
	  		milestone_status=$('#milestone_status').val();
	  		console.log(milestone_status);
	  		if(within_time_frame !=""){
	  			
	  			$("#submitBtn").prop('disabled', false);
	  			$("#submit_text").text("Submit");
	  			cicaClientForm.submit();
	  			
	  		}else{
		  		 toastr["error"]("There are empty required fields ", "CICA");
		  	}
		  break;
	   case "4":
		   let subject=$('#subject').val();
		   let description=$('#description').val();
	  		if(subject !="" || description !=""){
	  			$("#submitBtn").prop('disabled', false);
	  			$("#submit_text").text("Submit");
	  			cicaClientForm.submit();
	  			
	  		}else{
		  		 toastr["error"]("There are empty required fields ", "CICA");
		  	}
		  break;
	default:
		console.log("no criteria");
	}

	}
	else{
 		 toastr["error"]("There are empty required fields ", "CICA");
 	}
	
	let complaint_subject=$('input[name="complaint_subject"]').val();
	let complaint_description=$('#complaint_description').val();
	let results=$('#results').val();

}

function submitData(formData){
	const values = [...formData.entries()];
	 console.log(values);
	$.ajax({
		type:"POST",
		url:"clients",
		data:{formData,
		},
		success:function(response){
		  console.log(response);
		 let json_result = JSON.parse(response);

		 if(json_result.success){
			 toastr["success"]("Successfully", "CICA");
            } 
          else {
                    toastr["error"]("Error", "CICA");
             }

                $("#cicaClientForm").trigger('reset');

                $("#prevBtn").prop('disabled', false);
                $("#nextBtn").prop('disabled', false);
                
                setTimeout(function(){
                    location.reload();
                },1000); 
		}	
	})
	
	
}

			function regionChange(){
				 let x=region.value;
				 let division=$('#division').find(":selected").val();
				
				 if(division == ""){
					 toastr["warning"]("Select Division", "LEGAL");
					 $('#division').focus();
				 }
				 else{
					 
					 $.ajax({
							url:"Case_Management_Serv",
							method:"POST",
							data:{
									request_type:"get_lc_list_of_units"
							},
							success:function(response){
								//console.log(response);
								let json_p = JSON.parse(response);
								var datalist = $("#listofunits");
								datalist.empty();
								
								$(json_p.data).each(
												function() {
															
																if(this.unit_division ==division){
																datalist
																		.append('<option data-name="'
																				+ this.unit_name
																				+ '" data-id="'
																				+ this.unit_id
																				+ '" value="'
																				+ this.unit_name
																				+ '" ></option>');
																}
												
														});
							}
								
							})
				 }
	  }
	  
		function showEnquiryTab(){
			let x=document.getElementsByClassName("tab");
			 x[0].style.display ="block";
		}	*/	
</script>