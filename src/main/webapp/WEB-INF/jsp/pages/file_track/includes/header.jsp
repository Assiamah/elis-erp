 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws_casemgt.Ws_client_application" %>
<%@ page import="ws_users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<!-- <meta http-equiv="refresh" content="620"> -->
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta charset="utf-8">
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  	<meta name="description" content="">
  	<meta name="author" content="">
  
  
  	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="manifest" href="site.webmanifest">

  	<title>Enterprise Land Information System</title>
    <link rel="stylesheet" href="./openlayers/ol.css" type="text/css">
  	<script src="openlayers/ol.js"></script>
    <script src="openlayers/proj4.js"></script>
  	<!--      <script src="./openlayers5/ol.js"></script>
        <script src="./openlayers5/proj4.js"></script> -->
  
    <script src="openlayers/ol3-layerswitcher.js"></script>
    <link rel="stylesheet" href="openlayers/ol3-layerswitcher.css" type="text/css"> 
    

  	<!-- Custom fonts for this template-->
  	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
 	<!-- <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet"> --> 


<!-- CSS -->
<link href="css/cssw/smart_wizard.css" rel="stylesheet" type="text/css" />
 <!-- Optional SmartWizard theme -->
    <link href="css/cssw/smart_wizard_theme_circles.css" rel="stylesheet" type="text/css" />
    <link href="css/cssw/smart_wizard_theme_arrows.css" rel="stylesheet" type="text/css" />
    <link href="css/cssw/smart_wizard_theme_dots.css" rel="stylesheet" type="text/css" />
    <link href="css/summernote.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/flatpickr/dark.css">
	<link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
	
	<link href="css/responsive.dataTables.min.css" rel="stylesheet" type="text/css" />
	
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" rel="stylesheet" type="text/css" />
	
	
<link rel="stylesheet" href="file_tracking_system/includes/vendors/jquery-toast-plugin/jquery.toast.min.css">

<!-- <link href="css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
 -->
  <!-- Custom styles for this template-->
  
  <link href="css/tabulator.css" rel="stylesheet">

  
  
  <link rel="stylesheet" type="text/css" href="css/css/style.css">
  <link href="css/sb-admin-2.css" rel="stylesheet">
   <link href="css/jquery.dataTables.min.css" rel="stylesheet">
  <link href="css/buttons.dataTables.min.css" rel="stylesheet">
  
 <script src="vendor/jquery/jquery.min.js"></script>
 <script src="vendor/jquery/jquery.dataTables.min.js"></script>
 <script src="vendor/jquery/jquery.tabletojson.js"></script>
 

	 <script src="js/datatables-js/dataTables.buttons.min.js"></script>
	   <script src="js/datatables-js/jszip.min.js"></script>
	   <script src="js/datatables-js/pdfmake.min.js"></script>
	   <script src="js/datatables-js/vfs_fonts.js"></script>
	 <!-- <script src="js/datatables-js/pdfmake.min.js.map"></script> -->
	   <script src="vendor/datatables/buttons.colVis.min.js"></script>
	   <script src="js/datatables-js/buttons.html5.min.js"></script>
 	   <script src="js/datatables-js/buttons.print.min.js"></script>
	   <script src="vendor/datatables/dataTables.responsive.min.js"></script>
	 
	 
 
 
 	 <script src="js/js/jquery.steps.min.js"></script>
 	 <!-- <script src="js/js/parsley.min.js"></script> -->
 	  <script src="js/flatpickr.js"></script>
 	  
 	  <script src="js/jquery.inactivityTimeout.min.js"></script>
 	  
 	  <link rel="stylesheet" href="css/bootstrap-multiselect.min.css" type="text/css">
 	  <script type="text/javascript" src="js/bootstrap-multiselect.min.js"></script>
 <link href="legal/includes/bootstrap/css/bootstrap.min.css" rel="stylesheet">
 	 <!-- Toastr -->
  <link rel="stylesheet" href="legal/includes/bootstrap/css/toastr.min.css">



  <link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-calendar/latest/tui-calendar.css" />

