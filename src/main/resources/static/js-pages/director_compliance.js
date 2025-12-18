$(function () {


let startDate;
let endDate;
let newdatestart;
let newdateend;
let lastServiceType = null;





// Handle select all checkbox
// "Select All" checkbox logic
// Handle select all checkbox
$(document).on('change', '#select-all', function() {
  const isChecked = $(this).is(':checked');
  $('.app-checkbox').prop('checked', isChecked);
});

// Handle individual checkbox changes (optional)
$(document).on('change', '.app-checkbox', function() {
  if (!$(this).is(':checked')) {
    $('#select-all').prop('checked', false);
  } else if ($('.app-checkbox:checked').length === $('.app-checkbox').length) {
    $('#select-all').prop('checked', true);
  }
});


    // Get current date info
const today = new Date();
const yearStart = new Date(today.getFullYear(), 0, 1); // Jan 1 current year

// --- Date From ---
  const dateFromPicker =   flatpickr("#datefrom", {
        dateFormat: "Y-m-d", // Internal value format (YYYY-MM-DD)
        altInput: true, // Enables an alternative input field for display
        altFormat: "j F Y", // Display format (e.g., "1 February 2025")
        allowInput: true, // Allows manual input
        onChange: function(selectedDates, dateStr, instance) {
            let formattedDate = instance.formatDate(selectedDates[0], "j F Y"); // Format in "1 February 2025"
            
            console.log("Selected date (YYYY-MM-DD):", dateStr); 
            console.log("Selected date (j F Y):", formattedDate); 
    
            $('#start_date').val(dateStr);

            $('#startdate').val(formattedDate);

            // 🔹 Set minDate of "Date To" dynamically
        dateToPicker.set('minDate', dateStr);

        }
    });


// --- Date To ---
const dateToPicker = flatpickr("#dateto", {
  dateFormat: "Y-m-d",
  altInput: true,
  altFormat: "j F Y",
  allowInput: true,
  defaultDate: today, // prefill to today
  onChange: async function (selectedDates, dateStr, instance) {
    if (!$('#datefrom').val()) {
      alert("Please select 'Date From' before selecting 'Date To'.");
      $('#dateto').val('');
      return;
    }

    let dateFromVal = $('#datefrom').val();
    if (new Date(dateStr) < new Date(dateFromVal)) {
      alert("End date cannot be earlier than start date.");
      $('#dateto').val('');
      return;
    }

    let formattedDate = instance.formatDate(selectedDates[0], "j F Y");
    $('#end_date').val(dateStr);
    $('#enddate').val(formattedDate);

    // Load dashboard data whenever 'to' date changes
    loadDashboardData();
  }
});

// --- Prefill hidden fields for first load ---
$('#start_date').val(flatpickr.formatDate(yearStart, "Y-m-d"));
$('#end_date').val(flatpickr.formatDate(today, "Y-m-d"));
$('#startdate').val(flatpickr.formatDate(yearStart, "j F Y"));
$('#enddate').val(flatpickr.formatDate(today, "j F Y"));

// --- Auto-load on page ready ---
$(document).ready(function () {
  if ($("#page_name").text() === "director_compliance") {
    setTimeout(function () {
      loadDashboardData();
    }, 2000); // 2000ms = 2 seconds
  }
});







 





     function loadDashboardData() {

     startDate = $('#start_date').val();
     endDate = $('#end_date').val();


     function updateDisplayedDateRange() {
  const start = $('#startdate').val();
  const end = $('#enddate').val();
  $('#displayDateRange').text(`${start} - ${end}`);
    $('#displayDateRange1').text(`${start} - ${end}`);
      $('#displayDateRange2').text(`${start} - ${end}`);
        $('#displayDateRange3').text(`${start} - ${end}`);
          $('#displayDateRange4').text(`${start} - ${end}`);
           $('#displayDateRange5').text(`${start} - ${end}`);

}


            

// Run once after prefill
updateDisplayedDateRange();

// Update automatically when date changes
$('#datefrom, #dateto').on('change', function() {
  updateDisplayedDateRange();
});




    let region_id = $('#sel_change_region_compliance').val();
    if (region_id != undefined) {
        region_id = region_id.replace(".0", "");
    }

    var user_division = $('#director_division').val();

    console.log(startDate,endDate,user_division)
    $.ajax({
        type: "POST",
        url: "director_dashboard",
        data: {
            request_type: 'director_report_dashboard_all',
            division: user_division,
            date_from: startDate,  // Add start_date parameter
            date_to: endDate       // Add end_date parameter
        },
        cache: false,
        success: function(response) {
            var reccc = JSON.parse(response);
            console.log(reccc);

            firmList = reccc;
            
            let totalRec = reccc.total_apps_rec[0].total;
            let totalRecComp = reccc.total_comp_divisional_year[0].total;
            let totalpercentage = ((totalRecComp / totalRec) * 100).toFixed(2) + '%';

            $("#app-received-today").html(
                new Intl.NumberFormat().format(reccc.apps_rec_day[0].total)
            );
            $("#app-received-month").html(
                new Intl.NumberFormat().format(reccc.apps_rec_month[0].total)
            );
            $("#app-completed-today").html(
                new Intl.NumberFormat().format(reccc.apps_comp_day[0].total)
            );
            $("#app-completed-month").html(
                new Intl.NumberFormat().format(reccc.apps_comp_month[0].total)
            );

            // applications received for the year
            showDivisionSummary("#app-received-year", reccc.apps_rec_divisional, 'info');

            // applications completed for the year
            showDivisionSummary("#app-completed-year", reccc.apps_comp_divisional, 'success');

            // applications received and completed for the year
            showDivisionSummary(
                "#app-received-completed-year",
                reccc.apps_comp_divisional_year,
                'default'
            );

            // applications past due for the year
            showDivisionSummary(
                "#app-past-due-year",
                reccc.apps_past_due_dates_divisional,
                'danger'
            );

            // applications with divisions
            showDivisionSummary("#app-with-divisions", reccc.apps_at_division, 'warning');

            document.getElementById('pec_id').innerHTML = totalpercentage;


            const regionalPerformance = reccc.regional_performance;
//             const regionalPerformance = [
//   {"region_name":"Greater Accra - Accra Office","completion_rate":92.9,"avg_processing_days":17.8,"total_received":9471},
//   {"region_name":"Bono East - Techiman Office","completion_rate":88.0,"avg_processing_days":126.5,"total_received":25},
//   {"region_name":"Greater Accra -Tema Office","completion_rate":84.6,"avg_processing_days":37.7,"total_received":39},
//   {"region_name":"Western North Region - Sefwi-Wiawso Office","completion_rate":51.1,"avg_processing_days":182.4,"total_received":45},
//   {"region_name":"Ahafo - Goaso Office","completion_rate":32.3,"avg_processing_days":0.0,"total_received":31}
// ];

// Initialize ECharts
const chart = echarts.init(document.getElementById("regionComparisonChart"));

function renderRegionChart(metric) {
  let xLabels = regionalPerformance.map(r => r.region_name);
  let yValues = regionalPerformance.map(r => r[metric]);
  
  // Customize axis titles
  let metricLabel = metric === "completion_rate" ? "Completion Rate (%)" :
                    metric === "avg_processing_days" ? "Avg Processing Days" :
                    "Applications Received";

  // Dynamic color logic
  const getBarColor = (value) => {
    if (metric === "completion_rate") {
      if (value < 60) return "#e74c3c"; // red
      if (value < 80) return "#f1c40f"; // yellow
      return "#27ae60"; // green
    }
    if (metric === "avg_processing_days") {
      if (value > 60) return "#e74c3c";
      if (value > 30) return "#f39c12";
      return "#27ae60";
    }
    return "#3498db";
  };

  const option = {
    tooltip: {
      trigger: 'axis',
      formatter: params => {
        const data = params[0];
        return `${data.name}<br><strong>${metricLabel}:</strong> ${data.value}${metric === 'completion_rate' ? '%' : ''}`;
      }
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '10%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      data: xLabels,
      axisLabel: {
        rotate: 30,
        fontSize: 11
      }
    },
    yAxis: {
      type: 'value',
      name: metricLabel,
      nameTextStyle: { fontWeight: 'bold' }
    },
    series: [{
      name: metricLabel,
      type: 'bar',
      data: yValues,
      itemStyle: {
        color: (params) => getBarColor(params.value),
        borderRadius: [6, 6, 0, 0]
      },
      label: {
        show: true,
        position: 'top',
        fontSize: 11,
        formatter: (val) => metric === 'completion_rate' ? `${val.value.toFixed(1)}%` : val.value
      }
    }]
  };

  chart.setOption(option);
}

// Initial load
renderRegionChart("completion_rate");

// When metric changes
$("#region-comparison-metric").on("change", function() {
  const selectedMetric = $(this).val();
  renderRegionChart(selectedMetric);
});




// performance metric

    // Simulated response (you’d replace this with your actual JSON object
// Reference to container
const alertsContainer = $("#performance-alerts");

// Clear old alerts
alertsContainer.empty();

// Loop through and append alerts
reccc.performance_alerts.forEach(alert => {
  let icon = '';

  // Pick icon based on alert type
  switch (alert.alert_type) {
    case 'success':
      icon = '<i class="fas fa-check-circle"></i>';
      break;
    case 'danger':
      icon = '<i class="fas fa-exclamation-circle"></i>';
      break;
    case 'warning':
      icon = '<i class="fas fa-exclamation-triangle"></i>';
      break;
    case 'info':
      icon = '<i class="fas fa-info-circle"></i>';
      break;
    default:
      icon = '<i class="fas fa-bell"></i>';
  }

  // Create alert HTML
  const alertHTML = `
    <div class="alert alert-${alert.alert_type} alert-dismissible fade show" role="alert">
      <small>${icon} <strong>${alert.alert_message}</strong></small>
    </div>
  `;

  alertsContainer.append(alertHTML);
});


 //Services idicators


 function renderServiceTypeBreakdown(reccc) {
  const container = document.getElementById("service-type-breakdown");
  container.innerHTML = ""; // clear existing content

  // Color classes to rotate
  const colors = ["bg-primary", "bg-success", "bg-info", "bg-warning", "bg-danger", "bg-secondary"];
  
  // Get service type breakdown from JSON
  const breakdown = reccc.service_type_breakdown || [];

  breakdown.forEach((item, index) => {
    const color = colors[index % colors.length]; // cycle through colors
    const percentage = item.percentage.toFixed(1); // format to 1 decimal

    const row = `
      <div class="region-bar mb-2 d-flex align-items-center justify-content-between">
        <div class="region-name" style="width: 30%; font-weight: 500;">${item.service_type}</div>
        <div class="region-chart-bar" style="width: 55%; background: #f1f1f1; height: 10px; border-radius: 5px; overflow: hidden;">
          <div class="bar-fill ${color}" style="width: ${percentage}%; height: 100%;"></div>
        </div>
        <div class="region-value" style="width: 10%; text-align: right;">${percentage}%</div>
      </div>
    `;

    container.insertAdjacentHTML("beforeend", row);
  });
}

// Example usage with your JSON data
renderServiceTypeBreakdown(reccc);



        },
        error: function(xhr) {
            console.error("Failed to load dashboard data:", xhr);
        }
    });
}




  $('#sendMessageModal').on('shown.bs.modal', function () {
    //$('#myInput').trigger('focus')
    //$("#eventDetails").modal({backdrop: true});
    $("#past_due_apps_modal").css("z-index", "1029");
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




  $('#serviceTypeModal').on('shown.bs.modal', function () {
    //$('#myInput').trigger('focus')
    //$("#eventDetails").modal({backdrop: true});
    $("#regionsModal").css("z-index", "1029");
  })
  
  
  
   $('#serviceTypeModal').on('hidden.bs.modal', function () {
    //$('#myInput').trigger('focus')
    //$("#eventDetails").modal({backdrop: true});
    $("#regionsModal").css("z-index", "");
  })





  $('#completedTodayserviceTypeModal').on('shown.bs.modal', function () {
    //$('#myInput').trigger('focus')
    //$("#eventDetails").modal({backdrop: true});
    $("#regionsModal").css("z-index", "1029");
  })
  
  
  
   $('#completedTodayserviceTypeModal').on('hidden.bs.modal', function () {
    //$('#myInput').trigger('focus')
    //$("#eventDetails").modal({backdrop: true});
    $("#regionsModal").css("z-index", "");
  })





  $('#completedMonthserviceTypeModal').on('shown.bs.modal', function () {
    //$('#myInput').trigger('focus')
    //$("#eventDetails").modal({backdrop: true});
    $("#regionsModal").css("z-index", "1029");
  })
  
  
  
   $('#completedMonthserviceTypeModal').on('hidden.bs.modal', function () {
    //$('#myInput').trigger('focus')
    //$("#eventDetails").modal({backdrop: true});
    $("#regionsModal").css("z-index", "");
  })








  
  


  

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
  
    // $(document).on("click", ".sendMessage", function (event) {
    //   event.preventDefault();
  
    //   let sendMessageModal = $("#sendMessageModal");
  
    //   let staff = $(this).data("staff");

    //   let staffid = $(this).data("staffid");
      
  
    //   let jobNumbers = $(this).data("jobnumber");

    //   // Convert jobNumbers to an array if it is a comma-separated string
    //   if (typeof jobNumbers === "string") {
    //     jobNumbers = jobNumbers.split(",").map((job) => ({ job_number: job.trim() }));
    //   } else if (typeof jobNumbers === "undefined") {
    //     jobNumbers = [];
    //   }
      
    //   // If jobNumbers is empty, fetch from DataTable
    //   if (jobNumbers.length <= 0) {
    //     jobNumbers = $(this)
    //       .parents(".modal")
    //       .find("table")
    //       .DataTable()
    //       .rows()
    //       .data()
    //       .toArray()
    //       .map((currentItem) => {
    //         return { job_number: currentItem[0] }; // Ensure index 0 is job_number
    //       });
    //   }
      
    //   console.log(jobNumbers); // Check the output in console

    //   console.log(staff);
    //   console.log(staffid);
      
      
  
    //   // set hidden job_numbers input to job number array
    //   sendMessageModal.find("#job_numbers").val(JSON.stringify(jobNumbers));
  
    //   // set hidden staff input to staff id
    //   sendMessageModal.find("#officer_id").val(staffid);
    //   sendMessageModal.find("#officer_name").val(staff);
  
    //   sendMessageModal
    //     .find("#sendMessageModalLabel")
    //     .html(`Send Message To <span class="text-primary">${staff}</span>`);
  
    //   sendMessageModal.modal("show"); 
    // });
  

$(document).on("click", ".sendMessage", function (event) {
  event.preventDefault();

  const table = $("#past_due_apps_with_staff").DataTable();

  // ✅ Collect all selected rows using existing checkboxes
  const selectedRows = [];
  $(".app-checkbox:checked").each(function () {
    const row = $(this).closest("tr");
    const rowData = table.row(row).data();

    // Assuming DataTable columns: [checkbox, job_number, ar_name, ...]
    const jobNumber = rowData.job_number || rowData[1];
    const arName = rowData.ar_name || rowData[2];
    const pendingDays = rowData.days_due || rowData[4];

    selectedRows.push({
      job_number: jobNumber,
      ar_name: arName,
      pendindays: pendingDays,
    });
  });

  // ✅ If nothing selected, show professional alert and stop
  if (selectedRows.length === 0) {
    Swal.fire({
      icon: "warning",
      title: "No Applications Selected",
      text: "Please select at least one application before sending a message.",
      confirmButtonColor: "#0d6efd",
      confirmButtonText: "OK",
    });
    return;
  }

  // ✅ Get staff details
  const staff = $(this).data("staff");
  const staffid = $(this).data("staffid");

  // ✅ Populate modal hidden fields
  const sendMessageModal = $("#sendMessageModal");
  sendMessageModal.find("#officer_id").val(staffid);
  sendMessageModal.find("#officer_name").val(staff);
  sendMessageModal.find("#job_numbers").val(JSON.stringify(selectedRows));

  // ✅ Build HTML table for selected applications
  let selectedTable = `
    <div class="alert alert-info shadow-sm">
      <strong>Selected Applications (${selectedRows.length}):</strong>
      <div class="table-responsive mt-2">
        <table class="table table-sm table-bordered align-middle mb-0">
          <thead class="table-light">
            <tr>
              <th>Job Number</th>
              <th>Applicant Name</th>
              <th>Pending Days</th>
            </tr>
          </thead>
          <tbody>
            ${selectedRows
              .map(
                (item) => `
              <tr>
                <td><code>${item.job_number}</code></td>
                <td>${item.ar_name}</td>
                 <td>${item.pendindays}</td>
              </tr>
            `
              )
              .join("")}
          </tbody>
        </table>
      </div>
    </div>
  `;

  // ✅ Replace previous list/table if reopening
  sendMessageModal.find(".modal-body .alert-info").remove();
  sendMessageModal.find(".modal-body").prepend(selectedTable);

  // ✅ Update modal title and show
  sendMessageModal
    .find("#sendMessageModalLabel")
    .html(`Send Message To <span class="text-primary">${staff}</span>`);

  sendMessageModal.modal("show");
});


//         data = {
//   "request_type": $("#sendMessageModal").find("#request_type").val(),
//   "officer_id": $("#sendMessageModal").find("#officer_id").val(),
//   "officer_name": $("#sendMessageModal").find("#officer_name").val(),
//   "job_numbers": $("#sendMessageModal").find("#job_numbers").val(),
//   "message_type": $("#sendMessageModal").find("#message_type").val(),
//   "message": $("#sendMessageModal").find("#message").val()
// };



//   $("#message-form").on("submit", function (event) {
//   event.preventDefault();

//   let form = $(this);
//   let data = {
//     "request_type": "send_compliance_focal_person_message",
//     "officer_id": $("#sendMessageModal").find("#officer_id").val(),
//     "officer_name": $("#sendMessageModal").find("#officer_name").val(),
//     "job_numbers": $("#sendMessageModal").find("#job_numbers").val(),
//     "message_type": $("#sendMessageModal").find("#message_type").val(),
//     "message": $("#sendMessageModal").find("#message").val()
//   };

//   console.log(data);

//   submitAjax(
//     $(this).attr("action"),
//     "send_compliance_focal_person_message",
//     data,
//     function () {
//       form.trigger("reset");
//       form.parents(".modal").modal("hide");
//       alert("Message sent successfully.");
//     },
//     function () {
//       alert("We were not able to send your message. Please contact IT support if issue persists.");
//     }
//   );
// });



$("#message-form").on("submit", function (event) {
  event.preventDefault();

  const form = $(this);
  const sendMessageModal = $("#sendMessageModal");
    const officerName = sendMessageModal.find("#officer_name").val();


  const data = {
    "request_type": "send_compliance_focal_person_message",
    "officer_id": sendMessageModal.find("#officer_id").val(),
    "officer_name": sendMessageModal.find("#officer_name").val(),
    "job_numbers": sendMessageModal.find("#job_numbers").val(),
    "message_type": sendMessageModal.find("#message_type").val(),
    "message": sendMessageModal.find("#message").val()
  };

  // Show confirmation dialog before sending
  Swal.fire({
    title: "Send Message?",
    text: `Are you sure you want to send this message to ${officerName}?`,
    icon: "question",
    showCancelButton: true,
    confirmButtonColor: "#0d6efd",
    cancelButtonColor: "#6c757d",
    confirmButtonText: "Yes, Send",
    cancelButtonText: "Cancel",
  }).then((result) => {
    if (result.isConfirmed) {
      // Proceed with AJAX submission
      submitAjax(
        form.attr("action"),
        "send_compliance_focal_person_message",
        data,
        function () {
          Swal.fire({
            icon: "success",
            title: "Message Sent!",
            text: "Your message has been sent successfully.",
            confirmButtonColor: "#0d6efd"
          }).then(() => {
            form.trigger("reset");
            form.parents(".modal").modal("hide");
          });
        },
        function () {
          Swal.fire({
            icon: "error",
            title: "Message Failed",
            text: "We were not able to send your message. Please contact IT support if issue persists.",
            confirmButtonColor: "#0d6efd"
          });
        }
      );
    }
  });
});


  
  
    $(".generate-applications-chart").on("submit", function (event) {
      event.preventDefault();
  
      let chartType = $(this).serializeArray()[0].value;
  
      let modalBody = $(this).parents(".modal-content").find(".modal-body");
  
      let title = $(this).parents(".modal-content").find(".modal-title").text();

      console.log(title);
  
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
  
      let tablData = modalBody.find("table").DataTable().rows().data().toArray();

    // Transform array format into object format
    let tableData = tablData.map(row => ({
      name: row[0],     // First column: Service Name
      total: parseInt(row[1], 10) || 0,  // Second column: Count (convert to integer)
      action: row[2]    // Third column: Action (HTML link)
    }));

    // console.log("Formatted Table Data:", formattedData); // Log formatted data to console

      console.log(tableData);

  
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

  var Region_name = $(this).data("type");
  var users_division = $(this).data("regdivision");
  var regioncode = $(this).data("regcode");

    let newdatestart = $('#startdate').val();
    let  newdateend = $('#enddate').val();

  $("#director_regional_code").val(regioncode);

  var regional_code = $("#director_regional_code").val();

  console.log(users_division, regioncode);


  // Convert title to uppercase
  var title =
    (
      Region_name +
      "'S APPLICATIONS RECEIVED FROM " +
      newdatestart +
      " TO " +
      newdateend
    ).toUpperCase();

  // Apply uppercase title to modal header
  document.getElementById("divisionLabelRecievedYear").innerHTML = title;

  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: "director_report_dashboard_created_year_by_division",
      region_id: regioncode,
      division: users_division,
      region_name: Region_name,
      date_from: startDate,
      date_to: endDate,
    },
    cache: false,
    success: function (response) {
      var json_result = JSON.parse(response);
      console.log(json_result.apps_at_division);

      if (json_result.apps_at_division == "") {
        console.log("No data found");
      } else {
        let dataSet10 = [];
        let num10 = 0;

        $("#apps_recieved_year_table").DataTable().clear().destroy();

        for (let i = 0; i < json_result.apps_at_division.length; i++) {
          let html = [];
          num10 += 1;

          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `
            <a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}"  
               id="view_apps_recieved_year"  
               class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
                <i class="fa fa-info-circle"></i> Details
            </a>`;

          html.push(service_type);
          html.push(total);
          html.push(action);

          dataSet10.push(html);
        }

        // Initialize DataTable with uppercase export title
    $('#apps_recieved_year_table').DataTable({
  data: dataSet10,
  dom: 'Bfrtip',
  lengthMenu: [
    [10, 25, 50, -1],
    ['10 rows', '25 rows', '50 rows', 'Show all']
  ],
  buttons: [
    {
      extend: 'copy',
      title: title
    },
    {
      extend: 'csv',
      title: title
    },
    {
      extend: 'excel',
      title: title
    },
    {
      extend: 'pdf',
      title: title
    },
    {
      extend: 'print',
      text: 'Print',
      title: '', // prevent default title
      customize: function (win) {
        $(win.document.body)
          .prepend(
            `<<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3><br>
            <p style="text-align:center; ; font-weight:bold; margin-bottom:30px;">This report is generated using the Enterprise Land Information System</p>`
          )
          .css('font-size', '19px');

        // Optional: make the table look cleaner when printed
        $(win.document.body).find('table')
          .addClass('compact')
          .css('font-size', '19px')
          .css('width', '100%');
      }
    },
    {
      extend: 'colvis',
      text: 'Show / Hide Columns'
    },
    'pageLength'
  ]
}).draw();

      }
    },
  });
});




  $(document).on('click', '#view_apps_recieved_year', function (e) {
  e.preventDefault();

  $("#applicationsModalRecievedYear").modal("show");

  const regional_code = $('#director_regional_code').val();
  const serviceItype = $(this).data('id');
  lastServiceType = serviceItype; // ✅ store globally


   let newdatestart = $('#startdate').val();
    let  newdateend = $('#enddate').val();
    let  status_filter = $('#status_filter').val();

    console.log(serviceItype, status_filter);

     $('#serviceSelect').val(serviceItype);
    

  // Title in uppercase
 loadDivisionApps(lastServiceType, regional_code, newdatestart, newdateend, status_filter);



});




function loadDivisionApps(lastServiceType, regional_code, newdatestart, newdateend, status_filter) {


  let statusLabel = "";
  if (status_filter === "all" || !status_filter) {
    statusLabel = "RECEIVED";
  } else {
    statusLabel = status_filter.toUpperCase(); // e.g., PENDING, COMPLETED, QUERIED
  }

  // 🏷️ Build title dynamically
  const title = `${lastServiceType} APPLICATIONS ${statusLabel} BETWEEN ${newdatestart} AND ${newdateend}`.toUpperCase();

  
    // const title = (lastServiceType + " APPLICATIONS RECEIVED IN " + newdatestart +
    //   " AND " +
    //   newdateend).toUpperCase();

  document.getElementById('applicationsModalLabelRecievedYear').innerHTML = title;

  console.log(regional_code, lastServiceType);

  $('#view_applications_year_by_service_type').DataTable().clear().destroy();
  
  
  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: 'director_report_dashboard_created_year_by_service_type',
      region_id: regional_code,
      service_type: lastServiceType,
      date_from: startDate,
      date_to: endDate,
      status : status_filter
    },
    cache: false,
    success: function (response) {
      var json_result = JSON.parse(response);
      console.log(json_result);

      if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
        console.log("No data found");
        return;
      }

      let dataSet11 = [];

      for (let i = 0; i < json_result.apps_at_division.length; i++) {
        let row = json_result.apps_at_division[i];

        let action = `
          <div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
            </button>
            <div class="dropdown-menu">
            <button type="button" 
        class="dropdown-item" 
        id="btn_status"
        data-job_number=""
        data-id="${row.job_number}"
        title="View Application Stages"
        data-toggle="modal" 
        data-target="#stagesModal">
    Job Stages <i class="fas fa-hdd"></i>
</button>

              <button type="button" class="dropdown-item" href="#" id="btn_cabinet" data-staff_name="" data-staff_id="" data-job_number="" title="View Application Progress" data-target-id="${row.job_number}" data-target="#cabinetModal" data-toggle="modal">Track <i class="fas fa-hdd"></i></button>
              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" value="${row.transaction_number}">
                <input type="hidden" name="search_text" value="${row.case_number}">
                <input type="hidden" name="job_number" value="${row.job_number}">
                <input type="hidden" name="business_process_sub_name" value="${row.business_process_name}">
                <button type="submit" class="dropdown-item">
                  Application Details <i class="fas fa-info-circle"></i>
                </button>
              </form>
            </div>
          </div>
        `;

        dataSet11.push([
          row.job_number,
          row.ar_name,
          row.business_process_name,
          row.created_date,
          row.days_due,
          row.due_date,
          row.days_since_batched,
          row.job_status,
          action
        ]);
      }

      // Initialize DataTable with export buttons
      $('#view_applications_year_by_service_type').DataTable({
        data: dataSet11,
        dom: 'Bfrtip',
        lengthMenu: [
          [10, 25, 50, -1],
          ['10 rows', '25 rows', '50 rows', 'Show all']
        ],
        buttons: [
          {
            extend: 'copy',
            title: title
          },
          {
            extend: 'csv',
            title: title
          },
          {
            extend: 'excel',
            title: title
          },
          {
            extend: 'pdf',
            title: title,
            messageTop: 'This report is generated using the Enterprise Land Information System.'
          },
          {
            extend: 'print',
            text: 'Print',
            title: '', // prevent default title
            customize: function (win) {
              $(win.document.body)
                .prepend(
                  `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                   <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                   This report is generated using the Enterprise Land Information System</p>`
                )
                .css('font-size', '19px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '19px')
                .css('width', '100%');
            }
          },
          {
            extend: 'colvis',
            text: 'Show / Hide Columns'
          },
          'pageLength'
        ]
      }).draw();
    }
  });
  
}


