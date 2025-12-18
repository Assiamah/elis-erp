<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
 <jsp:useBean id="now" class="java.util.Date"/>    


<!-- Division Modal-->
<div class="modal fade" data-position="0" id="divisionModal" tabindex="-1" role="dialog"
	aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row"></div>
			</div>
		</div>
	</div>
</div>




<div class="modal fade show" data-position="1" id="divisionModal1" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-modal="true">
	<div class="modal-dialog modal-xl ui-draggable" role="document">
		<div class="modal-content">
			<div class="modal-header ui-draggable-handle">
				<h5 class="modal-title" id="divisionModalLabel1"></h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row"><div class="col-xl-3 col-md-6 mb-4" id="Applications_by_subservice" data-id="4"  data-name="APPLICATION FOR STAMPING">
                  <div class="card border-left-info shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">APPLICATION FOR STAMPING</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="smd_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="SMD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4" id="Applications_by_subservice1" data-id="16"  data-name="APPLICATION FOR CONSENT">
                  <div class="card border-left-default shadow">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">APPLICATION FOR CONSENT</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="lrd_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="LRD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4" id="Applications_by_subservice2" data-id="3" data-name="APPLICATION FOR REGISTRATION">
                  <div class="card border-left-danger shadow">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> APPLICATION FOR REGISTRATION</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="pvlmd_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="PVLMD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div><div class="col-xl-3 col-md-6 mb-4" id="Applications_by_subservice3" data-id="5"  data-name="APPLICATION FOR SEARCH (CONSOLIDATED)">
                  <div class="card border-left-secondary shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> APPLICATION FOR SEARCH (CONSOLIDATED)</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="lvd_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="LVD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>

				<!-- <div class="col-xl-3 col-md-6 mb-4" id="rloToday" data-id="RLO">
                  <div class="card border-left-warning shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> RLO</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="rlo_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div> -->
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="RLO" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      <!-- </div>
                    </div>
                  </div>
                </div> -->

				
			</div>
			</div>
		</div>
	</div>
</div>








<div class="modal fade show" data-position="1" id="divisionModal2" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-modal="true">
	<div class="modal-dialog modal-xl ui-draggable" role="document">
		<div class="modal-content">
			<div class="modal-header ui-draggable-handle">
				<h5 class="modal-title" id="divisionModalLabel2"></h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row"><div class="col-xl-3 col-md-6 mb-4" id="Applications_by_subservice_month" data-id="4"  data-name="APPLICATION FOR STAMPING">
                  <div class="card border-left-info shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">APPLICATION FOR STAMPING</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="stamping_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="SMD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4" id="Applications_by_subservice1_month" data-id="16"  data-name="APPLICATION FOR CONSENT">
                  <div class="card border-left-default shadow">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">APPLICATION FOR CONSENT</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="consent_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="LRD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4" id="Applications_by_subservice2_month" data-id="3" data-name="APPLICATION FOR REGISTRATION">
                  <div class="card border-left-danger shadow">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> APPLICATION FOR REGISTRATION</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="regnum_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="PVLMD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div><div class="col-xl-3 col-md-6 mb-4" id="Applications_by_subservice3_month" data-id="5"  data-name="APPLICATION FOR SEARCH (CONSOLIDATED)">
                  <div class="card border-left-secondary shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> APPLICATION FOR SEARCH (CONSOLIDATED)</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="search_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="LVD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>

				<!-- <div class="col-xl-3 col-md-6 mb-4" id="rloToday" data-id="RLO">
                  <div class="card border-left-warning shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> RLO</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="rlo_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div> -->
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="RLO" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      <!-- </div>
                    </div>
                  </div>
                </div> -->

				
			</div>
			</div>
		</div>
	</div>
</div>







