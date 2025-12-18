$(document).ready(function() {

    var unit_id;
 
     var datatable = $("#job_casemgtdetailsdataTableCS")
                             .DataTable({
                                 // responsive: true,
 
                                 stateSave : true,
                                 "createdRow" : function(row, data, dataIndex) {
                                     if (data[0] == "1") {
                                         $(row).addClass('tr-completed-work');
                                     }
                                 },
 
                             /*
                              * columns: [ { // Responsive control column data:
                              * null, defaultContent: '', className: 'control',
                              * orderable: false },
                              *  ],
                              */
                             }); 
 
                             
 
     // console.log("welcome");
 
 
     $(document).on('click','#view_applications_with_monitoring_unit',function(e){
         e.preventDefault();
         var user_created_id=$(this).data('id');
         
         var user_created_name=$(this).data('name_full');
         //var user_created_name = $(e.currentTarget).data("name");
     
         document.getElementById('staffname').innerHTML = user_created_name;
         //var user_created_name = $(e.currentTarget).data("name");
        
         $("#view_applications_with_monitoring_unit_modal").modal("show");  
        console.log(user_created_id);
        
     
        $.ajax({
            type : "POST",
            url : "request_monitoring_dashboard",
            data : {
                request_type : 'all_staff_apps_with_unit_monitoring',
                staff_id : user_created_id
            },
            cache: false,
            success: function(response) {
     
             console.log(response)
     
                var json_result = JSON.parse(response);
     
                if (json_result.apps_at_division == null){
     
                 let dataSet4 = [];
                 let num4 = 0;
              
               $('#view_applications_with_monitoring_unit_table').DataTable().clear().destroy();
     
                 // console.log("data not found");       
                 alert('Sorry Data Not Found');
     
     }else {
     
       let dataSet4 = [];
       let num4 = 0;
     
     $('#view_applications_with_monitoring_unit_table').DataTable().clear().destroy();
      
     
     
       for(let i=0; i<json_result.apps_at_division.length; i++) {
         let html = [];
         num4 = +num4 + 1;
     
         let job_number = json_result.apps_at_division[i].job_number;
         let ar_name = json_result.apps_at_division[i].ar_name;
         let business_process_name = json_result.apps_at_division[i].business_process_name;
         let created_on = json_result.apps_at_division[i].created_on;
         let job_status = json_result.apps_at_division[i].job_status;
         let job_purpose = json_result.apps_at_division[i].job_purpose;
         
         let message_Btn = "";
 
         message_Btn = `<button data-job-number="${json_result.apps_at_division[i].job_number}" data-staff_no="${user_created_id}" data-staff_name="${user_created_name}"  class="btn btn-primary ml-auto" id="sendMess" type="button">Send Message</button>`;
 
         document.getElementById("messageBt").innerHTML = message_Btn;  
 
 
 
         
  var startDate = json_result.apps_at_division[i].job_datesend;
 startDate = new Date(startDate.replace(/-/g, "/")); // Convert the start date string to Date object
 
 var endDate = "", noOfDaysToAdd = 10, count = 0;
 while (count < noOfDaysToAdd) {
     endDate = new Date(startDate.setDate(startDate.getDate() + 1));
     if (endDate.getDay() != 0 && endDate.getDay() != 6) { 
         // Skip weekends (Sunday = 0, Saturday = 6)
         count++;
     }
 }
 
 // Format the final end date (nxt_date) to MM/DD/YYYY
 var nxt_date = '';
 var datex = new Date(endDate);
 let day = datex.getDate();
 let month = (datex.getMonth() + 1); // Months are zero-based, so +1
 let year = datex.getFullYear();
 nxt_date = `${month}/${day}/${year}`; // Format as MM/DD/YYYY
 
 // Calculate the number of days between today and nxt_date
 var today = new Date().toJSON().slice(0, 10).replace(/-/g, '/'); // Today's date in MM/DD/YYYY format
 var date1 = new Date(today);
 var date2 = new Date(nxt_date);
 
 // Calculate the difference in days (taking care of the calculation)
 var diffDays = Math.floor((date2 - date1) / (1000 * 60 * 60 * 24), 10); // Number of milliseconds in a day
 var reminder = diffDays;
 
 // Display the reminder badge based on days remaining or passed
 var display_reminder = '';
 if (reminder <= 0) {
     // Negative or zero days means the date has passed
     var newStr = Math.abs(reminder).toString(); // Absolute value of days passed
     display_reminder = `<label class="badge badge-danger">${newStr} Day(s) Passed</label>`;
 } else {
     // Positive days remaining
     display_reminder = `<label class="badge badge-success">${reminder} Day(s) Left</label>`;
 }
 
         
 
     //    let action = '<button  class="btn btn-info btn-icon-split"  data-title="Add to List"  id="btnAddToBatchlist-'
     // 																							+ this.job_number
     // 																							+ '" data-job_number="'
     // 																							+ this.job_number
     // 																							+ '" data-ar_name="'
     // 																							+ this.ar_name
     // 																							+ '" data-business_process_sub_name="'
     // 																							+ this.business_process_sub_name
     // 																							+ '" data-application_stage="'
     // 																							+ this.application_stage
     // 																							+ '" data-application_stage_name="'
     // 																							+ this.application_stage_name
     // 																							+ '" data-application_stage_baby_step="'
     // 																							+ this.application_stage_baby_step
     // 																							+ '" data-application_stage_name_baby_step="'
     // 																							+ this.application_stage_name_baby_step
     // 																							+ '" data-target="#askForPurposeOfBatching" data-toggle="modal" >'
     // 																							+ ' <span class="icon text-white-50"> <i class="fas fa-list"></i></span><span class="text">Add to Batch</span>'
     // 																							+ ' </button>';
 
     // Create button using template literals
     let action = `<div class="btn-group" role="group">
     <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         Actions
     </button>
     <div class="dropdown-menu">
        
 
     <button data-staff='${json_result.apps_at_division[i].job_recieved_by}' data-staff_id='${json_result.apps_at_division[i].job_recieved_by_id}' data-job-number='${json_result.apps_at_division[i].job_number}' class="sendMessage dropdown-item" type="button">Send Message <i class="fas fa-comment-alt"></i></button>
     </div>
 </div>            
  `;
 
 // Event listener for showing the modal
         // let payment_status = e[i].payment_status;
         // let buttons = e[i].buttons;
         
         html.push(created_on);
         html.push(job_number);
         html.push(ar_name);
         html.push(business_process_name);
         html.push(job_status);
         html.push(job_purpose);
         html.push(display_reminder);
         html.push(action);
         
        
     
         dataSet4.push(html);
     
       //console.log(dataSet)
       }
     
     // let dataTable_Obj = $('#recievedtoday').DataTable({
     //     data: dataSet1
     //   })
     
       $('#view_applications_with_monitoring_unit_table').DataTable().clear().destroy();
                     
     //   $('#view_applications_with_monitoring_unit_table').DataTable({ data: dataSet4,
     //     dom : 'Bfrtip',
     //     lengthMenu : [
     //         [ 10, 25, 50, -1 ],
     //         [ '10 rows', '25 rows',
     //             '50 rows', 'Show all' ] ],
     //     buttons : [ 'pageLength', 'copy',
     //         'csv', 'excel', 'pdf', 'print' ] }).draw();
 
 
     $('#view_applications_with_monitoring_unit_table').DataTable({
         data: dataSet4,
         dom: 'Bfrtip',
         lengthMenu: [
             [10, 25, 50, -1],
             ['10 rows', '25 rows', '50 rows', 'Show all']
         ],
         buttons: [
             'pageLength', 
             'copy', 
             'csv', 
             'excel', 
             'pdf',
             {
                 extend: 'print',
                 text: 'Print',
                 title: 'Compliance Unit Request Applications with'+ " "+ user_created_name, // Add your custom title here
                 exportOptions: {
                     // Optional: Customize the exported data, e.g., columns to include
                     columns: ':visible'
                 }
             }
         ]
     }).draw();
     
     }
               // console.log(json_result)
     
               
     
     
            }
        })
 
 
 
 
     
 
     
     });
 
 
 
     $('#ur_district').change(function() {
         
         $('#ur_division').val("")	
         $('#ur_department').val("")
         datalist.empty();
     });
 
 
 
     $('#ur_division').change(function() {
         // Get the selected division
         var selected_division = $(this).val();
         var office_id = $("#ur_district").val();
         
         // Clear the selected department
         $("#ur_department").val("");
     
         $.ajax({
             type: "POST",
             url: "Case_Management_Serv",
             data: {
                 request_type: 'get_lc_list_of_units',
                 office_id: office_id
             },
             cache: false,
             success: function(jobdetails) {
                 var json_p = JSON.parse(jobdetails);
     
                 // Get the select element for units
                 var unitSelect = $("#ur_units");
                 unitSelect.empty(); // Clear the current options
     
                 // Add a default "Select" option
                 unitSelect.append('<option value="">Select</option>');
     
                 // Loop through the JSON data and append matching options to the select dropdown
                 $(json_p.data).each(function() {
                     if (this.unit_division.includes(selected_division)) {
                         unitSelect.append('<option data-name="' + this.unit_name + '" data-id="' + this.unit_id + '" value="' + this.unit_id + '">' + this.unit_name + '</option>');
                     }
                 });
             }
         });
     });
 
 
 
 
     $.ajax({
         type : "POST",
         url : "app_modal_fills_serv",
         data : {
             request_type : 'get_all_office_region',
         },
         cache : false,
         beforeSend : function() {
             // $('#district').html('<img
             // src="img/loading.gif"
             // alt="" width="24"
             // height="24">');
         },
         success : function(
                 jobdetails) {
 
             // console.log(jobdetails);
             var json_p = JSON
                     .parse(jobdetails);
             var options = $("#ur_district");
 
             // var options =
             // $("#selector");
             options.empty();
             options
                     .append(new Option(
                             "-- Select --",
                             0));
 
             $(json_p)
                     .each(
                             function() {
 
                                 // console.log(select_id);
                                 // console.log(this.business_process_id);
 
                                 // if
                                 // (main_service_id
                                 // ==this.business_process_id){
                                 $(
                                         '#ur_district')
                                         .append(
                                                 '<option value="'
                                                         + this.ord_region_code
                                                     
                                                         + '">'
                                                         + this.ord_region_name
                                                         + '</option>');
 
                                 // }
 
                             });
             // business_process_id
 
             $("#ur_district").val($(event.relatedTarget).data('regional_code'));
 
             
         }
     });
 
 
 
 
 
     $.ajax({
         type : "POST",
         url : "app_modal_fills_serv",
         data : {
             request_type : 'get_divisions_get_list',
         },
         cache : false,
         success : function(
                 jobdetails) {
             var json_p = JSON.parse(jobdetails);
             var options = $("#ur_division");
             options.empty();
             options.append(new Option("-- Select --",0));
             $(json_p)
                     .each(
                             function() {
                                 $(
                                         '#ur_division')
                                         .append(
                                                 '<option value="'
                                                         
                                                         + this.division_name
                                                         + '">'
                                                         + this.division_name
                                                         + '</option>');
 
 
                             });
 
                             $("#ur_division").val($(event.relatedTarget).data('division'));
         }
     });
 
 
 
 
 
 
 
 
 
 
 
 
 
     $('#ur_units').change(function(){
         console.log("selection made " + $(this).val() );
            
         const selectedOptionValue = $(this).val();
         $('#user_unit_id').val(selectedOptionValue);
 
         var unit_id = $('#user_unit_id').val();
 
 
         $.ajax({
             type : "POST",
             url : "request_monitoring_dashboard",
             data : {
                 request_type : 'select_staff_apps_with_unit_monitoring',
                 unit_id : unit_id
             },
             cache: false,
             success: function(response) {
     
                 console.log(response);
     
               
                 var json_result = JSON.parse(response);
                 var incoming = json_result.incoming;
                 var withofficers = json_result.withofficers;
                 var withinunit = json_result.withinunit;
                 var queried = json_result.queried;
     
                 document.getElementById('incoming_count').innerHTML = incoming;
                 document.getElementById('officers_count').innerHTML = withofficers;
                 document.getElementById('withinunit_count').innerHTML = withinunit;
                 document.getElementById('queried_count').innerHTML = queried;
     
                 
     
                 // console.log(json_result);
     
     
     
                 $.ajax({
                     type: "POST",
                     url: "request_monitoring_dashboard",
                     data: {
                         request_type: 'select_all_staff_apps_with_unit_monitoring',
                         unit_id: unit_id
                     },
                     cache: false,
                     success: function(response_new) {
                         var json_result1 = JSON.parse(response_new);
                         console.log(json_result1);
                 
                         // Clear the container before appending new data
                         document.getElementById("finish_btn1").innerHTML = "";
                 
                         for (let i = 0; i < json_result1.apps_at_division.length; i++) {
                             let Reload_Btn1 = `
                                <div class="row">
     <div class="col">
         <div class="h5 mb-0 font-weight-bold text-gray-800">${json_result1.apps_at_division[i].fullname}</div>
     </div>
     <div class="col">
         <div class="h5 mb-0 font-weight-bold text-gray-800">${json_result1.apps_at_division[i].count}</div>
     </div>
     <div class="col">
       <p>Pending :${json_result1.apps_at_division[i].pending_count} | Past Due:${json_result1.apps_at_division[i].past_due_count} | Queried: ${json_result1.apps_at_division[i].queried_count} </p>
 
         </div>
     <div class="col">
         <div class="progress mb-4">
             <!-- Completed part of the progress bar (Green) -->
             <div id="completed-pvlmd-progress-bar" 
                 class="progress-bar" 
                 role="progressbar" 
                 style="width:${json_result1.apps_at_division[i].approved_percentage}; background-color: green;" 
                 aria-valuenow="${json_result1.apps_at_division[i].approved_percentage}" aria-valuemin="0" aria-valuemax="100">${json_result1.apps_at_division[i].approved_percentage}
             </div>
             <!-- Warning part of the progress bar (Yellow) -->
             <div id="warning-pvlmd-progress-bar" 
                 class="progress-bar" 
                 role="progressbar" 
                 style="width:${json_result1.apps_at_division[i].pending_percentage}; background-color: #e2aa1b;" 
                 aria-valuenow="${json_result1.apps_at_division[i].pending_percentage}" aria-valuemin="0" aria-valuemax="100">${json_result1.apps_at_division[i].pending_percentage}
             </div>
             <!-- Pending part of the progress bar (Red) -->
             <div id="pending-pvlmd-progress-bar" 
                 class="progress-bar bg-danger" 
                 role="progressbar" 
                 style="width:${json_result1.apps_at_division[i].queried_percentage}; background-color: #f50505;" 
                 aria-valuenow="${json_result1.apps_at_division[i].queried_percentage}" aria-valuemin="0" aria-valuemax="100">${json_result1.apps_at_division[i].queried_percentage}
             </div>
         </div>
     </div>
     <div class="col">
         <a href="javascript:void(0)" data-id="${json_result1.apps_at_division[i].userid}" data-name_full="${json_result1.apps_at_division[i].fullname}" id="view_applications_with_monitoring_unit"  
             class="btn btn-secondary">View <i class="fa fa-eye"></i></a>
     </div>
 </div>
     
                                 <hr>
                             `;
                             // Append the HTML content instead of replacing it
                             document.getElementById("finish_btn1").innerHTML += Reload_Btn1;
                         }
                     }
                 });
     
     
     
                 
     
     
     
     
             }
         })
     
     
             
           
         // document.getElementById('pec_id').innerHTML = totalpercentage;
 
           
           });
 
           
     
 
 
       
     
 
 
 
         //   $('#askForPurposeOfBatchingnew').on('show.bs.modal', function (e) {
 
 
     
         //     const relatedTarget = $(e.relatedTarget);
 
         //     console.log(relatedTarget);
         //     $('#bl_job_number').val(relatedTarget.data('job_number'));
         //     $('#bl_ar_name').val(relatedTarget.data('ar_name'));
         //     $('#bl_business_process_sub_name').val(relatedTarget.data('business_process_sub_name'));
         //     });
             
 
 
 
         $('#askForPurposeOfBatchingnew').on('show.bs.modal', function(e) {
 
             $("#view_applications_with_monitoring_unit_modal").modal("hide");  
 
 
 
             $('#bl_job_number').val($(e.relatedTarget).data('job_number'));
             $('#bl_ar_name').val($(e.relatedTarget).data('ar_name'));
             $('#bl_business_process_sub_name').val($(e.relatedTarget).data('business_process_sub_name'));
             $('#bl_application_stage').val($(e.relatedTarget).data('application_stage'));
             $('#bl_application_stage_name').val($(e.relatedTarget).data('application_stage_name'));
             $('#bl_application_stage_baby_step').val($(e.relatedTarget).data('application_stage_baby_step'));
             $('#bl_application_stage_name_baby_step').val($(e.relatedTarget).data('application_stage_name_baby_step'));
 
 
 
             console.log($(e.relatedTarget).data('application_stage_name'));
             console.log($(e.relatedTarget).data('application_stage_baby_step'));
             console.log($(e.relatedTarget).data('application_stage_name_baby_step'));
 
              
             $.ajax({
                  type: "POST",
                  url: "app_modal_fills_serv",
                  data: {
                         request_type: 'tags_for_batching_jobs_list'},
                  cache: false,
                  beforeSend: function () {
                     // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
                  },
                  success: function(jobdetails) {
                     
                      
                         console.log(jobdetails);
                         var json_p = JSON.parse(jobdetails);
                         var options = $("#bl_job_purpose_new");
 
                        // var options = $("#selector");
                         options.empty();
                         options.append(new Option("-- Select --", 0));
                      
                         $(json_p).each(function () {
                           
                         //	console.log(select_id);
                        //	console.log(this.business_process_id);
                           
                       //   if (main_service_id ==this.business_process_id){
                               $('#bl_job_purpose_new').append('<option value="' + this.tfb_description +'">' + this.tfb_description + '</option>');
                                  
                       //  }
                           
                         
                            });  
                  }
                  });
               
        });
 
 
 
 
 
 
 
 
    $(document).on("click", ".sendMessage", function (event) {
     event.preventDefault();
 
     $("#sendMessageModal").modal("show");  
 
     let sendMessageModal = $("#sendMessageModal");
 
 
 
     let staff = $(this).data("staff");
     let staff_id = $(this).data("staff_id");
 
 // Parse the JSON string back into an object
 // var staffObject = JSON.parse(staff);
 
 // Access the 'fullname' property
 //   var fullName = staff.fullname;
 
    console.log(staff);  // Outputs: "EMMANUEL EGYAM"
 
 
     // console.log(staff);
 
     let jobNumbers = $(this).data("job-number");
 
        console.log(jobNumbers);
 
 
     jobNumbers =
         typeof jobNumbers === "undefined" ? [] : [{ job_number: jobNumbers }];
         
     if (jobNumbers.length <= 0) {
       jobNumbers = $(this)
         .parents(".modal")
         .find("table")
         .DataTable()
         .rows()
         .data()
         .toArray()
         .map((currentItem) => {
           return { job_number: currentItem.job_number };
         });
     }
 
     // set hidden job_numbers input to job number array
     sendMessageModal.find("#job_numbers").val(JSON.stringify(jobNumbers));
 
     // set hidden staff input to staff id
     sendMessageModal.find("#officer_id").val(staff_id);
     sendMessageModal.find("#officer_name").val(staff);
 
     sendMessageModal
       .find("#sendMessageModalLabel")
       .html(`Send Message To <span class="text-primary">${staff}</span>`);
 
     sendMessageModal.modal("show"); 
   });
 
   $("#message-form").on("submit", function (event) {
     event.preventDefault();
 
     let form = $(this);
     let data = form.serializeArray();
     
     
     
     data = {
       "request_type": $("#sendMessageModal").find("#request_type").val(),
       "officer_id": $("#sendMessageModal").find("#officer_id").val(),
       "officer_name": $("#sendMessageModal").find("#officer_name").val(),
       "job_numbers" : $("#sendMessageModal").find("#job_numbers").val(),
     "message_type":$("#sendMessageModal").find("#message_type").val(),
     "message": $("#sendMessageModal").find("#message").val()
     }
 
     console.log(data);
     
     
     submitAjax(
       $(this).attr("action"),
       "send_compliance_focal_person_message",
       data,
       function () {
         form.trigger("reset");
         form.parents(".modal").modal("hide");
         alert("Message sent successfully.");
       },
       function () {
         alert(
           "We were not able to send your message. Please contact IT support if issue persists."
         );
       }
     );
   });
 
 
 
 
 
 
   $(document).on("click", "#sendMess", function (event) {
     event.preventDefault();
 
     $("#allsendMessageModal").modal("show");  
 
     let sendMessageModal = $("#sendMessageModal");
 
 
 
     let staff = $(this).data("staff");
     let staff_id = $(this).data("staff_id");
     let staff_name = $(this).data("staff_name");
 
     
 
 // Parse the JSON string back into an object
 // var staffObject = JSON.parse(staff);
 
 // Access the 'fullname' property
 //   var fullName = staff.fullname;
 
    console.log(staff);  // Outputs: "EMMANUEL EGYAM"
 
 
     // console.log(staff);
 
     let jobNumbers = $(this).data("job-number");
 
        console.log(jobNumbers);
 
 
     jobNumbers =
         typeof jobNumbers === "undefined" ? [] : [{ job_number: jobNumbers }];
         
     if (jobNumbers.length <= 0) {
       jobNumbers = $(this)
         .parents(".modal")
         .find("table")
         .DataTable()
         .rows()
         .data()
         .toArray()
         .map((currentItem) => {
           return { job_number: currentItem.job_number };
         });
     }
 
     // set hidden job_numbers input to job number array
     sendMessageModal.find("#job_numbers").val(JSON.stringify(jobNumbers));
 
     // set hidden staff input to staff id
     sendMessageModal.find("#officer_id").val(staff_id);
     sendMessageModal.find("#officer_name").val(staff);
 
     sendMessageModal
       .find("#sendMessageModalLabel")
       .html(`Send Message To <span class="text-primary">${staff_name}</span>`);
 
     sendMessageModal.modal("show"); 
   });
 
   
     
 
     
 
 
 function submitAjax(
       url,
       requestType,
       data = {},
       success = function () {},
       error = function () {}
     ) {
      
 
       $.ajax({
         type: "POST",
         url,
         data: {
           request_type: requestType,
           ...data,
         },
         cache: false,
         success: function (response) {
        
         var reccc = JSON.parse(response);
 
         console.log(reccc);
         firmList = reccc;
         // console.log(reccc);
         // let totalPerRec = reccc.lrd_apps[0].total;
         // // let lrdData = reccc.apps_at_division.find(item => item.division === "LRD");
         // // let  lrdTotal = lrdData.total;
         //   console.log(totalPerRec);
           try {
             success(JSON.parse(response));
           } catch (e) {
             alert(
               "Failed to get requested data. Please try again shortly or contact IT Support if issue persists."
             );
             console.error(e);
           }
         },
         error: function (xhr) {
           error(xhr);
         },
       });
     }
 
     
 
     
 
 
     
 
     $('#incoming_apps').on('click', function(e) {
         e.preventDefault();
 
 
         var unit_id = $('#user_unit_id').val();
 
         if (unit_id==''){
             
             alert('Sorry. Please Select Unit');
 
         }
         else {
 
             $("#view_applications_incoming_with_monitoring_unit_modal").modal("show");  
             // console.log(user_created_id);
     
             document.getElementById('staffname1').innerHTML = 'APPLICATIONS INCOMING';
     
             
          
             $.ajax({
                 type : "POST",
                 url : "request_monitoring_dashboard",
                 data : {
                     request_type : 'select_staff_apps_with_unit_request_incoming_applications',
                     unit_id: unit_id
                 },
                 cache: false,
                 success: function(response) {
              
                     var json_result = JSON.parse(response);
      
                     console.log(json_result)
      
          
                     if (json_result.apps_at_division == null){
          
                      let dataSet4 = [];
                      let num4 = 0;
                   
                    $('#view_applications_incoming_with_monitoring_unit_table').DataTable().clear().destroy();
          
                      // console.log("data not found");       
                      alert('Sorry Data Not Found');
          
          }else {
          
            let dataSet4 = [];
            let num4 = 0;
          
          $('#view_applications_incoming_with_monitoring_unit_table').DataTable().clear().destroy();
           
          
          
            for(let i=0; i<json_result.apps_at_division.length; i++) {
              let html = [];
              num4 = +num4 + 1;
          
              let job_number = json_result.apps_at_division[i].job_number;
              let ar_name = json_result.apps_at_division[i].ar_name;
              let business_process_name = json_result.apps_at_division[i].business_process_name;
              let created_on = json_result.apps_at_division[i].created_on;
              let job_status = json_result.apps_at_division[i].job_status;
              let job_purpose = json_result.apps_at_division[i].job_purpose;
      
      
                      
       var startDate = json_result.apps_at_division[i].job_datesend;
       startDate = new Date(startDate.replace(/-/g, "/")); // Convert the start date string to Date object
       
       var endDate = "", noOfDaysToAdd = 10, count = 0;
       while (count < noOfDaysToAdd) {
           endDate = new Date(startDate.setDate(startDate.getDate() + 1));
           if (endDate.getDay() != 0 && endDate.getDay() != 6) { 
               // Skip weekends (Sunday = 0, Saturday = 6)
               count++;
           }
       }
       
       // Format the final end date (nxt_date) to MM/DD/YYYY
       var nxt_date = '';
       var datex = new Date(endDate);
       let day = datex.getDate();
       let month = (datex.getMonth() + 1); // Months are zero-based, so +1
       let year = datex.getFullYear();
       nxt_date = `${month}/${day}/${year}`; // Format as MM/DD/YYYY
       
       // Calculate the number of days between today and nxt_date
       var today = new Date().toJSON().slice(0, 10).replace(/-/g, '/'); // Today's date in MM/DD/YYYY format
       var date1 = new Date(today);
       var date2 = new Date(nxt_date);
       
       // Calculate the difference in days (taking care of the calculation)
       var diffDays = Math.floor((date2 - date1) / (1000 * 60 * 60 * 24), 10); // Number of milliseconds in a day
       var reminder = diffDays;
       
       // Display the reminder badge based on days remaining or passed
       var display_reminder = '';
       if (reminder <= 0) {
           // Negative or zero days means the date has passed
           var newStr = Math.abs(reminder).toString(); // Absolute value of days passed
           display_reminder = `<label class="badge badge-danger">${newStr} Day(s) Passed</label>`;
       } else {
           // Positive days remaining
           display_reminder = `<label class="badge badge-success">${reminder} Day(s) Left</label>`;
       }
      
       
      
              
      
       let action = `<div class="btn-group" role="group">
          <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
      
          <button data-staff='${json_result.apps_at_division[i].job_recieved_by}' data-staff_id='${json_result.apps_at_division[i].job_recieved_by_id}' data-job-number='${json_result.apps_at_division[i].job_number}' class="sendMessage dropdown-item" type="button">Send Message <i class="fas fa-comment-alt"></i></button>
          </div>
      </div>            
       `;
              // let payment_status = e[i].payment_status;
              // let buttons = e[i].buttons;
              
              html.push(created_on);
              html.push(job_number);
              html.push(ar_name);
              html.push(business_process_name);
              html.push(job_status);
              html.push(job_purpose);
              html.push(display_reminder);
              html.push(action);
             
          
              dataSet4.push(html);
          
            //console.log(dataSet)
            }
          
          // let dataTable_Obj = $('#recievedtoday').DataTable({
          //     data: dataSet1
          //   })
          
            $('#view_applications_incoming_with_monitoring_unit_table').DataTable().clear().destroy();
                          
            $('#view_applications_incoming_with_monitoring_unit_table').DataTable({ data: dataSet4,
              dom : 'Bfrtip',
              lengthMenu : [
                  [ 10, 25, 50, -1 ],
                  [ '10 rows', '25 rows',
                      '50 rows', 'Show all' ] ],
              buttons : [ 'pageLength', 'copy',
                  'csv', 'excel', 'pdf', 'print' ] }).draw();
          
          }
                    // console.log(json_result)
          
                    
          
          
                 }
             })
      
 
         }
 
         // console.log(unit_id);
 
 
      
  
  
     })
 
 
     
 
 
 
 
     $('#apps_with_officers').on('click', function(e) {
         e.preventDefault();
 
 
         var unit_id = $('#user_unit_id').val();
 
         if (unit_id==''){
             
             alert('Sorry. Please Select Unit');
 
         }
         else {
 
 
             $("#view_applications_incoming_with_monitoring_unit_modal").modal("show");  
             // console.log(user_created_id);
     
             document.getElementById('staffname1').innerHTML = 'APPLICATIONS WITH OFFICERS';
     
     
             var inbox_type=$(this).data('inbox');
     
     
             console.log(inbox_type);
     
             
          
             $.ajax({
                 type : "POST",
                 url : "request_monitoring_dashboard",
                 data : {
                     request_type : 'select_staff_apps_with_officers_request_withinunit_applications',
                     unit_id: unit_id,
                     inbox_type:inbox_type
                 },
                 cache: false,
                 success: function(response) {
              
                     var json_result = JSON.parse(response);
      
                     console.log(json_result)
      
          
                     if (json_result.apps_at_division == null){
          
                      let dataSet4 = [];
                      let num4 = 0;
                   
                    $('#view_applications_incoming_with_monitoring_unit_table').DataTable().clear().destroy();
          
                      // console.log("data not found");       
                      alert('Sorry Data Not Found');
          
          }else {
          
            let dataSet4 = [];
            let num4 = 0;
          
          $('#view_applications_incoming_with_monitoring_unit_table').DataTable().clear().destroy();
           
          
          
            for(let i=0; i<json_result.apps_at_division.length; i++) {
              let html = [];
              num4 = +num4 + 1;
          
              let job_number = json_result.apps_at_division[i].job_number;
              let ar_name = json_result.apps_at_division[i].ar_name;
              let business_process_name = json_result.apps_at_division[i].business_process_name;
              let created_on = json_result.apps_at_division[i].created_on;
              let job_status = json_result.apps_at_division[i].job_status;
              let job_purpose = json_result.apps_at_division[i].job_purpose;
      
      
                      
       var startDate = json_result.apps_at_division[i].job_datesend;
       startDate = new Date(startDate.replace(/-/g, "/")); // Convert the start date string to Date object
       
       var endDate = "", noOfDaysToAdd = 10, count = 0;
       while (count < noOfDaysToAdd) {
           endDate = new Date(startDate.setDate(startDate.getDate() + 1));
           if (endDate.getDay() != 0 && endDate.getDay() != 6) { 
               // Skip weekends (Sunday = 0, Saturday = 6)
               count++;
           }
       }
       
       // Format the final end date (nxt_date) to MM/DD/YYYY
       var nxt_date = '';
       var datex = new Date(endDate);
       let day = datex.getDate();
       let month = (datex.getMonth() + 1); // Months are zero-based, so +1
       let year = datex.getFullYear();
       nxt_date = `${month}/${day}/${year}`; // Format as MM/DD/YYYY
       
       // Calculate the number of days between today and nxt_date
       var today = new Date().toJSON().slice(0, 10).replace(/-/g, '/'); // Today's date in MM/DD/YYYY format
       var date1 = new Date(today);
       var date2 = new Date(nxt_date);
       
       // Calculate the difference in days (taking care of the calculation)
       var diffDays = Math.floor((date2 - date1) / (1000 * 60 * 60 * 24), 10); // Number of milliseconds in a day
       var reminder = diffDays;
       
       // Display the reminder badge based on days remaining or passed
       var display_reminder = '';
       if (reminder <= 0) {
           // Negative or zero days means the date has passed
           var newStr = Math.abs(reminder).toString(); // Absolute value of days passed
           display_reminder = `<label class="badge badge-danger">${newStr} Day(s) Passed</label>`;
       } else {
           // Positive days remaining
           display_reminder = `<label class="badge badge-success">${reminder} Day(s) Left</label>`;
       }
      
       
      
              
      
       let action = `<div class="btn-group" role="group">
          <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
          </button>
          <div class="dropdown-menu">
      
          <button data-staff='${json_result.apps_at_division[i].job_recieved_by}' data-staff_id='${json_result.apps_at_division[i].job_recieved_by_id}' data-job-number='${json_result.apps_at_division[i].job_number}' class="sendMessage dropdown-item" type="button">Send Message <i class="fas fa-comment-alt"></i></button>
          </div>
      </div>            
       `;
              // let payment_status = e[i].payment_status;
              // let buttons = e[i].buttons;
              
              html.push(created_on);
              html.push(job_number);
              html.push(ar_name);
              html.push(business_process_name);
              html.push(job_status);
              html.push(job_purpose);
              html.push(display_reminder);
              html.push(action);
             
          
              dataSet4.push(html);
          
            //console.log(dataSet)
            }
          
          // let dataTable_Obj = $('#recievedtoday').DataTable({
          //     data: dataSet1
          //   })
          
            $('#view_applications_incoming_with_monitoring_unit_table').DataTable().clear().destroy();
                          
            $('#view_applications_incoming_with_monitoring_unit_table').DataTable({ data: dataSet4,
              dom : 'Bfrtip',
              lengthMenu : [
                  [ 10, 25, 50, -1 ],
                  [ '10 rows', '25 rows',
                      '50 rows', 'Show all' ] ],
              buttons : [ 'pageLength', 'copy',
                  'csv', 'excel', 'pdf', 'print' ] }).draw();
          
          }
                    // console.log(json_result)
          
                    
          
          
                 }
             })
      
 
         }
 
 
    
  
  
     })
 
 
 
 
 
     $('#apps_completed_within_unit').on('click', function(e) {
         e.preventDefault();
 
         var unit_id = $('#user_unit_id').val();
 
         if (unit_id==''){
             
             alert('Sorry. Please Select Unit');
 
         }
         else {
 
 
             $("#view_applications_incoming_with_monitoring_unit_modal").modal("show");  
             // console.log(user_created_id);
     
             document.getElementById('staffname1').innerHTML = 'APPLICATIONS WITHIN UNIT';
     
     
             var inbox_type=$(this).data('inbox');
     
     
             console.log(inbox_type);
     
             
          
             $.ajax({
                 type : "POST",
                 url : "request_monitoring_dashboard",
                 data : {
                     request_type : 'select_staff_apps_with_officers_request_withinuni',
                     unit_id: unit_id,
                     inbox_type:inbox_type
                 },
                 cache: false,
                 success: function(response) {
              
                     var json_result = JSON.parse(response);
      
                     console.log(json_result)
      
          
                     if (json_result.apps_at_division == null){
          
                      let dataSet4 = [];
                      let num4 = 0;
                   
                    $('#view_applications_incoming_with_monitoring_unit_table').DataTable().clear().destroy();
          
                      // console.log("data not found");       
                      alert('Sorry Data Not Found');
          
          }else {
          
            let dataSet4 = [];
            let num4 = 0;
          
          $('#view_applications_incoming_with_monitoring_unit_table').DataTable().clear().destroy();
           
          
          
            for(let i=0; i<json_result.apps_at_division.length; i++) {
              let html = [];
              num4 = +num4 + 1;
          
              let job_number = json_result.apps_at_division[i].job_number;
              let ar_name = json_result.apps_at_division[i].ar_name;
              let business_process_name = json_result.apps_at_division[i].business_process_name;
              let created_on = json_result.apps_at_division[i].created_on;
              let job_status = json_result.apps_at_division[i].job_status;
              let job_purpose = json_result.apps_at_division[i].job_purpose;
      
      
                      
       var startDate = json_result.apps_at_division[i].job_datesend;
       startDate = new Date(startDate.replace(/-/g, "/")); // Convert the start date string to Date object
       
       var endDate = "", noOfDaysToAdd = 10, count = 0;
       while (count < noOfDaysToAdd) {
           endDate = new Date(startDate.setDate(startDate.getDate() + 1));
           if (endDate.getDay() != 0 && endDate.getDay() != 6) { 
               // Skip weekends (Sunday = 0, Saturday = 6)
               count++;
           }
       }
       
       // Format the final end date (nxt_date) to MM/DD/YYYY
       var nxt_date = '';
       var datex = new Date(endDate);
       let day = datex.getDate();
       let month = (datex.getMonth() + 1); // Months are zero-based, so +1
       let year = datex.getFullYear();
       nxt_date = `${month}/${day}/${year}`; // Format as MM/DD/YYYY
       
       // Calculate the number of days between today and nxt_date
       var today = new Date().toJSON().slice(0, 10).replace(/-/g, '/'); // Today's date in MM/DD/YYYY format
       var date1 = new Date(today);
       var date2 = new Date(nxt_date);
       
       // Calculate the difference in days (taking care of the calculation)
       var diffDays = Math.floor((date2 - date1) / (1000 * 60 * 60 * 24), 10); // Number of milliseconds in a day
       var reminder = diffDays;
       
       // Display the reminder badge based on days remaining or passed
       var display_reminder = '';
       if (reminder <= 0) {
           // Negative or zero days means the date has passed
           var newStr = Math.abs(reminder).toString(); // Absolute value of days passed
           display_reminder = `<label class="badge badge-danger">${newStr} Day(s) Passed</label>`;
       } else {
           // Positive days remaining
           display_reminder = `<label class="badge badge-success">${reminder} Day(s) Left</label>`;
       }
      
       
      
              
      
       let action = `<div class="btn-group" role="group">
          <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
          </button>
          <div class="dropdown-menu">
             
      
          <button data-staff='${json_result.apps_at_division[i].job_recieved_by}' data-staff_id='${json_result.apps_at_division[i].job_recieved_by_id}' data-job-number='${json_result.apps_at_division[i].job_number}' class="sendMessage dropdown-item" type="button">Send Message <i class="fas fa-comment-alt"></i></button>
          </div>
      </div>            
       `;
              // let payment_status = e[i].payment_status;
              // let buttons = e[i].buttons;
              
              html.push(created_on);
              html.push(job_number);
              html.push(ar_name);
              html.push(business_process_name);
              html.push(job_status);
              html.push(job_purpose);
              html.push(display_reminder);
              html.push(action);
             
          
              dataSet4.push(html);
          
            //console.log(dataSet)
            }
          
          // let dataTable_Obj = $('#recievedtoday').DataTable({
          //     data: dataSet1
          //   })
          
            $('#view_applications_incoming_with_monitoring_unit_table').DataTable().clear().destroy();
                          
            $('#view_applications_incoming_with_monitoring_unit_table').DataTable({ data: dataSet4,
              dom : 'Bfrtip',
              lengthMenu : [
                  [ 10, 25, 50, -1 ],
                  [ '10 rows', '25 rows',
                      '50 rows', 'Show all' ] ],
              buttons : [ 'pageLength', 'copy',
                  'csv', 'excel', 'pdf', 'print' ] }).draw();
          
          }
                    // console.log(json_result)
          
                    
          
          
                 }
             })
 
         }
 
  
  
  
  
     })
 
 
 
 
 
 
 
     $('#apps_queried').on('click', function(e) {
         e.preventDefault();
 
 
 
         var unit_id = $('#user_unit_id').val();
 
 
         if (unit_id==''){
             
             alert('Sorry. Please Select Unit');
 
         }
         else {
 
 
 
         $("#view_applications_incoming_with_monitoring_unit_modal").modal("show");  
         // console.log(user_created_id);
 
         document.getElementById('staffname1').innerHTML = 'APPLICATIONS QUERIED';
 
 
         var inbox_type=$(this).data('inbox');
 
 
         console.log(inbox_type);
 
         
      
         $.ajax({
             type : "POST",
             url : "request_monitoring_dashboard",
             data : {
                 request_type : 'select_staff_apps_with_officers_request_withinuni',
                 unit_id: unit_id,
                 inbox_type:inbox_type
             },
             cache: false,
             success: function(response) {
          
                 var json_result = JSON.parse(response);
  
                 console.log(json_result)
  
      
                 if (json_result.apps_at_division == null){
      
                  let dataSet4 = [];
                  let num4 = 0;
               
                $('#view_applications_incoming_with_monitoring_unit_table').DataTable().clear().destroy();
      
                  // console.log("data not found");       
                  alert('Sorry Data Not Found');
      
      }else {
      
        let dataSet4 = [];
        let num4 = 0;
      
      $('#view_applications_incoming_with_monitoring_unit_table').DataTable().clear().destroy();
       
      
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num4 = +num4 + 1;
      
          let job_number = json_result.apps_at_division[i].job_number;
          let ar_name = json_result.apps_at_division[i].ar_name;
          let business_process_name = json_result.apps_at_division[i].business_process_name;
          let created_on = json_result.apps_at_division[i].created_on;
          let job_status = json_result.apps_at_division[i].job_status;
          let job_purpose = json_result.apps_at_division[i].job_purpose;
  
  
                  
   var startDate = json_result.apps_at_division[i].job_datesend;
   startDate = new Date(startDate.replace(/-/g, "/")); // Convert the start date string to Date object
   
   var endDate = "", noOfDaysToAdd = 10, count = 0;
   while (count < noOfDaysToAdd) {
       endDate = new Date(startDate.setDate(startDate.getDate() + 1));
       if (endDate.getDay() != 0 && endDate.getDay() != 6) { 
           // Skip weekends (Sunday = 0, Saturday = 6)
           count++;
       }
   }
   
   // Format the final end date (nxt_date) to MM/DD/YYYY
   var nxt_date = '';
   var datex = new Date(endDate);
   let day = datex.getDate();
   let month = (datex.getMonth() + 1); // Months are zero-based, so +1
   let year = datex.getFullYear();
   nxt_date = `${month}/${day}/${year}`; // Format as MM/DD/YYYY
   
   // Calculate the number of days between today and nxt_date
   var today = new Date().toJSON().slice(0, 10).replace(/-/g, '/'); // Today's date in MM/DD/YYYY format
   var date1 = new Date(today);
   var date2 = new Date(nxt_date);
   
   // Calculate the difference in days (taking care of the calculation)
   var diffDays = Math.floor((date2 - date1) / (1000 * 60 * 60 * 24), 10); // Number of milliseconds in a day
   var reminder = diffDays;
   
   // Display the reminder badge based on days remaining or passed
   var display_reminder = '';
   if (reminder <= 0) {
       // Negative or zero days means the date has passed
       var newStr = Math.abs(reminder).toString(); // Absolute value of days passed
       display_reminder = `<label class="badge badge-danger">${newStr} Day(s) Passed</label>`;
   } else {
       // Positive days remaining
       display_reminder = `<label class="badge badge-success">${reminder} Day(s) Left</label>`;
   }
  
   
  
          
  
   let action = `<div class="btn-group" role="group">
      <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Actions
      </button>
      <div class="dropdown-menu">
         
  
      <button data-staff='${json_result.apps_at_division[i].job_recieved_by}' data-staff_id='${json_result.apps_at_division[i].job_recieved_by_id}' data-job-number='${json_result.apps_at_division[i].job_number}' class="sendMessage dropdown-item" type="button">Send Message <i class="fas fa-comment-alt"></i></button>
      </div>
  </div>            
   `;
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
          html.push(created_on);
          html.push(job_number);
          html.push(ar_name);
          html.push(business_process_name);
          html.push(job_status);
          html.push(job_purpose);
          html.push(display_reminder);
          html.push(action);
         
      
          dataSet4.push(html);
      
        //console.log(dataSet)
        }
      
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
      
        $('#view_applications_incoming_with_monitoring_unit_table').DataTable().clear().destroy();
                      
        $('#view_applications_incoming_with_monitoring_unit_table').DataTable({ data: dataSet4,
          dom : 'Bfrtip',
          lengthMenu : [
              [ 10, 25, 50, -1 ],
              [ '10 rows', '25 rows',
                  '50 rows', 'Show all' ] ],
          buttons : [ 'pageLength', 'copy',
              'csv', 'excel', 'pdf', 'print' ] }).draw();
      
      }
                // console.log(json_result)
      
                
      
      
             }
         })
  
         }
 
 
  
  
     })
 
     
 
     
 
 })