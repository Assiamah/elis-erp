$(document).ready(function() {

    var cs_main_transaction_number = $('#cs_main_transaction_number').val();
    var cs_main_job_number = $('#cs_main_job_number').val();

    $('#btnloadjobsrelatedtocase').on('click', function(e){

        $('#jobsrelatedtocase_dataTable').DataTable().destroy();

        let datatable = $("#jobsrelatedtocase_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadjobsrelatedtocase'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
                datatable.state.clear().draw();
                datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{
                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        datatable.row.add([
                            this.job_number,
                            this.business_process_sub_name,
                            
                            ]).draw(false);
                                        

                    });
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });

    $('#btnloadparties').on('click', function(e){

        $('#parties_dataTable').DataTable().destroy();

        let datatable = $("#parties_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadparties'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
				datatable.state.clear().draw();
				datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{
                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        datatable.row.add([
                            this.ar_name,
                            this.ar_gender,
                            this.ar_cell_phone,
                            this.type_of_party,
                            '<p data-placement="top" class="to_hide_on_level_1"  title="Edit Party">'
			          							+'<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"'
			          								+'data-target="#addeditpartyGeneral"'
			          								+'data-target-id="'+this.ar_client_id+'"'
			          								+'data-ar_name="'+this.ar_name+'"'
			          								+'data-ar_gender="'+this.ar_gender+'"'
			          								+'data-ar_address="'+this.ar_address+'"'
			          								+'data-ar_cell_phone="'+this.ar_cell_phone+'"'
			          								+'data-ar_cell_phone2="'+this.ar_cell_phone2+'"'
			          								+'data-ar_tin_no="'+this.ar_tin_no+'"'
			          								+'data-ar_id_type="'+this.ar_id_type+'"'
			          								+'data-ar_id_number="'+this.ar_id_number+'"'
			          								+'data-ar_location="'+this.ar_location+'"'
			          								+'data-ar_district="'+this.ar_district+'"'
			          								+'data-type_of_party="'+this.type_of_party+'"'
			          								+'data-ar_region="'+this.ar_region+'"'
			          								+'data-ar_person_type="'+this.ar_person_type+'"'
			          								+'>'   	 
			          								+'<span class="icon text-white-50"> '
			          								+'<i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>'
			          						+'</p>'
                        ]).draw(false);
                                        
                    });
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });

    $('#btnloadminutesonapplication').on('click', function(e){

        $('#minutesonapplication_dataTable').DataTable().destroy();

        let datatable = $("#minutesonapplication_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadminutesonapplication'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
				datatable.state.clear().draw();
				datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{
                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        datatable.row.add([
                            this.am_description,
                            this.am_from_officer,
                            this.am_to_officer,
                            this.am_activity_date,
                            '<p data-placement="top" class="to_hide_on_level_1"  title="Edit Party">'
			          							+'<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"'
			          								+'data-target="#addMinutesModal"'
			          								+'data-target-id="'+this.am_id+'"'
			          								+'data-am_description="'+this.am_description+'"'
			          								+'data-am_from_officer="'+this.am_from_officer+'"'
			          								+'data-am_to_officer="'+this.am_to_officer+'"'
			          								+'data-am_activity_date="'+this.am_activity_date+'"'
			          								+'data-am_edit="1"'
			          								+'>'   	 
			          								+'<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span></button>'
			          						+'</p>'
                        ]).draw(false);
                                        
                    });
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });

    $('#btnloadsmsonapp').on('click', function(e){

        $('#smsonapp_dataTable').DataTable().destroy();

        let datatable = $("#smsonapp_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadsmsonapp'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
				datatable.state.clear().draw();
				datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{
                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        datatable.row.add([
                            this.sms_message,
                            this.sms_created_by,
                            this.sms_created_date,
                        ]).draw(false);
                                        
                    });
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });

    $('#btnloadnotesorreports').on('click', function(e){

        console.log(cs_main_transaction_number, cs_main_job_number)

        $('#notesorreports_dataTable').DataTable().destroy();

        let datatable = $("#notesorreports_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
            stateSave : true,
            "createdRow" : function(row, data, dataIndex) {
                if (data[5] == "true") {
                    $(row).addClass('bg-danger');
                }
            },
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadnotesorreports'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
				datatable.state.clear().draw();
				datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{

                    //datatable.column(5).visible(false);

                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        var rowNode =  datatable.row.add([
                            //this.an_status,
                            '<p class="text-truncate" style="max-width:100px;">'+this.an_description+'</p>',
                            this.created_by,
                            this.created_date,
                            this.division,
                             `<p data-placement="top" class="" title="View/Edit">
			          							<button class="btn btn-info btn-icon-split" data-title="Edit"  data-toggle="modal"
			          								data-target="#addNotesModal"
			          								data-target-id="${this.an_id}"
			          								data-an_description="${this.an_description}"
			          								data-created_by="${this.created_by}"
			          								data-created_date="${this.created_date}"
			          								data-modified_by="${this.created_by}"
                                                    data-modified_date="${this.created_date}"
			          								data-note_edit="1" ${this.an_status == false ? 'disabled' : ''}
			          								 >
			          								<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">View</span>
			          						 </p>`
                        ]).draw(false).node();

                        // Add a class to the newly added row
                        if(this.an_status == false) {
                            $(rowNode).addClass('bg-danger');
                        }
                                        
                    });
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });

    $('#btnloadcommentsinfo').on('click', function(e){

        $('#commentsinfo_dataTable').DataTable().destroy();

        let datatable = $("#commentsinfo_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadcommentsinfo'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
				datatable.state.clear().draw();
				datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{
                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        datatable.row.add([
                            this.officers_general_comments,
                            this.created_by,
                            this.created_date,
                        ]).draw(false);
                                        
                    });

                    //datatable.order([2, 'asc']).draw();
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });

    $('#btnloadbillnpayments').on('click', function(e){

        $('#billnpayments_dataTable').DataTable().destroy();

        let datatable = $("#billnpayments_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadbillnpayments'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
				datatable.state.clear().draw();
				datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{
                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        datatable.row.add([
                            `<button			
                                    data-toggle="modal"
                                    data-target="#viewBillModal"
                                    
                                    data-egcr_id= "${this.payment_slip_number}"
                                   data-ref_number= "${this.ref_number}"
                                    class="btn btn-success viewBillModalBtn"
                                    title="View Bill Details" 
                                    >
                                View
                           </button> `,
                            this.payment_mode,
                            this.bill_amount,
                            this.payment_slip_number,
                            this.payment_date,
                            this.payment_amount
                        ]).draw(false);
                                        
                    });
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });

    $('#btnloadencumbrances').on('click', function(e){

        $('#encumbrances_dataTable').DataTable().destroy();

        let datatable = $("#encumbrances_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadencumbrances'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
				datatable.state.clear().draw();
				datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{
                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        datatable.row.add([
                            this.es_registered_number,
                            this.es_date_of_instrument,
                            this.es_date_of_registration,
                            this.es_memorials,
                            this.es_remarks
                        ]).draw(false);
                                        
                    });
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });

    $('#btnloadobjections').on('click', function(e){

        $('#objections_dataTable').DataTable().destroy();

        let datatable = $("#objections_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadobjections'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
				datatable.state.clear().draw();
				datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{
                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        datatable.row.add([
                            this.objector_name,
                            this.objector_address,
                            this.objector_contact,
                            this.reasons,
                            this.remarks,
                            // '<p data-placement="top" class="" title="View/Edit">'
			          							+'<button class="btn btn-secondary btn-icon-split" id="editOjectionModal" data-title="Edit"  data-toggle="modal"'
			          								+'data-target="#newObjectionModal"'
			          								+'data-target-id="'+this.id+'"'
			          								+'data-objector_name="'+this.objector_name+'"'
			          								+'data-objector_address="'+this.objector_address+'"'
			          								+'data-objector_contact="'+this.objector_contact+'"'
			          								+'data-reasons="'+this.reasons+'"'
                                                    +'data-remarks="'+this.remarks+'"'
			          								+'data-status="'+this.an_status+'"'
			          								+' >'   	 
			          								+'<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span></button>'
			          						// +'</p>',
                        ]).draw(false);
                                        
                    });
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });

    $('#btnloadqueries').on('click', function(e){

        $('#queries_dataTable').DataTable().destroy();

        let datatable = $("#queries_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadqueries'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
				datatable.state.clear().draw();
				datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{
                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        datatable.row.add([
                            this.job_number,
                            this.reasons,
                            this.remarks,
                            this.created_date,
                            // '<p data-placement="top" class="" title="View/Edit">'
			          							`<button type="button" id="editQueryModal"  data-toggle="modal" 
										      					data-target="#newQueryModal"  data-action="edit"  
										      					class="btn btn-icon-split  ${this.status == 1 ? 'btn-danger' : 'btn-info'}"  title="Edit Query" 
			          								data-id="${this.qid}" 
										                    	data-job_number="${this.am_description}" 
										                    	data-reasons="${this.reasons}" 
										                    	data-remarks="${this.remarks}" 
										                    	data-status="${this.status}" 
										                    	data-query_response="${this.query_response}" 
										                    	data-created_by="${this.created_by}" 
										                    	data-created_date="${this.created_date}" 
										                    	data-modified_by="${this.modified_by}" 
										                    	data-modified_date="${this.modified_date}" 
										                    	data-general_reason="${this.query_general_reason}"
																data-attachment_required="${this.attachment_required}"
			          								 >  	 
			          								<span class="icon text-white-50"> ${this.status == 1 ? '<i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>' : '<i class="fas fa-eye"></i></span><span class="text">View</span>'}</button>`
			          						// +'</p>',
                        ]).draw(false);
                                        
                    });
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });

    $('#btnloadlettersoncase').on('click', function(e){

        $('#lettersoncase_dataTable').DataTable().destroy();

        let datatable = $("#lettersoncase_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadlettersoncase'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
				datatable.state.clear().draw();
				datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{
                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        datatable.row.add([
                            this.created_date,
                            this.letter_type,
                            this.created_by,
                            // '<p data-placement="top" class="" title="View/Edit">'
			          							`<button type="button" id="btn-view-letters"  
										      					data-id="${this.id}"
										      					data-letter_type = "${this.letter_type}" 
										      					data-letter_template="${this.letter_template}" 
										      					data-carbon_copy="${this.carbon_copy}" 
										      					class="btn btn-primary btn-icon-split edit_letter_modal_open"  title="View Letter" >
													    			<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>
													    		</button> `
			          						// +'</p>',
                        ]).draw(false);
                                        
                    });
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });

    $('#btnloadinspectionsreports').on('click', function(e){

        $('#inspectionsreports_dataTable').DataTable().destroy();

        let datatable = $("#inspectionsreports_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadinspectionsreports'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
				datatable.state.clear().draw();
				datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{
                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        datatable.row.add([
                            this.inspection_date,
                            this.requested_by,
                            this.created_by,
                            this.inspection_purpose,
                            // '<p data-placement="top" class="" title="View/Edit">'
			          							`<button type="button" id="btn-view-inpection-report"  data-toggle="modal" data-target="#viewInspectionReportModal"  class="btn btn-primary btn-icon-split "  title="View Inspection Report" >
													    			<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>
													    		</button> `
			          						// +'</p>',
                        ]).draw(false);
                                        
                    });
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });

    $('#btnloadlinkdetails').on('click', function(e){

        $('#linkdetails_dataTable').DataTable().destroy();

        let datatable = $("#linkdetails_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadlinkdetails'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
				datatable.state.clear().draw();
				datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{
                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        datatable.row.add([
                            this.job_number,
                            this.mc_case_number,
                            this.mc_type_of_relationship,
                            this.created_date,
                           `<button type="button" id="btn-view-mother-Child-details"  data-job_number="${this.mc_job_number}" data-case_number="${this.mc_case_number}" data-transaction_number="[0, 0]" business_process_sub_name="-" data-toggle="modal" data-target="#transitional_certificate_template"  class="btn btn-primary btn-icon-split "  title="View Case Details" >
													    			<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>
													    		</button> `
                        ]).draw(false);
                                        
                    });
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });
    
    $('#btnloadcertnsearchdetails').on('click', function(e){

        $('#certnsearchdetails_dataTable').DataTable().destroy();

        let datatable = $("#certnsearchdetails_dataTable")
        .DataTable({
            // dom: 'Bfrtip',						
            // buttons: [
            //     'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
            // ]
        });

        $.ajax({
            type: "POST",
            url: 'Case_Management_Serv',
            data: {
                request_type: 'select_load_application_details',
                transaction_number : cs_main_transaction_number,
                job_number : cs_main_job_number,
                load_type : 'loadcertnsearchdetails'
            },
            cache: false,
            beforeSend: function () {
               // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
            },
            success: function(serviceresponse) {

                datatable.search("").draw();
				datatable.state.clear().draw();
				datatable.clear().draw(true);

                if(!serviceresponse){
                    return;
                }

                try{
                    var json_p = JSON.parse(serviceresponse);
                    $(json_p.data).each(function() {
                        
                        datatable.row.add([
                            this.mc_job_number,
                            this.mc_certificate_number,
                            this.created_date,
                            this.created_date,
                        //    '<button type="button" id="btn-view-mother-Child-details"'
                        //    +'data-job_number="'+this.mc_job_number+'"'
                        //     +'data-case_number="${mother_to_child_link_row.mc_case_number}"'
                        //     +'data-transaction_number="[0, 0]" business_process_sub_name="-" data-toggle="modal" data-target="#transitional_certificate_template"  class="btn btn-primary btn-icon-split "  title="View Case Details" >'
						// 							    			+'<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>'
						// 							    		+'</button> '
                        ]).draw(false);
                                        
                    });
                    
                }catch(e){
                    console.log(e);
                }

            }
        })

    });
})