<div class="modal fade show" data-position="1" id="divisionModal3" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-modal="true">
	<div class="modal-dialog modal-xl ui-draggable" role="document">
		<div class="modal-content">
			<div class="modal-header ui-draggable-handle">
				<h5 class="modal-title" id="divisionModalLabel3"></h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row"><div class="col-xl-3 col-md-6 mb-4" id="completed_apps_by_subservice_day" data-id="4"  data-name="APPLICATION FOR STAMPING">
                  <div class="card border-left-info shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">APPLICATION FOR STAMPING</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="completed_day_stamping_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="SMD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4" id="completed_apps_by_subservice_day1" data-id="16"  data-name="APPLICATION FOR CONSENT">
                  <div class="card border-left-default shadow">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">APPLICATION FOR CONSENT</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="completed_day_consent_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="LRD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4" id="completed_apps_by_subservice_day2" data-id="3" data-name="APPLICATION FOR REGISTRATION">
                  <div class="card border-left-danger shadow">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> APPLICATION FOR REGISTRATION</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="completed_day_regnumber_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="PVLMD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div><div class="col-xl-3 col-md-6 mb-4" id="completed_apps_by_subservice_day3" data-id="5"  data-name="APPLICATION FOR SEARCH (CONSOLIDATED)">
                  <div class="card border-left-secondary shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> APPLICATION FOR SEARCH (CONSOLIDATED)</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="completed_day_search_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="LVD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>

				<!-- <div class="col-xl-3 col-md-6 mb-4" id="rloToday" data-id="RLO">
                  <div class="card border-left-warning shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> RLO</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="rlo_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div> -->
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="RLO" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      <!-- </div>
                    </div>
                  </div>
                </div> -->

				
			</div>
			</div>
		</div>
	</div>
</div>








<div class="modal fade show" data-position="1" id="divisionModal4" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-modal="true">
	<div class="modal-dialog modal-xl ui-draggable" role="document">
		<div class="modal-content">
			<div class="modal-header ui-draggable-handle">
				<h5 class="modal-title" id="divisionModalLabel4"></h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row"><div class="col-xl-3 col-md-6 mb-4" id="smdDayCompleted" data-id="SMD">
                  <div class="card border-left-info shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> SMD</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="smd_count_completed_day">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="SMD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4" id="lrdDayCompleted" data-id="LRD">
                  <div class="card border-left-default shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> LRD</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="lrd_count_completed_day">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="LRD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4" id="pvlmdDayCompleted" data-id="PVLMD">
                  <div class="card border-left-danger shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> PVLMD</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="pvlmd_count_completed_day">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="PVLMD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div><div class="col-xl-3 col-md-6 mb-4" id="lvdDayCompleted" data-id="LVD">
                  <div class="card border-left-secondary shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> LVD</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="lvd_count_completed_day">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="LVD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div><div class="col-xl-3 col-md-6 mb-4" id="rloDayCompleted" data-id="RLO">
                  <div class="card border-left-warning shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> RLO</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="rlo_count_completed_day">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="RLO" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div></div>
			</div>
		</div>
	</div>
</div>










<div class="modal fade show" data-position="1" id="divisionModal5" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-modal="true">
	<div class="modal-dialog modal-xl ui-draggable" role="document">
		<div class="modal-content">
			<div class="modal-header ui-draggable-handle">
				<h5 class="modal-title" id="divisionModalLabel5"></h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                <input type="hidden" id="officer_startDate">
				<input type="hidden" id="officer_endDate">

				<div class="row" id="services_row">

				


               
			
			</div>
			</div>
		</div>
	</div>
</div>






<div class="modal fade show" data-position="1" id="divisionModal6" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-modal="true">
	<div class="modal-dialog modal-xl ui-draggable" role="document">
		<div class="modal-content">
			<div class="modal-header ui-draggable-handle">
				<h5 class="modal-title" id="divisionModalLabel6"></h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                <input type="hidden" id="officer_rec_comp_startDate">
				<input type="hidden" id="officer_rec_comp_endDate">

				<div class="row" id="services_row1">
			
				</div>
			</div>
		</div>
	</div>
</div>






<div class="modal fade show" data-position="1" id="divisionModal7" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-modal="true">
	<div class="modal-dialog modal-xl ui-draggable" role="document">
		<div class="modal-content">
			<div class="modal-header ui-draggable-handle">
				<h5 class="modal-title" id="divisionModalLabel7"></h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
                <input type="hidden" id="officer_comp_startDate">
				<input type="hidden" id="officer_comp_endDate">

				<div class="row" id="services_row2">
			
				</div>
			
			</div>
			</div>
		</div>
	</div>
</div>










