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
 <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop"> 
    <div class="pagetitle">
      <h4>Case Details</h4>
      <div class=" ">
		                   
			         <nav>
		                <ol class="breadcrumb">
		                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
		         
		                  <li class="breadcrumb-item active">Case Details</li>
		                  <button  class="btn btn-danger float-right" 
				                    style="position:absolute; right:50px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;"
				                    onclick="history.back()">
				      				Go Back
				      			  </button>
		                  
		                </ol>
	               </nav>
                    
		                    
		</div>	
    </div>  

    <section class="section">
      <div class="row">
  
        <div class="col-lg-9">

          <div class="card">
            <div class="card-body">
             
              <div class="card-header bg-dark text-white">
				  <h5 class="card-title">Suit No:<strong> ${cases.suit_number} </strong> - [<span class="text-danger me-2 ms-2">${cases.nature_of_case_description}</span>]</h5>		
			 </div>
				<input type="text" class="form-control" name="suit_number" id="suit_number" value="${cases.suit_number}" hidden>
				<input type="text" class="form-control" name="case_id" id="case_id" value="${cases.id}" hidden>
              <!-- Accordion without outline borders -->
              
              <div class="accordion" id="accordionCaseDetails">
               <div class="accordion-item">
	                 <h2 class="accordion-header" id="parties">
		                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse8" aria-expanded="true" aria-controls="collapse1">
	            			Remarks
		                </button>
	                 </h2>
	                  <div id="collapse8" class="accordion-collapse collapse" aria-labelledby="parties" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                     <%--  <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop"> --%>
	                    	<div class="row mb-4">
	                    		<div class="col-md-12">
	                    			<input class="form-control" name="request_type" value="update_releifs_and_summary" readonly="readonly" hidden="" />
						              <input class="form-control" name="case_id" value="${cases.id}" readonly="readonly" hidden="" />
									
			                    	<label>Note</label>
			                    	<textarea rows="" cols="" readonly class="form-control">${cases.assigned_reasons}</textarea>
		                    	</div>
	                    	</div>
						  	<%-- </c:forEach> --%>
	                    </div>
	                  </div>
	                </div>
                <div class="accordion-item">
                
	                   <h2 class="accordion-header" id="parties">
		                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="true" aria-controls="collapse1">
	            			Parties
		                </button>
	                 </h2>
                 
                  <div id="collapse1" class="accordion-collapse collapse" aria-labelledby="parties" data-bs-parent="#accordionCaseDetails" >
                    <div class="accordion-body">
	              <div class="card">
	                <div class="card-body">
	                	 
	                  <div class="row mt-4">
							  <table class="table table-striped" id="parties_tbl"  width="100%" cellspacing="0">
								  <thead>
								    <tr>
								      <th scope="col">Party Type</th>
								      <th scope="col">Party Name</th>
								      <th scope="col">Party's Lawyer</th>
								      <th scope="col">Lawyer's Tel</th>
								      <th scope="col">Lawyer's Add</th>
								      <th scope="col">Lawyer's Chambers</th>
								    </tr>
								  </thead>
								  <tbody>
								   <d:forEach items="${cases.parties}" var="parties"  varStatus="appfiles_loop"> 
								   	 <tr>
								   		<td>${parties.party_type}</td>
								   		<td>${parties.party_name}</td>
								   		<td>${parties.party_lawyer}</td>
								   		<td>${parties.lawyer_tel}</td>
								   		<td>${parties.lawyer_address}</td>
								   		<td>${parties.lawyer_chamber}</td>
								   	 </tr>
								   </d:forEach>
								  </tbody>
								</table>
               			</div>
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
	           
                  <div id="collapse2" class="accordion-collapse collapse" aria-labelledby="reliefs" data-bs-parent="#accordionCaseDetails" >
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
                 <div class="accordion-item">
                  
	                  <h2 class="accordion-header" id="flush-headingThree">
	                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse3" aria-expanded="false" aria-controls="collapse3">
	                      Documents
	                    </button>
	                  </h2>
	              
                  <div id="collapse3" class="accordion-collapse collapse" >
                    <div class="accordion-body">
                    	<div class="table-responsive">
		                    	<table class="table table-striped" id="attachments_"  width="100%" cellspacing="0">
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
                
                <div class="accordion-item">
		                  <h2 class="accordion-header" id="notes">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse5" aria-expanded="false" aria-controls="collapse5">
		                      Notes
		                    </button>
		                  </h2>
	                  <div id="collapse5" class="accordion-collapse collapse" aria-labelledby="notes" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	<div class="table-responsive">
		                    	<table class="table table-striped" id="notes_table_2"  width="100%" cellspacing="0">
						 		 	<thead>
						 				<tr>
						 					<th>Subject</th><th>Notes</th>
						 				</tr>
						 			</thead>
						 			<tbody>
						 		  	</tbody>    
		 		  				</table>
	 		  				</div>
	 		  				
	                    </div>
	                  </div>
	                </div>
	                
	                <div class="accordion-item">
		                  <h2 class="accordion-header" id="notes">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse6" aria-expanded="false" aria-controls="collapse5">
							 Records Info Requests
		                    </button>
		                  </h2>
	                  <div id="collapse6" class="accordion-collapse collapse" aria-labelledby="notes" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	<div class="table-responsive">
				                    	<table class="table table-striped" id="requested_info"  width="100%" cellspacing="0">
								 		 	<thead>
								 				<tr>
								 					<th>Subject</th><th>Description</th><th>Deadline</th><th>Status</th><th>Requested Date</th>
								 				</tr>
								 			</thead>
								 			<tbody>
								 		  	</tbody>    
				 		  				</table>
				 		  			</div>
	                    </div>
	                  </div>
	                </div>
	                
	                <div class="accordion-item">
		                  <h2 class="accordion-header" id="notes">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse7" aria-expanded="false" aria-controls="collapse5">
		                      Records Information
		                    </button>
		                  </h2>
	                  <div id="collapse7" class="accordion-collapse collapse" aria-labelledby="notes" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	<div class="table-responsive">
				                    	<table class="table table-striped" id="provided_docs"  width="100%" cellspacing="0">
								 		 	<thead>
								 				<tr>
								 					<th>Info. Provided</th>
								 					<!-- <th>Attachment</th> -->
								 					<th>Division</th><th>Provided By</th><th>Date</th><th>Action</th>
								 				</tr>
								 			</thead>
								 			<tbody>
								 		  	</tbody>    
				 		  				</table>
				 		  			</div>
	 		  				
	                    </div>
	                  </div>
	                </div>
	                
	                
	                <div class="accordion-item">
		                  <h2 class="accordion-header" id="notes">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse9" aria-expanded="false" aria-controls="collapse5">
		                      Minutes
		                    </button>
		                  </h2>
	                  <div id="collapse9" class="accordion-collapse collapse" aria-labelledby="notes" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	<div class="table-responsive">
				                    	<table style="width:100%" class="table table-striped"  id="minutes_tbl"  width="100%" cellspacing="0">
								 		 	<thead>
								 				<tr>
								 					<th style="width:70%">Note</th>
								 					<th style="width:15%">Minuted By</th>
								 					<th style="width:15%">Date</th>
								 					<!-- <th>Action</th> -->
								 				</tr>
								 			</thead>
								 			<tbody>
								 			<%--  <c:forEach items="${minute_detail}" var="minutes"  varStatus="appm_loop"> 
											   <d:forEach items="${minutes.data}" var="mdata"  varStatus="appd_loop"> 
											   	 <tr>
											   		<td>${mdata.minutes}</td>
											   		<td>${mdata.added_by_name}</td>
											   		<td>${mdata.date_created}</td>
											   		<td></td>
											   	 </tr>
											   </d:forEach>
								 			</c:forEach> --%>
											  </tbody>   
				 		  				</table>
				 		  			</div>
	 		  				<div class="d-flex justify-content-end mt-2">
		                       <button type="button" class="btn btn-success btn-sm" id="make_minute">
						          <span class="fas fa-edit"></span>Add New
						        </button>
						  	</div>
	                    </div>
	                  </div>
	                </div>
               <!--  <div class="accordion-item">
                  
	                  <h2 class="accordion-header" id="flush-headingFour">
	                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse4" aria-expanded="false" aria-controls="collapse4">
	                      Related Writ/Application/Motion
	                    </button>
	                  </h2>
	              
                  <div id="collapse4" class="accordion-collapse collapse" >
                    <div class="accordion-body">
                    
                    </div>
                  </div>
                </div>
			   -->        

            </div>
     	   <!-- End Accordion without outline borders  this is just a test that i'm just doing-->

        </div>
      </div>

    </div>
    <div class="col-lg-3">

          <!-- Recent Activity -->
          <div class="card">
          
            <div class="card-body">
              <h5 class="card-title">Upcoming <span>| Timeline </span></h5>
				<ul class="timeline-3" id="upcoming">
			       
			       
			      </ul>
            </div>
          </div><!-- End Recent Activity -->

         <!-- Recent Activity -->
          <div class="card mt-4">
            <div class="filter">
              <a class="icon" href="#" ><i class="bi bi-three-dots"></i></a>
            </div>

            <div class="card-body">
              <h5 class="card-title">Past <span>| Timeline</span></h5>
				<ul class="timeline-3" id="past">
			       
			      </ul>
           

            </div>
          </div><!-- End Recent Activity -->
         


        </div>
  </div>
