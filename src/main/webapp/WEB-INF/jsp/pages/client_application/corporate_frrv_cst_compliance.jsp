<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- <%@ page import="com.report_class.cls_reports" %> --%>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<jsp:useBean id="now" class="java.util.Date" />

<jsp:include page="../includes/_header.jsp"></jsp:include>
       

              <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Corporate Compliance Dashboard</h1>
             <a href="compliance" class="d-none d-sm-inline-block btn btn-sm btn-info shadow-sm"><i class="fas fa-home fa-sm text-white-50"></i>General Compliance Dashboard</a>
          </div>

          <!-- Content Row -->
         <%--  <div class="row">            
              <h2 style="text-align: center; margin: 0 auto"><br>Welcome  ${fullname} <br><br></h2> 
          </div>  --%>
		<!-- <button id="clickbutton">text</button> -->

		<input type="hidden" id="csd_compliance" value="1" />
		<input type="hidden" id="page_name_cst" value="${page_name}" />

		<!-- <ol class="breadcrumb">
			<li class="breadcrumb-item text-uppercase text-gray-800">Corporate Processing Units</li>
		</ol> -->
		
		  <!-- <div class="row">
			<div class="col-xl-4 col-md-6 mb-4" id="corporate_stamping_unit_staff" data-id="1252" data-name="CORPORATE STAMPING UNIT">
				<div class="card border-left-primary shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="font-weight-bold text-primary text-uppercase mb-1"> 
									CORPORATE STAMPING UNIT</div>
								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${stamping_unit_count}</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-file fa-2x text-gray-300"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
		
			<div class="col-xl-4 col-md-6 mb-4" id="corporate_registration_unit_staff" data-id="1253" data-name="CORPORATE REGISTRATION UNIT">
				<div class="card border-left-success shadow h-100 py-2">
		
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="font-weight-bold text-success text-uppercase mb-1">
									CORPORATE REGISTRATION UNIT</div>
								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${registration_unit_count}</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-file fa-2x text-gray-300"></i>
							</div>
						</div>
					</div>
		
				</div>
			</div>
		
			<div class="col-xl-4 col-md-6 mb-4" id="corporate_concurrence_unit_staff" data-id="1254"  data-name="CORPORATE ESTATES/SEARCH UNIT">
				<div class="card border-left-info shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="font-weight-bold text-info text-uppercase mb-1">CORPORATE ESTATES/SEARCH UNIT
								</div>
		
									<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${estates_unit_count}</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-clock fa-2x text-gray-300"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div> -->

		<div class="row">
			<!-- Application Received -->
			<div id="app-past-due-year" class="col-lg-6 mb-4">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-black">Applications Past Due</h6>
						<span class="small text-primary"><span class="count">0</span> Applications for
							<fmt:formatDate value="${now}" pattern="Y" /></span>
					</div>
					<div data-method="corporate_apps" data-period="past_due" data-url="Corporate_DashboardAppsRecieved" data-next-level-modal="showCorporateStaffModal" data-title="Applications Past Due Date" data-date="This Year (<fmt:formatDate value='${now}' pattern='Y' />)" class="content-body card-body"></div>
				</div>
		
			</div>
		
			<div id="app-with-divisions" class="col-lg-6 mb-4">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-black">Applications With Divisions </h6>
						<span class="small text-primary"><span class="count">0</span> Applications</span>
					</div>
					<div data-method="apps_with_division"  data-url="Corporate_DashboardAppsRecieved" data-next-level-modal="showCorporateStaffModal2" data-title="Applications With Divisions" class="content-body card-body"></div>
				</div>
			</div>
		
		
		
		</div>
		
		<div class="row mb-4">
			<div class="col col-12">
				<div class="card shadow ">
					<div class="card-body">
						<!-- <div class = "row mb-3"><div class="col"><h6>FRRV/CST UNIT SUMMARY</h6></div></div> -->
						<div class="row">
							<div class="col" style="cursor:pointer" id="frrv_cst_apps_at_qc">
								<div class=" font-weight-bold text-primary text-uppercase mb-1">QC/Further Entries  </div>
								<%-- <div class="text-xs  text-dark text-uppercase">as at today (<fmt:formatDate value="${now}" type="date" />)</div> --%>
								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${apps_at_qc}</div>							
							</div>
							<div class="col" style="cursor:pointer" id="frrv_cst_cordiantor_in">
								 <div class=" font-weight-bold text-info text-uppercase mb-1">FRRV/CST Incoming Applications for Rec Info  </div>
								<%-- <div class="text-xs  text-dark text-uppercase">as at today (<fmt:formatDate value="${now}" type="date" />)</div> --%>
								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${cordiantor_in}</div>		 				
							</div>
							<div class="col" style="cursor:pointer" id="frrv_cst_cordiantor_comp">
								<div class=" font-weight-bold text-success text-uppercase mb-1">Completed Ready for Summary </div>
								<%-- <div class="text-xs  text-dark text-uppercase">as at today (<fmt:formatDate value="${now}" type="date" />)</div> --%>
								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${cordiantor_comp }</div>							
							</div>
							<%-- <div class="col">
								<div class="text-xs font-weight-bold text-success text-uppercase mb-1">Queried Applications </div>
								<div class="text-xs  text-dark text-uppercase">as at today (<fmt:formatDate value="${now}" type="date" />)</div>
								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${cordiantor}</div>							
							</div> --%>
						</div>						
					</div>
				</div>
			</div>
		</div>
		
		<div class="row mb-4">
			<div class="col col-12">
				<div class="card shadow py-2">				
					<div class="card-body">
						<div class = "row mb-3"><div class="col"><h6>APPLICATIONS AT RECORD INFORMATION SUMMARY</h6></div></div>
						<div class="row">
							<div class="col">
								<div class="card border-left-primary shadow h-100 py-2">
								<div class="row px-3">
									<div class="col-3 border-right-primary">
										<div class="font-weight-bold text-primary text-uppercase  h3 text-left">SMD </div>
									</div>
								
								
									<div class="col">
										<div class=" text-primary text-uppercase mb-1"> Total Count  </div>
										<div class="h5 mb-0 font-weight-bold text-gray-800"> ${cordiantor_smd}</div>
									</div>
									<div class="col">
									
										<div class=" text-primary text-uppercase mb-1 text-right"><a href="#" class="open_app_withOfficers_frrv_cst" data-target_division="SMD"> Total with Officers </a> </div>
										<div class="h5 mb-0 font-weight-bold text-gray-800 text-right"> ${cordiantor_smd - supervisor_smd_in - supervisor_smd_comp - supervisor_smd_queried }</div>
									</div>
								</div>
									</div>				
							</div>
							<div class="col ">
								<div class="card border-left-info shadow h-100 py-2">
								<div class="row px-3">
									<div class="col-3 border-right-info">
										<div class="font-weight-bold text-info text-uppercase  h3 text-left">LRD </div>
									</div>
								
								
									<div class="col">
										<div class=" text-primary text-uppercase mb-1"> Total Count  </div>
										<div class="h5 mb-0 font-weight-bold text-gray-800"> ${cordiantor_lrd}</div>
									</div>
									<div class="col">
									
										<div class=" text-primary text-uppercase mb-1 text-right"><a href="#" class="open_app_withOfficers_frrv_cst" data-target_division="LRD"> Total with Officers </a> </div>
										<div class="h5 mb-0 font-weight-bold text-gray-800 text-right"> ${cordiantor_lrd - supervisor_lrd_in - supervisor_lrd_comp - supervisor_lrd_queried }</div>
									</div>
								</div>
											</div>		
							</div>
							<div class="col ">
								<div class="card border-left-success shadow h-100 py-2">
								<div class="row px-3">
									<div class="col-3 border-right-primary">
										<div class="font-weight-bold text-success text-uppercase  h3 text-left">PVLMD </div>
									</div>
								
								
									<div class="col">
										<div class=" text-primary text-uppercase mb-1"> Total Count  </div>
										<div class="h5 mb-0 font-weight-bold text-gray-800"> ${cordiantor_pvlmd}</div>
									</div>
									<div class="col">
									
										<div class=" text-primary text-uppercase mb-1 text-right"><a href="#" class="open_app_withOfficers_frrv_cst" data-target_division="PVLMD"> Total with Officers </a> </div>
										<div class="h5 mb-0 font-weight-bold text-gray-800 text-right"> ${cordiantor_pvlmd - supervisor_pvlmd_in - supervisor_pvlmd_comp - supervisor_pvlmd_queried }</div>
									</div>
								</div>
										</div>			
							</div>
							
						</div>
						
						
						
						<hr><br><br>
			<div class="row">
							<div id = "main-chart" style="min-height:500px ; width:100%"></div>
						</div>
					</div>
				</div>
			</div>
			
			
		</div>
        <!-- <div class="card shadow col-12 py-2">
        	<div class="card-body">
				<div class = "row mb-3"><div class="col"><h6>APPLICATIONS AT RECORD INFORMATION DETAILS</h6></div></div>
				       <div class="row">
							<div id = "main-chart" style="min-height:500px ; width:100%"></div>
						</div>
					</div>
		</div>  -->
		
		<div class="row mb-4 mt-4">
			<div class="col col-12">
				<div class="card shadow ">
					<div class="card-body">
						<div class = "row mb-3"><div class="col"><h6>SUMMARY & SIGNING</h6></div></div>
						<div class="row">
							<div class="col" style="cursor:pointer" id="frrv_cst_summary_in">
								<div class="font-weight-bold text-primary text-uppercase mb-1">Not assigned by Unit Head  </div>
