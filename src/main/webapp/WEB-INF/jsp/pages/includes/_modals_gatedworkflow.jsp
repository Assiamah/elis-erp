<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<jsp:useBean id="now" class="java.util.Date" />




     <div class="modal fade" id="approve_step" tabindex="-1"
     role="dialog" aria-labelledby="approve_step" aria-hidden="true">
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


  <div class="modal map-modal fade" id="upload_coordinate" tabindex="-1"
     role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
           <div class="modal-header">
              <h5 class="modal-title" id="">NOTIMG 0F PARCEL</h5>
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



</div>

<div class="btn-group mr-2">
<input type="checkbox" checked="checked" id="lc_lockmapscale">
<button type="button" class="btn btn-primary" id="lc_btn_scale_zoom" data-placement="top" data-toggle="tooltip" title="Zoom to Scale">
<i class="fa fa-search"></i>
</button>
</div>



  </div> 








</div>


  
       
       
       
        <div class="map-container" id="lc-map" ></div>
        
            <!--  Here is where the fee list comes -->

  <!-- Coordinate Buttons -->
                <div class="bs-example">
                    <div class="btn-group mr-2">

                        <button type="button" class="btn btn-primary"
                                id="lc_btn_add_coordinate"
                                data-placement="top"
                                data-toggle="modal"
                                data-target="#addcoordinatetoplot"
                                title="Add Coordinate">
                            <i class="fa fa-plus-circle"></i>
                        </button>

                        <button type="button" class="btn btn-primary"
                                id="lrd_btn_add_coordinate_by_csv"
                                data-toggle="modal"
                                data-target="#uploadcoordiantecsv"
                                data-placement="top"
                                title="Upload CSV">
                            <i class="fa fa-upload"></i>
                        </button>

                        <button type="button" class="btn btn-primary"
                                id="lc_btn_visualise_coordinate"
                                data-placement="top"
                                data-toggle="tooltip"
                                title="Visualise Polygon">
                            <i class="fa fa-eye"></i>
                        </button>

                        <button type="button" class="btn btn-primary"
                                id="btn_lc_save_parcel_for_general_noting"
                                data-placement="top"
                                data-toggle="tooltip"
                                title="Save">
                            <i class="fa fa-save"></i>
                        </button>

                    </div>
                </div>

                <!-- Coordinates Table -->
                <div class="table w-auto small mt-3">
                    <table class="table table-bordered" id="coordinatelis_Table" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>coordinate_name</th>
                                <th>x_coordinate</th>
                                <th>y_coordinate</th>
                                <th>Remove</th>
                            </tr>

                        </thead>
                        <tbody>
                            <!-- Data will be inserted dynamically -->
                        </tbody>
                    </table>
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



<div class="modal map-modal fade" id="check_for_polygon" tabindex="-1" role="dialog" aria-labelledby="#check_for_polygon" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered modal-lg">
   <div class="modal-content">
      <div class="modal-header">
         <h5 class="modal-title" id="">Check for Polygon</h5>
         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
     
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
            
                    </form>
      <!-- </div> -->
      <div class="modal-footer">
       <button type="button" class="btn btn-secondary "
          data-dismiss="modal">Close</button>
    </div>
   <!-- </div> -->
      </div>
</div>
</div>
</div>

<div class="modal fade" id="confirm_otp_for_approval_encumbrance" tabindex="-1"
  role="dialog" aria-labelledby="#confirm_otp_for_approval_encumbrance" aria-hidden="true">
  <div class="modal-dialog modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Request OTP For Encumbrance</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
        <div class="mt-3">
            <input type="button" id="lc_btn_approve_encumbrance_for_signature" class="btn btn-primary btn-block w-100" value="Generate" />  
         </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

  <div class="modal fade" id="sent_for_publication" tabindex="-1"
     role="dialog" aria-labelledby="#sent_for_publicationlable" aria-hidden="true">
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
                    <c:if test="${not empty publicity_date and publicity_date != 'null' and not fn:contains(publicity_date, '-')}">
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
                                       data-p_uid="${parties_row.p_uid}"
                                       data-ar_id="${parties_row.ar_id}"
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
           <h5 class="modal-title" id="">Inspection of Site (Documents on Applicaion)</h5>
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

<div class="modal fade" id="enter_encumbrance_transaction_on_mother" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Encumberance Transactions on Mother</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
          <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newEncumberancesOnMotherModal" data-toggle="tooltip" title="Add New">
            <i class="fa fa-plus-circle"></i>
          </button>
                 <div class= "clear"></div><br>
                        <div  class="able w-auto small table-responsive">
          <table class="table table-bordered" id="lrd_encumberance_details_dataTable">
               
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


<div class="modal fade" id="generate_certificate_of_registration_of_instrument" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Generate Certificate</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="row mt-2">
                <div class="col-md-12">
                    <input type="button" id="lc_btn_generate_certificate_of_registration_of_instrument" class="btn btn-primary btn-block w-100" value="Generate Certificate" />  
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

<div class="modal fade" id="generate_2d_barcode" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Generate Barcode</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="row mt-2">
                <div class="col-md-12">
                    <input type="button" id="btn_generate_smd_barcode" class="btn btn-primary btn-block w-100" value="Generate Barcode" />  
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



