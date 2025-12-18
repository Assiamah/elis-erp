<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>


<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


   <jsp:include page="../client_application/_application_process_header.jsp"></jsp:include>

          
					          

        <!-- SmartWizard html -->
        <div id="smartwizardfirstregistration">
            <ul class="d-none">
               
                 <!-- <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-1">Inspection<br /><small>Inspection</small></a></li> -->
                 <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-1">Assessment<br /><small>Assessment</small></a></li> 
          		 <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-2">Embossment after Payment<br /><small>Search Report Preparation</small></a></li>
          		
            </ul>

            <div>
            
             
                    
                  
      
                
                
                <div id="53ab3caa7e7d11ef98b51e576becd20e-1" class="">
                	<br>
                    <h3 class="border-bottom border-gray pb-2">Stamp Duty Assessment</h3>
                   	<div class="row">
                   	
                   	
                   	
                   	
				 <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-10">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Comparable Data</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				               <div id="alert-display-space">
				               </div>
				              <form action=""  method="post" id="form_comparable">
									
									
									 	<div class="form-group row">
								    		<label class="col-sm-4 col-form-label" style="text-align:right">Is the Land Developed ?</label>
								    		<div class="col">
								    			<div class="input-group">
								    				<div id="radioBtn" class="btn-group">
								    					<a class="btn btn-primary btn-sm notActive" data-toggle="land_state" data-title="Yes">YES</a>
								    					<a class="btn btn-primary btn-sm notActive" data-toggle="land_state" data-title="No">NO</a>
								    				</div>
								    				<input type="hidden" name="land_state" id="land_state">
								    			</div>
								    		</div>
								    	</div>
							    	
							    	
							    	
									
									
						          	<div id="alert-display-space1">
				               		</div>
									<div id="comparable_section_display"  style="display:none"> 
									  
									  <div class="form-group row">
									    <label for="assessed_value" class="col-sm-3 col-form-label" style="text-align:right">Locality/Land Size :</label>
									   
									    <div class="col-sm-5">
									    	 <div class="input-group mb-2">
										        <div class="input-group-prepend">
										        
										           <button type="button" name="btn_load_comparable_values" id="btn_load_comparable_values" class="btn btn-warning btn-icon-split"  >
									    			<span class="text">Load</span>
									    		</button>
									    		 
										        </div>
									       		 
									       		  <input  readonly class="form-control input-sm" id="new_comparable_locality"   type="text"   value="${locality}" >
									       		  <input  readonly class="form-control input-sm" id="new_comparable_size_of_land"   type="text"   value="${size_of_land}" > 
										      </div>
									    
									    
									    </div>
									    
									
									  </div>
									  
									  <div class="form-group row"> 
									    <label for="stamp_duty" class="col-sm-3 col-form-label" style="text-align:right">Max Value <span class="text-danger">*</span>:</label>
									    <div class="col-sm-5">
									    
									    <div class="input-group mb-2">
									        <div class="input-group-prepend">
									          <div class="input-group-text">GHS</div>
									        </div>
									        <input    step="0.1" type="number" id="txt_comp_max_value" name="txt_comp_max_value" class=" form-control  " required placeholder="Max Value">
									      </div>
									      
									     
									    </div>
									  </div>
									  
									  <div class="form-group row"> 
									    <label for="stamp_duty" class="col-sm-3 col-form-label" style="text-align:right">Min Value <span class="text-danger">*</span>:</label>
									    <div class="col-sm-5">
									    
									    <div class="input-group mb-2">
									        <div class="input-group-prepend">
									          <div class="input-group-text">GHS</div>
									        </div>
									        <input   step="0.1" type="number" id="txt_comp_min_value" name="txt_comp_min_value" class=" form-control  " required placeholder="Min Vale">
									      </div>
									      
								
									<!--   <input type="range" class="custom-range" id="assesedvalueRange">  
									   -->
									  
									  
