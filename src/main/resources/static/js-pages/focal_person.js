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
              showDivisionSummaryUpdatedQ("#app-received-year", data.apps_rec_divisional, 'info');
          
              // applications completed for the year
              showDivisionSummaryUpdatedQ("#app-completed-year", data.apps_comp_divisional, 'success');
          
              // applications received and completed for the year
              showDivisionSummaryUpdatedQ(
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
          <div class="progress progress-sm mb-4">
            <div class="progress-bar bg-${color}" role="progressbar" style="width: ${percent}%" aria-valuenow="${percent}"
              aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
        <input type='hidden' value='${current.division}' id='currentDivision'> `;
  
        return (sum += html);
      }, "");
  
      contentBody.html(dataHtml);
    }



function showDivisionSummaryUpdatedQ(id, data, color) {
    // Define all 4 divisions
    const allDivisions = ['LRD', 'LVD', 'PVLMD', 'SMD'];
    
    // Find data for each division
    const divisionData = {};
    
    allDivisions.forEach(division => {
        const foundData = data.find(item => item.division === division);
        divisionData[division] = foundData || { division: division, total: 0 };
    });
    
    // Calculate total from actual data (not including zeros for empty divisions)
    let total = data.reduce(function (sum, current) {
        return sum + current.total;
    }, 0);
    
    // Update total count
    $(id).find(".count").html(new Intl.NumberFormat().format(total));
    
    let cardBody = $(id).find(".card-body");
    let period = cardBody.data("period");
    let method = cardBody.data("method");
    let title = cardBody.data("title");
    let url = cardBody.data("url");
    let nextLevelModal = cardBody.data("next-level-modal");
    let date = cardBody.data("date") ?? "";
    
    let periodToAdd = typeof period === "undefined" ? "" : `_${period}`;
    
    // Clear existing progress bars and list
    $(id).find(".progress-animate").empty();
    $(id).find(".top-referral-pages").empty();
    
    // Color classes for different segments
    const colorClasses = ['primary', 'info', 'warning', 'success'];
    
    // Generate progress bars and list items for all 4 divisions
    allDivisions.forEach(function (division, index) {
        const current = divisionData[division];
        let percent = total > 0 ? ((current.total / total) * 100).toFixed(2) : 0;
        const colorClass = colorClasses[index % colorClasses.length];
        
        // Add progress bar segment (show zero width as minimum 1% for visibility)
        let progressWidth = current.total > 0 ? percent : 1;
        let progressBar = `<div class="progress-bar bg-${colorClass}" 
            role="progressbar" 
            style="width: ${progressWidth}%" 
            aria-valuenow="${percent}" 
            aria-valuemin="0" 
            aria-valuemax="100"
            title="${current.division}: ${current.total} (${percent}%)"
            data-bs-toggle="tooltip"></div>`;
        
        $(id).find(".progress-animate").append(progressBar);
        
        // Add list item
        let listItem = `<li class="${colorClass}">
            <div class="d-flex align-items-center justify-content-between">
                <div>
                    <a href="#" 
                       data-method="${method}" 
                       data-url="${url}" 
                       ${typeof period === "undefined" ? "" : `data-period="${period}"`}
                       data-action="report_dashboard_${method}${periodToAdd}" 
                       data-type="${current.division}" 
                       data-date="${date}" 
                       data-title="${title}" 
                       class="${nextLevelModal} text-decoration-none ${current.total === 0 ? 'text-muted' : ''}">
                        ${current.division}
                    </a>
                </div>
                <div class="fs-12 ${current.total === 0 ? 'text-muted opacity-50' : 'text-muted'}">
                    ${current.total.toLocaleString()} ${total > 0 ? `(${percent}%)` : ''}
                </div>
            </div>
        </li>`;
        
        $(id).find(".top-referral-pages").append(listItem);
    });
    
    // Initialize tooltips
    $('[data-bs-toggle="tooltip"]').tooltip();
}

// Optional: Function to calculate and update trend indicator
function updateTrendIndicator(id, currentData) {
    // This is a placeholder - you'll need to implement actual trend calculation
    // based on previous period data
    let currentTotal = currentData.reduce((sum, item) => sum + item.total, 0);
    
    // Mock trend calculation - replace with actual comparison logic
    let trendPercentage = 1.02; // Example: 1.02 means 2% increase
    let trendIcon = trendPercentage >= 1 ? 'ri-arrow-up-s-fill' : 'ri-arrow-down-s-fill';
    let trendColor = trendPercentage >= 1 ? 'success' : 'danger';
    
    $(id).find(".bg-success-transparent").removeClass("bg-success-transparent").addClass("bg-" + trendColor + "-transparent");
    $(id).find(".ri-arrow-up-s-fill, .ri-arrow-down-s-fill").remove();
    
    let trendBadge = `<span class="badge bg-${trendColor}-transparent">${trendPercentage.toFixed(2)}
        <i class="${trendIcon} align-middle ms-1"></i>
    </span>`;
    
    $(id).find(".badge").replaceWith(trendBadge);
}

// Helper function to get color class based on index
function getColorClass(index) {
    const colors = ['primary', 'info', 'warning', 'success', 'danger', 'secondary', 'dark', 'purple'];
    return colors[index % colors.length];
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

        //document.getElementById('total_rec_comp_year').innerHTML = newtotal;
  
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
        //console.log(reccc);

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

    // Click handler for the button
$('#apps_received_today').on('click', function(e) {
    e.preventDefault();
    
    // Show modal using Bootstrap 5
    const userDivisionModal = new bootstrap.Modal(document.getElementById('user_divisionModal'));
    userDivisionModal.show();
    
    // Load data
    loadDivisionData();
});

// Function to load division data
function loadDivisionData() {
    const modal = $('#user_divisionModal');
    const loadingState = modal.find('#loadingState');
    const dataContent = modal.find('#dataContent');
    const errorState = modal.find('#errorState');
    
    // Show loading, hide other states
    loadingState.removeClass('d-none');
    dataContent.addClass('d-none');
    errorState.addClass('d-none');
    
    var regional_code = $('#director_regional_code').val();
    var division = $('#director_division').val();
    
    console.log('Loading data for:', regional_code, division);
    
    $.ajax({
        type: "POST",
        url: "focal_compliance",
        data: {
            request_type: 'compliance_focal_report_dashboard_created_today',
            region_id: regional_code.trim(),
            user_division: division
        },
        cache: false,
        success: function(response) {
            try {
                var json_result = JSON.parse(response);
                
                // Hide loading
                loadingState.addClass('d-none');
                dataContent.removeClass('d-none');
                
                // Update last updated time
                updateLastUpdatedTime();
                
                // Process and display data
                if (json_result.apps_at_division && json_result.apps_at_division.length > 0) {
                    displayDivisionData(json_result);
                } else {
                    showNoDataState();
                }
            } catch (e) {
                console.error('Error parsing response:', e);
                showErrorState();
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', error);
            showErrorState();
        }
    });
}

// Function to display division data
function displayDivisionData(data) {
    // Update main division card
    if (data.apps_at_division && data.apps_at_division[0]) {
        const divisionData = data.apps_at_division[0];
        const count = divisionData.total || 0;
        const current_division = divisionData.division || 'N/A';
        
        $('#user_division').text(current_division);
        $('#div_count').text(count.toLocaleString());
        
        // Update all divisions (if available)
        if (data.all_divisions) {
            displayAllDivisions(data.all_divisions);
        } else {
            // If no all_divisions data, show just the main division
            $('#allDivisionsGrid').html(`
                <div class="col-12">
                    <div class="alert alert-info">
                        <i class="ri-information-line me-2"></i>
                        Only your division data is available.
                    </div>
                </div>
            `);
        }
    }
}

// Function to display all divisions
function displayAllDivisions(divisionsData) {
    const divisionsGrid = $('#allDivisionsGrid');
    divisionsGrid.empty();
    
    // Division configuration with colors and icons
    const divisionConfig = {
        'LRD': { name: 'Land Resources', color: 'primary', icon: 'ri-landscape-line' },
        'LVD': { name: 'Livestock', color: 'success', icon: 'ri-road-map-line' },
        'PVLMD': { name: 'Public & Veterinary', color: 'warning', icon: 'ri-home-5-line' },
        'SMD': { name: 'Support Services', color: 'danger', icon: 'ri-building-line' }
    };
    
    // Calculate total for percentages
    const total = divisionsData.reduce((sum, div) => sum + (div.total || 0), 0);
    
    // Create cards for each division
    divisionsData.forEach(division => {
        const config = divisionConfig[division.division] || { 
            name: division.division, 
            color: 'secondary', 
            icon: 'ri-question-line' 
        };
        
        const count = division.total || 0;
        const percentage = total > 0 ? Math.round((count / total) * 100) : 0;
        
        const cardHtml = `
            <div class="col-xl-3 col-lg-6 col-md-6">
                <div class="card border-0 shadow-sm h-100 transition-all">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <div class="bg-${config.color} bg-opacity-10 rounded-circle p-2 me-3">
                                <i class="${config.icon} text-${config.color} fs-4"></i>
                            </div>
                            <div>
                                <h6 class="mb-0 fw-bold">${division.division}</h6>
                                <small class="text-muted">${config.name}</small>
                            </div>
                        </div>
                        <div class="mb-3">
                            <h2 class="display-6 fw-bold mb-1">${count.toLocaleString()}</h2>
                            <div class="text-muted small">Applications</div>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="text-muted small">${percentage}% of total</div>
                            <div class="badge bg-${config.color} rounded-pill px-3">${division.division}</div>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        divisionsGrid.append(cardHtml);
    });
}