$(document).on("change", "#status_filter", function () {
  // ✅ Reuse last clicked service type
  if (lastServiceType) {
    const regional_code = $('#director_regional_code').val();
    const newdatestart = $('#startdate').val();
    const newdateend = $('#enddate').val();
    const status_filter = $('#status_filter').val();

    loadDivisionApps(lastServiceType, regional_code, newdatestart, newdateend, status_filter);
  } else {
    console.warn("No service type selected yet.");
  }
});


$(document).on("click", ".showServiceTypeModal_apps_recieved_and_completed", function (event) {
  event.preventDefault();

  $("#apps_recieved_completed_year_modal").modal("show");

  const Region_name = $(this).data("type");
  const users_division = $(this).data("regdivision");
  const regioncode = $(this).data("regcode");

  $("#director_regional_code").val(regioncode);

  const regional_code = $("#director_regional_code").val();

   let newdatestart = $('#startdate').val();
    let  newdateend = $('#enddate').val();


  console.log(users_division, regioncode);

  // UPPERCASE TITLE
  const title = (
    Region_name +
    "'S APPLICATIONS RECEIVED AND COMPLETED FRO " +
    newdatestart +
    " TO " +
    newdateend
  ).toUpperCase();

  document.getElementById("divisionLabelRecievedCompletedYear").innerHTML = title;

  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: "director_report_dashboard_created_completed_year_by_division",
      region_id: regional_code.trim(),
      division: users_division,
      date_from: startDate,
      date_to: endDate,
    },
    cache: false,
    success: function (response) {
      const json_result = JSON.parse(response);
      console.log(json_result.apps_at_division);

      if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
        console.log("No data found");
        return;
      }

      let dataSet12 = [];

      for (let i = 0; i < json_result.apps_at_division.length; i++) {
        const row = json_result.apps_at_division[i];

        const action = `
          <a href="javascript:void(0)" data-id="${row.service_type}"  
             id="view_apps_recieved_completed_year"  
             class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
              <i class="fa fa-info-circle"></i> Details
          </a>`;

        dataSet12.push([row.service_type, row.total, action]);
      }

      // Reinitialize DataTable
      $("#apps_recieved_completed_year_table").DataTable().clear().destroy();

      $("#apps_recieved_completed_year_table")
        .DataTable({
          data: dataSet12,
          dom: "Bfrtip",
          lengthMenu: [
            [10, 25, 50, -1],
            ["10 rows", "25 rows", "50 rows", "Show all"],
          ],
          buttons: [
            {
              extend: "copy",
              title: title,
            },
            {
              extend: "csv",
              title: title,
            },
            {
              extend: "excel",
              title: title,
            },
            {
              extend: "pdf",
              title: title,
              messageTop: "This report is generated using the Enterprise Land Information System.",
            },
            {
              extend: "print",
              text: "Print",
              title: "",
              customize: function (win) {
                $(win.document.body)
                  .prepend(
                    `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                     <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                     This report is generated using the Enterprise Land Information System</p>`
                  )
                  .css("font-size", "19px");

                $(win.document.body)
                  .find("table")
                  .addClass("compact")
                  .css("font-size", "19px")
                  .css("width", "100%");
              },
            },
            {
              extend: "colvis",
              text: "Show / Hide Columns",
            },
            "pageLength",
          ],
        })
        .draw();
    },
  });
});