</section>

</c:forEach>
</div>
<!-- End Page Content -->

<!-- Attachment Modal  -->
  <div class="modal fade" id="elisDocumentPreview" tabindex="-1" role="dialog"
	aria-labelledby="elisDocumentPreview" aria-hidden="true">
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
												
												<iframe src=""  id="elisdovumentpreviewblobfilexx" width="100%" height="600"></iframe>
							
				</div>

			</div>
			 	<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div>

<div class="modal fade" id="elisDocumentPreviewx" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Suit Number: <span class="text-danger" id="p_suit_number"></span></h5>
				<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
				<div class="card card-body mb-4">
				<b>Notes:</b>
					 <span class="" id="n_notes"></span>
				</div>
												
				<iframe src=""  id="elisdovumentpreviewblobfile" width="100%" height="600"></iframe>
							
				</div>

			</div>
			 	<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div>

<div class="modal fade" id="viewTimelineDetails" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Updated Info.</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="update_status_form_with_note" method="post" >
        
        <div class="modal-body" style="font-size: small;">
         
          <div class="row mb-3">
			<label for="inputNumber" class="col-sm-3 col-form-label">Suit Number:</label>
			<div class="col-sm-9">
              <input class="form-control" type="text" id="up_suit_number" name="up_suit_number" value='<c:out value="${case_detail[0].suit_number}"></c:out>' readonly required>
            </div>
		  </div>
		  
		  <div class="row mb-3" hidden="">
			<label for="inputNumber" class="col-sm-3 col-form-label">Case ID:</label>
			<div class="col-sm-9">
              <input class="form-control" type="text" id="up_case_id" name="up_case_id" readonly required>
            </div>
		  </div>
		  
		  <div class="row mb-3">
			<label for="inputNumber" class="col-sm-3 col-form-label">Note:</label>
			<div class="col-sm-9">
               <textarea class="form-control" rows="5" id="up_notes" readonly></textarea>
            </div>
		  </div>
		   <input type="text" name="updated_by" value="${sessionScope.userid}" hidden />

        </div>
        <%-- <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Update</button>
        </div> --%>
       </form>
      </div>
    </div>
  </div>
  
   <div class="modal fade" id="minuteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Add Minute</h5>
           <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="case_note" method="post" enctype="multipart/form-data">
        
        <div class="modal-body" style="font-size: small;">
         
          <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Suit Number:</label>
			<div class="col-sm-12">
              <input class="form-control" type="text" id="m_suit_number" name="m_suit_number" value='<c:out value="${case_detail[0].suit_number}"></c:out>' readonly required>
            </div>
		  </div>
		  <%-- <div class="row mb-3">
		  	<label for="inputNumber" class="col-sm-4 col-form-label">Subject</label>
		  
			<div class="col-sm-12">
              <input class="form-control" type="text" id="subject" name="subject"  required>
            </div>
		  </div> --%>
		  <div class="row mb-3">
		  <label for="inputNumber" class="col-sm-4 col-form-label">Notes</label>
		   
            <div class="col-sm-12">
              <textarea class="form-control" rows="5"  id="minutes" name="minutes" required></textarea>
            </div>
          </div>
          <input class="form-control" type="text" id="m_case_id" name="m_case_id" value="${case_detail[0].id}" hidden >
			<input type="text" name="created_by" id="created_by" value="${sessionScope.fullname}" hidden>
			<input type="text" name="created_by_id" id="created_by_id" value="${sessionScope.userid}" hidden>
        </div>
        <div class="modal-footer">
          <button type="submit" id="save_minute" class="btn btn-primary">Submit</button>
        </div>
       </form>
      </div>
    </div>
  </div>

 
