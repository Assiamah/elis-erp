 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
  <jsp:include page="../includes/_header.jsp"></jsp:include>
  <jsp:useBean id="now" class="java.util.Date" />

 
   
  <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">ELIS Report</a>
        </li>
        <li class="breadcrumb-item active">Report User - ${fullname}</li>
         
             
      </ol>
     
           

        
      
       <div class="row">
     
     
     
     <div class="col-lg-6">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           <div class="card-header">
				<h4 class='float-left'>
				<i class="fas fa-database"></i> Report by Service Types</h4>
				
		</div>
            <div class="card-body">


			<div class="accordion" id="accordionExample">
			  <div class="card">
			    
			
			    <div id="collapsedrinksn" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
			      <div class="card-body">
			         
			         
					           
			        <div class="form-group">
          <label for="type_of_report_name">Application Status</label>
       <select name="type_of_report_name"  id="type_of_report_name" class="form-control input-sm" data-style="btn-info" data-live-search="true">
            <option value="All">All</option>
            <option value="Completed" selected>Completed</option>
             <option value="Pending">Pending</option>
             <option value="gra_stamp_duty_report">GRA Stamp Duty Report</option>
             <option value="lrd_plotting_report">LRD Plotting Report</option>
            <!-- <option value="TAT">TAT</option> -->
         </select>
         </div>

         <div class="form-group">
          <label for="region">Select Region</label>
          <select id="sel_change_region_compliance" class="form-control input-sm" data-style="btn-info" data-live-search="true">
            <!-- <option selected disabled value="-1">-- select --</option>					 -->
            <option selected value="0">All Regions</option>						
            <c:forEach items="${officeregionlist}" var="officeregion">
              <option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
          </c:forEach>
              </select>
           </div>


       <div class="form-group">
          <label for="main_service">Main Service</label>
                  <select name="main_service_rpt" id="main_service_rpt"   class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                  <option value="-1">Select Main Service</option>
                 
                 <c:forEach items="${main_services}" var="main_service">
                   
                  
                  <%--  <c:if test="${(${main_service.business_process_id} == 'No')}" --%>
                         <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option>  
                    <%-- <p>Welcome, <c:out value="${nm }"/></p> --%>
                  <%--  </c:if> --%>
                  
                    
                   </c:forEach> 
                 
                </select>
          </div>
           <div class="form-group">
          <label for="sub_service">Sub Service</label>
                  <select name="sub_service_rpt" id="sub_service_rpt" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                    <option value="-1">Select Sub Service</option>
                  
                </select>
           </div>
           
           
            <div class="form-group">
       <label >Date From</label>
       <input type="date" name="date_from" id="date_from" min="1000-01-01"   max="3000-12-31" class="form-control">
           </div>
            
           <div class="form-group">
       <label >Date To</label>
       <input type="date" name="date_to" id="date_to" min="1000-01-01"   max="3000-12-31" class="form-control">
           </div>
        <!-- <input type="submit" name="save" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"  value="Generate Report" />
 -->
 			<!-- 	<button type="button" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" 
 				id="btn_generate_details_reports" data-placement="top" data-toggle="tooltip" 
 				title="Search"><i class="fas fa-download fa-sm text-white-50"></i>Download Report Result</button> -->
               
               
                <button type="button" class="d-none d-sm-inline-block btn btn-sm btn-info shadow-sm" 
                id="btn_generate_details_reports_new" data-placement="top" data-toggle="tooltip" title="Search">
                <i class="fas fa-download fa-sm text-white-50"></i>View Report Result</button>
                  
                  
                 <button type="button" class="d-none d-sm-inline-block btn btn-sm btn-info shadow-sm" 
                id="btn_generate_details_reports_new_csv" data-placement="top" data-toggle="tooltip" title="Search">
                <i class="fas fa-download fa-sm text-white-50"></i>Download Report Result</button>
                  
                  

       <!--  <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
          -->
			
			     
			      </div>
			    </div>
			  </div>
			  
			  <%-- <div class="card">
			    <div class="card-header" id="headingOne">
			      <h2 class="mb-0">
			        <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapsedrinksa" aria-expanded="true" aria-controls="collapseOne">
			          Others
			        </button>
			      </h2>
			    </div>
			
			    <div id="collapsedrinksa" class="collapse" aria-labelledby="headingOne" data-parent="#accordionExample">
			      <div class="card-body">
			         
			         
						    <!--  <button type="button" data-toggle="modal" data-target="#productAdd" class="list-group-item list-group-item-action">A second item</button>
							  -->
			           <c:forEach items="${products_list}" var="product">
							
							
							
							<c:if test="${product.category_name == 'DRINKS (ALCHOLIC)'}">
   
					     <div class="list-group">
											    <a href="#" 
											    data-target="#productOrdering" 
															                    		data-toggle="modal" 
															                    		data-name="${product.name}" 
															                    		data-id="${product.id}" 
															                    		data-category_id="${product.category_id}" 
															                    		data-category_name="${product.category_name}" 
															                    		data-store_id="${product.store_id}"  
															                    		data-is_veg="${product.is_veg}" 
															                    		data-is_active="${product.is_active}" 
															                    		data-description="${product.description}"  
															                    		data-price="${product.price}" 
															                    		data-cooking_time="${product.cooking_time}" 
															                    		data-image_url="${product.image_url}"  
															                    		data-is_recommended="${product.is_recommended}" 
															                    		
															                    		
															                    		class="list-group-item">
															                    		
											      <h6 class="list-group-item-heading">${product.name}</h6>
											       <small>Price : ${product.price}</small>
											    </a>
								<br>
							</div>    
   
 							 </c:if>			               
										          
			          
										               
										               
										               
										               
										               
										            </c:forEach>
										            
			       
			
			     
			      </div>
			    </div>
			  </div> --%>
			  
			 
			  
			  
			 
			</div>
			

            </div>
          
          </div>
          
         
        
    
   
        
      </div>
      
      
      
        <div class="col-lg-6">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           <div class="card-header">
				<h4 class='float-left'>
				<i class="fas fa-table"></i>Report by Division/Users</h4>
				<%-- <form action="${pageContext.request.contextPath}/client_application" >
				
				<button type="submit"  class="btn btn-primary btn-icon-split float-right" >
				<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Back</span>
				</button>
				</form> --%>
		</div>
            <div class="card-body">




			<div class="accordion" id="accordionExample">
			  <div class="card">
			    
			
			    <div id="collapsedrinksn" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
			      <div class="card-body">
			         
			         
					           
			        <div class="form-group">
				          <label for="type_of_report_name">Report Type</label>
					       <select name="type_of_report_name_rpt"  id="type_of_report_name_rpt" class="form-control input-sm" data-style="btn-info" data-live-search="true">
					           
					             <option value="individual_audit_trails">Individual Audit Trails</option>
					            <option value="Division">Division</option>
					            <option value="Unit" selected>Unit</option>
					             <option value="Staff">Staff</option>
					           
					         </select>
         			</div>


              


               <div class="form-group">
                <label for="region">Select Region</label>
                <select id="get_change_region_compliance" class="form-control input-sm" data-style="btn-info" data-live-search="true" required>
                  <!-- <option selected disabled value="-1">-- select --</option>					 -->
                  <option selected disabled>Please Select</option>						
                  <c:forEach items="${officeregionlist}" var="officeregion">
                    <option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                </c:forEach>
                    </select>
                 </div>
         
         		           
					<div class="form-group">
			           <label for="" class="col-form-label">Division :</label>
					                              <select id="unit_division_to_send_to_rpt" class="form-control" >
					                                 <option value="none">---Select Division---</option>
					                                 <option value="LVD">LVD</option>
					                                 <option value="LRD">LRD</option>
					                                 <option value="PVLMD">PVLMD</option>
					                                 <option value="SMD">SMD</option>
					                                 <option value="RLO">RLO</option>
					                              </select>
			         </div>


     	  <div class="form-group">
         <label for="" class="col-form-label">Unit :</label>
								      <input autocomplete="off" class="form-control" id="unit_to_send_to_rpt"  type="text"  list="listofunitsbatching_rpt" class=""  placeholder="Select/Enter Unit" required  >
		                              <datalist id="listofunitsbatching_rpt"></datalist>
          </div>
           <div class="form-group">
          		<label for="" class="col-form-label ">User :</label>
		                              <!-- <select id="user_to_send_to" class="form-control" >
		                                 </select> -->
		                              <input class="form-control" id="user_to_send_to_rpt"  name="user_to_send_to_rpt" type="text" autocomplete="off" 
		                                 list="listofusersbatching_rpt" class="autocomplat"  placeholder="Enter Username" required  onmousedown="value = '';" >
		                              <datalist id="listofusersbatching_rpt"></datalist>
           </div>
           
             <button type="button" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" id="btn_generate_details_based_on_users" data-placement="top" data-toggle="tooltip" title="Search"><i class="fas fa-download fa-sm text-white-50"></i>View Report</button>
                  
                 <button type="button" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" id="btn_generate_details_based_on_users_csv" data-placement="top" data-toggle="tooltip" title="Search"><i class="fas fa-download fa-sm text-white-50"></i>Download Report</button>
                  
              

       <!--  <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
          -->
			
			     
			      </div>
			    </div>
			  </div>
			  

			</div>
			

            </div>
          
          </div>
          
         
        
    
   
        
      </div>
      










    
      
  
      
     </div>






      
      
   
   
    <div class="row">
     
     
     
   
      
      
      
    <!--   Here is the right Table -->
        <div class="col-lg-12">
          <!-- Example Pie Chart Card-->
          
          
          
          
          <div id="accordion" role="tablist" aria-multiselectable="true">
		    
		  
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseparties" aria-expanded="false" aria-controls="collapseFive">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fa fa-cube"></i>Review
		            </a>
		        </h5>
		        <div id="collapseparties" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		                 
		                            <div class="table-responsive">
           <table class="table table-bordered table-hover datatable" id="job_casemgtdetailsdataTable_elis_reports" width="100%" cellspacing="0">
			<thead>
                <tr>
              <!--    <th style="">&nbsp;</th>
                 <th><input type="checkbox" id="selectAll"/></th> -->
                 <th>Job Number</th>
                 <th>Applicant Name</th>
                 <th>Application Type</th>
               	  <th>Date Received</th>
                 <th>Job Status</th>
                 <th>Case Number</th>
                 <th>Days(Received)</th>
                 <th>Days(Batched)</th>
                 
                 <th>Date(Completed)</th>
                 <th>Days(Completed)</th>
                 <th>Date(Collected)</th>
                
                 <!-- <th >Add to BatchList</th>
                 <th>View</th> -->
                 <th class="to_hide_on_level_1">View</th>
                 
                 
                 
                 
                 <!-- 	<th data-field="customer.name" data-align="center" data-sortable="true">customer</th>
                    <th data-field="type" data-align="center" data-sortable="true">type</th>
                    <th data-field="description" data-align="center" data-sortable="true">description</th>
                    <th data-field="cutter" data-align="center" data-sortable="true">cutter</th> 
                    <th data-field="valid_s" data-align="center" data-sortable="true">valid</th>
                  -->
                 
                 </tr>
              </thead>
              
                <tbody>
    
            
             </tbody>
            
            
            </table>
          </div>
             
		                 
		              
		            </div>
		        </div>
		    </div>
		     <br>
		   
				 
		 
		    
		      
		    
	

		    
		</div>

      </div>
      
     </div>
      
  
    </div>




    <div class="col-lg-12">
      <!-- Example Bar Chart Card-->
      <div class="card mb-3">
       
       <div class="card-header">
    <h4 class='float-left'>
    <i class="fas fa-database"></i> Report Count by Service Types</h4>
    