$(document).on('click', '#view_apps_recieved_completed_year', function (e) {
  e.preventDefault();

  $("#applicationsModalRecievedCompletedYear").modal("show");

  const regional_code = $('#director_regional_code').val();
  const service_type = $(this).data('id');

   let newdatestart = $('#startdate').val();
    let  newdateend = $('#enddate').val();

  // Title in uppercase
  const title = (
    service_type +
    " APPLICATIONS RECEIVED AND COMPLETED FROM " +
    newdatestart +
    " TO " +
    newdateend
  ).toUpperCase();

  document.getElementById('applicationsModalLabelRecievedCompletedYear').innerHTML = title;

  $('#view_applications_created_completed_year_by_service_type').DataTable().clear().destroy();

  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: 'director_report_dashboard_created_completed_year_by_service_typ',
      region_id: regional_code,
      service_type: service_type,
      date_from: startDate,
      date_to: endDate
    },
    cache: false,
    success: function (response) {
      const json_result = JSON.parse(response);
      console.log(json_result);

      if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
        console.log("No data found");
        return;
      }

      let dataSet13 = [];

      for (let i = 0; i < json_result.apps_at_division.length; i++) {
        const row = json_result.apps_at_division[i];

        const action = `
          <div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
            </button>
            <div class="dropdown-menu">
              <button type="button" class="dropdown-item" href="#" id="btn_cabinet" data-staff_name="" data-staff_id="" data-job_number="" title="View Application Progress" data-target-id="${row.job_number}" data-target="#cabinetModal" data-toggle="modal">Track <i class="fas fa-hdd"></i></button>

              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" value="${row.transaction_number}">
                <input type="hidden" name="search_text" value="${row.case_number}">
                <input type="hidden" name="job_number" value="${row.job_number}">
                <input type="hidden" name="business_process_sub_name" value="${row.business_process_name}">
                <button type="submit" class="dropdown-item">
                  Application Details <i class="fas fa-info-circle"></i>
                </button>
              </form>
            </div>
          </div>
        `;

        dataSet13.push([
          row.job_number,
          row.ar_name,
          row.business_process_name,
          row.created_date,
          row.completed_date,
          row.turnaround_days,
          action
        ]);
      }

      // Initialize DataTable with export buttons
      $('#view_applications_created_completed_year_by_service_type').DataTable({
        data: dataSet13,
        dom: 'Bfrtip',
        lengthMenu: [
          [10, 25, 50, -1],
          ['10 rows', '25 rows', '50 rows', 'Show all']
        ],
        buttons: [
          {
            extend: 'copy',
            title: title
          },
          {
            extend: 'csv',
            title: title
          },
          {
            extend: 'excel',
            title: title
          },
          {
            extend: 'pdf',
            title: title,
            messageTop: 'This report is generated using the Enterprise Land Information System.'
          },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(
                  `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                   <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                   This report is generated using the Enterprise Land Information System</p>`
                )
                .css('font-size', '19px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '19px')
                .css('width', '100%');
            }
          },
          {
            extend: 'colvis',
            text: 'Show / Hide Columns'
          },
          'pageLength'
        ]
      }).draw();
    }
  });
});



 $(document).on("click", ".showServiceTypeModal_apps_completed", function (event) {
  event.preventDefault();

  // Show modal
  $("#apps_completed_year_modal").modal("show");

  // Get values from data attributes
  const Region_name = $(this).data("type");
  const users_division = $(this).data("regdivision");
  const regioncode = $(this).data("regcode");

  // Store regional code in hidden input
  $("#director_regional_code").val(regioncode);
  const regional_code = $("#director_regional_code").val();

   let newdatestart = $('#startdate').val();
    let  newdateend = $('#enddate').val();


  console.log(users_division, regioncode);

  // UPPERCASE title
  const title = (
    Region_name +
    "'S APPLICATIONS COMPLETED FROM " +
    newdatestart +
    " TO " +
    newdateend
  ).toUpperCase();

  // Set modal title
  document.getElementById("divisionLabelCompletedYear1").innerHTML = title;

  // AJAX request
  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: "director_report_dashboard_completed_year_by_division",
      region_id: regional_code.trim(),
      division: users_division,
      region_name: Region_name,
      date_from: startDate,
      date_to: endDate,
    },
    cache: false,
    success: function (response) {
      const json_result = JSON.parse(response);
      console.log(json_result.apps_at_division);

      if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
        console.log("No data found");
        return;
      }

      let dataSet14 = [];

      for (let i = 0; i < json_result.apps_at_division.length; i++) {
        const row = json_result.apps_at_division[i];

        const action = `
          <a href="javascript:void(0)" data-id="${row.service_type}"  
             id="view_apps_completed_year"  
             class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
              <i class="fa fa-info-circle"></i> Details
          </a>`;

        dataSet14.push([row.service_type, row.total, action]);
      }

      // Reinitialize DataTable with export buttons and consistent formatting
      $("#apps_completed_year_table").DataTable().clear().destroy();

      $("#apps_completed_year_table")
        .DataTable({
          data: dataSet14,
          dom: "Bfrtip",
          lengthMenu: [
            [10, 25, 50, -1],
            ["10 rows", "25 rows", "50 rows", "Show all"],
          ],
          buttons: [
            {
              extend: "copy",
              title: title,
            },
            {
              extend: "csv",
              title: title,
            },
            {
              extend: "excel",
              title: title,
            },
            {
              extend: "pdf",
              title: title,
              messageTop:
                "This report is generated using the Enterprise Land Information System.",
            },
            {
              extend: "print",
              text: "Print",
              title: "",
              customize: function (win) {
                $(win.document.body)
                  .prepend(
                    `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                     <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                     This report is generated using the Enterprise Land Information System</p>`
                  )
                  .css("font-size", "19px");

                $(win.document.body)
                  .find("table")
                  .addClass("compact")
                  .css("font-size", "19px")
                  .css("width", "100%");
              },
            },
            {
              extend: "colvis",
              text: "Show / Hide Columns",
            },
            "pageLength",
          ],
        })
        .draw();
    },
  });
});


  
  
 $(document).on('click', '#view_apps_completed_year', function (e) {
  e.preventDefault();

  $("#applicationsModalCompletedYear").modal("show");

  const regional_code = $('#director_regional_code').val();
  const service_type = $(this).data('id');

   let newdatestart = $('#startdate').val();
    let  newdateend = $('#enddate').val();

  // Title with date range in uppercase
  const title = (
    service_type +
    " APPLICATIONS COMPLETED FROM " +
    newdatestart +
    " TO " +
    newdateend
  ).toUpperCase();

  document.getElementById('applicationsModalLabelCompletedYear').innerHTML = title;

  $('#view_applications_completed_year_by_service_type').DataTable().clear().destroy();

  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: 'director_report_dashboard_completed_year_by_service_type',
      region_id: regional_code,
      service_type: service_type,
      date_from: startDate,
      date_to: endDate
    },
    cache: false,
    success: function (response) {
      const json_result = JSON.parse(response);
      console.log(json_result);

      if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
        console.log("No data found");
        return;
      }

      let dataSet13 = [];

      for (let i = 0; i < json_result.apps_at_division.length; i++) {
        const row = json_result.apps_at_division[i];

        const action = `
          <div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
            </button>
            <div class="dropdown-menu">

          <button type="button" class="dropdown-item" href="#" id="btn_cabinet" data-staff_name="" data-staff_id="" data-job_number="" title="View Application Progress" data-target-id="${row.job_number}" data-target="#cabinetModal" data-toggle="modal">Track <i class="fas fa-hdd"></i></button>

              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" value="${row.transaction_number}">
                <input type="hidden" name="search_text" value="${row.case_number}">
                <input type="hidden" name="job_number" value="${row.job_number}">
                <input type="hidden" name="business_process_sub_name" value="${row.business_process_name}">
                <button type="submit" class="dropdown-item">
                  Application Details <i class="fas fa-info-circle"></i>
                </button>
              </form>
            </div>
          </div>
        `;

        dataSet13.push([
          row.job_number,
          row.ar_name,
          row.business_process_name,
          row.created_date,
          row.completed_date,
          row.turnaround_days,
          action
        ]);
      }

      // Initialize DataTable with export buttons
      $('#view_applications_completed_year_by_service_type').DataTable({
        data: dataSet13,
        dom: 'Bfrtip',
        lengthMenu: [
          [10, 25, 50, -1],
          ['10 rows', '25 rows', '50 rows', 'Show all']
        ],
        buttons: [
          {
            extend: 'copy',
            title: title
          },
          {
            extend: 'csv',
            title: title
          },
          {
            extend: 'excel',
            title: title
          },
          {
            extend: 'pdf',
            title: title,
            messageTop: 'This report is generated using the Enterprise Land Information System.'
          },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(
                  `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                   <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                   This report is generated using the Enterprise Land Information System</p>`
                )
                .css('font-size', '19px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '19px')
                .css('width', '100%');
            }
          },
          {
            extend: 'colvis',
            text: 'Show / Hide Columns'
          },
          'pageLength'
        ]
      }).draw();
    }
  });
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
    
    

  //   $('#sendMessageModal_FocalCompliance').on('show.bs.modal',function(event) {
  //     $("#sendMessageModal_FocalCompliance #officer_name").val($(event.relatedTarget).data('staff_name'));	
  //     $("#sendMessageModal_FocalCompliance #job_numbers").val('[{"job_number":"'+$(event.relatedTarget).data('job_number')+'"}]');
  //     $("#sendMessageModal_FocalCompliance #focal_officer_id").val($(event.relatedTarget).data('staff_id'));
  //      //$("#sendMessageModal #sendMessageModalLabel").val('Send Message To '+$(event.relatedTarget).data('receiver_name'));	
  //     document.getElementById('sendMessageModalLabel_FocalCompliance').innerHTML = 'Send Message To <span class="text-primary">'+$(event.relatedTarget).data('staff_name')+'</span>'
  //     // $("#sendMessageModal #e_lawyer_address").val($(event.relatedTarget).data('lawyer_address'));
  //     // $("#sendMessageModal #e_lawyer_chamber").val($(event.relatedTarget).data('lawyer_chamber'));
  // });
  

  


$('#sendMessageModal_FocalCompliance').on('show.bs.modal', function (event) {
  const button = $(event.relatedTarget);
  const staffName = button.data('staff_name');
  const staffId = button.data('staff_id');
  const jobNumber = button.data('job_number');

  // Set modal fields
  $("#sendMessageModal_FocalCompliance #officer_name").val(staffName);
  $("#sendMessageModal_FocalCompliance #job_numbers").val('[{"job_number":"' + jobNumber + '"}]');
  $("#sendMessageModal_FocalCompliance #focal_officer_id").val(staffId);

  document.getElementById('sendMessageModalLabel_FocalCompliance').innerHTML =
    'Send Message To <span class="text-primary">' + staffName + '</span>';

  // Fetch previous messages
  fetchPreviousNotices(jobNumber);
});

function fetchPreviousNotices(jobNumber) {
  // Show loading message
  $("#messagesContainer").html('<p class="text-muted mb-0">Loading previous messages...</p>');

  $.ajax({
    url: "director_dashboard", // your backend endpoint
    type: "POST",
    data: { 
      request_type: 'select_application_notices_by_job_number',
      job_number: jobNumber // ✅ send job number directly
    },
    success: function (response) {
      console.log(response);

    var json_response = JSON.parse(response);

      if (json_response.success && json_response.cabinet_tracking && json_response.cabinet_tracking.length > 0) {
        let html = `<ul class="list-group">`;
        json_response.cabinet_tracking.forEach(msg => {
  const typeColor =
    msg.notice_type.toLowerCase() === "query"
      ? "bg-warning text-dark"
      : msg.notice_type.toLowerCase() === "warning"
      ? "bg-danger text-white"
      : "bg-secondary text-white";

  html += `
    <li class="list-group-item border-0 shadow-sm mb-3 rounded-3 p-3" style="background: #f9fafb;">
      <div class="d-flex justify-content-between align-items-start mb-2">
        <span class="badge ${typeColor} px-3 py-1 rounded-pill text-capitalize">${msg.notice_type}</span>
        <small class="text-muted fw-light">
          <i class="far fa-clock me-1"></i>${new Date(msg.created_date).toLocaleString()}
        </small>
      </div>

      <div class="d-flex justify-content-between align-items-center">
        <p class="mb-2 text-dark flex-grow-1" style="font-size: 0.95rem;">
          ${msg.details}
        </p>
        <button class="btn btn-sm btn-outline-primary ms-2 view-replies-btn"
        data-notice-id="${msg.notice_id}"
        title="View Replies">
  <i class="fas fa-comments"></i>
</button>
      </div>

      <div class="text-muted small">
        <i class="fas fa-user-circle me-1 text-secondary"></i>
        <b>${msg.created_by}</b> → <span>${msg.receiver_name}</span>
      </div>
    </li>
  `;
});


        html += `</ul>`;
        $("#messagesContainer").html(html);
      } else {
        $("#messagesContainer").html('<p class="text-muted mb-0">No previous messages found for this application.</p>');
      }
    },
    error: function () {
      $("#messagesContainer").html('<p class="text-danger mb-0">Failed to load previous messages.</p>');
    }
  });
}




