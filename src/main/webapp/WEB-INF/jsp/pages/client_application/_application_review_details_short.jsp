<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


   <jsp:include page="../client_application/_application_process_header_ar.jsp"></jsp:include>
					          
   <style>
    /* Ensure both modals are visible at the same time */
    .x-modal {
        z-index: 1050 !important;
    }
    .x-modal-backdrop.show {
        opacity: 0 !important; /* Hide the backdrop to allow interaction */
    }
</style>		      
							   <!-- wizard start wizard end -->
		
<%-- <DIV>TEST :${page_name}</DIV> --%>
        <!-- smartwizardfirstregistration html -->
        
            
               
              <!--   <li><a href="#step-1">Upload file at CSAU Back Office<br /><small>Upload file at CSAU Back Office</small></a></li> -->
                
                <!-- <li><a href="#step-3">Update As Undergoing Registration<br /><small>Update As Undergoing Registration</small></a></li> -->
              
              
               <!--  <li><a href="#step-2">File Created <br /><small>Generate LRD File Number</small></a></li> -->
               <!-- <h4 class="bg-success p-3">Coordinate Entry and Record Verification<br /></h4> -->
           
            
                <!-- <div id="step-1" class=""> -->
			                	<br>
			                    <!-- <h3 class="border-bottom border-gray pb-2">Records Information Search</h3>
			                     -->
			                    
			                    


                                 <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header h5">Application Process</div>
                                            <div class="card-body">
                                            
                                                <div class="tree">
                                                    <ul class="list-group">
                                                        <c:forEach var="mileStone" items="${baby_step_milestone_list}">
                                                            <!-- Milestone -->
                                                            <li class="list-group-item mb-3">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <span class="fs-5 fw-bold text-primary">
                                                                        ${mileStone.milestone_description}
                                                                    </span>
                                                                    <!-- Milestone Status Badge -->
                                                                    <c:choose>
                                                                        <c:when test="${mileStone.mile_stone_status == 'Pending'}">
                                                                            <span class="badge badge-danger">${mileStone.mile_stone_status}</span>
                                                                        </c:when>
                                                                        <c:when test="${mileStone.mile_stone_status == 'Ongoing'}">
                                                                            <span class="badge badge-warning">${mileStone.mile_stone_status}</span>
                                                                        </c:when>
                                                                        <c:when test="${mileStone.mile_stone_status == 'Completed'}">
                                                                            <span class="badge badge-success">${mileStone.mile_stone_status}</span>
                                                                        </c:when>
                                                                    </c:choose>
                                                                </div>
                                                
                                                                
                                                             <!-- Baby Steps -->
<ul class="mt-2 ps-3">
    <c:forEach var="babyStep" items="${mileStone.baby_steps}">
        <li class="d-flex flex-column mb-4">
            <!-- Baby Step Description and Status -->
            <div class="d-flex align-items-center">
                <div class="flex-grow-1">
                    <c:choose>
                        <c:when test="${babyStep.bse_status == 'Pending'}">
                            <span class="badge badge-danger">${babyStep.bse_status}</span>
                        </c:when>
                        <c:when test="${babyStep.bse_status == 'Ongoing'}">
                            <span class="badge badge-warning">${babyStep.bse_status}</span>
                        </c:when>
                        <c:when test="${babyStep.bse_status == 'Completed'}">
                            <span class="badge badge-success">${babyStep.bse_status}</span>
                        </c:when>
                    </c:choose>
                    <span class="ms-2">${babyStep.bse_description}</span>
                </div>
                
                <!-- Action Buttons -->
                <div class="btn-group ms-3">
                    <button 
                        class="btn btn-warning btn-sm text-white" 
                        data-toggle="modal" 
                        data-target="#${babyStep.bse_description_key}"
                        data-bs-id="${babyStep.bse_id}" 
                        data-bse-id="${babyStep.bse_id}" 
                        data-bs-desc="${babyStep.bse_description}" 
                        data-bs-username="${babyStep.username}" 
                        data-bs-date="${babyStep.date}" 
                        data-bs-time="${babyStep.time}"
                    >
                        View Details
                    </button>
                    <button 
                        class="btn btn-success btn-sm text-white" 
                        onclick="reviewStep(`${babyStep.bs_id}`,`${babyStep.bse_id}`,`${job_number}`)" 
                        <c:if test="${babyStep.bse_status == 'Pending' || babyStep.bse_status == 'Completed'}">disabled</c:if>
                    >
                        Approve
                    </button>
                    <button 
                        class="btn btn-primary btn-sm text-white" 
                        data-toggle="modal" 
                        data-job_number="${job_number}" 
                        data-ar_name="${ar_name}" 
                        data-business_process_sub_name="${business_process_sub_name}" 
                        data-locality="${locality}" 
                        data-target="#askForPurposeOfSendingRequest" 
                        data-bs-desc="${babyStep.bse_description}" 
                        id="btnAddRequest"
                        <c:if test="${babyStep.bse_status == 'Pending' || babyStep.bse_status == 'Completed'}">disabled</c:if>
                    >
                        Send Request
                    </button>
                    <button 
                        class="btn btn-danger btn-sm text-white" 
                        data-toggle="modal" 
                        data-job_number="${job_number}" 
                        data-ar_name="${ar_name}" 
                        data-business_process_sub_name="${business_process_sub_name}" 
                        data-locality="${locality}" 
                        data-target="#newQueryModal" 
                        <c:if test="${babyStep.bs_status == 'Pending' || babyStep.bs_status == 'Completed'}">disabled</c:if>
                    >
                        Query
                    </button>
                </div>
            </div>
            
            <!-- Additional Details -->
            <div class="text-muted ms-4 mt-1">
                <small>
                    <!-- <strong>Username:</strong> <c:out value="${babyStep.username}" default="N/A" /> |
                    <strong>Date:</strong> <c:out value="${babyStep.date}" default="N/A" /> | -->
                    <strong>Status:</strong> <c:out value="${babyStep.bse_status}" default="Not Approved" /> |
                    <strong>Start Date:</strong> <c:out value="${babyStep.start_date}" default="Not Sent" /> |
                    <strong>Approved By:</strong> <c:out value="${babyStep.completed_by}" default="N/A" /> |
                    <strong>Approved Date:</strong> <c:out value="${babyStep.complete_by_date}" default="Not Sent" />
                </small>
            </div>

           
        </li>
    </c:forEach>
</ul>
                                                            </li>
                                                           
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                    
                                            </div>
                                        </div>
                    
                    
                    
                    
                                    </div>
                    
                                </div>	
                  

                                  

                                       

<div class="row mt-5">
<div class="col-4">
<!-- <button class="btn w-100 btn-success"><i class="fas fa-check-circle mr-1"></i>ADD TO BATCH LIST</button> -->
<button class="btn w-100 btn-success btnAddToBatchlist"  data-job_number="${job_number}" data-ar_name="${ar_name}" data-job_purpose="${job_purpose}"
				data-business_process_sub_name="${business_process_sub_name}" data-toggle="modal" data-target="#askForPurposeOfSendingRequesttoOfficer">
					 <i class="fas fa-check-circle mr-1"></i>ADD TO BATCH LIST
				</button>
</div>
 <div class="col-4">
  
    <button class="btn btn-primary w-100" id="btnViewRequestsList">
        <i class="fas fa-list mr-1"></i>VIEW PREPARED BATCH LIST
    </button>
   
    </div>
<!--<div class="col-4">

<button class="btn btn-warning w-100" id="btnViewRequestsList">
    <i class="fas fa-list mr-1"></i>PREPARED REQUEST LIST
</button>

</div> -->
<!-- <div class="col-3">
    <button class="btn w-100 btn-danger"><i class="fas fa-download mr-1"></i>KEEP IN VIEW</button>
    </div>-->
</div> 

<form action="registration_application_progress_details" id="registration_application_progress_details" method="post">
    <input type="hidden" name="case_number" value="${case_number}">
    <input type="hidden" name="transaction_number" value="${transaction_number}">
    <input type="hidden" name="job_number" id="job_number" value="${job_number}">
    <input type="hidden" name="business_process_sub_name"  value="${business_process_sub_name}">
    
</form>
			                
        <!-- </div> -->

     

     <div class="modal fade" id="approve_step" tabindex="-1"
     role="dialog" aria-labelledby="#approve_step" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content">
           <div class="modal-header">
              <h5 class="modal-title" id="">Are you sure you want to approve the step?</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           </div>
           <div class="modal-body">
            <label for="" class="col-form-label">Leave comment:</label>
              <textarea type="text" class="form-control" id="approve_comment_"  ></textarea>
              <input type="hidden" class="form-control" id="cs_main_step_id" />
           </div>
           <div class="modal-footer">
            <button type="button" class="btn btn-secondary "
               data-dismiss="modal">Close</button>
               <button type="button" class="btn btn-success " id="btn_approve_step"
               >Approve</button>
         </div>
        </div>
     </div>
  </div>

  
  <div class="modal fade" id="view_approve_comment" tabindex="-1"
  role="dialog" aria-labelledby="#view_approve_comment" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Approve Comment</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
           <div class="form-group">
            <label for="" class="col-form-label">Comment:</label>
              <textarea type="text" class="form-control" readonly id="approved_comment"  ></textarea>
        </div>
        <div class="form-group">
            <label for="" class="col-form-label">Approved By:</label>
              <input type="text" class="form-control" readonly id="approved_by" />
        </div>
        <div class="form-group">
            <label for="" class="col-form-label">Approved Date:</label>
              <input type="date" class="form-control" readonly id="approved_date" />
        </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-success " id="btn_approve_step"
            >Approve</button>
      </div>
     </div>
  </div>
</div>

     <div class="modal fade" id="upload_coordinate" tabindex="-1"
     role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content">
           <div class="modal-header">
              <h5 class="modal-title" id="">Coordinate Entry</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           </div>
           <div class="modal-body">
            <label for="" class="col-form-label">WKT Polygon:</label>
              <input type="text" class="form-control" readonly value="${parcel_wkt}" />
           </div>
           <div class="modal-footer">
            <button type="button" class="btn btn-secondary "
               data-dismiss="modal">Close</button>
         </div>
        </div>
     </div>
  </div>
  
  <!-- <div class="modal fade" id="check_for_polygon" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Check for Polygon</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
         <label for="" class="col-form-label">WKT Polygon:</label>
           <input type="text" class="form-control" readonly value="${parcel_wkt}" />
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div> -->

<div class="modal map-modal fade" id="check_for_polygon" tabindex="-1"
role="dialog" aria-labelledby="#check_for_polygon" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered modal-lg">
   <div class="modal-content">
      <div class="modal-header">
         <h5 class="modal-title" id="">Check for Polygon</h5>
         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
      
                     <!--  The Form starts here -->
                    <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
             
  <!-- Maps Details Starts Here  -->
  
    <div class="form-group">
                              <div class="form-row">  <label for="lc_bl_wkt_polygon">WKT Polygon</label>
                                    <input class="form-control" id="lc_bl_wkt_polygon"  name="lc_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
      
                                  <!-- <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" ></textarea> -->
                              </div>
                              
                        
                           </div>


  
  <div class="bs-example">
  

  
  
  

              <div class="btn-group mr-2">
              


<button type="button" class="btn btn-primary"  id="lc_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-map"></i>
</button>
<!--  
<button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
<i class="fa fa-save"></i>
</button>
-->

<button type="button" class="btn btn-primary" id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
<i class="fa fa-object-ungroup"></i>
</button>




<button type="button" class="btn btn-primary" id="lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-print"></i>
</button>


<div class="btn-group">
Scale:
</div>
<div class="btn-group">
<input class="form-control" id="lc_scale_value_e"  name="lc_scale_value_e" type="text" class="autocomplat" />


<select name="lc_scale_value" id="lc_scale_value">
<option value="500">500</option>
<option value="1107">1107</option>
<option value="1250">1250</option>
<option value="2500">2500</option>
<option value="2140">2140</option>
<option value="2670">2670</option>
<option value="2215">2215</option>
<option value="2825">2825</option>
<option value="5000">5000</option>
<option value="10000">10000</option>
<option value="15000">15000</option>
<option value="20000">20000</option>

</select>


<!-- <datalist id="scalelist">
<option>500</option>
<option>1107</option>
<option>1250</option>
<option>2500</option>
<option>2140</option>
<option>2670</option>
<option>2215</option>
<option>2825</option>
<option>5000</option>
<option>10000</option>
<option>15000</option>
<option>20000</option>
</datalist> -->
</div>

<div class="btn-group mr-2">
<input type="checkbox" checked="checked" id="lc_lockmapscale">
<button type="button" class="btn btn-primary" id="lc_btn_scale_zoom" data-placement="top" data-toggle="tooltip" title="Zoom to Scale">
<i class="fa fa-search"></i>
</button>
</div>



</div> 








</div>



  
  
  
   <div class="map-container" id="lc-map___" ></div>
   
       <!--  Here is where the fee list comes -->


                        
                    </form>
                  
                


      </div>
      <div class="modal-footer">
       <button type="button" class="btn btn-secondary "
          data-dismiss="modal">Close</button>
    </div>
   </div>
</div>
</div>


<div class="modal map-modal fade" id="generate_smd_number" tabindex="-1"
role="dialog" aria-labelledby="#check_for_polygon" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered modal-lg">
   <div class="modal-content">
      <div class="modal-header">
         <h5 class="modal-title" id="">Generate SMD Numbers</h5>
         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">

        <div class="row">
          <!--   Here is the right Table -->
             <div class="col-lg-12">
             <!-- Example Pie Chart Card-->
             <div class="card mb-3">
               <div class="card-body">
          
          
                     <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
          
               
              <div class="form-row">
                 
                 <div class="col-md-4">
                  <label for="search_value">GLPIN</label>
                  <input class="form-control" id="txt_glpin"    type="text" aria-describedby="nameHelp" placeholder="GLPIN" value="${glpin}" readonly>
                </div>
                
                  
                <div class="col-md-4">
                  <label for="search_value">Type of Plotting</label>
                  <input class="form-control" id="txt_lc_smd_type_of_plotting"  name="txt_lc_smd_type_of_plotting"  type="text" aria-describedby="nameHelp"  value="${smd_type_of_plotting}" readonly>
                </div>
          
                  <div class="col-md-4">
                  <label for="search_value">SMD Reference Number</label>
                  <input class="form-control" id="txt_lc_smd_reference_number"  name="txt_lc_smd_reference_number"  type="text" aria-describedby="nameHelp"  value="${smd_reference_number}" readonly>
                  </div>
          
              </div>
               
               
               <div class="form-row">
               
             
          
                <div class="col-md-4">
                <label for="search_value">Registration District</label>
                <input class="form-control" id="txt_lc_registration_district_number"  name="txt_lc_registration_district_number"  type="text" aria-describedby="nameHelp" value="${registration_district_number}" readonly >
              </div>
          
              <div class="col-md-4">
                <label for="search_value">Section Number</label>
                <input class="form-control" id="txt_lc_registration_section_number"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registration_section_number}" readonly>
              </div>
                <div class="col-md-4">
                <label for="search_value">Block Number</label>
                <input class="form-control" id="txt_lc_registration_block_number"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registration_block_number}" readonly>
              </div>
               
              </div>
              
              
                 <div class="form-row">
              
                  <div class="col-md-4">
                    <label for="search_value">Land size</label>
                    <input class="form-control" id="txt_lc_size_of_land"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${size_of_land}" readonly>
                  </div>
                    <div class="col-md-4">
                    <label for="search_value">Plan Number</label>
                    <input class="form-control" id="txt_lc_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp" value="${plan_no}" readonly>
                  </div>
               <div class="col-md-4">
                 <label for="search_value">LTR Plan Number</label>
                <input class="form-control" id="ltr_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${ltr_plan_no}" readonly>
              
                 
               </div>
               
              </div>
              
              <div class="form-row">
              <div class="col-md-4">
                <label for="search_value">Registry Map No</label>
                <input class="form-control" id="txt_lc_registry_mapref"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registry_mapref}" readonly>
              </div>
              
              <div class="col-md-4">
                <label for="search_value">CC No</label>
                <input class="form-control" id="txt_lc_cc_no"  name="search_value"  type="text" aria-describedby="nameHelp" value="${cc_no}" readonly>
              </div> 
              
               
               
              </div>
          
               
                
                 
             </form>
          
               
             </div>
            
             </div>
           <!--   Here is the end of right table -->
          
           </div>
           
          
          </div>
      <div class="card card-body mt-2">
                     <!--  The Form starts here -->
                    <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
             
  <!-- Maps Details Starts Here  -->
  
    <div class="form-group">
                              <div class="form-row">  <label for="lc_bl_wkt_polygon">WKT Polygon</label>
                                    <input class="form-control" id="lc_bl_wkt_polygon"  name="lc_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
      
                                  <!-- <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" ></textarea> -->
                              </div>
                              
                        
                           </div>


  
  <div class="bs-example">
  

  
  
  

              <div class="btn-group mr-2">
              


<button type="button" class="btn btn-primary"  id="lc_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-map"></i>
</button>
<!--  
<button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
<i class="fa fa-save"></i>
</button>
-->

<button type="button" class="btn btn-primary" id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
<i class="fa fa-object-ungroup"></i>
</button>




<button type="button" class="btn btn-primary" id="lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-print"></i>
</button>


<div class="btn-group">
Scale:
</div>
<div class="btn-group">
<input class="form-control" id="lc_scale_value_e"  name="lc_scale_value_e" type="text" class="autocomplat" />


<select name="lc_scale_value" id="lc_scale_value">
<option value="500">500</option>
<option value="1107">1107</option>
<option value="1250">1250</option>
<option value="2500">2500</option>
<option value="2140">2140</option>
<option value="2670">2670</option>
<option value="2215">2215</option>
<option value="2825">2825</option>
<option value="5000">5000</option>
<option value="10000">10000</option>
<option value="15000">15000</option>
<option value="20000">20000</option>

</select>


<!-- <datalist id="scalelist">
<option>500</option>
<option>1107</option>
<option>1250</option>
<option>2500</option>
<option>2140</option>
<option>2670</option>
<option>2215</option>
<option>2825</option>
<option>5000</option>
<option>10000</option>
<option>15000</option>
<option>20000</option>
</datalist> -->
</div>

<div class="btn-group mr-2">
<input type="checkbox" checked="checked" id="lc_lockmapscale">
<button type="button" class="btn btn-primary" id="lc_btn_scale_zoom" data-placement="top" data-toggle="tooltip" title="Zoom to Scale">
<i class="fa fa-search"></i>
</button>
</div>



</div> 








</div>



  
  
  
   <div class="map-container" id="lc-map____" ></div>
   
       <!--  Here is where the fee list comes -->


                        
                    </form>
                    </div>
<div class="mt-2">
  <button class="btn btn-success w-100" id="btn_generate_smd_title_plan_numbers"> Generate</button>
</div>
                  
      </div>
      <div class="modal-footer">
       <button type="button" class="btn btn-secondary "
          data-dismiss="modal">Close</button>
    </div>
   </div>
</div>
</div>