<div class="modal fade show" data-position="1" id="divisionModal8" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-modal="true">
	<div class="modal-dialog modal-xl ui-draggable" role="document">
		<div class="modal-content">
			<div class="modal-header ui-draggable-handle">
				<h5 class="modal-title" id="divisionModalLabel8"></h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row"><div class="col-xl-3 col-md-6 mb-4" id="completed_apps_by_subservice_month" data-id="4"  data-name="APPLICATION FOR STAMPING">
                  <div class="card border-left-info shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">APPLICATION FOR STAMPING</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="completed_month_stamping_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="SMD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4" id="completed_apps_by_subservice_month1" data-id="16"  data-name="APPLICATION FOR CONSENT">
                  <div class="card border-left-default shadow">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">APPLICATION FOR CONSENT</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="completed_month_consent_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="LRD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-4" id="completed_apps_by_subservice_month2" data-id="3" data-name="APPLICATION FOR REGISTRATION ">
                  <div class="card border-left-danger shadow">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> APPLICATION FOR REGISTRATION</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="completed_month_regnumber_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="PVLMD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div><div class="col-xl-3 col-md-6 mb-4" id="completed_apps_by_subservice_month3" data-id="5"  data-name="APPLICATION FOR SEARCH (CONSOLIDATED)">
                  <div class="card border-left-secondary shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> APPLICATION FOR SEARCH (CONSOLIDATED)</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="completed_month_search_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="LVD" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      </div>
                    </div>
                  </div>
                </div>

				<!-- <div class="col-xl-3 col-md-6 mb-4" id="rloToday" data-id="RLO">
                  <div class="card border-left-warning shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> RLO</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="rlo_count">0</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div> -->
                        <!-- <a href="#" data-method="summary_created" data-period="month" data-by="service_type" data-url="Corporate_DashboardDivisionSummary" data-type="RLO" data-title="Applications Received" data-date="This Month (June)" class="showServiceTypeModal text-decoration-none stretched-link">
              </a> -->
                      <!-- </div>
                    </div>
                  </div>
                </div> -->

				
			</div>
			</div>
		</div>
	</div>
</div>




<div class="modal fade" data-position="0" id="serviceTypeModal" tabindex="-1" role="dialog"
	aria-labelledby="serviceTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="serviceTypeModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<input type="hidden" id="service_user_id">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-data="name" data-name="name">Service Name</th>
										<th data-data="total" data-name="total">Count</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
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
				<form class="generate-chart form-inline">
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
				</form>
			</div>
		</div>
	</div>
</div>




<!-- Application Type Modal-->
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
        
                            <!-- <table id="csau_staff_daily_apps_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
                               <thead>
                                    <th>Service Name</th>
                                    <th>Count</th>
                                    <th>Action</th>
                              </thead>
                                  <tbody>        
                                  </tbody>
                            </table>
                        </div> 
						<!-- <div class="col-12">
							<div class="chart"></div>
						</div> -->
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<!-- <form class="generate-chart form-inline">
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
                <button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>

			</div>
		</div>
	</div>
</div>

<!-- Units Modal-->
<div class="modal fade" data-position="0" id="unitModal" tabindex="-1" role="dialog"
	aria-labelledby="unitModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="unitModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                   }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="name" data-data="name">Unit</th>
										<th data-name="total" data-data="total">Count</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
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
				<form class="generate-chart form-inline">
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
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Officers Modal-->
<div class="modal fade" data-position="0" id="officerModal" tabindex="-1" role="dialog"
	aria-labelledby="officerModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="officerModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="name" data-data="name">Officer</th>
										<th data-name="total" data-data="total">Count</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
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
				<form class="generate-chart form-inline">
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
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Applications Modal-->
<div class="modal fade" data-position="0" id="applicationsModal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="job_number" data-data="job_number">Job Number</th>
										<th data-name="ar_name" data-data="ar_name">Applicant Name</th>
										<th data-name="business_process_sub_name" data-data="business_process_sub_name">Application Type</th>
										<th data-name="created_date" data-data="created_date">Submission Date</th>
										<th data-name="due_date" data-data="due_date">Date Received by Officer</th>
										<th data-name="days_due" data-data="days_due">Pending Days</th>
										<th data-name="days_since_batched" data-data="days_since_batched">Days With Officer</th>
										<!-- <th data-name="job_purpose" data-data="job_purpose">Purpose</th> -->
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
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
				<form class="generate-applications-chart form-inline">
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
				</form>
			</div>
		</div>
	</div>
</div>












<div class="modal fade" data-position="0" id="applicationsModal1" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel1"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" id="services_applications">
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
                <button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>

			</div>
		</div>
	</div>
</div>





