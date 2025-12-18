<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


   <jsp:include page="../client_application/_application_process_header.jsp"></jsp:include>
					          
   <h3 class="border-bottom border-gray pb-2">Update Documents</h3>
   
 	  
   
    <div id="accordion">
        <div class="card">
          <div class="card-header" id="headingOne">
            <h5 class="mb-0">
              <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                Documents on Application
              </button>
            </h5>
          </div>
      
          <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
            <div class="card-body">
                <button type="button" class="btn btn-success" id="btn_load_scanned_documents_" data-placement="top"  title="Load Docs">
                    <i class="fas fa-eye"></i>
                </button>
                
                <button type="button" class="btn btn-primary" id="" data-toggle="modal" data-target="#fileUploadModal" title="Add Documents">
                    <i class="fa fa-plus-circle"></i>
                </button> 
                
                
            <div  class="table-responsive mt-2">
               <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable_" width="100%" class="display" cellspacing="0">
               
                  <thead>
                    <tr>
    
                     <th>Document Name</th>
                     <th>Document Type</th>
                   </tr>
                  </thead>
                  
                    <tbody>				
                    <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
                    <tr>
                        <td>${casescanneddocuments_row.document_name}</td>
                        <td>${casescanneddocuments_row.document_type}</td>
                            <td>
                                <form action="registration_application_progress_details" method="post">
                                    <input type="hidden" name="document_path" id="document_path" value="${casescanneddocuments_row.document_file}">
                                        <button type="submit" name="save" class="btn btn-info btn-icon-split" >
                                        <span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>
                                        </button>
                                </form>
                            </td>

                        </tr>
                        </c:forEach>
                      </tbody>
        
                
                </table>
              </div>
            </div>
          </div>
        </div>
        <div class="card">
          <div class="card-header" id="headingTwo">
            <h5 class="mb-0">
              <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                Public Documents
              </button>
            </h5>
          </div>
          <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
            <div class="card-body">
                <button type="button" class="btn btn-success" id="btn_load_scanned_documents_public_" data-placement="top"  title="Load Docs">
                    <i class="fas fa-eye"></i>
                </button>
                
                <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-toggle="modal" data-target="#publicFileUploadModal" title="Add Documents">
                    <i class="fa fa-plus-circle"></i>
                </button> 
                
                
            <div  class="table-responsive mt-2">
               <table class="table table-bordered  table-hover table-sm" id="lc_public_documents_dataTable_" width="100%" class="display" cellspacing="0">
               
                  <thead>
                    <tr>
    
                     <th>Document Name</th>
                     <th>Document Type</th>
                   </tr>
                  </thead>
                  
                    <tbody>				
                    <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
                    <tr>
                        <td>${casescanneddocuments_row.document_name}</td>
                        <td>${casescanneddocuments_row.document_type}</td>
                            <td>
                                <form action="registration_application_progress_details" method="post">
                                    <input type="hidden" name="document_path" id="document_path" value="${casescanneddocuments_row.document_file}">
                                        <button type="submit" name="save" class="btn btn-info btn-icon-split" >
                                        <span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>
                                        </button>
                                </form>
                            </td>

                        </tr>
                        </c:forEach>
                      </tbody>
        
                
                </table>
              </div>
            </div>
          </div>
        </div>
        <!-- <div class="card">
          <div class="card-header" id="headingThree">
            <h5 class="mb-0">
              <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                Collapsible Group Item #3
              </button>
            </h5>
          </div>
          <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
            <div class="card-body">
              Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
            </div>
          </div>
        </div> -->
      </div>
  

<input type="hidden" id="ars_job_purpose" class="form-control" value="${job_purpose}">


<div class="mt-5">
	<button class="btn btn-success btn-icon-split float-left "  data-job_number="${job_number}" id="btnApproveJob">
		<span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Approve Request</span>
	</button>

	<button class="btn btn-danger btn-icon-split float-left ml-3"  data-job_number="${job_number}" id="btnQueryJob">
		<span class="icon text-white-50"> <i class="fas fa-times fa-2x"></i></span><span class="text">Query Request</span>
	</button>
 </div>
 
 

          
            
		<jsp:include page="../client_application/_application_process_footer_ar.jsp"></jsp:include>
  
  
