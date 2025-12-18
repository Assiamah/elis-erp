  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
  <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
  <jsp:include page="../includes/_header.jsp"></jsp:include>
       
<!-- Begin Page Content -->
<div class="container-fluid">
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h5 class="m-0 text-dark">REVENUES PER SERVICE</h5>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->
	<div class="content">
	      <div class="container-fluid">
	        <div class="row">
	          <div class="col-lg-3">
	            <div class="card">
	            	<div class="card-header">
	            		<h6 class="card-title">Filter</h6>
	            	</div>
	            	<div class="card-body">
	            		<div class="row mb-2">
	            			<div class="form-group">
	            				<label>Filter by</label>
	            				<select class="form-control filter" style="width: 100%;">
	            					<option selected="selected" value="">All</option>
	            					<option value="">Others</option>
	            				</select>
	            			</div>
	            		</div>
	            		<div class="row">
	            			<div class="form-group">
                  				<label>Date</label>
                  				<div class="input-group">
                    				<div class="input-group-prepend"><span class="input-group-text"><i class="fa fa-calendar-alt"></i></span>
                    				</div>
                    				<input type="date" class="form-control" data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy" data-mask>
                  				</div>
                  			</div>
                  		</div>
                  		<div class="row mb-2">
                  				<div class="form-group ">
                  					<div class="input-group">
	                    				<div class="input-group-prepend"><span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
	                    				</div>
	                    				<input type="date" class="form-control" data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy" data-mask>
	                  				</div>
	            				</div>
	            		</div>
	            		<div class="row mb-2">
	            			<div class="form-group">
	            				<label>Transaction Type</label>
	            				<div class="input-group">
			            			<div class="input-group-prepend">
		                    			<button type="button" class="btn btn-danger">Volume	</button>
		                  			</div>
          							<button type="button" class="btn btn-danger">Count</button>
	            				</div>
	            			</div>
	            		</div>
	            			
	            		<div class="row mb-2">
	            			<div class="form-group">
                    			<label>Cut-Off Point</label>
                    			<input type="text" class="form-control" >
                  			</div>
	            		</div>
	  
	            		<div class="row mb-2">
	            			<div class="form-group">
	            				<label>Export Type</label>
	            				<div class="input-group">
	            					<div class="input-group-prepend">
                    					<button type="button" class="btn btn-danger">PDF</button>
                  					</div>
                  						<button type="button" class="btn btn-danger">CSV</button>
	            				</div>
	            			</div>
	            		</div>
	            		<div class="row mb-2">
	            			<div class="form-group">
                  				<button type="button" class="btn btn-danger">Count</button>
	            			</div>
	            		</div>
	           	</div>
	    	</div>
	    </div>
	
	           <div class="col-lg-9">
	            <div class="card">
	            	<div class="container-fluid">
       			
				        <div class="row">
				          <div class="col-lg-4 col-6">
				            <!-- Card -->
				            <div class="card ">
				            	<div class="card-body">
				
					                <h3>GHC</h3>
					                <p>Total Amount</p>
					              
					             </div>
					        </div>
				          </div>

				            <div class="col-lg-4 col-6">
				            <!-- Card -->
				            <div class="card ">
				            	<div class="card-body">
					              
					                <h3>GHC</h3>
					                <p>Average Amount per Transaction</p>
					       
					              
					            </div>
					        </div>
				          </div>
				      

				        
				            <div class="col-lg-4 col-6">
				            <!-- Card -->
				            <div class="card ">
				            	<div class="card-body">
					              
					                <h3>GHC</h3>
					                <p>Total Count</p>
					              
					            </div>
					        </div>
				          </div>
				         
          
        			</div>
             		<!-- /.row -->
	            </div>
	            <!-- Container -->
	           </div>
	           <!-- Card -->
	        </div>
	        <!-- col -->
	      </div>
	      <!-- row -->

	</div>
	<!-- Container -->
</div>
<!-- Content -->
</div>
<jsp:include page="../includes/_ticket_footer.jsp"></jsp:include>