// Function to show error state
function showErrorState() {
    const modal = $('#user_divisionModal');
    modal.find('#loadingState').addClass('d-none');
    modal.find('#dataContent').addClass('d-none');
    modal.find('#errorState').removeClass('d-none');
}

// Function to show no data state
function showNoDataState() {
    const modal = $('#user_divisionModal');
    modal.find('#loadingState').addClass('d-none');
    modal.find('#dataContent').addClass('d-none');
    
    // Show empty state within data content
    modal.find('#allDivisionsGrid').html(`
        <div class="col-12">
            <div class="text-center py-5">
                <div class="mb-4">
                    <i class="ri-folder-open-line display-1 text-muted opacity-25"></i>
                </div>
                <h5 class="text-muted mb-3">No Data Available</h5>
                <p class="text-muted mb-0">No applications received today.</p>
            </div>
        </div>
    `);
    modal.find('#dataContent').removeClass('d-none');
}

// Function to update last updated time
function updateLastUpdatedTime() {
    const now = new Date();
    const timeString = now.toLocaleTimeString([], { 
        hour: '2-digit', 
        minute: '2-digit',
        second: '2-digit' 
    });
    $('#lastUpdated').text(timeString);
}

// Event listeners for modal buttons
$(document).ready(function() {
    // Refresh button
    $('#refreshButton').on('click', function() {
        loadDivisionData();
    });
    
    // Retry button
    $('#retryButton').on('click', function() {
        loadDivisionData();
    });
    
    // Modal show event
    $('#user_divisionModal').on('show.bs.modal', function() {
        updateLastUpdatedTime();
    });
    
    // Modal hidden event
    $('#user_divisionModal').on('hidden.bs.modal', function() {
        // Reset modal state if needed
        const modal = $(this);
        modal.find('#loadingState').removeClass('d-none');
        modal.find('#dataContent').addClass('d-none');
        modal.find('#errorState').addClass('d-none');
    });
});



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
    
    // Show modal using Bootstrap 5
    const userDivisionMonthModal = new bootstrap.Modal(document.getElementById('user_divisionModal_this_month'));
    userDivisionMonthModal.show();
    
    // Load data
    loadMonthlyDivisionData();
});