// use the container that holds the messages (example: #messagesContainer)
$('#messagesContainer').on('click', '.view-replies-btn', function () {
  const noticeId = $(this).data('notice-id');

  $('#repliesModal').modal('show');
  $('#repliesModalBody').html('<p class="text-muted text-center my-3"><i class="fas fa-spinner fa-spin"></i> Loading replies...</p>');

  $.ajax({
    url: "director_dashboard",
    type: "POST",
    data: { 
      request_type: 'select_application_notice_replies',
      notice_id: noticeId
    },
    success: function (response) {
      const json_response = JSON.parse(response);
      console.log(json_response);

      if (json_response.success && json_response.notice_info && json_response.notice_info.length > 0) {
        let repliesHtml = `
          <div class="list-group list-group-flush">
        `;

        json_response.notice_info.forEach(reply => {
          repliesHtml += `
            <div class="list-group-item border-0 border-bottom py-3">
              <div class="d-flex justify-content-between align-items-center mb-1">
                <h6 class="fw-semibold mb-0 text-primary">
                  <i class="fas fa-user-circle me-1 text-secondary"></i> ${reply.created_by}
                </h6>
                <small class="text-muted">
                  <i class="far fa-clock me-1"></i> ${new Date(reply.created_date).toLocaleString()}
                </small>
              </div>
              <p class="mb-0 text-dark" style="font-size: 0.95rem; line-height: 1.4;">
                ${reply.reply_details}
              </p>
            </div>
          `;
        });

        repliesHtml += `</div>`;
        $('#repliesModalBody').html(repliesHtml);
      } else {
        $('#repliesModalBody').html(`
          <div class="text-center text-muted py-4">
            <i class="fas fa-comments fa-2x mb-2"></i>
            <p class="mb-0">No replies found for this notice.</p>
          </div>
        `);
      }
    },
    error: function () {
      $('#repliesModalBody').html('<p class="text-danger text-center mb-0 py-3">Failed to load replies.</p>');
    }
  });
});




$("#message-form_focal_complaince").on("submit", function (event) {
  event.preventDefault();

  let form = $(this);

  // Gather form data
  let data = {
    "request_type": $("#sendMessageModal_FocalCompliance").find("#request_type").val(),
    "officer_id": $("#sendMessageModal_FocalCompliance").find("#focal_officer_id").val(),
    "officer_name": $("#sendMessageModal_FocalCompliance").find("#officer_name").val(),
    "job_numbers": $("#sendMessageModal_FocalCompliance").find("#job_numbers").val(),
    "message_type": $("#sendMessageModal_FocalCompliance").find("#message_type").val(),
    "message": $("#sendMessageModal_FocalCompliance").find("#message").val()
  };

  // Validate — ensure at least one job number is selected
  if (!data.job_numbers || data.job_numbers.trim() === "") {
    Swal.fire({
      icon: "warning",
      title: "No Applications Selected",
      text: "Please select at least one application before sending a message.",
      confirmButtonColor: "#0d6efd",
      confirmButtonText: "OK",
    });
    return;
  }

  // Confirmation alert before sending
  Swal.fire({
    title: "Are you sure?",
    text: `Do you want to send this message to ${data.officer_name}?`,
    icon: "question",
    showCancelButton: true,
    confirmButtonColor: "#0d6efd",
    cancelButtonColor: "#6c757d",
    confirmButtonText: "Yes, Send it!",
    cancelButtonText: "Cancel",
  }).then((result) => {
    if (result.isConfirmed) {
      // Proceed with AJAX submission
      submitAjax(
        form.attr("action"),
        "send_compliance_focal_person_message",
        data,
        function () {
          form.trigger("reset");
          form.parents(".modal").modal("hide");

          Swal.fire({
            icon: "success",
            title: "Message Sent!",
            text: "Your message was sent successfully.",
            confirmButtonColor: "#0d6efd",
          });
        },
        function () {
          Swal.fire({
            icon: "error",
            title: "Sending Failed",
            text: "We were not able to send your message. Please contact IT support if the issue persists.",
            confirmButtonColor: "#0d6efd",
          });
        }
      );
    }
  });
});

  

    



    
    
    $('#sel_change_region_compliance').change(function(){
  // console.log("selection made " + $(this).val() );
  let decimal = $(this).val();
  let new_region_id= Math.trunc(decimal);
  // console.log(new_region_id);
  // document.getElementById('director_regional_code').innerHTML = new_region_id;
  $("#director_regional_code").val(new_region_id);
      
    submitAjax("director_dashboard", "director_report_dashboard_all", {}, function (data) {
  
  
      let totalRec = data.total_apps_rec[0].total;
      let totalRecComp = data.total_comp_divisional_year[0].total;
  
      let totalpercentage = isNaN(((totalRecComp / totalRec) * 100).toFixed(2)) ? 0+'%' : ((totalRecComp / totalRec) * 100).toFixed(2)+'%';
  
              console.log(totalpercentage);
  
      
              $("#app-received-today").html(
                new Intl.NumberFormat().format(data.apps_rec_day[0].total)
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
    
    
    
    
    // if($("#page_name").text() === "director_compliance"){
    //  // console.log("pagen complaince")
    //   setTimeout(
    //       function() 
    //       {
  
    //         submitAjax("director_dashboard", "director_report_dashboard_all", {}, function (data) {
    //          let totalRec = data.total_apps_rec[0].total;
    //          let totalRecComp = data.total_comp_divisional_year[0].total;
    //         //  let totalpercentage = totalRec*totalRecComp/100
              
    //           let totalpercentage = ((totalRecComp / totalRec) * 100).toFixed(2)+'%';
  
    //           // let totalpercentage = isNaN(((totalRecComp / totalRec) * 100).toFixed(2)) ? 0 : ((totalRecComp / totalRec) * 100).toFixed(2);
  
    //          console.log(totalpercentage);
  
  
  
    //           $("#app-received-today").html(
    //             new Intl.NumberFormat().format(data.apps_rec_day[0].total)
    //           );
    //           $("#app-received-month").html(
    //             new Intl.NumberFormat().format(data.apps_rec_month[0].total)
    //           );
    //           $("#app-completed-today").html(
    //             new Intl.NumberFormat().format(data.apps_comp_day[0].total)
    //           );
    //           $("#app-completed-month").html(
    //             new Intl.NumberFormat().format(data.apps_comp_month[0].total)
    //           );
          
    //           // applications received for the year
    //           showDivisionSummary("#app-received-year", data.apps_rec_divisional, 'info');
          
    //           // applications completed for the year
    //           showDivisionSummary("#app-completed-year", data.apps_comp_divisional, 'success');
          
    //           // applications received and completed for the year
    //           showDivisionSummary(
    //             "#app-received-completed-year",
    //             data.apps_comp_divisional_year,
    //       'default'
    //           );
          
    //           // applications past due for the year
    //           showDivisionSummary(
    //             "#app-past-due-year",
    //             data.apps_past_due_dates_divisional,
    //       'danger'
    //           );
          
    //           // applications with divisions
    //           showDivisionSummary("#app-with-divisions", data.apps_at_division, 'warning');
  
  
    //           document.getElementById('pec_id').innerHTML = totalpercentage;
  
              
  
    //          // total_comp_divisional_year
    //         });
    //       }, 2000);
      
    // }
  
  
  
    
  
  
  
  
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
    let total = data.reduce((sum, current) => sum + current.total, 0);
    $(id).find(".count").html(new Intl.NumberFormat().format(total));
  
    let contentBody = $(id).find(".content-body");
  
    let date = contentBody.data("date") ?? "";
    let period = contentBody.data("period");
    let method = contentBody.data("method");
    let title = contentBody.data("title");
    let url = contentBody.data("url");
    let nextLevelModal = contentBody.data("next-level-modal");
  
    let periodToAdd = typeof period === "undefined" ? "" : `_${period}`;
  
    let dataHtml = "";
    let showMore = data.length > 5; // If more than 5 items, show "Show More" button
  
    data.forEach((current, index) => {
      let percent = ((current.total / total) * 100).toFixed(2);
      
      let hiddenClass = index >= 5 ? "d-none more-items" : ""; // Hide extra items initially
  
      dataHtml += `<div class="item ${hiddenClass}">
        <h4 class="small font-weight-bold">
          <a href="#" data-method="${method}" data-url="${url}" ${
            typeof period === "undefined" ? "" : `data-period="${period}"`
          } data-action="report_dashboard_${method}${periodToAdd}" data-type="${
            current.division
          }" data-regcode="${
            current.region_code
          }" data-regdivision="${
            current.current_division_of_application
          }"
          data-date="${date}" data-title="${title}" class="${nextLevelModal} text-decoration-none text-muted">
            ${current.division} (${current.total})
          </a>
          <span class="float-right">${percent}%</span>
        </h4>
        <div class="progress mb-4">
          <div class="progress-bar bg-${color}" role="progressbar" style="width: ${percent}%" aria-valuenow="${percent}"
            aria-valuemin="0" aria-valuemax="100"></div>
        </div>
      </div>`;
    });
  
    // Append "Show More/Less" button if needed
    if (showMore) {
      dataHtml += `
        <button class="btn btn-link show-more-btn" data-expanded="false">Show More</button>
      `;
    }
  
    contentBody.html(dataHtml);
  
    // Handle "Show More/Less" button click
    $(id).find(".show-more-btn").on("click", function () {
      let expanded = $(this).data("expanded");
  
      if (expanded) {
        // Hide extra items
        $(id).find(".more-items").addClass("d-none");
        $(this).text("Show More").data("expanded", false);
      } else {
        // Show all items
        $(id).find(".more-items").removeClass("d-none");
        $(this).text("Show Less").data("expanded", true);
      }
    });
  }



// Old Function
  // function showDivisionSummary(id, data, color) {
  //   // console.log(data[0]); // Logging the first data item

  //   let total = data.reduce(function (sum, current) {
     
  //     return (sum += current.total);
  //   }, 0);
  //  //console.log(total);

  //   $(id).find(".count").html(new Intl.NumberFormat().format(total));

  //   let contentBody = $(id).find(".content-body");

  //   let date = contentBody.data("date") ?? "";
  //   let period = contentBody.data("period");
  //   let method = contentBody.data("method");
  //   let title = contentBody.data("title");
  //   let url = contentBody.data("url");
  //   let nextLevelModal = contentBody.data("next-level-modal");

  //   let periodToAdd = typeof period === "undefined" ? "" : `_${period}`;
  //   let dataHtml = data.reduce(function (sum, current) {
  //     let percent = ((current.total / total) * 100).toFixed(2);

  //    // console.log(percent);

  //     let html = `<div class="item">
  //       <h4 class="small font-weight-bold">
  //         <a href="#" data-method="${method}" data-url="${url}" ${
  //       typeof period === "undefined" ? "" : `data-period="${period}"`
  //     } data-action="report_dashboard_${method}${periodToAdd}" data-type="${
  //       current.division
  //     }"  data-regcode="${
  //       current.region_code
  //     }"  data-regdivision="${
  //       current.current_division_of_application
  //     }"
  //      data-date="${date}" data-title="${title}" class="${nextLevelModal} text-decoration-none text-muted">
  //           ${current.division} (${current.total})
  //         </a>
  //         <span class="float-right">${percent}%</span>
  //       </h4>
  //       <div class="progress mb-4">
  //         <div class="progress-bar bg-${color}" role="progressbar" style="width: ${percent}%" aria-valuenow="${percent}"
  //           aria-valuemin="0" aria-valuemax="100"></div>
  //       </div>
  //     </div>
  //     <input type='hidden' value='${current.division}' id='currentDivision'> `;

  //     return (sum += html);
  //   }, "");

  //   contentBody.html(dataHtml);
  // }

  
  
  
  
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
    
    
  
     if(region_id != undefined){
      region_id =  region_id.replace(".0", "");
     }

      var user_division = $('#director_division').val();
     console.log(user_division,user_division);
  
      $.ajax({
        type: "POST",
        url,
        data: {
          request_type: requestType,
          region_id: region_id,
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

  $('#apps_received_today').on('click', function (e) {
  e.preventDefault();

  $("#regionsModal").modal("show");

  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${day} ${months[monthIndex]} ${year}`;

  const division = $('#director_division').val();

  // Create uppercase title
  const title = `${division}'S APPLICATIONS RECEIVED TODAY ${formattedDate}`.toUpperCase();

  // Set modal header
  document.getElementById('regionsModalLabel').innerHTML = title;

  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: 'director_report_dashboard_created_day_by_regions',
      division: division
    },
    cache: false,
    success: function (response) {
      const json_result = JSON.parse(response);
      console.log(json_result.apps_at_division);

      if (json_result.apps_at_division == '') {
        console.log("No data found");
      } else {
        let dataSet1 = [];
        let num1 = 0;

        $('#region_table').DataTable().clear().destroy();

        for (let i = 0; i < json_result.apps_at_division.length; i++) {
          let html = [];
          num1 += 1;

          let region = json_result.apps_at_division[i].region;
          let total = json_result.apps_at_division[i].total;

          let action = `
            <a href="javascript:void(0)" 
               data-id="${json_result.apps_at_division[i].region_code}" 
               data-regionname="${json_result.apps_at_division[i].region}"  
               id="view_recieved_today_by_region"  
               class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
              <i class="fa fa-info-circle"></i> Details
            </a>`;

          html.push(region);
          html.push(total);
          html.push(action);

          dataSet1.push(html);
        }

        // Initialize DataTable with uppercase title for exports
        $('#region_table').DataTable({
          data: dataSet1,
          dom: 'Bfrtip',
          lengthMenu: [
            [10, 25, 50, -1],
            ['10 rows', '25 rows', '50 rows', 'Show all']
          ],
          buttons: [
            {
              extend: 'copy',
              title: title
            },
            {
              extend: 'csv',
              title: title
            },
            {
              extend: 'excel',
              title: title
            },
            {
              extend: 'pdf',
              title: title
            },
            {
              extend: 'print',
              text: 'Print',
              title: '', // Remove default
              customize: function (win) {
                $(win.document.body)
                  .prepend(
                    `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                     <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                       This report is generated using the Enterprise Land Information System
                     </p>`
                  )
                  .css('font-size', '19px');

                $(win.document.body).find('table')
                  .addClass('compact')
                  .css('font-size', '19px')
                  .css('width', '100%');
              }
            },
            {
              extend: 'colvis',
              text: 'Show / Hide Columns'
            },
            'pageLength'
          ]
        }).draw();
      }
    }
  });
});



    



 $(document).on('click', '#view_recieved_today_by_region', function (e) {
  e.preventDefault();

  // Show modal
  $("#serviceTypeModal").modal("show");

  // Prepare date info
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${day} ${months[monthIndex]} ${year}`;

  // Extract region data
  const regional_code = $(this).data('id');
  const regional_name = $(this).data('regionname');
  const division = $('#director_division').val();

  console.log("Region:", regional_name);

  // Set hidden field
  $("#today_region_id").val(regional_code);

  // Title (uppercase)
  const title = `${regional_name}'S APPLICATIONS RECEIVED TODAY ${formattedDate}`.toUpperCase();
  document.getElementById('serviceTypeModalLabel').innerHTML = title;

  // AJAX call
  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: 'director_report_dashboard_created_day_by_division',
      region_id: regional_code,
      division: division
    },
    cache: false,
    success: function (response) {
      const json_result = JSON.parse(response);
      console.log(json_result.apps_at_division);

      if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
        console.log("No data found");
        return;
      }

      // Sort results by total (descending)
      json_result.apps_at_division.sort((a, b) => b.total - a.total);

      let dataSet1 = [];
      let num1 = 0;

      // Clear previous DataTable
      $('#created_by_services_today').DataTable().clear().destroy();

      // Populate data
      for (let i = 0; i < json_result.apps_at_division.length; i++) {
        const serviceData = json_result.apps_at_division[i];
        num1 += 1;

        const service_type = serviceData.service_type;
        const total = serviceData.total;

        const action = `
          <a href="javascript:void(0)" 
             data-id="${serviceData.service_type}"  
              data-rg="${regional_name}"  
             id="view_recieved_today_by_service"  
             class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
              <i class="fa fa-info-circle"></i> Details
          </a>`;

        dataSet1.push([service_type, total, action]);
      }

      // Initialize DataTable
      $('#created_by_services_today').DataTable({
        data: dataSet1,
        dom: 'Bfrtip',
        order: [[1, 'desc']], // Sort by total descending
        lengthMenu: [
          [10, 25, 50, -1],
          ['10 rows', '25 rows', '50 rows', 'Show all']
        ],
        buttons: [
          { extend: 'copy', title: title },
          { extend: 'csv', title: title },
          { extend: 'excel', title: title },
          { extend: 'pdf', title: title },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(`
                  <h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                  <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                    This report is generated using the Enterprise Land Information System
                  </p>
                `)
                .css('font-size', '19px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '19px')
                .css('width', '100%');
            }
          },
          { extend: 'colvis', text: 'Show / Hide Columns' },
          'pageLength'
        ]
      }).draw();
    }
  });
});






    $('#user_division_today').on('click', function(e) {
        e.preventDefault();

     $("#serviceTypeModal").modal("show");  
     const months = [
      'January', 'February', 'March', 'April', 'May', 'June',  
      'July', 'August', 'September', 'October', 'November', 'December'
    ];    const currentDate = new Date();
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
            url : "director_dashboard",
            data : { 
                request_type : 'director_report_dashboard_created_day_by_division',
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
            let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}"  id=""  
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






   $(document).on('click', '#view_recieved_today_by_service', function (e) {
  e.preventDefault();

  // Show modal
  $("#applicationsModal").modal("show");

  // Prepare date info
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${day} ${months[monthIndex]} ${year}`;

  // Extract data
  const regional_code = $('#today_region_id').val();
  const service_type = $(this).data('id');
  const regName = $(this).data('rg');

  

  // Title (uppercase)
  const title = `${service_type} RECEIVED TODAY (${formattedDate}) FROM ${regName}`.toUpperCase();
  document.getElementById('applicationsModalLabel').innerHTML = title;

  // Destroy existing DataTable
  $('#view_applications_by_service_type').DataTable().clear().destroy();

  // AJAX Request
  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: 'director_report_dashboard_created_day_by_service_type',
      region_id: regional_code,
      service_type: service_type
    },
    cache: false,
    success: function (response) {
      const json_result = JSON.parse(response);
      console.log(json_result);

      // Handle no data case
      if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
        console.log("No data found");
        $('#view_applications_by_service_type').DataTable().clear().destroy();
        $('#view_applications_by_service_type').html(`
          <tr>
            <td colspan="8" class="text-center text-muted">
              No applications received today for this service type.
            </td>
          </tr>
        `);
        return;
      }

      // Sort by days_due descending
      json_result.apps_at_division.sort((a, b) => b.days_due - a.days_due);

      // Build dataset
      const dataSet = json_result.apps_at_division.map(app => {
        const action = `
          <div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
            </button>
            <div class="dropdown-menu">
              <button type="button" class="dropdown-item"
                id="btn_cabinet"
                data-target-id="${app.job_number}"
                data-toggle="modal"
                data-target="#cabinetModal">
                Track <i class="fas fa-hdd"></i>
              </button>
              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" value="${app.transaction_number}">
                <input type="hidden" name="search_text" value="${app.case_number}">
                <input type="hidden" name="job_number" value="${app.job_number}">
                <input type="hidden" name="business_process_sub_name" value="${app.business_process_name}">
                <button type="submit" name="save" class="dropdown-item">
                  Application Details <i class="fas fa-info-circle"></i>
                </button>
              </form>
            </div>
          </div>
        `;

        return [
          app.job_number,
          app.ar_name,
          app.business_process_name,
          app.created_date,
          app.days_due,
          app.due_date,
          app.days_since_batched,
           app.job_status,
          action
        ];
      });

      // Initialize DataTable
      $('#view_applications_by_service_type').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        order: [[5, 'desc']], // sort by days_due descending
        lengthMenu: [
          [10, 25, 50, -1],
          ['10 rows', '25 rows', '50 rows', 'Show all']
        ],
        buttons: [
          { extend: 'copy', title: title },
          { extend: 'csv', title: title },
          { extend: 'excel', title: title },
          { extend: 'pdf', title: title },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(`
                  <h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                  <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                    This report is generated using the Enterprise Land Information System
                  </p>
                `)
                .css('font-size', '19px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '19px')
                .css('width', '100%');
            }
          },
          { extend: 'colvis', text: 'Show / Hide Columns' },
          'pageLength'
        ]
      }).draw();
    }
  });
});





 $('#apps_received_this_month').on('click', function (e) {
  e.preventDefault();

  $("#regionsModal").modal("show");

  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  const currentDate = new Date();
  const monthIndex = currentDate.getMonth();
  const day = currentDate.getDate();
    const year = currentDate.getFullYear();
  const formattedDate = `${day} ${months[monthIndex]} ${year}`;

  const division = $('#director_division').val();

  // Create uppercase title
  const title = `${division}'S APPLICATIONS RECEIVED TODAY ${formattedDate}`.toUpperCase();

  // Apply uppercase title to modal header
  document.getElementById('regionsModalLabel').innerHTML = title;

  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: 'director_report_dashboard_created_month_by_regions',
      division: division
    },
    cache: false,
    success: function (response) {
      const json_result = JSON.parse(response);
      console.log(json_result.apps_at_division);

      if (json_result.apps_at_division == '') {
        console.log("No data found");
      } else {
        let dataSet1 = [];
        let num1 = 0;

        $('#region_table').DataTable().clear().destroy();

        for (let i = 0; i < json_result.apps_at_division.length; i++) {
          let html = [];
          num1 += 1;

          let region = json_result.apps_at_division[i].region;
          let total = json_result.apps_at_division[i].total;

          let action = `
            <a href="javascript:void(0)" 
               data-id="${json_result.apps_at_division[i].region_code}" 
               data-regionname="${json_result.apps_at_division[i].region}"  
               id="view_recieved_month_by_region"  
               class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
              <i class="fa fa-info-circle"></i> Details
            </a>`;

          html.push(region);
          html.push(total);
          html.push(action);
          dataSet1.push(html);
        }

        // Initialize DataTable with export buttons using uppercase title
        $('#region_table').DataTable({
          data: dataSet1,
          dom: 'Bfrtip',
          lengthMenu: [
            [10, 25, 50, -1],
            ['10 rows', '25 rows', '50 rows', 'Show all']
          ],
          buttons: [
            {
              extend: 'copy',
              title: title
            },
            {
              extend: 'csv',
              title: title
            },
            {
              extend: 'excel',
              title: title
            },
            {
              extend: 'pdf',
              title: title
            },
            {
              extend: 'print',
              text: 'Print',
              title: '', // disable default
              customize: function (win) {
                $(win.document.body)
                  .prepend(
                    `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                     <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                       This report is generated using the Enterprise Land Information System
                     </p>`
                  )
                  .css('font-size', '19px');

                $(win.document.body).find('table')
                  .addClass('compact')
                  .css('font-size', '19px')
                  .css('width', '100%');
              }
            },
            {
              extend: 'colvis',
              text: 'Show / Hide Columns'
            },
            'pageLength'
          ]
        }).draw();
      }
    }
  });
});