<div class="modal fade" id="determining_type_of_transfer" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Determine Type of Transfer</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
             <!-- <div class="form-row">  -->
                <label for="bl_job_purpose">Extent Land</label>
            <select name="lc_intended_parcel" id="lc_intended_parcel" data-live-search="true" data-none-results-text="I found no results" title="Please select Letter type" class="form-control selectpicker">
             <option value="${intended_parcel == '' ? '' : intended_parcel}">${intended_parcel == '' ? '-- select --' : intended_parcel}</option>					
               <option value="Whole Parcel">Whole Parcel</option>
               <option value="Part of parcel">Part of parcel</option>
                     
                     </select>
             <!-- </div> -->
           </div>

            <div class="form-group">
	 

              <!-- <div class="form-row">  -->
                 <label for="bl_job_purpose">Extent Interest</label>
        
             <select name="lc_intended_interest" id="lc_intended_interest" data-live-search="true" data-none-results-text="I found no results" title="Please select Letter type" class="form-control selectpicker">
              <option value="${intended_interest == '' ? '' : intended_interest}">${intended_interest == '' ? '-- select --' : intended_interest}</option>
                <option value="Whole Interest">Whole Interest</option>
                <option value="Part of Interest">Part of Interest</option>
                      
                        
                      </select>
              <!-- </div> -->
               </div>
           
            <div class="mt-3">
                <input type="button" id="lc_btn_determine_type_of_transfer" 
                class="btn btn-primary btn-block w-100" 
                value="Submit"
                />  
             </div>

             <!-- <c:if test="${not empty type_of_transfer and type_of_transfer != 'null' and not fn:contains(type_of_transfer, '-')}">
              disabled
          </c:if> -->
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="application_to_mother_file" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Move Application to Mother File</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="row mt-2">
                <div class="col-md-12">
    
                    <input type="button" id="lc_btn_application_to_mother_file" class="btn btn-primary btn-block w-100" value="Move Applicaion" />  
    
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
                <c:if test="${not empty certificate_number and certificate_number != 'null' and not fn:contains(certificate_number, '-')}">
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

          <c:if test="${not empty volume_number and volume_number != 'null' and not fn:contains(volume_number, '-')}">
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

<!-- <c:if test="${not ((empty volume_number or empty folio_number) or (volume_number.trim() eq '' or folio_number.trim() eq '') or (volume_number == 'null' or folio_number == 'null'))}">
  disabled
</c:if>  -->


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


<div class="modal fade" id="confirm_otp_for_approval_register" tabindex="-1"
  role="dialog" aria-labelledby="#send_opt_for_approval_register" aria-hidden="true">
  <div class="modal-dialog modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Request OTP For Register</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
       
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
           <h5 class="modal-title" id="">Check Availability of Mother File</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
          

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


<div class="modal fade" id="send_to_records_for_info" tabindex="-1"
role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
<div class="modal-dialog modal-dialog-centered">
  <div class="modal-content">
    <div class="modal-header">
      <h4 class="modal-title custom_align" id="Heading">Send To Records</h4>
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

              <button class="btn btn-success w-100" id="btn_send_to_records"><i class="fas fa-envelope mr-1"></i>Send</button>
              <div class="mt-2">
                  <a href="#" style="text-decoration: underline;" data-target="#fileUploadModal" data-toggle="modal">
                      Upload Existing Records Information
                  </a>
              </div>

              <div class="card card-body mt-3">
                  <ul class="list-group list-group-flush">
                      <li class="list-group-item"><b>Records: </b> <h5 id="send_record_info_badge"></h5></li>
                    </ul>
              </div>
      


    </div>
    <div class="modal-footer ">

      <div class="my-2"></div>
     

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
                            </div>
                <!-- </div> -->

                     
			</div>
			
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
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
				<h4 class="modal-title custom_align" id="Heading">Review Documents</h4>
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
                        Documents on Application
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



