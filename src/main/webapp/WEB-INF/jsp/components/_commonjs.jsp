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
<!-- <script src="${pageContext.request.contextPath}/assets/libs/intl-tel-input/build/js/intlTelInput.min.js"></script> -->

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

<!-- Quill Editor JS -->
<script src="${pageContext.request.contextPath}/assets/libs/quill/dist/quill.js"></script>

<!-- Internal Quill JS -->
<script src="${pageContext.request.contextPath}/assets/js/quill-editor.js"></script>



<!-- Echarts-->
${(page_name == "compliance_cst") || (page_name == "director_compliance") || (page_name == "csau_monitoring")  || (page_name == "compliance") || (page_name=="unit_case_management_revised") || (page_name == "account-reports") ||(page_name == "rent_report_dashboard")  || (page_name=="compliance_no_login") || (page_name == "focal_compliance_person") ? "<script src='assets/libs/echarts/dist/echarts.min.js'></script> " : ""}
${page_name == "executive_dashboard" ? "<script src='assets/libs/chart.js/Chart.min.js'></script>" : ""}
${page_name == "csau_monitoring"  ? "<script src='assets/libs/chart.js/Chart.min.js'></script>" : ""}

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
${page_name != "live_monitoring" ? "<script src='js-pages/global.js'></script>" : ""}
<!-- <script src="${pageContext.request.contextPath}/js-pages/all_functions.js"></script> -->
<script src="${pageContext.request.contextPath}/js-pages/inactivity_check.js"></script>

<script src="${pageContext.request.contextPath}/assets/libs/jsw/jquery.smartWizard.js" type="text/javascript"></script>

${page_name == "rent_management_dashboard" ? "<script src='js-pages/rent_management.js'></script>" : ""}
${page_name == "audit_report" ? "<script src='js-pages/audit_report_dashboard.js'></script>" : ""}
<!-- ${page_name == "audit_report" ? "<script src='js-pages/audit_report.js'></script>" : ""} -->


${page_name == "rent_management_maps" ? "<script src='js-pages/js-map/rent_management_maps.js'></script>" : ""}
${page_name == "case_processing" ? "<script src='js-pages/js-map/lrdmaps.js'></script>" : ""}
${page_name == "case_processing" ? "<script src='js-pages/js-map/lrdfpmaps.js'></script>" : ""}
${page_name == "case_processing" ? "<script src='js-pages/js-map/lcfrsmaps.js'></script>" : ""}
${page_name == "case_processing" ? "<script src='js-pages/js-map/smdfrtpmaps.js'></script>" : ""}

${page_name == "lvd_compensation_maps" ? "<script src='js-pages/js-map/lvd_compensation_maps.js'></script>" : ""}

<!-- ${page_name == "case_processing" ? "<script src='js-pages/js-map/pvlmd_spatial.js'></script>" : ""} -->
${page_name == "case_processing" ? "<script src='js-pages/js-map/lcfrfamaps.js'></script>" : ""}
${(page_name == "case_processing" || page_name == "application_review_details_advanced" || page_name == "deed_data_capture") ? "<script src='js-pages/js-map/lcmaps.js'></script>" : ""}
${page_name == "link_transaction_and_parcel_data" ? "<script src='js-pages/js-map/pvlmd_spatial.js'></script>" : ""}
${page_name == "link_transaction_and_parcel_data" ? "<script src='js-pages/pvlmd_transaction_parcel_link.js'></script>" : ""}

${(page_name == "unit_case_management_revised" || page_name == "further_entries_new") ? "<script src='js-pages/unit_case_management_revised.js'></script>" : ""}
${page_name == "unit_case_management_revised" ? "<script src='js-pages/unit_case_management_compliance.js'></script>" : ""}

${(page_name == "compliance_cst") || (page_name == "compliance") || (page_name=="certificate_signing_module") ? "<script src='js-pages/compliance.js'></script> " : ""}
${(page_name == "compliance_cst") ? "<script src='js-pages//compliance_cst.js'></script> " : ""}

${(page_name == "compliance_cst") ? "<script src='js-pages/corporate_application.js'></script> " : ""}

