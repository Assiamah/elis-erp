$(document).ready(function() {

    //further enteries applications recieved today

    $('#further_entries_recieved_today').on('click', function(e) {
        e.preventDefault();

     $("#further_entries_recieved_today_modal").modal("show");  


        var regional_code = $('#csau_manager_regional_code').val();
       // console.log(regional_code);


        $.ajax({
            type : "POST",
            url : "csau_manager_dashboard_backoffice",
            data : { 
                request_type : 'load_apps_backoffice_further_entries_applications_recieved_toda',
                regional_code : regional_code.trim()
            },
            cache: false,
            success: function(response) {
               // console.log(response);

                var json_result = JSON.parse(response);

                if (json_result.data == null){

                    //.log("data not found");       
    
    }else {

        let dataSet1 = [];
        let num1 = 0;
 
      $('#further_entries_recieved_today_table').DataTable().clear().destroy();

        for(let i=0; i<json_result.data.length; i++) {
            let html = [];
            num1 = +num1 + 1;

            let current_division_of_application = json_result.data[i].current_division_of_application;
            let count = json_result.data[i].count;
            let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].current_division_of_application}"  id="view_divisional_today_data"  
            class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

            // let payment_status = e[i].payment_status;
            // let buttons = e[i].buttons;
            html.push(current_division_of_application);
            html.push(count);
            html.push(action);

            dataSet1.push(html);

          //console.log(dataSet)
          }

        // let dataTable_Obj = $('#recievedtoday').DataTable({
        //     data: dataSet1
        //   })

          $('#further_entries_recieved_today_table').DataTable().clear().destroy();
                        
          $('#further_entries_recieved_today_table').DataTable({ data: dataSet1,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            buttons : [ 'pageLength', 'copy',
                'csv', 'excel', 'pdf', 'print' ] }).draw();

     }


            }
        })
    })






        //further enteries applications recieved week

    $('#further_entries_recieved_week').on('click', function(e) {
        e.preventDefault();

     $("#further_entries_recieved_week_modal").modal("show");  


        var regional_code = $('#csau_manager_regional_code').val();
        //console.log(regional_code);


        $.ajax({
            type : "POST",
            url : "csau_manager_dashboard_backoffice",
            data : {
                request_type : 'load_apps_backoffice_further_entries_applications_recieved_week',
                regional_code : regional_code.trim()
            },
            cache: false,
            success: function(response) {
               // console.log(response);

                var json_result = JSON.parse(response);

                if (json_result.data == null){

                   // console.log("data not found");       
    
    }else {

        let dataSet2 = [];
        let num2 = 0;
 
      $('#further_entries_recieved_week_table').DataTable().clear().destroy();

        for(let i=0; i<json_result.data.length; i++) {
            let html = [];
            num2 = +num2 + 1;

            let current_division_of_application = json_result.data[i].current_division_of_application;
            let count = json_result.data[i].count;
            let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].current_division_of_application}" data-name_full="${json_result.data[i].fullname}" id="view_divisional_week_data"  
            class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

            // let payment_status = e[i].payment_status;
            // let buttons = e[i].buttons;
            html.push(current_division_of_application);
            html.push(count);
            html.push(action);

            dataSet2.push(html);

          //console.log(dataSet)
          }

        // let dataTable_Obj = $('#recievedtoday').DataTable({
        //     data: dataSet1
        //   })

          $('#further_entries_recieved_week_table').DataTable().clear().destroy();
                        
          $('#further_entries_recieved_week_table').DataTable({ data: dataSet2,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            buttons : [ 'pageLength', 'copy',
                'csv', 'excel', 'pdf', 'print' ] }).draw();

     }


            }
        })
    })




 
        //further enteries applications recieved month

        $('#further_entries_recieved_month').on('click', function(e) {
            e.preventDefault();
    
         $("#further_entries_recieved_month_modal").modal("show");  
    
    
            var regional_code = $('#csau_manager_regional_code').val();
           // console.log(regional_code);
    
    
            $.ajax({
                type : "POST",
                url : "csau_manager_dashboard_backoffice",
                data : {
                    request_type : 'load_apps_backoffice_further_entries_applications_recieved_mont',
                    regional_code : regional_code.trim()
                },
                cache: false,
                success: function(response) {
                    //console.log(response);
    
                    var json_result = JSON.parse(response);
    
                    if (json_result.data == null){
    
                       // console.log("data not found");       
        
        }else {
    
            let dataSet3 = [];
            let num3 = 0;
     
          $('#further_entries_recieved_month_table').DataTable().clear().destroy();
    
            for(let i=0; i<json_result.data.length; i++) {
                let html = [];
                num3 = +num3 + 1;
    
                let current_division_of_application = json_result.data[i].current_division_of_application;
                let count = json_result.data[i].count;
                let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].current_division_of_application}" data-name_full="${json_result.data[i].fullname}" id="view_divisional_month_data"  
                class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
                // let payment_status = e[i].payment_status;
                // let buttons = e[i].buttons;
                html.push(current_division_of_application);
                html.push(count);
                html.push(action);
    
                dataSet3.push(html);
    
              //console.log(dataSet)
              }
    
            // let dataTable_Obj = $('#recievedtoday').DataTable({
            //     data: dataSet1
            //   })
    
              $('#further_entries_recieved_month_table').DataTable().clear().destroy();
                            
              $('#further_entries_recieved_month_table').DataTable({ data: dataSet3,
                dom : 'Bfrtip',
                lengthMenu : [
                    [ 10, 25, 50, -1 ],
                    [ '10 rows', '25 rows',
                        '50 rows', 'Show all' ] ],
                buttons : [ 'pageLength', 'copy',
                    'csv', 'excel', 'pdf', 'print' ] }).draw();
    
         }
    
    
                }
            })
        })
        
        
    
            //further enteries applications recieved year

            $('#further_entries_recieved_year').on('click', function(e) {
                e.preventDefault();
        
             $("#further_entries_recieved_year_modal").modal("show");  
        
        
                var regional_code = $('#csau_manager_regional_code').val();
                //console.log(regional_code);
        
        
                $.ajax({
                    type : "POST",
                    url : "csau_manager_dashboard_backoffice",
                    data : {
                        request_type : 'load_apps_backoffice_further_entries_applications_recieved_year',
                        regional_code : regional_code.trim()
                    },
                    cache: false,
                    success: function(response) {
                       // console.log(response);
        
                        var json_result = JSON.parse(response);
        
                        if (json_result.data == null){
        
                           // console.log("data not found");       
            
            }else {
        
                let dataSet4 = [];
                let num4 = 0;
         
              $('#further_entries_recieved_year_table').DataTable().clear().destroy();
        
                for(let i=0; i<json_result.data.length; i++) {
                    let html = [];
                    num4 = +num4 + 1;
        
                    let current_division_of_application = json_result.data[i].current_division_of_application;
                    let count = json_result.data[i].count;
                    let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].current_division_of_application}" data-name_full="${json_result.data[i].fullname}" id="view_divisional_year_data"  
                    class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
        
                    // let payment_status = e[i].payment_status;
                    // let buttons = e[i].buttons;
                    html.push(current_division_of_application);
                    html.push(count);
                    html.push(action);
        
                    dataSet4.push(html);
        
                  //console.log(dataSet)
                  }
        
                // let dataTable_Obj = $('#recievedtoday').DataTable({
                //     data: dataSet1
                //   })
        
                  $('#further_entries_recieved_year_table').DataTable().clear().destroy();
                                
                  $('#further_entries_recieved_year_table').DataTable({ data: dataSet4,
                    dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] }).draw();
        
             }
        
        
                    }
                })
            }) 