<div class="modal fade" id="update_digital_workflow_milestone" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Update Digital Workflow Milestone</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="row mt-2">
                <div class="col-md-12">

                 
				<input id="up_userid" name="up_userid" type="hidden" value="${userid}">


				<div class="form-group">
					<label for="bl_job_number">Full Name</label> <input
						class="form-control " type="text" placeholder=""
						id="up_fullname" readonly
					>
				</div>




				<div class="row">
					<div class="col-lg-12">
						<!-- Example Bar Chart Card-->
						<div class="card mb-3">
							<div class="card-header">
								<i class="fa fa-bar-chart"></i>Milestone List
							</div>
							<div class="card-body">



								<!--  Here is where the fee list comes -->

								<div class="table-responsive">
								
									
									<table class="table table-bordered table-hover" id="tbl_baby_steps_list_dataTable"
										width="100%"
									>
									
										<thead>
											<tr>
												<th>Description</th>
												<th>Option</th>
											

											</tr>
										</thead>
				
										<tbody>



										</tbody>
									</table>
								</div>

								<!--  End Of Table -->
							</div>
							<div class="card-footer small text-muted"></div>
						</div>


					</div>
				</div>

    
                </div>
            </div>
        </div>
        <div class="modal-footer">
      
          <button type="button" id="btn_process_updated_milestone"  class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Update Milestone</span>
				</button>
      
          <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="review_motherfile_details" tabindex="-1"
  role="dialog" aria-labelledby="#review_motherfile_details" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-xl">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id=""> Review Motherfile</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
           <div class="card">
					<div class="card-header bg-dark text-white " role="tab"
						id="headingThree"
					>
						<a class="collapsed d-block  text-white " data-toggle="collapse"
							data-parent="#accordion" href="#collapseaddcertregis"
							aria-expanded="false" aria-controls="collapseFive"
							style="text-decoration: none !important"
						> <i class="fa fa-chevron-down pull-right"></i> <i
							class="fa fa-users"
						></i>Root of Title
						</a>
					</div>
					<div id="collapseaddcertregis" class="collapse" role="tabpanel"
						aria-labelledby="headingThree"
					>
						<div class="card-body">
              <div class="d-flex justify-content-between">

 					<h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
                    <button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
			            <i class="fa fa-plus-circle"></i>
			        </button>
              </div>
                     
               	  <div  class="table w-auto small table-responsive">
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
								<!-- <th>Approve</th> -->
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
										data-ps_term="${proprietorship_section.ps_term}"
										data-whatever="edit">
											<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
										</button>
										</p>
									</td>
									
										
									<!-- <td>
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
									</td> -->
									 
									
									</tr>
								</c:forEach>
							  </tbody>
			    
			            
			            </table>
			          </div>
			          
			          
			          
			          <div class="d-flex justify-content-between">

			           <h5 class="border-bottom border-gray pb-2">Memorial Details</h5>
			              <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newMemorialsModal" data-toggle="tooltip" title="Add New Memorial">
		            <i class="fa fa-plus-circle"></i>
		        </button>
                </div>
                     
               	  <div  class="table w-auto small table-responsive">
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
			          
			          <div class="d-flex justify-content-between">

                   <h5 class="border-bottom border-gray pb-2">Valuation Details</h5>
			       <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newValuationModal" data-toggle="tooltip" title="Add New Valuation Records">
		            <i class="fa fa-plus-circle"></i>
		        </button>
                </div>
			         
                     
               	  <div  class="table w-auto small table-responsive">
			           <table class="table table-bordered" id="lrd_valuation_details_dataTable">
			           
			              <thead>
			                <tr>
			
			                 <th>Date of Valuation</th>
			                 <th>Amount</th>
			                 <th>Remarks</th>
			                 <th>Edit</th>
			                  
			                  </tr>
			              </thead>
			              
			                <tbody>
			     <c:forEach items="${lrd_valuation_section}" var="valuation_section">
                <tr>
                    <td>${valuation_section.vs_date_of_valuation}</td>
                    <td>${valuation_section.vs_amount}</td>
                    <td>${valuation_section.vs_remarks}</td>
                    
                     <td>
						                    
						                    <p data-placement="top"  title="Edit">  
			          							<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
			          								 data-target="#newValuationModal"
			          								 data-target-id="${valuation_section.vs_id}"
			          								 data-vs_id="${valuation_section.vs_id}"  
			          								 data-vs_case_number="${valuation_section.vs_case_number}"
			          								 data-vs_date_of_valuation="${valuation_section.vs_date_of_valuation}"
			          								 data-vs_amount="${valuation_section.vs_amount}"
			 
			          								 data-vs_remarks="${valuation_section.vs_remarks}"
			          								 > 
			          								    	 
			          								    	 
			          								<span class="icon text-white-50"> 
			          								<i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>
			          						</p>
						                    
						                    </td>
                   
                  <%--  <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"   method="post" target="_blank" id="downloadForm"><input type="hidden" name="case_numer" id="case_number" value="${valuation_section.vs_id}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                    --%> 
                    	
                    
                     
                    
                    </tr>
            </c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div>
			          
			          <div class="d-flex justify-content-between"> 
                   <h5 class="border-bottom border-gray pb-2">Certificate Details</h5>
			      	<button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newCertificateModal" data-toggle="tooltip" title="Add New">
		            <i class="fa fa-plus-circle"></i>
		        	</button>
                </div>
			          
                     <div class= "clear"></div><br>
               	  <div  class="table w-auto small table-responsive">
			           <table class="table table-bordered" id="lrd_certificate_details_dataTable">
			           
			              <thead>
			                <tr>
			
			                 <th>Date of Issue</th>
			                 <th>To Whom Issued</th>
			                 <th>Serial Number</th>
			                 <th>Official Notes</th>
			                 
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
                    <td>
						                    
						                    <p data-placement="top"  title="Edit">  
			          							<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
			          								 data-target="#newCertificateModal"
			          								 data-target-id="${certificate_section.cs_id}"
			          								 data-cs_id="${certificate_section.cs_id}"  
			          								 data-cs_case_number="${certificate_section.cs_case_number}"
			          								 data-cs_date_of_registration="${certificate_section.cs_date_of_registration}"
			          								 data-cs_to_whom_issued="${certificate_section.cs_to_whom_issued}"
			          								 data-cs_serial_number="${certificate_section.cs_serial_number}"

			          								 data-cs_official_notes="${certificate_section.cs_official_notes}"
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
			          
                
                <div class="d-flex justify-content-between"> 
                  <h5 class="border-bottom border-gray pb-2">Reservation Details</h5>
			      	<button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newReservationModal" data-toggle="tooltip" title="Add New">
		            <i class="fa fa-plus-circle"></i>
		        	</button>
                </div>
                
					  
                     <div class= "clear"></div><br>
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
					</div>
				</div>
				<br>
				

	<div class="card">
					<div class="card-header bg-dark text-white " role="tab"
						id="headingThree"
					>
						<a class="collapsed d-block  text-white " data-toggle="collapse"
							data-parent="#accordion" href="#collapseencumbrances"
							aria-expanded="false" aria-controls="collapseFive"
							style="text-decoration: none !important"
						> <i class="fa fa-chevron-down pull-right"></i> <i
							class="fa fa-users"
						></i>Encumberances Details
						</a>
					</div>
					<div id="collapseencumbrances" class="collapse" role="tabpanel"
						aria-labelledby="headingThree"
					>
						<div class="card-body">