<div class="modal map-modal fade" id="review_plan_details" tabindex="-1"
role="dialog" aria-labelledby="#check_for_polygon" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered modal-lg">
   <div class="modal-content">
      <div class="modal-header">
         <h5 class="modal-title" id="">Review Plan Details</h5>
         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">

        <div class="row">
          <!--   Here is the right Table -->
             <div class="col-lg-12">
             <!-- Example Pie Chart Card-->
             <div class="card mb-3">
               <div class="card-body">
          
          
                     <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
          
               
              <div class="form-row">
                 
                 <div class="col-md-4">
                  <label for="search_value">GLPIN</label>
                  <input class="form-control" id="txt_glpin"    type="text" aria-describedby="nameHelp" placeholder="GLPIN" value="${glpin}" readonly>
                </div>
                
                  
                <div class="col-md-4">
                  <label for="search_value">Type of Plotting</label>
                  <input class="form-control" id="txt_lc_smd_type_of_plotting"  name="txt_lc_smd_type_of_plotting"  type="text" aria-describedby="nameHelp"  value="${smd_type_of_plotting}" readonly>
                </div>
          
                  <div class="col-md-4">
                  <label for="search_value">SMD Reference Number</label>
                  <input class="form-control" id="txt_lc_smd_reference_number"  name="txt_lc_smd_reference_number"  type="text" aria-describedby="nameHelp"  value="${smd_reference_number}" readonly>
                  </div>
          
              </div>
               
               
               <div class="form-row">
               
             
          
                <div class="col-md-4">
                <label for="search_value">Registration District</label>
                <input class="form-control" id="txt_lc_registration_district_number"  name="txt_lc_registration_district_number"  type="text" aria-describedby="nameHelp" value="${registration_district_number}" readonly >
              </div>
          
              <div class="col-md-4">
                <label for="search_value">Section Number</label>
                <input class="form-control" id="txt_lc_registration_section_number"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registration_section_number}" readonly>
              </div>
                <div class="col-md-4">
                <label for="search_value">Block Number</label>
                <input class="form-control" id="txt_lc_registration_block_number"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registration_block_number}" readonly>
              </div>
               
              </div>
              
              
                 <div class="form-row">
              
                  <div class="col-md-4">
                    <label for="search_value">Land size</label>
                    <input class="form-control" id="txt_lc_size_of_land"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${size_of_land}" readonly>
                  </div>
                    <div class="col-md-4">
                    <label for="search_value">Plan Number</label>
                    <input class="form-control" id="txt_lc_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp" value="${plan_no}" readonly>
                  </div>
               <div class="col-md-4">
                 <label for="search_value">LTR Plan Number</label>
                <input class="form-control" id="ltr_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${ltr_plan_no}" readonly>
              
                 
               </div>
               
              </div>
              
              <div class="form-row">
              <div class="col-md-4">
                <label for="search_value">Registry Map No</label>
                <input class="form-control" id="txt_lc_registry_mapref"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registry_mapref}" readonly>
              </div>
              
              <div class="col-md-4">
                <label for="search_value">CC No</label>
                <input class="form-control" id="txt_lc_cc_no"  name="search_value"  type="text" aria-describedby="nameHelp" value="${cc_no}" readonly>
              </div> 
              
               
               
              </div>
          
               
                
                 
             </form>
          
               
             </div>
            
             </div>
           <!--   Here is the end of right table -->
          
           </div>
           
          
          </div>
      <div class="card card-body mt-2">
                     <!--  The Form starts here -->
                    <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
             
  <!-- Maps Details Starts Here  -->
  
    <div class="form-group">
                              <div class="form-row">  <label for="lc_bl_wkt_polygon">WKT Polygon</label>
                                    <input class="form-control" id="lc_bl_wkt_polygon"  name="lc_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
      
                                  <!-- <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" ></textarea> -->
                              </div>
                              
                        
                           </div>


  
  <div class="bs-example">
  

  
  
  

              <div class="btn-group mr-2">
              


<button type="button" class="btn btn-primary"  id="lc_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-map"></i>
</button>
<!--  
<button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
<i class="fa fa-save"></i>
</button>
-->

<button type="button" class="btn btn-primary" id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
<i class="fa fa-object-ungroup"></i>
</button>




<button type="button" class="btn btn-primary" id="lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-print"></i>
</button>


<div class="btn-group">
Scale:
</div>
<div class="btn-group">
<input class="form-control" id="lc_scale_value_e"  name="lc_scale_value_e" type="text" class="autocomplat" />


<select name="lc_scale_value" id="lc_scale_value">
<option value="500">500</option>
<option value="1107">1107</option>
<option value="1250">1250</option>
<option value="2500">2500</option>
<option value="2140">2140</option>
<option value="2670">2670</option>
<option value="2215">2215</option>
<option value="2825">2825</option>
<option value="5000">5000</option>
<option value="10000">10000</option>
<option value="15000">15000</option>
<option value="20000">20000</option>

</select>


<!-- <datalist id="scalelist">
<option>500</option>
<option>1107</option>
<option>1250</option>
<option>2500</option>
<option>2140</option>
<option>2670</option>
<option>2215</option>
<option>2825</option>
<option>5000</option>
<option>10000</option>
<option>15000</option>
<option>20000</option>
</datalist> -->
</div>

<div class="btn-group mr-2">
<input type="checkbox" checked="checked" id="lc_lockmapscale">
<button type="button" class="btn btn-primary" id="lc_btn_scale_zoom" data-placement="top" data-toggle="tooltip" title="Zoom to Scale">
<i class="fa fa-search"></i>
</button>
</div>



</div> 








</div>



  
  
  
   <div class="map-container" id="lc-map_____" ></div>
   
       <!--  Here is where the fee list comes -->


                        
                    </form>
                    </div>
<!-- <div class="mt-2">
  <button class="btn btn-success w-100" id=""> Generate</button>
</div> -->
                  
      </div>
      <div class="modal-footer">
       <button type="button" class="btn btn-secondary "
          data-dismiss="modal">Close</button>
    </div>
   </div>
</div>
</div>
  
  <div class="modal fade" id="sent_for_publication" tabindex="-1"
     role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content">
           <div class="modal-header">
              <h5 class="modal-title" id="">Check for Publication</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           </div>
           <div class="modal-body">
            <label for="" class="col-form-label">Publication Date:</label>
            <div class="row">
                <div class="col-8">
                    <!-- <c:if test="${not empty publicity_date and publicity_date ne 'null'}">
                       <input type="date" class="form-control" value="${publicity_date}" id="lc_txt_publicity_date" />
                    </c:if>
                    <c:if test="${empty publicity_date}">
                       <input type="date" class="form-control" value="${publicity_date}" id="lc_txt_publicity_date" />
                    </c:if> -->

                    <c:if test="${not empty publicity_date and publicity_date != 'null' and not fn:contains(publicity_date, '-')}">
                      <input type="date" class="form-control" id="lc_txt_publicity_date" readonly value="${publicity_date}" />
                  </c:if>
                  
                  <c:if test="${empty publicity_date or publicity_date == 'null' or fn:contains(publicity_date, '-')}">
                      <input type="date" class="form-control" id="lc_txt_publicity_date" value="${publicity_date}" />
                  </c:if>
                </div>
                <div class="col-4">
                    <button class="btn btn-warning w-100" id="lc_btn_update_publication_date"
                    <c:if test="${not empty publicity_date and publicity_date ne 'null'}">
                        disabled
                    </c:if>
                    ><i class="fas fa-save mr-1"></i>Update</button>
                </div>
            </div>
              <div class="mt-3">
                <button 
                    class="btn btn-primary w-100" id="lc_btn_add_to_publication_list"
                    <c:if test="${not empty publicity_date and publicity_date ne 'null'}">
                        disabled
                    </c:if>
                >

                <i class="fas fa-upload mr-1"></i>
                    Send For Publication
                </button>
              </div>
           </div>
           <div class="modal-footer">
            <button type="button" class="btn btn-secondary "
               data-dismiss="modal">Close</button>
         </div>
        </div>
     </div>
  </div>

  <div class="modal fade" id="generate_interest_number" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Generate Interest Number</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
         <label for="" class="col-form-label">Interest Number:</label>
           <input type="text" class="form-control" readonly value="${interest_number}" id="lc_txt_interest_number" />
           <div class="mt-3">
            <button 
            class="btn btn-primary w-100" id="lc_btn_generate_interest_number"
            <c:if test="${not empty interest_number and interest_number ne 'null'}">
                disabled
            </c:if>
         >
 
        <i class="fas fa-check-circle mr-1"></i>
            Generate
        </button>
           </div> 
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="generate_sub_interest_number" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Generate Sub Interest Number</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
         <label for="" class="col-form-label">Sub Interest Number:</label>
           <input type="text" class="form-control" readonly value="${sub_interest_number}" id="lc_txt_sub_interest_number" />

           <div class="mt-3">
            <button 
            class="btn btn-primary w-100" id="lc_btn_generate_sub_interest_number"
            <c:if test="${not empty sub_interest_number and sub_interest_number ne 'null'}">
                disabled
            </c:if>
         >
 
        <i class="fas fa-check-circle mr-1"></i>
            Generate
        </button>
           </div> 
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>