<%-- 								<div class="text-xs  text-dark text-uppercase">as at today (<fmt:formatDate value="${now}" type="date" />)</div>
 --%>								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${summary_in}</div>							
							</div>
							<div class="col" style="cursor:pointer" id="frrv_cst_summary_comp">
								 <div class=" font-weight-bold text-info text-uppercase mb-1">Completed Applications </div>
<%-- 								<div class="text-xs  text-dark text-uppercase">as at today (<fmt:formatDate value="${now}" type="date" />)</div>
 --%>								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${summary_comp}</div>		 				
							</div>
							<div class="col" style="cursor:pointer" id="frrv_cst_summary_queried">
								<div class=" font-weight-bold text-success text-uppercase mb-1">Queried Applications </div>
<%-- 								<div class="text-xs  text-dark text-uppercase">as at today (<fmt:formatDate value="${now}" type="date" />)</div>
 --%>								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${summary_queried }</div>							
							</div>
							<div class="col">
							<a style="cursor:pointer" class="showOfficerModal" data-method="apps_with_division" data-url="DashboardAppsWithDivision" 
									data-type="CST SUMMARY & SIGNING UNIT" data-title="Applications Within Unit" data-date="" 
									data-unit-id="61" data-division="PVLMD">
								<div class="font-weight-bold text-success text-uppercase mb-1">Applications with Offices </div>
								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">
									${summary_count}				
								</div>	
								</a>		
							</div> 
						</div>						
					</div>
				</div>
			</div>
		</div>
	
        
        
		
        