// csau Batching applications worked on today

            $('#batching_apps_worked_on_today').on('click', function(e) {
                e.preventDefault();
        
             $("#batching_apps_worked_on_today_modal").modal("show");  
        
             var regional_code = $('#csau_manager_regional_code').val();
            // console.log(regional_code);
     
     
             $.ajax({
                 type : "POST",
                 url : "csau_manager_dashboard_backoffice",
                 data : {
                     request_type : 'select_count_worked_on_batching_officers',
                     regional_code : regional_code.trim()
                 },
                 cache: false,
                 success: function(response) {
                    // console.log(response);
     
                     var json_result = JSON.parse(response);
     
                     if (json_result.data == null){
     
                        // console.log("data not found");       
         
         }else {
     
     
            let dataSet5 = [];
            let num5 = 0;
     
          $('#batching_apps_worked_on_today_table').DataTable().clear().destroy();
    

            for(let i=0; i<json_result.data.length; i++) {
                let html = [];
                num5 = +num5 + 1;
    
                let fullname = json_result.data[i].fullname;
                let count = json_result.data[i].count;
                let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_daily_apps_batched_tocabinet"  
                class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
            
                
    
                html.push(fullname);
                html.push(count);
                html.push(action);
              
    
                dataSet5.push(html);
    
              //console.log(dataSet)
              }
    
    
              $('#batching_apps_worked_on_today_table').DataTable().clear().destroy();
                            
              $('#batching_apps_worked_on_today_table').DataTable({ data: dataSet5,
                dom : 'Bfrtip',
                lengthMenu : [
                    [ 10, 25, 50, -1 ],
                    [ '10 rows', '25 rows',
                        '50 rows', 'Show all' ] ],
                buttons : [ 'pageLength', 'copy',
                    'csv', 'excel', 'pdf', 'print' ] }).draw();
    
     
          }
     
     
                 }
             })
    

            }) 



// csau Batching applications worked on this week



            $('#batching_apps_worked_on_thisweek').on('click', function(e) {
                e.preventDefault();
        
             $("#batching_apps_worked_on_thisweek_modal").modal("show");  
        
             var regional_code = $('#csau_manager_regional_code').val();
             //console.log(regional_code);
     
     
             $.ajax({
                 type : "POST",
                 url : "csau_manager_dashboard_backoffice",
                 data : {
                     request_type : 'select_count_worked_on_batching_officers_week',
                     regional_code : regional_code.trim()
                 },
                 cache: false,
                 success: function(response) {
                     //console.log(response);
     
                     var json_result = JSON.parse(response);
     
                     if (json_result.data == null){
     
                         console.log("data not found");       
         
         }else {
     
     
            let dataSet6 = [];
            let num6 = 0;
     
          $('#batching_apps_worked_on_thisweek_table').DataTable().clear().destroy();
    

            for(let i=0; i<json_result.data.length; i++) {
                let html = [];
                num6 = +num6 + 1;
    
                let fullname = json_result.data[i].fullname;
                let count = json_result.data[i].count;
                let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_weekly_apps_batched_tocabinet"  
                class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
            
                
    
                html.push(fullname);
                html.push(count);
                html.push(action);
              
    
                dataSet6.push(html);
    
              //console.log(dataSet)
              }
    
    
              $('#batching_apps_worked_on_thisweek_table').DataTable().clear().destroy();
                            
              $('#batching_apps_worked_on_thisweek_table').DataTable({ data: dataSet6,
                dom : 'Bfrtip',
                lengthMenu : [
                    [ 10, 25, 50, -1 ],
                    [ '10 rows', '25 rows',
                        '50 rows', 'Show all' ] ],
                buttons : [ 'pageLength', 'copy',
                    'csv', 'excel', 'pdf', 'print' ] }).draw();
    
     
          }
     
     
                 }
             })
    

            }) 







