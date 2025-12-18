 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws_casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


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
		        		<!-- <div class="col-md-3 text-end">
		        			<button type="button" id="prevBtn" class="btn-sm" onclick="nextPrev(-1)"><i class="fas fa-arrow-circle-left me-2"></i>Previous</button>
							<button type="button" id="nextBtn" class="btn-sm" onclick="nextPrev(1)">Next<i class="fas fa-arrow-circle-right ms-5"></i></button>
		        		</div> -->
		        	</div>
	        	</div>
	          
		          <div class="card-body">
		          
		         	 <form id="cicaClientForm"  method="post" >
		         	 	<!-- Tab 1 -->  
		            	<div class="">
			            <div class="row col-md-6 mt-3">
			            <h5 class="text-bold text-secondary mb-3">Client's Details</h5>
			            <div class="row mb-3">
				           <label for="inputText" class="col-sm-4 col-form-label"><b>Name</b><span class="text-danger">*</span>:</label>
				           <div class="col-sm-8">
				             <input type="text" class="form-control required-input" name="complainant_name" id="complainant_name" required>
				           </div>
				       	</div>
				          <div class="row mb-3">
				           <label for="inputText" class="col-sm-4 col-form-label"><b>Phone</b><span class="text-danger">*</span>:</label>
				           <div class="col-sm-8">
				             <input type="number" class="form-control required-input" name="complainant_phone" id="complainant_phone" required>
				           </div>
				         </div>
				         <div class="row mb-3">
				           <label for="inputText" class="col-sm-4 col-form-label"><b>Email</b>:</label>
				           <div class="col-sm-8">
				             <input type="text" class="form-control required-input" name="complainant_email" id="complainant_email" >
				           </div>
				         </div>
				         <div class="row mb-3">
				           <label for="inputText" class="col-sm-4 col-form-label"><b>Address</b>:</label>
				           <div class="col-sm-8">
				             <textarea  class="form-control" name="complainant_add" id="complainant_add"></textarea>
				           </div>
				         </div>
				         <div class="row mb-5">
				           <label for="inputText" class="col-sm-4 col-form-label"><b>Purpose</b><span class="text-danger">*</span>:</label>
				           <div class="col-sm-8">
				             <select class="form-control required-input" aria-label="Default select example" name="enquiry_type" id="enquiry_type" required>
				               	<option disabled selected>-- select --</option>
				               	<option value="1">Service Enquiry</option>
								<option value="2">Other Enquiry</option>
								<option value="3">Service Complaint</option>
								<option value="2">Non Service Complaint</option>	
					         </select>
				           </div>
				         </div>
				         	<input type="text" name="request_type" value="clients_details" hidden />
							<input type="text" name="request_by_id" value="${sessionScope.userid}" hidden />
				         	<input type="text" name="request_by" value="${sessionScope.fullname}" hidden />
			          </div>
			          </div>
			          
			          <div class="" id="tab-extra">
			          	 
			          </div>
			          
		        	</form> 
		        	
		     	</div>
		     	<div class="card-footer">
		     		<button type="button" id="showEnquiryTab" class="btn-sm" onclick="showEnquiryTab()"><i class="fas fa-arrow-circle-down me-2"></i>Enquiry</button>
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
 
 <div class="modal fade" id="addTicketModal" tabindex="-1">
   <div class="modal-dialog modal-lg">
     <div class="modal-content">
       <div class="modal-header">
         <h5 class="modal-title text-uppercase">Add Ticket</h5>
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
       </div>
       <form method="post" id="ticketForm">
       <div class="modal-body" >
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Complainant Name</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="text" class="form-control" name="ticket_name" id="ticket_name" required>
           </div>
         </div>
           <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Email:</b></label>
           <div class="col-sm-8">
             <input type="email" class="form-control" name="ticket_email" id="ticket_email">
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Telephone</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="number" class="form-control" name="ticket_tel" id="ticket_tel" required>
           </div>
         </div>
         <hr />
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="text" class="form-control" name="subject" required>
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <textarea class="form-control" name="description" id="description" required></textarea>
           </div>
         </div>
       
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Contact Type</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <select class="form-control" aria-label="Default select example" name="contact_type" id="contact_type" required>
               <option disabled selected>-- select --</option>
               <option value="telephone">Telephone</option>
			<option value="email">Email</option>	
             </select>
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Complaint Type</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <select class="form-control" aria-label="Default select example" name="complaint_type" id="complaint_type" required>
               <option disabled selected>-- select --</option>
               <option value="service related">Service Related</option>
			<option value="None-service related">None-Service Related</option>	
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
		    </select>
           </div>
         </div>
         <div id="related_services"></div>
       </div>
       <div class="modal-footer">
       <button type="reset" id="clear_btn" class="btn btn-danger"><i class="fas fa-times-circle"></i>Clear</button>
         <button type="submit" id="save_btn" class="btn btn-success"><i class="fas fa-check-circle"></i>Save</button>
       </div>
       </form>
     </div>
   </div>
 </div>
 
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

