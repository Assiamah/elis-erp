<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
</div>
<!-- Footer -->
<footer class="sticky-footer bg-white">
	<div class="container my-auto">
		<div class="copyright text-center my-auto">
			<!-- <button id="clickbutton">chrome</button> -->
			<span>Copyright &copy; Lands Commission 2021</span>
		</div>
	</div>
</footer>
<!-- End of Footer -->

</div>
<!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"> <i
	class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">Select "Logout" below if you are ready
				to end your current session.</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				<a class="btn btn-primary"
					href="${pageContext.request.contextPath}/Logout"
					onclick="doLogoutClearing()">Logout</a>
			</div>
			<input id="val_fullname" value="${fullname}" type="hidden">
		</div>
	</div>
</div>


<!-- Bootstrap core JavaScript-->
<script>

window.doLogoutClearing = function doLogoutClearing(){
	 localStorage.clear();
}
</script>

<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="js/sb-admin-2.min.js"></script>


<!-- Page level plugins -->
<!-- <script src="vendor/chart.js/Chart.min.js"></script>

Page level custom scripts
<script src="js/demo/chart-area-demo.js"></script>
<script src="js/demo/chart-pie-demo.js"></script> -->

<!-- JS for loading Overlay spinner -->
<script src="js/loadingOverlay.js"></script>



<!-- <script src="jsmap/maps.js"></script> -->
 <!-- <script src="pvlmd_maps_templates/pvlmdmaps.js"></script>  -->
 
<script src="js_includes/professional_tem.js"></script>
<script src="js_includes/transitional_tem.js"></script>
<script src="js_includes/case_movement.js"></script>
<script src="js_includes/all_functions.js"></script>

<script src="csau_template/csau_online.js"></script>


<script src="js_includes/users_to_batch.js"></script>
<script src="js_includes/_user_profile.js"></script>
<script src="transitional_templates/transitional_tem.js"></script>
<script src="pvlmd_maps_templates/pvlmd_transaction_search.js"></script>

<script src="js_includes/letters_template.js"></script>
<script src="lrd_maps_templates/lrd_transaction_search.js"></script>
<script src="smd_maps_templates/smd_transaction_search.js"></script>

<script src="js_includes/public_document_upload.js"></script>
<script src="js_includes/notifications.js"></script>


<script type="text/javascript" src="js/tabulator.js"></script>
<!-- <script type="text/javascript" src="js/xlsx.full.min.js"></script> -->
<script type="text/javascript" src="pdf/jspdf.min.js"></script>
<script type="text/javascript" src="pdf/jspdf.plugin.autotable.js"></script>
<!-- <script src="js_includes/reports.js"></script> -->

<!-- <script src="pdf/jspdf.min.js"></script>
<script src="pdf/jspdf.plugin.autotable.js"></script> -->


<!-- <script src="jsmap/pvlmdmaps.js"></script> -->
<script src="js/js/jquery.steps.js"></script>
<script src="js/js/main.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/bootstrap-notify.js"></script>
<script src='js/lodash.min.js'></script>
<!-- <script src="js/js/parsley_form.js"></script> -->

<!-- bootbox code -->
<script src="js/bootbox.min.js"></script>

<!-- JavaScript -->
<script src="js/jsw/jquery.smartWizard.js" type="text/javascript"></script>
<script src="js/summernote.min.js" type="text/javascript"></script>
<script src="js/datatables-js/dataTables.responsive.min.js" type="text/javascript"></script>

<!-- Toastr -->
 <script src="legal/includes/bootstrap/js/toastr.min.js"></script>

<!--  <script src="legal/includes/bootstrap/js/bootstrap.min.js"></script> -->
<script src="legal/includes/tinymce/tinymce.min.js"></script>
<script src="legal/includes/main.js"></script>
<script src="CICA/includes/pages_script/cica_dashboard.js"></script>
<script src="file_tracking_system/includes/page_script/main2.js"></script>

<script src="file_tracking_system/includes/vendors/jquery-toast-plugin/jquery.toast.min.js"></script>

<script type="text/javascript">

var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

function convertDate(date_str) {
  temp_date = date_str.split("-");
  return temp_date[2] + " " + months[Number(temp_date[1]) - 1] + " " + temp_date[0];
}




toastr.options = {
		  "closeButton": false,
		  "debug": false,
		  "newestOnTop": false,
		  "progressBar": false,
		  "positionClass": "toast-top-right",
		  "preventDuplicates": false,
		  "onclick": null,
		  "showDuration": "3000",
		  "hideDuration": "1000",
		  "timeOut": "5000",
		  "extendedTimeOut": "1000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
		}
		
</script>

<jsp:include page="modals.jsp"></jsp:include>

</body>
</html>