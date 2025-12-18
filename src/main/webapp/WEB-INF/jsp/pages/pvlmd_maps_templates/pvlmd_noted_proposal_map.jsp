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


  <jsp:include page="../includes/_header.jsp"></jsp:include>
  

  <% 


	  
%>

  
  


    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="#">PVLMD Plottings (CRO and GARRO)</a>
        </li>
        <li class="breadcrumb-item active">Maps</li>
      </ol>
           
           
      
      
      
       <div class="row">
    
    
     <div class="col-lg-3">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Map Plottings</div>
            <div class="card-body">
            
         
		     <div class="btn-group mr-2">
		      <button type="button" class="btn btn-primary" id="pvlmd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addcoordinatetoplot" data-toggle="tooltip" title="Draw a Line">
            <i class="fa fa-plus-circle"></i>
           
        </button>
        
         
               
          <button type="button" class="btn btn-primary"  id="lrd_btn_add_coordinate_by_csv" data-placement="top" data-toggle="modal" data-target="#uploadcoordiantecsv" data-toggle="tooltip" title="Upload CSV">
            <i class="fa fa-upload"></i>
        </button>
        
        
		   <button type="button" class="btn btn-primary"  id="pvlmd_btn_visualise_coordinate" data-placement="top" data-toggle="tooltip" title="Visualise Coordinate">
            <i class="fa fa-eye"></i>
        </button>

        
        
      

		 
		 </div>
		    
		    
		    
		      <!--  WKT row here -->
        <div class="form-group">
       
        <div class="form-row"> 
        
        
        
      
        
        </div>
         </div>
         
         
               <!--  WKT row here -->
       <!--  <div class="form-group">
       
        <div class="form-row"> 
        
        	<label class="radio-inline">
      <input type="radio" name="optradio" checked>Answer 1</label>
    <label class="radio-inline">
      <input type="radio" name="optradio">Answer 2</label>
   
		       
        
        </div>
         </div>
		     -->
		    
                 <!--  WKT row here -->
     <!--    <div class="form-group">
       
        <div class="form-row"> 
        
				        	<label for="selectsingle">Select a single option:</label>
				 <select id="selectsingle" class="form-control">
				    <option>Dogs</option>
				    <option>Cats</option>
				    <option>Fish</option>
				    <option>Birds</option>
				 </select>
        </div>
         </div>
		     -->
         
    
    
                 <!--  Here is where the fee list comes -->
             
              <div  class="table-responsive w-auto small">
           <table class="table table-bordered" id="coordinatelis_Table" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                 
                 <th>name</th>
                 <th>x_coordinate</th>
                 <th>y_coordinate</th>
                 <th>Action</th>
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
    
    
     <!--  WKT row here -->
        <div class="form-group">
       
        <div class="form-row">  <label for="bl_job_purpose">WKT Polygon</label>
        <textarea rows="2" class="form-control" placeholder="" id="pvlmd_bl_wkt_polygon" ></textarea>
        </div>
        <br>
        
		     <div class="btn-group mr-2">
		      
        
		   <button type="button" class="btn btn-primary"  id="pvlmd_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon(KKT)">
            <i class="fa fa-map"></i>
        </button>
        
          <button type="button" class="btn btn-primary"  id="pvlmd_btn_save_wkt" data-placement="top" data-toggle="tooltip" title="Save Parcels">
            <i class="fa fa-save"></i>
        </button>
        
        
        
      

		 
		 </div>
        
         </div>
         
         
         
          <!--  Zoom to cooedinate -->
         <div class="row">
					                                                        
            <div class="col-md-5">
                <div class="form-group">
                  
                    <input class="form-control" type="text" name="name"  id="pvlmd_x_coordinate_mak" placeholder="X-Coordinate"> 
                </div>
            </div>
            
            
            <div class="col-md-5">
                <div class="form-group">
                  
                    <input class="form-control" type="text" name="name" id="pvlmd_y_coordinate_mak" placeholder="Y-Coordinate"> 
                  
            
                </div>
            </div>
            
            <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="pvlmd_btn_show_location" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-map-marker"></i> </button>
            
                </div>
            </div>
            
             <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="pvlmd_btn_load_for_scanned_maps_by_point" data-placement="top" data-toggle="tooltip" title="Search Scanned Map"><i class="fa fa-check-circle"></i> </button>
            
                </div>
            </div>
            

        </div>
        
        
        
       <!-- search by reference nunber -->
         
			          <div class="row">
								                                                        
			            <div class="col-md-8">
			                <div class="form-group">
			                  
			        	  <input class="form-control" id="pvlmd_search_by_text"  name="pvlmd_search_by_text"  type="text"  placeholder="Search by Ref Number" required >
						   
			                </div>
			            </div>
			
			          
			          <!-- <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="pvlmd_btn_search_by_certificate_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-retweet"></i> </button>
			            
			                </div>
			            </div> -->
			            
			            <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="pvlmd_btn_search_by_reference_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-search"></i> </button>
			            
			                </div>
			            </div>
			            
			
			        </div>
			        
        
          <input id="pvlmd_btn_search_by_transaction_reference_number"   type="hidden"  >
    
        
          <!--  Scanned Maps -->
          
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
                 <button type="button" class="btn btn-primary" id="pvlmd_btn_search_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="Search for related sheets"><i class="fa fa-search"></i> </button>
            
                </div>
            </div>
             <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="pvlmd_btn_load_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="Show Selected Sheet"><i class="fa fa-check-circle"></i> </button>
            
                </div>
            </div>

        </div>
        
        
         <div class="row">
        
         <h5>More than one overlay</h5>
         
                       <div  class="table-responsive w-auto small">
           <table class="table table-bordered" id="pvlmd_more_than_one_parcel_Table" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                 
                 <th>Reference Number</th>
                 <th>NT Number</th>
                 <th>Locality</th>
                 <th>Details</th>
                  </tr>
              </thead>
              
                <tbody>
    
  			</tbody>
           
            
            </table>
          </div>
         
         </div>
         
         
         <!-- 
           <div class="row">
					
					<h5> Search for Transaction</h5>
								                                                        
			            <div class="col-md-8">
			                <div class="form-group">
			                  
			        	  <input class="form-control" id="pvlmd_search_transaction_by_text"  name="pvlmd_search_transaction_by_text"  type="text"  placeholder="Search by Ref Number" required >
						   
			                </div>
			            </div>
			
			          
			          <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="pvlmd_btn_search_by_certificate_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-retweet"></i> </button>
			            
			                </div>
			            </div>
			            
			            <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="pvlmd_btn_search_transaction" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-search"></i> </button>
			            
			                </div>
			            </div>
			            
			
			        </div>
          -->
         			<!--  <div class="row">
        
         
								<div class="table w-auto small">
									<table class="table table-bordered"
										id="pvlmd_transaction_all_dataTable" width="100%" cellspacing="0"
									>

										<thead>
											<tr>

												<th>Name</th>
												<th>Grantor</th>
												<th>Certificate Number</th>
												<th>Instrument Type</th>
												<th>Details</th>
											</tr>
										</thead>

										<tbody>

										</tbody>
			

									</table>
								</div>
							</div>
            -->

    
         
         
         
    
            
          
            </div>
          
          </div>
          
         
        
    
   
        
      </div>
    
    
    
     <div class="col-lg-9">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Map sample</div>
            <div class="card-body">
            
          
          
            <!-- Maps Details Starts Here  -->
            <div class="bs-example">
            
            
            
            <div class="form-check form-check-inline">
		  <input type="radio" class="form-check-input" id="draw" name="interaction_type" value="draw" checked>
		  <label class="form-check-label" for="draw">Draw</label>
		</div>
		
		<!-- Material inline 2 -->
		<div class="form-check form-check-inline">
		  <input type="radio" class="form-check-input" id="modify" name="interaction_type" value="modify">
		  <label class="form-check-label" for="modify">Modify</label>
		</div>
		
		
		
		<!-- <div id="rates">
		  <input type="radio" id="r1" name="rate" value="Fixed Rate"> Fixed Rate
		  <input type="radio" id="r2" name="rate" value="Variable Rate"> Variable Rate
		  <input type="radio" id="r3" name="rate" value="Multi Rate" checked="checked"> Multi Rate  
		</div> -->
            
            
            
    <div class="btn-group mr-2">
       
              
       <button type="button" class="btn btn-primary" id="pvlmd_btnprintmap" data-placement="top" data-toggle="tooltip" title="Print Map">
            <i class="fa fa-print"></i>
        </button>
		 
		  
        <button type="button" class="btn btn-primary" id="pvlmd_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
            <i class="fa fa-search"></i>
        </button>
		
		 
		 <button type="button" class="btn btn-primary" id="pvlmd_btngeneratesearchreport" data-placement="top" data-toggle="tooltip" title="Print Search Report">
            <i class="fa fa-print"></i>
        </button> 
        
         
		 <button type="button" class="btn btn-primary" id="pvlmd_btn_download_geojson" data-placement="top" data-toggle="tooltip" title="Geojson">
            <i class="fa fa-download"></i>
        </button> 
		 
       

        
        
    </div>
   
    
      <div class="btn-group">
       Scale:
    </div>
    <div class="btn-group">
        <input class="form-control" id="pvlmd_scale_value_e"  name="pvlmd_scale_value_e" type="text" class="autocomplat" />
   
       
       <select name="pvlmd_scale_value" id="pvlmd_scale_value">
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
         <input type="checkbox" checked="checked" id="pvlmd_lockmapscale">
          <button type="button" class="btn btn-primary" id="pvlmd_btn_scale_zoom" data-placement="top" data-toggle="tooltip" title="Zoom to Scale">
            <i class="fa fa-search"></i>
        </button>
    </div>
   
    
     
    
</div>

          
            <!-- Maps Details Starts Here  -->
   <div class="bs-example">
   
   
    

  
    
   

    
   
    
    
    
</div>
       
            
            
            
             <div id="pvlmd-map" ></div>
             
             
             
             
          <form action="${pageContext.request.contextPath}/#"  method="post" target="_blank">



 


        </form>
          
          
            
          
            </div>
            <div class="card-footer small text-muted">Registration Process Movement</div>
          </div>
          
         
        
    
   
        
      </div>
     </div>
      
      
   
      
    </div>
  

 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
