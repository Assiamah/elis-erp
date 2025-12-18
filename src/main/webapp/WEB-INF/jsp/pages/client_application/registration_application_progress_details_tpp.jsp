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
					          
					      
							   <!-- wizard start wizard end -->
		

        <!-- smartwizardfirstregistration html -->
        <!-- <div id="smartwizardfirstregistration">
            <ul>
               
                <li><a href="#step-1">Upload file at CSAU Back Office<br /><small>Upload file at CSAU Back Office</small></a></li>
                
                <li><a href="#step-3">Update As Undergoing Registration<br /><small>Update As Undergoing Registration</small></a></li>
              
              
                <li><a href="#step-2">File Created <br /><small>Generate LRD File Number</small></a></li>
                <li><a href="#step-3" >Parcel Plan Preparation<br /><small>Parcel Plan Preparation</small></a></li>
              
              
            </ul>

            <div>
            
             
            
                
               
                
            </div>
        </div> -->
        <div id="step-3" class="">
                    <h3 class="border-bottom border-gray pb-2 text-white bg-primary p-3">Title Plan 
                    
                    <c:if test="${vr_job_status < '5'}">
				              		&nbsp;Preparation
				              </c:if>
				              <c:if test="${vr_job_status == '5'}">
				              		&nbsp;Signing
				              </c:if>
				              <c:if test="${vr_job_status == '6'}">
				              		&nbsp;Approval
				              </c:if>
				              <c:if test="${vr_job_status == '7'}">
				              		&nbsp;Sealing & Scanning
				              </c:if></h3>
						      
					<div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Title Plan Update</div>
				            <div class="card-body">
				
				
							              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
				
						    <div class="form-group">
					       
					       <input  id="vr_job_status_tpp" name="vr_job_status_tpp" type="hidden" value="${vr_job_status}" >
					       
					       
					        <div class="form-row">  <label for="bl_job_purpose">WKT Polygon</label>
					         
					         <input class="form-control" id="lc_fr_bl_wkt_polygon"  name="lc_fr_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
				             
					        </div>
					        
					         </div>
						         
						         <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Land size</label>
				                <input class="form-control" id="txt_lc_size_of_land"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${size_of_land}" readonly>
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Plan Number</label>
				                <input class="form-control" id="txt_lc_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Nature of Instrument" value="${plan_no}" readonly>
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Registration District</label>
				                <input class="form-control" id="txt_lc_registration_district_number"  name="txt_lc_registration_district_number"  type="text" aria-describedby="nameHelp" placeholder="Enter Consideration" value="${registration_district_number}" readonly >
				              </div>
				             
				            </div>
				            
				              
						         <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Section Number</label>
				                <input class="form-control" id="txt_lc_registration_section_number"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${registration_section_number}" readonly>
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Block Number</label>
				                <input class="form-control" id="txt_lc_registration_block_number"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Nature of Instrument" value="${registration_block_number}" readonly>
				              </div>
				              
				               <div class="col-md-4">
				                   <label for="search_value">ltr_plan_no</label>
				                <input class="form-control" id="ltr_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${ltr_plan_no}" readonly>
				              
				                 
				               </div>
				             
				            </div>
				            
				                <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Registry Map No</label>
				                <input class="form-control" id="txt_lc_registry_mapref"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${registry_mapref}" readonly>
				              </div>
				              
				             <%--   <div class="col-md-4">
				                <label for="search_value">cc_no</label>
				                <input class="form-control" id="txt_lc_cc_no"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${cc_no}" readonly>
				              </div> --%>
				              
				              
				               <div class="col-md-4">
				                <label for="search_value">glpin</label>
				                <input class="form-control" id="txt_glpin"    type="text" aria-describedby="nameHelp" placeholder="GLPIN" value="${glpin}" readonly>
				              </div>
				              
				            <!--    <div class="col-md-4">
				            
				                  <button type="button" class="btn btn-primary" id="lc_btn_save_details_at_title_plan" data-placement="top" data-toggle="tooltip" title="Save">
						            <i class="fa fa-object-ungroup"></i>
						        </button>
				               </div> -->
				               
				             
				            </div>
				            
						         
						        
				        </form>
				
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      
				     
				     </div>
				     
				     
				                     <div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Title Plan Preparation</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
				       
            <!-- Maps Details Starts Here  -->
            <div class="bs-example">
            
         
            
            
            
    <div class="btn-group mr-2">
      <button type="button" class="btn btn-primary"  id="smdfrtp_lc_btn_fr_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-map"></i>
        </button>
  
       
        <button type="button" class="btn btn-primary" id="btn_print_new_title_plan" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-print"></i>
        </button>
    </div>
   

      
    
</div>


       
            
            
            
             <div id="smdfrtp-map" ></div>
             
             
						          
				              </form>
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      

				     </div>
               
  </div>
             
                
                
                
                <button class="btn btn-warning btn-icon-split float-left to_hidxe_on_level_2"  data-job_number="${job_number}" id="btnCompleteJobtpp_we">
					<span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Complete My Work</span>
				</button>
				 <c:if test="${vr_job_status == '6'}">
					<button class="btn btn-success btn-icon-split float-left to_hide_on_level_1"  data-job_number="${job_number}" id="btnApproveJobtpp_we">
						<span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Approve Plan has been Prepared</span>
					</button>
				</c:if>
				<c:if test="${vr_job_status == '5'}">
					<button class="btn btn-primary btn-icon-split float-left to_hide_on_level_1"  data-job_number="${job_number}" id="btnApproveJobtpp_signed_we">
						<span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Approve As Signed</span>
					</button>
        		</c:if>
							
          
            
          <jsp:include page="../client_application/_application_process_footer_tpp.jsp"></jsp:include>
  
  