</div>
        

<div class="modal fade" data-position="0" id="serviceTypeModal1" tabindex="-1" role="dialog"
	aria-labelledby="serviceTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="serviceTypeModalLabel1"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="table-responsive">
                            <table class="table table-bordered table-hover" id="services_table" width="100%" cellspacing="0">
                                       <thead>
                                    <th>Staff Name</th>
                                    <th>Count</th>
                                    <th>Action</th>
                              </thead>
                                  <tbody>        
                                  </tbody>
                            </table>
                        </div> 
					</div>
				</div>
			</div>
			<div class="modal-footer">
				
                <button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>

			</div>
		</div>
	</div>
</div>






<div class="modal fade" data-position="0" id="corporate_unit_staff_apps_modals" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabelRecievedYear"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table table-bordered table-hover" id="corporate_unit_staff_apps_table" width="100%" cellspacing="0">
								<thead>
									<tr>
										<th>Job Number</th>
										<th>Applicant Name</th>
										<th>Application Type</th>
										<th>Submission Date</th>
										<th>Date Received by Officer</th>
										<th>Pending Days</th>
										<th>Days With Officer</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<!-- <form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form> -->
			</div>
		</div>
	</div>
</div>




<div class="modal fade" id="cabinetModal" tabindex="-1" role="dialog"
	aria-labelledby="addInspectionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addMinutesModalLabel">Application
					Tracking History</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-8">
						<div class="card">
							<div class="card-header">History</div>
							<div class="card-body">
								<table class="table table-bordered" id="cabinet-tracking">
									<thead>
										<tr>
											<th>Comments</th>
											<th>Division/Unit</th>
											<th>Batching Officer</th>
											<th>Date</th>
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							</div>
						</div>




					</div>
					<div class="col-md-4">
						<div class="card">
							<div class="card-header">Details</div>
							<div class="card-body">
								<form >
									<fieldset>
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Applicant
												Name</label>

											<textarea readonly class="form-control"
												id="enq_applicant_name"></textarea>

										</div>

										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Applicant type</label> 
											<input type="text" readonly class="form-control" id="enq_applicant_type">

										</div>
									</fieldset>
									<hr>
									<fieldset>
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Cabinet
												Name</label> <input type="text" readonly class="form-control"
												id="enq_cabinet_name">
										</div>
										<hr>
										<!-- <div class="form-group ">
									    <label for="staticEmail" class=" col-form-label">Shelve Number</label>
									      <input type="text" readonly class="form-control" id="shelve_number" value="3C">
									 </div> -->
										 <div class="form-group ">
									    <label for="staticEmail" class=" col-form-label">Job Purpose</label>
									      <textarea  readonly class="form-control" id="enq_job_purpose" rows="4"></textarea>
									 </div> 
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Job
												Status</label> 
												<textarea readonly class="form-control"
												id="enq_job_status" rows="4"></textarea>
												
										</div>
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Application Status
												</label> 
												<textarea  readonly class="form-control" id="enq_current_application_status" rows="4"></textarea>
												
										</div>
									</fieldset>


								</form>
							</div>
						</div>
					</div>

				</div>


			</div>
		</div>
	</div>