// csau Batching applications worked on this month

            $('#batching_apps_worked_on_month').on('click', function(e) {
                e.preventDefault();
        
             $("#batching_apps_worked_on_thismonth_modal").modal("show");  
        
             var regional_code = $('#csau_manager_regional_code').val();
             //console.log(regional_code);
     
     
             $.ajax({
                 type : "POST",
                 url : "csau_manager_dashboard_backoffice",
                 data : {
                     request_type : 'select_count_worked_on_batching_officers_month',
                     regional_code : regional_code.trim()
                 },
                 cache: false,
                 success: function(response) {
                    // console.log(response);
     
                     var json_result = JSON.parse(response);
     
                     if (json_result.data == null){
     
                         console.log("data not found");       
         
         }else {
     
     
            let dataSet7 = [];
            let num7 = 0;
     
          $('#batching_apps_worked_on_thismonth_table').DataTable().clear().destroy();
    

            for(let i=0; i<json_result.data.length; i++) {
                let html = [];
                num7 = +num7 + 1;
    
                let fullname = json_result.data[i].fullname;
                let count = json_result.data[i].count;
                let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_monthly_apps_batched_tocabinet"  
                class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
            
                
    
                html.push(fullname);
                html.push(count);
                html.push(action);
              
    
                dataSet7.push(html);
    
              //console.log(dataSet)
              }
    
    
              $('#batching_apps_worked_on_thismonth_table').DataTable().clear().destroy();
                            
              $('#batching_apps_worked_on_thismonth_table').DataTable({ data: dataSet7,
                dom : 'Bfrtip',
                lengthMenu : [
                    [ 10, 25, 50, -1 ],
                    [ '10 rows', '25 rows',
                        '50 rows', 'Show all' ] ],
                buttons : [ 'pageLength', 'copy',
                    'csv', 'excel', 'pdf', 'print' ] }).draw();
    
     
          }
     
     
                 }
             })
    

            }) 






// csau Batching applications worked on this year