<div class="modal fade" id="check_for_payment" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Check For Payment</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div  class="table-responsive">
                <table class="table table-bordered  table-hover table-sm" id="bill_payment_dataTable">
                
                   <thead>
                     <tr>
                          <th>Action</th>
                          <th>Payment Mode</th>
                          <th>Amount</th>
                          <th>Receipt Number</th>
                          <th>Payment Date</th>
                          <th>Payment Amount</th>
                      </tr>
                   </thead>
                   
                     <tbody>
                      <c:forEach items="${payment_invoice}" var="payment_bill_row">
                         <tr>
                             <td><button 
                                           id="viewBillModalBtn"  
                                           data-toggle="modal" 
                                           data-target="#viewBillModal"  
                                         
                                         data-egcr_id= "${payment_bill_row.payment_slip_number}"
                                         data-ref_number= "${payment_bill_row.ref_number}"
                                           class="btn btn-success"  
                                           title="View Bill Details" >
                                     View
                                 </button> 
                             </td>
                             <td>${payment_bill_row.payment_mode}</td>
                             <td>${payment_bill_row.bill_amount}</td>
                             <td>${payment_bill_row.payment_slip_number}</td>
                             <td>${payment_bill_row.payment_date}</td>
                             <td>${payment_bill_row.payment_amount}</td>
                             
                          </tr>
                      </c:forEach>
                       </tbody>
         
                 
                 </table>
               </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="add_edit_parties" tabindex="-1"
  role="dialog" aria-labelledby="#add_edit_parties" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Add/Edit Parties</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <button type="button" class=" float-right btn btn-primary" id="lrd_btn_add_grantor" data-placement="top" data-toggle="modal" data-target="#addeditpartyGeneral" title="Add party">
                <i class="fa fa-plus-circle"></i>Add Grantor
            </button>
            
            <button type="button" class=" float-left btn btn-primary" id="lrd_btn_add_grantee" data-placement="top" data-toggle="modal" data-target="#addeditpartyGeneral" title="Add party">
                <i class="fa fa-plus-circle"></i>Add Applicant
            </button>
            <br>
            <div class="table-responsive">
                <table class="table table-bordered  table-hover table-sm" id="party_details_datatable">

                    <thead>
                        <tr>

                            <th>Name</th>
                            <th>Sex</th>
                            <th>Contact</th>
                            <th>Role</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach items="${parties}" var="parties_row">
                        <tr>
                            <td>${parties_row.ar_name}</td>
                            <td>${parties_row.ar_gender}</td>
                            <td>${parties_row.ar_cell_phone}</td>
                            <td>${parties_row.type_of_party}</td>
                            <td>
                            
                            <p data-placement="top"  title="Edit Party">  
                                  <button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
                                       data-target="#addeditpartyGeneral"
                                       data-target-id="${parties_row.ar_client_id}"  
                                       data-ar_name="${parties_row.ar_name}"
                                       data-ar_gender="${parties_row.ar_gender}"
                                       data-ar_address="${parties_row.ar_address}"
                                       data-ar_cell_phone="${parties_row.ar_cell_phone}"
                                       data-ar_cell_phone2="${parties_row.ar_cell_phone2}"
                                       data-ar_tin_no="${parties_row.ar_tin_no}"
                                       data-ar_id_type="${parties_row.ar_id_type}"
                                       data-ar_id_number="${parties_row.ar_id_number}"
                                       data-ar_location="${parties_row.ar_location}"
                                       data-ar_district="${parties_row.ar_district}"
                                       data-type_of_party="${parties_row.type_of_party}"
                                       data-ar_region="${parties_row.ar_region}"
                                       data-ar_person_type="${parties_row.ar_person_type}"
                                       > 
                                               
                                               
                                      <span class="icon text-white-50"> 
                                      <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>
                                      <button class="btn btn-danger btn-icon-split" data-title="Edit"  data-toggle="modal"
                                      data-target="#deletepartyGeneral"
                                      data-target-id="${parties_row.ar_client_id}"  
                                      data-ar_name="${parties_row.ar_name}"
                                      data-ar_gender="${parties_row.ar_gender}"
                                      data-ar_address="${parties_row.ar_address}"
                                      data-ar_cell_phone="${parties_row.ar_cell_phone}"
                                      data-ar_cell_phone2="${parties_row.ar_cell_phone2}"
                                      data-ar_tin_no="${parties_row.ar_tin_no}"
                                      data-ar_id_type="${parties_row.ar_id_type}"
                                      data-ar_id_number="${parties_row.ar_id_number}"
                                      data-ar_location="${parties_row.ar_location}"
                                      data-ar_district="${parties_row.ar_district}"
                                      data-type_of_party="${parties_row.type_of_party}"
                                      data-ar_region="${parties_row.ar_region}"
                                      data-ar_person_type="${parties_row.ar_person_type}"
                                      data-p_uid="${parties_row.p_uid}"
                                      data-ar_id="${parties_row.ar_id}"
                                      > 
                                              
                                              
                                     <span class="icon text-white-50"> 
                                     <i class="fas fa-trash"></i></span> <span class="text">Delete</span>  </button>
                              </p>
                            
                            </td>
                         </tr>
                    </c:forEach>
                    </tbody>


                </table>
            </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="send_for_title_plan_preparation" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Title Plan Preparation</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="" class="col-form-label">Plan Number:</label>

                <c:if test="${not empty plan_no and plan_no != 'null' and not fn:contains(plan_no, '-')}">
                  <input type="text" class="form-control" id="txt_lc_plan_no_pl_smd" readonly value="${plan_no}" />
              </c:if>
              
              <c:if test="${empty plan_no or plan_no == 'null' or fn:contains(plan_no, '-')}">
                  <input type="text" class="form-control" id="txt_lc_plan_no_pl_smd" value="${plan_no}" />
              </c:if>

            </div>
            <div class="form-group">
                <label for="" class="col-form-label">Registry Map Ref:</label>
               

                        <c:if test="${not empty registry_mapref and registry_mapref != 'null' and not fn:contains(registry_mapref, '-')}">
                          <input type="text" class="form-control" id="txt_lc_registry_mapref_pl_smd" readonly value="${registry_mapref}" />
                      </c:if>
                      
                      <c:if test="${empty registry_mapref or registry_mapref == 'null' or fn:contains(registry_mapref, '-')}">
                          <input type="text" class="form-control" id="txt_lc_registry_mapref_pl_smd" value="${registry_mapref}" />
                      </c:if>
            </div>
            <div class="form-group">
                <label for="" class="col-form-label">CC Number:</label>
                <c:if test="${not empty cc_no and cc_no != 'null' and not fn:contains(cc_no, '-')}">
                  <input type="text" class="form-control" id="txt_cc_no_pl_smd" readonly value="${cc_no}" />
              </c:if>
              
              <c:if test="${empty cc_no or cc_no == 'null' or fn:contains(cc_no, '-')}">
                  <input type="text" class="form-control" id="txt_cc_no_pl_smd" value="${cc_no}" />
              </c:if>
            </div>
            <div class="form-group">
                <label for="" class="col-form-label">LTR Number:</label>
                <c:if test="${not empty ltr_plan_no and ltr_plan_no != 'null' and not fn:contains(ltr_plan_no, '-')}">
                  <input type="text" class="form-control" id="ltr_plan_no_pl_smd" readonly value="${ltr_plan_no}" />
              </c:if>
              
              <c:if test="${empty ltr_plan_no or ltr_plan_no == 'null' or fn:contains(ltr_plan_no, '-')}">
                  <input type="text" class="form-control" id="ltr_plan_no_pl_smd" value="${ltr_plan_no}" />
              </c:if>
            </div>
            <div class="mt-3">
                <button 
                    class="btn btn-primary w-100" id="btn_save_lrd_title_plan_update_details_smd_new_update"
                >

                <i class="fas fa-upload mr-1"></i>
                    Update
                </button>
              </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="inspection_of_site" tabindex="-1"
  role="dialog" aria-labelledby="#inspection_of_site" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Inspection of Site</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <button type="button" class="btn btn-success" id="btn_load_scanned_documents___" data-placement="top"  title="Load Docs">
                <i class="fas fa-eye"></i>
            </button>
            
            <button type="button" class="btn btn-primary" id="" data-toggle="modal" data-target="#fileUploadModal" title="Add Documents">
                <i class="fa fa-plus-circle"></i>
            </button> 
            
            
        <div  class="table-responsive mt-2">
           <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable___" width="100%" class="display" cellspacing="0">
           
              <thead>
                <tr>

                 <th>Document Name</th>
                 <th>Document Type</th>
               </tr>
              </thead>
              
                <tbody>				
                <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
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
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="view_register" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">View Register</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="row mt-2">
                <div class="col-md-12">
    
                    <input type="button" id="lc_btn_activate_final_register" class="btn btn-primary btn-block w-100" value="Generate Register" />  
                    <!-- 																	 
                    <input type="button" id="lc_btn_activate_provisional_certificate" class="btn btn-warning btn-block" value="Generate Provisional Certificate" />  
                    -->
                </div>
            </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="compose_mmemo" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Preview Memo</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="row mt-2">
                <div class="col-md-12">
    
                    <input type="button" id="lc_btn_generate_memo_for_certificate_2" class="btn btn-primary btn-block w-100" value="Generate Memo" />  
                    <!-- 																	 
                    <input type="button" id="lc_btn_activate_provisional_certificate" class="btn btn-warning btn-block" value="Generate Provisional Certificate" />  
                    -->
                </div>
            </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="preview_memo" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Preview Memo</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="row mt-2">
                <div class="col-md-12">
    
                    <input type="button" id="lc_btn_generate_memo_for_certificate" class="btn btn-primary btn-block w-100" value="Preview Memo" />  
                    <!-- 																	 
                    <input type="button" id="lc_btn_activate_provisional_certificate" class="btn btn-warning btn-block" value="Generate Provisional Certificate" />  
                    -->
                </div>
            </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="verify_transaction_on_mother" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Verify Transaction on Mother</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
          <div  class="table-responsive">
            <table class="table table-bordered  table-hover table-sm" id="linkdetails_dataTable">
         <thead>
           <tr>
             
             <th>Job Number</th>
             <th>Case Number</th>
             <th>Type of Relationship</th>
             <th>Date</th>
             <th>Action</th>
           </tr>
         </thead>
         <tbody>
           <c:forEach items="${mother_to_child_link_list}" var="mother_to_child_link_row">
                           <tr>
                               
                               <td>${mother_to_child_link_row.job_number}</td>
                               <td>${mother_to_child_link_row.mc_case_number}</td>
                               <td>${mother_to_child_link_row.mc_type_of_relationship}</td>
                               <td>${mother_to_child_link_row.created_date}</td>
                               <td>
                             <button type="button" id="btn-view-mother-Child-details"  data-job_number="${mother_to_child_link_row.mc_job_number}" data-case_number="${mother_to_child_link_row.mc_case_number}" data-transaction_number="[0, 0]" business_process_sub_name="-" data-toggle="modal" data-target="#transitional_certificate_template"  class="btn btn-primary btn-icon-split "  title="View Case Details" >
                             <span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>
                           </button> 
                       </td>
                            </tr>
                        </c:forEach>
         </tbody>
       </table>
           </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="view_certificate" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">View Certificate</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="row mt-2">
                <div class="col-md-12">
    
                    <input type="button" id="lc_btn_activate_final_certificate" class="btn btn-primary btn-block w-100" value="Generate Certificate" />  
    
                    <!-- 																	 
                    <input type="button" id="lc_btn_activate_provisional_certificate" class="btn btn-warning btn-block" value="Generate Provisional Certificate" />  
                    -->
                </div>
            </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="confirm_parcel_and_transaction" tabindex="-1"
  role="dialog" aria-labelledby="#confirm_parcel_and_transaction" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Confirm Parcel and Transaction</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="row mt-2">
                <div class="col-md-12">
    
                    <input type="button" id="" class="btn btn-primary btn-block w-100" value="Confirm Transaction" />  
    
                    <!-- 																	 
                    <input type="button" id="lc_btn_activate_provisional_certificate" class="btn btn-warning btn-block" value="Generate Provisional Certificate" />  
                    -->
                </div>
            </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="generate_certificate_number" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Generate Certificate Number</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="job_number">Certificte Type</label>
                <select name="lc_txt_type_of_certificate" id="lc_txt_type_of_certificate" class="form-control input-sm" data-style="btn-info" required data-live-search="true">
                    <option value="${certificate_type == 'Individual' ? '' : certificate_type}">${certificate_type == 'Individual' ? '-- select --' : certificate_type}</option>
                    <option value="Provisional Certificate">Provisional Certificate</option>
                    <option value="Land Certificate">Land Certificate</option>
                    <option value="Substituted Certificate">Substituted Certificate</option>
                </select> 
            </div>
            <div class="form-group">
                <label for="" class="col-form-label">Certificate Number:</label>
                  <input type="text" class="form-control" id="lc_txt_certificate_number" readonly value="${certificate_number}" />
            </div>
            <div class="mt-3">
                <input type="button" id="lc_btn_generate_certificate_number_only" 
                class="btn btn-primary btn-block w-100" 
                value="Generate" 
                <c:if test="${not empty certificate_number and certificate_number ne 'null'}">
                        disabled
                    </c:if>
                />  
             </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="generate_volume_and_folio" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Generate Volume and Folio</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
        <div class="form-group">
            <label for="" class="col-form-label">Volume:</label>
              <input type="text" class="form-control" readonly id="lc_txt_volume_number" value="${volume_number}" />
        </div>
        <div class="form-group">
            <label for="" class="col-form-label">Folio:</label>
              <input type="text" class="form-control" readonly id="lc_txt_folio_number" value="${folio_number}" />
        </div>
        <div class="mt-3">
            <input type="button" id="lc_btn_generate_volume_folio_number_only" class="btn btn-primary btn-block w-100" 
            value="Generate"
            <c:if test="${not empty volume_number and not empty folio_number}">
                disabled
            </c:if>
             />  
         </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="confirm_otp_for_approval_certificate" tabindex="-1"
  role="dialog" aria-labelledby="#send_opt_for_approval_certificate" aria-hidden="true">
  <div class="modal-dialog modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Request OTP For Certificate</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
        <!-- <div class="form-group">
            <label for="" class="col-form-label">Volume:</label>
              <input type="text" class="form-control" readonly value="${volume_number}" />
        </div>
        <div class="form-group">
            <label for="" class="col-form-label">Folio:</label>
              <input type="text" class="form-control" readonly value="${folio_number}" />
        </div> -->
        <div class="mt-3">
            <input type="button" id="lc_btn_approve_certicate_for_signature" class="btn btn-primary btn-block w-100" value="Generate" />  
         </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="plot_transaction_to_smd_layer" tabindex="-1"
  role="dialog" aria-labelledby="#plot_transaction_to_smd_layer" aria-hidden="true">
  <div class="modal-dialog modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Request OTP For Final Signing</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
        <!-- <div class="form-group">
            <label for="" class="col-form-label">Volume:</label>
              <input type="text" class="form-control" readonly value="${volume_number}" />
        </div>
        <div class="form-group">
            <label for="" class="col-form-label">Folio:</label>
              <input type="text" class="form-control" readonly value="${folio_number}" />
        </div> -->
        <div class="mt-3">
            <input type="button" id="lc_btn_approve_for_plot_transaction_to_smd_layer" class="btn btn-primary btn-block w-100" value="Generate" />  
         </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="complete_request_forward_to_approval_officer" tabindex="-1"
  role="dialog" aria-labelledby="#complete_request_forward_to_approval_officer" aria-hidden="true">
  <div class="modal-dialog modal-md modal-dialog-centered">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Complete Request and forward to Approval Officer</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
          <div class="">
            <button class="btn btn-success btn-icon-split float-left to_hide_on_level_1 w-100"  data-job_number="${job_number}" id="btnApproveJob">
              <span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Approve Request</span>
            </button>
          
            <!-- <button class="btn btn-danger btn-icon-split float-left ml-3"  data-job_number="${job_number}" id="btnQueryJob">
              <span class="icon text-white-50"> <i class="fas fa-times fa-2x"></i></span><span class="text">Query Request</span>
            </button> -->
           </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="confirm_otp_for_approval_register" tabindex="-1"
  role="dialog" aria-labelledby="#send_opt_for_approval_register" aria-hidden="true">
  <div class="modal-dialog modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Request OTP For Register</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
        <!-- <div class="form-group">
            <label for="" class="col-form-label">Volume:</label>
              <input type="text" class="form-control" readonly value="${volume_number}" />
        </div>
        <div class="form-group">
            <label for="" class="col-form-label">Folio:</label>
              <input type="text" class="form-control" readonly value="${folio_number}" />
        </div> -->
        <div class="mt-3">
            <input type="button" id="lc_btn_generate_activation_code" class="btn btn-primary btn-block w-100" value="Generate" />  
         </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="send_opt_for_approval_morgtgage" tabindex="-1"
  role="dialog" aria-labelledby="#send_opt_for_approval_register" aria-hidden="true">
  <div class="modal-dialog modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Request OTP For Mortgage</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
        <!-- <div class="form-group">
            <label for="" class="col-form-label">Volume:</label>
              <input type="text" class="form-control" readonly value="${volume_number}" />
        </div>
        <div class="form-group">
            <label for="" class="col-form-label">Folio:</label>
              <input type="text" class="form-control" readonly value="${folio_number}" />
        </div> -->
        <div class="mt-3">
            <input type="button" id="lc_btn_generate_activation_code__" class="btn btn-primary btn-block w-100" value="Generate" />  
         </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="check_availability_of_mother_file" tabindex="-1"
  role="dialog" aria-labelledby="#check_availability_of_mother_file" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Check availability of Mother File</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <!-- <div  class="table-responsive">
                <table class="table table-bordered  table-hover table-sm" id="linkdetails_dataTable">
                     <thead>
                         <tr>
                             
                             <th>Job Number</th>
                             <th>Case Number</th>
                             <th>Type of Relationship</th>
                             <th>Date</th>
                             <th>Action</th>
                         </tr>
                     </thead>
                     <tbody>
                         <c:forEach items="${mother_to_child_link_list}" var="mother_to_child_link_row">
                                         <tr>
                                             
                                             <td>${mother_to_child_link_row.job_number}</td>
                                             <td>${mother_to_child_link_row.mc_case_number}</td>
                                             <td>${mother_to_child_link_row.mc_type_of_relationship}</td>
                                             <td>${mother_to_child_link_row.created_date}</td>
                                             <td>
                                                       <button type="button" id="btn-view-mother-Child-details"  data-job_number="${mother_to_child_link_row.mc_job_number}" data-case_number="${mother_to_child_link_row.mc_case_number}" data-transaction_number="[0, 0]" business_process_sub_name="-" data-toggle="modal" data-target="#transitional_certificate_template"  class="btn btn-primary btn-icon-split "  title="View Case Details" >
                                                         <span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>
                                                     </button> 
                                             </td>
                                          </tr>
                                      </c:forEach>
                     </tbody>
                 </table>
               </div> -->

               <div class="card card-body">
                <form id="linkSearchMotherfile"  method="post">
                    <div class="form-group">
                    <div class="custom-control custom-radio custom-control-inline">
                        <input type="radio" id="rbtn_search_type3" name="link_search_type" class="custom-control-input" value="job_number" required>
                        <label class="custom-control-label" for="rbtn_search_type3">Job number</label>
                      </div>
                      <div class="custom-control custom-radio custom-control-inline">
                        <input type="radio" id="rbtn_search_type4" name="link_search_type" class="custom-control-input" value="certificate_number" required>
                        <label class="custom-control-label" for="rbtn_search_type4">Certificate Number</label>
                      </div>
                    </div>
                  <br>
                  <div class="form-group">
                    <div class="form-row">
                    <!-- <label for="search_value">Search  by Case Number / Regional Number / Applicant Name / Job number /GLPIN</label> -->
                      <div class="col-md-8">
                        
                        <input class="form-control" id="link_search_value"  name="link_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
                      </div>
                      <div class="col-md-4">
                          
                        <button type="submit" class="btn btn-primary btn-block" value="Search" id="btnEnquiryJobSearch" > Search </button>
                        
                      </div>
                    </div>
                  </div>
                </form>
    
                <div class="card mb-3" style="display:none" id="link-search-results-section">
                    <div class="card-header">
                      <i class="fa fa-bar-chart"></i>Search Results</div>
                    <div class="card-body">
                    
                 
                    
                         <!--  Here is where the fee list comes -->
                         
                         <div class="table-responsive" >
                               <table class="table table-bordered " id="link-search-results-table">
                                  <thead>
                                    <tr>
                                     <th>Applicant Name</th>
                                      <th>Certificate Number</th>
                                      <th>Job Number</th>
                                      <th>Locality</th>
                                      
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
    
                </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="check_interest_and_sub_interest_mother_file" tabindex="-1"
  role="dialog" aria-labelledby="#check_interest_and_sub_interest_mother_file" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Check Interest and Sub Interest Mother File</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
           
            
                <div class="card card-body mb-3">
                    <form id="linkSearchMotherfile__"  method="post">
                        <div class="form-group">
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="rbtn_search_type10" name="link_search_type__" class="custom-control-input" value="job_number" required>
                            <label class="custom-control-label" for="rbtn_search_type10">Job number</label>
                          </div>
                          <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="rbtn_search_type11" name="link_search_type__" class="custom-control-input" value="certificate_number" required>
                            <label class="custom-control-label" for="rbtn_search_type11">Certificate Number</label>
                          </div>
                        </div>
                      <br>
                      <div class="form-group">
                        <div class="form-row">
                        <!-- <label for="search_value">Search  by Case Number / Regional Number / Applicant Name / Job number /GLPIN</label> -->
                          <div class="col-md-8">
                            
                            <input class="form-control" id="link_search_value__"  name="link_search_value__"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
                          </div>
                          <div class="col-md-4">
                              
                            <button type="submit" class="btn btn-primary btn-block" value="Search" id="btnEnquiryJobSearch" > Search </button>
                            
                          </div>
                        </div>
                      </div>
                    </form>
                </div>
                    <div class="card card-body mb-3" style="display:none" id="link-search-results-section__">
                      <div class="form-row">

                        <div class="col">	
                          <div class="form-group">
                            <label for="bl_job_number">Interest #</label> <input
                              class="form-control " type="text" 
                              id="chk_interest_number" readonly
                            >
                          </div>
                        </div>
            
                        <div class="col">	
                          <div class="form-group">
                            <label for="bl_job_number">Sub Insterest #</label> <input
                              class="form-control " type="text" 
                              id="chk_sub_interest_number" readonly
                            >
                          </div>
                        </div>
                        
                      </div>
                      </div>
        
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="link_to_mother_file" tabindex="-1"
  role="dialog" aria-labelledby="#link_to_mother_file" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Link to Mother File</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
           
            
                     <!-- Example Bar Chart Card-->
                   
               <input class="form-control" hidden id="linkedMotherFile" value="${mother_to_child_link_list}" />      
                <!-- Example Bar Chart Card-->
                        <div id="htmlLinkedMotherFile"></div>
                <div class="card card-body">
                    <form id="linkSearchMotherfile_"  method="post">
                        <div class="form-group">
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="rbtn_search_type7" name="link_search_type_" class="custom-control-input" value="job_number" required>
                            <label class="custom-control-label" for="rbtn_search_type7">Job number</label>
                          </div>
                          <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="rbtn_search_type8" name="link_search_type_" class="custom-control-input" value="certificate_number" required>
                            <label class="custom-control-label" for="rbtn_search_type8">Certificate Number</label>
                          </div>
                        </div>
                      <br>
                      <div class="form-group">
                        <div class="form-row">
                        <!-- <label for="search_value">Search  by Case Number / Regional Number / Applicant Name / Job number /GLPIN</label> -->
                          <div class="col-md-8">
                            
                            <input class="form-control" id="link_search_value_"  name="link_search_value_"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
                          </div>
                          <div class="col-md-4">
                              
                            <button type="submit" class="btn btn-primary btn-block" value="Search" id="btnEnquiryJobSearch" > Search </button>
                            
                          </div>
                        </div>
                      </div>
                    </form>
                </div>
                    <div class="card mb-3" style="display:none" id="link-search-results-section_">
                        <div class="card-header">
                          <i class="fa fa-bar-chart"></i>Search Results</div>
                        <div class="card-body">
                        
                     
                        
                             <!--  Here is where the fee list comes -->
                             
                             <div class="table-responsive" >
                                   <table class="table table-bordered " id="link-search-results-table_">
                                      <thead>
                                        <tr>
                                         <th>Applicant Name</th>
                                          <th>Certificate Number</th>
                                          <th>Job Number</th>
                                          <th>Locality</th>
                                          
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
        
               

      
      
    <div class="card card-body mt-2">
   <h5>Link Application to Mother File</h5>
   <hr>
        <div class="form-group">
      <div class="custom-control custom-radio custom-control-inline">
        <input type="radio" id="rbtn_search_type5" name="rbtn_search_type" class="custom-control-input" value="job_number" required>
        <label class="custom-control-label" for="rbtn_search_type5">Job number</label>
      </div>
      <div class="custom-control custom-radio custom-control-inline">
        <input type="radio" id="rbtn_search_type6" name="rbtn_search_type" class="custom-control-input" value="certificate_number" required>
        <label class="custom-control-label" for="rbtn_search_type6">Certificate Number</label>
      </div>
      <br>
      </div>
   

      <div class="row">
                                                        
<div class="col-md-8">
    <div class="form-group">
      
  <input class="form-control" id="lrd_search_for_mother_transction_to_child"  name="lrd_search_for_mother_transction_to_child"  type="text" value="" placeholder="Job Number of the Mother File" required >
   
    </div>
</div>


<!-- <div class="col-md-2">
    <div class="form-group">
     <button type="button" class="btn btn-primary" id="pvlmd_btn_search_by_certificate_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-retweet"></i> </button>

    </div>
</div> -->

<div class="col-md-4">
    <div class="form-group">
     <button type="button" class="btn btn-primary w-100" id="lrd_btn_search_for_mother_transction_to_child" data-placement="top" data-toggle="tooltip" title="Search">Link</button>

    </div>
</div>


</div>

