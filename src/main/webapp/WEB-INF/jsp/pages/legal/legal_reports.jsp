<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  
     <div class="col-lg-5">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           <div class="card-header">
				<h4 class='float-left'>
				<i class="fas fa-database"></i>Generate Reports</h4>
				
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
          
          <%--  <span>${regional_code}</span> --%>
           
            <div class="form-group">
       <label >Date From <span class="text-danger">*</span></label>
       <input type="date" name="date_from" id="date_from" min="1000-01-01"   max="3000-12-31" class="form-control">
           </div>
            
           <div class="form-group">
       <label >Date To <span class="text-danger">*</span></label>
       <input type="date" name="date_to" id="date_to" min="1000-01-01"   max="3000-12-31" class="form-control">
           </div>
    
                <button type="submit" class="d-none d-sm-inline-block btn btn-sm btn-info shadow-sm" 
                id="btn_reports_by_nature_of_case" data-placement="top" data-toggle="tooltip" title="Search">
                <i class="fas fa-chart-bar fa-sm text-white-50"></i>View Report Result</button>
                  
                  

      
			     </form>
			      </div>
			    </div>
			  </div>
			  

			</div>
			

            </div>
          
          </div>     
      </div>
      
      
      
        <div class="col-lg-7">
          <div class="card mb-3">
           
           <div class="card-header">
				<h4 class='float-left'>
				<i class="fas fa-table"></i>Charts</h4>
				
		</div>
            <div class="card-body">

				<div class="row">
					<div class="col-md-7">
						<label>Legal Officers</label>
							<ul id="chart_html">
								<!-- <li>
									<div class="row">
										<div class="col-md-8">
											Unassigned Cases:
										</div>
										<div class="col-md-4">
											<span class="ms-5 text-end" href="">0</span>
										</div>
									</div>
								
								 </li>
								<li>
									<div class="row">
										<div class="col-md-8">
											Mawutor Prosper:
										</div>
										<div class="col-md-4">
											<span class="ms-5 text-end" href="">0</span>
										</div>
									</div>
								
								 </li> -->
							</ul>
					</div>
					
					<div class="col-md-5">
						<div class="chart-pie pt-4 pb-2">
		                    <canvas id="myPieChart"></canvas>
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
		    
		  
		    <div class="card">
		        <h5 class="card-header" role="tab">Generated Results
		        </h5>
		        <div id="collapseparties" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		                 
		                            <div class="table-responsive card card-body">
           <table  class="table table-striped" id="table_list">
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
			        <th>Status</th>
			        <th>Assigned To</th>
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
  


  <jsp:include page="../legal/includes/footer.jsp"></jsp:include>

<script type="text/javascript" src="legal/includes/pages_script/legal_reports.js"></script> 
<script type="text/javascript" src="vendor/chart.js/Chart.min.js"></script> 

<script>


</script>