// Function to load monthly division data
function loadMonthlyDivisionData() {
    const modal = $('#user_divisionModal_this_month');
    const loadingState = modal.find('#loadingStateMonth');
    const dataContent = modal.find('#dataContentMonth');
    const errorState = modal.find('#errorStateMonth');
    
    // Show loading, hide other states
    loadingState.removeClass('d-none');
    dataContent.addClass('d-none');
    errorState.addClass('d-none');
    
    var regional_code = $('#director_regional_code').val();
    var division = $('#director_division').val();
    
    console.log('Loading monthly data for:', regional_code, division);
    
    $.ajax({
        type: "POST",
        url: "focal_compliance",
        data: {
            request_type: 'compliance_focal_report_dashboard_created_this_month',
            region_id: regional_code.trim(),
            user_division: division
        },
        cache: false,
        success: function(response) {
            try {
                var json_result = JSON.parse(response);
                
                // Hide loading
                loadingState.addClass('d-none');
                dataContent.removeClass('d-none');
                
                // Process and display data
                if (json_result.apps_at_division && json_result.apps_at_division.length > 0) {
                    displayMonthlyDivisionData(json_result);
                } else {
                    showNoMonthlyDataState();
                }
            } catch (e) {
                console.error('Error parsing monthly response:', e);
                showMonthlyErrorState();
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error (monthly):', error);
            showMonthlyErrorState();
        }
    });
}

// Function to display monthly division data
function displayMonthlyDivisionData(data) {
    // Update main division card
    if (data.apps_at_division && data.apps_at_division[0]) {
        const divisionData = data.apps_at_division[0];
        const count = divisionData.total || 0;
        const current_division = divisionData.division || 'N/A';
        
        $('#user_division_month').text(current_division);
        $('#div_count_month').text(count.toLocaleString());
        
        // Calculate and display additional stats
        calculateMonthlyStats(count, data);
        
        // Update all divisions (if available)
        if (data.all_divisions) {
            displayAllMonthlyDivisions(data.all_divisions);
        }
    }
}

// Add event listeners for the monthly modal
$(document).ready(function() {
    // Refresh button for monthly modal
    $('#refreshButtonMonth').on('click', function() {
        loadMonthlyDivisionData();
    });
    
    // Retry button for monthly modal
    $('#retryButtonMonth').on('click', function() {
        loadMonthlyDivisionData();
    });
});





    $('#user_division_this_month').on('click', function(e) {
      e.preventDefault();

   $("#serviceTypeModal").modal("show");  
  const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${months[monthIndex]}`;


      var regional_code = $('#director_regional_code').val();
      var division = $('#director_division').val();

      var title  = division+"'"+'s'+" "+"Applications Received This Month"+" "+"("+formattedDate+")";

      document.getElementById('serviceTypeModalLabel').innerHTML = title;

      
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

    $('#serviceTypeTable').DataTable().clear().destroy();

      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num2 = +num2 + 1;

          let name = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}"  id="view_recieved_month_by_service"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          html.push(name);
          html.push(total);
          html.push(action);

          dataSet2.push(html);

        ///console.log(dataSet1)
        }

      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })

        $('#serviceTypeTable').DataTable().clear().destroy();
                      
        $('#serviceTypeTable').DataTable({ data: dataSet2,
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
    
    // Show modal using Bootstrap 5
    const completedDivisionModal = new bootstrap.Modal(document.getElementById('user_completed_divison_today'));
    completedDivisionModal.show();
    
    // Load data
    loadCompletedTodayData();
});

// Function to load completed today data
function loadCompletedTodayData() {
    const modal = $('#user_completed_divison_today');
    const loadingState = modal.find('#loadingStateCompletedToday');
    const dataContent = modal.find('#dataContentCompletedToday');
    const errorState = modal.find('#errorStateCompletedToday');
    
    // Show loading, hide other states
    loadingState.removeClass('d-none');
    dataContent.addClass('d-none');
    errorState.addClass('d-none');
    
    var regional_code = $('#director_regional_code').val();
    var division = $('#director_division').val();
    
    console.log('Loading completed today data for:', regional_code, division);
    
    $.ajax({
        type: "POST",
        url: "director_dashboard",
        data: {
            request_type: 'director_report_dashboard_completed_today',
            region_id: regional_code.trim(),
            user_division: division
        },
        cache: false,
        success: function(response) {
            try {
                var json_result = JSON.parse(response);
                console.log('Completed today data:', json_result);
                
                // Hide loading
                loadingState.addClass('d-none');
                dataContent.removeClass('d-none');
                
                // Process and display data
                if (json_result.apps_at_division && json_result.apps_at_division.length > 0) {
                    displayCompletedTodayData(json_result);
                } else {
                    showNoCompletedDataState();
                }
            } catch (e) {
                console.error('Error parsing completed today response:', e);
                showCompletedErrorState();
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error (completed today):', error);
            showCompletedErrorState();
        }
    });
}

// Function to display completed today data
function displayCompletedTodayData(data) {
    // Update main division card
    if (data.apps_at_division && data.apps_at_division[0]) {
        const divisionData = data.apps_at_division[0];
        const count = divisionData.total || 0;
        const current_division = divisionData.division || 'N/A';
        
        $('#user_division_completed_today').text(current_division);
        $('#div_count_completed_today').text(count.toLocaleString());
        
        // Calculate completion rate if received data is available
        if (data.received_today && data.received_today > 0) {
            const completionRate = Math.round((count / data.received_today) * 100);
            $('#completionProgress').css('width', completionRate + '%');
            $('#completionPercentage').text(completionRate + '%');
        } else {
            $('#completionRateSection').addClass('d-none');
        }
        
        // Update performance stats if available
        updatePerformanceStats(data);
        
        // Update all divisions completed
        if (data.all_divisions_completed) {
            displayAllDivisionsCompleted(data.all_divisions_completed);
        }
        
        // Update service type breakdown
        if (data.service_types) {
            displayServiceTypeBreakdown(data.service_types);
        }
    }
}

// Function to display all divisions completed
function displayAllDivisionsCompleted(divisionsData) {
    const grid = $('#allDivisionsCompletedGrid');
    grid.empty();
    
    const divisionConfig = {
        'LRD': { name: 'Land Resources', color: 'primary', icon: 'ri-landscape-line' },
        'LVD': { name: 'Livestock', color: 'success', icon: 'ri-road-map-line' },
        'PVLMD': { name: 'Public & Veterinary', color: 'warning', icon: 'ri-home-5-line' },
        'SMD': { name: 'Support Services', color: 'danger', icon: 'ri-building-line' }
    };
    
    // Calculate total for percentages
    const total = divisionsData.reduce((sum, div) => sum + (div.total || 0), 0);
    
    divisionsData.forEach(division => {
        const config = divisionConfig[division.division] || { 
            name: division.division, 
            color: 'secondary', 
            icon: 'ri-question-line' 
        };
        
        const count = division.total || 0;
        const percentage = total > 0 ? Math.round((count / total) * 100) : 0;
        
        const cardHtml = `
            <div class="col-xl-3 col-lg-6 col-md-6">
                <div class="card border-0 shadow-sm h-100 transition-all">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <div class="bg-${config.color} bg-opacity-10 rounded-circle p-2 me-3">
                                <i class="${config.icon} text-${config.color} fs-4"></i>
                            </div>
                            <div>
                                <h6 class="mb-0 fw-bold">${division.division}</h6>
                                <small class="text-muted">${config.name}</small>
                            </div>
                        </div>
                        <div class="mb-3">
                            <h2 class="display-6 fw-bold mb-1">${count.toLocaleString()}</h2>
                            <div class="text-muted small">Completed</div>
                        </div>
                        <div class="progress" style="height: 6px;">
                            <div class="progress-bar bg-${config.color}" 
                                 role="progressbar" 
                                 style="width: ${percentage}%"
                                 aria-valuenow="${percentage}" 
                                 aria-valuemin="0" 
                                 aria-valuemax="100"></div>
                        </div>
                        <div class="d-flex justify-content-between mt-2">
                            <span class="text-muted small">${percentage}% of total</span>
                            <span class="badge bg-${config.color}">${division.division}</span>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        grid.append(cardHtml);
    });
}