</div>
        
        
        <!-- /.container-fluid -->

    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
  
  
  <script type="text/javascript">
  $(document).ready(function() {
	  console.log ("labels:" )
		//Draw graph
		try{
  var chartDom = document.getElementById('main-chart');
  var myChart = echarts.init(chartDom);
  var option;

  option = {
		  toolbox: {
			    show: true,
			    feature: {
			      
			      dataView: {
			        readOnly: true
			      },
			      magicType: {
			        type: ["line", "bar"]
			      },
			      restore: {},
			      saveAsImage: {}
			    }
			  },
    legend: {},
    tooltip: {},
    dataset: {
      dimensions: [
        'Applications',
        'Not assigned by Supervisor',
        'Completed Report Pending Supervisor Approval',
        'Queried'
      ],
      source: [
        {
          'Applications': 'SMD',
          'Not assigned by Supervisor': `${supervisor_smd_in}`,
          'Completed Report Pending Supervisor Approval': `${supervisor_smd_comp}`,
          'Queried': `${supervisor_smd_queried}`
        },
        {
          'Applications': 'LRD',
          'Not assigned by Supervisor': `${supervisor_lrd_in}`,
          'Completed Report Pending Supervisor Approval': `${supervisor_lrd_comp}`,
          'Queried': `${supervisor_lrd_queried}` 
        },
        {
          'Applications': 'PVLMD',
          'Not assigned by Supervisor': `${supervisor_pvlmd_in}`,
          'Completed Report Pending Supervisor Approval': `${supervisor_pvlmd_comp}`,
          'Queried': `${supervisor_pvlmd_queried}`
        }
      ]
    },
    color: [
      '#5470c6',
      '#91cc75',
      '#ee6666',
      '#73c0de',
      '#3ba272',
      '#fc8452',
      '#9a60b4',
      '#ea7ccc'
    ],
    xAxis: { type: 'category' },
    yAxis: {},
    // Declare several bar series, each will be mapped
    // to a column of dataset.source by default.
    series: [
      { type: 'bar', label: { show: true, rotate: 90 } },
      { type: 'bar', label: { show: true, rotate: 90 } },
      { type: 'bar', label: { show: true, rotate: 90 } }
    ]
  };

  

 myChart.setOption(option);
		}catch(e){
			console.log ("Errors: "+ e);
		
		}
		myChart.on('click', function(params) {
			// console.log(params)
			// alert(params.name)

			let datatable = $("#cst_unit_summary_details_table")
			.DataTable({
				dom: 'Bfrtip',						
				buttons: [
					'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
				]
			});

			var division_name = params.name;
			var application_type = params.seriesName;

			$("#cst_us_modal_name").html(division_name +' : '+ application_type);
			$("#cstUnitSummaryModal").modal("show");

			$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_corporate_frrv_cst_unit_chart_summary',
				division_name : division_name,
				application_type: application_type
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				datatable.search("").draw();
				datatable.state.clear();
				datatable.clear();
				
				try{
					var json_p = JSON.parse(jobdetails);
					
					$(json_p.data).each(function() {
						//Add to table
						datatable.row
						.add(
								[

									this.job_number,
									this.ar_name,
									this.date_received,
									this.duration,
									// '<button data-job-number="'+ this.job_number +'" data-staff="{"staff":"' + this.job_recieved_by +'","staff_id":"' + this.job_recieved_by_id +'"}" class="btn btn-info btn-icon-split sendMessage">'
									// + '<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>'
									// + '</button>'
									`<button data-job-number="`+this.job_number+`" id="sendMessage" data-staff='{"staff":"`+this.job_recieved_by+`","staff_id":"`+this.job_recieved_by_id+`"}'
										class="btn btn-info btn-icon-split "
									>
									<span class="icon text-white-50"> <i class="fas fa-envelope"></i></span><span class="text">Send Message</span>
									</button>`,
									

								]).draw(false);
					});

				
				}catch(e){
					
				}
				
			}

		});

	});

	
		
  });
  
  </script>