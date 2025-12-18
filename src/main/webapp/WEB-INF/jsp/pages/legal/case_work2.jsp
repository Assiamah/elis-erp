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
	    <h2 class="">Case Management</h2>
	    <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop">
	    <!-- <p class="">Suit No: <strong>${cases.suit_number}</strong></p> -->
	    <input type="text" value="${cases.suit_number}" name="suit_number" id="suit_number" hidden>
	    </c:forEach>
 	</div><!-- End Page Title -->
	<section class="section dashboard">
    	<div class="row">
      		<div class="col-lg-8">
      			<c:choose>
 					<c:when test="${(milestone !== 'WS01')}">
 						<d:choose>
 							<d:when test="${(sub_milestone)=='PS1' || (sub_milestone)=='null'}">
	 					     <div class="mb-4">
	 					      <h4 class="mb-4">PLEADING STAGE</h3>
	 					      <nav>
						        <ol class="breadcrumb">
						          <li class="breadcrumb-item text-primary ">File Appearance</li>
						          <li class="breadcrumb-item">Statement of Defence and/or Counter Claim</li>
						          <li class="breadcrumb-item ">Receive Plaintiff Response</li>
								  <li class="breadcrumb-item ">Receive Application for Direction</li>
								  <li class="breadcrumb-item ">File Witness Statement and other documents</li>
								  <li class="breadcrumb-item ">Case Management</li>
						        </ol>
						      </nav>
	 					      
				              <textarea class="tinymce-editor" id="file_appearance">
				                 <p>Template goes here</p>
				              </textarea>
				              </div>
				              <div class="mb-4">
				              		<button class="btn btn-primary" id="attach_letter" data-id="PS1" >Attach Letter</button>
				              		<button class="btn btn-primary" id="make_note"  >Make Note</button>
				              </div>
				              </d:when>
			              </d:choose>
 					</c:when>
 					<c:otherwise>
 						<div>
 							<h4>Set milestone</h4>
 							<div class="row mb-3">
			                <label for="inputText" class="col-sm-2 col-form-label">Status of Case<span class="text-danger">*</span>:</label>
			                <div class="col-sm-10">
				              <select class="form-control" aria-label="Default select example" name="status_of_case" id="status_of_case">
				                <option>-- select --</option>
				                <option value="1">File Affidavit in Response</option>
				                <option value="2">Statement of Case By Applicant</option>
				                <option value="3">File Appearance</option>
				                <option value="4">Statement of Defence and/or Counter Claim</option>
				                <option value="5">Receive Plaintiff Response</option>	               
				              </select>
			            	</div>
		          	 </div>
 						</div>
 					</c:otherwise>
 				</c:choose>	
      		
      		</div>
      		<!-- Case Details -->
      		<div class="col-lg-4">
				 <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop">
	              <h5 class="card-title">Suit No:<strong> ${cases.suit_number} </strong></h5>
				</c:forEach>
              <!-- Accordion without outline borders -->
              <div class="accordion" id="accordionCaseDetails">
              <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop">
	                <div class="accordion-item">
	                 <h2 class="accordion-header" id="parties">
		                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="true" aria-controls="collapse1">
	            			Parties
		                </button>
	                 </h2>
	                  <div id="collapse1" class="accordion-collapse collapse show" aria-labelledby="parties" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                      <div class="row ">
	                      	<div class="col-sm-12">
	                      		<p>Plaintiffs</p>
	                      		<ol>
			                      	<d:forEach items="${cases.plaintiffs}" var="plaintiffs" varStatus="appfiles_loop">
			                      		<li>${plaintiffs.plaintiffs_name}</li>
			                      	</d:forEach>
	                      		</ol>
	                      		<p>Defendants</p>
	                      		<ol>
			                      	<d:forEach items="${cases.defendants}" var="defendants" varStatus="appfiles_loop">
			                      		<li>${defendants.defendants_name}</li>
			                      	</d:forEach>
	                      		</ol>
	                       </div>
	                       
	                      </div>
	                    </div>
	                  </div>
	                </div>
                <div class="accordion-item">
	                  <h2 class="accordion-header" id="reliefs">
	                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2" aria-expanded="false" aria-controls="collapse2">
	                      Reliefs / Summary
	                    </button>
	                  </h2>
	                  <div id="collapse2" class="accordion-collapse collapse" aria-labelledby="reliefs" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	<div class="row mb-4">
	                    		<div class="col-md-12">
			                    	<label>Relief</label>
			                    	<textarea rows="" cols="" class="form-control">${cases.releifs}</textarea>
		                    	</div>
	                    	</div>
	                    	<div class="row mb-4">
	                    		<div class="col-md-12">
			                    	<label>Summary</label>
			                    	<textarea rows="" cols="" class="form-control">${cases.summary}</textarea>
		                    	</div>
	                    	</div>
	                    	
	                    </div>
	                  </div>
	                </div>
                
                </c:forEach>
	                 <div class="accordion-item">
		                  <h2 class="accordion-header" id="documents">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse3" aria-expanded="false" aria-controls="collapse3">
		                       Documents
		                    </button>
		                  </h2>
	                  <div id="collapse3" class="accordion-collapse collapse" aria-labelledby="documents" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	<table class="table-responsive" id="attachments">
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
              
	                 <div class="accordion-item">
		                  <h2 class="accordion-header" id="related_motions">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse4" aria-expanded="false" aria-controls="collapse4">
		                      Related Writ/Application/Motion
		                    </button>
		                  </h2>
	                  <div id="collapse4" class="accordion-collapse collapse" aria-labelledby="related_motions" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    dfdg
	                    </div>
	                  </div>
	                </div>
	                 <div class="accordion-item">
		                  <h2 class="accordion-header" id="notes">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse5" aria-expanded="false" aria-controls="collapse5">
		                      Notes
		                    </button>
		                  </h2>
	                  <div id="collapse5" class="accordion-collapse collapse" aria-labelledby="notes" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    dfdg
	                    </div>
	                  </div>
	                </div>
                
			</div> <!-- Accordion -->
           </div><!-- col6 -->

 
	</section>
 
 	</div>
