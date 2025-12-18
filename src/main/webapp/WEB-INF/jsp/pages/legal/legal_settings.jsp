<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <jsp:include page="../legal/includes/header.jsp"></jsp:include>
 
<!-- Begin Page Content -->
<div class="container-fluid">
	<!-- Main content -->
    <section class="content">
				    
                <!-- Page Heading -->
                <div class="row mb-4">
                	 <div class="col-md-12">
		                <div class=" ">
		                   
					         <nav>
				                <ol class="breadcrumb">
				                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
				                  <li class="breadcrumb-item active">Settings</li>
				     
				      		
				      			  <button class="btn btn-danger float-right" 
				                    style="position:absolute; right:100px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;" onclick="history.back()">
				      				Back
				      			  </button>
				      			
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div>
                
				      <div class="row">
				            <div class="col-md-6">
				              <div class="card">
				              <div class="card-header bg-dark text-white">
								<i class="fa fa-bar-chart"></i>Nature of Case
									<span
								class="col-md-3 float-right ">
								<button class="btn btn-success btn-icon-split float-right "
									id="btnAddNature">
									<span
										class="text">Add</span>
								</button>
							</span>
								</div>
				                <div class="card-body">
				                  <div class="tab-content">
								            <div id="" class="table-responsive">
								                <table class="table " id="nature_list"  width="100%" cellspacing="0" >				      
				              						<thead>
													    <tr>													  
													        <th>Nature of Case</th>
															<th>Actions</th>
													    </tr>
													  </thead>
													  <tbody id="table_body">
													   <c:forEach items="${type_of_cases}" var="typeslist"  varStatus="typeslist_loop">									                      
													    <tr>
													    
													    	<td>${typeslist.description}</td>
													    	<td><%-- <div class="dropdown no-arrow">
											              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
														               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
														                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
														              </svg>
											              	  </a>
											              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
											              	    
											              	    <a class="" id="btnAddNature2" data-nature_of_case='${typeslist.id}' data-nature_of_case_id='${typeslist.description}' href="#">Edit</a>
											              	  </div>
											              	</div> --%>
											              	<button type="button" class="btn btn-primary btn-sm btnEditNature" data-nature_of_case_id='${typeslist.id}' data-nature_of_case='${typeslist.description}'>Edit</button>
											              	
											              	</td>
													    </tr>
													     </c:forEach>
													  </tbody>
					                   	        </table>
								            </div>
								    </div>
				                </div>
				              </div>
				            </div>
				            <div class="col-md-6">
				              <div class="card">
				              <div class="card-header bg-dark text-white">
								<i class="fa fa-bar-chart"></i>Courts
									<span
								class="col-md-3 float-right ">
								<button class="btn btn-success btn-icon-split float-right "
									id="btnAddCourt">
									<span
										class="text">Add</span>
								</button>
							</span>
								</div>
				                <div class="card-body">
				                  <div class="tab-content">
								            <div id="" class="table-responsive">
								                <table class="table " id="court_list" >				      
				              						<thead>
													    <tr>													  
													        <th>Name</th>
															<th>Region</th>
															<th>City</th>
															<th>Description</th>
															<th>Action</th>
													    </tr>
													  </thead>
													  <tbody id="table_body">
													   <c:forEach items="${courts}" var="courtslist"  varStatus="typeslist_loop">									                      
													    <tr>
													    
													    	<td>${courtslist.court_name}</td>
													    	<td>${courtslist.region}</td>
													    	<td>${courtslist.city}</td>
													    	<td>${courtslist.description}</td>
													    	<td><%-- <div class="dropdown no-arrow">
											              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
														               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
														                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
														              </svg>
											              	  </a>
											              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
											              	    
											              	    <a class="dropdown-item edit_court" id="${courtslist.id}" data_id='${courtslist.id}' href="#">Edit</a>
											              	  </div>
											              	</div> --%>
											              	
											              	<button type="button" class="btn btn-primary btn-sm btnEditCourt" data-court_id="${courtslist.id}" data-court_id='${courtslist.id}' data-court_name='${courtslist.court_name}' data-region='${courtslist.region}' data-city='${courtslist.city}' data-description='${courtslist.description}'>Edit</button>
											              	</td>
													    </tr>
													     </c:forEach>
													  </tbody>
					                   	        </table>
								            </div>
								    </div>
				                </div>
				              </div>
				            </div>
				            
				            
				          </div>
				
				      
				    </section>
				    <!-- /.content -->

            </div>
            <!-- End of Main Content -->
            
   <!-- Nature of Case Add Modal -->
  <div class="modal fade" id="addNatureModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Nature of Case</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="addnature" method="post" >
        
        <div class="modal-body">
         
          <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Nature Of Case</label>
			<div class="col-sm-8" hidden="">
              <input class="form-control" type="text" id="nature_of_case_id" name="nature_of_case_id">
            </div>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="nature_of_case" name="nature_of_case" required >
            </div>
		  </div>
		  
	

        </div>
        <div class="modal-footer">
          <button type="submit" id="save_btn" class="btn btn-primary">Save</button>
        </div>
       </form>
      </div>
    </div>
  </div>
  
  <!-- Nature of Case Add Modal  -->
  <!-- Courts Add Modal -->
  <div class="modal fade" id="addCourtModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Courts</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="addcourt" method="post" >
        
        <div class="modal-body">
         
          <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Name of Court <span class="text-danger">*</span></label>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="court_name" name="court_name" required >
            </div>
		  </div>
		  <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Region <span class="text-danger">*</span></label>
			<div class="col-sm-8">
              <select class="form-control"  name="court_region" id="court_region" required>
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
		  </div>
		  <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">City</label>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="city" name="city" >
            </div>
		  </div>
		  <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Description</label>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="description" name="description"  >
            </div>
            <div class="col-sm-8" hidden="">
              <input class="form-control" type="text" id="court_id" name="court_id"  >
            </div>
		  </div>
		  
	

        </div>
        <div class="modal-footer">
          <button type="submit" id="save_court_btn" class="btn btn-primary">Save</button>
        </div>
       </form>
      </div>
    </div>
  </div>
  
  <!-- Nature of Case Add Modal  -->
 
  <jsp:include page="../legal/includes/footer.jsp"></jsp:include>

<script type="text/javascript" src="legal/includes/pages_script/legal_settings.js"></script> 

  