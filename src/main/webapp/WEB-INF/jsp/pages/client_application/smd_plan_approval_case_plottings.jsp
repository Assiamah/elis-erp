
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


<%
	
%>




<div class="content-wrapper">
	<div class="container-fluid">
		<!-- Breadcrumbs-->
		

		<div class="row">
			



			<!--   Here is the right Table -->
			<div class="col-lg-3">
				<!-- Example Pie Chart Card-->
				<div class="card mb-3">
					<div class="card-header bg-dark text-white">
						<i class="fa fa-pie-chart"></i> Processing After Payment
					</div>
					<div class="card-body">
						<!--  The Form starts here -->
						<%--  <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
 --%>
						<div class="form-group">
									<!--   <label for="job_number">Job Number</label> -->
									<input class="form-control" id="txt_job_number_after_payment"
										name="job_number" type="text" aria-describedby="nameHelp"
										placeholder="Enter Bill Number" required>
										</div>
								<div class="form-group">
									<button class="btn btn-primary btn-block"
										id="btn_load_job_details_after_payment">
										<span
											class="text" >Seach</span>
									</button>

								</div>
					</div>
				</div>
				<!--   Here is the end of right table -->

			</div>
			<div class="col-lg-3">

						<form action="${pageContext.request.contextPath}/front_office_case_add_on" method="post">
						<div class="card mb-3">
					<div class="card-header bg-dark text-white">
						<i class="fa fa-pie-chart"></i> Processing Job on Existing Case
					</div>
					<div class="card-body">
						<div class="form-group">
						
									<input class="form-control" id="search_text"
										name="search_text" type="text" aria-describedby="nameHelp"
										placeholder="Enter Case Number" required>
								</div>						
								<div class="form-group">
								
									<button type="submit" class="btn btn-info  btn-block"
										id="btn_load_job_details_after_payment">
										<span
											class="text">Seach</span>
									</button>
								</div>
					</div>
				</div>
			
						</form>
						<!--   </form> -->

						<!-- The form Ends Hers -->

					</div>

				

			</div>





		</div>







         <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header bg-dark text-white">
              <i class="fa fa-bar-chart"></i>Application Details
              	<span class="col-md-3 float-right ">
              <button class="btn btn-success btn-icon-split float-right "  id="btnViewBatchlist">
					<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View Batch List</span>
				</button></span>
              
              </div>
              
            <div class="card-body">
            
         
            
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered data-table" id="job_detailsdataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                 
                 <th>Job Number</th>
                 <th>Applicant Name</th>
               <!--   <th style="display:none">Status</th> -->
                 <!-- <th>Status</th> -->
                
                 <th>Status</th>
                
                 <th >Action</th>
                  <th ></th>
                 
                 
                 
                 
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
                <tr ${appfiles.objections > 0 ? "class='bg-dark text-white red-tooltip' title='Application has pending Objections'  data-toggle='tooltip' data-placement='left' ":""}>
                    <td >${appfiles.job_number}</td>
                    
                    
                    
                    
                    <td    data-toggle="tooltip" data-placement="top" title="${fn:length(appfiles.ar_name) >20 ? appfiles.ar_name : ''}"> ${fn:substring(appfiles.ar_name, 0, 20)}
                    	${fn:length(appfiles.ar_name) >20 ? "..." : ""}
                    </td>
                    <td data-toggle="tooltip" data-placement="top"  title="${fn:length(appfiles.current_application_status) >20 ? appfiles.current_application_status : ''}">${fn:substring(appfiles.current_application_status, 0, 20)} 
                    	${fn:length(appfiles.current_application_status) >20 ? "..." : ""}
                    </td>
                    
                    <td>
                    	<button 
                    		class="btn btn-info btn-icon-split" 
                    		data-title="Delete" 
                    		id="btnAddToBatchlist-${appfiles.job_number}" 
                    		data-target-id="${appfiles.job_number}" 
                    		data-target-name="${appfiles.ar_name}"  
                    		data-target-process_sub="${appfiles.business_process_sub_name}" 
                    		onclick="addJobToBatchlist('${appfiles.job_number}','${appfiles.ar_name}','${appfiles.business_process_sub_name}');">
                    		<span class="icon text-white-50"> <i class="fas fa-list"></i></span>
                    		<span class="text">Add to Batch</span>
                    	</button>
                    	
                    	
                    	</td>
                
                
                <%--    <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details" method="post"><input type="hidden" name="case_number" id="case_number" value="${appfiles.case_number}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                 --%>    
                  <%--     <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"  target="_blank"><input type="hidden" name="case_number" id="case_number" value="${appfiles.case_number}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                    
                  --%>	
                    
              <%--       <td>
						<form action="smd_plan_approval_plotting_details" method="post">
							<input type="hidden" name="case_number" id="case_number" value="${appfiles.case_number}">
							<input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}">
							<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="${appfiles.business_process_sub_name}">
							
								<button type="submit" name="save" class="btn btn-info btn-icon-split" >
								<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>
								</button>
						</form>
						
					</td> --%>
					
					
					
					<td>
						<form action="smd_plan_approval_plotting_details" method="post">
							<input type="hidden" name="case_number" id="case_number" value="${appfiles.transaction_number}">
							<input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}">
							<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="${appfiles.business_process_sub_name}">
							
								<button type="submit" name="save" class="btn btn-info btn-icon-split" >
								<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>
								</button>
						</form>
						
					</td>
                     
                     
                    
                    </tr>
            </c:forEach>
            
            
             </tbody>
            
            
            </table>
          </div>
             
              <!--  End Of Table -->
            </div>
            
          </div>
          
     
     
    
       
    
   
        
      </div>
     </div>
     

	</div>



	<jsp:include page="../includes/_footer.jsp"></jsp:include>