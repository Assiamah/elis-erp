
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="../includes/_header.jsp"></jsp:include>







    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">Create Job Number</a>
        </li>
        <li class="breadcrumb-item active">Dashboard - ${fullname}</li>
         
             
      </ol>
     
           

      
        
      
       <div class="row">
     
     
         <!--   Here is the right Table -->
        <div class="col-lg-4">
          <!-- Example Pie Chart Card-->
          
          
          
          	    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapselistofservices" aria-expanded="false" aria-controls="collapseFive">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fa fa-users"></i>Case Details
		            </a>
		        </h5>
		        <div id="collapselistofservices" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		                 <div class="row">
								                                                        
			            <div class="col-md-8">
			                <div class="form-group">
			                  
			        	  <input class="form-control" id="pvlmd_search_case_by_job_number"  name="pvlmd_search_case_by_job_number"  type="text"  placeholder="Search by Jo Number" required >
						   
			                </div>
			            </div>
			
			            
			            <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="pvlmd_btn_search_case_by_job_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-search"></i> </button>
			            
			                </div>
			            </div>
			            
			
			        </div>
			        
			        
			        
			        
			          <div class="form-row">
				              <div class="col-md-6">
				                <label for="search_value">case_number</label>
				                <input class="form-control" id="txt_lc_cd_case_number"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				                <div class="col-md-6">
				                <label for="search_value">transaction_number</label>
				                <input class="form-control" id="txt_lc_cd_transaction_number"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				               
				             
				        </div>
				        
				        
				          <div class="form-row">
				              <div class="col-md-6">
				                <label for="search_value">ar_name</label>
				                <input class="form-control" id="txt_lc_cd_ar_name"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				                <div class="col-md-6">
				                <label for="search_value">glpin</label>
				                <input class="form-control" id="txt_lc_cd_glpin"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				               
				             
				        </div>
				        
				        
				          <div class="form-row">
				              <div class="col-md-6">
				                <label for="search_value">business_process_sub_name</label>
				                <input class="form-control" id="txt_lc_cd_business_process_sub_name"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				                <div class="col-md-6">
				                <label for="search_value">file_number</label>
				                <input class="form-control" id="txt_lc_cd_file_number"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				               
				             
				        </div>
				        
				          <div class="form-row">
				              <div class="col-md-6">
				                <label for="search_value">Land size</label>
				                <input class="form-control" id="txt_lc_cd_land_size"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				                <div class="col-md-6">
				                <label for="search_value">regional_number</label>
				                <input class="form-control" id="txt_lc_cd_regional_number"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				               
				             
				        </div>
				        
				         <div class="form-row">
				              <div class="col-md-6">
				                <label for="search_value">Locality</label>
				                <input class="form-control" id="txt_lc_cd_locality"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				                <div class="col-md-6">
				                <label for="search_value">date_of_document</label>
				                <input class="form-control" id="txt_lc_cd_date_of_document"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				               
				             
				        </div>
				        
				         <div class="form-row">
				              <div class="col-md-6">
				                <label for="search_value">nature_of_instrument</label>
				                <input class="form-control" id="txt_lc_cd_nature_of_instrument"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				                <div class="col-md-6">
				                <label for="search_value">type_of_use</label>
				                <input class="form-control" id="txt_lc_cd_type_of_use"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				               
				             
				        </div>
				        
				        <div class="form-row">
				              <div class="col-md-6">
				                <label for="search_value">term</label>
				                <input class="form-control" id="txt_lc_cd_term"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				                <div class="col-md-6">
				                <label for="search_value">commencement_date</label>
				                <input class="form-control" id="txt_lc_cd_commencement_date"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				               
				             
				        </div>
				        
				        <div class="form-row">
				              <div class="col-md-6">
				                <label for="search_value">plot_number</label>
				                <input class="form-control" id="txt_lc_cd_plot_number"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				                <div class="col-md-6">
				                <label for="search_value">grantors_name</label>
				                <input class="form-control" id="txt_lc_cd_grantors_name"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder=""  readonly>
				              </div>
				               
				             
				        </div>
				        
			        
			        
		                
		            </div>
		        </div>
		    </div>
		     <br>
          
          
          
          
          
          <div id="accordion" role="tablist" aria-multiselectable="true">
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingOne">
		            <a data-toggle="collapse" data-parent="#accordion" href="#collapsejobs" aria-expanded="true" aria-controls="collapseOne" class="d-block">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-info-circle"></i>Map Tools
		            </a>
		        </h5>
		
		        <div id="collapsejobs" class="collapse show" role="tabpanel" aria-labelledby="headingOne">
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
                 
                 
                 
                 <th>NT Number</th>
                 <th>CRO Ref</th>
                 <th>GARRO Ref</th>
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
		    <br>
		
		   
		    
		    
		    
		    
		    
		      
		    
	

		    
		</div>

      </div>
     
     
     
     <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           <div class="card-header">
				<h4 class='float-left'>
				<i class="fas fa-stamp"></i>Professional Templates - ${fullname}</h4>
				<%-- <form action="${pageContext.request.contextPath}/client_application" >
				
				<button type="submit"  class="btn btn-primary btn-icon-split float-right" >
				<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Back</span>
				</button>
				</form> --%>
		</div>
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
		 
       

        
        
    </div>
   
    
     <div class="btn-group">
       Scale 1:
    </div>
   
  <div class="btn-group">
       <input class="form-control" id="pvlmd_scale_value"  name="pvlmd_scale_valued" type="text" list="scalelist" class="autocomplat" />
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
    
    
     
    
</div>

          
            <!-- Maps Details Starts Here  -->
   <div class="bs-example">
   
   
    

  
    
   

    
   
    
    
    
</div>
       
            
            
            
             <div id="pvlmd-map" ></div>
             
             
















   <div class="card">

		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseclientservicerequest" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Map Interface
		            </a>
		        </h5>
		        <div id="collapseclientservicerequest" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

				      
				   
				      
				          
					        
		                
		            </div>
		        </div>
		    </div>
      
				  
				     


 <br>   





          
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingTwo">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseappdetails" aria-expanded="false" aria-controls="collapseTwo">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-clipboard"></i>Noted  Transaction
		            </a>
		        </h5>
		        <div id="collapseappdetails" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
		            <div class="card-body">
		                
		             
	
	
	
				      
		            </div>
		        </div>
		    </div>
		    
		      <div class="card">
		        <h5 class="card-header" role="tab" id="headingTwo">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseappdetails" aria-expanded="false" aria-controls="collapseTwo">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-clipboard"></i>Search Transaction
		            </a>
		        </h5>
		        <div id="collapseappdetails" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
		            <div class="card-body">
		                
		             
	
	 
           <div class="row">
					
					<h5> Search for Transaction</h5>
								                                                        
			            <div class="col-md-8">
			                <div class="form-group">
			                  
			        	  <input class="form-control" id="pvlmd_search_transaction_by_text"  name="pvlmd_search_transaction_by_text"  type="text"  placeholder="Search by Ref Number" required >
						   
			                </div>
			            </div>
			
			          
			          <!-- <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="pvlmd_btn_search_by_certificate_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-retweet"></i> </button>
			            
			                </div>
			            </div> -->
			            
			            <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="pvlmd_btn_search_transaction" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-search"></i> </button>
			            
			                </div>
			            </div>
			            
			
			        </div>
         
         			 <div class="row">
        
         
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
	
				      
		            </div>
		        </div>
		    </div>
		      
		  
            </div>
          
          </div>
          
         
        
    
   
        
      </div>
      

     </div>
      
      
   
      
    </div>

	<jsp:include page="../includes/_footer.jsp"></jsp:include>