<!-- End Page Content -->

 <!-- Attachment Modal -->
  <div class="modal fade" id="attachmentModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Attach Document</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="letter_upload" method="post" enctype="multipart/form-data">
        
        <div class="modal-body" style="font-size: small;">
         
          <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Suit Number:</label>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="a_suit_number" name="a_suit_number" readonly required>
            </div>
		  </div>
		  <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Type of Document:</label>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="type_of_document" name="type_of_document" readonly required>
            </div>
		  </div>
		   <div class="row mb-3">
            <label for="inputNumber" class="col-sm-4 col-form-label">Select Document:</label>
            <div class="col-sm-8">
              <input class="form-control" type="file" id="file" name="file" accept="application/pdf" required>
            </div>
          </div>

        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Upload</button>
        </div>
       </form>
      </div>
    </div>
  </div>
  
  <!-- Notes Modal  -->
   <!-- Attachment Modal -->
  <div class="modal fade" id="notesModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Make Note</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="case_note" method="post" enctype="multipart/form-data">
        
        <div class="modal-body" style="font-size: small;">
         
          <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Suit Number:</label>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="n_suit_number" name="n_suit_number" readonly required>
            </div>
		  </div>
		  	<label for="inputNumber" class="col-sm-4 col-form-label">Subject</label>
		  <div class="row mb-3">
			<div class="col-sm-12">
              <input class="form-control" type="text" id="subject" name="subject"  required>
            </div>
		  </div>
		  <label for="inputNumber" class="col-sm-4 col-form-label">Notes</label>
		   <div class="row mb-3">
            <div class="col-sm-12">
              <textarea class="form-control"  id="notes" name="notes" required></textarea>
            </div>
          </div>
			<input type="text" name="created_by" id="created_by" value="${sessionScope.userid}" hidden>
        </div>
        <div class="modal-footer">
          <button type="submit" id="save_note" class="btn btn-primary">Save</button>
        </div>
       </form>
      </div>
    </div>
  </div>
  
  <!-- Notes Modal  -->
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

<script type="text/javascript" src="legal/includes/pages_script/case_work.js"></script>
<script src="https://mozilla.github.io/pdf.js/build/pdf.js"></script>