<!-- If you use the default popups, use this. -->
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css" />

	
 <script>
 
 $(document).ready(function(){
	 
	 
 /* localStorage.setItem('userid', '${userid}');
 localStorage.setItem('fullname','${fullname}');
 localStorage.setItem('division', '${division}' );
 localStorage.setItem('user_level', '${user_level}' ); 
 
 sessionStorage.setItem("username", "..."); */

/* localStorage.setItem('application_stage', '${application_stage}' ); */

	 localStorage.setItem('user_level', '${user_level}' ); 
	 
	 $(document).inactivityTimeout({
         inactivityWait: 1200,
         dialogWait: 60,
         logoutUrl: 'Logout'
     })
 }); 
 



				
 </script>
 
 <style>
	 .btn{
	    border-radius: 0 !important;
	}
	.card{
		 /* offset-x | offset-y | blur-radius | spread-radius | color */
	  /* -webkit-box-shadow: -2px -2px 15px 7px rgba(0,0,0,0.5);
	  -moz-box-shadow: -3px -3px 15px 7px rgba(0,0,0,0.5);
	  box-shadow: 0 -4px 15px 7px rgba(0,0,0,0.5); */
	}
	.card, .card-header,  .breadcrumb{
		border-radius: 0 !important;
	}
	 .modal {
	  overflow-y:auto;
	 
	}
  	#radioBtn .notActive, #radioBtnBatching .notActive{
	    color: #3276b1;
	    background-color: #fff;
	    cursor: pointer;
	}
  
  	#label{
	    margin-bottom:10px;
	    border : 1px solid red;
	    width : 150px;
	    height : 20px;
	    line-height : 20px;
	    position:relative;
	    text-align : center;
	}
	
	.modal-body_lg  {
	    max-height: calc(100vh - 210px);
	    overflow-y: auto;
	}


	.tr-completed-work {background-color: #006400  !important; color: white !important;}
	.tr-passed-3-days{background-color: #FFC0CB  !important; }
	.tr-passed-5-days{background-color: #FA8072  !important; color: white !important;}
	.tr-passed-7-days{background-color: #800000  !important; color: white !important;}
	.modal-header { cursor: move }
	
	.card-actions {
	  /* margin-top: 20px; */
	  /* margin-bottom: 0; */
	  text-align: right;
	  list-style: none;
	  
	}
	.card-actions a {
	  color:#333;
	}
	.card-fullscreen {
	    display: block;
	    z-index: 9999;
	    position: fixed;
	    width: 100%;
	    height: 100%;
	    top: 0;
	    right: 0;
	    left: 0;
	    bottom: 0;
	    overflow: auto;
	}
	
	/* Legal custom css */
	
	ol.breadcrumb{
	padding: 15px 16px;
	}
	
	ol.breadcrumb li{
		font-size: 18px;
		font-weight:600px;
		
	}
	
	ol.breadcrumb li a{
		text-decoration:none;
	}
	
	table.dataTable tbody tr.greenClass{
	  background-color:	#33cc33;
	}
	
	table.dataTable tbody tr.redClass{
	  background-color:	red;
	}
	div.bg-active{
		background-color:#000;
		color: white;
	}
	
	.modal.right.fade .modal-dialog {
	left: -320px;
	-webkit-transition: opacity 0.3s linear, left 0.3s ease-out;
	-moz-transition: opacity 0.3s linear, left 0.3s ease-out;
	-o-transition: opacity 0.3s linear, left 0.3s ease-out;
	transition: opacity 0.3s linear, left 0.3s ease-out;
}

.modal.right.fade.show .modal-dialog {
	right: 0;
}

/* ----- MODAL STYLE ----- */
.modal-content {
	border-radius: 0;
	border: none;
}

.modal-header {
	border-bottom-color: #eeeeee;
	background-color: #fafafa;
}
ul.timeline-3 {
list-style-type: none;
position: relative;
}
ul.timeline-3:before {
content: ' ';
background: #d4d9df;
display: inline-block;
position: absolute;
left: 29px;
width: 2px;
height: 100%;
z-index: 400;
}
ul.timeline-3 > li {
margin: 20px 0;
padding-left: 20px;
}
ul.timeline-3 > li:before {
content: ' ';
background: white;
display: inline-block;
position: absolute;
border-radius: 50%;
border: 3px solid #22c0e8;
left: 20px;
width: 20px;
height: 20px;
z-index: 400;
}
  </style>
  

</head>

<body id="page-top">
	<div id="page_name" style="display:none">${page_name}</div>
	<div id="page_ready" style="display:none"></div>
	<div id="regional_code_general" style="display:none">${regional_code}</div>
  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
		<ul class="navbar-nav bg-gradient-dark4 sidebar sidebar-dark accordion text-dark" id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a class="sidebar-brand d-flex align-items-center justify-content-center"
				href="#" >
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-map-marked-alt"></i>
				</div>
				<div class="sidebar-brand-text mx-3">
					ELIS <sup>1.22</sup>
				</div>
			</a>
			
			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<!-- <li class="nav-item active"><a
				class="nav-link"
				href="#"
			> <i class="fas fa-fw fa-tachometer-alt"></i> <span>Dashboard</span></a>
			</li> -->

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">Menu</div>


			<!-- Nav Item - Tables -->


			<!--   <li class="nav-item">
        <a class="nav-link" href="tables.html">
          <i class="fas fa-fw fa-table"></i>
          <span>Tables</span></a>
      </li> -->
      
      
      <% if (session.getAttribute("userid") != null || session.getAttribute("userid") !="") { %>
		
		
			<li class="nav-item" data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/dashboard"
			> <i class="fas fa-fw fa-home"></i> <span
					class="nav-link-text "
				>DASHBOARD</span>
			</a></li> 
			
			
			

<% } %>


			<%-- <li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/client_application"
			> <i class="fas fa-fw fa-running"></i> <span
					class="nav-link-text "
				>CSAU Application</span>
			</a></li>

			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/app_database_update"
			> <i class="fas fa-fw fa-exchange-alt"></i> <span class="nav-link-text">App
						Database Update</span>
			</a></li>

			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/enquiry_desk"
			> <i class="fas fa-fw fa-newspaper"></i> <span class="nav-link-text">Enquiry
						Desk</span>
			</a></li>
			
			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/further_entries"
			> <i class="fas fa-keyboard"></i> <span class="nav-link-text">Further Entries
						</span>
			</a></li>
			
			
			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/publication_management"
			> <i class="fas fa-newspaper"></i> <span class="nav-link-text">Publication Management
						</span>
			</a></li>


			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/client_application"
			> <i class="fa fa-fw fa-area-chart"></i> <span class="nav-link-text">File
						Movement </span>
			</a></li> --%>

<%-- 
			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/user_list"
			> <i class="fas fa-fw fa-users"></i> <span class="nav-link-text">User
						Accounts </span>
			</a></li>
 --%>




		<%-- 	<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/maps_data_capture_update"
			> <i class="fas fa-fw fa-map"></i> <span class="nav-link-text">Data
						Capture Maps</span>
			</a></li>



			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/maps_internal_search"
			> <i class="fas fa-fw fa-search"></i> <span class="nav-link-text">Internal
						Search Report</span>
			</a></li>

			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/pvlmd_maps"
			> <i class="fa fa-fw fa-area-chart"></i> <span class="nav-link-text">PVLMD
						Maps</span>
			</a></li>
			
			
			
			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/lvd_comparable_maps"
			> <i class="fa fa-fw fa-area-chart"></i> <span class="nav-link-text">LVD Comparables</span>
			</a></li>



			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/comparable_mgt"
			> <i class="fa fa-fw fa-area-chart"></i> <span class="nav-link-text">LVD Comparables Mgt</span>
			</a></li>


			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/registration_application_progress_details"
			> <i class="fa fa-fw fa-area-chart"></i> <span class="nav-link-text">Registration
						Process </span>
			</a></li>





			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/case_movement_module"
			> <i class="fas fa-fw fa-server"></i> <span class="nav-link-text">Case
						Management</span>
			</a></li>



			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/smd_plan_approval_case_plottings"
			> <i class="fas fa-fw fa-server"></i> <span class="nav-link-text">SMD Case Plottings</span>
			</a></li>
			
			
			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/data_upload_template"
			> <i class="fas fa-fw fa-server"></i> <span class="nav-link-text">Data Upload Template</span>
			</a></li>
			

			<li
				class="nav-item"
				data-toggle="tooltip"
				data-placement="right"
				title="Charts"
			><a
				class="nav-link"
				href="${pageContext.request.contextPath}/user_mgt_module_servlet"
			> <i class="fas fa-fw fa-server"></i> <span class="nav-link-text">User Account Management</span>
			</a></li>
 --%>
 
 
 
 
 

			 <c:forEach
				var="menu"
				items="${menus}"
			>

				<li
					class="nav-item"
					data-toggle="tooltip"
					data-placement="right"
					title=""
				><a
					class="nav-link"
					href="${pageContext.request.contextPath}/${menu.javalink}"
				> <i class="fas fa-fw fa-table"></i> <span class="nav-link-text">${menu.profile_name}</span></a>
				</li>

			</c:forEach> 

			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button
					class="rounded-circle border-0"
					id="sidebarToggle"
				></button>
			</div>

		</ul>
		<!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Topbar Search -->
        <!--   <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
            <div class="input-group">
              <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
              <div class="input-group-append">
                <button class="btn btn-primary" type="button">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form> -->

          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

            <!-- Nav Item - Search Dropdown (Visible Only XS) -->
            <li class="nav-item dropdown no-arrow d-sm-none">
              <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-search fa-fw"></i>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                <form class="form-inline mr-auto w-100 navbar-search">
                  <div class="input-group">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                      <button class="btn btn-primary" type="button">
                        <i class="fas fa-search fa-sm"></i>
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </li>

             <!-- Nav Item - Alerts -->
            <li class="nav-item dropdown no-arrow mx-1" id="notificationSection">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-bell fa-fw"></i>
                <!-- Counter - Alerts -->
                <span class="badge badge-danger badge-counter" id="notificationBadgeCounter" style="display:none" ></span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown" >
                <h6 class="dropdown-header">
                  Alerts/Notifications Center
                </h6>
                <span id="notificationssDropdown"></span>
                <!-- <span class="dropdown-item text-center small text-gray-500" > </span> -->
              </div>
            </li>

           <%--  <!-- Nav Item - Messages -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-envelope fa-fw"></i>
                <!-- Counter - Messages -->
                <span class="badge badge-danger badge-counter">7</span>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown">
                <h6 class="dropdown-header">
                  Message Center
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div class="font-weight-bold">
                    <div class="text-truncate">${menus}</div>
                    <div class="small text-gray-500">Emily Fowler · 58m</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt="">
                    <div class="status-indicator"></div>
                  </div>
                  <div>
                    <div class="text-truncate">I have the photos that you ordered last month, how would you like them sent to you?</div>
                    <div class="small text-gray-500">Jae Chun · 1d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt="">
                    <div class="status-indicator bg-warning"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Last month's report looks great, I am very happy with the progress so far, keep up the good work!</div>
                    <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Am I a good boy? The reason I ask is because someone told me that people say this to all dogs, even if they aren't good...</div>
                    <div class="small text-gray-500">Chicken the Dog · 2w</div>
                  </div>
                </a>
                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
              </div>
            </li>  --%>

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${fullname}</span>
                <img class="img-profile rounded-circle" src="favicon-32x32.png">
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#profileUpdate">
				<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
				Profile
				</a>
                
                <!-- <a class="dropdown-item" href="#">
                  <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                  Settings
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                  Activity Log
                </a> -->
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>

          </ul>

        </nav>
        <!-- End of Topbar -->