
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
          <a href="#">Rent - Leasee's Details</a>
        </li>
        <!-- <li class="breadcrumb-item active"> ${fullname}</li> -->
         
             
      </ol>
     
           
      
      
      
        
      
       <div class="row mt-3">
     
     
     
     <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          
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
      
      
      
      
    <!--   Here is the right Table -->
        <div class="col-lg-4">

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