// Function to display service type breakdown
function displayServiceTypeBreakdown(serviceTypes) {
    const table = $('#serviceTypeCompletedTable');
    table.empty();
    
    serviceTypes.forEach(service => {
        const statusClass = service.avg_days <= 5 ? 'success' : 
                           service.avg_days <= 10 ? 'warning' : 'danger';
        const statusText = service.avg_days <= 5 ? 'Fast' : 
                          service.avg_days <= 10 ? 'Moderate' : 'Slow';
        
        const rowHtml = `
            <tr>
                <td class="fw-medium">${service.service_type}</td>
                <td class="text-center">
                    <span class="badge bg-success rounded-pill px-3">${service.total}</span>
                </td>
                <td class="text-center fw-bold">${service.avg_days || '--'} days</td>
                <td class="text-center">
                    <span class="badge bg-${statusClass}">${statusText}</span>
                </td>
            </tr>
        `;
        
        table.append(rowHtml);
    });
}

// Function to update performance stats
function updatePerformanceStats(data) {
    if (data.avg_processing_time) {
        $('#avgProcessingTime').text(data.avg_processing_time + ' days');
    }
    if (data.fastest_completion) {
        $('#fastestCompletion').text(data.fastest_completion + ' days');
    }
    if (data.on_time_rate) {
        $('#onTimeRate').text(data.on_time_rate + '%');
    }
}

