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
          <a href="index.jsp">Data Capture</a>
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
		      <button type="button" class="btn btn-primary" id="lc_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addcoordinatetoplot" data-toggle="tooltip" title="Add Coordinate">
            <i class="fa fa-plus-circle"></i>
        </button>
        
        
		   <button type="button" class="btn btn-primary"  id="lc_btn_visualise_coordinate" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-eye"></i>
        </button>
        
		   <button type="button" class="btn btn-primary"  id="lc_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-map"></i>
        </button>
       <!--  
          <button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
            <i class="fa fa-save"></i>
        </button>
        -->
         <button type="button" class="btn btn-primary"  id="lrd_btn_add_coordinate_by_csv" data-placement="top" data-toggle="modal" data-target="#uploadcoordiantecsv" data-toggle="tooltip" title="Upload CSV">
            <i class="fa fa-upload"></i>
        </button>
         <button type="button" class="btn btn-primary" id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
            <i class="fa fa-object-ungroup"></i>
        </button>
        
       
        <button type="button" class="btn btn-primary" id="lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-print"></i>
        </button>
		 
		  
      
		 
		 
		<button type="button" class="btn btn-primary" id="lc_btngeneratesearchreport" data-placement="top" data-toggle="tooltip" title="Print Search Report">
            <i class="fa fa-print"></i>
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
        <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" value="System Cleanup"></textarea>
        </div>
         </div>
         
         
         
          <!--  Zoom to cooedinate -->
         <div class="row">
					                                                        
            <div class="col-md-5">
                <div class="form-group">
                  
                    <input class="form-control" type="text" name="name" placeholder="X-Coordinate" id="lc_x_coordinate"> 
                </div>
            </div>
            
            
            <div class="col-md-5">
                <div class="form-group">
                  
                    <input class="form-control" type="text" name="name" placeholder="Y-Coordinate"  id="lc_y_coordinate"> 
                  
            
                </div>
            </div>
            
            <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lc_btn_show_location" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-map-marker"></i> </button>
            
                </div>
            </div>
            

        </div>
        
        
        
         <!-- search by reference nunber -->
         
           <div class="row">
					                                                        
            <div class="col-md-10">
			       <div class="btn-group">
			      <input class="form-control" id="pvlmd_saerch_by_text"  name="lc_pvlmd_saerch_by_text"  type="text"  placeholder="Enter Search Text" required >
			    		</div>
            </div>
            
 
            
            <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lc_btn_show_location766" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-search"></i> </button>
            
                </div>
            </div>
            

        </div>
          <!--  Scanned Maps -->
          
            <div class="row">
					                                                        
            <div class="col-md-10">
                <div class="form-group">
                  
                       		 
			<input class="form-control" id="lc_scale_value"  name="lc_scale_value" type="text" list="cars" class="autocomplat" placeholder="Scanned Maps" />
				<datalist id="cars">
				  <option>Volvo</option>
				  <option>Saab</option>
				  <option>Mercedes</option>
				  <option>Audi</option>
				</datalist> 
                </div>
            </div>

            <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lc_btn_show_location334" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-search"></i> </button>
            
                </div>
            </div>
            

        </div>
         
         
         
         
                                      <div class="tab-pane" role="tabpanel" id="step4">
					                                    <h4 class="text-center">Step 4</h4>
					                                    <div class="all-info-container">
					                                        <div class="list-content">
					                                            <a href="#listone" data-toggle="collapse" aria-expanded="false" aria-controls="listone">Collapse 1 <i class="fa fa-chevron-down"></i></a>
					                                            <div class="collapse" id="listone">
					                                                <div class="list-box">
					                                                    <div class="row">
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>First and Last Name *</label> 
					                                                                <input class="form-control" type="text"  name="name" placeholder="" "> 
					                                                            </div>
					                                                        </div>
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Phone Number *</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder=""> 
					                                                            </div>
					                                                        </div>
					                                                        
					                                                    </div>
					                                                </div>
					                                            </div>
					                                        </div>
					                                        <div class="list-content">
					                                            <a href="#listtwo" data-toggle="collapse" aria-expanded="false" aria-controls="listtwo">Collapse 2 <i class="fa fa-chevron-down"></i></a>
					                                            <div class="collapse" id="listtwo">
					                                                <div class="list-box">
					                                                    <div class="row">
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Address 1 *</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder="" > 
					                                                            </div>
					                                                        </div>
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>City / Town *</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder=""> 
					                                                            </div>
					                                                        </div>
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Country *</label> 
					                                                                <select name="country2" class="form-control" id="country2" >
					                                                                    <option value="NG" selected="selected">Nigeria</option>
					                                                                    <option value="NU">Niue</option>
					                                                                    <option value="NF">Norfolk Island</option>
					                                                                    <option value="KP">North Korea</option>
					                                                                    <option value="MP">Northern Mariana Islands</option>
					                                                                    <option value="NO">Norway</option>
					                                                                </select>
					                                                            </div>
					                                                        </div>
					                                                        
					                                                        
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Legal Form</label> 
					                                                                <select name="legalform2" class="form-control" id="legalform2" ">
					                                                                    <option value="" selected="selected">-Select an Answer-</option>
					                                                                    <option value="AG">Limited liability company</option>
					                                                                    <option value="GmbH">Public Company</option>
					                                                                    <option value="GbR">No minimum capital, unlimited liability of partners, non-busines</option>
					                                                                </select> 
					                                                            </div>
					                                                        </div>
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Business Registration No.</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder="" disabled="disabled"> 
					                                                            </div>
					                                                        </div>
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Registered</label> 
					                                                                <select name="vat2" class="form-control" id="vat2" disabled="disabled">
					                                                                    <option value="" selected="selected">-Select an Answer-</option>
					                                                                    <option value="yes">Yes</option>
					                                                                    <option value="no">No</option>
					                                                                </select> 
					                                                            </div>
					                                                        </div>
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Seller</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder="" disabled="disabled"> 
					                                                            </div>
					                                                        </div>
					                                                        <div class="col-md-12">
					                                                            <div class="form-group">
					                                                                <label>Company Name *</label> 
					                                                                <input class="form-control" type="password" name="name" placeholder="" disabled="disabled"> 
					                                                            </div>
					                                                        </div>
					                                                    </div>
					                                                </div>
					                                            </div>
					                                        </div>
					                                        <div class="list-content">
					                                            <a href="#listthree" data-toggle="collapse" aria-expanded="false" aria-controls="listthree">Collapse 3 <i class="fa fa-chevron-down"></i></a>
					                                            <div class="collapse" id="listthree">
					                                                <div class="list-box">
					                                                    <div class="row">
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Name *</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder=""> 
					                                                            </div>
					                                                        </div>
					                                                        
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Number *</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder=""> 
					                                                            </div>
					                                                        </div>
					                                                        
					                                                    </div>
					                                                </div>
					                                            </div>
					                                        </div>
					                                    </div>
					                                    
					                                    <ul class="list-inline pull-right">
					                                        <li><button type="button" class="default-btn prev-step">Back</button></li>
					                                        <li><button type="button" class="default-btn next-step">Finish</button></li>
					                                    </ul>
					                                </div>
    
            
          
            </div>
            <div class="card-footer small text-muted">Side Menu</div>
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
        <button type="button" class="btn btn-primary">
            <i class="fa fa-map"></i>
        </button>
        <button type="button" class="btn btn-primary">
            <i class="fa fa-map-marker"></i>
        </button>
        <button type="button" class="btn btn-primary">
            <i class="fa fa-info-circle"></i>
        </button>
    </div>
    <div class="btn-group mr-2">
        <button type="button" class="btn btn-primary">
            <i class="fa fa-plus-circle"></i>
        </button>
        <button type="button" class="btn btn-primary">
            <i class="fa fa-retweet"></i>
        </button>
        <button type="button" class="btn btn-primary">
            <i class="fa fa-times-circle"></i>
        </button>
        <button type="button" class="btn btn-primary">
            <i class="fa fa-object-ungroup"></i>
        </button>
    </div>
    <div class="btn-group">
        <button type="button" class="btn btn-primary">
            <i class="fa fa-object-group"></i>
        </button>
    </div>
     <div class="btn-group">
        <button type="button" class="btn btn-primary">
            <i class="fa fa-question-circle"></i>
        </button>
    </div>
    
     <div class="btn-group mr-2">
        <button type="button" class="btn btn-primary" data-placement="top" data-toggle="tooltip" title="Plot Parcel">
            <i class="fa fa-save"></i>
        </button>
        <button type="button" class="btn btn-primary" data-placement="top" data-toggle="tooltip" title="Draw a Line">
            <i class="fa fa-check-circle"></i>
        </button>
        <button type="button" class="btn btn-primary" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-print"></i>
        </button>
    </div>
    <div class="btn-group mr-2">
        <button type="button" class="btn btn-primary" data-placement="top" data-toggle="tooltip" title="Draw a Line">
            <i class="fa fa-square"></i>
        </button>
        <button type="button" class="btn btn-primary" data-placement="top" data-toggle="tooltip" title="Draw a Line" >
            <i class="fa fa-minus"></i>
        </button>
        <button type="button" class="btn btn-primary">
            <i class="fa fa-times-circle"></i>
        </button>
        
    </div>
    
      
    