</div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="confirm_otp_for_approval_certificate_old"
	tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<!-- <button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button> -->
				<h4 class="modal-title custom_align" id="Heading">Approve Transaction for this case</h4>
			</div>
			<div class="modal-body">

			
				<form id="frmVerification" autocomplete="off">
					<input type="hidden" id="ta_txt_ta_id_" name="ta_txt_ta_id" value="0">
					<input type="hidden" id="ta_txt_type_of_transaction_" name="ta_txt_type_of_transaction">
					<input type="hidden" id="ta_txt_business_process_sub_name_" name="ta_txt_business_process_sub_name">
					
					<div class="form-row">

						<div class="col">	
							<div class="form-group">
								<label for="bl_job_number">Job #</label> <input
									class="form-control " type="text" value="${job_number}"
									id="ta_txt_job_number_" readonly
								>
							</div>
						</div>

						<div class="col">	
							<div class="form-group">
								<label for="bl_job_number">Case #</label> <input
									class="form-control " type="text"  value="${case_number}"
									id="ta_txt_case_number_" readonly
								>
							</div>
						</div>
						
					</div>
					
					<!-- <div class="form-row"> -->
					 <div class="form-group">
							<label for="bl_ar_name">Message</label>
							<textarea rows="2" columns="2" class="form-control" placeholder=""
								id="ta_txt_transaction_details_" readonly
							></textarea>
						 </div> 
					<!-- </div> -->
				
							
							
								<div class="form-row">


									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code1_" maxlength="1" required
												autocomplete="off" data-index="3"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code2_" maxlength="1"  required
												autocomplete="off" data-index="4"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code3_" maxlength="1"  required
												autocomplete="off" data-index="5"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code4_" maxlength="1" required
												autocomplete="off" data-index="6"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code5_" maxlength="1" required
												autocomplete="off" data-index="7"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code6_" maxlength="1" required
												autocomplete="off" data-index="8"
											>
										</div>
									</div>

								</div>

								
								
								<!-- <br/> <br/> -->
								<div class="clearfix"></div>
							</form>

							<div class="alert alert-danger">
								<span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to Approve this transaction?
							</div>

							

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success"
					id="btn_final_registration_approval_dialog_"
				>
					<span class="glyphicon glyphicon-ok-sign"></span>Approve
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="preview_certificate" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Preview Certificate</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="row mt-2">
                <div class="col-md-12">
    
                    <input type="button" id="lc_btn_activate_final_certificate_" class="btn btn-primary btn-block w-100" value="View Certificate" />  
    
                    <!-- 																	 
                    <input type="button" id="lc_btn_activate_provisional_certificate" class="btn btn-warning btn-block" value="Generate Provisional Certificate" />  
                    -->
                </div>
            </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="review_instruction_with_request" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Review Instruction With Request</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="row mt-2">
                <div class="col-md-12">

                  <textarea class="form-control" readonly rows="10">${review_instruction}</textarea>
    
                </div>
            </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="send_a_message_to_client_" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Send a Message to Client</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="row mt-2">
                <div class="col-md-12">
    
                    <input type="button" id="lc_btn_send_a_message_to_client" class="btn btn-primary btn-block w-100" value="Send Message" />  
    
                    <!-- 																	 
                    <input type="button" id="lc_btn_activate_provisional_certificate" class="btn btn-warning btn-block" value="Generate Provisional Certificate" />  
                    -->
                </div>
            </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade show" id="send_a_message_to_client" tabindex="-1" role="dialog" aria-labelledby="viewFileListModal" aria-modal="true">
    <div class="modal-dialog modal-md ui-draggable">
       <div class="modal-content">
          <div class="modal-header ui-draggable-handle">
             <h5 class="modal-title" id="">Cabinet Job Applications</h5>
             <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
          </div>
          <div class="modal-body">
             <form>
                
                <!-- <div class="container"> -->
                   <div class="col-sm-12 col-xs-12">
                      <!-- <div class="form-group"> -->
                      
                          <!-- <div class="form-group row">
                             <div class="col-sm-12">
  -->
                                 
                                     <div class="form-row" style="background-color:#32a852; padding:15px; " id="cabinet-batching">
                                        <div class="col-12"><h5 style="" class="text-white">Batching to Cabinet</h5></div>
                                        <br>
                                            
                                         <div class="col-md-4">
                                             <label for="" class="col-form-label text-white">Cabinet Name :</label>
                                         </div>
                                         <div class="col-md-8">
                                             <input class="form-control" type="text" id="cabinet_to_send_to" required="">
                                         </div>
                                            
                                        
                                     </div>
                                     <div class="form-group">
                                        <label for="" class="col-form-label">Applicant Name:</label>
                                          <input type="text" class="form-control" value="${ar_name}" readonly />
                                    </div>
                                    <div class="form-group">
                                        <label for="" class="col-form-label">Job Number:</label>
                                          <input type="text" class="form-control" value="${job_number}" readonly  />
                                    </div>
                                    <div class="form-group">
                                        <label for="" class="col-form-label">Locality:</label>
                                          <input type="text" class="form-control" value="${locality}" readonly />
                                    </div>
                                     
                             <!-- </div>
                             
                         </div> -->
                          
                         
                         
                      <!-- </div> -->
                   </div>
                <!-- </div> -->
            </form>
                
                <div class="modal-footer">
                 <button type="button" class="btn btn-primary" id="btn_process_completed_app_cabinet">Process</button>
                 <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                 </div>
             
          </div>
       </div>
    </div>
 </div>

 <div class="modal fade" id="viewFileListModal" tabindex="-1"
   role="dialog" aria-labelledby="viewFileListModal" aria-hidden="true">
   <div class="modal-dialog modal-xl">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="">Request List Processing</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
         </div>
         <div class="modal-body">
            <form >
               <%-- <input id="bl_modified_by" name="bl_modified_by" type="hidden" value="${fullname}"> 
               <input id="bl_modified_by_id" name="bl_modified_by_id" type="hidden" value="${userid}"> --%>
               <div class="container">
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                     
                     	<div class="form-group row">
							
							<div class="col-sm-4">
							<label class="col-form-label" style="text-align: right"><h2>Send Request To :</h2></label>
								<div class="input-group">
									<div id="radioBtnBatching" class="btn-group ">
										<a class="btn btn-primary btn-sm notActive" data-toggle="batch_type" data-title="Unit"><h2>A Unit</h2></a> 
										<a class="btn btn-primary btn-sm notActive" data-toggle="batch_type" data-title="Individual"><h2>An Individual</h2></a>
									</div>
									<input type="hidden" name="batch_type" id="batch_type">
								</div>
							</div>
							<div class="col">
								<div class="form-row" id="rs_unit-batching" style="background-color:#123456; padding:15px; display:none">
									<div class="col-12"><h4 style="" class="text-white">Sending to a Unit</h4></div>
								    <div class="col">
								      <label for="" class="col-form-label">Division :</label>
		                              <select id="unit_division_to_send_to" class="form-control" >
		                                 <option value="none">---Select Division---</option>
		                                 <!-- ${division == "CORPORATE" ? "" : "<option value='LVD'>LVD</option>"}
		                                 ${division == "CORPORATE" ? "" : "<option value='LRD'>LRD</option>"}
		                                 ${division == "CORPORATE" ? "" : "<option value='PVLMD'>PVLMD</option>"}
		                                 ${division == "CORPORATE" ? "" : "<option value='SMD'>SMD</option>"}
		                                 ${division == "CORPORATE" ? "" : "<option value='RLO'>RLO</option>"}
										 ${division == "CORPORATE" ? "<option value='CORPORATE'>CORPORATE</option>" : ""} -->
										 <option value='LVD'>LVD</option>
		                                 <option value='LRD'>LRD</option>
		                                 <option value='PVLMD'>PVLMD</option>
		                                 <option value='SMD'>SMD</option>
		                                 <option value='RLO'>RLO</option>
										 <option value='CORPORATE'>CORPORATE</option>
		                              </select>
								      
								    </div>
								    <div class="col">
								    <label for="" class="col-form-label">Unit :</label>
								      <input autocomplete="off" class="form-control" id="rs_unit_to_send_to"  type="text"  list="listofunitsbatching" class=""  placeholder="Select/Enter Unit" required  >
		                              <datalist id="listofunitsbatching"></datalist>
								    </div>
								</div>
								
								<div class="form-row"  style="background-color:#654321; padding:15px; display:none" id="rs_individual-batching" >
                                    <div class="col-12"><h4 style="" class="text-white">Sending to an Individual</h4></div>
                                    <div class="col-sm-3">
                                       <label for="" class="col-form-label text-light">Division/Unit :</label>
                                       <!-- <select id="division_to_send_to" class="form-control" >
                                          <option value="none">---Select Division---</option>
                                          <option value="CSAU">CSAU</option>
                                          <option value="LVD">LVD</option>
                                          <option value="LRD">LRD</option>
                                          <option value="PVLMD">PVLMD</option>
                                          <option value="SMD">SMD</option>
                                            <option value="RLO">RLO</option>
                                       </select> -->
                                       <input class="form-control" type="text" value="${unit_name}" id="division_to_send_to" readonly>
                                    </div>
                                    <div class="col-sm-9">
                                       <label for="" class="col-form-label text-light">User :</label>
                                       <!-- <select id="user_to_send_to" class="form-control" >
                                          </select> -->
                                       <input class="form-control" id="rs_user_to_send_to"  name="user_to_send_to" type="text" autocomplete="off" 
                                          list="listofusersbatching" class="autocomplat"  placeholder="Enter Username" required  onmousedown="value = '';" >
                                       <datalist id="listofusersbatching"></datalist>
                                    </div>
                                 </div>
								
								
							  &nbsp;
							</div>
						</div>
                     	
                        
                        
                     </div>
                  </div>
               </div>
               <BR>
               <div class="container">
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                        <table id="FileListdataTable"
                           class="table table-bordered table-hover"></table>
                     </div>
                  </div>
               </div>
               <br> <br> <br>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary d-none"
                     data-dismiss="modal">Close</button>
                  <button type="button" id="apbtn_process_request_list"  class="btn btn-primary" >Process List</button>
               </div>
            </form>
         </div>
      </div>
   </div>
</div>

<div class="modal fade" id="archive_application" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Archive Application</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="row mt-2">
                <div class="col-md-12">
    
                    <input type="button" id="" class="btn btn-primary btn-block w-100" value="Archive" />  
    
                    <!-- 																	 
                    <input type="button" id="lc_btn_activate_provisional_certificate" class="btn btn-warning btn-block" value="Generate Provisional Certificate" />  
                    -->
                </div>
            </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="enter_details_for_collection_and_print_collection" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Enter Details for Collector</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <form id="frmSaveCollection">
                <!-- <h3 class="border-bottom border-gray pb-2">Collection Checklist</h3>
                <div class="">
                    <table class="table table-bordered" id="collection-checklist"  >
                        <thead>
                            <tr>
                                <th>Description</th>
                                <th>Confirm</th>
                            </tr>
                        </thead>
                        <tbody></tbody>

                    </table>
                
                </div>
                <br>
                
                <br>
                <h3 class="border-bottom border-gray pb-2">Details Confirmation</h3> -->
                 <div class="form-group row">
                    <label class="col-sm-3 col-form-label">Collected by: </label>
                    <div class="col-sm-9">
                      <input type="text"  required class="form-control" id="col_collected_by">
                    </div>
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-3 col-form-label">ID Type: </label>
                    <div class="col-sm-9">
                        <select id="col_id_type" required  class="form-control" >
                            <option value="NATIONAL ID">NATIONAL ID</option>
                            <option value="PASSPORT">PASSPORT</option>
                            <option value="DRIVERS LICENSE">DRIVERS LICENSE</option>
                            <option value="NHIS CARD">NHIS CARD</option>
                            <option value="VOTERS ID">VOTERS ID</option>
                            <option value="SSNIT ID CARD">SSNIT ID CARD</option>
                        </select>
                    </div>
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-3 col-form-label">ID Number: </label>
                    <div class="col-sm-9">
                      <input type="text" required  class="form-control" id="col_id_number">
                    </div>
                  </div>
                  <div class="form-group row mb-2">
                    <label class="col-sm-3 col-form-label">Phone Number: </label>
                    <div class="col-sm-9">
                      <input type="text" required  class="form-control" id="col_phone_number">
                    </div>
                  </div>
                  <a href="#" style="text-decoration: underline;" data-toggle="modal" data-target="#publicFileUploadModal">
                     Click here to attach collector's document
                  </a>
                  
                  <div class="form-group row mt-4">
                    <!-- <label class="col-sm-5 col-form-label">&nbsp; </label> -->
                    <div class="col-sm-12">
                      <input type="submit" value="Save" class="btn btn-lg btn-primary" style="width:100%">
                    </div>
                  </div>
                  
                
            </form>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="confirm_otp_for_approval_register_old"
	tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<!-- <button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button> -->
				<h4 class="modal-title custom_align" id="Heading">Approve Transaction for this case</h4>
			</div>
			<div class="modal-body">

			
				<form id="frmVerification" autocomplete="off">
					<input type="hidden" id="ta_txt_ta_id__" name="ta_txt_ta_id" value="0">
					<input type="hidden" id="ta_txt_type_of_transaction__" name="ta_txt_type_of_transaction">
					<input type="hidden" id="ta_txt_business_process_sub_name__" name="ta_txt_business_process_sub_name">
					
					<div class="form-row">

						<div class="col">	
							<div class="form-group">
								<label for="bl_job_number">Job #</label> <input
									class="form-control " type="text" value="${job_number}"
									id="ta_txt_job_number__" readonly
								>
							</div>
						</div>

						<div class="col">	
							<div class="form-group">
								<label for="bl_job_number">Case #</label> <input
									class="form-control " type="text"  value="${case_number}"
									id="ta_txt_case_number__" readonly
								>
							</div>
						</div>
						
					</div>
					
					<!-- <div class="form-row"> -->
					 <div class="form-group">
							<label for="bl_ar_name">Message</label>
							<textarea rows="2" columns="2" class="form-control" placeholder=""
								id="ta_txt_transaction_details__" readonly
							></textarea>
						 </div> 
					<!-- </div> -->
				
							
							
								<div class="form-row">


									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code1__" maxlength="1" required
												autocomplete="off" data-index="3"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code2__" maxlength="1"  required
												autocomplete="off" data-index="4"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code3__" maxlength="1"  required
												autocomplete="off" data-index="5"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code4__" maxlength="1" required
												autocomplete="off" data-index="6"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code5__" maxlength="1" required
												autocomplete="off" data-index="7"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code6__" maxlength="1" required
												autocomplete="off" data-index="8"
											>
										</div>
									</div>

								</div>

								
								
								<!-- <br/> <br/> -->
								<div class="clearfix"></div>
							</form>

							<div class="alert alert-danger">
								<span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to Approve this transaction?
							</div>

							

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success"
					id="btn_final_registration_approval_dialog__"
				>
					<span class="glyphicon glyphicon-ok-sign"></span>Approve
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="confirm_otp_for_approval_mortgage"
	tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<!-- <button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button> -->
				<h4 class="modal-title custom_align" id="Heading">Approve Transaction for this case</h4>
			</div>
			<div class="modal-body">

			
				<form id="frmVerification" autocomplete="off">
					<input type="hidden" id="ta_txt_ta_id___" name="ta_txt_ta_id" value="0">
					<input type="hidden" id="ta_txt_type_of_transaction___" name="ta_txt_type_of_transaction">
					<input type="hidden" id="ta_txt_business_process_sub_name___" name="ta_txt_business_process_sub_name">
					
					<div class="form-row">

						<div class="col">	
							<div class="form-group">
								<label for="bl_job_number">Job #</label> <input
									class="form-control " type="text" value="${job_number}"
									id="ta_txt_job_number___" readonly
								>
							</div>
						</div>

						<div class="col">	
							<div class="form-group">
								<label for="bl_job_number">Case #</label> <input
									class="form-control " type="text"  value="${case_number}"
									id="ta_txt_case_number___" readonly
								>
							</div>
						</div>
						
					</div>
					
					<!-- <div class="form-row"> -->
					 <div class="form-group">
							<label for="bl_ar_name">Message</label>
							<textarea rows="2" columns="2" class="form-control" placeholder=""
								id="ta_txt_transaction_details___" readonly
							></textarea>
						 </div> 
					<!-- </div> -->
				
							
							
								<div class="form-row">


									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code1___" maxlength="1" required
												autocomplete="off" data-index="3"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code2___" maxlength="1"  required
												autocomplete="off" data-index="4"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code3___" maxlength="1"  required
												autocomplete="off" data-index="5"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code4___" maxlength="1" required
												autocomplete="off" data-index="6"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code5___" maxlength="1" required
												autocomplete="off" data-index="7"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code6___" maxlength="1" required
												autocomplete="off" data-index="8"
											>
										</div>
									</div>

								</div>

								
								
								<!-- <br/> <br/> -->
								<div class="clearfix"></div>
							</form>

							<div class="alert alert-danger">
								<span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to Approve this transaction?
							</div>

							

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success"
					id="btn_final_registration_approval_dialog___"
				>
					<span class="glyphicon glyphicon-ok-sign"></span>Approve
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

  <div class="modal fade" id="further_entry" tabindex="-1"
     role="dialog" aria-labelledby="#further_entry" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
           <div class="modal-header">
              <h5 class="modal-title" id="">Further Entry</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           </div>
           <div class="modal-body">
           
            <form id='frmFurtherEntries_only_'>
                <div class="form-row"></div>
                <div class="form-row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="inputEmail4">Job Number</label> <input
                                type="text" class="form-control" id="fe_job_number"
                                placeholder="Job number" required readonly value="${job_number}"
                            >
                        </div>
                        
                        
                        <input id="fe_client_name" type=hidden value="${ar_name}" >
                        <input id="fe_business_process_sub_name" type=hidden value="${business_process_sub_name}" >
                        
                        
                        <div class="form-group">
                            <label for="">Surveyors Number</label> <input type="text"
                                class="form-control" id="fe_surveyor_number"
                                placeholder="Surveyors Number"    value="${surveyor_number}"
                            >
                        </div>
                        <div class="form-group">
                            <label for="">Regional Number</label> <input type="text"
                                class="form-control" id="fe_regional_number"
                                placeholder="Regional Number"   value="${regional_number}"
                            >
                        </div>


                        <div class="form-group">
                            <label for="">Land Size</label> 
                            
                            <div class="input-group">
                                <div class="input-group-prepend">
                                  <span class="input-group-text" id="inputGroupPrepend">Acre</span>
                                </div>
                                <input value="${size_of_land}" step="0.111" type="text" class="form-control" id="fe_land_size" placeholder="size in Acreage" aria-describedby="inputGroupPrepend" >
                                <div class="invalid-feedback">
                                  Please enter Land Size.
                                </div>
                              </div>
                        </div>

                        <div class="form-group">
                            
                            
                            <label for="">Nature of Instrument</label> <input type="text"
                                class="form-control" id="fe_nature_of_instrument"
                                   value="${nature_of_instrument}"
                            >
                        </div>

            <div class="form-group">
                            


                        <label for="">Type of Use</label> <input type="text"
                                class="form-control" id="fe_type_of_use"
                                   value="${type_of_use}"
                            >

                        </div>


                        <div class="form-group">
                            <label for="">Type of Interest</label> <select value="${type_of_interest}"
                                class="form-control" id="fe_type_of_interest" required
                            >
                                <option >Select Type of Interest</option>
                                <option ${type_of_interest=="LEASEHOLD" ? "selected" : ""}>LEASEHOLD</option>
                                <option ${type_of_interest=="FREEHOLD" ? "selected" : ""}>FREEHOLD</option>
                            </select>


                        </div>

                        
                        <div class="form-group">
                            <label for="">Consideration Currency</label> 
                            <select class="form-control" id="fe_consideration_currency" required>
                                <option value="GHS" ${consideration_fee_currency=="GHS" ? "selected":"" }>Ghana Cedis</option>
                                <option value="USD" ${consideration_fee_currency=="USD" ? "selected":"" }>US Dollars</option>
                                <option value="GBP" ${consideration_fee_currency=="GBP" ? "selected":"" }>Pound sterling</option>
                                <option value="EUR" ${consideration_fee_currency=="EUR" ? "selected":"" }>Euro</option>
                            </select>
                            
                            
                        </div>
                        <div class="form-group">
                            <label for="">Date of Document </label> <input type="date"
                                class="form-control " id ="fe_date_of_document" placeholder=""
                                required value="${date_of_document}"
                            >
                        </div>
                        <div class="form-group">
                            <label for="">Commencement Date</label> <input type="date"
                                class="form-control " id ="fe_commencement_date"
                                placeholder="" required value="${commencement_date}"
                            >
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="inputEmail4">Case Number</label> <input
                                type="text" class="form-control" id="fe_case_number"
                                placeholder="Case number" required readonly  value="${case_number}"
                            >
                        </div>

                        <div class="form-group">
                            <label for="">Locality</label> <input type="text" class="form-control"
                                id="fe_locality" required  value="${locality}"
                            >
                                

                        </div>
                        <div class="form-group">
                            <label for="">District</label> <input type="text" class="form-control"
                                id="fe_district" required  value="${district}"
                            >
                                

                        </div>
                        <div class="form-group">
                            <label for="">Region</label> <input type="text" class="form-control"
                                id="fe_region" required  value="${region}"
                            >
                                

                        </div>


                        <div class="form-group">
                            <label for="inputEmail4">Term </label> <input type="number"
                                class="form-control" id="fe_term" placeholder="Term" value="${term}"
                                required
                            >
                        </div>
                        <div class="form-group">
                            <label for="">Option to Renew</label> <input type="text"
                                class="form-control" id="fe_renewal_term" placeholder=""
                                required value="${renewal_term}"
                            >
                        </div>
                        <!-- <div class="form-group">
                            <label for="">Lessee's Name</label> <input
                                type="text"
                                class="form-control"
                                id="fe_lessee_name"
                                placeholder=""
                                required
                            >
                        </div>
                        <div class="form-group">
                            <label for="">Lesse's Address</label> <input
                                type="text"
                                class="form-control"
                                id="fe_lessee_address"
                                placeholder=""
                                required
                            >
                        </div>
                        <div class="form-group">
                            <label for="">Grantor's Name</label> <input
                                type="text"
                                class="form-control"
                                id="fe_grantor_name"
                                placeholder=""
                                required
                            >
                        </div>
                        <div class="form-group">
                            <label for="">Grantor's Address</label> <input
                                type="text"
                                class="form-control"
                                id="fe_grantor_address"
                                placeholder=""
                                required
                            > 
                        </div>-->

                        <input type="hidden"
                                class="form-control" id="fe_family_name"
                                placeholder="Stool/Family Name" required 
                            >
                        

                        <input type="hidden"
                                class="form-control" id="fe_grantor_family" placeholder=""
                                required
                            >

                        <div class="form-group">
                            <label for="">Extent</label> <input type="text"
                                class="form-control" id="fe_extent" placeholder="" required value="${extent}"
                            > 
                        </div>


                        <div class="form-group">
                        
                        
                            <label for="">Consideration Fee</label> 
                              <div class="input-group">
                                <div class="input-group-prepend">
                                  <span class="input-group-text" id="inputGroupPrependConsideration">${consideration_fee_currency}</span>
                                </div>
                                <input value="${consideration_fee}" type="number" class="form-control" id="fe_consideration_fee"  placeholder="amount in GHS" aria-describedby="inputGroupPrepend" required>
                                <div class="invalid-feedback">
                                  Please enter Consideration.
                                </div>
                              </div>
                            
                        
                        
                        </div>
                        <div class="form-group">
                            
                            <label for="">Annual Rent</label> 
                            
                            <div class="input-group">
                                <div class="input-group-prepend">
                                  <span class="input-group-text" id="inputGroupPrepend">GHS</span>
                                </div>
                                <input value="${annual_rent}" type="number" class="form-control" id="fe_annual_rent"  placeholder="amount in GHS" aria-describedby="inputGroupPrepend" required>
                                <div class="invalid-feedback">
                                  Please enter Rent.
                                </div>
                              </div>
                        </div>
                        
                        
                        <div class="form-group">
                            <label for="inputEmail4">Transaction Number</label> <input
                                type="text" class="form-control" id="fe_transaction_number"
                                placeholder="Case number" required readonly value="${transaction_number}"
                            >
                        </div>

                    </div>


                </div>



                <div class="dropdown-divider"></div>
                <div id="alert-display-space"></div>

                <button type="button" class="btn btn-secondary "
               data-dismiss="modal">Close</button>
               <button type="submit" id="btnAddFurtherDetails"
										class="btn btn-success float-right"
									>Save Changes</button>

            </form>
              
           </div>
           <!-- <div class="modal-footer">
            
         </div> -->
        </div>
     </div>
  </div>



  <div class="modal map-modal fade" id="visualise_and_confirm" tabindex="-1"
     role="dialog" aria-labelledby="#visualise_and_confirm" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
           <div class="modal-header">
              <h5 class="modal-title" id="">Visualise and Confirm</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           </div>
           <div class="modal-body">
           
                          <!--  The Form starts here -->
                         <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
                  
       <!-- Maps Details Starts Here  -->
       
         <div class="form-group">
                                   <div class="form-row">  <label for="lc_bl_wkt_polygon">WKT Polygon</label>
                                         <input class="form-control" id="lc_bl_wkt_polygon"  name="lc_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
           
                                       <!-- <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" ></textarea> -->
                                   </div>
                                   
                             
                                </div>
    

       
       <div class="bs-example">
       
    
       
       
       

                   <div class="btn-group mr-2">
                   