$(document).on('click', '#view_recieved_month_by_region', function (e) {
  e.preventDefault();

  // Show modal
  $("#serviceTypeModal").modal("show");

  // Prepare month info
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  const currentDate = new Date();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const day = currentDate.getDate();
  const formattedDate = `${day} ${months[monthIndex]} ${year}`;

  // Extract region data
  const regional_code = $(this).data('id');
  const regional_name = $(this).data('regionname');
  const division = $('#director_division').val();

  console.log("Region:", regional_name);

  // Set hidden field
  $("#today_region_id").val(regional_code);

  // Title (uppercase)
  const title = `${regional_name}'S APPLICATIONS RECEIVED TODAY (${formattedDate})`.toUpperCase();
  document.getElementById('serviceTypeModalLabel').innerHTML = title;

  // AJAX call
  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: 'director_report_dashboard_pending_as_at_day_by_division',
      region_id: regional_code,
      division: division
    },
    cache: false,
    success: function (response) {
      const json_result = JSON.parse(response);
      console.log(json_result.apps_at_division);

      if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
        console.log("No data found");
        $('#created_by_services_today').DataTable().clear().destroy();
        $('#created_by_services_today').html('<tr><td colspan="3" class="text-center text-muted">No applications found for this month.</td></tr>');
        return;
      }

      // Sort results by total (descending)
      json_result.apps_at_division.sort((a, b) => b.total - a.total);

      let dataSet1 = [];
      let num1 = 0;

      // Clear previous DataTable
      $('#created_by_services_today').DataTable().clear().destroy();

      // Populate data
      for (let i = 0; i < json_result.apps_at_division.length; i++) {
        const serviceData = json_result.apps_at_division[i];
        num1 += 1;

        const service_type = serviceData.service_type;
        const total = serviceData.total;

        const action = `
          <a href="javascript:void(0)" 
             data-id="${serviceData.service_type}"  
             data-rg="${regional_name}"
             id="view_recieved_month_by_service"  
             class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
              <i class="fa fa-info-circle"></i> Details
          </a>`;

        dataSet1.push([service_type, total, action]);
      }

      // Initialize DataTable
      $('#created_by_services_today').DataTable({
        data: dataSet1,
        dom: 'Bfrtip',
        order: [[1, 'desc']], // Sort by total descending
        lengthMenu: [
          [10, 25, 50, -1],
          ['10 rows', '25 rows', '50 rows', 'Show all']
        ],
        buttons: [
          { extend: 'copy', title: title },
          { extend: 'csv', title: title },
          { extend: 'excel', title: title },
          { extend: 'pdf', title: title },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(`
                  <h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                  <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                    This report is generated using the Enterprise Land Information System
                  </p>
                `)
                .css('font-size', '19px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '19px')
                .css('width', '100%');
            }
          },
          { extend: 'colvis', text: 'Show / Hide Columns' },
          'pageLength'
        ]
      }).draw();
    }
  });
});


        


$(document).on('click', '#view_recieved_month_by_service', function (e) {
  e.preventDefault();

  // Show modal
  $("#applicationsModalRecievedMonth").modal("show");

  // Prepare date info
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  const currentDate = new Date();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
    const day = currentDate.getDate();
  const formattedDate = `${day} ${months[monthIndex]} ${year}`;

  // Extract data
  const regional_code = $('#today_region_id').val();
  const service_type = $(this).data('id');
  const regionalName = $(this).data('rg');

  // Title (uppercase)
  const title = `${service_type} RECEIVED THIS TODAY (${formattedDate}) FROM ${regionalName}`.toUpperCase();
  document.getElementById('applicationsModalLabelRecievedMonth').innerHTML = title;

  // Destroy existing DataTable
  $('#view_applications_month_by_service_type').DataTable().clear().destroy();

  // AJAX Request
  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: 'director_report_dashboard_created_month_by_service_type',
      region_id: regional_code,
      service_type: service_type
    },
    cache: false,
    success: function (response) {
      const json_result = JSON.parse(response);
      console.log(json_result);

      // Handle no data case
      if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
        console.log("No data found");
        $('#view_applications_month_by_service_type').DataTable().clear().destroy();
        $('#view_applications_month_by_service_type').html(`
          <tr>
            <td colspan="8" class="text-center text-muted">
              No applications received this month for this service type.
            </td>
          </tr>
        `);
        return;
      }

      // Sort by days_due descending
      json_result.apps_at_division.sort((a, b) => b.days_due - a.days_due);

      // Build dataset
      const dataSet = json_result.apps_at_division.map(app => {
        const action = `
          <div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
            </button>
            <div class="dropdown-menu">
              <button type="button" class="dropdown-item"
                id="btn_cabinet"
                data-target-id="${app.job_number}"
                data-toggle="modal"
                data-target="#cabinetModal">
                Track <i class="fas fa-hdd"></i>
              </button>
              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" value="${app.transaction_number}">
                <input type="hidden" name="search_text" value="${app.case_number}">
                <input type="hidden" name="job_number" value="${app.job_number}">
                <input type="hidden" name="business_process_sub_name" value="${app.business_process_name}">
                <button type="submit" name="save" class="dropdown-item">
                  Application Details <i class="fas fa-info-circle"></i>
                </button>
              </form>
            </div>
          </div>
        `;

        return [
          app.job_number,
          app.ar_name,
          app.business_process_name,
          app.created_date,
          app.days_due,
          app.due_date,
          app.days_since_batched,
           app.job_status,
          action
        ];
      });

      // Initialize DataTable
      $('#view_applications_month_by_service_type').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        order: [[5, 'desc']], // sort by days_due descending
        lengthMenu: [
          [10, 25, 50, -1],
          ['10 rows', '25 rows', '50 rows', 'Show all']
        ],
        buttons: [
          { extend: 'copy', title: title },
          { extend: 'csv', title: title },
          { extend: 'excel', title: title },
          { extend: 'pdf', title: title },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(`
                  <h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                  <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                    This report is generated using the Enterprise Land Information System
                  </p>
                `)
                .css('font-size', '19px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '19px')
                .css('width', '100%');
            }
          },
          { extend: 'colvis', text: 'Show / Hide Columns' },
          'pageLength'
        ]
      }).draw();
    }
  });
});



