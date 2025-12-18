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
<jsp:include page="../legal/includes/header.jsp"></jsp:include>
<!-- Begin Page Content -->
   <div class="container-fluid">
	<section class="section dashboard">
		 <!-- Page Heading -->
                <div class="row mb-4">
                	 <div class="col-md-12">
		                <div class=" ">
		                   
					         <nav>
				                <ol class="breadcrumb">
				                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
				                  <li class="breadcrumb-item active">Legal Unit - Further Entries</li>
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div>
	
	
     	<div class="row mb-4">
      		<!-- Left side columns -->
        <div class="col-lg-12">
          <div class="row">
            <!-- Assigned Cases Card -->
            <div class="col-xl-4 col-md-6" id="incoming">
              <div class="card border-left-info shadow h-100 py-2" id="body-bg-1">

                <div class="card-body">
	                  		<h5 class="card-title">Cases <span>| Incoming</span></h5>
							
							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<i class="fa fa-tasks fa-2x text-info"></i>
								</div>
								 <div class="">	
		                     	 	<h4 id="incoming_count"><c:out value="${incoming}"></c:out></h4>
								 </div>
		                    </div>
                </div>

              </div>
            </div><!-- Assigned Cases Card -->

            <!-- Unit Cases Card -->
            <div class="col-xl-4 col-md-6" id="unit">
              <div class="card border-left-success shadow h-100 py-2" id="body-bg-2">

               <div class="card-body">
               	
                  <h5 class="card-title">Cases <span>| Received</span></h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="fas fa-list fa-2x text-success"></i>
                    </div>
                    <div class="">
                      <h4 id="unit_count"><c:out value="${unit_count}"></c:out></h4>

                    </div>
                  </div>
                </div>

              </div>
            </div><!-- Unit Cases Card -->

            <!-- Archived Cases Card -->
            <div class="col-xl-4 col-md-6" id="month">			 
              <div class="card border-left-primary shadow h-100 py-2" id="body-bg-3">

                <div class="card-body">
                	
                    <h5 class="card-title">Cases <span>| All</span></h5>

	                <div class="d-flex align-items-center">
	                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
	                      <i class="fas fa-calendar fa-2x text-info-300"></i>
	                    </div>
	                    <div class="ps-3">
	                      <h4 id="total_count"><c:out value="${total_count}"></c:out></h4>
	
	                    </div>
	                  </div>
					
                </div>
              </div>
			 
            </div><!-- Archived Cases Card -->
     	
     
     </div>
    </div>
  </div>
  
  
	<div class="row" id="legal_unit_div" >
	<h6>Table Background Indicators</h6>
			<span class="mb-2 small"><i class="fas fa-dot-circle text-white" style="border: 1px solid black; border-radius: 50%"></i>Case without both further entries and uploaded document.</span>
	<span class="mb-2 small"><i class="fas fa-dot-circle text-danger"></i>Case with only uploaded full document.</span>
		<span class="mb-2 small"><i class="fas fa-dot-circle text-warning"></i>Case with only further entries.</span>
		<span class="mb-2 small"><i class="fas fa-dot-circle text-success"></i>Case with both further entries and uploaded full document.</span>
	</div>
	
	<div class="row" id="secratariat_unit_div" >
	<h6>Table Background Indicators</h6>
		<span class="mb-2 small"><i class="fas fa-dot-circle text-white" style="border: 1px solid black; border-radius: 50%"></i>New case with no attachment.</span>
		<!-- <span class="mb-2 small"><i class="fas fa-dot-circle text-danger"></i>Case with only uploaded document.</span> -->
		<span class="mb-2 small"><i class="fas fa-dot-circle text-success"></i>Case with uploaded full document.</span>
		<span class="mb-2 small"><i class="fas fa-dot-circle text-warning"></i>Case has been batched to the Legal unit.</span>
	</div>

	      <div class="row mb-4">
	            <div class="col-md-12">
	              <div class="card">
	              	<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i>Process Details <span
						class="col-md-3 float-right ">
						<button class="btn btn-success btn-icon-split float-right "
							id="btnViewBatchlist" disabled>
							<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span
								class="text">View Batch List</span>
						</button>
					</span>
					</div>
	                <div class="card-body">
	                	  <h5 class="card-title">Writs | <span id="card_title"> </span></h5>
	                  <div class="tab-content">
					            <div id="" class="table-responsive">
					                <table class="table " id="table_list"  width="100%" cellspacing="0" >
	              						<thead>
										    <tr>
										        <th>#</th>
										        <th>Suit Number</th>
										        <th>Nature of Case</th>
										        <th>Court Process</th>
										        <th>Court</th>
										        <th>Court Region</th>
										        <th>Plaintiff(s)</th>
										        <th>Defendant(s)</th>
										        <th>Date of Filing</th>
										        <th>Date Received</th>
										        <th>Reminder</th>
												<th>Actions</th>
										    </tr>
										  </thead>
										  <tbody id="table_body">
										    
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
<!-- End Page Content -->

 <!-- Incoming Modal-->
  <%--  <div class="modal fade" id="incomingModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Incoming | Cases</h5>
           
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
            <!--  <div class="col-12">
				<div class="gap-2 mt-3 mb-3" style="float:right;">
	                
	              </div>
             </div> -->
          </div>
                <!-- Buttons  -->
			 <!-- Buttons  -->
          <div class="modal-body">
            <div class="row">
                   <div id="" class="table-responsive">
                  <table class="table" id="incoming_list">
                  
                  </table>
                  </div>
            	</div>

          	</div>
          	<div class="modal-footer">
          		 <button  class="btn btn-success" type="button" id="btn_print" >Receive Physical Document </button>
            	<button type="button" class="btn btn-secondary"  data-dismiss="modal">Close</button>
          	</div>
        </div>
      </div>
    </div> --%>
<!-- Incoming Modal-->
 <!-- Attachment Modal  -->
  <div class="modal fade" id="elisDocumentPreview" tabindex="-1" role="dialog"
	aria-labelledby="elisDocumentPreview" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Document Preview</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
												
					<iframe src=""  id="elisdovumentpreviewblobfile" width="100%" height="600"></iframe>
							
				</div>

			</div>
			 	<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div>

  <div class="modal fade" id="showBatchlist" tabindex="-1" role="dialog"
	aria-labelledby="showBatchlist" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Receiving Items</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div id="batch_list">
				
				</div>

			</div>
			 	<div class="modal-footer">
			 	<button type="button" class="btn btn-primary" id="btn_print" >Accept Physical File(s)</button>
			 	
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div>


 <script>
function deleteRow(r) {
  var i = r.parentNode.parentNode.rowIndex;
  document.getElementById("batchTable").deleteRow(i);
  //$(#gridCheck).prop("checked", false);
  
  //var rows = document.getElementById("table_list").rows;
  //var suit_ = $(event.currentTarget).data('suit_number');
  
  //for (a = 0; a < rows.length; a++) {
      //var _row = rows[a];
      //console.log(_row)
      //$(_row).closest('tr').find(':checkbox').prop("checked", false);
 // }
  
}
</script>
<jsp:include page="../legal/includes/footer.jsp"></jsp:include>
<jsp:include page="../legal/includes/modals.jsp"></jsp:include>
<script type="text/javascript" src="legal/includes/pages_script/legal_unit.js"></script>