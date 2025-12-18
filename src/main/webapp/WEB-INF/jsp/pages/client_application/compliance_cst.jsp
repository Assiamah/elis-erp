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
            <h1 class="h3 mb-0 text-gray-800">Consolidated Search Dashboard</h1>
             <a href="compliance" class="d-none d-sm-inline-block btn btn-sm btn-info shadow-sm"><i class="fas fa-home fa-sm text-white-50"></i>General Compliance Dashboard</a>
          </div>

          <!-- Content Row -->
         <%--  <div class="row">            
              <h2 style="text-align: center; margin: 0 auto"><br>Welcome  ${fullname} <br><br></h2> 
          </div>  --%>
		<!-- <button id="clickbutton">text</button> -->

		<input type="hidden" id="csd_compliance" value="1" />
		
		<div class="row mb-4">
			<div class="col col-12">
				<div class="card shadow ">
					<div class="card-body">
						<div class = "row mb-3"><div class="col"><h6>CST UNIT SUMMARY</h6></div></div>
						<div class="row">
							<div class="col" style="cursor:pointer" id="cst_apps_at_qc">
								<div class=" font-weight-bold text-primary text-uppercase mb-1">QC/Further Entries  </div>
								<%-- <div class="text-xs  text-dark text-uppercase">as at today (<fmt:formatDate value="${now}" type="date" />)</div> --%>
								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${apps_at_qc}</div>							
							</div>
							<div class="col" style="cursor:pointer" id="cst_cordiantor_in">
								 <div class=" font-weight-bold text-info text-uppercase mb-1">Incoming Applications for Rec Info  </div>
								<%-- <div class="text-xs  text-dark text-uppercase">as at today (<fmt:formatDate value="${now}" type="date" />)</div> --%>
								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${cordiantor_in}</div>		 				
							</div>
							<div class="col" style="cursor:pointer" id="cst_cordiantor_comp">
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
									
										<div class=" text-primary text-uppercase mb-1 text-right"><a href="#" class="open_app_withOfficers_cst" data-target_division="SMD"> Total with Officers </a> </div>
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
									
										<div class=" text-primary text-uppercase mb-1 text-right"><a href="#" class="open_app_withOfficers_cst" data-target_division="LRD"> Total with Officers </a> </div>
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
									
										<div class=" text-primary text-uppercase mb-1 text-right"><a href="#" class="open_app_withOfficers_cst" data-target_division="PVLMD"> Total with Officers </a> </div>
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
						<div class = "row mb-3"><div class="col"><h6>CST SUMMARY & SIGNING UNIT</h6></div></div>
						<div class="row">
							<div class="col" style="cursor:pointer" id="cst_summary_in">
								<div class="font-weight-bold text-primary text-uppercase mb-1">Not assigned by Unit Head  </div>
<%-- 								<div class="text-xs  text-dark text-uppercase">as at today (<fmt:formatDate value="${now}" type="date" />)</div>
 --%>								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${summary_in}</div>							
							</div>
							<div class="col" style="cursor:pointer" id="cst_summary_comp">
								 <div class=" font-weight-bold text-info text-uppercase mb-1">Completed Applications </div>
<%-- 								<div class="text-xs  text-dark text-uppercase">as at today (<fmt:formatDate value="${now}" type="date" />)</div>
 --%>								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${summary_comp}</div>		 				
							</div>
							<div class="col" style="cursor:pointer" id="cst_summary_queried">
								<div class=" font-weight-bold text-success text-uppercase mb-1">Queried Applications </div>
<%-- 								<div class="text-xs  text-dark text-uppercase">as at today (<fmt:formatDate value="${now}" type="date" />)</div>
 --%>								<div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">${summary_queried }</div>							
							</div>
							<div class="col">
							<a style="cursor:pointer" class="showOfficerModal" data-method="apps_with_division" data-url="DashboardAppsWithDivision" 
									data-type="CST SUMMARY & SIGNING UNIT" data-title="Applications Within Unit" data-date="" 
									data-unit-id="61" data-division="PVLMD">
								<div class="text-xs font-weight-bold text-success text-uppercase mb-1">Applications with Offices </div>
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
				request_type : 'load_cst_unit_chart_summary',
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