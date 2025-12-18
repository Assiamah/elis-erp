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
					          
   <!-- <div id="" class=""> -->
    <h3 class="border-bottom border-gray pb-2">Final Approval of Registration</h3>

      
         
    <h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
    <button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
        <i class="fa fa-plus-circle"></i>
    </button>
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
                <th>Action</th>
                <th>Approve</th>
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


                
                    <td>
                        <p data-placement="top" data-toggle="tooltip" title="Batch">
                            <!-- <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newProprietorshipModal" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
                                <span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
                            </button> -->
                            <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newProprietorshipModal" 
                        data-target-id="${proprietorship_section.ps_id}" 
                        data-ps_id="${proprietorship_section.ps_id}"
                        data-ps_case_number="${proprietorship_section.ps_case_number}"
                        data-ps_registration_number="${proprietorship_section.ps_registration_number}"
                        data-ps_date_of_instrument="${proprietorship_section.ps_date_of_instrument}"
                        data-ps_nature_of_instrument="${proprietorship_section.ps_nature_of_instrument}"
                        data-ps_date_of_registration="${proprietorship_section.ps_date_of_registration}"
                        data-ps_transferor="${proprietorship_section.ps_transferor}"
                        data-ps_transferee="${proprietorship_section.ps_transferee}"
                        data-ps_price_paid="${proprietorship_section.ps_price_paid}"
                        data-ps_remarks="${proprietorship_section.ps_remarks}"
                        data-ps_signature="${proprietorship_section.ps_signature}"
                        data-ps_proprietor="${proprietorship_section.ps_proprietor}"
                        data-whatever="edit">
                            <span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
                        </button>
                        </p>
                    </td>
                    
                        
                    <td>
                        <p data-placement="top" data-toggle="tooltip" title="Batch">
                            <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#lrdtransactionapprovalmodal" 
                            data-target-id="${proprietorship_section.ps_id}" 
                            data-ps_proprietor="${proprietorship_section.ps_proprietor}"
                            data-ps_nature_of_instrument="${proprietorship_section.ps_nature_of_instrument}"
                            data-case_number="${proprietorship_section.case_number}"
                            data-transaction_id="${proprietorship_section.ps_id}"
                            data-whatever="edit">
                                <span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Approve</span>
                            </button>
                        </p>
                    </td>
                     
                    
                    </tr>
                </c:forEach>
              </tbody>

        
        </table>
      </div>
      
    </div>  



    <!-- <div class="form-row">
        <div class="col-md-12">
          <label for="search_value">Certificate Summary</label>
           
          
           
              <textarea id="lc_search_report_summary_details" name="lc_search_report_summary_details" class="form-control col-sm-12" required rows=7  style="padding:50px !important;">${remark_or_comment} </textarea> 
          
          
         <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
--%>
                                      
          </div>
          
         
       
      </div>
      
      
      
       
      <div class="form-row">
        
        <div class="col-auto">
                <br><br>									                 
                     
                         <button type="button" name="btn_compose_certificate_template" id="btn_compose_certificate_template" class="btn  btn-primary btn-icon-split "  >
                      <span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
                  </button>
                  
              
          </div>
          
           <div class="col">
                    <br><br>
                  
                     <button type="button" name="lc_btn_save_search_report" id="lc_btn_save_search_report" 
                     class="btn btn-block btn-secondary btn-icon-split "  >
                       <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Save Certificate</span>
                  </button>
          
          </div>
          
        </div> -->

        <div class="card">
            <div class="card-header bg-dark text-white " role="tab"
                id="headingThree"
            >
                <a class="collapsed d-block  text-white " data-toggle="collapse"
                    data-parent="#accordion" href="#collapseprecertregis"
                    aria-expanded="false" aria-controls="collapseFive"
                    style="text-decoration: none !important"
                > <i class="fa fa-chevron-down pull-right"></i> <i
                    class="fa fa-users"
                ></i>Preview Certificate and Land Register
                </a>
            </div>
            <div id="collapseprecertregis" class="collapse" role="tabpanel"
                aria-labelledby="headingThree"
            >
                <div class="card-body">



