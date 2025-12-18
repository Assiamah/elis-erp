<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="d" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %> 
<%@page import="java.util.*" %>

<jsp:include page="../includes/_header.jsp"></jsp:include>
				 
<!-- Begin Page Content -->
<div class="content-wrapper">
   <div class="container-fluid">
	<section class="section dashboard">
		 <!-- Page Heading -->
                <!-- <div class="row mb-4">
                	 <div class="col-md-12">
		                <div class=" ">
		                   
					         <nav>
				                <ol class="breadcrumb">
				                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
				                  <li class="breadcrumb-item active">CAC - ENQUIRY </li>
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div> -->
	
			
		

		 <div class="card mb-3">
			<div class="card-header">
			  <i class="fa fa-bar-chart"></i>Reverse Transaction Approvals  <%-- ${page_name == "page_enquiry_backoffice" ? "test value" : ""} --%> </div>
			<div class="card-body">
				  <!--  The Form starts here -->
                  <form id="frmEnquiryJobSearch"  method="post">
				  <div class="row mb-4">
                    <div class="col-md-9">				
                        <div class="form-group">
					  	
                            <label><b>Search By: </b></label>
                        
                    </div>	   
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="custom-control-input" value="job_number" required>
                            <label class="custom-control-label" for="rbtn_search_type1">Job number</label>
                          </div>
                           <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="rbtn_search_type5" name="rbtn_search_type" class="custom-control-input" value="ar_name" required>
                            <label class="custom-control-label" for="rbtn_search_type5">Applicant Name</label>
                          </div> 
									   <br><br>
                                       <div class="form-group">
                                        <div class="form-row">
                                        <!-- <label for="search_value">Search  by Case Number / Regional Number / Applicant Name / Job number /GLPIN</label> -->
                                          <div class="col-md-8">
                                            
                                            <input class="form-control" id="enq_search_value"  name="enq_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
                                          </div>
                                          <div class="col-md-4">
                                              
                                            <button type="submit" class="btn btn-primary btn-block" value="Search" id="btnEnquiryJobSearch" > Search </button>
                                            
                                          </div>
                                        </div>
                                      </div>
                                      </div>
                                    </div>
                                    </form>
				</div>
			</div>	
			
			<!-- The form Ends Hers -->

			
		   <!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
		  
			
	      <div class="row mb-4">
	            <div class="col-md-12">
	              <div class="card" style="display:none" id="enq-search-results-section">
	              	<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i><span class="h5">Search Results</span> <span
						class="col-md-3 float-right ">
						 <button class="btn btn-danger btn-icon-split float-right "
							id="btnViewCabinetlist" style="margin-right: -15px">
							<span class="icon text-white-50"> <i class="fas fa-angle-double-right"></i></span><span
								class="text">Reverse Approval</span>
						</button>
					</span>
					</div>
	                <div class="card-body">
	
	                  <div class="tab-content mt-4">
                        <div class="table-responsive" >
                            <table class="table table-bordered " id="reverse-transaction-approval-table" style="min-height:500px">
                               <thead>
                                 <tr>
                                  <th>Applicant Name</th>
                                   <th>Case Number</th>
                                   <th>Job Number</th>
                                   <!-- <th>GLPIN</th> -->
                                   <th>Locality</th>
                                   <!-- <th>Regional Number</th> -->
                                   <th>Status</th>
                                   <th class="text-center">Actions</th>
                                   
                                   
                                 
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

     </section>
    </div>
	</div>

<!-- <div class="modal fade" id="showCabinetlist" tabindex="-1" role="dialog"
	aria-labelledby="showBatchlist" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Cabinet Job Applications</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
                    <div class="table-responsive" >
                        <div id="cabinet_list">
                        </div>
                    </div>
			</div>
			 	<div class="modal-footer">
			 	<button type="button" class="btn btn-primary" id="btn_print" >Process</button>
			 	
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div> -->

<div class="modal fade" id="showCabinetlist" tabindex="-1"
   role="dialog" aria-labelledby="viewFileListModal" aria-hidden="true">
   <div class="modal-dialog modal-xl">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="">Reserve Application Transaction Approvals</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
         </div>
         <div class="modal-body">
            <form >
               <%-- <input id="bl_modified_by" name="bl_modified_by" type="hidden" value="${fullname}"> 
               <input id="bl_modified_by_id" name="bl_modified_by_id" type="hidden" value="${userid}"> --%>

               <div class="container">
                <label class="col-form-label" style="text-align: right"><h2>Transaction Approval List :</h2></label>
                <br>
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                        <!-- <table id="FileListdataTable"
                           class="table table-bordered table-hover"></table> -->
                        <div class="table-responsive" >
                            <div id="approval_list">
                            </div>
                        </div>
                     </div>
                  </div>
               </div>
               <br> <br> <br>
               <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="btn_process_transaction_approval" >Process</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </form>
         </div>
      </div>
   </div>
</div>

<script>
    function deleteRow(r) {
      var i = r.parentNode.parentNode.rowIndex;
      document.getElementById("cabinetTable").deleteRow(i);
    }
</script>

<!-- End Page Content -->
<jsp:include page="../includes/_footer.jsp"></jsp:include>