<div class="d-flex justify-content-between">
  
  <h5 class="border-bottom border-gray pb-2">Encumberances Details</h5>
			      	<button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newEncumberancesModal" data-toggle="tooltip" title="Add New">
		            <i class="fa fa-plus-circle"></i>
		        	</button> </div>
                     <div class= "clear"></div><br>
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


<div class="modal fade" id="review_xxxxx_details" tabindex="-1"
  role="dialog" aria-labelledby="#review_motherfile_details" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-xl">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id=""> Review Motherfile</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
           <div class="card">
					<div class="card-header bg-dark text-white " role="tab"
						id="headingThree"
					>
						<a class="collapsed d-block  text-white " data-toggle="collapse"
							data-parent="#accordion" href="#collapseaddcertregis"
							aria-expanded="false" aria-controls="collapseFive"
							style="text-decoration: none !important"
						> <i class="fa fa-chevron-down pull-right"></i> <i
							class="fa fa-users"
						></i>Root of Title
						</a>
					</div>
					<div id="collapseaddcertregis" class="collapse" role="tabpanel"
						aria-labelledby="headingThree"
					>
						<div class="card-body">
              <div class="d-flex justify-content-between">

 					<h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
                    <button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
			            <i class="fa fa-plus-circle"></i>
			        </button>
              </div>
                     
               	  <div  class="table w-auto small table-responsive">
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
								<!-- <th>Approve</th> -->
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
										data-ps_term="${proprietorship_section.ps_term}"
										data-whatever="edit">
											<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
										</button>
										</p>
									</td>
									
										
									<!-- <td>
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
									</td> -->
									 
									
									</tr>
								</c:forEach>
							  </tbody>
			    
			            
			            </table>
			          </div>
			          
			          
			          
			          <div class="d-flex justify-content-between">

			           <h5 class="border-bottom border-gray pb-2">Memorial Details</h5>
			              <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newMemorialsModal" data-toggle="tooltip" title="Add New Memorial">
		            <i class="fa fa-plus-circle"></i>
		        </button>
                </div>
                     
               	  <div  class="table w-auto small table-responsive">
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
			          
			          <div class="d-flex justify-content-between">

                   <h5 class="border-bottom border-gray pb-2">Valuation Details</h5>
			       <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newValuationModal" data-toggle="tooltip" title="Add New Valuation Records">
		            <i class="fa fa-plus-circle"></i>
		        </button>
                </div>
			         
                     
               	  <div  class="table w-auto small table-responsive">
			           <table class="table table-bordered" id="lrd_valuation_details_dataTable">
			           
			              <thead>
			                <tr>
			
			                 <th>Date of Valuation</th>
			                 <th>Amount</th>
			                 <th>Remarks</th>
			                 <th>Edit</th>
			                  
			                  </tr>
			              </thead>
			              
			                <tbody>
			     <c:forEach items="${lrd_valuation_section}" var="valuation_section">
                <tr>
                    <td>${valuation_section.vs_date_of_valuation}</td>
                    <td>${valuation_section.vs_amount}</td>
                    <td>${valuation_section.vs_remarks}</td>
                    
                     <td>
						                    
						                    <p data-placement="top"  title="Edit">  
			          							<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
			          								 data-target="#newValuationModal"
			          								 data-target-id="${valuation_section.vs_id}"
			          								 data-vs_id="${valuation_section.vs_id}"  
			          								 data-vs_case_number="${valuation_section.vs_case_number}"
			          								 data-vs_date_of_valuation="${valuation_section.vs_date_of_valuation}"
			          								 data-vs_amount="${valuation_section.vs_amount}"
			 
			          								 data-vs_remarks="${valuation_section.vs_remarks}"
			          								 > 
			          								    	 
			          								    	 
			          								<span class="icon text-white-50"> 
			          								<i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>
			          						</p>
						                    
						                    </td>
                   
                  <%--  <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"   method="post" target="_blank" id="downloadForm"><input type="hidden" name="case_numer" id="case_number" value="${valuation_section.vs_id}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                    --%> 
                    	
                    
                     
                    
                    </tr>
            </c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div>
			          
			          <div class="d-flex justify-content-between"> 
                   <h5 class="border-bottom border-gray pb-2">Certificate Details</h5>
			      	<button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newCertificateModal" data-toggle="tooltip" title="Add New">
		            <i class="fa fa-plus-circle"></i>
		        	</button>
                </div>
			          
                     <div class= "clear"></div><br>
               	  <div  class="table w-auto small table-responsive">
			           <table class="table table-bordered" id="lrd_certificate_details_dataTable">
			           
			              <thead>
			                <tr>
			
			                 <th>Date of Issue</th>
			                 <th>To Whom Issued</th>
			                 <th>Serial Number</th>
			                 <th>Official Notes</th>
			                 
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
                    <td>
						                    
						                    <p data-placement="top"  title="Edit">  
			          							<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
			          								 data-target="#newCertificateModal"
			          								 data-target-id="${certificate_section.cs_id}"
			          								 data-cs_id="${certificate_section.cs_id}"  
			          								 data-cs_case_number="${certificate_section.cs_case_number}"
			          								 data-cs_date_of_registration="${certificate_section.cs_date_of_registration}"
			          								 data-cs_to_whom_issued="${certificate_section.cs_to_whom_issued}"
			          								 data-cs_serial_number="${certificate_section.cs_serial_number}"

			          								 data-cs_official_notes="${certificate_section.cs_official_notes}"
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
			          
                
                <div class="d-flex justify-content-between"> 
                  <h5 class="border-bottom border-gray pb-2">Reservation Details</h5>
			      	<button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newReservationModal" data-toggle="tooltip" title="Add New">
		            <i class="fa fa-plus-circle"></i>
		        	</button>
                </div>
                
					  
                     <div class= "clear"></div><br>
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
					</div>
				</div>
				<br>
				

	<div class="card">
					<div class="card-header bg-dark text-white " role="tab"
						id="headingThree"
					>
						<a class="collapsed d-block  text-white " data-toggle="collapse"
							data-parent="#accordion" href="#collapseencumbrances"
							aria-expanded="false" aria-controls="collapseFive"
							style="text-decoration: none !important"
						> <i class="fa fa-chevron-down pull-right"></i> <i
							class="fa fa-users"
						></i>Encumberances Details
						</a>
					</div>
					<div id="collapseencumbrances" class="collapse" role="tabpanel"
						aria-labelledby="headingThree"
					>
						<div class="card-body">
