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
				<i class="fas fa-database"></i>UNIT APPLICATIONS REPORT</h4>
				
		</div>
            <div class="card-body">


			<div class="accordion" id="accordionExample">
			  <div class="card">
			    
			
			    <div id="collapsedrinksn" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
			      <div class="card-body">
                    
        
                    <!-- <input type="text" value="${region_id}" id="region_id"> -->


                    <input type="hidden" value="${userid}" id="user_id" >
                    <input type="hidden" value="${unit_id}" id="user_unit" >
                    <input type="hidden" value="${division}" id="user_division">
                    <input type="hidden" value="${unit_name}" id="unit_name">
                    <input type="hidden" value="${region_id}" id="region_id">
                    <input type="hidden" id = "select-user">



                    <input type="hidden" id = "startdate">
                    <input type="hidden" id = "enddate">


                    


                   
                 


                    
                    


                    <!-- System.out.println(userid);
                    System.out.println(unit_id);
                    System.out.println(division); -->

                    


					           
		<div class="form-group">
          <label for="type_of_report_name">Status Type</label>
       <select name="type_of_report_name"  id="type_of_report_name" class="form-control input-sm" data-style="btn-info" data-live-search="true" required>
            <option value="Received">RECIEVED</option>
             <option value="Batched">BATCHED</option>
            <!-- <option value="TAT">TAT</option> -->
         </select>
         </div>




         




         <input type="hidden" value="${region_id}" id="ur_district">





         <!-- <div class="form-group">
            <label for="type_of_report_name">Region</label>
     
            <select id="ur_district" class="form-control selectpicker"  required>
        
                <option value>Select</option> 
                <option value="${region_id}">${region_id}</option> 

 
            </select>
           </div>
   -->


           <div class="form-group">
            <label for="type_of_report_name">Division</label>
     
            <select id="ur_division" class="form-control selectpicker">
        
            </select>
           </div>



           <div class="form-group">
            <label for="type_of_report_name">Unit</label>
     
            <select id="ur_units" class="form-control selectpicker">
                <!-- <option value=none>Select</option> -->
              
            </select>
           </div>

  


         <div class="form-group">
            <label for="type_of_report_name"> User</label>
         <select name="by_batched"  id="by_batched" class="form-control input-sm" data-style="btn-info" data-live-search="true" required>
               <!-- <option value="${unit_id}">${unit_id}</option> -->
           </select>
           </div>






              <div class="form-group">
                  <label for="region">Select Date From</label>
                  <input type="text" id="datefrom" class="form-control"  placeholder="Select Date Range" required>
              </div>



              <div class="form-group">
                <label for="region">Select Date To</label>
                <input type="text" id="dateto" class="form-control"  placeholder="Select Date Range" required>
              </div>



<input type="hidden" id="start_date" name="start_date">
<input type="hidden" id="end_date" name="end_date">

<input type="hidden" id="survey_select" name="survey_select">

<hr><br>

<button type="button" class="d-none d-sm-inline-block btn btn-md btn-info shadow-sm" 
id="btn_generate_details_reports_new" data-placement="top" data-toggle="tooltip" title="Generate">
<i class="fas fa-chart-line fa-sm text-white-50"></i>Generate Report</button>

           
            <!-- <div class="form-group">
       <label >Date</label>
       <input type="text" class="form-control input-sm"  id="daterange" />           
    </div> -->
            

			
			     
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
      
      
      
      
      










    
      
  
      
     </div>






      
      
   
   
 
      
  
    </div>
   
  


  
<div class="modal fade" id="reporting_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel"><span id="reportheading"></span> </h5>
            <button class="close" type="button" data-dismiss="modal"
                aria-label="Close">
                <span aria-hidden="true"> <i class="fa fa-times"></i></span>
            </button>
        </div>
        <div class="modal-body">
            <div class="row">
                <!-- Application Received -->
                
            </div>
            <div class="table-responsive">
                <table class="table table-bordered table-hover" id="reporting_table" width="100%" cellspacing="0">
                <!-- <table id="csau_staff_yearly_apps_view" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                   <thead>
                    <th>Applicant Name</th>
                    <th>Job Number</th>
                    <th>Application Type</th>
                    <th>Application Destination</th>
                    <th>Date Batched</th>
                    <th>Job Purpose</th>             
                    <th>Action</th>                             
                  </thead>
                      <tbody>        
                      </tbody>
                </table>
            </div> 
        </div>
        <div class="modal-footer">
            <button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
        </div>
    </div>
