$(document).ready(function() {
    var plan_submitted;
    var user_unit = $('#user_unit').val();
    var unit_name = $('#unit_name').val();

    var regionalcode = $('#region_id').val();


    // const surveyorName = selectedOption.getAttribute('data-name') || 'STAMPING UNIT';



    
  
    //   const selectedOption = $('#licensed_select').find(':selected');
  
    //   // Retrieve the data-name attribute of the selected option
    //   const surveyorName = selectedOption.data('name') || 'All Surveyors';
  
    //   // Set the surveyorName value in the #survey_select input
    //   $('#survey_select').val(surveyorName);
  
  
  
  
    flatpickr("#datefrom", {
        dateFormat: "Y-m-d", // Internal value format (YYYY-MM-DD)
        altInput: true, // Enables an alternative input field for display
        altFormat: "j F Y", // Display format (e.g., "1 February 2025")
        allowInput: true, // Allows manual input
        onClose: function(selectedDates, dateStr, instance) {
            let formattedDate = instance.formatDate(selectedDates[0], "j F Y"); // Format in "1 February 2025"
            
            console.log("Selected date (YYYY-MM-DD):", dateStr); 
            console.log("Selected date (j F Y):", formattedDate); 
    
            $('#start_date').val(dateStr);

            $('#startdate').val(formattedDate);

        }
    });
    
    
    
    
    flatpickr("#dateto", {
        dateFormat: "Y-m-d", // Internal value format (YYYY-MM-DD)
        altInput: true, // Enables an alternative input field for display
        altFormat: "j F Y", // Display format (e.g., "1 February 2025")
        allowInput: true, // Allows manual input
        onClose: function(selectedDates, dateStr, instance) {
            let formattedDate = instance.formatDate(selectedDates[0], "j F Y"); // Format in "1 February 2025"
            console.log("Selected date:", dateStr); // Logs in YYYY-MM-DD format
            $('#end_date').val(dateStr);


            $('#enddate').val(formattedDate);


    
        }
    });
  



    $(document).ready(function() {
      




        // $.ajax({
        //     type : "POST",
        //     url : "app_modal_fills_serv",
        //     data : {
        //         request_type : 'get_all_office_region',
        //     },
        //     cache : false,
        //     beforeSend : function() {
        //         // $('#district').html('<img
        //         // src="img/loading.gif"
        //         // alt="" width="24"
        //         // height="24">');
        //     },
        //     success : function(
        //             jobdetails) {
    
        //         // console.log(jobdetails);
        //         var json_p = JSON
        //                 .parse(jobdetails);
        //         var options = $("#ur_district");
    
        //         // var options =
        //         // $("#selector");
        //         options.empty();
        //         options
        //                 .append(new Option(
        //                         "-- Select --",
        //                         0));
    
        //         $(json_p)
        //                 .each(
        //                         function() {
    
        //                             // console.log(select_id);
        //                             // console.log(this.business_process_id);
    
        //                             // if
        //                             // (main_service_id
        //                             // ==this.business_process_id){
        //                             $(
        //                                     '#ur_district')
        //                                     .append(
        //                                             '<option value="'
        //                                                     + this.ord_region_code
                                                        
        //                                                     + '">'
        //                                                     + this.ord_region_name
        //                                                     + '</option>');
    
        //                             // }
    
        //                         });
        //         // business_process_id
    
        //         $("#ur_district").val($(event.relatedTarget).data('regional_code'));
    
                
        //     }
        // });





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
    






       
            // On change of Division dropdown
            $('#ur_division').change(function () {
                var selected_division = $(this).val(); // Get selected division
                var office_id = $("#ur_district").val(); // Get selected district
        
                // Clear the selected department & unit dropdown
                $("#ur_department").val("");
                $("#ur_units").empty().append('<option value="">Select</option>'); // Clear previous units
        
                // First AJAX to get units
                $.ajax({
                    type: "POST",
                    url: "Case_Management_Serv",
                    data: {
                        request_type: 'get_lc_list_of_units',
                        office_id: office_id
                    },
                    cache: false,
                    success: function (jobdetails) {
                        var json_p = JSON.parse(jobdetails);
                        var unitSelect = $("#ur_units");
        
                        // Populate the units dropdown
                        json_p.data.forEach(function (unit) {
                            if (unit.unit_division.includes(selected_division)) {
                                unitSelect.append(`
                                    <option data-name="${unit.unit_name}" data-id="${unit.unit_id}" value="${unit.unit_id}">
                                        ${unit.unit_name}
                                    </option>
                                `);
                            }
                        });
                    }
                });
            });
        
            // On change of Units dropdown
            $('#ur_units').change(function () {
                var unitid = $(this).val(); // Get selected unit ID
                var unit_name = $("#ur_units option:selected").data("name"); // Get selected unit name
        
                // Clear previous users
                $("#by_batched").empty();
        
                // Append selected unit as the first option
                $("#by_batched").append(`
                    <option data-name="${unit_name}" data-id="${unitid}" value="${unitid}">
                        ${unit_name} (Unit)
                    </option>
                `);
        
                // Second AJAX to get users in the selected unit
                $.ajax({
                    type: "POST",
                    url: "reports_api",
                    data: {
                        request_type: 'general_user_in_unit',
                        unitid: unitid
                    },
                    cache: false,
                    success: function (response) {
                        var json_result = JSON.parse(response);
                        var userSelect = $("#by_batched");
        
                        // Populate the user dropdown
                        json_result.apps_at_division.forEach(user => {
                            userSelect.append(`
                                <option value="${user.userid}" data-name="${user.fullname}">
                                    ${user.fullname}
                                </option>
                            `);
                        });
        
                        // Auto-select the first user if available
                        if (json_result.apps_at_division.length > 0) {
                            let firstUser = json_result.apps_at_division[0];
                            $('#by_batched').val(firstUser.userid);
                        }
        
                        // Update input field with unit name
                        $('#select-user').val(unit_name);
                    },
                    error: function (xhr, status, error) {
                        console.error("Error fetching data:", error);
                    }
                });
            });
 


        


        // var by_batched_id = $('#by_batched').val();



        // $.ajax({
        //     type: "POST",
        //     url: "reports_api",
        //     data: { 
        //         request_type: 'general_user_in_unit',
        //         unitid: by_batched_id
        //     },
        //     cache: false,
        //     success: function(response) {
        //         var json_result = JSON.parse(response);
    
        //         // Clear previous options except the first empty one
        //         $("#by_batched").empty().append(`
        //             // <option value="${user_unit}">${unit_name}</option>
        //         `);
    
        //         // Append new options from AJAX response
        //         json_result.apps_at_division.forEach(user => {
        //             $("#by_batched").append(`
        //                 <option value="${user.userid}" data-name="${user.fullname}" >${user.fullname}</option>
        //             `);
        //         });
    
        //         // Ensure selectpicker works if using Bootstrap Select
        //         // $("#by_batched").selectpicker("refresh");
        //         // $('#select-user').val(firstUser.fullname); // Set input field value
        //         let firstUser = json_result.apps_at_division[0]; // Get the first user
        //         // $('#by_batched').val(firstUser.userid); // Set dropdown value
        //         $('#select-user').val(unit_name); // Set input field value


        //     },
        //     error: function(xhr, status, error) {
        //         console.error("Error fetching data:", error);
        //     }
        // });

        




        
    

           


    });



    
  
  
  
   
      // $(function() {
      //   var datepicker = $('input[name="daterange"]').daterangepicker({
      //     opens: 'left',
      //     autoUpdateInput: false, // Prevent auto-filling to allow manual input
      //     locale: {
      //       format: 'YYYY-MM-DD'
      //     }
      //   });
      
      //   // Update input when date is selected from the dropdown
      //   datepicker.on('apply.daterangepicker', function(ev, picker) {
      //     $(this).val(picker.startDate.format('YYYY-MM-DD') + ' to ' + picker.endDate.format('YYYY-MM-DD'));
      //   });
      
      //   // Allow manual input and update the datepicker when user types a date
      //   $('#daterange').on('change', function() {
      //     var dates = $(this).val().split(' to ');
      //     var start = moment(dates[0], 'YYYY-MM-DD', true);
      //     var end = moment(dates[1], 'YYYY-MM-DD', true);
      
      //     if (start.isValid() && end.isValid() && start.isSameOrBefore(end)) {
      //       datepicker.data('daterangepicker').setStartDate(start);
      //       datepicker.data('daterangepicker').setEndDate(end);
  
      //       $('#start_date').val(datepicker.data('daterangepicker').startDate.format('YYYY-MM-DD'));
      //         $('#end_date').val(datepicker.data('daterangepicker').endDate.format('YYYY-MM-DD'));
  
              
      //     } else {
      //       // alert("Invalid date range! Please enter a valid range.");
      //       $(this).val(''); // Clear input if invalid
            
      //     }
      //   });
      // });
  
  
  
  
    //   $(function() {
    //     // Set default date range to "Today"
    //     var start = moment();
    //     var end = moment();
    
    //     // Callback function to update the display
    //     function cb(start, end) {
    //         $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    //         $('#start_date').val(start.format('YYYY-MM-DD'));
    //         $('#end_date').val(end.format('YYYY-MM-DD'));
    //     }
    
    //     // Initialize the date range picker
    //     var datepicker = $('#reportrange').daterangepicker({
    //         startDate: start,
    //         endDate: end,
    //         ranges: {
    //             'Today': [moment(), moment()],
    //             'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
    //             'Last 7 Days': [moment().subtract(6, 'days'), moment()],
    //             'Last 30 Days': [moment().subtract(29, 'days'), moment()],
    //             'This Month': [moment().startOf('month'), moment().endOf('month')],
    //             'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
    //         },
    //         locale: {
    //             format: 'YYYY-MM-DD',
    //         },
    //         opens: 'left',
    //         drops: 'down',
    //         showDropdowns: true,
    //         minDate: '2000-01-01',
    //         maxDate: moment(),
    //         autoUpdateInput: true, // Allow manual typing
    //         maxYear: moment().year(),
    //     }, function(start, end) {
    //         cb(start, end);
    //     });
    
    //     // Trigger the callback to display the initial range
    //     cb(start, end);
    
    //     // **Enable manual input changes**
    //     $('#start_date, #end_date').on('change', function() {
    //         let manualStart = moment($('#start_date').val(), 'YYYY-MM-DD', true);
    //         let manualEnd = moment($('#end_date').val(), 'YYYY-MM-DD', true);
    
    //         // Validate the entered dates
    //         if (manualStart.isValid() && manualEnd.isValid() && manualStart.isSameOrBefore(manualEnd)) {
    //             datepicker.data('daterangepicker').setStartDate(manualStart);
    //             datepicker.data('daterangepicker').setEndDate(manualEnd);
    //             cb(manualStart, manualEnd);
    //         } else {
    //             alert("Invalid date range! Please enter a valid date range.");
    //             // Reset to previous valid date if input is incorrect
    //             $('#start_date').val(datepicker.data('daterangepicker').startDate.format('YYYY-MM-DD'));
    //             $('#end_date').val(datepicker.data('daterangepicker').endDate.format('YYYY-MM-DD'));
    //         }
    //     });
    // });
  
  
      $('#reportrange').on('apply.daterangepicker', function(ev, picker) {
          
  
          $('#start_date').val(picker.startDate.format('YYYY-MM-DD'));
          $('#end_date').val(picker.endDate.format('YYYY-MM-DD'));
  
      });
  
  
      $('#by_batched').change(function(){
          // console.log("selection made " + $(this).val() );
          const selectedOption = this.options[this.selectedIndex];
  
  
           surveyorName = selectedOption.getAttribute('data-name') || 'STAMPING UNIT';
  
  
                        $('#select-user').val(surveyorName);
      })
      
  
  
      $('#btn_generate_details_reports_new').click(function(e){
          e.preventDefault();

      
          
          var user_id = $('#by_batched').val();
          var type_of_report_name = $('#type_of_report_name').val();
          var start_date = $('#start_date').val();
          var end_date = $('#end_date').val();
          var user_division = $('#user_division').val();
          var region_code = $('#region_id').val();



          var startdate = $('#startdate').val().toUpperCase();
          var enddate = $('#enddate').val().toUpperCase();




          var type_of_report_upper = type_of_report_name.toUpperCase();


          var name = $('#select-user').val();

          
  
        //   regional_code = Math.trunc(region_cod);
  
  
          var surveyyy_by = $('#survey_select').val();
  
  
  
  
      // document.getElementById('reportheading').innerHTML = start_date;
  
      
           
           console.log(user_id,type_of_report_name,start_date,end_date,region_code);
  
  
           if(type_of_report_name !='' && start_date !='' && end_date !=''){
  
  
  
  
          //  if ($('#search_bill_number').parsley().isValid()) {
  
          //     // alert('Are you sure you want to save instrument?') 
          
          e.preventDefault();
          // fields validation
            $.ajax({
              type : "POST",
              url : "reports_api",
              data : {
                  request_type : 'report_on_smd_cartogis',
                  application_status : type_of_report_name,
                  date_from : start_date,
                  date_to : end_date,
                  userid:user_id,
                  regionid :region_code
  
              },
              cache: false,
            beforeSend:function(){  
              $(this).prop('disabled', false);
           $('#btn_generate_details_reports_new').text("Loading...Please Wait").prop("disabled",true); 
            },
            success:function(response){ 
  
  
              json_result = JSON.parse(response);
           
            console.log(json_result);
  
  
            if (json_result.data == null){
  
              alert('We couldn\'t find any results matching your search criteria. Please review your filters or try again later.');
  
              $('#btn_generate_details_reports_new')
          .prop("disabled", false)
          .html(`<i class="fas fa-chart-line fa-sm text-white-50"></i>Generate Report`);
  
            }else if (json_result.data != null && type_of_report_name == 'Received'){
  
  
              document.getElementById('reportheading2').innerHTML ='REPORT ON ' + ' ' + type_of_report_upper+ ' ' + "APPLICATIONS" + ' ' + 'BETWEEN '+' '+startdate+ ' ' + 'TO'+ ' ' + enddate + ' ' + 'BY' + ' ' + name;
  
  
              // document.getElementById('reportheading2').innerHTML ='Report On' + ' ' + type_of_report_name+ ' ' + business_process_sub_name + ' ' + 'From '+' '+start_date+ ' ' + 'to'+ ' ' + end_date + ' ' + 'for' + ' ' + surveyyy_by;
  
              // document.getElementById('reportheading2').innerHTML ='Report On' + ' ' + type_of_report_name+ ' ' + 'Plan Approval Applications From '+' '+start_date+ ' ' + 'to'+ ' ' + end_date + ' ' + 'for' + ' ' + surveyyy_by;
  
  
              $("#other_reporting_modal").modal("show");  
  
              $('#btn_generate_details_reports_new')
          .prop("disabled", false)
          .html(`<i class="fas fa-chart-line fa-sm text-white-50"></i>Generate Report`);
  
  
  
  
              let dataSet1 = [];
              let num1 = 0;
       
            $('#other_reporting_table').DataTable().clear().destroy();


          


      
      
      
              for(let i=0; i<json_result.data.length; i++) {
                  let html = [];
                  num1 = +num1 + 1;
                  let ar_name = json_result.data[i].ar_name;
                  let job_number = json_result.data[i].job_number;
                  let business_process_sub_name = json_result.data[i].business_process_sub_name;

                  let receiver_name = json_result.data[i].receiver_name;
                  let date_created = json_result.data[i].date_created;
                  let job_purpose = json_result.data[i].job_purpose;
                  let action = `<div class="btn-group" role="group">
   <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
     Actions
   </button>
   <div class="dropdown-menu">
    <button type="button" class="dropdown-item" href="#" id="btn_cabinet" data-staff_name="" data-staff_id="" data-job_number="" title="View Application Progress" data-target-id="${json_result.data[i].job_number}" data-target="#cabinetModal" data-toggle="modal">Track <i class="fas fa-hdd"></i></button>
   <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
           <input type="hidden" name="case_number" id="case_number" value="${json_result.data[i].job_number}">
           <input type="hidden" name="search_text" id="search_text" value="${json_result.data[i].case_number}">
           <input type="hidden" name="job_number" id="job_number" value=""${json_result.data[i].job_number}">
           <input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value=""${json_result.data[i].case_number}">
           <button type="submit" name="save" class="dropdown-item" >Application Details <i class="fas fa-info-circle"></i></button>
         </form> 
   </div>
 </div`;
                
  
        
                  
                  html.push(ar_name);
                  html.push(job_number);
                  html.push(business_process_sub_name);
                  html.push(receiver_name);
                  html.push(date_created);
                  html.push(job_purpose);
                  html.push(action);

                  
      
               
                  // html.push(action);
                  // html.push(payment_status);
                  // html.push(buttons);
      
                  dataSet1.push(html);
      
                //console.log(dataSet)
                }
      
              // let dataTable_Obj = $('#recievedtoday').DataTable({
              //     data: dataSet1
              //   })
      
                $('#other_reporting_table').DataTable().clear().destroy();


                document.getElementById('reportheading2').innerHTML ='REPORT ON ' + ' ' + type_of_report_upper+ ' ' + "APPLICATIONS" + ' ' + 'BETWEEN '+' '+startdate+ ' ' + 'TO'+ ' ' + enddate + ' ' + 'BY' + ' ' + name;


  
  
                $('#other_reporting_table').DataTable({ data: dataSet1,
                  dom : 'Bfrtip',
                                lengthMenu : [
                                    [ 10, 25, 50, -1 ],
                                    [ '10 rows', '25 rows',
                                        '50 rows', 'Show all' ] ],
  
                                        buttons: [
                                          'pageLength', // Default page length button
                                          'copy',       // Default copy button
                                          {
                                              extend: 'csv',
                                              title: `REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}`,
                                              filename: `Report_On_${type_of_report_upper}_APPLICATIONS_BETWEEN_${startdate}_to_${enddate}_BY_${name.replace(/\s+/g, '_')}`
                                          },
                                          {
                                              extend: 'excel',
                                              title: `REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}`,
                                              filename: `Report_On_${type_of_report_upper}_APPLICATIONS_BETWEEN_${startdate}_to_${enddate}_BY_${name.replace(/\s+/g, '_')}`
                                          },
                                          {
                                              extend: 'pdf',
                                              title: `REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}`,
                                              filename: `Report_On_${type_of_report_upper}_APPLICATIONS_BETWEEN_${startdate}_to_${enddate}_BY_${name.replace(/\s+/g, '_')}`
                                          },
                                          {
                                              extend: 'print',
                                              title: `<h3>REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}</h3>`,
                                              message: 'This report is generated using LC ELIS'
                                          }
                                      ],
                                      pageLength: 10, // Default rows displayed
  
  
                              //   buttons : [ 'pageLength', 'copy',
                              //       'csv', 'excel', 'pdf', 'print' ] 
                }).draw();
              
  
            } else {

                document.getElementById('reportheading').innerHTML ='REPORT ON ' + ' ' + type_of_report_upper+ ' ' + "APPLICATIONS" + ' ' + 'BETWEEN '+' '+startdate+ ' ' + 'TO'+ ' ' + enddate + ' ' + 'BY' + ' ' + name;

  
  
                // document.getElementById('reportheading2').innerHTML ='Report On' + ' ' + type_of_report_name+ ' ' + business_process_sub_name + ' ' + 'From '+' '+start_date+ ' ' + 'to'+ ' ' + end_date + ' ' + 'for' + ' ' + surveyyy_by;
    
                // document.getElementById('reportheading2').innerHTML ='Report On' + ' ' + type_of_report_name+ ' ' + 'Plan Approval Applications From '+' '+start_date+ ' ' + 'to'+ ' ' + end_date + ' ' + 'for' + ' ' + surveyyy_by;
    
    
                $("#reporting_modal").modal("show");  
    
                $('#btn_generate_details_reports_new')
            .prop("disabled", false)
            .html(`<i class="fas fa-chart-line fa-sm text-white-50"></i>Generate Report`);
    
    
    
    
                let dataSet1 = [];
                let num1 = 0;
         
              $('#reporting_table').DataTable().clear().destroy();
  
  
            
  
  
        
        
        
                for(let i=0; i<json_result.data.length; i++) {
                    let html = [];
                    num1 = +num1 + 1;
                    let ar_name = json_result.data[i].ar_name;
                    let job_number = json_result.data[i].job_number;
                    let business_process_sub_name = json_result.data[i].business_process_sub_name;
  
                    let officers_general_comments = json_result.data[i].officers_general_comments;
                    let date_created = json_result.data[i].date_created;
                    let job_purpose = json_result.data[i].job_purpose;
                    let action = `<div class="btn-group" role="group">
   <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
     Actions
   </button>
   <div class="dropdown-menu">
 <button type="button" class="dropdown-item" href="#" id="btn_cabinet" data-staff_name="" data-staff_id="" data-job_number="" title="View Application Progress" data-target-id="${json_result.data[i].job_number}" data-target="#cabinetModal" data-toggle="modal">Track <i class="fas fa-hdd"></i></button>
   <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
           <input type="hidden" name="case_number" id="case_number" value="${json_result.data[i].job_number}">
           <input type="hidden" name="search_text" id="search_text" value="${json_result.data[i].case_number}">
           <input type="hidden" name="job_number" id="job_number" value=""${json_result.data[i].job_number}">
           <input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value=""${json_result.data[i].case_number}">
           <button type="submit" name="save" class="dropdown-item" >Application Details <i class="fas fa-info-circle"></i></button>
         </form> 
   </div>
 </div`;
                  
    
          
                    
                    html.push(ar_name);
                    html.push(job_number);
                    html.push(business_process_sub_name);
                    html.push(officers_general_comments);
                    html.push(date_created);
                    html.push(job_purpose);
                    html.push(action);

                    
        
                 
                    
                    // html.push(payment_status);
                    // html.push(buttons);
        
                    dataSet1.push(html);
        
                  //console.log(dataSet)
                  }
        
                // let dataTable_Obj = $('#recievedtoday').DataTable({
                //     data: dataSet1
                //   })
        
                  $('#reporting_table').DataTable().clear().destroy();
    
    
                  $('#reporting_table').DataTable({ data: dataSet1,
                    dom : 'Bfrtip',
                                  lengthMenu : [
                                      [ 10, 25, 50, -1 ],
                                      [ '10 rows', '25 rows',
                                          '50 rows', 'Show all' ] ],
    
                                          buttons: [
                                            'pageLength', // Default page length button
                                            'copy',       // Default copy button
                                            {
                                                extend: 'csv',
                                                title: `REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}`,
                                                filename: `Report_On_${type_of_report_upper}_APPLICATIONS_BETWEEN_${startdate}_to_${enddate}_BY_${name.replace(/\s+/g, '_')}`
                                            },
                                            {
                                                extend: 'excel',
                                                title: `REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}`,
                                                filename: `Report_On_${type_of_report_upper}_APPLICATIONS_BETWEEN_${startdate}_to_${enddate}_BY_${name.replace(/\s+/g, '_')}`
                                            },
                                            {
                                                extend: 'pdf',
                                                title: `REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}`,
                                                filename: `Report_On_${type_of_report_upper}_APPLICATIONS_BETWEEN_${startdate}_to_${enddate}_BY_${name.replace(/\s+/g, '_')}`
                                            },
                                            {
                                                extend: 'print',
                                                title: `<h3>REPORT ON ${type_of_report_upper} APPLICATIONS  BETWEEN ${startdate} to ${enddate} BY ${name}</h3>`,
                                                message: 'This report is generated using LC ELIS'
                                            }
                                        ],
                                        pageLength: 10, // Default rows displayed
    
    
                                //   buttons : [ 'pageLength', 'copy',
                                //       'csv', 'excel', 'pdf', 'print' ] 
                  }).draw();
                





            }
  
             
            } 
  
            });
  
  
  
  
  
           }else {
  
  
            alert('Sorry!. All Fields Required');
  
           }
  
  
  
  
      
  
        });




        $('#cabinetModal')
.on(
    'show.bs.modal',
    function(event) {
      var job_number = $(event.relatedTarget)
          .data('target-id') // Extract
      // info from
      // data-*
      // attributes
      var table = $('#cabinet-tracking');
      table.find("tbody tr").remove();

      $("#enq_applicant_name").val("");
      $("#enq_applicant_type").val("");
      $("#enq_cabinet_name").val("");
      // $("#enq_job_purpose").val(this.job_purpose);
      $("#enq_job_status").val("");

      console.log(job_number);

      $
          .ajax({
            type : "POST",
            url : "Case_Management_Serv",
            data : {
              request_type : 'load_application_cabinet_details_by_job_number',
              job_number : job_number
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

              // console.log();
              $(
                  json_p.cabinet_tracking)
                  .each(
                      function() {

                        table
                            .append("<tr><td>"
                                + this.officers_general_comments
                                + "</td><td>"
                                + this.division
                                + "</td><td>"
                                + this.created_by
                                + "</td><td>"
                                + this.created_date
                                + '</tr>');

                      });

              $(json_p.cabinet_data)
                  .each(
                      function() {

                        $(
                            "#enq_applicant_name")
                            .val(
                                this.ar_name);
                        $(
                            "#enq_applicant_type")
                            .val(
                                this.business_process_sub_name);
                        $(
                            "#enq_cabinet_name")
                            .val(
                                this.file_number);
                        $(
                            "#enq_job_purpose")
                            .val(
                                this.job_purpose);
                        $(
                            "#enq_job_status")
                            .val(
                                this.job_status);

                        $(
                            "#enq_current_application_status")
                            .val(
                                this.current_application_status);

                      });

            }
          });

    });




  
     
  
    });
  
  