<div class="d-flex justify-content-between">
  
  <h5 class="border-bottom border-gray pb-2">Encumberances Details</h5>
			      	<button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newEncumberancesModal" data-toggle="tooltip" title="Add New">
		            <i class="fa fa-plus-circle"></i>
		        	</button> </div>
                     <div class= "clear"></div><br>
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
			          
                
							
						</div>
					</div>
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
                          
                             <button type="button" name="lc_btn_save_register_description" id="lc_btn_activate_final_register__" 
                             class="btn btn-block btn-success btn-icon-split "  >
                               <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Generate Register</span>
                          </button>
                  
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
     


<div class="modal fade" id="add_new_records_Info_frrv" tabindex="-1"
	role="dialog" aria-labelledby="add_new_records_Info_frrvmodal" aria-hidden="true"
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
                 <div class="form-group">
		                 <button class="btn btn-primary btn-icon-split" id="add_records_information_notes">
						<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Add New Records Information Notes</span>
						</button>
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
                     
                   
                  </div>
                  
                 
                   
                  
                  <div class="form-row">
                    <div class="col-md-4">
                      <label for="search_value">Commencement Date</label>
                      <input readonly class="form-control"  type="text" aria-describedby="nameHelp"  value="${commencement_date}" >
                    </div>
                    
                    <div class="col-md-4">
                      <label for="search_value">Date of Registration</label>
                        <input readonly type="text" class="form-control" aria-describedby="nameHelp"  value="${date_of_registration}">
                                                  
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
                        <label for="search_value">Job Number</label>
                           <input readonly class="form-control" id=""  name="cs_main_job_number"  type="text" value="${job_number}" >
                                                    
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
                                <label for="search_value">GLPIN</label>
                                <input class="form-control" id="txt_glpin"    type="text" aria-describedby="nameHelp" placeholder="GLPIN" value="${glpin}" readonly>
                              </div>
                      
                  </div>

                  <div class="form-row">
                   <div class="col-md-4">
                     <label for="search_value">Type of Plotting</label>
                     <input class="form-control" id="txt_lc_smd_type_of_plotting"  name="txt_lc_smd_type_of_plotting"  type="text" aria-describedby="nameHelp"  value="${smd_type_of_plotting}" readonly>
                   </div>
             
                     <div class="col-md-4">
                     <label for="search_value">SMD Reference Number</label>
                     <input class="form-control" id="txt_lc_smd_reference_number"  name="txt_lc_smd_reference_number"  type="text" aria-describedby="nameHelp"  value="${smd_reference_number}" readonly>
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
                      <input class="form-control" id="txt_lc_cc_no"  name="search_value"  type="text" aria-describedby="nameHelp" value="${cc_no}" readonly>
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
                       <input class="form-control" id="txt_lc_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp" value="${plan_no}" readonly>
                     </div>
                  <div class="col-md-4">
                    <label for="search_value">LTR Plan Number</label>
                   <input class="form-control" id="ltr_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${ltr_plan_no}" readonly>
                 
                    
                  </div>
                  <div class="col-md-4">
                    <label for="search_value">Registry Map No</label>
                    <input class="form-control" id="txt_lc_registry_mapref"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registry_mapref}" readonly>
                  </div>
                  
                 </div>
                 
                 <div class="form-row">
                 
                 
                 

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
          