<div class="form-row">
                                  <div class="col-md-12">
                                    <label for="search_value">Register:Description of Land</label>
                                     
                                    
                                     
                                        <textarea id="lc_description_of_land_lrd_2" name="lc_description_of_land_lrd" class="form-control col-sm-12" required rows=3  style="padding:50px !important;">${smd_region} </textarea> 
                                    
                                    
                                   <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
                     --%>
                                                                
                                    </div>
                                    
                                   
                                 
                                </div>


<div class="form-row">
                                  
                                  <!-- <div class="col-auto">
                                          <br><br>									                 
                                               
                                                   <button type="button" name="btn_compose_register_description" id="btn_compose_register_description_2" class="btn  btn-primary btn-icon-split "  >
                                                <span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
                                            </button>
                                            
                                        
                                    </div> -->
                                    
                                     <div class="col">
                                              <br><br>
                                            
                                               <button type="button" name="lc_btn_save_register_description" id="lc_btn_save_register_description_2" 
                                               class="btn btn-block btn-secondary btn-icon-split "  >
                                                 <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Update Register</span>
                                            </button>
                                    
                                    </div>
                                    
                                  
                                  </div>
                                


   <div class="form-row">
                                  <div class="col-md-12">
                                    <label for="search_value">Certificate Summary</label>
                                     
                                    
                                     
                                        <textarea id="lc_search_report_summary_details_2" name="lc_search_report_summary_details" class="form-control col-sm-12" required rows=7  style="padding:50px !important;">${remark_or_comment} </textarea> 
                                    
                                    
                                   <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
                     --%>
                                                                
                                    </div>
                                    
                                   
                                 
                                </div>
                                
                                
                                
                                 
                                <div class="form-row">
                                  
                                  <!-- <div class="col-auto">
                                          <br><br>									                 
                                               
                                                   <button type="button" name="btn_compose_certificate_template" id="btn_compose_certificate_template_2" class="btn  btn-primary btn-icon-split "  >
                                                <span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
                                            </button>
                                            
                                        
                                    </div> -->
                                    
                                     <div class="col">
                                              <br><br>
                                            
                                               <button type="button" name="lc_btn_save_search_report" id="lc_btn_save_search_report_2" 
                                               class="btn btn-block btn-secondary btn-icon-split "  >
                                                 <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Update Certificate</span>
                                            </button>
                                    
                                    </div>
                                    
                                    <!-- <div class="col">
                                              <br><br>
                                            <button type="button" name="lc_btn_preview_consent_certificate" id="lc_btn_preview_consent_certificate" class="btn  btn-primary btn-icon-split "  >
                                                <span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Preview Certificate</span>
                                            </button>
                                    
                                    </div> -->
                                    
                                      
                                    <div class="col">
                                              <br><br>
                                             <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
                            <input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
                                <input type="hidden" id="job_number" name="job_number" value="${job_number}" >
                                <input type="hidden" id="request_type" name="request_type" value="request_to_generate_register_unsigned">
                                 <div class="form-group">
                           
                            
                              
                                <input type="submit" class="btn btn-primary btn-block" value="Preview Register" />  
                           
                          </div>
                        </form>
                                    
                                    </div>
                                    
                                    
                                     
                                    
                                  </div>
                                


                </div>
            </div>
        </div>
      

      <div class="row">

        <!--   Here is the right Table -->
                           <div class="col-lg-12">
                             <!-- Example Pie Chart Card-->
                             <div class="card mb-3">
                               <div class="card-header">
                                 <i class="fa fa-pie-chart"></i>Generate Certificate, Volume and Folio</div>
                               <div class="card-body">
                                  <!--  The Form starts here -->
                           
                              <div class="form-row">
                                <div class="col-md-3">
                                  <label for="job_number">Certificte Type</label>
                                <select name="lc_txt_type_of_certificate" id="lc_txt_type_of_certificate" class="form-control input-sm" data-style="btn-info" required data-live-search="true">
                                    <option value="${certificate_type == 'Individual' ? '' : certificate_type}">${certificate_type == 'Individual' ? '-- select --' : certificate_type}</option>
                                    <option value="Provisional Certificate">Provisional Certificate</option>
                                    <option value="Land Certificate">Land Certificate</option>
                                    <option value="Substituted Certificate">Substituted Certificate</option>
                                </select> 

                                  </div>
                                  <div class="col-md-3">
                                    <label for="job_number">Certificate Number</label>
                                     <input class="form-control" id="lc_txt_certificate_number"  name="file_number"  type="text" aria-describedby="nameHelp"  value="${certificate_number}" >
                                    </div>
                                   <div class="col-md-3">
                                  <label for="job_number">Volume</label>
                                   <input class="form-control" id="lc_txt_volume_number"  name="file_number"  type="text" aria-describedby="nameHelp"  value="${volume_number}" >
                                 </div>
                                 
                                  <div class="col-md-3">
                                      <label for="job_number">Folio</label>
                                   <input class="form-control" id="lc_txt_folio_number"  name="file_number"  type="text" aria-describedby="nameHelp"  value="${folio_number}" >
                                
                                    
                                  </div>
                                     <div class="col-md-3">
                                     <label for="job_number">.</label>
                                      <input type="button" id="lc_btn_generate_certificate_volume_folio" class="btn btn-primary btn-block to_hide_on_level_1" value="Generate Indices" />  
                                   </div>
                                
                               </div>
                               
                               <!-- The form Ends Hers -->
                               
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
                                 <i class="fa fa-pie-chart"></i>Final Approvals</div>
                               <div class="card-body">
                                  <!--  The Form starts here -->
                                  <input class="form-control" id="txt_certificete_approval_status"  name="txt_certificete_approval_status"  type="hidden" aria-describedby="nameHelp" readonly value="${certificete_approval_status}" >
                                  <input class="form-control" id="txt_final_approval_status"  name="txt_final_approval_status"  type="hidden" aria-describedby="nameHelp" readonly value="${final_approval_status}" >
          
                                   <div class="form-row">
                                                <div class="col-md-3">
                                                    <input type="button" id="lc_btn_approve_certicate_for_signature" class="btn btn-danger btn-block" value="Approve Certificate" />  
              
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="button" id="lc_btn_generate_activation_code" class="btn btn-danger btn-block" value="Final Approval of Title" />  
              
                                                </div>
                                                
                                                <div class="col-md-3">

                                                    <input type="button" id="lc_btn_activate_final_certificate" class="btn btn-primary btn-block" value="Generate Final Certificate" />  
             
                                                    <!-- 																	 
                                                    <input type="button" id="lc_btn_activate_provisional_certificate" class="btn btn-warning btn-block" value="Generate Provisional Certificate" />  
                                                     -->
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="button" id="lc_btn_activate_final_register" class="btn btn-primary btn-block" value="Generate Final Register" />  
         
                                                </div>
                                
                               </div>
                               
                               <!-- The form Ends Hers -->
                               
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
              <i class="fa fa-pie-chart"></i>Final Approval of Registration</div>
            <div class="card-body">
               <!--  The Form starts here -->
              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
       
