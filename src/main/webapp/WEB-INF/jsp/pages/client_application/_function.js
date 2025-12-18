$(document).ready(function() {

  // applications recieved today

  $('#csau_applications_received_today').on('click', function(e) {
      e.preventDefault();

   $("#recievedtodayModal").modal("show");  


      var regional_code = $('#csau_manager_regional_code').val();
      console.log(regional_code);


      $.ajax({
          type : "POST",
          url : "csau_manager_dashboard",
          data : {
              request_type : 'select_count_received_today_by_csau_front_officers',
              regional_code : regional_code.trim()
          },
          cache: false,
          success: function(response) {

              var json_result = JSON.parse(response);

              if (json_result.data == null){

                alert('Sorry Data Not Found');

  
  }else {

      let dataSet1 = [];
      let num1 = 0;

    $('#recievedtoday').DataTable().clear().destroy();



      for(let i=0; i<json_result.data.length; i++) {
          let html = [];
          num1 = +num1 + 1;

          let fullname = json_result.data[i].fullname;
          let count = json_result.data[i].count;
          let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_daily_officer_apps"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          

          html.push(fullname);
          html.push(count);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);

          dataSet1.push(html);

        //console.log(dataSet)
        }

      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })

        $('#recievedtoday').DataTable().clear().destroy();
                      
        $('#recievedtoday').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        

   }

             

             


          }
      })
  })





   // bills created and paid today
   $('#bills_created_and_paid_today').on('click', function(e) {
    e.preventDefault();

 $("#billcreatedandpaidModal").modal("show"); 

    var regional_code = $('#csau_manager_regional_code').val();
   // console.log(regional_code);


    $.ajax({
        type : "POST",
        url : "csau_manager_dashboard",
        data : {
            request_type : 'select_bills_today_by_csau_front_officers_and_paid',
            regional_code : regional_code.trim()
        },
        cache: false,
        success: function(response) {

            var json_result = JSON.parse(response);

            console.log(json_result)

            if (json_result.data == null){

                // console.log("data not found");      
                alert('Sorry Data Not Found'); 

}else {

    let dataSet52 = [];
    let num52 = 0;

  $('#billcreatedandpaidTable').DataTable().clear().destroy();


    for(let i=0; i<json_result.data.length; i++) {
        let html = [];
        num52 = +num52 + 1;

        let fullname = json_result.data[i].fullname;
        let count = json_result.data[i].count;
        let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_daily_officer_created_and_paid_bills"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        

        html.push(fullname);
        html.push(count);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);

        dataSet52.push(html);

      //console.log(dataSet)
      }

    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })

      $('#billcreatedandpaidTable').DataTable().clear().destroy();
                    
      $('#billcreatedandpaidTable').DataTable({ data: dataSet52,
        dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ]
       }).draw();

}

            

          


        }
    })
})







     // bills created and acknowledged today
     $('#bills_created_and_acknowledged_today').on('click', function(e) {
      e.preventDefault();

   $("#billcreatedandacknowledgedModal").modal("show"); 

      var regional_code = $('#csau_manager_regional_code').val();
      console.log(regional_code);


      $.ajax({
          type : "POST",
          url : "csau_manager_dashboard",
          data : {
              request_type : 'select_bills_today_by_csau_front_officers_and_acknowledged',
              regional_code : regional_code.trim()
          },
          cache: false,
          success: function(response) {

              var json_result = JSON.parse(response);

              console.log(json_result)

              if (json_result.data == null){

                  // console.log("data not found");       
                  alert('Sorry Data Not Found');
  
  }else {

      let dataSet54 = [];
      let num54 = 0;

    $('#billcreatedandAckTable').DataTable().clear().destroy();


      for(let i=0; i<json_result.data.length; i++) {
          let html = [];
          num54 = +num54 + 1;

          let fullname = json_result.data[i].fullname;
          let count = json_result.data[i].count;
          let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_daily_officer_created_and_ack_bills"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          

          html.push(fullname);
          html.push(count);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);

          dataSet54.push(html);

        //console.log(dataSet)
        }

      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })

        $('#billcreatedandAckTable').DataTable().clear().destroy();
                      
        $('#billcreatedandAckTable').DataTable({ data: dataSet54,
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








// View Daily Paid applications 
$(document).on('click','#view_daily_officer_created_and_paid_bills',function(e){
e.preventDefault();
var user_created_id=$(this).data('id');

var user_created_name=$(this).data('name_full');
//var user_created_name = $(e.currentTarget).data("name");

document.getElementById('staff_name53').innerHTML = user_created_name;

//console.log(user_created_id,user_created_name);

$("#today_bills_created_modal").modal("show");  


let dataSet53 = [];
let num53 = 0;

$('#today_bills_created_table').DataTable().clear().destroy();

$.ajax({
   type : "POST",
   url : "csau_manager_dashboard",
   data : {
       request_type : 'get_bills_created_by_csau_front_officers_today_and_paid',
       created_by_id : user_created_id
   },
   cache: false,
   success: function(response) {

   // console.log(response)

       var json_result = JSON.parse(response);
       console.log(json_result)

       if (json_result.data == null){

       //console.log("data not found");  
       
       alert('Sorry Data Not Found');

}else {

for(let i=0; i<json_result.data.length; i++) {
  let html = [];
  num53 = +num53 + 1;

  let lessees_name = json_result.data[i].lessees_name;
  let business_process_name = json_result.data[i].business_process_name;
  let ref_number = json_result.data[i].ref_number;
  let payment_status = json_result.data[i].payment_status;
  let created_date = json_result.data[i].created_date;
 // let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  

  html.push(lessees_name);
  html.push(business_process_name);
  html.push(ref_number);
  html.push(payment_status);
  html.push(created_date);

  dataSet53.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#today_bills_created_table').DataTable().clear().destroy();
              
$('#today_bills_created_table').DataTable({ data: dataSet53,
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










// View Daily Acknowledged applications 

$(document).on('click','#view_daily_officer_created_and_ack_bills',function(e){
e.preventDefault();
var user_created_id=$(this).data('id');

var user_created_name=$(this).data('name_full');
//var user_created_name = $(e.currentTarget).data("name");

document.getElementById('staff_name54').innerHTML = user_created_name;

//console.log(user_created_id,user_created_name);

$("#today_bills_acknowledged_modal").modal("show");  


let dataSet55 = [];
let num55 = 0;

$('#today_bills_acknowledged_table').DataTable().clear().destroy();

$.ajax({
   type : "POST",
   url : "csau_manager_dashboard",
   data : {
       request_type : 'get_bills_created_by_csau_front_officers_today_and_acknowledged',
       created_by_id : user_created_id
   },
   cache: false,
   success: function(response) {

   // console.log(response)

       var json_result = JSON.parse(response);
       console.log(json_result)

       if (json_result.data == null){

       //console.log("data not found");      
       alert('Sorry Data Not Found'); 

}else {

for(let i=0; i<json_result.data.length; i++) {
  let html = [];
  num55 = +num55 + 1;

  let lessees_name = json_result.data[i].lessees_name;
  let business_process_name = json_result.data[i].business_process_name;
  let job_number = json_result.data[i].job_number;
  let ref_number = json_result.data[i].ref_number;
  let payment_status = json_result.data[i].payment_status;
  let created_date = json_result.data[i].created_date;
 // let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  

  html.push(lessees_name);
  html.push(business_process_name);
  html.push(job_number);
  html.push(ref_number);
  html.push(payment_status);
  html.push(created_date);

  dataSet55.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#today_bills_acknowledged_table').DataTable().clear().destroy();
              
$('#today_bills_acknowledged_table').DataTable({ data: dataSet55,
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











// applications recieved this week
  $('#csau_applications_received_week').on('click', function(e) {
      e.preventDefault();

   $("#recievedWeekModal").modal("show"); 

      var regional_code = $('#csau_manager_regional_code').val();
      console.log(regional_code);


      $.ajax({
          type : "POST",
          url : "csau_manager_dashboard",
          data : {
              request_type : 'select_count_received_week_by_csau_front_officers',
              regional_code : regional_code.trim()
          },
          cache: false,
          success: function(response) {

              var json_result = JSON.parse(response);

              if (json_result.data == null){

                  // console.log("data not found");   
                  alert('Sorry Data Not Found');    
  
  }else {

      let dataSet15 = [];
      let num15 = 0;

    $('#recievedWeek').DataTable().clear().destroy();


      for(let i=0; i<json_result.data.length; i++) {
          let html = [];
          num15 = +num15 + 1;

          let fullname = json_result.data[i].fullname;
          let count = json_result.data[i].count;
          let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_weekly_officer_apps"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          

          html.push(fullname);
          html.push(count);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);

          dataSet15.push(html);

        //console.log(dataSet)
        }

      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })

        $('#recievedWeek').DataTable().clear().destroy();
                      
        $('#recievedWeek').DataTable({ data: dataSet15,
          dom : 'Bfrtip',
          lengthMenu : [
              [ 10, 25, 50, -1 ],
              [ '10 rows', '25 rows',
                  '50 rows', 'Show all' ] ],
          buttons : [ 'pageLength', 'copy',
              'csv', 'excel', 'pdf', 'print' ] }).draw();

  }

              //console.log(json_result)

            


          }
      })
  })






  $('#csau_applications_received_this_month').on('click', function(e) {
      e.preventDefault();

   $("#recievedMonthModal").modal("show");  

      var regional_code = $('#csau_manager_regional_code').val();
      console.log(regional_code);

      $.ajax({
          type : "POST",
          url : "csau_manager_dashboard",
          data : {
              request_type : 'select_count_received_month_by_csau_front_officers',
              regional_code : regional_code.trim()
          },
          cache: false,
          success: function(response) {

              var json_result = JSON.parse(response);
             
              if (json_result.data == null){

                  // console.log("data not found");       
                  alert('Sorry Data Not Found');
  
  }else {


      let dataSet2 = [];
      let num2 = 0;

    $('#recievedMonth').DataTable().clear().destroy();


      for(let i=0; i<json_result.data.length; i++) {
          let html = [];
          num2 = +num2 + 1;

          let fullname = json_result.data[i].fullname;
          let count = json_result.data[i].count;
          let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_front_officer_monthly_apps"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
         ;
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          

          html.push(fullname);
          html.push(count);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);

          dataSet2.push(html);

        //console.log(dataSet)
        }

      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })

        $('#recievedMonth').DataTable().clear().destroy();
                      
        $('#recievedMonth').DataTable({ data: dataSet2,
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





// $('#csau_applications_received_this_month').on('click', function(e) {
//     e.preventDefault();

//  $("#recievedMonthModal").modal("show");  

//     var regional_code = $('#csau_manager_regional_code').val();
//     console.log(regional_code);

//     let dataSet2 = [];
//     let num2 = 0;

//   $('#recievedMonth').DataTable().clear().destroy();

//     $.ajax({
//         type : "POST",
//         url : "csau_manager_dashboard",
//         data : {
//             request_type : 'select_count_received_month_by_csau_front_officers',
//             regional_code : regional_code.trim()
//         },
//         cache: false,
//         success: function(response) {

//             var json_result = JSON.parse(response);
//             console.log(json_result)

//             for(let i=0; i<json_result.data.length; i++) {
//                 let html = [];
//                 num2 = +num2 + 1;

//                 let fullname = json_result.data[i].fullname;
//                 let count = json_result.data[i].count;
//                 let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
//                 // let payment_status = e[i].payment_status;
//                 // let buttons = e[i].buttons;
              

//                 html.push(fullname);
//                 html.push(count);
//                 html.push(action);
//                 // html.push(payment_status);
//                 // html.push(buttons);

//                 dataSet2.push(html);

//               //console.log(dataSet)
//               }

//             // let dataTable_Obj = $('#recievedtoday').DataTable({
//             //     data: dataSet1
//             //   })

//               $('#recievedMonth').DataTable().clear().destroy();
                          
//               $('#recievedMonth').DataTable({ data: dataSet2 }).draw();


//         }
//     })
// })





$('#csau_applications_received_this_year').on('click', function(e) {
  e.preventDefault();

$("#recievedYearModal").modal("show");  

  var regional_code = $('#csau_manager_regional_code').val();
  console.log(regional_code);

  $.ajax({
      type : "POST",
      url : "csau_manager_dashboard",
      data : {
          request_type : 'select_count_received_year_by_csau_front_officers',
          regional_code : regional_code.trim()
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);

          if (json_result.data == null){

              // console.log("data not found");       
              alert('Sorry Data Not Found');

}else {

  let dataSet3 = [];
  let num3 = 0;

$('#recievedYear').DataTable().clear().destroy();


  for(let i=0; i<json_result.data.length; i++) {
      let html = [];
      num3 = +num3 + 1;

      let fullname = json_result.data[i].fullname;
      let count = json_result.data[i].count;
      let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_front_officer_yearly_apps"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `;
      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(fullname);
      html.push(count);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet3.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#recievedYear').DataTable().clear().destroy();
                  
    $('#recievedYear').DataTable({ data: dataSet3,
      dom : 'Bfrtip',
      lengthMenu : [
          [ 10, 25, 50, -1 ],
          [ '10 rows', '25 rows',
              '50 rows', 'Show all' ] ],
      buttons : [ 'pageLength', 'copy',
          'csv', 'excel', 'pdf', 'print' ] }).draw();

}

          console.log(json_result)

         


      }
  })
})




$(document).on('click','#view_front_officer_yearly_apps',function(e){
  e.preventDefault();
  var user_created_id=$(this).data('id');
  
  var user_created_name=$(this).data('name_full');
  //var user_created_name = $(e.currentTarget).data("name");

  document.getElementById('staffname').innerHTML = user_created_name;
  //var user_created_name = $(e.currentTarget).data("name");
 
  $("#csau_staff_yearly_apps_modal").modal("show");  
 console.log(user_created_id);
 

 $.ajax({
     type : "POST",
     url : "csau_manager_dashboard",
     data : {
         request_type : 'select_applications_received_year_by_csau_front_officers',
         created_by : user_created_id
     },
     cache: false,
     success: function(response) {

      console.log(response)

         var json_result = JSON.parse(response);

         if (json_result.data == null){

          let dataSet4 = [];
          let num4 = 0;
       
        $('#csau_staff_yearly_apps_view').DataTable().clear().destroy();

          // console.log("data not found");       
          alert('Sorry Data Not Found');

}else {

let dataSet4 = [];
let num4 = 0;

$('#csau_staff_yearly_apps_view').DataTable().clear().destroy();



for(let i=0; i<json_result.data.length; i++) {
  let html = [];
  num4 = +num4 + 1;

  let job_number = json_result.data[i].job_number;
  let ar_name = json_result.data[i].ar_name;
  let business_process_name = json_result.data[i].business_process_name;
  let created_date = json_result.data[i].created_date;
 // let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  

  html.push(job_number);
  html.push(ar_name);
  html.push(business_process_name);
  html.push(created_date);
  // html.push(buttons);

  dataSet4.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#csau_staff_yearly_apps_view').DataTable().clear().destroy();
              
$('#csau_staff_yearly_apps_view').DataTable({ data: dataSet4,
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
});


// View Daily Apps 


$(document).on('click','#view_daily_officer_apps',function(e){
e.preventDefault();
var user_created_id=$(this).data('id');

var user_created_name=$(this).data('name_full');
//var user_created_name = $(e.currentTarget).data("name");

document.getElementById('staff_name51').innerHTML = user_created_name;

console.log(user_created_id,user_created_name);

$("#csau_staff_daily_apps_modal").modal("show");  



let dataSet51 = [];
let num51 = 0;

$('#csau_staff_daily_apps_table').DataTable().clear().destroy();

$.ajax({
   type : "POST",
   url : "csau_manager_dashboard",
   data : {
       request_type : 'select_applications_received_today_by_csau_front_officers',
       created_by_id : user_created_id
   },
   cache: false,
   success: function(response) {

    console.log(response)

       var json_result = JSON.parse(response);
       console.log(json_result)

       if (json_result.data == null){

        // console.log("data not found"); 
        alert('Sorry Data Not Found');      

}else {

for(let i=0; i<json_result.data.length; i++) {
  let html = [];
  num51 = +num51 + 1;

  let job_number = json_result.data[i].job_number;
  let ar_name = json_result.data[i].ar_name;
  let business_process_name = json_result.data[i].business_process_name;
  let created_date = json_result.data[i].created_date;
 // let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  

  html.push(job_number);
  html.push(ar_name);
  html.push(business_process_name);
  html.push(created_date);
  // html.push(buttons);

  dataSet51.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#csau_staff_daily_apps_table').DataTable().clear().destroy();
              
$('#csau_staff_daily_apps_table').DataTable({ data: dataSet51,
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










// view officer weekly applications

$(document).on('click','#view_weekly_officer_apps',function(e){
  e.preventDefault();
  var user_created_id=$(this).data('id');
 
  var user_created_name=$(this).data('name_full');
  //var user_created_name = $(e.currentTarget).data("name");

  document.getElementById('staff_name5').innerHTML = user_created_name;
 
$("#csau_staff_weekly_apps_modal").modal("show");  
 console.log(user_created_name);
 

 let dataSet5 = [];
 let num5 = 0;

$('#csau_staff_weekly_apps_table').DataTable().clear().destroy();

 $.ajax({
     type : "POST",
     url : "csau_manager_dashboard",
     data : {
         request_type : 'select_applications_received_week_by_csau_front_officers',
         created_by_id : user_created_id
     },
     cache: false,
     success: function(response) {

      console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result)


         if (json_result.data == null){

          // console.log("data not found");       
          alert('Sorry Data Not Found');      

}else {


for(let i=0; i<json_result.data.length; i++) {
  let html = [];
  num5 = +num5 + 1;

  let job_number = json_result.data[i].job_number;
  let ar_name = json_result.data[i].ar_name;
  let business_process_name = json_result.data[i].business_process_name;
  let created_date = json_result.data[i].created_date;
 // let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  

  html.push(job_number);
  html.push(ar_name);
  html.push(business_process_name);
  html.push(created_date);
  // html.push(buttons);

  dataSet5.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#csau_staff_weekly_apps_table').DataTable().clear().destroy();
              
$('#csau_staff_weekly_apps_table').DataTable({ data: dataSet5,
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






$(document).on('click','#view_front_officer_monthly_apps',function(e){
  e.preventDefault();
  var user_created_id=$(this).data('id');
 
  var user_created_name=$(this).data('name_full');
  //var user_created_name = $(e.currentTarget).data("name");

  document.getElementById('staff_name7').innerHTML = user_created_name;
 
$("#csau_staff_monthly_apps_modal").modal("show");  
 console.log(user_created_name);
 


 $.ajax({
     type : "POST",
     url : "csau_manager_dashboard",
     data : {
         request_type : 'select_applications_received_month_by_csau_front_officers',
         created_by : user_created_id
     },
     cache: false,
     success: function(response) {

      //console.log(response)

         var json_result = JSON.parse(response);

         if (json_result.data == null){

          // console.log("data not found");       
          alert('Sorry Data Not Found');      

}else {

let dataSet16 = [];
let num16 = 0;

$('#csau_staff_monthly_apps_view').DataTable().clear().destroy();

for(let i=0; i<json_result.data.length; i++) {
  let html = [];
  num16 = +num16 + 1;

  let job_number = json_result.data[i].job_number;
  let ar_name = json_result.data[i].ar_name;
  let business_process_name = json_result.data[i].business_process_name;
  let created_date = json_result.data[i].created_date;
 // let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  

  html.push(job_number);
  html.push(ar_name);
  html.push(business_process_name);
  html.push(created_date);
  // html.push(buttons);

  dataSet16.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#csau_staff_monthly_apps_view').DataTable().clear().destroy();
              
$('#csau_staff_monthly_apps_view').DataTable({ data: dataSet16,
  dom : 'Bfrtip',
  lengthMenu : [
      [ 10, 25, 50, -1 ],
      [ '10 rows', '25 rows',
          '50 rows', 'Show all' ] ],
  buttons : [ 'pageLength', 'copy',
      'csv', 'excel', 'pdf', 'print' ] }).draw();

}
         
         //console.log(json_result)

        


     }
 })
});









// bills created


$('#6months_bills_created').on('click', function(e) {
  e.preventDefault();

$("#bill_createdModal").modal("show");  


  var regional_code = $('#csau_manager_regional_code').val();
  console.log(regional_code);


  $.ajax({
      type : "POST",
      url : "csau_manager_dashboard",
      data : {
          request_type : 'select_6months_bills_created_by_csau_front_officers',
          regional_code : regional_code.trim()
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);

          if (json_result.data == null){

              // console.log("data not found");       
              alert('Sorry Data Not Found');      

}else {

  let dataSet6 = [];
  let num6 = 0;

$('#bills_CreatedTable').DataTable().clear().destroy();


  for(let i=0; i<json_result.data.length; i++) {
      let html = [];
      num6 = +num6 + 1;

      let fullname = json_result.data[i].fullname;
      let count = json_result.data[i].count;
      let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_6months_bills"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(fullname);
      html.push(count);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet6.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#bills_CreatedTable').DataTable().clear().destroy();
                  
    $('#bills_CreatedTable').DataTable({ data: dataSet6,
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




$('#biils_created_and_paid').on('click', function(e) {
  e.preventDefault();

$("#bill_createdand_paidModal").modal("show");  


  var regional_code = $('#csau_manager_regional_code').val();
  console.log(regional_code);

  
  $.ajax({
      type : "POST",
      url : "csau_manager_dashboard",
      data : {
          request_type : 'select_bills_created_by_csau_front_officers_and_paid',
          regional_code : regional_code.trim()
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          
          if (json_result.data == null){

            alert('Sorry Data Not Found');      

}else {


  let dataSet7 = [];
  let num7 = 0;

$('#bills_Createdand_paidTable').DataTable().clear().destroy();


  for(let i=0; i<json_result.data.length; i++) {
      let html = [];
      num7 = +num7 + 1;

      let fullname = json_result.data[i].fullname;
      let count = json_result.data[i].count;
      let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_6months_bills_paid"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(fullname);
      html.push(count);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet7.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#bills_Createdand_paidTable').DataTable().clear().destroy();
                  
    $('#bills_Createdand_paidTable').DataTable({ data: dataSet7,
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




$('#bills_created_and_acknowledged').on('click', function(e) {
  e.preventDefault();

$("#bills_paid_and_acknowleged_Modal").modal("show");  


  var regional_code = $('#csau_manager_regional_code').val();
  console.log(regional_code);

 

  $.ajax({
      type : "POST",
      url : "csau_manager_dashboard",
      data : {
          request_type : 'select_bills_created_by_csau_front_officers_and_acknowledged',
          regional_code : regional_code.trim()
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          
          if (json_result.data == null){

            alert('Sorry Data Not Found');      

}else {

  let dataSet8 = [];
  let num8 = 0;

$('#bills_paid_and_acknlowledged_Table').DataTable().clear().destroy();

  for(let i=0; i<json_result.data.length; i++) {
      let html = [];
      num8 = +num8 + 1;

      let fullname = json_result.data[i].fullname;
      let count = json_result.data[i].count;
      let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_6months_bills_acknow"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(fullname);
      html.push(count);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet8.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#bills_paid_and_acknlowledged_Table').DataTable().clear().destroy();
                  
    $('#bills_paid_and_acknlowledged_Table').DataTable({ data: dataSet8,
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




// bill created past 6 months



$(document).on('click','#view_6months_bills',function(e){
  e.preventDefault();
  var user_created_id=$(this).data('id');
 
  var user_created_name=$(this).data('name_full');
  //var user_created_name = $(e.currentTarget).data("name");

  document.getElementById('staff_name1').innerHTML = user_created_name;
 
  $("#csau_6months_biils_modal").modal("show");  
 console.log(user_created_name);
 

let dataSet9 = [];
 let num9 = 0;

$('#csau_staff_6months_bills_view').DataTable().clear().destroy(); 

 $.ajax({
     type : "POST",
     url : "csau_manager_dashboard",
     data : {
         request_type : 'get_bills_created_by_csau_front_officers_last6months',
         created_by_id : user_created_id
     },
     cache: false,
     success: function(response) {

      console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result)

         for(let i=0; i<json_result.data.length; i++) {
             let html = [];
             num9 = +num9 + 1;

             let lessees_name = json_result.data[i].lessees_name;
             let business_process_name = json_result.data[i].business_process_name;
             let ref_number = json_result.data[i].ref_number;
             let payment_status = json_result.data[i].payment_status;
             let created_date = json_result.data[i].created_date;
            // let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
             // let payment_status = e[i].payment_status;
             // let buttons = e[i].buttons;
             
           

             html.push(lessees_name);
             html.push(business_process_name);
             html.push(ref_number);
             html.push(payment_status);
             html.push(created_date);

             dataSet9.push(html);

           //console.log(dataSet)
           }

      //    let dataTable_Obj = $('#recievedtoday').DataTable({
      //        data: dataSet9
      //      })

           $('#csau_staff_6months_bills_view').DataTable().clear().destroy();
                         
           $('#csau_staff_6months_bills_view').DataTable({ data: dataSet9,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            buttons : [ 'pageLength', 'copy',
                'csv', 'excel', 'pdf', 'print' ] }).draw();


     }
 })
});





// bill created past 6 months and paid 

$(document).on('click','#view_6months_bills_paid',function(e){
  e.preventDefault();
  var user_created_id=$(this).data('id');
 
  var user_created_name=$(this).data('name_full');
  //var user_created_name = $(e.currentTarget).data("name");

  document.getElementById('staff_name2').innerHTML = user_created_name;
 
  $("#csau_6months_biils_paid_modal").modal("show");  
 console.log(user_created_name);
 

let dataSet10 = [];
 let num10 = 0;

$('#csau_staff_6months_bills_paid_view').DataTable().clear().destroy(); 


 $.ajax({
     type : "POST",
     url : "csau_manager_dashboard",
     data : {
         request_type : 'get_bills_created_by_csau_front_officers_last6months_and_paid',
         created_by_id : user_created_id
     },
     cache: false,
     success: function(response) {

      console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result)

         for(let i=0; i<json_result.data.length; i++) {
             let html = [];
             num10 = +num10 + 1;

             let lessees_name = json_result.data[i].lessees_name;
             let business_process_name = json_result.data[i].business_process_name;
             let ref_number = json_result.data[i].ref_number;
             let payment_status = json_result.data[i].payment_status;
             let created_date = json_result.data[i].created_date;
            // let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
             // let payment_status = e[i].payment_status;
             // let buttons = e[i].buttons;
             
             html.push(lessees_name);
             html.push(business_process_name);
             html.push(ref_number);
             html.push(payment_status);
             html.push(created_date);

             dataSet10.push(html);

           //console.log(dataSet)
           }

      //    let dataTable_Obj = $('#recievedtoday').DataTable({
      //        data: dataSet9
      //      })

           $('#csau_staff_6months_bills_paid_view').DataTable().clear().destroy();
                         
          //  $('#csau_staff_6months_bills_paid_view').DataTable({ data: dataSet10 }).draw();
          $('#csau_staff_6months_bills_paid_view').DataTable({
  data: dataSet10,
  dom : 'Bfrtip',
                  lengthMenu : [
                      [ 10, 25, 50, -1 ],
                      [ '10 rows', '25 rows',
                          '50 rows', 'Show all' ] ],
                  buttons : [ 'pageLength', 'copy',
                      'csv', 'excel', 'pdf', 'print' ]
                    
}).draw();


     }
 })
});




// bill created past 6 months and acknowledged


$(document).on('click','#view_6months_bills_acknow',function(e){
  e.preventDefault();
  var user_created_id=$(this).data('id');
 
  var user_created_name=$(this).data('name_full');
  //var user_created_name = $(e.currentTarget).data("name");

  document.getElementById('staff_name3').innerHTML = user_created_name;
 
  $("#csau_6months_biils_acknow_modal").modal("show");  
 console.log(user_created_name);
 

let dataSet11 = [];
 let num11 = 0;

$('#csau_staff_6months_bills_acknow_view').DataTable().clear().destroy(); 

 $.ajax({
     type : "POST",
     url : "csau_manager_dashboard",
     data : {
         request_type : 'get_bills_created_by_csau_front_officers_last6months_and_acknow',
         created_by_id : user_created_id
     },
     cache: false,
     success: function(response) {

      console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result)

         for(let i=0; i<json_result.data.length; i++) {
             let html = [];
             num11 = +num11 + 1;

             let lessees_name = json_result.data[i].lessees_name;
             let business_process_name = json_result.data[i].business_process_name;
             let ref_number = json_result.data[i].ref_number;
             let payment_status = json_result.data[i].payment_status;
             let created_date = json_result.data[i].created_date;
            // let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
             // let payment_status = e[i].payment_status;
             // let buttons = e[i].buttons;
             
             html.push(lessees_name);
             html.push(business_process_name);
             html.push(ref_number);
             html.push(payment_status);
             html.push(created_date);

             dataSet11.push(html);

           //console.log(dataSet)
           }

      //    let dataTable_Obj = $('#recievedtoday').DataTable({
      //        data: dataSet9
      //      })

           $('#csau_staff_6months_bills_acknow_view').DataTable().clear().destroy();
                         
           $('#csau_staff_6months_bills_acknow_view').DataTable({ data: dataSet11,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            buttons : [ 'pageLength', 'copy',
                'csv', 'excel', 'pdf', 'print' ] }).draw();


     }
 })
});




// Applications signed out today

$('#apps_signedout_today').on('click', function(e) {
  e.preventDefault();

$("#signedouttodayModal").modal("show");  


  var regional_code = $('#csau_manager_regional_code').val();
  console.log(regional_code);

  $.ajax({
      type : "POST",
      url : "csau_manager_dashboard",
      data : {
          request_type : 'select_count_signedout_today_by_csau_front_officers',
          regional_code : regional_code.trim()
      },
      cache: false,
      success: function(response) {
          console.log(response);

          var json_result = JSON.parse(response);

          if (json_result.data == null){

              console.log("data not found");       

}else {

  let dataSet12 = [];
  let num12 = 0;

$('#signedouttodayTable').DataTable().clear().destroy();


  for(let i=0; i<json_result.data.length; i++) {
      let html = [];
      num12 = +num12 + 1;
  
      let fullname = json_result.data[i].fullname;
      let count = json_result.data[i].count;
      let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_front_officer_today_signedout"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
      

      // let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_front_officer_apps"  
      // class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      
      html.push(fullname);
      html.push(count);
      html.push(action);

      dataSet12.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#signedouttodayTable').DataTable().clear().destroy();
                  
    $('#signedouttodayTable').DataTable({ data: dataSet12,
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





// Applications signed out this week

$('#apps_signedout_week').on('click', function(e) {
  e.preventDefault();

$("#signedoutWeekModal").modal("show");  


  var regional_code = $('#csau_manager_regional_code').val();
  console.log(regional_code);

  $.ajax({
      type : "POST",
      url : "csau_manager_dashboard",
      data : {
          request_type : 'select_count_signedout_week_by_csau_front_officers',
          regional_code : regional_code.trim()
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);

          if (json_result.data == null){

            alert('Sorry Data Not Found');      

}else {

              let dataSet17 = [];
              let num17 = 0;
          
$('#signedoutWeekTable').DataTable().clear().destroy();

      console.log(response);

     
      console.log(json_result)

      for(let i=0; i<json_result.data.length; i++) {
          let html = [];
          num17 = +num17 + 1;

          let fullname = json_result.data[i].fullname;
          let count = json_result.data[i].count;
          let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_front_officer_week_signedout"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          
  
          // let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_front_officer_apps"  
          // class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
          html.push(fullname);
          html.push(count);
          html.push(action);

          

          dataSet17.push(html);

          // console.log(dataSet)
       }

      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })

          $('#signedoutWeekTable').DataTable().clear().destroy();
                      
          $('#signedoutWeekTable').DataTable({ data: dataSet17,
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





// Applications signed out this year

$('#apps_signedout_year').on('click', function(e) {
  e.preventDefault();

$("#signedoutyearModal").modal("show");  

  var regional_code = $('#csau_manager_regional_code').val();
  console.log(regional_code);

  let dataSet13 = [];
  let num13 = 0;

$('#signedoutyearTable').DataTable().clear().destroy();

  $.ajax({
      type : "POST",
      url : "csau_manager_dashboard",
      data : {
          request_type : 'select_count_signedout_year_by_csau_front_officers',
          regional_code : regional_code.trim()
      },
      cache: false,
      success: function(response) {
         // console.log(response);

          var json_result = JSON.parse(response);
          //console.log(json_result)

          if (json_result.data == null){

            alert('Sorry Data Not Found');      
  
  }else {
    
  

    for(let i=0; i<json_result.data.length; i++) {
      let html = [];
      num13 = +num13 + 1;


  let fullname = json_result.data[i].fullname;
  let count = json_result.data[i].count;
  let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_front_officer_yearly_signedout"  
  class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  

  // let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_front_officer_apps"  
  // class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  
  html.push(fullname);
  html.push(count);
  html.push(action);

  dataSet13.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#signedoutyearTable').DataTable().clear().destroy();
                  
    $('#signedoutyearTable').DataTable({ data: dataSet13,
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



$('#apps_signedout_month').on('click', function(e) {
  e.preventDefault();

$("#signedoutMonthlModal").modal("show");  

  var regional_code = $('#csau_manager_regional_code').val();
  console.log(regional_code);

  let dataSet14 = [];
  let num14 = 0;

$('#signedoutMonthTable').DataTable().clear().destroy();

  $.ajax({
      type : "POST",
      url : "csau_manager_dashboard",
      data : {
          request_type : 'select_count_signedout_month_by_csau_front_officers',
          regional_code : regional_code.trim()
      },
      cache: false,
      success: function(response) {
          //console.log(response);

          var json_result = JSON.parse(response);
         console.log(json_result)

         if (json_result.data == null){

          alert('Sorry Data Not Found');      

}else {

  for(let i=0; i<json_result.data.length; i++) {
    let html = [];
    num14 = +num14 + 1;

    let fullname = json_result.data[i].fullname;
    let count = json_result.data[i].count;
    let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_front_officer_month_signedout"  
    class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    

    // let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="view_front_officer_apps"  
    // class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

    // let payment_status = e[i].payment_status;
    // let buttons = e[i].buttons;
    
    html.push(fullname);
    html.push(count);
    html.push(action);


    dataSet14.push(html);

  //console.log(dataSet)
  }

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

  $('#signedoutMonthTable').DataTable().clear().destroy();
                
  $('#signedoutMonthTable').DataTable({ data: dataSet14,
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




// Applications signed out by csau front officers yearly


$(document).on('click','#view_front_officer_yearly_signedout',function(e){
e.preventDefault();
var user_created_id=$(this).data('id');

var user_created_name=$(this).data('name_full');
//var user_created_name = $(e.currentTarget).data("name");

document.getElementById('staff_name9').innerHTML = user_created_name;

$("#csau_staff_yearly_signedout_modal").modal("show");  
console.log(user_created_id);



$.ajax({
   type : "POST",
   url : "csau_manager_dashboard",
   data : {
       request_type : 'select_applications_signedout_year_by_csau_front_officers',
       created_by : user_created_id
   },
   cache: false,
   success: function(response) {

    //console.log(response)

       var json_result = JSON.parse(response);

       if (json_result.data == null){

        alert('Sorry Data Not Found');          

}else {

let dataSet19 = [];
let num19 = 0;

$('#csau_staff_yearly_signedout_table').DataTable().clear().destroy();

for(let i=0; i<json_result.data.length; i++) {
let html = [];
num19 = +num19 + 1;

let job_number = json_result.data[i].job_number;
let ar_name = json_result.data[i].ar_name;
let business_process_name = json_result.data[i].business_process_name;
let job_purpose = json_result.data[i].job_purpose;
let created_date = json_result.data[i].created_date;
// let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
// let payment_status = e[i].payment_status;
// let buttons = e[i].buttons;


html.push(job_number);
html.push(ar_name);
html.push(business_process_name);
html.push(job_purpose);
html.push(created_date);
// html.push(buttons);

dataSet19.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#csau_staff_yearly_signedout_table').DataTable().clear().destroy();
            
$('#csau_staff_yearly_signedout_table').DataTable({ data: dataSet19,
dom : 'Bfrtip',
lengthMenu : [
    [ 10, 25, 50, -1 ],
    [ '10 rows', '25 rows',
        '50 rows', 'Show all' ] ],
buttons : [ 'pageLength', 'copy',
    'csv', 'excel', 'pdf', 'print' ] }).draw();

}
       
       //console.log(json_result)    


   }
})


});


// Applications signed out by csau front officers today


$(document).on('click','#view_front_officer_today_signedout',function(e){
e.preventDefault();
var user_created_id=$(this).data('id');

var user_created_name=$(this).data('name_full');
//var user_created_name = $(e.currentTarget).data("name");

document.getElementById('staff_name10').innerHTML = user_created_name;

$("#csau_staff_today_signedout_modal").modal("show");  
console.log(user_created_id);



$.ajax({
   type : "POST",
   url : "csau_manager_dashboard",
   data : {
       request_type : 'select_applications_signedout_today_by_csau_front_officers',
       created_by : user_created_id
   },
   cache: false,
   success: function(response) {

    //console.log(response)

       var json_result = JSON.parse(response);

       if (json_result.data == null){

        alert('Sorry Data Not Found');       

}else {

let dataSet20 = [];
let num20 = 0;

$('#csau_staff_today_signedout_table').DataTable().clear().destroy();

for(let i=0; i<json_result.data.length; i++) {
let html = [];
num20 = +num20 + 1;

let job_number = json_result.data[i].job_number;
let ar_name = json_result.data[i].ar_name;
let business_process_name = json_result.data[i].business_process_name;
let job_purpose = json_result.data[i].job_purpose;
let created_date = json_result.data[i].created_date;
// let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
// let payment_status = e[i].payment_status;
// let buttons = e[i].buttons;


html.push(job_number);
html.push(ar_name);
html.push(business_process_name);
html.push(job_purpose);
html.push(created_date);
// html.push(buttons);

dataSet20.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#csau_staff_today_signedout_table').DataTable().clear().destroy();
            
$('#csau_staff_today_signedout_table').DataTable({ data: dataSet20,
dom : 'Bfrtip',
lengthMenu : [
    [ 10, 25, 50, -1 ],
    [ '10 rows', '25 rows',
        '50 rows', 'Show all' ] ],
buttons : [ 'pageLength', 'copy',
    'csv', 'excel', 'pdf', 'print' ] }).draw();

}
       
       //console.log(json_result)    


   }
})


});







// Applications signed out by csau front officers week
$(document).on('click','#view_front_officer_week_signedout',function(e){
e.preventDefault();
var user_created_id=$(this).data('id');

var user_created_name=$(this).data('name_full');
//var user_created_name = $(e.currentTarget).data("name");

document.getElementById('staff_name11').innerHTML = user_created_name;

$("#csau_staff_week_signedout_modal").modal("show");  
console.log(user_created_id);



$.ajax({
   type : "POST",
   url : "csau_manager_dashboard",
   data : {
       request_type : 'select_applications_signedout_week_by_csau_front_officers',
       created_by : user_created_id
   },
   cache: false,
   success: function(response) {

    //console.log(response)

       var json_result = JSON.parse(response);

       if (json_result.data == null){

        alert('Sorry Data Not Found');      

}else {

let dataSet21 = [];
let num21 = 0;

$('#csau_staff_week_signedout_table').DataTable().clear().destroy();

for(let i=0; i<json_result.data.length; i++) {
let html = [];
num21 = +num21 + 1;

let job_number = json_result.data[i].job_number;
let ar_name = json_result.data[i].ar_name;
let business_process_name = json_result.data[i].business_process_name;
let job_purpose = json_result.data[i].job_purpose;
let created_date = json_result.data[i].created_date;
// let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
// let payment_status = e[i].payment_status;
// let buttons = e[i].buttons;


html.push(job_number);
html.push(ar_name);
html.push(business_process_name);
html.push(job_purpose);
html.push(created_date);
// html.push(buttons);

dataSet21.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#csau_staff_week_signedout_table').DataTable().clear().destroy();
            
$('#csau_staff_week_signedout_table').DataTable({ data: dataSet21,
dom : 'Bfrtip',
lengthMenu : [
    [ 10, 25, 50, -1 ],
    [ '10 rows', '25 rows',
        '50 rows', 'Show all' ] ],
buttons : [ 'pageLength', 'copy',
    'csv', 'excel', 'pdf', 'print' ] }).draw();

}
       
       //console.log(json_result)    


   }
})


});




// Applications signed out by csau front officers week
$(document).on('click','#view_front_officer_month_signedout',function(e){
e.preventDefault();
var user_created_id=$(this).data('id');

var user_created_name=$(this).data('name_full');
//var user_created_name = $(e.currentTarget).data("name");

document.getElementById('staff_name12').innerHTML = user_created_name;

$("#csau_staff_month_signedout_modal").modal("show");  
console.log(user_created_id);

$.ajax({
   type : "POST",
   url : "csau_manager_dashboard",
   data : {
       request_type : 'select_applications_signedout_month_by_csau_front_officers',
       created_by : user_created_id
   },
   cache: false,
   success: function(response) {

    //console.log(response)

       var json_result = JSON.parse(response);

       if (json_result.data == null){

        alert('Sorry Data Not Found');      

}else {

let dataSet26 = [];
let num26 = 0;

$('#csau_staff_month_signedout_table').DataTable().clear().destroy();

for(let i=0; i<json_result.data.length; i++) {
let html = [];
num26 = +num26 + 1;

let job_number = json_result.data[i].job_number;
let ar_name = json_result.data[i].ar_name;
let business_process_name = json_result.data[i].business_process_name;
let job_purpose = json_result.data[i].job_purpose;
let created_date = json_result.data[i].created_date;
// let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
// let payment_status = e[i].payment_status;
// let buttons = e[i].buttons;


html.push(job_number);
html.push(ar_name);
html.push(business_process_name);
html.push(job_purpose);
html.push(created_date);
// html.push(buttons);

dataSet26.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#csau_staff_month_signedout_table').DataTable().clear().destroy();
            
$('#csau_staff_month_signedout_table').DataTable({ data: dataSet26,
dom : 'Bfrtip',
lengthMenu : [
    [ 10, 25, 50, -1 ],
    [ '10 rows', '25 rows',
        '50 rows', 'Show all' ] ],
buttons : [ 'pageLength', 'copy',
    'csv', 'excel', 'pdf', 'print' ]
   }).draw();

}
       
       //console.log(json_result)    


   }
})


});





$('#apps_recieved_within_dates').on('click', function(e) {
e.preventDefault();

$("#apps_recieved_within_dates_modal").modal("show");  

})






$('#submit_Btn').click(function(e){
e.preventDefault();

var regional_code = $('#csau_manager_regional_code').val();
 var start_date = $('#startDate').val();
 var end_date = $('#endDate').val();
 


 if (start_date === '' || end_date === '') {
  alert('Please fill in both Start Date and End Date fields.');

}
 else {


 $.ajax({
  type : "POST",
  url : "csau_manager_dashboard",
  data : {
      request_type : 'csau_report_count_received_by_csau_front_officers_by_date',
      regional_code : regional_code.trim(),
      start_date : start_date,
      end_date : end_date
  },
  cache: false,
  success: function(response) {

      var json_result = JSON.parse(response)

      console.log(json_result);

      if (json_result.data == null){

        alert('Sorry Data Not Found');
          // console.log("data not found");      

}else {

// document.getElementById('startDate1').innerHTML = start_date;


$("#apps_recieved_within_dates_officers_modal").modal("show");  


document.getElementById('startDate1').innerHTML = start_date;
document.getElementById('startDate2').innerHTML = end_date;


$("#officer_startDate").val(start_date);
$("#officer_endDate").val(end_date);


 console.log(start_date,end_date);



let dataSet22 = [];
let num22 = 0;

$('#apps_recieved_within_dates_officers_table').DataTable().clear().destroy();



for(let i=0; i<json_result.data.length; i++) {
  let html = [];
  num22 = +num22 + 1;

  let fullname = json_result.data[i].fullname;
  let count = json_result.data[i].count;
  let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="load_apps_created_by_officers_by_date"  
  class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  

  html.push(fullname);
  html.push(count);
  html.push(action);
  // html.push(payment_status);
  // html.push(buttons);

  dataSet22.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#apps_recieved_within_dates_officers_table').DataTable().clear().destroy();
              
$('#apps_recieved_within_dates_officers_table').DataTable({ data: dataSet22,
  dom : 'Bfrtip',
                lengthMenu : [
                    [ 10, 25, 50, -1 ],
                    [ '10 rows', '25 rows',
                        '50 rows', 'Show all' ] ],
                buttons : [ 'pageLength', 'copy',
                    'csv', 'excel', 'pdf', 'print' ] 
}).draw();


}

     

     


  }
})

}


});






$(document).on('click','#load_apps_created_by_officers_by_date',function(e){
e.preventDefault();
var user_created_id=$(this).data('id');

var user_created_name=$(this).data('name_full');
//var user_created_name = $(e.currentTarget).data("name");

document.getElementById('staff_name71').innerHTML = user_created_name;


var new_startDate = $('#officer_startDate').val();
var new_endDate = $('#officer_endDate').val();


document.getElementById('staff_date').innerHTML = new_startDate;

document.getElementById('staff_end_date').innerHTML = new_endDate;

// console.log(user_created_id,user_created_name);

// console.log(new_startDate,new_endDate);


$("#load_apps_created_by_officers_by_date_modal").modal("show");  



let dataSet23 = [];
let num23 = 0;

$('#load_apps_created_by_officers_by_date_table').DataTable().clear().destroy();

$.ajax({
   type : "POST",
   url : "csau_manager_dashboard",
   data : {
       request_type : 'csau_report_apps_received_by_csau_front_officers_by_date',
       created_by_id : user_created_id,
       start_date: new_startDate,
       end_date: new_endDate

   },
   cache: false,
   success: function(response) {

    console.log(response)

       var json_result = JSON.parse(response);
       console.log(json_result)

       if (json_result.data == null){

        // console.log("data not found");       
        alert('Sorry Data Not Found');


}else {

for(let i=0; i<json_result.data.length; i++) {
  let html = [];
  num23 = +num23 + 1;

  let job_number = json_result.data[i].job_number;
  let ar_name = json_result.data[i].ar_name;
  let business_process_name = json_result.data[i].business_process_name;
  let created_date = json_result.data[i].created_date;
 // let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  

  html.push(job_number);
  html.push(ar_name);
  html.push(business_process_name);
  html.push(created_date);
  // html.push(buttons);

  dataSet23.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#load_apps_created_by_officers_by_date_table').DataTable().clear().destroy();
              
$('#load_apps_created_by_officers_by_date_table').DataTable({ data: dataSet23,
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






$('#apps_signed_out_within_dates').on('click', function(e) {
e.preventDefault();

$("#apps_signed_out_within_dates_modal").modal("show");  

})










$('#submit_signedout_Btn').click(function(e){
e.preventDefault();

var regional_code = $('#csau_manager_regional_code').val();
 var start_date = $('#signed_out_startDate').val();
 var end_date = $('#signed_out_endDate').val();
 


 if (start_date === '' || end_date === '') {
  alert('Please fill in both Start Date and End Date fields.');

}
 else {


 $.ajax({
  type : "POST",
  url : "csau_manager_dashboard",
  data : {
      request_type : 'csau_report_count_signedout_by_csau_front_officers_by_date',
      regional_code : regional_code.trim(),
      start_date : start_date,
      end_date : end_date
  },
  cache: false,
  success: function(response) {

      var json_result = JSON.parse(response)

      console.log(json_result);

      if (json_result.data == null){

        alert('Sorry Data Not Found');
          // console.log("data not found");      

}else {

// document.getElementById('startDate1').innerHTML = start_date;


$("#apps_signedout_within_dates_officers_modal").modal("show");  


document.getElementById('startDate3').innerHTML = start_date;
document.getElementById('startDate4').innerHTML = end_date;


$("#signedout_officer_startDate").val(start_date);
$("#signedout_officer_endDate").val(end_date);


 console.log(start_date,end_date);



let dataSet24 = [];
let num24 = 0;

$('#apps_signedout_within_dates_officers_table').DataTable().clear().destroy();



for(let i=0; i<json_result.data.length; i++) {
  let html = [];
  num24 = +num24 + 1;

  let fullname = json_result.data[i].fullname;
  let count = json_result.data[i].count;
  let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="load_apps_signedout_by_officers_by_date"  
  class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  

  html.push(fullname);
  html.push(count);
  html.push(action);
  // html.push(payment_status);
  // html.push(buttons);

  dataSet24.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#apps_signedout_within_dates_officers_table').DataTable().clear().destroy();
              
$('#apps_signedout_within_dates_officers_table').DataTable({ data: dataSet24,
  dom : 'Bfrtip',
                lengthMenu : [
                    [ 10, 25, 50, -1 ],
                    [ '10 rows', '25 rows',
                        '50 rows', 'Show all' ] ],
                buttons : [ 'pageLength', 'copy',
                    'csv', 'excel', 'pdf', 'print' ] 
}).draw();


}

     

  }
})

}


});










$(document).on('click','#load_apps_signedout_by_officers_by_date',function(e){
e.preventDefault();
var collection_issued_by=$(this).data('id');

var user_created_name=$(this).data('name_full');
//var user_created_name = $(e.currentTarget).data("name");

document.getElementById('staff_name72').innerHTML = user_created_name;


var new_startDate = $('#signedout_officer_startDate').val();
var new_endDate = $('#signedout_officer_endDate').val();


document.getElementById('staff_date6').innerHTML = new_startDate;

document.getElementById('staff_end_date1').innerHTML = new_endDate;

// console.log(user_created_id,user_created_name);

console.log(new_startDate,new_endDate);


$("#load_apps_signedout_by_officers_by_date_modal").modal("show");  



let dataSet25 = [];
let num25 = 0;

$('#load_apps_signedout_by_officers_by_date_table').DataTable().clear().destroy();

$.ajax({
   type : "POST",
   url : "csau_manager_dashboard",
   data : {
       request_type : 'csau_report_apps_signedout_by_csau_front_officers_by_date',
       collection_issued_by : collection_issued_by,
       start_date: new_startDate,
       end_date: new_endDate

   },
   cache: false,
   success: function(response) {

    console.log(response)

       var json_result = JSON.parse(response);
       console.log(json_result)

       if (json_result.data == null){

        // console.log("data not found");       
        alert('Sorry Data Not Found');


}else {

for(let i=0; i<json_result.data.length; i++) {
  let html = [];
  num25 = +num25 + 1;

  let job_number = json_result.data[i].job_number;
  let ar_name = json_result.data[i].ar_name;
  let business_process_name = json_result.data[i].business_process_name;
  let collected_date = json_result.data[i].collected_date;
 // let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  

  html.push(job_number);
  html.push(ar_name);
  html.push(business_process_name);
  html.push(collected_date);
  // html.push(buttons);

  dataSet25.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#load_apps_signedout_by_officers_by_date_table').DataTable().clear().destroy();
              
$('#load_apps_signedout_by_officers_by_date_table').DataTable({ data: dataSet25,
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







$('#bills_created_by_dates').on('click', function(e) {
e.preventDefault();

$("#bills_created_within_dates_modal").modal("show");  

})





$('#submit_bills_created_Btn').click(function(e){
e.preventDefault();

var regional_code = $('#csau_manager_regional_code').val();
 var start_date = $('#bills_created_startDate').val();
 var end_date = $('#bills_created_endDate').val();
 var mode_of_query = "";
 


 if (start_date === '' || end_date === '') {
  alert('Please fill in both Start Date and End Date fields.');

}
 else {


 $.ajax({
  type : "POST",
  url : "csau_manager_dashboard",
  data : {
      request_type : 'csau_report_count_bills_created_by_csau_front_officers_by_date',
      regional_code : regional_code.trim(),
      start_date : start_date,
      end_date : end_date,
      mode_of_query: mode_of_query
  },
  cache: false,
  success: function(response) {

      var json_result = JSON.parse(response)

      console.log(json_result);

      if (json_result.data == null){

        alert('Sorry Data Not Found');
          // console.log("data not found");      

}else {

// document.getElementById('startDate1').innerHTML = start_date;


$("#apps_created_within_dates_officers_modal").modal("show");  


document.getElementById('startDate5').innerHTML = start_date;
document.getElementById('startDate6').innerHTML = end_date;


$("#signedout_officer_startDate").val(start_date);
$("#signedout_officer_endDate").val(end_date);


 console.log(start_date,end_date);



let dataSet27 = [];
let num27 = 0;

$('#apps_created_within_dates_officers_table').DataTable().clear().destroy();



for(let i=0; i<json_result.data.length; i++) {
  let html = [];
  num27 = +num27 + 1;

  let fullname = json_result.data[i].fullname;
  let count = json_result.data[i].count;
  let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="load_bills_created_by_officers_by_date"  
  class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  

  html.push(fullname);
  html.push(count);
  html.push(action);
  // html.push(payment_status);
  // html.push(buttons);

  dataSet27.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#apps_created_within_dates_officers_table').DataTable().clear().destroy();
              
$('#apps_created_within_dates_officers_table').DataTable({ data: dataSet27,
  dom : 'Bfrtip',
                lengthMenu : [
                    [ 10, 25, 50, -1 ],
                    [ '10 rows', '25 rows',
                        '50 rows', 'Show all' ] ],
                buttons : [ 'pageLength', 'copy',
                    'csv', 'excel', 'pdf', 'print' ] 
}).draw();


}

     

  }
})

}


});




$("#select_bill_created").on('change', function() {
var level = $(this).val();

var regional_code = $('#csau_manager_regional_code').val();
var start_date = $('#bills_created_startDate').val();
 var end_date = $('#bills_created_endDate').val();


 $("#created_mode").val(level);



console.log(level)

//  $("#sel_change_region_compliance").prop("disabled", true);

if (level) {

$.ajax({
    type: 'POST',
    url: 'csau_manager_dashboard',
    data : {
      request_type : 'csau_report_count_bills_created_by_csau_front_officers_by_date',
      regional_code : regional_code.trim(),
      start_date : start_date,
      end_date : end_date,
      mode_of_query: level
  },
  cache: false,
    success: function(server_response){
      console.log(server_response);
      var json_result = JSON.parse(server_response)





let dataSet29 = [];
let num29 = 0;

$('#apps_created_within_dates_officers_table').DataTable().clear().destroy();



for(let i=0; i<json_result.data.length; i++) {
  let html = [];
  num29 = +num29 + 1;

  let fullname = json_result.data[i].fullname;
  let count = json_result.data[i].count;
  let action = `<a href="javascript:void(0)" data-id="${json_result.data[i].userid}" data-name_full="${json_result.data[i].fullname}" id="load_bills_created_by_officers_by_date"  
  class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  

  html.push(fullname);
  html.push(count);
  html.push(action);
  // html.push(payment_status);
  // html.push(buttons);

  dataSet29.push(html);

//console.log(dataSet)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#apps_created_within_dates_officers_table').DataTable().clear().destroy();
              
$('#apps_created_within_dates_officers_table').DataTable({ data: dataSet29,
  dom : 'Bfrtip',
                lengthMenu : [
                    [ 10, 25, 50, -1 ],
                    [ '10 rows', '25 rows',
                        '50 rows', 'Show all' ] ],
                buttons : [ 'pageLength', 'copy',
                    'csv', 'excel', 'pdf', 'print' ] 
}).draw();




    }

  });

}

});






// View Daily Paid applications 
$(document).on('click','#load_bills_created_by_officers_by_date',function(e){
  e.preventDefault();
  var user_created_id=$(this).data('id');
 
  var user_created_name=$(this).data('name_full');
  //var user_created_name = $(e.currentTarget).data("name");

  var start_date = $('#bills_created_startDate').val();
 var end_date = $('#bills_created_endDate').val();

 var created_mode = $('#created_mode').val()

  document.getElementById('staff_name60').innerHTML = user_created_name;

  console.log(user_created_name,created_mode);

  console.log(start_date,end_date);


$("#today_bills_created_by_date_modal").modal("show");  
 

 let dataSet28 = [];
 let num28 = 0;

$('#today_bills_created_by_date_table').DataTable().clear().destroy();

 $.ajax({
     type : "POST",
     url : "csau_manager_dashboard",
      data : {
      request_type : 'csau_report_all_bills_created_by_csau_front_officers_by_date',
      created_by_id: user_created_id,
      start_date : start_date,
      end_date : end_date,
      mode_of_query: created_mode
  },
     cache: false,
     success: function(response) {

     // console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result)

         if (json_result.data == null){

         //console.log("data not found");       

}else {

  for(let i=0; i<json_result.data.length; i++) {
    let html = [];
    num28 = +num28 + 1;

    let lessees_name = json_result.data[i].lessees_name;
    let business_process_name = json_result.data[i].business_process_name;
    let ref_number = json_result.data[i].ref_number;
    let payment_status = json_result.data[i].payment_status;
    let created_date = json_result.data[i].created_date;
   // let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
    // let payment_status = e[i].payment_status;
    // let buttons = e[i].buttons;
    

    html.push(lessees_name);
    html.push(business_process_name);
    html.push(ref_number);
    html.push(payment_status);
    html.push(created_date);

    dataSet28.push(html);

  //console.log(dataSet)
  }

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

  $('#today_bills_created_by_date_table').DataTable().clear().destroy();
                
  $('#today_bills_created_by_date_table').DataTable({ data: dataSet28,
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