<div class="modal fade" id="compose_search_report" tabindex="-1"
	role="dialog" aria-labelledby="compose_search_reportmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Compose Search Report</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="card">
          <div class="card-header">
            <i class="fa fa-pie-chart"></i>Records Information</div>
            <div class="card-body">
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
        </div>
        <div class="card">
          <div class="card-header">
            <i class="fa fa-pie-chart"></i>Summarize Search Reports</div>
          <div class="card-body">
             <!--  The Form starts here -->
         

            <div class="form-group">
          
          
          <div class="form-row">
            <div class="col-md-12">
              <label for="search_value">Report Summary</label>
       
      
       
          <textarea id="lc_search_report_summary_details_2" name="lc_search_report_summary_details" class="form-control col-sm-12" required rows=7  style="padding:50px !important;">${remark_or_comment} </textarea> 
                    
                    
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
            <div class="col-auto">
                <br><br>									                 
                   <button type="button" name="lc_btn_save_search_report_2" id="lc_btn_save_search_report_2" 
                   class="btn btn-block btn-secondary btn-icon-split "  >
               <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Save Report</span>
            </button>
              </div>
              
               <div class="col">
                  <br><br>
                  <button type="button" name="btn_preview_search_report" id="btn_preview_search_report" class="btn  btn-primary btn-icon-split "  >
              <span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Preview Search Report</span>
            </button>
              
              </div>
            </div>
          
        </div>
        
        
        
        
       
        
        
        
    
          
          <!-- The form Ends Hers -->
          
        </div>
       
      </div>

			</div>
			<div class="modal-footer ">

				
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="check_search_report" tabindex="-1"
	role="dialog" aria-labelledby="check_search_reporttmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading"> Check Search Report</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				
        <div class="card">
          <div class="card-header">
            <i class="fa fa-pie-chart"></i>Summarize Search Reports</div>
          <div class="card-body">
             <!--  The Form starts here -->
         

            <div class="form-group">
          
          
          <div class="form-row">
            <div class="col-md-12">
              <label for="search_value">Report Summary</label>
       
      
       
          <textarea id="lc_search_report_summary_details_3" name="lc_search_report_summary_details" class="form-control col-sm-12" required rows=7  style="padding:50px !important;">${remark_or_comment} </textarea> 
                    
                    
                   <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
     --%>
                        
              </div>
              
             
           
          </div>
          
          
          
           
          <div class="form-row">
             <div class="col-auto">
                <br><br>									                 
                   
                  
          
              </div>
            <div class="col-auto">
                <br><br>									                 
                   <button type="button" name="lc_btn_save_search_report_3" id="lc_btn_save_search_report_2" 
                   class="btn btn-block btn-secondary btn-icon-split "  >
               <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Save Report</span>
            </button>
              </div>
              
               <div class="col">
                  <br><br>
                  <button type="button" name="btn_preview_search_report" id="btn_preview_search_report_2" class="btn  btn-primary btn-icon-split "  >
              <span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Preview Search Report</span>
            </button>
              
              </div>
            </div>
          
        </div>
        
        
        
        
       
        
        
        
    
          
          <!-- The form Ends Hers -->
          
        </div>
       
      </div>

			</div>
			<div class="modal-footer ">

				
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="check_search_report_details" tabindex="-1"
	role="dialog" aria-labelledby="check_search_report_detailsmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading"> Check Search Report Details</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="card">
          <div class="card-header">
            <i class="fa fa-pie-chart"></i>Records Information</div>
            <div class="card-body">
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
        </div>
        <div class="card">
          <div class="card-header">
            <i class="fa fa-pie-chart"></i>Summarize Search Reports</div>
          <div class="card-body">
             <!--  The Form starts here -->
         

            <div class="form-group">
          
          
          <div class="form-row">
            <div class="col-md-12">
              <label for="search_value">Report Summary</label>
       
      
       
          <textarea id="lc_search_report_summary_details_4" name="lc_search_report_summary_details_final" class="form-control col-sm-12" required rows=7  style="padding:50px !important;">${remark_or_comment} </textarea> 
                    
                    
                   <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
     --%>
                        
              </div>
              
             
           
          </div>
          
          
          
           
          <div class="form-row">
             <div class="col-auto">
                <br><br>									                 
                   
                     <!-- <button type="button" name="btn_compose_certificate_template" id="btn_compose_certificate_template" class="btn  btn-primary btn-icon-split "  >
              <span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
            </button> -->
            
          
              </div>
            <div class="col-auto">
                <br><br>									                 
                   <button type="button" name="lc_btn_save_search_report_3" id="lc_btn_save_search_report_3" 
                   class="btn btn-block btn-secondary btn-icon-split "  >
               <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Save Report</span>
            </button>
              </div>
              
               <div class="col">
                  <br><br>
                  <button type="button" name="btn_preview_search_report" id="btn_preview_search_report_2" class="btn  btn-primary btn-icon-split "  >
              <span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Preview Search Report</span>
            </button>
              
              </div>
            </div>
          
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

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="confirm_otp_for_approval_search" tabindex="-1"
  role="dialog" aria-labelledby="#confirm_otp_for_approval_search" aria-hidden="true">
  <div class="modal-dialog modal-md modal-dialog-centered">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id=""> Request and Enter OTP for Approval (Search)</h5>
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
            <input type="button" id="lc_btn_approve_search_for_signature" class="btn btn-primary btn-block w-100" value="Approve" />  
         </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="preview_composed_report" tabindex="-1"
  role="dialog" aria-labelledby="#check_signed_report" aria-hidden="true">
  <div class="modal-dialog modal-md modal-dialog-centered">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id=""> Check Search Report</h5>
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
            <input type="button" id="btn_preview_search_report_2" class="btn btn-warning btn-block w-100" value="View Search Report" />  
         </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="check_signed_report" tabindex="-1"
  role="dialog" aria-labelledby="#check_signed_report" aria-hidden="true">
  <div class="modal-dialog modal-md modal-dialog-centered">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id=""> Check Signed Report</h5>
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
            <input type="button" id="btn_preview_final_search_report" class="btn btn-warning btn-block w-100" value="View Search Report" />  
         </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="enter_assessed_value_and_duty_payable" tabindex="-1"
	role="dialog" aria-labelledby="enter_assessed_value_and_duty_payable" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading"> Enter Assessed value and Duty Payable</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
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
			<div class="modal-footer ">

				
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>



