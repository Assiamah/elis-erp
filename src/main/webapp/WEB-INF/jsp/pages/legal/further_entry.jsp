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
   
   <!-- Page Heading -->
                <div class="row mb-4">
                	 <div class="col-md-12">
                	     <h4>Case Management</h4>
		                <div class=" ">
		                   
					         <nav>
				                <ol class="breadcrumb">
				                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
				                  <li class="breadcrumb-item "><a href="${pageContext.request.contextPath}/legal_unit">Legal Unit</a></li>
				                  <li class="breadcrumb-item active">Further Entries</li>
				                  <a  class="btn btn-danger float-right" 
				                    style="position:absolute; right:160px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;"
				                    href="${pageContext.request.contextPath}/legal_unit">
				      				Go Back
				      			  </a>
				                  <button data-toggle="modal" href="#attachmentDoc" class="btn btn-primary float-right" 
				                    style="position:absolute; right:27px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;">
				      				Attachment
				      			  </button>
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div>
   
   
	<section class="section dashboard">
	
		             <form id="further_entry_form">
	     	<div class="row mb-4">
		      <div class="col-lg-12">
		
		         <div class="card">
		           <div class="card-body">

		             
		             <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop"> 
		               <div class="row mb-3">
		               	<div class="col-6 d-flex justify-content-start mb-4">
		               			<h5 class="mb-4">Suit Number:<span class="text-success ms-2">${cases.suit_number}</span> - [<span class="text-danger me-2 ms-2">${cases.nature_of_case_description}</span>]</h5>
		               	</div>
		               	<%-- <div class="col-6 d-flex justify-content-end mb-4">
			                 <button type="submit" class="btn btn-success"><i class="fas fa-save"></i>Save Form</button>
			             </div> --%>
			             </div>
		               	<!-- <hr/>
		               	<h6>Case Details</h6> -->
		               	
		               	<div class="row">
		               		<div class="col-6">
		               			<div class="row">
				               		<div class="col-4">
				               			<label for="" class="col-form-label">Court:<span class="text-danger"> *</span></label>
				               		</div>
				               		<div class="col-8"> 
				               			<select class="form-control" name="court_id" id="court_id">
					                 		<option value="${cases.court_id}">${cases.court_name}</option>
					                 		<d:forEach items="${courts}" var="court"  varStatus="appfiles_loop"> 
					                 			<option value="${court.id}">${court.court_name} - (${court.city})</option>
					                 		</d:forEach>
					                 	</select>
				               		</div>
				               	</div>
				               		<div class="row mt-4">
		                				<div class="col-4">
		                					<span>Reference Number:</span>
		                				</div>
		                				<div class="col-8">
		                					<input class="form-control" name="reference_number" id="reference_number"  value="${cases.reference_number}" />
		                				</div>
		                			</div>
				               	<div class="row mt-4">
		                				<div class="col-4">
		                					<span>Court Process:</span>
		                				</div>
		                				<div class="col-8">
		                					<input class="form-control" name="court_process" id="court_process"  value="${cases.court_process}" />
		                				</div>
		                			</div>
				               	<div class="row mt-3">
				               		<div class="col-4">
				               			<label for="" class="col-form-label">Region:<span class="text-danger"> *</span></label>
				               		</div>
				               		<div class="col-8"> 
				               			<input type="text" class="form-control" name="court_region" id="court_region" value="${cases.court_region}">
				               		</div>
				               	</div>
				               	
				               	<div class="row mt-3">
				               		<div class="col-4">
				               			<label for="" class="col-form-label">City/Town:<span class="text-danger"> *</span></label>
				               		</div>
				               		<div class="col-8"> 
				               			<input type="text" class="form-control" name="court_city" value="${cases.court_city}"  >
				               		</div>
				               	</div>
				               	
				               	<div class="row mt-3">
				               		<div class="col-4">
				               			<label for="" class="col-form-label">Court Description:</label>
				               		</div>
				               		<div class="col-8"> 
				               			<input type="text" class="form-control" name="court_description" value="${cases.court_description}">
				               		</div>
				               	</div>
				               	
				               	<div class="row mt-3">
				               		<div class="col-4">
				               			<label for="" class="col-form-label">Nature of Cases:<span class="text-danger">*</span></label>
				               		</div>
				               		<div class="col-8"> 
				               			<select class="form-control" name="nature_of_case" id="nature_of_case">
						                 		<option value="${cases.nature_of_case}">${cases.nature_of_case_description}</option>
						                 		<d:forEach items="${type_of_cases}" var="toc"  varStatus="appfiles_loop"> 
						                 			<option value="${toc.id}">${toc.description}</option>
						                 		</d:forEach>
						                </select>
				               		</div>
				               	</div>
				               	
				               	<div class="row mt-3">
				               		<div class="col-4">
				               			<label for="" class="col-form-label">Filing Date:<span class="text-danger"> *</span></label>
				               		</div>
				               		<div class="col-8"> 
										<input type="date" class="form-control" placeholder="dd/mm/yyyy" name="date_of_document"  value="${cases.date_of_document}" required>
				               		</div>
				               	</div>
				               	
				               	<div class="row mt-3">
				               		<div class="col-4">
				               			<label for="" class="col-form-label">Date Received:<span class="text-danger"> *</span></label>
				               		</div>
				               		<div class="col-8"> 
				               			<input type="date" class="form-control"  placeholder="dd/mm/yyyy" name="date_received" value="${cases.date_received}" readonly>
				               		</div>
				               	</div>
		               		</div>
		               		<div class="col-6"> 
		               			<div class="row">
				               		<div class="col-4">
				               			<label for="" class="col-form-label">Reliefs:<span class="text-danger"> *</span></label>
				               		</div>
				               		<div class="col-8"> 
				               			<textarea class="form-control" rows="7" name="reliefs" id="reliefs" required="required">${cases.releifs}</textarea>
				               		</div>
				               	</div>
				               	
				               	<div class="row mt-3">
				               		<div class="col-4">
				               			<label for="" class="col-form-label">Summary:<span class="text-danger">*</span></label>
				               		</div>
				               		<div class="col-8"> 
				               			<textarea class="form-control" name="summary" id="summary" rows="6" required="required">${cases.summary}</textarea>
				               		</div>
				               	</div>
		               		</div>
		               	</div>
		               	
		               	<input class="form-control" type="text" id="suit_number" name="suit_number"  value="${cases.suit_number}" hidden>
		               	<input class="form-control" type="text" id="case_id" name="case_id"  value="${cases.id}" hidden>
		               	<input type="text" name="request_type" value="further_entries" hidden>
		          	
	               </c:forEach> 
	            
			   </div>
	         </div>
	       </div>
	     </div>
	     
	     
	     <div class="row mb-4">
	            <div class="col-md-12">
	              <div class="card">
	                <div class="card-body">
	                	 
	                  <div class="row">
               				<div class="col-md-12">
               				<p>
							  <a class="btn btn-warning" id="scroll_page" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
							    Parties
							  </a>
							</p><br/>
							<div id="alert_party"></div>
							<div class="collapse" id="collapseExample">
							  <div class="card card-body">
							  <div class="text-end mb-2">
							  	<button  type="button" class="btn btn-warning small"  data-toggle="modal" data-target="#addPartyModal"><i class="fas fa-plus-circle"></i>Add Parties</button>
							  </div>
							  <table class="table table-striped" id="parties_tbl_main"  width="100%" cellspacing="0">
								  <thead>
								    <tr> 
									<th scope="col">#</th>
								      <th scope="col">Party Type</th>
								      <th scope="col">Party Name</th>
								      <th scope="col">Party's Address</th>
								      <th scope="col">Party's Lawyer</th>
								      <th scope="col">Lawyer's Tel</th>
								      <th scope="col">Lawyer's Add</th>
								      <th scope="col">Lawyer's Chambers</th>
								      <th scope="col">Action</th>
								    </tr>
								  </thead>
								  <tbody id="parties_tbl">
								   
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
	          
	          
	     <div class="row mb-3">
		               	<div class="col-6 d-flex justify-content-start mb-4">
		               			<%-- <h4 class="mb-4">Suit Number:<span class="text-success">${cases.suit_number}</span></h4> --%>
		               	</div>
		               	<div class="col-6 d-flex justify-content-end mb-4">
			                 <button type="submit" class="btn btn-success"><i class="fas fa-save"></i>Save Form</button>
			             </div>
			             </div>
	      </form>
	     	<div class="row mt-2">
	            <div class="col-md-12">
	              <div class="card">
	                <div class="card-body">
	                	  <div class="card card-body">
	                  <div class="tab-content">
					        <div  class="table-responsive">
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
	     
     </section>

	</div>
