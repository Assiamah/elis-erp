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
				                  <li class="breadcrumb-item active">Add New Case</li>
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div>
   
   
	<section class="section dashboard">
	     	<div class="row mb-4">
		      <div class="col-lg-12">
		
		         <div class="card">
		           <div class="card-body">


		             <!-- Horizontal Form -->
		             <form id="further_entry_form">
		             <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop"> 
		               <div class="row mb-3 col-sm-12">
		               	
		               	<input class="form-control" type="text" id="page_suit_number" name="page_suit_number"  value="" >
		                 <label for="" class="col-sm-2 col-form-label">Court<span class="text-danger"> *</span></label>
		                 <div class="col-sm-4">
		                 	<select class="form-control" name="court_id" id="court_id">
		                 		<option value="${cases.court_id}">${cases.court_name}</option>
		                 		<d:forEach items="${courts}" var="court"  varStatus="appfiles_loop"> 
		                 			<option value="${court.id}">${court.court_name} - (${court.city})</option>
		                 		</d:forEach>
		                 	</select>
		                   
		                 </div>
		                 
		                 <label for="reliefs" class="col-sm-2 col-form-label">Region<span class="text-danger"> *</span></label>	 
		                 <div  class="col-sm-4" >
		                 	<input type="text" class="form-control" name="court_region" id="court_region" >	 
		               </div>
		            </div>
					                
	                <div class="row mb-4 col-sm-12">
	               
	                 	<label for="court" class="col-sm-2 col-form-label">City/Town <span class="text-danger"> *</span></label>
	                 	<div class="col-sm-4">
	                   		 <input type="text" class="form-control" name="court_city"  readonly >
	                 	</div>
	                 
	                 	<label for="caseSummary" class="col-sm-2 col-form-label">Suit Number <span class="text-danger"> *</span></label>	 
	                 	<div  class="col-sm-4">
	                   		<input type="text" class="form-control" name="suit_number"  readonly>
	                 	</div>
	               	</div>
	               	<div class="row mb-4 col-sm-12">
	               
	                 	<label for="court" class="col-sm-2 col-form-label">Court Description</label>
	                 	<div class="col-sm-10">
	                   		 <input type="text" class="form-control" name="court_description" readonly >
	                 	</div>
	               	</div>
	                <hr>
	                <h5 class="card-title">Parties </h5>
	                
	                <div class="row mb-3 col-sm-12">
	                  <label class="col-sm-2 col-form-label">Plaintiff(s) / Applicant(s)</label>
	                  <div class="col-sm-8">
		                 <input type="text" class="form-control" name="plaintiff" id="plaintiff">
	                  </div>
	                   <div class="col-sm-2">
	                  	<button class="btn btn-primary pull-right" id="add_plaintiff" ><i class="glyphicon glyphicon-plus"></i>Add Plaintiff</button>
	                  </div>
	                </div>
	                <div class="row mb-3 col-sm-12" id="all_plaintiffs">
	                 
			        </div>
		
	                <div class="row mb-3 col-sm-12">
	                  <label class="col-sm-2 col-form-label">Defendant(s) / Respondent(s)</label>
	                  <div class="col-sm-8">
			             <input type="text" class="form-control" name="defendant" id="defendant">
	                  </div>
		               <div class="col-sm-2">
	                  	<button class="btn btn-primary pull-right" id="add_defendant" ><i class="glyphicon glyphicon-plus"></i>Add Defendant</button>
	                  </div>
	               </div>
	                <div class="row mb-3 col-sm-12" id="all_defendants">
	                   
			        </div>
   
	              <label for="caseId" class="col-sm-1 col-form-label">Reliefs:</label>
	              <div class="row mb-3 col-sm-12">
	               
	                <div class="col-sm-12">
	                  <textarea class="form-control" style="height: 100px" name="reliefs" id="reliefs" >${cases.releifs}</textarea>
	                </div>
	              </div>
	            
	              <div class="row mb-3">
	               <label for="inputText" class="col-sm-2 col-form-label">Nature of Cases<span class="text-danger">*</span>:</label>
	               <div class="col-sm-10">
	                  <select class="form-control" name="nature_of_case" id="nature_of_case">
		                 		<option value="${cases.nature_of_case}">${cases.nature_of_case_description}</option>
		                 		<d:forEach items="${type_of_cases}" var="toc"  varStatus="appfiles_loop"> 
		                 			<option value="${toc.id}">${toc.description}</option>
		                 		</d:forEach>
		                </select>
	               </div>
	              </div>
				  <label for="caseId" class="col-sm-1 col-form-label">Summary:</label>
	              <div class="row mb-3 col-sm-12">
		             <div class="col-sm-12">
		                <textarea class="form-control" name="summary" id="summary" style="height: 100px" >${cases.summary}</textarea>
		             </div>
	              </div>
	              <hr><br>
	               
	              <p class="card-text">Plaintiff Lawyer Details<p>
	                <div class="row mb-3 col-sm-12">
	                
	                   <label for="plaintiffsName" class="col-sm-2 col-form-label"> Name :</label>
	                 <div class="col-sm-4">
	                    <input type="text" class="form-control" name="plaintiff_lawyer_name"  required>
	                 </div>
	             <label for="entryOfAppearance" class="col-sm-2 col-form-label">Telephone:</label>
	             <div class="col-sm-4">
	                 <input type="text" class="form-control"  name="plaintiff_lawyer_tel" >
	           	 </div>
	               </div>
	                  <div class="row mb-3 col-sm-12">
	                   
	                     <label for="plaintiffsName" class="col-sm-2 col-form-label"> Chambers :</label>
	                      <div class="col-sm-4">
	                          <input type="text" class="form-control"  name="plaintiff_lawyer_chambers"  required>
	                     </div>
	                       <label for="entryOfAppearance" class="col-sm-2 col-form-label">Location:</label>
		                 <div class="col-sm-4">
	                          <input type="text" class="form-control"  name="plaintiff_lawyer_location"  required>
		            	 </div>
	                  </div>
					                 
	                  <p class="card-text">Defendants Lawyer Details<p>
	                  <div class="row mb-3 col-sm-12">
	                  
	                     <label for="plaintiffsName" class="col-sm-2 col-form-label"> Name :</label>
	                     <div class="col-sm-4">
	                          <input type="text" class="form-control" name="defendant_lawyer_name"  required >
	                     </div>
	                       <label for="entryOfAppearance" class="col-sm-2 col-form-label">Telephone:</label>
		                 <div class="col-sm-4">
		                     <input type="text" class="form-control" name="defendant_lawyer_tel"  required>
		            	 </div>
	                  </div>
	                  <div class="row mb-3 col-sm-12">
	                   
	                     <label for="plaintiffsName" class="col-sm-2 col-form-label"> Chambers :</label>
	                     <div class="col-sm-4">
	                          <input type="text" class="form-control" name="defendant_lawyer_chambers" required>
	                     </div>
	                       <label for="entryOfAppearance" class="col-sm-2 col-form-label">Location:</label>
		                 <div class="col-sm-4">
		                     <input type="text" class="form-control" name="defendant_lawyer_location" required>
		            	 </div>
	                  </div>
					                 
	                  <hr><br>
	                  <div class="row mb-3">
			            <label for="inputText" class="col-sm-2 col-form-label">Filing Date <span class="text-danger" >*</span>:</label>
			            <div class="col-sm-4">
			              <input type="date" class="form-control" placeholder="dd/mm/yyyy" name="date_of_document"   required>
			            </div>
		            	<label for="inputText" class="col-sm-2 col-form-label">Date Received <span class="text-danger">*</span>:</label>
			            <div class="col-sm-4">
			              <input type="date" class="form-control"  placeholder="dd/mm/yyyy" name="date_received" readonly>
			            </div>
			          </div>
		           
		             <!--  <div class="row mb-3">
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
		          	 </div> -->
		          	 
		          	<input type="text" name="request_type" value="further_entries" hidden>
		          	
		             <div class="text-center">
		              	 <a type="button" href="${pageContext.request.contextPath}/legal_unit" class="btn btn-info">Back </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                 <button type="submit" class="btn btn-primary">Save</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		             </div>
	           
	               </c:forEach> 
	             </form><!-- End Horizontal Form -->
			   </div>
	         </div>
	       </div>
	     </div>
	     
	
	     
     </section>

	</div>
<!-- End Page Content -->




 
<jsp:include page="../legal/includes/footer.jsp"></jsp:include>

<script type="text/javascript" src="legal/includes/pages_script/further_entry.js"></script>  
<script type="text/javascript" >
$(function(){
	
	
</script> 