<div class="modal fade" id="enter_assessed_value_and_duty_payable" tabindex="-1"
	role="dialog" aria-labelledby="enter_assessed_value_and_duty_payable" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading"> Enter Assessed value and Duty Payable</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
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
			<div class="modal-footer ">

				
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="generate_concurrence_certificate" tabindex="-1"
	role="dialog" aria-labelledby="generate_concurrence_certificate" aria-hidden="true"
>
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Generate Concurrence Certificate</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                <div class="card card-body">
                    <div class="form-row">
                        <div class="col-md-12">
                          <label for="search_value">Certificate Summary</label>
                              <textarea id="lc_search_report_summary_details_cs" name="lc_search_report_summary_details_cs" class="form-control col-sm-12" required rows=7  style="padding:50px !important;">${remark_or_comment} </textarea> 
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
                                        
                                           <button type="button" name="lc_btn_save_search_report_cs" id="lc_btn_save_search_report_cs" 
                                           class="btn btn-block btn-secondary btn-icon-split "  >
                                             <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Save Certificate</span>
                                        </button>
                                
                                </div>

                                <div class="col-6">
                                    <br>
                                  
                                     <button type="button" name="lc_btn_activate_final_concurrence_certificate_cs" id="lc_btn_activate_final_concurrence_certificate_cs" 
                                     class="btn btn-block btn-success btn-icon-split "  >
                                       <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Generate Certificate</span>
                                  </button>
                                </div>
                                
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


<div class="modal fade" id="check_signed_certificate_of_registration_of_instrument" tabindex="-1"
  role="dialog" aria-labelledby="#check_signed_report" aria-hidden="true">
  <div class="modal-dialog modal-md modal-dialog-centered">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Check Signed View Certificate</h5>
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
            <input type="button" id="lc_btn_activate_final_concurrence_certificate_" class="btn btn-primary btn-block w-100" value="View Certificate" />  
         </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>

<div class="modal fade" id="generate_deed_number" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Generate Deed Number</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <!-- <div class="form-group">
                <label for="job_number">Certificte Type</label>
                <select name="lc_txt_type_of_certificate" id="lc_txt_type_of_certificate" class="form-control input-sm" data-style="btn-info" required data-live-search="true">
                    <option value="${certificate_type == 'Individual' ? '' : certificate_type}">${certificate_type == 'Individual' ? '-- select --' : certificate_type}</option>
                    <option value="Provisional Certificate">Provisional Certificate</option>
                    <option value="Land Certificate">Land Certificate</option>
                    <option value="Substituted Certificate">Substituted Certificate</option>
                </select> 
            </div> -->
            <div class="form-group">
                <label for="" class="col-form-label">Deed Number:</label>
                  <input type="text" class="form-control" id="lc_txt_deed_number" readonly value="${deed_number}" />
            </div>
            <div class="mt-3">
                <input type="button" id="lc_btn_generate_deed_number_only" 
                class="btn btn-primary btn-block w-100" 
                value="Generate"
                <c:if test="${not empty deed_number and deed_number != 'null' and not fn:contains(deed_number, '-')}">
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


