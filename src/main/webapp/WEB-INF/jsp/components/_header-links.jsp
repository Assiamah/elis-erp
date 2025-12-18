<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

 <!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath}/assets/images/NewLogo.jpg" type="image/x-icon">

<!-- Choices JS -->
<script src="${pageContext.request.contextPath}/assets/libs/choices.js/public/assets/scripts/choices.min.js"></script>

<!-- Main Theme Js -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

<!-- Bootstrap Css -->
<link id="style" href="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" >

<!-- Style Css -->
<link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet" >

<!-- Icons Css -->
<link href="${pageContext.request.contextPath}/assets/css/icons.css" rel="stylesheet" >

<!-- Node Waves Css -->
<link href="${pageContext.request.contextPath}/assets/libs/node-waves/dist/waves.min.css" rel="stylesheet" > 

<!-- Simplebar Css -->
<link href="${pageContext.request.contextPath}/assets/libs/simplebar/dist/simplebar.min.css" rel="stylesheet" >

<!-- Color Picker Css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/@simonwep/pickr/dist/themes/nano.min.css">

<!-- Choices Css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/choices.js/public/assets/styles/choices.min.css">

<!-- FlatPickr CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/flatpickr/dist/flatpickr.min.css">

<!-- Auto Complete CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/@tarekraafat/autocomplete.js/dist/css/autoComplete.css">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Remix Icon -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.css" rel="stylesheet" >

<!-- Bootstrap Icon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<!-- Material Design Icon -->
<link href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css" rel="stylesheet">

<!-- Tabler Icon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">

<!-- intl-tel-input css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/intl-tel-input/build/css/intlTelInput.min.css">

<!-- Tagify CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/@yaireo/tagify/dist/tagify.css">

<!-- Dragsort CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/@yaireo/dragsort/dist/dragsort.css">

<!-- Dual ListBox CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/dual-listbox/dist/dual-listbox.css">

<!-- Toastify CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/toastify-js/src/toastify.css">

<!-- SweetAlert2 CSS -->
<link href="${pageContext.request.contextPath}/assets/libs/sweetalert2/dist/sweetalert2.min.css" rel="stylesheet" type="text/css">

<!-- Prism CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/prismjs/themes/prism-coy.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/gridjs/dist/theme/mermaid.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/openlayers/ol.css" type="text/css">
<script src="${pageContext.request.contextPath}/assets/openlayers/ol.js"></script>
<script src="${pageContext.request.contextPath}/assets/openlayers/proj4.js"></script>
<script src="${pageContext.request.contextPath}/assets/openlayers/ol3-layerswitcher.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/openlayers/ol3-layerswitcher.css" type="text/css">



<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"/>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.4.120/pdf.min.js"></script>

<!-- DataTables -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.3.0/css/responsive.bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.3/css/buttons.bootstrap5.min.css">
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
</script>