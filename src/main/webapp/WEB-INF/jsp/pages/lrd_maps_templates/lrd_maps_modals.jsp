<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>






<div class="modal fade" id="lrdparcelinformationfirsttimesavewithinfo" role="dialog"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">LRD
					Parcel Info</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


							
									<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">GLPIN Number</label> <input
												class="form-control " type="text"
												placeholder="" id="lrd_glpin"
											readonly>
										</div>
			
									</div>
								</div>
								
							
					
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="bl_ar_name">Locality</label> <input
												class="form-control " type="text" placeholder=""
												id="lrd_locality_fts"
											>
										</div>
				
										<div class="col">
											<label for="bl_business_process_sub_name">Remarks</label> <input
									class="form-control " type="text" placeholder=""
									id="lrd_remarks_fts"
								>
										</div>
									</div>
								</div>
							

							
							<div class="form-group">
								<label for="bl_parcelwkt">Parcel WKT</label> <input
									class="form-control " type="text" placeholder=""
									id="lrd_parcel_wkt_to_plot_fts"
								>
							</div>


						
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											
									
									
										</div>
				
										<div class="col">
											
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
				
				<button class="btn btn-primary btn-block" id="btn_save_lrd_parcel_details_fts_with_info">
					<span class="text" >Save</span>
			</button>
				
			</div>

		</div>
	</div>
</div>






