<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<jsp:useBean id="now" class="java.util.Date" />

<style>
    /* Additional styles for the chart and modal (complements compliance.css) */
    #main-chart {
        min-height: 500px;
        width: 100%;
    }
    .division-link {
        cursor: pointer;
        text-decoration: none;
    }
    .division-link:hover {
        text-decoration: underline;
    }
</style>

<!-- Begin Page Content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Page Header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div class="d-flex align-center gap-2">
                    <div>
                        <h1 class="page-title fw-medium fs-20 mb-1">
                            <i class="ri-search-line me-2 text-info"></i>Consolidated Search Dashboard
                        </h1>
                    </div>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="compliance">Compliance</a></li>
                    <li class="breadcrumb-item active" aria-current="page">CST Dashboard</li>
                </ol>
            </div>
            <div class="mt-2">
                <a href="compliance" class="btn btn-sm btn-info shadow-sm">
                    <i class="fas fa-home fa-sm text-white-50"></i> General Compliance Dashboard
                </a>
            </div>
        </div>

        <!-- CST UNIT SUMMARY Row -->
        <div class="row mb-4">
            <div class="col-xl-4 col-md-4">
                <div class="card stat-card custom-card primary school-card" id="cst_apps_at_qc" style="cursor:pointer;">
                    <div class="card-body">
                        <div class="d-flex align-items-start gap-3">
                            <div>
                                <span class="avatar avatar-md bg-primary svg-white">
                                    <i class="ri-file-copy-line fs-4"></i>
                                </span>
                            </div>
                            <div>
                                <span class="d-block text-muted">QC / Further Entries</span>
                                <h5 class="fw-semibold mb-1">${apps_at_qc}</h5>
                                <div class="text-muted fs-12">
                                    <span class="text-success">current</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-4 col-md-4">
                <div class="card stat-card custom-card info school-card" id="cst_cordiantor_in" style="cursor:pointer;">
                    <div class="card-body">
                        <div class="d-flex align-items-start gap-3">
                            <div>
                                <span class="avatar avatar-md bg-info svg-white">
                                    <i class="ri-inbox-archive-line fs-4"></i>
                                </span>
                            </div>
                            <div>
                                <span class="d-block text-muted">Incoming for Rec Info</span>
                                <h5 class="fw-semibold mb-1">${cordiantor_in}</h5>
                                <div class="text-muted fs-12">
                                    <span class="text-success">awaiting assignment</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-4 col-md-4">
                <div class="card stat-card custom-card success school-card" id="cst_cordiantor_comp" style="cursor:pointer;">
                    <div class="card-body">
                        <div class="d-flex align-items-start gap-3">
                            <div>
                                <span class="avatar avatar-md bg-success svg-white">
                                    <i class="ri-checkbox-circle-line fs-4"></i>
                                </span>
                            </div>
                            <div>
                                <span class="d-block text-muted">Completed Ready for Summary</span>
                                <h5 class="fw-semibold mb-1">${cordiantor_comp}</h5>
                                <div class="text-muted fs-12">
                                    <span class="text-success">ready for next step</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- APPLICATIONS AT RECORD INFORMATION SUMMARY -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card custom-card">
                    <div class="card-header">
                        <div class="card-title">Applications at Record Information Summary</div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <!-- SMD Card -->
                            <div class="col-lg-4 mb-3">
                                <div class="card border shadow-sm h-100">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center mb-3">
                                            <span class="avatar avatar-sm bg-primary me-2">SMD</span>
                                            <h6 class="fw-bold mb-0">SMD</h6>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span class="text-muted">Total Count</span>
                                            <span class="fw-semibold">${cordiantor_smd}</span>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <a href="#" class="open_app_withOfficers_cst" data-target_division="SMD">
                                                With Officers
                                                </a>
                                            <!-- <span class="text-muted" class="open_app_withOfficers_cst division-link" data-target_division="SMD">With Officers</span> -->
                                            <span class="fw-semibold">
                                                <a href="#">
                                                    ${cordiantor_smd - supervisor_smd_in - supervisor_smd_comp - supervisor_smd_queried}
                                                </a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- LRD Card -->
                            <div class="col-lg-4 mb-3">
                                <div class="card border shadow-sm h-100">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center mb-3">
                                            <span class="avatar avatar-sm bg-info me-2">LRD</span>
                                            <h6 class="fw-bold mb-0">LRD</h6>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span class="text-muted">Total Count</span>
                                            <span class="fw-semibold">${cordiantor_lrd}</span>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <a href="#" class="open_app_withOfficers_cst" data-target_division="LRD">
                                                With Officers
                                                </a>
                                            <span class="fw-semibold">
                                                <a href="#" class="open_app_withOfficers_cst division-link">
                                                    ${cordiantor_lrd - supervisor_lrd_in - supervisor_lrd_comp - supervisor_lrd_queried}
                                                </a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- PVLMD Card -->
                            <div class="col-lg-4 mb-3">
                                <div class="card border shadow-sm h-100">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center mb-3">
                                            <span class="avatar avatar-sm bg-success me-2">PVLMD</span>
                                            <h6 class="fw-bold mb-0">PVLMD</h6>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span class="text-muted">Total Count</span>
                                            <span class="fw-semibold">${cordiantor_pvlmd}</span>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <a href="#" class="open_app_withOfficers_cst" data-target_division="PVLMD">
                                                With Officers
                                                </a>
                                            <span class="fw-semibold">
                                                <a href="#" class="open_app_withOfficers_cst division-link">
                                                    ${cordiantor_pvlmd - supervisor_pvlmd_in - supervisor_pvlmd_comp - supervisor_pvlmd_queried}
                                                </a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Chart -->
                        <div id="main-chart"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- CST SUMMARY & SIGNING UNIT -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card custom-card">
                    <div class="card-header">
                        <div class="card-title">CST Summary & Signing Unit</div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-xl-3 col-md-6 mb-3" id="cst_summary_in" style="cursor:pointer;">
                                <div class="card stat-card custom-card warning school-card">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start gap-3">
                                            <span class="avatar avatar-md bg-warning svg-white">
                                                <i class="ri-user-unfollow-line fs-4"></i>
                                            </span>
                                            <div>
                                                <span class="d-block text-muted">Not assigned by Unit Head</span>
                                                <h5 class="fw-semibold mb-1">${summary_in}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6 mb-3" id="cst_summary_comp" style="cursor:pointer;">
                                <div class="card stat-card custom-card success school-card">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start gap-3">
                                            <span class="avatar avatar-md bg-success svg-white">
                                                <i class="ri-check-line fs-4"></i>
                                            </span>
                                            <div>
                                                <span class="d-block text-muted">Completed Applications</span>
                                                <h5 class="fw-semibold mb-1">${summary_comp}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6 mb-3" id="cst_summary_queried" style="cursor:pointer;">
                                <div class="card stat-card custom-card danger school-card">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start gap-3">
                                            <span class="avatar avatar-md bg-danger svg-white">
                                                <i class="ri-question-line fs-4"></i>
                                            </span>
                                            <div>
                                                <span class="d-block text-muted">Queried Applications</span>
                                                <h5 class="fw-semibold mb-1">${summary_queried}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6 mb-3">
                                <div class="card stat-card custom-card primary school-card">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start gap-3">
                                            <span class="avatar avatar-md bg-primary svg-white">
                                                <i class="ri-group-line fs-4"></i>
                                            </span>
                                            <div>
                                                <span class="d-block text-muted">
                                                    <a href="#" class="showOfficerModal text-decoration-none" 
                                                       data-method="apps_with_division" 
                                                       data-url="DashboardAppsWithDivision" 
                                                       data-type="CST SUMMARY & SIGNING UNIT" 
                                                       data-title="Applications Within Unit" 
                                                       data-unit-id="61" 
                                                       data-division="PVLMD">
                                                        Applications with Officers
                                                    </a>
                                                </span>
                                                <h5 class="fw-semibold mb-1">${summary_count}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Modals (shared from compliance modals file, plus custom CST modal) -->
