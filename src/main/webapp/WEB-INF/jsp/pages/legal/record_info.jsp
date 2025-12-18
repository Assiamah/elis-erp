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
<%-- <c:choose>
<c:when test="${(stage == '1')}"> --%>
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
  
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
             
              <div class="card-header bg-dark text-white">
				  <h5 class="card-title">Suit No:<strong> ${cases.suit_number} </strong></h5>		
			 </div>
				
            <div class="card mt-4">
	               
	               <form method="post" action="record_info"  enctype="multipart/form-data">
	                <div class="card-body">		                
			                <div class="row mt-4 mb-4">
		                		<div class="col-md-12">
		                			<div id="alert col-md-12"></div>
		                		
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Suit Number<span class="text-danger">*</span> :</span>
		                				</div>
		                				<div class="col-md-6">
		                					<input class="form-control" name="suit_number" id="suit_number"  value="${cases.suit_number}" required readonly />
		                				</div>
		                			</div>
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Nature of case :</span>
		                				</div>
		                				<div class="col-md-6">
		                					<input class="form-control" name="nature_of_case_desc" id="nature_of_case_desc"  value="${cases.nature_of_case_description}" required readonly />
		                				</div>
		                			</div>
		                			<div class="row mt-4 mb-4">
		                				<div class="col-md-2">
		                					<span>Court:</span>
		                				</div>
		                				<div class="col-md-6">
		                					<input class="form-control" name="court_name" id="court_name"  value="${cases.court_name}" required readonly />
		                				</div>
		                			</div>
		                			<hr />
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Division<span class="text-danger">*</span>:</span>
		                				</div>
		                				<div class="col-md-6">
		                					<select class="form-control" aria-label="Default select example" name="division" id="division" required>
								                <option value="" disabled selected>-- select --</option>
								                <option value="PVLMD">PVLMD</option>
												<option value="LRD">LRD</option>
												<option value="LVD">LVD</option>	
												<option value="SMD">SMD</option>	
												<option value="CORPORATE">CORPORATE</option>		
								              </select>
		                				</div>
		                			</div>
		                			
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Region<span class="text-danger">*</span>:</span>
		                				</div>
		                				<div class="col-md-6">
		                					<select class="form-control" aria-label="Default select example" name="region" id="region" required>
								                <option disabled selected>-- select --</option>
								                 <option value="11">Greater Accra</option>
													<option value="10">Western</option>
													<option value="9">Volta</option>	
													<option value="4">Eastern</option>	
													<option value="1">Ashanti</option>	
													<option value="3">Central</option>	
													<option value="6">Northern</option>	
													<option value="7">Upper East</option>	
													<option value="8">Upper West</option>	
													<option value="11">Tema</option>
													<option value="22">Oti</option>	
													<option value="23">Bono East</option>	
													<option value="24">Ahafo</option>	
													<option value="2">Bono</option>	
													<option value="5">North East </option>	
													<option value="26">Savannah</option>
													<option value="21">Western North</option>
								              </select>
		                				</div>
		                			</div>
		                			
		                		
		                			
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Unit <span class="text-danger">*</span>:</span>
		                				</div>
		                				<div class="col-md-6">
		                					   <input class="form-control" id="unit"  name="unit" type="text" autocomplete="off" 
		                                 list="listofunits" class="autocomplat"  placeholder="Enter Username" required  onmousedown="value = '';" >
		        <datalist id="listofunits"></datalist>
		                				</div>
		                			</div>
		                			
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Subject <span class="text-danger">*</span>:</span>
		                				</div>
		                				<div class="col-md-6">
											<textarea  class="form-control " name="subject" id="subject" required></textarea>
		                				</div>
		                			</div>
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Description <span class="text-danger">*</span>:</span>
		                				</div>
		                				<div class="col-md-6">
											<textarea  class="form-control " name="description" id="description" rows="5" required></textarea>
		                				</div>
		                			</div>
		                			
		                			
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Deadline<span class="text-danger">*</span>:</span>
		                				</div>
		                				<div class="col-md-6">
		                					<input type="date" class="form-control " name="deadline" id="deadline" required />
		                				</div>
		                			</div>
		                			<div class="row mt-4">
		                				<div class="col-md-4">
		                					<span>Would a document be attached ?:</span>
		                					<input type="checkbox" class="form-check-input ml-4" name="attach_file" id="attach_file"  />
		                				</div>
		                				
		                			</div>
		                			
		                			<div class="row mt-4" id="attach_doc">
							            <label for="inputNumber" class="col-md-2 col-form-label">Select Document:</label>
							            <div class="col-md-6">
							              <input class="form-control" type="file" id="file" name="file" accept="application/pdf" >
							            </div>
						
									 </div>
		                			<div class="row mt-4">
		                				
		                				<div class="col-md-6">
		                					
		                					<br>
		                					<input type="text" name="request_type" value="request_record_info" hidden />
									        <input type="text" name="request_by" value="${sessionScope.userid}" hidden />
									        <input type="text" name="case_id" value="${cases.id}" hidden />
									        <input type="text" name="nature_of_case" value="${cases.nature_of_case}" hidden />
									        <br>
		                					<button type="submit" id="save_case" class="btn btn-success"><i class="fas fa-save"></i>Submit</button>
		                				</div>
		                			</div>
		                		</div>
		                	</div>
	                </div>
	               </form>
	              </div>

        </div>
      </div>

    </div>
  </div>