</div>

          
            <!-- Maps Details Starts Here  -->
   <div class="bs-example">
   
   
    
    
     <div class="btn-group">
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
    </div>
    
    <div class="btn-group">
       Scale 1:
    </div>
   
   <div class="btn-group">

						<select name="lc_layer_type" id="lc_layer_type" data-live-search="true" data-none-results-text="I found no results" title="Please select fruit" class="form-control selectpicker">
							<option value="Existing GARRO Layer">Existing GARRO Layer</option>
							<option value="Existing CRO Layer">Existing CRO Layer</option>
							<option value="PVLMD Current Layer">PVLMD Current Layer</option>
							<option value="LRD Layer">LRD Layer</option>
							<option value="SMD Parcel Layer">SMD Parcel Layer</option>
							<option value="SMD Cadastral Layer">SMD Cadastral Layer</option>
							
						</select>
      		 
    </div>
    
    

     <div class="btn-group">

			<div class="custom-control custom-checkbox">
		    <input type="checkbox" class="custom-control-input" id="customCheck" name="example1">
		    <label class="custom-control-label" for="customCheck">Lock Scale</label>
		  </div>
    </div>
    
    
</div>
       
            
            
            
             <div id="lc-map" ></div>
             
             
             
             
          <form action="${pageContext.request.contextPath}/#"  method="post" target="_blank">



 


        </form>
          
          
            
          
            </div>
            <div class="card-footer small text-muted">Registration Process Movement</div>
          </div>
          
         
        
    
   
        
      </div>
     </div>
      
      
   
      
    </div>
  

 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