<button type="button" class="btn btn-primary"  id="lc_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-map"></i>
</button>
<!--  
<button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
<i class="fa fa-save"></i>
</button>
-->

<button type="button" class="btn btn-primary" id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
<i class="fa fa-object-ungroup"></i>
</button>




<button type="button" class="btn btn-primary" id="lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-print"></i>
</button>


<div class="btn-group">
Scale:
</div>
<div class="btn-group">
<input class="form-control" id="lc_scale_value_e"  name="lc_scale_value_e" type="text" class="autocomplat" />


<select name="lc_scale_value" id="lc_scale_value">
<option value="500">500</option>
<option value="1107">1107</option>
<option value="1250">1250</option>
<option value="2500">2500</option>
<option value="2140">2140</option>
<option value="2670">2670</option>
<option value="2215">2215</option>
<option value="2825">2825</option>
<option value="5000">5000</option>
<option value="10000">10000</option>
<option value="15000">15000</option>
<option value="20000">20000</option>

</select>


<!-- <datalist id="scalelist">
<option>500</option>
<option>1107</option>
<option>1250</option>
<option>2500</option>
<option>2140</option>
<option>2670</option>
<option>2215</option>
<option>2825</option>
<option>5000</option>
<option>10000</option>
<option>15000</option>
<option>20000</option>
</datalist> -->
</div>

<div class="btn-group mr-2">
<input type="checkbox" checked="checked" id="lc_lockmapscale">
<button type="button" class="btn btn-primary" id="lc_btn_scale_zoom" data-placement="top" data-toggle="tooltip" title="Zoom to Scale">
<i class="fa fa-search"></i>
</button>
</div>



  </div> 








</div>


  
       
       
       
        <div class="map-container" id="lc-map_" ></div>
        
            <!--  Here is where the fee list comes -->


                             
                         </form>
                       
                     


           </div>
           <div class="modal-footer">
            <button type="button" class="btn btn-secondary "
               data-dismiss="modal">Close</button>
         </div>
        </div>
     </div>
  </div>


 
  <div class="modal fade" id="send_to_frrv" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Send To FRRV</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row mb-1">
					<!-- <label for="bl_job_number">Job Number </label>  -->
					<div class="col-md-12">
						<div class="form-group">
							<input
								class="form-control " type="text" readonly
								id="send_ffrv_job_number" placeholder="Job Number" value="${job_number}"
							>
						</div>
					</div>
					<!-- <div class="col-md-2">
						
					</div> -->
				</div>

                <button class="btn btn-success w-100" id="btn_send_to_frrv"><i class="fas fa-envelope mr-1"></i>Send</button>
                <div class="mt-2">
                    <a href="#" style="text-decoration: underline;" data-target="#fileUploadModal" data-toggle="modal">
                        Upload Existing Records Information
                    </a>
                </div>

                <div class="card card-body mt-3">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><b>LRD: </b> <h5 id="send_lrd_badge_ffrv_v"></h5></li>
                        <li class="list-group-item"><b>SMD: </b> <h5 id="send_smd_badge_ffrv_v"></h5></li>
                        <li class="list-group-item"><b>PVLMD: </b> <h5 id="send_pvlmd_badge_ffrv_v"></h5></li>
                      </ul>
                </div>
				


			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<!-- <button type="button" id="btn_update_app_status_ffrv" style="display:none"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Confirm Final Approval</span>
				</button> -->

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="enter_root_of_title" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Root of Title</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                <h5 class="text-primary"><b>Proprietorship Details</b></h5>
                <div  class="table w-auto small table-responsive mt-2">
                    <table class="table table-bordered" id="lrd_proprietorship_details_dataTable" >
                    
                     <thead>
                         <tr>
                             <!-- <th>approval_status</th> -->
                              <th>Registered No.</th>
                              <th>Proprietors</th>
                              <th>Date of Instrument</th>
                              <th>Nature of Instrument</th>
                              <th>Date of Regsitration</th>
                              <th>Parties</th>
                              <th>Price Paid</th>
                              <th>Remarks</th>
                              <th>Term</th>
                            <th>Action</th>
                            <!--   <th>Approve</th> -->
                           </tr>
                       </thead>
                       
                         <tbody>
                              <c:forEach items="${lrd_proprietorship_section}" var="proprietorship_section">
                                     <tr>
                                    <!-- <td>${proprietorship_section.approval_status}</td> -->
                                 <td>${proprietorship_section.ps_registration_number}</td>
                                 <td>${proprietorship_section.ps_proprietor}</td>
                                 <td>${proprietorship_section.ps_date_of_instrument}</td>
                                 <td>${proprietorship_section.ps_nature_of_instrument}</td>
                                 <td>${proprietorship_section.ps_date_of_registration}</td>
                                 <td>${proprietorship_section.ps_transferor} - ${proprietorship_section.ps_transferee}</td>
                                 <td>${proprietorship_section.ps_price_paid}</td>
                                 <td>${proprietorship_section.ps_remarks}</td>
                                 <td>${proprietorship_section.ps_term}</td>

                                 <td>
                                     <p data-placement="top"  title="Edit">  
                                         <button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
                                              data-target="#newProprietorshipModal"
                                              data-target-id="${proprietorship_section.ps_id}"
                                               data-ps_id="${proprietorship_section.ps_id}"  
                                              data-ps_case_number="${proprietorship_section.ps_case_number}"
                                              data-ps_registration_number="${proprietorship_section.ps_registration_number}"
                                              data-ps_proprietor="${proprietorship_section.ps_proprietor}"
                                              data-ps_date_of_instrument="${proprietorship_section.ps_date_of_instrument}"
                                              data-ps_nature_of_instrument="${proprietorship_section.ps_nature_of_instrument}"
                                              data-ps_date_of_registration="${proprietorship_section.ps_date_of_registration}"
                                              data-ps_transferor="${proprietorship_section.ps_transferor}"
                                              data-ps_transferee="${proprietorship_section.ps_transferee}"
                                              data-ps_price_paid="${proprietorship_section.ps_price_paid}"
                                              data-ps_remarks="${proprietorship_section.ps_remarks}"
                                              data-ps_signature="${proprietorship_section.ps_signature}"
                                              data-ps_term="${proprietorship_section.ps_term}"
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
                   
                   <h5 class="text-danger"><b>Memorial Details</b></h5>
                   <div  class="table w-auto small mt-2">
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
                <h5 class="text-success"><b>Reservation Details</b></h5>
                <div  class="table w-auto small table-responsive">
                    <table class="table table-bordered" id="lrd_reservation_details_dataTable">
                    
                       <thead>
                         <tr>
         
                          <th>Reservation Description</th>
                          <th>Created By</th>
                          <th>Created On</th>
                          
                            <th>Action</th>
                           </tr>
                       </thead>
                       
                         <tbody>
              <c:forEach items="${lrd_reservation_section}" var="reservation_section">
             <tr>
                 <td>${reservation_section.reservation_description}</td>
                 <td>${reservation_section.modified_by}</td>
                 <td>${reservation_section.created_date}</td>
                 <!-- <td>${certificate_section.cs_official_notes}</td> -->
                 <td>
                                         
                                         <p data-placement="top"  title="Edit">  
                                               <button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
                                                    data-target="#newReservationModal"
                                                    data-rs_id="${reservation_section.rs_id}"
                                                    data-rs_reservation_description="${reservation_section.reservation_description}"  
                                                    data-rs_case_number="${reservation_section.case_number}"
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
                   <h5 class="text-warning"><b>Encumberances Details</b></h5>
		  
				  <div  class="able w-auto small table-responsive">
				<table class="table table-bordered" id="lrd_registration_encumbrance_dataTable">
					   
					<thead>
					  <tr>
  <!-- 	es_id -->
					   <th>Registered Number</th>
					   <th>Date of Instrument</th>
					   <th>Date of Registration</th>
					   <th>Memorials</th>
					   <th>Remarks</th>
					   <th>Entry No.</th>
					   <th>Action</th>
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
							  <td>${lrd_encumbrances_section_row.es_entry_number}</td>
							  <td>
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
								  data-es_entry_number="${lrd_encumbrances_section_row.es_entry_number}"
								  data-es_action_on_form_encumbrances="edit"
								  >
								  <span class="icon text-white-50"> 
									  <i class="fas fa-pen"></i></span> <span class="text">Edit</span>
								  </button>
							  </td>
						   </tr>
					   </c:forEach>
						</tbody>
  
				  
				  </table>
			  </div>
                   <div class="card card-body">
                    <div class="form-row">
                        <div class="col-md-12">
                          <label for="search_value">Register: Description of Land</label>
                           
                          
                           
                              <textarea id="lc_description_of_land_lrd" name="lc_description_of_land_lrd" class="form-control col-sm-12" required rows=5  style="padding:10px !important;">${smd_region} </textarea> 
                          
                          
                         <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
           --%>
                                                      
                          </div>
                          
                         
                       
                      </div>
    
                      <div class="form-row">
                                                      
                        <!-- <div class="col-4">
                                <br>									                 
                                     
                                         <button type="button" name="btn_compose_register_description" id="btn_compose_register_description" class="btn  btn-primary btn-icon-split "  >
                                      <span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
                                  </button>
                                  
                              
                          </div> -->
                          
                           <div class="col-6">
                                    <br>
                                  
                                     <button type="button" name="lc_btn_save_register_description" id="lc_btn_save_register_description" 
                                     class="btn btn-block btn-secondary btn-icon-split "  >
                                       <span class="icon text-white-50"> <i class="fas fa-save"></i></span><span class="text">Save Register</span>
                                  </button>
                          
                          </div>

                          <div class="col-6">
                            <br>
                          
                             <button type="button" name="lc_btn_save_register_description" id="lc_btn_activate_final_register_" 
                             class="btn btn-block btn-success btn-icon-split "  >
                               <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Generate Register</span>
                          </button>
                  
                  </div>
                          
                        
                        </div>
                </div>
			</div>
			<div class="modal-footer ">

				
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="verify_frrv" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-md modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Records Verification (FRRV)</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row mb-3">
					<!-- <label for="bl_job_number">Job Number </label>  -->
					<div class="col-md-10">
						<div class="form-group">
							<input
								class="form-control " type="text" readonly
								id="verify_ffrv_job_number" placeholder="Job Number" value="${job_number}"
							>
						</div>
					</div>
					<div class="col-md-2">
						<button class="btn btn-success" id="_verify_ffrv_application_status"><i class="fas fa-search"></i></button>
					</div>
				</div>

				<ul class="list-group list-group-flush">
					<li class="list-group-item"><b>LRD: </b> <h5 id="_html_lrd_badge_ffrv_v"></h5></li>
					<li class="list-group-item"><b>SMD: </b> <h5 id="_html_smd_badge_ffrv_v"></h5></li>
					<li class="list-group-item"><b>PVLMD: </b> <h5 id="_html_pvlmd_badge_ffrv_v"></h5></li>
				  </ul>


			</div>
			<div class="modal-footer ">

				
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="compose_certificate" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Compose Certificate</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                <!-- <div class="card card-body">
                    <div class="form-row">
                        <div class="col-md-12">
                          <label for="search_value">Register: Description of Land</label>
                           
                          
                           
                              <textarea id="lc_description_of_land_lrd" name="lc_description_of_land_lrd" class="form-control col-sm-12" required rows=5  style="padding:10px !important;">${smd_region} </textarea> 
                          
                          
                         <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
           --%>
                                                      
                          </div>
                          
                         
                       
                      </div>
    
                      <div class="form-row">
                                                      
                        <div class="col-4">
                                <br>									                 
                                     
                                         <button type="button" name="btn_compose_register_description" id="btn_compose_register_description" class="btn  btn-primary btn-icon-split "  >
                                      <span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
                                  </button>
                                  
                              
                          </div>
                          
                           <div class="col-4">
                                    <br>
                                  
                                     <button type="button" name="lc_btn_save_register_description" id="lc_btn_save_register_description" 
                                     class="btn btn-block btn-secondary btn-icon-split "  >
                                       <span class="icon text-white-50"> <i class="fas fa-save"></i></span><span class="text">Save Register</span>
                                  </button>
                          
                          </div>

                          <div class="col-4">
                            <br>
                          
                             <button type="button" name="lc_btn_save_register_description" id="lc_btn_activate_final_register_" 
                             class="btn btn-block btn-success btn-icon-split "  >
                               <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Generate Register</span>
                          </button>
                  
                  </div>
                          
                        
                        </div>
                </div> -->
                <div class="card card-body d-none mb-3" id="cert_type_for_reg">
                  <div class="form-group">
                    <label for="job_number">Certificte Type</label>
                    <select name="lc_txt_type_of_certificate_" id="lc_txt_type_of_certificate_" class="form-control input-sm" data-style="btn-info" required data-live-search="true">
                        <option value="${certificate_type == 'Individual' ? '' : certificate_type}">${certificate_type == 'Individual' ? '-- select --' : certificate_type}</option>
                        <option value="Provisional Certificate">Provisional Certificate</option>
                        <option value="Land Certificate">Land Certificate</option>
                        <option value="Substituted Certificate">Substituted Certificate</option>
                    </select> 
                </div>
                <div class="form-group">
                    <label for="" class="col-form-label">Certificate Number:</label>
                      <input type="text" class="form-control" id="lc_txt_certificate_number_" readonly value="${certificate_number}" />
                </div>
                <div class="mt-3">
                    <input type="button" id="btn_save_lrd_certificate_update_details_" 
                    class="btn btn-primary btn-block w-100" 
                    value="Update" 
                    />  
                 </div>
                </div>
                <div class="card card-body">
                    <div class="form-row">
                        <div class="col-md-12">
                          <label for="search_value">Certificate Summary</label>
                           
                          
                           
                              <textarea id="lc_search_report_summary_details" name="lc_search_report_summary_details" class="form-control col-sm-12" required rows=7  style="padding:50px !important;">${remark_or_comment} </textarea> 
                          
                          
                         <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
           --%>
                                                      
                          </div>
                          
                         
                       
                      </div>

                          <div class="form-row">
                    
                              <!-- <div class="col-4">
                                      <br>									                 
                                           
                                               <button type="button" name="btn_compose_certificate_template" id="btn_compose_certificate_template" class="btn  btn-primary btn-icon-split "  >
                                            <span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
                                        </button>
                                        
                                    
                                </div> -->
                                
                                 <div class="col-6">
                                          <br>
                                        
                                           <button type="button" name="lc_btn_save_search_report" id="lc_btn_save_search_report" 
                                           class="btn btn-block btn-secondary btn-icon-split "  >
                                             <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Save Certificate</span>
                                        </button>
                                
                                </div>

                                <div class="col-6">
                                    <br>
                                  
                                     <button type="button" name="lc_btn_save_register_description" id="lc_btn_activate_final_certificate_" 
                                     class="btn btn-block btn-success btn-icon-split "  >
                                       <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Generate Certificate</span>
                                  </button>
                                </div>
                                <!-- <div class="col">
                                          <br><br>
                                        <button type="button" name="lc_btn_preview_consent_certificate" id="lc_btn_preview_consent_certificate" class="btn  btn-primary btn-icon-split "  >
                                            <span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Preview Certificate</span>
                                        </button>
                                
                                </div> -->
                                
                                  
                                <!-- <div class="col">
                                          <br><br>
                                         <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
                        <input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
                            <input type="hidden" id="job_number" name="job_number" value="${job_number}" >
                            <input type="hidden" id="request_type" name="request_type" value="request_to_generate_register_unsigned">
                             <div class="form-group">
                       
                        
                          
                            <input type="submit" class="btn btn-primary btn-block" value="Generate Register" />  
                       
                      </div>
                    </form>
                                
                                </div> -->
                                
                                
                                 
                                
                              </div>
                            </div>
                <!-- </div> -->

                     
			</div>
			<!-- <div class="modal-footer ">

				
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div> -->
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="enter_memorial" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Memorials Details</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
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
			</div>
			<div class="modal-footer ">

				
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>



