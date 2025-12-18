<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:include page="../legal/includes/header.jsp"></jsp:include>
<!-- Begin Page Content -->
   <div class="container-fluid">
	<section class="section dashboard">
     	<div class="row mb-4">
      		<!-- Left side columns -->
        <div class="col-lg-12">
          <div class="row">

            <!-- Assigned Cases Card -->
            <div class="col-xl-4 col-md-6" id="incoming">
              <div class="card border-left-primary shadow h-100 py-2">

                <div class="card-body">
	                  		<h5 class="card-title">Cases <span>| Incoming</span></h5>
					
							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<i class="fas fa-calendar fa-2x text-primary"></i>
								</div>
								 <div class="">	
		                     	 	<h4 id="incoming_count"></h4>
								 </div>
		                    </div>
                </div>

              </div>
            </div><!-- Assigned Cases Card -->

            <!-- Unit Cases Card -->
            <div class="col-xl-4 col-md-6" id="unit">
              <div class="card border-left-success shadow h-100 py-2">

               <div class="card-body">
                  <h5 class="card-title">Cases <span>| Unit</span></h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="fas fa-calendar fa-2x text-success"></i>
                    </div>
                    <div class="">
                      <h4 id="unit_count"></h4>

                    </div>
                  </div>
                </div>

              </div>
            </div><!-- Unit Cases Card -->

            <!-- Archived Cases Card -->
            <div class="col-xl-4 col-md-6" id="month">
			 
              <div class="card border-left-info shadow h-100 py-2">

                <div class="card-body">
                    <h5 class="card-title">Cases <span>| All</span></h5>

                <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="fas fa-calendar fa-2x text-info"></i>
                    </div>
                    <div class="ps-3">
                      <h4></h4>

                    </div>
                  </div>

                </div>
              </div>
			 
            </div><!-- Archived Cases Card -->
     	
     
     </div>
    </div>
  </div>

	      <div class="row">
	            <div class="col-md-12">
	              <div class="card">
	                <div class="card-body">
	                	  <h5 class="card-title">Received Writ <span>| Secretariat</span></h5>
	                  <div class="tab-content">
					            <div id="" class="table-responsive">
					                <table class="table " id="table_list" >
	              
		                   	        </table>
					            </div>
					    </div>
	                </div>
	              </div>
	            </div>
	          </div>

     </section>

	</div>
<!-- End Page Content -->

 <!-- Incoming Modal-->
   <div class="modal fade" id="incomingModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Incoming | Cases</h5>
           
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
            <!--  <div class="col-12">
				<div class="gap-2 mt-3 mb-3" style="float:right;">
	                
	              </div>
             </div> -->
          </div>
                <!-- Buttons  -->
			 <!-- Buttons  -->
          <div class="modal-body">
            <div class="row">
                   <div id="" class="table-responsive">
                  <table class="table" id="incoming_list">
                  
                  </table>
                  </div>
            	</div>

          	</div>
          	<div class="modal-footer">
          		 <button  class="btn btn-success" type="button" id="receive_physical" >Receive Physical Document </button>
            	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          	</div>
        </div>
      </div>
    </div>
<!-- Incoming Modal-->
<jsp:include page="../legal/includes/footer.jsp"></jsp:include>
<script type="text/javascript" src="legal/includes/pages_script/legal_unit.js"></script>