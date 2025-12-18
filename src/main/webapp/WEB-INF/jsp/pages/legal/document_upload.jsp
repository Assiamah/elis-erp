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
      <h1>Attach Document</h1>
    </div>  

 <section class="section">
 		<c:choose>
 			<c:when test="${(status == null)}">
		 			<form action="document_attachment" method="post" enctype="multipart/form-data">
		  		  <div class="row mb-3">
					<label for="inputNumber" class="col-sm-4 col-form-label">Suit Number:</label>
					<div class="col-sm-8">
		              <input class="form-control" type="text" id="suit_number" name="suit_number" value='<c:out value="${suit_number}"></c:out>' readonly required>
		            </div>
				  </div>
				  <div class="row mb-3">
					<label for="inputNumber" class="col-sm-4 col-form-label">Type of Document:</label>
					<div class="col-sm-8">
		              <select name="type_of_document" class="form-control" required>
			 				<option value="wis">Writ(initial scan)</option>
			 				<option value="wfs">Writ(full scan)</option>
			 				<option value="apd">Appearance(draft)</option>
			 				<option value="aps">Appearance(stamped)</option>
			 				<option value="oth">other</option>
					  </select>
		            </div>
				  </div> 
				   <div class="row mb-3">
		            <label for="inputNumber" class="col-sm-4 col-form-label">Select Document:</label>
		            <div class="col-sm-8">
		              <input class="form-control" type="file" id="file" name="file" accept="application/pdf" required>
		            </div>
		          </div>
		          <input type="text" name="request_type" value="upload_document" hidden>
		           <div class="row mb-3">
		           <button type="submit" class="btn btn-primary">Upload</button>
		           </div>
				</form>
 			
 			</c:when>
 			<c:when test="${(status =='success')}">
 				<h2>Document upload to <strong><c:out value="${suit_number}"></c:out></strong> was successful. </h2>
 				<a href="#" class="btn btn-primary" onclick="history.go(-2)" title="Return to previous">
                                    Go back
                                </a>
 			</c:when>
 			<c:otherwise>
 				<h1>Error Saving Document</h1>
 			</c:otherwise>
 			
 		</c:choose>
 	 	<div  class="table-responsive">
 		 <table class="table" id="attachments">
 		 	<thead>
 				<tr>
 					<th>Document Name</th><th>Document Type</th>
 				</tr>
 			</thead>
 			<tbody>
		 		 <!--<c:forEach items="${attachments}" var="attachment"  varStatus="appfiles_loop">
		 		  	 <tr>
		 		  	 	<td>${attachment.type_of_document}</td><td>${attachment.file_name}</td><td><a class="view_attach"  href="#" id="${attachment.file_location}" data-id="${attachment.file_location}">view</a></td>
		 		  	 </tr>	
		 		  </c:forEach> -->
 		  	</tbody>    
 		  </table>
		</div>
</section>


</div>
<!-- End Page Content -->

  <!-- Attachment Modal -->
  <div class="modal fade" id="viewAttachmentModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">View Document</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>       
        <div class="modal-body" style="font-size: small;">
   			<canvas id="pdf_render">
   			
   			
   			</canvas>      
  
        </div>
        <div class="modal-footer">

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
  
 
<jsp:include page="../legal/includes/footer.jsp"></jsp:include>
<script src="https://mozilla.github.io/pdf.js/build/pdf.js"></script>
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
												+ '<td> <a class="link-post" href="'
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
			function(e) {
				// console.log(e)
				e.preventDefault();

				

				var file_to_open = event.target.href;
				// C://gelisscans//scanpdf//LCGARGAPCN717422820190/APPLICATION_FOR_OFFICIAL_SEARCH_(CONSOLIDATED)_01436449.pdf

				// var str = "Visit Microsoft!";
				var file_path = file_to_open.replace(
						"file:///", "");

				$.ajax({
							type : "POST",
							url : "open_pdffile",
							// target:'_blank',
							data : {
								request_type : 'request_to_generate_batch_list',
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