 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
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
          <a href="#">Strata Plan Management</a>
        </li>
        <li class="breadcrumb-item active">Maps</li>
      </ol>
           
           
      
      
      
       <div class="row">
    
    
     <div class="col-lg-3">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Rent Mangement Maps Templates</div>
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
        
		   <button type="button" class="btn btn-primary"  id="pvlmd_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-map"></i>
        </button>
        
          <button type="button" class="btn btn-primary"  id="pvlmd_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Save Parcels">
            <i class="fa fa-save"></i>
        </button>
       
      
       
     
		 
		 </div>
		    
		    
		    
		      <!--  WKT row here -->
        <div class="form-group">
       
        <div class="form-row"> 
 
        
        </div>
         </div>
         
       
  
        
       <!-- search by reference nunber -->
         
			          <div class="row">
								                                                        
			            <div class="col-md-6">
			                <div class="form-group">
			                  
			        	  <input class="form-control" id="pvlmd_search_by_text"  name="pvlmd_search_by_text"  type="text"  placeholder="Search by Certificate Number" required >
						   
			                </div>
			            </div>
			
			          
			           <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="pvlmd_btn_search_by_certificate_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-retweet"></i> </button>
			            
			                </div>
			            </div>
			            
			        
			            
			
			        </div>
			        
        
                     <!--  Scanned Maps -->
          
            <div class="row">
					                                                        
                <div class="col-md-8">
                    <div class="form-group">
                      
                                    
                
                  <select name="cbo_estate_list" id="cbo_estate_list" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                  <option value="-1">--select estate--</option>
                      <c:forEach items="${estate_list}" var="estate">
                        <option  value="${estate.ge_id}">${estate.ge_location_name}</option>
                      </c:forEach>
                  </select> 
                    </div>
                </div>
    
            </div>
             
            
          
            </div>
          
          </div>
          
         
        
    
   
        
      </div>
    
    
              
              <div class="col-lg-9">
                  
                <div class="row">
                  <!-- First Column -->
                  <div class="col-lg-6">
                    <div class="card mb-3">
                      <div class="card-header">
                        <i class="fa fa-map"></i> Parcel Map
                      </div>
                      <div class="card-body">
                        <div id="map-1" style="height: 300px; width: 100%;"></div>
                      </div>
                      <div class="card-footer small text-muted">Parcel Map Management</div>
                    </div>
                
                    <div class="card mb-3">
                      <div class="card-header">
                        <i class="fa fa-map"></i> Block Map
                      </div>
                      <div class="card-body">
                        <div id="map-2" style="height: 300px; width: 100%;"></div>
                      </div>
                      <div class="card-footer small text-muted">Block Map Management</div>
                    </div>
                  </div>
                
                  <!-- Second Column -->
                  <div class="col-lg-6">
                    <div class="card mb-3">
                      <div class="card-header">
                        <i class="fa fa-map"></i> Floor Data
                      </div>
                      <div class="card-body">
                        <div id="map-3" style="height: 300px; width: 100%;"></div>
                      </div>
                      <div class="card-footer small text-muted">Floor Data</div>
                    </div>
                
                    <div class="card mb-3">
                      <div class="card-header">
                        <i class="fa fa-map"></i> Government Land Estates - Map 4
                      </div>
                      <div class="card-body">
                        <div id="map-4" style="height: 300px; width: 100%;"></div>
                      </div>
                      <div class="card-footer small text-muted">Geospatial Analysis</div>
                    </div>
                  </div>
                </div>
            
                  
                </div>
     </div>
      
      
   
      
    </div>
  

 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