<div class="modal fade" id="enter_mortgage_transaction" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Mortgage Transaction</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" id="getMCRegistered_no" data-target="#newMemorialsMDModal" data-toggle="tooltip" title="Add New Memorial">
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
			</div>
			<div class="modal-footer ">

				
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="enter_reservation" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Reservation Details</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                <div  class="table w-auto small table-responsive">
                    <table class="table table-bordered" id="lrd_reservation_details_dataTable">
                    
                       <thead>
                         <tr>
         
                          <th>Reservation Description</th>
                          <th>Created By</th>
                          <th>Created On</th>
                          
                            <th>Action</th>
                           </tr>
                       </thead>
                       
                         <tbody>
              <c:forEach items="${lrd_reservation_section}" var="reservation_section">
             <tr>
                 <td>${reservation_section.reservation_description}</td>
                 <td>${reservation_section.modified_by}</td>
                 <td>${reservation_section.created_date}</td>
                 <!-- <td>${certificate_section.cs_official_notes}</td> -->
                 <td>
                                         
                                         <p data-placement="top"  title="Edit">  
                                               <button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
                                                    data-target="#newReservationModal"
                                                    data-rs_id="${reservation_section.rs_id}"
                                                    data-rs_reservation_description="${reservation_section.reservation_description}"  
                                                    data-rs_case_number="${reservation_section.case_number}"
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
			</div>
			<div class="modal-footer ">

				
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="check_for_objection" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Check for Objection</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                <div  class="table-responsive">
                    <table class="table table-bordered table-hover table-sm">
                                       <thead>
                                           <tr>
                                               <th>Objector </th>
                                               <th>Address</th>
                                               <th>Contact</th>
                                               <th>Reasons </th>
                                               <th>Remarks </th>
                                               <th>Action</th>
                                           </tr>
                                       </thead>
                                       
                                       <tbody>
                                          <c:forEach items="${case_objection}" var="case_objection_row">
                                             <tr>
                                                 <td>${case_objection_row.objector_name}</td>
                                                 <td>${case_objection_row.objector_address}</td>
                                                 <td>${case_objection_row.objector_contact}</td>
                                                 <td>${case_objection_row.reasons}</td>
                                                 <td>${case_objection_row.remarks}</td>
                                                 
                                                 <td>
                                                           <button type="button" 
                                                           
                                                           id="editOjectionModal"  
                                                           data-toggle="modal" 
                                                           data-target="#newObjectionModal"  
                                                           data-action="edit"  
                                                         data-target-id= ${case_objection_row.id} 
                                                            data-objector_name= ${case_objection_row.objector_name}  
                                                             data-objector_address=${case_objection_row.objector_address} 
                                                             data-objector_contact=${case_objection_row.objector_contact} 
                                                             data-reasons= ${case_objection_row.reasons} 
                                                            data-remarks=${case_objection_row.remarks} 
                                                            data-status=${case_objection_row.status} 
                                                            

                                                           class="btn btn-danger btn-icon-split "  
                                                           title="edit objection" >
                                                             <span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
                                                         </button> 
                                                 </td>
                                              </tr>
                                          </c:forEach>
                                       </tbody>
                                       
                                       
                                   </table>
                   </div>
			</div>
			<div class="modal-footer ">

				
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="check_proprietorship_details" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Proprietorship Details</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                <div id="" class="table-responsive">
                    <div  class="table w-auto small">
                      <table class="table table-bordered" id="lrd_proprietorship_details_dataTable_final_approval" >
                      
                         <thead>
                          <tr>
                            <!-- <th>approval_status</th> -->
                             <th>Registered No.</th>
                             <th>Proprietors</th>
                             <th>Date of Instrument</th>
                             <th>Nature of Instrument</th>
                             <th>Date of Regsitration</th>
                             <th>Parties</th>
                             <th>Price Paid</th>
                             <th>Remarks</th>
                             <th>Term</th>
                           <th>Action</th>
                           <!--   <th>Approve</th> -->
                          </tr>
                         </thead>
                         
                         <tbody>
                          <c:forEach items="${lrd_proprietorship_section}" var="proprietorship_section">
                                 <tr>
                                <!-- <td>${proprietorship_section.approval_status}</td> -->
                             <td>${proprietorship_section.ps_registration_number}</td>
                             <td>${proprietorship_section.ps_proprietor}</td>
                             <td>${proprietorship_section.ps_date_of_instrument}</td>
                             <td>${proprietorship_section.ps_nature_of_instrument}</td>
                             <td>${proprietorship_section.ps_date_of_registration}</td>
                             <td>${proprietorship_section.ps_transferor} - ${proprietorship_section.ps_transferee}</td>
                             <td>${proprietorship_section.ps_price_paid}</td>
                             <td>${proprietorship_section.ps_remarks}</td>
                             <td>${proprietorship_section.ps_term}</td>

                             <td>
                                 <p data-placement="top"  title="Edit">  
                                     <button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
                                          data-target="#newProprietorshipModal"
                                          data-target-id="${proprietorship_section.ps_id}"
                                           data-ps_id="${proprietorship_section.ps_id}"  
                                          data-ps_case_number="${proprietorship_section.ps_case_number}"
                                          data-ps_registration_number="${proprietorship_section.ps_registration_number}"
                                          data-ps_proprietor="${proprietorship_section.ps_proprietor}"
                                          data-ps_date_of_instrument="${proprietorship_section.ps_date_of_instrument}"
                                          data-ps_nature_of_instrument="${proprietorship_section.ps_nature_of_instrument}"
                                          data-ps_date_of_registration="${proprietorship_section.ps_date_of_registration}"
                                          data-ps_transferor="${proprietorship_section.ps_transferor}"
                                          data-ps_transferee="${proprietorship_section.ps_transferee}"
                                          data-ps_price_paid="${proprietorship_section.ps_price_paid}"
                                          data-ps_remarks="${proprietorship_section.ps_remarks}"
                                          data-ps_signature="${proprietorship_section.ps_signature}"
                                          data-ps_term="${proprietorship_section.ps_term}"
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
                     
                   </div>  
			</div>
			<div class="modal-footer ">

				
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="review_documents" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Review hh Documents</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                
               
              <div id="accordion">
                <div class="card">
                  <div class="card-header" id="headingOne">
                    <h5 class="mb-0">
                      <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                        Document On Case
                      </button>
                    </h5>
                  </div>
              
                  <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                    <div class="card-body">
                        <button type="button" class="btn btn-success" id="btn_load_scanned_documents_" data-placement="top"  title="Load Docs">
                            <i class="fas fa-eye"></i>
                        </button>
                        
                        <button type="button" class="btn btn-primary" id="" data-toggle="modal" data-target="#fileUploadModal" title="Add Documents">
                            <i class="fa fa-plus-circle"></i>
                        </button> 
                        
                        
                    <div  class="table-responsive mt-2">
                       <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable_" width="100%" class="display" cellspacing="0">
                       
                          <thead>
                            <tr>
            
                             <th>Document Name</th>
                             <th>Document Type</th>
                           </tr>
                          </thead>
                          
                            <tbody>				
                            <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
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
                <div class="card">
                  <div class="card-header" id="headingTwo">
                    <h5 class="mb-0">
                      <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        Public Documents
                      </button>
                    </h5>
                  </div>
                  <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                    <div class="card-body">
                        <button type="button" class="btn btn-success" id="btn_load_scanned_documents_public_" data-placement="top"  title="Load Docs">
                            <i class="fas fa-eye"></i>
                        </button>
                        
                        <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-toggle="modal" data-target="#publicFileUploadModal" title="Add Documents">
                            <i class="fa fa-plus-circle"></i>
                        </button> 
                        
                        
                    <div  class="table-responsive mt-2">
                       <table class="table table-bordered  table-hover table-sm" id="lc_public_documents_dataTable_" width="100%" class="display" cellspacing="0">
                       
                          <thead>
                            <tr>
            
                             <th>Document Name</th>
                             <th>Document Type</th>
                           </tr>
                          </thead>
                          
                            <tbody>				
                            <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
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
                <!-- <div class="card">
                  <div class="card-header" id="headingThree">
                    <h5 class="mb-0">
                      <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                        Collapsible Group Item #3
                      </button>
                    </h5>
                  </div>
                  <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                    <div class="card-body">
                      Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                    </div>
                  </div>
                </div> -->
              </div>
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<button type="button" id="btn_update_app_status_ffrv" style="display:none"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Confirm Final Approval</span>
				</button>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="upload_pdf_plan" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Upload PDF Plan</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                
               
              <div id="accordion">
                <div class="card">
                  <div class="card-header" id="headingOne">
                    <h5 class="mb-0">
                      <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                        Document On Case
                      </button>
                    </h5>
                  </div>
              
                  <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                    <div class="card-body">
                        <button type="button" class="btn btn-success" id="btn_load_scanned_documents__" data-placement="top"  title="Load Docs">
                            <i class="fas fa-eye"></i>
                        </button>
                        
                        <button type="button" class="btn btn-primary" id="" data-toggle="modal" data-target="#fileUploadModal" title="Add Documents">
                            <i class="fa fa-plus-circle"></i>
                        </button> 
                        
                        
                    <div  class="table-responsive mt-2">
                       <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable__" width="100%" class="display" cellspacing="0">
                       
                          <thead>
                            <tr>
            
                             <th>Document Name</th>
                             <th>Document Type</th>
                           </tr>
                          </thead>
                          
                            <tbody>				
                            <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
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
                <div class="card">
                  <div class="card-header" id="headingTwo">
                    <h5 class="mb-0">
                      <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        Public Documents
                      </button>
                    </h5>
                  </div>
                  <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                    <div class="card-body">
                        <button type="button" class="btn btn-success" id="btn_load_scanned_documents_public___" data-placement="top"  title="Load Docs">
                            <i class="fas fa-eye"></i>
                        </button>
                        
                        <!-- <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-toggle="modal" data-target="#publicFileUploadModal" title="Add Documents">
                            <i class="fa fa-plus-circle"></i>
                        </button>  -->
                        
                        
                    <div  class="table-responsive mt-2">
                       <table class="table table-bordered  table-hover table-sm" id="lc_public_documents_dataTable___" width="100%" class="display" cellspacing="0">
                       
                          <thead>
                            <tr>
            
                             <th>Document Name</th>
                             <th>Document Type</th>
                           </tr>
                          </thead>
                          
                            <tbody>				
                            <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
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
                <!-- <div class="card">
                  <div class="card-header" id="headingThree">
                    <h5 class="mb-0">
                      <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                        Collapsible Group Item #3
                      </button>
                    </h5>
                  </div>
                  <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                    <div class="card-body">
                      Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                    </div>
                  </div>
                </div> -->
              </div>
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<button type="button" id="btn_update_app_status_ffrv" style="display:none"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Confirm Final Approval</span>
				</button>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="check_review_documents" data-backdrop="static" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Review Documents</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                
                <button type="button" class="btn btn-primary" id="btn_load_scanned_documents_public__" data-placement="top"  title="Load Docs">
                    <i class="fas fa-eye"></i>
                </button>
                
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#publicFileUploadModal" title="Add Documents">
                    <i class="fa fa-plus-circle"></i>
                </button>
                
                
            <div  class="table-responsive">
               <table class="table table-bordered  table-hover table-sm" id="lc_public_documents_dataTable__" width="100%" class="display" cellspacing="0">
               
                  <thead>
                    <tr>
    
                     <th>Document Name</th>
                     <th>Document Type</th>
                   </tr>
                  </thead>
                  
                    <tbody>				
                    <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
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
			<div class="modal-footer ">

				<div class="my-2"></div>
				<button type="button" id="btn_update_app_status_ffrv" style="display:none"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Confirm Final Approval</span>
				</button>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="review_records_verification" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Records Verification (FRRV)</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                <div class="mt-1 mb-2">
                    <a style="text-decoration: underline;" href="#" id="view_existing_records_info">
                        View Attachments (Existing Records Information)
                    </a>
                    <div  class="table-responsive mt-2 d-none" id="exreinfo_table">
                        <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable__" width="100%" class="display" cellspacing="0">
                        
                           <thead>
                             <tr>
             
                              <th>Document Name</th>
                              <th>Document Type</th>
                            </tr>
                           </thead>
                           
                             <tbody>				
                             <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
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
                <div  class="table-responsive">
                    <table class="table table-bordered  table-hover table-sm" id="lrd_scanned_documents_dataTable" >
                    
                       <thead>
                         <tr>
                
                          <th>Note</th>
                          <th>Note By</th>
                          <th>Note Date</th>
                          <th>Division</th>
                          <th>Action</th>
                           </tr>
                       </thead>
                       
                         <tbody>
                           <c:forEach items="${application_notes}" var="application_notes_row">
                                  <%-- <tr><td colspan=5>${application_notes_row}</td></tr> --%>
                                 <tr ${application_notes_row.an_status ==false ? "class='bg-danger'  data-toggle='tooltip' title='Note has been disabled'":""}>
                                             <td class="text-truncate" style="max-width:100px;">${application_notes_row.an_description}</td>
                                             <td>${application_notes_row.created_by} ${application_notes_row.an_status}</td>
                                             <td>${application_notes_row.created_date}</td>
                                             <td>${application_notes_row.division}</td>
                                             
                                             <td><p data-placement="top" data-toggle="tooltip" title="View/Edit">
                                                 <button class="btn btn-info btn-icon-split"  data-toggle="modal" data-target="#addNotesModal" 
                                                 data-target-id="${application_notes_row.an_id}" 
                                                 data-an_description="${application_notes_row.an_description}" 
                                                 data-created_by="${application_notes_row.created_by}"  
                                                 data-created_date="${application_notes_row.created_date}" 
                                                 data-modified_by="${application_notes_row.created_by}"  
                                                 data-modified_date="${application_notes_row.created_date}" 
                                                 
                                                 ${application_notes_row.an_status ==false ? "disabled ":""}
                                                 
                                                 >
                                                 <span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">View</span>
                                                 </button></p></td>
                                          </tr>
                             </c:forEach> 
                           </tbody>
                       </table>
                   </div>
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<button type="button" id="btn_update_app_status_ffrv" style="display:none"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Confirm Final Approval</span>
				</button>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
     

<div class="modal fade" id="review_records_information" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Review Records Information</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                <div class="mt-1 mb-2">
                    <a style="text-decoration: underline;" href="#" id="view_existing_records_info_">
                        View Attachments (Existing Records Information)
                    </a>
                    <div  class="table-responsive mt-2 d-none" id="exreinfo_table_">
                        <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable___" width="100%" class="display" cellspacing="0">
                        
                           <thead>
                             <tr>
             
                              <th>Document Name</th>
                              <th>Document Type</th>
                            </tr>
                           </thead>
                           
                             <tbody>				
                             <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
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
                <div  class="table-responsive">
                    <table class="table table-bordered  table-hover table-sm" id="lrd_scanned_documents_dataTable" >
                    
                       <thead>
                         <tr>
                
                          <th>Note</th>
                          <th>Note By</th>
                          <th>Note Date</th>
                          <th>Division</th>
                          <th>Action</th>
                           </tr>
                       </thead>
                       
                         <tbody>
                           <c:forEach items="${application_notes}" var="application_notes_row">
                                  <%-- <tr><td colspan=5>${application_notes_row}</td></tr> --%>
                                 <tr ${application_notes_row.an_status ==false ? "class='bg-danger'  data-toggle='tooltip' title='Note has been disabled'":""}>
                                             <td class="text-truncate" style="max-width:100px;">${application_notes_row.an_description}</td>
                                             <td>${application_notes_row.created_by} ${application_notes_row.an_status}</td>
                                             <td>${application_notes_row.created_date}</td>
                                             <td>${application_notes_row.division}</td>
                                             
                                             <td><p data-placement="top" data-toggle="tooltip" title="View/Edit">
                                                 <button class="btn btn-info btn-icon-split"  data-toggle="modal" data-target="#addNotesModal" 
                                                 data-target-id="${application_notes_row.an_id}" 
                                                 data-an_description="${application_notes_row.an_description}" 
                                                 data-created_by="${application_notes_row.created_by}"  
                                                 data-created_date="${application_notes_row.created_date}" 
                                                 data-modified_by="${application_notes_row.created_by}"  
                                                 data-modified_date="${application_notes_row.created_date}" 
                                                 
                                                 ${application_notes_row.an_status ==false ? "disabled ":""}
                                                 
                                                 >
                                                 <span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">View</span>
                                                 </button></p></td>
                                          </tr>
                             </c:forEach> 
                           </tbody>
                       </table>
                   </div>
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<button type="button" id="btn_update_app_status_ffrv" style="display:none"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Confirm Final Approval</span>
				</button>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal map-modal fade" id="view_parcel_and_transaction" tabindex="-1"
     role="dialog" aria-labelledby="#view_parcel_and_transaction" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
           <div class="modal-header">
              <h5 class="modal-title" id="">View Parcel and Transaction</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           </div>
           <div class="modal-body">

            <div class="card card-body mb-3">
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
                         <input  readonly class="form-control" id=""  name="cs_main_case_number"  type="text" aria-describedby="nameHelp"  value="${case_number}" >
                                                  
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
                      <input  readonly class="form-control" id="" type="text" aria-describedby="nameHelp"  value="${registration_district_number}" >
                    </div>
                      <div class="col-md-4">
                      <label for="search_value">Registration Section</label>
                      <input  readonly class="form-control"  id="" type="text" aria-describedby="nameHelp"  value="${registration_section_number}" >
                    </div>
                      <div class="col-md-4">
                      <label for="search_value">Registration Block</label>
                      <input  readonly class="form-control" id=""  type="text" aria-describedby="nameHelp"  value="${registration_block_number}" >
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
                      <input  readonly class="form-control" id=""  type="text" aria-describedby="nameHelp"  value="${size_of_land}" >
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
                         <input readonly class="form-control" id=""  name="cs_main_job_number"  type="text" value="${job_number}" >
                                                  
                      </div>
                      
                      
                       <div class="col-md-4">
                      <label for="search_value">Applicant Name</label>
                         <input readonly class="form-control" id=""  name="cs_main_ar_name"  type="text" aria-describedby="nameHelp"  value="${ar_name}" >
                                                  
                      </div>
                      
                      
                      
                      
                      
                     
                   
                  </div>
                  
                  <div class="form-row">
                  
                      <div class="col-md-4">
                      <label for="search_value">Transaction Number</label>
                         <input readonly class="form-control" id=""  name="cs_main_transaction_number"  type="text" value="${transaction_number}" >
                                                  
                      </div>
                      
                        <div class="col-md-4">
                      <label for="search_value">GLPIN</label>
                         <input readonly class="form-control" id=""  name="cs_main_glpin"  type="text"  value="${glpin}" >
                                                  
                      </div>
                      
                      <div class="col-md-4">
                      <label for="search_value">Certificate Number</label>
                      <input readonly class="form-control" id=""  type="text" aria-describedby="nameHelp"  value="${certificate_number}" >
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
                         <input readonly class="form-control" id=""  type="text"  value="${consideration_fee}" >
                                                  
                      </div>
                      
                     <div class="col-md-4">
                      <label for="search_value">Consideration Currency</label>
                         <input readonly class="form-control" id=""  type="text"  value="${consideration_fee_currency}" >
                                                  
                      </div>
                      <div class="col-md-4">
                      <label for="search_value">Adopted Currency Rate</label>
                         <input readonly class="form-control" id=""  type="text"  value="${consideration_fee_adopted_rate}" >
                                                  
                      </div>

                      <div class="col-md-4">
                          <label for="search_value">Publication Date</label>
                             <input readonly class="form-control" id=""  type="text"  value="${publicity_date}" >
                                                      
                          </div>

                      <div class="col-md-4">
                          <label for="search_value">Date of Issue</label>
                              <input readonly class="form-control" id=""  type="text"  value="${date_of_issue}" >
                                                      
                          </div>

                          <div class="col-md-4">
                              <label for="search_value">Registered Number</label>
                                  <input readonly class="form-control" id=""  type="text"  value="${registered_number}" >
                                                          
                              </div>
                      
                              <div class="col-md-4">
                                  <label for="search_value">Interest Number</label>
                                      <input readonly class="form-control" id=""  type="text"  value="${interest_number}" >
                                                              
                                  </div>
                                  <div class="col-md-4">
                                      <label for="search_value">Sub-Interest Number</label>
                                          <input readonly class="form-control" id=""  type="text"  value="${sub_interest_number}" >
                                                                  
                                      </div>
                      
                   
                  </div>
            </div>
           
                          <!--  The Form starts here -->
                         <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
                  
       <!-- Maps Details Starts Here  -->
       
         <div class="form-group">
                                   <div class="form-row">  <label for="lc_bl_wkt_polygon">WKT Polygon</label>
                                         <input class="form-control" id="lc_bl_wkt_polygon"  name="lc_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
           
                                       <!-- <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" ></textarea> -->
                                   </div>
                                   
                             
                                </div>
    

       
       <div class="bs-example">
       
    
       
       
       

                   <div class="btn-group mr-2">
                   