<!-- <jsp:include page="../../components/_compliance_modals.jsp"></jsp:include> -->

<!-- CST Unit Summary Modal (specific to this page) -->
<div class="modal fade modal-blur effect-scale"
     id="cstUnitSummaryModal"
     tabindex="-1"
     aria-labelledby="cstUnitSummaryModal"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl">

        <div class="modal-content">

            <!-- Header -->
            <div class="modal-header bg-primary text-light">

                <h5 class="modal-title">
                    <span id="cst_us_modal_name"></span>
                </h5>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <div id="sendmsg1"></div>
                <button type="button"
                        class="btn-close btn-close-white"
                        data-bs-dismiss="modal">
                </button>

            </div>


            <!-- Body -->
            <div class="modal-body">

                <div class="table-responsive">

                    <table id="cst_unit_summary_details_table"
                           class="table">

                        <thead>

                            <tr>
                                <th>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="select-all">
                    <label class="form-check-label small" for="select-all">Select All</label>
                </div>
            </th>

                                <th>Job Number</th>

                                <th>Applicant Name</th>

                                <th>Received Date</th>

                                <th>Duration</th>

                                <!-- <th>Action</th> -->

                            </tr>

                        </thead>

                        <tbody>
                        </tbody>

                    </table>

                </div>

            </div>


            <!-- Footer -->
            <div class="modal-footer">

                <button type="button"
                        class="btn btn-danger"
                        data-bs-dismiss="modal">

                    Close

                </button>

            </div>

        </div>

    </div>

</div>