// Add event listeners for the completed today modal
$(document).ready(function() {
    // Refresh button
    $('#refreshButtonCompletedToday').on('click', function() {
        loadCompletedTodayData();
    });
    
    // Retry button
    $('#retryButtonCompletedToday').on('click', function() {
        loadCompletedTodayData();
    });
});






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
    
    // Show modal using Bootstrap 5
    const completedMonthModal = new bootstrap.Modal(document.getElementById('user_completed_divison_month'));
    completedMonthModal.show();
    
    // Load data
    loadCompletedMonthData();
});

// Function to load completed month data
function loadCompletedMonthData() {
    const modal = $('#user_completed_divison_month');
    const loadingState = modal.find('#loadingStateCompletedMonth');
    const dataContent = modal.find('#dataContentCompletedMonth');
    const errorState = modal.find('#errorStateCompletedMonth');
    
    // Show loading, hide other states
    loadingState.removeClass('d-none');
    dataContent.addClass('d-none');
    errorState.addClass('d-none');
    
    var regional_code = $('#director_regional_code').val();
    var division = $('#director_division').val();
    
    console.log('Loading completed month data for:', regional_code, division);
    
    $.ajax({
        type: "POST",
        url: "focal_compliance",
        data: {
            request_type: 'compliance_focal_report_dashboard_completed_month',
            region_id: regional_code.trim(),
            user_division: division
        },
        cache: false,
        success: function(response) {
            try {
                var json_result = JSON.parse(response);
                console.log('Completed month data:', json_result);
                
                // Hide loading
                loadingState.addClass('d-none');
                dataContent.removeClass('d-none');
                
                // Process and display data
                if (json_result.apps_at_division && json_result.apps_at_division.length > 0) {
                    displayCompletedMonthData(json_result);
                } else {
                    showNoCompletedMonthDataState();
                }
            } catch (e) {
                console.error('Error parsing completed month response:', e);
                showCompletedMonthErrorState();
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error (completed month):', error);
            showCompletedMonthErrorState();
        }
    });
}

// Function to display completed month data
function displayCompletedMonthData(data) {
    // Update main division card
    if (data.apps_at_division && data.apps_at_division[0]) {
        const divisionData = data.apps_at_division[0];
        const count = divisionData.total || 0;
        const current_division = divisionData.division || 'N/A';
        
        $('#user_division_completed_month').text(current_division);
        $('#div_count_completed_month').text(count.toLocaleString());
        
        // Update monthly stats in footer
        $('#totalMonthlyCompleted').text(count.toLocaleString());
        
        // Update monthly performance stats
        updateMonthlyPerformanceStats(data, count);
        
        // Update monthly chart if data available
        if (data.monthly_trend) {
            updateMonthlyChart(data.monthly_trend);
        }
        
        // Update all divisions monthly completion
        if (data.all_divisions_monthly) {
            updateMonthlyDivisionsTable(data.all_divisions_monthly);
        }
        
        // Update weekly breakdown
        if (data.weekly_breakdown) {
            updateWeeklyBreakdown(data.weekly_breakdown);
        }
    }
}

// Function to update monthly performance stats
function updateMonthlyPerformanceStats(data, currentCount) {
    // Monthly trend
    if (data.previous_month && data.previous_month > 0) {
        const trend = Math.round(((currentCount - data.previous_month) / data.previous_month) * 100);
        const trendIcon = trend >= 0 ? 'ri-arrow-up-line text-success' : 'ri-arrow-down-line text-danger';
        const trendClass = trend >= 0 ? 'text-success' : 'text-danger';
        
        $('#monthlyCompletionTrend').html(`
            ${Math.abs(trend)}%
            <i class="${trendIcon}"></i>
        `).removeClass('text-success text-danger').addClass(trendClass);
    }
    
    // Daily average
    if (data.working_days && data.working_days > 0) {
        const dailyAvg = Math.round(currentCount / data.working_days);
        $('#monthlyDailyAverage').text(dailyAvg);
    }
    
    // Completion rate
    if (data.received_month && data.received_month > 0) {
        const completionRate = Math.round((currentCount / data.received_month) * 100);
        $('#monthlyCompletionRate').text(completionRate + '%');
        
        // Update progress bar
        if (data.monthly_target) {
            const targetPercentage = Math.min(Math.round((currentCount / data.monthly_target) * 100), 100);
            $('#monthlyCompletionProgress').css('width', targetPercentage + '%');
            $('#monthlyCompletionPercentage').text(targetPercentage + '%');
        }
    }
    
    // Average time
    if (data.avg_completion_time) {
        $('#monthlyAvgTime').text(data.avg_completion_time + ' days');
    }
}

// Function to update monthly chart
function updateMonthlyChart(trendData) {
    const ctx = document.getElementById('monthlyCompletionChart').getContext('2d');
    
    // Destroy existing chart if exists
    if (window.monthlyCompletionChart) {
        window.monthlyCompletionChart.destroy();
    }
    
    // Create new chart
    window.monthlyCompletionChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: trendData.labels || ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
            datasets: [{
                label: 'Completed Applications',
                data: trendData.data || [0, 0, 0, 0],
                borderColor: '#28a745',
                backgroundColor: 'rgba(40, 167, 69, 0.1)',
                borderWidth: 2,
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return `Completed: ${context.raw}`;
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        drawBorder: false
                    },
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString();
                        }
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            }
        }
    });
}