$('#apps_completed_today_division').on('click', function (e) {
  e.preventDefault();

  // Show modal
  $("#regionsModal").modal("show");

  // Prepare current date
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${day} ${months[monthIndex]} ${year}`;

  // Get division and title
  const division = $('#director_division').val();
  const title = `${division}'S APPLICATIONS COMPLETED TODAY ${formattedDate}`.toUpperCase();

  // Apply uppercase title to modal header
  document.getElementById('regionsModalLabel').innerHTML = title;

  // Fetch data from backend
  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: 'director_report_dashboard_completed_today_by_regions',
      division: division
    },
    cache: false,
    success: function (response) {
      const json_result = JSON.parse(response);
      console.log(json_result.apps_at_division);

      if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
        console.log("No data found");
        return;
      }

      // Sort results by total (descending)
      json_result.apps_at_division.sort((a, b) => b.total - a.total);

      let dataSet1 = [];
      let num1 = 0;

      // Clear old table
      $('#region_table').DataTable().clear().destroy();

      // Populate table
      for (let i = 0; i < json_result.apps_at_division.length; i++) {
        const regionData = json_result.apps_at_division[i];
        num1 += 1;

        const region = regionData.region;
        const total = regionData.total;

        const action = `
          <a href="javascript:void(0)" 
             data-id="${regionData.region_code}" 
             data-regionname="${regionData.region}"  
             id="view_completed_today_by_region"  
             class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
            <i class="fa fa-info-circle"></i> Details
          </a>`;

        dataSet1.push([region, total, action]);
      }

      // Initialize DataTable with export options
      $('#region_table').DataTable({
        data: dataSet1,
        dom: 'Bfrtip',
        lengthMenu: [
          [10, 25, 50, -1],
          ['10 rows', '25 rows', '50 rows', 'Show all']
        ],
        order: [[1, 'desc']], // Sort by total descending
        buttons: [
          { extend: 'copy', title: title },
          { extend: 'csv', title: title },
          { extend: 'excel', title: title },
          { extend: 'pdf', title: title },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(`
                  <h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                  <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                    This report is generated using the Enterprise Land Information System
                  </p>
                `)
                .css('font-size', '19px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '19px')
                .css('width', '100%');
            }
          },
          { extend: 'colvis', text: 'Show / Hide Columns' },
          'pageLength'
        ]
      }).draw();
    }
  });
});




$(document).on('click', '#view_completed_today_by_region', function (e) {
  e.preventDefault();

  // Show modal
  $("#completedTodayserviceTypeModal").modal("show");

  // Prepare date info
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${day} ${months[monthIndex]} ${year}`;

  // Extract region data
  const regional_code = $(this).data('id');
  const regional_name = $(this).data('regionname');
  const division = $('#director_division').val();

  console.log("Region:", regional_name);

  // Set hidden field
  $("#today_region_id").val(regional_code);

  // Title (uppercase for clarity)
  const title = `${regional_name}'S APPLICATIONS COMPLETED TODAY (${formattedDate})`.toUpperCase();
  document.getElementById('completedTodayserviceTypeModalLabel').innerHTML = title;

  // AJAX request
  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: 'director_report_dashboard_completed_today_by_division',
      region_id: regional_code,
      division: division
    },
    cache: false,
    success: function (response) {
      const json_result = JSON.parse(response);
      console.log(json_result.apps_at_division);

      // Handle no data case
      // if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
      //   console.log("No data found");
      //   $('#completed_serviceType_Table').DataTable().clear().destroy();
      //   $('#completed_serviceType_Table').html('<tr><td colspan="3" class="text-center text-muted">No applications completed today for this region.</td></tr>');
      //   return;
      // }

      // Sort results by total descending
      json_result.apps_at_division.sort((a, b) => b.total - a.total);

      let dataSet6 = [];

      // Destroy existing DataTable
      $('#completed_serviceType_Table').DataTable().clear().destroy();

      // Populate new rows
      json_result.apps_at_division.forEach(serviceData => {
        const service_type = serviceData.service_type;
        const total = serviceData.total;

        const action = `
          <a href="javascript:void(0)"
             data-id="${serviceData.service_type}"
              data-rg="${regional_name}"
             id="apps_completed_today_servicetype"
             class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
            <i class="fa fa-info-circle"></i> Details
          </a>`;

        dataSet6.push([service_type, total, action]);
      });

      // Initialize DataTable
      $('#completed_serviceType_Table').DataTable({
        data: dataSet6,
        dom: 'Bfrtip',
        order: [[1, 'desc']], // sort by total descending
        lengthMenu: [
          [10, 25, 50, -1],
          ['10 rows', '25 rows', '50 rows', 'Show all']
        ],
        buttons: [
          { extend: 'copy', title: title },
          { extend: 'csv', title: title },
          { extend: 'excel', title: title },
          { extend: 'pdf', title: title },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(`
                  <h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                  <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                    This report is generated using the Enterprise Land Information System
                  </p>
                `)
                .css('font-size', '19px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '19px')
                .css('width', '100%');
            }
          },
          { extend: 'colvis', text: 'Show / Hide Columns' },
          'pageLength'
        ]
      }).draw();
    }
  });
});







// $(document).on('click','#view_recieved_today_by_service',function(e){
//   e.preventDefault();
 
// $("#applicationsModal").modal("show");  


// const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
// const currentDate = new Date();
// const day = currentDate.getDate();
// const monthIndex = currentDate.getMonth();
// const year = currentDate.getFullYear();
// const formattedDate = `${day} ${months[monthIndex]} ${year}`;


//   var regional_code = $('#director_regional_code').val();
//   // var division = $('#director_division').val();

//   var service_type=$(this).data('id');


//   var title  = service_type+" "+"Applications Received Today"+" "+formattedDate;

//   document.getElementById('applicationsModalLabel').innerHTML = title;

// //  console.log(service_type);


//  let dataSet51 = [];
//  let num51 = 0;

// $('#view_applications_by_service_type').DataTable().clear().destroy();

//  $.ajax({
//      type : "POST",
//      url : "director_dashboard",
//      data : {
//          request_type : 'director_report_dashboard_created_day_by_service_type',
//          region_id : regional_code,
//          service_type : service_type
//      },
//      cache: false,
//      success: function(response) {

//       //console.log(response)

//          var json_result = JSON.parse(response);
//          console.log(json_result)

//          if (json_result.apps_at_division == ""){

//           //console.log("data not found");       

// }else {

//   for(let i=0; i<json_result.apps_at_division.length; i++) {
//     let html = [];
//     num51 = +num51 + 1;

//     let job_number = json_result.apps_at_division[i].job_number;
//     let ar_name = json_result.apps_at_division[i].ar_name;
//     let business_process_name = json_result.apps_at_division[i].business_process_name;
//     let created_date = json_result.apps_at_division[i].created_date;
//     let due_date = json_result.apps_at_division[i].due_date;
//     let days_due = json_result.apps_at_division[i].days_due;
//     let days_since_batched = json_result.apps_at_division[i].days_since_batched;
//   //  let action = ' <a href="#" class="btn btn-secondary">View <i class="fa fa-eye"></i></a>';
//     // let payment_status = e[i].payment_status;
//     // let buttons = e[i].buttons;
    

//     html.push(job_number);
//     html.push(ar_name);
//     html.push(business_process_name);
//     html.push(created_date);
//     html.push(due_date);
//     html.push(days_due);
//     html.push(days_since_batched);
//   //   html.push(action);

//     dataSet51.push(html);

//   //console.log(dataSet)
//   }

// // let dataTable_Obj = $('#recievedtoday').DataTable({
// //     data: dataSet1
// //   })

//   $('#view_applications_by_service_type').DataTable().clear().destroy();
                
//   $('#view_applications_by_service_type').DataTable({ data: dataSet51,
//     dom : 'Bfrtip',
//     lengthMenu : [
//         [ 10, 25, 50, -1 ],
//         [ '10 rows', '25 rows',
//             '50 rows', 'Show all' ] ],
//     buttons : [ 'pageLength', 'copy',
//         'csv', 'excel', 'pdf', 'print' ] }).draw();

// }
        

         


//      }
//  })



// });





$('#completed_today_service').on('click', function(e) {
  e.preventDefault();

// $("#completedTodayserviceTypeModal").modal("show");  
// const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
// const currentDate = new Date();
// const day = currentDate.getDate();
// const monthIndex = currentDate.getMonth();
// const year = currentDate.getFullYear();
// const formattedDate = `${day} ${months[monthIndex]} ${year}`;


//   var regional_code = $('#director_regional_code').val();
//   var division = $('#director_division').val();

//   var title  = division+"'"+'s'+" "+"Applications Completed Today"+" "+formattedDate;

//   document.getElementById('completedTodayserviceTypeModalLabel').innerHTML = title;

  
//  //console.log(regional_code,division);



//   $.ajax({
//       type : "POST",
//       url : "director_dashboard",
//       data : { 
//           request_type : 'director_report_dashboard_completed_today_by_division',
//           region_id : regional_code.trim(),
//           division:division
//       },
//       cache: false,
//       success: function(response) {
//         console.log(response);

//           var json_result = JSON.parse(response);

//           console.log(json_result.apps_at_division);

//           if (json_result.apps_at_division == ''){

//               //.log("data not found");       

// }else {

//   let dataSet6 = [];
//   let num6 = 0;

// $('#completed_serviceType_Table').DataTable().clear().destroy();

//   for(let i=0; i<json_result.apps_at_division.length; i++) {
//       let html = [];
//       num6 = +num6 + 1;

//       let service_type = json_result.apps_at_division[i].service_type;
//       let total = json_result.apps_at_division[i].total;
//       let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}"  id="apps_completed_today_servicetype"  
//       class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

//       // let payment_status = e[i].payment_status;
//       // let buttons = e[i].buttons;
//       html.push(service_type);
//       html.push(total);
//       html.push(action);

//       dataSet6.push(html);

//     ///console.log(dataSet1)
//     }

//   // let dataTable_Obj = $('#recievedtoday').DataTable({
//   //     data: dataSet1
//   //   })

//     $('#completed_serviceType_Table').DataTable().clear().destroy();
                  
//     $('#completed_serviceType_Table').DataTable({ data: dataSet6,
//       dom : 'Bfrtip',
//       lengthMenu : [
//           [ 10, 25, 50, -1 ],
//           [ '10 rows', '25 rows',
//               '50 rows', 'Show all' ] ],
//       buttons : [ 'pageLength', 'copy',
//           'csv', 'excel', 'pdf', 'print' ] }).draw();

// }


//       }
//   })



})