<!-- Maps Details Starts Here  -->
<div class="bs-example">





<div class="btn-group mr-2">
<button type="button" class="btn btn-primary"  id="btn_lcfrfa_lc_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-map"></i>
</button>

<!--  
<button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
<i class="fa fa-save"></i>
</button>
-->

<button type="button" class="btn btn-primary" id="btn_lcfrfa_lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
<i class="fa fa-object-ungroup"></i>
</button>


<button type="button" class="btn btn-primary" id="btn_lcfrfa_lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-print"></i>
</button>
</div>


</div>

<div id="lcfrfa-map" ></div>


                  
              </form>
            
            <!-- The form Ends Hers -->
            
          </div>
         
        </div>
      <!--   Here is the end of right table -->
  
      </div>
      
    
     </div>
     
<!-- </div> -->
		 
		 <input type="hidden" id="ars_job_purpose" class="form-control" value="${job_purpose}">
		 
		 <div class="mt-5">
			<button class="btn btn-success btn-icon-split float-left"  data-job_number="${job_number}" id="btnApproveJob">
				<span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Approve Request</span>
			</button>

			<button class="btn btn-danger btn-icon-split float-left ml-3"  data-job_number="${job_number}" id="btnQueryJob">
				<span class="icon text-white-50"> <i class="fas fa-times fa-2x"></i></span><span class="text">Query Request</span>
			</button>
		 </div>

          
            
		<jsp:include page="../client_application/_application_process_footer_ar.jsp"></jsp:include>
  
  
