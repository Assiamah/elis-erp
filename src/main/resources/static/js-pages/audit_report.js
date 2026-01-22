$(document).ready(function() {


    // When the second modal is shown, blur the fullscreen modal
$('#job_numberbill_items').on('show.bs.modal', function () {
    $('#transactions_modal .modal-content').addClass('blur-background');
});

// When the second modal is hidden, remove the blur effect
$('#job_numberbill_items').on('hidden.bs.modal', function () {
    $('#transactions_modal .modal-content').removeClass('blur-background');
});






// When the second modal is shown, blur the fullscreen modal
$('#bill_items').on('show.bs.modal', function () {
    $('#sub_service_modal .modal-content').addClass('blur-background');
});

// When the second modal is hidden, remove the blur effect
$('#bill_items').on('hidden.bs.modal', function () {
    $('#sub_service_modal .modal-content').removeClass('blur-background');
});


// When the second modal is shown, blur the fullscreen modal
$('#bill_items_new').on('show.bs.modal', function () {
    $('#sub_service_modal .modal-content').addClass('blur-background');
});

// When the second modal is hidden, remove the blur effect
$('#bill_items_new').on('hidden.bs.modal', function () {
    $('#sub_service_modal .modal-content').removeClass('blur-background');
});






// When the second modal is shown, blur the fullscreen modal
$('#bill_items_regional_modal').on('show.bs.modal', function () {
    $('#bill_items .modal-content').addClass('blur-background');
});

// When the second modal is hidden, remove the blur effect
$('#bill_items_regional_modal').on('hidden.bs.modal', function () {
    $('#bill_items .modal-content').removeClass('blur-background');
});











// sub_service_modal




    const selectedOption = $('#sel_change_region_compliance').find(':selected');

    // Retrieve the data-name attribute of the selected option
    const surveyorName = selectedOption.data('name') || 'Nationwide';

    // Set the surveyorName value in the #survey_select input
    $('#region_select').val(surveyorName);




    let code = 0;
    let startDate;
    let endDate;

    let upperCaseVariable;


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

        $('#sel_change_region_compliance').val('-1');

    
        }
    });



    // $(function() {
    //     // Set the default date range to "Today"
    //     var start = moment();
    //     var end = moment();
      
    //     // Callback function to update the date range display
    //     function cb(start, end) {
    //         $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    //     }
      
    //     // Initialize the date range picker
    //     $('#reportrange').daterangepicker({
    //         startDate: moment(),
    //         endDate: moment(),
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
    //         opens: 'left', // Adjust dropdown open position (optional)
    //         drops: 'down', // Dropdown position (optional)
    //         showDropdowns: true, // Enable month and year selection via dropdowns
    //         minDate: '2000-01-01', // Set the minimum date to Jan 1, 2000
    //         maxDate: moment(), // Set the max date to the current date
    //         autoUpdateInput: false, // Prevent automatic update in the input field
    //         maxYear: moment().year(), // Allow selecting up to the current year
    //     }, function(start, end, label) {
    //         // Update the label manually when a custom date is selected
    //         cb(start, end);
            
    //         // Log the selected date range (for debugging)
    //         console.log("Selected date range: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));

    //         $('#start_date').val(start.format('YYYY-MM-DD'));
    //         $('#end_date').val(end.format('YYYY-MM-DD'));

    //         // Reset the "sel_change_region_compliance" dropdown
    //         $('#sel_change_region_compliance').val('-1');

    //     });
      
    //     // Trigger the callback to display the initial "Today" range
    //     cb(start, end);
      
    //     // Log the selected start and end dates (for debugging)
    //     console.log('Start Date: ', start.format('YYYY-MM-DD'));
    //     console.log('End Date: ', end.format('YYYY-MM-DD'));
      
    //     // Set the input fields to today's date
    //     $('#start_date').val(start.format('YYYY-MM-DD'));
    //     $('#end_date').val(end.format('YYYY-MM-DD'));


        
    // });


    



    $.ajax({
        type: 'POST',
        url: 'audit_reporting',
        data : {
                    request_type : 'audit_report_count_on_payments',
                    regional_code : code,
                    start_date: startDate,
                    end_date : endDate

                },
        success: function(server_response){


            var jsonresult = JSON.parse(server_response)
              
             console.log(jsonresult)

              let total_count = jsonresult.total_count;
            //   let total_amount = 'GHS'+ ' ' +  jsonresult.total_amount;

              let total_amount = new Intl.NumberFormat('en-US', {
                style: 'currency',
                currency: 'GHS', // Sets the currency to GHS
                minimumFractionDigits: 2, // Ensures 2 decimal places
            }).format(jsonresult.total_amount);
            
            // Set the formatted amount to the element
            document.getElementById('total_revenue').innerHTML = total_amount;


           
              document.getElementById('total_transactions').innerHTML = total_count;
              document.getElementById('total_revenue').innerHTML = total_amount;



        }
    })







    $('#sel_change_region_compliance').change(function(){


        const selectedOption = this.options[this.selectedIndex];


        const surveyorName = selectedOption.getAttribute('data-name') || 'Nationwide';


        upperCaseVariable = surveyorName.toUpperCase();



        console.log(surveyorName);


       $('#region_select').val(surveyorName);




        var level = $(this).val();
        code = Math.trunc(level); // 3

        startDate = $('#start_date').val();
        endDate = $('#end_date').val();
   
        console.log(code);



        $.ajax({
            type: 'POST',
            url: 'audit_reporting',
            data : {
                        request_type : 'audit_report_count_on_payments',
                        regional_code : code,
                        start_date: startDate,
                        end_date : endDate
                    },
            success: function(server_response){
    
    
                var jsonresult = JSON.parse(server_response)
                  
                 console.log(jsonresult)
    
                  let total_count = jsonresult.total_count;
                //   let total_amount = 'GHS'+ ' ' +  jsonresult.total_amount;
    
                  let total_amount = new Intl.NumberFormat('en-US', {
                    style: 'currency',
                    currency: 'GHS', // Sets the currency to GHS
                    minimumFractionDigits: 2, // Ensures 2 decimal places
                }).format(jsonresult.total_amount);
                
                // Set the formatted amount to the element
                document.getElementById('total_revenue').innerHTML = total_amount;
    
    
               
                  document.getElementById('total_transactions').innerHTML = total_count;
                  document.getElementById('total_revenue').innerHTML = total_amount;
    
    
    
            }
        })




    })


    

  




    $('#totalrevenue').on('click', function(e) {
        e.preventDefault();
  
     $("#sub_service_modal").modal("show");  
  
        
  
     var title  = upperCaseVariable+ " " + "TOTAL REVENUE BY SERVICES" + "  " + "BETWEEN"+" " + startDate+ " "+ "AND " + endDate ;
          
     document.getElementById('sub_service_modalLabel').innerHTML = title;


           
     let dataSet11 = [];
     let num11 = 0;
    
    $('#sub_service_table').DataTable().clear().destroy();
    
     $.ajax({
        type : "POST",
        url : "audit_reporting",
        data : {
            request_type : 'audit_report_on_subservices',
             regional_code : code,
             start_date: startDate,
             end_date : endDate
         },
         cache: false,
         success: function(response) {
    
      //    console.log(response)
    
             var json_result = JSON.parse(response);
            console.log(json_result)
    
             if (json_result.apps_at_division == null){
    
              console.log("data not found");       
    
    }else {
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num11 = +num11 + 1;
    
        let business_process_sub_name = json_result.apps_at_division[i].business_process_sub_name;

        let total_bill_amount = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'GHS', // Sets the currency to GHS
            minimumFractionDigits: 2, // Ensures 2 decimal places
        }).format(json_result.apps_at_division[i].total_bill_amount);
        let record_count = json_result.apps_at_division[i].record_count;
         let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].business_process_sub_id}" data-name_full="${json_result.apps_at_division[i].business_process_sub_name}" data-total_sum="${total_bill_amount}" id="view_bill_items"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
        
    
      
        html.push(business_process_sub_name);
        html.push(total_bill_amount);
        html.push(record_count);
        html.push(action);
       
       
    
        dataSet11.push(html);
    
      
      }
   
      $('#sub_service_table').DataTable().clear().destroy();

      $('#sub_service_table').DataTable({
        data: dataSet11,
        dom: 'Bfrtip',
        lengthMenu: [
            [10, 25, 50, -1],
            ['10 rows', '25 rows', '50 rows', 'Show all']
        ],
        buttons: [
            'pageLength', // Default page length button
            'copy',       // Default copy button
            {
                extend: 'csv',
                // upperCaseVariable+ " " + "TOTAL REVENUE BY SERVICES" + "  " + "BETWEEN"+" " + startDate+ " "+ "AND " + endDate
                title: `${upperCaseVariable} TOTAL REVENUE BY SERVICES BETWEEN ${startDate} to ${endDate}`,
                            filename: `${upperCaseVariable}_TOTAL_REVENUE_BY_SERVICES_BETWEEN_${startDate}_to_${endDate}`
            },
            {
                extend: 'excel',
                title: `${upperCaseVariable} TOTAL REVENUE BY SERVICES BETWEEN ${startDate} to ${endDate}`,
                filename: `${upperCaseVariable}_TOTAL_REVENUE_BY_SERVICES_BETWEEN_${startDate}_to_${endDate}`
            },
            {
                extend: 'pdf',
                title: `${upperCaseVariable} TOTAL REVENUE BY SERVICES BETWEEN ${startDate} to ${endDate}`,
                filename: `${upperCaseVariable}_TOTAL_REVENUE_BY_SERVICES_BETWEEN_${startDate}_to_${endDate}`,
                orientation: 'landscape', // Optional for better layout
                pageSize: 'A4' // Optional for better layout
            },
            {
                extend: 'print',
                title: `<h3>${upperCaseVariable} TOTAL REVENUE BY SERVICES BETWEEN ${startDate} to ${endDate}</h3>`,
                message: 'This report is generated using the Enterprise Land Information System'
            }
        ],
        pageLength: 10, // Default rows displayed
    }).draw();

    
    }
            
    
    
         }
     })

     


    })






    $(document).on('click','#view_bill_items',function(e){
        e.preventDefault();




        if (upperCaseVariable == "NATIONWIDE"){

            var business_process_sub_id=$(this).data('id');
       
            var user_created_name=$(this).data('name_full');
            var total=$(this).data('total_sum');
    
    
            var title =upperCaseVariable+ " "+  "SUM OF BILL ITEMS FOR"+ ' ' +user_created_name+ " " + "BETWEEN"+" " + startDate+ " "+ "AND " + endDate;     
    

            
          
            document.getElementById('banks_modalLabel').innerHTML = title;

            document.getElementById('total_span1').innerHTML = total;


            
    
    
            $('#service_to_bank_name').val(user_created_name);
    
            
    
    
            //var user_created_name = $(e.currentTarget).data("name");
          
            // document.getElementById('staff_name4').innerHTML = user_created_name;
          
            console.log(business_process_sub_id,user_created_name);
            
    
          $("#bill_items").modal("show");  
           
           
          
           let dataSet11 = [];
           let num11 = 0;
          
          $('#banks_table').DataTable().clear().destroy();
          
           $.ajax({
               type : "POST",
               url : "audit_reporting",
               data : {
                   request_type : 'audit_report_on_bill_items',
                   business_sub_id : business_process_sub_id,
                   regional_code : code,
                   start_date: startDate,
                   end_date : endDate
               },
               cache: false,
               success: function(response) {
          
            //    console.log(response)
          
                   var json_result = JSON.parse(response);
                  console.log(json_result)
          
                   if (json_result.apps_at_division == null){
          
                    console.log("data not found");       
          
          }else {
          
            for(let i=0; i<json_result.apps_at_division.length; i++) {
              let html = [];
              num11 = +num11 + 1;
          
              let customer_id = json_result.apps_at_division[i].customer_id;
    
              let total_bill_amount = new Intl.NumberFormat('en-US', {
                style: 'currency',
                currency: 'GHS', // Sets the currency to GHS
                minimumFractionDigits: 2, // Ensures 2 decimal places
            }).format(json_result.apps_at_division[i].sum);
            
    
            //   let sum = json_result.apps_at_division[i].sum;
            let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].customer_id}" data-service_name="${user_created_name}"  data-total="${total_bill_amount}" id="view_regional_bill_items"  
            class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
              
          
              html.push(customer_id);
              html.push(total_bill_amount);
              html.push(action);
             
             
          
              dataSet11.push(html);
          
            
            }
         
            $('#banks_table').DataTable().clear().destroy();
    
            $('#banks_table').DataTable({
                data: dataSet11,
                dom: 'Bfrtip',
                lengthMenu: [
                    [10, 25, 50, -1],
                    ['10 rows', '25 rows', '50 rows', 'Show all']
                ],
                buttons: [
                    'pageLength', // Default page length button
                    'copy',       // Default copy button
                    {
                        extend: 'csv',
                         title: `${upperCaseVariable} SUM OF BILL ITEMS FOR ${user_created_name} BETWEEN ${startDate} AND ${endDate}`,
                         filename: `${upperCaseVariable}_SUM_OF_BILL_ITEMS_FOR_${user_created_name}_BETWEEN_${startDate}_AND_${endDate}`
                        
                    },
                    {
                        extend: 'excel',
                         title: `${upperCaseVariable} SUM OF BILL ITEMS FOR ${user_created_name} BETWEEN ${startDate} AND ${endDate}`,
                         filename: `${upperCaseVariable}_SUM_OF_BILL_ITEMS_FOR_${user_created_name}_BETWEEN_${startDate}_AND_${endDate}`
                    },
                    {
                        extend: 'pdf',
                        title: 'Bank Bill Items Report',
                        filename: 'Bank_Bill_Items_Report',
                        orientation: 'landscape', // Optional for better layout
                        pageSize: 'A4' // Optional for better layout
                    },
                    {
                        extend: 'print',
                        title: `<h3>${upperCaseVariable} SUM OF BILL ITEMS FOR ${user_created_name} BETWEEN ${startDate} AND ${endDate}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ],
                pageLength: 10, // Default rows displayed
            }).draw();
    
    
                          
           
          
          }
                  
          
          
               }
           })
    

           





        }
        else {





            var business_process_sub_id=$(this).data('id');
       
            var user_created_name=$(this).data('name_full');
            var total=$(this).data('total_sum');

    
    
            var title =upperCaseVariable+ " "+  "SUM OF BILL ITEMS FOR"+ ' ' +user_created_name+ " " + "BETWEEN"+"  " + startDate+ " "+ "AND " + endDate ;
    
          
            document.getElementById('banks_modalLabel_1').innerHTML = title;

            document.getElementById('total_span2').innerHTML = total;

    
    
            $('#service_to_bank_name_1').val(user_created_name);
    
            
    
    
            //var user_created_name = $(e.currentTarget).data("name");
          
            // document.getElementById('staff_name4').innerHTML = user_created_name;
          
            console.log(business_process_sub_id,user_created_name);
            
    
            $("#bill_items_new").modal("show");  


            
           
           
          
           let dataSet11 = [];
           let num11 = 0;
          
          $('#banks_table_1').DataTable().clear().destroy();
          
           $.ajax({
               type : "POST",
               url : "audit_reporting",
               data : {
                   request_type : 'audit_report_on_bill_items',
                   business_sub_id : business_process_sub_id,
                   regional_code : code,
                   start_date: startDate,
                   end_date : endDate
               },
               cache: false,
               success: function(response) {
          
            //    console.log(response)
          
                   var json_result = JSON.parse(response);
                  console.log(json_result)
          
                   if (json_result.apps_at_division == null){
          
                    console.log("data not found");       
          
          }else {
          
            for(let i=0; i<json_result.apps_at_division.length; i++) {
              let html = [];
              num11 = +num11 + 1;
          
              let customer_id = json_result.apps_at_division[i].customer_id;
    
              let total_bill_amount = new Intl.NumberFormat('en-US', {
                style: 'currency',
                currency: 'GHS', // Sets the currency to GHS
                minimumFractionDigits: 2, // Ensures 2 decimal places
            }).format(json_result.apps_at_division[i].sum);
            
    
            //   let sum = json_result.apps_at_division[i].sum;
            //    let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].customer_id}" data-service_name="${user_created_name}" data-name_full="${json_result.apps_at_division[i].total_bill_amount}" id="view_regional_bill_items"  
            // class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
              
          
              html.push(customer_id);
              html.push(total_bill_amount);
            //   html.push(action);
             
             
          
              dataSet11.push(html);
          
            
            }
         
            $('#banks_table_1').DataTable().clear().destroy();
    
            $('#banks_table_1').DataTable({
                data: dataSet11,
                dom: 'Bfrtip',
                lengthMenu: [
                    [10, 25, 50, -1],
                    ['10 rows', '25 rows', '50 rows', 'Show all']
                ],
                buttons: [
                    'pageLength', // Default page length button
                    'copy',       // Default copy button
                    {
                        extend: 'csv',
                        title: `${upperCaseVariable} SUM OF BILL ITEMS FOR ${user_created_name} BETWEEN ${startDate} AND ${endDate}`,
                        filename: `${upperCaseVariable}_SUM_OF_BILL_ITEMS_FOR_${user_created_name}_BETWEEN_${startDate}_AND_${endDate}`
                    },
                    {
                        extend: 'excel',
                        title: `${upperCaseVariable} SUM OF BILL ITEMS FOR ${user_created_name} BETWEEN ${startDate} AND ${endDate}`,
                        filename: `${upperCaseVariable}_SUM_OF_BILL_ITEMS_FOR_${user_created_name}_BETWEEN_${startDate}_AND_${endDate}`
                    },
                    {
                        extend: 'pdf',
                        title: `${upperCaseVariable} SUM OF BILL ITEMS FOR ${user_created_name} BETWEEN ${startDate} AND ${endDate}`,
                        filename: `${upperCaseVariable}_SUM_OF_BILL_ITEMS_FOR_${user_created_name}_BETWEEN_${startDate}_AND_${endDate}`,
                        orientation: 'landscape', // Optional for better layout
                        pageSize: 'A4' // Optional for better layout
                    },
                    {
                        extend: 'print',
                        title: `<h3>${upperCaseVariable} SUM OF BILL ITEMS FOR ${user_created_name} BETWEEN ${startDate} AND ${endDate}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ],
                pageLength: 10, // Default rows displayed
            }).draw();
    
    
                          
           
          
          }
                  
          
          
               }
           })
    

        
            
        }







       
      
      });









    $(document).on('click','#view_regional_bill_items',function(e){
        e.preventDefault();

        var item_name=$(this).data('id');
       
        var sub_service_name=$(this).data('service_name');

        var total_sum=$(this).data('total');

        console.log(total_sum);
        
        

        const upper_item_name = item_name.toUpperCase();



        var title = upper_item_name +" FOR" +  " " + sub_service_name + " " + "BETWEEN"+"  " + startDate+ " "+ "AND " + endDate +" " + "| REGIONS";    

        
      
        document.getElementById('bill_items_regional_Label').innerHTML = title;

        document.getElementById('total_span').innerHTML = total_sum;


      
        console.log(item_name,sub_service_name);

        

      $("#bill_items_regional_modal").modal("show");  
       
       
      
       let dataSet15 = [];
       let num15 = 0;
      
      $('#bill_items_regional_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "audit_reporting",
           data : {
               request_type : 'audit_report_on_bill_items_by_regions',
               start_date: startDate,
               end_date : endDate,
               bill_item_name:item_name,
               business_process_sub_name:sub_service_name


           },
           cache: false,
           success: function(response) {
      
        //    console.log(response)
      
            var json_result = JSON.parse(response);
              console.log(json_result)
      
               if (json_result.apps_at_division == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num15 = +num15 + 1;
      
          let regional_name = json_result.apps_at_division[i].regional_name;

          let total_bill_amount = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'GHS', // Sets the currency to GHS
            minimumFractionDigits: 2, // Ensures 2 decimal places
        }).format(json_result.apps_at_division[i].sum);

        //   let sum = json_result.apps_at_division[i].sum;
           let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sum}" data-name_full="${json_result.apps_at_division[i].sum}" id="view_applications_recieved_by_banks"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          
      
          html.push(regional_name);
          html.push(total_bill_amount);
        //   html.push(action);
         
         
      
        dataSet15.push(html);
      
        
        }
     
        $('#bill_items_regional_table').DataTable().clear().destroy();

        $('#bill_items_regional_table').DataTable({
            data: dataSet15,
            dom: 'Bfrtip',
            lengthMenu: [
                [10, 25, 50, -1],
                ['10 rows', '25 rows', '50 rows', 'Show all']
            ],
            buttons: [
                'pageLength', // Default page length button
                'copy',       // Default copy button
                {
                    extend: 'csv',
                    title: `${upper_item_name} FOR ${sub_service_name} BETWEEN ${startDate} AND ${endDate} | REGIONS`,
                    filename: `${upper_item_name}_FOR_${sub_service_name}_BETWEEN_${startDate}_AND_${endDate}_|_REGIONS`
                },
                {
                    extend: 'excel',
                    title: `${upper_item_name} FOR ${sub_service_name} BETWEEN ${startDate} AND ${endDate} | REGIONS`,
                    filename: `${upper_item_name}_FOR_${sub_service_name}_BETWEEN_${startDate}_AND_${endDate}_|_REGIONS`
                },
                {
                    extend: 'pdf',
                    title: `${upper_item_name} FOR ${sub_service_name} BETWEEN ${startDate} AND ${endDate} | REGIONS`,
                    filename: `${upper_item_name}_FOR_${sub_service_name}_BETWEEN_${startDate}_AND_${endDate}_|_REGIONS`,
                    orientation: 'landscape', // Optional for better layout
                    pageSize: 'A4' // Optional for better layout
                },
                {
                    extend: 'print',
                    title: `<h3>${upper_item_name} FOR ${sub_service_name} BETWEEN ${startDate} AND ${endDate} | REGIONS</h3>`,
                    message: 'This report is generated using the Enterprise Land Information System'
                }
            ],
            pageLength: 10, // Default rows displayed
        }).draw();


                      
       
      
      }
              
      
      
           }
       })
       
      
      });










    //   audit_report_on_all_transactions

    $('#totalTransactions').on('click', function(e) {
        e.preventDefault();
  
     $("#transactions_modal").modal("show");  
  
    //  console.log(created_for_id);
    
  
     var title  =upperCaseVariable+ " " +  "TOTAL TRANSACTIONS" + "BETWEEN"+" " + startDate+ " "+ "AND " + endDate; 
          
     document.getElementById('transactions_Label').innerHTML = title;

           
     let dataSet11 = [];
     let num11 = 0;
    
    $('#transactions_table').DataTable().clear().destroy();
    
     $.ajax({
        type : "POST",
        url : "audit_reporting",
        data : {
            request_type : 'audit_report_on_all_transactions',
             regional_code : code,
             start_date: startDate,
             end_date : endDate
         },
         cache: false,
         success: function(response) {
    
      //    console.log(response)
    
             var json_result = JSON.parse(response);
            console.log(json_result)
    
             if (json_result.apps_at_division == null){
    
              console.log("data not found");       
    
    }else {
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num11 = +num11 + 1;
        let lessees_name = json_result.apps_at_division[i].lessees_name;
        let job_number = json_result.apps_at_division[i].job_number;
        let business_process_sub_name = json_result.apps_at_division[i].business_process_sub_name;
        let ref_number = json_result.apps_at_division[i].ref_number;
        let payment_amount = json_result.apps_at_division[i].bill_amount;
        let bill_amount = json_result.apps_at_division[i].bill_amount;
        let client_ref = json_result.apps_at_division[i].client_ref;
        let payment_slip_number = json_result.apps_at_division[i].payment_slip_number;
        let payment_mode = json_result.apps_at_division[i].payment_mode;
        let created_date = json_result.apps_at_division[i].created_date;
       let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].job_number}" data-name_full="${json_result.apps_at_division[i].payment_amount}"   data-ref_number="${json_result.apps_at_division[i].ref_number}"  data-app_name="${json_result.apps_at_division[i].lessees_name}"  id="view_bill_items_with_job_number"  
      class="btn btn-secondary">Bill Details <i class="fa fa-cogs"></i></a> `
        
    
        html.push(lessees_name);
        html.push(job_number);
        html.push(business_process_sub_name);
        html.push(ref_number);
        html.push(bill_amount);
        html.push(payment_amount);
        html.push(client_ref);
        html.push(payment_slip_number);
        html.push(payment_mode);
        html.push(created_date);
        html.push(action);
        dataSet11.push(html);
    
      
      }
   
      $('#transactions_table').DataTable().clear().destroy();

      $('#transactions_table').DataTable({
        data: dataSet11,
        dom: 'Bfrtip',
        lengthMenu: [
            [10, 25, 50, -1],
            ['10 rows', '25 rows', '50 rows', 'Show all']
        ],
        buttons: [
            'pageLength', // Default page length button
            'copy',       // Default copy button
            {
                extend: 'csv',
                title: `${upperCaseVariable} TOTAL TRANSACTIONS BETWEEN ${startDate} AND ${endDate}`,
                filename: `${upperCaseVariable}_TOTAL_TRANSACTIONS_BETWEEN_${startDate}_AND_${endDate}`
            },
            {
                extend: 'excel',
                title: `${upperCaseVariable} TOTAL TRANSACTIONS BETWEEN ${startDate} AND ${endDate}`,
                filename: `${upperCaseVariable}_TOTAL_TRANSACTIONS_BETWEEN_${startDate}_AND_${endDate}`
            },
            {
                extend: 'pdf',
                title: `${upperCaseVariable} TOTAL TRANSACTIONS BETWEEN ${startDate} AND ${endDate}`,
                filename: `${upperCaseVariable}_TOTAL_TRANSACTIONS_BETWEEN_${startDate}_AND_${endDate}`,
                orientation: 'landscape', // Optional for better layout
                pageSize: 'A4' // Optional for better layout
            },
            {
                extend: 'print',
                title: `<h3>${upperCaseVariable} TOTAL TRANSACTIONS BETWEEN ${startDate} AND ${endDate}</h3>`,
                message: 'This report is generated using the Enterprise Land Information System'
            }
        ],
        pageLength: 10, // Default rows displayed
    }).draw();

    
    }
            
    
    
         }
     })

     


    })












    $(document).on('click','#view_bill_items_with_job_number',function(e){
        e.preventDefault();

        var job_number=$(this).data('id');
       
        var payment_amount=$(this).data('name_full');
        var ref_number=$(this).data('ref_number');
        var app_name=$(this).data('app_name');


        var title = "BILL DETAILS FOR"+ ' ' +job_number;    

      
        document.getElementById('job_numberbillLabel').innerHTML = title;


        $('#bill_number').val(ref_number);
        $('#bill_amount').val(payment_amount);
        $('#applicant_name').val(app_name);


        //var user_created_name = $(e.currentTarget).data("name");
      
        // document.getElementById('staff_name4').innerHTML = user_created_name;
      
        console.log(job_number);

        

      $("#job_numberbill_items").modal("show");  
       
       
      
       let dataSet15 = [];
       let num15 = 0;
      
      $('#job_numberbill_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "audit_reporting",
           data : {
               request_type : 'audit_report_on_bill_items_by_job_number',
               job_number : job_number,
           },
           cache: false,
           success: function(response) {
      
        //    console.log(response)
      
               var json_result = JSON.parse(response);
              console.log(json_result)
      
               if (json_result.apps_at_division == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num15 = +num15 + 1;
      
          let customer_id = json_result.apps_at_division[i].customer_id;

          let total_bill_amount = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'GHS', // Sets the currency to GHS
            minimumFractionDigits: 2, // Ensures 2 decimal places
        }).format(json_result.apps_at_division[i].sum);

        //   let sum = json_result.apps_at_division[i].sum;
           let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sum}" data-name_full="${json_result.apps_at_division[i].sum}" id="view_applications_recieved_by_banks"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          
      
          html.push(customer_id);
          html.push(total_bill_amount);
        //   html.push(action);
         
         
      
        dataSet15.push(html);
      
        
        }
     
        $('#job_numberbill_table').DataTable().clear().destroy();

        $('#job_numberbill_table').DataTable({
            data: dataSet15,
            dom: 'Bfrtip',
            lengthMenu: [
                [10, 25, 50, -1],
                ['10 rows', '25 rows', '50 rows', 'Show all']
            ],
            buttons: [
                'pageLength', // Default page length button
                'copy',       // Default copy button
                {
                    extend: 'csv',
                    title: `BILL DETAILS FOR ${job_number}`,
                    filename: `BILL_DETAILS_FOR_${job_number}`
                },
                {
                    extend: 'excel',
                    title: `BILL DETAILS FOR ${job_number}`,
                    filename: `BILL_DETAILS_FOR_${job_number}`
                },
                {
                    extend: 'pdf',
                    title: `BILL DETAILS FOR ${job_number}`,
                    filename: `BILL_DETAILS_FOR_${job_number}`,
                    orientation: 'landscape', // Optional for better layout
                    pageSize: 'A4' // Optional for better layout
                },
                {
                    extend: 'print',
                    title: `<h3>BILL DETAILS FOR ${job_number}</h3>`,
                    message: 'This report is generated using the Enterprise Land Information System'
                }
            ],
            pageLength: 10, // Default rows displayed
        }).draw();


                      
       
      
      }
              
      
      
           }
       })
       
      
      });





    




    


})