// Function to update monthly divisions table
function updateMonthlyDivisionsTable(divisionsData) {
    const table = $('#monthlyDivisionsTable');
    table.empty();
    
    const divisionConfig = {
        'LRD': { name: 'Land Resources', color: 'primary' },
        'LVD': { name: 'Livestock', color: 'success' },
        'PVLMD': { name: 'Public & Veterinary', color: 'warning' },
        'SMD': { name: 'Support Services', color: 'danger' }
    };
    
    divisionsData.forEach(division => {
        const config = divisionConfig[division.division] || { name: division.division, color: 'secondary' };
        const achievement = division.target > 0 ? Math.round((division.total / division.target) * 100) : 0;
        const trend = division.previous_month > 0 ? 
            Math.round(((division.total - division.previous_month) / division.previous_month) * 100) : 0;
        
        const statusClass = achievement >= 100 ? 'success' : 
                           achievement >= 80 ? 'warning' : 'danger';
        const statusText = achievement >= 100 ? 'On Target' : 
                          achievement >= 80 ? 'Near Target' : 'Below Target';
        
        const trendIcon = trend >= 0 ? 
            `<i class="ri-arrow-up-line text-success"></i> ${Math.abs(trend)}%` : 
            `<i class="ri-arrow-down-line text-danger"></i> ${Math.abs(trend)}%`;
        const trendClass = trend >= 0 ? 'text-success' : 'text-danger';
        
        const rowHtml = `
            <tr>
                <td class="fw-medium">
                    <i class="ri-building-2-line text-${config.color} me-2"></i>
                    ${division.division}
                    <small class="text-muted d-block">${config.name}</small>
                </td>
                <td class="text-center">
                    <span class="badge bg-${config.color} rounded-pill px-3">${division.total.toLocaleString()}</span>
                </td>
                <td class="text-center fw-medium">${division.target.toLocaleString()}</td>
                <td class="text-center">
                    <div class="d-flex align-items-center justify-content-center">
                        <div class="progress flex-grow-1 me-2" style="height: 6px; max-width: 80px;">
                            <div class="progress-bar bg-${config.color}" 
                                 style="width: ${Math.min(achievement, 100)}%"></div>
                        </div>
                        <span class="fw-bold">${achievement}%</span>
                    </div>
                </td>
                <td class="text-center ${trendClass} fw-medium">
                    ${trendIcon}
                </td>
                <td class="text-center">
                    <span class="badge bg-${statusClass}">${statusText}</span>
                </td>
            </tr>
        `;
        
        table.append(rowHtml);
    });
}

