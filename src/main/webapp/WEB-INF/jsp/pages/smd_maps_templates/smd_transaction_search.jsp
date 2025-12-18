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
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

  <jsp:include page="../includes/_header.jsp"></jsp:include>
  

  <% 


	  
%>

  
  


    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">SMD Transaction Template</a>
        </li>
        <li class="breadcrumb-item active">Search for Transaction</li>
      </ol>
      
      
      <!-- 	<button type="button" class="btn btn-success btn-sm" id="btn_open_smd_transaction_short"
									
								>Add New Short Transaction</button>
       -->
           
          <div class="row">
								                                                        
			            <div class="col-md-2">
			                <div class="form-group">
			                  
			        	  <input class="form-control" id="smd_search_by_text"  name="smd_search_by_text"  type="text"  placeholder="Search by Ref Number" required >
						   
			                </div>
			            </div>
			
			          
			          <!-- <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="smd_btn_search_by_certificate_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-retweet"></i> </button>
			            
			                </div>
			            </div> -->
			            
			            <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="smd_btn_search_by_transaction_reference_number" data-placement="top" data-toggle="tooltip" title="Search"><i class="fa fa-search"></i> </button>
			            
			                </div>
			            </div>
			            
			
			        </div>
     
     
         <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header bg-dark text-white">
              <i class="fa fa-bar-chart"></i>Transaction List
              	<span class="col-md-3 float-right ">
              <button class="btn btn-success btn-icon-split float-right "  id="btnViewBatchlist">
					<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">ViewS</span>
				</button></span>
              
              </div>
              
            <div class="card-body">
            
         
            
             <!--  Here is where the fee list comes -->
             
          <div class="table w-auto small">
									<table class="table table-bordered"
										id="smd_transaction_dataTable" width="100%" cellspacing="0"
									>

										<thead>
											<tr>

												<th>Name</th>
												<th>Grantor</th>
												<th>Multiple Claim</th>
												<th>Remarks</th>
												<th>Details</th>
											</tr>
										</thead>

										<tbody>

										</tbody>
									

									</table>
								</div>
             
              <!--  End Of Table -->
            </div>
            
          </div>
          
     
     
    
       
    
   
        
      </div>
     </div>
     
    
    

     
     
     

 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