<div class="modal fade modal-blur effect-scale"
     id="cstUnitSummaryModal_2"
     tabindex="-1"
     aria-labelledby="cstUnitSummaryModal_2"
     aria-hidden="true"
     data-bs-backdrop="static">

    <div class="modal-dialog modal-xl">

        <div class="modal-content">

            <!-- Header -->
            <div class="modal-header bg-primary text-light">

                <h5 class="modal-title">
                    <span id="cst_us_modal_name_2"></span>
                </h5>
                <!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <div id="sendmsg1"></div> -->
                <button type="button"
                        class="btn-close btn-close-white"
                        data-bs-dismiss="modal">
                </button>

            </div>


            <!-- Body -->
            <div class="modal-body">

                <div class="table-responsive">

                    <table id="cst_unit_summary_details_table_2"
                           class="table">

                        <thead>

                            <tr>

                                <th>Job Number</th>

                                <th>Applicant Name</th>

                                <th>Received Date</th>

                                <th>Duration</th>

                                <th>Action</th>

                            </tr>

                        </thead>

                        <tbody>
                        </tbody>

                    </table>

                </div>

            </div>


            <!-- Footer -->
            <div class="modal-footer">

                <button type="button"
                        class="btn btn-danger"
                        data-bs-dismiss="modal">

                    Close

                </button>

            </div>

        </div>

    </div>

</div>




<div class="modal fade modal-blur effect-scale"
     id="cstStaffSummaryModal"
     tabindex="-1"
     aria-labelledby="cstStaffSummaryModalLabel"
     aria-hidden="true"
     data-bs-backdrop="static">

  <div class="modal-dialog modal-xl">

    <div class="modal-content">

      <!-- Header -->
      <div class="modal-header bg-primary text-light">

        <h5 class="modal-title"
            id="cstStaffSummaryModalLabel">

          Summary of Assigned Applications for Records Information at
          <span id="cst_modal_divison_name"></span>

        </h5>

        <button type="button"
                class="btn-close btn-close-white"
                data-bs-dismiss="modal">
        </button>

      </div>


      <!-- Body -->
      <div class="modal-body">

        <div class="table-responsive">

          <table id="cst_apps_with_staff_summary_table"
                 class="table">

            <thead>

              <tr>

                <th>Staff Name</th>

                <th>No of Applications</th>

                <th>No of Overdue Applications</th>

                <th>Action</th>

              </tr>

            </thead>

            <tbody>

            </tbody>

          </table>

        </div>

      </div>


      <!-- Footer -->
      <div class="modal-footer">

        <button type="button"
                class="btn btn-secondary"
                data-bs-dismiss="modal">

          Close

        </button>

      </div>

    </div>

  </div>

</div>


 

<div class="modal fade modal-blur effect-scale"
     id="cstStaffDetailsModal"
     tabindex="-1"
     aria-labelledby="cstStaffDetailsModalLabel"
     aria-hidden="true"
     data-bs-backdrop="static">

  <div class="modal-dialog modal-xl">

    <div class="modal-content">

      <!-- Header -->
      <div class="modal-header bg-primary text-light">

        <h5 class="modal-title"
            id="cstStaffDetailsModalLabel">

          Records Information Applications with
          <span id="cst_modal_staff_name"></span>
            
        </h5>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <div id="sendmsg"></div>
        <button type="button"
                class="btn-close btn-close-white"
                data-bs-dismiss="modal">
        </button>

      </div>


      <!-- Body -->
      <div class="modal-body">

        <div class="table-responsive">

          <table id="cst_apps_with_staff_details_table"
                 class="table table-hover align-middle">

            <thead class="table-light">

              <tr>
                <th>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="select-all">
                    <label class="form-check-label small" for="select-all">Select All</label>
                </div>
            </th>

                <th>Job Number</th>

                <th>Received Date</th>

                <th>Duration</th>

                <th>Sent By</th>

                <!-- <th>Action</th> -->

              </tr>

            </thead>

            <tbody>

            </tbody>

          </table>

        </div>

      </div>


      <!-- Footer -->
      <div class="modal-footer">

        <button type="button"
                class="btn btn-danger"
                data-bs-dismiss="modal">

          Close

        </button>

      </div>

    </div>

  </div>

</div>



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

			let datatable = $("#cst_unit_summary_details_table_2")
			.DataTable({
                destroy: true, 
				dom: 'Bfrtip',						
				buttons: [
					'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
				]
			});

			var division_name = params.name;
			var application_type = params.seriesName;

			$("#cst_us_modal_name_2").html(division_name +' : '+ application_type);
			$("#cstUnitSummaryModal_2").modal("show");

			$.ajax({ 
			type : "POST",
			url : "Case_Management_Serv",
			data : {
				request_type : 'load_cst_unit_chart_summary',
				division_name : division_name,
				application_type: application_type
			},
			cache : false,
			success : function(jobdetails) {
				//console.log(jobdetails)

				// datatable.search("").draw();
				// datatable.state.clear();
				// datatable.clear();
				
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
									`<button data-job-number="`+this.job_number+`" data-staff="`+this.job_recieved_by+`" data-staff_id="`+this.job_recieved_by_id+`"  id="sendMessage"
										class="btn btn-info btn-icon-split sendMessageCSS"
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