</div>
</div>






<div class="modal fade" id="other_reporting_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel"><span id="reportheading2"></span> </h5>
            <button class="close" type="button" data-dismiss="modal"
                aria-label="Close">
                <span aria-hidden="true"> <i class="fa fa-times"></i></span>
            </button>
        </div>
        <div class="modal-body">
            <div class="row">
                <!-- Application Received -->
                
            </div>
            <div class="table-responsive">
                <table class="table table-bordered table-hover" id="other_reporting_table" width="100%" cellspacing="0">
                <!-- <table id="csau_staff_yearly_apps_view" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                   <thead>
                        <th>Applicant Name</th>
                        <th>Job Number</th>
                        <th>Application Type</th>
                        <th>Recieved By</th>
                        <th>Date Recieved</th>
                        <th>Job Purpose</th>    
                        <th>Action</th>                             
                
                  </thead>
                      <tbody>        
                      </tbody>
                </table>
            </div> 
        </div>
        <div class="modal-footer">
            <button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
        </div>
    </div>
</div>
</div>





<div class="modal fade" id="cabinetModal" tabindex="-1" role="dialog"
aria-labelledby="addInspectionModalLabel" aria-hidden="true">

	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addMinutesModalLabel">Application
					Tracking History</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-8">
						<div class="card">
							<div class="card-header">History</div>
							<div class="card-body">
								<table class="table table-bordered" id="cabinet-tracking">
									<thead>
										<tr>
											<th>Comments</th>
											<th>Division/Unit</th>
											<th>Batching Officer</th>
											<th>Date</th>
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							</div>
						</div>




					</div>
					<div class="col-md-4">
						<div class="card">
							<div class="card-header">Details</div>
							<div class="card-body">
								<form >
									<fieldset>
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Applicant
												Name</label>

											<textarea readonly class="form-control"
												id="enq_applicant_name"></textarea>

										</div>

										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Applicant type</label> 
											<input type="text" readonly class="form-control" id="enq_applicant_type">

										</div>
									</fieldset>
									<hr>
									<fieldset>
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Cabinet
												Name</label> <input type="text" readonly class="form-control"
												id="enq_cabinet_name">
										</div>
										<hr>
										<!-- <div class="form-group ">
									    <label for="staticEmail" class=" col-form-label">Shelve Number</label>
									      <input type="text" readonly class="form-control" id="shelve_number" value="3C">
									 </div> -->
										 <div class="form-group ">
									    <label for="staticEmail" class=" col-form-label">Job Purpose</label>
									      <textarea  readonly class="form-control" id="enq_job_purpose" rows="4"></textarea>
									 </div> 
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Job
												Status</label> 
												<textarea readonly class="form-control"
												id="enq_job_status" rows="4"></textarea>
												
										</div>
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Application Status
												</label> 
												<textarea  readonly class="form-control" id="enq_current_application_status" rows="4"></textarea>
												
										</div>
									</fieldset>


								</form>
							</div>
						</div>
					</div>

				</div>


			</div>
		</div>
	</div>
</div>



     
     
  
  <jsp:include page="../includes/_footer.jsp"></jsp:include>

  <script type="text/javascript" src="../js_includes/apps_report.js"></script>

  <!-- <script type="text/javascript">
    $(function() {
    
        var start = moment().subtract(29, 'days');
        var end = moment();
    
        function cb(start, end) {
            $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
        }
    
        $('#reportrange').daterangepicker({
            startDate: start,
            endDate: end,
            ranges: {
               'Today': [moment(), moment()],
               'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
               'Last 7 Days': [moment().subtract(6, 'days'), moment()],
               'Last 30 Days': [moment().subtract(29, 'days'), moment()],
               'This Month': [moment().startOf('month'), moment().endOf('month')],
               'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
            }
        }, cb);
    
        cb(start, end);
    
    });
    </script> -->

<script>
    $(document).ready(function() {
      $('#by_batched').select2({
        placeholder: "Select ",
        allowClear: true
      });
    });
  </script>