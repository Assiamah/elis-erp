<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Scroll To Top -->
<div class="scrollToTop">
    <span class="arrow lh-1"><i class="ri-arrow-up-line fs-18"></i></span>
</div>
<div id="responsive-overlay"></div>
<!-- Scroll To Top -->

<!-- Popper JS -->
<script src="${pageContext.request.contextPath}/assets/libs/@popperjs/core/dist/umd/popper.min.js"></script>

<!-- Bootstrap JS -->
<script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

<!-- Defaultmenu JS -->
<script src="${pageContext.request.contextPath}/assets/js/defaultmenu.min.js"></script>

<!-- Node Waves JS-->
<script src="${pageContext.request.contextPath}/assets/libs/node-waves/dist/waves.min.js"></script>

<!-- Sticky JS -->
<script src="${pageContext.request.contextPath}/assets/js/sticky.js"></script>

<!-- Simplebar JS -->
<script src="${pageContext.request.contextPath}/assets/libs/simplebar/dist/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/simplebar.js"></script>

<!-- axios js -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<!-- Auto Complete JS -->
<script src="${pageContext.request.contextPath}/assets/libs/@tarekraafat/autocomplete.js/dist/autoComplete.min.js"></script>

<!-- intl-tel-input JS -->
<script src="${pageContext.request.contextPath}/assets/libs/intl-tel-input/build/js/intlTelInput.min.js"></script>

<!-- Color Picker JS -->
<script src="${pageContext.request.contextPath}/assets/libs/@simonwep/pickr/dist/pickr.es5.min.js"></script>

<!-- Date & Time Picker JS -->
<script src="${pageContext.request.contextPath}/assets/libs/flatpickr/dist/flatpickr.min.js"></script>

<!-- Apex Charts JS -->
<!-- <script src="${pageContext.request.contextPath}/assets/libs/apexcharts/dist/apexcharts.min.js"></script> -->

<!-- Sales Dashboard --> 
<!-- <script src="${pageContext.request.contextPath}/assets/js/sales-dashboard.js"></script> -->

<!-- Tagify JS -->
<!-- <script src="${pageContext.request.contextPath}/assets/libs/@yaireo/tagify/dist/tagify.js"></script> -->
<!-- Dragsort JS -->
<script src="${pageContext.request.contextPath}/assets/libs/@yaireo/dragsort/dist/dragsort.js"></script>

<!-- Dual ListBox JS -->
<!-- <script src="${pageContext.request.contextPath}/assets/libs/dual-listbox/dist/dual-listbox.js"></script> -->
<!-- Internal Advanced Forms JS -->
<script src="${pageContext.request.contextPath}/assets/js/form-advanced.js"></script>
<!-- Internal Tagify JS -->
<!-- <script src="${pageContext.request.contextPath}/assets/js/tagify.js"></script> -->
<!-- Custom JS -->
<script src="${pageContext.request.contextPath}/assets/js/custom.js"></script>

<!-- Select2 Cdn -->
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<!-- Internal Select-2.js -->
<script src="${pageContext.request.contextPath}/assets/js/select2.js"></script>

<!-- Toastify JS -->
<script src="${pageContext.request.contextPath}/assets/libs/toastify-js/src/toastify.js"></script>

<!-- Prism JS -->
<script src="${pageContext.request.contextPath}/assets/libs/prismjs/prism.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/prism-custom.js"></script>

<!-- SweetAlert2 JS -->
<script src="${pageContext.request.contextPath}/assets/libs/sweetalert2/dist/sweetalert2.min.js"></script>

<script src="${pageContext.request.contextPath}/assets/js/config.js"></script>

<!-- Grid JS -->
<script src="${pageContext.request.contextPath}/assets/libs/gridjs/dist/gridjs.umd.js"></script>

<!-- Echarts-->
${(page_name == "compliance_cst") || (page_name == "compliance") || (page_name=="unit_case_management_revised") || (page_name == "account-reports") || (page_name=="compliance_no_login") ? "<script src='assets/libs/echarts/dist/echarts.min.js'></script> " : ""}

<!-- Datatables Cdn -->
<script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.3.0/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.3/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.print.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.6/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.html5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>


<script src="${pageContext.request.contextPath}/js-pages/csau_online.js"></script>
<script src="${pageContext.request.contextPath}/js-pages/app_scripts.js"></script>
<script src="${pageContext.request.contextPath}/js-pages/global.js"></script>
<script src="${pageContext.request.contextPath}/js-pages/all_functions.js"></script>
<script src="${pageContext.request.contextPath}/js-pages/inactivity_check.js"></script>

<script src="${pageContext.request.contextPath}/assets/libs/jsw/jquery.smartWizard.js" type="text/javascript"></script>

${page_name == "case_processing" ? "<script src='js-pages/js-map/lrdmaps.js'></script>" : ""}
${page_name == "case_processing" ? "<script src='js-pages/js-map/lrdfpmaps.js'></script>" : ""}
${page_name == "case_processing" ? "<script src='js-pages/js-map/lcfrsmaps.js'></script>" : ""}
${page_name == "case_processing" ? "<script src='js-pages/js-map/smdfrtpmaps.js'></script>" : ""}
${page_name == "case_processing" ? "<script src='js-pages/js-map/pvlmd_spatial.js'></script>" : ""}
${page_name == "case_processing" ? "<script src='js-pages/js-map/lcfrfamaps.js'></script>" : ""}
${(page_name == "case_processing" || page_name == "application_review_details_advanced") ? "<script src='js-pages/js-map/lcmaps.js'></script>" : ""}

${page_name == "unit_case_management_revised" ? "<script src='js-pages/unit_case_management_revised.js'></script>" : ""}

${(page_name == "compliance_cst") || (page_name == "compliance") || (page_name=="unit_case_management_revised") || (page_name=="certificate_signing_module") ? "<script src='js-pages/compliance.js'></script> " : ""}

${page_name == "application_review_details_advanced" ? "<script src='js-pages/gated_workflow.js'></script>" : ""}