$(document).on('click', '#apps_completed_today_servicetype', function (e) {
  e.preventDefault();

  // Show modal
  $("#applicationsModalCompletedToday").modal("show");

  // Prepare date info
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${day} ${months[monthIndex]} ${year}`;

  // Extract data
  const regional_code = $('#today_region_id').val();
  const service_type = $(this).data('id');
    const compregionNAme = $(this).data('rg');


  // Title (uppercase)
  const title = `${service_type} COMPLETED TODAY (${formattedDate}) FROM ${compregionNAme}`.toUpperCase();
  document.getElementById('applicationsModalLabelCompletedToday').innerHTML = title;

  // Destroy any existing DataTable
  $('#view_applications_completed_today_by_service_type').DataTable().clear().destroy();

  // AJAX Request
  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: 'director_report_dashboard_completed_today_by_service_type',
      region_id: regional_code,
      service_type: service_type
    },
    cache: false,
    success: function (response) {
      const json_result = JSON.parse(response);
      console.log(json_result);

      // Handle no data case
      if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
        console.log("No data found");
        $('#view_applications_completed_today_by_service_type').DataTable().clear().destroy();
        $('#view_applications_completed_today_by_service_type').html(`
          <tr>
            <td colspan="7" class="text-center text-muted">
              No applications completed today for this service type.
            </td>
          </tr>
        `);
        return;
      }

      // Sort results by turnaround_days descending
      json_result.apps_at_division.sort((a, b) => b.turnaround_days - a.turnaround_days);

      const dataSet7 = json_result.apps_at_division.map(app => {
        const action = `
          <div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
            </button>
            <div class="dropdown-menu">
              <button type="button" class="dropdown-item"
                id="btn_cabinet"
                data-target-id="${app.job_number}"
                data-toggle="modal"
                data-target="#cabinetModal">
                Track <i class="fas fa-hdd"></i>
              </button>
              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" value="${app.transaction_number}">
                <input type="hidden" name="search_text" value="${app.case_number}">
                <input type="hidden" name="job_number" value="${app.job_number}">
                <input type="hidden" name="business_process_sub_name" value="${app.business_process_name}">
                <button type="submit" name="save" class="dropdown-item">
                  Application Details <i class="fas fa-info-circle"></i>
                </button>
              </form>
            </div>
          </div>
        `;

        return [
          app.job_number,
          app.ar_name,
          app.business_process_name,
          app.created_date,
          app.completed_date,
          app.turnaround_days,
          action
        ];
      });

      // Initialize DataTable
      $('#view_applications_completed_today_by_service_type').DataTable({
        data: dataSet7,
        dom: 'Bfrtip',
        order: [[5, 'desc']], // sort by turnaround days descending
        lengthMenu: [
          [10, 25, 50, -1],
          ['10 rows', '25 rows', '50 rows', 'Show all']
        ],
        buttons: [
          { extend: 'copy', title: title },
          { extend: 'csv', title: title },
          { extend: 'excel', title: title },
          { extend: 'pdf', title: title },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(`
                  <h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                  <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                    This report is generated using the Enterprise Land Information System
                  </p>
                `)
                .css('font-size', '19px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '19px')
                .css('width', '100%');
            }
          },
          { extend: 'colvis', text: 'Show / Hide Columns' },
          'pageLength'
        ]
      }).draw();
    }
  });
});




$('#apps_completed_month_division').on('click', function(e) {
  e.preventDefault();

  $("#regionsModal").modal("show");  
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',  
    'July', 'August', 'September', 'October', 'November', 'December'
  ];        const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${months[monthIndex]}`;
  
  
      var division = $('#director_division').val();
  
      var title  = division+"'"+'s'+" "+"Applications Completed This Month"+" "+formattedDate;
  
      document.getElementById('regionsModalLabel').innerHTML = title;
  
      
     //console.log(regional_code,division);
  
      $.ajax({
          type : "POST",
          url : "director_dashboard",
          data : { 
              request_type : 'director_report_dashboard_completed_month_by_regions',
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
  
    $('#region_table').DataTable().clear().destroy();
  
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
  
          let region = json_result.apps_at_division[i].region;
          let total = json_result.apps_at_division[i].total;
          // let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].region_code}" data-regionname ="${json_result.apps_at_division[i].region}"  id="view_completed_month_by_region"  
          // class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          let action = `
          <a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].region_code}" data-regionname ="${json_result.apps_at_division[i].region}"  id="view_completed_month_by_region"  
             class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
              <i class="fa fa-info-circle"></i>Details
          </a>`;


  
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          html.push(region);
          html.push(total);
          html.push(action);
  
          dataSet1.push(html);
  
        ///console.log(dataSet1)
        }
  
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
  
        $('#region_table').DataTable().clear().destroy();
                      
        $('#region_table').DataTable({ data: dataSet1,
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





$(document).on('click','#view_completed_month_by_region',function(e){
  e.preventDefault();
 
  $("#completedMonthserviceTypeModal").modal("show");  
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',  
    'July', 'August', 'September', 'October', 'November', 'December'
  ];      const currentDate = new Date();
  const day = currentDate.getDate();
  const monthIndex = currentDate.getMonth();
  const year = currentDate.getFullYear();
  const formattedDate = `${months[monthIndex]}`;
  
  
      var regional_code=$(this).data('id');
      var regional_name=$(this).data('regionname');



      $("#today_region_id").val(regional_code);


      // today_region_id


      var division = $('#director_division').val();
  
      var title  = regional_name+"'"+'s'+" "+"Applications Completed Month"+" "+formattedDate;
    
      document.getElementById('completedMonthserviceTypeModalLabel').innerHTML = title;

  
      
     //console.log(regional_code,division);
  
     $.ajax({
      type : "POST",
      url : "director_dashboard",
      data : { 
          request_type : 'director_report_dashboard_completed_month_by_division',
          region_id : regional_code,
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
      // let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}"  id="apps_completed_month_servicetype"  
      // class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      let action = `
      <a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}"  id="apps_completed_month_servicetype"  
         class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
          <i class="fa fa-info-circle"></i>Details
      </a>`;


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

  


});








$(document).on('click','#apps_completed_month_servicetype',function(e){
  e.preventDefault();
 
$("#applicationsModalCompletedMonth").modal("show");  


const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${months[monthIndex]}`;


  var regional_code = $('#today_region_id').val();
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
     url : "director_dashboard",
     data : {
         request_type : 'director_report_dashboard_completed_month_by_service_type',
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
   let action = ` <div class="btn-group" role="group">
   <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
     Actions
   </button>
   <div class="dropdown-menu">
   <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
           <input type="hidden" name="case_number" id="case_number" value="${json_result.apps_at_division[i].transaction_number}">
           <input type="hidden" name="search_text" id="search_text" value="${json_result.apps_at_division[i].case_number}">
           <input type="hidden" name="job_number" id="job_number" value=""${json_result.apps_at_division[i].job_number}">
           <input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value=""${json_result.apps_at_division[i].case_number}">
           <button type="submit" name="save" class="dropdown-item" >Application Details <i class="fas fa-info-circle"></i></button>
         </form> 
   </div>
 </div`;
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

  var Region_name = $(this).data("type");
  var users_division = $(this).data("regdivision");
  var regioncode = $(this).data("regcode");

  $("#director_regional_code").val(regioncode);
  var regional_code = $("#director_regional_code").val();

  console.log(users_division, regioncode);

  // Get date range from inputs
  let startDate = $("#start_date").val();
  let endDate = $("#end_date").val();
  let newdatestart = $('#startdate').val();
    let  newdateend = $('#enddate').val();



  // Format title (uppercase and includes date range)
  var title = (
    Region_name +
    "'S APPLICATIONS PAST DUE FROM " +
    newdatestart +
    " TO " +
    newdateend
  ).toUpperCase();

  // Set modal header
  document.getElementById("divisionLabelCompletedYear").innerHTML = title;

  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: "director_compliance_apps_pastdue_units",
      region_id: regional_code.trim(),
      division: users_division,
      date_from: startDate,
      date_to: endDate,
    },
    cache: false,
    success: function (response) {
      var json_result = JSON.parse(response);
      console.log(json_result.apps_at_division_unit);

      if (!json_result.apps_at_division_unit || json_result.apps_at_division_unit.length === 0) {
        console.log("No data found");
        return;
      }

      let dataSet15 = [];
      let num15 = 0;

      $("#apps_past_due_unit").DataTable().clear().destroy();

      for (let i = 0; i < json_result.apps_at_division_unit.length; i++) {
        num15 += 1;
        let unit = json_result.apps_at_division_unit[i].unit_name;
        let total = json_result.apps_at_division_unit[i].total;

        let action = `
          <a href="javascript:void(0)" 
             data-id="${json_result.apps_at_division_unit[i].unit_id}" 
             data-name="${json_result.apps_at_division_unit[i].unit_name}"  
             id="view_apps_pastdue_within_units"  
             class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
              <i class="fa fa-info-circle"></i> Details
          </a>`;

        dataSet15.push([unit, total, action]);
      }

      // Initialize DataTable with export buttons and custom print header
      $("#apps_past_due_unit").DataTable({
        data: dataSet15,
        dom: "Bfrtip",
        lengthMenu: [
          [10, 25, 50, -1],
          ["10 rows", "25 rows", "50 rows", "Show all"],
        ],
        buttons: [
          {
            extend: "copy",
            title: title,
          },
          {
            extend: "csv",
            title: title,
          },
          {
            extend: "excel",
            title: title,
          },
          {
            extend: "pdf",
            title: title,
          },
          {
            extend: "print",
            text: "Print",
            title: "",
            customize: function (win) {
              $(win.document.body)
                .prepend(
                  `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                   <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                   This report is generated using the Enterprise Land Information System
                   </p>`
                )
                .css("font-size", "19px");

              $(win.document.body)
                .find("table")
                .addClass("compact")
                .css("font-size", "19px")
                .css("width", "100%");
            },
          },
          {
            extend: "colvis",
            text: "Show / Hide Columns",
          },
          "pageLength",
        ],
      }).draw();
    },
  });
});






$(document).on("click", "#view_apps_pastdue_within_units", function (e) {
  e.preventDefault();

  $("#officerModal").modal("show");

  // Get dates from inputs
  let startDate = $("#start_date").val();
  let endDate = $("#end_date").val();
  let newdatestart = $('#startdate').val();
    let  newdateend = $('#enddate').val();

  // Get region, division, and unit details
  let regional_code = $("#director_regional_code").val();
  let users_division = $("#director_division").val();
  let unit_id = $(this).data("id");
  let name = $(this).data("name");

  console.log(unit_id, regional_code, users_division);

  // Build uppercase title with date range
  let title = (
    name +
    "'S APPLICATIONS PAST DUE FROM " +
    newdatestart +
    " TO " +
    newdateend
  ).toUpperCase();

  // Apply title to modal header
  document.getElementById("officerModalLabel").innerHTML = title;

  // Initialize DataTable setup
  let dataSet16 = [];
  let num16 = 0;
  $("#past_due_officers_table").DataTable().clear().destroy();

  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: "director_compliance_apps_pastdue_within_unit",
      region_id: regional_code,
      division: users_division,
      unit: name,
      date_from: startDate,
      date_to: endDate,
    },
    cache: false,
    success: function (response) {
      let json_result = JSON.parse(response);
      console.log(json_result);

      if (
        !json_result.apps_at_unit ||
        json_result.apps_at_unit.length === 0
      ) {
        console.log("No data found");
        return;
      }

      // Build dataset
      for (let i = 0; i < json_result.apps_at_unit.length; i++) {
        num16 += 1;
        let staff = json_result.apps_at_unit[i].staff;
        let total = json_result.apps_at_unit[i].total;

        let action = `
          <a href="javascript:void(0)" 
             id="past_due_apps"  
             data-id="${json_result.apps_at_unit[i].staff_id}"  
             data-name="${json_result.apps_at_unit[i].staff}"
             class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
              <i class="fa fa-info-circle"></i> Details
          </a>`;

        dataSet16.push([staff, total, action]);
      }

      // Initialize DataTable with export buttons and print header
      $("#past_due_officers_table")
        .DataTable({
          data: dataSet16,
          dom: "Bfrtip",
          lengthMenu: [
            [10, 25, 50, -1],
            ["10 rows", "25 rows", "50 rows", "Show all"],
          ],
          buttons: [
            {
              extend: "copy",
              title: title,
            },
            {
              extend: "csv",
              title: title,
            },
            {
              extend: "excel",
              title: title,
            },
            {
              extend: "pdf",
              title: title,
            },
            {
              extend: "print",
              text: "Print",
              title: "",
              customize: function (win) {
                $(win.document.body)
                  .prepend(
                    `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                     <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                     This report is generated using the Enterprise Land Information System
                     </p>`
                  )
                  .css("font-size", "19px");

                $(win.document.body)
                  .find("table")
                  .addClass("compact")
                  .css("font-size", "19px")
                  .css("width", "100%");
              },
            },
            {
              extend: "colvis",
              text: "Show / Hide Columns",
            },
            "pageLength",
          ],
        })
        .draw();
    },
  });
});








$(document).on("click", "#past_due_apps", function (e) {
  e.preventDefault();

  $("#past_due_apps_modal").modal("show");

  // Get date inputs
  let startDate = $("#start_date").val();
  let endDate = $("#end_date").val();
  let newdatestart = $("#startdate").val();
  let newdateend = $("#enddate").val();

  // Get staff and context info
  let staff_id = $(this).data("id");
  let staff_name = $(this).data("name");
  let users_division = $("#director_division").val();
  let regional_code = $("#director_regional_code").val();

  console.log(staff_id, regional_code, users_division);

  // Build uppercase title with date range
  let title = (
    staff_name +
    "'S APPLICATIONS PAST DUE FROM " +
    newdatestart +
    " TO " +
    newdateend
  ).toUpperCase();

  // Set modal title
  document.getElementById("past_due_apps_Label").innerHTML = title;

  // Initialize DataTable setup
  let dataSet17 = [];
  let num17 = 0;
  $("#past_due_apps_with_staff").DataTable().clear().destroy();

  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: "director_compliance_apps_pastdue_with_officer",
      staff_id: staff_id,
      division: users_division,
      region_code: regional_code,
      date_from: startDate,
      date_to: endDate,
    },
    cache: false,
    success: function (response) {
      let json_result = JSON.parse(response);
      console.log(json_result);

      if (
        !json_result.apps_with_staff ||
        json_result.apps_with_staff.length === 0
      ) {
        console.log("No data found");
        return;
      }

      let jobNumbers = [];

      for (let i = 0; i < json_result.apps_with_staff.length; i++) {
        num17 += 1;
        let app = json_result.apps_with_staff[i];

        jobNumbers.push(app.job_number);
         let checkbox = `
    <input type="checkbox" class="app-checkbox form-check-input" value="${app.job_number}">
  `;

        let action = `
          <div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
            </button>
            <div class="dropdown-menu">
                  <button type="button" class="dropdown-item" href="#" id="btn_cabinet" data-staff_name="" data-staff_id="" data-job_number="" title="View Application Progress" data-target-id="${app.job_number}" data-target="#cabinetModal" data-toggle="modal">Track <i class="fas fa-hdd"></i></button>
              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" value="${app.transaction_number}">
                <input type="hidden" name="search_text" value="${app.case_number}">
                <input type="hidden" name="job_number" value="${app.job_number}">
                <input type="hidden" name="business_process_sub_name" value="${app.case_number}">
                <button type="submit" name="save" class="dropdown-item">
                  Application Details <i class="fas fa-info-circle"></i>
                </button>
              </form> 
              <button type="button" class="dropdown-item" data-staff_name="${staff_name}" data-staff_id="${staff_id}" data-job_number="${app.job_number}" data-target="#sendMessageModal_FocalCompliance" data-toggle="modal">
                Send Message
              </button>
            </div>
          </div>`;

        dataSet17.push([
          checkbox,
          app.job_number,
          app.ar_name,
          app.created_date,
           app.days_due,
          app.due_date,
          app.days_since_batched,
          app.job_status,
          action,
        ]);
      }

      // Generate Send Message Button
      let jobNumbersString = jobNumbers.join(",");
      let pdfBtn = `
        <button class="sendMessage btn btn-primary ml-auto" 
                id="send_message" 
                data-staffid="${staff_id}" 
                data-staff="${staff_name}" 
                data-jobnumber="${jobNumbersString}" 
                type="button">
          Send Message
        </button>`;
      document.getElementById("sendmsg").innerHTML = pdfBtn;

      // Initialize DataTable with full export + print formatting
      $("#past_due_apps_with_staff")
        .DataTable({
          data: dataSet17,
          dom: "Bfrtip",
          lengthMenu: [
            [10, 25, 50, -1],
            ["10 rows", "25 rows", "50 rows", "Show all"],
          ],
          buttons: [
            {
              extend: "copy",
              title: title,
            },
            {
              extend: "csv",
              title: title,
            },
            {
              extend: "excel",
              title: title,
            },
            {
              extend: "pdf",
              title: title,
            },
            {
              extend: "print",
              text: "Print",
              title: "",
              customize: function (win) {
                $(win.document.body)
                  .prepend(
                    `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                     <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                     This report is generated using the Enterprise Land Information System
                     </p>`
                  )
                  .css("font-size", "19px");

                $(win.document.body)
                  .find("table")
                  .addClass("compact")
                  .css("font-size", "19px")
                  .css("width", "100%");
              },
            },
            {
              extend: "colvis",
              text: "Show / Hide Columns",
            },
            "pageLength",
          ],
        })
        .draw();
    },
  });
});





$(document).on("click", ".showServiceTypeModal_apps_with_divisions", function (event) {
  event.preventDefault();

  $("#unitModal").modal("show");

  // Date values
  let startDate = $("#start_date").val();
  let endDate = $("#end_date").val();
  let newdatestart = $("#startdate").val();
  let newdateend = $("#enddate").val();

  // Region and division info
  let Region_name = $(this).data("type");
  let users_division = $(this).data("regdivision");
  let regioncode = $(this).data("regcode");

  $("#director_regional_code").val(regioncode);
  let regional_code = $("#director_regional_code").val();

  console.log(users_division, regional_code);

  // Build uppercase title with date range
  let title = (
    Region_name +
    "'S APPLICATIONS WITH " + "UNITS " + "FROM " +
    newdatestart +
    " TO " +
    newdateend
  ).toUpperCase();

  document.getElementById("divisionLabelCompletedYear").innerHTML = title;

  // AJAX request
  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: "director_compliance_apps_with_division_units",
      region_id: regional_code.trim(),
      division: users_division,
      date_from: startDate,
      date_to: endDate,
    },
    cache: false,
    success: function (response) {
      let json_result = JSON.parse(response);
      console.log(json_result.apps_at_division_unit);

      if (!json_result.apps_at_division_unit || json_result.apps_at_division_unit.length === 0) {
        console.log("No data found");
        return;
      }

      let dataSet15 = [];
      let num15 = 0;

      $("#apps_past_due_unit").DataTable().clear().destroy();

      for (let i = 0; i < json_result.apps_at_division_unit.length; i++) {
        num15++;

        let unit = json_result.apps_at_division_unit[i].unit_name;
        let total = json_result.apps_at_division_unit[i].total;

        let action = `
          <a href="javascript:void(0)" 
             data-id="${json_result.apps_at_division_unit[i].unit_id}" 
             data-name="${json_result.apps_at_division_unit[i].unit_name}"  
             data-reg="${Region_name}"
             id="view_apps_withdivision_within_units"
             class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
            <i class="fa fa-info-circle"></i> Details
          </a>`;

        dataSet15.push([unit, total, action]);
      }

      // Initialize DataTable with export buttons
      $("#apps_past_due_unit")
        .DataTable({
          data: dataSet15,
          dom: "Bfrtip",
          lengthMenu: [
            [10, 25, 50, -1],
            ["10 rows", "25 rows", "50 rows", "Show all"],
          ],
          buttons: [
            {
              extend: "copy",
              title: title,
            },
            {
              extend: "csv",
              title: title,
            },
            {
              extend: "excel",
              title: title,
            },
            {
              extend: "pdf",
              title: title,
            },
            {
              extend: "print",
              text: "Print",
              title: "",
              customize: function (win) {
                $(win.document.body)
                  .prepend(
                    `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                     <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                       This report is generated using the Enterprise Land Information System
                     </p>`
                  )
                  .css("font-size", "19px");

                $(win.document.body)
                  .find("table")
                  .addClass("compact")
                  .css("font-size", "19px")
                  .css("width", "100%");
              },
            },
            {
              extend: "colvis",
              text: "Show / Hide Columns",
            },
            "pageLength",
          ],
        })
        .draw();
    },
  });
});