${(page_name == "application_review_details_advanced") || (page_name == "add_new_case_template") || (page_name == "deed_data_capture") ? "<script src='js-pages/gated_workflow.js?v=20260824-2'></script>" : ""}
${page_name == "deed_data_capture" ? "<script src='js-pages/deed_data_capture.js'></script>" : ""}

${page_name == "page_enquiry_backoffice" ? "<script src='js-pages/enquiry_backoffice.js'></script>" : ""}
${page_name == "page_enquiry_desk" ? "<script src='js-pages/enquiry_collections.js'></script>" : ""}
${page_name == "page_enquiry_desk_stamping" ? "<script src='js-pages/enquiry_collections_stamping.js'></script>" : ""}
${page_name == "page_enquiry_teller" ? "<script src='js-pages/enquiry_teller.js'></script>" : ""}
${page_name == "page_bulk_csau_collection" ? "<script src='js-pages/bulk_csau_collection.js'></script>" : ""}
${page_name == "page_bulk_csau_receiving" ? "<script src='js-pages/bulk_csau_receiving.js'></script>" : ""}
${page_name == "page_bulk_collection_for_payment" ? "<script src='js-pages/bulk_collection_for_payment.js'></script>" : ""}

${page_name == "user_management" ? "<script src='js-pages/user_mgt.js'></script>" : ""}

${(page_name == "compliance_query_and_response") || (page_name == "regional_compliance_query_and_response") || (page_name == "compliance_notice_report") ? "<script src='js-pages/compliance_query_and_response.js'></script> " : ""}

${page_name == "focal_compliance_person" ? "<script src='js-pages/focal.js'></script>" : ""}

${page_name == "executive_dashboard" ? "<script src='js-pages/executive_compliance.js'></script>" : ""}

${page_name == "director_compliance" ? "<script src='js-pages/director_compliance.js'></script>" : ""}

${page_name == "cica_clients" ? "<script src='js-pages/cica_clients.js'></script>" : ""}
${(page_name == "cica_tickets") || (page_name == "cica_focal_person") || (page_name == "cica_replies") ? "<script src='js-pages/cica_tickets.js'></script>" : ""}
${(page_name == "cica_dashboard") ? "<script src='js-pages/cica_dashboard.js'></script>" : ""}
${page_name == "cica_replies" ? "<script src='js-pages/cica_reply_details.js'></script>" : ""}
${page_name == "cica_ticket_details" ? "<script src='js-pages/cica_ticket_details.js'></script>" : ""}

${page_name == "reports" ? "<script src='js-pages/reports.js'></script>" : ""}

${page_name == "reports" ? "<script src='js-pages/apps_report.js'></script>" : ""}

${(page_name == "account-reports-grand-rent")  ? "<script src='js-pages/account_reports_rent.js?v=20260806-2'></script> " : ""}
${page_name == "account-reports" ? "<script src='js-pages/audit_report.js'></script>" : ""}

${page_name == "account-reports" ? "<script src='js-pages/account_reports.js'></script>" : ""}

${page_name == "rent_report_dashboard" ? "<script src='js-pages/rent_reports.js'></script>" : ""}

${page_name == "page_file_management" ?  "<script src='js-pages/file_management.js'></script>" : ""}

${page_name == "csau_monitoring" ? "<script src='js-pages/monitoring_csau.js'></script>" : ""}
${page_name == "unit_user_report" ? "<script src='js-pages/apps_report.js'></script>" : ""}

${page_name == "help_desk" ? "<script src='js-pages/help_desk.js'></script>" : ""}

${page_name == "page_appdata_transfer_template" ? "<script src='js-pages/_apps_update.js?v=20260812-3'></script>" : ""}
${page_name == "page_appdata_transfer_template" ? "<script src='js-pages/users_to_batch.js?v=20260812-2'></script>" : ""}

${page_name == "settings_basic" ? "<script src='js-pages/settings_basic.js'></script>" : ""}
${page_name == "settings_units" ? "<script src='js-pages/settings_units.js'></script>" : ""}