</div>
        <div class="card-body">


  <div class="accordion" id="accordionExample">
    <div class="card">
      
  
      <div id="collapsedrinksn" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
        <div class="card-body">
           
     
          
          <div class="row">
            
            <!-- <div class="col-md-6">
              <div class="form-group">
                <label for="type_of_report_name">Application Status</label>
             <select name="type_of_report_name"  id="type_of_report_name" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                  <option value="All">All</option>
                  <option value="Completed" selected>Completed</option>
                   <option value="Pending">Pending</option>
                   <option value="gra_stamp_duty_report">GRA Stamp Duty Report</option>
                   <option value="lrd_plotting_report">LRD Plotting Report</option>
               </select>
               </div>
          </div> -->

            <div class="col-md-12">
              <div class="form-group">
                <label for="region">Select Region</label>
                <select id="report_count_sel_change_region_compliance" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                  <!-- <option selected disabled value="-1">-- select --</option>					 -->
                  <option selected value="0">All Regions</option>						
                  <c:forEach items="${officeregionlist}" var="officeregion">
                    <option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                </c:forEach>
                    </select>
                 </div>
          </div>
          </div>

                 



          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="main_service">Main Service</label>
                        <select name="main_service_rpt" id="report_count_main_service_rpt"   class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                        <option value="-1">Select Main Service</option>
                       
                       <c:forEach items="${main_services}" var="main_service">
                         
                        
                        <%--  <c:if test="${(${main_service.business_process_id} == 'No')}" --%>
                               <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option>  
                          <%-- <p>Welcome, <c:out value="${nm }"/></p> --%>
                        <%--  </c:if> --%>
                        
                          
                         </c:forEach> 
                       
                      </select>
                </div>
          </div>

            <div class="col-md-6">
              <div class="form-group">
                <label for="sub_service">Sub Service</label>
                        <select name="sub_service_rpt" id="report_count_sub_service_rpt" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                          <option value="-1">Select Sub Service</option>
                        
                      </select>
                 </div>
          </div>
          </div>
 

   



          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label >Date From</label>
                <input type="date" name="date_from" id="report_count_date_from" min="1000-01-01"   max="3000-12-31" class="form-control">
                    </div>
          </div>

            <div class="col-md-6">
              <div class="form-group">
                <label >Date To</label>
                <input type="date" name="date_to" id="report_count_date_to" min="1000-01-01"   max="3000-12-31" class="form-control">
                    </div>
          </div>
          </div>  
     
    <!-- <input type="submit" name="save" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"  value="Generate Report" />