<div class="modal fade" data-position="0" id="new_modal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="job_number" data-data="job_number">Job Number</th>
										<th data-name="ar_name" data-data="ar_name">Applicant Name</th>
										<th data-name="business_process_sub_name" data-data="business_process_sub_name">Application Type</th>
										<th data-name="created_date" data-data="created_date">Submission Date</th>
										<th data-name="due_date" data-data="due_date">Date Received by Officer</th>
										<th data-name="days_due" data-data="days_due">Pending Days</th>
										<th data-name="days_since_batched" data-data="days_since_batched">Days With Officer</th>
										<th data-name="job_purpose" data-data="job_purpose">Purpose</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
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
				<form class="generate-applications-chart form-inline">
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
				</form>
			</div>
		</div>
	</div>
</div>











<div class="modal fade" data-position="0" id="completedapplicationsModal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="job_number" data-data="job_number">Job Number</th>
										<th data-name="ar_name" data-data="ar_name">Applicant Name</th>
										<th data-name="business_process_sub_name" data-data="business_process_sub_name">Application Type</th>
										<th data-name="created_date" data-data="created_date">Submission Date</th>
										<th data-name="completed_date" data-data="completed_date">Completed Date</th>
										<th data-name="days_due" data-data="days_due">TAT</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
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
				<form class="generate-applications-chart form-inline">
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
				</form>
			</div>
		</div>
	</div>
</div>




<!-- Send Message Modal-->
<div class="modal fade" data-position="0" id="sendMessageModal" tabindex="-1" role="dialog"
	aria-labelledby="sendMessageModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="sendMessageModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<form method="post" id="message-form" action="SendComplianceMessage">
					<input id="officer_id" name="officer_id" type="hidden"/>
					<input id="request_type" value="send_compliance_message" type="hidden">
					<input id="officer_name" name="officer_name" type="hidden"/>
					<input id="job_numbers" name="job_numbers[]" type="hidden"/>
				  <div class="mb-3">
				    <label for="message_type" class="form-label">Message Type</label>
				    <select required class="form-control" name="message_type" id="message_type">
				    	<option value="">Select One</option>
				    	<option value="query">Query</option>
				    	<option value="Warning">Warning</option>
				    </select>
				  </div>
				  <div class="mb-3">
				    <label for="message" class="form-label">Message</label>
				    <textarea required class="form-control" name="message" id="message"></textarea>
				  </div>
				  <button type="submit" class="btn btn-primary">Submit</button>
				</form>
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







<div class="modal fade" id="apps_recieved_within_dates_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Recieved Within Dates</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
              
				<form class="" method="POST">
						<div class="row">

							<div class="col-md-6">
							<div class="mb-4">
							 <label class="form-label" for="val-username">Start Date<span class="text-danger">*</span></label>
							 <input type="date" class="form-control" id="startDate" name="startDate" >
						   </div>
						 </div>
	   
						   <div class="col-md-6">
						   <div class="mb-4">
							 <label class="form-label" for="val-username">End Date<span class="text-danger">*</span></label>
							 <input type="date" class="form-control" id="endDate"  name="endDate" >
						   </div>
						 </div>
					 
						 </div>
                
            </div>
			<div class="modal-footer">
				<button class="btn btn-success" id="submit_Btn" type="button" >Submit <i class="fa fa-save"></i></button>
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</form>
		</div>
	</div>
</div>




<div class="modal fade" id="apps_recieved_completed_within_dates_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Recieved And Completed Within Dates</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
              
				<form class="" method="POST">
						<div class="row">

							<div class="col-md-6">
							<div class="mb-4">
							 <label class="form-label" for="val-username">Start Date<span class="text-danger">*</span></label>
							 <input type="date" class="form-control" id="rec_comp_startDate" name="startDate" >
						   </div>
						 </div>
	   
						   <div class="col-md-6">
						   <div class="mb-4">
							 <label class="form-label" for="val-username">End Date<span class="text-danger">*</span></label>
							 <input type="date" class="form-control" id="rec_comp_endDate"  name="endDate" >
						   </div>
						 </div>
					 
						 </div>
                
            </div>
			<div class="modal-footer">
				<button class="btn btn-success" id="submit_Btn2" type="button" >Submit <i class="fa fa-save"></i></button>
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</form>
		</div>
	</div>
</div>