<!-- 									  <input type="range" class="form-control-range" id="assesedvalueRange">
 -->									  <br><br>
									  <div id="label" style='display:none'>Please slide !</div>
									  <div id="assesedvalueRange">
										  
									  </div>
									  
									  
									  
									  
									    </div>
									  </div>
									  
									</div>	  
										
						          
						        </form>
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
                   	

 						 <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-10">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Stamp Duty</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				               <div id="alert-display-space">
				               </div>
				              <form action=""  method="post" id="form_assessment">
									
									
						          	<div id="alert-display-space1">
				               		</div>
				               		
				               		<div class="form-group row bg-secondary text-light" >

										
										<div class="col-sm-6">
											<label for="adopted_value"  >Consideration <span class="text-danger">*</span>:</label>
											<div class="input-group mb-2">
												<div class="input-group-prepend">
													<div class="input-group-text">${consideration_fee_currency}</div>
												</div>
												<input value="${consideration_fee}" step="0.1" type="number" class=" form-control  " 
													required placeholder="Consideration Amount" readonly
												>
											</div>	
										</div>										
										
										<div class="col-sm-6">
											<label for="adopted_value" >Currency Conversion Rate Used <span class="text-danger">*</span>:</label>
											<div class="input-group mb-2">
												
												<input value="${considertion_fee_adopted_rate}" step="0.1" type="number" id="considertion_fee_adopted_rate"
													name="considertion_fee_adopted_rate" class=" form-control  " 
													required placeholder="Currency Adopted Rate" 
												>
											</div>
	
										</div>
									</div>
									<hr>
									   <div class="form-group row"> 
									  	
									    <label for="adopted_value" class="col-sm-4 col-form-label" style="text-align:right">Adopted Land Value /acre <span class="text-danger">*</span>:</label>
									    <div class="col-sm-5">
									    
									    <div class="input-group mb-2">
									        <div class="input-group-prepend">
									          <div class="input-group-text">GHS</div>
									        </div>
									        <input  value=""  step="0.1" type="text" id="adopted_value" name="adopted_value" class=" form-control  "  required placeholder="Adopted Value">
									      </div>
									      
									     
									    </div>
									  </div>
									  <div class="form-group row">
									    <label for="assessed_value" class="col-sm-4 col-form-label" style="text-align:right">Assessed Value <span class="text-danger">*</span>:</label>
									    <div class="col-sm-5">
									    	 <div class="input-group mb-2">
										        <div class="input-group-prepend">
										          <div class="input-group-text">GHS</div>
										        </div>
									       		<input value="${assessed_value}" step="0.1" type="text" name="assessed_value" id="assessed_value" class=" form-control  "  required placeholder="Assessed Value"> 
										      </div>
									    
									    
									    </div>
									  </div>
									  
									  <div class="form-group row"> 
									    <label for="stamp_duty" class="col-sm-4 col-form-label" style="text-align:right">Stamp Duty Payable <span class="text-danger">*</span>:</label>
									    <div class="col-sm-5">
									    
									    <div class="input-group mb-2">
									        <div class="input-group-prepend">
									          <div class="input-group-text">GHS</div>
									        </div>
									        <input  value="${stamp_duty_payable}"  step="0.1" type="text" id="stamp_duty" name="stamp_duty" class=" form-control  "  required placeholder="Stamp Duty Payable">
									      </div>
									      
									     
									    </div>
									  </div>
									  <div class="form-group row">
									    <label for="assessed_comment" class="col-sm-4 col-form-label " style="text-align:right">Comments <span class="text-danger">*</span>:</label>
									    <div class="col-sm-5">
									       <textarea  name="assessed_comment" id="assessed_comment" class=" form-control  "  >${stamp_duty_description}</textarea>
									    </div>
									  </div>
									  <div class="form-group row">
									  <label for="assessed_value" class="col-sm-5 col-form-label"> </label>
									    <div class="form-row ">
									    	<div class="col-sm-6">
									    		<button type="submit" name="submit_assessment" id="submit_assessment" class="btn  btn-primary btn-icon-split"  >
									    			<span class="icon text-white-50"> <i class="fas fa-check col-sm-12"></i></span><span class="text">Save</span>
									    		</button>
									    	</div>
									    	<div class="col-sm-6">
									    		<button type="button" name="submit_print_stamp_bill" id="submit_print_stamp_bill" class="btn  btn-warning btn-icon-split"  >
									    			<span class="icon text-white-50"> <i class="fas fa-print col-sm-12"></i></span><span class="text">Print</span>
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
                
                
                
                
                <div id="53ab3caa7e7d11ef98b51e576becd20e-2" class="">
                	<br>
                    <h3 class="border-bottom border-gray pb-2">Embossment after Payment</h3>
						          
						 <div class="row">
						 
						       <!--   Here is the right Table -->
						        <div class="col-lg-8">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i></div>
						            <div class="card-body">
						               <!--  The Form starts here -->
						              <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank" class="form-inline">
										<input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
										<input type="hidden" id="job_number" name="job_number" value="${job_number}" >
										<input type="hidden" id="request_type" name="request_type" value="request_to_generate_inspection_letter">
								          
								              
								              
								              	<input type="text"  class="form-control form-control-plaintext" id="staticEmail" value="Is document embossed?">
								                <button type="submit" name="submit_assessment" id="submit_assessment" class="btn  btn-primary btn-icon-split form-control"  >
									    			<span class="icon text-white-50"> <i class="fas fa-check col-sm-12"></i></span><span class="text">Yes</span>
									    		</button>
									    		
								             
								            
								        </form>
						            
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
							
          
            
          
       <jsp:include page="../client_application/_application_process_footer.jsp"></jsp:include>
 
  

