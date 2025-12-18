<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


		<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		<html>

		<head>
			<!-- <meta http-equiv="refresh" content="620"> -->
			<!-- <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" /> -->

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

			<!-- <link href="css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
 -->
			<!-- Custom styles for this template-->

			<link href="css/tabulator.css" rel="stylesheet">
			<link rel="stylesheet" href="legal/includes/bootstrap/css/toastr.min.css">



			<link rel="stylesheet" type="text/css" href="css/css/style.css">
			<link href="css/sb-admin-2.css" rel="stylesheet">
			<link href="css/jquery.dataTables.min.css" rel="stylesheet">
			<link href="css/buttons.dataTables.min.css" rel="stylesheet">

			<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous"> -->
			<!-- Stepper Styles -->
			<link rel="stylesheet" href="stepper-css/style.css">
			<!-- Demo CSS -->
			<!-- <link rel="stylesheet" href="stepper-css/demo.css"> -->

			<script src="vendor/jquery/jquery.min.js"></script>
			<script src="vendor/jquery/jquery.dataTables.min.js"></script>
			<script src="vendor/jquery/jquery.tabletojson.js"></script>


			<!-- <link rel="stylesheet" href="assets/login/style.css"> -->
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


			${(page_name == "compliance_no_login") ? "" : "
			<script src='js/jquery.inactivityTimeout.min.js'></script>"}

			<link rel="stylesheet" href="css/bootstrap-multiselect.min.css" type="text/css">
			<script type="text/javascript" src="js/bootstrap-multiselect.min.js"></script>



			<link rel="stylesheet" type="text/css"
				href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
			<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
			<script type="text/javascript"
				src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>


			<!-- Select2 CSS -->
			<link rel="stylesheet"
				href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/css/select2.min.css">

			<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/js/select2.min.js"></script>

<style>
  
         
			#recordDetails {
				background: linear-gradient(to right, #dff0d8, #b2dfdb);
				font-size: 14px;
				border-radius: 0.25rem 0.25rem 0 0;
			}

   
          body {
            background: linear-gradient(to right, #c6f6d5, #a2d9ce);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
          }

          .app-banner {
            background: linear-gradient(to right, #198754, #20c997);
            color: white;
            padding: 12px 20px;
            text-align: center;
            font-size: 1.1rem;
            font-weight: 500;
            border-top-left-radius: 0.5rem;
            border-top-right-radius: 0.5rem;
          }

          .record-list {
            max-height: 540px;
            overflow-y: auto;
            background-color: #fefefe;
            border-radius: 0 0 0.5rem 0.5rem;
            border: 1px solid #dee2e6;
          }

          .record-item {
            transition: all 0.3s;
          }

          .record-item:hover,
          .record-item.active {
            background-color: #d1f2eb;
            font-weight: 500;
          }

          .chat-header {
            background: linear-gradient(to right, #198754, #20c997);
            color: white;
            padding: 12px 20px;
            border-top-left-radius: 0.5rem;
            border-top-right-radius: 0.5rem;
          }

          .record-details {
            background-color: #e9f5ec;
            padding: 10px 20px;
            border-bottom: 1px solid #dee2e6;
            font-size: 15px;
          }


          .chat-box {
            height: 380px;
            overflow-y: auto;
            background-color: white;
            padding: 20px;
            border-radius: 0 0 0.5rem 0.5rem;
          }


          @keyframes fadeIn {
            to {
              opacity: 1;
              transform: translateY(0);
            }
          }

          .user-message {
            text-align: right;
          }

          .agent-message {
            text-align: left;
          }

          .message-bubble {
            display: inline-block;
            padding: 12px 18px;
            border-radius: 20px;
            max-width: 80%;
            word-wrap: break-word;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.15);
          }

          .user-bubble {
            background-color: #065f46;
            /* Deep green */
            color: white;
            border-bottom-right-radius: 5px;
          }

          .agent-bubble {
            background-color: #ecfdf5;
            /* Light green background */
            color: #065f46;
            border-bottom-left-radius: 5px;
          }

          .typing-indicator {
            color: #6c757d;
            font-style: italic;
            padding-left: 1rem;
          }

          .input-area {
            background-color: #ffffff;
            border-radius: 12px;
            padding: 10px 15px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
            margin-top: 1rem;
          }

          .error-message {
            color: #dc3545;
            padding-left: 1rem;
          }

          .ticket-icon {
            width: 16px;
          }

       

		    #btn_generate_ai_message {
    border-radius: 20px;
    padding-left: 20px;
    padding-right: 20px;
  }
      
</style>
<style>
    /* Modern UI Styles */
    :root {
        --primary-color: #3498db;
        --secondary-color: #2c3e50;
        --accent-color: #e74c3c;
        --light-gray: #f8f9fa;
        --dark-gray: #343a40;
        --success-color: #28a745;
        --warning-color: #ffc107;
        --info-color: #17a2b8;
    }
    
    .card {
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        border: none;
        margin-bottom: 20px;
    }
    
    .card-header {
        background-color: var(--secondary-color);
        color: white;
        border-radius: 8px 8px 0 0 !important;
        padding: 15px 20px;
    }
    
    .card-header h5 {
        font-weight: 600;
        margin-bottom: 0;
    }
    
    .card-header a {
        color: white;
        text-decoration: none;
    }
    
    .card-body {
        padding: 20px;
    }
    
    .badge {
        font-weight: 500;
        padding: 5px 10px;
        border-radius: 4px;
    }
    
    .form-control:read-only {
        background-color: #f8f9fa;
    }
    
    .table {
        font-size: 14px;
    }
    
    .table th {
        background-color: var(--light-gray);
        font-weight: 600;
    }
    
    .btn-icon-split {
        padding: 8px 12px;
    }
    
    .section-title {
        font-size: 1.3rem;
        color: var(--secondary-color);
        margin-bottom: 15px;
        font-weight: 600;
        border-bottom: 2px solid var(--light-gray);
        padding-bottom: 8px;
    }
    
    .case-header {
        background-color: var(--secondary-color);
        color: white;
        padding: 15px;
        border-radius: 8px;
        margin-bottom: 20px;
    }
    
    .case-header h4 {
        margin-bottom: 0;
    }
    
    .accordion-toggle::after {
        font-family: 'Font Awesome 5 Free';
        content: '\f078';
        float: right;
        transition: transform 0.3s;
    }
    
    .accordion-toggle.collapsed::after {
        content: '\f054';
    }
    
    .status-badge {
        font-size: 12px;
        padding: 4px 8px;
        border-radius: 12px;
    }
    
    .action-buttons .btn {
        margin-right: 5px;
        margin-bottom: 5px;
    }
    
    /* Map specific styles */
    #parcelMap {
        height: 300px;
        width: 100%;
        border-radius: 4px;
        margin-bottom: 15px;
    }
    
    /* Process list styles */
    .process-list {
        list-style: none;
        padding: 0;
    }
    
    .process-list li {
        padding: 12px 0;
        display: flex;
        align-items: flex-start;
    }
    
    .process-list li i {
        margin-right: 12px;
        font-size: 0.9rem;
        margin-top: 2px;
    }
    
    .process-item {
        font-weight: 500;
        font-size: 0.9rem;
    }
    
    .process-details {
        font-size: 0.8rem;
        color: var(--dark-gray);
        display: flex;
        gap: 15px;
        flex-wrap: wrap;
    }
    
    .action-list {
        list-style: none;
        padding: 0;
    }
    
    .action-list li {
        padding: 8px 0;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    
    .action-list li i {
        margin-right: 8px;
        color: var(--warning-color);
    }
    
    .action-list .btn {
        font-size: 0.8rem;
        padding: 4px 8px;
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .card-body {
            padding: 15px;
        }
        
        .form-row > div {
            margin-bottom: 15px;
        }
        
        #parcelMap {
            height: 200px;
        }
        
        .process-details {
            font-size: 0.85rem;
            gap: 10px;
        }
        
        .process-item {
            font-size: 1rem;
        }
        
        .action-list .btn {
            font-size: 0.7rem;
            padding: 3px 6px;
        }
    }
</style>
			<c:choose>
				<c:when test="${page_name != 'compliance_no_login'}">
					<script>
						window.getGeoServerEndPoint = function getGeoServerEndPoint(url = document.location.href) {
							const url_obj = new URL(url)
							let link_url;
							//   console.log(url_obj)

							switch (url_obj.hostname) {
								case '41.66.204.146':
									link_url = url_obj.protocol + '//' + url_obj.hostname + ':6065';
									break;
								//    case 'csscloudservice.com':
								// 	  link_url = url_obj.protocol + '//196.61.42.16:26060';
								//     break;

								// 	case '196.61.42.16':
								// 	  link_url = url_obj.protocol + '//196.61.42.16:26060';
								//     break;

								// 	case '10.1.0.38':
								// 	  link_url = url_obj.protocol + '//10.1.0.36:8080';
								//     break;

								case '10.4.1.47':
									link_url = url_obj.protocol + '//10.4.0.48:2020';
									break;

								case 'elis.lc.gov.gh':
									//link_url = url_obj.protocol + '//41.66.204.146:6065';
									link_url = 'http:' + '//41.66.204.146:6065';
									https://41.66.204.146:6065
									break;

								case 'localhost':
									link_url = url_obj.protocol + '//localhost:2020';
									//link_url = url_obj.protocol + '//10.4.1.53:2020';
									break;
								default:
									link_url = url_obj.protocol + '//' + url_obj.hostname + ':2020';
								//link_url = url_obj.protocol + '//' + url_obj.hostname + ':2020';
								//link_url = url_obj.protocol + '//10.4.1.53:2020';
							}

							return link_url;
						}
						/* window.getBaseDomain = function getBaseDomain (url = document.location.href) {
							 const url_obj =  new URL(url)
							 return url_obj.protocol + '//' + url_obj.hostname + url_obj.port;
					   }  */


						$(document).ready(function () {

							//console.log('location is: ' + getBaseDomain() + document.location.origin);


							//const geserver_domain = current_loc.hostname
							// console.log('hostname is: ' + getGeoServerEndPoint());



							/* localStorage.setItem('userid', '${userid}');
							localStorage.setItem('fullname','${fullname}');
							localStorage.setItem('division', '${division}' );
							localStorage.setItem('user_level', '${user_level}' ); 
						    
							sessionStorage.setItem("username", "..."); */

							/* localStorage.setItem('application_stage', '${application_stage}' ); */

							localStorage.setItem('user_level', '${user_level}');




							if ($('#page_name').text() !== 'compliance') {

								$(document).inactivityTimeout({
									inactivityWait: 1200,
									dialogWait: 60,
									logoutUrl: 'Logout'
								})


							}

						});


					</script>

				</c:when>
			</c:choose>

			<style>
				.notify {
					z-index: 9999 !important;
				}

				.btn {
					border-radius: 0 !important;
				}

				.card {
					/* offset-x | offset-y | blur-radius | spread-radius | color */
					/* -webkit-box-shadow: -2px -2px 15px 7px rgba(0,0,0,0.5);
	  -moz-box-shadow: -3px -3px 15px 7px rgba(0,0,0,0.5);
	  box-shadow: 0 -4px 15px 7px rgba(0,0,0,0.5); */
				}

				.card,
				.card-header,
				.breadcrumb {
					border-radius: 0 !important;
				}

				.modal {
					overflow-y: auto;

				}

				#radioBtn .notActive,
				#radioBtnBatching .notActive {
					color: #3276b1;
					background-color: #fff;
					cursor: pointer;
				}

				#label {
					margin-bottom: 10px;
					border: 1px solid red;
					width: 150px;
					height: 20px;
					line-height: 20px;
					position: relative;
					text-align: center;
				}

				.modal-body_lg {
					max-height: calc(100vh - 210px);
					overflow-y: auto;
				}

				div.bg-active {
					background-color: #000;
					color: white;
				}


				.tr-completed-work {
					background-color: #006400 !important;
					color: white !important;
				}

				.tr-passed-3-days {
					background-color: #FFC0CB !important;
				}

				.tr-passed-5-days {
					background-color: #FA8072 !important;
					color: white !important;
				}

				.tr-passed-7-days {
					background-color: #800000 !important;
					color: white !important;
				}

				.modal-header {
					cursor: move
				}

				.card-actions {
					/* margin-top: 20px; */
					/* margin-bottom: 0; */
					text-align: right;
					list-style: none;

				}

				.card-actions a {
					color: #333;
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

				#leftcol {
					position: fixed;
					width: 150px;
					overflow-y: scroll;
					top: 0;
					bottom: 0;
				}

				/* .container_dotp {
		display: flex;
		justify-content: center;
		align-items: center;
		min-height: 10vh;
	}

	.input_dotp {
		width: 40px;
		border: none;
		border-bottom: 3px solid rgba(0, 0, 0, 0.5);
		margin: 0 10px;
		text-align: center;
		font-size: 36px;
		cursor: not-allowed;
		pointer-events: none;
	}
	
	.input_dotp:focus {
		border-bottom: 3px solid orange;
		outline: none;
	}
	
	.input_dotp:nth-child(1) {
		cursor: pointer;
		pointer-events: all;
	} */


				.card-label {
					position: absolute;
					top: -10px;
					/* Adjust this value as needed */
					left: 20px;
					/* Adjust this value as needed */
					background-color: #0d6efd;
					/* Bootstrap primary color */
					color: white;
					padding: 2px 8px;
					border-radius: 5px;
					font-size: 0.75rem;
				}

				.otp-input {
					display: flex;
					gap: 0.5em;
				}

				.otp-input input {
					width: 4em;
					padding: 0.5em 0;
					font-family: monospace;
					font-size: 1em;
					text-align: center;
					border: none;
					border-bottom: 3px solid rgba(0, 0, 0, 0.5);
					/* cursor: not-allowed;
		pointer-events: none; */
				}

				.otp-input input:focus {
					border-bottom: 3px solid orange;
					outline: none;
				}

				/* hide spinner */
				.otp-input input::-webkit-outer-spin-button,
				.otp-input input::-webkit-inner-spin-button {
					-webkit-appearance: none;
					margin: 0;
				}

				.otp-input input[type=number] {
					-moz-appearance: textfield;
					/* Firefox */
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
				<ul class="navbar-nav bg-gradient-primary shadow sidebar sidebar-dark accordion text-white"
					id="accordionSidebar">
					<!-- <div id="leftcol"> -->
					<!-- Sidebar - Brand -->
					<a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
						<div class="sidebar-brand-icon rotate-n-15">
							<i class="fas fa-map-marked-alt"></i>
						</div>
						<div class="sidebar-brand-text mx-3">
							ELIS <sup>3.0</sup>
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


					<% if (session.getAttribute("userid") !=null || session.getAttribute("userid") !="" ) { %>


						<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Charts"><a
								class="nav-link" href="${pageContext.request.contextPath}/dashboard"> <i
									class="fas fa-fw fa-home"></i> <span class="nav-link-text ">DASHBOARD</span>
							</a></li>

						<% } %>


							<%-- <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Charts"><a
									class="nav-link" href="${pageContext.request.contextPath}/client_application"> <i
										class="fas fa-fw fa-running"></i> <span class="nav-link-text ">CSAU
										Application</span>
								</a></li>

								<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Charts"><a
										class="nav-link" href="${pageContext.request.contextPath}/app_database_update">
										<i class="fas fa-fw fa-exchange-alt"></i> <span class="nav-link-text">App
											Database Update</span>
									</a></li>

								<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Charts"><a
										class="nav-link" href="${pageContext.request.contextPath}/enquiry_desk"> <i
											class="fas fa-fw fa-newspaper"></i> <span class="nav-link-text">Enquiry
											Desk</span>
									</a></li>

								<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Charts"><a
										class="nav-link" href="${pageContext.request.contextPath}/further_entries"> <i
											class="fas fa-keyboard"></i> <span class="nav-link-text">Further Entries
										</span>
									</a></li>


								<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Charts"><a
										class="nav-link"
										href="${pageContext.request.contextPath}/publication_management"> <i
											class="fas fa-newspaper"></i> <span class="nav-link-text">Publication
											Management
										</span>
									</a></li>


								<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Charts"><a
										class="nav-link" href="${pageContext.request.contextPath}/client_application">
										<i class="fa fa-fw fa-area-chart"></i> <span class="nav-link-text">File
											Movement </span>
									</a></li> --%>

								<%-- <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Charts"><a
										class="nav-link" href="${pageContext.request.contextPath}/user_list"> <i
											class="fas fa-fw fa-users"></i> <span class="nav-link-text">User
											Accounts </span>
									</a></li>
									--%>




									<%-- <li class="nav-item" data-toggle="tooltip" data-placement="right"
										title="Charts"><a class="nav-link"
											href="${pageContext.request.contextPath}/maps_data_capture_update"> <i
												class="fas fa-fw fa-map"></i> <span class="nav-link-text">Data
												Capture Maps</span>
										</a></li>



										<li class="nav-item" data-toggle="tooltip" data-placement="right"
											title="Charts"><a class="nav-link"
												href="${pageContext.request.contextPath}/maps_internal_search"> <i
													class="fas fa-fw fa-search"></i> <span
													class="nav-link-text">Internal
													Search Report</span>
											</a></li>

										<li class="nav-item" data-toggle="tooltip" data-placement="right"
											title="Charts"><a class="nav-link"
												href="${pageContext.request.contextPath}/pvlmd_maps"> <i
													class="fa fa-fw fa-area-chart"></i> <span
													class="nav-link-text">PVLMD
													Maps</span>
											</a></li>



										<li class="nav-item" data-toggle="tooltip" data-placement="right"
											title="Charts"><a class="nav-link"
												href="${pageContext.request.contextPath}/lvd_comparable_maps"> <i
													class="fa fa-fw fa-area-chart"></i> <span class="nav-link-text">LVD
													Comparables</span>
											</a></li>



										<li class="nav-item" data-toggle="tooltip" data-placement="right"
											title="Charts"><a class="nav-link"
												href="${pageContext.request.contextPath}/comparable_mgt"> <i
													class="fa fa-fw fa-area-chart"></i> <span class="nav-link-text">LVD
													Comparables Mgt</span>
											</a></li>


										<li class="nav-item" data-toggle="tooltip" data-placement="right"
											title="Charts"><a class="nav-link"
												href="${pageContext.request.contextPath}/registration_application_progress_details">
												<i class="fa fa-fw fa-area-chart"></i> <span
													class="nav-link-text">Registration
													Process </span>
											</a></li>





										<li class="nav-item" data-toggle="tooltip" data-placement="right"
											title="Charts"><a class="nav-link"
												href="${pageContext.request.contextPath}/case_movement_module"> <i
													class="fas fa-fw fa-server"></i> <span class="nav-link-text">Case
													Management</span>
											</a></li>



										<li class="nav-item" data-toggle="tooltip" data-placement="right"
											title="Charts"><a class="nav-link"
												href="${pageContext.request.contextPath}/smd_plan_approval_case_plottings">
												<i class="fas fa-fw fa-server"></i> <span class="nav-link-text">SMD Case
													Plottings</span>
											</a></li>


										<li class="nav-item" data-toggle="tooltip" data-placement="right"
											title="Charts"><a class="nav-link"
												href="${pageContext.request.contextPath}/data_upload_template"> <i
													class="fas fa-fw fa-server"></i> <span class="nav-link-text">Data
													Upload Template</span>
											</a></li>


										<li class="nav-item" data-toggle="tooltip" data-placement="right"
											title="Charts"><a class="nav-link"
												href="${pageContext.request.contextPath}/user_mgt_module_servlet"> <i
													class="fas fa-fw fa-server"></i> <span class="nav-link-text">User
													Account Management</span>
											</a></li>
										--%>







										<c:forEach var="menu" items="${menus}">

											<li class="nav-item" data-toggle="tooltip" data-placement="right" title="">
												<a class="nav-link"
													href="${pageContext.request.contextPath}/${menu.javalink}"> <i
														class="fas fa-fw fa-table"></i> <span
														class="nav-link-text">${menu.profile_name}</span></a>
											</li>

										</c:forEach>


										<!-- Divider -->
										<hr class="sidebar-divider d-none d-md-block">

										<!-- Sidebar Toggler (Sidebar) -->
										<div class="text-center d-none d-md-inline">
											<button class="rounded-circle border-0" id="sidebarToggle"></button>
										</div>

				</ul>
				<!-- End of Sidebar -->
				<!-- </div> -->
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
									<a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
										data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										<i class="fas fa-search fa-fw"></i>
									</a>
									<!-- Dropdown - Messages -->
									<div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
										aria-labelledby="searchDropdown">
										<form class="form-inline mr-auto w-100 navbar-search">
											<div class="input-group">
												<input type="text" class="form-control bg-light border-0 small"
													placeholder="Search for..." aria-label="Search"
													aria-describedby="basic-addon2">
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
									<a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
										data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										<i class="fas fa-bell fa-fw"></i>
										<!-- Counter - Alerts -->
										<span class="badge badge-danger badge-counter" id="notificationBadgeCounter"
											style="display:none"></span>
									</a>
									<!-- Dropdown - Alerts -->
									<div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
										aria-labelledby="alertsDropdown">
										<h6 class="dropdown-header">
											Alerts/Notifications Center
										</h6>
										<span id="notificationssDropdown"></span>
										<!-- <span class="dropdown-item text-center small text-gray-500" > </span> -->
									</div>
								</li>

								<!-- Nav Item - Messages -->
								<li class="nav-item dropdown no-arrow mx-1">
									<a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
										data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										<i class="fas fa-envelope fa-fw"></i>
										<!-- Counter - Messages -->
										<span class="badge badge-danger badge-counter" id="messageBadgeCounter"
											style="display:none"></span>
									</a>
									<!-- Dropdown - Messages -->
									<div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
										aria-labelledby="messagesDropdown">
										<h6 class="dropdown-header">
											Message Center
										</h6>
										<span id="messageDropdown"></span>
										<a class="dropdown-item text-center small text-gray-500"
											href="message_center">Read More Messages</a>
									</div>
								</li>

								<div class="topbar-divider d-none d-sm-block"></div>

								<!-- Nav Item - User Information -->
								<li class="nav-item dropdown no-arrow">
									<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
										data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										<span class="mr-2 d-none d-lg-inline text-gray-600 small">${fullname} - Region: ${regional_name} - District: ${district_name}</span>
										<img class="img-profile rounded-circle" src="favicon-32x32.png">
									</a>


									<!-- Dropdown - User Information -->
									<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
										aria-labelledby="userDropdown">

										<a class="dropdown-item" href="#" data-toggle="modal"
											data-target="#profileUpdate">
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
										<a class="dropdown-item" href="#" data-toggle="modal"
											data-target="#logoutModal">
											<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
											Logout
										</a>
									</div>
								</li>

							</ul>

						</nav>
						<!-- End of Topbar -->