$(document).ready(function() {

    $("#parcel_deletion_requested").on("click", function(e) {
        e.preventDefault()

        $("#body-bg-1").addClass('bg-active');
        $("#body-bg-2, #body-bg-3, #body-bg-4").removeClass('bg-active');
        $("#parcel_table_tab").removeClass('d-none');
        $("#transaction_table_tab").addClass('d-none');
        $("#parcel_search").removeClass('d-none');
        $("#transaction_search").addClass('d-none');
        $("#parcel_tab").removeClass('d-none');
        $("#parcel_approval_tab").addClass('d-none');
        $("#accordion_p").removeClass('d-none');

        var enq_tab_value = 'parcel_deletion_requested';

        function callA() {

            let dataSet_pl = [];
            let num_pl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'pvlmd_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_pl = +num_pl + 1;
                                let gid = json_result.data[i].gid;
                                let reference_number = json_result.data[i].reference_number;
                                let file_number = json_result.data[i].file_number;
                                let locality = json_result.data[i].locality;
                                let plotting_date = convertDate(json_result.data[i].plotting_date.slice(0,10));
                                let plotted_by = json_result.data[i].plotted_by;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let action = "";

                                switch(status) {
                                    case '':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-danger btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_initiate_delete_request"
                                                        data-pvlmd_id_idr="${gid}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Send Request
                                                    </button>
                                                </div>`;
                                    break;

                                    case 'pending':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${gid}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;

                                    case 'approved':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${gid}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;

                                    case 'reviewed':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${gid}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_pl);
                                html.push(reference_number);
                                html.push(file_number);
                                html.push(locality); 
                                html.push(plotting_date); 
                                html.push(plotted_by);
                                html.push(status); 
                                html.push(action); 

                                dataSet_pl.push(html);
                            }
                        }

                        $('#table_pvlmd_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_pvlmd_parcel_list').DataTable({ 
                            data: dataSet_pl
                        }).draw();
                    }

                    CallB();

                }
            })
        }

        function CallB() {

            let dataSet_gl = [];
            let num_gl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'garro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_gl = +num_gl + 1;
                                let gid = json_result.data[i].gid;
                                // let document_no = json_result.data[i].document_no;
                                // let date_of_instrument = json_result.data[i].date_of_instrument;
                                let prop_no = json_result.data[i].prop_no;
                                // let date_of_plotting = json_result.data[i].date_of_plotting == null ? '' : convertDate(json_result.data[i].date_of_plotting.slice(0,10));
                                // let nature_of_interest = json_result.data[i].nature_of_interest;
                                // let grantee = json_result.data[i].grantee;
                                // let location = json_result.data[i].location;
                                // let file_no = json_result.data[i].file_no;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let action = "";

                                switch(status) {
                                    case '':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-danger btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_initiate_delete_request"
                                                        data-pvlmd_id_idr="${gid}"
                                                        data-pvlmd_reference_number_idr="${prop_no}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="GARRO"
                                                    >
                                                        Send Request
                                                    </button>
                                                </div>`;
                                    break;

                                    case 'pending':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${gid}"
                                                        data-pvlmd_reference_number_idr="${prop_no}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="GARRO"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;

                                    case 'reviewed':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${gid}"
                                                        data-pvlmd_reference_number_idr="${prop_no}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="GARRO"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;

                                    case 'approved':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${gid}"
                                                        data-pvlmd_reference_number_idr="${prop_no}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="GARRO"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_gl);
                                html.push(gid);
                                html.push(prop_no);
                                // html.push(grantee); 
                                // html.push(location); 
                                // html.push(date_of_plotting);
                                html.push(status); 
                                html.push(action); 

                                dataSet_gl.push(html);
                            }
                        }

                        $('#table_garro_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_garro_parcel_list').DataTable({ 
                            data: dataSet_gl
                        }).draw();
                    }

                    CallC();

                }
            })

        }

        function CallC() {

            let dataSet_cl = [];
            let num_cl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'cro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_cl = +num_cl + 1;
                                let gid = json_result.data[i].gid;
                                let file_number = json_result.data[i].file_number;
                                let ls_number = json_result.data[i].ls_number;
                                let plan_number = json_result.data[i].plan_number;
                                //let date_of_plotting = json_result.data[i].date_of_plotting == null ? '' : convertDate(json_result.data[i].date_of_plotting.slice(0,10));
                                let plot_number = json_result.data[i].plot_number;
                                let locality = json_result.data[i].locality;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let action = "";

                                switch(status) {
                                    case '':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-danger btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_initiate_delete_request"
                                                        data-pvlmd_id_idr="${gid}"
                                                        data-pvlmd_reference_number_idr="${file_number}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="CRO"
                                                    >
                                                        Send Request
                                                    </button>
                                                </div>`;
                                    break;

                                    case 'pending':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${gid}"
                                                        data-pvlmd_reference_number_idr="${file_number}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="CRO"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;

                                    case 'approved':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${gid}"
                                                        data-pvlmd_reference_number_idr="${file_number}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="CRO"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;

                                    case 'reviewed':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${gid}"
                                                        data-pvlmd_reference_number_idr="${file_number}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="CRO"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_cl);
                                html.push(file_number);
                                html.push(ls_number);
                                html.push(plan_number); 
                                html.push(plot_number); 
                                html.push(locality);
                                html.push(status); 
                                html.push(action); 

                                dataSet_cl.push(html);
                            }
                        }

                        $('#table_cro_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_cro_parcel_list').DataTable({ 
                            data: dataSet_cl
                        }).draw();
                    }

                }
            })
        }

        callA();
    })


    $("#parcel_deletion_approved").on("click", function(e) {
        e.preventDefault()

        $("#body-bg-2").addClass('bg-active');
        $("#body-bg-1, #body-bg-3, #body-bg-4").removeClass('bg-active');
        $("#parcel_table_tab").removeClass('d-none');
        $("#transaction_table_tab").addClass('d-none');
        $("#parcel_search").addClass('d-none');
        $("#transaction_search").addClass('d-none');
        $("#parcel_tab").addClass('d-none');
        $("#parcel_approval_tab").removeClass('d-none');
        $("#accordion_p").removeClass('d-none');

        var enq_tab_value = 'parcel_deletion_approved';

        function callA() {

            let dataSet_pl = [];
            let num_pl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'pvlmd_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_pl = +num_pl + 1;
                                let gid = json_result.data[i].gid;
                                let reference_number = json_result.data[i].reference_number;
                                let file_number = json_result.data[i].file_number;
                                let locality = json_result.data[i].locality;
                                let plotting_date = convertDate(json_result.data[i].plotting_date.slice(0,10));
                                let plotted_by = json_result.data[i].plotted_by;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_approved_by = json_result.data[i].deleted_approved_by;
                                let approve_note = json_result.data[i].approve_note;
                                let delete_note = json_result.data[i].delete_note;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by
                                let reviewed_by = json_result.data[i].reviewed_by
                                let review_note = json_result.data[i].review_note
                                let action = "";

                                switch(status) {

                                    case 'approved':
                                    action = `<div class="text-center">
                                                <button type="button" class="btn btn-outline-success btn-sm"
                                                    data-toggle="modal" data-target="#plvmd_confirm_approve_delete_request"
                                                    data-pvlmd_id_aadr="${gid}"
                                                    data-pvlmd_reference_number_aadr="${reference_number}"
                                                    data-pvlmd_delete_attachment_aadr="${delete_attachment}"
                                                    data-pvlmd_deleted_approved_by_aadr="${deleted_approved_by}"
                                                    data-pvlmd_deleted_approve_note_aadr="${approve_note}"
                                                    data-pvlmd_delete_note_aadr="${delete_note}"
                                                    data-pvlmd_deleted_requested_by_aadr="${deleted_requested_by}"
                                                    data-pvlmd_reviewed_by_aadr="${reviewed_by}"
                                                    data-pvlmd_review_note_aadr="${review_note}"
                                                    data-initiate_type="parcel"
                                                    data-layer_type="PVLMD"
                                                >
                                                    View Approval
                                                </button>
                                            </div>`;
                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_pl);
                                html.push(reference_number);
                                html.push(file_number);
                                html.push(locality); 
                                html.push(plotting_date); 
                                html.push(plotted_by);
                                html.push(status); 
                                html.push(action); 

                                dataSet_pl.push(html);
                            }
                        }

                        $('#table_pvlmd_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_pvlmd_parcel_list').DataTable({ 
                            data: dataSet_pl
                        }).draw();
                    }

                    CallB();

                }
            })
        }

        function CallB(){

            let dataSet_gl = [];
            let num_gl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'garro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_gl = +num_gl + 1;
                                let gid = json_result.data[i].gid;
                                let prop_no = json_result.data[i].prop_no;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_approved_by = json_result.data[i].deleted_approved_by;
                                let approve_note = json_result.data[i].approve_note;
                                let delete_note = json_result.data[i].delete_note;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by
                                let reviewed_by = json_result.data[i].reviewed_by
                                let review_note = json_result.data[i].review_note
                                let action = "";

                                switch(status) {
                                    case 'approved':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-success btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_confirm_approve_delete_request"
                                                        data-pvlmd_id_aadr="${gid}"
                                                        data-pvlmd_reference_number_aadr="${prop_no}"
                                                        data-pvlmd_delete_attachment_aadr="${delete_attachment}"
                                                        data-pvlmd_deleted_approved_by_aadr="${deleted_approved_by}"
                                                        data-pvlmd_deleted_approve_note_aadr="${approve_note}"
                                                        data-pvlmd_delete_note_aadr="${delete_note}"
                                                        data-pvlmd_deleted_requested_by_aadr="${deleted_requested_by}"
                                                        data-pvlmd_reviewed_by_aadr="${reviewed_by}"
                                                        data-pvlmd_review_note_aadr="${review_note}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="GARRO"
                                                    >
                                                        View Approval
                                                    </button>
                                                </div>`;
                                        break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_gl);
                                html.push(gid);
                                html.push(prop_no);
                            //   html.push(grantee); 
                            //   html.push(location); 
                            //   html.push(date_of_plotting);
                                html.push(status); 
                                html.push(action); 

                                dataSet_gl.push(html);
                            }
                        }

                        $('#table_garro_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_garro_parcel_list').DataTable({ 
                            data: dataSet_gl
                        }).draw();
                    }

                    CallC();

                }
            })
        }

        function CallC() {

            let dataSet_cl = [];
            let num_cl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'cro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_cl = +num_cl + 1;
                                let gid = json_result.data[i].gid;
                                let file_number = json_result.data[i].file_number;
                                let ls_number = json_result.data[i].ls_number;
                                let plan_number = json_result.data[i].plan_number;
                                let plot_number = json_result.data[i].plot_number;
                                let locality = json_result.data[i].locality;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_approved_by = json_result.data[i].deleted_approved_by;
                                let approve_note = json_result.data[i].approve_note;
                                let delete_note = json_result.data[i].delete_note;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by
                                let reviewed_by = json_result.data[i].reviewed_by
                                let review_note = json_result.data[i].review_note
                                let action = "";

                                switch(status) {
                                    case 'approved':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-success btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_confirm_approve_delete_request"
                                                        data-pvlmd_id_aadr="${gid}"
                                                        data-pvlmd_reference_number_aadr="${file_number}"
                                                        data-pvlmd_delete_attachment_aadr="${delete_attachment}"
                                                        data-pvlmd_deleted_approved_by_aadr="${deleted_approved_by}"
                                                        data-pvlmd_deleted_approve_note_aadr="${approve_note}"
                                                        data-pvlmd_delete_note_aadr="${delete_note}"
                                                        data-pvlmd_deleted_requested_by_aadr="${deleted_requested_by}"
                                                        data-pvlmd_reviewed_by_aadr="${reviewed_by}"
                                                        data-pvlmd_review_note_aadr="${review_note}"
                                                        data-initiate_type="parcel"
                                                        data-layer_type="CRO"
                                                    >
                                                        View Approval
                                                    </button>
                                                </div>`;
                                        break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_cl);
                                html.push(file_number);
                                html.push(ls_number);
                                html.push(plan_number); 
                                html.push(plot_number); 
                                html.push(locality);
                                html.push(status); 
                                html.push(action); 

                                dataSet_cl.push(html);
                            }
                        }

                        $('#table_cro_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_cro_parcel_list').DataTable({ 
                            data: dataSet_cl
                        }).draw();
                    }

                }
            })
        }

        callA();
    })


    $("#parcel_deletion_requested_reviewed").on("click", function(e) {
        e.preventDefault()

        $("#body-bg-1").addClass('bg-active');
        $("#body-bg-2, #body-bg-3, #body-bg-4").removeClass('bg-active');
        $("#parcel_table_tab").removeClass('d-none');
        $("#transaction_table_tab").addClass('d-none');
        $("#parcel_search").addClass('d-none');
        $("#transaction_search").addClass('d-none');
        $("#parcel_tab").addClass('d-none');
        $("#parcel_approval_tab").removeClass('d-none');
        $("#accordion_p").removeClass('d-none');

        var enq_tab_value = 'parcel_deletion_reviewed';

        function CallA() {

            let dataSet_pl = [];
            let num_pl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'pvlmd_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_pl = +num_pl + 1;
                                let gid = json_result.data[i].gid;
                                let reference_number = json_result.data[i].reference_number;
                                let file_number = json_result.data[i].file_number;
                                let locality = json_result.data[i].locality;
                                let plotting_date = convertDate(json_result.data[i].plotting_date.slice(0,10));
                                let plotted_by = json_result.data[i].plotted_by;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let reviewed_by = json_result.data[i].reviewed_by;
                                let review_note = json_result.data[i].review_note;
                                let delete_note = json_result.data[i].delete_note;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by
                                let action = "";

                                switch(status) {

                                    case 'reviewed':
                                    action = `<div class="text-center">
                                                <button type="button" class="btn btn-outline-success btn-sm"
                                                    data-toggle="modal" data-target="#plvmd_approve_delete_request"
                                                    data-pvlmd_id_radr="${gid}"
                                                    data-pvlmd_reference_number_radr="${reference_number}"
                                                    data-pvlmd_delete_attachment_radr="${delete_attachment}"
                                                    data-pvlmd_reviewed_by_radr="${reviewed_by}"
                                                    data-pvlmd_review_note_radr="${review_note}"
                                                    data-pvlmd_delete_note_radr="${delete_note}"
                                                    data-pvlmd_deleted_requested_by_radr="${deleted_requested_by}"
                                                    data-initiate_type_radr="parcel"
                                                    data-layer_type_radr="PVLMD"
                                                >
                                                    View Request
                                                </button>
                                            </div>`;
                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_pl);
                                html.push(reference_number);
                                html.push(file_number);
                                html.push(locality); 
                                html.push(plotting_date); 
                                html.push(plotted_by);
                                html.push(status); 
                                html.push(action); 

                                dataSet_pl.push(html);
                            }
                        }

                        $('#table_pvlmd_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_pvlmd_parcel_list').DataTable({ 
                            data: dataSet_pl
                        }).draw();
                    }

                    CallB();

                }
            })
        }

        function CallB() {

            let dataSet_gl = [];
            let num_gl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'garro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_gl = +num_gl + 1;
                                let gid = json_result.data[i].gid;
                                let prop_no = json_result.data[i].prop_no;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let reviewed_by = json_result.data[i].reviewed_by;
                                let review_note = json_result.data[i].review_note;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by
                                let action = "";

                                switch(status) {
                                    case 'reviewed':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-danger btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_approve_delete_request"
                                                        data-pvlmd_id_radr="${gid}"
                                                        data-pvlmd_reference_number_radr="${prop_no}"
                                                        data-pvlmd_delete_attachment_radr="${delete_attachment}"
                                                        data-pvlmd_reviewed_by_radr="${reviewed_by}"
                                                        data-pvlmd_review_note_radr="${review_note}"
                                                        data-pvlmd_delete_note_radr="${delete_note}"
                                                        data-pvlmd_deleted_requested_by_radr="${deleted_requested_by}"
                                                        data-initiate_type_radr="parcel"
                                                        data-layer_type_radr="GARRO"
                                                    >
                                                        View Request
                                                    </button>
                                                </div>`;
                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_gl);
                                html.push(gid);
                                html.push(prop_no);
                            //   html.push(grantee); 
                            //   html.push(location); 
                            //   html.push(date_of_plotting);
                                html.push(status); 
                                html.push(action); 

                                dataSet_gl.push(html);
                            }
                        }

                        $('#table_garro_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_garro_parcel_list').DataTable({ 
                            data: dataSet_gl
                        }).draw();
                    }

                    CallC();

                }
            })
        }

        function CallC() {

            let dataSet_cl = [];
            let num_cl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'cro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_cl = +num_cl + 1;
                                let gid = json_result.data[i].gid;
                                let file_number = json_result.data[i].file_number;
                                let ls_number = json_result.data[i].ls_number;
                                let plan_number = json_result.data[i].plan_number;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let reviewed_by = json_result.data[i].reviewed_by;
                                let review_note = json_result.data[i].review_note;
                                let plot_number = json_result.data[i].plot_number;
                                let locality = json_result.data[i].locality;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by
                                let action = "";

                                switch(status) {
                                    case 'reviewed':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-danger btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_approve_delete_request"
                                                        data-pvlmd_id_radr="${gid}"
                                                        data-pvlmd_reference_number_radr="${file_number}"
                                                        data-pvlmd_delete_attachment_radr="${delete_attachment}"
                                                        data-pvlmd_reviewed_by_radr="${reviewed_by}"
                                                        data-pvlmd_review_note_radr="${review_note}"
                                                        data-pvlmd_delete_note_radr="${delete_note}"
                                                        data-pvlmd_deleted_requested_by_radr="${deleted_requested_by}"
                                                        data-initiate_type_radr="parcel"
                                                        data-layer_type_radr="CRO"
                                                    >
                                                        View Request
                                                    </button>
                                                </div>`;
                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_cl);
                                html.push(file_number);
                                html.push(ls_number);
                                html.push(plan_number); 
                                html.push(plot_number); 
                                html.push(locality);
                                html.push(status); 
                                html.push(action); 

                                dataSet_cl.push(html);
                            }
                        }

                        $('#table_cro_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_cro_parcel_list').DataTable({ 
                            data: dataSet_cl
                        }).draw();
                    }

                }
            })
        }

        CallA();
    })



    $("#transaction_deletion_requested_reviewed").on("click", function(e) {
        e.preventDefault()

        $("#body-bg-3").addClass('bg-active');
        $("#body-bg-2, #body-bg-1, #body-bg-4").removeClass('bg-active');
        $("#parcel_table_tab").addClass('d-none');
        $("#transaction_table_tab").removeClass('d-none');
        $("#parcel_search").addClass('d-none');
        $("#transaction_search").removeClass('d-none');
        $("#transaction_search").addClass('d-none');
        $("#accordion_t").removeClass('d-none');

        var enq_tab_value = 'transaction_deletion_reviewed';

        function CallA() {

            let dataSet_pt = [];
            let num_pt = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'pvlmd_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_pt = +num_pt + 1;
                                let t_id = json_result.data[i].t_id;
                                let reference_number = json_result.data[i].reference_number;
                                let file_number = json_result.data[i].file_number;
                                let property_number = json_result.data[i].property_number;
                                let instrument_type = json_result.data[i].instrument_type;
                                let grantee = json_result.data[i].party2_defendant;
                                let grantor = json_result.data[i].party1_plaintiff;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by;
                                let reviewed_by = json_result.data[i].reviewed_by;
                                let review_note = json_result.data[i].review_note;
                                let doc_number = json_result.data[i].doc_number;
                                let instrument_date = json_result.data[i].instrument_date;
                                let consent_date = json_result.data[i].consent_date;
                                let remarks = json_result.data[i].remarks;
                                let action = "";

                                switch(status) {

                                    case 'reviewed':
                                    action = `<div class="text-center">
                                                <button type="button" class="btn btn-outline-success btn-sm"
                                                    data-toggle="modal" data-target="#plvmd_approve_delete_request"
                                                    data-pvlmd_id_radr="${t_id}"
                                                    data-pvlmd_reference_number_radr="${reference_number}"
                                                    data-pvlmd_delete_attachment_radr="${delete_attachment}"
                                                    data-pvlmd_reviewed_by_radr="${reviewed_by}"
                                                    data-pvlmd_review_note_radr="${review_note}"
                                                    data-pvlmd_delete_note_radr="${delete_note}"
                                                    data-pvlmd_deleted_requested_by_radr="${deleted_requested_by}"
                                                    data-initiate_type_radr="transaction"
                                                    data-layer_type_radr="PVLMD"
                                                >
                                                View Request
                                                </button>
                                            </div>`;
                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_pt);
                                html.push(reference_number);
                                html.push(doc_number);
                                html.push(instrument_type); 
                                html.push(instrument_date); 
                                html.push(consent_date);
                                html.push(grantor);
                                html.push(grantee);
                                html.push(remarks);
                                html.push(status); 
                                html.push(action); 

                                dataSet_pt.push(html);
                            }
                        }

                        $('#table_pvlmd_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_pvlmd_transaction_list').DataTable({ 
                            data: dataSet_pt
                        }).draw();
                    }

                    CallB();

                }
            })
        }

        function CallB(){

            let dataSet_ct = [];
            let num_ct = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'cro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_ct = +num_ct + 1;
                                let t_id = json_result.data[i].id;
                                let reference_number = json_result.data[i].doc_number;
                                let document_date = json_result.data[i].doc_date;
                                let document_type = json_result.data[i].doc_type;
                                let purpose = json_result.data[i].purpose;
                                let commencement_date = json_result.data[i].commencement_date;
                                let applicant_name = json_result.data[i].party2_2 == "" ? json_result.data[i].plaintiff : json_result.data[i].party2_2;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by;
                                let reviewed_by = json_result.data[i].reviewed_by;
                                let review_note = json_result.data[i].review_note;
                                let action = "";

                                switch(status) {
                                    case 'reviewed':
                                    action = `<div class="text-center">
                                                <button type="button" class="btn btn-outline-success btn-sm"
                                                    data-toggle="modal" data-target="#plvmd_approve_delete_request"
                                                    data-pvlmd_id_radr="${t_id}"
                                                    data-pvlmd_reference_number_radr="${reference_number}"
                                                    data-pvlmd_delete_attachment_radr="${delete_attachment}"
                                                    data-pvlmd_reviewed_by_radr="${reviewed_by}"
                                                    data-pvlmd_review_note_radr="${review_note}"
                                                    data-pvlmd_delete_note_radr="${delete_note}"
                                                    data-pvlmd_deleted_requested_by_radr="${deleted_requested_by}"
                                                    data-initiate_type_radr="transaction"
                                                    data-layer_type_radr="CRO"
                                                >
                                                View Request
                                                </button>
                                            </div>`;
                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_ct);
                                html.push(reference_number);
                                html.push(document_type);
                                html.push(purpose); 
                                html.push(applicant_name); 
                                html.push(commencement_date);
                                html.push(status); 
                                html.push(action); 

                                dataSet_ct.push(html);
                            }
                        }

                        $('#table_cro_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_cro_transaction_list').DataTable({ 
                            data: dataSet_ct
                        }).draw();
                    }

                    CallC();

                }
            })
        }

        function CallC() {

            let dataSet_gt = [];
            let num_gt = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'garro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_gt = +num_gt + 1;
                                let t_id = json_result.data[i].id;
                                let reference_number = json_result.data[i].document_no;
                                let property_number = json_result.data[i].property_no;
                                let date_of_instrument = json_result.data[i].date_of_instrument;
                                let nature_of_interest = json_result.data[i].nature_of_interest;
                                let location = json_result.data[i].location;
                                let sheet_no = json_result.data[i].sheet_no;
                                let applicant_name = json_result.data[i].grantee;
                                let interest = json_result.data[i].interest;
                                let purpose = json_result.data[i].purpose;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by;
                                let reviewed_by = json_result.data[i].reviewed_by;
                                let review_note = json_result.data[i].review_note;
                                let action = "";

                                switch(status) {
                                    case 'reviewed':
                                    action = `<div class="text-center">
                                                <button type="button" class="btn btn-outline-success btn-sm"
                                                    data-toggle="modal" data-target="#plvmd_approve_delete_request"
                                                    data-pvlmd_id_radr="${t_id}"
                                                    data-pvlmd_reference_number_radr="${reference_number}"
                                                    data-pvlmd_delete_attachment_radr="${delete_attachment}"
                                                    data-pvlmd_reviewed_by_radr="${reviewed_by}"
                                                    data-pvlmd_review_note_radr="${review_note}"
                                                    data-pvlmd_delete_note_radr="${delete_note}"
                                                    data-pvlmd_deleted_requested_by_radr="${deleted_requested_by}"
                                                    data-initiate_type_radr="transaction"
                                                    data-layer_type_radr="GARRO"
                                                >
                                                View Request
                                                </button>
                                            </div>`;
                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_gt);
                                html.push(reference_number);
                                html.push(property_number);
                                html.push(location); 
                                html.push(applicant_name); 
                                html.push(nature_of_interest);
                                html.push(date_of_instrument);
                                html.push(status); 
                                html.push(action); 

                                dataSet_gt.push(html);
                            }
                        }

                        $('#table_garro_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_garro_transaction_list').DataTable({ 
                            data: dataSet_gt
                        }).draw();
                    }

                }
            })
        }

        CallA();
    })

    
      $('#plvmd_approve_delete_request').on('shown.bs.modal', function(event) {
        $("#plvmd_approve_delete_request #pvlmd_id_radr").val($(event.relatedTarget).data('pvlmd_id_radr'));	
        $("#plvmd_approve_delete_request #pvlmd_reference_number_radr").val($(event.relatedTarget).data('pvlmd_reference_number_radr'));	
        $("#plvmd_approve_delete_request #pvlmd_delete_attachment_radr").val($(event.relatedTarget).data('pvlmd_delete_attachment_radr'));
        $("#plvmd_approve_delete_request #pvlmd_reviewed_by_radr").val($(event.relatedTarget).data('pvlmd_reviewed_by_radr'));	
        $("#plvmd_approve_delete_request #pvlmd_review_note_radr").val($(event.relatedTarget).data('pvlmd_review_note_radr'));
        $("#plvmd_approve_delete_request #initiate_type_radr").val($(event.relatedTarget).data('initiate_type_radr'));	
        $("#plvmd_approve_delete_request #layer_type_radr").val($(event.relatedTarget).data('layer_type_radr'));
        $("#plvmd_approve_delete_request #pvlmd_deleted_requested_by_radr").val($(event.relatedTarget).data('pvlmd_deleted_requested_by_radr'));	
        $("#plvmd_approve_delete_request #pvlmd_delete_note_radr").val($(event.relatedTarget).data('pvlmd_delete_note_radr'));

        console.log($(event.relatedTarget).data('pvlmd_delete_attachment_radr'))

        var file_path = $(event.relatedTarget).data('pvlmd_delete_attachment_radr');

        $.ajax({
            type : "POST",
            url : "Maps",
            data : {
                request_type : 'open_doc',
                file_path : file_path,
            },
            cache : false,
            xhrFields : {
                responseType : 'blob'
            },
            beforeSend : function() {
            },
            success : function(response) {
                var blob = new Blob([ response ], {
                    type : "application/pdf"
                });
                var objectUrl = URL.createObjectURL(blob);
                
                $('#elisdovumentpreviewblobfile_radr').attr('src', objectUrl);
            }

        })
    })

    

    $('#plvmd_confirm_approve_delete_request').on('shown.bs.modal', function(event) {
        $("#plvmd_confirm_approve_delete_request #pvlmd_id_aadr").val($(event.relatedTarget).data('pvlmd_id_aadr'));	
        $("#plvmd_confirm_approve_delete_request #pvlmd_reference_number_aadr").val($(event.relatedTarget).data('pvlmd_reference_number_aadr'));	
        $("#plvmd_confirm_approve_delete_request #pvlmd_delete_attachment_aadr").val($(event.relatedTarget).data('pvlmd_delete_attachment_aadr'));
        $("#plvmd_confirm_approve_delete_request #pvlmd_deleted_approved_by_aadr").val($(event.relatedTarget).data('pvlmd_deleted_approved_by_aadr'));	
        $("#plvmd_confirm_approve_delete_request #pvlmd_deleted_approve_note_aadr").val($(event.relatedTarget).data('pvlmd_deleted_approve_note_aadr'));	
        $("#plvmd_confirm_approve_delete_request #pvlmd_delete_note_aadr").val($(event.relatedTarget).data('pvlmd_delete_note_aadr'));
        $("#plvmd_confirm_approve_delete_request #initiate_type_aadr").val($(event.relatedTarget).data('initiate_type'));	
        $("#plvmd_confirm_approve_delete_request #pvlmd_layer_type_aadr").val($(event.relatedTarget).data('layer_type'));
        $("#plvmd_confirm_approve_delete_request #pvlmd_deleted_requested_by_aadr").val($(event.relatedTarget).data('pvlmd_deleted_requested_by_aadr'));	
        $("#plvmd_confirm_approve_delete_request #pvlmd_delete_note_aadr").val($(event.relatedTarget).data('pvlmd_delete_note_aadr'));
        $("#plvmd_confirm_approve_delete_request #pvlmd_reviewed_by_aadr").val($(event.relatedTarget).data('pvlmd_reviewed_by_aadr'));	
        $("#plvmd_confirm_approve_delete_request #pvlmd_review_note_aadr").val($(event.relatedTarget).data('pvlmd_review_note_aadr'));

        var file_path = $(event.relatedTarget).data('pvlmd_delete_attachment_aadr');

        $.ajax({
            type : "POST",
            url : "Maps",
            data : {
                request_type : 'open_doc',
                file_path : file_path,
            },
            cache : false,
            xhrFields : {
                responseType : 'blob'
            },
            beforeSend : function() {
            },
            success : function(response) {
                var blob = new Blob([ response ], {
                    type : "application/pdf"
                });
                var objectUrl = URL.createObjectURL(blob);
                
                $('#elisdovumentpreviewblobfile_aadr').attr('src', objectUrl);
            }

        })
    })

    $("#transaction_deletion_requested").on("click", function(e) {
        e.preventDefault()

        $("#body-bg-3").addClass('bg-active');
        $("#body-bg-2, #body-bg-1, #body-bg-4").removeClass('bg-active');
        $("#parcel_table_tab").addClass('d-none');
        $("#transaction_table_tab").removeClass('d-none');
        $("#parcel_search").addClass('d-none');
        $("#transaction_search").removeClass('d-none');
        $("#accordion_t").removeClass('d-none');

        var enq_tab_value = 'transaction_deletion_requested';

        function CallA() {

            let dataSet_pt = [];
            let num_pt = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'pvlmd_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_pt = +num_pt + 1;
                                let t_id = json_result.data[i].t_id;
                                let reference_number = json_result.data[i].reference_number;
                                let file_number = json_result.data[i].file_number;
                                let property_number = json_result.data[i].property_number;
                                let instrument_type = json_result.data[i].instrument_type;
                                let grantee = json_result.data[i].party2_defendant;
                                let grantor = json_result.data[i].party1_plaintiff;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let doc_number = json_result.data[i].doc_number;
                                let instrument_date = json_result.data[i].instrument_date;
                                let consent_date = json_result.data[i].consent_date;
                                let remarks = json_result.data[i].remarks;
                                let action = "";

                                switch(status) {
                                    case '':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-danger btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_initiate_delete_request"
                                                        data-pvlmd_id_idr="${t_id}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Send Request
                                                    </button>
                                                </div>`;
                                    break;

                                    case 'pending':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${t_id}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;

                                    case 'approved':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${t_id}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;

                                    case 'reviewed':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${t_id}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_pt);
                                html.push(reference_number);
                                html.push(doc_number);
                                html.push(instrument_type); 
                                html.push(instrument_date); 
                                html.push(consent_date);
                                html.push(grantor);
                                html.push(grantee);
                                html.push(remarks);
                                html.push(status); 
                                html.push(action); 

                                dataSet_pt.push(html);
                            }
                        }

                        $('#table_pvlmd_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_pvlmd_transaction_list').DataTable({ 
                            data: dataSet_pt
                        }).draw();
                    }

                    CallB();

                }
            })
        }

        function CallB() {

            let dataSet_ct = [];
            let num_ct = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'cro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_ct = +num_ct + 1;
                                let t_id = json_result.data[i].id;
                                let reference_number = json_result.data[i].doc_number;
                                let document_date = json_result.data[i].doc_date;
                                let document_type = json_result.data[i].doc_type;
                                let purpose = json_result.data[i].purpose;
                                let commencement_date = json_result.data[i].commencement_date;
                                let applicant_name = json_result.data[i].party2_2 == "" ? json_result.data[i].plaintiff : json_result.data[i].party2_2;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let action = "";

                                switch(status) {
                                    case '':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-danger btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_initiate_delete_request"
                                                        data-pvlmd_id_idr="${t_id}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Send Request
                                                    </button>
                                                </div>`;
                                    break;

                                    case 'pending':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${t_id}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;

                                    case 'approved':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${t_id}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;

                                    case 'reviewed':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${t_id}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_ct);
                                html.push(reference_number);
                                html.push(document_type);
                                html.push(purpose); 
                                html.push(applicant_name); 
                                html.push(commencement_date);
                                html.push(status); 
                                html.push(action); 

                                dataSet_ct.push(html);
                            }
                        }

                        $('#table_cro_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_cro_transaction_list').DataTable({ 
                            data: dataSet_ct
                        }).draw();
                    }

                    CallC();

                }
            })
        }

        function CallC() {

            let dataSet_gt = [];
            let num_gt = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'garro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_gt = +num_gt + 1;
                                let t_id = json_result.data[i].id;
                                let reference_number = json_result.data[i].document_no;
                                let property_number = json_result.data[i].property_no;
                                let date_of_instrument = json_result.data[i].date_of_instrument;
                                let nature_of_interest = json_result.data[i].nature_of_interest;
                                let location = json_result.data[i].location;
                                let sheet_no = json_result.data[i].sheet_no;
                                let applicant_name = json_result.data[i].grantee;
                                let interest = json_result.data[i].interest;
                                let purpose = json_result.data[i].purpose;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let action = "";

                                switch(status) {
                                    case '':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-danger btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_initiate_delete_request"
                                                        data-pvlmd_id_idr="${t_id}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Send Request
                                                    </button>
                                                </div>`;
                                    break;

                                    case 'pending':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${t_id}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;

                                    case 'approved':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${t_id}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;

                                    case 'reviewed':
                                        action = `<div class="text-center">
                                                    <button type="button" class="btn btn-outline-warning btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                        data-pvlmd_id_idr="${t_id}"
                                                        data-pvlmd_reference_number_idr="${reference_number}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="PVLMD"
                                                    >
                                                        Cancel Request
                                                    </button>
                                                </div>`;

                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_gt);
                                html.push(reference_number);
                                html.push(property_number);
                                html.push(location); 
                                html.push(applicant_name); 
                                html.push(nature_of_interest);
                                html.push(date_of_instrument);
                                html.push(status); 
                                html.push(action); 

                                dataSet_gt.push(html);
                            }
                        }

                        $('#table_garro_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_garro_transaction_list').DataTable({ 
                            data: dataSet_gt
                        }).draw();
                    }

                }
            })
        }

        CallA();
 
    })


    $("#transaction_deletion_approved").on("click", function(e) {
        e.preventDefault()

        $("#body-bg-4").addClass('bg-active');
        $("#body-bg-2, #body-bg-1, #body-bg-3").removeClass('bg-active');
        $("#parcel_table_tab").addClass('d-none');
        $("#transaction_table_tab").removeClass('d-none');
        $("#parcel_search").addClass('d-none');
        $("#transaction_search").removeClass('d-none');
        $("#accordion_t").removeClass('d-none');

        var enq_tab_value = 'transaction_deletion_approved';

        function CallA() {

            let dataSet_pt = [];
            let num_pt = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'pvlmd_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_pt = +num_pt + 1;
                                let t_id = json_result.data[i].t_id;
                                let reference_number = json_result.data[i].reference_number;
                                let file_number = json_result.data[i].file_number;
                                let property_number = json_result.data[i].property_number;
                                let instrument_type = json_result.data[i].instrument_type;
                                let grantee = json_result.data[i].party2_defendant;
                                let grantor = json_result.data[i].party1_plaintiff;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by;
                                let reviewed_by = json_result.data[i].reviewed_by;
                                let review_note = json_result.data[i].review_note;
                                let deleted_approved_by = json_result.data[i].deleted_approved_by;
                                let approve_note = json_result.data[i].approve_note;
                                let doc_number = json_result.data[i].doc_number;
                                let instrument_date = json_result.data[i].instrument_date;
                                let consent_date = json_result.data[i].consent_date;
                                let remarks = json_result.data[i].remarks;
                                let action = "";

                                switch(status) {

                                    case 'approved':
                                    action = `<div class="text-center">
                                                <button type="button" class="btn btn-outline-success btn-sm"
                                                    data-toggle="modal" data-target="#plvmd_confirm_approve_delete_request"
                                                    data-pvlmd_id_aadr="${t_id}"
                                                    data-pvlmd_reference_number_aadr="${reference_number}"
                                                    data-pvlmd_delete_attachment_aadr="${delete_attachment}"
                                                    data-pvlmd_deleted_approved_by_aadr="${deleted_approved_by}"
                                                    data-pvlmd_deleted_approve_note_aadr="${approve_note}"
                                                    data-pvlmd_delete_note_aadr="${delete_note}"
                                                    data-pvlmd_reviewed_by_aadr="${reviewed_by}"
                                                    data-pvlmd_review_note_aadr="${review_note}"
                                                    data-initiate_type="transaction"
                                                    data-layer_type="PVLMD"
                                                >
                                                    View Approval
                                                </button>
                                            </div>`;
                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_pt);
                                html.push(reference_number);
                                html.push(doc_number);
                                html.push(instrument_type); 
                                html.push(instrument_date); 
                                html.push(consent_date);
                                html.push(grantor);
                                html.push(grantee);
                                html.push(remarks);
                                html.push(status); 
                                html.push(action);  

                                dataSet_pt.push(html);
                            }
                        }

                        $('#table_pvlmd_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_pvlmd_transaction_list').DataTable({ 
                            data: dataSet_pt
                        }).draw();
                    }

                    CallB();

                }
            })
        }

        function CallB() {

            let dataSet_ct = [];
            let num_ct = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'cro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_ct = +num_ct + 1;
                                let t_id = json_result.data[i].id;
                                let reference_number = json_result.data[i].doc_number;
                                let document_date = json_result.data[i].doc_date;
                                let document_type = json_result.data[i].doc_type;
                                let purpose = json_result.data[i].purpose;
                                let commencement_date = json_result.data[i].commencement_date;
                                let applicant_name = json_result.data[i].party2_2 == "" ? json_result.data[i].plaintiff : json_result.data[i].party2_2;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by;
                                let reviewed_by = json_result.data[i].reviewed_by;
                                let review_note = json_result.data[i].review_note;
                                let deleted_approved_by = json_result.data[i].deleted_approved_by;
                                let approve_note = json_result.data[i].approve_note;
                                let action = "";

                                switch(status) {
                                    case 'approved':
                                    action = `<div class="text-center">
                                                <button type="button" class="btn btn-outline-success btn-sm"
                                                    data-toggle="modal" data-target="#plvmd_confirm_approve_delete_request"
                                                    data-pvlmd_id_aadr="${t_id}"
                                                    data-pvlmd_reference_number_aadr="${reference_number}"
                                                    data-pvlmd_delete_attachment_aadr="${delete_attachment}"
                                                    data-pvlmd_deleted_approved_by_aadr="${deleted_approved_by}"
                                                    data-pvlmd_deleted_approve_note_aadr="${approve_note}"
                                                    data-pvlmd_delete_note_aadr="${delete_note}"
                                                    data-pvlmd_reviewed_by_aadr="${reviewed_by}"
                                                    data-pvlmd_review_note_aadr="${review_note}"
                                                    data-initiate_type="transaction"
                                                    data-layer_type="CRO"
                                                >
                                                    View Approval
                                                </button>
                                            </div>`;
                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_ct);
                                html.push(reference_number);
                                html.push(document_type);
                                html.push(purpose); 
                                html.push(applicant_name); 
                                html.push(commencement_date);
                                html.push(status); 
                                html.push(action); 

                                dataSet_ct.push(html);
                            }
                        }

                        $('#table_cro_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_cro_transaction_list').DataTable({ 
                            data: dataSet_ct
                        }).draw();
                    }

                    CallC();

                }
            })
        }

        function CallC() {

            let dataSet_gt = [];
            let num_gt = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'garro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_gt = +num_gt + 1;
                                let t_id = json_result.data[i].id;
                                let reference_number = json_result.data[i].document_no;
                                let property_number = json_result.data[i].property_no;
                                let date_of_instrument = json_result.data[i].date_of_instrument;
                                let nature_of_interest = json_result.data[i].nature_of_interest;
                                let location = json_result.data[i].location;
                                let sheet_no = json_result.data[i].sheet_no;
                                let applicant_name = json_result.data[i].grantee;
                                let interest = json_result.data[i].interest;
                                let purpose = json_result.data[i].purpose;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by;
                                let reviewed_by = json_result.data[i].reviewed_by;
                                let review_note = json_result.data[i].review_note;
                                let deleted_approved_by = json_result.data[i].deleted_approved_by;
                                let approve_note = json_result.data[i].approve_note;
                                let action = "";

                                switch(status) {
                                    case 'approved':
                                    action = `<div class="text-center">
                                                <button type="button" class="btn btn-outline-success btn-sm"
                                                    data-toggle="modal" data-target="#plvmd_confirm_approve_delete_request"
                                                    data-pvlmd_id_aadr="${t_id}"
                                                    data-pvlmd_reference_number_aadr="${reference_number}"
                                                    data-pvlmd_delete_attachment_aadr="${delete_attachment}"
                                                    data-pvlmd_deleted_approved_by_aadr="${deleted_approved_by}"
                                                    data-pvlmd_deleted_approve_note_aadr="${approve_note}"
                                                    data-pvlmd_delete_note_aadr="${delete_note}"
                                                    data-pvlmd_reviewed_by_aadr="${reviewed_by}"
                                                    data-pvlmd_review_note_aadr="${review_note}"
                                                    data-initiate_type="transaction"
                                                    data-layer_type="GARRO"
                                                >
                                                    View Approval
                                                </button>
                                            </div>`;
                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_gt);
                                html.push(reference_number);
                                html.push(property_number);
                                html.push(location); 
                                html.push(applicant_name); 
                                html.push(nature_of_interest);
                                html.push(date_of_instrument);
                                html.push(status); 
                                html.push(action); 

                                dataSet_gt.push(html);
                            }
                        }

                        $('#table_garro_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_garro_transaction_list').DataTable({ 
                            data: dataSet_gt
                        }).draw();
                    }

                }
            })

        }

        CallA();
    })


    $("#btnPJobSearch").on("click", function () {
        // Check if radio button and input field filled
        $("#body-bg-2, #body-bg-4, #body-bg-3").removeClass('bg-active');

        if(checkInput()){
            // Submit Search
            var enq_search_type = "";
            var selected_rbtn = $("input[name='rbtn_search_type']:checked");
            if (selected_rbtn.length > 0) {
                enq_search_type = selected_rbtn.val();
                //console.log("selected " + enq_search_type);
            }

            var enq_search_value = $("#pd_search_value").val();
            var parcel_type = $("input[type='radio'][name='rbtn_search_type']:checked").val();
              
            if (enq_search_type.length <= 0){
                $.notify({
                    message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
                }, { type : 'danger' , z_index: 9999  });
                
            } else {

                switch(parcel_type) {
                    case 'pvlmd_layer':
                        
                        let dataSet_pl = [];
                        let num_pl = 0
        
                        $.ajax({
                            type : "POST",
                            url : "Maps",
                            data : {
                                request_type : 'search_pvlmd_parcel_details',
                                search_value : enq_search_value,
                                layer_type: parcel_type
                            },
                            cache : false,
                            success : function(response) {
        
                                let json_result = JSON.parse(response);
                                console.log(json_result)
        
                                if(json_result.success){
                                    if(json_result.data !== null){
                                        for(let i=0; i<json_result.data.length; i++){
                                            let html=[];
                                            num_pl = +num_pl + 1;
                                            let gid = json_result.data[i].gid;
                                            let reference_number = json_result.data[i].reference_number;
                                            let file_number = json_result.data[i].file_number;
                                            let locality = json_result.data[i].locality;
                                            let plotting_date = convertDate(json_result.data[i].plotting_date.slice(0,10));
                                            let plotted_by = json_result.data[i].plotted_by;
                                            let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                            let action = "";
        
                                            switch(status) {
                                                case '':
                                                    action = `<div class="text-center">
                                                                <button type="button" class="btn btn-outline-danger btn-sm"
                                                                    data-toggle="modal" data-target="#plvmd_initiate_delete_request"
                                                                    data-pvlmd_id_idr="${gid}"
                                                                    data-pvlmd_reference_number_idr="${reference_number}"
                                                                    data-initiate_type="parcel"
                                                                    data-layer_type="PVLMD"
                                                                >
                                                                    Send Request
                                                                </button>
                                                            </div>`;
                                                break;
        
                                                case 'pending':
                                                    action = `<div class="text-center">
                                                                <button type="button" class="btn btn-outline-warning btn-sm"
                                                                    data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                    data-pvlmd_id_idr="${gid}"
                                                                    data-pvlmd_reference_number_idr="${reference_number}"
                                                                    data-initiate_type="parcel"
                                                                    data-layer_type="PVLMD"
                                                                >
                                                                    Cancel Request
                                                                </button>
                                                            </div>`;
        
                                                break;
        
                                                case 'confirmed':
                                                    action = `<div class="text-center">
                                                                <button type="button" class="btn btn-outline-secondary btn-sm disabled"
                                                                    data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                    data-pvlmd_id_idr="${gid}"
                                                                    data-pvlmd_reference_number_idr="${reference_number}"
                                                                    data-initiate_type="parcel"
                                                                    data-layer_type="PVLMD"
                                                                >
                                                                    Not Available
                                                                </button>
                                                            </div>`;
                                                break;
                                            }
        
                                            if(status == '') {
                                                status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                            } else if(status == 'pending') {
                                                status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                            } else if(status == 'approved') {
                                                status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                            } else if(status == 'reviewed') {
                                                status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                            }
        
                                            html.push(num_pl);
                                            html.push(reference_number);
                                            html.push(file_number);
                                            html.push(locality); 
                                            html.push(plotting_date); 
                                            html.push(plotted_by);
                                            html.push(status); 
                                            html.push(action); 
        
                                            dataSet_pl.push(html);
                                        }
                                    }
        
                                    $('#table_pvlmd_parcel_list').DataTable().clear().destroy();
                                        
                                    $('#table_pvlmd_parcel_list').DataTable({ 
                                        data: dataSet_pl
                                    }).draw();
        
                                    $("#collapseOne").addClass('show');
                                    $("#collapseTwo").removeClass('show');
                                    $("#collapseThree").removeClass('show');
                                }
        
                            }
                        })
                    break;
        
                    case 'garro_layer':
                        
                        let dataSet_gl = [];
                        let num_gl = 0
        
                        $.ajax({
                            type : "POST",
                            url : "Maps",
                            data : {
                                request_type : 'search_pvlmd_parcel_details',
                                search_value : enq_search_value,
                                layer_type: parcel_type
                            },
                            cache : false,
                            success : function(response) {
        
                                let json_result = JSON.parse(response);
                                console.log(json_result)
        
                                if(json_result.success){
                                    if(json_result.data !== null){
                                        for(let i=0; i<json_result.data.length; i++){
                                            let html=[];
                                            num_gl = +num_gl + 1;
                                            let gid = json_result.data[i].gid;
                                            // let document_no = json_result.data[i].document_no;
                                            // let date_of_instrument = json_result.data[i].date_of_instrument;
                                            let prop_no = json_result.data[i].prop_no;
                                            // let date_of_plotting = json_result.data[i].date_of_plotting == null ? '' : convertDate(json_result.data[i].date_of_plotting.slice(0,10));
                                            // let nature_of_interest = json_result.data[i].nature_of_interest;
                                            // let grantee = json_result.data[i].grantee;
                                            // let location = json_result.data[i].location;
                                            // let file_no = json_result.data[i].file_no;
                                            let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                            let action = "";
        
                                            switch(status) {
                                                case '':
                                                    action = `<div class="text-center">
                                                                <button type="button" class="btn btn-outline-danger btn-sm"
                                                                    data-toggle="modal" data-target="#plvmd_initiate_delete_request"
                                                                    data-pvlmd_id_idr="${gid}"
                                                                    data-pvlmd_reference_number_idr="${prop_no}"
                                                                    data-initiate_type="parcel"
                                                                    data-layer_type="GARRO"
                                                                >
                                                                    Send Request
                                                                </button>
                                                            </div>`;
                                                break;
        
                                                case 'pending':
                                                    action = `<div class="text-center">
                                                                <button type="button" class="btn btn-outline-warning btn-sm"
                                                                    data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                    data-pvlmd_id_idr="${gid}"
                                                                    data-pvlmd_reference_number_idr="${prop_no}"
                                                                    data-initiate_type="parcel"
                                                                    data-layer_type="GARRO"
                                                                >
                                                                    Cancel Request
                                                                </button>
                                                            </div>`;
        
                                                break;
        
                                                case 'confirmed':
                                                    action = `<div class="text-center">
                                                                <button type="button" class="btn btn-outline-secondary btn-sm disabled"
                                                                    data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                    data-pvlmd_id_idr="${gid}"
                                                                    data-pvlmd_reference_number_idr="${prop_no}"
                                                                    data-initiate_type="parcel"
                                                                    data-layer_type="GARRO"
                                                                >
                                                                    Not Available
                                                                </button>
                                                            </div>`;
                                                break;
                                            }
        
                                            if(status == '') {
                                                status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                            } else if(status == 'pending') {
                                                status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                            } else if(status == 'approved') {
                                                status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                            } else if(status == 'reviewed') {
                                                status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                            }
        
                                            html.push(num_gl);
                                            html.push(gid);
                                            html.push(prop_no);
                                            // html.push(grantee); 
                                            // html.push(location); 
                                            // html.push(date_of_plotting);
                                            html.push(status); 
                                            html.push(action); 
        
                                            dataSet_gl.push(html);
                                        }
                                    }
        
                                    $('#table_garro_parcel_list').DataTable().clear().destroy();
                                        
                                    $('#table_garro_parcel_list').DataTable({ 
                                        data: dataSet_gl
                                    }).draw();
        
                                    $("#collapseOne").removeClass('show');
                                    $("#collapseTwo").addClass('show');
                                    $("#collapseThree").removeClass('show');
                                }
        
                            }
                        })
                    break;
        
                    case 'cro_layer':
                        
                        let dataSet_cl = [];
                        let num_cl = 0
        
                        $.ajax({
                            type : "POST",
                            url : "Maps",
                            data : {
                                request_type : 'search_pvlmd_parcel_details',
                                search_value : enq_search_value,
                                layer_type: parcel_type
                            },
                            cache : false,
                            success : function(response) {
        
                                let json_result = JSON.parse(response);
                                console.log(json_result)
        
                                if(json_result.success){
                                    if(json_result.data !== null){
                                        for(let i=0; i<json_result.data.length; i++){
                                            let html=[];
                                            num_cl = +num_cl + 1;
                                            let gid = json_result.data[i].gid;
                                            let file_number = json_result.data[i].file_number;
                                            let ls_number = json_result.data[i].ls_number;
                                            let plan_number = json_result.data[i].plan_number;
                                            //let date_of_plotting = json_result.data[i].date_of_plotting == null ? '' : convertDate(json_result.data[i].date_of_plotting.slice(0,10));
                                            let plot_number = json_result.data[i].plot_number;
                                            let locality = json_result.data[i].locality;
                                            let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                            let action = "";
        
                                            switch(status) {
                                                case '':
                                                    action = `<div class="text-center">
                                                                <button type="button" class="btn btn-outline-danger btn-sm"
                                                                    data-toggle="modal" data-target="#plvmd_initiate_delete_request"
                                                                    data-pvlmd_id_idr="${gid}"
                                                                    data-pvlmd_reference_number_idr="${file_number}"
                                                                    data-initiate_type="parcel"
                                                                    data-layer_type="CRO"
                                                                >
                                                                    Send Request
                                                                </button>
                                                            </div>`;
                                                break;
        
                                                case 'pending':
                                                    action = `<div class="text-center">
                                                                <button type="button" class="btn btn-outline-warning btn-sm"
                                                                    data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                    data-pvlmd_id_idr="${gid}"
                                                                    data-pvlmd_reference_number_idr="${file_number}"
                                                                    data-initiate_type="parcel"
                                                                    data-layer_type="CRO"
                                                                >
                                                                    Cancel Request
                                                                </button>
                                                            </div>`;
        
                                                break;
        
                                                case 'confirmed':
                                                    action = `<div class="text-center">
                                                                <button type="button" class="btn btn-outline-secondary btn-sm disabled"
                                                                    data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                    data-pvlmd_id_idr="${gid}"
                                                                    data-pvlmd_reference_number_idr="${file_number}"
                                                                    data-initiate_type="parcel"
                                                                    data-layer_type="CRO"
                                                                >
                                                                    Not Available
                                                                </button>
                                                            </div>`;
                                                break;
                                            }
        
                                            if(status == '') {
                                                status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                            } else if(status == 'pending') {
                                                status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                            } else if(status == 'confirmed') {
                                                status = '<div class="text-center"><span class="badge badge-danger">Deleted</span></div>'
                                            }
        
                                            html.push(num_cl);
                                            html.push(file_number);
                                            html.push(ls_number);
                                            html.push(plan_number); 
                                            html.push(plot_number); 
                                            html.push(locality);
                                            html.push(status); 
                                            html.push(action); 
        
                                            dataSet_cl.push(html);
                                        }
                                    }
        
                                    $('#table_cro_parcel_list').DataTable().clear().destroy();
                                        
                                    $('#table_cro_parcel_list').DataTable({ 
                                        data: dataSet_cl
                                    }).draw();
        
                                    $("#collapseOne").removeClass('show');
                                    $("#collapseTwo").removeClass('show');
                                    $("#collapseThree").addClass('show');
                                }
        
                            }
                        })
                    break;
                }

            }
        }

    })

    $("#btnTJobSearch").on("click", function () {
        // Check if radio button and input field filled
        $("#body-bg-2, #body-bg-1, #body-bg-4").removeClass('bg-active');

        if(checkInput_()){
            // Submit Search
            var enq_search_type = "";
            var selected_rbtn = $("input[name='rbtn_search_type']:checked");
            if (selected_rbtn.length > 0) {
                enq_search_type = selected_rbtn.val();
                //console.log("selected " + enq_search_type);
            }

            var enq_search_value = $("#pt_search_value").val();
            var parcel_type = $("input[type='radio'][name='rbtn_search_type']:checked").val();
              
            if (enq_search_type.length <= 0){
                $.notify({
                    message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
                }, { type : 'danger' , z_index: 9999  });
                
            } else {

                switch(parcel_type) {
                    case 'pvlmd_layer':
                        
                    let dataSet_pt = [];
                    let num_pt = 0
            
                    $.ajax({
                        type : "POST",
                        url : "Maps",
                        data : {
                            request_type : 'search_pvlmd_transaction_details',
                            search_value : enq_search_value,
                            layer_type: parcel_type
                        },
                        cache : false,
                        success : function(response) {
            
                            let json_result = JSON.parse(response);
                            console.log(json_result)
            
                            if(json_result.success){
                                if(json_result.data !== null){
                                    for(let i=0; i<json_result.data.length; i++){
                                        let html=[];
                                        num_pt = +num_pt + 1;
                                        let t_id = json_result.data[i].t_id;
                                        let reference_number = json_result.data[i].reference_number;
                                        let file_number = json_result.data[i].file_number;
                                        let property_number = json_result.data[i].property_number;
                                        let instrument_type = json_result.data[i].instrument_type;
                                        let grantee = json_result.data[i].party2_defendant;
                                let grantor = json_result.data[i].party1_plaintiff;
                                        let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                        let doc_number = json_result.data[i].doc_number;
                                let instrument_date = json_result.data[i].instrument_date;
                                let consent_date = json_result.data[i].consent_date;
                                let remarks = json_result.data[i].remarks;
                                        let action = "";
            
                                        switch(status) {
                                            case '':
                                                action = `<div class="text-center">
                                                            <button type="button" class="btn btn-outline-danger btn-sm"
                                                                data-toggle="modal" data-target="#plvmd_initiate_delete_request"
                                                                data-pvlmd_id_idr="${t_id}"
                                                                data-pvlmd_reference_number_idr="${reference_number}"
                                                                data-initiate_type="transaction"
                                                                data-layer_type="PVLMD"
                                                            >
                                                                Send Request
                                                            </button>
                                                        </div>`;
                                            break;
            
                                            case 'pending':
                                                action = `<div class="text-center">
                                                            <button type="button" class="btn btn-outline-warning btn-sm"
                                                                data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                data-pvlmd_id_idr="${t_id}"
                                                                data-pvlmd_reference_number_idr="${reference_number}"
                                                                data-initiate_type="transaction"
                                                                data-layer_type="PVLMD"
                                                            >
                                                                Cancel Request
                                                            </button>
                                                        </div>`;
            
                                            break;
            
                                            case 'approved':
                                                action = `<div class="text-center">
                                                            <button type="button" class="btn btn-outline-warning btn-sm"
                                                                data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                data-pvlmd_id_idr="${t_id}"
                                                                data-pvlmd_reference_number_idr="${reference_number}"
                                                                data-initiate_type="transaction"
                                                                data-layer_type="PVLMD"
                                                            >
                                                                Cancel Request
                                                            </button>
                                                        </div>`;
            
                                            break;
            
                                            case 'reviewed':
                                                action = `<div class="text-center">
                                                            <button type="button" class="btn btn-outline-warning btn-sm"
                                                                data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                data-pvlmd_id_idr="${t_id}"
                                                                data-pvlmd_reference_number_idr="${reference_number}"
                                                                data-initiate_type="transaction"
                                                                data-layer_type="PVLMD"
                                                            >
                                                                Cancel Request
                                                            </button>
                                                        </div>`;
            
                                            break;
                                        }
            
                                        if(status == '') {
                                            status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                        } else if(status == 'pending') {
                                            status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                        } else if(status == 'approved') {
                                            status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                        } else if(status == 'reviewed') {
                                            status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                        }
            
                                        html.push(num_pt);
                                        html.push(reference_number);
                                        html.push(doc_number);
                                        html.push(instrument_type); 
                                        html.push(instrument_date); 
                                        html.push(consent_date);
                                        html.push(grantor);
                                        html.push(grantee);
                                        html.push(remarks);
                                        html.push(status); 
                                        html.push(action); 
            
                                        dataSet_pt.push(html);
                                    }
                                }
            
                                $('#table_pvlmd_transaction_list').DataTable().clear().destroy();
                                    
                                $('#table_pvlmd_transaction_list').DataTable({ 
                                    data: dataSet_pt
                                }).draw();

                                $("#collapseOne_t").addClass('show');
                                $("#collapseTwo_t").removeClass('show');
                                $("#collapseThree_t").removeClass('show');
                            }
            
                        }
                    })
                    break;
        
                    case 'cro_layer':
                        
                    let dataSet_ct = [];
                    let num_ct = 0
            
                    $.ajax({
                        type : "POST",
                        url : "Maps",
                        data : {
                            request_type : 'search_pvlmd_transaction_details',
                            search_value : enq_search_value,
                            layer_type: parcel_type
                        },
                        cache : false,
                        success : function(response) {
            
                            let json_result = JSON.parse(response);
                            console.log(json_result)
            
                            if(json_result.success){
                                if(json_result.data !== null){
                                    for(let i=0; i<json_result.data.length; i++){
                                        let html=[];
                                        num_ct = +num_ct + 1;
                                        let t_id = json_result.data[i].id;
                                        let reference_number = json_result.data[i].doc_number;
                                        let document_date = json_result.data[i].doc_date;
                                        let document_type = json_result.data[i].doc_type;
                                        let purpose = json_result.data[i].purpose;
                                        let commencement_date = json_result.data[i].commencement_date;
                                        let applicant_name = json_result.data[i].party2_2 == "" ? json_result.data[i].plaintiff : json_result.data[i].party2_2;
                                        let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                        let action = "";
            
                                        switch(status) {
                                            case '':
                                                action = `<div class="text-center">
                                                            <button type="button" class="btn btn-outline-danger btn-sm"
                                                                data-toggle="modal" data-target="#plvmd_initiate_delete_request"
                                                                data-pvlmd_id_idr="${t_id}"
                                                                data-pvlmd_reference_number_idr="${reference_number}"
                                                                data-initiate_type="transaction"
                                                                data-layer_type="CRO"
                                                            >
                                                                Send Request
                                                            </button>
                                                        </div>`;
                                            break;
            
                                            case 'pending':
                                                action = `<div class="text-center">
                                                            <button type="button" class="btn btn-outline-warning btn-sm"
                                                                data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                data-pvlmd_id_idr="${t_id}"
                                                                data-pvlmd_reference_number_idr="${reference_number}"
                                                                data-initiate_type="transaction"
                                                                data-layer_type="CRO"
                                                            >
                                                                Cancel Request
                                                            </button>
                                                        </div>`;
            
                                            break;
            
                                            case 'approved':
                                                action = `<div class="text-center">
                                                            <button type="button" class="btn btn-outline-warning btn-sm"
                                                                data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                data-pvlmd_id_idr="${t_id}"
                                                                data-pvlmd_reference_number_idr="${reference_number}"
                                                                data-initiate_type="transaction"
                                                                data-layer_type="CRO"
                                                            >
                                                                Cancel Request
                                                            </button>
                                                        </div>`;
            
                                            break;
            
                                            case 'reviewed':
                                                action = `<div class="text-center">
                                                            <button type="button" class="btn btn-outline-warning btn-sm"
                                                                data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                data-pvlmd_id_idr="${t_id}"
                                                                data-pvlmd_reference_number_idr="${reference_number}"
                                                                data-initiate_type="transaction"
                                                                data-layer_type="CRO"
                                                            >
                                                                Cancel Request
                                                            </button>
                                                        </div>`;
            
                                            break;
                                        }
            
                                        if(status == '') {
                                            status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                        } else if(status == 'pending') {
                                            status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                        } else if(status == 'approved') {
                                            status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                        } else if(status == 'reviewed') {
                                            status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                        }
            
                                        html.push(num_ct);
                                        html.push(reference_number);
                                        html.push(document_type);
                                        html.push(purpose); 
                                        html.push(applicant_name); 
                                        html.push(commencement_date);
                                        html.push(status); 
                                        html.push(action); 
            
                                        dataSet_ct.push(html);
                                    }
                                }
            
                                $('#table_cro_transaction_list').DataTable().clear().destroy();
                                    
                                $('#table_cro_transaction_list').DataTable({ 
                                    data: dataSet_ct
                                }).draw();

                                $("#collapseOne_t").removeClass('show');
                                $("#collapseTwo_t").removeClass('show');
                                $("#collapseThree_t").addClass('show');
                            }
            
                        }
                    })
                    break;
        
                    case 'garro_layer':
                        
                    let dataSet_gt = [];
                    let num_gt = 0
            
                    $.ajax({
                        type : "POST",
                        url : "Maps",
                        data : {
                            request_type : 'search_pvlmd_transaction_details',
                            search_value : enq_search_value,
                            layer_type: parcel_type
                        },
                        cache : false,
                        success : function(response) {
            
                            let json_result = JSON.parse(response);
                            console.log(json_result)
            
                            if(json_result.success){
                                if(json_result.data !== null){
                                    for(let i=0; i<json_result.data.length; i++){
                                        let html=[];
                                        num_gt = +num_gt + 1;
                                        let t_id = json_result.data[i].id;
                                        let reference_number = json_result.data[i].document_no;
                                        let property_number = json_result.data[i].property_no;
                                        let date_of_instrument = json_result.data[i].date_of_instrument;
                                        let nature_of_interest = json_result.data[i].nature_of_interest;
                                        let location = json_result.data[i].location;
                                        let sheet_no = json_result.data[i].sheet_no;
                                        let applicant_name = json_result.data[i].grantee;
                                        let interest = json_result.data[i].interest;
                                        let purpose = json_result.data[i].purpose;
                                        let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                        let action = "";
            
                                        switch(status) {
                                            case '':
                                                action = `<div class="text-center">
                                                            <button type="button" class="btn btn-outline-danger btn-sm"
                                                                data-toggle="modal" data-target="#plvmd_initiate_delete_request"
                                                                data-pvlmd_id_idr="${t_id}"
                                                                data-pvlmd_reference_number_idr="${reference_number}"
                                                                data-initiate_type="transaction"
                                                                data-layer_type="GARRO"
                                                            >
                                                                Send Request
                                                            </button>
                                                        </div>`;
                                            break;
            
                                            case 'pending':
                                                action = `<div class="text-center">
                                                            <button type="button" class="btn btn-outline-warning btn-sm"
                                                                data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                data-pvlmd_id_idr="${t_id}"
                                                                data-pvlmd_reference_number_idr="${reference_number}"
                                                                data-initiate_type="transaction"
                                                                data-layer_type="GARRO"
                                                            >
                                                                Cancel Request
                                                            </button>
                                                        </div>`;
            
                                            break;
            
                                            case 'approved':
                                                action = `<div class="text-center">
                                                            <button type="button" class="btn btn-outline-warning btn-sm"
                                                                data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                data-pvlmd_id_idr="${t_id}"
                                                                data-pvlmd_reference_number_idr="${reference_number}"
                                                                data-initiate_type="transaction"
                                                                data-layer_type="GARRO"
                                                            >
                                                                Cancel Request
                                                            </button>
                                                        </div>`;
            
                                            break;
            
                                            case 'reviewed':
                                                action = `<div class="text-center">
                                                            <button type="button" class="btn btn-outline-warning btn-sm"
                                                                data-toggle="modal" data-target="#plvmd_cancel_delete_request"
                                                                data-pvlmd_id_idr="${t_id}"
                                                                data-pvlmd_reference_number_idr="${reference_number}"
                                                                data-initiate_type="transaction"
                                                                data-layer_type="GARRO"
                                                            >
                                                                Cancel Request
                                                            </button>
                                                        </div>`;
            
                                            break;
                                        }
            
                                        if(status == '') {
                                            status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                        } else if(status == 'pending') {
                                            status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                        } else if(status == 'approved') {
                                            status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                        } else if(status == 'reviewed') {
                                            status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                        }
            
                                        html.push(num_gt);
                                        html.push(reference_number);
                                        html.push(property_number);
                                        html.push(location); 
                                        html.push(applicant_name); 
                                        html.push(nature_of_interest);
                                        html.push(date_of_instrument);
                                        html.push(status); 
                                        html.push(action); 
            
                                        dataSet_gt.push(html);
                                    }
                                }
            
                                $('#table_cro_transaction_list').DataTable().clear().destroy();
                                    
                                $('#table_cro_transaction_list').DataTable({ 
                                    data: dataSet_gt
                                }).draw();

                                $("#collapseOne_t").removeClass('show');
                                $("#collapseTwo_t").addClass('show');
                                $("#collapseThree_t").removeClass('show');
                            }
            
                        }
                    })
                    break;
                }

            }
        }

    })

    function checkInput(){
        let checkedList=[];
        let cc_search_value = $('#pd_search_value').val();
        let checkBoxes =document.getElementsByClassName('rbtn_search_type');
        for (let i=0;i<checkBoxes.length;i++){
            if(checkBoxes[i].checked){
                checkedValue=checkBoxes[i].value;
                checkedList.push(checkedValue);
            }
        }
                   
        if(checkedList.length === 0){
            //toastr["error"]("Nothing selected ", "Error");
            $.notify({
                message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Nothing selected.</span>',
            }, { type : 'danger' , z_index: 9999  });
            return false;
        } else if (!cc_search_value){
            //toastr["error"]("Search keyword required ", "Error");
            $.notify({
                message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Search keyword required.</span>',
            }, { type : 'danger' , z_index: 9999  });
            return false;
        }
        else{
            return true;
        }
    }

    function checkInput_(){
        let checkedList=[];
        let cc_search_value = $('#pt_search_value').val();
        let checkBoxes = $("input[name='rbtn_search_type']");
        for (let i=0;i<checkBoxes.length;i++){
            if(checkBoxes[i].checked){
                checkedValue=checkBoxes[i].value;
                checkedList.push(checkedValue);
            }
        }
                   
        if(checkedList.length === 0){
            //toastr["error"]("Nothing selected ", "Error");
            $.notify({
                message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Nothing selected.</span>',
            }, { type : 'danger' , z_index: 9999  });
            return false;
        } else if (!cc_search_value){
            //toastr["error"]("Search keyword required ", "Error");
            $.notify({
                message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Search keyword required.</span>',
            }, { type : 'danger' , z_index: 9999  });
            return false;
        }
        else{
            return true;
        }
    }


    $('#plvmd_initiate_delete_request').on('shown.bs.modal', function(event) {
        $("#plvmd_initiate_delete_request #pvlmd_id_idr").val($(event.relatedTarget).data('pvlmd_id_idr'));	
        $("#plvmd_initiate_delete_request #pvlmd_reference_number_idr").val($(event.relatedTarget).data('pvlmd_reference_number_idr'));	
        $("#plvmd_initiate_delete_request #initiate_type").val($(event.relatedTarget).data('initiate_type'));
        $("#plvmd_initiate_delete_request #pvlmd_layer_type_idr").val($(event.relatedTarget).data('layer_type'));
    })
    

    $('#btn_initiate_pvlmd_delete_request').on('click', function(e) {
        e.preventDefault()

        var _id = $('#pvlmd_id_idr').val();
        var reference_number = $('#pvlmd_reference_number_idr').val();
        var delete_note = $('#pvlmd_delete_note_idr').val();
        var initiate_type = $('#initiate_type').val();

        let formdata = new FormData();
			
        formdata.append("_id",_id);
        formdata.append("reference_number",reference_number);
        formdata.append("delete_note",delete_note);
        formdata.append("initiate_type",initiate_type);

        jQuery.each(jQuery('#pvlmd_attachment_location_idr')[0].files,function(i,file){
            formdata.append('file',file);
        })

        formdata.append("request_type",'select_pvlmd_initiate_delete_request');

        $.ajax({
			method:"POST",
			enctype : 'multipart/form-data',
			url : "Maps",
			data : formdata,
			processData : false,
			contentType : false,
			cache : false,
			success:function(response){
                
				console.log(response);
			    let json_result = JSON.parse(response);

			    if(json_result.success){
				    //toastr["success"]("Request intiated successfully", "Success");

                    $.notify({
                        message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Request intiated successfully.</span>',
                    }, { type : 'success', z_index : 9999 });
                } 
                else{
                    $.notify({
                        message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error occurred uploading file".</span>',
                    }, { type : 'danger' , z_index: 9999  });
                }

                $("#plvmd_initiate_delete_request").find('form').trigger('reset');
                $("#plvmd_initiate_delete_request").modal('hide');

                setTimeout(function(){
                    location.reload();
                },1000); 
			}
			
		})

    })

    $('#plvmd_cancel_delete_request').on('shown.bs.modal', function(event) {
        $("#plvmd_cancel_delete_request #pvlmd_id_cdr").val($(event.relatedTarget).data('pvlmd_id_idr') == "" ? $('#pvlmd_id_aadr').val() : $(event.relatedTarget).data('pvlmd_id_idr'));	
        $("#plvmd_cancel_delete_request #pvlmd_reference_number_cdr").val($(event.relatedTarget).data('pvlmd_reference_number_idr') == "" ? $('#pvlmd_reference_number_aadr').val() : $(event.relatedTarget).data('pvlmd_reference_number_idr'));
        $("#plvmd_cancel_delete_request #initiate_type_cdr").val($(event.relatedTarget).data('initiate_type') == "" ? $('#initiate_type_aadr').val() : $(event.relatedTarget).data('initiate_type'));
        $("#plvmd_cancel_delete_request #layer_type_cdr").val($(event.relatedTarget).data('layer_type') == "" ? $('#pvlmd_layer_type_aadr').val() : $(event.relatedTarget).data('layer_type'));
    })

    $('#btn_cancel_pvlmd_delete_request').on('click', function(e) {
        e.preventDefault()

        var _id = $('#pvlmd_id_cdr').val();
        var reference_number = $('#pvlmd_reference_number_cdr').val();
        var initiate_type = $('#initiate_type_cdr').val();
        var layer_type = $('#layer_type_cdr').val();

        $.ajax({
			type : "POST",
            url : "Maps",
			data : {
                request_type : 'select_plvmd_cancel_delete_request',
                _id : _id,
                reference_number: reference_number,
                initiate_type: initiate_type,
                layer_type: layer_type
            },
			cache : false,
			success:function(response){
                
				console.log(response);
			    let json_result = JSON.parse(response);

			    if(json_result.success){
				   // toastr["success"]("Request intiated successfully", "Success");
                   $.notify({
                    message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Request canceled successfully.</span>',
                }, { type : 'success', z_index : 9999 });
                   
                } 
                else{
                   // toastr["error"]("Error occurred uploading file", "Error");
                   $.notify({
                    message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error occurred uploading file".</span>',
                }, { type : 'danger' , z_index: 9999  });
                }

                $("#plvmd_cancel_delete_request").find('form').trigger('reset');
                $("#plvmd_cancel_delete_request").modal('hide');

                setTimeout(function(){
                    location.reload();
                },1000); 
			}
			
		})

    })

    $("#parcel_deletion_requested_approval").on("click", function(e) {


        $("#body-bg-1").addClass('bg-active');
        $("#body-bg-2, #body-bg-3, #body-bg-4").removeClass('bg-active');
        $("#parcel_table_tab").removeClass('d-none');
        $("#transaction_table_tab").addClass('d-none');
        $("#parcel_search").removeClass('d-none');
        $("#transaction_search").addClass('d-none');
        $("#parcel_tab").removeClass('d-none');
        $("#parcel_approval_tab").addClass('d-none');
        $("#accordion_p").removeClass('d-none');

        var enq_tab_value = 'parcel_deletion_requested';

        function CallA() {

            let dataSet_pl = [];
            let num_pl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: "pvlmd_layer"
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_pl = +num_pl + 1;
                                let gid = json_result.data[i].gid;
                                let reference_number = json_result.data[i].reference_number;
                                let file_number = json_result.data[i].file_number;
                                let locality = json_result.data[i].locality;
                                let plotting_date = convertDate(json_result.data[i].plotting_date.slice(0,10));
                                let plotted_by = json_result.data[i].plotted_by;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by;
                                let action = "";

                                switch(status) {

                                case 'pending':
                                    action = `<div class="text-center">

                                                <button type="button" class="btn btn-outline-success btn-sm"
                                                    data-toggle="modal" data-target="#plvmd_review_delete_request"
                                                    data-pvlmd_id_adr="${gid}"
                                                    data-pvlmd_reference_number_adr="${reference_number}"
                                                    data-pvlmd_delete_note_adr="${delete_note}"
                                                    data-pvlmd_delete_attachment_adr="${delete_attachment}"
                                                    data-pvlmd_delete_requested_by_adr="${deleted_requested_by}"
                                                    data-initiate_type="parcel"
                                                    data-layer_type="PVLMD"
                                                >
                                                View Request
                                                </button>
                                            </div>`;

                                break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_pl);
                                html.push(reference_number);
                                html.push(file_number);
                                html.push(locality); 
                                html.push(plotting_date); 
                                html.push(plotted_by);
                                html.push(status); 
                                html.push(action); 

                                dataSet_pl.push(html);
                            }
                        }

                        $('#table_pvlmd_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_pvlmd_parcel_list').DataTable({ 
                            data: dataSet_pl
                        }).draw();
                    }

                    CallB();

                }
            })
        }

        function CallB() {

            let dataSet_gl = [];
            let num_gl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: "garro_layer"
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_gl = +num_gl + 1;
                                let gid = json_result.data[i].gid;
                                let prop_no = json_result.data[i].prop_no;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by;
                                let action = "";

                                switch(status) {

                                case 'pending':
                                    action = `<div class="text-center">

                                                <button type="button" class="btn btn-outline-success btn-sm"
                                                    data-toggle="modal" data-target="#plvmd_review_delete_request"
                                                    data-pvlmd_id_adr="${gid}"
                                                    data-pvlmd_reference_number_adr="${prop_no}"
                                                    data-pvlmd_delete_note_adr="${delete_note}"
                                                    data-pvlmd_delete_attachment_adr="${delete_attachment}"
                                                    data-pvlmd_delete_requested_by_adr="${deleted_requested_by}"
                                                    data-initiate_type="parcel"
                                                    data-layer_type="GARRO"
                                                >
                                                View Request
                                                </button>
                                            </div>`;

                                break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_gl);
                                html.push(gid);
                                html.push(prop_no);
                                html.push(status); 
                                html.push(action); 

                                dataSet_gl.push(html);
                            }
                        }

                        $('#table_garro_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_garro_parcel_list').DataTable({ 
                            data: dataSet_gl
                        }).draw();
                    }

                    CallC();

                }
            })
        }

        function CallC() {

            let dataSet_cl = [];
            let num_cl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: "cro_layer"
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_cl = +num_cl + 1;
                                let gid = json_result.data[i].gid;
                                let file_number = json_result.data[i].file_number;
                                let ls_number = json_result.data[i].ls_number;
                                let plan_number = json_result.data[i].plan_number;
                                let plot_number = json_result.data[i].plot_number;
                                let locality = json_result.data[i].locality;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by;
                                let action = "";

                                switch(status) {

                                case 'pending':
                                    action = `<div class="text-center">

                                                <button type="button" class="btn btn-outline-success btn-sm"
                                                    data-toggle="modal" data-target="#plvmd_review_delete_request"
                                                    data-pvlmd_id_adr="${gid}"
                                                    data-pvlmd_reference_number_adr="${file_number}"
                                                    data-pvlmd_delete_note_adr="${delete_note}"
                                                    data-pvlmd_delete_attachment_adr="${delete_attachment}"
                                                    data-pvlmd_delete_requested_by_adr="${deleted_requested_by}"
                                                    data-initiate_type="parcel"
                                                    data-layer_type="CRO"
                                                >
                                                View Request
                                                </button>
                                            </div>`;

                                break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_cl);
                                html.push(file_number);
                                html.push(ls_number);
                                html.push(plan_number); 
                                html.push(plot_number); 
                                html.push(locality);
                                html.push(status); 
                                html.push(action); 

                                dataSet_cl.push(html);
                            }
                        }

                        $('#table_cro_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_cro_parcel_list').DataTable({ 
                            data: dataSet_cl
                        }).draw();
                    }

                }
            })
        }

        CallA();
    })



    $("#transaction_deletion_requested_approval").on("click", function(e) {
        e.preventDefault()

        $("#body-bg-3").addClass('bg-active');
        $("#body-bg-2, #body-bg-1, #body-bg-4").removeClass('bg-active');
        $("#parcel_table_tab").addClass('d-none');
        $("#transaction_table_tab").removeClass('d-none');
        $("#parcel_search").addClass('d-none');
        $("#transaction_search").removeClass('d-none');
        $("#transaction_search").addClass('d-none');
        $("#accordion_t").removeClass('d-none');

        var enq_tab_value = 'transaction_deletion_requested';

        function CallA() {

            let dataSet_pt = [];
            let num_pt = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'pvlmd_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_pt = +num_pt + 1;
                                let t_id = json_result.data[i].t_id;
                                let reference_number = json_result.data[i].reference_number;
                                let file_number = json_result.data[i].file_number;
                                let property_number = json_result.data[i].property_number;
                                let instrument_type = json_result.data[i].instrument_type;
                                let grantee = json_result.data[i].party2_defendant;
                                let grantor = json_result.data[i].party1_plaintiff;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by;
                                let doc_number = json_result.data[i].doc_number;
                                let instrument_date = json_result.data[i].instrument_date;
                                let consent_date = json_result.data[i].consent_date;
                                let remarks = json_result.data[i].remarks;
                                let action = "";

                                switch(status) {

                                    case 'pending':
                                        action = `<div class="text-center">

                                                    <button type="button" class="btn btn-outline-success btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_review_delete_request"
                                                        data-pvlmd_id_adr="${t_id}"
                                                        data-pvlmd_reference_number_adr="${reference_number}"
                                                        data-pvlmd_delete_note_adr="${delete_note}"
                                                        data-pvlmd_delete_attachment_adr="${delete_attachment}"
                                                        data-pvlmd_delete_requested_by_adr="${deleted_requested_by}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="PVLMD"
                                                    >
                                                    View Request
                                                    </button>
                                                </div>`;

                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_pt);
                                html.push(reference_number);
                                html.push(doc_number);
                                html.push(instrument_type); 
                                html.push(instrument_date); 
                                html.push(consent_date);
                                html.push(grantor);
                                html.push(grantee);
                                html.push(remarks);
                                html.push(status); 
                                html.push(action);  

                                dataSet_pt.push(html);
                            }
                        }

                        $('#table_pvlmd_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_pvlmd_transaction_list').DataTable({ 
                            data: dataSet_pt
                        }).draw();
                    }

                    CallB();

                }
            })

        }

        function CallB() {

            let dataSet_ct = [];
            let num_ct = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'cro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_ct = +num_ct + 1;
                                let t_id = json_result.data[i].id;
                                let reference_number = json_result.data[i].doc_number;
                                let document_date = json_result.data[i].doc_date;
                                let document_type = json_result.data[i].doc_type;
                                let purpose = json_result.data[i].purpose;
                                let commencement_date = json_result.data[i].commencement_date;
                                let applicant_name = json_result.data[i].party2_2 == "" ? json_result.data[i].plaintiff : json_result.data[i].party2_2;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by;
                                let action = "";

                                switch(status) {
                                    case 'pending':
                                        action = `<div class="text-center">

                                                    <button type="button" class="btn btn-outline-success btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_review_delete_request"
                                                        data-pvlmd_id_adr="${t_id}"
                                                        data-pvlmd_reference_number_adr="${reference_number}"
                                                        data-pvlmd_delete_note_adr="${delete_note}"
                                                        data-pvlmd_delete_attachment_adr="${delete_attachment}"
                                                        data-pvlmd_delete_requested_by_adr="${deleted_requested_by}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="CRO"
                                                    >
                                                    View Request
                                                    </button>
                                                </div>`;

                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_ct);
                                html.push(reference_number);
                                html.push(document_type);
                                html.push(purpose); 
                                html.push(applicant_name); 
                                html.push(commencement_date);
                                html.push(status); 
                                html.push(action); 

                                dataSet_ct.push(html);
                            }
                        }

                        $('#table_cro_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_cro_transaction_list').DataTable({ 
                            data: dataSet_ct
                        }).draw();
                    }

                    CallC();

                }
            })
        }

        function CallC() {

            let dataSet_gt = [];
            let num_gt = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_deletion_request',
                    tab_value : enq_tab_value,
                    layer_type: 'garro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_gt = +num_gt + 1;
                                let t_id = json_result.data[i].id;
                                let reference_number = json_result.data[i].document_no;
                                let property_number = json_result.data[i].property_no;
                                let date_of_instrument = json_result.data[i].date_of_instrument;
                                let nature_of_interest = json_result.data[i].nature_of_interest;
                                let location = json_result.data[i].location;
                                let sheet_no = json_result.data[i].sheet_no;
                                let applicant_name = json_result.data[i].grantee;
                                let interest = json_result.data[i].interest;
                                let purpose = json_result.data[i].purpose;
                                let status = json_result.data[i].status == null ? '' : json_result.data[i].status;
                                let delete_note = json_result.data[i].delete_note;
                                let delete_attachment = json_result.data[i].delete_attachment;
                                let deleted_requested_by = json_result.data[i].deleted_requested_by;
                                let action = "";

                                switch(status) {
                                    case 'pending':
                                        action = `<div class="text-center">

                                                    <button type="button" class="btn btn-outline-success btn-sm"
                                                        data-toggle="modal" data-target="#plvmd_review_delete_request"
                                                        data-pvlmd_id_adr="${t_id}"
                                                        data-pvlmd_reference_number_adr="${reference_number}"
                                                        data-pvlmd_delete_note_adr="${delete_note}"
                                                        data-pvlmd_delete_attachment_adr="${delete_attachment}"
                                                        data-pvlmd_delete_requested_by_adr="${deleted_requested_by}"
                                                        data-initiate_type="transaction"
                                                        data-layer_type="GARRO"
                                                    >
                                                    View Request
                                                    </button>
                                                </div>`;

                                    break;
                                }

                                if(status == '') {
                                    status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                } else if(status == 'pending') {
                                    status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                } else if(status == 'approved') {
                                    status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                } else if(status == 'reviewed') {
                                    status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                }

                                html.push(num_gt);
                                html.push(reference_number);
                                html.push(property_number);
                                html.push(location); 
                                html.push(applicant_name); 
                                html.push(nature_of_interest);
                                html.push(date_of_instrument);
                                html.push(status); 
                                html.push(action); 

                                dataSet_gt.push(html);
                            }
                        }

                        $('#table_garro_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_garro_transaction_list').DataTable({ 
                            data: dataSet_gt
                        }).draw();
                    }

                }
            })
        }

        CallA();
    })

    $('#plvmd_review_delete_request').on('shown.bs.modal', function(event) {
        console.log($(event.relatedTarget).data('pvlmd_id_adr'), $(event.relatedTarget).data('pvlmd_delete_attachment_adr'))
        $("#plvmd_review_delete_request #pvlmd_id_cda").val($(event.relatedTarget).data('pvlmd_id_adr'));	
        $("#plvmd_review_delete_request #pvlmd_reference_number_cda").val($(event.relatedTarget).data('pvlmd_reference_number_adr'));	
        $("#plvmd_review_delete_request #initiate_type_cda").val($(event.relatedTarget).data('initiate_type'));
        $("#plvmd_review_delete_request #pvlmd_delete_note_cda").val($(event.relatedTarget).data('pvlmd_delete_note_adr'));
        //$("#plvmd_review_delete_request #elisdovumentpreviewblobfile_cda").attr('src', $(event.relatedTarget).data('pvlmd_delete_attachment_adr'));
        $("#plvmd_review_delete_request #pvlmd_delete_requested_by_cda").val($(event.relatedTarget).data('pvlmd_delete_requested_by_adr'));
        $("#plvmd_review_delete_request #pvlmd_layer_type_cda").val($(event.relatedTarget).data('layer_type'));

        var file_path = $(event.relatedTarget).data('pvlmd_delete_attachment_adr');

        $.ajax({
            type : "POST",
            url : "Maps",
            data : {
                request_type : 'open_doc',
                file_path : file_path,
            },
            cache : false,
            xhrFields : {
                responseType : 'blob'
            },
            beforeSend : function() {
            },
            success : function(response) {
                var blob = new Blob([ response ], {
                    type : "application/pdf"
                });
                var objectUrl = URL.createObjectURL(blob);
                
                $('#elisdovumentpreviewblobfile_cda').attr('src', objectUrl);
            }

        })

       
    })

    // $('#plvmd_decline_delete_request').on('shown.bs.modal', function(event) {
    //     $("#plvmd_decline_delete_request #pvlmd_id_dda").val($(event.relatedTarget).data('pvlmd_id_adr'));	
    //     $("#plvmd_decline_delete_request #pvlmd_reference_number_dda").val($(event.relatedTarget).data('pvlmd_reference_number_adr'));	
    //     $("#plvmd_decline_delete_request #initiate_type_dda").val($(event.relatedTarget).data('initiate_type'));
    //     $("#plvmd_decline_delete_request #pvlmd_delete_note_dda").val($(event.relatedTarget).data('pvlmd_delete_note_adr'));
    //     $("#plvmd_decline_delete_request #elisdovumentpreviewblobfile_dda").attr('src', $(event.relatedTarget).data('pvlmd_delete_attachment_adr'));
    //     $("#plvmd_decline_delete_request #pvlmd_delete_requested_by_dda").val($(event.relatedTarget).data('pvlmd_delete_requested_by_adr'));
    // })

    $('#btn_confirm_pvlmd_delete_request').on('click', function(e) {
        e.preventDefault();

        let text = "Are you sure to confirm the deletion?";
        var _id = $('#pvlmd_id_cda').val();
        var reference_number = $('#pvlmd_reference_number_cda').val();
        var initiate_type = $('#initiate_type_cda').val();

        if (confirm(text) == true) {
            //console.log('ok')
            $.ajax({
                type: "post",
                url: "Maps",
                data: {
                    request_type : 'select_pvlmd_approved_delete_request',
                    _id : _id,
                    reference_number : reference_number,
                    initiate_type : initiate_type
                },
                cache : false,
                success : function(response) {
                    console.log(response);

                    console.log(response);
                    let json_result = JSON.parse(response);

                    if(json_result.success){
                        toastr["success"]("Request intiated successfully", "Success");
                    } 
                    else{
                        toastr["error"]("Error occurred uploading file", "Error");
                    }

                    //$("#plvmd_cancel_delete_request").find('form').trigger('reset');
                    $("#plvmd_review_delete_request").modal('hide');

                    setTimeout(function(){
                        location.reload();
                    },1000); 

                }
            })
        } else {
            
        }
    })


    $('#decline_request').on('shown.bs.modal', function () {
        $("#plvmd_review_delete_request").css("z-index", "1029");
        $("#plvmd_approve_delete_request").css("z-index", "1029");
        $("#plvmd_confirm_approve_delete_request").css("z-index", "1029");

        var reference_number = ($('#pvlmd_reference_number_cda').val() == "" ? $('#pvlmd_reference_number_radr').val() : $('#pvlmd_reference_number_cda').val()) == "" ? $('#pvlmd_reference_number_aadr').val() : ($('#pvlmd_reference_number_cda').val() == "" ? $('#pvlmd_reference_number_radr').val() : $('#pvlmd_reference_number_cda').val());
        $('#pvlmd_reference_number_decline').val(reference_number);
      })
      
    $('#decline_request').on('hidden.bs.modal', function () {
        $("#plvmd_review_delete_request").css("z-index", "");
        $("#plvmd_approve_delete_request").css("z-index", "");
        $("#plvmd_confirm_approve_delete_request").css("z-index", "");
    })

    $('#verify_otp_for_review_delete').on('shown.bs.modal', function () {
        $("#plvmd_review_delete_request").css("z-index", "1029");
        var reference_number = $('#pvlmd_reference_number_cda').val();
        $('#pvlmd_reference_number_decline').val(reference_number);
      })
      
    $('#verify_otp_for_review_delete').on('hidden.bs.modal', function () {
        $("#plvmd_review_delete_request").css("z-index", "");
    })


    $('#btn_decline_pvlmd_delete_request').on('click', function(e) {

        var _id = ($('#pvlmd_id_cda').val() == "" ? $('#pvlmd_id_rdar').val() : $('#pvlmd_id_cda').val()) == "" ? $('#pvlmd_id_aadr').val() : ($('#pvlmd_id_cda').val() == "" ? $('#pvlmd_id_rdar').val() : $('#pvlmd_id_cda').val());
        var reference_number = $('#pvlmd_reference_number_decline').val();
        var initiate_type = ($('#initiate_type_cda').val() == "" ? $('#initiate_type_rdar').val() : $('#initiate_type_cda').val()) ==  "" ? $('#initiate_type_aadr').val() : ($('#initiate_type_cda').val() == "" ? $('#initiate_type_rdar').val() : $('#initiate_type_cda').val());
        var layer_type = ($('#pvlmd_layer_type_cda').val() == "" ? $('#pvlmd_layer_type_rdar').val() : $('#pvlmd_layer_type_cda').val()) == "" ? $('#pvlmd_layer_type_aadr').val() : ($('#pvlmd_layer_type_cda').val() == "" ? $('#pvlmd_layer_type_rdar').val() : $('#pvlmd_layer_type_cda').val());
        var decline_note = $('#plvmd_decline_note').val();

        $.ajax({
            type: "post",
            url: "Maps",
            data: {
                request_type : 'select_plvmd_cancel_delete_request',
                _id : _id,
                reference_number : reference_number,
                initiate_type : initiate_type,
                layer_type: layer_type,
                decline_note: decline_note
            },
            cache : false,
            success : function(response) {
                console.log(response);

                console.log(response);
                let json_result = JSON.parse(response);

                if(json_result.success){
                    //toastr["success"]("Request intiated successfully", "Success");
                    $.notify({
                        message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Request declined successfully.</span>',
                    }, { type : 'success', z_index : 9999 });
                } 
                else{
                    $.notify({
                        message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error occurred uploading file.</span>',
                    }, { type : 'danger' , z_index: 9999  });
                    //toastr["error"]("Error occurred uploading file", "Error");
                }

                // $("#plvmd_review_delete_request").find('form').trigger('reset');
                $("#plvmd_review_delete_request").modal('hide');

                setTimeout(function(){
                    location.reload();
                },1000); 

            }
        })
    })


    $('#btn_verify_otp_for_initiate_delete').on('click', function(event) {

       var ref_no = $('#pvlmd_reference_number_idr').val();
       //var request_to = $('#pvlmd_send_request_to_idr').val();
       var delete_note = $('#pvlmd_delete_note_idr').val();
       var attachment_location = $('#pvlmd_delete_note_idr').val();
       if(!ref_no || !delete_note || !attachment_location) {
            // $.notify({
            //     message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Fill the required fields.</span>',
            // }, { type : 'danger' , z_index: 9999  });
            alert("Fill the required fields.");
       } else {

            $("#verify_otp_for_initiate_delete").modal('show');

            $.ajax({
                type: "post",
                url: "Maps",
                data: {
                    request_type : 'verify_otp_for_initiate_delete',
                    reference_number: ref_no
                },
                cache : false,
                success : function(response) {
                    

                }
            })

       }
       
    })

    let text = document.getElementById("vc_6");
        text.onkeyup = function() {
        if( text.value.length == 1 ) {
                //$("#verifydeleteform").submit();
                var vc_1 = $('#vc_1').val();
                var vc_2 = $('#vc_2').val();
                var vc_3 = $('#vc_3').val();
                var vc_4 = $('#vc_4').val();
                var vc_5 = $('#vc_5').val();
                var vc_6 = $('#vc_6').val();

                $.ajax({
                    type: "post",
                    url: "Maps",
                    data: {
                        request_type : 'confirm_otp_for_initiate_delete',
                        vc_1: vc_1,
                        vc_2: vc_2,
                        vc_3: vc_3,
                        vc_4: vc_4,
                        vc_5: vc_5,
                        vc_6: vc_6
                    },
                    cache : false,
                    success : function(response) {

                        if(response == "true") {
                            $('#verify_otp_for_initiate_delete').modal('hide');
                            $('#confrim_verify_otp_for_initiate_delete').removeClass('d-none');
                            $('#btn_verify_otp_for_initiate_delete').addClass('d-none');

                        } else {
                            alert("Invalid OTP code entered.");
                        }
                    }
                })
        }
    }

    $('#confrim_verify_otp_for_initiate_delete').on('click', function(event){

        var _id = $('#plvmd_initiate_delete_request #pvlmd_id_idr').val();
        var reference_number = $('#plvmd_initiate_delete_request #pvlmd_reference_number_idr').val();
        var delete_note = $('#plvmd_initiate_delete_request #pvlmd_delete_note_idr').val();
        var initiate_type = $('#plvmd_initiate_delete_request #initiate_type').val();
        var send_to = $('#plvmd_initiate_delete_request #pvlmd_send_request_to_idr').val();
        var layer_type = $('#plvmd_initiate_delete_request #pvlmd_layer_type_idr').val();

        let formdata = new FormData();
            
        formdata.append("_id",_id);
        formdata.append("reference_number",reference_number);
        formdata.append("delete_note",delete_note);
        formdata.append("initiate_type",initiate_type);
        formdata.append("send_to",send_to);
        formdata.append("layer_type",layer_type);

        jQuery.each(jQuery('#pvlmd_attachment_location_idr')[0].files,function(i,file){
            formdata.append('file',file);
        })

        formdata.append("request_type",'select_pvlmd_initiate_delete_request');

        $.ajax({
            method:"POST",
            enctype : 'multipart/form-data',
            url : "Maps",
            data : formdata,
            processData : false,
            contentType : false,
            cache : false,
            success:function(response){
                
                console.log(response);
                let json_result = JSON.parse(response);

                if(json_result.success){
                    //toastr["success"]("Request intiated successfully", "Success");
                    $("#plvmd_initiate_delete_request").find('form').trigger('reset');
                    $("#plvmd_initiate_delete_request").modal('hide');
                    $("#verify_otp_for_initiate_delete").modal('hide');

                    $.notify({
                        message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Request intiated successfully.</span>',
                    }, { type : 'success', z_index : 9999 });
                } 
                else{
                    //toastr["error"]("Error occurred uploading file", "Error");
                    $.notify({
                        message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error occurred uploading file.</span>',
                    }, { type : 'danger' , z_index: 9999  });
                }

                setTimeout(function(){
                    location.reload();
                },1500); 
            }
            
        })
    })


    $('#btn_review_pvlmd_delete_request').on('click', function(event) {

        var pvlmd_review_note_cda = $('#pvlmd_review_note_cda').val();
        var reference_number = $('#pvlmd_reference_number_cda').val();

        if(!pvlmd_review_note_cda) {
             // $.notify({
             //     message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Fill the required fields.</span>',
             // }, { type : 'danger' , z_index: 9999  });
             alert("Fill the required fields.");
        } else {
 
             $("#verify_otp_for_review_delete").modal('show');
 
             $.ajax({
                 type: "post",
                 url: "Maps",
                 data: {
                     request_type : 'verify_otp_for_review_delete',
                     reference_number:reference_number
                 },
                 cache : false,
                 success : function(response) {
                     
 
                 }
             })
 
        }
        
     })


     const text_a = document.getElementById("ac_6");
        text_a.onkeyup = function() {
            if( text_a.value.length == 1 ) {
        var vc_1 = $('#ac_1').val();
        var vc_2 = $('#ac_2').val();
        var vc_3 = $('#ac_3').val();
        var vc_4 = $('#ac_4').val();
        var vc_5 = $('#ac_5').val();
        var vc_6 = $('#ac_6').val();

        $.ajax({
            type: "post",
            url: "Maps",
            data: {
                request_type : 'confirm_otp_for_initiate_delete',
                vc_1: vc_1,
                vc_2: vc_2,
                vc_3: vc_3,
                vc_4: vc_4,
                vc_5: vc_5,
                vc_6: vc_6
            },
            cache : false,
            success : function(response) {

                // let json_result = JSON.parse(response);
                // console.log(json_result)

                if(response == "true") {

                    $('#verify_otp_for_review_delete').modal('hide');
                    $('#btn_send_review_pvlmd_delete_request').removeClass('d-none');
                    $('#btn_review_pvlmd_delete_request').addClass('d-none');

                } else {

                    // $.notify({
                    //     message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Invalid OTP code entered.</span>',
                    // }, { type : 'danger' , z_index: 9999  });
                    alert("Invalid OTP code entered.");
                }
            }
        })
    }
        
    }


    $('#btn_send_review_pvlmd_delete_request').on('click', function(event) {

        var _id = $('#pvlmd_id_cda').val();
        var reference_number = $('#pvlmd_reference_number_cda').val();
        var initiate_type = $('#initiate_type_cda').val();
        var review_note = $('#pvlmd_review_note_cda').val();
        var layer_type = $('#pvlmd_layer_type_cda').val();
        var send_to = $('#pvlmd_send_request_to_cda').val();

        let formdata = new FormData();
            
        formdata.append("_id",_id);
        formdata.append("reference_number",reference_number);
        formdata.append("review_note",review_note);
        formdata.append("initiate_type",initiate_type);
        formdata.append("layer_type",layer_type);
        formdata.append("send_to",send_to);

        // jQuery.each(jQuery('#pvlmd_attachment_location_idr')[0].files,function(i,file){
        //     formdata.append('file',file);
        // })

        formdata.append("request_type",'select_pvlmd_review_delete_request');

        $.ajax({
            method:"POST",
            enctype : 'multipart/form-data',
            url : "Maps",
            data : formdata,
            processData : false,
            contentType : false,
            cache : false,
            success:function(response){
                
                console.log(response);
                let json_result = JSON.parse(response);

                if(json_result.success){
                    //toastr["success"]("Request intiated successfully", "Success");
                    //$("#plvmd_initiate_delete_request").find('form').trigger('reset');
                    $("#plvmd_review_delete_request").modal('hide');
                    $("#verify_otp_for_review_delete").modal('hide');

                    $.notify({
                        message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Request has been reviewed successfully.</span>',
                    }, { type : 'success', z_index : 9999 });
                } 
                else{
                    //toastr["error"]("Error occurred uploading file", "Error");
                    $.notify({
                        message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error occurred uploading file.</span>',
                    }, { type : 'danger' , z_index: 9999  });
                }

                setTimeout(function(){
                    location.reload();
                },1500); 
            }
            
        })
    })

    $('#btn_confirm_approve_pvlmd_delete_request').on('click', function(event) {

       var reference_number = $('#pvlmd_reference_number_aadr').val();

             $("#verify_otp_for_confirm_delete").modal('show');
 
             $.ajax({
                 type: "post",
                 url: "Maps",
                 data: {
                     request_type : 'verify_otp_for_confirm_delete',
                     reference_number:reference_number
                 },
                 cache : false,
                 success : function(response) {
                     
 
                 }
             })
 
        
     })

     $('#verify_otp_for_confirm_delete').on('shown.bs.modal', function () {
        $("#plvmd_confirm_approve_delete_request").css("z-index", "1029");
      })
      
    $('#verify_otp_for_confirm_delete').on('hidden.bs.modal', function () {
        $("#plvmd_confirm_approve_delete_request").css("z-index", "");
    })


     const text_c = document.getElementById("cc_6");
        text_c.onkeyup = function() {
        if( text_c.value.length == 1 ) {

                var vc_1 = $('#cc_1').val();
                var vc_2 = $('#cc_2').val();
                var vc_3 = $('#cc_3').val();
                var vc_4 = $('#cc_4').val();
                var vc_5 = $('#cc_5').val();
                var vc_6 = $('#cc_6').val();

                $.ajax({
                    type: "post",
                    url: "Maps",
                    data: {
                        request_type : 'confirm_otp_for_initiate_delete',
                        vc_1: vc_1,
                        vc_2: vc_2,
                        vc_3: vc_3,
                        vc_4: vc_4,
                        vc_5: vc_5,
                        vc_6: vc_6
                    },
                    cache : false,
                    success : function(response) {

                        // let json_result = JSON.parse(response);
                        // console.log(json_result)

                        if(response == "true") {

                            $('#btn_pvlmd_delete_request').removeClass('d-none');
                            $('#verify_otp_for_confirm_delete').modal('hide');
                            $('#btn_confirm_approve_pvlmd_delete_request').addClass('d-none');
                        } else {

                            // $.notify({
                            //     message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Invalid OTP code entered.</span>',
                            // }, { type : 'danger' , z_index: 9999  });
                            alert("Invalid OTP code entered.");
                        }
                    }
                })
        }
    }


    $('#btn_pvlmd_delete_request').on('click', function(e) {

        var _id = $('#pvlmd_id_aadr').val();
        var reference_number = $('#pvlmd_reference_number_aadr').val();
        var initiate_type = $('#initiate_type_aadr').val();
        var layer_type = $('#pvlmd_layer_type_aadr').val();

        let formdata = new FormData();
            
        formdata.append("_id",_id);
        formdata.append("reference_number",reference_number);
        formdata.append("initiate_type",initiate_type);
        formdata.append("layer_type",layer_type);

        // jQuery.each(jQuery('#pvlmd_attachment_location_idr')[0].files,function(i,file){
        //     formdata.append('file',file);
        // })

        formdata.append("request_type",'select_confirm_delete_pvlmd_parcles');

        $.ajax({
            method:"POST",
            enctype : 'multipart/form-data',
            url : "Maps",
            data : formdata,
            processData : false,
            contentType : false,
            cache : false,
            success:function(response){
                
                console.log(response);
                let json_result = JSON.parse(response);

                if(json_result.success){
                    //toastr["success"]("Request intiated successfully", "Success");
                    //$("#plvmd_initiate_delete_request").find('form').trigger('reset');
                    $("#plvmd_confirm_approve_delete_request").modal('hide');
                    $("#verify_otp_for_confirm_delete").modal('hide');

                    $.notify({
                        message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Deleted successfully.</span>',
                    }, { type : 'success', z_index : 9999 });
                } 
                else{
                    //toastr["error"]("Error occurred uploading file", "Error");
                    $.notify({
                        message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error occurred uploading file.</span>',
                    }, { type : 'danger' , z_index: 9999  });
                }

                setTimeout(function(){
                    location.reload();
                },1500); 
            }
            
        })
    })


    $('#verify_otp_for_initiate_delete').on('shown.bs.modal', function () {
        $("#plvmd_initiate_delete_request").css("z-index", "1029");
      })
      
    $('#verify_otp_for_initiate_delete').on('hidden.bs.modal', function () {
        $("#plvmd_initiate_delete_request").css("z-index", "");
    })


    $('#btn_approve_pvlmd_delete_request').on('click', function(event) {

        var pvlmd_approve_note_radr = $('#pvlmd_approve_note_radr').val();
        var reference_number = $('#pvlmd_reference_number_radr').val();

        if(!pvlmd_approve_note_radr) {
             alert("Fill the required fields.");
        } else {
 
             $("#verify_otp_for_approve_delete").modal('show');
 
             $.ajax({
                 type: "post",
                 url: "Maps",
                 data: {
                     request_type : 'verify_otp_for_approval_delete',
                     reference_number:reference_number
                 },
                 cache : false,
                 success : function(response) {
                     
 
                 }
             })
 
        }
        
     })

     $('#verify_otp_for_approve_delete').on('shown.bs.modal', function () {
        $("#plvmd_approve_delete_request").css("z-index", "1029");
      })
      
    $('#verify_otp_for_approve_delete').on('hidden.bs.modal', function () {
        $("#plvmd_approve_delete_request").css("z-index", "");
    })

    const text_b = document.getElementById("aac_6");
        text_b.onkeyup = function() {
            if( text_b.value.length == 1 ) {
        var vc_1 = $('#aac_1').val();
        var vc_2 = $('#aac_2').val();
        var vc_3 = $('#aac_3').val();
        var vc_4 = $('#aac_4').val();
        var vc_5 = $('#aac_5').val();
        var vc_6 = $('#aac_6').val();

        console.log('ok')

        $.ajax({
            type: "post",
            url: "Maps",
            data: {
                request_type : 'confirm_otp_for_initiate_delete',
                vc_1: vc_1,
                vc_2: vc_2,
                vc_3: vc_3,
                vc_4: vc_4,
                vc_5: vc_5,
                vc_6: vc_6
            },
            cache : false,
            success : function(response) {

                // let json_result = JSON.parse(response);
                // console.log(json_result)

                if(response == "true") {

                    $('#verify_otp_for_approve_delete').modal('hide');
                    $('#btn_confirm_approval_delete_request').removeClass('d-none');
                    $('#btn_approve_pvlmd_delete_request').addClass('d-none');

                } else {

                    // $.notify({
                    //     message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Invalid OTP code entered.</span>',
                    // }, { type : 'danger' , z_index: 9999  });
                    alert("Invalid OTP code entered.");
                }
            }
        })
    }
    }

    $('#btn_confirm_approval_delete_request').on('click', function(event) {

        var _id = $('#pvlmd_id_radr').val();
        var reference_number = $('#pvlmd_reference_number_radr').val();
        var initiate_type = $('#initiate_type_radr').val();
        var approve_note = $('#pvlmd_approve_note_radr').val();
        var layer_type = $('#layer_type_radr').val();
       // var send_to = $('#pvlmd_send_request_to_cda').val();

       console.log(initiate_type, layer_type, approve_note, _id,reference_number )

        let formdata = new FormData();
            
        formdata.append("_id",_id);
        formdata.append("reference_number",reference_number);
        formdata.append("approve_note",approve_note);
        formdata.append("initiate_type",initiate_type);
        formdata.append("layer_type",layer_type);
        //formdata.append("send_to",send_to);

        // jQuery.each(jQuery('#pvlmd_attachment_location_idr')[0].files,function(i,file){
        //     formdata.append('file',file);
        // })

        formdata.append("request_type",'select_pvlmd_approve_delete_request');

        $.ajax({
            method:"POST",
            enctype : 'multipart/form-data',
            url : "Maps",
            data : formdata,
            processData : false,
            contentType : false,
            cache : false,
            success:function(response){
                
                console.log(response);
                let json_result = JSON.parse(response);

                if(json_result.success){
                    //toastr["success"]("Request intiated successfully", "Success");
                    //$("#plvmd_initiate_delete_request").find('form').trigger('reset');
                    $("#plvmd_approve_delete_request").modal('hide');
                    $("#verify_otp_for_approve_delete").modal('hide');

                    $.notify({
                        message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Request has been approved successfully.</span>',
                    }, { type : 'success', z_index : 9999 });
                } 
                else{
                    //toastr["error"]("Error occurred uploading file", "Error");
                    $.notify({
                        message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Error occurred uploading file.</span>',
                    }, { type : 'danger' , z_index: 9999  });
                }

                setTimeout(function(){
                    location.reload();
                },1500); 
            }
            
        })
    })

    $('#plvmd_cancel_delete_request').on('shown.bs.modal', function () {
        $("#plvmd_confirm_approve_delete_request").css("z-index", "1029");
    })
      
    $('#plvmd_cancel_delete_request').on('hidden.bs.modal', function () {
        $("#plvmd_confirm_approve_delete_request").css("z-index", "");
    })


    $('#load_requested_application_details').on('shown.bs.modal', function (event) {

        var reference_number = $('#pvlmd_reference_number_cda').val() == "" ? $('#pvlmd_reference_number_radr').val() : $('#pvlmd_reference_number_cda').val();
        var layer_type = $('#pvlmd_layer_type_cda').val() == "" ? $('#layer_type_radr').val() : $('#pvlmd_layer_type_cda').val();

        let num = 0
        var form_id = ""

        switch(layer_type) {
            case 'PVLMD' :

                $.ajax({
                    method:"POST",
                    url : "Maps",
                    data : {
                        request_type : 'select_pvlmd_deletion_request_details',
                        reference_number : reference_number,
                        layer_type: layer_type
                    },
                    cache : false,
                    success : function(response) {
                        
                        let json_result = JSON.parse(response);
                        console.log(json_result)

                        if(json_result.success){
                            if(json_result.data !== null){
                                for(let i=0; i<json_result.data.length; i++){

                                    num = +num + 1;
                                    form_id += `
                                    <div class="card">
                                        <div class="card-header" id="headingOne_${num}">
                                            <h5 class="mb-0">
                                            <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne_${num}" aria-expanded="true" aria-controls="collapseOne">
                                            ${json_result.data[i].reference_number}
                                            </button>
                                            </h5>
                                        </div>
                                        <div id="collapseOne_${num}" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion_d">
                                            <div class="card-body">
                                            <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Reference No.</label>
                                                            <input class="form-control" value="${json_result.data[i].reference_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">File No.</label>
                                                            <input class="form-control" value="${json_result.data[i].file_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Property No.</label>
                                                            <input class="form-control" value="${json_result.data[i].property_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Deed No.</label>
                                                            <input class="form-control" value="${json_result.data[i].deed_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Serial No.</label>
                                                            <input class="form-control" value="${json_result.data[i].serial_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Sheet No.</label>
                                                            <input class="form-control" value="${json_result.data[i].sheet_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Plan No.</label>
                                                            <input class="form-control" value="${json_result.data[i].plan_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Plot No.</label>
                                                            <input class="form-control" value="${json_result.data[i].plot_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">LVB No.</label>
                                                            <input class="form-control" value="${json_result.data[i].lvb_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Instrument Date</label>
                                                            <input class="form-control" value="${json_result.data[i].instrument_date}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Instrument Type</label>
                                                            <input class="form-control" value="${json_result.data[i].instrument_type}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Document No.</label>
                                                            <input class="form-control" value="${json_result.data[i].doc_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Grantor</label>
                                                            <input class="form-control" value="${json_result.data[i].party1_plaintiff}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Grantee</label>
                                                            <input class="form-control" value="${json_result.data[i].party2_defendant}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                        
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Term</label>
                                                            <input class="form-control" value="${json_result.data[i].term}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Commencement Date</label>
                                                            <input class="form-control" value="${json_result.data[i].commencement_date}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Purpose</label>
                                                            <input class="form-control" value="${json_result.data[i].purpose}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Consideration</label>
                                                            <input class="form-control" value="${json_result.data[i].consideration}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Premium</label>
                                                            <input class="form-control" value="${json_result.data[i].premium}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Remarks</label>
                                                            <input class="form-control" value="${json_result.data[i].remarks}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Suit No.</label>
                                                            <input class="form-control" value="${json_result.data[i].suit_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Judgement In Favor Of</label>
                                                            <input class="form-control" value="${json_result.data[i].judgement_in_favour_of}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Floor Level</label>
                                                            <input class="form-control" value="${json_result.data[i].floor_level}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Apartment No.</label>
                                                            <input class="form-control" value="${json_result.data[i].apartment_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Rent</label>
                                                            <input class="form-control" value="${json_result.data[i].rent}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Entered By</label>
                                                            <input class="form-control" value="${json_result.data[i].entered_by}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Entered Date</label>
                                                            <input class="form-control" value="${json_result.data[i].entered_date}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    `
                                }

                                document.getElementById('delete_application_details').innerHTML = form_id;
                            }
                        }
                    }
                    
                })
            break;

            case 'GARRO' :

                $.ajax({
                    method:"POST",
                    url : "Maps",
                    data : {
                        request_type : 'select_pvlmd_deletion_request_details',
                        reference_number : reference_number,
                        layer_type: layer_type
                    },
                    cache : false,
                    success : function(response) {
                        
                        let json_result = JSON.parse(response);
                        console.log(json_result)

                        if(json_result.success){
                            if(json_result.data !== null){
                                for(let i=0; i<json_result.data.length; i++){

                                    num = +num + 1;
                                    form_id += `
                                    <div class="card">
                                        <div class="card-header" id="headingOne_${num}">
                                            <h5 class="mb-0">
                                            <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne_${num}" aria-expanded="true" aria-controls="collapseOne">
                                            ${json_result.data[i].document_no}
                                            </button>
                                            </h5>
                                        </div>
                                        <div id="collapseOne_${num}" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion_d">
                                            <div class="card-body">
                                            <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Document No.</label>
                                                            <input class="form-control" value="${json_result.data[i].document_no}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Date of Plotting</label>
                                                            <input class="form-control" value="${json_result.data[i].date_of_plotting}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Property No.</label>
                                                            <input class="form-control" value="${json_result.data[i].property_no}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Date of Instrument</label>
                                                            <input class="form-control" value="${json_result.data[i].date_of_instrument}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Nature of Instrument</label>
                                                            <input class="form-control" value="${json_result.data[i].nature_of_instrument}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Grantor</label>
                                                            <input class="form-control" value="${json_result.data[i].grantor}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Grantee</label>
                                                            <input class="form-control" value="${json_result.data[i].grantee}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Plot No.</label>
                                                            <input class="form-control" value="${json_result.data[i].plot_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Sheet No.</label>
                                                            <input class="form-control" value="${json_result.data[i].sheet_no}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                        
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Location</label>
                                                            <input class="form-control" value="${json_result.data[i].location}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Area</label>
                                                            <input class="form-control" value="${json_result.data[i].area}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Consideration</label>
                                                            <input class="form-control" value="${json_result.data[i].consideration}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Interest</label>
                                                            <input class="form-control" value="${json_result.data[i].interest}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Purpose</label>
                                                            <input class="form-control" value="${json_result.data[i].purpose}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Years</label>
                                                            <input class="form-control" value="${json_result.data[i].years}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Remarks</label>
                                                            <input class="form-control" value="${json_result.data[i].remarks}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">File No.</label>
                                                            <input class="form-control" value="${json_result.data[i].file_no}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    `
                                }

                                document.getElementById('delete_application_details').innerHTML = form_id;
                            }
                        }
                    }
                    
                })
            break;

            case 'CRO' :
                $.ajax({
                    method:"POST",
                    url : "Maps",
                    data : {
                        request_type : 'select_pvlmd_deletion_request_details',
                        reference_number : reference_number,
                        layer_type: layer_type
                    },
                    cache : false,
                    success : function(response) {
                        
                        let json_result = JSON.parse(response);
                        console.log(json_result)

                        if(json_result.success){
                            if(json_result.data !== null){
                                for(let i=0; i<json_result.data.length; i++){

                                    num = +num + 1;
                                    form_id += `
                                    <div class="card">
                                        <div class="card-header" id="headingOne_${num}">
                                            <h5 class="mb-0">
                                            <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne_${num}" aria-expanded="true" aria-controls="collapseOne">
                                            ${json_result.data[i].doc_number}
                                            </button>
                                            </h5>
                                        </div>
                                        <div id="collapseOne_${num}" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion_d">
                                            <div class="card-body">
                                            <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Document No.</label>
                                                            <input class="form-control" value="${json_result.data[i].doc_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Document Date</label>
                                                            <input class="form-control" value="${json_result.data[i].doc_date}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Document No.</label>
                                                            <input class="form-control" value="${json_result.data[i].doc_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Party One</label>
                                                            <input class="form-control" value="${json_result.data[i].party1_1}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Party Two</label>
                                                            <input class="form-control" value="${json_result.data[i].party2_2}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Term</label>
                                                            <input class="form-control" value="${json_result.data[i].term}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Commencement Date</label>
                                                            <input class="form-control" value="${json_result.data[i].commencement_date}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Purpose</label>
                                                            <input class="form-control" value="${json_result.data[i].purpose}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Consideration No.</label>
                                                            <input class="form-control" value="${json_result.data[i].consideration}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Premium</label>
                                                            <input class="form-control" value="${json_result.data[i].premium}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Phone</label>
                                                            <input class="form-control" value="${json_result.data[i].phone}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Remarks</label>
                                                            <input class="form-control" value="${json_result.data[i].remarks}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                        
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Unit Description</label>
                                                            <input class="form-control" value="${json_result.data[i].unit_description}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Floor Level</label>
                                                            <input class="form-control" value="${json_result.data[i].floor_level}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Flat File No.</label>
                                                            <input class="form-control" value="${json_result.data[i].flat_file_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Flat LS No.</label>
                                                            <input class="form-control" value="${json_result.data[i].flat_ls_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Flat Property No.</label>
                                                            <input class="form-control" value="${json_result.data[i].flat_property_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Apartment No.</label>
                                                            <input class="form-control" value="${json_result.data[i].apartment_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Suit No.</label>
                                                            <input class="form-control" value="${json_result.data[i].suite_number}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Rent</label>
                                                            <input class="form-control" value="${json_result.data[i].rent}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Judgement In Favor Of</label>
                                                            <input class="form-control" value="${json_result.data[i].judgement_in_favour_of}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Plaintiff</label>
                                                            <input class="form-control" value="${json_result.data[i].plaintiff}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Defendant</label>
                                                            <input class="form-control" value="${json_result.data[i].defendant}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="form-row">
                                                        <div class="col">
                                                            <label for="pvlmd_reference_number_fts">Acquisition</label>
                                                            <input class="form-control" value="${json_result.data[i].acquisition}" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    `
                                }

                                document.getElementById('delete_application_details').innerHTML = form_id;
                            }
                        }
                    }
                    
                })
            break;
        }

    })


    $('#load_requested_application_details').on('shown.bs.modal', function () {
        $("#plvmd_review_delete_request, #plvmd_approve_delete_request").css("z-index", "1029");
    })
      
    $('#load_requested_application_details').on('hidden.bs.modal', function () {
        $("#plvmd_review_delete_request, #plvmd_approve_delete_request").css("z-index", "");
    })


    $("#track_requested_amendment").on("click", function(e) {
        e.preventDefault()

        $("#body-bg-1").addClass('bg-active');
        $("#body-bg-2, #body-bg-3, #body-bg-4").removeClass('bg-active');
        $("#parcel_table_tab").addClass('d-none');
        $("#transaction_table_tab").addClass('d-none');
        $("#track_request").removeClass('d-none');
        $("#generate_request").addClass('d-none');
        $("#track_request_tab").removeClass('d-none');

        $('#table_amendment_requested').DataTable().clear().destroy();
    })

    $("#generate_requested_activities").on("click", function(e) {
        e.preventDefault()

        $("#body-bg-3").addClass('bg-active');
        $("#body-bg-2, #body-bg-1, #body-bg-4").removeClass('bg-active');
        $("#parcel_table_tab").addClass('d-none');
        $("#transaction_table_tab").addClass('d-none');
        $("#track_request").addClass('d-none');
        $("#generate_request").removeClass('d-none');
        $("#track_request_tab").removeClass('d-none');

        $('#table_amendment_requested').DataTable().clear().destroy();

    })

    $("#parcel_requested_deleted").on("click", function(e) {
        e.preventDefault()

        $("#body-bg-2").addClass('bg-active');
        $("#body-bg-1, #body-bg-3, #body-bg-4").removeClass('bg-active');
        $("#parcel_table_tab").removeClass('d-none');
        $("#transaction_table_tab").addClass('d-none');
        $("#track_request").addClass('d-none');
        $("#generate_request").addClass('d-none');
        $("#track_request_tab").addClass('d-none');
        $("#accordion_p").removeClass('d-none');


        var enq_tab_value = 'parcel_deletion_approved';

        function callA() {

            let dataSet_pl = [];
            let num_pl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_request_deleted',
                    tab_value : enq_tab_value,
                    layer_type: 'pvlmd_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_pl = +num_pl + 1;
                                let gid = json_result.data[i].gid;
                                let reference_number = json_result.data[i].reference_number;
                                let file_number = json_result.data[i].file_number;
                                let locality = json_result.data[i].locality;
                                let deleted_by_date = json_result.data[i].deleted_by_date
                                let deleted_by = json_result.data[i].deleted_by;
                                let action = "";

                                html.push(num_pl);
                                html.push(reference_number);
                                html.push(file_number);
                                html.push(locality); 
                                html.push(deleted_by); 
                                html.push(deleted_by_date);
                                html.push(action); 

                                dataSet_pl.push(html);
                            }
                        }

                        $('#table_pvlmd_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_pvlmd_parcel_list').DataTable({ 
                            data: dataSet_pl
                        }).draw();
                    }

                    callB();

                }
            })
        }

        function callB() {

            let dataSet_gl = [];
            let num_gl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_request_deleted',
                    tab_value : enq_tab_value,
                    layer_type: 'garro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_gl = +num_gl + 1;
                                let gid = json_result.data[i].gid;
                                // let document_no = json_result.data[i].document_no;
                                // let date_of_instrument = json_result.data[i].date_of_instrument;
                                let prop_no = json_result.data[i].prop_no;
                                // let date_of_plotting = json_result.data[i].date_of_plotting == null ? '' : convertDate(json_result.data[i].date_of_plotting.slice(0,10));
                                // let nature_of_interest = json_result.data[i].nature_of_interest;
                                // let grantee = json_result.data[i].grantee;
                                // let location = json_result.data[i].location;
                                // let file_no = json_result.data[i].file_no;
                                let deleted_by_date = convertDate(json_result.data[i].deleted_by_date.slice(0,10));
                                let deleted_by = json_result.data[i].deleted_by;
                                let action = "";

                                

                                html.push(num_gl);
                                html.push(gid);
                                html.push(prop_no);
                                // html.push(grantee); 
                                // html.push(location); 
                                // html.push(date_of_plotting);
                                html.push(deleted_by); 
                                html.push(deleted_by_date);
                                html.push(action); 

                                dataSet_gl.push(html);
                            }
                        }

                        $('#table_garro_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_garro_parcel_list').DataTable({ 
                            data: dataSet_gl
                        }).draw();
                    }

                    callC();

                }
            })

        }

        function callC() {

            let dataSet_cl = [];
            let num_cl = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_request_deleted',
                    tab_value : enq_tab_value,
                    layer_type: 'cro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_cl = +num_cl + 1;
                                let gid = json_result.data[i].gid;
                                let file_number = json_result.data[i].file_number;
                                let ls_number = json_result.data[i].ls_number;
                                let plan_number = json_result.data[i].plan_number;
                                //let date_of_plotting = json_result.data[i].date_of_plotting == null ? '' : convertDate(json_result.data[i].date_of_plotting.slice(0,10));
                                let plot_number = json_result.data[i].plot_number;
                                let locality = json_result.data[i].locality;
                                let deleted_by_date = convertDate(json_result.data[i].deleted_by_date.slice(0,10));
                                let deleted_by = json_result.data[i].deleted_by;
                                let action = "";

                                

                                html.push(num_cl);
                                html.push(file_number);
                                html.push(ls_number);
                                html.push(plan_number); 
                                html.push(plot_number); 
                                html.push(locality);
                                html.push(deleted_by); 
                                html.push(deleted_by_date);
                                html.push(action); 

                                dataSet_cl.push(html);
                            }
                        }

                        $('#table_cro_parcel_list').DataTable().clear().destroy();
                            
                        $('#table_cro_parcel_list').DataTable({ 
                            data: dataSet_cl
                        }).draw();
                    }

                }
            })
        }

        callA();

    })

    $("#transaction_requested_deleted").on("click", function(e) {
        e.preventDefault()

        $("#body-bg-4").addClass('bg-active');
        $("#body-bg-2, #body-bg-3, #body-bg-1").removeClass('bg-active');
        $("#parcel_table_tab").addClass('d-none');
        $("#transaction_table_tab").removeClass('d-none');
        $("#track_request").addClass('d-none');
        $("#generate_request").addClass('d-none');
        $("#track_request_tab").addClass('d-none');
        $("#accordion_t").removeClass('d-none');

        var enq_tab_value = 'transaction_deletion_approved';

        function callA() {

            let dataSet_pt = [];
            let num_pt = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_request_deleted',
                    tab_value : enq_tab_value,
                    layer_type: 'pvlmd_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_pt = +num_pt + 1;
                                let t_id = json_result.data[i].t_id;
                                let reference_number = json_result.data[i].reference_number;
                                let file_number = json_result.data[i].file_number;
                                let property_number = json_result.data[i].property_number;
                                let instrument_type = json_result.data[i].instrument_type;
                                let applicant_name = json_result.data[i].party2_defendant;
                                let deleted_by_date = json_result.data[i].deleted_by_date
                                let deleted_by = json_result.data[i].deleted_by;
                                let action = "";

                                // switch(status) {

                                //     case 'reviewed':
                                //     action = `<div class="text-center">
                                //                 <button type="button" class="btn btn-outline-success btn-sm"
                                //                     data-toggle="modal" data-target="#plvmd_approve_delete_request"
                                //                     data-pvlmd_id_radr="${t_id}"
                                //                     data-pvlmd_reference_number_radr="${reference_number}"
                                //                     data-pvlmd_delete_attachment_radr="${delete_attachment}"
                                //                     data-pvlmd_reviewed_by_radr="${reviewed_by}"
                                //                     data-pvlmd_review_note_radr="${review_note}"
                                //                     data-initiate_type_radr="transaction"
                                //                     data-layer_type_radr="PVLMD"
                                //                 >
                                //                     Review Request
                                //                 </button>
                                //             </div>`;
                                //     break;
                                // }

                                // if(status == '') {
                                //     status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                // } else if(status == 'pending') {
                                //     status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                // } else if(status == 'approved') {
                                //     status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                // } else if(status == 'reviewed') {
                                //     status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                // }

                                html.push(num_pt);
                                html.push(reference_number);
                                html.push(file_number);
                                html.push(applicant_name); 
                                html.push(property_number); 
                                html.push(instrument_type);
                                html.push(deleted_by); 
                                html.push(deleted_by_date);
                                html.push(action); 

                                dataSet_pt.push(html);
                            }
                        }

                        $('#table_pvlmd_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_pvlmd_transaction_list').DataTable({ 
                            data: dataSet_pt
                        }).draw();
                    }

                    CallB();

                }
            })

        }

        function CallB() {

            let dataSet_ct = [];
            let num_ct = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_request_deleted',
                    tab_value : enq_tab_value,
                    layer_type: 'cro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_ct = +num_ct + 1;
                                let t_id = json_result.data[i].id;
                                let reference_number = json_result.data[i].doc_number;
                                let document_date = json_result.data[i].doc_date;
                                let document_type = json_result.data[i].doc_type;
                                let purpose = json_result.data[i].purpose;
                                let commencement_date = json_result.data[i].commencement_date;
                                let applicant_name = json_result.data[i].party2_2 == "" ? json_result.data[i].plaintiff : json_result.data[i].party2_2;
                                let deleted_by_date = json_result.data[i].deleted_by_date
                                let deleted_by = json_result.data[i].deleted_by;
                                let action = "";

                                // switch(status) {
                                //     case 'reviewed':
                                //     action = `<div class="text-center">
                                //                 <button type="button" class="btn btn-outline-success btn-sm"
                                //                     data-toggle="modal" data-target="#plvmd_approve_delete_request"
                                //                     data-pvlmd_id_radr="${t_id}"
                                //                     data-pvlmd_reference_number_radr="${reference_number}"
                                //                     data-pvlmd_delete_attachment_radr="${delete_attachment}"
                                //                     data-pvlmd_reviewed_by_radr="${reviewed_by}"
                                //                     data-pvlmd_review_note_radr="${review_note}"
                                //                     data-initiate_type_radr="transaction"
                                //                     data-layer_type_radr="CRO"
                                //                 >
                                //                     Review Request
                                //                 </button>
                                //             </div>`;
                                //     break;
                                // }

                                // if(status == '') {
                                //     status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                // } else if(status == 'pending') {
                                //     status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                // } else if(status == 'approved') {
                                //     status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                // } else if(status == 'reviewed') {
                                //     status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                // }

                                html.push(num_ct);
                                html.push(reference_number);
                                html.push(document_type);
                                html.push(purpose); 
                                html.push(applicant_name); 
                                html.push(commencement_date);
                                html.push(deleted_by); 
                                html.push(deleted_by_date);
                                html.push(action); 

                                dataSet_ct.push(html);
                            }
                        }

                        $('#table_cro_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_cro_transaction_list').DataTable({ 
                            data: dataSet_ct
                        }).draw();
                    }

                    callC();

                }
            })
        }

        function callC() {

            let dataSet_gt = [];
            let num_gt = 0

            $.ajax({
                type : "POST",
                url : "Maps",
                data : {
                    request_type : 'select_pvlmd_request_deleted',
                    tab_value : enq_tab_value,
                    layer_type: 'garro_layer'
                },
                cache : false,
                success : function(response) {

                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num_gt = +num_gt + 1;
                                let t_id = json_result.data[i].id;
                                let reference_number = json_result.data[i].document_no;
                                let property_number = json_result.data[i].property_no;
                                let date_of_instrument = json_result.data[i].date_of_instrument;
                                let nature_of_interest = json_result.data[i].nature_of_interest;
                                let location = json_result.data[i].location;
                                let sheet_no = json_result.data[i].sheet_no;
                                let applicant_name = json_result.data[i].grantee;
                                let interest = json_result.data[i].interest;
                                let purpose = json_result.data[i].purpose;
                                let deleted_by_date = json_result.data[i].deleted_by_date
                                let deleted_by = json_result.data[i].deleted_by;
                                let action = "";

                                // switch(status) {
                                //     case 'reviewed':
                                //     action = `<div class="text-center">
                                //                 <button type="button" class="btn btn-outline-success btn-sm"
                                //                     data-toggle="modal" data-target="#plvmd_approve_delete_request"
                                //                     data-pvlmd_id_radr="${t_id}"
                                //                     data-pvlmd_reference_number_radr="${reference_number}"
                                //                     data-pvlmd_delete_attachment_radr="${delete_attachment}"
                                //                     data-pvlmd_reviewed_by_radr="${reviewed_by}"
                                //                     data-pvlmd_review_note_radr="${review_note}"
                                //                     data-initiate_type_radr="transaction"
                                //                     data-layer_type_radr="GARRO"
                                //                 >
                                //                     Review Request
                                //                 </button>
                                //             </div>`;
                                //     break;
                                // }

                                // if(status == '') {
                                //     status = '<div class="text-center"><span class="badge badge-success">Available</span></div>'
                                // } else if(status == 'pending') {
                                //     status = '<div class="text-center"><span class="badge badge-warning">Pending</span></div>'
                                // } else if(status == 'approved') {
                                //     status = '<div class="text-center"><span class="badge badge-success">Approved</span></div>'
                                // } else if(status == 'reviewed') {
                                //     status = '<div class="text-center"><span class="badge badge-info">Reviewed</span></div>'
                                // }

                                html.push(num_gt);
                                html.push(reference_number);
                                html.push(property_number);
                                html.push(location); 
                                html.push(applicant_name); 
                                html.push(nature_of_interest);
                                html.push(date_of_instrument);
                                html.push(deleted_by); 
                                html.push(deleted_by_date);
                                html.push(action); 

                                dataSet_gt.push(html);
                            }
                        }

                        $('#table_garro_transaction_list').DataTable().clear().destroy();
                            
                        $('#table_garro_transaction_list').DataTable({ 
                            data: dataSet_gt
                        }).draw();
                    }

                }
            })

        }

        callA()

    })

    $('#btnTrackRequest').on('click', function(e) {
        
        var reference_number = $('#pd_search_value').val();

        if(!reference_number) {
            $.notify({
                message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Enter reference number.</span>',
            }, { type : 'danger' , z_index: 9999  });
        }
        else {
            let dataSet = [];
            let num = 0;

            $.ajax({
                method:"POST",
                url : "Maps",
                data : {
                    request_type : 'select_track_requested_details',
                    reference_number : reference_number
                },
                cache : false,
                success : function(response) {
                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num = +num + 1;
                                let id = json_result.data[i].id;
                                let reference_number = json_result.data[i].reference_number;
                                let sender_number = json_result.data[i].sender_number;
                                let description = json_result.data[i].description;
                                let requested_date = convertDate(json_result.data[i].requested_date.slice(0,10));
                                let otp_code = json_result.data[i].otp_code;
                                let approval = json_result.data[i].approval == true ? 'Approved' : 'Not Approved';
                                let requested_by = json_result.data[i].requested_by;
                                let request_type = json_result.data[i].request_type;
                                let action = "";

                                // switch(status) {

                                //     case 'reviewed':
                                //     action = `<div class="text-center">
                                //                 <button type="button" class="btn btn-outline-success btn-sm"
                                //                     data-toggle="modal" data-target="#plvmd_approve_delete_request"
                                //                     data-pvlmd_id_radr="${gid}"
                                //                     data-pvlmd_reference_number_radr="${reference_number}"
                                //                     data-pvlmd_delete_attachment_radr="${delete_attachment}"
                                //                     data-pvlmd_reviewed_by_radr="${reviewed_by}"
                                //                     data-pvlmd_review_note_radr="${review_note}"
                                //                     data-initiate_type_radr="parcel"
                                //                     data-layer_type_radr="PVLMD"
                                //                 >
                                //                     Review Request
                                //                 </button>
                                //             </div>`;
                                //     break;
                                // }

                                if(approval == 'Approved') {
                                    approval = '<div class="text-center"><span class="badge badge-success">Verified</span></div>'
                                } else if(approval == 'Not Approved') {
                                    approval = '<div class="text-center"><span class="badge badge-danger">Not Verified</span></div>'
                                }

                                html.push(num);
                                html.push(reference_number);
                                html.push(sender_number);
                                html.push(description); 
                                html.push(request_type); 
                                html.push(requested_by);
                                html.push(approval); 
                                html.push(requested_date); 
                                html.push(action); 

                                dataSet.push(html);
                            }
                        }

                        $('#table_amendment_requested').DataTable().clear().destroy();
                            
                        $('#table_amendment_requested').DataTable({ 
                            data: dataSet
                        }).draw();
                    }
                }
            })
        }
    })


    $('#btn_generate_amendment_request').on('click', function(e) {
        
        var from_date = $('#from_date_idr').val();
        var to_date = $('#to_date_idr').val();

        if(!from_date || !to_date) {
            $.notify({
                message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please fill the required fields.</span>',
            }, { type : 'danger' , z_index: 9999  });
        }
        else {
            let dataSet = [];
            let num = 0;

            $.ajax({
                method:"POST",
                url : "Maps",
                data : {
                    request_type : 'select_generate_requested_details',
                    from_date : from_date,
                    to_date: to_date
                },
                cache : false,
                success : function(response) {
                    let json_result = JSON.parse(response);
                    console.log(json_result)

                    if(json_result.success){
                        if(json_result.data !== null){
                            for(let i=0; i<json_result.data.length; i++){
                                let html=[];
                                num = +num + 1;
                                let id = json_result.data[i].id;
                                let reference_number = json_result.data[i].reference_number;
                                let sender_number = json_result.data[i].sender_number;
                                let description = json_result.data[i].description;
                                let requested_date = convertDate(json_result.data[i].requested_date.slice(0,10));
                                let otp_code = json_result.data[i].otp_code;
                                let approval = json_result.data[i].approval == true ? 'Approved' : 'Not Approved';
                                let requested_by = json_result.data[i].requested_by;
                                let request_type = json_result.data[i].request_type;
                                let action = "";

                                // switch(status) {

                                //     case 'reviewed':
                                //     action = `<div class="text-center">
                                //                 <button type="button" class="btn btn-outline-success btn-sm"
                                //                     data-toggle="modal" data-target="#plvmd_approve_delete_request"
                                //                     data-pvlmd_id_radr="${gid}"
                                //                     data-pvlmd_reference_number_radr="${reference_number}"
                                //                     data-pvlmd_delete_attachment_radr="${delete_attachment}"
                                //                     data-pvlmd_reviewed_by_radr="${reviewed_by}"
                                //                     data-pvlmd_review_note_radr="${review_note}"
                                //                     data-initiate_type_radr="parcel"
                                //                     data-layer_type_radr="PVLMD"
                                //                 >
                                //                     Review Request
                                //                 </button>
                                //             </div>`;
                                //     break;
                                // }

                                if(approval == 'Approved') {
                                    approval = '<div class="text-center"><span class="badge badge-success">Verified</span></div>'
                                } else if(approval == 'Not Approved') {
                                    approval = '<div class="text-center"><span class="badge badge-danger">Not Verified</span></div>'
                                }

                                html.push(num);
                                html.push(reference_number);
                                html.push(sender_number);
                                html.push(description); 
                                html.push(request_type); 
                                html.push(requested_by);
                                html.push(approval); 
                                html.push(requested_date); 
                                html.push(action); 

                                dataSet.push(html);
                            }
                        }

                        $('#table_amendment_requested').DataTable().clear().destroy();
                            
                        $('#table_amendment_requested').DataTable({ 
                            data: dataSet
                        }).draw();
                    }
        
                }
            })
        }
    })
})


$(function () {

    var ajaxes  = [
            {
                url      : '<url>',
                data     : {},
                callback : function (data) { /*do work on data*/ }
            },
            {
                url      : '<url2>',
                data     : {},
                callback : function (data) { /*maybe something different (maybe not)*/ }
            }
        ],
        current = 0;

    function do_ajax() {

        if (current < ajaxes.length) {

            $.ajax({
                url      : ajaxes[current].url,
                data     : ajaxes[current].data,
                success  : function (serverResponse) {

                    ajaxes[current].callback(serverResponse);

                },
                complete : function () {

                    current++;
                    do_ajax();

                }
            });
        }
    }

    do_ajax();

});