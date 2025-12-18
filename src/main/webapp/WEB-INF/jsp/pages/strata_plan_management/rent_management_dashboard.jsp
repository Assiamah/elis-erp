
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="../includes/_header.jsp"></jsp:include>







    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">Rent Management Dashboard</a>
        </li>
        <li class="breadcrumb-item active"> ${fullname}</li>
         
             
      </ol>
     
           
      
       <!-- Content Row -->
          <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card bg-gradient-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Total Lessees/Assignees</div>
                      <div class="h5 mb-0 font-weight-bold text-white mt-2">${total_leasee}</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-users fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card bg-gradient-danger shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Total Rent Outstanding</div>
                      <div class="h5 mb-0 font-weight-bold text-white mt-2">GHS ${total_rent_oustanding}</div>
                    </div>
                    <div class="col-auto">
                        <h1 class="text-gray-300">₵</h1>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card bg-gradient-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Due Rents</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto mt-2">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-white">0</div>
                        </div>
                        <!-- <div class="col mt-2">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                        </div> -->
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-exclamation-triangle fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            
              <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card bg-gradient-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Total Rents Paid (This Year)</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-white">GHS 0.00</div>
                        </div>
                       
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-check-circle fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pending Requests Card Example -->
            <!-- <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Pending Requests</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">${fullname}</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div> -->
          </div>
      
      
        
      
       <div class="row mt-3">
     
     
     
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           <div class="card-header">
				<div class="d-flex justify-content-between">
                    <div class="card card-body col-5">
                        <label class="col-form-label" >Search Section:</label>
                        <div class="form-row">
                            
                            <select class="form-control" id="rts_select_type">
                                <option disabled selected value="-1">-- select type --</option>
                                <option value="Plot Number">Plot Number</option>
                                <option value="Estate">Estate</option>
                                <option value="Name of Leasee/Assignee">Name of Lessee</option>
                            </select>
                        </div>
                        <div class="form-row mt-2 d-none" id="div_rent_estate">
                            <!-- <input class="form-control" id="rent_search" placeholder="Enter keyword"/> -->
                            <!-- <select class="form-control" id="rent_locality">
                                <option disabled selected value="-1">-- select type --</option>
                            </select> -->
                            <select
								name="rts_estate"
								id="rts_estate"
								class="form-control input-sm" data-style="btn-info"
								data-live-search="true"
							>
								<option selected disabled value="">-- select --</option>
																
								<c:forEach items="${estate_list}" var="estateList">
									<option  value="${estateList.ge_id}">${estateList.ge_location_name}</option>
								  </c:forEach>
								</select>
                        </div>
                        <div class="form-row mt-2 d-none" id="div_rent_keyword">
                            <input class="form-control" id="rts_keyword" placeholder="Enter keyword..."/>
                        </div>
                        <button class="btn btn-success btn-sm w-100 mt-3" id="btn_rt_search"><i class="fas fa-search mr-1"></i>Search</button>
                    </div>
                    <div>
                        <!-- <button class="btn btn-success" data-toggle="modal" data-target="#addestate"><i class="fas fa-plus-circle mr-1"></i>Add Estate</button>
                        <button class="btn btn-danger" data-toggle="modal" data-target="#addplotnumber"><i class="fas fa-plus-circle mr-1"></i>Add Plot Number</button> -->
                        <button class="btn btn-warning" data-toggle="modal" data-target="#addlegder"><i class="fas fa-plus-circle mr-1"></i>Add Lessee</button>
                    </div>
                </div>
		    </div>
            <div class="card-body">

                <div class="table-responsive">
                    <table class="table table-bordered table-hover display "
                        id="job_casemgtdetailsdataTable" width="100%" cellspacing="0">
                        <thead class="small">
                            <tr>
                                <th>Plot Number</th>
                                <th>Name of Lessee</th>
                                <th>File Number</th>
                                <th>Commencement Date</th>
                                <th>Consent Date</th>
                                <th>Term</th>
                                <th>Plot Size</th>
                                <th>Rent Review Period</th>
                                <th>Last Payment Period</th>
                                <th>Rent Outstanding</th>
                                <th>Unexpired Term</th>
                                <th>Action</th>

                            </tr>
                        </thead>
                        <tbody>



                        </tbody>


                    </table>
                </div>
    
            </div>
          
          </div>
        
        
      </div>
      
      
      
      
    <!--   Here is the right Table -->
        <div class="col-lg-4 d-none">

            <div id="accordion">
                <div class="card">
                  <div class="card-header" id="headingOne">
                    <h5 class="mb-0">
                      <button class="btn btn-link text-secondary" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                        <i class="fa fa-calculator"></i>Ground Rent Calculator
                      </button>
                    </h5>
                  </div>
              
                  <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                    <div class="card-body">
                     
                    </div>
                  </div>
                </div>
                <div class="card">
                  <div class="card-header" id="headingTwo">
                    <h5 class="mb-0">
                      <button class="btn btn-link text-secondary collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        <i class="fas fa-info-circle"></i>Payment History
                      </button>
                    </h5>
                  </div>
                  <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-8">
                                <input class="form-control form-control-sm" placeholder="Enter Account Number"/>
                            </div>
                            <div class="col-4">
                                <button class="btn btn-success btn-sm w-100" id="btn_rt_search_payment"><i class="fas fa-search"></i>Search</button>
                            </div>
                        </div>
                        <div class="card card-body mt-2">
                            <div class="table-responsive small">
                                <table class="table table-striped table-bordered table-hover"
                                    id="tbl_rent_payment_history" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Action</th>
                                            <th>Payment Mode</th>
                                            <th>Amount</th>
                                            <th>Receipt No.</th>
                                            <th>Date</th>
                                            <th>Payment Amount</th>
            
                                        </tr>
                                    </thead>
                                    <tbody>
            
            
            
                                    </tbody>
            
            
                                </table>
                            </div>
                        </div>
                    </div>
                  </div>
                </div>
                <div class="card">
                  <div class="card-header" id="headingThree">
                    <h5 class="mb-0">
                      <button class="btn btn-link text-secondary collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                        <i class="fas fa-file-alt"></i>Reports
                      </button>
                    </h5>
                  </div>
                  <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                    <div class="card-body">
                     
                    </div>
                  </div>
                </div>
              </div>

      </div>
      
     </div>
      
      
   
      
    </div>
 
 
	<jsp:include page="../includes/_footer.jsp"></jsp:include>