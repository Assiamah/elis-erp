$(document).ready(function() {

	var table = $('#tblLocations').DataTable();
	//var tableDis = $('#tblDistricts').DataTable();
	 
	$('#editUnitModal').on('show.bs.modal',function(e) {
		//console.log($(e.relatedTarget).data('loc_id'))
		$("#un_unit_id").val($(e.relatedTarget).data('un_id')? $(e.relatedTarget).data('un_id') : '0');
		$("#un_unit_name").val($(e.relatedTarget).data('un_name'));
		$("#un_divisions").val($(e.relatedTarget).data('un_divisions'));
		$("#un_status").val($(e.relatedTarget).data('un_status') ==true?'Active':'Disabled');	
		//$('#un_status').prop('checked', $(e.relatedTarget).data('un_status'))
		//$(e.relatedTarget).data('un_status') == 'true' ? $('#un_status').prop('checked', true): $('#un_status').prop('checked', true)		
	});
	
	
	$('#frmEditUnit').on('submit',function(e) {
		// validation code here
		e.preventDefault();
		var unit_id = 0;
		if($("#un_unit_id").val()){
			unit_id =$("#un_unit_id").val();
		}
		var unit_name = $("#un_unit_name").val()
		var office_name = $("#un_office_name").val()
		var office_id = $("#un_office_id").val()
		var divisions = $("#un_divisions").val()
		var status = $("#un_status").val()==='Active'?true:false;
		//console.log('how are your search' + status);

		$.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'select_lc_add_update_unit',
                unit_id: unit_id,
                unit_name: unit_name,
                office_name: office_name,
                office_id: office_id,
                divisions: divisions,
                status: status
            },
            success: function(jobdetails) {
				try{
					//console.log("new RESULT: " + jobdetails)
			    	let result = JSON.parse(jobdetails);
					$("#editUnitModal").modal("hide");
			        if(result !==null){
						$.notify({
		                    message: '<i class="fas fa-check  fa-3x fa-fw"></i><span class="text-bold"> Success </span>',
		                }, {
		                    type: 'success'
		                });
			        	//load new data
					    table.clear();
						    if(!result){
						    	table.row.add( ['no localities found','','','']).draw( false );
						    }
							$(result).each(function () {
								//console.log("new District: " + JSON.stringify(this));
								//label = this.status=='true' ? 'success':  '">'+ this.status + '</span>'
				        		table.row.add( [
									this.unit_name,
									this.unit_division,
									this.status ==true ? '<span class="badge bg-success text-dark p-2">Active</span>': '<span class="badge bg-danger text-light p-2">Disabled</span>',

									'<button  class="btn btn-info btn-icon-split" ' 
									+ '" data-un_id="' + this.unit_id
			                		+ '" data-un_name="' + this.unit_name 
			                		+ '" data-un_divisions="' +this.unit_division
			                		+ '" data-un_status="' + this.status 
			                		+ '" data-target="#editUnitModal" data-toggle="modal" >'
			                		+ ' <span class="icon text-white-50"> <i class="fas fa-edit"></i></span><span class="text">Edit</span>'
			                		+ ' </button>'
			            		]).draw(false);
							 });
							 
			        }else{
			        	
			        	$.notify({
		                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Somthing went wrong 1 </span>',
		                }, {
		                    type: 'danger'
		                });
			        }

				} catch(e){
					$.notify({
		                    message: '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">'+ e.message +'Somthing went wrong 2 </span>',
		                }, {
		                    type: 'danger'
		                });
				}
            }
        });			
	});
	
	

	$('#district_region_office_units').change(function() {
			// alert($(this).val());

			var sub_service = $(this).val();
			const sub_service_name_id = sub_service.split('_');
			var office_id = sub_service_name_id[0];
			//var office_name = sub_service_name_id[1];
			var office_name = $('#district_region_office_units').find(":selected").text();

			console.log(office_id, office_name)


			office_id = office_id.replace('.0', '');

			$("#un_office_id").val(office_id);
   	    	$("#un_office_name").val(office_name);
   	    
			$.ajax({
					type : "POST",
					url : "Case_Management_Serv",
					data : {
						request_type : 'get_lc_list_of_units_manage',
						office_id : office_id
					},
					cache : false,
					success : function(jobdetails) {
							// console.log("District: " + jobdetails);
						    var json_p = JSON.parse(jobdetails);
						    table.clear();
						    if(!json_p.data){
						    	table.row.add( ['no localities found','','','']).draw( false );
						    }
							$(json_p.data).each(function () {
								//console.log("new District: " + JSON.stringify(this));
									//label = this.status=='true' ? 'success':  '">'+ this.status + '</span>'
				        		table.row.add( [
									this.unit_name,
									this.unit_division,
									this.status ==true ? '<span class="badge bg-success text-dark p-2">Active</span>': '<span class="badge bg-danger text-light p-2">Disabled</span>',
									'<button  class="btn btn-info btn-icon-split" ' 
									+ '" data-un_id="' + this.unit_id
			                		+ '" data-un_name="' + this.unit_name 
			                		+ '" data-un_divisions="' +this.unit_division
			                		+ '" data-un_status="' + this.status 
			                		+ '" data-target="#editUnitModal" data-toggle="modal" >'
			                		+ ' <span class="icon text-white-50"> <i class="fas fa-edit"></i></span><span class="text">Edit</span>'
			                		+ ' </button>'
			            		] ).draw( false );
							 });
						}
					});
		});   		
 });