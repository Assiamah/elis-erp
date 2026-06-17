$(document).ready(function() {

	var table = $('#tblLocations').DataTable();
	var tableDis = $('#tblDistricts').DataTable();
	
   $('#editLocalityModal').on('show.bs.modal',function(e) {
	   //console.log($(e.relatedTarget).data('loc_id'))
	   var loc_office_name = $("#district_region_office").find(":selected").text();
	   $("#loc_office_name").val(loc_office_name);
	   $("#loc_locality_id").val($(e.relatedTarget).data('loc_id'));
	   $("#loc_locality_name").val($(e.relatedTarget).data('loc_name'));
	   
   });
   
   $('#editDistrictModal').on('show.bs.modal',function(e) {
	   //console.log($(e.relatedTarget).data('dis_id'))
	   var region_name = $("#district_region").find(":selected").text();
	   $("#region_name").val(region_name);
	   $("#district_id").val($(e.relatedTarget).data('dis_id'));
	   $("#district_name").val($(e.relatedTarget).data('dis_name'));
	   console.log($(e.relatedTarget).data('dis_name'))
   });
   
   
   
   $('#frmEditDistrict').on('submit',function(e) {

	   // validation code here
	   e.preventDefault();
	   
	   var region_id = 0;
	   var district_id =0;
	   if($("#vregion_id").val()){
		   region_id =$("#vregion_id").val();
	   }
	   var district_name = $("#district_name").val()
	   var district_id = $("#district_id").val()
	   
	   console.log('how are your search' + region_id);
	   if(region_id == 0){
		   Swal.fire({ icon: 'warning', title: 'Required', text: 'Please select a Region.' });
		   return false;
	   }else{
		   $.ajax({
			   type: "POST",
			   url: "Case_Management_Serv",
			   data: {
				   request_type: 'select_lc_add_update_district',
				   district_id: district_id,
				   district_name: district_name,
				   region_id:region_id
			   },
			   success: function(jobdetails) {
			   
					
				   //var result = JSON.parse(jobdetails);
				   //console.log('how come')
				   //console.log(result)
					   $("#editDistrictModal").modal("hide");
				   
					   if(jobdetails.includes("good") ){
						   //table.clear();
						   //console.log("not null")
						   /*$(result).each(function() { 
							   table.row.add( [
							   this.location_name,
							   
							   '<button  class="btn btn-info btn-icon-split" ' 
							   + '" data-loc_id=' + this.id
							   + ' data-loc_name=' + this.location_name  
								 
							   + ' data-target=" #editLocalityModal" data-toggle="modal" >'
							   + ' <span class="icon text-white-50"> <i class="fas fa-edit"></i></span><span class="text">Edit</span>'
							   + ' </button>',
							   
							   
							   
							   
							   ] ).draw( false );
						   });*/
						   
						   Swal.fire({ icon: 'success', title: 'Success', text: 'District saved successfully.' });


					   }else{

						   Swal.fire({ icon: 'error', title: 'Error', text: 'Something went wrong. Please try again.' });
						   
					   }
					   
			   }
		   });
	   }

					   
				   
	   
   });
   $('#frmEditLocality').on('submit',function(e) {

	   // validation code here
	   e.preventDefault();
	   
	   var locality_id = 0;
	   if($("#loc_locality_id").val()){
		   locality_id =$("#loc_locality_id").val();
	   }
	   var locality_name = $("#loc_locality_name").val()
	   var office_name = $("#loc_office_name").val()
	   var office_id = $("#loc_office_id").val()
	   
	   console.log(office_name, office_id);

	   $.ajax({
		   type: "POST",
		   url: "Case_Management_Serv",
		   data: {
			   request_type: 'select_lc_add_update_locality',
			   locality_id: locality_id,
			   locality_name: locality_name,
			   office_name: office_name,
			   office_id: office_id
		   },
		   success: function(jobdetails) {
		   
			   try{
				   let result = JSON.parse(jobdetails);
				   $("#editLocalityModal").modal("hide");
			   
				   if(result !==null){
					   Swal.fire({ icon: 'success', title: 'Success', text: 'Locality saved successfully.' });
					   //load new data
					   table.clear();
						   
						   $(result).each(function () {
							   console.log("new District: " + this);
								   
							   table.row.add( [
								   this.location_name,
								   
								   '<button  class="btn btn-info btn-icon-split" ' 
								   + '" data-loc_id="' + this.id
								   + '" data-loc_name=' + this.location_name  
								   + ' data-bs-target="#editLocalityModal" data-bs-toggle="modal" >'
								   + ' <span class="icon text-white-50"> <i class="fas fa-edit"></i></span><span class="text">Edit</span>'
								   + ' </button>'
							   ] ).draw( false );
							   
							});
							
				   }else{
					   
					   Swal.fire({ icon: 'error', title: 'Error', text: 'Something went wrong. Please try again.' });
					   
				   }

			   } catch(e){
				   Swal.fire({ icon: 'error', title: 'Error', text: 'Something went wrong. Please try again.' });
			   }
			   
				   
		   }
	   });

					   
				   
	   
   });
   
   
   $('#district_region').change(function() {
		  
		  //var region_id = $(this).find(':selected').attr('data-id');
		  //console.log("seleted gerion: " + region_id);
		  var region_id = $(this).val();
		  region_id = region_id.replace('.0', '');


		  $("#vregion_id").val(region_id);
		  $("#region_id").val(region_id);

   
		  
		  $.ajax({
				type: "POST",
				url: "Case_Management_Serv",
				data: {
					   request_type: 'get_list_of_district',
					   region_id: region_id },
				cache: false,
				success: function(jobdetails) {
				   
				  console.log("District: " + jobdetails);
				  if(jobdetails != "") {

				   var json_p = JSON.parse(jobdetails);
				   
				   tableDis.clear();

				   if(!json_p){
					   tableDis.row.add( ['no districts found','']).draw( false );
				   }
				   $(json_p).each(function () {
					   //console.log("new District: " + this);
						   
					   tableDis.row.add( [
						   this.district_name,
						   '<button  class="btn btn-info btn-icon-split" ' 
						   + '" data-dis_id=' + this.id
						   + ' data-dis_name=' + this.district_name  
						   + ' data-bs-target="#editDistrictModal" data-bs-toggle="modal" >'
						   + ' <span class="icon text-white-50"> <i class="fas fa-edit"></i></span><span class="text">Edit</span>'
						   + ' </button>'
					   ] ).draw( false );
					   
					});	
				  } else {

						tableDis.clear();

						Swal.fire({ icon: 'warning', title: 'No Data', text: 'No data found.' });

				  }
							   
				 }
		   });
		  
		  
});


$('#district_region_office').change(function() {
									   // alert($(this).val());

		   var sub_service = $(this).val();

		   const
		   sub_service_name_id = sub_service
				   .split('_');

		   var main_service_id = sub_service_name_id[0];
		   var main_service_name = sub_service_name_id[1];


		   main_service_id = main_service_id.replace('.0', '');


		   //console.log(main_service_id);
		   //console.log(main_service_name);
		   $("#loc_office_id").val(main_service_id);
			  $("#loc_office_name").val(main_service_name);
		  

		   $.ajax({
				   type : "POST",
				   url : "Case_Management_Serv",
				   data : {
					   request_type : 'get_list_of_locality',
					   region_id : main_service_id
				   },
				   cache : false,
				   
				   success : function(jobdetails) {

						   
						   // console.log("District: " + jobdetails);
						   var json_p = JSON.parse(jobdetails);
						   
						   table.clear();
						   if(!json_p){
							   table.row.add( ['no localities found','']).draw( false );
						   }
						   $(json_p).each(function () {
							   console.log("new District: " + JSON.stringify(this));
								   
							   table.row.add( [
								   this.location_name,
								   
								   '<button  class="btn btn-info btn-icon-split" ' 
								   + '" data-loc_id="' + this.id
								   + '" data-loc_name=' + this.location_name  
								   + ' data-bs-target="#editLocalityModal" data-bs-toggle="modal" >'
								   + ' <span class="icon text-white-50"> <i class="fas fa-edit"></i></span><span class="text">Edit</span>'
								   + ' </button>'
							   ] ).draw( false );
							   
							});
						   
						   
						   
						   

						   
					   }
				   });

	   });
	   
								   
		  
	  });