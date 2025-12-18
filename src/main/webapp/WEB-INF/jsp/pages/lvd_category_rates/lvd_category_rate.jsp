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


  <jsp:include page="../includes/_header.jsp"></jsp:include>
  

  <% 


	  
%>

  
  


    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="#">LVD Categories and Rates</a>
        </li>
        <li class="breadcrumb-item active">Maps</li>
      </ol>
           
           
      <div class="min-vh-100 bg-light py-4">
        <div class="container">
            <!-- Top Card -->
            <div class="card mb-4">
                <div class="card-body">
                    <h2 class="h4 font-weight-bold text-dark mb-4">Categories and Rates</h2>
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <label for="category" class="text-dark mb-2">Category</label>
                            <select id="cbo_main_category" class="form-control border border-primary" value="{{ category }}">
                                <option value="">Select Category</option>
                                <c:forEach items="${main_category_list}" var="maincategorylist">
									<option  value="${maincategorylist.mc_code}">${maincategorylist.main_category}</option>
								  </c:forEach>
								</select>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="cbo_sub_category" class="text-dark mb-2">Sub-category</label>
                            <select id="cbo_sub_category" class="form-control border border-primary" value="{{ subCategory }}">
                                <option value="">Select Sub-category</option>
                               
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="bg-primary text-white p-3 rounded" id="txt_cost_per_square_meter">Cost per Square Meter - {cost_per_square_meter}</div>
                        </div>
                        <div class="col-md-3">
                            <div class="bg-primary text-white p-3 rounded" id="txt_gross_floor_area">Gross Floor Area - {gross_floor_area}</div>
                        </div>
                        <div class="col-md-3">
                            <div class="bg-primary text-white p-3 rounded" id="txt_number_of_floors">Number of Floors - {number_of_floors}</div>
                        </div>
                        <div class="col-md-3">
                            <div class="bg-primary text-white p-3 rounded" id="txt_cost_per_square_meter">Information 2 - {cost_per_square_meter}</div>
                        </div>
                    </div>
                </div>
            </div>
    
            <!-- Bottom Card -->
            <div class="row">
                <div class="col-md-8">
                    <div class="card mb-4">
                        <div class="card-body">
                            <h2 class="h4 font-weight-bold text-dark mb-4">Sub Category Details</h2>
                            <div class="table-responsive">
                                <table id="sub_category_details_datatable" class="table table-bordered">
                                    <thead class="thead-light">
                                        <tr>
                                            <th scope="col">Description</th>
                                            <th scope="col">Quantity</th>
                                            <th scope="col">Unit</th>
                                            <th scope="col">Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Add table rows dynamically here -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">

                            <div class="card-body">
                            <h2 class="h4 font-weight-bold text-dark mb-4">Value Calculation</h2>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="bg-primary text-white p-3 rounded" id="lbl_electrical_installation_rate">electrical_installation_rate</div>
                                </div>
                               
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="bg-primary text-white p-3 rounded" id="lbl_preliminaries_rate">preliminaries_rate</div>
                                </div>
                               
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="bg-primary text-white p-3 rounded" id="lbl_professional_charges_rate">professional_charges_rate</div>
                                </div>
                               
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="bg-primary text-white p-3 rounded" id="lbl_plumbing_installation_rate">plumbing_installation_rate</div>
                                </div>
                               
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="bg-primary text-white p-3 rounded" id="lbl_nhil_covid_levy_rate">nhil_covid_levy_rate</div>
                                </div>
                               
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="bg-primary text-white p-3 rounded" id="lbl_vat_nhil_rate">vat_nhil_rate</div>
                                </div>
                               
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="bg-primary text-white p-3 rounded" id="lbl_developers_profit">developers_profit</div>
                                </div>
                               
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    
            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Modal Title</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Content for Row {{ selectedRow !== null ? selectedRow + 1 : '' }}
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
      
      
   
      
    </div>
  

 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