$('#batching_apps_worked_on_year').on('click', function(e) {
    e.preventDefault();

 $("#batching_apps_worked_on_thisyear_modal").modal("show");  

 var regional_code = $('#csau_manager_regional_code').val();
 //console.log(regional_code);


 $.ajax({
     type : "POST",
     url : "csau_manager_dashboard_backoffice",
     data : {
         request_type : 'select_count_worked_on_batching_officers_year',
         regional_code : regional_code.trim()
     },
     cache: false,
     success: function(response) {
         //console.log(response);

         var json_result = JSON.parse(response);

         if (json_result.data == null){

             console.log("data not found");       

}else {


let dataSet8 = [];
let num8 = 0;

$('#batching_apps_worked_on_thisyear_table').DataTable().clear().destroy();


for(let i=0; i<json_result.data.length; i++) {
    let html = [];
    num8 = +num8 + 1;

    let fullname = json_result.data[i].fullname;
    let count = json_result.data[i].count;
    let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_yearly_apps_batched_tocabinet"  
    class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `


    

    html.push(fullname);
    html.push(count);
    html.push(action);
  

    dataSet8.push(html);

  //console.log(dataSet)
  }


  $('#batching_apps_worked_on_thisyear_table').DataTable().clear().destroy();
                
  $('#batching_apps_worked_on_thisyear_table').DataTable({ data: dataSet8,
    dom : 'Bfrtip',
    lengthMenu : [
        [ 10, 25, 50, -1 ],
        [ '10 rows', '25 rows',
            '50 rows', 'Show all' ] ],
    buttons : [ 'pageLength', 'copy',
        'csv', 'excel', 'pdf', 'print' ] }).draw();


}


     }
 })


}) 






// Applications batched today

$(document).on('click','#view_daily_apps_batched_tocabinet',function(e){
    e.preventDefault();
    var user_created_id=$(this).data('id');
   
    var user_created_name=$(this).data('name_full');
    //var user_created_name = $(e.currentTarget).data("name");
  
    document.getElementById('staff_name1').innerHTML = user_created_name;
  
   // console.log(user_created_id,user_created_name);
   
  $("#view_daily_apps_batched_tocabinet_modal").modal("show");  
   
   
  
   let dataSet9 = [];
   let num9 = 0;
  
  $('#view_daily_apps_batched_tocabinet_table').DataTable().clear().destroy();
  
   $.ajax({
       type : "POST",
       url : "csau_manager_dashboard_backoffice",
       data : {
           request_type : 'select_applications_workedon_today_by_csau_batching_officers',
           created_by_id : user_created_id
       },
       cache: false,
       success: function(response) {
  
       // console.log(response)
  
           var json_result = JSON.parse(response);
          // console.log(json_result)
  
           if (json_result.data == null){
  
            console.log("data not found");       
  
  }else {
  
    for(let i=0; i<json_result.data.length; i++) {
      let html = [];
      num9 = +num9 + 1;
  
      let job_number = json_result.data[i].job_number;
      let ar_name = json_result.data[i].ar_name;
      let business_process_name = json_result.data[i].business_process_name;
      let modified_date = json_result.data[i].modified_date;
      let job_status = json_result.data[i].job_status;

      
  
      html.push(job_number);
      html.push(ar_name);
      html.push(business_process_name);
      html.push(modified_date);
      html.push(job_status);
     
  
      dataSet9.push(html);
  
    
    }
 
  
    $('#view_daily_apps_batched_tocabinet_table').DataTable().clear().destroy();
                  
    $('#view_daily_apps_batched_tocabinet_table').DataTable({ data: dataSet9,
        dom : 'Bfrtip',
        lengthMenu : [
            [ 10, 25, 50, -1 ],
            [ '10 rows', '25 rows',
                '50 rows', 'Show all' ] ],
        buttons : [ 'pageLength', 'copy',
            'csv', 'excel', 'pdf', 'print' ] }).draw();
  
  }
          
  
  
       }
   })
   
  
  });







  // Applications batched this week 
$(document).on('click','#view_weekly_apps_batched_tocabinet',function(e){
    e.preventDefault();
    var user_created_id=$(this).data('id');
   
    var user_created_name=$(this).data('name_full');
    //var user_created_name = $(e.currentTarget).data("name");
  
    document.getElementById('staff_name2').innerHTML = user_created_name;
  
    //console.log(user_created_id,user_created_name);
   
  $("#view_weekly_apps_batched_tocabinet_modal").modal("show");  
   
   
  
   let dataSet10 = [];
   let num10 = 0;
  
  $('#view_weekly_apps_batched_tocabinet_table').DataTable().clear().destroy();
  
   $.ajax({
       type : "POST",
       url : "csau_manager_dashboard_backoffice",
       data : {
           request_type : 'select_applications_workedon_week_by_csau_batching_officers',
           created_by_id : user_created_id
       },
       cache: false,
       success: function(response) {
  
        //console.log(response)
  
           var json_result = JSON.parse(response);
           //console.log(json_result)
  
           if (json_result.data == null){
  
            console.log("data not found");       
  
  }else {
  
    for(let i=0; i<json_result.data.length; i++) {
      let html = [];
      num10 = +num10 + 1;
  
      let job_number = json_result.data[i].job_number;
      let ar_name = json_result.data[i].ar_name;
      let business_process_name = json_result.data[i].business_process_name;
      let modified_date = json_result.data[i].modified_date;
      let job_status = json_result.data[i].job_status;

      
  
      html.push(job_number);
      html.push(ar_name);
      html.push(business_process_name);
      html.push(modified_date);
      html.push(job_status);
     
  
      dataSet10.push(html);
  
    
    }
 
    $('#view_weekly_apps_batched_tocabinet_table').DataTable().clear().destroy();
                  
    $('#view_weekly_apps_batched_tocabinet_table').DataTable({ data: dataSet10,
        dom : 'Bfrtip',
        lengthMenu : [
            [ 10, 25, 50, -1 ],
            [ '10 rows', '25 rows',
                '50 rows', 'Show all' ] ],
        buttons : [ 'pageLength', 'copy',
            'csv', 'excel', 'pdf', 'print' ] }).draw();
  
  }
          
  
  
       }
   })
   
  
  });







  // Applications batched this Month 
$(document).on('click','#view_monthly_apps_batched_tocabinet',function(e){
    e.preventDefault();
    var user_created_id=$(this).data('id');
   
    var user_created_name=$(this).data('name_full');
    //var user_created_name = $(e.currentTarget).data("name");
  
    document.getElementById('staff_name3').innerHTML = user_created_name;
  
    //console.log(user_created_id,user_created_name);
   
  $("#view_monthly_apps_batched_tocabinet_modal").modal("show");  
   
   
  
   let dataSet11 = [];
   let num11 = 0;
  
  $('#view_monthly_apps_batched_tocabinet_table').DataTable().clear().destroy();
  
   $.ajax({
       type : "POST",
       url : "csau_manager_dashboard_backoffice",
       data : {
           request_type : 'select_applications_workedon_month_by_csau_batching_officers',
           created_by_id : user_created_id
       },
       cache: false,
       success: function(response) {
  
      //  console.log(response)
  
           var json_result = JSON.parse(response);
         //  console.log(json_result)
  
           if (json_result.data == null){
  
            console.log("data not found");       
  
  }else {
  
    for(let i=0; i<json_result.data.length; i++) {
      let html = [];
      num11 = +num11 + 1;
  
      let job_number = json_result.data[i].job_number;
      let ar_name = json_result.data[i].ar_name;
      let business_process_name = json_result.data[i].business_process_name;
      let modified_date = json_result.data[i].modified_date;
      let job_status = json_result.data[i].job_status;

      
  
      html.push(job_number);
      html.push(ar_name);
      html.push(business_process_name);
      html.push(modified_date);
      html.push(job_status);
     
  
      dataSet11.push(html);
  
    
    }
 
    $('#view_monthly_apps_batched_tocabinet_table').DataTable().clear().destroy();
                  
    $('#view_monthly_apps_batched_tocabinet_table').DataTable({ data: dataSet11,
        dom : 'Bfrtip',
        lengthMenu : [
            [ 10, 25, 50, -1 ],
            [ '10 rows', '25 rows',
                '50 rows', 'Show all' ] ],
        buttons : [ 'pageLength', 'copy',
            'csv', 'excel', 'pdf', 'print' ] }).draw();
  
  }
          
  
  
       }
   })
   
  
  });







    // Applications batched this Year 
$(document).on('click','#view_yearly_apps_batched_tocabinet',function(e){
    e.preventDefault();
    var user_created_id=$(this).data('id');
   
    var user_created_name=$(this).data('name_full');
    //var user_created_name = $(e.currentTarget).data("name");
  
    document.getElementById('staff_name4').innerHTML = user_created_name;
  
    //console.log(user_created_id,user_created_name);
   
  $("#view_yearly_apps_batched_tocabinet_modal").modal("show");  
   
   
  
   let dataSet11 = [];
   let num11 = 0;
  
  $('#view_yearly_apps_batched_tocabinet_table').DataTable().clear().destroy();
  
   $.ajax({
       type : "POST",
       url : "csau_manager_dashboard_backoffice",
       data : {
           request_type : 'select_applications_workedon_year_by_csau_batching_officers',
           created_by_id : user_created_id
       },
       cache: false,
       success: function(response) {
  
       // console.log(response)
  
           var json_result = JSON.parse(response);
         //  console.log(json_result)
  
           if (json_result.data == null){
  
            console.log("data not found");       
  
  }else {
  
    for(let i=0; i<json_result.data.length; i++) {
      let html = [];
      num11 = +num11 + 1;
  
      let job_number = json_result.data[i].job_number;
      let ar_name = json_result.data[i].ar_name;
      let business_process_name = json_result.data[i].business_process_name;
      let modified_date = json_result.data[i].modified_date;
      let job_status = json_result.data[i].job_status;

      
  
      html.push(job_number);
      html.push(ar_name);
      html.push(business_process_name);
      html.push(modified_date);
      html.push(job_status);
     
  
      dataSet11.push(html);
  
    
    }
 
    $('#view_yearly_apps_batched_tocabinet_table').DataTable().clear().destroy();
                  
    $('#view_yearly_apps_batched_tocabinet_table').DataTable({ data: dataSet11,
        dom : 'Bfrtip',
        lengthMenu : [
            [ 10, 25, 50, -1 ],
            [ '10 rows', '25 rows',
                '50 rows', 'Show all' ] ],
        buttons : [ 'pageLength', 'copy',
            'csv', 'excel', 'pdf', 'print' ] }).draw();
  
  }
          
  
  
       }
   })
   
  
  });



  


//   Further Entries Worked on Today

  $('#further_entries_worked_on_today').on('click', function(e) {
    e.preventDefault();

  $("#further_entries_worked_on_today_modal").modal("show");  

 var regional_code = $('#csau_manager_regional_code').val();
// console.log(regional_code);


 $.ajax({
     type : "POST",
     url : "csau_manager_dashboard_backoffice",
     data : {
         request_type : 'select_count_worked_on_further_entries_officers_today',
         regional_code : regional_code.trim()
     },
     cache: false,
     success: function(response) {
        // console.log(response);

         var json_result = JSON.parse(response);

         if (json_result.data == null){

            // console.log("data not found");       

}else {


let dataSet12 = [];
let num12 = 0;

$('#further_entries_worked_on_today_table').DataTable().clear().destroy();


for(let i=0; i<json_result.data.length; i++) {
    let html = [];
    num12 = +num12 + 1;

    let fullname = json_result.data[i].fullname;
    let count = json_result.data[i].count;
    let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="further_entries_workedon_today"  
    class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `


    

    html.push(fullname);
    html.push(count);
    html.push(action);
  

    dataSet12.push(html);

  //console.log(dataSet)
  }


  $('#further_entries_worked_on_today_table').DataTable().clear().destroy();
                
  $('#further_entries_worked_on_today_table').DataTable({ data: dataSet12,
    dom : 'Bfrtip',
    lengthMenu : [
        [ 10, 25, 50, -1 ],
        [ '10 rows', '25 rows',
            '50 rows', 'Show all' ] ],
    buttons : [ 'pageLength', 'copy',
        'csv', 'excel', 'pdf', 'print' ] }).draw();


}


     }
 })


}) 






