$(document).ready(function() {
  var plan_submitted;

    const selectedOption = $('#licensed_select').find(':selected');

    // Retrieve the data-name attribute of the selected option
    const surveyorName = selectedOption.data('name') || 'All Surveyors';

    // Set the surveyorName value in the #survey_select input
    $('#survey_select').val(surveyorName);




    flatpickr("#datefrom", {
      dateFormat: "Y-m-d", // Internal value format (YYYY-MM-DD)
      altInput: true, // Enables an alternative input field for display
      altFormat: "j F Y", // Display format (e.g., "1 February 2025")
      allowInput: true, // Allows manual input
      onClose: function(selectedDates, dateStr, instance) {
          console.log("Selected date:", dateStr); // Logs in YYYY-MM-DD format
          $('#start_date').val(dateStr);
  
      }
  });
  
  
  
  
  flatpickr("#dateto", {
      dateFormat: "Y-m-d", // Internal value format (YYYY-MM-DD)
      altInput: true, // Enables an alternative input field for display
      altFormat: "j F Y", // Display format (e.g., "1 February 2025")
      allowInput: true, // Allows manual input
      onClose: function(selectedDates, dateStr, instance) {
          console.log("Selected date:", dateStr); // Logs in YYYY-MM-DD format
          $('#end_date').val(dateStr);
  
      }
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


    $('#licensed_select').change(function(){
        // console.log("selection made " + $(this).val() );
        const selectedOption = this.options[this.selectedIndex];


        const surveyorName = selectedOption.getAttribute('data-name') || 'All Surveyors';


                      $('#survey_select').val(surveyorName);
    })
    


    $('#btn_generate_details_reports_new').click(function(e){
        e.preventDefault();
    
        
        var licensed_select = $('#licensed_select').val();
        var type_of_report_name = $('#type_of_report_name').val();
        var start_date = $('#start_date').val();
        var end_date = $('#end_date').val();
        var region_cod = $('#sel_change_region_compliance').val();
       var business_process_sub_name   = "New";

        regional_code = Math.trunc(region_cod);


        var surveyyy_by = $('#survey_select').val();




    // document.getElementById('reportheading').innerHTML = start_date;

    
         
         console.log(start_date);


         if(licensed_select !='' && type_of_report_name !='' && start_date !='' && end_date !='' && region_cod !='' ){




        //  if ($('#search_bill_number').parsley().isValid()) {

        //     // alert('Are you sure you want to save instrument?') 
        
        e.preventDefault();
        // fields validation
          $.ajax({
            type : "POST",
            url : "reports_api",
            data : {
                request_type : 'report_on_plan_approval2',
                ls_number : licensed_select,
                application_status : type_of_report_name,
                date_from : start_date,
                date_to : end_date,
                region_code : regional_code

            },
            cache: false,
          beforeSend:function(){  
            $(this).prop('disabled', false);
         $('#btn_generate_details_reports_new').text("Loading...Please Wait").prop("disabled",true); 
          },
          success:function(response){ 


            json_result = JSON.parse(response);
         
          console.log(json_result.data);


          if (json_result.data == null){

            alert('We couldn\'t find any results matching your search criteria. Please review your filters or try again later.');

            $('#btn_generate_details_reports_new')
        .prop("disabled", false)
        .html(`<i class="fas fa-chart-line fa-sm text-white-50"></i>Generate Report`);

          }else if (json_result.data != null && type_of_report_name == 'Completed'){





            document.getElementById('reportheading').innerHTML ='Report On' + ' ' + type_of_report_name+ ' ' + "Regional Number | Plan Approval" + ' ' + 'From '+' '+start_date+ ' ' + 'to'+ ' ' + end_date + ' ' + 'for' + ' ' + surveyyy_by;


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
                let case_number = json_result.data[i].case_number;
                let licensed_surveyor_name = json_result.data[i].licensed_surveyor_name;
                let business_process_sub_name = json_result.data[i].business_process_sub_name;
                let regional_number = json_result.data[i].regional_number;
                let locality = json_result.data[i].locality;
                let plansubmitted = json_result.data[i].plan_submitted;

                if (plansubmitted == 'YES'){
                  plan_submitted = `<span class="badge badge-pill badge-success">Plan Approval</span>`;


                }else {
                  plan_submitted = `<span class="badge badge-pill badge-warning">Regional Number</span>`;

                }
                let created_date = json_result.data[i].created_date;
                let job_status = json_result.data[i].job_status;
                let days_completed = json_result.data[i].days_completed;
                let completed_date = json_result.data[i].completed_date;
                let collected_date = json_result.data[i].collected_date;
    
                // let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_daily_officer_apps"  
                // class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
                // let payment_status = e[i].payment_status;
                // let buttons = e[i].buttons;
                
                html.push(ar_name);
                html.push(job_number);
                html.push(case_number);
                html.push(licensed_surveyor_name);
                html.push(business_process_sub_name);
                html.push(regional_number);
                html.push(locality);
                html.push(plan_submitted);
                html.push(created_date);
                html.push(job_status);
                html.push(days_completed);
                html.push(completed_date);
                html.push(collected_date);
    
             
                // html.push(action);
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
                                            title: `Report On ${type_of_report_name} Regional Number | Plan Approval From ${start_date} to ${end_date} for ${surveyyy_by}`,
                                            filename: `Report_On_${type_of_report_name}_Plan_Approval_${start_date}_to_${end_date}_for_${surveyyy_by.replace(/\s+/g, '_')}`
                                        },
                                        {
                                            extend: 'excel',
                                            title: `Report On ${type_of_report_name} Regional Number | Plan Approval From ${start_date} to ${end_date} for ${surveyyy_by}`,
                                            filename: `Report_On_${type_of_report_name}_Plan_Approval_${start_date}_to_${end_date}_for_${surveyyy_by.replace(/\s+/g, '_')}`
                                        },
                                        {
                                            extend: 'pdf',
                                            title: `Report On ${type_of_report_name} Regional Number | Plan Approval From ${start_date} to ${end_date} for ${surveyyy_by}`,
                                            filename: `Report_On_${type_of_report_name}_Plan_Approval_${start_date}_to_${end_date}_for_${surveyyy_by.replace(/\s+/g, '_')}`
                                        },
                                        {
                                            extend: 'print',
                                            title: `<h3>Report On ${type_of_report_name} Regional Number | Plan Approval From ${start_date} to ${end_date} for ${surveyyy_by}</h3>`,
                                            message: 'This report is generated using LC ELIS'
                                        }
                                    ],
                                    pageLength: 10, // Default rows displayed


                            //   buttons : [ 'pageLength', 'copy',
                            //       'csv', 'excel', 'pdf', 'print' ] 
              }).draw();



          }else {


            document.getElementById('reportheading2').innerHTML ='Report On' + ' ' + type_of_report_name+ ' ' + "Regional Number | Plan Approval" + ' ' + 'From '+' '+start_date+ ' ' + 'to'+ ' ' + end_date + ' ' + 'for' + ' ' + surveyyy_by;


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
                let case_number = json_result.data[i].case_number;
                let licensed_surveyor_name = json_result.data[i].licensed_surveyor_name;
                let business_process_sub_name = json_result.data[i].business_process_sub_name;
                let regional_number = json_result.data[i].regional_number;
                let locality = json_result.data[i].locality;
                let plansubmitted = json_result.data[i].plan_submitted;
                if (plansubmitted == 'YES'){
                  plan_submitted = `<span class="badge badge-pill badge-success">Plan Approval</span>`;


                }else {
                  plan_submitted = `<span class="badge badge-pill badge-warning">Regional Number</span>`;

                }


                let created_date = json_result.data[i].created_date;
                let job_status = json_result.data[i].job_status;
                // let days_completed = json_result.data[i].days_completed;
                // let completed_date = json_result.data[i].completed_date;
                // let collected_date = json_result.data[i].collected_date;
    
                // let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_daily_officer_apps"  
                // class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
                // let payment_status = e[i].payment_status;
                // let buttons = e[i].buttons;
                
                html.push(ar_name);
                html.push(job_number);
                html.push(case_number);
                html.push(licensed_surveyor_name);
                html.push(business_process_sub_name);
                html.push(regional_number);
                html.push(locality);
                html.push(plan_submitted);
                html.push(created_date);
                html.push(job_status);
                // html.push(days_completed);
                // html.push(completed_date);
                // html.push(collected_date); 
    
             
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
                                            title: `Report On ${type_of_report_name} Regional Number | Plan Approval From ${start_date} to ${end_date} for ${surveyyy_by}`,
                                            filename: `Report_On_${type_of_report_name}_Plan_Approval_${start_date}_to_${end_date}_for_${surveyyy_by.replace(/\s+/g, '_')}`
                                        },
                                        {
                                            extend: 'excel',
                                            title: `Report On ${type_of_report_name} Regional Number | Plan Approval From ${start_date} to ${end_date} for ${surveyyy_by}`,
                                            filename: `Report_On_${type_of_report_name}_Plan_Approval_${start_date}_to_${end_date}_for_${surveyyy_by.replace(/\s+/g, '_')}`
                                        },
                                        {
                                            extend: 'pdf',
                                            title: `Report On ${type_of_report_name} Regional Number | Plan Approval From ${start_date} to ${end_date} for ${surveyyy_by}`,
                                            filename: `Report_On_${type_of_report_name}_Plan_Approval_${start_date}_to_${end_date}_for_${surveyyy_by.replace(/\s+/g, '_')}`
                                        },
                                        {
                                            extend: 'print',
                                            title: `<h3>Report On ${type_of_report_name} Regional Number | Plan Approval From ${start_date} to ${end_date} for ${surveyyy_by}</h3>`,
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

   

  });

