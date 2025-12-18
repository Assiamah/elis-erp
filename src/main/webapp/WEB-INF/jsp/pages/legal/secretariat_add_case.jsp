<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
				                  <li class="breadcrumb-item "><a href="${pageContext.request.contextPath}/secretariat">Secretariat</a></li>
				                  <li class="breadcrumb-item active">New Case
				                  <button  class="btn btn-danger float-right"  onclick="history.back()"
				                    style="position:absolute; right:50px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;">
				      				Back
				      			  </button>
				      			  <%-- <a href="${pageContext.request.contextPath}/legal_settings">
				      			  <button class="btn btn-success float-right" 
				                    style="position:absolute; right:50px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;">
				      				Settings
				      			  </button>
				      			  </a> --%>
				                  </li>
				                </ol>
				                
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div>
   
   
<section class="section dashboard">
	     	<div class="row mb-4">
	            <div class="col-md-12">
	              <div class="card">
	              	<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i>Add Existing Case
					</div>
	                <div class="card-body">
		                <form method="post" id="search_suit">
			                <div class="row mt-4 mb-4">
		                		<div class="col-md-2">
		                			<span>Suit Number<span class="text-danger">*</span>:</span>
		                		</div>
		                		<div class="col-md-6">
		                			<input class="form-control" name="search_suit_number" id="search_suit_number" placeholder="Enter Suit Number" required />
		                			<br>
		                			<button class="btn btn-success" id="search_btn"><i class="fas fa-check-circle"></i>Check</button>
		                		</div>
		                	</div>
		                </form>
	                </div>
	              </div>
	              
	              <div class="card mt-4">
	               
	               <form method="post" id="add_case">
	                <div class="card-body">		                
			                <div class="row mt-4 mb-4">
		                		<div class="col-md-12">
		                			<div id="alert col-md-12"></div>
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Suit Number<span class="text-danger">*</span>:</span>
		                				</div>
		                				<div class="col-md-6">
		                					<input class="form-control" name="suit_number" id="suit_number" placeholder="Enter Suit Number" required />
		                				</div>
		                			</div>
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Reference Number:</span>
		                				</div>
		                				<div class="col-md-6">
		                					<input class="form-control" name="reference_number" id="reference_number" placeholder="" />
		                				</div>
		                			</div>
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Nature of case<span class="text-danger">*</span>:</span>
		                				</div>
		                				<div class="col-md-6">
		                				<select class="form-control" aria-label="Default select example" name="nature_of_case" id="nature_of_case"  required>
							                <option value="">-- select --</option>
							                 <c:forEach items="${type_of_cases}" var="typeslist"  varStatus="typeslist_loop">
							                        <option value="${typeslist.id}" >${typeslist.description}</option>
							                     </c:forEach>
							              </select>
		                				</div>
		                			</div>
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Court Process <span class="text-danger">*</span>:</span>
		                				</div>
		                				<div class="col-md-6">
		                					<input class="form-control" name="court_process" id="court_process" placeholder="" required />
		                				</div>
		                			</div>
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Region <span class="text-danger">*</span>:</span>
		                				</div>
		                				<div class="col-md-6">
		                					<select class="form-control" aria-label="Default select example" name="court_region" id="court_region" required>
								                <option value="">-- select --</option>
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
		                					<span>Court<span class="text-danger">*</span>:</span>
		                				</div>
		                				<div class="col-md-6">
		                					<select class="form-control" aria-label="Default select example" name="court" id="court" required>
							                <option value="">-- select --</option>
							              		
							            	</select>
		                				</div>
		                			</div>
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Court Description:</span>
		                				</div>
		                				<div class="col-md-6">
		                					<input type="text" class="form-control" name="court_description" id="court_description"  />
		                				</div>
		                			</div>
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>City/Town:</span>
		                				</div>
		                				<div class="col-md-6">
		                					<input type="text" class="form-control" name="court_city" id="court_city" />
		                				</div>
		                			</div>
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Filing Date<span class="text-danger">*</span>:</span>
		                				</div>
		                				<div class="col-md-6">
		                					<input type="date" class="form-control" name="date_document" id="date_document" required />
		                				</div>
		                			</div>
		                			<div class="row mt-4">
		                				<div class="col-md-2">
		                					<span>Date Received<span class="text-danger">*</span>:</span>
		                				</div>
		                				<div class="col-md-6">
		                					<input type="date" class="form-control" name="date_received" id="date_received" data-date="" data-date-format="DD MMMM YYYY" required />
		                				</div>
		                			</div> 
		                			
		                			<div class="input-group mb-3" hidden>
									  <textarea  class="form-control " name="reliefs" id="reliefs" ></textarea>
									</div>
									<div class="input-group mb-3" hidden>
									  <textarea  class="form-control " name="summary" id="summary" ></textarea>
									</div>
		                	
		 								 
		                			<div class="row mt-4">
		                				<div class="col-md-12">
		                				<p>
										  <a class="btn btn-warning" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
										    Parties
										  </a>
										</p><br/>
										<div id="alert_party"></div><br/>
										<div class="collapse" id="collapseExample">
										  <div class="card card-body">
										  <div class="text-end mb-2">
										  	<button  type="button" class="btn btn-warning small"  data-toggle="modal" data-target="#addPartyModal"><i class="fas fa-plus-circle"></i>Add Parties</button>
										  </div>
										  <table class="table table-striped" id="parties_tbl_main"  width="100%" cellspacing="0">
											  <thead>
											    <tr>
													<th scope="col">#</th>
											      <th scope="col">Party Type</th>
											      <th scope="col">Party Name</th>
											       <th scope="col">Party's Address</th>
											      <th scope="col">Party's Lawyer</th>
											      <th scope="col">Lawyer's Tel</th>
											      <th scope="col">Lawyer's Add</th>
											      <th scope="col">Lawyer's Chambers</th>
											      <th scope="col">Action</th>
											    </tr>
											  </thead>
											  <tbody id="parties_tbl">
											   
											  </tbody>
											</table>
										  </div>
										</div>
		                				</div>
		                			</div>
		                			<div class="row mt-4">
		                				
		                				<div class="col-md-6">
		                					
		                					<br>
		                					<input type="text" name="request_type" value="receive_writ" hidden />
									        <input type="text" name="received_by" value="${sessionScope.userid}" hidden />
									        <input type="text" name="received_at" value="${sessionScope.unit_name}" hidden />
									        <br>
		                					<button type="submit" id="save_case" class="btn btn-success"><i class="fas fa-save"></i>Save</button>
		                				</div>
		                				<div id="save_alert" class="col-md-6"></div>
		                			</div>
		                		</div>
		                	</div>
	                </div>
	               </form>
	              </div>
	            </div>
	          </div>
	</section>  
	
  </div>

	<div class="modal fade" id="addPartyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Add Party</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <form method="post" id="addPartyForm">
	      <div class="modal-body">
	      	<div class="text-start">
				<label for="basic-url">Party Type <span class="text-danger">*</span></label>
			</div>
			<div class="input-group mb-3">
			  <select class="form-control" aria-label="Default select example" name="party_type" id="party_type" required>
                	
              </select>
			</div>
			<div class="text-start">
				<label for="basic-url">Party Name <span class="text-danger">*</span></label>
			</div>
			<div class="input-group mb-3">
			  <input type="text" class="form-control " name="party_name" id="party_name" required />
			</div>
			<div class="text-start">
				<label for="basic-url">Party's Address</label>
			</div>
			<div class="input-group mb-3">
			  <textarea  class="form-control " name="party_address" id="party_address" ></textarea>
			</div>
			<div class="text-start">
				<label for="basic-url">Party's Lawyer</label>
			</div>
			<div class="input-group mb-3">
			  <input type="text" class="form-control " name="party_lawyer" id="party_lawyer"  />
			</div>
			<div class="text-start">
				<label for="basic-url">Lawyer's Telephone</label>
			</div>
			<div class="input-group mb-3">
			  <input type="number" class="form-control " name="lawyer_tel"  id="lawyer_tel" />
			</div>
			<div class="text-start">
				<label for="basic-url">Lawyer's Address</label>
			</div>
			<div class="input-group mb-3">
			  <textarea  class="form-control " name="lawyer_address" id="lawyer_address" ></textarea>
			</div>
			<div class="text-start">
				<label for="basic-url">Lawyer's Chamber</label>
			</div>
			<div class="input-group mb-3">
			  <input type="text" class="form-control " name="lawyer_chamber" id="lawyer_chamber"  />
			</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-success" id="add_party">Add</button>
	      </div>
	     </form>
	    </div>
	  </div>
	</div>  


	<div class="modal fade" id="editPartyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
		  <div class="modal-content">
			<div class="modal-header">
			  <h5 class="modal-title" id="exampleModalLabel">Edit Party</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<form action="" method="POST" enctype="multipart/form-data" id="edit_party_form">
			<div class="modal-body">
				<!-- <input type="" id="party_id" value=""> -->
				<input type="hidden" id="row_num" value="">
				<div class="text-start">
				  <label for="basic-url">Party Type <span class="text-danger">*</span></label>
			  </div>
			  <div class="input-group mb-3">
				<select class="form-control" aria-label="Default select example" name="party_type" id="e_party_type" required>
					
				</select>
			  </div>
			  <div class="text-start">
				  <label for="basic-url">Party Name <span class="text-danger">*</span></label>
			  </div>
			  <div class="input-group mb-3">
				<input type="text" class="form-control " name="party_name" id="e_party_name" required />
			  </div>
			  <div class="text-start">
				  <label for="basic-url">Party's Address</label>
			  </div>
			  <div class="input-group mb-3">
				<textarea  class="form-control " name="party_address" id="e_party_address" ></textarea>
			  </div>
			  <div class="text-start">
				  <label for="basic-url">Party's Lawyer</label>
			  </div>
			  <div class="input-group mb-3">
				<input type="text" class="form-control " name="party_lawyer" id="e_party_lawyer"  />
			  </div>
			  <div class="text-start">
				  <label for="basic-url">Lawyer's Telephone</label>
			  </div>
			  <div class="input-group mb-3">
				<input type="number" class="form-control " name="lawyer_tel"  id="e_lawyer_tel" />
			  </div>
			  <div class="text-start">
				  <label for="basic-url">Lawyer's Address</label>
			  </div>
			  <div class="input-group mb-3">
				<textarea  class="form-control " name="lawyer_address" id="e_lawyer_address" ></textarea>
			  </div>
			  <div class="text-start">
				  <label for="basic-url">Lawyer's Chamber</label>
			  </div>
			  <div class="input-group mb-3">
				<input type="text" class="form-control " name="lawyer_chamber" id="e_lawyer_chamber"  />
			  </div>
			</div>
			<div class="modal-footer">
			  <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			  <button type="button" class="btn btn-success" data-dismiss="modal" id="btn-update-party">Update</button>
			</div>
		   </form>
		  </div>
		</div>
	  </div>  
<!-- End Page Content -->
<jsp:include page="../legal/includes/footer.jsp"></jsp:include>

<script type="text/javascript" src="legal/includes/pages_script/secretariat_add_case.js"></script>  