//   Further Entries Worked on Week

$('#further_entries_worked_on_week').on('click', function(e) {
    e.preventDefault();

  $("#further_entries_worked_on_week_modal").modal("show");  

 var regional_code = $('#csau_manager_regional_code').val();
console.log(regional_code);


 $.ajax({
     type : "POST",
     url : "csau_manager_dashboard_backoffice",
     data : {
         request_type : 'select_count_worked_on_further_entries_officers_week',
         regional_code : regional_code.trim()
     },
     cache: false,
     success: function(response) {
        // console.log(response);

         var json_result = JSON.parse(response);

         if (json_result.data == null){

            // console.log("data not found");       

}else {


let dataSet13 = [];
let num13 = 0;

$('#further_entries_worked_on_week_table').DataTable().clear().destroy();


for(let i=0; i<json_result.data.length; i++) {
    let html = [];
    num13 = +num13 + 1;

    let fullname = json_result.data[i].fullname;
    let count = json_result.data[i].count;
    let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="further_entries_workedon_week"  
    class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `


    

    html.push(fullname);
    html.push(count);
    html.push(action);
  

    dataSet13.push(html);

  //console.log(dataSet)
  }


  $('#further_entries_worked_on_week_table').DataTable().clear().destroy();
                
  $('#further_entries_worked_on_week_table').DataTable({ data: dataSet13,
    dom : 'Bfrtip',
    lengthMenu : [
        [ 10, 25, 50, -1 ],
        [ '10 rows', '25 rows',
            '50 rows', 'Show all' ] ],
    buttons : [ 'pageLength', 'copy',
        'csv', 'excel', 'pdf', 'print' ] }).draw();


}


     }
 })


}) 





//   Further Entries Worked on month

$('#further_entries_worked_on_month').on('click', function(e) {
    e.preventDefault();

  $("#further_entries_worked_on_month_modal").modal("show");  

 var regional_code = $('#csau_manager_regional_code').val();
console.log(regional_code);


 $.ajax({
     type : "POST",
     url : "csau_manager_dashboard_backoffice",
     data : {
         request_type : 'select_count_worked_on_further_entries_officers_month',
         regional_code : regional_code.trim()
     },
     cache: false,
     success: function(response) {
        // console.log(response);

         var json_result = JSON.parse(response);

         if (json_result.data == null){

            // console.log("data not found");       

}else {


let dataSet13 = [];
let num13 = 0;

$('#further_entries_worked_on_month_table').DataTable().clear().destroy();


for(let i=0; i<json_result.data.length; i++) {
    let html = [];
    num13 = +num13 + 1;

    let fullname = json_result.data[i].fullname;
    let count = json_result.data[i].count;
    let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="further_entries_workedon_month"  
    class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `


    

    html.push(fullname);
    html.push(count);
    html.push(action);
  

    dataSet13.push(html);

  //console.log(dataSet)
  }


  $('#further_entries_worked_on_month_table').DataTable().clear().destroy();
                
  $('#further_entries_worked_on_month_table').DataTable({ data: dataSet13,
    dom : 'Bfrtip',
    lengthMenu : [
        [ 10, 25, 50, -1 ],
        [ '10 rows', '25 rows',
            '50 rows', 'Show all' ] ],
    buttons : [ 'pageLength', 'copy',
        'csv', 'excel', 'pdf', 'print' ] }).draw();


}


     }
 })


}) 







// further_entries_worked_on_year


