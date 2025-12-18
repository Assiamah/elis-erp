 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="com.report_class.cls_reports" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
 <jsp:include page="../legal/includes/header.jsp"></jsp:include>
 
   
  <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">LEGAL Report</a>
        </li>
        <li class="breadcrumb-item active">Report User - ${fullname}</li>
         
             
      </ol>

       <div class="row">
  
     <div class="col-lg-6">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           <div class="card-header">
				<h4 class='float-left'>
				<i class="fas fa-database"></i> Report by Nature of Cases</h4>
				
		</div>
            <div class="card-body">

			<div class="accordion" id="accordionExample">
			  <div class="card">
			    
			
			    <div id="collapsedrinksn" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
			      <div class="card-body">
			           <form id="report_by_nature_of_case" method="post" >
			         
					           
			        <div class="form-group">
          	<label for="nature_of_case">Nature of Case</label>
		       <select name="nature_of_case"  id="nature_of_case" class="form-control input-sm" data-style="btn-info" data-live-search="true">
		              <option value="0" selected>All</option>
		             <c:forEach items="${type_of_cases}" var="typeslist"  varStatus="typeslist_loop">	
		            <option value="${typeslist.id}" >${typeslist.description}</option>
		            </c:forEach>
		         </select>
         </div>
       <div class="form-group">
          <label for="court_region">Region</label>
                  <select name="court_region" id="court_region"   class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                  <option value="0">All</option>
		                <option >Greater Accra</option>
						<option >Western</option>
						<option >Volta</option>	
						<option >Eastern</option>	
						<option >Ashanti</option>	
						<option >Central</option>	
						<option >Northern</option>	
						<option >Upper East</option>	
						<option >Upper West</option>	
						<option >Oti</option>	
						<option >Bono East</option>	
						<option >Ahafo</option>	
						<option >Bono</option>	
						<option >North East </option>	
						<option >Savannah</option>
						<option >Western North</option>	
                </select>
          </div>
          
           
           
            <div class="form-group">
       <label >Date From</label>
       <input type="date" name="date_from" id="date_from" min="1000-01-01"   max="3000-12-31" class="form-control">
           </div>
            
           <div class="form-group">
       <label >Date To</label>
       <input type="date" name="date_to" id="date_to" min="1000-01-01"   max="3000-12-31" class="form-control">
           </div>
    
                <button type="submit" class="d-none d-sm-inline-block btn btn-sm btn-info shadow-sm" 
                id="btn_reports_by_nature_of_case" data-placement="top" data-toggle="tooltip" title="Search">
                <i class="fas fa-download fa-sm text-white-50"></i>View Report Result</button>
                  
                  

      
			     </form>
			      </div>
			    </div>
			  </div>
			  

			</div>
			

            </div>
          
          </div>     
      </div>
      
      
      
        <div class="col-lg-6">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           <div class="card-header">
				<h4 class='float-left'>
				<i class="fas fa-table"></i>Report by Courts</h4>
				
		</div>
            <div class="card-body">




			<div class="accordion" id="accordionExample">
			  <div class="card">
			    
			
			    <div id="collapsedrinksn" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
			      <div class="card-body">
			         
			         
					           
			          <div class="form-group">
			          <label for="region">Region</label>
			                  <select name="region" id="region"   class="form-control input-sm" data-style="btn-info"  data-live-search="true">
			                  <option >All</option>
					                <option >Greater Accra</option>
									<option >Western</option>
									<option >Volta</option>	
									<option >Eastern</option>	
									<option >Ashanti</option>	
									<option >Central</option>	
									<option >Northern</option>	
									<option >Upper East</option>	
									<option >Upper West</option>	
									<option >Oti</option>	
									<option >Bono East</option>	
									<option >Ahafo</option>	
									<option >Bono</option>	
									<option >North East </option>	
									<option >Savannah</option>
									<option >Western North</option>	
			                </select>
			          </div>
         			
         			
         			  <div class="form-group">
					       <label >Date From</label>
					       <input type="date" name="court_date_from" id="court_date_from" min="1000-01-01"   max="3000-12-31" class="form-control">
			           </div>
			            
			           <div class="form-group">
					       <label >Date To</label>
					       <input type="date" name="court_date_to" id="court_date_to" min="1000-01-01"   max="3000-12-31" class="form-control">
			           </div>
          
           <!--  
             			<button type="button" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" id="btn_generate_details_based_on_users" data-placement="top" data-toggle="tooltip" title="Search"><i class="fas fa-download fa-sm text-white-50"></i>View Report</button>
                  
             -->     

   
			
			     
			      </div>
			    </div>
			  </div>
			  

			</div>
			

            </div>
          
          </div>
          
         
        
    
   
        
      </div>
      
      
  
      
     </div>
      
      
   
   
    <div class="row">
     
     
     
   
      
      
      
    <!--   Here is the right Table -->
        <div class="col-lg-12">
          <!-- Example Pie Chart Card-->
          
          
          
          
          <div id="accordion" role="tablist" aria-multiselectable="true">
		    
		  
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseparties" aria-expanded="false" aria-controls="collapseFive">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fa fa-cube"></i>Review
		            </a>
		        </h5>
		        <div id="collapseparties" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		                 
		                            <div class="table-responsive">
           <table  class="table " id="table_list">
			<thead>
                <tr>
                	<td>#</td>
			        <th>Suit Number</th>
			        <th>Nature of Case</th>
			        <th>Court</th>
			        <th>Court Region</th>
			        <th>Plaintiff(s)</th>
			        <th>Defendant(s)</th>
			        <th>Date of Document</th>
			        <th>Date Received</th>
			        <th>Received By</th>
					<th>Actions</th>
                 </tr>
              </thead>
              
                <tbody>
    
            
             	</tbody>
            
            
            </table>
          </div>
             
		                 
		              
		            </div>
		        </div>
		    </div>
		     <br>
		   
				 
		 
		    
		      
		    
	

		    
		</div>

      </div>
      
     </div>
      
   
   
   
      
    </div>
  


  <jsp:include page="../legal/includes/footer.jsp"></jsp:include>

<script type="text/javascript" src="legal/includes/pages_script/legal_reports.js"></script> 
