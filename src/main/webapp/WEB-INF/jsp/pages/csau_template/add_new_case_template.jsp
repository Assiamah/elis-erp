  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
  <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
  <jsp:include page="../includes/_header.jsp"></jsp:include>
       

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Add New Case Template - ${fullname}</h1>
<!--             <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Test Generate Report</a>
 -->          </div>
          
    
          <hr>
          
          
        
        

       <div class="row">
     
     
     
     <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-body">
					<div class="row">
      					<div class="col">
      						 <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#CreateJobNumberModal" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit" data-backdrop="static" data-keyboard="false">
			                    	<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Create New Job/Application </span>
			                   </button>
      					</div>
      					<div class="col">
      							<button  data-action="edit"  class="btn btn-primary btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#CreateJobNumberModalExisting" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit" data-backdrop="static" data-keyboard="false">
			                    	<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Create Existing Job  (with Job Number)</span>
			                   </button>
      					</div>
      				</div>
		    </div>
 		  </div>
      				            
        </div>
        
         <!--   Here is the right Table -->
        <div class="col-lg-4">
          <!-- Example Pie Chart Card-->
          	    <div class="card">
			        <h5 class="card-header" role="tab" id="headingThree">
			            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapselistofservices" aria-expanded="false" aria-controls="collapseFive">
			                <i class="fa fa-chevron-down pull-right"></i> <i class="fa fa-users"></i>Instructions
			            </a>
			        </h5>
			        <div id="collapselistofservices" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
			            <div class="card-body">
			           
	
			            </div>
			        </div>
			    </div>
	
          
          
          		<div id="accordion" role="tablist" aria-multiselectable="true">
   				</div>

      	</div>
          
      </div>
          
         
        
    
   
        
      </div>
      
      
      
      
   
      
     </div>
      
       

           
        

        </div>
        <!-- /.container-fluid -->

    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
  
  
  
  

