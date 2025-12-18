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
    

    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">LRD Plottings</a>
        </li>
        <li class="breadcrumb-item active">Maps : Total Parcels (${parcel_count})</li>
      </ol>

       <div class="row">
    
    
     <div class="col-lg-3">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Map sample</div>
            <div class="card-body">
            
         
		     <div class="btn-group mr-2">
		      <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addcoordinatetoplot" data-toggle="tooltip" title="Add Coordinate">
            <i class="fa fa-plus-circle"></i>
        </button>
        
          <button type="button" class="btn btn-primary"  id="lrd_btn_add_coordinate_by_csv" data-placement="top" data-toggle="modal" data-target="#uploadcoordiantecsv" data-toggle="tooltip" title="Upload CSV">
            <i class="fa fa-upload"></i>
        </button>
        
		   <button type="button" class="btn btn-primary"  id="lrd_btn_visualise_coordinate" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-eye"></i>
        </button>
        
		   <button type="button" class="btn btn-primary"  id="lrd_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-map"></i>
        </button>
        
          <button type="button" class="btn btn-primary"  id="lrd_btn_refresh_btn_wkt" data-placement="top" data-toggle="tooltip" title="Refresh">
            <i class="fa fa-retweet" style="color:red"></i>
        </button>
        
        
          <button type="button" class="btn btn-primary"  id="lrd_btn_save_wkt" data-placement="top" data-toggle="tooltip" title="Plot Parcel">
            <i class="fa fa-save"></i>
        </button>
       

       
       
      
	
	<!-- 	<button type="button" class="btn btn-primary" id="lrd_btn_generate_search_report" data-placement="top" data-toggle="tooltip" title="Print Search Report">
            <i class="fa fa-print"></i>
        </button>
		  -->
		 
		 </div>
		    

                 <!--  Here is where the fee list comes -->
             
             <div  class="table w-auto small table-responsive">
           <table class="table table-bordered" id="coordinatelis_Table" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                 
                 <th>name</th>
                 <th>x_coordinate</th>
                 <th>y_coordinate</th>
                 <th>remove</th>
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
        <textarea rows="2" class="form-control" placeholder="" id="lrd_txt_wkt_polygon"></textarea>
        </div>
         </div>
         
         
         
          <!--  Zoom to cooedinate -->
         <div class="row">
					                                                        
            <div class="col-md-5">
                <div class="form-group">
                  
                    <input class="form-control" type="text" name="lrd_x_coordinate" placeholder="X-Coordinate" id="lrd_x_coordinate"> 
                </div>
            </div>
            
            
            <div class="col-md-5">
                <div class="form-group">
                  
                    <input class="form-control" type="text" name="lrd_y_coordinate" placeholder="Y-Coordinate"  id="lrd_y_coordinate"> 
                  
            
                </div>
            </div>
            
            <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lrd_btn_show_location" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-map-marker"></i> </button>
            
                </div>
            </div>
            
            <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lrd_btn_load_for_scanned_maps_by_point" data-placement="top" data-toggle="tooltip" title="Search Scanned Map"><i class="fa fa-check-circle"></i> </button>
            
                </div>
            </div>

        </div>
        
        
            
        
         
			          <div class="row">
								                                                        
			            <div class="col-md-8">
			                <div class="form-group">
			                  
			        	  <input class="form-control" id="lrd_search_by_text"  name="lrd_search_by_text"  type="text"  placeholder="Search by Certificate Number" required >
						   
			                </div>
			            </div>
			
			          
			          <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="lrd_btn_search_by_certificate_number" data-placement="top" data-toggle="tooltip" title="Search By Certificate Number"><i class="fa fa-retweet"></i> </button>
			            
			                </div>
			            </div>
			            
			            <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="lrd_btn_search_by_reference_number" data-placement="top" data-toggle="tooltip" title="Serach by Reference Number"><i class="fa fa-search"></i> </button>
			            
			                </div>
			            </div>
			            
			
			        </div>

          <!--  Scanned Maps -->
          
            <div class="row">
					                                                        
            <div class="col-md-8">
                <div class="form-group">
                  
                       		 
			
              <select name="geoserverscannedimages_list" id="geoserverscannedimages_list" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
              <option value="-1">No Scanned Image</option>
                <!-- <option value="csau_geospatial:108_PART_1_modified:[1173152.85826898,342671.514293023,1179683.69808146,347057.607642237]">csau_geospatial:108_PART_1_modified</option> -->
                <!-- 2450;1173152.85826898;1179683.69808146;342671.514293023;347057.607642237;"EPSG:2136" -->
              </select> 
                </div>
            </div>

            <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lrd_btn_search_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="search_for_scanned_maps"><i class="fa fa-search"></i> </button>
            
                </div>
            </div>
             <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lrd_btn_load_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="Show Scanned Map"><i class="fa fa-check-circle"></i> </button>
            
                </div>
            </div>

        </div>
         
         
           <div class="row">
								                                                        
			            <div class="col-md-8">
			                <div class="form-group">
			                  
			        	  <input class="form-control" id="lrd_search_smd_by_text"  name="lrd_search_smd_by_text"  type="text"  placeholder="Search SMD Records by Ref" required >
						   
			                </div>
			            </div>
			
			          
			          <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="lrd_btn_search_smd_dat_by_ref" data-placement="top" data-toggle="tooltip" title="Search SMD Data by Ref"><i class="fa fa-retweet"></i> </button>
			            
			                </div>
			            </div>
			            
			            <div class="col-md-2">
			                
			            </div>
			            
			
			        </div>
			        
			         <div class="row">
								                                                        
			            <div class="col-md-8">
			                <div class="form-group">
			                  
			    		  <input class="form-control" id="scannned_map_to_search_for"  name="geoserverscannedimages_list" type="text" autocomplete="off" 
		                                 list="listofscannnedmaptosearchfor" class="autocomplat"  placeholder="Enter Map name" required  onmousedown="value = '';" >
		                              <datalist id="listofscannnedmaptosearchfor"></datalist>  
			                </div>
			            </div>
			
			          
			          <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="lrd_btn_search_for_scanned_maps_all" data-placement="top" data-toggle="tooltip" title="Search SMD Data by Ref"><i class="fa fa-retweet"></i> </button>
			            
			                </div>
			            </div>
			            
			            <div class="col-md-2">
			                 <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="lrd_btn_load_for_scanned_maps_all" data-placement="top" data-toggle="tooltip" title="Search SMD Data by Ref"><i class="fa fa-retweet"></i> </button>
			            
			                </div>
			            </div>
			            
			
			        </div>
         
         
             <div class="row">
        
         <h5>More than One overlay</h5>
                       <div  class="table w-auto small table table-responsive">
           <table class="table table-bordered" id="lrd_more_than_one_parcel_Table" width="100%" cellspacing="0">
           
              <thead>
                <tr>

                 <th>Reference Number</th>
                 <th>Locality</th>
                 <th>Remarks</th>
                 <th>Details</th>
                  </tr>
              </thead>
              
                <tbody>
    
  			</tbody>
           
            
            </table>
          </div>
         
         </div>
         
         
      
         
         
                                   
    
            
          
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
		  <input type="radio" class="form-check-input" id="materialInline1" name="inlineMaterialRadiosExample" checked>
		  <label class="form-check-label" for="materialInline1">Draw</label>
		</div>
		
		<!-- Material inline 2 -->
		<div class="form-check form-check-inline">
		  <input type="radio" class="form-check-input" id="materialInline2" name="inlineMaterialRadiosExample">
		  <label class="form-check-label" for="materialInline2">Modify</label>
		</div>
		

    <div class="btn-group mr-2">
        
          <button type="button" class="btn btn-primary" id="lrd_btn_print_map" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-print"></i>
        </button>
		 
        
      <!--   <button type="button" class="btn btn-primary" data-placement="top" data-toggle="tooltip" title="Draw a Line">
            <i class="fa fa-square"></i>
        </button>
        <button type="button" class="btn btn-primary" data-placement="top" data-toggle="tooltip" title="Draw a Line" >
            <i class="fa fa-minus"></i>
        </button>
        <button type="button" class="btn btn-primary">
            <i class="fa fa-times-circle"></i>
        </button>
         -->
    </div>
    
    
    
     
     <div class="btn-group">
       Scale:
    </div>
    <div class="btn-group">
        <input class="form-control" id="lrd_scale_value_e"  name="lrd_scale_value_e" type="text" class="autocomplat" />
   
       
       <select name="lrd_scale_value" id="lrd_scale_value">
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
         <input type="checkbox" checked="checked" id="lrd_lockmapscale">
          <button type="button" class="btn btn-primary" id="lrd_btn_scale_zoom" data-placement="top" data-toggle="tooltip" title="Zoom to Scale">
            <i class="fa fa-search"></i>
        </button>
    </div>

</div>

          
            
            
            
             <div id="lrd-block-map" ></div>
             
             
             
             
          <form action="${pageContext.request.contextPath}/#"  method="post" target="_blank">



 


        </form>
          
          
            
          
            </div>
            <div class="card-footer small text-muted">Registration Process Movement</div>
          </div>
          
         
        
    
   
        
      </div>
     </div>
      
      
   
      
    </div>
  

 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
