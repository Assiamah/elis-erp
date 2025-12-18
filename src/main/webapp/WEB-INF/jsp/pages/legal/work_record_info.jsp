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
   
    <div class="pagetitle">
	    <h4 class="">Record Information</h4>
	     <div class=" ">
		                   
					         <nav>
				                <ol class="breadcrumb">
				                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
				                  <li class="breadcrumb-item "><a href="${pageContext.request.contextPath}/legal_request">Legal Request</a></li>
				                  <li class="breadcrumb-item active">Work
				                  	<%-- <a href="${pageContext.request.contextPath}/legal_request"> --%>
					                  <button  class="btn btn-warning float-right" id="print_request"
					                    style="position:absolute; right:100px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;">
					      				Print Request
					      			  </button>
					      			 <!--  </a> -->
				                 	 <a href="${pageContext.request.contextPath}/legal_request">
					                  <button  class="btn btn-danger float-right"  onclick="history.back()"
					                    style="position:absolute; right:30px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;">
					      				Back
					      			  </button>
					      			  </a>
				      			  </li>
				                </ol>
			               </nav>
       
	 
 	</div><!-- End Page Title -->
 	</div>
	<section class="section dashboard">
    	<div class="row">	
      		<!-- Case Details -->
      		<div class="col-lg-6">
				 <%-- <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop">
	              <h5 class="card-title">Suit No:<strong> ${cases.suit_number} </strong></h5>
				</c:forEach> --%>
              <!-- Accordion without outline borders -->
              <div class="accordion" id="accordionCaseDetails">
              <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop">
	                <div class="accordion-item">
	                 <h2 class="accordion-header" id="parties">
		                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="true" aria-controls="collapse1">
	            			Requested Description
		                </button>
	                 </h2>
	                  <div id="collapse1" class="accordion-collapse collapse show" aria-labelledby="parties" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                      <div class="row ">
	                      	<div class="col-sm-12">
	                      	<input type="text" class="form-control" id="req_suit_number" name="suit_number" value="${cases.suit_number}" hidden>
	                      	<input type="text" name="case_id" id="req_case_id" value="${cases.case_id}" hidden />
	                      	<input type="text" name="deadline" id="req_deadline" value="${cases.deadline}" hidden />
	                      	<input type="text" name="deadline" id="req_subject" value="${cases.subject}" hidden />
	                      	<input type="text" name="deadline" id="req_description" value="${cases.description}" hidden />
	                      	<input type="text" name="deadline" id="req_requested_by" value="${cases.requested_by}" hidden />
	                        <!-- <input type="text" name="deadline" id="req_description" value="${cases.division}" hidden />
	                      	<input type="text" name="attach_file" id="req_description" value="${cases.description}" hidden /> 
	                      	<input type="text" name="attach_file" id="req_description" value="${cases.description}" hidden />  -->
	                      	
	                    	<div class="row mb-4">
	                    		<div class="col-md-12">
	                    			<input class="form-control" name="request_type" value="update_releifs_and_summary" readonly="readonly" hidden="" />
						              <input class="form-control" name="case_id" value="${cases.id}" readonly="readonly" hidden="" />
									<h5>Suit No.: <span class="text-danger">${cases.suit_number}</span></h5>
									<hr>
									<b><label class="mt-2">Deadline:</label>
			                    	<span>${cases.deadline}</span></b><br>
			                    	<label class="mt-4">Subject</label>
			                    	<textarea rows="" cols="" class="form-control" id="" readonly>${cases.subject}</textarea>
		                    	</div>
	                    	</div>
	                    	<div class="row mb-4">
	                    		<div class="col-md-12">
			                    	<label>Description</label>
			                    	<textarea rows="5" cols="" class="form-control" id="" readonly>${cases.description}</textarea>
		                    	</div>
	                    	</div>
						  	<div class="row mb-4">
	                    		<div class="col-md-12">
	                    			<label>Process Documents</label>
		                    		<div class="table-responsive mb-5">
			                    	<table class="table table-striped" id="doc_on_case"  width="100%" cellspacing="0">
							 		 	<thead>
							 				<tr>
							 					<th>Document Name</th><th>Document Type</th>
							 				</tr>
							 			</thead>
							 			<tbody>
							 		  	</tbody>    
			 		  				</table>
			 		  			    </div>
			 		  			    <hr>
			                    	<label>Requested Documents</label>
			                    	<div class="table-responsive">
				                    	<table class="table table-striped" id="attachments"  width="100%" cellspacing="0">
								 		 	<thead>
								 				<tr>
								 					<th>Document Name</th><th>Document Type</th>
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
                
                </c:forEach>
	                 
	                
	                 <div class="accordion-item">
		                  <h2 class="accordion-header" id="notes">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse5" aria-expanded="false" aria-controls="collapse5">
		                      Information Provided
		                    </button>
		                  </h2>
	                  <div id="collapse5" class="accordion-collapse collapse" aria-labelledby="notes" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	 		  				<div class="row mb-4">
	                    		<div class="col-md-12">
			                    	<div class="table-responsive">
				                    	<table class="table" id="provided_docs"  width="100%" cellspacing="0">
								 		 	<thead>
								 				<tr>
								 					<th>Notes</th><th>Attachment</th><th>Date</th><th>Action</th>
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
	                
                
			</div> <!-- Accordion -->
           </div><!-- col6 -->
            <!-- Right side columns -->
        <div class="col-lg-6">

          <!-- Recent Activity -->
		  <form method="post" id="requested_note" enctype="multipart/form-data">
           <div class="card">
          	<div class="card-header"><h5>Add Notes</h5></div>
            <div class="card-body">
				  <label>Note</label>
				   <div class="row mb-3">
				   <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop">
				   <input type="text" class="form-control" id="suit_number" name="suit_number" value="${cases.suit_number}" hidden>
	                      	<input type="text" id="case_id" name="case_id" value="${cases.case_id}" hidden />
	                      	<input type="text" id="request_type" name="request_type" value="provide_record_info" hidden />
				   </c:forEach>
				   
		            <div class="col-sm-12">
		              <textarea class="form-control" rows="5" id="note_provided" name="note_provided" required></textarea>
		            </div>
		          </div>
		          <%-- <label>Attachment</label>
				  <div class="row mb-3">
					<div class="col-sm-12">
		              <input class="form-control" type="file" id="note_attachment" name="note_attachment">
		            </div>
				  </div> --%>
				  
				  <!-- <%-- <div class="row mt-4">
		                				<div class="col-md-12">
		                					<span>Would a file be attached ?:</span>
		                					<input type="checkbox" class="form-check-input ml-4" name="attach_file" id="attach_file"  />
		                				</div>
		                				
		                			</div> --%>
		                			
		                			<div class="row mt-4 mb-4" id="">
							            <label>Select Document:</label>
							            <div class="col-md-12">
							              <input class="form-control" type="file" id="file" name="file" accept="application/pdf">
							            </div>
						
									 </div> -->

									 <div class="row mt-4">
		                				<div class="col-md-12">
		                					<span>Would a document be attached ?:</span>
		                					<input type="checkbox" class="form-check-input ml-4" name="attach_file_" id="attach_file_"  />
		                				</div>
		                				
		                			</div>
		                			
		                			<div class="row mt-4 mb-4" id="attach_doc_">
							            
											<label for="inputNumber" class="col-md-12 col-form-label">Select Document:</label>
							            <div class="col-md-12">
							              <input class="form-control" type="file" id="file_" name="file_" accept="application/pdf" >
							            </div>
						
									 </div>
				  
				  <div class="d-flex justify-content-end">
		                 <button type="submit" class="btn btn-success"><i class="fas fa-save"></i>Submit</button>
		             </div>
            </div>
          </div>
          </form>
          <!-- End Recent Activity -->
			<!-- End Recent Activity -->
         


        </div><!-- End Right side columns -->

 		</div>
 		
 	<%-- 	<div class="row">
 				<div class="col-lg-4">
	 			<div class="card">
	 				<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i>Generate Template 
					</div>
	 				<div class="card-body">
			 			
			           <form id="generate_letter">
			              <div class="row mb-3">
							<label for="inputNumber" class="col-sm-4 col-form-label">Letter Template</label>
						 </div> 
						 <div class="row mb-3">   
			             		<select class="form-control" id="letter_template" required>
			             			<option value="default" selected>Default</option>
			             			<option value="appearance">File Appearance</option>
			             			<option value="statement">State of Defendence</option>
			             		</select>
			             </div> 
			 			  <div class="row mb-3">
							<label for="inputNumber" class="col-sm-4 col-form-label">Letter Body</label>
						 </div> 
						 <div class="row mb-3">   
			              <textarea rows="10" style="height:100%;" type="text" class="form-control" id="text-area-first" name="text-area-first" required placeholder="text">
			                 
			              </textarea>
			             </div> 
			             <div class="row mb-3">
			             		<div class="d-flex justify-content-center">
			             			<button class="btn btn-primary"  type="submit" id="generateLetterBtn"
				                    style="border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;">
				      				Generate Letter
				      			  </button>
			             		</div> 		
			             </div>
			             </form>
			        </div>
				</div>
      		</div>
 				
 		
 		
 		</div> --%>
 		
	</section>
 
 	</div>
