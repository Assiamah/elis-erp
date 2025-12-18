 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


  <jsp:include page="../includes/_header.jsp"></jsp:include>
  

 


    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">Application Processing</a>
        </li>
        <li class="breadcrumb-item active">Entire Processing</li>
         
             
      </ol>
     
           
      
      
      
      
        
      
       <div class="row">
     <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           <div class="card-header ${active_case_objection >0 ? 'bg-danger text-white' : ''}  ${active_case_queries >0 ? 'bg-danger text-white' : ''}">
				<h4 class='float-left'>
				<i class="fas fa-stamp"></i><sapn id="work-header">${business_process_sub_name} - ${case_number}</sapn> </h4>
				<%-- <form action="${pageContext.request.contextPath}/case_movement_module" >
				 --%><!-- <input type="submit" class="btn btn-primary btn-block" value="Back to File Movement" /> -->
				
				<button class="btn btn-primary btn-icon-split float-none float-sm-right d-block mt-1 mt-sm-0 text-center" onclick="javascript:history.go(-1)">
				<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Back</span>
				</button>
				<!-- </form> -->
		</div>
            <div class="card-body">

 
      	    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsemaincase" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Summary of the case 
		            </a>
		        </h5>
		        <div id="collapsemaincase" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
			         		<!--   <button type="button" class="btn btn-primary" id="btn_load_scanned_documents" data-placement="top"  data-toggle="tooltip" title="Load Docs">
					            <i class="fa fa-plus-circle"></i>
					        </button> -->
					        
					        	          <div class="form-group">
				           <input type="hidden" id="cs_main_active_objections"  value="${active_case_objection}">
				           <input type="hidden" id="cs_main_active_queries"  value="${active_case_queries}">
				      
				           <input type="hidden" id="cs_main_business_process_id"  value="${business_process_id}">
				           <input type="hidden" id="cs_main_business_process_name"  value="${business_process_name}">
				           <input type="hidden" id="cs_main_business_process_sub_id"  value="${business_process_sub_id}">
				           <input type="hidden" id="cs_main_business_process_sub_name"  value="${business_process_sub_name}">
				            <input type="hidden" id="cs_main_client_number"  value="${phone_number}">
				            <input type="hidden" id="cs_main_application_stage"  value="${application_stage}">
				           
				           <div class="form-row">
				              <div class="col-md-6">
				                <label for="search_value">Date Created </label>
								   <input  readonly class="form-control" type="text"  value="${created_date}" >       													
				              </div>
				              <div class="col-md-6">
				                <label for="search_value">Last Modified Date</label>
				                <input  readonly class="form-control"    type="text" aria-describedby="nameHelp"  value="${modified_date}" >
				              </div>				             
				            </div>
				            <br><br>
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Case Number</label>
								   <input  readonly class="form-control" id="cs_main_case_number"  name="cs_main_case_number"  type="text" aria-describedby="nameHelp"  value="${case_number}" >
        													
				                </div>
				                 <div class="col-md-4">
				                <label for="search_value">Regional Number</label>
				                <input  readonly class="form-control"    type="text" aria-describedby="nameHelp"  value="${regional_number}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Locality</label>
				                <input  readonly class="form-control"   type="text" aria-describedby="nameHelp"  value="${locality}" >
				              </div>
				             
				            </div>
				            
				            
				      
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Registration District</label>
				                <input  readonly class="form-control" id="txt_new_lc_registration_district_number" type="text" aria-describedby="nameHelp"  value="${registration_district_number}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Registration Section</label>
				                <input  readonly class="form-control"  id="txt_new_lc_registration_section_number" type="text" aria-describedby="nameHelp"  value="${registration_section_number}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Registration Block</label>
				                <input  readonly class="form-control" id="txt_new_lc_registration_block_number"  type="text" aria-describedby="nameHelp"  value="${registration_block_number}" >
				              </div>
				             
				            </div>
				            
				            
				               <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">District</label>
				                <input  readonly class="form-control" type="text" aria-describedby="nameHelp"  value="${district}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Region</label>
				                <input  readonly class="form-control"  type="text" aria-describedby="nameHelp"  value="${region}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Size of Land</label>
				                <input  readonly class="form-control" id="size_of_land_case"  type="text" aria-describedby="nameHelp"  value="${size_of_land}" >
				              </div>
				             
				            </div>
				            
				              <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Date of Document</label>
				                <input  readonly class="form-control  date-picker" type="text" aria-describedby="nameHelp"  value="${date_of_document}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Nature of Instrument</label>
				                <input  readonly class="form-control"  type="text" aria-describedby="nameHelp" value="${nature_of_instrument}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Type of Interest</label>
				                <input  readonly class="form-control"   type="text" aria-describedby="nameHelp" value="${type_of_interest}" >
				              </div>
				             
				            </div>
				            
				            
				             <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Type of Use</label>
				                <input readonly  class="form-control"  type="text" aria-describedby="nameHelp"  value="${type_of_use}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Term</label>
				                <input readonly class="form-control"  type="text" aria-describedby="nameHelp"  value="${term}" >
				              </div>
							  <div class="col-md-4">
				                <label for="search_value">Option for Renewal</label>
				                <input readonly class="form-control"  type="text" aria-describedby="nameHelp"  value="${renewal_term}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Commencement Date</label>
				                <input readonly class="form-control"  type="text" aria-describedby="nameHelp"  value="${commencement_date}" >
				              </div>
				             
				            </div>
				            
				           
				             
				            
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Date of Registration</label>
								  <input readonly type="text" class="form-control" aria-describedby="nameHelp"  value="${date_of_registration}">
        													
				                </div>
				                <div class="col-md-4">
				                <label for="search_value">Job Number</label>
								   <input readonly class="form-control" id="cs_main_job_number"  name="cs_main_job_number"  type="text" value="${job_number}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Applicant Name</label>
								   <input readonly class="form-control" id="cs_main_ar_name"  name="cs_main_ar_name"  type="text" aria-describedby="nameHelp"  value="${ar_name}" >
        													
				                </div>
				                
				                
				                
				                
				                
				               
				             
				            </div>
				            
				            <div class="form-row">
				            
				                <div class="col-md-4">
				                <label for="search_value">Transaction Number</label>
								   <input readonly class="form-control" id="cs_main_transaction_number"  name="cs_main_transaction_number"  type="text" value="${transaction_number}" >
        													
				                </div>
				                
				                  <div class="col-md-4">
				                <label for="search_value">GLPIN</label>
								   <input readonly class="form-control" id="cs_main_glpin"  name="cs_main_glpin"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                <div class="col-md-4">
				                <label for="search_value">Certificate Number</label>
				                <input readonly class="form-control" id="cs_main_certificate_number"  type="text" aria-describedby="nameHelp"  value="${certificate_number}" >
				              </div>
				                
				               
				             
				             
				            </div>
				             
				             
				             
				           <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Assessed Value</label>
				                <input readonly  class="form-control"  type="text" aria-describedby="nameHelp"  value="${assessed_value}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Stamp Duty Payable</label>
				                <input readonly class="form-control"  type="text" aria-describedby="nameHelp"  value="${stamp_duty_payable}" >
				              </div>
				               <div class="col-md-4">
				                <label for="search_value">Consideration in Document</label>
								   <input readonly class="form-control" id="cs_main_consideration"  type="text"  value="${consideration_fee}" >
        													
				                </div>
				                
				               <div class="col-md-4">
				                <label for="search_value">Consideration Currency</label>
								   <input readonly class="form-control" id="cs_main_consideration_currency"  type="text"  value="${consideration_fee_currency}" >
        													
				                </div>
				                <div class="col-md-4">
				                <label for="search_value">Adopted Currency Rate</label>
								   <input readonly class="form-control" id="cs_main_consideration_rate"  type="text"  value="${consideration_fee_adopted_rate}" >
        													
				                </div>

								<div class="col-md-4">
									<label for="search_value">Publication Date</label>
									   <input readonly class="form-control" id="cs_main_publicity_date"  type="text"  value="${publicity_date}" >
																
									</div>

								<div class="col-md-4">
									<label for="search_value">Date of Issue</label>
										<input readonly class="form-control" id="cs_main_date_of_issue"  type="text"  value="${date_of_issue}" >
																
									</div>

									<div class="col-md-4">
										<label for="search_value">Registered Number</label>
											<input readonly class="form-control" id="cs_main_registered_number"  type="text"  value="${registered_number}" >
																	
										</div>
				                
										<div class="col-md-4">
											<label for="search_value">Interest Number</label>
												<input readonly class="form-control" id="cs_main_interest_number"  type="text"  value="${interest_number}" >
																		
											</div>
											<div class="col-md-4">
												<label for="search_value">Sub-Interest Number</label>
													<input readonly class="form-control" id="cs_main_sub_interest_number"  type="text"  value="${sub_interest_number}" >
																			
												</div>
				                
				             
				            </div>
				            
							<div class="form-row">
								<div class="col-md-12">
									<label for="search_value">WKT Polygon</label>
												<input readonly class="form-control" id="cs_main_interest_number"  type="text"  value="${parcel_wkt}" >
													
									</div>
							</div>
							
				          	</div>
						</div>
					</div>
				</div>
      
				  
				     


 <br>   

<script>

var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

function convertDate(date_str) {
  temp_date = date_str.split("-");
  return temp_date[2] + " " + months[Number(temp_date[1]) - 1] + " " + temp_date[0];
}

var cs_main_publicity_date = $("#cs_main_publicity_date").val();
console.log(cs_main_publicity_date);
$("#cs_main_publicity_date").val(cs_main_publicity_date == null ? "" : convertDate(cs_main_publicity_date.slice(0,10)));
	
</script>


