$(function () {


  $(document).on("click", ".showApplicationsModal", function (event) {
    event.preventDefault();

    let item = $(this);
    // let modal = $("#applicationsModal");
    let type = item.data("type") ?? "";

    let title = item.data("title");
    console.log(title);

    // let modal = title !== "Applications With Divisions" ? $("#applicationsModal") : $("#completedapplicationsModal");

    // let modal = (title === "Applications Completed" || title === "Applications Received and Completed") ? $("#completedapplicationsModal") : $("#applicationsModal");


    let modal = (title === "Applications Completed" || title === "Applications Received and Completed") ? $("#completedapplicationsModal") : ((title === "Applications" || title === "Applications Past Due Date") ? $("#new_modal") : $("#applicationsModal"));
    

    let date = item.data("date") ?? "";

    let url = item.data("url");

    let data = {};
    data[item.data("key")] = item.data("value");

    let method = item.data("method");
    let period = item.data("period");
    let by = item.data("by");

    let staff = item.data("staff");
   
    let action =
      method +
      (period ? `_${period}` : "") +
      (typeof by === "undefined" ? "" : `_${by}`) +
      "_applications";

    submitAjax(url, action, data, function (data) {
      
      
      data = data.apps_with_staff || data.apps_at_division || [];
      
      let applicationsData = data.map(function (item) {
        let sendMessageAction =
          typeof staff === "undefined"
            ? ""
            : `<a data-job-number="${
                item.job_number
              }" data-staff='${JSON.stringify(
                staff
              )}' class="dropdown-item sendMessage" href="#">Send Message</a>`;
        
        let page_name_title = $("#page_name").text();

        return {
          ...item,
          action: `<div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
            </button>
            <div class="dropdown-menu">
            <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
              <input type="hidden" name="case_number" id="case_number" value="${item.transaction_number}">
              <input type="hidden" name="search_text" id="search_text" value="${item.case_number}">
              <input type="hidden" name="job_number" id="job_number" value="${item.job_number}">
              <input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="${item.business_process_sub_name}">
              <button type="submit" name="save" class="dropdown-item" >View</button>
            </form>
              ${sendMessageAction}
              
              ${page_name_title ==="unit_case_management" ?`
              <a href="#" class="dropdown-item "  data-job_number="${item.job_number}" data-ar_name="${item.ar_name}"
        data-business_process_sub_name="${item.business_process_sub_name}"  data-toggle="modal" data-target="#askForPurposeOfBatching">
        Add to Batch List
        </a>`
          
              : ""}
              
              
              
            </div>
          </div>`,
        };
      });

      modal
        .find(".modal-body table")
        .DataTable({ destroy: true, responsive: true, data: applicationsData });
    });

    modal
      .find("#applicationsModalLabel")
      .html(`${type} ${title} <span class="text-primary">${date}</span>`);

    let sendMessageAction =
      typeof staff === "undefined"
        ? ""
        : `<button data-staff='${JSON.stringify(
            staff
          )}' class="sendMessage btn btn-primary ml-auto" type="button">Send Message</button>`;

    $(sendMessageAction).insertAfter(modal.find("#applicationsModalLabel"));

    modal.find(".modal-body table").DataTable();

    modal.modal("show");
  });


//     let divisions = [
//       { division: "SMD", total: 0 },
//       { division: "LRD", total: 0 },
//       { division: "PVLMD", total: 0 },
//       { division: "LVD", total: 0 },
//     { division: "RLO", total: 0 },
//     ];
  
//     let colors = ["danger", "warning", "default", "info", "success", "secondary"];
  
//     $(document).on("click", ".sendMessage", function (event) {
//       event.preventDefault();
  
//       let sendMessageModal = $("#sendMessageModal");
  
//       let staff = $(this).data("staff");
  
//       let jobNumbers = $(this).data("job-number");
//       jobNumbers =
//           typeof jobNumbers === "undefined" ? [] : [{ job_number: jobNumbers }];
          
//       if (jobNumbers.length <= 0) {
//         jobNumbers = $(this)
//           .parents(".modal")
//           .find("table")
//           .DataTable()
//           .rows()
//           .data()
//           .toArray()
//           .map((currentItem) => {
//             return { job_number: currentItem.job_number };
//           });
//       }
  
//       // set hidden job_numbers input to job number array
//       sendMessageModal.find("#job_numbers").val(JSON.stringify(jobNumbers));
  
//       // set hidden staff input to staff id
//       sendMessageModal.find("#officer_id").val(staff.staff_id);
//       sendMessageModal.find("#officer_name").val(staff.staff);
  
//       sendMessageModal
//         .find("#sendMessageModalLabel")
//         .html(`Send Message To <span class="text-primary">${staff.staff}</span>`);
  
//       sendMessageModal.modal("show"); 
//     });
  
    $("#message-form_focal_complaince").on("submit", function (event) {
      event.preventDefault();
  
      let form = $(this);
      let data = form.serializeArray();
      
      
      
      
      
      data = {
        "request_type": $("#sendMessageModal_FocalCompliance").find("#request_type").val(),
        "officer_id": $("#sendMessageModal_FocalCompliance").find("#focal_officer_id").val(),
        "officer_name": $("#sendMessageModal_FocalCompliance").find("#officer_name").val(),
        "job_numbers" : $("#sendMessageModal_FocalCompliance").find("#job_numbers").val(),
      "message_type":$("#sendMessageModal_FocalCompliance").find("#message_type").val(),
      "message": $("#sendMessageModal_FocalCompliance").find("#message").val()
      }
      
      
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
  
    $(".generate-applications-chart").on("submit", function (event) {
      event.preventDefault();
  
      let chartType = $(this).serializeArray()[0].value;
  
      let modalBody = $(this).parents(".modal-content").find(".modal-body");
  
      let title = $(this).parents(".modal-content").find(".modal-title").text();
  
      let tableData = modalBody.find("table").DataTable().rows().data().toArray();
  
      let data = tableData.reduce((groupedData, currentItem) => {
        let foundIndex = groupedData.findIndex((currentValue) => {
          return currentValue.name === currentItem.business_process_sub_name;
        });
  
        if (foundIndex < 0) {
          groupedData.push({
            name: currentItem.business_process_sub_name,
            total: 0,
          });
          foundIndex = groupedData.length - 1;
        }
  
        groupedData[foundIndex] = {...groupedData[foundIndex],
          total: groupedData[foundIndex].total + 1,
        };
  
        return groupedData;
      }, []);
  
      generateChart(modalBody, title, chartType, data);
    });
  
    $(".generate-chart").on("submit", function (event) {
      event.preventDefault();
  
      let chartType = $(this).serializeArray()[0].value;
  
      let modalBody = $(this).parents(".modal-content").find(".modal-body");
  
      let tableData = modalBody.find("table").DataTable().rows().data().toArray();
  
      let title = $(this).parents(".modal-content").find(".modal-title").text();
  
      generateChart(modalBody, title, chartType, tableData);
    });
  
    // $(document).on("click", ".showDivisionModal", function (event) {
    //   event.preventDefault();
  
    //   let item = $(this);
    //   let iconClass = item.data("icon");
    //   let modal = $("#divisionModal");
  
    //   let title = item.data("title");
  
      
    //   let date = item.data("date") ?? "";
  
    //   let url = item.data("url");
  
    //   let method = item.data("method");
    //   let period = item.data("period");
  
    //   let by = item.data("by");
  
    //   let action =
    //     method +
    //     (period ? `_${period}` : "") +
    //     (typeof by === "undefined" ? "" : `_${by}`);
  
    //   submitAjax(url, action, {}, function (data) {
    //     divisionsNotFound = divisions.filter(function (division) {
    //       return !data.apps_at_division.some(function (item) {
    //         return item.division == division.division;
    //       });
    //     });
  
    //     let newColors = [...colors];
  
    //     divisionHtml = [...data.apps_at_division, ...divisionsNotFound].reduce(
    //       function (sum, current) {
    //         let selectedColorIndex = Math.floor(Math.random() * newColors.length);
    //         let color = newColors[selectedColorIndex];
    //         newColors.splice(selectedColorIndex, 1);
  
    //         let html = `<div class="col-xl-3 col-md-6 mb-4">
    //               <div class="card border-left-${color} shadow ">
    //                 <div class="card-body">
    //                   <div class="row no-gutters align-items-center">
    //                     <div class="col mr-2">
    //                       <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> ${current.division}</div>
    //                       <div class="h5 mb-0 font-weight-bold text-gray-800">${current.total}</div>
    //                     </div>
    //                     <div class="col-auto">
    //                       <i class="fas fa-2x text-gray-300 ${iconClass}"></i>
    //                     </div>
    //                     <a href="#" data-method="${method}" data-period="${period}" data-by="service_type" data-url="${url}" data-type="${current.division}" data-title="${title}" data-date="${date}" class="showServiceTypeModal text-decoration-none stretched-link">
    //           </a>
    //                   </div>
    //                 </div>
    //               </div>
    //             </div>`;
  
    //         return (sum += html);
    //       },
    //       ""
    //     );
  
    //     modal.find(".modal-body > .row").html(divisionHtml);
    //   });
  
    //   modal
    //     .find("#divisionModalLabel")
    //     .html(`${title} <span class="text-primary">${date}</span>`);
  
    //   modal.modal("show");
    // });
  
    $(document).on("click", ".showServiceTypeModal_apps_recieved", function (event) {
      event.preventDefault();
  
      $("#apps_recieved_year_modal").modal("show");  

      var users_division = $('#currentDivision').val();

      var regional_code = $('#director_regional_code').val();


      const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
      const currentDate = new Date();
      const day = currentDate.getDate();
      const monthIndex = currentDate.getMonth();
      const year = currentDate.getFullYear();
      const formattedDate = `${year}`;
    
    
      var title  = users_division+"'s"+" "+"Applications Received In "+" "+"("+formattedDate+")";
      
      document.getElementById('divisionLabelRecievedYear').innerHTML = title;


      // console.log(users_division,regional_code);

      $.ajax({
        type : "POST",
        url : "focal_compliance",
        data : { 
            request_type : 'compliance_focal_report_dashboard_created_year_by_division',
            region_id : regional_code.trim(),
            division:users_division
        },
        cache: false,
        success: function(response) {
           // console.log(response);

            var json_result = JSON.parse(response);

            console.log(json_result.apps_at_division);

            if (json_result.apps_at_division == ''){

                //.log("data not found");       
}else {

    let dataSet10 = [];
    let num10 = 0;

  $('#apps_recieved_year_table').DataTable().clear().destroy();

    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num10 = +num10 + 1;

        let service_type = json_result.apps_at_division[i].service_type;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}"  id="view_apps_recieved_year"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        html.push(service_type);
        html.push(total);
        html.push(action);

        dataSet10.push(html);

      ///console.log(dataSet1)
      }

    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })

      $('#apps_recieved_year_table').DataTable().clear().destroy();
                    
      $('#apps_recieved_year_table').DataTable({ data: dataSet10,
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
  



    $(document).on('click','#view_apps_recieved_year',function(e){
      e.preventDefault();
     
  $("#applicationsModalRecievedYear").modal("show");  
  
  
  const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
  const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${year}`;
  
  
      var regional_code = $('#director_regional_code').val();
      // var division = $('#director_division').val();
  
      var service_type=$(this).data('id');
  
  
      var title  = service_type+" "+"Applications Received In"+" "+formattedDate;
  
      document.getElementById('applicationsModalLabelRecievedYear').innerHTML = title;
  
    //  console.log(service_type);
  
    
     let dataSet11 = [];
     let num11 = 0;
    
    $('#view_applications_year_by_service_type').DataTable().clear().destroy();
    
     $.ajax({
         type : "POST",
         url : "focal_compliance",
         data : {
             request_type : 'compliance_focal_report_dashboard_created_year_by_service_type',
             region_id : regional_code,
             service_type : service_type
         },
         cache: false,
         success: function(response) {
    
          //console.log(response)
    
             var json_result = JSON.parse(response);
             console.log(json_result)
    
             if (json_result.apps_at_division == ""){
    
              //console.log("data not found");       
    
    }else {
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num11 = +num11 + 1;
    
        let job_number = json_result.apps_at_division[i].job_number;
        let ar_name = json_result.apps_at_division[i].ar_name;
        let business_process_name = json_result.apps_at_division[i].business_process_name;
        let created_date = json_result.apps_at_division[i].created_date;
        let due_date = json_result.apps_at_division[i].due_date;
        let days_due = json_result.apps_at_division[i].days_due;
        let days_since_batched = json_result.apps_at_division[i].days_since_batched;
      //  let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
    
        html.push(job_number);
        html.push(ar_name);
        html.push(business_process_name);
        html.push(created_date);
        html.push(due_date);
        html.push(days_due);
        html.push(days_since_batched);
      //   html.push(action);
    
        dataSet11.push(html);
    
      //console.log(dataSet)
      }
    
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
    
      $('#view_applications_year_by_service_type').DataTable().clear().destroy();
                    
      $('#view_applications_year_by_service_type').DataTable({ data: dataSet11,
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





    $(document).on("click", ".showServiceTypeModal_apps_recieved_and_completed", function (event) {
      event.preventDefault();
  
      $("#apps_recieved_completed_year_modal").modal("show");  
      

      var users_division = $('#currentDivision').val();

      var regional_code = $('#director_regional_code').val();

      const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
      const currentDate = new Date();
      const day = currentDate.getDate();
      const monthIndex = currentDate.getMonth();
      const year = currentDate.getFullYear();
      const formattedDate = `${year}`;
    
    
      var title  = users_division+"'s"+" "+"Applications Received And Completed In "+" "+"("+formattedDate+")";
      
      document.getElementById('divisionLabelRecievedCompletedYear').innerHTML = title;


      // console.log(users_division,regional_code);

      $.ajax({
        type : "POST",
        url : "director_dashboard",
        data : { 
            request_type : 'director_report_dashboard_created_completed_year_by_division',
            region_id : regional_code.trim(),
            division:users_division
        },
        cache: false,
        success: function(response) {
           // console.log(response);

            var json_result = JSON.parse(response);

            console.log(json_result.apps_at_division);

            if (json_result.apps_at_division == ''){

                //.log("data not found");       
}else {

    let dataSet12 = [];
    let num12 = 0;

  $('#apps_recieved_completed_year_table').DataTable().clear().destroy();

    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num12= +num12 + 1;

        let service_type = json_result.apps_at_division[i].service_type;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}"  id="view_apps_recieved_completed_year"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        html.push(service_type);
        html.push(total);
        html.push(action);

        dataSet12.push(html);

      ///console.log(dataSet1)
      }

    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })

      $('#apps_recieved_completed_year_table').DataTable().clear().destroy();
                    
      $('#apps_recieved_completed_year_table').DataTable({ data: dataSet12,
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
  





$(document).on('click','#view_apps_recieved_completed_year',function(e){
      e.preventDefault();
     
  $("#applicationsModalRecievedCompletedYear").modal("show");  
  
  
  const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
  const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${year}`;
  
  
      var regional_code = $('#director_regional_code').val();
      // var division = $('#director_division').val();
  
      var service_type=$(this).data('id');
  
  
      var title  = service_type+" "+"Applications Received And Completed In "+" "+formattedDate;
  
      document.getElementById('applicationsModalLabelRecievedCompletedYear').innerHTML = title;
  
    //  console.log(service_type);
  
    
     let dataSet13 = [];
     let num13 = 0;
    
    $('#view_applications_created_completed_year_by_service_type').DataTable().clear().destroy();
    
     $.ajax({
         type : "POST",
         url : "focal_compliance",
         data : {
             request_type : 'compliance_focal_report_dashboard_created_completed_year_by_ser',
             region_id : regional_code,
             service_type : service_type
         },
         cache: false,
         success: function(response) {
    
          //console.log(response)
    
             var json_result = JSON.parse(response);
             console.log(json_result)
    
             if (json_result.apps_at_division == ""){
    
              //console.log("data not found");       
    
    }else {
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num13 = +num13 + 1;
    
        let job_number = json_result.apps_at_division[i].job_number;
        let ar_name = json_result.apps_at_division[i].ar_name;
        let business_process_name = json_result.apps_at_division[i].business_process_name;
        let created_date = json_result.apps_at_division[i].created_date;
        let completed_date = json_result.apps_at_division[i].completed_date;
        let days_due = json_result.apps_at_division[i].days_due;
        // let days_since_batched = json_result.apps_at_division[i].days_since_batched;
       let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
    
        html.push(job_number);
        html.push(ar_name);
        html.push(business_process_name);
        html.push(created_date);
        html.push(completed_date);
        html.push(days_due);
        html.push(action);
    
        dataSet13.push(html);
    
      //console.log(dataSet)
      }
    
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
    
      $('#view_applications_created_completed_year_by_service_type').DataTable().clear().destroy();
                    
      $('#view_applications_created_completed_year_by_service_type').DataTable({ data: dataSet13,
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




  
    $(document).on("click", ".showServiceTypeModal_apps_completed", function (event) {
      event.preventDefault();
  
      $("#apps_completed_year_modal").modal("show");  

      var users_division = $('#currentDivision').val();

      var regional_code = $('#director_regional_code').val();


  const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
  const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${year}`;


  var title  = users_division+"'s"+" "+"Applications Completed This Year "+" "+"("+formattedDate+")";
  
  document.getElementById('divisionLabelCompletedYear').innerHTML = title;




      console.log(users_division,regional_code);

      $.ajax({
        type : "POST",
        url : "focal_compliance",
        data : { 
            request_type : 'compliance_focal_report_dashboard_completed_year_by_division',
            region_id : regional_code.trim(),
            division:users_division
        },
        cache: false,
        success: function(response) {
           // console.log(response);

            var json_result = JSON.parse(response);

            console.log(json_result.apps_at_division);

            if (json_result.apps_at_division == ''){

                //.log("data not found");       
}else {

    let dataSet14 = [];
    let num14 = 0;

  $('#apps_completed_year_table').DataTable().clear().destroy();

    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num14= +num14 + 1;

        let service_type = json_result.apps_at_division[i].service_type;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}"  id="view_apps_completed_year"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        html.push(service_type);
        html.push(total);
        html.push(action);

        dataSet14.push(html);

      ///console.log(dataSet1)
      }

    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })

      $('#apps_completed_year_table').DataTable().clear().destroy();
                    
      $('#apps_completed_year_table').DataTable({ data: dataSet14,
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


  
  
    $(document).on('click','#view_apps_completed_year',function(e){
      e.preventDefault();
     
  $("#applicationsModalCompletedYear").modal("show");  
  
  
  const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
  const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${year}`;
  
  
      var regional_code = $('#director_regional_code').val();
      // var division = $('#director_division').val();
  
      var service_type=$(this).data('id');
  
  
      var title  = service_type+" "+"Applications Completed This Year "+" "+"("+formattedDate+")";
  
      document.getElementById('applicationsModalLabelCompletedYear').innerHTML = title;
  
    //  console.log(service_type);
  
    
     let dataSet13 = [];
     let num13 = 0;
    
    $('#view_applications_completed_year_by_service_type').DataTable().clear().destroy();
    
     $.ajax({
         type : "POST",
         url : "focal_compliance",
         data : {
             request_type : 'compliance_focal_report_dashboard_completed_year_by_service_typ',
             region_id : regional_code,
             service_type : service_type
         },
         cache: false,
         success: function(response) {
    
          //console.log(response)
    
             var json_result = JSON.parse(response);
             console.log(json_result)
    
             if (json_result.apps_at_division == ""){
    
              //console.log("data not found");       
    
    }else {
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num13 = +num13 + 1;
    
        let job_number = json_result.apps_at_division[i].job_number;
        let ar_name = json_result.apps_at_division[i].ar_name;
        let business_process_name = json_result.apps_at_division[i].business_process_name;
        let created_date = json_result.apps_at_division[i].created_date;
        let completed_date = json_result.apps_at_division[i].completed_date;
        let days_due = json_result.apps_at_division[i].days_due;
        // let days_since_batched = json_result.apps_at_division[i].days_since_batched;
       let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
    
        html.push(job_number);
        html.push(ar_name);
        html.push(business_process_name);
        html.push(created_date);
        html.push(completed_date);
        html.push(days_due);
        html.push(action);
    
        dataSet13.push(html);
    
      //console.log(dataSet)
      }
    
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
    
      $('#view_applications_completed_year_by_service_type').DataTable().clear().destroy();
                    
      $('#view_applications_completed_year_by_service_type').DataTable({ data: dataSet13,
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
   
     




//     $(document).on("click", ".showUnitModal", function (event) {
//       event.preventDefault();
  
//       let item = $(this);
//       let modal = $("#unitModal");
//       let type = item.data("type") ?? "";
  
//       // let title = item.data("title");
      
//       // console.log(title);
  
//       let title = (item.data("title") === "Applications With Divisions") ? "Applications" : item.data("title");
  
  
      
//       let date = item.data("date") ?? "";
  
//       let url = item.data("url");
  
//       let method = item.data("method");
//       let period = item.data("period");
//       let by = item.data("by");
  
//       let action =
//         method +
//         (typeof period === "undefined" ? "" : `_${period}`) +
//         (typeof by === "undefined" ? "" : `_${by}`) +
//         "_units";
  
//       submitAjax(url, action, { division: type }, function (data) {
//         let unitsData = data.apps_at_division_unit.map(function (item) {
//           return {
//             name: item.unit,
//             total: item.total,
//             action: `<a href="#" 
//               class="modalButton showOfficerModal text-decoration-none"
//               data-method="${method}" 
//               data-count="${item.total}" 
//             ${typeof period === "undefined" ? "" : `data-period="${period}"`}
//             data-url="${url}"
//             ${typeof by === "undefined" ? "" : `data-by="${by}"`}
//             data-type="${item.unit}"
//             data-title="${title}" 
//             data-date="${date}" 
//               data-unit-id="${item.unit_id}"
//             data-division="${type}"
//           >View</a>`,
//           };
//         });
  
//         modal
//           .find(".modal-body table")
//           .DataTable({ destroy: true, responsive: true, data: unitsData });
//       });
  
//       modal
//         .find("#unitModalLabel")
//         .html(
//           `${type}'s Units ${title} <span class="text-primary">${date}</span>`
//         );
  
//       modal.find(".modal-body table").DataTable();
  
//       modal.modal("show");
//     });
  
//     $(document).on("click", ".showOfficerModal", function (event) {
//       event.preventDefault();
  
//       let item = $(this);
//       let modal = $("#officerModal");
//       let type = item.data("type") ?? "";
  
//       let title = item.data("title");
  
//       //  console.log(title);
  
//       let date = item.data("date") ?? "";
  
//       let url = item.data("url");
  
//       let method = item.data("method");
//       let period = item.data("period");
//       let by = item.data("by");
  
//       let division = item.data("division");
//       let unit = item.data("unit-id");
//       let count = item.data("count");
  
//       let action =
//         method +
//         (typeof period === "undefined" ? "" : `_${period}`) +
//         (typeof by === "undefined" ? "" : `_${by}`) +
//         "_officers";
  
//       submitAjax(url, action, { division, unit }, function (data) {
//         let officersData = data.apps_at_unit.map(function (item) {
//           return {
//             name: item.staff,
//             total: item.total,
//             action: `<a href="#" 
//               class="modalButton showApplicationsModal text-decoration-none"
//               data-staff='${JSON.stringify(item)}'
//               data-method="${method}" 
//             ${typeof period === "undefined" ? "" : `data-period="${period}"`}
//             data-url="${url}"
//             ${typeof by === "undefined" ? "" : `data-by="${by}"`}
//             data-type="${item.staff}'s"
//             data-title="${title}" 
//             data-date="${date}"
//             data-key="staff"
//             data-value="${item.staff_id}"
//           >View</a>`,
//           };
//         });
//         // let unassigned =
//         //     count -
//         //     data.apps_at_unit.reduce(function (sum, current) {
//         //       return (sum += current.total);
//         //     }, 0);
  
//         //   officersData = [
//         //     {
//         //       name: "UNASSIGNED",
//         //       total: unassigned,
//         //       action: `<a href="#" 
//         //        class="modalButton showApplicationsModal text-decoration-none"
//         //        data-method="${method}" 
//         //      ${typeof period === "undefined" ? "" : `data-period="${period}"`}
//         //      data-url="${url}"
//         //      ${typeof by === "undefined" ? "" : `data-by="${by}"`}
//         //      data-type="Unassigned"
//         //      data-title="${title}" 
//         //      data-date="${date}"
//         //      data-key="staff"
//         //      data-value="${unit}"
//         //    >View</a>`,
//         //     },
//         //     ...officersData,
//         //   ];
          
//         modal
//           .find(".modal-body table")
//           .DataTable({ destroy: true, responsive: true, data: officersData });
//       });
  
//       modal
//         .find("#officerModalLabel")
//         .html(
//           `${type}'s Officers ${title} <span class="text-primary">${date}</span>`
//         );
  
//       modal.find(".modal-body table").DataTable();
  
//       modal.modal("show");
//     });
  
//     $(document).on("click", ".showApplicationsModal", function (event) {
//       event.preventDefault();
  
//       let item = $(this);
//       // let modal = $("#applicationsModal");
//       let type = item.data("type") ?? "";
  
//       let title = item.data("title");
//       console.log(title);
  
//       // let modal = title !== "Applications With Divisions" ? $("#applicationsModal") : $("#completedapplicationsModal");
  
//       // let modal = (title === "Applications Completed" || title === "Applications Received and Completed") ? $("#completedapplicationsModal") : $("#applicationsModal");
  
  
//       let modal = (title === "Applications Completed" || title === "Applications Received and Completed") ? $("#completedapplicationsModal") : ((title === "Applications" || title === "Applications Past Due Date") ? $("#new_modal") : $("#applicationsModal"));
      
  
//       let date = item.data("date") ?? "";
  
//       let url = item.data("url");
  
//       let data = {};
//       data[item.data("key")] = item.data("value");
  
//       let method = item.data("method");
//       let period = item.data("period");
//       let by = item.data("by");
  
//       let staff = item.data("staff");
     
//       let action =
//         method +
//         (period ? `_${period}` : "") +
//         (typeof by === "undefined" ? "" : `_${by}`) +
//         "_applications";
  
//       submitAjax(url, action, data, function (data) {
        
        
//         data = data.apps_with_staff || data.apps_at_division || [];
        
//         let applicationsData = data.map(function (item) {
//           let sendMessageAction =
//             typeof staff === "undefined"
//               ? ""
//               : `<a data-job-number="${
//                   item.job_number
//                 }" data-staff='${JSON.stringify(
//                   staff
//                 )}' class="dropdown-item sendMessage" href="#">Send Message</a>`;
          
//           let page_name_title = $("#page_name").text();
  
//           return {
//             ...item,
//             action: `<div class="btn-group" role="group">
//               <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
//                 Actions
//               </button>
//               <div class="dropdown-menu">
//               <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
//                 <input type="hidden" name="case_number" id="case_number" value="${item.transaction_number}">
//                 <input type="hidden" name="search_text" id="search_text" value="${item.case_number}">
//                 <input type="hidden" name="job_number" id="job_number" value="${item.job_number}">
//                 <input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="${item.business_process_sub_name}">
//                 <button type="submit" name="save" class="dropdown-item" >View</button>
//               </form>
//                 ${sendMessageAction}
                
//                 ${page_name_title ==="unit_case_management" ?`
//                 <a href="#" class="dropdown-item "  data-job_number="${item.job_number}" data-ar_name="${item.ar_name}"
//           data-business_process_sub_name="${item.business_process_sub_name}"  data-toggle="modal" data-target="#askForPurposeOfBatching">
//           Add to Batch List
//           </a>`
            
//                 : ""}
                
                
                
//               </div>
//             </div>`,
//           };
//         });
  
//         modal
//           .find(".modal-body table")
//           .DataTable({ destroy: true, responsive: true, data: applicationsData });
//       });
  
//       modal
//         .find("#applicationsModalLabel")
//         .html(`${type} ${title} <span class="text-primary">${date}</span>`);
  
//       let sendMessageAction =
//         typeof staff === "undefined"
//           ? ""
//           : `<button data-staff='${JSON.stringify(
//               staff
//             )}' class="sendMessage btn btn-primary ml-auto" type="button">Send Message</button>`;
  
//       $(sendMessageAction).insertAfter(modal.find("#applicationsModalLabel"));
  
//       modal.find(".modal-body table").DataTable();
  
//       modal.modal("show");
//     });
  
    let chart;
  
    $(".clear-chart").on("click", function () {
      $(this).parents(".generate-chart").trigger("reset");
  
      echarts.init($(this).parents(".modal").find(".chart")[0]).dispose();
  
      $(this).parents(".modal").find(".chart").width(0).height(0);
    });
  
    $(".modal").on("shown.bs.modal", function () {
      $(this).attr("data-position", $(".modal:visible").length);
  
  $('.modal').each(function(){
    if ($(this).find(".chart").length > 0) {
      echarts.init($(this).find(".chart")[0]).dispose();
  
        $(this).find(".chart").width(0).height(0);
  
      $(this).find(".generate-chart").trigger("reset");
    
        $(this).find(".generate-applications-chart").trigger("reset");
    }
  });
    });
  
    $(".modal").on("hidden.bs.modal", function () {
      $(this).attr("data-position", 0);
  
      if ($(this).find(".chart").length > 0) {
        echarts.init($(this).find(".chart")[0]).dispose();
  
        $(this).find(".chart").width(0).height(0);
  
        $(this).find(".generate-chart").trigger("reset");
  
        $(this).find(".generate-applications-chart").trigger("reset");
      }
  
      if ($(this).find("table").length > 0) {
        $(this).find("table").DataTable().clear().draw();
        $(this).find("table").DataTable().destroy();
      }
  
      if (
        $(`.modal:visible[data-position=${$(".modal:visible").length}]`).length >
        0
      ) {
        $("body").addClass("modal-open");
      }
  
      if (
        !$("#applicationsModal").is(":visible") &&
        $(".sendMessage").length > 0
      ) {
        $(".sendMessage").remove();
      }
    });
  
    function generateChart(modalBody, title, type, tableData) {
      let data = null;
      let labels = null;
  
      switch (type) {
        case "pie":
        case "doughnut":
          data = tableData.map(({ name, total }) => {
            return { name, value: total };
          });
          break;
        case "bar":
          (data = tableData.map((item) => item.total)),
            (labels = tableData.map((item) => item.name));
          break;
        default:
          alert("Please select one option.");
          break;
      }
  
      if (!type) {
        return;
      }
  
      if (chart) {
        chart.dispose();
  
        $(chart.getDom()).width(0).height(0);
      }
  
      let height = type === "pie" || type === "doughnut" ? 400 : "700px";
  
      modalBody.find(".chart").width("100%").height(height);
  
      chart = echarts.init(modalBody.find(".chart")[0]);
  
      let options = {
        title: {
          text: title,
        },
        toolbox: {
          right: "5%",
          feature: {
            saveAsImage: {},
          },
        },
      };
  
      switch (type) {
        case "pie":
          options = { ...options, ...getPieOptions(data, "70%") };
          break;
        case "doughnut":
          options = { ...options, ...getPieOptions(data, ["40%", "70%"]) };
          break;
        case "bar":
          options = { ...options, ...getBarOptions(labels, data) };
          break;
      }
  
      chart.setOption(options);
    }
  
    function getPieOptions(data, radius) {
      return {
        tooltip: {
          trigger: "item",
        },
        series: [
          {
            type: "pie",
            radius,
            data: data,
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: "rgba(0, 0, 0, 0.5)",
              },
            },
          },
        ],
      };
    }
  
    function getBarOptions(labels, data) {
      return {
        tooltip: {
          trigger: "axis",
          axisPointer: {
            type: "shadow",
          },
        },
        grid: {
          left: 0,
          right: 0,
          top: 80,
          bottom: 100,
          containLabel: true,
          tooltip: {
            trigger: "axis",
            axisPointer: {
              type: "shadow",
              label: {
                show: true,
                formatter: function (params) {
                  return params.value.replace("\n", "");
                },
              },
            },
          },
        },
        legend: {
          data: labels,
        },
        xAxis: {
          type: "category",
          data: labels,
          axisLabel: {
            showMinLabel: true,
            showMaxLabel: true,
            interval: 0,
            rotate: 90,
            formatter: function (value) {
              return value
                .split(" ")
                .reduce((previousValue, currentValue, currentIndex) => {
                  if (currentIndex && (currentIndex + 1) % 2 === 1) {
                    return [...previousValue, "\n", currentValue];
                  }
  
                  return [...previousValue, currentValue];
                }, [])
                .slice(0, 10)
                .reduce((previousValue, currentValue, currentIndex) => {
                  if (currentIndex === 9) {
                    currentValue = `${currentValue}...`;
                  }
  
                  return [...previousValue, currentValue];
                }, [])
                .join(" ");
            },
          },
        },
        yAxis: {
          type: "value",
        },
        series: [
          {
            data,
            barWidth: "60%",
            type: "bar",
          },
        ],
      };
    }
    //console.log("pagen complaince: "+$("#page_name").text() )
    
    
    
    
    
    $('#sel_change_region_compliance').change(function(){
  // console.log("selection made " + $(this).val() );
  let decimal = $(this).val();
  let new_region_id= Math.trunc(decimal);
  // console.log(new_region_id);
  // document.getElementById('director_regional_code').innerHTML = new_region_id;
  $("#director_regional_code").val(new_region_id);
      
    submitAjax("director_dashboard", "director_report_dashboard_all", {}, function (data) {
  
  
      let totalRec = data.apps_rec_divisional[0].total;
      let totalRecComp = data.total_comp_divisional_year[0].total;
  
      
      let totalpercentage = isNaN(((totalRecComp / totalRec) * 100).toFixed(2)) ? 0+'%' : ((totalRecComp / totalRec) * 100).toFixed(2)+'%';


  
              console.log(data.apps_rec_day[0].total);
  
      
              $("#app-received-today").html(
                  new Intl.NumberFormat('en-US', { style: 'decimal' }).format(data.apps_rec_day[0].total)
              //   new Intl.NumberFormat().format(data.apps_rec_day[0].total)
              );
              $("#app-received-month").html(
                new Intl.NumberFormat().format(data.apps_rec_month[0].total)
              );
              $("#app-completed-today").html(
                new Intl.NumberFormat().format(data.apps_comp_day[0].total)
              );
              $("#app-completed-month").html(
                new Intl.NumberFormat().format(data.apps_comp_month[0].total)
              );
          
              // applications received for the year
              showDivisionSummary("#app-received-year", data.apps_rec_divisional, 'info');
          
              // applications completed for the year
              showDivisionSummary("#app-completed-year", data.apps_comp_divisional, 'success');
          
              // applications received and completed for the year
              showDivisionSummary(
                "#app-received-completed-year",
                data.apps_comp_divisional_year,
          'default'
              );
          
              // applications past due for the year
              showDivisionSummary(
                "#app-past-due-year",
                data.apps_past_due_dates_divisional,
          'danger'
              );
          
              // applications with divisions
              showDivisionSummary("#app-with-divisions", data.apps_at_division, 'warning');
  
              document.getElementById('pec_id').innerHTML = totalpercentage;
  
            });
    });
    
    
    
    
    if($("#page_name").text() === "focal_compliance_person"){
     // console.log("pagen complaince")
      setTimeout(
          function() 
          {
  
            submitAjax("focal_compliance", "compliance_focal_report_dashboard_all", {}, function (data) {
        

          let totalRec = data.apps_rec_divisional[0].total;
          let totalRecComp = data.total_comp_divisional_year[0].total;
      
          
          let totalpercentage = isNaN(((totalRecComp / totalRec) * 100).toFixed(2)) ? 0+'%' : ((totalRecComp / totalRec) * 100).toFixed(2)+'%';
  
  
      
         // console.log(totalpercentage);
      

             document.getElementById('app-received-today').innerHTML = data.apps_rec_day[0].total;
             document.getElementById('app-received-month').innerHTML = data.apps_rec_month[0].total;
             document.getElementById('app-completed-today').innerHTML = data.apps_comp_day[0].total;
             document.getElementById('app-completed-month').innerHTML = data.apps_comp_month[0].total;
             
             

              // $("#app-received-today").html(
              //   new Intl.NumberFormat().format(data.apps_rec_day[0].total)
              // );
              // $("#app-received-month").html(
              //   new Intl.NumberFormat().format(data.apps_rec_month[0].total)
              // );
              // $("#app-completed-today").html(
              //   new Intl.NumberFormat().format(data.apps_comp_day[0].total)
              // );
              // $("#app-completed-month").html(
              //   new Intl.NumberFormat().format(data.apps_comp_month[0].total)
              // );
          
              // applications received for the year
              showDivisionSummary("#app-received-year", data.apps_rec_divisional, 'info');
          
              // applications completed for the year
              showDivisionSummary("#app-completed-year", data.apps_comp_divisional, 'success');
          
              // applications received and completed for the year
              showDivisionSummary_new(
                "#app-received-completed-year",
                data.apps_comp_divisional_year,
          'default'
              );
          
              // applications past due for the year
              showDivisionSummary(
                "#app-past-due-year",
                data.apps_past_due_dates_divisional,
          'danger'
              );
          
              // applications with divisions
              showDivisionSummary("#app-with-divisions", data.apps_at_division, 'warning');
  
  
              document.getElementById('pec_id').innerHTML = totalpercentage;
  
              
  
             // total_comp_divisional_year
            });
          }, 1000);
      
    }
  
  
  
    
  
  
  
  
  //   if ($("#page_name").text() === "compliance") {
  //     setInterval(function() {
  //         // Your code here
  //         submitAjax("ComplianceReport", "report_dashboard_all", {}, function(data) {
  //             let totalRec = data.total_apps_rec[0].total;
  //             let totalRecComp = data.total_comp_divisional_year[0].total;
  //             let totalpercentage = ((totalRecComp / totalRec) * 100).toFixed(2) + '%';
  //             $("#app-received-today").html(new Intl.NumberFormat().format(data.apps_rec_day[0].total));
  //             $("#app-received-month").html(new Intl.NumberFormat().format(data.apps_rec_month[0].total));
  //             $("#app-completed-today").html(new Intl.NumberFormat().format(data.apps_comp_day[0].total));
  //             $("#app-completed-month").html(new Intl.NumberFormat().format(data.apps_comp_month[0].total));
  
  //             // applications received for the year
  //             showDivisionSummary("#app-received-year", data.apps_rec_divisional, 'info');
  
  //             // applications completed for the year
  //             showDivisionSummary("#app-completed-year", data.apps_comp_divisional, 'success');
  
  //             // applications received and completed for the year
  //             showDivisionSummaryUpdated("#app-received-completed-year", data.apps_comp_divisional_year, 'default');
  
  //             // applications past due for the year
  //             showDivisionSummary("#app-past-due-year", data.apps_past_due_dates_divisional, 'danger');
  
  //             // applications with divisions
  //             showDivisionSummary("#app-with-divisions", data.apps_at_division, 'warning');
  
  //             document.getElementById('pec_id').innerHTML = totalpercentage;
  //         });
  //     }, 60000); // 60000 milliseconds = 1 minute
  // }
  
  
  
    function showDivisionSummary(id, data, color) {
      // console.log(data[0]); // Logging the first data item
  
      let total = data.reduce(function (sum, current) {
       
        return (sum += current.total);
      }, 0);
  //    console.log(total);
  
      $(id).find(".count").html(new Intl.NumberFormat().format(total));
  
      let contentBody = $(id).find(".content-body");
  
      let date = contentBody.data("date") ?? "";
      let period = contentBody.data("period");
      let method = contentBody.data("method");
      let title = contentBody.data("title");
      let url = contentBody.data("url");
      let nextLevelModal = contentBody.data("next-level-modal");
  
      let periodToAdd = typeof period === "undefined" ? "" : `_${period}`;
      let dataHtml = data.reduce(function (sum, current) {
        let percent = ((current.total / total) * 100).toFixed(2);
        


       

  
     
  
        let html = `<div class="item">
          <h4 class="small font-weight-bold">
            <a href="#" data-method="${method}" data-url="${url}" ${
          typeof period === "undefined" ? "" : `data-period="${period}"`
        } data-action="report_dashboard_${method}${periodToAdd}" data-type="${
          current.division
        }" data-date="${date}" data-title="${title}" class="${nextLevelModal} text-decoration-none text-muted">
              ${current.division} (${current.total})
            </a>
            
          </h4>
          <div class="progress mb-4">
            <div class="progress-bar bg-${color}" role="progressbar" style="width: ${percent}%" aria-valuenow="${percent}"
              aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
        <input type='hidden' value='${current.division}' id='currentDivision'> `;
  
        return (sum += html);
      }, "");
  
      contentBody.html(dataHtml);
    }







  //   total_rec_comp_year


    function showDivisionSummary_new(id, data, color) {
      // console.log(data[0]); // Logging the first data item
  
      let total = data.reduce(function (sum, current) {


       
        return (sum += current.total);
      }, 0);
  //    console.log(total);
  
      $(id).find(".count").html(new Intl.NumberFormat().format(total));
  
      let contentBody = $(id).find(".content-body");
  
      let date = contentBody.data("date") ?? "";
      let period = contentBody.data("period");
      let method = contentBody.data("method");
      let title = contentBody.data("title");
      let url = contentBody.data("url");
      let nextLevelModal = contentBody.data("next-level-modal");
  
      let periodToAdd = typeof period === "undefined" ? "" : `_${period}`;
      let dataHtml = data.reduce(function (sum, current) {
      

        let newtotal = firmList.total_comp_divisional_year[0].total;
        let totalRec = firmList.total_apps_rec[0].total;

        //let lrdData = firmList.apps_rec_divisional.find(item => item.division === "LRD");


        //let lrd_Data = lrdData.total;

        let percent = ((current.total / totalRec) * 100).toFixed(2);

        //console.log(lrd_Data);

        document.getElementById('total_rec_comp_year').innerHTML = newtotal;
  
       // console.log(percent);
  
        let html = `<div class="item">
          <h4 class="small font-weight-bold">
            <a href="#" data-method="${method}" data-url="${url}" ${
          typeof period === "undefined" ? "" : `data-period="${period}"`
        } data-action="report_dashboard_${method}${periodToAdd}" data-type="${
          current.division
        }" data-date="${date}" data-title="${title}" class="${nextLevelModal} text-decoration-none text-muted">
              ${current.division} (${current.total})
            </a>
            <span class="float-right">${percent}%</span>
          </h4>
          <div class="progress mb-4">
            <div class="progress-bar bg-${color}" role="progressbar" style="width: ${percent}%" aria-valuenow="${percent}"
              aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
        <input type='hidden' value='${current.division}' id='currentDivision'> `;
  
        return (sum += html);
      }, "");
  
      contentBody.html(dataHtml);
    }
  
  
  
  
  
    function showDivisionSummaryUpdated(id, data,color) {
      
      let newtotal = firmList.total_apps_rec[0].total;
  
      let lrdData = firmList.apps_rec_divisional.find(item => item.division === "LRD");
      let lvdData = firmList.apps_rec_divisional.find(item => item.division === "LVD");
      let pvlmdData = firmList.apps_rec_divisional.find(item => item.division === "PVLMD");
      let smdData = firmList.apps_rec_divisional.find(item => item.division === "SMD");
  
  
  
  
      let lrdData1 = firmList.apps_comp_divisional_year.find(item => item.division === "LRD");
      let lvdData1 = firmList.apps_comp_divisional_year.find(item => item.division === "LVD");
      let pvlmdData1 = firmList.apps_comp_divisional_year.find(item => item.division === "PVLMD");
      let smdData1 = firmList.apps_comp_divisional_year.find(item => item.division === "SMD");
    
  
      let lrd_rec_total = lrdData && lrdData.total !== '' ? lrdData.total : 0;
      let lvd_rec_total = lvdData && lvdData.total !== '' ? lvdData.total : 0;
      let pvlmd_rec_total = pvlmdData && pvlmdData.total !== '' ? pvlmdData.total : 0;
      let smd_rec_total = smdData && smdData.total !== '' ? smdData.total : 0;
  
  
      let lrd_rec_comp_total = lrdData1 && lrdData1.total !== '' ? lrdData1.total : 0;
      let lvd_rec_comp_total = lvdData1 && lvdData1.total !== '' ? lvdData1.total : 0;
      let pvlmd_rec_comp_total = pvlmdData1 && pvlmdData1.total !== '' ? pvlmdData1.total : 0;
      let smd_rec_comp_total = smdData1 && smdData1.total !== '' ? smdData1.total : 0;
  
  
  
      // console.log(lrd_rec_total,lvd_rec_total,pvlmd_rec_total,smd_rec_total);
  
  
  
      let lrdtotalpercentage = isNaN(((lrd_rec_comp_total / lrd_rec_total) * 100).toFixed(2)) ? 0 : ((lrd_rec_comp_total / lrd_rec_total) * 100).toFixed(2);
      let lvdtotalpercentage = isNaN(((lvd_rec_comp_total / lvd_rec_total) * 100).toFixed(2)) ? 0 : ((lvd_rec_comp_total / lvd_rec_total) * 100).toFixed(2);
      let pvlmdtotalpercentage = isNaN(((pvlmd_rec_comp_total / pvlmd_rec_total) * 100).toFixed(2)) ? 0 : ((pvlmd_rec_comp_total / pvlmd_rec_total) * 100).toFixed(2);
       let smdtotalpercentage = isNaN(((smd_rec_comp_total / smd_rec_total) * 100).toFixed(2)) ? 0 : ((smd_rec_comp_total / smd_rec_total) * 100).toFixed(2);
  
  
  
  
  
       
      let total = data.reduce(function (sum, current) {
       
        return (sum += current.total);
      }, 0);
     // let total = totalPerRec;
     //console.log(newtotal);
     
  
      $(id).find(".count").html(new Intl.NumberFormat().format(total));
  
      let contentBody = $(id).find(".content-body");
  
      let date = contentBody.data("date") ?? "";
      let period = contentBody.data("period");
      let method = contentBody.data("method");
      let title = contentBody.data("title");
      let url = contentBody.data("url");
      let nextLevelModal = contentBody.data("next-level-modal");
  
      let periodToAdd = typeof period === "undefined" ? "" : `_${period}`;
      let dataHtml = data.reduce(function (sum, current) {
        let percent = ((current.total / newtotal) * 100).toFixed(2);
       
        
       
  
       // console.log(percent);
  
        let html = `<div class="item">
          <h4 class="small font-weight-bold">
            <a href="#" data-method="${method}" data-url="${url}" ${
          typeof period === "undefined" ? "" : `data-period="${period}"`
        } data-action="report_dashboard_${method}${periodToAdd}" data-type="LRD" data-date="${date}" data-title="${title}" class="${nextLevelModal} text-decoration-none text-muted">
              LRD (${lrd_rec_comp_total})
            </a>
            <span class="float-right">${lrdtotalpercentage}%</span>
          </h4>
          <div class="progress mb-4">
            <div class="progress-bar bg-${color}" role="progressbar" style="width: ${lrdtotalpercentage}%" aria-valuenow="${lrdtotalpercentage}"
              aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
  
  
        <div class="item">
          <h4 class="small font-weight-bold">
            <a href="#" data-method="${method}" data-url="${url}" ${
          typeof period === "undefined" ? "" : `data-period="${period}"`
        } data-action="report_dashboard_${method}${periodToAdd}" data-type="LVD" data-date="${date}" data-title="${title}" class="${nextLevelModal}
         text-decoration-none text-muted">
              LVD (${lvd_rec_comp_total})
            </a>
            <span class="float-right">${lvdtotalpercentage}%</span>
          </h4>
          <div class="progress mb-4">
            <div class="progress-bar bg-${color}" role="progressbar" style="width: ${lvdtotalpercentage}%" aria-valuenow="${lvdtotalpercentage}"
              aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
  
  
  
        <div class="item">
          <h4 class="small font-weight-bold">
            <a href="#" data-method="${method}" data-url="${url}" ${
          typeof period === "undefined" ? "" : `data-period="${period}"`
        } data-action="report_dashboard_${method}${periodToAdd}" data-type="PVLMD" data-date="${date}" data-title="${title}" class="${nextLevelModal} text-decoration-none text-muted">
              PVLMD (${pvlmd_rec_comp_total})
            </a>
            <span class="float-right">${pvlmdtotalpercentage}%</span>
          </h4>
          <div class="progress mb-4">
            <div class="progress-bar bg-${color}" role="progressbar" style="width: ${pvlmdtotalpercentage}%" aria-valuenow="${pvlmdtotalpercentage}"
              aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
  
  
        
        <div class="item">
          <h4 class="small font-weight-bold">
            <a href="#" data-method="${method}" data-url="${url}" ${
          typeof period === "undefined" ? "" : `data-period="${period}"`
        } data-action="report_dashboard_${method}${periodToAdd}" data-type="SMD" data-date="${date}" data-title="${title}" class="${nextLevelModal} text-decoration-none text-muted">
              SMD (${smd_rec_comp_total})
            </a>
            <span class="float-right">${smdtotalpercentage}%</span>
          </h4>
          <div class="progress mb-4">
            <div class="progress-bar bg-${color}" role="progressbar" style="width: ${smdtotalpercentage}%" aria-valuenow="${smdtotalpercentage}"
              aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
        `
        ;
  
        return (html);
      }, "");
  
      contentBody.html(dataHtml);
    }
  
  
  
    
//     var firmList; // global variable
  
  
  
    function submitAjax(
      url,
      requestType,
      data = {},
      success = function () {},
      error = function () {}
    ) {
     
     var region_id =$('#sel_change_region_compliance').val();
    
    
  
  //    if(region_id != undefined){
  //     region_id =  region_id.replace(".0", "");
  //    }


      var user_division = $('#director_division').val();
      var region_code = $('#director_regional_code').val();
  //    console.log(user_division,user_division);
  
      $.ajax({
        type: "POST",
        url,
        data: {
          request_type: requestType,
          region_id: region_code,
          division: user_division,
          ...data,
        },
        cache: false,
        success: function (response) {
        var reccc = JSON.parse(response);
        console.log(reccc);

        firmList = reccc;
        
        //  let totalPerRec = reccc.apps_rec_divisional[0].total;
        // let lrdData = reccc.apps_at_division.find(item => item.division === "LRD");
        // let  lrdTotal = lrdData.total;
        
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
  });
  
  

$(document).ready(function() {

    $('#apps_received_today').on('click', function(e) {
        e.preventDefault();

     $("#user_divisionModal").modal("show");  

        var regional_code = $('#director_regional_code').val();
        var division = $('#director_division').val();
        console.log(regional_code,division);


        $.ajax({
            type : "POST",
            url : "focal_compliance",
            data : {
                request_type : 'compliance_focal_report_dashboard_created_today',
                region_id : regional_code.trim(),
                user_division:division
            },
            cache: false,
            success: function(response) {

                var json_result = JSON.parse(response);
               
              var count =  json_result.apps_at_division[0].total;
              var current_division =  json_result.apps_at_division[0].division;

                 document.getElementById('user_division').innerHTML = current_division;
                 document.getElementById('div_count').innerHTML = count;


                // console.log(count);

            }
        })
    })



    $('#user_division_today').on('click', function(e) {
        e.preventDefault();

     $("#serviceTypeModal").modal("show");  
    const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
    const currentDate = new Date();
    const day = currentDate.getDate();
    const monthIndex = currentDate.getMonth();
    const year = currentDate.getFullYear();
    const formattedDate = `${day} ${months[monthIndex]} ${year}`;


        var regional_code = $('#director_regional_code').val();
        var division = $('#director_division').val();

        var title  = division+"'"+'s'+" "+"Applications Received Today"+" "+formattedDate;

        document.getElementById('serviceTypeModalLabel').innerHTML = title;

        
       //console.log(regional_code,division);



        $.ajax({
            type : "POST",
            url : "focal_compliance",
            data : { 
                request_type : 'compliance_focal_report_dashboard_created_day_by_division',
                region_id : regional_code.trim(),
                division:division
            },
            cache: false,
            success: function(response) {
               // console.log(response);

                var json_result = JSON.parse(response);

                console.log(json_result.apps_at_division);

                if (json_result.apps_at_division == ''){

                    //.log("data not found");       
    
    }else {

        let dataSet1 = [];
        let num1 = 0;
 
      $('#created_by_services_today').DataTable().clear().destroy();

        for(let i=0; i<json_result.apps_at_division.length; i++) {
            let html = [];
            num1 = +num1 + 1;

            let service_type = json_result.apps_at_division[i].service_type;
            let total = json_result.apps_at_division[i].total;
            let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}"  id="view_recieved_today_by_service"  
            class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

            // let payment_status = e[i].payment_status;
            // let buttons = e[i].buttons;
            html.push(service_type);
            html.push(total);
            html.push(action);

            dataSet1.push(html);

          ///console.log(dataSet1)
          }

        // let dataTable_Obj = $('#recievedtoday').DataTable({
        //     data: dataSet1
        //   })

          $('#created_by_services_today').DataTable().clear().destroy();
                        
          $('#created_by_services_today').DataTable({ data: dataSet1,
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






    $(document).on('click','#view_recieved_today_by_service',function(e){
        e.preventDefault();
       
    $("#applicationsModal").modal("show");  
   

    const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
    const currentDate = new Date();
    const day = currentDate.getDate();
    const monthIndex = currentDate.getMonth();
    const year = currentDate.getFullYear();
    const formattedDate = `${day} ${months[monthIndex]} ${year}`;


        var regional_code = $('#director_regional_code').val();
        // var division = $('#director_division').val();

        var service_type=$(this).data('id');


        var title  = service_type+" "+"Applications Received Today"+" "+formattedDate;

        document.getElementById('applicationsModalLabel').innerHTML = title;

      //  console.log(service_type);

      
       let dataSet51 = [];
       let num51 = 0;
      
      $('#view_applications_by_service_type').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "focal_compliance",
           data : {
               request_type : 'compliance_focal_report_dashboard_created_day_by_service_type',
               region_id : regional_code,
               service_type : service_type
           },
           cache: false,
           success: function(response) {
      
            //console.log(response)
      
               var json_result = JSON.parse(response);
               console.log(json_result)
      
               if (json_result.apps_at_division == ""){
      
                //console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num51 = +num51 + 1;
      
          let job_number = json_result.apps_at_division[i].job_number;
          let ar_name = json_result.apps_at_division[i].ar_name;
          let business_process_name = json_result.apps_at_division[i].business_process_name;
          let created_date = json_result.apps_at_division[i].created_date;
          let due_date = json_result.apps_at_division[i].due_date;
          let days_due = json_result.apps_at_division[i].days_due;
          let days_since_batched = json_result.apps_at_division[i].days_since_batched;
        //  let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
      
          html.push(job_number);
          html.push(ar_name);
          html.push(business_process_name);
          html.push(created_date);
          html.push(due_date);
          html.push(days_due);
          html.push(days_since_batched);
        //   html.push(action);
      
          dataSet51.push(html);
      
        //console.log(dataSet)
        }
      
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
      
        $('#view_applications_by_service_type').DataTable().clear().destroy();
                      
        $('#view_applications_by_service_type').DataTable({ data: dataSet51,
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







    $('#apps_received_this_month').on('click', function(e) {
        e.preventDefault();

     $("#user_divisionModal_this_month").modal("show");  

        var regional_code = $('#director_regional_code').val();
        var division = $('#director_division').val();
        console.log(regional_code,division);


        $.ajax({
            type : "POST",
            url : "focal_compliance",
            data : {
                request_type : 'compliance_focal_report_dashboard_created_this_month',
                region_id : regional_code.trim(),
                user_division:division
            },
            cache: false,
            success: function(response) {

                var json_result = JSON.parse(response);
                //console.log(json_result);
               
              var count =  json_result.apps_at_division[0].total;
              var current_division =  json_result.apps_at_division[0].division;

                 document.getElementById('user_division_month').innerHTML = current_division;
                 document.getElementById('div_count_month').innerHTML = count;


                // console.log(count);

            }
        })
    })





    $('#user_division_this_month').on('click', function(e) {
      e.preventDefault();

   $("#serviceTypeModalMonth").modal("show");  
  const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${months[monthIndex]}`;


      var regional_code = $('#director_regional_code').val();
      var division = $('#director_division').val();

      var title  = division+"'"+'s'+" "+"Applications Received This Month"+" "+"("+formattedDate+")";

      document.getElementById('serviceTypeModalLabelMonth').innerHTML = title;

      
     //console.log(regional_code,division);



      $.ajax({
          type : "POST",
          url : "focal_compliance",
          data : { 
              request_type : 'compliance_focal_report_dashboard_created_month_by_division',
              region_id : regional_code.trim(),
              division:division
          },
          cache: false,
          success: function(response) {
             console.log(response);

              var json_result = JSON.parse(response);

              console.log(json_result.apps_at_division);

              if (json_result.apps_at_division == ''){

                  //.log("data not found");       
  
  }else {

      let dataSet2 = [];
      let num2 = 0;

    $('#created_by_services_month').DataTable().clear().destroy();

      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num2 = +num2 + 1;

          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}"  id="view_recieved_month_by_service"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          html.push(service_type);
          html.push(total);
          html.push(action);

          dataSet2.push(html);

        ///console.log(dataSet1)
        }

      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })

        $('#created_by_services_month').DataTable().clear().destroy();
                      
        $('#created_by_services_month').DataTable({ data: dataSet2,
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

      



  $(document).on('click','#view_recieved_month_by_service',function(e){
    e.preventDefault();
   
$("#applicationsModalRecievedMonth").modal("show");  


const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${day} ${months[monthIndex]} ${year}`;


    var regional_code = $('#director_regional_code').val();
    // var division = $('#director_division').val();

    var service_type=$(this).data('id');


    var title  = service_type+" "+"Applications Received Month"+" "+formattedDate;

    document.getElementById('applicationsModalLabelRecievedMonth').innerHTML = title;

  //  console.log(service_type);

  
   let dataSet5 = [];
   let num5 = 0;
  
  $('#view_applications_month_by_service_type').DataTable().clear().destroy();
  
   $.ajax({
       type : "POST",
       url : "focal_compliance",
       data : {
           request_type : 'compliance_focal_report_dashboard_created_month_by_service_type',
           region_id : regional_code,
           service_type : service_type
       },
       cache: false,
       success: function(response) {
  
        //console.log(response)
  
           var json_result = JSON.parse(response);
           console.log(json_result)
  
           if (json_result.apps_at_division == ""){
  
            //console.log("data not found");       
  
  }else {
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num5 = +num5 + 1;
  
      let job_number = json_result.apps_at_division[i].job_number;
      let ar_name = json_result.apps_at_division[i].ar_name;
      let business_process_name = json_result.apps_at_division[i].business_process_name;
      let created_date = json_result.apps_at_division[i].created_date;
      let due_date = json_result.apps_at_division[i].due_date;
      let days_due = json_result.apps_at_division[i].days_due;
      let days_since_batched = json_result.apps_at_division[i].days_since_batched;
    //  let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      
  
      html.push(job_number);
      html.push(ar_name);
      html.push(business_process_name);
      html.push(created_date);
      html.push(due_date);
      html.push(days_due);
      html.push(days_since_batched);
    //   html.push(action);
  
      dataSet5.push(html);
  
    //console.log(dataSet)
    }
  
  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })
  
    $('#view_applications_month_by_service_type').DataTable().clear().destroy();
                  
    $('#view_applications_month_by_service_type').DataTable({ data: dataSet5,
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



  $('#apps_completed_today_division').on('click', function(e) {
    e.preventDefault();

 $("#user_completed_divison_today").modal("show");  

    var regional_code = $('#director_regional_code').val();
    var division = $('#director_division').val();
    console.log(regional_code,division);


    $.ajax({
        type : "POST",
        url : "director_dashboard",
        data : {
            request_type : 'director_report_dashboard_completed_today',
            region_id : regional_code.trim(),
            user_division:division
        },
        cache: false,
        success: function(response) {

            var json_result = JSON.parse(response);
                  console.log(json_result);


           
          var count =  json_result.apps_at_division[0].total;
          var current_division =  json_result.apps_at_division[0].division;

             document.getElementById('user_division_completed_today').innerHTML = current_division;
             document.getElementById('div_count_completed_toda').innerHTML = count;


            // console.log(count);

        }
    })
})






$(document).on('click','#view_recieved_today_by_service',function(e){
  e.preventDefault();
 
$("#applicationsModal").modal("show");  


const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${day} ${months[monthIndex]} ${year}`;


  var regional_code = $('#director_regional_code').val();
  // var division = $('#director_division').val();

  var service_type=$(this).data('id');


  var title  = service_type+" "+"Applications Received Today"+" "+formattedDate;

  document.getElementById('applicationsModalLabel').innerHTML = title;

//  console.log(service_type);


 let dataSet51 = [];
 let num51 = 0;

$('#view_applications_by_service_type').DataTable().clear().destroy();

 $.ajax({
     type : "POST",
     url : "focal_compliance",
     data : {
         request_type : 'compliance_focal_report_dashboard_created_day_by_service_type',
         region_id : regional_code,
         service_type : service_type
     },
     cache: false,
     success: function(response) {

      //console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result)

         if (json_result.apps_at_division == ""){

          //console.log("data not found");       

}else {

  for(let i=0; i<json_result.apps_at_division.length; i++) {
    let html = [];
    num51 = +num51 + 1;

    let job_number = json_result.apps_at_division[i].job_number;
    let ar_name = json_result.apps_at_division[i].ar_name;
    let business_process_name = json_result.apps_at_division[i].business_process_name;
    let created_date = json_result.apps_at_division[i].created_date;
    let due_date = json_result.apps_at_division[i].due_date;
    let days_due = json_result.apps_at_division[i].days_due;
    let days_since_batched = json_result.apps_at_division[i].days_since_batched;
  //  let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
    // let payment_status = e[i].payment_status;
    // let buttons = e[i].buttons;
    

    html.push(job_number);
    html.push(ar_name);
    html.push(business_process_name);
    html.push(created_date);
    html.push(due_date);
    html.push(days_due);
    html.push(days_since_batched);
  //   html.push(action);

    dataSet51.push(html);

  //console.log(dataSet)
  }

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

  $('#view_applications_by_service_type').DataTable().clear().destroy();
                
  $('#view_applications_by_service_type').DataTable({ data: dataSet51,
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





$('#completed_today_service').on('click', function(e) {
  e.preventDefault();

$("#completedTodayserviceTypeModal").modal("show");  
const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${day} ${months[monthIndex]} ${year}`;


  var regional_code = $('#director_regional_code').val();
  var division = $('#director_division').val();

  var title  = division+"'"+'s'+" "+"Applications Completed Today"+" "+formattedDate;

  document.getElementById('completedTodayserviceTypeModalLabel').innerHTML = title;

  
 //console.log(regional_code,division);



  $.ajax({
      type : "POST",
      url : "focal_compliance",
      data : { 
          request_type : 'compliance_focal_report_dashboard_completed_today_by_division',
          region_id : regional_code.trim(),
          division:division
      },
      cache: false,
      success: function(response) {
        console.log(response);

          var json_result = JSON.parse(response);

          console.log(json_result.apps_at_division);

          if (json_result.apps_at_division == ''){

              //.log("data not found");       

}else {

  let dataSet6 = [];
  let num6 = 0;

$('#completed_serviceType_Table').DataTable().clear().destroy();

  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num6 = +num6 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}"  id="apps_completed_today_servicetype"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      html.push(service_type);
      html.push(total);
      html.push(action);

      dataSet6.push(html);

    ///console.log(dataSet1)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#completed_serviceType_Table').DataTable().clear().destroy();
                  
    $('#completed_serviceType_Table').DataTable({ data: dataSet6,
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






$(document).on('click','#apps_completed_today_servicetype',function(e){
  e.preventDefault();
 
$("#applicationsModalCompletedToday").modal("show");  


const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${day} ${months[monthIndex]} ${year}`;


  var regional_code = $('#director_regional_code').val();
  // var division = $('#director_division').val();

  var service_type=$(this).data('id');


  var title  = service_type+" "+"Applications Completed Today"+" "+formattedDate;

  document.getElementById('applicationsModalLabelCompletedToday').innerHTML = title;

//  console.log(service_type);


 let dataSet7 = [];
 let num7 = 0;

$('#view_applications_completed_today_by_service_type').DataTable().clear().destroy();

 $.ajax({
     type : "POST",
     url : "focal_compliance",
     data : {
         request_type : 'compliance_focal_report_dashboard_completed_today_by_service_ty',
         region_id : regional_code,
         service_type : service_type
     },
     cache: false,
     success: function(response) {

      //console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result)

         if (json_result.apps_at_division == ""){

          //console.log("data not found");       

}else {

  for(let i=0; i<json_result.apps_at_division.length; i++) {
    let html = [];
    num7 = +num7 + 1;

    let job_number = json_result.apps_at_division[i].job_number;
    let ar_name = json_result.apps_at_division[i].ar_name;
    let business_process_name = json_result.apps_at_division[i].business_process_name;
    let created_date = json_result.apps_at_division[i].created_date;
    let completed_date = json_result.apps_at_division[i].completed_date;
    let days_due = json_result.apps_at_division[i].days_due;
    // let days_since_batched = json_result.apps_at_division[i].days_since_batched;
   let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
    // let payment_status = e[i].payment_status;
    // let buttons = e[i].buttons;
    

    html.push(job_number);
    html.push(ar_name);
    html.push(business_process_name);
    html.push(created_date);
    html.push(completed_date);
    html.push(days_due);
    html.push(action);
  //   html.push(action);

    dataSet7.push(html);

  //console.log(dataSet)
  }

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

  $('#view_applications_completed_today_by_service_type').DataTable().clear().destroy();
                
  $('#view_applications_completed_today_by_service_type').DataTable({ data: dataSet7,
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





$('#apps_completed_month_division').on('click', function(e) {
  e.preventDefault();

$("#user_completed_divison_month").modal("show");  

  var regional_code = $('#director_regional_code').val();
  var division = $('#director_division').val();
  console.log(regional_code,division);


  $.ajax({
      type : "POST",
      url : "focal_compliance",
      data : {
          request_type : 'compliance_focal_report_dashboard_completed_month',
          region_id : regional_code.trim(),
          user_division:division
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
                console.log(json_result);


         
        var count =  json_result.apps_at_division[0].total;
        var current_division =  json_result.apps_at_division[0].division;

           document.getElementById('user_division_completed_month').innerHTML = current_division;
           document.getElementById('div_count_completed_momth').innerHTML = count;


          // console.log(count);

      }
  })
})






$('#completed_month_service').on('click', function(e) {
  e.preventDefault();

$("#completedMonthserviceTypeModal").modal("show");  
const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${months[monthIndex]}`;


  var regional_code = $('#director_regional_code').val();
  var division = $('#director_division').val();

  var title  = division+"'"+'s'+" "+"Applications Completed Month"+" "+formattedDate;

  document.getElementById('completedMonthserviceTypeModalLabel').innerHTML = title;

  
 //console.log(regional_code,division);



  $.ajax({
      type : "POST",
      url : "focal_compliance",
      data : { 
          request_type : 'compliance_focal_report_dashboard_completed_month_by_division',
          region_id : regional_code.trim(),
          division:division
      },
      cache: false,
      success: function(response) {
        console.log(response);

          var json_result = JSON.parse(response);

          console.log(json_result.apps_at_division);

          if (json_result.apps_at_division == ''){

              //.log("data not found");       

}else {

  let dataSet8 = [];
  let num8 = 0;

$('#completed_MonthserviceType_Table').DataTable().clear().destroy();

  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num8 = +num8 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}"  id="apps_completed_month_servicetype"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      html.push(service_type);
      html.push(total);
      html.push(action);

      dataSet8.push(html);

    ///console.log(dataSet1)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#completed_MonthserviceType_Table').DataTable().clear().destroy();
                  
    $('#completed_MonthserviceType_Table').DataTable({ data: dataSet8,
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







$(document).on('click','#apps_completed_month_servicetype',function(e){
  e.preventDefault();
 
$("#applicationsModalCompletedMonth").modal("show");  


const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${months[monthIndex]}`;


  var regional_code = $('#director_regional_code').val();
  // var division = $('#director_division').val();

  var service_type=$(this).data('id');


  var title  = service_type+" "+"Applications Completed This Month"+" "+formattedDate;

  document.getElementById('applicationsModalLabelCompletedMonth').innerHTML = title;

//  console.log(service_type);


 let dataSet9 = [];
 let num9 = 0;

$('#view_applications_completed_month_by_service_type').DataTable().clear().destroy();

 $.ajax({
     type : "POST",
     url : "focal_compliance",
     data : {
         request_type : 'compliance_focal_report_dashboard_completed_month_by_service_ty',
         region_id : regional_code,
         service_type : service_type
     },
     cache: false,
     success: function(response) {

      //console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result)

         if (json_result.apps_at_division == ""){

          //console.log("data not found");       

}else {

  for(let i=0; i<json_result.apps_at_division.length; i++) {
    let html = [];
    num9 = +num9 + 1;

    let job_number = json_result.apps_at_division[i].job_number;
    let ar_name = json_result.apps_at_division[i].ar_name;
    let business_process_name = json_result.apps_at_division[i].business_process_name;
    let created_date = json_result.apps_at_division[i].created_date;
    let completed_date = json_result.apps_at_division[i].completed_date;
    let days_due = json_result.apps_at_division[i].days_due;
    // let days_since_batched = json_result.apps_at_division[i].days_since_batched;
   let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
    // let payment_status = e[i].payment_status;
    // let buttons = e[i].buttons;
    

    html.push(job_number);
    html.push(ar_name);
    html.push(business_process_name);
    html.push(created_date);
    html.push(completed_date);
    html.push(days_due);
    html.push(action);
  //   html.push(action);

    dataSet9.push(html);

  //console.log(dataSet)
  }

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

  $('#view_applications_completed_month_by_service_type').DataTable().clear().destroy();
                
  $('#view_applications_completed_month_by_service_type').DataTable({ data: dataSet9,
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














$(document).on("click", ".showServiceTypeModal_apps_pastdue", function (event) {
  event.preventDefault();

  $("#unitModal").modal("show");  

  var users_division = $('#currentDivision').val();

  var regional_code = $('#director_regional_code').val();


const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${year}`;


var title  = users_division+"'s"+" "+"Applications Past Due Date This Year "+" "+"("+formattedDate+")";

document.getElementById('divisionLabelCompletedYear').innerHTML = title;




  console.log(users_division,regional_code);

  $.ajax({
    type : "POST",
    url : "focal_compliance",
    data : { 
        request_type : 'compliance_focal_apps_pastdue_units',
        region_id : regional_code.trim(),
        division:users_division
    },
    cache: false,
    success: function(response) {
       // console.log(response);

        var json_result = JSON.parse(response);

        console.log(json_result.apps_at_division_unit);

        if (json_result.apps_at_division_unit == ''){

            //.log("data not found");       
}else {

let dataSet15 = [];
let num15 = 0;

$('#apps_past_due_unit').DataTable().clear().destroy();

for(let i=0; i<json_result.apps_at_division_unit.length; i++) {
    let html = [];
    num15= +num15 + 1;

    let unit = json_result.apps_at_division_unit[i].unit;
    let total = json_result.apps_at_division_unit[i].total;
    let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division_unit[i].unit_id}"   data-name="${json_result.apps_at_division_unit[i].unit}"  id="view_apps_pastdue_within_units"  
    class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

    // let payment_status = e[i].payment_status;
    // let buttons = e[i].buttons;
    html.push(unit);
    html.push(total);
    html.push(action);

    dataSet15.push(html);

  ///console.log(dataSet1)
  }

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

  $('#apps_past_due_unit').DataTable().clear().destroy();
                
  $('#apps_past_due_unit').DataTable({ data: dataSet15,
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







$(document).on('click','#view_apps_pastdue_within_units',function(e){
  e.preventDefault();
 
$("#officerModal").modal("show");  


const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${months[monthIndex]}`;


  var regional_code = $('#director_regional_code').val();
  // var division = $('#director_division').val();

  var unit_id=$(this).data('id');
  var name=$(this).data('name');

  

  var users_division = $('#currentDivision').val();

  var regional_code = $('#director_regional_code').val();



     console.log(unit_id);



  var title  = name+" "+"Applications Past Due"+" "+formattedDate;

  document.getElementById('officerModalLabel').innerHTML = title;



 let dataSet16 = [];
 let num16 = 0;

$('#past_due_officers_table').DataTable().clear().destroy();

 $.ajax({
     type : "POST",
     url : "focal_compliance",
     data : {
         request_type : 'compliance_focal_apps_pastdue_within_unit',
         region_id : regional_code,
         division : users_division,
         unit : unit_id
     },
     cache: false,
     success: function(response) {

      //console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result)

         if (json_result.apps_at_unit == ""){

          //console.log("data not found");       

}else {

  for(let i=0; i<json_result.apps_at_unit.length; i++) {
    let html = [];
    num16 = +num16 + 1;

    let staff = json_result.apps_at_unit[i].staff;
    let total = json_result.apps_at_unit[i].total;
    // let days_since_batched = json_result.apps_at_division[i].days_since_batched;
   let action = `<a href="#" id="past_due_apps"  data-id="${json_result.apps_at_unit[i].staff_id}"  data-name="${json_result.apps_at_unit[i].staff}"  class="btn btn-secondary">View <i class="fa fa-eye"></i></a>`;
    // let payment_status = e[i].payment_status;
    // let buttons = e[i].buttons;
    

    html.push(staff);
    html.push(total);
    html.push(action);
  //   html.push(action);

    dataSet16.push(html);

  //console.log(dataSet)
  }

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

  $('#past_due_officers_table').DataTable().clear().destroy();
                
  $('#past_due_officers_table').DataTable({ data: dataSet16,
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











$(document).on('click','#past_due_apps',function(e){
  e.preventDefault();
 
$("#past_due_apps_modal").modal("show");  


const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${day} ${months[monthIndex]} ${year}`;


//     var regional_code = $('#director_regional_code').val();
//     // var division = $('#director_division').val();

  var staff_id=$(this).data('id');
  var staff_name=$(this).data('name');

  console.log(staff_id);


  var title  = staff_name+"'s"+" "+"Applications Past Due"+" "+"("+year+")";


//   var title  = staff_name+" "+"Applications Past Due"+" "+year;


  document.getElementById('past_due_apps_Label').innerHTML = title;

//   //  console.log(service_type);


 let dataSet17 = [];
 let num17 = 0;

$('#past_due_apps_with_staff').DataTable().clear().destroy();

 $.ajax({
     type : "POST",
     url : "focal_compliance",
     data : {
         request_type : 'compliance_focal_apps_pastdue_with_officer',
         staff_id : staff_id
     },
     cache: false,
     success: function(response) {

      //console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result)

         if (json_result.apps_with_staff == ""){

          //console.log("data not found");       

}else {

  for(let i=0; i<json_result.apps_with_staff.length; i++) {
    let html = [];
    num17 = +num17 + 1;

    let job_number = json_result.apps_with_staff[i].job_number;
    let ar_name = json_result.apps_with_staff[i].ar_name;
    let business_process_name = json_result.apps_with_staff[i].business_process_name;
    let created_date = json_result.apps_with_staff[i].created_date;
    let due_date = json_result.apps_with_staff[i].due_date;
    let days_due = json_result.apps_with_staff[i].days_due;
    let days_since_batched = json_result.apps_with_staff[i].days_since_batched;
    let job_purpose = json_result.apps_with_staff[i].job_purpose;
   let action = `<div class="btn-group" role="group">
   <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
     Actions
   </button>
   <div class="dropdown-menu">
   <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
     <input type="hidden" name="case_number" id="case_number" value="">
     <input type="hidden" name="search_text" id="search_text" value="">
     <input type="hidden" name="job_number" id="job_number" value="">
     <input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="">
     <button type="submit" name="save" class="dropdown-item" >View</button>
   </form>   
   <button type="button" class="dropdown-item" href="#" data-staff_name="${staff_name}" data-staff_id="${staff_id}" data-job_number="${job_number}" data-target="#sendMessageModal_FocalCompliance" data-toggle="modal" >Send Message</button>
   </div>
 </div`;
    // let payment_status = e[i].payment_status;
    // let buttons = e[i].buttons;
    

    html.push(job_number);
    html.push(ar_name);
    html.push(business_process_name);
    html.push(created_date);
    html.push(due_date);
    html.push(days_due);
    html.push(days_since_batched);
    html.push(job_purpose);
    html.push(action);

    dataSet17.push(html);

  //console.log(dataSet)
  }

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

  $('#past_due_apps_with_staff').DataTable().clear().destroy();
                
  $('#past_due_apps_with_staff').DataTable({ data: dataSet17,
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







$(document).on("click", ".showServiceTypeModal_apps_with_divisions", function (event) {
  event.preventDefault();

  $("#unitModal").modal("show");  

  var users_division = $('#currentDivision').val();

  var regional_code = $('#director_regional_code').val();


const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${year}`;


var title  = users_division+"'s"+" "+"Units Applications";

document.getElementById('divisionLabelCompletedYear').innerHTML = title;




  console.log(users_division,regional_code);

  $.ajax({
    type : "POST",
    url : "focal_compliance",
    data : { 
        request_type : 'compliance_focal_apps_with_division',
        region_id : regional_code.trim(),
        division:users_division
    },
    cache: false,
    success: function(response) {
       // console.log(response);

        var json_result = JSON.parse(response);

        console.log(json_result.apps_at_division_unit);

        if (json_result.apps_at_division_unit == ''){

          //.log("data not found");       
}else {

let dataSet18 = [];
let num18 = 0;

$('#apps_past_due_unit').DataTable().clear().destroy();

for(let i=0; i<json_result.apps_at_division_unit.length; i++) {
  let html = [];
  num18= +num18 + 1;

  let unit = json_result.apps_at_division_unit[i].unit;
  let total = json_result.apps_at_division_unit[i].total;
  let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division_unit[i].unit_id}"   data-name="${json_result.apps_at_division_unit[i].unit}"  id="view_apps_divisions_within_units"  
  class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

  // let payment_status = e[i].payment_status;
  // let buttons = e[i].buttons;
  html.push(unit);
  html.push(total);
  html.push(action);

  dataSet18.push(html);

///console.log(dataSet1)
}

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

$('#apps_past_due_unit').DataTable().clear().destroy();
              
$('#apps_past_due_unit').DataTable({ data: dataSet18,
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








$(document).on('click','#view_apps_divisions_within_units',function(e){
  e.preventDefault();
 
$("#officerModal").modal("show");  


const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${months[monthIndex]}`;


  var regional_code = $('#director_regional_code').val();
  // var division = $('#director_division').val();

  var unit_id=$(this).data('id');
  var name=$(this).data('name');

  

  var users_division = $('#currentDivision').val();

  var regional_code = $('#director_regional_code').val();



     console.log(unit_id);


     
  var title  = name+"'s"+" "+"Officers Applications";

  // var title  = name+" "+"Officers Applications";

  document.getElementById('officerModalLabel').innerHTML = title;



 let dataSet19 = [];
 let num19 = 0;

$('#past_due_officers_table').DataTable().clear().destroy();

 $.ajax({
     type : "POST",
     url : "focal_compliance",
     data : {
         request_type : 'compliance_focal_apps_with_division_unit',
         region_id : regional_code,
         division : users_division,
         unit : unit_id
     },
     cache: false,
     success: function(response) {

      //console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result)

         if (json_result.apps_at_unit == ""){

          //console.log("data not found");       

}else {

  for(let i=0; i<json_result.apps_at_unit.length; i++) {
    let html = [];
    num19 = +num19 + 1;

    let staff = json_result.apps_at_unit[i].staff;
    let total = json_result.apps_at_unit[i].total;
    // let days_since_batched = json_result.apps_at_division[i].days_since_batched;
   let action = `<a href="#" id="apps_with_division_officers"  data-id="${json_result.apps_at_unit[i].staff_id}"  data-name="${json_result.apps_at_unit[i].staff}"  class="btn btn-secondary">View <i class="fa fa-eye"></i></a>`;
    // let payment_status = e[i].payment_status;
    // let buttons = e[i].buttons;
    

    html.push(staff);
    html.push(total);
    html.push(action);
  //   html.push(action);

    dataSet19.push(html);

  //console.log(dataSet)
  }

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

  $('#past_due_officers_table').DataTable().clear().destroy();
                
  $('#past_due_officers_table').DataTable({ data: dataSet19,
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








$(document).on('click','#apps_with_division_officers',function(e){
  e.preventDefault();
 
$("#apps_with_division_officers_modal").modal("show");  


const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${day} ${months[monthIndex]} ${year}`;


//     var regional_code = $('#director_regional_code').val();
//     // var division = $('#director_division').val();

  var staff_id=$(this).data('id');
  var staff_name=$(this).data('name');

  console.log(staff_id);


  var title  = staff_name+"'s"+" "+"Applications";


//   var title  = staff_name+" "+"Applications Past Due"+" "+year;


  document.getElementById('apps_with_division_officers_Label').innerHTML = title;

//   //  console.log(service_type);


 let dataSet20 = [];
 let num20 = 0;

$('#apps_with_division_officers_table').DataTable().clear().destroy();

 $.ajax({
     type : "POST",
     url : "focal_compliance",
     data : {
         request_type : 'compliance_focal_apps_with_division_staff_apps',
         staff_id : staff_id
     },
     cache: false,
     success: function(response) {

      //console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result)

         if (json_result.apps_with_staff == ""){

          //console.log("data not found");       

}else {

  for(let i=0; i<json_result.apps_with_staff.length; i++) {
    let html = [];
    num20 = +num20 + 1;

    let job_number = json_result.apps_with_staff[i].job_number;
    let ar_name = json_result.apps_with_staff[i].ar_name;
    let business_process_name = json_result.apps_with_staff[i].business_process_name;
    let created_date = json_result.apps_with_staff[i].created_date;
    let due_date = json_result.apps_with_staff[i].due_date;
    let days_due = json_result.apps_with_staff[i].days_due;
    let days_since_batched = json_result.apps_with_staff[i].days_since_batched;
    let job_purpose = json_result.apps_with_staff[i].job_purpose;
   let action = `<div class="btn-group" role="group">
   <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
     Actions
   </button>
   <div class="dropdown-menu">
   <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
     <input type="hidden" name="case_number" id="case_number" value="">
     <input type="hidden" name="search_text" id="search_text" value="">
     <input type="hidden" name="job_number" id="job_number" value="">
     <input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="">
     <button type="submit" name="save" class="dropdown-item" >View</button>
   </form>   
   <button type="button" class="dropdown-item" href="#" data-staff_name="${staff_name}" data-staff_id="${staff_id}" data-job_number="${job_number}" data-target="#sendMessageModal_FocalCompliance" data-toggle="modal" >Send Message</button>
   </div>
 </div>`;
    // let payment_status = e[i].payment_status;
    // let buttons = e[i].buttons;
    

    html.push(job_number);
    html.push(ar_name);
    html.push(business_process_name);
    html.push(created_date);
    html.push(due_date);
    html.push(days_due);
    html.push(days_since_batched);
    html.push(job_purpose);
    html.push(action);

    dataSet20.push(html);

  //console.log(dataSet)
  }

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

  $('#apps_with_division_officers_table').DataTable().clear().destroy();
                
  $('#apps_with_division_officers_table').DataTable({ data: dataSet20,
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


$('#sendMessageModal_FocalCompliance').on('show.bs.modal',function(event) {
  $("#sendMessageModal_FocalCompliance #officer_name").val($(event.relatedTarget).data('staff_name'));	
  $("#sendMessageModal_FocalCompliance #job_numbers").val('[{"job_number":"'+$(event.relatedTarget).data('job_number')+'"}]');
  $("#sendMessageModal_FocalCompliance #focal_officer_id").val($(event.relatedTarget).data('staff_id'));
   //$("#sendMessageModal #sendMessageModalLabel").val('Send Message To '+$(event.relatedTarget).data('receiver_name'));	
  document.getElementById('sendMessageModalLabel_FocalCompliance').innerHTML = 'Send Message To <span class="text-primary">'+$(event.relatedTarget).data('staff_name')+'</span>'
  // $("#sendMessageModal #e_lawyer_address").val($(event.relatedTarget).data('lawyer_address'));
  // $("#sendMessageModal #e_lawyer_chamber").val($(event.relatedTarget).data('lawyer_chamber'));
});





//   $('#send_message').click(function(e){
//     e.preventDefault();

//     $("#sendMessageModal").modal("show");  

   


//   });


$('#sendMessageModal').on('shown.bs.modal', function () {
  //$('#myInput').trigger('focus')
  //$("#eventDetails").modal({backdrop: true});
  $("#past_due_apps_modal").css("z-index", "1050");
  
})

$('#sendMessageModal').on('hidden.bs.modal', function () {
  //$('#myInput').trigger('focus')
  //$("#eventDetails").modal({backdrop: true});
  $("#past_due_apps_modal").css("z-index", "");
})



$('#sendMessageModal').on('shown.bs.modal', function () {
  //$('#myInput').trigger('focus')
  //$("#eventDetails").modal({backdrop: true});
  $("#apps_with_division_officers_modal").css("z-index", "1029");
})



 $('#sendMessageModal').on('hidden.bs.modal', function () {
  //$('#myInput').trigger('focus')
  //$("#eventDetails").modal({backdrop: true});
  $("#apps_with_division_officers_modal").css("z-index", "");
})


$('#sendMessageModal_FocalCompliance').on('shown.bs.modal', function () {
  //$('#myInput').trigger('focus')
  //$("#eventDetails").modal({backdrop: true});
  $("#past_due_apps_modal").modal("hide");
  
})

$('#sendMessageModal_FocalCompliance').on('hidden.bs.modal', function () {
  //$('#myInput').trigger('focus')
  //$("#eventDetails").modal({backdrop: true});
  $("#past_due_apps_modal").css("show");
})



$('#sendMessageModal_FocalCompliance').on('shown.bs.modal', function () {
  //$('#myInput').trigger('focus')
  //$("#eventDetails").modal({backdrop: true});
  $("#apps_with_division_officers_modal").modal("hide");
})



 $('#sendMessageModal_FocalCompliance').on('hidden.bs.modal', function () {
  //$('#myInput').trigger('focus')
  //$("#eventDetails").modal({backdrop: true});
  $("#apps_with_division_officers_modal").modal("show");
})




  
  });