</section>

</c:forEach>
<%-- </c:when>
<c:when test="${(stage == '2')}">
    <div class="pagetitle">
      <h4>Case Details</h4>
      <div class=" ">
		                   
			         <nav>
		                <ol class="breadcrumb">
		                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
		         		  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/legal_case_management">Legal Case Management</a></li>  
		                  <li class="breadcrumb-item active">Case Details</li>
		                  <button  class="btn btn-danger float-right" 
				                    style="position:absolute; right:50px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;"
				                    >
				                    <a href="${pageContext.request.contextPath}/legal_case_management">
				      				Go Back
				      				</a>
				      			  </button>
		                  
		                </ol>
	               </nav>
                    
		                    
		</div>	
    </div>  

    <section class="section">
      <div class="row">
  
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
             
              <div class="card-header bg-dark text-white">
				  <h5 class="card-title">Suit No:<strong> ${suit_number} </strong></h5>		
			 </div>
				
            <div class="card mt-4">
            		
            		<h1>Request for Record Information Successful</h1>
            		<a href="${pageContext.request.contextPath}/legal_case_management">Go Back</a>
			</div>

        </div>
      </div>

    </div>
  </div>
</section>

</c:when>
<c:otherwise>
<h1>Successful</h1>
</c:otherwise>
</c:choose> --%>

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
												
												<iframe src=""  id="elisdovumentpreviewblobfile" width="100%" height="600"></iframe>
							
				</div>

			</div>
			 	<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				
			</div>
			 
		</div>
	</div>
</div>

 
<jsp:include page="../legal/includes/footer.jsp"></jsp:include>
 <script src="legal/includes/bootstrap/js/bootstrap.bundle.js"></script>
 
 ${param.success == "true" ? "
 
 <script> 
toastr['success']('Record info has been requested successfully', 'Success');
</script>
 ":""}
 
 <script>

  document.addEventListener('DOMContentLoaded', function() {
   
	  let region=document.getElementById("region");
	  let division=document.getElementById("division");

	//   division.addEventListener("change",function () {
		
		
	//   })

	// console.log('fegrhtjgrfgfh')

	  $('#division').on('change', function() {
			$('#region').val(`<option disabled>--select--</option>`);
	  })
	 
	  
	  region.addEventListener("change",function () {
			 let x=region.value;
			 let division=$('#division').find(":selected").val();
			
			 if(division == ""){
				 toastr["warning"]("Select Division", "LEGAL");
				 $('#division').focus();
			 }
			 else{
				 
				 $.ajax({
						url:"Case_Management_Serv",
						method:"POST",
						data:{
								request_type:"get_lc_list_of_units"
						},
						success:function(response){
							console.log(response);
							let json_p = JSON.parse(response);
							var datalist = $("#listofunits");
							datalist.empty();
							
							$(json_p.data).each(
											function() {
														
															if(this.unit_division ==division){
															datalist
																	.append('<option data-name="'
																			+ this.unit_name
																			+ '" data-id="'
																			+ this.unit_id
																			+ '" value="'
																			+ this.unit_name
																			+ '" ></option>');
															}
											
													});
						}
							
						})
			 }
	  })
	  
		
			
			
			 $("#cases_upload").on('submit',function(e){
					e.preventDefault();
					
					$("#upload_btn").prop('disabled', true);
					
					let suit_number=$('input[name="suit_number"]').val();
					let type_of_document="request_info";
					
					let formdata = new FormData();
					formdata.append("request_type","cases_upload");
					formdata.append("suit_number",suit_number);
					formdata.append("type_of_document",type_of_document);
					formdata.append("scan_type","full");
					jQuery.each(jQuery('#file')[0].files,function(i,file){
						formdata.append('file',file);
					})
					//formdata.append("file",fileinput.files[0]);
					
					$.ajax({
						method:"POST",
						enctype : 'multipart/form-data',
						url : "cases_upload",
						data : formdata,
						processData : false,
						contentType : false,
						cache : false,
						success:function(response){
							console.log(response);
						 let json_result = JSON.parse(response);

						 if(json_result.success){
							 toastr["success"]("Uploaded successfully", "File");
			                } 
			              else {
			                        toastr["error"]("Error occurred uploading file", "File");
			                 }

			                    $("#attachmentModal").find('form').trigger('reset');
			                    $("#attachmentModal").modal('hide');
			                    $("#upload_btn").prop('disabled', false);
			                    
			                     setTimeout(function(){
			                        location.reload();
			                    },1000); 
			                  
						}
						
					})
				})
			    
		
				const checkbox = document.querySelector("input[name=attach_file]");

			  checkbox.addEventListener("change", (e) => {
			    if (e.target.checked) {
			      document.getElementById("attach_doc").style.display="block";
			    } else {
			      document.getElementById("attach_doc").style.display="none";
			    }
			  });
		
		
	})

			
	

 </script> 