$(document).on("click", "#view_apps_withdivision_within_units", function (e) {
  e.preventDefault();

  $("#officerModal").modal("show");

  // Get date values
  let startDate = $("#start_date").val();
  let endDate = $("#end_date").val();
  let newdatestart = $("#startdate").val();
  let newdateend = $("#enddate").val();

  // Get region and division info
  let regional_code = $("#director_regional_code").val();
  let unit_id = $(this).data("id");
  let name = $(this).data("name");
  let regName = $(this).data("reg");

  
  let users_division = $("#director_division").val();

  console.log("Unit ID:", unit_id, "Region:", regional_code, "Division:", users_division);

  // Build uppercase title with date range
  let title = (
   regName + " "+ name +
    "'S APPLICATIONS WITH " + " " + "OFFICERS FROM " +
    newdatestart +
    " TO " +
    newdateend
  ).toUpperCase();

  document.getElementById("officerModalLabel").innerHTML = title;

  // Prepare DataTable
  $("#past_due_officers_table").DataTable().clear().destroy();

  // AJAX request
  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: "director_compliance_apps_withdivision_within_unit",
      region_id: regional_code,
      division: users_division,
      unit: name,
      date_from: startDate,
      date_to: endDate,
    },
    cache: false,
    success: function (response) {
      let json_result = JSON.parse(response);
      console.log(json_result);

      if (!json_result.apps_at_unit || json_result.apps_at_unit.length === 0) {
        console.log("No data found");
        return;
      }

      let dataSet16 = [];
      let num16 = 0;

      // Build rows
      for (let i = 0; i < json_result.apps_at_unit.length; i++) {
        num16++;

        let staff = json_result.apps_at_unit[i].staff;
        let total = json_result.apps_at_unit[i].total;

        let action = `
          <a href="javascript:void(0)" 
             id="division_apps"
             data-id="${json_result.apps_at_unit[i].staff_id}" 
             data-name="${json_result.apps_at_unit[i].staff}" 
             data-reg="${regName}"
             class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
            <i class="fa fa-info-circle"></i> Details
          </a>`;

        dataSet16.push([staff, total, action]);
      }

      // Initialize DataTable
      $("#past_due_officers_table")
        .DataTable({
          data: dataSet16,
          dom: "Bfrtip",
          lengthMenu: [
            [10, 25, 50, -1],
            ["10 rows", "25 rows", "50 rows", "Show all"],
          ],
          buttons: [
            {
              extend: "copy",
              title: title,
            },
            {
              extend: "csv",
              title: title,
            },
            {
              extend: "excel",
              title: title,
            },
            {
              extend: "pdf",
              title: title,
            },
            {
              extend: "print",
              text: "Print",
              title: "",
              customize: function (win) {
                $(win.document.body)
                  .prepend(
                    `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                     <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                       This report is generated using the Enterprise Land Information System
                     </p>`
                  )
                  .css("font-size", "19px");

                $(win.document.body)
                  .find("table")
                  .addClass("compact")
                  .css("font-size", "19px")
                  .css("width", "100%");
              },
            },
            {
              extend: "colvis",
              text: "Show / Hide Columns",
            },
            "pageLength",
          ],
        })
        .draw();
    },
  });
});





$(document).on("click", "#division_apps", function (e) {
  e.preventDefault();

  $("#past_due_apps_modal").modal("show");

  // Get date inputs
  let startDate = $("#start_date").val();
  let endDate = $("#end_date").val();
  let newdatestart = $("#startdate").val();
  let newdateend = $("#enddate").val();

  // Get staff and region info
  let staff_id = $(this).data("id");
  let staff_name = $(this).data("name");
    let regName = $(this).data("reg");

  let users_division = $("#director_division").val();
  let regional_code = $("#director_regional_code").val();

  console.log("Staff:", staff_id, staff_name, "Division:", users_division, "Region:", regional_code);

  // Uppercase title with date range
  let title = (
    staff_name + " "+ regName + " "+
    "APPLICATIONS FROM " +
    newdatestart +
    " TO " +
    newdateend
  ).toUpperCase();

  document.getElementById("past_due_apps_Label").innerHTML = title;

  // Initialize DataTable
  $("#past_due_apps_with_staff").DataTable().clear().destroy();

  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: "director_compliance_apps_withdivision_with_officer",
      staff_id: staff_id,
      division: users_division,
      region_code: regional_code,
      date_from: startDate,
      date_to: endDate,
    },
    cache: false,
    success: function (response) {
      let json_result = JSON.parse(response);
      console.log(json_result.apps_with_staff);

      if (!json_result.apps_with_staff || json_result.apps_with_staff.length === 0) {
        console.log("No data found");
        return;
      }

      let dataSet17 = [];
      let jobNumbers = [];

      for (let i = 0; i < json_result.apps_with_staff.length; i++) {
        let app = json_result.apps_with_staff[i];


 let checkbox = `
    <input type="checkbox" class="app-checkbox form-check-input" value="${app.job_number}">
  `;

        let job_number = app.job_number;
        let ar_name = app.ar_name;
        let business_process_name = app.business_process_name;
        let created_date = app.created_date;
        let due_date = app.due_date;
        let days_due = app.days_due;
        let days_since_batched = app.days_since_batched;
        let job_status = app.job_status;

        let action = `
          <div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
            </button>
            <div class="dropdown-menu">

      <button type="button" class="dropdown-item" href="#" id="btn_cabinet" data-staff_name="" data-staff_id="" data-job_number="" title="View Application Progress" data-target-id="${app.job_number}" data-target="#cabinetModal" data-toggle="modal">Track <i class="fas fa-hdd"></i></button>

              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" value="${app.transaction_number}">
                <input type="hidden" name="search_text" value="${app.case_number}">
                <input type="hidden" name="job_number" value="${app.job_number}">
                <input type="hidden" name="business_process_sub_name" value="${app.case_number}">
                <button type="submit" name="save" class="dropdown-item">
                  Application Details <i class="fas fa-info-circle"></i>
                </button>
              </form>
              <button type="button" class="dropdown-item"
                data-staff_name="${staff_name}"
                data-staff_id="${staff_id}"
                data-job_number="${job_number}"
                data-target="#sendMessageModal_FocalCompliance"
                data-toggle="modal">
                Send Message
              </button>
            </div>
          </div>`;

        dataSet17.push([
          checkbox,
          job_number,
          ar_name,
          created_date,
          days_due,
          due_date,
          days_since_batched,
          job_status,
          action,
        ]);

        jobNumbers.push(job_number);
      }

      // Add Send Message button dynamically
      let jobNumbersString = jobNumbers.join(",");
      let pdfBtn = `
        <button class="sendMessage btn btn-primary ml-auto" 
          id="send_message" 
          data-staffid="${staff_id}" 
          data-staff="${staff_name}" 
          data-jobnumber="${jobNumbersString}" 
          type="button">
          Send Message
        </button>`;
      document.getElementById("sendmsg").innerHTML = pdfBtn;

      // Initialize DataTable with export buttons
      $("#past_due_apps_with_staff")
        .DataTable({
          data: dataSet17,
          dom: "Bfrtip",
          lengthMenu: [
            [10, 25, 50, -1],
            ["10 rows", "25 rows", "50 rows", "Show all"],
          ],
          buttons: [
            {
              extend: "copy",
              title: title,
            },
            {
              extend: "csv",
              title: title,
            },
            {
              extend: "excel",
              title: title,
            },
            {
              extend: "pdf",
              title: title,
            },
            {
              extend: "print",
              text: "Print",
              title: "",
              customize: function (win) {
                $(win.document.body)
                  .prepend(
                    `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                     <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                       This report is generated using the Enterprise Land Information System
                     </p>`
                  )
                  .css("font-size", "19px");

                $(win.document.body)
                  .find("table")
                  .addClass("compact")
                  .css("font-size", "19px")
                  .css("width", "100%");
              },
            },
            {
              extend: "colvis",
              text: "Show / Hide Columns",
            },
            "pageLength",
          ],
        })
        .draw();
    },
  });
});










// $(document).on("click", "#btn_status", function (e) {
//   e.preventDefault();

//       let jobNumber = $(this).data('id');

//   // $("#past_due_apps_modal").modal("show");
//   $.ajax({
//     type: "POST",
//     url: "director_dashboard",
//     data: {
//       request_type: "select_application_stages_by_job_number",
//       job_number: jobNumber
//     },
//     cache: false,
//     success: function (response) {
//       let json_result = JSON.parse(response);
//       console.log(json_result);


//                   if (json_result.success && json_result.cabinet_tracking && json_result.cabinet_tracking.length > 0) {
//                 let timelineHtml = '';
//                 json_result.cabinet_tracking.forEach(item => {
//                     timelineHtml += `
//                       <div class="timeline-item">
//                         <div class="timeline-header">
//                           ${item.division} — ${item.divisional_registry_unit}
//                         </div>
//                         <div class="timeline-body">
//                           <p><strong>Officer:</strong> ${item.created_by}</p>
//                           <p><strong>Comment:</strong> ${item.officers_general_comments}</p>
//                           <p><strong>Date:</strong> ${item.created_date}</p>
//                           <p><strong>Days Spent:</strong> ${item.days_spent || 'N/A'}</p>
//                         </div>
//                       </div>
//                     `;
//                 });
//                 $("#stagesTrackingContainer").html(timelineHtml);
//             } else {
//                 $("#stagesTrackingContainer").html('<div class="text-center text-danger mt-3">No tracking data found.</div>');
//             }

 
//     },
//   });
// });



$(document).on("click", "#btn_status", function (e) {
  e.preventDefault();

  let jobNumber = $(this).data("id");

  $("#stagesModal").modal("show");
  $("#stagesTrackingContainer").html(
    '<div class="text-center text-muted mt-3">Loading tracking details...</div>'
  );

  $.ajax({
    type: "POST",
    url: "director_dashboard",
    data: {
      request_type: "select_application_stages_by_job_number",
      job_number: jobNumber,
    },
    cache: false,
    success: function (response) {
      console.log("Raw response:", response);

      try {
        let json_result = JSON.parse(response);

        if (
          json_result.success &&
          json_result.cabinet_tracking &&
          json_result.cabinet_tracking.length > 0
        ) {
          let tracking = json_result.cabinet_tracking;
          let timelineHtml = `
            <div class="timeline">
          `;

          tracking.forEach((item, i) => {
            let statusClass = i === 0
              ? "completed"
              : i === tracking.length - 1
              ? "active"
              : "pending";

            timelineHtml += `
              <div class="timeline-item ${statusClass}">
                <div class="timeline-icon">
                  <i class="fas fa-check"></i>
                </div>
                <div class="timeline-content p-3">
                  <h6 class="mb-1"> ${item.divisional_registry_unit || "N/A"}</h6>
                  <p class="mb-1">${item.officers_general_comments || "No Comment"}</p>
                  <small class="text-muted d-block"><strong>Officer:</strong> ${item.created_by || "N/A"}</small>
                  <small class="text-muted d-block"><strong>Date:</strong> ${item.created_date}</small>
                  <small class="text-muted"><strong>Days Spent:</strong> ${item.days_spent || "N/A"}</small>
                </div>
              </div>
            `;
          });

          timelineHtml += `</div>`;
          $("#stagesTrackingContainer").html(timelineHtml);
        } else {
          $("#stagesTrackingContainer").html(
            `<div class="alert alert-warning text-center">No tracking data found</div>`
          );
        }
      } catch (error) {
        console.error("Error parsing JSON:", error);
        $("#stagesTrackingContainer").html(
          `<div class="alert alert-danger text-center">Invalid server response</div>`
        );
      }
    },
    error: function () {
      $("#stagesTrackingContainer").html(
        `<div class="alert alert-danger text-center">Server error. Try again!</div>`
      );
    },
  });
});






// $(document).on('click', '#btn_status', function() {
//     let jobNumber = $(this).data('id');

//     console.log(jobNumber);
//     // $("#stagesTrackingContainer").html('<div class="text-center text-muted mt-3">Loading tracking details...</div>');


//     $.ajax({
//     type: "POST",
//     url: "director_dashboard",
//     data: {
//  request_type: "select_application_stage_details_by_job_number",
//        job_number: jobNumber
//     },
//     cache: false,
//     success: function (response) {
//     //   $.ajax({
//     // type: "POST",
//     // url: "director_dashboard",
//     // data: {
//     //   request_type: "select_application_stage_details_by_job_number",
//     //   data: JSON.stringify({ job_number: jobNumber }),

//     // },
//     // cache: false,
//     // success: function (response) {
//           console.log(response);

//             if (response.success && response.cabinet_tracking && response.cabinet_tracking.length > 0) {
//                 let timelineHtml = '';
//                 response.cabinet_tracking.forEach(item => {
//                     timelineHtml += `
//                       <div class="timeline-item">
//                         <div class="timeline-header">
//                           ${item.division} — ${item.divisional_registry_unit}
//                         </div>
//                         <div class="timeline-body">
//                           <p><strong>Officer:</strong> ${item.created_by}</p>
//                           <p><strong>Comment:</strong> ${item.officers_general_comments}</p>
//                           <p><strong>Date:</strong> ${item.created_date}</p>
//                           <p><strong>Days Spent:</strong> ${item.days_spent || 'N/A'}</p>
//                         </div>
//                       </div>
//                     `;
//                 });
//                 $("#stagesTrackingContainer").html(timelineHtml);
//             } else {
//                 $("#stagesTrackingContainer").html('<div class="text-center text-danger mt-3">No tracking data found.</div>');
//             }

 
          
//         },
//         error: function() {
//             $("#cabinetTrackingContainer").html('<div class="text-center text-danger mt-3">Failed to load data.</div>');
//         }
//     });
  
// });



});