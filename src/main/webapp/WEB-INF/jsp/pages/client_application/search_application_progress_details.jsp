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
			               
			                <li><a href="#link-1">Coordinate Entry<br /><small>Coordinate Entry</small></a></li>
			            
			               <li><a href="#link-2">Record Verification<br /><small>Record Verification</small></a></li>
			                <!--  <li><a href="#link-2">Record Verification<br /><small>Record Verification</small></a></li> -->
			          		 <li><a href="#link-3">Search Report Preparation<br /><small>Search Report Preparation</small></a></li>
			          		 <li><a href="#link-4">Quality Control<br /><small>Signing</small></a></li>
							
			            </ul>
			
			            <div>
			                

			      
			                <div id="link-1" class="">
			                	<br>
			                    <h3 class="border-bottom border-gray pb-2">Coordinate Entry</h3>
			                    
			                    
			                      <div class="row">
			                     <!--   Here is the right Table -->
							        <div class="col-lg-12">
							          <!-- Example Pie Chart Card-->
							          <div class="card mb-3">
							            <div class="card-header">
							              <i class="fa fa-pie-chart"></i>Coordinate Entry</div>
							            <div class="card-body">
							               <!--  The Form starts here -->
							              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
							       
			       
			            
			            
			            
			             <div id="lcfrs-map" ></div>
			             
			                 <!--  Here is where the fee list comes -->
             
           
									          
							              </form>
							            
							            <!-- The form Ends Hers -->
							            
							          </div>
							          
							          
							             <!--  Scanned Maps -->
          
          
                      <!--  Zoom to cooedinate -->
     
           
        
        
        
        
        
                    <div class="bs-example">

			  
					                <div class="btn-group mr-2">
								     <button type="button" class="btn btn-primary" id="lc_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addcoordinatetoplot" data-toggle="tooltip" title="Add Coordinate">
							            <i class="fa fa-plus-circle"></i>
							        </button>
							        
							        
							            <button type="button" class="btn btn-primary"  id="lrd_btn_add_coordinate_by_csv" data-placement="top" data-toggle="modal" data-target="#uploadcoordiantecsv" data-toggle="tooltip" title="Upload CSV">
						            <i class="fa fa-upload"></i>
						        </button>
							        
							          <button type="button" class="btn btn-primary"  id="lc_btn_visualise_coordinate" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
							            <i class="fa fa-eye"></i>
							        </button>
							        
							         <button type="button" class="btn btn-primary" id="btn_lc_save_parcel_for_search" data-placement="top" data-toggle="tooltip" title="Save">
							            <i class="fa fa-save"></i>
							        </button>

							   </div> 
			
						</div>
						
			
			       
			            
			            
			          
			             
			                 <!--  Here is where the fee list comes -->
             
           <div  class="table w-auto small">
						           <table class="table table-bordered" id="coordinatelis_Table" width="100%" cellspacing="0">
						           
						              <thead>
						                <tr>
						                 
						                 
						                 
						                 <th>name</th>
						                 <th>x_coordinate</th>
						                 <th>y_coordinate</th>
						                 <th>Remove</th>
						                  </tr>
						              </thead>
						              
						                <tbody>
						    
						  </tbody>
						             <!--  <tfoot>
						                <tr>
						                  <th>Job Number</th>
						                  <th>Applicant Name</th>
						                  <th>Status</th>
						                  <th>Case Details</th>
						                      
						                       <th>Add To List</th>
						                </tr>
						              </tfoot> -->
						            
						            </table>
						          </div>
									         
        
          <div class="form-group">
											        <div class="form-row">  <label for="lc_bl_wkt_polygon">WKT Polygon</label>
											              <input class="form-control" id="lc_bl_wkt_polygon"  name="lc_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
				            
											        	<!-- <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" ></textarea> -->
											        </div>
											        
											  
										         </div>
			         
        
        
        
        
							         
							        </div>
							      <!--   Here is the end of right table -->
							  
							      </div>
							      

							     </div>
			                </div>
			                
			                <div id="link-2" class="">
			                	<br>
			                    <h3 class="border-bottom border-gray pb-2">Records Information Search</h3>
			                    
			                    
			                      <div class="row">
			                     <!--   Here is the right Table -->
							        <div class="col-lg-12">
							          <!-- Example Pie Chart Card-->
							          <div class="card mb-3">
							            <div class="card-header">
							              <i class="fa fa-pie-chart"></i>Records Information</div>
							            <div class="card-body">
							               <!--  The Form starts here -->
							              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
							       
			            <!-- Maps Details Starts Here  -->
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
			
			
			       
			            
			            
			            
			             <div id="lc-map" ></div>
			             
			                 <!--  Here is where the fee list comes -->
             
           
									          
							              </form>
							            
							            <!-- The form Ends Hers -->
							            
							          </div>
							          
							          
							             <!--  Scanned Maps -->
          
          
                      <!--  Zoom to cooedinate -->
         <div class="row">
					                                                        
            <div class="col-md-4">
                <div class="form-group">
                  
                    <input class="form-control" type="text" name="lc_x_coordinate" placeholder="X-Coordinate" id="lc_x_coordinate"> 
                </div>
            </div>
            
            
            <div class="col-md-4">
                <div class="form-group">
                  
                    <input class="form-control" type="text" name="lc_y_coordinate" placeholder="Y-Coordinate"  id="lc_y_coordinate"> 
                  
            
                </div>
            </div>
            
            <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lc_btn_show_location" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-map-marker"></i> </button>
            
                </div>
            </div>
            
            <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lc_btn_load_for_scanned_maps_by_point" data-placement="top" data-toggle="tooltip" title="Search Scanned Map"><i class="fa fa-check-circle"></i> </button>
            
                </div>
            </div>

        </div>
        
          
            <div class="row">
					                                                        
            <div class="col-md-8">
                <div class="form-group">
                  
                       		 
			
              <select name="geoserverscannedimages_list" id="geoserverscannedimages_list" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
              <option value="-1">No Scanned Image</option>
              </select> 
                </div>
            </div>

            <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lc_btn_search_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="search_for_scanned_maps"><i class="fa fa-search"></i> </button>
            
                </div>
            </div>
             <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lc_btn_load_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="Load"><i class="fa fa-check-circle"></i> </button>
            
                </div>
            </div>

        </div>
        
        
        
        
        
			            
			            
		
									         
        
        
        
        
        
							         
							        </div>
							      <!--   Here is the end of right table -->
							  
							      </div>
							      

							     </div>
			                </div>
			                
			                <div id="link-3" class=""><br>
			                    <h3 class="border-bottom border-gray pb-2">Search Report Preparation</h3>
			                   <div class="row form-group ">
			
			 
			      
			      
							      
							       <!--   Here is the right Table -->
							        <div class="col-lg-12">
							          <!-- Example Pie Chart Card-->
							          <div class="card mb-10">
							            <div class="card-header">
							              <i class="fa fa-pie-chart"></i>Summarize Search Reports</div>
							            <div class="card-body">
							               <!--  The Form starts here -->
							           
							
									          <div class="form-group">
							            
							            
							            <div class="form-row">
							              <div class="col-md-12">
							                <label for="search_value">Report Summary</label>
											 
											
											 
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
							              <div class="col-auto">
									              <br><br>									                 
						               				<button type="button" name="lc_btn_save_search_report" id="lc_btn_save_search_report" 
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
							      <!--   Here is the end of right table -->
							  
							      </div>
			
			 </div>
			                </div>
			                           
			                <div id="link-4" class=""><br>
			                    <h3 class="border-bottom border-gray pb-2">Signing and Generate Report</h3>
									          
									 
									  <div class="row">
						 
						       			<!--   Here is the right Table -->
								       
								         
							            
								       
								        <div class="col-lg-12">
								          <!-- Example Pie Chart Card-->
								          <div class="card mb-3">
								            <div class="card-header">
								              <i class="fa fa-pie-chart"></i>Proof Reading of Search Report</div>
								            <div class="card-body">
								                 <textarea id="lc_search_report_summary_details_final" 
								                 name="lc_search_report_summary_details_final" 
								                 class="form-control col-sm-12" required rows=10 style="padding:150px !important">${remark_or_comment} </textarea> 
			        	                    
								             <div class="form-row">
							              
							              <div class="col-auto">
							              		<br>
							                    <button type="button" name="lc_btn_save_search_report_final" id="lc_btn_save_search_report_final" 
							                    class="btn btn-block btn-secondary btn-icon-split "  >
											    	 <span class="icon text-white-50"> <i class="fas fa-upload fa-2x"></i></span><span class="text">Update Report</span>
									    		</button>
							               </div>
							              
							               <div class="col-auto">
							               		<br>
							               		<button type="button" name="btn_generate_pvlmd_search_report" id="btn_generate_pvlmd_search_report" 
							               		class="btn  btn-success btn-icon-split "  >
									    			<span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Approve</span>
									    		</button>
							               </div>

										   <div class="col-auto">
											<br>
											<button type="button" name="btn_preview_final_search_report" id="btn_preview_final_search_report" 
											class="btn  btn-primary btn-icon-split "  >
											 <span class="icon text-white-50"> <i class="fas fa-print fa-2x"></i></span><span class="text">Preview Search Report</span>
										 </button>
										</div>
							               
							               
							               
							            </div>
								          </div>
								         
								        </div>
								      <!--   Here is the end of right table -->
								  
								      </div>
								      
								      
								       <div class="col-lg-4">
								          <!-- Example Pie Chart Card-->
								          <div class="card mb-3">
								            
								            <div class="card-body">
								               <!--  The Form starts here -->
								           
								              	  <div class="form-group row"> 
												   <!--  <div class="col-sm-12">
												    
												      <figure class="figure">
														  <img src="https://dummyimage.com/595%20x%20842/accc93/000000.png&text=Sample+Final+Report" class="figure-img img-fluid rounded" alt="A generic square placeholder image with rounded corners in a figure.">
														  <figcaption class="figure-caption text-right">Please Confirm Report</figcaption>
														</figure>
												      
												    </div> -->
												  </div>
												  
												  
											<input type="text"  class="form-control form-control-plaintext" id="staticEmail" value="Is document Signed">
									                
										    		
								          </div>
								         
								        </div>
								      <!--   Here is the end of right table -->
								  
								      </div>
								      
								 </div>
			               
			  					</div>
			                
			                
			     
			               
			                
			            </div>
			        </div>
							
          
          
          
          
             <jsp:include page="../client_application/_application_process_footer.jsp"></jsp:include>
     