<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="transitional_certificate_template" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Certificate and Register Details</h4>
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
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsemaincasexx" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Case Details
		            </a>
		        </h5>
		        <div id="collapsemaincasexx" class="collapse" role="tabpanel" aria-labelledby="headingThree">

					<div class="card card-body mb-3">

						<input type="hidden" id="ts_main_business_process_id_sm" >
						<input type="hidden" id="ts_main_business_process_name_sm" >
						<input type="hidden" id="ts_main_business_process_sub_id_sm" >
						<input type="hidden" id="ts_main_business_process_sub_name_sm" >
						 <input type="hidden" id="ts_main_client_number_sm" >
						 <input type="hidden" id="ts_main_application_stage_sm">

						<!-- <div class="form-row">
							<div class="col-md-6">
							  <label for="search_value">Date Created </label>
								 <input  readonly class="form-control" type="text"  value="${created_date}" >       													
							</div>
							<div class="col-md-6">
							  <label for="search_value">Last Modified Date</label>
							  <input  readonly class="form-control"    type="text" aria-describedby="nameHelp"  value="${modified_date}" >
							</div>				             
						  </div> -->
						  <div class="form-row">
							<div class="col-md-4">
							  <label for="search_value">Case Number</label>
								 <input  readonly class="form-control" id="ts_main_case_number_sm"  name="ts_main_case_number_sm"  type="text" aria-describedby="nameHelp"  >
														  
							  </div>
							   <div class="col-md-4">
							  <label for="search_value">Regional Number</label>
							  <input  readonly class="form-control"  id="ts_main_regional_number_sm"  type="text" aria-describedby="nameHelp" >
							</div>
							  <div class="col-md-4">
							  <label for="search_value">Locality</label>
							  <input  readonly class="form-control"  id="ts_main_locality_sm" type="text" aria-describedby="nameHelp"   >
							</div>
						   
						  </div>
						  
						  
					
						  <div class="form-row">
							<div class="col-md-4">
							  <label for="search_value">Registration District</label>
							  <input  readonly class="form-control" id="ts_main_registration_district_number_sm" type="text" aria-describedby="nameHelp"  >
							</div>
							  <div class="col-md-4">
							  <label for="search_value">Registration Section</label>
							  <input  readonly class="form-control"  id="ts_main_registration_section_number_sm" type="text" aria-describedby="nameHelp" >
							</div>
							  <div class="col-md-4">
							  <label for="search_value">Registration Block</label>
							  <input  readonly class="form-control" id="ts_main_registration_block_number_sm"  type="text" aria-describedby="nameHelp" >
							</div>
						   
						  </div>
						  
						  
							 <div class="form-row">
							<div class="col-md-4">
							  <label for="search_value">District</label>
							  <input  readonly class="form-control" id="ts_main_district_sm" type="text" aria-describedby="nameHelp">
							</div>
							  <div class="col-md-4">
							  <label for="search_value">Region</label>
							  <input  readonly class="form-control" id="ts_main_region_sm" type="text" aria-describedby="nameHelp"  >
							</div>
							  <div class="col-md-4">
							  <label for="search_value">Size of Land</label>
							  <input  readonly class="form-control" id="ts_main_size_of_land_sm"  type="text" aria-describedby="nameHelp" >
							</div>
						   
						  </div>
						  
							<div class="form-row">
							<div class="col-md-4">
							  <label for="search_value">Date of Document</label>
							  <input  readonly class="form-control  date-picker" id="ts_main_date_of_document_sm" type="text" aria-describedby="nameHelp"  >
							</div>
							  <div class="col-md-4">
							  <label for="search_value">Nature of Instrument</label>
							  <input  readonly class="form-control" id="ts_main_nature_of_instrument_sm" type="text" aria-describedby="nameHelp">
							</div>
							  <div class="col-md-4">
							  <label for="search_value">Type of Interest</label>
							  <input  readonly class="form-control" id="ts_main_type_of_interest_sm"  type="text" aria-describedby="nameHelp"  >
							</div>
						   
						  </div>
						  
						  
						   <div class="form-row">
							<div class="col-md-4">
							  <label for="search_value">Type of Use</label>
							  <input readonly  class="form-control" id="ts_main_type_of_use_sm" type="text" aria-describedby="nameHelp">
							</div>
							  <div class="col-md-4">
							  <label for="search_value">Term</label>
							  <input readonly class="form-control" id="ts_main_term_sm" type="text" aria-describedby="nameHelp" >
							</div>
							<div class="col-md-4">
							  <label for="search_value">Option for Renewal</label>
							  <input readonly class="form-control" id="" type="text" aria-describedby="nameHelp" >
							</div>
							 
						   
						  </div>
						  
						 
						   
						  
						  <div class="form-row">
							<div class="col-md-4">
							  <label for="search_value">Commencement Date</label>
							  <input readonly class="form-control" id="ts_main_commencement_date_sm"  type="text" aria-describedby="nameHelp">
							</div>
							
							<div class="col-md-4">
							  <label for="search_value">Date of Registration</label>
								<input readonly type="text" class="form-control" aria-describedby="nameHelp"  id="ts_main_date_of_registration_sm">
														  
							  </div>
							  
							  
							  
							   <div class="col-md-4">
							  <label for="search_value">Applicant Name</label>
								 <textarea readonly class="form-control" name="ts_main_ar_name_sm"  type="text" aria-describedby="nameHelp"  id="ts_main_ar_name_sm"></textarea>
						  
							  </div>
							  
							  
							  
							  
							  
							 
						   
						  </div>
						  
						  <div class="form-row">
						  
							  <div class="col-md-4">
							  <label for="search_value">Transaction Number</label>
								 <input readonly class="form-control" id="ts_main_transaction_number_sm"  name="ts_main_transaction_number_sm"  type="text" value="${transaction_number}" >
														  
							  </div>
							  
							  <div class="col-md-4">
								<label for="search_value">Job Number</label>
								   <input readonly class="form-control" id="ts_main_job_number_sm"  name="ts_main_job_number_sm"  type="text" >
															
								</div>
							  
							  <div class="col-md-4">
							  <label for="search_value">Certificate Number</label>
							  <input readonly class="form-control" id="ts_main_certificate_number_sm"  type="text" aria-describedby="nameHelp" >
							</div>
							  
							 
						   
						   
						  </div>
						   
						   
						   
						 <div class="form-row">
							<div class="col-md-4">
							  <label for="search_value">Assessed Value</label>
							  <input readonly  class="form-control"  type="text" aria-describedby="nameHelp" id="ts_main_assessed_value_sm" >
							</div>
							  <div class="col-md-4">
							  <label for="search_value">Stamp Duty Payable</label>
							  <input readonly class="form-control"  type="text" aria-describedby="nameHelp"  id="ts_main_stamp_duty_payable_sm">
							</div>
							 <div class="col-md-4">
							  <label for="search_value">Consideration in Document</label>
								 <input readonly class="form-control" id="ts_main_consideration_fee_sm"  type="text" >
														  
							  </div>
							  
							 <div class="col-md-4">
							  <label for="search_value">Consideration Currency</label>
								 <input readonly class="form-control" id="ts_main_case_consideration_fee_currency_sm"  type="text" >
														  
							  </div>
							  <div class="col-md-4">
							  <label for="search_value">Adopted Currency Rate</label>
								 <input readonly class="form-control" id="ts_main_case_consideration_fee_adopted_rate_sm"  type="text" >
														  
							  </div>
		
							  <div class="col-md-4">
								  <label for="search_value">Publication Date</label>
									 <input readonly class="form-control" id="ts_main_publicity_date_sm"  type="text">
															  
								  </div>
		
							  <div class="col-md-4">
								  <label for="search_value">Date of Issue</label>
									  <input readonly class="form-control" id="ts_main_case_date_of_issue_sm"  type="text">
															  
								  </div>
		
								  <div class="col-md-4">
									  <label for="search_value">Registered Number</label>
										  <input readonly class="form-control" id="ts_main_case_registered_number_sm"  type="text"  >
																  
									  </div>
		
									  <div class="col-md-4">
										<label for="search_value">GLPIN</label>
										<input class="form-control" id="ts_main_glpin_sm"    type="text" aria-describedby="nameHelp" placeholder="GLPIN" readonly>
									  </div>
							  
						  </div>
		
						  <div class="form-row">
						   <div class="col-md-4">
							 <label for="search_value">Type of Plotting</label>
							 <input class="form-control" id="ts_main_smd_type_of_plotting_sm"  name="ts_main_smd_type_of_plotting_sm"  type="text" aria-describedby="nameHelp"   readonly>
						   </div>
					 
							 <div class="col-md-4">
							 <label for="search_value">SMD Reference Number</label>
							 <input class="form-control" id="ts_main_smd_reference_number_sm"  name="ts_main_smd_reference_number_sm"  type="text" aria-describedby="nameHelp" readonly>
							 </div>
		
							 <!-- <div class="col-md-4">
							  <label for="search_value">Registration District</label>
							  <input class="form-control" id="txt_lc_registration_district_number"  name="txt_lc_registration_district_number"  type="text" aria-describedby="nameHelp" value="${registration_district_number}" readonly >
							</div> -->
							<!-- <div class="col-md-4">
							  <label for="search_value">Land size</label>
							  <input class="form-control" id="txt_lc_size_of_land"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${size_of_land}" readonly>
							</div> -->
		
							<div class="col-md-4">
							  <label for="search_value">CC No</label>
							  <input class="form-control" id="ts_main_cc_no_sm"  name="search_value"  type="text" aria-describedby="nameHelp" readonly>
							</div> 
						
					 
						 </div>
						  
						  
						<!--   <div class="form-row">
						  
						 <div class="col-md-4">
						   <label for="search_value">Section Number</label>
						   <input class="form-control" id="txt_lc_registration_section_number"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registration_section_number}" readonly>
						 </div>
						   <div class="col-md-4">
						   <label for="search_value">Block Number</label>
						   <input class="form-control" id="txt_lc_registration_block_number"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registration_block_number}" readonly>
						 </div> 
		
						<div class="col-md-4">
						  <label for="search_value">Land size</label>
						  <input class="form-control" id="txt_lc_size_of_land"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${size_of_land}" readonly>
						</div> 
						  
						 </div>-->
						 
						 
							<div class="form-row">
						 
							   <div class="col-md-4">
							   <label for="search_value">Plan Number</label>
							   <input class="form-control" id="ts_main_plan_no_sm"  name="ts_main_plan_no_sm"  type="text" aria-describedby="nameHelp" readonly>
							 </div>
						  <div class="col-md-4">
							<label for="search_value">LTR Plan Number</label>
						   <input class="form-control" id="ts_main_ltr_plan_no_sm"  name="ts_main_ltr_plan_no_sm"  type="text" aria-describedby="nameHelp"  readonly>
						 
							
						  </div>
						  <div class="col-md-4">
							<label for="search_value">Registry Map No</label>
							<input class="form-control" id="ts_main_registry_mapref_sm"  name="ts_main_registry_mapref_sm"  type="text" aria-describedby="nameHelp"  readonly>
						  </div>
						  
						 </div>
						 
						 <div class="form-row">
						 
						 
						 
		
						 <div class="col-md-4">
						  <label for="search_value">Interest Number</label>
							  <input readonly class="form-control" id="ts_main_interest_number"  type="text" >
													  
						  </div>
						  <div class="col-md-4">
							  <label for="search_value">Sub-Interest Number</label>
								  <input readonly class="form-control" id="ts_main_sub_interest_number"  type="text"  >
														  
							  </div>
						  
						  
						 </div>
					</div>
		        </div>
		    </div>
      
				  
				     

 <br>   

  
  
  
   <div class="card">

		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseacknowledgeofterPayment" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Root of Title
		            </a>
		        </h5>
		        <div id="collapseacknowledgeofterPayment" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

			   	        
				        <h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
                    <!-- <button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" id="btn_newProprietorshipModal" data-toggle="tooltip" title="Add New ">
			            <i class="fa fa-plus-circle"></i>
			        </button> -->
                     
               	  <div  class="table w-auto small">
			           <table class="table table-bordered" id="lrd_proprietorship_details_dataTable_2" >
			           
			              <thead>
			                <tr>
			
				                 <th>Registrated No.</th>
				                 <th>Proprietor</th>
				                 <th>Date of Instrument</th>
				                 <th>Nature of Instrument</th>
			                    <!-- <th>Action</th> -->
			                  </tr>
			              </thead>
			              
			                <tbody>
							     <c:forEach items="${lrd_proprietorship_section}" var="proprietorship_section">
				               		 <tr>
				                    <td>${proprietorship_section.ps_registration_number}</td>
				                    <td>${proprietorship_section.ps_proprietor}</td>
				                    <td>${proprietorship_section.ps_date_of_instrument}</td>
				                    <td>${proprietorship_section.ps_nature_of_instrument}</td>
				                    <!-- <td class="${proprietorship_section.edit == 1 ? 'd-none' : ''}">
				                    	<p data-placement="top" data-toggle="tooltip" title="Batch">
					                    	<button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newProprietorshipModal" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
					                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
					                    	</button>
				                    	</p>
				                    </td> -->
				                    
				                    	
				                    
				                     
				                    
				                    </tr>
				            	</c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div>
			          
			          
			          
			          
			           <h5 class="border-bottom border-gray pb-2">Memorial Details</h5>
			              <!-- <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  id="btn_newMemorialsModal" data-toggle="tooltip" title="Add New Memorial">
		            <i class="fa fa-plus-circle"></i>
		        </button> -->
                     
               	  <div  class="table w-auto small">
			           <table class="table table-bordered" id="lrd_memorial_details_dataTable_2" >
			           
			              <thead>
			                <tr>
			
			                 <th>Registered No.</th>
			                 <th>Memorials</th>
			                 <th>Date of Instrument</th>
			                 <th>Date of Registration</th>
							 <th>Entry No</th>
			                 <!-- <th>Action</th> -->
			                
			                 </tr>
			              </thead>
			              
			                <tbody>
						     <c:forEach items="${lrd_memorials_section}" var="memorials_section">
				                <tr>
				                    <td>${memorials_section.m_registered_no}</td>
				                    <td>${memorials_section.m_memorials}</td>
				                    <td>${memorials_section.m_date_of_instrument}</td>
				                    <td>${memorials_section.m_date_of_registration}</td>
									<td>${memorials_section.m_entry_number}</td>
				                    <!-- <td class="${memorials_section.edit == 1 ? 'd-none' : ''}">
									 <p data-placement="top"  title="Edit">  
										<button class="btn btn-info btn-icon-split" data-title="Edit"  data-toggle="modal"
											 data-target="#newMemorialsModal"
											 data-target-id="${memorials_section.mid}"
											 data-mid="${memorials_section.mid}"  
											 data-m_case_number="${memorials_section.m_case_number}"
											 data-m_registered_no="${memorials_section.m_registered_no}"
											 data-m_memorials="${memorials_section.m_memorials}"
											 data-m_date_of_registration="${memorials_section.m_date_of_registration}"
											 data-m_date_of_instrument="${memorials_section.m_date_of_instrument}"
											 data-m_back="${memorials_section.m_back}"
											 data-m_remarks="${memorials_section.m_remarks}"
											 > 
													 
													 
											<span class="icon text-white-50"> 
											<i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>
									</p>
									</td> -->
				                   
				                  <%--  	<td>
				                   		<form  action="${pageContext.request.contextPath}/registration_application_progress_details"   method="post" target="_blank" id="downloadForm">
				                   		<input type="hidden" name="case_numer" id="case_number" value="${memorials_section.mid}"> <input type="hidden" name="job_number" id="job_number" value="${memorials_section.mid}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Edit"/></form></td>
				                     --%>
	                    	
                    
                     
                    
                    </tr>
          				  </c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div>
			          
			          
			          <h5 class="border-bottom border-gray pb-2">Valuation Details</h5>
			       <!-- <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" id="btn_newValuationModal" data-toggle="tooltip" title="Add New Valuation Records">
		            <i class="fa fa-plus-circle"></i>
		        </button> -->
                     
               	  <div  class="table w-auto small">
			           <table class="table table-bordered" id="lrd_valuation_details_dataTable_2">
			           
			              <thead>
			                <tr>
			
			                 <th>Date of Valuation</th>
			                 <th>Amount</th>
			                 <th>Remarks</th>
			                 <!-- <th>Action</th> -->
			                  
			                  </tr>
			              </thead>
			              
			                <tbody>
			     <c:forEach items="${lrd_valuation_section}" var="valuation_section">
                <tr>
                    <td>${valuation_section.vs_date_of_valuation}</td>
                    <td>${valuation_section.vs_amount}</td>
                    <td>${valuation_section.vs_remarks}</td>
                    
                    <!-- <td>
						<p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p>
					</td> -->
					<!-- <td class="${valuation_section.edit == 1 ? 'd-none' : ''}">
						<button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newValuationModal" 
						data-target-id="${valuation_section.vs_id}" 
						data-vs_id="${valuation_section.vs_id}"
						data-vs_case_number="${valuation_section.vs_case_number}"
						data-vs_date_of_valuation="${valuation_section.vs_date_of_valuation}"
						data-vs_amount="${valuation_section.vs_amount}"
						data-vs_remarks="${valuation_section.vs_remarks}"
						data-whatever="edit">
							<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
						</button>
					</td> -->
                   
                   
                  <!-- <%--  <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"   method="post" target="_blank" id="downloadForm"><input type="hidden" name="case_numer" id="case_number" value="${valuation_section.vs_id}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                    --%>  -->
                    	
                    
                     
                    
                    </tr>
            </c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div>
			          
			          
			          
			      <h5 class="border-bottom border-gray pb-2">Certificate Details</h5>
			      <!-- <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  id="btn_newCertificateModal" data-toggle="tooltip" title="Add New">
		            <i class="fa fa-plus-circle"></i>
		        </button> -->
                     
               	  <div  class="table w-auto small">
			           <table class="table table-bordered" id="lrd_certificate_details_dataTable_2">
			           
			              <thead>
			                <tr>
			
			                 <th>Date of Registration</th>
			                 <th>TO Whom Issued</th>
			                 <th>Serial Number</th>
			                 <th>Official Notes</th>
			                 
			                   <!-- <th>Remove</th> -->
			                  </tr>
			              </thead>
			              
			                <tbody>
			     <c:forEach items="${lrd_certificate_section}" var="certificate_section">
                <tr>
                    <td>${certificate_section.cs_date_of_registration}</td>
                    <td>${certificate_section.cs_to_whom_issued}</td>
                    <td>${certificate_section.cs_serial_number}</td>
                    <td>${certificate_section.cs_official_notes}</td>
                    <!-- <td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${certificate_section.cs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p></td> -->
                  
                <!-- <%--    <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"   method="post" target="_blank" id="downloadForm"><input type="hidden" name="case_numer" id="case_number" value="${certificate_section.cs_id}"> <input type="hidden" name="job_number" id="job_number" value="${certificate_section.cs_id}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                  --%>    -->
                    	
                    
                     
                    
                    </tr>
            </c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div>
			          
                
			          <!-- <div class="card-body"> -->
		
						<h5 class="border-bottom border-gray pb-2">Encumberances Details</h5>
											<!-- <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newEncumberancesModal" data-toggle="tooltip" title="Add New">
										  <i class="fa fa-plus-circle"></i>
										  </button> -->
										   <div class= "clear"></div><br>
													<div  class="able w-auto small table-responsive">
												 <table class="table table-bordered" id="lrd_registration_encumbrance_dataTable_2">
												 
													<thead>
													  <tr>
								  <!-- 	es_id -->
													   <th>Registered Number</th>
													   <th>Date of Instrument</th>
													   <th>Date of Registration</th>
													   <th>Memorials</th>
													   <th>Remarks</th>
													   <!-- <th>Action</th> -->
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
															  <!-- <td>
																  <button class="btn btn-secondary btn-icon-split" 
																  data-toggle="modal"
																  data-target="#newEncumberancesModal"
																  data-es_id="${lrd_encumbrances_section_row.es_id}"
																  data-es_case_number="${lrd_encumbrances_section_row.es_case_number}"
																  data-es_registered_number="${lrd_encumbrances_section_row.es_registered_number}"
																  data-es_date_of_registration="${lrd_encumbrances_section_row.es_date_of_registration}"
																  data-es_date_of_instrument="${lrd_encumbrances_section_row.es_date_of_instrument}"
																  data-es_back="${lrd_encumbrances_section_row.es_back}"
																  data-es_forward="${lrd_encumbrances_section_row.es_forward}"
																  data-es_remarks="${lrd_encumbrances_section_row.es_remarks}"
																  data-es_memorials="${lrd_encumbrances_section_row.es_memorials}"
																  data-es_signature="${lrd_encumbrances_section_row.es_signature}"
																  data-es_action_on_form_encumbrances="edit"
																  >
																  <span class="icon text-white-50"> 
																	  <i class="fas fa-pen"></i></span> <span class="text">Edit</span>
																  </button>
															  </td> -->
														   </tr>
													   </c:forEach>
														</tbody>
								  
												  
												  </table>
												</div>
											
									  
												  
											  <!-- </div> -->
                
				      
		                
		            </div>
		        </div>
 </div>
      
				  
				     

          
			
      
  <br>
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsedocsxx" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Documents On Application
		            </a>
		        </h5>
		        <div id="collapsedocsxx" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
			         		  <button type="button" class="btn btn-primary" id="btn_load_scanned_documents_ts" data-placement="top"  title="Load Docs">
					            <i class="fas fa-eye"></i>
					        </button>
					        
					         <!-- <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-toggle="modal" data-target="#fileUploadModal" title="Add Documents">
					            <i class="fa fa-plus-circle"></i>
					        </button> -->
					        
					      
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable_ts" width="100%" class="display" cellspacing="0">
				           
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
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsemaualbills" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Previews
		            </a>
		        </h5>
		        <div id="collapsemaualbills" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

						<div class="row mt-2">
							<div class="col-md-12">
				
								<input type="button" id="lc_btn_generate_mother_final_register" class="btn btn-primary btn-block w-100" value="Generate Register" />  
								<!-- 																	 
								<input type="button" id="lc_btn_activate_provisional_certificate" class="btn btn-warning btn-block" value="Generate Provisional Certificate" />  
								-->
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
</div>






<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="original_transitional_certificate_template" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Certificate and Register Details</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


			   <div class="row">
     
     
     
     <div class="col-lg-8">
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
				            
				            <input type="hidden" id="cs_main_business_process_id"  value="${business_process_id}">
				           <input type="hidden" id="cs_main_business_process_name"  value="${business_process_name}">
				           <input type="hidden" id="cs_main_business_process_sub_id"  value="${business_process_sub_id}">
				           <input type="hidden" id="cs_main_business_process_sub_name"  value="${business_process_sub_name}">
				            <input type="hidden" id="cs_main_client_number"  value="${phone_number}">
				            <input type="hidden" id="cs_main_application_stage"  value="${application_stage}">
				           
				          
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Case Number</label>
								   <input   class="form-control" id="cs_main_case_number"  name="cs_main_case_number"  type="text" aria-describedby="nameHelp"  value="${case_number}" >
        													
				                </div>
				                 <div class="col-md-4">
				                <label for="search_value">Regional Number</label>
				                <input   class="form-control"  id="cs_main_regional_number"  type="text" aria-describedby="nameHelp"  value="${regional_number}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Locality</label>
				                <input   class="form-control"  id="cs_main_locality" type="text" aria-describedby="nameHelp"  value="${locality}" >
				              </div>
				             
				            </div>
				            
				            
				      
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Registration District</label>
				                <input   class="form-control" id="cs_main_registration_district_number" type="text" aria-describedby="nameHelp"  value="${registration_district_number}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Registration Section</label>
				                <input   class="form-control"  id="cs_main_registration_section_number" type="text" aria-describedby="nameHelp"  value="${registration_section_number}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Registration Block</label>
				                <input   class="form-control" id="cs_main_registration_block_number"  type="text" aria-describedby="nameHelp"  value="${registration_block_number}" >
				              </div>
				             
				            </div>
				            
				            
				               <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">District</label>
				                <input   class="form-control" id="cs_main_district" type="text" aria-describedby="nameHelp"  value="${district}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Region</label>
				                <input   class="form-control" id="cs_main_region" type="text" aria-describedby="nameHelp"  value="${region}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Size of Land</label>
				                <input   class="form-control" id="cs_main_size_of_land"  type="text" aria-describedby="nameHelp"  value="${size_of_land}" >
				              </div>
				             
				            </div>
				            
				              <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Date of Document</label>
				                <input   class="form-control  date-picker" id="cs_main_date_of_document"type="text" aria-describedby="nameHelp"  value="${date_of_document}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Nature of Instrument</label>
				                <input   class="form-control" id="cs_main_nature_of_instrument" type="text" aria-describedby="nameHelp" value="${nature_of_instrument}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Type of Interest</label>
				                <input   class="form-control"  id="cs_main_type_of_interest" type="text" aria-describedby="nameHelp" value="${type_of_interest}" >
				              </div>
				             
				            </div>
				            
				            
				             <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Type of Use</label>
				                <input   class="form-control" id="cs_main_type_of_use" type="text" aria-describedby="nameHelp"  value="${type_of_use}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Term</label>
				                <input  class="form-control" id="cs_main_term" type="text" aria-describedby="nameHelp"  value="${term}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Commencement Date</label>
				                <input  class="form-control"  id="cs_main_commencement_date" type="text" aria-describedby="nameHelp"  value="${commencement_date}" >
				              </div>
				             
				            </div>
				            
				           
				             
				            
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Date of Registration</label>
								  <input  type="text" id="cs_main_date_of_registration" class="form-control" aria-describedby="nameHelp"  value="">
        													
				                </div>
				                <div class="col-md-4">
				                <label for="search_value">Job Number</label>
								   <input  class="form-control" id="cs_main_job_number"  name="cs_main_job_number"  type="text" value="${job_number}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Applicant Name</label>
								   <input  class="form-control" id="cs_main_ar_name_large"   type="text" aria-describedby="nameHelp"  value="${ar_name}" >
        													
				                </div>
				                
				                
				                
				                
				                
				               
				             
				            </div>
				            
				            <div class="form-row">
				            
				                <div class="col-md-4">
				                <label for="search_value">Transaction Number</label>
								   <input  class="form-control" id="cs_main_transaction_number"  name="cs_main_transaction_number"  type="text" value="${transaction_number}" >
        													
				                </div>
				                
				                  <div class="col-md-4">
				                <label for="search_value">GLPIN</label>
								   <input  class="form-control" id="cs_main_glpin"  name="cs_main_glpin"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				               
				                
				                
				                  <div class="col-md-4">
				                <label for="search_value">licensed_no</label>
								   <input  class="form-control" id="cs_main_licensed_no"  name="cs_main_licensed_no"  type="text"  value="${licensed_no}" >
        													
				                </div>
				                
				               
				             
				             
				            </div>
				             
				             
				             
				                <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Assessed Value</label>
				                <input   class="form-control" id="cs_main_assessed_value" type="text" aria-describedby="nameHelp"  value="${assessed_value}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Stamp Duty Payable</label>
				                <input  class="form-control"  id="cs_main_stamp_duty_payable" type="text" aria-describedby="nameHelp"  value="${stamp_duty_payable}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Certificate Number</label>
				                <input  class="form-control" id="cs_main_certificate_number" type="text" aria-describedby="nameHelp"  value="${certificate_number}" >
				              </div>
				             
				            </div>
				            
				            
				            
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">cs_main_registry_mapref</label>
				                <input   class="form-control" id="cs_main_registry_mapref" type="text" aria-describedby="nameHelp"  value="${registry_mapref}" >
				              </div>
				              
				              <div class="col-md-4">
				                <label for="search_value">cs_main_plan_no</label>
				                <input   class="form-control" id="cs_main_plan_no" type="text" aria-describedby="nameHelp"  value="${registry_mapref}" >
				              </div>
				              
				              <div class="col-md-4">
				                <label for="search_value">cs_main_cc_no</label>
				                <input   class="form-control" id="cs_main_cc_no" type="text" aria-describedby="nameHelp"  value="${registry_mapref}" >
				              </div>
				              
				              <div class="col-md-4">
				                <label for="search_value">cs_main_ltr_plan_no</label>
				                <input   class="form-control" id="cs_main_ltr_plan_no" type="text" aria-describedby="nameHelp"  value="${registry_mapref}" >
				              </div>
				               
				              
				             
				            </div>
				            
				             <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Locality Class</label>
				                <input   class="form-control" id="cs_main_locality_class" type="text" aria-describedby="nameHelp"  value="${registry_mapref}" >
				              </div>
				              
				              
				              
				             
				            </div>
				            
				           
				            
				          </div>
				          
					        
		                
		            </div>
		        </div>
		    </div>
      
				  
				     

 <br>   

  
  
  
   <div class="card">

		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseacknowledgeofterPayment" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Root of Title
		            </a>
		        </h5>
		        <div id="collapseacknowledgeofterPayment" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

			   	        
				        <h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
                    <button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
			            <i class="fa fa-plus-circle"></i>
			        </button>
                     
               	  <div  class="table w-auto small">
			           <table class="table table-bordered" id="lrd_proprietorship_details_dataTable" >
			           
			              <thead>
			                <tr>
			
				                 <th>registration_number</th>
				                 <th>proprietor</th>
				                 <th>date_of_instrument</th>
				                 <th>nature_of_instrument</th>
			                    <th>Action</th>
			                  </tr>
			              </thead>
			              
			                <tbody>
							     <c:forEach items="${lrd_proprietorship_section}" var="proprietorship_section">
				               		 <tr>
				                    <td>${proprietorship_section.ps_registration_number}</td>
				                    <td>${proprietorship_section.ps_proprietor}</td>
				                    <td>${proprietorship_section.ps_date_of_instrument}</td>
				                    <td>${proprietorship_section.ps_nature_of_instrument}</td>
				                    <td>
				                    	<p data-placement="top" data-toggle="tooltip" title="Batch">
					                    	<button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newProprietorshipModal" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
					                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
					                    	</button>
				                    	</p>
				                    </td>
				                    
				                    	
				                    
				                     
				                    
				                    </tr>
				            	</c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div>
			          
			          
			          
			          
			           <h5 class="border-bottom border-gray pb-2">Memorial Details</h5>
			              <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newMemorialsModal" data-toggle="tooltip" title="Add New Memorial">
		            <i class="fa fa-plus-circle"></i>
		        </button>
                     
               	  <div  class="table w-auto small">
					<table class="table table-bordered" id="lrd_memorial_details_dataTable" >
			           
						<thead>
						  <tr>
			
						   <th>Registered No</th>
						   <th>Memorials</th>
						   <th>Date of Instrument</th>
						   <th>Date of Registration</th>
						   <th>Entry No</th>
						   <th>Edit</th>
						  
						   </tr>
						</thead>
						
						  <tbody>
						   <c:forEach items="${lrd_memorials_section}" var="memorials_section">
							  <tr>
								  <td>${memorials_section.m_registered_no}</td>
								  <td>${memorials_section.m_memorials}</td>
								  <td>${memorials_section.m_date_of_instrument}</td>
								  <td>${memorials_section.m_date_of_registration}</td>
								  <td>${memorials_section.m_entry_number}</td>
								   <td>
										  
										  <p data-placement="top"  title="Edit">  
												<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
													 data-target="#newMemorialsModal"
													 data-target-id="${memorials_section.mid}"
													 data-mid="${memorials_section.mid}"  
													 data-m_case_number="${memorials_section.m_case_number}"
													 data-m_registered_no="${memorials_section.m_registered_no}"
													 data-m_memorials="${memorials_section.m_memorials}"
													 data-m_date_of_registration="${memorials_section.m_date_of_registration}"
													 data-m_date_of_instrument="${memorials_section.m_date_of_instrument}"
													 data-m_back="${memorials_section.m_back}"
													 data-m_remarks="${memorials_section.m_remarks}"
													 data-m_entry_number="${memorials_section.m_entry_number}"
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
			          
			          
			          <h5 class="border-bottom border-gray pb-2">Valuation Details</h5>
			       <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newValuationModal" data-toggle="tooltip" title="Add New Valuation Records">
		            <i class="fa fa-plus-circle"></i>
		        </button>
                     
               	  <div  class="table w-auto small">
			           <table class="table table-bordered" id="lrd_valuation_details_dataTable">
			           
			              <thead>
			                <tr>
			
			                 <th>vs_date_of_valuation</th>
			                 <th>vs_amount</th>
			                 <th>vs_remarks</th>
			                 <th>Edit</th>
			                  
			                  </tr>
			              </thead>
			              
			                <tbody>
			     <c:forEach items="${lrd_valuation_section}" var="valuation_section">
                <tr>
                    <td>${valuation_section.vs_date_of_valuation}</td>
                    <td>${valuation_section.vs_amount}</td>
                    <td>${valuation_section.vs_remarks}</td>
                    
                    <td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p></td>
                   
                   
                  <%--  <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"   method="post" target="_blank" id="downloadForm"><input type="hidden" name="case_numer" id="case_number" value="${valuation_section.vs_id}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                    --%> 
                    	
                    
                     
                    
                    </tr>
            </c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div>
			          
			          
			          
			      <h5 class="border-bottom border-gray pb-2">Certificate Details</h5>
			      <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newCertificateModal" data-toggle="tooltip" title="Add New">
		            <i class="fa fa-plus-circle"></i>
		        </button>
                     
               	  <div  class="table w-auto small">
			           <table class="table table-bordered" id="lrd_certificate_details_dataTable">
			           
			              <thead>
			                <tr>
			
			                 <th>cs_date_of_registration</th>
			                 <th>cs_to_whom_issued</th>
			                 <th>cs_serial_number</th>
			                 <th>cs_official_notes</th>
			                 
			                   <th>Remove</th>
			                  </tr>
			              </thead>
			              
			                <tbody>
			     <c:forEach items="${lrd_certificate_section}" var="certificate_section">
                <tr>
                    <td>${certificate_section.cs_date_of_registration}</td>
                    <td>${certificate_section.cs_to_whom_issued}</td>
                    <td>${certificate_section.cs_serial_number}</td>
                    <td>${certificate_section.cs_official_notes}</td>
                    <td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${certificate_section.cs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p></td>
                  
                <%--    <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"   method="post" target="_blank" id="downloadForm"><input type="hidden" name="case_numer" id="case_number" value="${certificate_section.cs_id}"> <input type="hidden" name="job_number" id="job_number" value="${certificate_section.cs_id}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                  --%>   
                    	
                    
                     
                    
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
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsepocessingoncase" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i> Certificate Customization
		            </a>
		        </h5>
		        <div id="collapsepocessingoncase" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

			   
		 <textarea id="lc_search_report_summary_details" name="lc_search_report_summary_details" class="form-control col-sm-12" required rows=7  style="padding:50px !important;">${remark_or_comment} </textarea> 
			        	                    
		               
				      
		                
		            </div>
		        </div>
 </div>
      
    <br>

	    <div class="card">

		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsemaualbills" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Previews
		            </a>
		        </h5>
		        <div id="collapsemaualbills" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

			  
		                
		            </div>
		        </div>
		    </div>
      
				  

 
      

      
            
          
            </div>
          
          </div>
          
         
        
    
   
        
      </div>
      
      
      
      
    <!--   Here is the right Table -->
        <div class="col-lg-4">
          <!-- Example Pie Chart Card-->
          
          
          
          	    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapselistofservices" aria-expanded="false" aria-controls="collapseFive">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fa fa-users"></i>Instructions
		            </a>
		        </h5>
		        <div id="collapselistofservices" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		               
		                 <textarea id="lc_search_report_summary_details" name="lc_search_report_summary_details" class="form-control col-sm-12" required rows=7  style="padding:50px !important;">${remark_or_comment} </textarea> 
			        	                    
		               
		               
		               
		               
		       <!--   <form action="http://localhost:8080/lccorporate/Login" method="post">
				
				
				  <input type="hidden" id="username" name="username"  value="jecd@gmail.com">
				    <input type="hidden" id="password" name="password"  value="win">
				<button type="submit"  class="btn btn-primary btn-icon-split float-right" >
				<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Back</span>
				</button>
				</form> -->
		               

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
		               
		               
			         		  <button type="button" class="btn btn-primary" id="btn_load_scanned_documents" data-placement="top"  title="Load Docs">
					            <i class="fas fa-eye"></i>
					        </button>
					        
					         <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-toggle="modal" data-target="#fileUploadModal" title="Add Documents">
					            <i class="fa fa-plus-circle"></i>
					        </button>
					        
					      
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable" width="100%" class="display" cellspacing="0">
				           
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
          
          <div id="accordion" role="tablist" aria-multiselectable="true">
		   
		   
		   
		 
		   <!--  <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsedocs" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Reports
		            </a>
		        </h5>
		        <div id="collapsedocs" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
		        
		            </div>
		        </div>
		    </div> -->
		    <br>
		    

		    
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
				
			</div>

		</div>
	</div>
</div>




   <!-- Certificate Section============================= -->
	<div class="modal fade" id="newCertificateModal" tabindex="-1" role="dialog" aria-labelledby="newCertificateModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="newCertificateModalLabel">Certificate Section</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form id="form_add_certificate">
	        
	        	<input  id="cs_id" name="cs_id" type="hidden" value="0" >
	        	<!-- <input id="request_type" name="request_type" type="hidden" value="select_lrd_certificate_section_add_and_update">
	        	 -->
	        	
	          <div class="row">
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="case_number" class="col-form-label">Case Number</label>
	            		<input type="text" name="cs_case_number" id="cs_case_number" class="form-control" required value="${case_number}" readonly>
	          		</div>
	          		<div class="form-group">
	            		<label for="cs_date_of_registration" class="col-form-label">Date of Issue</label>
	            		<input type="date" name="cs_date_of_registration" id="cs_date_of_registration" class="form-control" required>
	          		</div>
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="cs_to_whom_issued" class="col-form-label">To Whom Issued</label>
	            		<input type="text" name="cs_to_whom_issued" id="cs_to_whom_issued" class="form-control" required>
	          		</div>
	          		<div class="form-group">
	            		<label for="cs_serial_number" class="col-form-label">Serial Number</label>
	            		<input type="text" name="cs_serial_number" id="cs_serial_number" class="form-control" required>
	          		</div>
	          	</div>
	          </div>
	          <div class="form-group">
	            <label for="cs_official_notes" class="col-form-label">Official Notes</label>
	            <textarea class="form-control" required id="cs_official_notes"></textarea>
	          </div>
	           <div class="modal-footer row">
	           	<div class="col-xl-12">
	           		<button type="button" class="btn btn-danger float-left btn_reg_root_delete_action" data-action_type='certificate' >Delete</button>
	           		<div class="float-right">
	    	       		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				        <button type="submit" id="btn_certificate_section" class="btn btn-primary">Save Changes</button>
	           		</div>	
	           	</div>
	           	
		        </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>


	<!-- Reservation Section============================= -->
	<div class="modal fade" id="newReservationModal" tabindex="-1" role="dialog" aria-labelledby="newReservationModalLabel" aria-hidden="true">
		<div class="modal-dialog">
		  <div class="modal-content">
			<div class="modal-header">
			  <h5 class="modal-title" id="newReservationModalLabel">Reservation Section</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<div class="modal-body">
			  <form id="form_add_reservation">
			  
				  <input  id="rs_id" name="rs_id" type="hidden" value="0" >
				  <!-- <input id="request_type" name="request_type" type="hidden" value="select_lrd_certificate_section_add_and_update">
				   -->
				  
				<div class="row">
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div class="form-group">
						  <label for="case_number" class="col-form-label">Case Number</label>
						  <input type="text" name="rs_case_number" id="rs_case_number" class="form-control" required value="${case_number}" readonly>
						</div>
						<!-- <div class="form-group">
						  <label for="cs_date_of_registration" class="col-form-label">Date of Issue</label>
						  <input type="date" name="cs_date_of_registration" id="cs_date_of_registration" class="form-control" required>
						</div> -->
					</div>
				</div>
				<div class="form-group">
				  <label for="cs_official_notes" class="col-form-label">Reservation Description</label>
				  <textarea class="form-control" rows="10" required id="rs_reservation_description"></textarea>
				</div>
				 <div class="modal-footer row">
					 <div class="col-xl-12">
						 <!-- <button type="button" class="btn btn-danger float-left btn_reg_root_delete_action" data-action_type='certificate' >Delete</button> -->
						 <div class="float-right">
							 <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						  <button type="submit" id="btn_reservation_section" class="btn btn-primary">Save Changes</button>
						 </div>	
					 </div>
					 
				  </div>
			  </form>
			</div>
		  </div>
		</div>
	  </div>
 
<!-- Encumberances Section============================= -->
	<div class="modal fade" id="newEncumberancesModal" tabindex="-1" role="dialog" aria-labelledby="newEncumberancesModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="newEncumberancesModalLabel">Encumberances Section</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form id="form_add_encumbrances" >
	        
	        	<input id="es_id" name="es_id" type="hidden" value="0">
	        	<input id="action_on_form_encumbrances" name="action_on_form_encumbrances" type="hidden">
	        	
	        	
	          <div class="row">
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          	
					  <div class="form-group">
	            		<label for="es_case_number" class="col-form-label">Case Number</label>
	            		<input type="text" name="es_case_number" id="es_case_number" class="form-control" required readonly value="${case_number}">
	          		</div>

					  <div class="form-group">
	            		<label for="es_registered_number" class="col-form-label">Registered Number</label>
	            		<input type="text" name="es_registered_number" id="es_registered_number" class="form-control" required>
	          		</div>
	          		<div class="form-group">
	            		<label for="es_date_of_registration" class="col-form-label">Date of Registration</label>
	            		<input type="date" name="es_date_of_registration" id="es_date_of_registration" class="form-control" required>
	          		</div>
	          		<div class="form-group">
	            		<label for="es_date_of_instrument" class="col-form-label">Date of Instrument</label>
	            		<input type="date" name="es_date_of_instrument" id="es_date_of_instrument" class="form-control" required>
	          		</div>
	          		<div class="form-group">
	            		<label for="es_memorials" class="col-form-label">Memorials</label>
	            		<textarea type="text" name="es_memorials" id="es_memorials" class="form-control" required></textarea>
	          		</div>
	          		<div class="form-group">
	            		<label for="es_back" class="col-form-label">Entry No.</label>
	            		<!-- <textarea name="es_back" id="es_entry_number" class="form-control" required></textarea> -->
						<input type="text" name="es_entry_number" id="es_entry_number" class="form-control" required>
	          		</div>
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
					<div class="form-group">
					  <label for="es_back" class="col-form-label">Back</label>
					  <textarea name="es_back" id="es_back" class="form-control" required></textarea>
					</div>
	          		<div class="form-group">
	            		<label for="es_forward" class="col-form-label">Forward</label>
	            		<textarea name="es_forward" id="es_forward" class="form-control" required></textarea>
	          		</div>
	          		<div class="form-group">
	            		<label for="es_remarks" class="col-form-label">Remarks</label>
	            		<textarea name="es_remarks" id="es_remarks" class="form-control" required></textarea>
	          		</div>
	          		<div class="form-group">
	            		<label for="cs_serial_number" class="col-form-label">Signaure</label>
	            		<textarea name="es_signature" id="es_signature" class="form-control" required></textarea>
	          		</div>
	          	</div>
	          </div>
	          <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="submit" id="btn_encumberances_section" class="btn btn-primary">Save Changes</button>
		      </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>

	
	<div class="modal fade" id="newEncumberancesOnMotherModal" tabindex="-1" role="dialog" aria-labelledby="newEncumberancesModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
		  <div class="modal-content">
			<div class="modal-header">
			  <h5 class="modal-title" id="newEncumberancesModalLabel">Encumberances Section</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<div class="modal-body">
			  <form id="form_add_encumbrances_on_mother" >
			  
				  <input id="m_es_id" name="es_id" type="hidden" value="0">
				  <input id="m_action_on_form_encumbrances" name="action_on_form_encumbrances" type="hidden">
				  
				  
				<div class="row">
					<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
						<c:forEach items="${mother_to_child_link_list}" var="mother_to_child_link_row">
						<div class="form-group">
						  <label for="es_case_number" class="col-form-label">Case Number</label>
						  <input type="text" name="es_case_number" id="m_es_case_number" class="form-control" required readonly value="${mother_to_child_link_row.mc_case_number}">
						</div>
					</c:forEach>
						<div class="form-group">
						  <label for="es_registered_number" class="col-form-label">Registered Number</label>
						  <input type="text" name="es_registered_number" id="m_es_registered_number" class="form-control" required>
						</div>
						<div class="form-group">
						  <label for="es_date_of_registration" class="col-form-label">Date of Registration</label>
						  <input type="date" name="es_date_of_registration" id="m_es_date_of_registration" class="form-control" required>
						</div>
						<div class="form-group">
						  <label for="es_date_of_instrument" class="col-form-label">Date of Instrument</label>
						  <input type="date" name="es_date_of_instrument" id="m_es_date_of_instrument" class="form-control" required>
						</div>
						<div class="form-group">
						  <label for="es_memorials" class="col-form-label">Memorials</label>
						  <textarea type="text" name="es_memorials" id="m_es_memorials" class="form-control" required></textarea>
						</div>
						<div class="form-group">
						  <label for="es_back" class="col-form-label">Entry No.</label>
						  <!-- <textarea name="es_back" id="es_entry_number" class="form-control" required></textarea> -->
						  <input type="text" name="es_entry_number" id="m_es_entry_number" class="form-control" required>
						</div>
					</div>
					<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
					  <div class="form-group">
						<label for="es_back" class="col-form-label">Back</label>
						<textarea name="es_back" id="m_es_back" class="form-control" required></textarea>
					  </div>
						<div class="form-group">
						  <label for="es_forward" class="col-form-label">Forward</label>
						  <textarea name="es_forward" id="m_es_forward" class="form-control" required></textarea>
						</div>
						<div class="form-group">
						  <label for="es_remarks" class="col-form-label">Remarks</label>
						  <textarea name="es_remarks" id="m_es_remarks" class="form-control" required></textarea>
						</div>
						<div class="form-group">
						  <label for="cs_serial_number" class="col-form-label">Signaure</label>
						  <textarea name="es_signature" id="m_es_signature" class="form-control" required></textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer">
				  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				  <button type="submit" id="btn_mother_encumberances_section" class="btn btn-primary">Save Changes</button>
				</div>
			  </form>
			</div>
		  </div>
		</div>
	  </div>
<!-- Memorials Section============================= -->
	<div class="modal fade" id="newMemorialsModal" tabindex="-1" role="dialog" aria-labelledby="newMemorialsModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="newMemorialsModalLabel">Memorials Section</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form id="form_add_memorials" >
	        
	        	<input  id="mid" name="mid" type="hidden" value="0" >
	        	<!-- <input id="request_type" name="request_type" type="hidden" value="select_lrd_memorials_section_add_and_update">
	        	 -->
	        	
	        	
	          <div class="row">
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="m_case_number" class="col-form-label">Case Number</label>
	            		<input type="text" name="m_case_number" id="m_case_number" value="${case_number}" class="form-control" readonly >
	          		</div>
	          		<div class="form-group">
	            		<label for="m_registered" class="col-form-label">Registered No.</label>
	            		<input type="text" name="m_registered_no" id="m_registered_no" class="form-control"value="${registered_number}" required>
	          		</div>
	          		<div class="form-group">
	            		<label for="m_memorials" class="col-form-label">Memorials</label>
	            		
	            		<textarea name="m_memorials" id="m_memorials" class="form-control" required>Subject to the reservations, exceptions, restrictions, restrictive covenants and conditions contained or referred to in a lease (a true copy of which is annexed hereto) made between (Grantor_Here) of the one part and ${ar_name} of the other part. 
	            		</textarea>
	          		</div>
	          		<div class="form-group">
	            		<label for="m_date_of_registration" class="col-form-label">Date of Instrument</label>
	            		<input type="date" name="m_date_of_instrument" id="m_date_of_instrument" class="form-control" required>
	          		</div>
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="m_date_of_registration" class="col-form-label">Date of Registration</label>
	            		<input type="date" name="m_date_of_registration" id="m_date_of_registration" class="form-control" required>
	          		</div>

					  <div class="form-group">
	            		<label for="m_date_of_registration" class="col-form-label">Entry Number</label>
	            		<input type="text" name="m_entry_number" id="m_entry_number" class="form-control" required>
	          		</div>
	          		<!-- <div class="form-group">
	            		<label for="m_back" class="col-form-label">Back</label>
	            		<textarea name="m_back" id="m_back" class="form-control" required></textarea>
	          		</div>
	          		<div class="form-group">
	            		<label for="m_forward" class="col-form-label">Forward</label>
	            		<textarea name="m_forward" id="m_forward" class="form-control" required></textarea>
	          		</div> -->
	          		<div class="form-group">
	            		<label for="m_remarks" class="col-form-label">Remarks</label>
	            		<textarea name="m_remarks" id="m_remarks" class="form-control" required></textarea>
	          		</div>
	          	</div>
	          </div>
	          <div class="modal-footer row">
	          	<div class="col-xl-12">
	          	<button type="button" class="btn btn-danger float-left btn_reg_root_delete_action" data-action_type='memorials' >Delete</button>
		          		<div class="float-right">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				        <button type="submit" id="btn_memorials" class="btn btn-primary">Save Changes</button>
				        </div>
		        </div>
	            </div>
	        </form>
	      </div>
	      
	    </div>
	  </div>
	</div>


	<div class="modal fade" id="newMemorialsMDModal" tabindex="-1" role="dialog" aria-labelledby="newMemorialsModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
		  <div class="modal-content">
			<div class="modal-header">
			  <h5 class="modal-title" id="newMemorialsModalLabel">Memorials Section</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<div class="modal-body">
			  <form id="form_add_memorials_MD" >
			  
				  <input  id="mid_MD" name="mid_MD" type="hidden" value="0" >
				  <!-- <input id="request_type" name="request_type" type="hidden" value="select_lrd_memorials_section_add_and_update">
				   -->
				  
				  
				<div class="row">
					<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
						<div class="form-group">
						  <label for="m_case_number" class="col-form-label">Case Number</label>
						  <input type="text" name="m_case_number_MD" id="m_case_number_MD" value="${case_number}" class="form-control" readonly >
						</div>
						<div class="form-group">
						  <label for="m_registered" class="col-form-label">Registered No.</label>
						  <input type="text" name="m_registered_no_MD" id="m_registered_no_MD" class="form-control"value="${registered_number}" required>
						</div>
						<div class="form-group">
						  <label for="m_memorials" class="col-form-label">Memorials</label>
						  
						  <textarea name="m_memorials_MD" id="m_memorials_MD" class="form-control" required>Mortgage to ${ar_name} to secure [LOAN AMOUNT] and the interest thereon. 
						  </textarea>
						</div>
						<div class="form-group">
						  <label for="m_date_of_registration" class="col-form-label">Date of Instrument</label>
						  <input type="date" name="m_date_of_instrument_MD" id="m_date_of_instrument_MD" class="form-control" required>
						</div>
					</div>
					<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
						<div class="form-group">
						  <label for="m_date_of_registration" class="col-form-label">Date of Registration</label>
						  <input type="date" name="m_date_of_registration_MD" id="m_date_of_registration_MD" class="form-control" required>
						</div>
						<div class="form-group">
							<label for="m_date_of_registration" class="col-form-label">Entry Number</label>
							<input type="text" name="m_entry_number" id="m_entry_number" class="form-control" required>
						  </div>
						<!-- <div class="form-group">
						  <label for="m_back" class="col-form-label">Back</label>
						  <textarea name="m_back" id="m_back" class="form-control" required></textarea>
						</div>
						<div class="form-group">
						  <label for="m_forward" class="col-form-label">Forward</label>
						  <textarea name="m_forward" id="m_forward" class="form-control" required></textarea>
						</div> -->
						<div class="form-group">
						  <label for="m_remarks" class="col-form-label">Remarks</label>
						  <textarea name="m_remarks_MD" id="m_remarks_MD" class="form-control" required></textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer row">
					<div class="col-xl-12">
					<button type="button" class="btn btn-danger float-left btn_reg_root_delete_action" data-action_type='memorials' >Delete</button>
							<div class="float-right">
						  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						  <button type="submit" id="btn_memorials" class="btn btn-primary">Save Changes</button>
						  </div>
				  </div>
				  </div>
			  </form>
			</div>
			
		  </div>
		</div>
	  </div>
	<!-- Proprietorship Section============================= -->
	<div class="modal fade" id="newProprietorshipModal" tabindex="-1" role="dialog" aria-labelledby="newProprietorshipModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="newProprietorshipModalLabel">Proprietorship Section</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
		      <form  id="form_add_proprietory">
		      
	        	<input  id="ps_id" name="ps_id" type="hidden" value="0" >
	        	<!-- <input id="request_type" name="request_type" type="hidden" value="select_lrd_proprietorship_section_add_and_update">
	        	 -->
	        	
		          <div class="row">
		          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
		          		<div class="form-group">
		            		<label for="ps_case_number" class="col-form-label">Case Number</label>
		            		<input type="text" name="ps_case_number" id="ps_case_number" value="${case_number}" class="form-control" required readonly>
		    
		          		</div>
		          		
		          		      
				       
				            
		          		<div class="form-group">
		            		<label for=" ps_registration_number" class="col-form-label">Registered Number</label>
		            		<input type="text" name="ps_registration_number" id="ps_registration_number" class="form-control" value="${registered_number}" required>
		          		</div>
		          		<div class="form-group">
		            		<label for="ps_proprietor" class="col-form-label">Proprietor/Grantee</label>
		            		<input type="text" name="ps_proprietor" id="ps_proprietor" class="form-control" value="${ar_name}" required>
		          		</div>
		          		<div class="form-group">
		            		<label for="ps_date_of_instrument" class="col-form-label">Date of Instrument</label>
		            		<input type="date" data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy"name="ps_date_of_instrument" id="ps_date_of_instrument" class="form-control" required>
		          		</div>
		          		<div class="form-group">
		            		<label for="ps_nature_of_instrument" class="col-form-label">Nature of Instrument</label>
		            		<!-- <input type="text" name="ps_nature_of_instrument" id="ps_nature_of_instrument" class="form-control" required>
		          			 -->	
							<!-- <select name="ps_nature_of_instrument" id="ps_nature_of_instrument" data-live-search="true" data-none-results-text="I found no results" title="Please select fruit" class="form-control selectpicker">
		                        <option value="Select">-Select-</option>
		                         <option value="Lease">Lease</option>
		                        <option value="Conveyance">Conveyance</option>
		                        <option value="Mortgage">Mortgage</option>
		                         <option value="Gift">Gift</option>
		                        <option value="Sub-Lease">Sub-Lease</option>
		                        <option value="Surrender">Surrender</option>
		                          <option value="Vesting Assent">Vesting Assent</option>
		                         <option value="Certificate of Purchase issued by a court">Certificate of Purchase issued by a court</option>
		                         <option value="Certificate of purchase issued under the Borrowers and
Lenders Act, 2008 (Act 773)">Certificate of purchase issued under the Borrowers and
Lenders Act, 2008 (Act 773)</option>
		                         <option value="Power of Attorney">Power of Attorney</option>
		                         <option value="Caveat or a Restriction">Caveat or a Restriction</option>
		                          <option value="Statutory Declaration">Statutory Declaration</option>
		                         <option value="Court Judgment">Court Judgment</option>

		                      
		                     </select> -->
		                     <textarea id="ps_nature_of_instrument" name="ps_nature_of_instrument" class="form-control" required></textarea>
		          		</div>
		          		<div class="form-group">
		            		<label for="ps_date_of_registration" class="col-form-label">Date of Registration</label>
		            		<input type="date" name="ps_date_of_registration" id="ps_date_of_registration" class="form-control" required>
		            	
		          		</div>
						  <div class="form-group">
		            		<label for="m_remarks" class="col-form-label">Term</label>
		            		<input type="text" name="ps_term" id="ps_term" class="form-control" required>
		          		</div>
		          	</div>
		          	
		          	
		          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
		          		<div class="form-group">
		            		<label for="ps_transferor" class="col-form-label">Grantor</label>
		            		<textarea name="ps_transferor" id="ps_transferor" class="form-control" required rows=4></textarea>
		          		</div>
		          		<div class="form-group">
		            		<label for="ps_transferee" class="col-form-label">Grantee</label>
		            		<textarea name="ps_transferee" id="ps_transferee" class="form-control"  required  rows=4>value="${ar_name}"</textarea>
		          		</div>
		          		<div class="form-group">
		            		<label for="m_remarks" class="col-form-label">Price Paid</label>
		            		<input type="text" name="ps_price_paid" id="ps_price_paid" class="form-control" required>
		          		</div>
		          		<div class="form-group">
		            		<label for="ps_remarks" class="col-form-label">Remarks</label>
		            		<textarea name="ps_remarks" id="ps_remarks" class="form-control" required></textarea>
		          		</div>
		          		 <div class="form-group">
		            		<label for="ps_signature" class="col-form-label">Signed By</label>
		            		<textarea name="ps_signature" id="ps_signature" class="form-control" required></textarea>
		          		</div> 
		          	</div>
		          </div>
		          <div class="modal-footer row">
		          	<div class="col-xl-12">
			          	<button type="button" class="btn btn-danger float-left btn_reg_root_delete_action" data-action_type='proprietor' >Delete</button>
		          		<div class="float-right">
		          			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        		<button type="submit" id="btn_proprietorship" class="btn btn-primary">Save Changes</button>		
		          		</div>
			          		        
		          	</div>
			       
		            </div>
		        </form>
	      </div>
	      </div>
	    </div>
	  </div>
	  
	   <!-- Valuation Section============================= -->
	<div class="modal fade" id="newValuationModal" tabindex="-1" role="dialog" aria-labelledby="newValuationModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="newValuationModalLabel">Valuation Section</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form id="form_add_valuation" >
	        
	        <input  id="vs_id" name="vs_id" type="hidden" value="0">
	        	<div class="row">
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="query_case_number" class="col-form-label">Case Number</label>
	            		<input type="text" name="vs_case_number" id="vs_case_number" value="${case_number}" class="form-control" required readonly>
	          		</div>
	          		<div class="form-group">
	            		<label for="vs_date_of_valuation" class="col-form-label">Date of Valuation</label>
	            		<input type="date" name="vs_date_of_valuation" id="vs_date_of_valuation" class="form-control" required>
	          		</div>
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="vs_amount" class="col-form-label">Amount</label>
	            		<input type="number" name="vs_amount" id="vs_amount" class="form-control" required>
	          		</div>
	          		<div class="form-group">
	            		<label for="vs_remarks" class="col-form-label">Remarks</label>
	            		<textarea name="vs_remarks" id="vs_remarks" class="form-control" required></textarea>
	          		</div>
	          	</div>
	          </div>
	           <div class="modal-footer row">
	           	<div class="col-xl-12">
	           		<button type="button" class="btn btn-danger float-left btn_reg_root_delete_action" data-action_type='valuation' >Delete</button>
		          	<div class="float-right">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				        <button type="submit" id="btn_valution_section" class="btn btn-primary">Save Changes</button>
				    </div>
		        </div>
		      </div>
		      
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
 
 
 



<!-- 
<div class="modal fade" id="transitional_certificate_template" role="dialog"
>
	<div class="modal-dialog">
		<div class="modal-content">

			Header
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading"></h4>
			</div>



			 Body Start
			<div class="modal-body">


											
							<div class="form-group">
							<div class="form-row">
								<div class="col">
									<label for="pvlmd_reference_number">GLPIN Number</label> <input
										class="form-control " type="text"
										placeholder="" id="lrd_glpin"
									readonly>
								</div>
	
							</div>
						</div>
												
												
					<div class="row">
					         <h2>Demo</h2>
				      <form method="post" class="summernote">
				        <textarea id="my-summernote" name="editordata"></textarea>
				      </form>
				     
					</div>
			
			</div>

			Body End



			Footer
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
				
				<button class="btn btn-primary btn-block" id="btn_generate_transitional_certificate">
					<span class="text" >Save</span>
			</button>
				
			</div>

		</div>
	</div>
</div>

 -->





<div class="modal fade" id="frmlrdtitleplanupdatemodal" role="dialog"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<!-- <button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button> -->
				<h4 class="modal-title custom_align" id="Heading">Title Plan Update</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>



			<!--  Body Start -->
			<div class="modal-body">
         <input  id="gid_pl" name="gid_pl" type="hidden" value="0" >
         <input  id="lc_txt_transaction_number_pl" name="lc_txt_transaction_number_pl" type="hidden" value="0" >

						<div class="form-row">
						
						 <div class="col-md-4">
				                <label for="search_value">District</label>
								   <input  class="form-control" id="txt_lc_registration_district_number_pl"  name="txt_lc_registration_district_number_pl"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Section</label>
								   <input  class="form-control" id="txt_lc_registration_section_number_pl"  name="txt_lc_registration_district_number_pl"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                 <div class="col-md-4">
				                <label for="search_value">Block</label>
								   <input  class="form-control" id="txt_lc_registration_block_number_pl"  name="txt_lc_registration_district_number_pl"  type="text"  value="${glpin}" >
        													
				                </div>
						
						</div>							
									
									
									
													<div class="form-row">
						
						 <div class="col-md-4">
				                <label for="search_value">Plan Number</label>
								   <input  class="form-control" id="txt_lc_plan_no_pl"  name="txt_lc_plan_no_pl"  type="text"  value="" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">LTR Plan Number</label>
								   <input  class="form-control" id="ltr_plan_no_pl"  name="ltr_plan_no_pl"  type="text"  value="" >
        													
				                </div>
				                
				                 <div class="col-md-4">
				                <label for="search_value">Registry Map Ref</label>
								   <input  class="form-control" id="txt_lc_registry_mapref_pl"  name="txt_lc_registry_mapref_pl"  type="text"  value="" >
        													
				                </div>
						
						</div>			
						
						
						
						<div class="form-row">
						
						 <div class="col-md-4">
				                <label for="search_value">Certificate Number</label>
								   <input  class="form-control" id="lc_txt_certificate_number_pl"  name="lc_txt_certificate_number_pl"  type="text"  value="" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Volume Number</label>
								   <input  class="form-control" id="lc_txt_volume_number_pl"  name="lc_txt_volume_number_pl"  type="text"  value="" >
        													
				                </div>
				                
				                 <div class="col-md-4">
				                <label for="search_value">Folio Number</label>
								   <input  class="form-control" id="lc_txt_folio_number_pl"  name="lc_txt_folio_number_pl"  type="text"  value="" >
        													
				                </div>
						
						</div>							
								
						<div class="form-row">
						
						 <div class="col-md-4">
				                <label for="search_value">GLPIN</label>
								   <input readonly class="form-control" id="txt_glpin_pl"  name="txt_glpin_pl"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Size of Land</label>
								   <input readonly class="form-control" id="txt_lc_size_of_land_pl"  name="txt_lc_size_of_land_pl"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                 
						
						</div>							
								
									
									
									
							

										
								

				



			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
				
				<button class="btn btn-primary btn-block" id="btn_save_lrd_title_plan_update_details">
					<span class="text" >Save</span>
			</button>
				
			</div>

		</div>
	</div>
</div>


<div class="modal fade" id="frmlrdtitlehardcopyplanupdatemodal" role="dialog"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Title Plan Update</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>



			<!--  Body Start -->
			<div class="modal-body">
         <input  id="gid_uhp" name="gid_uhp" type="hidden" value="0" >
         <input  id="lc_txt_transaction_number_uhp" name="lc_txt_transaction_number_uhp" type="hidden" value="0" >

						<div class="form-row">
						
						 <div class="col-md-4">
				                <label for="search_value">Registration District</label>
								   <input  class="form-control" id="txt_lc_registration_district_number_uhp"  name="txt_lc_registration_district_number_uhp"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Section Number</label>
								   <input  class="form-control" id="txt_lc_registration_section_number_uhp"  name="txt_lc_registration_district_number_uhp"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                 <div class="col-md-4">
				                <label for="search_value">Block Number</label>
								   <input  class="form-control" id="txt_lc_registration_block_number_uhp"  name="txt_lc_registration_district_number_uhp"  type="text"  value="${glpin}" >
        													
				                </div>
						
						</div>							
									
									
									
													<div class="form-row mt-3">
						
						 <div class="col-md-4">
				                <label for="search_value">Plan Number</label>
								   <input  class="form-control" id="txt_lc_plan_no_uhp"  name="txt_lc_plan_no_uhp"  type="text"  value="" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">LTR Plan Number</label>
								   <input  class="form-control" id="ltr_plan_no_uhp"  name="ltr_plan_no_uhp"  type="text"  value="" >
        													
				                </div>
				                
				                 <div class="col-md-4">
				                <label for="search_value">Registry Map Ref</label>
								   <input  class="form-control" id="txt_lc_registry_mapref_uhp"  name="txt_lc_registry_mapref_uhp"  type="text"  value="" >
        													
				                </div>
						
						</div>			
						
						
						
						<!-- <div class="form-row">
						
						 <div class="col-md-4">
				                <label for="search_value">Certificate Number</label>
								   <input  class="form-control" id="lc_txt_certificate_number_pl"  name="lc_txt_certificate_number_pl"  type="text"  value="" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Volume Number</label>
								   <input  class="form-control" id="lc_txt_volume_number_pl"  name="lc_txt_volume_number_pl"  type="text"  value="" >
        													
				                </div>
				                
				                 <div class="col-md-4">
				                <label for="search_value">Folio Number</label>
								   <input  class="form-control" id="lc_txt_folio_number_pl"  name="lc_txt_folio_number_pl"  type="text"  value="" >
        													
				                </div>
						
						</div>							 -->
								
												<div class="form-row mt-3">
				                
												<div class="col-md-4">
											   <label for="search_value">CC Number</label>
												  <input  class="form-control" id="cs_main_cc_no_uhp"  name="cs_main_cc_no_uhp"  type="text"  value="" >
																		   
											   </div>
						
						 <div class="col-md-4">
				                <label for="search_value">GLPIN</label>
								   <input readonly class="form-control" id="txt_glpin_uhp"  name="txt_glpin_uhp"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Size of Land</label>
								   <input class="form-control" id="txt_lc_size_of_land_uhp"  name="txt_lc_size_of_land_uhp"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                 
						
						</div>							
							

			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
				
				<button class="btn btn-primary btn-block" id="btn_save_lrd_title_hardcopy_plan_update_details">
					<span class="text" >Save</span>
			</button>
				
			</div>

		</div>
	</div>
</div>


<div class="modal fade" id="frmlrdtitlemecdplanupdatemodal" role="dialog"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Certificate Details Update</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">
         <input  id="gid_mecd" name="gid_mecd" type="hidden" value="0" >
         <input  id="lc_txt_transaction_number_mecd" name="lc_txt_transaction_number_mecd" type="hidden" value="0" >

						<!-- <div class="form-row">
						
						 <div class="col-md-4">
				                <label for="search_value">District</label>
								   <input  class="form-control" id="txt_lc_registration_district_number_mecd"  name="txt_lc_registration_district_number_mecd"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Section</label>
								   <input  class="form-control" id="txt_lc_registration_section_number_mecd"  name="txt_lc_registration_district_number_mecd"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                 <div class="col-md-4">
				                <label for="search_value">Block</label>
								   <input  class="form-control" id="txt_lc_registration_block_number_mecd"  name="txt_lc_registration_district_number_mecd"  type="text"  value="${glpin}" >
        													
				                </div>
						
						</div>							
									
									
									
													<div class="form-row">
						
						 <div class="col-md-4">
				                <label for="search_value">Plan Number</label>
								   <input  class="form-control" id="txt_lc_plan_no_mecd"  name="txt_lc_plan_no_mecd"  type="text"  value="" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">LTR Plan Number</label>
								   <input  class="form-control" id="ltr_plan_no_mecd"  name="ltr_plan_no_mecd"  type="text"  value="" >
        													
				                </div>
				                
				                 <div class="col-md-4">
				                <label for="search_value">Registry Map Ref</label>
								   <input  class="form-control" id="txt_lc_registry_mapref_mecd"  name="txt_lc_registry_mapref_mecd"  type="text"  value="" >
        													
				                </div>
						
						</div>			 -->
						
						
						
						<div class="form-row">
						
						 <div class="col-md-4">
				                <label for="search_value">Certificate Number</label>
								   <input  class="form-control" id="lc_txt_certificate_number_mecd"  name="lc_txt_certificate_number_mecd"  type="text"  value="" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Volume Number</label>
								   <input  class="form-control" id="lc_txt_volume_number_mecd"  name="lc_txt_volume_number_mecd"  type="text"  value="" >
        													
				                </div>
				                
				                 <div class="col-md-4">
				                <label for="search_value">Folio Number</label>
								   <input  class="form-control" id="lc_txt_folio_number_mecd"  name="lc_txt_folio_number_mecd"  type="text"  value="" >
        													
				                </div>
						
						</div>							
								
												<div class="form-row mt-3">
													<div class="col-md-4">
														<label for="job_number">Certificte Type</label>
													  <select name="lc_txt_type_of_certificate_mecd" id="lc_txt_type_of_certificate_mecd" class="form-control input-sm" data-style="btn-info" required data-live-search="true">
														  <option value="-1">-- select --</option>
														  <option value="Provisional Certificate">Provisional Certificate</option>
														  <option value="Land Certificate">Land Certificate</option>
														  <option value="Substituted Certificate">Substituted Certificate</option>
													  </select> 
	  
														</div>
						
						 <div class="col-md-4">
				                <label for="search_value">GLPIN</label>
								   <input readonly class="form-control" id="txt_glpin_mecd"  name="txt_glpin_mecd"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Size of Land</label>
								   <input class="form-control" id="txt_lc_size_of_land_mecd"  name="txt_lc_size_of_land_mecd"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                 
						
						</div>							
							

			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
				
				<button class="btn btn-primary btn-block" id="btn_save_lrd_title_mecd_plan_update_details">
					<span class="text" >Save</span>
			</button>
				
			</div>

		</div>
	</div>
</div>


<div class="modal fade" id="frmlrdtitleplanupdatemodal_smd" role="dialog"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Title Plan Update SMD</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">
        
				<input  id="gid_pl_smd" name="gid_pl_smd" type="hidden" value="0" >
                <input  id="lc_txt_transaction_number_pl_smd" name="lc_txt_transaction_number_pl_smd" type="hidden" value="0" >

						<div class="form-row">
						
						 <div class="col-md-4">
				                <label for="search_value">District</label>
								   <input  class="form-control" id="txt_lc_registration_district_number_pl_smd"  name="txt_lc_registration_district_number_pl_smd"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Section</label>
								   <input  class="form-control" id="txt_lc_registration_section_number_pl_smd"  name="txt_lc_registration_district_number_pl_smd"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                 <div class="col-md-4">
				                <label for="search_value">Block</label>
								   <input  class="form-control" id="txt_lc_registration_block_number_pl_smd"  name="txt_lc_registration_district_number_pl_smd"  type="text"  value="${glpin}" >
        													
				                </div>
						
						</div>							
									
									
									
						<div class="form-row">
						
						 <div class="col-md-4">
				                <label for="search_value">Plan Number</label>
								   <input  class="form-control" id="txt_lc_plan_no_pl_smd"  name="txt_lc_plan_no_pl_smd"  type="text"  value="" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">LTR Plan Number</label>
								   <input  class="form-control" id="ltr_plan_no_pl_smd"  name="ltr_plan_no_pl_smd"  type="text"  value="" >
        													
				                </div>
				                
				                 <div class="col-md-4">
				                <label for="search_value">Registry Map Ref</label>
								   <input  class="form-control" id="txt_lc_registry_mapref_pl_smd"  name="txt_lc_registry_mapref_pl_smd"  type="text"  value="" >
        													
				                </div>
						
						</div>			
						
						
						
												
								
							<div class="form-row">
						
						 <div class="col-md-4">
				                <label for="search_value">GLPIN</label>
								   <input readonly class="form-control" id="txt_glpin_pl_smd"  name="txt_glpin_pl_smd"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Size of Land</label>
								   <input readonly class="form-control" id="txt_lc_size_of_land_pl_smd"  name="txt_lc_size_of_land_pl_smd"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                 
						
						</div>							
								
									
									
									
							

										
								

				



			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
				
				<button class="btn btn-primary btn-block" id="btn_save_lrd_title_plan_update_details_smd">
					<span class="text" >Save</span>
				</button>
				
			</div>

		</div>
	</div>
</div>




<div class="modal fade" id="frmlrdgeneratelsnumberdeedsmodal" role="dialog"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Generation of LS AND Deed Numbers</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">
         <input  id="gid_pl" name="gid_pl" type="hidden" value="0" >
         <input  id="lc_txt_transaction_number_pl" name="lc_txt_transaction_number_pl" type="hidden" value="0" >

						<div class="form-row">
						
						 <div class="col-md-6">
				                <label for="search_value">case Number</label>
								   <input  class="form-control" id="txt_lc_case_number_gld"  name="txt_lc_registration_district_number_pl"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-6">
				                <label for="search_value">Job Number</label>
								   <input  class="form-control" id="txt_lc_job_number_gld"  name="txt_lc_registration_district_number_pl"  type="text"  value="${glpin}" >
        													
				                </div>
				                
				                
						
						</div>							
									
									
									
						<div class="form-row">
						
						 <div class="col-md-12">
				                <label for="search_value">Applicant Name</label>
								   <input  class="form-control" id="txt_lc_ar_name_gld"  name="txt_lc_plan_no_pl"  type="text"  value="" >
        													
				                </div>
				                
				                
				                
						
						</div>			
						
						
						
						<div class="form-row">
						
						 <div class="col-md-6">
				                <label for="search_value">Deeds Number</label>
								   <input  class="form-control" id="lc_txt_certificate_number_gld"  name="lc_txt_certificate_number_pl"  type="text"  value="" >
        													
				                </div>
				                
				                
				                 <div class="col-md-6">
				                <label for="search_value">LS Number</label>
								   <input  class="form-control" id="lc_txt_plot_number_gld"  name="lc_txt_volume_number_pl"  type="text"  value="" >
        													
				                </div>
				                
				                
						
						</div>							
								

			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
				
				<button class="btn btn-primary btn-block" id="btn_save_generate_lc_number_deeds_number_gld">
					<span class="text" >Generate</span>
			</button>
				
			</div>

		</div>
	</div>
</div>



<!-- Memorials Section============================= -->
	<div class="modal fade" id="lrdpEncumbranceModal" tabindex="-1" role="dialog" aria-labelledby="lrdpEncumbranceModalModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="lrdpEncumbranceModalLabel">Memorials Section</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form id="" >
	        
	        	<input  id="lrdp_id" name="lrdp_id" type="hidden" value="0" >
	        	
	        	
	        	
	          <div class="row">
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="m_case_number" class="col-form-label">Ref Number</label>
	            		<input type="text" name="lrdp_ref_number" id="lrdp_ref_number" value="${case_number}" class="form-control" readonly >
	          		</div>
	          		<div class="form-group">
	            		<label for="m_registered" class="col-form-label">Registered</label>
	            		<input type="text" name="lrdp_registered" id="lrdp_registered" class="form-control" required>
	          		</div>
	          		<div class="form-group">
	            		<label for="lrdp_memorials" class="">Memorials</label>
	            		
	            		<textarea name="lrdp_memorials" id="lrdp_memorials" class="form-control" required></textarea>
	          		</div>
	          		<div class="form-group">
	            		<label for="lrdp_date_of_registration" class="col-form-label">Date of Instrument</label>
	            		<input type="date" name="lrdp_date_of_instrument" id="lrdp_date_of_instrument" class="form-control" required>
	          		</div>
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="m_date_of_registration" class="col-form-label">Date of Registration</label>
	            		<input type="date" name="lrdp_date_of_registration" id="lrdp_date_of_registration" class="form-control" required>
	          		</div>
	          		
	          		<div class="form-group">
	            		<label for="m_remarks" class="col-form-label">Remarks</label>
	            		<textarea name="lrdp_remarks" id="lrdp_remarks" class="form-control" required></textarea>
	          		</div>
	          	</div>
	          </div>
	          <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" id="btn_lrdp_save_encumbrance" class="btn btn-primary">Save Changes</button>
	            </div>
	        </form>
	      </div>
	      
	    </div>
	  </div>
	</div>
	
	
	   <!-- Certificate Section============================= -->
	<div class="modal fade" id="newTransferMothertoChildModal" tabindex="-1" role="dialog" aria-labelledby="newTransferMothertoChildModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="newTransferMothertoChildModalLabel">Transfer Mother to Child</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	       <!--  <form id="form_add_certificate"> -->
	        
	       <!--  	<input  id="cs_id" name="cs_id" type="hidden" value="0" >
 -->	        	<!-- <input id="request_type" name="request_type" type="hidden" value="select_lrd_certificate_section_add_and_update">
	        	 -->
	        	
	          <div class="row">
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="case_number" class="col-form-label">Mother Job Number</label>
	            		<input type="text" name="tmc_mc_job_number" id="tmc_mc_job_number" class="form-control" required>
	          		</div>
	          		<div class="form-group">
	            		<label for="tmc_job_number" class="col-form-label">Job Number</label>
	            		<input type="text" name="tmc_job_number" id="tmc_job_number" class="form-control" required readonly>
	          		</div>
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="tmc_transaction_number" class="col-form-label"> Transaction Number</label>
	            		<input type="text" name="tmc_transaction_number" id="tmc_transaction_number" class="form-control" required readonly>
	          		</div>
	          		<div class="form-group">
	            		<label for="tmc_case_number" class="col-form-label">Case Number</label>
	            		<input type="text" name="tmc_case_number" id="tmc_case_number" class="form-control" required readonly>
	          		</div>
	          	</div>
	          </div>
	        
	           <div class="modal-footer row">
	           	<div class="col-xl-12">
	           		
	           		<div class="float-right">
	    	       		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				        <button type="submit" id="btn_copy_mother_file_transaction_to_child" class="btn btn-primary">Transfer Mother Details to Child</button>
	           		</div>	
	           	</div>
	           	
		        </div>
	       <!--  </form> -->
	      </div>
	    </div>
	  </div>
	</div>

 