<div class="modal fade" id="apps_completed_within_dates_modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Applications Completed Within Dates</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true"> <i class="fa fa-times"></i></span>
				</button>
			</div>
			<div class="modal-body">
              
				<form class="" method="POST">
						<div class="row">

							<div class="col-md-6">
							<div class="mb-4">
							 <label class="form-label" for="val-username">Start Date<span class="text-danger">*</span></label>
							 <input type="date" class="form-control" id="completed_startDate" name="startDate" >
						   </div>
						 </div>
	   
						   <div class="col-md-6">
						   <div class="mb-4">
							 <label class="form-label" for="val-username">End Date<span class="text-danger">*</span></label>
							 <input type="date" class="form-control" id="completed_endDate"  name="endDate" >
						   </div>
						 </div>
					 
						 </div>
                
            </div>
			<div class="modal-footer">
				<button class="btn btn-success" id="submit_Btn1" type="button" >Submit <i class="fa fa-save"></i></button>
				<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
			</div>
		</form>
		</div>
	</div>
</div>










<div class="modal fade" id="main_service_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="main_service_modal_title"></h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="main_service_table" width="100%" cellspacing="0">
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Service Name</th>
						<th>Count</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
			</div> 
		</div>
		<div class="modal-footer">
			<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
		</div>
	</div>
</div>
</div>





<div class="modal fade" id="sub_service_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="sub_service_modalLabel"></h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="sub_service_table" width="100%" cellspacing="0">
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Sub Service Name</th>
						<th>Count</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
			</div> 
		</div>
		<div class="modal-footer">
			<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
		</div>
	</div>
</div>
</div>









<div class="modal fade" id="sub_service_modal1" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="sub_service_modalLabel1"></h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="sub_service_table1" width="100%" cellspacing="0">
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Sub Service Name</th>
						<th>Count</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
			</div> 
		</div>
		<div class="modal-footer">
			<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
		</div>
	</div>
</div>
</div>







<div class="modal fade" id="banks_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="banks_modalLabel"> </h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<input type="hidden" id="subprocessid">
				<input type="hidden" id="completed_subprocessid">
				<input type="hidden" id="service_to_bank_name">
				<table class="table table-bordered table-hover" id="banks_table" width="100%" cellspacing="0">
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Bank Name</th>
						<th>Count</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
			</div> 
		</div>
		<div class="modal-footer">
			<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
		</div>
	</div>
</div>
</div>





<div class="modal fade" id="banks_modal1" tabindex="-1" role="dialog" aria-labelledby="banks_modalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="banks_modalLabel1"></h5>
                <button class="close text-white" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="fa fa-times"></i></span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Report Summary Section -->
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Report Summary</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="stat-card bg-info text-white p-3 rounded">
                                            <h6 class="stat-title">Total Applications</h6>
                                            <h3 class="stat-value" id="totalApplications">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="stat-card bg-success text-white p-3 rounded">
                                            <h6 class="stat-title">Top Bank</h6>
                                            <h3 class="stat-value" id="topBank">-</h3>
                                            <small id="topBankCount">0 applications</small>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="stat-card bg-warning text-white p-3 rounded">
                                            <h6 class="stat-title">Average per Bank</h6>
                                            <h3 class="stat-value" id="avgPerBank">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="stat-card bg-danger text-white p-3 rounded">
                                            <h6 class="stat-title">Date Range</h6>
                                            <h3 class="stat-value" id="dateRange">-</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Visualization Section -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-bar mr-2"></i>Applications by Bank</h6>
                            </div>
                            <div class="card-body">
                                <canvas id="bankChart" height="250"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Distribution</h6>
                            </div>
                            <div class="card-body">
                                <canvas id="distributionChart" height="250"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Detailed Data Section -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light d-flex justify-content-between align-items-center">
                                <h6 class="mb-0"><i class="fas fa-table mr-2"></i>Detailed Report</h6>
                                <div class="btn-group">
                                    <!-- <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="fas fa-download mr-1"></i> Export
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-right">
                                        <a class="dropdown-item export-btn" href="#" data-type="csv"><i class="fas fa-file-csv mr-2"></i>CSV</a>
                                        <a class="dropdown-item export-btn" href="#" data-type="excel"><i class="fas fa-file-excel mr-2"></i>Excel</a>
                                        <a class="dropdown-item export-btn" href="#" data-type="pdf"><i class="fas fa-file-pdf mr-2"></i>PDF</a>
                                        <a class="dropdown-item export-btn" href="#" data-type="print"><i class="fas fa-print mr-2"></i>Print</a>
                                    </div> -->
                                </div>
                            </div>
                            <div class="card-body">
                                <input type="hidden" id="subprocessid">
                                <input type="hidden" id="completed_subprocessid">
                                <input type="hidden" id="service_to_bank_name">
                                <table class="table table-bordered table-hover table-striped" id="banks_table1" width="100%" cellspacing="0">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th>Bank Name</th>
                                            <th>Count</th>
                                            <th>Percentage</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                    <tfoot>
                                        <tr class="font-weight-bold">
                                            <td>Total</td>
                                            <td id="totalCount">0</td>
                                            <td>100%</td>
                                            <td></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
				<button type="button" class="btn btn-primary" id="downloadFullReport">
                    <i class="fas fa-save mr-1"></i> Save Report Images
                </button>

                <button type="button" class="btn btn-danger" data-dismiss="modal">
                    <i class="fas fa-times mr-1"></i> Close
                </button>
                

				<!-- <div class="modal-header bg-primary text-white">
					<h5 class="modal-title" id="banks_modalLabel"></h5>
					<button type="button" class="btn btn-light ml-2" id="downloadFullReport">
						<i class="fas fa-download mr-1"></i> Download Full Report
					</button>
					<button class="close text-white" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true"><i class="fa fa-times"></i></span>
					</button>
				</div> -->


            </div>
        </div>
    </div>