<button type="button" class="btn btn-primary"  id="lc_btn_visualise_wkt_" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-map"></i>
</button>
<!--  
<button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
<i class="fa fa-save"></i>
</button>
-->

<button type="button" class="btn btn-primary" id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
<i class="fa fa-object-ungroup"></i>
</button>




<button type="button" class="btn btn-primary" id="lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-print"></i>
</button>


<div class="btn-group">
Scale:
</div>
<div class="btn-group">
<input class="form-control" id="lc_scale_value_e"  name="lc_scale_value_e" type="text" class="autocomplat" />


<select name="lc_scale_value" id="lc_scale_value">
<option value="500">500</option>
<option value="1107">1107</option>
<option value="1250">1250</option>
<option value="2500">2500</option>
<option value="2140">2140</option>
<option value="2670">2670</option>
<option value="2215">2215</option>
<option value="2825">2825</option>
<option value="5000">5000</option>
<option value="10000">10000</option>
<option value="15000">15000</option>
<option value="20000">20000</option>

</select>


<!-- <datalist id="scalelist">
<option>500</option>
<option>1107</option>
<option>1250</option>
<option>2500</option>
<option>2140</option>
<option>2670</option>
<option>2215</option>
<option>2825</option>
<option>5000</option>
<option>10000</option>
<option>15000</option>
<option>20000</option>
</datalist> -->
</div>

<div class="btn-group mr-2">
<input type="checkbox" checked="checked" id="lc_lockmapscale">
<button type="button" class="btn btn-primary" id="lc_btn_scale_zoom" data-placement="top" data-toggle="tooltip" title="Zoom to Scale">
<i class="fa fa-search"></i>
</button>
</div>



  </div> 








</div>


  
       
       
       
        <div class="map-container mb-3" id="lc-map__" ></div>
        
            <!--  Here is where the fee list comes -->


                             
                         </form>
                       
                     

                         <input type="button" id="btn_confirm_registration_transaction" class="btn btn-success btn-block w-100" value="Confirm Transaction" />  
           </div>
           <div class="modal-footer">
            <button type="button" class="btn btn-secondary "
               data-dismiss="modal">Close</button>
         </div>
        </div>
     </div>
  </div>




<div class="modal fade" id="process_case_related_issues_details" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Correction Request Processing </h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="job_number">Correction Type</label>
                <select name="lc_correction_request_processing_types" id="lc_correction_request_processing_types" class="form-control input-sm" data-style="btn-info" required data-live-search="true">
                    <option value="no_request_type"> '-- select --'</option>
                    <option value="release_for_regeneration">Release For Re-Genererations of Certificate Number</option>
                    <option value="correct_volume_folio">Correct Volume and Folio</option>
                    <option value="reset_application_process">Reset Application Process</option>
                </select> 
            </div>
           
            <div class="mt-3">
                <input type="button" id="btn_lc_correction_request_processing_types" 
                class="btn btn-primary btn-block w-100" 
                value="Process Request" />  
             </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>



  <div class="modal map-modal fade" id="view_parcel_and_transaction_registrar" tabindex="-1"
  role="dialog" aria-labelledby="#view_parcel_and_transaction_registrar" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">View Parcel and Transaction</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">

         <div class="card card-body mb-3">
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
                      <input  readonly class="form-control" id=""  name="cs_main_case_number"  type="text" aria-describedby="nameHelp"  value="${case_number}" >
                                               
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
                   <input  readonly class="form-control" id="" type="text" aria-describedby="nameHelp"  value="${registration_district_number}" >
                 </div>
                   <div class="col-md-4">
                   <label for="search_value">Registration Section</label>
                   <input  readonly class="form-control"  id="" type="text" aria-describedby="nameHelp"  value="${registration_section_number}" >
                 </div>
                   <div class="col-md-4">
                   <label for="search_value">Registration Block</label>
                   <input  readonly class="form-control" id=""  type="text" aria-describedby="nameHelp"  value="${registration_block_number}" >
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
                   <input  readonly class="form-control" id=""  type="text" aria-describedby="nameHelp"  value="${size_of_land}" >
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
                      <input readonly class="form-control" id=""  name="cs_main_job_number"  type="text" value="${job_number}" >
                                               
                   </div>
                   
                   
                    <div class="col-md-4">
                   <label for="search_value">Applicant Name</label>
                      <input readonly class="form-control" id=""  name="cs_main_ar_name"  type="text" aria-describedby="nameHelp"  value="${ar_name}" >
                                               
                   </div>
                   
                   
                   
                   
                   
                  
                
               </div>
               
               <div class="form-row">
               
                   <div class="col-md-4">
                   <label for="search_value">Transaction Number</label>
                      <input readonly class="form-control" id=""  name="cs_main_transaction_number"  type="text" value="${transaction_number}" >
                                               
                   </div>
                   
                     <div class="col-md-4">
                   <label for="search_value">GLPIN</label>
                      <input readonly class="form-control" id=""  name="cs_main_glpin"  type="text"  value="${glpin}" >
                                               
                   </div>
                   
                   <div class="col-md-4">
                   <label for="search_value">Certificate Number</label>
                   <input readonly class="form-control" id=""  type="text" aria-describedby="nameHelp"  value="${certificate_number}" >
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
                      <input readonly class="form-control" id=""  type="text"  value="${consideration_fee}" >
                                               
                   </div>
                   
                  <div class="col-md-4">
                   <label for="search_value">Consideration Currency</label>
                      <input readonly class="form-control" id=""  type="text"  value="${consideration_fee_currency}" >
                                               
                   </div>
                   <div class="col-md-4">
                   <label for="search_value">Adopted Currency Rate</label>
                      <input readonly class="form-control" id=""  type="text"  value="${consideration_fee_adopted_rate}" >
                                               
                   </div>

                   <div class="col-md-4">
                       <label for="search_value">Publication Date</label>
                          <input readonly class="form-control" id=""  type="text"  value="${publicity_date}" >
                                                   
                       </div>

                   <div class="col-md-4">
                       <label for="search_value">Date of Issue</label>
                           <input readonly class="form-control" id=""  type="text"  value="${date_of_issue}" >
                                                   
                       </div>

                       <div class="col-md-4">
                           <label for="search_value">Registered Number</label>
                               <input readonly class="form-control" id=""  type="text"  value="${registered_number}" >
                                                       
                           </div>
                   
                           <div class="col-md-4">
                               <label for="search_value">Interest Number</label>
                                   <input readonly class="form-control" id=""  type="text"  value="${interest_number}" >
                                                           
                               </div>
                               <div class="col-md-4">
                                   <label for="search_value">Sub-Interest Number</label>
                                       <input readonly class="form-control" id=""  type="text"  value="${sub_interest_number}" >
                                                               
                                   </div>
                   
                
               </div>
         </div>
        
                       <!--  The Form starts here -->
                      <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
               
    <!-- Maps Details Starts Here  -->
    
      <div class="form-group">
                                <div class="form-row">  <label for="lc_bl_wkt_polygon">WKT Polygon</label>
                                      <input class="form-control" id="lc_bl_wkt_polygon"  name="lc_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
        
                                    <!-- <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" ></textarea> -->
                                </div>
                                
                          
                             </div>
 

    
    <div class="bs-example">
    
 
    
    
    

                <div class="btn-group mr-2">
                


<button type="button" class="btn btn-primary"  id="lc_btn_visualise_wkt_" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-map"></i>
</button>
<!--  
<button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
<i class="fa fa-save"></i>
</button>
-->

<button type="button" class="btn btn-primary" id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
<i class="fa fa-object-ungroup"></i>
</button>




<button type="button" class="btn btn-primary" id="lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-print"></i>
</button>


<div class="btn-group">
Scale:
</div>
<div class="btn-group">
<input class="form-control" id="lc_scale_value_e"  name="lc_scale_value_e" type="text" class="autocomplat" />


<select name="lc_scale_value" id="lc_scale_value">
<option value="500">500</option>
<option value="1107">1107</option>
<option value="1250">1250</option>
<option value="2500">2500</option>
<option value="2140">2140</option>
<option value="2670">2670</option>
<option value="2215">2215</option>
<option value="2825">2825</option>
<option value="5000">5000</option>
<option value="10000">10000</option>
<option value="15000">15000</option>
<option value="20000">20000</option>

</select>


<!-- <datalist id="scalelist">
<option>500</option>
<option>1107</option>
<option>1250</option>
<option>2500</option>
<option>2140</option>
<option>2670</option>
<option>2215</option>
<option>2825</option>
<option>5000</option>
<option>10000</option>
<option>15000</option>
<option>20000</option>
</datalist> -->
</div>

<div class="btn-group mr-2">
<input type="checkbox" checked="checked" id="lc_lockmapscale">
<button type="button" class="btn btn-primary" id="lc_btn_scale_zoom" data-placement="top" data-toggle="tooltip" title="Zoom to Scale">
<i class="fa fa-search"></i>
</button>
</div>



</div> 








</div>



    
    
    
     <div class="map-container mb-3" id="lc-map____" ></div>
     
         <!--  Here is where the fee list comes -->


                          
                      </form>
                    
                  

                      <!-- <input type="button" id="btn_confirm_registration_transaction" class="btn btn-success btn-block w-100" value="Confirm Transaction" />   -->
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>
          <jsp:include page="../client_application/_application_process_footer_ar.jsp"></jsp:include>

      
  <style>
    .tree ul {
        padding-left: 1rem;
        list-style: none;
    }

    .tree-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 5px 10px;
        margin-bottom: 5px;
        border-radius: 4px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        transition: background-color 0.3s, transform 0.2s;
    }

    .tree-item[data-status="active"] {
        background-color: #28a745; /* Green for active */
        color: #ffffff;
    }

    .tree-item[data-status="inactive"] {
        background-color: #dc3545; /* Red for inactive */
        color: #ffffff;
    }

    .tree-item:hover {
        transform: scale(1.02);
    }

    .btn-group-custom .btn {
        border: none;
        color: #ffffff;
        font-size: 0.85rem;
        border-radius: 20px;
        padding: 5px 15px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        transition: background-color 0.2s ease, box-shadow 0.3s ease;
    }

    .btn-group-custom .btn-primary {
        background-color: #007bff;
    }

    .btn-group-custom .btn-primary:hover {
        background-color: #0056b3;
        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.3);
    }

    .btn-group-custom .btn-danger {
        background-color: #e3342f;
    }

    .btn-group-custom .btn-danger:hover {
        background-color: #c82333;
        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.3);
    }
    .description {
            font-size: 0.85rem;
            margin-left: 10px;
            color: #ffffff;
        }
</style>
<script>
    //$(document).ready(function() {
    // Function to handle editing a step
    function editStep(stepId) {
        console.log(stepId)
        //console.log(baby_description)
        alert('Editing step with ID: '+stepId);
       // alert(`Editing step with ID: ${baby_description}`);
        // Replace the alert with your logic for editing
    }

    // Function to handle deleting a step
    function deleteStep(stepId) {
        const confirmation = confirm('Are you sure you want to delete the step with ID: '+stepId+'?');
        if (confirmation) {
            alert('Deleted step with ID: '+stepId);
            // Replace the alert with your logic for deleting
        }
    }

    function reviewStep(stepId,bse_id,job_number) {
        const confirmation = confirm('Are you sure you want to approve the step?');
        if (confirmation) {
            
            var bs_id = stepId;
            var bse_id = bse_id;
            var job_number = job_number;

            if(!bs_id || !job_number){
                alert('Sorry! An error occurred, try again.');
                return;
            }

            $.ajax({
                type : "POST",
                url : "Case_Management_Serv",
                data : {
                    request_type : 'select_review_baby_steps_check_for_completion',
                    bs_id: parseInt(bs_id),
                    bse_id: parseInt(bse_id),
                    job_number: job_number
                },
                cache: false,
                success: function(response) {

                    console.log(response)
                   
                    var json_result = JSON.parse(response);
                    
                    
                   if (json_result.success){
                    alert(json_result.msg)
                    location.reload()
                   }else{
                    alert(json_result.msg)
                   }

                   
                   // var json_result = JSON.parse(response);


                }
            })

        }
    }

    $('#approve_step').on('shown.bs.modal', function(e) {
        var stepId = $(e.relatedTarget).data('bs-id');
        $('#cs_main_step_id').val(stepId);
    })

    
    $('#view_approve_comment').on('shown.bs.modal', function(e) {
        var stepId = $(e.relatedTarget).data('bs-id');
        var job_number = $('#cs_main_job_number').val();

        $.ajax({
                type : "POST",
                url : "Case_Management_Serv",
                data : {
                    request_type : 'select_load_step_approved_comment',
                    bs_id: parseInt(stepId),
                    job_number: job_number,
                    //approve_comment: approve_comment
                },
                cache: false,
                success: function(response) {

                    console.log(response)

                    if(!response) {
                        $
														.notify(
																{
																	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">No comment!! <br><br></span>',
																},
																{
																	type : 'danger' , z_index: 9999 
																});

                                                                //alert("Approve comment is required!!")

                                                                $('#view_approve_comment').modal("hide");

											return;
                    }
                   
                    var json_result = JSON.parse(response);
                    
                    
                   if (json_result.success){
                        $('#approved_comment').val(json_result.data[0].approved_comment)
                        $('#approved_by').val(json_result.data[0].approved_by)
                        $('#approved_date').val(json_result.data[0].approved_date)

                   }else{
                    alert(json_result.msg)
                   }

                   
                   // var json_result = JSON.parse(response);


                }
            })
    })

    $('#btn_approve_step').on('click', function(e) {
        e.preventDefault();

        var job_number = $('#cs_main_job_number').val();
        var stepId = $('#cs_main_step_id').val();
        var approve_comment = $('#approve_comment_').val();



        if(!approve_comment) {
											$
														.notify(
																{
																	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Approve comment is required!! <br><br></span>',
																},
																{
																	type : 'danger' , z_index: 9999 
																});

                                                                alert("Approve comment is required!!")
											return;
										}

                                        const confirmation = confirm('Are you sure you want to approve the step?');

                                        if (confirmation) {

                                        $.ajax({
                type : "POST",
                url : "Case_Management_Serv",
                data : {
                    request_type : 'select_review_baby_steps_check_for_completion',
                    bs_id: parseInt(stepId),
                    job_number: job_number,
                    approve_comment: approve_comment
                },
                cache: false,
                success: function(response) {

                    console.log(response)
                   
                    var json_result = JSON.parse(response);
                    
                    
                   if (json_result.success){
                    alert(json_result.msg)
                    location.reload()
                   }else{
                    alert(json_result.msg)
                   }

                   
                   // var json_result = JSON.parse(response);


                }
            })
        }
    })

    $('#_verify_ffrv_application_status').on('click', function(e){
										e.preventDefault();
										var job_number = $('#verify_ffrv_job_number').val();

										if(!job_number) {
											$
														.notify(
																{
																	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job number is required!! <br><br></span>',
																},
																{
																	type : 'danger' , z_index: 9999 
																});
											return;
										}

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'select_verify_ffrv_from_division',
														job_number : job_number

													},
													cache : false,

													success : function(
															jobdetails) {
														console.log("jobdetails:" + jobdetails);
														// if (jobdetails
														// 		.includes("Success")) {
														// 	$(
														// 			"#general_message_dialog")
														// 			.modal();
														// 	$(
														// 			'#general_message_dialog #general_message_dialog_msg_new')
														// 			.val(
														// 					"Notes Approved and Moved to the Coordinator ");

														// } else {
														// 	$(
														// 			"#general_message_dialog")
														// 			.modal();
														// 	$(
														// 			'#general_message_dialog #general_message_dialog_msg_new')
														// 			.val(
														// 					"Error ! Something went wrong"
														// 							+ jobdetails);
														// }

														var json_b = JSON.parse(jobdetails)
														var pvlmd_status = json_b.pvlmd_completed;
														var smd_status = json_b.smd_completed;
														var lrd_status = json_b.lrd_completed;

														let _html_lrd_badge;
														let _html_smd_badge;
														let _html_pvlmd_badge;

														if(pvlmd_status == 1){
															_html_pvlmd_badge = '<span class="badge badge-success">Approved</span'
														} else {
															_html_pvlmd_badge = '<span class="badge badge-danger">Not Approved</span'
														}

														if(smd_status == 1){
															_html_smd_badge = '<span class="badge badge-success">Approved</span'
														} else {
															_html_smd_badge = '<span class="badge badge-danger">Not Approved</span'
														}

														if(lrd_status == 1){
															_html_lrd_badge = '<span class="badge badge-success">Approved</span'
														} else {
															_html_lrd_badge = '<span class="badge badge-danger">Not Approved</span'
														}

														document.getElementById('_html_pvlmd_badge_ffrv_v').innerHTML = _html_pvlmd_badge;
														document.getElementById('_html_smd_badge_ffrv_v').innerHTML = _html_smd_badge;
														document.getElementById('_html_lrd_badge_ffrv_v').innerHTML = _html_lrd_badge;

														if(pvlmd_status == 1 && smd_status == 1 && lrd_status == 1 ) {
															$('#btn_update_app_status_ffrv').show()
														} else {
															$('#btn_update_app_status_ffrv').hide()
														}

													},
													error : function(request) {
														alert("Request falied");
													}
												});


									})
  
                                    $('#btn_work').on('click', function (e) {

                                        var form = document.getElementById('registration_application_progress_details');

                                        form.submit();
                                    })


                                    // Ensure #check_review_documents is shown when any of the listed modals open
                                    // $("#add_edit_parties, #further_entry, #review_records_verification, #send_for_title_plan_preparation, #check_for_objection, #enter_root_of_title, #enter_memorial, #enter_reservation, #check_proprietorship_details").on('shown.bs.modal', function (e) {
                                    //     var checkReviewModal = new bootstrap.Modal(document.getElementById("check_review_documents"), {
                                    //         backdrop: false, // Prevents the modal backdrop from blocking interaction
                                    //         keyboard: false // Prevents accidental closing via keyboard
                                    //     });
                                    //     checkReviewModal.show();

                                    //     // Adjust z-index to keep all modals accessible
                                    //     // $("#check_review_documents").css("z-index", "1060"); // Higher than normal modals
                                    //     // $(".modal-backdrop").last().css("opacity", "0"); // Hide any new backdrop to allow interactions
                                    // });

                                    // Keep check_review_documents open when another modal closes
                                    // $("#check_review_documents").on('hidden.bs.modal', function (e) {
                                    //     $(this).modal('show'); // Reopen if closed
                                    // });