<div class="modal fade" id="generate_ls_number" tabindex="-1"
  role="dialog" aria-labelledby="#generate_ls_number" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Generate Land Serial (LS) Number</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <!-- <div class="form-group">
                <label for="job_number">Certificte Type</label>
                <select name="lc_txt_type_of_certificate" id="lc_txt_type_of_certificate" class="form-control input-sm" data-style="btn-info" required data-live-search="true">
                    <option value="${certificate_type == 'Individual' ? '' : certificate_type}">${certificate_type == 'Individual' ? '-- select --' : certificate_type}</option>
                    <option value="Provisional Certificate">Provisional Certificate</option>
                    <option value="Land Certificate">Land Certificate</option>
                    <option value="Substituted Certificate">Substituted Certificate</option>
                </select> 
            </div> -->
            <div class="form-group">
                <label for="" class="col-form-label">LS Number:</label>
                  <input type="text" class="form-control" id="lc_txt_ls_number" readonly value="${ls_number}" />
            </div>
            <div class="mt-3">
                <input type="button" id="lc_btn_generate_ls_number_only" 
                class="btn btn-primary btn-block w-100" 
                value="Generate"
                <c:if test="${not empty ls_number and ls_number != 'null' and not fn:contains(ls_number, '-')}">
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

<div class="modal fade" id="generate_file_number" tabindex="-1"
  role="dialog" aria-labelledby="#generate_ls_number" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Open File</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="" class="col-form-label">File Number:</label>
                  <input type="text" class="form-control" id="lc_txt_file_number" readonly value="${file_number}" />
            </div>
            <div class="mt-3">
                <input type="button" id="lc_btn_generate_file_number_only" 
                class="btn btn-primary btn-block w-100" 
                value="Generate"
                <c:if test="${not empty file_number and file_number != 'null' and not fn:contains(file_number, '-')}">
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


<div class="modal fade" id="ground_rent" tabindex="-1"
  role="dialog" aria-labelledby="#ground_rent" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Ground Rent Amount</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="" class="col-form-label">Ground Rent Amount:</label>
                  <input type="text" class="form-control" id="lc_txt_ground_rent" value="${ground_rent}" />
            </div>
            <div class="mt-3">
                <input type="button" id="lc_btn_generate_ground_rent_only" 
                class="btn btn-primary btn-block w-100" 
                value="Update Ground Rent"
                <c:if test="${not empty ground_rent and ground_rent != 'null' and not fn:contains(ground_rent, '-')}">
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

<div class="modal fade" id="preview_certificate_deed_land_serial_number" tabindex="-1"
  role="dialog" aria-labelledby="#generate_ls_number" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Preview Certificate/Deed Number/Land Serial Number</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <!-- <div class="form-group">
                <label for="job_number">Certificte Type</label>
                <select name="lc_txt_type_of_certificate" id="lc_txt_type_of_certificate" class="form-control input-sm" data-style="btn-info" required data-live-search="true">
                    <option value="${certificate_type == 'Individual' ? '' : certificate_type}">${certificate_type == 'Individual' ? '-- select --' : certificate_type}</option>
                    <option value="Provisional Certificate">Provisional Certificate</option>
                    <option value="Land Certificate">Land Certificate</option>
                    <option value="Substituted Certificate">Substituted Certificate</option>
                </select> 
            </div> -->
            <div class="form-group">
              <label for="" class="col-form-label">LS Number:</label>
                <input type="text" class="form-control" id="lc_view_ls_number" readonly value="${ls_number}" />
          </div>
            <div class="form-group">
                <label for="" class="col-form-label">Deed Number:</label>
                  <input type="text" class="form-control" id="lc_view_deed_number" readonly value="${deed_number}" />
            </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="imprint_job_number_and_commissioners_stamps_on_document" tabindex="-1"
  role="dialog" aria-labelledby="#upload_coordinate" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Imprint Job Number and Commissioners Stamps on Document</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
          <h5>Check Payments</h5>
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

               <div class="form-group">
                <label for="" class="col-form-label">Job Number:</label>
                  <input type="text" class="form-control" id="" readonly value="${job_number}" />
            </div>
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary "
            data-dismiss="modal">Close</button>
      </div>
     </div>
  </div>
</div>


<div class="modal fade" id="check_for_payment_receipts_and_ghanagov" tabindex="-1"
  role="dialog" aria-labelledby="#check_for_payment_receipts_and_ghanagov" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
     <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title" id="">Check for Payment(Receipts and Ghana.Gov)</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
          <div class="card mb-3">
            <div class="card-header">
            	<h3 class="text-primary">Verify Stamp Duty Bills & Receive Document</h1>
            </div>
    
			
            <div class="card-body"> 				     
	               <div class="form-group">
							<div class="form-row">
								<div class="col-sm-7">
									<input class="form-control" id="txt_ref_number_for_payment_rec" type="text" aria-describedby="Ref Number" placeholder="Enter Reference/Job Number" required="">
								</div>
								<div class="col-sm-5">
									<button class="btn btn-success btn-icon-split float-right  btn-lg" id="btn_load_bill_details_after_payment_stamp_duty_receive" >
											<span class="icon text-white-50"> <i class="fa fa-search"></i></span><span class="text">Search </span>
										</button>
								</div>
							</div>
					</div>
					<div  id="payment_details_section"></div>			          
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
