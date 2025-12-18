
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
          <a href="index.jsp">Payment and Receipt Dashboard</a>
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
                      <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Total Bills</div>
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
                      <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Total Payment Confirmation</div>
                      <div class="h5 mb-0 font-weight-bold text-white mt-2">${total_rent_oustanding}</div>
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
                      <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Payment with EGCR</div>
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
                      <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Total Payments</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 font-weight-bold text-white mt-2">GHS ${total_rent_oustanding}</div>
                        </div>
                       
                      </div>
                    </div>
                    <div class="col-auto">
                      <h1 class="text-gray-300">₵</h1>
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
         
      <style>
        /* Add elevation effect to the tabs */
        .nav-pills .nav-link {
          color: white;
          background-color: #007bff; /* Default Blue */
          transition: all 0.3s ease; /* Smooth transition */
          border-radius: 5px; /* Rounded edges */
        }
      
        .nav-pills .nav-link.active {
          background-color: #0056b3; /* Darker Blue for Active Tab */
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Elevation for active tab */
          transform: translateY(-2px); /* Slight lift effect */
        }
      
        .nav-pills .nav-link:hover {
          background-color: #0056b3; /* Hover Effect */
          box-shadow: 0 4px 6px rgba(0, 0, 0, 0.15); /* Slight shadow on hover */
          transform: translateY(-2px); /* Elevation effect */
        }
      
        .tab-content {
          padding: 20px;
          border: 1px solid #ddd;
          border-radius: 5px;
          background-color: #f8f9fa;
        }
      </style>
      
      <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
        <li class="nav-item" role="presentation">
          <button class="nav-link active" id="pills-home-tab" data-toggle="pill" data-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">
            Payment and Receipt Verification
          </button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="pills-profile-tab" data-toggle="pill" data-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">
            Payment Report By Day
          </button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="pills-contact-tab" data-toggle="pill" data-target="#pills-contact" type="button" role="tab" aria-controls="pills-contact" aria-selected="false">
            Payment Summary Report
          </button>
        </li>
      </ul>
      
      <div class="tab-content" id="pills-tabContent">
        <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                 <!-- First Row: Date From, Date To, Select, Input, and Button -->
                <div class="row mb-3">
                 
                  <div class="col-md-2">
                    <select id="cbo_pr_search_by" class="form-control">
                      <option value="">Select Option</option>
                      <option value="ref_number">Reference Number</option>
                      <option value="gog_invoice_number">GOG Invoice Number</option>
                      <!-- <option value="reseolve_with_gog_invoice_number">Resolve with GOG Invoice Number</option> -->
                    </select>
                  </div>
                  <div class="col-md-2">
                    <input type="text" id="txt_pr_search_value" class="form-control" placeholder="Enter Search Value">
                  </div>
                  <div class="col-md-2">
                    <button class="btn btn-primary btn-block" id="btn_search_for_bill_to_rectify">Search</button>
                  </div>
                  <div class="col-md-2">
                    <input type="text" id="txt_pr_invoice_number" class="form-control" placeholder="Enter Invoice Nmber">
                  </div>
                  <div class="col-md-2">
                    <input type="text" id="txt_pr_ref_number" class="form-control" placeholder="Enter Reference Number">
                  </div>
                  <div class="col-md-2">
                    <button class="btn btn-primary btn-block" id="btn_resolve_with_gog_invoice_number">Check and Update</button>
                  </div>
                </div>

                <!-- Second Row: DataTable -->
                <div class="row">
                  <div class="col-12">
                    <table id="tbl_payment_receipt_verification_table" class="display" style="width:100%">
                      <thead>
                        <tr>
                          <th>Ref Number</th>
                          <th>Applicant Name</th>
                          <th>Bill Date</th>
                          <th>Bill Amount</th>
                          <th>Payment Date</th>
                          <th>EGCR Number</th>
                          <th>Payment Amount</th>
                          <th>Invoice Number</th>
                        
                          <th>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        
                        <!-- Add more rows as needed -->
                      </tbody>
                    </table>
                  </div>
                </div>
        </div>
        <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
              <div class="row mb-3">
                <div class="col-md-2">
                  <input type="date" class="form-control" placeholder="Date From">
                </div>
                <div class="col-md-2">
                  <input type="date" class="form-control" placeholder="Date To">
                </div>
                <div class="col-md-2">
                  <select class="form-control">
                    <option value="">Select Option</option>
                    <option value="1">Option 1</option>
                    <option value="2">Option 2</option>
                    <option value="3">Option 3</option>
                  </select>
                </div>
                <div class="col-md-4">
                  <input type="text" class="form-control" placeholder="Enter text here">
                </div>
                <div class="col-md-2">
                  <button class="btn btn-primary btn-block">Submit</button>
                </div>
              </div>

              <!-- Second Row: DataTable -->
              <div class="row">
                <div class="col-12">
                  <table id="example" class="display" style="width:100%">
                    <thead>
                      <tr>
                        <th>Name</th>
                        <th>Position</th>
                        <th>Office</th>
                        <th>Age</th>
                        <th>Start date</th>
                        <th>Salary</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td>Tiger Nixon</td>
                        <td>System Architect</td>
                        <td>Edinburgh</td>
                        <td>61</td>
                        <td>2011/04/25</td>
                        <td>$320,800</td>
                        <td>
                          <button class="btn btn-sm btn-info">Edit</button>
                          <button class="btn btn-sm btn-danger">Delete</button>
                        </td>
                      </tr>
                      <tr>
                        <td>Garrett Winters</td>
                        <td>Accountant</td>
                        <td>Tokyo</td>
                        <td>63</td>
                        <td>2011/07/25</td>
                        <td>$170,750</td>
                        <td>
                          <button class="btn btn-sm btn-info">Edit</button>
                          <button class="btn btn-sm btn-danger">Delete</button>
                        </td>
                      </tr>
                      <!-- Add more rows as needed -->
                    </tbody>
                  </table>
                </div>
              </div>
        </div>
        <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
            <div class="row mb-3">
              <div class="col-md-2">
                <input type="date" class="form-control" placeholder="Date From">
              </div>
              <div class="col-md-2">
                <input type="date" class="form-control" placeholder="Date To">
              </div>
              <div class="col-md-2">
                <select class="form-control">
                  <option value="">Select Option</option>
                  <option value="1">Option 1</option>
                  <option value="2">Option 2</option>
                  <option value="3">Option 3</option>
                </select>
              </div>
              <div class="col-md-4">
                <input type="text" class="form-control" placeholder="Enter text here">
              </div>
              <div class="col-md-2">
                <button class="btn btn-primary btn-block">Submit</button>
              </div>
            </div>

            <!-- Second Row: DataTable -->
            <div class="row">
              <div class="col-12">
                <table id="example" class="display" style="width:100%">
                  <thead>
                    <tr>
                      <th>Name</th>
                      <th>Position</th>
                      <th>Office</th>
                      <th>Age</th>
                      <th>Start date</th>
                      <th>Salary</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>Tiger Nixon</td>
                      <td>System Architect</td>
                      <td>Edinburgh</td>
                      <td>61</td>
                      <td>2011/04/25</td>
                      <td>$320,800</td>
                      <td>
                        <button class="btn btn-sm btn-info">Edit</button>
                        <button class="btn btn-sm btn-danger">Delete</button>
                      </td>
                    </tr>
                    <tr>
                      <td>Garrett Winters</td>
                      <td>Accountant</td>
                      <td>Tokyo</td>
                      <td>63</td>
                      <td>2011/07/25</td>
                      <td>$170,750</td>
                      <td>
                        <button class="btn btn-sm btn-info">Edit</button>
                        <button class="btn btn-sm btn-danger">Delete</button>
                      </td>
                    </tr>
                    <!-- Add more rows as needed -->
                  </tbody>
                </table>
              </div>
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