-->
   <!-- 	<button type="button" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" 
     id="btn_generate_details_reports" data-placement="top" data-toggle="tooltip" 
     title="Search"><i class="fas fa-download fa-sm text-white-50"></i>Download Report Result</button> -->
           
           
            <button type="button" class="d-none d-sm-inline-block btn btn-sm btn-info shadow-sm" 
            id="btn_generate_count_reports" data-placement="top" data-toggle="tooltip" title="Search">
            <i class="fas fa-download fa-sm text-white-50"></i>View Report Count Result</button>
              
              
             <button type="button" class="d-none d-sm-inline-block btn btn-sm btn-info shadow-sm" 
            id="btn_generate_details_reports_new_csv" data-placement="top" data-toggle="tooltip" title="Search">
            <i class="fas fa-download fa-sm text-white-50"></i>Download Report Result</button>
              
              

   <!--  <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
      -->
  
       
        </div>
      </div>
    </div>
    
    <%-- <div class="card">
      <div class="card-header" id="headingOne">
        <h2 class="mb-0">
          <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapsedrinksa" aria-expanded="true" aria-controls="collapseOne">
            Others
          </button>
        </h2>
      </div>
  
      <div id="collapsedrinksa" class="collapse" aria-labelledby="headingOne" data-parent="#accordionExample">
        <div class="card-body">
           
           
            <!--  <button type="button" data-toggle="modal" data-target="#productAdd" class="list-group-item list-group-item-action">A second item</button>
            -->
             <c:forEach items="${products_list}" var="product">
          
          
          
          <c:if test="${product.category_name == 'DRINKS (ALCHOLIC)'}">

           <div class="list-group">
                      <a href="#" 
                      data-target="#productOrdering" 
                                                  data-toggle="modal" 
                                                  data-name="${product.name}" 
                                                  data-id="${product.id}" 
                                                  data-category_id="${product.category_id}" 
                                                  data-category_name="${product.category_name}" 
                                                  data-store_id="${product.store_id}"  
                                                  data-is_veg="${product.is_veg}" 
                                                  data-is_active="${product.is_active}" 
                                                  data-description="${product.description}"  
                                                  data-price="${product.price}" 
                                                  data-cooking_time="${product.cooking_time}" 
                                                  data-image_url="${product.image_url}"  
                                                  data-is_recommended="${product.is_recommended}" 
                                                  
                                                  
                                                  class="list-group-item">
                                                  
                        <h6 class="list-group-item-heading">${product.name}</h6>
                         <small>Price : ${product.price}</small>
                      </a>
            <br>
          </div>    

            </c:if>			               
                          
            
                               
                               
                               
                               
                               
                            </c:forEach>
                            
         
  
       
        </div>
      </div>
    </div> --%>
    
   
    
    
   
  </div>
  

        </div>
      
      </div>
   
  


     

<div class="modal fade" id="report_count_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="reportCountModalLabel"></h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
      <div class="row">
        <!-- Application Received (Today) -->
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> Applications
                                Pending</div>
                
                            <div id="app-pending" class="h5 mb-0 font-weight-bold text-gray-800">0
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-file fa-2x text-gray-300"></i>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>

        <!-- Application Received (Monthly) -->
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">

                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Applications
                                Completed</div>
                            <div id="app-completed" class="h5 mb-0 font-weight-bold text-gray-800">0</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-file fa-2x text-gray-300"></i>
                        </div>
                        
                    </div>
                </div>

            </div>
        </div>

        <!-- Application Completed (Today) -->
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card border-left-danger shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Applications Queried
                            </div>
                            <div class="row no-gutters align-items-center">
                                <div class="col-auto">
                                    <div id="app-queried" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">0</div>
                                </div>

                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-clock fa-2x text-gray-300"></i>
                        </div>
                      
                    </div>
                </div>
            </div>
        </div>
    </div>
		</div>
    <div class="modal-footer">
      <button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
  </div>
		
	</div>
</div>
</div>

     
     
  
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
