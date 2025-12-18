<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="org.codehaus.jettison.json.*" %>
      <%@ page import="com.google.gson.Gson" %>
        <%@ page import="com.google.gson.GsonBuilder" %>

          <%@ page import="org.codehaus.jettison.json.JSONArray" %>
            <%@ page import="org.codehaus.jettison.json.JSONException" %>
              <%@ page import="org.codehaus.jettison.json.JSONObject" %>


                <jsp:include page="../includes/_header.jsp"></jsp:include>

                <div class="container-fluid">
                  <!-- Breadcrumbs-->
                  <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                      <a href="#">Rent Management</a>
                    </li>
                    <li class="breadcrumb-item active">Maps</li>
                  </ol>





                  <div class="row">


                    <div class="col-lg-3">
                      <!-- Example Bar Chart Card-->
                      <div class="card mb-3">
                        <div class="card-header"> 
                          <i class="fa fa-bar-chart"></i>Rent Mangement Maps Templates
                        </div>
                        <div class="card-body">


                          <div class="btn-group w-100 mr-2">
                            <button type="button" class="btn btn-primary" id="pvlmd_btn_add_coordinate"
                              data-placement="top" data-toggle="modal" data-target="#addcoordinatetoplot"
                              data-toggle="tooltip" title="Draw a Line">
                              <i class="fa fa-plus-circle"></i>

                            </button>



                            <button type="button" class="btn btn-warning" id="lrd_btn_add_coordinate_by_csv"
                              data-placement="top" data-toggle="modal" data-target="#uploadcoordiantecsv"
                              data-toggle="tooltip" title="Upload CSV">
                              <i class="fa fa-upload"></i>
                            </button>


                            <button type="button" class="btn btn-danger" id="pvlmd_btn_visualise_coordinate"
                              data-placement="top" data-toggle="tooltip" title="Visualise Coordinate">
                              <i class="fa fa-eye"></i>
                            </button>

                            <button type="button" class="btn btn-info" id="pvlmd_btn_visualise_wkt"
                              data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
                              <i class="fa fa-map"></i>
                            </button>

                            <button type="button" class="btn btn-success" id="pvlmd_btn_visualise_wkt"
                              data-placement="top" data-toggle="tooltip" title="Save Parcels">
                              <i class="fa fa-save"></i>
                            </button>





                          </div>



                          <!--  WKT row here -->
                          <div class="form-group">

                            <div class="form-row">


                            </div>
                          </div>




                          <!-- search by reference nunber -->

                          <!-- <div class="row">

                            <div class="col-md-6">
                              <div class="form-group">

                                <input class="form-control" id="pvlmd_search_by_text" name="pvlmd_search_by_text"
                                  type="text" placeholder="Search by Certificate Number" required>

                              </div>
                            </div>


                            <div class="col-md-2">
                              <div class="form-group">
                                <button type="button" class="btn btn-primary"
                                  id="pvlmd_btn_search_by_certificate_number" data-placement="top" data-toggle="tooltip"
                                  title="Show Location"><i class="fa fa-retweet"></i> </button>

                              </div>
                            </div>




                          </div> -->


                          <!--  Scanned Maps -->

                          <!-- <div class="row">

                            <div class="col-md-8">
                              <div class="form-group">



                                <select name="cbo_estate_list" id="cbo_estate_list" class="form-control input-sm"
                                  data-style="btn-info" data-live-search="true">
                                  <option value="-1">--select estate--</option>
                                  <c:forEach items="${estate_list}" var="estate">
                                    <option value="${estate.ge_id}">${estate.ge_location_name}</option>
                                  </c:forEach>
                                </select>
                              </div>
                            </div>

                          </div> -->

                          <div class="d-flex justify-content-between">
                    <div class="card card-body">
                        <label class="col-form-label" >Search Section:</label>
                        <div class="form-row">
                            
                            <select class="form-control" id="rts_select_type">
                                <option disabled selected value="-1">-- select type --</option>
                                <option value="Plot Number">Plot Number</option>
                                <option value="Estate">Estate</option>
                                <option value="Certificate Number">Certificate Number</option>
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
                        <div class="form-row" id="div_btn_rmap_search">
                         <button class="btn btn-success btn-sm w-100 mt-3" id="btn_rmap_search"><i class="fas fa-search mr-1"></i>Search</button>
                        </div>
                        <div class="form-row d-none mt-2" id="div_certificate_rmap_search">
                          <!-- <div class="form-group"> -->

                                <input class="form-control" id="pvlmd_search_by_text" name="pvlmd_search_by_text"
                                  type="text" placeholder="Search by Certificate Number" required>

                              <!-- </div> -->
                         <button type="button" class="btn btn-danger btn-sm w-100 mt-3"
                                  id="pvlmd_btn_search_by_certificate_number" data-placement="top" data-toggle="tooltip"
                                  title="Show Location"><i class="fas fa-search mr-1"></i>Search</button>
                        </div>
                    </div>
                    <div>
                    </div>
                </div>



                        </div>

                      </div>






                    </div>



                    <div class="col-lg-9">
                      <!-- Example Bar Chart Card-->
                      <div class="card mb-3">
                        <div class="card-header">
                          <i class="fa fa-bar-chart"></i>Government Land Estates
                        </div>
                        <div class="card-body">









                          <div id="govrent-map"></div>







                        </div>
                        <div class="card-footer small text-muted">Rent Management</div>
                      </div>






                    </div>
                  </div>




                </div>




                <jsp:include page="../includes/_footer.jsp"></jsp:include>