<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <jsp:include page="../legal/includes/header.jsp"></jsp:include>
 
<!-- Begin Page Content -->
<div class="container-fluid">
	<!-- Main content -->
    <section class="content">
				    
                <!-- Page Heading -->
                <div class="row mb-4">
                	 <div class="col-md-12">
		                <div class=" ">
		                   
					         <nav>
				                <ol class="breadcrumb">
				                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
				                  <li class="breadcrumb-item active">Secretariat</li>
				                  <a href="${pageContext.request.contextPath}/secretariat_add_case">
				                  <button  class="btn btn-danger float-right" 
				                    style="position:absolute; right:27px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;">
				      				New Process
				      			  </button>
				      			  </a>
				      			 <%--  <a href="${pageContext.request.contextPath}/legal_settings">
				      			  <button class="btn btn-success float-right" 
				                    style="position:absolute; right:50px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;">
				      				Settings
				      			  </button>
				      			  </a> --%>
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div>
                
           			<div class="row">
	<h6>Table Background Indicators</h6>
		<span class="mb-2 small"><i class="fas fa-dot-circle text-white" style="border: 1px solid black; border-radius: 50%"></i>New case with no attachment.</span>
		<!-- <span class="mb-2 small"><i class="fas fa-dot-circle text-danger"></i>Case with only uploaded document.</span> -->
		<span class="mb-2 small"><i class="fas fa-dot-circle text-success"></i>Case with uploaded document.</span>
		<span class="mb-2 small"><i class="fas fa-dot-circle text-warning"></i>Case has been batched to the Legal unit.</span>
	</div>
                
				      <div class="row">
				            <div class="col-md-12">
				              <div class="card">
				              <div class="card-header bg-dark text-white">
								<i class="fa fa-bar-chart"></i>Process Details 
								<button class="btn btn-success btn-icon-split float-right "
									id="btnViewBatchlist">
									<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span
										class="text">View Batch List</span>
								</button>
							</div>
				                <div class="card-body">
				                	  <h5 class="card-title">Received Process <span>| Secretariat</span></h5>
				                  <div class="tab-content">
								            <div id="" class="table-responsive">
								                <table class="table " id="table_list"  width="100%" cellspacing="0" >
				              
					                   	        </table>
								            </div>
								    </div>
				                </div>
				              </div>
				            </div>
				          </div>
				
				      
				    </section>
				    <!-- /.content -->

            </div>
            <!-- End of Main Content -->
            
 <div class="modal fade" id="showBatchlist" tabindex="-1" role="dialog"
	aria-labelledby="showBatchlist" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Forward Cases</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div id="batch_list">
					
				
				</div>

			</div>
			 	<div class="modal-footer">
			 	<button type="button" class="btn btn-primary" id="btn_print" >Forward Physical File</button>
			 	
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div>
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

<!-- Attachment Modal -->
  <div class="modal fade" id="attachmentModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Attach Document</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="cases_upload" method="post" enctype="multipart/form-data">
        
        <div class="modal-body" style="font-size: small;">
         
         <div class="row mb-3" hidden="">
			<label for="inputNumber" class="col-sm-4 col-form-label">Suit Number:</label>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="case_id" name="case_id" readonly required>
            </div>
		  </div>
          <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Suit Number:</label>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="suit_number" name="suit_number" readonly required>
            </div>
		  </div>
		  <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Type of Document:</label>
			<div class="col-sm-8">
             	<input class="form-control" type="text" id="type_of_document" name="court_process" readonly required>
            </div>
		  </div> 
		   <input type="text" name="type_of_document" value="initial_scan" hidden>
		   <div class="row mb-3">
            <label for="inputNumber" class="col-sm-4 col-form-label">Select Document:</label>
            <div class="col-sm-8">
              <input class="form-control" type="file" id="file" name="file" accept="application/pdf" required>
            </div>
          </div>

        </div>
        <div class="modal-footer">
          <button type="submit" id="upload_btn" class="btn btn-primary">Upload</button>
        </div>
       </form>
      </div>
    </div>
  </div>
  
  <!-- Attachment Modal  -->
  
  <script>
function deleteRow(r) {
  var i = r.parentNode.parentNode.rowIndex;
  document.getElementById("batchTable").deleteRow(i);
}
</script>
 
  <jsp:include page="../legal/includes/footer.jsp"></jsp:include>
<script type="text/javascript" src="legal/includes/pages_script/secretariat.js"></script>

  
  
  