// Function to update weekly breakdown
function updateWeeklyBreakdown(weeklyData) {
    const grid = $('#weeklyBreakdownGrid');
    grid.empty();
    
    const weekColors = ['primary', 'success', 'warning', 'danger'];
    let total = 0;
    
    weeklyData.forEach((week, index) => {
        total += week.total || 0;
        const color = weekColors[index % weekColors.length];
        const percentage = weeklyData.reduce((sum, w) => sum + (w.total || 0), 0) > 0 ? 
            Math.round((week.total / weeklyData.reduce((sum, w) => sum + (w.total || 0), 0)) * 100) : 0;
        
        const cardHtml = `
            <div class="col-xl-3 col-lg-6 col-md-6">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <div class="bg-${color} bg-opacity-10 rounded-circle p-2 me-3">
                                <i class="ri-calendar-line text-${color} fs-4"></i>
                            </div>
                            <div>
                                <h6 class="mb-0 fw-bold">${week.week || 'Week ' + (index + 1)}</h6>
                                <small class="text-muted">${week.date_range || ''}</small>
                            </div>
                        </div>
                        <div class="mb-3">
                            <h2 class="display-6 fw-bold mb-1">${week.total.toLocaleString()}</h2>
                            <div class="text-muted small">Completed</div>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="text-muted small">${percentage}% of month</div>
                            <div class="badge bg-${color}">Week ${index + 1}</div>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        grid.append(cardHtml);
    });
}

// Add event listeners for the completed month modal
$(document).ready(function() {
    // Refresh button
    $('#refreshButtonCompletedMonth').on('click', function() {
        loadCompletedMonthData();
    });
    
    // Retry button
    $('#retryButtonCompletedMonth').on('click', function() {
        loadCompletedMonthData();
    });
    
    // Export button
    $('#exportMonthlyData').on('click', function() {
        exportMonthlyData();
    });
    
    // Chart type buttons
    $('[data-chart-type]').on('click', function() {
        $('[data-chart-type]').removeClass('active');
        $(this).addClass('active');
        const chartType = $(this).data('chart-type');
        if (window.monthlyCompletionChart) {
            window.monthlyCompletionChart.config.type = chartType;
            window.monthlyCompletionChart.update();
        }
    });
});

// Function to export monthly data
function exportMonthlyData() {
    // Implement export functionality here
    alert('Export monthly data functionality would be implemented here');
}



// Function to calculate monthly statistics
function calculateMonthlyStats(count, data) {
    // Update monthly trend
    if (data.previous_month_count) {
        const previousCount = data.previous_month_count || 0;
        const trend = previousCount > 0 ? 
            Math.round(((count - previousCount) / previousCount) * 100) : 
            (count > 0 ? 100 : 0);
        
        const trendIcon = trend >= 0 ? 'ri-arrow-up-line' : 'ri-arrow-down-line';
        const trendColor = trend >= 0 ? 'success' : 'danger';
        
        $('#monthlyTrend').html(`
            ${Math.abs(trend)}%
            <i class="${trendIcon}"></i>
        `).removeClass('text-success text-danger').addClass('text-' + trendColor);
    }
    
    // Calculate daily average (assuming 30 days in month for simplicity)
    // In real implementation, you'd calculate based on actual working days
    const daysInMonth = new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0).getDate();
    const daysPassed = Math.min(new Date().getDate(), daysInMonth);
    const dailyAverage = daysPassed > 0 ? (count / daysPassed).toFixed(1) : 0;
    
    $('#dailyAverage').text(dailyAverage);
    
    // Update last updated time
    const now = new Date();
    const timeString = now.toLocaleTimeString([], { 
        hour: '2-digit', 
        minute: '2-digit',
        second: '2-digit' 
    });
    $('#lastUpdatedMonth').text(timeString);
}

// Function to display all monthly divisions
function displayAllMonthlyDivisions(divisionsData) {
    const grid = $('#allDivisionsGridMonth');
    grid.empty();
    
    const divisionConfig = {
        'LRD': { name: 'Land Resources', color: 'primary', icon: 'ri-landscape-line' },
        'LVD': { name: 'Livestock', color: 'success', icon: 'ri-road-map-line' },
        'PVLMD': { name: 'Public & Veterinary', color: 'warning', icon: 'ri-home-5-line' },
        'SMD': { name: 'Support Services', color: 'danger', icon: 'ri-building-line' }
    };
    
    // Calculate total for percentages
    const total = divisionsData.reduce((sum, div) => sum + (div.total || 0), 0);
    
    divisionsData.forEach(division => {
        const config = divisionConfig[division.division] || { 
            name: division.division, 
            color: 'secondary', 
            icon: 'ri-question-line' 
        };
        
        const count = division.total || 0;
        const percentage = total > 0 ? Math.round((count / total) * 100) : 0;
        
        const cardHtml = `
            <div class="col-xl-3 col-lg-6 col-md-6">
                <div class="card border-0 shadow-sm h-100 transition-all">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <div class="bg-${config.color} bg-opacity-10 rounded-circle p-2 me-3">
                                <i class="${config.icon} text-${config.color} fs-4"></i>
                            </div>
                            <div>
                                <h6 class="mb-0 fw-bold">${division.division}</h6>
                                <small class="text-muted">${config.name}</small>
                            </div>
                        </div>
                        <div class="mb-3">
                            <h2 class="display-6 fw-bold mb-1">${count.toLocaleString()}</h2>
                            <div class="text-muted small">Applications</div>
                        </div>
                        <div class="progress" style="height: 6px;">
                            <div class="progress-bar bg-${config.color}" 
                                 role="progressbar" 
                                 style="width: ${percentage}%"
                                 aria-valuenow="${percentage}" 
                                 aria-valuemin="0" 
                                 aria-valuemax="100"></div>
                        </div>
                        <div class="d-flex justify-content-between mt-2">
                            <span class="text-muted small">${percentage}% of total</span>
                            <span class="badge bg-${config.color}">${division.division}</span>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        grid.append(cardHtml);
    });
}