</div>







<div class="modal fade" id="banks_apps_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="banks_apps_modalLabel">Applications Recieved </h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="banks_apps_table" width="100%" cellspacing="0">
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
					<th>Job Number</th>
					<th>Applicant Name</th>
					<th>Application Type</th>
					<th>Submission Date</th>
					<th>Date Received by Officer</th>
					<th>Pending Days</th>
					<th>Days With Officer</th>
					<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
			</div> 
		</div>
		<div class="modal-footer">
			<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
		</div>
	</div>
</div>
</div>










<div class="modal fade" id="banks_apps_completed_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="banks_apps_completed_modalLabel">Applications Recieved </h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="banks_apps_completed_table" width="100%" cellspacing="0">
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
					<th>Job Number</th>
					<th>Applicant Name</th>
					<th>Application Type</th>
					<th>Submission Date</th>
					<th>Date Completed</th>
					<th>Days Completed</th>
					<th>Date Collected</th>
					<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
			</div> 
		</div>
		<div class="modal-footer">
			<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
		</div>
	</div>
</div>
</div>










<div class="modal fade" id="bank_reporting_modal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
	  <div class="modal-content">
		<div class="modal-header bg-dark text-white">
		  <h5 class="modal-title" id="modalTitle">Applications Received</h5>
		  <button class="close text-white" type="button" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>
		</div>
  
		<div class="modal-body">
		  <!-- Summary Cards -->
		  <div class="row text-center mb-3" id="reportSummary">
			<div class="col-md-3">
			  <div class="alert alert-primary"><strong>Total Applications</strong><br><span id="totalApplications">0</span></div>
			</div>
			<div class="col-md-3">
			  <div class="alert alert-success"><strong>Unique Banks</strong><br><span id="uniqueBanks">0</span></div>
			</div>
			<div class="col-md-3">
			  <div class="alert alert-warning"><strong>Service Types</strong><br><span id="uniqueServices">0</span></div>
			</div>
			<div class="col-md-3">
			  <div class="alert alert-info"><strong>Sub Services</strong><br><span id="uniqueSubServices">0</span></div>
			</div>
		  </div>
  
		  <!-- Chart -->
		  <div class="mb-4">
			<canvas id="appsByBankChart" height="100"></canvas>
		  </div>
  
		  <!-- Group By Filter -->
		  <div class="form-inline mb-2">
			<label for="groupByColumn">Group By:&nbsp;</label>
			<select id="groupByColumn" class="form-control">
			  <option value="0">Bank Name</option>
			  <option value="3">Application Type</option>
			  <option value="5">Sub Service</option>
			</select>
		  </div>
  
		  <!-- Table -->
		  <div class="table-responsive">
			<table class="table table-bordered table-hover" id="bank_reporting_table" width="100%">
			  <thead>
				<tr>
				  <th>Bank Name</th>
				  <th>Job Number</th>
				  <th>Applicant Name</th>
				  <th>Application Type</th>
				  <th>Submission Date</th>
				  <th>Sub Service Name</th>
				  <th>Action</th>
				</tr>
			  </thead>
			  <tbody></tbody>
			</table>
		  </div>
		</div>
  
		<div class="modal-footer">
		  <button class="btn btn-danger" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
		</div>
	  </div>
	</div>
  </div>

