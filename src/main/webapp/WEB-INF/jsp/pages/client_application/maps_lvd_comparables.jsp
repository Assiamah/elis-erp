 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

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
          <a href="index.jsp">LVD Comparable</a>
        </li>
        <li class="breadcrumb-item active">Maps</li>
      </ol>
           
           
      
      
      
       <div class="row">
    
    
     <div class="col-lg-3">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Map sample</div>
            <div class="card-body">
            
         
		     <div class="btn-group mr-2">
		      <button type="button" class="btn btn-primary" id="lvd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addcoordinatetoplot" data-toggle="tooltip" title="Add Coordinate">
            <i class="fa fa-plus-circle"></i>
        </button>
        
          <button type="button" class="btn btn-primary"  id="lvd_btn_add_coordinate_by_csv" data-placement="top" data-toggle="modal" data-target="#uploadcoordiantecsv" data-toggle="tooltip" title="Upload CSV">
            <i class="fa fa-upload"></i>
        </button>
        
		   <button type="button" class="btn btn-primary"  id="lvd_btn_visualise_coordinate" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-eye"></i>
        </button>
        
		   <button type="button" class="btn btn-primary"  id="lvd_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-map"></i>
        </button>
        
          <button type="button" class="btn btn-primary"  id="lvd_btn_save_wkt" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
            <i class="fa fa-save"></i>
        </button>
       
     
       
       
        <button type="button" class="btn btn-primary" id="lvd_btn_print_map" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-print"></i>
        </button>
		 
	
	
		 
		 </div>
		    
		     Point Upload
		     
		    <div class="btn-group mr-2">
		      
                
		   <button type="button" class="btn btn-primary"  id="lvd_btn_visualise_point" data-placement="top" data-toggle="tooltip" title="Visualise Point">
            <i class="fa fa-eye"></i>
        </button>
        

          <button type="button" class="btn btn-primary"  id="lvd_btn_save_wkt_point" data-placement="top" data-toggle="tooltip" title="Plot Point">
            <i class="fa fa-save"></i>
        </button>
       
 
		 
		 </div>  
           
         
    
    
                 <!--  Here is where the fee list comes -->
             
             <div  class="table w-auto small">
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
        <textarea rows="2" class="form-control" placeholder="" id="lvd_txt_wkt_polygon"></textarea>
        </div>
         </div>
         
         
          
        <div class="row">
			
            <div class="col-md-2">
                <div class="form-group">
                <button type="button" class="btn btn-primary" id="lvd_btn_search_comparables_by_polygon" data-placement="top" data-toggle="tooltip" title="search_for_scanned_maps"><i class="fa fa-search"></i> </button>
            
                </div>
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
                 <button type="button" class="btn btn-primary" id="lvd_btn_show_location" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-map-marker"></i> </button>
            
                </div>
            </div>
            

        </div>
        
        
       
        
                      
        
            
         <!-- search by reference nunber -->
        <!--  
			          <div class="row">
								                                                        
			            <div class="col-md-8">
			                <div class="form-group">
			                  
			        	  <input class="form-control" id="lrd_search_by_text"  name="lrd_search_by_text"  type="text"  placeholder="Search by Reference Number" required >
						   
			                </div>
			            </div>
			
			          
			          <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="lvd_btn_search_by_certificate_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-retweet"></i> </button>
			            
			                </div>
			            </div>
			            
			            <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="lvd_btn_search_by_reference_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-search"></i> </button>
			            
			                </div>
			            </div>
			            
			            
			
			        </div>
			         -->
        
              
       <div class="row">
        
         <h5>Comparable Details</h5>
         
                       <div  class="table-responsive w-auto small">
           <table class="table table-bordered" id="pvlmd_more_than_one_parcel_Table" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                 
                 <th>Ref Number</th>
                 <th>Value</th>
                 <th>Locality</th>
                 <th>Details</th>
                  </tr>
              </thead>
              
                <tbody>
    
  			</tbody>
           
            
            </table>
          </div>
         
         </div>
         
         
         
         
              
         <div class="row">
        
         <h5>Comparable Details</h5>
         
                  
             <div class="table-responsive">
           <table class="table table-bordered data-table" id="map_comparablesearchdataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                 
                 <th>Ref Number</th>
                 <th>Transaction Date</th>
                 <th>Lands Size</th>
               <!--   <th style="display:none">Status</th> -->
                 <!-- <th>Status</th> -->
                
                 <th>Property Value</th>
                
                 <th >View</th>
                
                
                 
                 
                 
                 
                 <!-- 	<th data-field="customer.name" data-align="center" data-sortable="true">customer</th>
                    <th data-field="type" data-align="center" data-sortable="true">type</th>
                    <th data-field="description" data-align="center" data-sortable="true">description</th>
                    <th data-field="cutter" data-align="center" data-sortable="true">cutter</th> 
                    <th data-field="valid_s" data-align="center" data-sortable="true">valid</th>
                  -->
                 
                 </tr>
              </thead>
              
                <tbody>
    
            		
                  <c:forEach items="${applicationlist}" var="appfiles">
                <tr >
                    <td >${appfiles.job_no}</td>

                    <td >${appfiles.transaction_date}</td>
                    
                     <td >${appfiles.accreage_size_of_land}</td>
                    
                     <td >${appfiles.value_of_property}</td>
                    
                    <td>
                    	<button 
                    		class="btn btn-info btn-icon-split" 
                    		data-title="Delete" 
                    		id="btn_view_comparable_on_map-${appfiles.job_no}" 
                    		data-id="${appfiles.id}" 
                    		data-job_no="${appfiles.job_no}" 
                    		data-property_owner="${appfiles.property_owner}"  
                    		data-wkt="${appfiles.wkt}" 
                    		 data-target="#comparablepopup" data-toggle="modal" >
                    		<span class="icon text-white-50"> <i class="fas fa-list"></i></span>
                    		<span class="text">View</span>
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
    
    
    
     <div class="col-lg-9">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Map sample</div>
            <div class="card-body">
            
          
          
            <!-- Maps Details Starts Here  -->
            <div class="bs-example">
            
            
            
            <div class="form-check form-check-inline">
		  <input type="radio" class="form-check-input" id="interaction_type" name="interaction_type" value="draw" checked>
		  <label class="form-check-label" for="materialInline1">Draw</label>
		</div>
		
		<!-- Material inline 2 -->
		<div class="form-check form-check-inline">
		  <input type="radio" class="form-check-input" id="interaction_type" name="interaction_type" value="modify">
		  <label class="form-check-label" for="materialInline2">Modify</label>
		</div>
		
	
            
            
            
    <div class="btn-group mr-2">
               
      <!--      <button type="button" class="btn btn-primary"  id="lvd_btn_add_comparable" data-placement="top" data-toggle="modal" data-target="#newcomparabledata" data-toggle="tooltip" title="Upload CSV">
            <i class="fa fa-map-marker"></i>
        </button>
         -->
        
        
        <button type="button" class="btn btn-secondary" id="polygon" data-toggle="tooltip" title="Draw Polygon">
            <i class="fa fa-square"></i>
        </button>
        
         <button type="button" class="btn btn-secondary" id="line" data-toggle="tooltip" title="Draw Point">
            <i class="fa fa-map-marker"></i>
        </button>
        
        
        <button type="button" class="btn btn-secondary" id="stopdraw" data-toggle="tooltip" title="Stop Draw">
            <i class="fa fa-window-close"></i>
        </button>
        
       <!--   <button type="button" class="btn btn-primary" id="btn_approve_comparable_" data-toggle="tooltip" title="Upload CSV">
            <i class="fa fa-info-circle"></i>
        </button> -->
        
        
          
       
        <d type="button" class="btn btn-primary" id="btn_map_comparable_report_rpt" data-placement="top" data-toggle="tooltip" title="Print By Polygon">
            <i class="fa fa-print"></i>
        </button>
		 
	
    </div>
    
   
     <div class="btn-group">
       Locality:
    </div>
		<div class="btn-group">
		       <input class="form-control" id="lcc_locality_value"  name="lcc_locality_value" type="text" list="localitylist" class="autocomplat" />
				<datalist id="localitylist">
		
		                  <c:forEach items="${localitylist}" var="appfiles">
		                 		<option>${appfiles.locality}</option>
		           		 </c:forEach>
		            
            
		
		</datalist>
    </div>
     
    <button type="button" class="btn btn-primary" id="btn_map_comparable_search_by_locality" data-placement="top"  title="Search">
					            <i class="fas fa-search-plus"></i>
					        </button>
 
      
    
</div>

          
            <!-- Maps Details Starts Here  -->
   <div class="bs-example">
   
   
    
    
   <!--   <div class="btn-group">
       Scale 1:
    </div>
<div class="btn-group">
       <input class="form-control" id="lc_scale_value"  name="lc_scale_value" type="text" list="scalelist" class="autocomplat" />
		<datalist id="scalelist">
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
		</datalist>
    </div> -->
    
   
    <button type="button" class="btn btn-primary" id="btn_map_comparable_report_rpt" data-placement="top"  title="Comparable Report">
					            <i class="fas fa-eye"></i>
					        </button>
					        
					        
        
         <button type="button" class="btn btn-primary" id="btn_map_comparable_search_by_report" data-placement="top"  title="Search by WKT">
            <i class="fas fa-eye"></i>
        </button>

    
    
    
</div>
       
            
            
            
             <div id="lvd-map" ></div>
             
             
             
             
          <form action="${pageContext.request.contextPath}/#"  method="post" target="_blank">



 


        </form>
          
          
            
          
            </div>
            <div class="card-footer small text-muted">LVD Comparable Maps</div>
          </div>
          
         
        
    
   
        
      </div>
     </div>
      
      
   
      
      
   
      
    </div>
  





 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