// Function to show monthly error state
function showMonthlyErrorState() {
    const modal = $('#user_divisionModal_this_month');
    modal.find('#loadingStateMonth').addClass('d-none');
    modal.find('#dataContentMonth').addClass('d-none');
    modal.find('#errorStateMonth').removeClass('d-none');
}

// Function to show no monthly data state
function showNoMonthlyDataState() {
    const modal = $('#user_divisionModal_this_month');
    modal.find('#loadingStateMonth').addClass('d-none');
    modal.find('#dataContentMonth').addClass('d-none');
    
    // Show empty state
    modal.find('#allDivisionsGridMonth').html(`
        <div class="col-12">
            <div class="text-center py-5">
                <div class="mb-4">
                    <i class="ri-folder-open-line display-1 text-muted opacity-25"></i>
                </div>
                <h5 class="text-muted mb-3">No Data Available</h5>
                <p class="text-muted mb-0">No applications received this month.</p>
            </div>
        </div>
    `);
    modal.find('#dataContentMonth').removeClass('d-none');
}

// Function to show completed month error state
function showCompletedMonthErrorState() {
    const modal = $('#user_completed_divison_month');
    modal.find('#loadingStateCompletedMonth').addClass('d-none');
    modal.find('#dataContentCompletedMonth').addClass('d-none');
    modal.find('#errorStateCompletedMonth').removeClass('d-none');
}

// Function to show no completed month data state
function showNoCompletedMonthDataState() {
    const modal = $('#user_completed_divison_month');
    modal.find('#loadingStateCompletedMonth').addClass('d-none');
    modal.find('#dataContentCompletedMonth').removeClass('d-none');
    
    // Show empty state within the table
    modal.find('#monthlyDivisionsTable').html(`
        <tr>
            <td colspan="6" class="text-center py-5">
                <div class="mb-3">
                    <i class="ri-folder-open-line display-1 text-muted opacity-25"></i>
                </div>
                <h5 class="text-muted mb-3">No Data Available</h5>
                <p class="text-muted mb-0">No applications completed this month.</p>
            </td>
        </tr>
    `);
}


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