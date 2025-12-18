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
          <a href="#">LVD Compensation Map</a>
        </li>
        <li class="breadcrumb-item active">Maps</li>
      </ol>
           
           
      
      
      
       <div class="row">
    
    
     <div class="col-lg-3">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Map Plotting</div>
            <div class="card-body">
            
         
		<div class="btn-group mr-2">
		      <button type="button" class="btn btn-primary" id="comp_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addcoordinatetoplot" data-toggle="tooltip" title="Draw a Line">
            <i class="fa fa-plus-circle"></i>
           
        </button>
        
         
               
          <button type="button" class="btn btn-primary"  id="lrd_btn_add_coordinate_by_csv" data-placement="top" data-toggle="modal" data-target="#uploadcoordiantecsv" data-toggle="tooltip" title="Upload CSV">
            <i class="fa fa-upload"></i>
        </button>
        
        
		   <button type="button" class="btn btn-primary"  id="comp_btn_visualise_coordinate" data-placement="top" data-toggle="tooltip" title="Visualise Coordinate">
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
        <textarea rows="2" class="form-control" placeholder="" id="comp_bl_wkt_polygon" ></textarea>
        </div>
        <br>
        
		     <div class="btn-group mr-2">
		      
        
		   <button type="button" class="btn btn-primary"  id="comp_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon(KKT)">
            <i class="fa fa-map"></i>
        </button>
        
          <button type="button" class="btn btn-primary"  id="comp_btn_save_wkt" data-placement="top" data-toggle="tooltip" title="Save Parcels">
            <i class="fa fa-save"></i>
        </button>
        
        
        
      

		 
		 </div>
        
         </div>
         
         
         
          <!--  Zoom to cooedinate -->
         <div class="row">
					                                                        
            <div class="col-md-5">
                <div class="form-group">
                  
                    <input class="form-control" type="text" name="name"  id="comp_x_coordinate_mak" placeholder="Eastings"> 
                </div>
            </div>
            
            
          
          
            
            
           

        </div>
        
        
        
  
         
			          <div class="row">
								                                                        
			            <div class="col-md-8">
			                <div class="form-group">
			                  
			        	  <input class="form-control" id="comp_search_by_text"  name="smd_search_by_text"  type="text"  placeholder="Search by Ref Number" required >
						   
			                </div>
			            </div>
			
			        
			            
			            <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="comp_btn_search_by_reference_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-search"></i> </button>
			            
			                </div>
			            </div>
			            
			
			        </div>
			        
        
        
    
        
          <!--  Scanned Maps -->
          
        
         <div class="row">
        
         <h5>More than one overlay</h5>
         
                       <div  class="table w-auto small table-responsive">
           <table class="table table-bordered" id="comp_more_than_one_parcel_Table" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                 
                 <th>Ref Number</th>
                 <th>Locality</th>
                 <th>Plotted By</th>
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
       
              
       <button type="button" class="btn btn-primary" id="comp_btnprintmap" data-placement="top" data-toggle="tooltip" title="Print Map">
            <i class="fa fa-print"></i>
        </button>
		 
		  
        <button type="button" class="btn btn-primary" id="comp_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
            <i class="fa fa-search"></i>
        </button>
		
		 
		 <button type="button" class="btn btn-primary" id="comp_btngeneratesearchreport" data-placement="top" data-toggle="tooltip" title="Print Search Report">
            <i class="fa fa-print"></i>
        </button> 
		 
       

        
        
    </div>
   
    
    
    
   
   
    
     
    
</div>

          
            <!-- Maps Details Starts Here  -->
   <div class="bs-example">
   
   
    

  
    
   

    
   
    
    
    
</div>
       
            
            
            
             <div id="lvdc-map" ></div>
             
             
             
             
         
          
          
            
          
            </div>
            <div class="card-footer small text-muted">Plottings</div>
          </div>
          
         
        
    
   
        
      </div>
     </div>
      
      
   
      
    </div>
  

 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