$('#further_entries_worked_on_year').on('click', function(e) {
    e.preventDefault();

  $("#further_entries_worked_on_year_modal").modal("show");  

 var regional_code = $('#csau_manager_regional_code').val();
console.log(regional_code);


 $.ajax({
     type : "POST",
     url : "csau_manager_dashboard_backoffice",
     data : {
         request_type : 'select_count_worked_on_further_entries_officers_year',
         regional_code : regional_code.trim()
     },
     cache: false,
     success: function(response) {
        // console.log(response);

         var json_result = JSON.parse(response);

         if (json_result.data == null){

            // console.log("data not found");       

}else {


let dataSet19 = [];
let num19 = 0;

$('#further_entries_worked_on_year_table').DataTable().clear().destroy();


for(let i=0; i<json_result.data.length; i++) {
    let html = [];
    num19 = +num19 + 1;

    let fullname = json_result.data[i].fullname;
    let count = json_result.data[i].count;
    let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="further_entries_workedon_month"  
    class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `


    

    html.push(fullname);
    html.push(count);
    html.push(action);
  

    dataSet19.push(html);

  //console.log(dataSet)
  }


  $('#further_entries_worked_on_year_table').DataTable().clear().destroy();
                
  $('#further_entries_worked_on_year_table').DataTable({ data: dataSet19,
    dom : 'Bfrtip',
    lengthMenu : [
        [ 10, 25, 50, -1 ],
        [ '10 rows', '25 rows',
            '50 rows', 'Show all' ] ],
    buttons : [ 'pageLength', 'copy',
        'csv', 'excel', 'pdf', 'print' ] }).draw();


}


     }
 })


}) 










    // Applications Futher Entries worked on today 
    $(document).on('click','#further_entries_workedon_today',function(e){
        e.preventDefault();
        var user_created_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');
        //var user_created_name = $(e.currentTarget).data("name");
      
        document.getElementById('staff_name5').innerHTML = user_created_name;
      
        //console.log(user_created_id,user_created_name);
       
      $("#further_entries_workedon_today_modal").modal("show");  
       
      
       let dataSet20 = [];
       let num20 = 0;
      
      $('#further_entries_workedon_today_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "csau_manager_dashboard_backoffice",
           data : {
               request_type : 'select_applications_workedon_today_by_csau_futher_entries_offic',
               created_by_id : user_created_id
           },
           cache: false,
           success: function(response) {
      
           // console.log(response)
      
               var json_result = JSON.parse(response);
               console.log(json_result)
      
               if (json_result.data == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.data.length; i++) {
          let html = [];
          num20 = +num20 + 1;
      
          let job_number = json_result.data[i].job_number;
          let ar_name = json_result.data[i].ar_name;
          let business_process_name = json_result.data[i].business_process_name;
          let modified_date = json_result.data[i].modified_date;
          let job_status = json_result.data[i].job_status;
    
          
      
          html.push(job_number);
          html.push(ar_name);
          html.push(business_process_name);
          html.push(modified_date);
          html.push(job_status);
         
      
          dataSet20.push(html);
      
        
        }
     
        $('#further_entries_workedon_today_table').DataTable().clear().destroy();
                      
        $('#further_entries_workedon_today_table').DataTable({ data: dataSet20,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            buttons : [ 'pageLength', 'copy',
                'csv', 'excel', 'pdf', 'print' ] }).draw();
      
      }
              
      
      
           }
       })
       
      
      });






          // Applications Futher Entries worked on Week 
    $(document).on('click','#further_entries_workedon_week',function(e){
        e.preventDefault();
        var user_created_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');
        //var user_created_name = $(e.currentTarget).data("name");
      
        document.getElementById('staff_name6').innerHTML = user_created_name;
      
        //console.log(user_created_id,user_created_name);
       
      $("#further_entries_workedon_week_modal").modal("show");  
       
      
       let dataSet21 = [];
       let num21 = 0;
      
      $('#further_entries_workedon_week_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "csau_manager_dashboard_backoffice",
           data : {
               request_type : 'select_applications_workedon_today_by_csau_futher_entries_offic',
               created_by_id : user_created_id
           },
           cache: false,
           success: function(response) {
      
           // console.log(response)
      
               var json_result = JSON.parse(response);
               console.log(json_result)
      
               if (json_result.data == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.data.length; i++) {
          let html = [];
          num21 = +num21 + 1;
      
          let job_number = json_result.data[i].job_number;
          let ar_name = json_result.data[i].ar_name;
          let business_process_name = json_result.data[i].business_process_name;
          let modified_date = json_result.data[i].modified_date;
          let job_status = json_result.data[i].job_status;
    
          
      
          html.push(job_number);
          html.push(ar_name);
          html.push(business_process_name);
          html.push(modified_date);
          html.push(job_status);
         
      
          dataSet21.push(html);
      
        
        }
     
        $('#further_entries_workedon_week_table').DataTable().clear().destroy();
                      
        $('#further_entries_workedon_week_table').DataTable({ data: dataSet21,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            buttons : [ 'pageLength', 'copy',
                'csv', 'excel', 'pdf', 'print' ] }).draw();
      
      }
              
      
      
           }
       })
       
      
      });




                // Applications Futher Entries worked on month 
    $(document).on('click','#further_entries_workedon_week',function(e){
        e.preventDefault();
        var user_created_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');
        //var user_created_name = $(e.currentTarget).data("name");
      
        document.getElementById('staff_name6').innerHTML = user_created_name;
      
        //console.log(user_created_id,user_created_name);
       
      $("#further_entries_workedon_week_modal").modal("show");  
       
      
       let dataSet22 = [];
       let num22 = 0;
      
      $('#further_entries_workedon_week_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "csau_manager_dashboard_backoffice",
           data : {
               request_type : 'select_applications_workedon_week_by_csau_futher_entries_offic',
               created_by_id : user_created_id
           },
           cache: false,
           success: function(response) {
      
           // console.log(response)
      
               var json_result = JSON.parse(response);
               console.log(json_result)
      
               if (json_result.data == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.data.length; i++) {
          let html = [];
          num22 = +num22 + 1;
      
          let job_number = json_result.data[i].job_number;
          let ar_name = json_result.data[i].ar_name;
          let business_process_name = json_result.data[i].business_process_name;
          let modified_date = json_result.data[i].modified_date;
          let job_status = json_result.data[i].job_status;
    
          
      
          html.push(job_number);
          html.push(ar_name);
          html.push(business_process_name);
          html.push(modified_date);
          html.push(job_status);
         
      
          dataSet22.push(html);
      
        
        }
     
        $('#further_entries_workedon_week_table').DataTable().clear().destroy();
                      
        $('#further_entries_workedon_week_table').DataTable({ data: dataSet22,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            buttons : [ 'pageLength', 'copy',
                'csv', 'excel', 'pdf', 'print' ] }).draw();
      
      }
              
      
      
           }
       })
       
      
      });






                    // Applications Futher Entries worked on month 
    $(document).on('click','#further_entries_workedon_month',function(e){
        e.preventDefault();
        var user_created_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');
        //var user_created_name = $(e.currentTarget).data("name");
      
        document.getElementById('staff_name7').innerHTML = user_created_name;
      
        //console.log(user_created_id,user_created_name);
       
      $("#further_entries_workedon_month_modal").modal("show");  
       
      
       let dataSet23 = [];
       let num23 = 0;
      
      $('#further_entries_workedon_month_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "csau_manager_dashboard_backoffice",
           data : {
               request_type : 'select_applications_workedon_month_by_csau_futher_entries_offic',
               created_by_id : user_created_id
           },
           cache: false,
           success: function(response) {
      
           // console.log(response)
      
               var json_result = JSON.parse(response);
               console.log(json_result)
      
               if (json_result.data == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.data.length; i++) {
          let html = [];
          num23 = +num23 + 1;
      
          let job_number = json_result.data[i].job_number;
          let ar_name = json_result.data[i].ar_name;
          let business_process_name = json_result.data[i].business_process_name;
          let modified_date = json_result.data[i].modified_date;
          let job_status = json_result.data[i].job_status;
    
          
      
          html.push(job_number);
          html.push(ar_name);
          html.push(business_process_name);
          html.push(modified_date);
          html.push(job_status);
         
      
          dataSet23.push(html);
      
        
        }
     
        $('#further_entries_workedon_month_table').DataTable().clear().destroy();
                      
        $('#further_entries_workedon_month_table').DataTable({ data: dataSet23,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            buttons : [ 'pageLength', 'copy',
                'csv', 'excel', 'pdf', 'print' ] }).draw();
      
      }
              
      
      
           }
       })
       
      
      });

    







                    // Applications Futher Entries worked on month 
    $(document).on('click','#further_entries_workedon_year',function(e){
        e.preventDefault();
        var user_created_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');
        //var user_created_name = $(e.currentTarget).data("name");
      
        document.getElementById('staff_name8').innerHTML = user_created_name;
      
        //console.log(user_created_id,user_created_name);
       
      $("#further_entries_workedon_year_modal").modal("show");  
       
      
       let dataSet24 = [];
       let num24 = 0;
      
      $('#further_entries_workedon_year_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "csau_manager_dashboard_backoffice",
           data : {
               request_type : 'select_applications_workedon_year_by_csau_futher_entries_offic',
               created_by_id : user_created_id
           },
           cache: false,
           success: function(response) {
      
           // console.log(response)
      
               var json_result = JSON.parse(response);
               console.log(json_result)
      
               if (json_result.data == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.data.length; i++) {
          let html = [];
          num24 = +num24 + 1;
      
          let job_number = json_result.data[i].job_number;
          let ar_name = json_result.data[i].ar_name;
          let business_process_name = json_result.data[i].business_process_name;
          let modified_date = json_result.data[i].modified_date;
          let job_status = json_result.data[i].job_status;
    
          
      
          html.push(job_number);
          html.push(ar_name);
          html.push(business_process_name);
          html.push(modified_date);
          html.push(job_status);
         
      
          dataSet24.push(html);
      
        
        }
     
        $('#further_entries_workedon_year_table').DataTable().clear().destroy();
                      
        $('#further_entries_workedon_year_table').DataTable({ data: dataSet24,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            buttons : [ 'pageLength', 'copy',
                'csv', 'excel', 'pdf', 'print' ] }).draw();
      
      }
              
      
      
           }
       })
       
      
      });


           // Daily Further Entries divisional
      $(document).on('click','#view_divisional_today_data',function(e){
        e.preventDefault();


        var division=$(this).data('id');
        var regional_code = $('#csau_manager_regional_code').val();

       
        // var user_created_name=$(this).data('name_full');
        //var user_created_name = $(e.currentTarget).data("name");
      
        document.getElementById('division_name').innerHTML = division;
      
        console.log(division,regional_code);
       
      $("#view_divisional_today_data_modal").modal("show");  
       
      
       let dataSet15 = [];
       let num15 = 0;
      
      $('#view_divisional_today_data_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "csau_manager_dashboard_backoffice",
           data : {
               request_type : 'load_apps_backoffice_further_entries_apps_by_divisions_today',
               regional_code : regional_code,
               regional_division : division
           },
           cache: false,
           success: function(response) {
      
            console.log(response)
      
               var json_result = JSON.parse(response);
               console.log(json_result)
      
               if (json_result.data == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.data.length; i++) {
          let html = [];
          num15 = +num15 + 1;
      
          let job_number = json_result.data[i].job_number;
          let ar_name = json_result.data[i].ar_name;
          let business_process_name = json_result.data[i].business_process_name;
          let created_date = json_result.data[i].created_date;
          let age_of_application = json_result.data[i].age_of_application;
    
          
      
          html.push(job_number);
          html.push(ar_name);
          html.push(business_process_name);
          html.push(created_date);
          html.push(age_of_application);
         
      
          dataSet15.push(html);
      
        
        }
     
        $('#view_divisional_today_data_table').DataTable().clear().destroy();
                      
        $('#view_divisional_today_data_table').DataTable({ data: dataSet15,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            buttons : [ 'pageLength', 'copy',
                'csv', 'excel', 'pdf', 'print' ] }).draw();
      
      }
              
      
      
           }
       })
       
      
      });



                // Weekly Further Entries divisional
                $(document).on('click','#view_divisional_week_data',function(e){
                    e.preventDefault();
            
            
                    var division=$(this).data('id');
                    var regional_code = $('#csau_manager_regional_code').val();
            
                   
                    // var user_created_name=$(this).data('name_full');
                    //var user_created_name = $(e.currentTarget).data("name");
                  
                    document.getElementById('division_name1').innerHTML = division;
                  
                    console.log(division,regional_code);
                   
                  $("#view_divisional_week_data_modal").modal("show");  
                   
                  
                   let dataSet16 = [];
                   let num16 = 0;
                  
                  $('#view_divisional_week_data_table').DataTable().clear().destroy();
                  
                   $.ajax({
                       type : "POST",
                       url : "csau_manager_dashboard_backoffice",
                       data : {
                           request_type : 'load_apps_backoffice_further_entries_apps_by_divisions_week',
                           regional_code : regional_code,
                           regional_division : division
                       },
                       cache: false,
                       success: function(response) {
                  
                        console.log(response)
                  
                           var json_result = JSON.parse(response);
                           console.log(json_result)
                  
                           if (json_result.data == null){
                  
                            console.log("data not found");       
                  
                  }else {
                  
                    for(let i=0; i<json_result.data.length; i++) {
                      let html = [];
                      num16 = +num16 + 1;
                  
                      let job_number = json_result.data[i].job_number;
                      let ar_name = json_result.data[i].ar_name;
                      let business_process_name = json_result.data[i].business_process_name;
                      let created_date = json_result.data[i].created_date;
                      let age_of_application = json_result.data[i].age_of_application;
                
                      
                  
                      html.push(job_number);
                      html.push(ar_name);
                      html.push(business_process_name);
                      html.push(created_date);
                      html.push(age_of_application);
                     
                  
                      dataSet16.push(html);
                  
                    
                    }
                 
                    $('#view_divisional_week_data_table').DataTable().clear().destroy();
                                  
                    $('#view_divisional_week_data_table').DataTable({ data: dataSet16,
                        dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] }).draw();
                  
                  }
                          
                  
                  
                       }
                   })
                   
                  
                  });







                // Monthly Further Entries divisional
                $(document).on('click','#view_divisional_month_data',function(e){
                    e.preventDefault();
            
            
                    var division=$(this).data('id');
                    var regional_code = $('#csau_manager_regional_code').val();
            
                   
                    // var user_created_name=$(this).data('name_full');
                    //var user_created_name = $(e.currentTarget).data("name");
                  
                    document.getElementById('division_name2').innerHTML = division;
                  
                    console.log(division,regional_code);
                   
                  $("#view_divisional_month_data_modal").modal("show");  
                   
                  
                   let dataSet17 = [];
                   let num17 = 0;
                  
                  $('#view_divisional_month_data_table').DataTable().clear().destroy();
                  
                   $.ajax({
                       type : "POST",
                       url : "csau_manager_dashboard_backoffice",
                       data : {
                           request_type : 'load_apps_backoffice_further_entries_apps_by_divisions_month',
                           regional_code : regional_code,
                           regional_division : division
                       },
                       cache: false,
                       success: function(response) {
                  
                        console.log(response)
                  
                           var json_result = JSON.parse(response);
                           console.log(json_result)
                  
                           if (json_result.data == null){
                  
                            console.log("data not found");       
                  
                  }else {
                  
                    for(let i=0; i<json_result.data.length; i++) {
                      let html = [];
                      num17 = +num17 + 1;
                  
                      let job_number = json_result.data[i].job_number;
                      let ar_name = json_result.data[i].ar_name;
                      let business_process_name = json_result.data[i].business_process_name;
                      let created_date = json_result.data[i].created_date;
                      let age_of_application = json_result.data[i].age_of_application;
                
                      
                  
                      html.push(job_number);
                      html.push(ar_name);
                      html.push(business_process_name);
                      html.push(created_date);
                      html.push(age_of_application);
                     
                  
                      dataSet17.push(html);
                  
                    
                    }
                 
                    $('#view_divisional_month_data_table').DataTable().clear().destroy();
                                  
                    $('#view_divisional_month_data_table').DataTable({ data: dataSet17,
                        dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] }).draw();
                  
                  }
                          
                  
                  
                       }
                   })
                   
                  
                  });






                                // YEARLY Further Entries divisional
                $(document).on('click','#view_divisional_year_data',function(e){
                    e.preventDefault();
            
            
                    var division=$(this).data('id');
                    var regional_code = $('#csau_manager_regional_code').val();
            
                   
                    // var user_created_name=$(this).data('name_full');
                    //var user_created_name = $(e.currentTarget).data("name");
                  
                    document.getElementById('division_name3').innerHTML = division;
                  
                    console.log(division,regional_code);
                   
                  $("#view_divisional_year_data_modal").modal("show");  
                   
                  
                   let dataSet18 = [];
                   let num18 = 0;
                  
                  $('#view_divisional_year_data_table').DataTable().clear().destroy();
                  
                   $.ajax({
                       type : "POST",
                       url : "csau_manager_dashboard_backoffice",
                       data : {
                           request_type : 'load_apps_backoffice_further_entries_apps_by_divisions_year',
                           regional_code : regional_code,
                           regional_division : division
                       },
                       cache: false,
                       success: function(response) {
                  
                        console.log(response)
                  
                           var json_result = JSON.parse(response);
                           console.log(json_result)
                  
                           if (json_result.data == null){
                  
                            console.log("data not found");       
                  
                  }else {
                  
                    for(let i=0; i<json_result.data.length; i++) {
                      let html = [];
                      num18 = +num18 + 1;
                  
                      let job_number = json_result.data[i].job_number;
                      let ar_name = json_result.data[i].ar_name;
                      let business_process_name = json_result.data[i].business_process_name;
                      let created_date = json_result.data[i].created_date;
                      let age_of_application = json_result.data[i].age_of_application;
                
                      
                  
                      html.push(job_number);
                      html.push(ar_name);
                      html.push(business_process_name);
                      html.push(created_date);
                      html.push(age_of_application);
                     
                  
                      dataSet18.push(html);
                  
                    
                    }
                 
                    $('#view_divisional_year_data_table').DataTable().clear().destroy();
                                  
                    $('#view_divisional_year_data_table').DataTable({ data: dataSet18,
                        dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] }).draw();
                  
                  }
                          
                  
                  
                       }
                   })
                   
                  
                  });
            

      


});