//7u})

// $("#enter_details_for_collection_and_print_collection").on('shown.bs.modal', function(e) {

//     var job_number = $("#cs_main_job_number").val();

//     $
// 												.ajax({
// 													type : "POST",
// 													url : "Case_Management_Serv",
// 													data : {
// 														request_type : 'load_application_collection_details_by_job_number',
// 														job_number : job_number
// 													},
// 													cache : false,
// 													beforeSend : function() {
// 														// $('#district').html('<img
// 														// src="img/loading.gif"
// 														// alt="" width="24"
// 														// height="24">');
// 													},
// 													success : function(jobdetails) {

// 														var table = $('#collection-checklist');
// 														table.find("tbody tr").remove();

// 														console.log(jobdetails);
// 														var json_p = JSON.parse(jobdetails);

// 														// console.log();
// 														$(json_p.collection_checklist).each(function() {

// 																table.append("<tr><td>"
// 																	+ this.collection_of_application_checklist_name
// 																	+ "</td><td> <input type='checkbox' required></td>"
// 																	+ '</tr>');

// 														});
// 														var table = $('#collection-parties');
// 														table.find("tbody tr")
// 																.remove();

// 														$(json_p.application_parties).each(function() {

// 																table.append("<tr><td>"
// 																	+ this.ar_name
// 																	+ "</td><td>"
// 																	+ this.ar_gender
// 																	+ "</td><td>"
// 																	+ this.ar_cell_phone
// 																	+ "</td><td>"
// 																	+ this.ar_id_type
// 																	+ "</td><td>"
// 																	+ this.ar_id_number
// 																	+ "</td><td>"
// 																	+ this.type_of_party
// 																	+ '</tr>');
// 															});

// 														$(json_p.application_details).each(function() {

// 																			$("#col_applicant_name").val(this.ar_name);
// 																			$("#col_application_type").val(this.business_process_name);
// 																			$("#col_job_number").val(this.job_number);

// 																			// -----------
// 																			$("#col_division").val(this.current_division_of_application);
// 																			$("#col_job_purpose").val(this.job_purpose);
// 																			$("#col_job_status").val(this.current_application_status);
// 																			$("#col_collection_status").val(this.is_collected);
// 																			$("#col_forwarded_by").val(this.job_forwarded_by);
// 																			$("#col_date_forwarded").val(
// 																							this.job_datesend);
// 																			$(
// 																					"#col_current_officer")
// 																					.val(
// 																							this.job_purpose);
// 																			$(
// 																					"#col_received_by")
// 																					.val(
// 																							this.job_recieved_by);
// 																			$(
// 																					"#col_received_date")
// 																					.val(
// 																							this.job_purpose);
// 																			$(
// 																					"#col_carbinet")
// 																					.val(
// 																							this.file_number);
// 																			$(
// 																					"#col_shelve")
// 																					.val(
// 																							"--");
// 																			$(
// 																					"#col_filed")
// 																					.val(
// 																							this.is_filed);
// 																			$(
// 																					"#col_filed_date")
// 																					.val(
// 																							this.filed_date);
// 																			$(
// 																					"#col_batchnumber")
// 																					.val(
// 																							this.batch_number);
// 																			$(
// 																					"#col_batched_date")
// 																					.val(
// 																							this.batch_date);
// 																			$(
// 																					"#col_batched_by")
// 																					.val(
// 																							this.batched_by);

// 																			$(
// 																					"#col_collected_by")
// 																					.val(
// 																							this.collected_by);
// 																			$(
// 																					"#col_id_type")
// 																					.val(
// 																							this.collected_by_id_type);
// 																			$(
// 																					"#col_id_number")
// 																					.val(
// 																							this.collected_by_id_number);
// 																			$(
// 																					"#col_phone_number")
// 																					.val(
// 																							this.collected_by_phone_number);

// 																		});

// 													}
// 												});     

// })


$('#frmSaveCollection')
							.on(
									'submit',
									function(e) {

										// validation code here
										e.preventDefault();
										// console.log('how are your search');

										var col_job_number = $(
												"#cs_main_job_number").val();
										console.log('Save: ' + col_job_number);

										col_collected_by_id_type = $(
												"#col_id_type").val();
										col_collected_by = $(
												"#col_collected_by").val();
										col_collected_by_id_number = $(
												"#col_id_number").val();
										col_collected_by_phone_number = $(
												"#col_phone_number").val();

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'load_save_collection_details_by_job_number',
														job_number : col_job_number,
														collected_by_id_type : col_collected_by_id_type,
														collected_by : col_collected_by,
														collected_by_id_number : col_collected_by_id_number,
														collected_by_phone_number : col_collected_by_phone_number
													},
													cache : false,
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {

														// console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);

														// console.log();

														console.log(json_p.msg)
														if (json_p.msg == "SUCCESS") {
															$(
																	"#general_message_dialog")
																	.modal();
															// $('#general_message_dialog
															// #general_message_dialog_msg').val(jobdetails);
															$(
																	'#general_message_dialog #general_message_dialog_msg_new')
																	.val(
																			"Collection details saved successfully");

															// $('#collectionModal').modal('hide');
														}

													}
												});

									});


                                    $("#send_a_message_to_client").on('shown.bs.modal', function() {
		
        let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
        
        let txt = '<table id="cabinetTable" class="table table-bordered " ><thead ><th>Applicant Name</th><th>Job Number</th><th>Locality</th></thead><tbody>';
        if(checkedList != null){
            for (let i = 0; i < checkedList.length; i++) {
                txt += `<tr><td>${ar_name} </td>`;
                txt += `<td>${job_number} </td>`;
                txt += `<td>${locality}</td>`;
                // txt +=`<td><button class="btn btn-danger remove" onclick="deleteRow(this)" id="${checkedList[i].jn_id}" data-jn_id="${checkedList[i].jn_id}"><i class="fas fa-trash"></i>Remove</button></td></tr>`
            }
            txt += '</tbody></table>';
        } else {
            txt = "<tr>No Data</tr>";
        }

        document.getElementById("cabinet_list").innerHTML = txt;
    })



                                    $('#btn_process_cabinet').on('click',function(){
		
        let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
        if(checkedList != null){
            
            const json_list = checkedList;
            
            let list_of_application = JSON.stringify(json_list);
            let cabinet_to_send_to = $('#cabinet_to_send_to').val();

            console.log(list_of_application);
            
            //$('#showBatchlist').modal('hide');
            
            
            $.ajax({
                url:"Case_Management_Serv",
                type:"POST",
                data:{
                    request_type:"select_cabinet_completed_searches",
                    list_of_application:list_of_application,
                    cabinet_to_send_to:cabinet_to_send_to
                },
                success:function(response){
                    console.log(response);

                    let json_b = JSON.parse(response)

                    if(json_b.success == true) {

                        $('#showCabinetlist').modal('hide');

                        $.notify({
                            message : '<i class="fa fa-check  fa-3x fa-fw"></i><span class="text-bold">Job application(s) have been completed successfully.</span>',
                        }, { type : 'success', z_index : 9999 });
    
                        setTimeout(function(){
                            location.reload();
                        },1000); 
                    }
                    else {

                        $.notify({
                            message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">system failed. Somethinng went wrong, try agaiin.</span>',
                        }, { type : 'danger' , z_index: 9999  });
                    }
                    
                }
            })  
        }
        else{
            
            $.notify({
                message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select job application to cabinet.</span>',
            }, { type : 'danger' , z_index: 9999  });
            
        }
        
    })


    $('#btn_load_scanned_documents___').on('click', function(e) { 
	   
	   var table_docs = $('#lc_scanned_documents_dataTable___');
	  table_docs.find("tbody tr").remove(); 	
	  
	  
	  
	   var table_docs_mains = $('#lc_main_scanned_documents_dataTable___');
	   table_docs_mains.find("tbody tr").remove(); 
 
	  var case_number = $("#cs_main_case_number").val();
	  //console.log(case_number);
	  $.ajax({
		   type: "POST",
		   url: "LoadLRDJackets",
		   data: {
				  request_type: 'load_case_scanned_document_new',
				  case_number:case_number},
		   cache: false,
		   beforeSend: function () {
			  // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		   },
		   success: function(serviceresponse) {
			  // if(!serviceresponse){
			  // 	return;
			  // }
			  try{
				  var json_p = JSON.parse(serviceresponse);
				  //console.log(json_p)
									  
				  
				   $(json_p).each(function () {
						  
					   table_docs.append("<tr><td>" + this.doc_description + "</td><td>" +this.document_extention + "</td>"
							   +  '<td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td>'

									  + "</tr>");

					   table_docs_mains.append('<tr><td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td><td>' +this.document_extention + '</td>' 

							  + "</tr>");

				   });

			  }catch(e){
											  console.log(e)
										  }
			  
				
		   }
		   }); 
  //	
  });


  $('#btn_process_completed_app_cabinet').on('click',function(){
		
        //let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
        //if(checkedList != null){
            
            // const json_list = checkedList;
            
            // let list_of_application = JSON.stringify(json_list);
            // let cabinet_to_send_to = $('#cabinet_to_send_to').val();

            // console.log(list_of_application);
            
            //$('#showBatchlist').modal('hide');
            var cabinet_to_send_to = $('#cabinet_to_send_to').val();
            var job_number = $("#cs_main_job_number").val();

           // console.log(job_number, cabinet_to_send_to);
            //return;

            if(!job_number || !cabinet_to_send_to) {

                $.notify({
                    message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Cabinet name and Job is required.</span>',
                }, { type : 'danger' , z_index: 9999  });

                return;
            }
            
            
            $.ajax({
                url:"Case_Management_Serv",
                type:"POST",
                data:{
                    request_type:"select_cabinet_completed_application",
                    job_number:job_number,
                    cabinet_to_send_to:cabinet_to_send_to
                },
                success:function(response){
                    console.log(response);

                    let json_b = JSON.parse(response)

                    if(json_b.success == true) {

                       // $('#showCabinetlist').modal('hide');

                        $.notify({
                            message : '<i class="fa fa-check  fa-3x fa-fw"></i><span class="text-bold">Job application(s) have been completed successfully.</span>',
                        }, { type : 'success', z_index : 9999 });
    
                        setTimeout(function(){
                            location.reload();
                        },1000); 
                    }
                    else {

                        $.notify({
                            message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">system failed. Somethinng went wrong, try agaiin.</span>',
                        }, { type : 'danger' , z_index: 9999  });
                    }
                    
                }
            })  
     //   }
        
        
    })



      
    
$('#btn_lc_correction_request_processing_types').on('click',function(){
            var case_number = $('#cs_main_case_number').val();
            var job_number = $("#cs_main_job_number").val();
            var transaction_number = $("#cs_main_transaction_number").val();

            if(!job_number) {

                $.notify({
                    message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job is required.</span>',
                }, { type : 'danger' , z_index: 9999  });

                return;
            }
            var confirmText = "Are you sure you want to process the request?";
            if (confirm(confirmText)) {
            
            $.ajax({
                url:"Case_Management_Serv",
                type:"POST",
                data:{
                    request_type:"select_application_correction_request",
                    job_number:job_number,
                    case_number:case_number,
                    transaction_number: transaction_number
                },
                success:function(response){
                  //  console.log(response);

                   // let json_b = JSON.parse(response)

                    if(response == 'Application Successfully completed') {

                        //$('#showCabinetlist').modal('hide');

                        $.notify({
                            message : '<i class="fa fa-check  fa-3x fa-fw"></i><span class="text-bold">Correction Request processed Successfulyy</span>',
                        }, { type : 'success', z_index : 9999 });
    
                        setTimeout(function(){
                            location.reload();
                        },1000); 
                    }
                    else {

                        $.notify({
                            message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">system failed. Somethinng went wrong, try agaiin.</span>',
                        }, { type : 'danger' , z_index: 9999  });
                    }
                    
                }
                
            })  
       }
        
        
    })

    
    $('#btn_confirm_registration_transaction').on('click',function(){
		
        //let checkedList = JSON.parse(localStorage.getItem('checkedList')) || [];
        //if(checkedList != null){
            
            // const json_list = checkedList;
            
            // let list_of_application = JSON.stringify(json_list);
            // let cabinet_to_send_to = $('#cabinet_to_send_to').val();

            // console.log(list_of_application);
            
            //$('#showBatchlist').modal('hide');
            var case_number = $('#cs_main_case_number').val();
            var job_number = $("#cs_main_job_number").val();
            var transaction_number = $("#cs_main_transaction_number").val();

           // console.log(job_number, cabinet_to_send_to);
           // return;

            if(!job_number) {

                $.notify({
                    message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Job is required.</span>',
                }, { type : 'danger' , z_index: 9999  });

                return;
            }
            var confirmText = "Are you sure you want to confirm parcel and transaction?";
            if (confirm(confirmText)) {
            
            $.ajax({
                url:"Case_Management_Serv",
                type:"POST",
                data:{
                    request_type:"select_confirm_registration_transaction",
                    job_number:job_number,
                    case_number:case_number,
                    transaction_number: transaction_number
                },
                success:function(response){
                  //  console.log(response);

                   // let json_b = JSON.parse(response)

                    if(response == 'Application Successfully completed') {

                        //$('#showCabinetlist').modal('hide');

                        $.notify({
                            message : '<i class="fa fa-check  fa-3x fa-fw"></i><span class="text-bold">Transaction has been confirmed successfully</span>',
                        }, { type : 'success', z_index : 9999 });
    
                        setTimeout(function(){
                            location.reload();
                        },1000); 
                    }
                    else {

                        $.notify({
                            message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">system failed. Somethinng went wrong, try agaiin.</span>',
                        }, { type : 'danger' , z_index: 9999  });
                    }
                    
                }
                
            })  
       }
        
        
    })


    $("#link_to_mother_file").on('shown.bs.modal', function(e) {

        var linkedMotherFile = $("#linkedMotherFile").val();
        let htmlLinkedMotherFile;

        if(!linkedMotherFile) {
            htmlLinkedMotherFile = '<div class="alert alert-danger" role="alert"><i class="fas fa-info-circle mr-2"></i>Mother File has not been linked yet.</div>';
            $("#lrd_search_for_mother_transction_to_child").prop('disabled', false);
            $("#lrd_btn_search_for_mother_transction_to_child").prop('disabled', false);

        } else {
            htmlLinkedMotherFile = '<div class="alert alert-success" role="alert"><i class="fas fa-info-circle mr-2"></i>Mother File has been linked.</div>';

            $("#lrd_search_for_mother_transction_to_child").prop('disabled', true);
            $("#lrd_btn_search_for_mother_transction_to_child").prop('disabled', true);
        }

        document.getElementById("htmlLinkedMotherFile").innerHTML = htmlLinkedMotherFile;
    })

    $("#compose_certificate").on('shown.bs.modal', function(e) {
        var bs_id = $(e.relatedTarget).data("bs-id");
        var bs_desc = $(e.relatedTarget).data("bs-desc");

        console.log(bs_id)

        // if(parseInt(bs_id) == 23 || parseInt(bs_id) == 21 || parseInt(bs_id) == 18 || parseInt(bs_id) == 20){
        //   $("#btn_compose_certificate_template").prop('disabled', true);
          
        // } else {
        //   $("#btn_compose_certificate_template").prop('disabled', false);
        // }

        if(parseInt(bs_id) == 23 || bs_desc == 'Check Certificate Details' || parseInt(bs_id) == 20){
         
          $("#cert_type_for_reg").removeClass('d-none');
        } else {
          $("#cert_type_for_reg").addClass('d-none');
        }

    })

    // $("#enter_root_of_title").on('shown.bs.modal', function(e) {

    //   var bs_id = $(e.relatedTarget).data("bs-id");
    //     console.log(bs_id)

    //     if(parseInt(bs_id) == 24 || parseInt(bs_id) == 22 || parseInt(bs_id) == 15){
    //       $("#btn_compose_register_description").prop('disabled', true);
    //     } else {
    //       $("#btn_compose_register_description").prop('disabled', false);
    //     }

    // })

    

    $('#btn_load_scanned_documents__').on('click', function(e) { 
	  
	  
	  
	   var table_docs_mains = $('#lc_main_scanned_documents_dataTable__');
	   table_docs_mains.find("tbody tr").remove(); 
 
	  var case_number = $("#cs_main_case_number").val();
	  //console.log(case_number);
	  $.ajax({
		   type: "POST",
		   url: "LoadLRDJackets",
		   data: {
				  request_type: 'load_case_scanned_document_new',
				  case_number:case_number},
		   cache: false,
		   beforeSend: function () {
			  // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		   },
		   success: function(serviceresponse) {
			  // if(!serviceresponse){
			  // 	return;
			  // }
			  try{
				  var json_p = JSON.parse(serviceresponse);
				  //console.log(json_p)
									  
				  
				   $(json_p).each(function () {
						  
					   table_docs.append("<tr><td>" + this.doc_description + "</td><td>" +this.document_extention + "</td>"
							   +  '<td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td>'

									  + "</tr>");

					   table_docs_mains.append('<tr><td> <a class="link-post" href="' + this.document_file + '">' + this.doc_description + '</a></td><td>' +this.document_extention + '</td>' 

							  + "</tr>");

				   });

			  }catch(e){
											  console.log(e)
										  }
			  
				
		   }
		   }); 
  //	
  });

    

</script>