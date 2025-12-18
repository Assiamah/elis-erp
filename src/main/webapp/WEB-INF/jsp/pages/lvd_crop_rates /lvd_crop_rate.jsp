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
          <a href="#">LVD Compensation Map</a>
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
                            <select id="category" class="form-control border border-primary" value="{{ category }}">
                                <option value="">Select Category</option>
                                <!-- Add category options dynamically here -->
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="subcategory" class="text-dark mb-2">Sub-category</label>
                            <select id="subcategory" class="form-control border border-primary" value="{{ subCategory }}">
                                <option value="">Select Sub-category</option>
                                <!-- Add subcategory options dynamically here -->
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="bg-primary text-white p-3 rounded">Cost per Square Meter - {{ listofsubdetail.cost_per_square_meter }}</div>
                        </div>
                        <div class="col-md-3">
                            <div class="bg-primary text-white p-3 rounded">Gross Floor Area - {{ listofsubdetail.gross_floor_area }}</div>
                        </div>
                        <div class="col-md-3">
                            <div class="bg-primary text-white p-3 rounded">Number of Floors - {{ listofsubdetail.number_of_floors }}</div>
                        </div>
                        <div class="col-md-3">
                            <div class="bg-primary text-white p-3 rounded">Information 2 - {{ listofsubdetail.cost_per_square_meter }}</div>
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
                                <table class="table table-bordered">
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
                                <div class="col-md-6">
                                    <div class="bg-primary text-white p-3 rounded">Info 1</div>
                                </div>
                                <div class="col-md-6">
                                    <div class="bg-primary text-white p-3 rounded">{{ listofsubdetail.electrical_installation_rate }}</div>
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
  