<!-- End Page Content -->

 
  

  
  <!-- Attachment Modal  -->
 <%--  <div class="modal fade" id="elisDocumentPreview" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true"> --%>
	<div class="modal fade" id="elisDocumentPreview" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Document Preview</h5>
				<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
												
					<iframe src=""  id="elisdovumentpreviewblobfile" width="100%" height="600"></iframe>
							
				</div>

			</div>
			 	<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div>

<div class="modal fade" id="view_notes" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Suit Number: <span class="text-danger" id="n_suit_number"></span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <b>Notes:</b> <span class="ms-2" id="n_notes"></span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
      </div>
    </div>
  </div>
</div>
  
  <!-- Notes Modal  -->
<jsp:include page="../legal/includes/footer.jsp"></jsp:include>
<script type="text/javascript" src="legal/includes/pages_script/record_info.js"></script>
<script src="https://mozilla.github.io/pdf.js/build/pdf.js"></script>
 <script src="legal/includes/bootstrap/js/bootstrap.min.js"></script>
 
 ${param.success == "true" ? "
 
 <script> 
toastr['success']('Record info has been requested successfully', 'Success');
</script>
 ":""}
 
 <script>

  document.addEventListener('DOMContentLoaded', function() {
		
	  var table_docs = $('#attachments');
		table_docs.find("tbody tr").remove();

		var table_docs_a = $('#doc_on_case');
		table_docs_a.find("tbody tr").remove();
		
		
		let suit_number=$('input[name="suit_number"]').val();
		
		
		$.ajax({
			url:"load_scanned_documents",
			method:"POST",
			data:{
					"request_type":"load_requested_document",
					"suit_number":suit_number
			},
			success:function(response){
				console.log(response);
				

				var json_p = JSON
						.parse(response);
				console.log(json_p)

				$(json_p)
						.each(
								function() {

									table_docs
											.append("<tr>"
													+ '<td> <a class="link-post" data-file_path="'+ this.document_name +'" href="'
													+ this.document_file
													+ '">'
													+ this.document_name
													+ '</a></td>'
													+'<td>'
													+ this.document_extention
													+ "</td>"
													+ "</tr>");


								});
			}
		})
		
		
		
		$.ajax({
			url:"load_scanned_documents",
			method:"POST",
			data:{
					"request_type":"load_scanned_document",
					"suit_number":suit_number
			},
			success:function(response){
				console.log(response);
				

				var json_p = JSON
						.parse(response);
				console.log(json_p)

				$(json_p)
						.each(
								function() {
									
									table_docs_a
											.append("<tr>"
													+ '<td> <a class="link-post" data-file_path="'+ this.document_name +'" href="'
													+ this.document_file
													+ '">'
													+ this.document_name
													+ '</a></td>'
													+'<td>'
													+ this.document_extention
													+ "</td>"
													+ "</tr>");


								});
			}
		})
		
		
		$('#attachments')
		.on(
				'click',
				'.link-post',
				function(event) {
					// console.log(e)
					event.preventDefault();

					var suit_number=$('input[name="suit_number"]').val();
					var file_path = $(event.currentTarget).data('file_path');
					
					console.log(file_path);
					console.log(suit_number);
						
					//var file_to_open = event.target.href;
					// C://gelisscans//scanpdf//LCGARGAPCN717422820190/APPLICATION_FOR_OFFICIAL_SEARCH_(CONSOLIDATED)_01436449.pdf
					//console.log(file_to_open)
					// var str = "Visit Microsoft!";
					//var file_path = file_to_open.replace("http://localhost:8080/U", "file:///u");
					
					$.ajax({
								type : "POST",
								//url : "open_pdffile",
								url: "legal_unit_serv",
								// target:'_blank',
								data : {
									//request_type : 'request_to_generate_batch_list',
									request_type: 'open_request_doc',
									suit_number : suit_number,
									file_path: file_path
								},
								cache : false,
								xhrFields : {
									responseType : 'blob'
								},
								beforeSend : function() {
									// $('#district').html('<img
									// src="img/loading.gif"
									// alt="" width="24"
									// height="24">');
								},
								success : function(jobdetails) {
									console.log(jobdetails);
									// const arrayBuffer =
									// _base64ToArrayBuffer(jobdetails);
									$('#elisDocumentPreview').modal('show');
									$('#elisDocumentPreview')
											.modal(
													{
														backdrop : 'static',
													});

									var blob = new Blob(
											[ jobdetails ],
											{
												type : "application/pdf"
											});
									var objectUrl = URL
											.createObjectURL(blob);
									// window.open(objectUrl);

									$(
											'#elisdovumentpreviewblobfile')
											.attr('src',
													objectUrl);

									$(
											'#fedocumentPreviewblobfile')
											.attr('src',
													objectUrl);

									// $('#NotoncaseafterPaymentModalonCase').modal('hide');

								}
							});

				});
		
		
		
		$('#doc_on_case')
	.on(
			'click',
			'.link-post',
			function(event) {
				// console.log(e)
				event.preventDefault();

				var suit_number=$('input[name="suit_number"]').val();
				var file_path = $(event.currentTarget).data('file_path');
				
				console.log(file_path);
				console.log(suit_number);
					
				//var file_to_open = event.target.href;
				// C://gelisscans//scanpdf//LCGARGAPCN717422820190/APPLICATION_FOR_OFFICIAL_SEARCH_(CONSOLIDATED)_01436449.pdf
				//console.log(file_to_open)
				// var str = "Visit Microsoft!";
				//var file_path = file_to_open.replace("http://localhost:8080/U", "file:///u");
				
				$.ajax({
							type : "POST",
							//url : "open_pdffile",
							url: "legal_unit_serv",
							// target:'_blank',
							data : {
								//request_type : 'request_to_generate_batch_list',
								request_type: 'open_case_doc',
								suit_number : suit_number,
								file_path: file_path
							},
							cache : false,
							xhrFields : {
								responseType : 'blob'
							},
							beforeSend : function() {
								// $('#district').html('<img
								// src="img/loading.gif"
								// alt="" width="24"
								// height="24">');
							},
							success : function(jobdetails) {
								console.log(jobdetails);
								// const arrayBuffer =
								// _base64ToArrayBuffer(jobdetails);
								$('#elisDocumentPreview').modal('show');
								$('#elisDocumentPreview')
										.modal(
												{
													backdrop : 'static',
												});

								var blob = new Blob(
										[ jobdetails ],
										{
											type : "application/pdf"
										});
								var objectUrl = URL
										.createObjectURL(blob);
								// window.open(objectUrl);

								$(
										'#elisdovumentpreviewblobfile')
										.attr('src',
												objectUrl);

								$(
										'#fedocumentPreviewblobfile')
										.attr('src',
												objectUrl);

								// $('#NotoncaseafterPaymentModalonCase').modal('hide');

							}
						});

			});
		
		
		const checkbox = document.querySelector("input[name=attach_file_]");

		  checkbox.addEventListener("change", (e) => {
		    if (e.target.checked) {
		      document.getElementById("attach_doc_").style.display="block";
		    } else {
		      document.getElementById("attach_doc_").style.display="none";
		    }
		  });
		  
		  
		  $('#print_request').on('click', function(e) {
			  e.preventDefault();
			  
			  var req_suit_number = $('#req_suit_number').val();
			  var req_case_id = $('#req_case_id').val();
			  var req_deadline = $('#req_deadline').val();
			  var req_subject = $('#req_subject').val();
			  var req_description = $('#req_description').val();
			  var req_requested_by = $('#req_requested_by').val();
			  
			  $.ajax({
					type : "POST",
					//url : "open_pdffile",
					url: "work_record_info_serv",
					// target:'_blank',
					data : {
						//request_type : 'request_to_generate_batch_list',
						request_type: 'print_request',
						suit_number : req_suit_number,
						case_id: req_case_id,
						deadline: req_deadline,
						subject: req_subject,
						description: req_description,
						requested_by: req_requested_by,
					},
					cache : false,
							xhrFields : {
								responseType : 'blob'
							},
							beforeSend : function() {
								// $('#district').html('<img
								// src="img/loading.gif"
								// alt="" width="24"
								// height="24">');
							},
					success:function(jobdetails){
						console.log(jobdetails);
					
						//showbatchlist(response);

						$('#elisDocumentPreview').modal('show');
								$('#elisDocumentPreview')
										.modal(
												{
													backdrop : 'static',
												});

								var blob = new Blob(
										[ jobdetails ],
										{
											type : "application/pdf"
										});
								var objectUrl = URL
										.createObjectURL(blob);
								// window.open(objectUrl);

								$(
										'#elisdovumentpreviewblobfile')
										.attr('src',
												objectUrl);

								$(
										'#fedocumentPreviewblobfile')
										.attr('src',
												objectUrl);
						
					}
				});
			  
		  })
		  
		  function showbatchlist(response){
				
				
				var file_path =response;
				console.log(file_path);
				
				$.ajax({
							type : "POST",
							url : "legal_unit_serv",
							// target:'_blank',
							data : {
								request_type : 'open_request_pdf',
								file_path : file_path
							},
							cache : false,
							xhrFields : {
								responseType : 'blob'
							},
							beforeSend : function() {
								// $('#district').html('<img
								// src="img/loading.gif"
								// alt="" width="24"
								// height="24">');
							},
							success : function(jobdetails) {
								console.log(jobdetails);
								// const arrayBuffer =
								// _base64ToArrayBuffer(jobdetails);
							
$('#elisDocumentPreview').modal('show');
								$('#elisDocumentPreview')
										.modal(
												{
													backdrop : 'static',
												});

								var blob = new Blob(
										[ jobdetails ],
										{
											type : "application/pdf"
										});
								var objectUrl = URL
										.createObjectURL(blob);
								// window.open(objectUrl);

								$(
										'#elisdovumentpreviewblobfile')
										.attr('src',
												objectUrl);

								$(
										'#fedocumentPreviewblobfile')
										.attr('src',
												objectUrl);

								// $('#NotoncaseafterPaymentModalonCase').modal('hide');

							}
						});


					}
		

			// const checkbox = document.querySelector("input[name=attach_file]");

			//   checkbox.addEventListener("change", (e) => {
			//     if (e.target.checked) {
			//       document.getElementById("attach_doc").style.display="block";
			//     } else {
			//       document.getElementById("attach_doc").style.display="none";
			//     }
			//   });
		
	})

			
	

 </script> 