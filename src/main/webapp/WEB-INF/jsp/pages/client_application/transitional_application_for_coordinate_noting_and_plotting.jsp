<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


   <jsp:include page="../client_application/_application_process_header.jsp"></jsp:include>


   <div  class="container">
    <br>
    <h3 class="border-bottom border-gray pb-2">Coordinate Entry</h3>
    
    
      <div class="row">
     <!--   Here is the right Table -->
        <div class="col-lg-12">
          <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i>Coordinate Entry</div>
            <div class="card-body">
               <!--  The Form starts here -->
              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
       
<!-- Maps Details Starts Here  -->

<div class="form-group">
                        <div class="form-row">  <label for="lc_fr_bl_wkt_polygon">WKT Polygon</label>
                              <input class="form-control" id="lc_fr_bl_wkt_polygon"  name="lc_fr_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >

                            <!-- <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" ></textarea> -->
                        </div>
                        
                  
                     </div>



<div class="bs-example">






        <div class="btn-group mr-2">
        


<button type="button" class="btn btn-primary"  id="lc_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-map"></i>
</button>
<!--  
<button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
<i class="fa fa-save"></i>
</button>
-->

<button type="button" class="btn btn-primary" id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
<i class="fa fa-object-ungroup"></i>
</button>



<!--        
<button type="button" class="btn btn-primary" id="lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
<i class="fa fa-print"></i>
</button> -->






</div> 








</div>






<!-- <div id="lcfrs-map" ></div> -->
<div id="lrdfp-map" ></div>

 <!--  Here is where the fee list comes -->


                  
              </form>
            
            <!-- The form Ends Hers -->
            
          </div>
          
          
             <!--  Scanned Maps -->








<div class="bs-example">






        <div class="btn-group mr-2">
         <button type="button" class="btn btn-primary" id="lc_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addcoordinatetoplot" data-toggle="tooltip" title="Add Coordinate">
            <i class="fa fa-plus-circle"></i>
        </button>
        
        
            <button type="button" class="btn btn-primary"  id="lrd_btn_add_coordinate_by_csv" data-placement="top" data-toggle="modal" data-target="#uploadcoordiantecsv" data-toggle="tooltip" title="Upload CSV">
        <i class="fa fa-upload"></i>
    </button>
        
          <button type="button" class="btn btn-primary"  id="lc_btn_fr_visualise_coordinate" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-eye"></i>
        </button>
        
         <button type="button" class="btn btn-primary" id="btn_lc_save_parcel_for_search" data-placement="top" data-toggle="tooltip" title="Save">
            <i class="fa fa-save"></i>
        </button>

   </div> 

</div>







 <!--  Here is where the fee list comes -->

<div  class="table w-auto small">
       <table class="table table-bordered" id="coordinatelis_Table" width="100%" cellspacing="0">
       
          <thead>
            <tr>
             
             
             
             <th>name</th>
             <th>x_coordinate</th>
             <th>y_coordinate</th>
             <th>Remove</th>
              </tr>
          </thead>
          
            <tbody>

</tbody>
         <!--  <tfoot>
            <tr>
              <th>Job Number</th>
              <th>Applicant Name</th>
              <th>Status</th>
              <th>Case Details</th>
                  
                   <th>Add To List</th>
            </tr>
          </tfoot> -->
        
        </table>
      </div>
                 











         
        </div>
      <!--   Here is the end of right table -->
  
      </div>
      

     </div>
</div>
					          
					      
		
							
          
            
          <jsp:include page="../client_application/_application_process_footer.jsp"></jsp:include>
  
  