<script type="text/javascript" src="CICA/includes/pages_script/clients.js"></script>

    
 <jsp:include page="../CICA/includes/footer.jsp"></jsp:include>
 <script src="CICA/includes/bootstrap/js/bootstrap.bundle.js"></script>
  
<script>
let currentTab =0;
//showTab(currentTab);

let enquiry_type=document.getElementById("enquiry_type");
let cicaClientForm=document.getElementById("cicaClientForm");
cicaClientForm.addEventListener('submit',cicaClientFormSubmit);

enquiry_type.addEventListener("change",function () {
		 let x=enquiry_type.value;
		 let html="";
		 if(x=="enquiry"){
			 document.getElementById("contents_enquiry").style.display="block";
			 document.getElementById("contents_complaint").style.display="none";
			 let extra_tab=document.getElementById("tab-extra");
			 extra_tab.className += " tab";
			 
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
				                                                            + "</td><td>"*/
				                                                            + this.job_number
				                                                            + "</td><td>"
				                                                            /*+ this.glpin
				                                                            + "</td><td>"*/
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
				                                                            + '</div></div></td></tr>');

				                                        });

				                    }
				                });
	
                        }
                        
                       }

                       })
			 
		 }
		 else if(x=="complaint"){
			 document.getElementById("contents_enquiry").style.display="none";
			 document.getElementById("contents_complaint").style.display="block";
			 let extra_tab=document.getElementById("tab-extra");
			 extra_tab.className = "";
			 extra_tab.innerHTML="";
			 
		 }
		 else{
			 
			 document.getElementById("contents").innerHTML="Select enquiry type";
		 }
	
	})

function showTab(n){
	 let x=document.getElementsByClassName("tab");
	 x[n].style.display ="block";
	 
	 if(n==0){
		 document.getElementById("prevBtn").style.display = "none";
	 
	 } else {
	    document.getElementById("prevBtn").style.display = "inline";
	  }
	 if (n == (x.length - 1)) {
		    document.getElementById("nextBtn").innerHTML = "Submit";
		   
		    
	  } 
	 if(n==2) {
		 document.getElementById("tab-extra").innerHTML=`<div class="row col-md-7 mt-3">
      		<div id="contents_extra">
      		
  			<div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Results</b>:</label>
		           <div class="col-sm-8">
		             <textarea type="text" class="form-control" name="results" id="results"></textarea>
		           </div>
		         </div>
  			
  			</div>
  		</div>`; 
	 }
	else {
	    document.getElementById("nextBtn").innerHTML = `Next <i class="fas fa-arrow-circle-right"></i>`;
	  }
	 
	 //fixStepIndicator(n)
}

function fixStepIndicator(n){
	 var i, x = document.getElementsByClassName("step");
	 for (i = 0; i < x.length; i++) {
		    x[i].className = x[i].className.replace(" active", "");
	 }
	 
	 x[n].className += " active";
}


function showEnquiryTab(){
	let x=document.getElementsByClassName("tab");
	 x[0].style.display ="block";
}
function nextPrev(n) {
	 
	 var x = document.getElementsByClassName("tab");
	 if (n == 1 && !validateForm()) return false;
	 x[currentTab].style.display = "none";
	 currentTab = currentTab + n;
	 if (currentTab >= x.length) {
		    //...the form gets submitted:
		   // document.getElementById("cicaClientForm").submit();
		 cicaClientFormSubmit();
		    return false;
		  }
	 showTab(currentTab);
}

function validateForm() {
	 var x, y, i, valid = true;
	  x = document.getElementsByClassName("tab");
	  y = x[currentTab].getElementsByClassName("required-input");
	  for (i = 0; i < y.length; i++) {
		  
		    if (y[i].value == "") {
		      
		      y[i].className += " invalid";
		     
		      valid = false;
		    }
		  }
		 /* if (valid) {
		    document.getElementsByClassName("step")[currentTab].className += " finish";
		  }*/
		  return valid;
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

function cicaClientFormSubmit(){

	$("#prevBtn").prop('disabled', true);
	$("#nextBtn").prop('disabled', true);
	$("#nextBtn").text("Please wait ...");
	
	
	let complainant_name=$('input[name="complainant_name"]').val();
	let complainant_phone=$('input[name="complainant_phone"]').val();
	let complainant_email=$('input[name="complainant_email"]').val();
	let complainant_add=$('#complainant_add').val();
	let enquiry_type=$('#enquiry_type').find(":selected").text();
	let request_by=$('input[name="request_by"]').val();
	let request_by_id=$('input[name="request_by_id"]').val();
	let complaint_subject=$('input[name="complaint_subject"]').val();
	let complaint_description=$('#complaint_description').val();
	let results=$('#results').val();
	
	$.ajax({
		type:"POST",
		url:"clients",
		data:{"request_type":"clients_details",
			  "complainant_name":complainant_name,
			  "complainant_phone":complainant_phone,
			  "complainant_email":complainant_email,
			  "enquiry_type":"enquiry",
			  "request_by":request_by,
			  "request_by_id":request_by_id,
			  "complaint_subject":complaint_subject,
			  "complaint_description":complaint_description,
			  "results":results
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

</script>