<!-- End Page Content -->

 <!-- Attachment Modal -->
  <div class="modal fade" id="attachmentDoc" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Attach Document</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="cases_upload" method="post" enctype="multipart/form-data">
        
        <div class="modal-body" style="font-size: small;">
         <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop"> 
          <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Suit Number:</label>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="suit_number" name="suit_number" value="${cases.suit_number}" readonly required>
            </div>
		  </div>
		  <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Type of Document:</label>
			<div class="col-sm-8">
             	<%-- <select class="form-control" name="type_of_document" id="type_of_document" required>
                		<d:forEach items="${type_of_cases}" var="toc"  varStatus="appfiles_loop"> 
                			<option value="${toc.id}">${toc.description}</option>
                		</d:forEach>
		         </select> --%>
		         <input class="form-control" type="text" id="type_of_document" name="type_of_document" value="${cases.court_process}" readonly required>
            </div>
		  </div> 
		   <div class="row mb-3">
            <label for="inputNumber" class="col-sm-4 col-form-label">Select Document:</label>
            <div class="col-sm-8">
              <input class="form-control" type="file" id="file" name="file" accept="application/pdf" required>
            </div>
          </div>
            <input class="form-control" hidden="" type="text" id="case_number" name="case_number" value="${cases.id}" >
		 </c:forEach>
        </div>
        <div class="modal-footer">
          <button type="submit" id="upload_btn" class="btn btn-primary">Upload</button>
        
        </div>
       </form>
      </div>
    </div>
  </div>
  
  <!-- Attachment Modal  -->


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
	<div class="modal fade" id="addPartyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Add Party</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <form method="post" id="addPartyForm">
	      <div class="modal-body">
	     
	      	<div class="text-start">
				<label for="basic-url">Party Type</label>
			</div>
			<div class="input-group mb-3">
			  <select class="form-control" aria-label="Default select example" name="party_type" id="party_type" required>
                <option disabled selected>-- select --</option>
                <option value="Plaintiff">Plaintiff</option>
				<option value="Defendant">Defendant</option>	
              </select>
			</div>
			<div class="text-start">
				<label for="basic-url">Party Name</label>
			</div>
			<div class="input-group mb-3">
			  <input type="text" class="form-control " name="party_name" id="party_name" required />
			</div>
			<div class="text-start">
				<label for="basic-url">Party's Address</label>
			</div>
			<div class="input-group mb-3">
			  <textarea  class="form-control " name="party_address" id="party_address" ></textarea>
			</div>
			<div class="text-start">
				<label for="basic-url">Party's Lawyer</label>
			</div>
			<div class="input-group mb-3">
			  <input type="text" class="form-control " name="party_lawyer" id="party_lawyer"  />
			</div>
			<div class="text-start">
				<label for="basic-url">Lawyer's Telephone</label>
			</div>
			<div class="input-group mb-3">
			  <input type="number" class="form-control " name="lawyer_tel"  id="lawyer_tel" />
			</div>
			<div class="text-start">
				<label for="basic-url">Laywer's Address</label>
			</div>
			<div class="input-group mb-3">
			  <textarea  class="form-control " name="lawyer_address" id="lawyer_address" ></textarea>
			</div>
			<div class="text-start">
				<label for="basic-url">Laywer's Chamber</label>
			</div>
			<div class="input-group mb-3">
			  <input type="text" class="form-control " name="lawyer_chamber" id="lawyer_chamber"  />
			</div>
			
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-success" id="add_party">Add</button>
	      </div>
	     </form>
	    </div>
	  </div>
	</div> 

	<div class="modal fade" id="editPartyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
		  <div class="modal-content">
			<div class="modal-header">
			  <h5 class="modal-title" id="exampleModalLabel">Edit Party</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<form action="" method="POST" enctype="multipart/form-data" id="edit_party_form">
			<div class="modal-body">
				<!-- <input type="" id="party_id" value=""> -->
				<input type="hidden" id="row_num" value="">
				<div class="text-start">
				  <label for="basic-url">Party Type <span class="text-danger">*</span></label>
			  </div>
			  <div class="input-group mb-3">
				<select class="form-control" aria-label="Default select example" name="party_type" id="e_party_type" required>
					
				</select>
			  </div>
			  <div class="text-start">
				  <label for="basic-url">Party Name <span class="text-danger">*</span></label>
			  </div>
			  <div class="input-group mb-3">
				<input type="text" class="form-control " name="party_name" id="e_party_name" required />
			  </div>
			  <div class="text-start">
				  <label for="basic-url">Party's Address</label>
			  </div>
			  <div class="input-group mb-3">
				<textarea  class="form-control " name="party_address" id="e_party_address" ></textarea>
			  </div>
			  <div class="text-start">
				  <label for="basic-url">Party's Lawyer</label>
			  </div>
			  <div class="input-group mb-3">
				<input type="text" class="form-control " name="party_lawyer" id="e_party_lawyer"  />
			  </div>
			  <div class="text-start">
				  <label for="basic-url">Lawyer's Telephone</label>
			  </div>
			  <div class="input-group mb-3">
				<input type="number" class="form-control " name="lawyer_tel"  id="e_lawyer_tel" />
			  </div>
			  <div class="text-start">
				  <label for="basic-url">Lawyer's Address</label>
			  </div>
			  <div class="input-group mb-3">
				<textarea  class="form-control " name="lawyer_address" id="e_lawyer_address" ></textarea>
			  </div>
			  <div class="text-start">
				  <label for="basic-url">Lawyer's Chamber</label>
			  </div>
			  <div class="input-group mb-3">
				<input type="text" class="form-control " name="lawyer_chamber" id="e_lawyer_chamber"  />
			  </div>
			</div>
			<div class="modal-footer">
			  <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			  <button type="button" class="btn btn-success" data-dismiss="modal" id="btn-update-party">Update</button>
			</div>
		   </form>
		  </div>
		</div>
	  </div>  
 
<jsp:include page="../legal/includes/footer.jsp"></jsp:include>

<script type="text/javascript" src="legal/includes/pages_script/further_entry.js"></script>  
<script type="text/javascript" >
$(function(){
	
	var table_docs = $('#attachments');
	table_docs.find("tbody tr").remove();

	let suit_number=$('input[name="suit_number"]').val();
	
	
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

								table_docs
										.append("<tr>"
												+ '<td> <a class="link-post" data-file_path="'+ this.document_name +'" href="'
												+ this.document_name
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
	
	
})

</script> 