<jsp:include page="../legal/includes/footer.jsp"></jsp:include>
 <script src="legal/includes/bootstrap/js/bootstrap.bundle.js"></script>
 <script type="text/javascript" src="legal/includes/pages_script/case_work.js"></script>
 
 <script>

  document.addEventListener('DOMContentLoaded', function() {
	  
	  let suit_number =  $('#suit_number').val();
	  let case_id =  $('#case_id').val();
	  
	  let dataSet =[];
	  let num = "";
		
		$.ajax({
			type:"POST",
			url:"case_details_serv",
			data:{"request_type":"load_minutes_on_case",
				  "suit_number":suit_number,
				  "case_id":case_id,
			},
			success:function(response){
				console.log(response);
				let json_result = JSON.parse(response);
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
				                let html=[];
				                //num = (+num + 1);
				                let minutes= json_result.data[i].minutes;
				                let added_by_name= json_result.data[i].added_by_name;
				               	let date_created=json_result.data[i].date_created.split('.')[0];;
				               	let action="";
				                
				               html.push("<span style='width: 70%'>"+minutes+"</span>");
				               html.push(added_by_name);
				               html.push(date_created); 
				               //html.push(action); 
			
				                dataSet.push(html);
		            		}

						}
							
						$('#minutes_tbl').DataTable().clear().destroy();
							
						$('#minutes_tbl').DataTable({ 
							data: dataSet
						}).draw();
						
						//document.getElementById("minutes_tbl").style.width = "1000px";
							
					}

				}
		})
	  
	  $("#make_minute").on('click',function(e){
		  $("#minuteModal").modal('show');
	  })
	  
	  $("#save_minute").on('click',function(e){
		  e.preventDefault();
		  
			let suit_number =  $('#m_suit_number').val();
			let case_id =  $('#m_case_id').val();
			let created_by =  $('#created_by').val();
			let created_by_id =  $('#created_by_id').val();
			let minutes =  $('#minutes').val();
			
			if(!minutes) {
				toastr["error"]("Please the required field is empty", "Error");
			}
			else {
				$.ajax({
					type:"POST",
					url:"case_work_serv",
					data:{"request_type":"add_minutes_on_case",
						  "suit_number":suit_number,
						  "created_by_id":created_by_id,
						  "minutes":minutes,
						  "created_by":created_by,
						  "case_id":case_id,
					},
					success:function(response){
						console.log(response);
						
						let json_results=JSON.parse(response);
						
						if(json_results.success){
							 toastr["success"]("Munite saved successfully", "Success");
							 
							  setInterval(function(){
			                       location.reload();
			                 },1000); 
			                 
			                 $("#minuteModal").modal('hide');
		                } 
		              else {
		                        toastr["error"]("Error occurred saving munite", "Error");
		                 }

		                    $("#minuteModal").find('form').trigger('reset');
		                    
		                    $("#make_minute").prop('disabled', false);
						}
				})
			}
			
	  })
  
	  var table_docs = $('#attachments_');
		table_docs.find("tbody tr").remove();

		let c_suit_number=$('input[name="suit_number"]').val();
		
		
		$.ajax({
			url:"load_scanned_documents",
			method:"POST",
			data:{
					"request_type":"load_scanned_document",
					"suit_number":c_suit_number
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
		
		
		$('#attachments_')
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
											'#elisdovumentpreviewblobfilexx')
											.attr('src',
													objectUrl);

									$(
											'#fedocumentPreviewblobfilexx')
											.attr('src',
													objectUrl);

									// $('#NotoncaseafterPaymentModalonCase').modal('hide');

								}
							});

				});
		
		
	})

			
	

 </script> 