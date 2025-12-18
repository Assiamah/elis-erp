$(document).ready(function() {

    var startDate;
    var endDate;

    var startdate;
    var enddate;
    var totalApplications;
    var newdatestart;
    var newdateend;

  var  totalApplicationsSum ; 


    $('#sendMessageModal_FocalCompliance').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#staffapps_modal").css("z-index", "1029");
      })
      
      $('#sendMessageModal_FocalCompliance').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#staffapps_modal").css("z-index", "");
      })
  



    $('#sendMessageModal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#staffapps_modal").css("z-index", "1029");
      })
      
      $('#sendMessageModal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#staffapps_modal").css("z-index", "");
      })
  

    $('#sub_service_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#recieved_reporting_modal").css("z-index", "1029");
      })
      
      $('#sub_service_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#recieved_reporting_modal").css("z-index", "");
      })
  



    $('#apps_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#sub_service_modal").css("z-index", "1029");
      })
      
      $('#apps_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#sub_service_modal").css("z-index", "");
      })
  



        $('#cabinetModal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#apps_modal").css("z-index", "1029");
        $("#staffapps_modal").css("z-index", "1029");
       $("#completed_apps_modal").css("z-index", "1029");
       $("#sub_service_modal").css("z-index", "1029");

        

      })
      
      $('#cabinetModal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#apps_modal").css("z-index", "");
        $("#staffapps_modal").css("z-index", "");
        $("#completed_apps_modal").css("z-index", "");
        $("#sub_service_modal").css("z-index", "");
        


      })




        $('#regional_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#divisions_modal").css("z-index", "1029");
      })
      
      $('#regional_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#divisions_modal").css("z-index", "");
      })




        $('#regional_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#divisions_modal").css("z-index", "1029");
      })
      
      $('#regional_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#divisions_modal").css("z-index", "");
      })



        $('#units_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#regional_modal").css("z-index", "1029");
      })
      
      $('#units_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#regional_modal").css("z-index", "");
      })



       $('#officers_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#units_modal").css("z-index", "1029");
      })
      
      $('#officers_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#units_modal").css("z-index", "");
      })




       $('#staffapps_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#officers_modal").css("z-index", "1029");
      })
      
      $('#staffapps_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#officers_modal").css("z-index", "");
      })




    $('#cabinetModal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        // $("#apps_modal").css("z-index", "1029");
        $("#staffapps_modal").css("z-index", "1029");

      })
      
      $('#cabinetModal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        // $("#apps_modal").css("z-index", "");
        $("#staffapps_modal").css("z-index", "");

      })



     $('#regional_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        // $("#apps_modal").css("z-index", "1029");
        $("#status_modal").css("z-index", "1029");

      })
      
      $('#regional_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        // $("#apps_modal").css("z-index", "");
        $("#status_modal").css("z-index", "");

      })



     $('#regional_divisions_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        // $("#apps_modal").css("z-index", "1029");
        $("#regional_modal").css("z-index", "1029");

      })
      
      $('#regional_divisions_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        // $("#apps_modal").css("z-index", "");
        $("#regional_modal").css("z-index", "");

      })



       $('#recieved_reporting_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        // $("#apps_modal").css("z-index", "1029");
        $("#regional_divisions_modal").css("z-index", "1029");

      })
      
      $('#recieved_reporting_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        // $("#apps_modal").css("z-index", "");
        $("#regional_divisions_modal").css("z-index", "");

      })





        // $("#").modal("show");  


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




  $(document).on("click", ".sendMessage", function (event) {
  event.preventDefault();

  const table = $("#staffapps_table").DataTable();

  // ✅ Collect all selected rows using existing checkboxes
  const selectedRows = [];
  $(".app-checkbox:checked").each(function () {
    const row = $(this).closest("tr");
    const rowData = table.row(row).data();

    // Assuming DataTable columns: [checkbox, job_number, ar_name, ...]
    const jobNumber = rowData.job_number || rowData[1];
    const arName = rowData.ar_name || rowData[2];
    const pendingDays = rowData.days_due || rowData[5];

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


    // Store chart instances globally
let statusPieChart = null;
let monthlyTrendChart = null;
let regionalCompletedChart = null;
let regionalChartInstance = null;
let subServicesChart = null;


  const dateToPicker = flatpickr("#dateto", {
    dateFormat: "Y-m-d",
    altInput: true,
    altFormat: "j F Y",
    allowInput: true,
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

        let startDate = $('#start_date').val();
        let endDate = $('#end_date').val();


         newdatestart = $('#startdate').val();
        newdateend = $('#enddate').val();

        try {
            // 1️⃣ Run All Count
            let allCountRes = await loadAllCount(startDate, endDate);
            let json_result = JSON.parse(allCountRes);
            console.log(json_result);

            document.getElementById('app-received').innerHTML = json_result.received.toLocaleString();
            document.getElementById('app-pending').innerHTML = json_result.pending.toLocaleString();
            document.getElementById('app-received-completed').innerHTML = json_result.received_completed.toLocaleString();
            document.getElementById('app-pastdue').innerHTML = json_result.pastdue.toLocaleString();
            // document.getElementById('app-queried').innerHTML = json_result.queried.toLocaleString();
            document.getElementById('app-completed').innerHTML = json_result.completed.toLocaleString();
            
                        
            
            document.getElementById('alltime-app-received').innerHTML = json_result.all_received.toLocaleString();
            document.getElementById('alltime-app-completed').innerHTML = json_result.all_completed.toLocaleString();


            



              let allloadDivisionCount = await loadDivisionCount(startDate, endDate);
               let division_result = JSON.parse(allloadDivisionCount);
                // console.log("Division data:", division_result.divisionTotals);

                let lrdpendingPercent   = division_result.divisionTotals.LRD.pending_percent;
                let lrdcompletedPercent = division_result.divisionTotals.LRD.received_completed_percent;
                let pvlmdpendingPercent   = division_result.divisionTotals.PVLMD.pending_percent;
                let pvlmdcompletedPercent = division_result.divisionTotals.PVLMD.received_completed_percent;

                let smdpendingPercent   = division_result.divisionTotals.SMD.pending_percent;
                let smdcompletedPercent = division_result.divisionTotals.SMD.received_completed_percent;


                let lvdpendingPercent   = division_result.divisionTotals.LVD.pending_percent;
                let lvdcompletedPercent = division_result.divisionTotals.LVD.received_completed_percent;


           document.getElementById('pvlmdtotal_rec').innerHTML = division_result.divisionTotals.PVLMD.received.toLocaleString();
           document.getElementById('pvlmdtotal_pending').innerHTML = division_result.divisionTotals.PVLMD.pending.toLocaleString();
           document.getElementById('pvlmdtotal_completed').innerHTML = division_result.divisionTotals.PVLMD.received_completed.toLocaleString();


           document.getElementById('lrdtotal_rec').innerHTML = division_result.divisionTotals.LRD.received.toLocaleString();
           document.getElementById('lrdtotal_pending').innerHTML = division_result.divisionTotals.LRD.pending.toLocaleString();
           document.getElementById('lrdtotal_completed').innerHTML = division_result.divisionTotals.LRD.received_completed.toLocaleString();


           // Update progress bar widths
                let pendingBar = document.getElementById('lrdPendingBar');
                pendingBar.style.width = lrdpendingPercent + "%";
                pendingBar.setAttribute("aria-valuenow", lrdpendingPercent);
                pendingBar.textContent = lrdpendingPercent + "%";

                // Completed
                let completedBar = document.getElementById('lrdCompletedBar');
                completedBar.style.width = lrdcompletedPercent + "%";
                completedBar.setAttribute("aria-valuenow", lrdcompletedPercent);
                completedBar.textContent = lrdcompletedPercent + "%";



                 let pvlmdpendingBar = document.getElementById('pvlmdPendingBar');
                pvlmdpendingBar.style.width = pvlmdpendingPercent + "%";
                pvlmdpendingBar.setAttribute("aria-valuenow", pvlmdpendingPercent);
                pvlmdpendingBar.textContent = pvlmdpendingPercent + "%";

                // Completed
                let pvlmdcompletedBar = document.getElementById('pvlmdCompletedBar');
                pvlmdcompletedBar.style.width = pvlmdcompletedPercent + "%";
                pvlmdcompletedBar.setAttribute("aria-valuenow", pvlmdcompletedPercent);
                pvlmdcompletedBar.textContent = pvlmdcompletedPercent + "%";




                 let lvdpendingBar = document.getElementById('lvdPendingBar');
                lvdpendingBar.style.width = lvdpendingPercent + "%";
                lvdpendingBar.setAttribute("aria-valuenow", lvdpendingPercent);
                lvdpendingBar.textContent = lvdpendingPercent + "%";

                // Completed
                let lvdcompletedBar = document.getElementById('lvdCompletedBar');
                lvdcompletedBar.style.width = lvdcompletedPercent + "%";
                lvdcompletedBar.setAttribute("aria-valuenow", lvdcompletedPercent);
                lvdcompletedBar.textContent = lvdcompletedPercent + "%";




                let smdpendingBar = document.getElementById('smdPendingBar');
                smdpendingBar.style.width = smdpendingPercent + "%";
                smdpendingBar.setAttribute("aria-valuenow", smdpendingPercent);
                smdpendingBar.textContent = smdpendingPercent + "%";

                // Completed
                let smdcompletedBar = document.getElementById('smdCompletedBar');
                smdcompletedBar.style.width = smdcompletedPercent + "%";
                smdcompletedBar.setAttribute("aria-valuenow", smdcompletedPercent);
                smdcompletedBar.textContent = smdcompletedPercent + "%";




           document.getElementById('smdtotal_rec').innerHTML = division_result.divisionTotals.SMD.received.toLocaleString();
           document.getElementById('smdtotal_pending').innerHTML = division_result.divisionTotals.SMD.pending.toLocaleString();
           document.getElementById('smdtotal_completed').innerHTML = division_result.divisionTotals.SMD.received_completed.toLocaleString();


            document.getElementById('lvdtotal_rec').innerHTML = division_result.divisionTotals.LVD.received.toLocaleString();
           document.getElementById('lvdtotal_pending').innerHTML = division_result.divisionTotals.LVD.pending.toLocaleString();
           document.getElementById('lvdtotal_completed').innerHTML = division_result.divisionTotals.LVD.received_completed.toLocaleString();



        //    document.getElementById('pvlmdtotal_queried').innerHTML = division_result.divisionTotals.PVLMD.queried.toLocaleString(); 



                
                                    // pvlmdtotal_pending
                                    // pvlmdtotal_completed

            // 2️⃣ Run Charts request
            let chartRes = await loadCharts(startDate, endDate);
            let jsonresult = JSON.parse(chartRes);
            // console.log("Charts data:", jsonresult);

            /* ============================
               STATUS PIE CHART
            ============================ */
            const pieCanvas = document.getElementById('statusPieChart');
            const pieCtx = pieCanvas.getContext('2d');
            
            // Destroy previous chart if exists
            if (statusPieChart) {
                statusPieChart.destroy();
                pieCtx.clearRect(0, 0, pieCanvas.width, pieCanvas.height);
            }

            const statusData = jsonresult.statusPieChart || {};
            const pieChartData = {
                labels: ['Received', 'Pending', 'Completed', 'Queried'],
                datasets: [{
                    data: [
                        statusData.received || 0,
                        statusData.pending || 0,
                        statusData.completed || 0,
                        statusData.queried || 0
                    ],
                    backgroundColor: ['#3a7bd5','#ffb347','#4CAF50','#ff4d4d'],
                    borderColor: '#fff',
                    borderWidth: 2
                }]
            };
            
            const commonOptions = {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            label: function (context) {
                                return `${context.label}: ${context.parsed.toLocaleString()}`;
                            }
                        }
                    }
                }
            };
            
            statusPieChart = new Chart(pieCtx, {
                type: 'doughnut',
                data: pieChartData,
                options: { ...commonOptions, cutout: '50%' }
            });

            // Toggle buttons
            document.getElementById('toggle-doughnut').onclick = (e) => {
                e.preventDefault();
                statusPieChart.destroy();
                statusPieChart = new Chart(pieCtx, { 
                    type: 'doughnut', 
                    data: pieChartData, 
                    options: {...commonOptions, cutout:'50%'} 
                });
            };
            
            document.getElementById('toggle-pie').onclick = (e) => {
                e.preventDefault();
                statusPieChart.destroy();
                statusPieChart = new Chart(pieCtx, { 
                    type: 'pie', 
                    data: pieChartData, 
                    options: {...commonOptions, cutout:0} 
                });
            };
            
            document.getElementById('export-pie-chart').onclick = (e) => {
                e.preventDefault();
                const link = document.createElement('a');
                link.href = statusPieChart.toBase64Image();
                link.download = 'status_chart.png';
                link.click();
            };

            /* ============================
               MONTHLY TREND CHART
            ============================ */


let alloadSubservicesData = await loadSubservicesData(startDate, endDate);
let services_result = JSON.parse(alloadSubservicesData);
console.log("Services data:", services_result);

const regionalChar = document.getElementById('monthlyTrendChart').getContext('2d');

// Destroy previous chart if it exists
if (window.subServicesChart && typeof window.subServicesChart.destroy === 'function') {
    window.subServicesChart.destroy();
}

// Extract values
const Services = services_result.topSubservices.map(item => item.subservice);
const receivedData = services_result.topSubservices.map(item => item.received);
const pendingData = services_result.topSubservices.map(item => item.pending);
const compData = services_result.topSubservices.map(item => item.receivedCompleted);

console.log("Top Services:", Services);

// Create new chart instance
window.subServicesChart = new Chart(regionalChar, {
    type: 'bar',
    data: {
        labels: Services,
        datasets: [
            {
                label: 'Applications Received',
                data: receivedData,
                backgroundColor: '#3a7bd5',
                borderColor: '#3a7bd5',
                borderWidth: 1
            },
            {
                label: 'Pending Applications',
                data: pendingData,
                backgroundColor: '#f6c23e',
                borderColor: '#f6c23e',
                borderWidth: 1
            },
            {
                label: 'Completed Applications',
                data: compData,
                backgroundColor: '#2E8B57',
                borderColor: '#2E8B57',
                borderWidth: 1
            }
        ]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false, // makes it fill parent container
        layout: {
            padding: { left: 10, right: 10, top: 20, bottom: 10 }
        },
        legend: {
            display: true,
            labels: {
                fontSize: 10,
                boxWidth: 12
            }
        },
        tooltips: {
            mode: 'index',
            intersect: false,
            callbacks: {
                label: function (tooltipItem, data) {
                    const dataset = data.datasets[tooltipItem.datasetIndex];
                    return `${dataset.label}: ${tooltipItem.yLabel.toLocaleString()}`;
                }
            }
        },
        scales: {
            x: {
                ticks: { font: { size: 5 }, maxRotation: 60, minRotation: 60 }
            },
            // y: {
            //     beginAtZero: true
            // }
            yAxes: [{
    type: 'logarithmic',
    ticks: {
        min: 1, // avoids log(0) issues
        callback: function (value, index, values) {
            if (value === 100000) return '100K';
            if (value === 10000) return '10K';
            if (value === 1000) return '1K';
            if (value === 100) return '100';
            if (value === 10) return '10';
            if (value === 1) return '1';
            return null; // skip other tick labels for clarity
        }
    },
    afterBuildTicks: function (chartObj) {
        // Dynamically adjust tick spacing for better visualization
        chartObj.ticks = [1, 10, 100, 1000, 10000, 100000];
    },
    scaleLabel: {
        display: true,
        // labelString: 'Applications Received Vrs Pending'
    }
}]
        }
    }
});

// Make chart truly responsive on window resize
window.addEventListener('resize', () => {
    if (window.subServicesChart) {
        window.subServicesChart.resize();
    }
});


// ✅ Export chart as PNG
document.getElementById('export-trend-chart').addEventListener('click', function (e) {
    e.preventDefault();

    if (!window.subServicesChart) {
        alert("Chart not available yet!");
        return;
    }

    const link = document.createElement('a');
    const fileName = `Top_Services_Trend_${new Date().toISOString().slice(0, 10)}.png`;
    link.download = fileName;
    link.href = window.subServicesChart.toBase64Image('image/png', 1.0);
    link.click();
});


            // const trendCanvas = document.getElementById('monthlyTrendChart');
            // const trendCtx = trendCanvas.getContext('2d');
            
            // // Destroy previous chart if exists
            // if (monthlyTrendChart) {
            //     monthlyTrendChart.destroy();
            //     trendCtx.clearRect(0, 0, trendCanvas.width, trendCanvas.height);
            // }

            // const colors = {
            //     completed: { line: '#56AB2F', bar: '#56AB2F' },
            //     recComp: { line: '#2E8B57', bar: '#2E8B57' },
            //     received: { line: '#3a7bd5', bar: '#3a7bd5' }
            // };

            // const trendData = {
            //     labels: jsonresult.monthlyTrendChart.labels,
            //     datasets: [
            //         {
            //             label: 'Completed',
            //             data: jsonresult.monthlyTrendChart.completed,
            //             borderColor: colors.completed.line,
            //             backgroundColor: 'line' ? 'rgba(28,200,138,0.2)' : colors.completed.bar,
            //             tension: 0.4,
            //             fill: 'line',
            //             pointBackgroundColor: colors.completed.line,
            //             pointBorderColor: '#fff'
            //         },
            //         {
            //             label: 'Received And Completed',
            //             data: jsonresult.monthlyTrendChart.received_completed,
            //             borderColor: colors.recComp.line,
            //             backgroundColor: 'line' ? 'rgba(47,158,158,0.2)' : colors.recComp.bar,
            //             tension: 0.4,
            //             fill: 'line',
            //             pointBackgroundColor: colors.recComp.line,
            //             pointBorderColor: '#fff'
            //         },
            //         {
            //             label: 'Received',
            //             data: jsonresult.monthlyTrendChart.received,
            //             borderColor: colors.received.line,
            //             backgroundColor: 'line' ? 'rgba(78,115,223,0.2)' : colors.received.bar,
            //             tension: 0.4,
            //             fill: 'line',
            //             pointBackgroundColor: colors.received.line,
            //             pointBorderColor: '#fff'
            //         }
            //     ]
            // };

            // monthlyTrendChart = new Chart(trendCtx, {
            //     type: 'line',
            //     data: trendData,
            //     options: {
            //         responsive: true,
            //         maintainAspectRatio: false,
            //         plugins: {
            //             legend: { display: true },
            //             tooltip: { enabled: true }
            //         },
            //         scales: {
            //             x: { grid: { display: false } },
            //             y: { grid: { color: '#eee' } }
            //         }
            //     }
            // });

            // // Toggle buttons
            // document.getElementById('toggle-bar').onclick = (e) => {
            //     e.preventDefault();
            //     monthlyTrendChart.destroy();
            //     monthlyTrendChart = new Chart(trendCtx, {
            //         type: 'bar',
            //         data: trendData,
            //         options: {
            //             responsive: true,
            //             maintainAspectRatio: false,
            //             plugins: {
            //                 legend: { display: true },
            //                 tooltip: { enabled: true }
            //             },
            //             scales: {
            //                 x: { grid: { display: false } },
            //                 y: { grid: { color: '#eee' } }
            //             }
            //         }
            //     });
            // };
            
            // document.getElementById('toggle-line').onclick = (e) => {
            //     e.preventDefault();
            //     monthlyTrendChart.destroy();
            //     monthlyTrendChart = new Chart(trendCtx, {
            //         type: 'line',
            //         data: trendData,
            //         options: {
            //             responsive: true,
            //             maintainAspectRatio: false,
            //             plugins: {
            //                 legend: { display: true },
            //                 tooltip: { enabled: true }
            //             },
            //             scales: {
            //                 x: { grid: { display: false } },
            //                 y: { grid: { color: '#eee' } }
            //             }
            //         }
            //     });
            // };
            
            // document.getElementById('export-trend-chart').onclick = (e) => {
            //     e.preventDefault();
            //     const link = document.createElement('a');
            //     link.href = monthlyTrendChart.toBase64Image();
            //     link.download = 'monthly_trend_chart.png';
            //     link.click();
            // };


        }
         catch (error) {
            console.error("Error loading dashboard data:", error);
            // Clear charts on error
            if (statusPieChart) {
                statusPieChart.destroy();
                statusPieChart = null;
            }
            if (monthlyTrendChart) {
                monthlyTrendChart.destroy();
                monthlyTrendChart = null;
            }
        }



        //Regional Data
        // Global variable to track the chart instance

// Your existing code with modifications:
let allLoadRegionalData = await loadRegionalData(startDate, endDate);
let regional_result = JSON.parse(allLoadRegionalData);
// console.log("Regional data:", regional_result);

const regionalChar = document.getElementById('regionalReceivedChart').getContext('2d');

// Destroy previous chart if it exists
if (regionalChartInstance) {
    regionalChartInstance.destroy();
}

// Extract values
const regions = regional_result.regionalReceived.map(item => item.region);
const regions_ID = regional_result.regionalReceived.map(item => item.regionId);

const receivedData = regional_result.regionalReceived.map(item => item.received);
const pendingData = regional_result.regionalReceived.map(item => item.pending);
const compData = regional_result.regionalReceived.map(item => item.receivedcompleted);

console.log(regions)

// Create new chart instance
// Create new chart instance
regionalChartInstance = new Chart(regionalChar, {
    type: 'bar',
    data: {
        labels: regions,
        datasets: [
            {
                label: 'Applications Received',
                data: receivedData,
                backgroundColor: '#3a7bd5',
                borderColor: '#3a7bd5',
                borderWidth: 1,
                status: 'received' 

            },
            {
                label: 'Pending Applications',
                data: pendingData,
                backgroundColor: '#f6c23e',
                borderColor: '#f6c23e',
                borderWidth: 1,
                status: 'pending' 

            },
            {
                label: 'Completed Applications',
                data: compData,
                backgroundColor: '#2E8B57',
                borderColor: '#2E8B57',
                borderWidth: 1,
                status: 'receivedcompleted' 

            }
        ]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: { display: true },
            tooltip: {
                callbacks: {
                    label: function (context) {
                        return `${context.dataset.label}: ${context.parsed.y.toLocaleString()}`;
                    }
                }
            }
        },
        scales: {
            x: {
                ticks: { font: { size: 10 }, maxRotation: 60, minRotation: 60 }
            },
            // y: {
            //     beginAtZero: true
            // }
            yAxes: [{
    type: 'logarithmic',
    ticks: {
        min: 1, // avoids log(0) issues
        callback: function (value, index, values) {
            if (value === 100000) return '100K';
            if (value === 10000) return '10K';
            if (value === 1000) return '1K';
            if (value === 100) return '100';
            if (value === 10) return '10';
            if (value === 1) return '1';
            return null; // skip other tick labels for clarity
        }
    },
    afterBuildTicks: function (chartObj) {
        // Dynamically adjust tick spacing for better visualization
        chartObj.ticks = [1, 10, 100, 1000, 10000, 100000];
    },
    scaleLabel: {
        display: true,
        // labelString: 'Applications Received Vrs Pending'
    }
}]
        },
        // 👇 Add this onClick handler
        onClick: async function (evt, elements) {
    const chart = this;
    const activePoints = chart.getElementAtEvent(evt);

    if (!activePoints.length) return;

    const firstPoint = activePoints[0];
    const regionIndex = firstPoint._index;
    const datasetIndex = firstPoint._datasetIndex;

    if (
        regionIndex === undefined ||
        !chart.data.labels[regionIndex] ||
        !chart.data.datasets[datasetIndex]
    ) return;

// 📊 REGIONAL APPLICATIONS (Click from Chart)
const regionName = chart.data.labels[regionIndex];
const regionId = regions_ID[regionIndex]; // ✅ Match region IDs
const dataset = chart.data.datasets[datasetIndex];
const AppStatus = dataset.status; // ✅ Extract status from dataset

console.log("🗺️ Region:", regionName, "| ID:", regionId, "| Status:", AppStatus);

// Modal Title
const title = `${regionName} ${AppStatus} APPLICATIONS BY DIVISIONS`.toUpperCase();
document.getElementById('regional_divisions_title').innerHTML = title;

// Show modal
$("#regional_divisions_modal").modal("show");

// Reset DataTable
$('#regional_divisions_table').DataTable().clear().destroy();

// Selected date range
const newdatestart = $('#startdate').val();
const newdateend = $('#enddate').val();

// AJAX Request
$.ajax({
  type: "POST",
  url: "executive_dashboard",
  data: {
    request_type: 'executive_dashboard_apps_by_regions_to_divisions',
    region_code: regionId,
    status: AppStatus,
    date_from: startDate,
    date_to: endDate
  },
  cache: false,
  success: function (response) {
    console.log("Regional → Division Response:", response);

    const json_result = JSON.parse(response);
    const divisions = json_result.apps_at_division || [];

    const totalApplications = divisions.length;
    const totalApplicationsSum = divisions.reduce((sum, item) => sum + (item.total || 0), 0);

    if (divisions.length === 0) {
      alert(` No ${AppStatus.toLowerCase()} applications found for ${regionName} between ${newdatestart} and ${newdateend}.`);
      return;
    }

    // Prepare DataTable Data
    const dataSet = divisions.map(item => {
      const division = item.division;
      const total = item.total;
      const action = `
        <a href="javascript:void(0)" 
           data-id="${regionId}" 
           data-name_full="${division}" 
           data-status="${AppStatus}" 
           data-regionname="${regionName}"
           id="view_regional_applications_by_divisions_by_services"
           class="btn btn-md btn-secondary shadow-sm px-3 py-2 rounded-lg">
           <i class="fas fa-cogs"></i> View Services
        </a>`;
      return [division, total, action];
    });

    // Update summary section
    updateSummaryStatusRegionsDivisionsNew(json_result.data, totalApplications, totalApplicationsSum);

    // Initialize DataTable
    $('#regional_divisions_table').DataTable({
      data: dataSet,
      columns: [
        { title: "Division" },
        { title: "Total Applications" },
        { title: "Action", orderable: false, searchable: false }
      ],
      dom: 'Bfrtip',
      paging: true,
      lengthChange: true,
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
          title: title,
          filename: `Report_on_${regionName}_${AppStatus}_Applications_Between_${newdatestart}_and_${newdateend}`
        },
        {
          extend: 'excel',
          title: title,
          filename: `Report_on_${regionName}_${AppStatus}_Applications_Between_${newdatestart}_and_${newdateend}`
        },
        {
          extend: 'pdf',
          title: title,
          filename: `Report_on_${regionName}_${AppStatus}_Applications_Between_${newdatestart}_and_${newdateend}`
        },
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
                </p>`)
              .css('font-size', '18px');
            $(win.document.body).find('table')
              .addClass('compact')
              .css('font-size', '16px')
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
  },
  error: function (xhr, status, error) {
    console.error(" Error loading regional division data:", error);
    alert("An error occurred while loading regional division data. Please try again later.");
  }
});
     

}

    }
});



// Export as PNG
document.getElementById('export-regional-png').addEventListener('click', function () {
    const link = document.createElement('a');
    link.href = regionalChartInstance.toBase64Image();
    link.download = 'regional_applications.png';
    link.click();
});

// Export as PDF
document.getElementById('export-regional-pdf').addEventListener('click', function () {
    const { jsPDF } = window.jspdf;
    const pdf = new jsPDF();
    pdf.text("Regional Applications (Received vs Pending)", 10, 10);
    pdf.addImage(regionalChartInstance.toBase64Image(), 'PNG', 10, 20, 180, 100);
    pdf.save('regional_applications.pdf');
});





                    // Store chart instance in a global variable
// Your data loading code
// let alloadCompletedRegionalData = await loadCompletedRegionalData(startDate, endDate);
// let Completedregional_result = JSON.parse(alloadCompletedRegionalData);
// console.log("Regional Completed data:", Completedregional_result);

// const ctx2 = document.getElementById('regionalCompletedChart').getContext('2d');

// // Destroy existing chart if it exists
// if (regionalCompletedChart) {
//     regionalCompletedChart.destroy();
// }

// // Extract data from Completedregional_result
// const regionss = Completedregional_result.regionalStats.map(item => item.region);
// const completedData = Completedregional_result.regionalStats.map(item => item.completed);
// const receivedCompletedData = Completedregional_result.regionalStats.map(item => item.received_completed);

// // Create new chart
// regionalCompletedChart = new Chart(ctx2, {
//     type: 'bar',
//     data: {
//         labels: regionss,
//         datasets: [
//             {
//                 label: 'Received And Completed',
//                 data: receivedCompletedData,
//                 backgroundColor: '#2E8B57',
//                 borderColor: '#2E8B57',
//                 borderWidth: 1,
//                 status : 'receivedcompleted'
//             },
//             {
//                 label: 'Completed',
//                 data: completedData,
//                 backgroundColor: '#56AB2F',
//                 borderColor: '#56AB2F',
//                 borderWidth: 1,
//                 status : 'completed'
//             }
//         ]
//     },
//     options: {
//         responsive: true,
//         maintainAspectRatio: false,
//         plugins: {
//             tooltip: {
//                 callbacks: {
//                     label: function (context) {
//                         return `${context.dataset.label}: ${context.parsed.y}`;
//                     }
//                 }
//             }
//         },
//         scales: {
//             x: {
//                 stacked: false,
//                 ticks: { font: { size: 11 }, maxRotation: 45, minRotation: 45 }
//             },
//             yAxes: [{
//     type: 'logarithmic',
//     ticks: {
//         min: 1, // avoids log(0) issues
//         callback: function (value, index, values) {
//             if (value === 100000) return '100K';
//             if (value === 10000) return '10K';
//             if (value === 1000) return '1K';
//             if (value === 100) return '100';
//             if (value === 10) return '10';
//             if (value === 1) return '1';
//             return null; // skip other tick labels for clarity
//         }
//     },
//     afterBuildTicks: function (chartObj) {
//         // Dynamically adjust tick spacing for better visualization
//         chartObj.ticks = [1, 10, 100, 1000, 10000, 100000];
//     },
//     scaleLabel: {
//         display: true,
//         // labelString: 'Applications Completed Vrs Received & Completed'
//     }
// }]
// //             y: {
// //     type: 'logarithmic',
// //     beginAtZero: true,
// //     ticks: {
// //         callback: function (value) {
// //             return value.toLocaleString(); // formats ticks
// //         }
// //     }
// // }
//         },

//                 // 👇 Add this onClick handler
//         onClick: async function (evt, elements) {
//     const chart = this;
//     const activePoints = chart.getElementAtEvent(evt);

//     if (!activePoints.length) return;

//     const firstPoint = activePoints[0];
//     const regionIndex = firstPoint._index;
//     const datasetIndex = firstPoint._datasetIndex;

//     if (
//         regionIndex === undefined ||
//         !chart.data.labels[regionIndex] ||
//         !chart.data.datasets[datasetIndex]
//     ) return;

//     // ✅ Correct mapping
//     const regionName = chart.data.labels[regionIndex];
//     const regionid = regions_ID[regionIndex]; // <-- get ID from your parallel array
//     const datasetLabel = chart.data.datasets[datasetIndex];
//     // const status = chart.data.status[regionIndex];
//     const dataset = chart.data.datasets[datasetIndex];
//     const AppStatus = dataset.status; // ✅ get status from dataset

//     // console.log("🟩 Region clicked:", regionName);
//     // console.log("🆔 Region ID:", regionid);
//     // console.log("📊 Dataset clicked:", datasetLabel);
//     //  console.log("📌 Status:", status);
//         //  var regionid=$(this).data('id');       
//         // var regionName=$(this).data('name_full');
//         //  var AppStatus=$(this).data('stats');

//         console.log(regionid,regionName);


//         var title = regionName + " "+ AppStatus+ " "+ "APPLICATIONS";  
      
//         document.getElementById('regional_divisions_title').innerHTML = title.toUpperCase();

        
//         $("#regional_divisions_modal").modal("show");  


//        let dataSet2 = [];
//        let num2 = 0;
      
//       $('#regional_divisions_table').DataTable().clear().destroy();




//           $.ajax({
//            type : "POST",
//            url : "executive_dashboard",
//            data : {
//                request_type : 'executive_dashboard_apps_by_regions_to_divisions',
//                region_code : regionid,
//                status : AppStatus,
//                date_from : startDate,
//            date_to : endDate
//            },
//            cache: false,
//            success: function(response) {
      
//             console.log(response)
      
//                var json_result = JSON.parse(response);
//                console.log(json_result.apps_at_division)

// totalApplications = json_result.apps_at_division?.length ?? 0;
//              totalApplicationsSum = json_result.apps_at_division
//     ? json_result.apps_at_division.reduce((sum, item) => sum + (item.total || 0), 0)
//     : 0;
      
      
//         for(let i=0; i<json_result.apps_at_division.length; i++) {
//           let html = [];
//           num2 = +num2 + 1;
      
//           let division = json_result.apps_at_division[i].division;
//           let total = json_result.apps_at_division[i].total;
//           let action = `<a href="javascript:void(0)" data-id="${regionid}" data-name_full="${json_result.apps_at_division[i].division}" data-status="${AppStatus}" data-regionname="${regionName}"  id="view_regional_applications_by_divisions_by_services"  
//         class="btn btn-md btn-secondary"> <i class="fas fa-cogs"></i> View Services </a> `;
    
      
//           html.push(division);
//           html.push(total);
//           html.push(action);
      
//           dataSet2.push(html);
      
//         //console.log(dataSet)
//         }
      

//         updateSummaryStatusRegionsDivisionsNew(json_result.data, totalApplications,totalApplicationsSum );

   
      
//         $('#regional_divisions_table').DataTable().clear().destroy();
                      
//         $('#regional_divisions_table').DataTable({ data: dataSet2,
//           dom : 'Blfrtip',
//               paging: true,
//             lengthChange: true,   // <-- ensure this is enabled
//           lengthMenu : [
//               [ 10, 25, 50, -1 ],
//               [ '10 rows', '25 rows',
//                   '50 rows', 'Show all' ] ],

//                 //   servicetobankname + " "+ "Recieved From"+ " " + bank_name+ " " + "Between" + ' ' + startDate + ' ' +"AND "+ " " +endDate;
         
//                   buttons: [   
//                     {
//                         extend: 'csv',
//                         title: `Report on ${regionName} APPLICATIONS  BETWEEN ${newdatestart} and ${newdateend}`,
//                         filename: `Report_on_${regionName}_APPLICATIONS_BETWEEN_${newdatestart}_and_${newdateend}`
//                     },
//                     {
//                         extend: 'excel',
//                         title: `Report on ${regionName} APPLICATIONS  BETWEEN ${newdatestart} and ${newdateend}`,
//                         filename: `Report_on_${regionName}_APPLICATIONS_BETWEEN_${newdatestart}_and_${newdateend}`
//                     },
//                     {
//                         extend: 'pdf',
//                         title: `Report on ${regionName} APPLICATIONS  BETWEEN ${newdatestart} and ${newdateend}`,
//                         filename: `Report_on_${regionName}_APPLICATIONS_BETWEEN_${newdatestart}_and_${newdateend}`
//                     },
//                     {
//                         extend: 'print',
//                         title: `<h3>Report on ${regionName} APPLICATIONS ${newdatestart} and ${newdateend}</h3>`,
//                         message: 'This report is generated using the Enterprise Land Information System'
//                     }
//                 ]

            
            
//             }).draw();
      
//     //  }
              
     
      
      
//            }
//        })
     

// }
//     }
// });

// Update export event listeners
// function updateExportListeners() {
//     // Remove existing event listeners
//     const pngBtn = document.getElementById('export-completed-png');
//     const pdfBtn = document.getElementById('export-completed-pdf');
    
//     // Clone and replace buttons to remove old event listeners
//     const newPngBtn = pngBtn.cloneNode(true);
//     const newPdfBtn = pdfBtn.cloneNode(true);
    
//     pngBtn.parentNode.replaceChild(newPngBtn, pngBtn);
//     pdfBtn.parentNode.replaceChild(newPdfBtn, pdfBtn);
    
//     // Add new event listeners
//     newPngBtn.addEventListener('click', function () {
//         if (!regionalCompletedChart) {
//             alert('Please load chart data first');
//             return;
//         }
//         const link = document.createElement('a');
//         link.href = regionalCompletedChart.toBase64Image();
//         link.download = 'regional_completed_applications.png';
//         link.click();
//     });

//     newPdfBtn.addEventListener('click', function () {
//         if (!regionalCompletedChart) {
//             alert('Please load chart data first');
//             return;
//         }
//         const { jsPDF } = window.jspdf;
//         const pdf = new jsPDF();
//         pdf.text("Regional Applications - Received vs Completed", 10, 10);
//         pdf.addImage(regionalCompletedChart.toBase64Image(), 'PNG', 10, 20, 180, 100);
//         pdf.save('regional_completed_applications.pdf');
//     });
// }

// // Update the export listeners
// updateExportListeners();




       
/// Received Apps

$(document).off('click', '#received_apps').on('click', '#received_apps', function (e) {
  e.preventDefault();

  // Date range values
  const datefrom = startDate;
  const dateto = endDate;

  const new_date_start = $('#startdate').val();
  const new_date_end = $('#enddate').val();

  console.log("Selected date range:", new_date_start, new_date_end);

  // Set modal title and open modal
  const title = `APPLICATIONS RECEIVED BETWEEN ${new_date_start} AND ${new_date_end}`.toUpperCase();
  document.getElementById('recieved_applications_title').innerHTML = title;
  $("#recieved_reporting_modal").modal("show");

  // Clear existing DataTable if any
  $('#main_service_table').DataTable().clear().destroy();

  // Fetch received applications
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_apps_recieved',
      date_from: datefrom,
      date_to: dateto
    },
    cache: false,
    success: function (response) {
      console.log("Raw response:", response);

      const json_result = JSON.parse(response);
      const receivedApps = json_result.apps_at_division || [];

      const totalApplications = receivedApps.length;
      const totalApplicationsSum = receivedApps.reduce((sum, item) => sum + (item.total || 0), 0);

      console.log("Total Applications:", totalApplications);
      console.log("Sum of all applications:", totalApplicationsSum);

      if (receivedApps.length === 0) {
        alert("No applications were received within the selected date range. Please check back later.");
        return;
      }

      // Build DataTable dataset
      const dataSet = receivedApps.map((app) => {
        const service_name = app.service_name;
        const count = app.total;
        const percentage = totalApplicationsSum > 0
          ? ((count / totalApplicationsSum) * 100).toFixed(1) + '%'
          : '0%';
        const action = `
          <a href="javascript:void(0)" 
            data-id="${app.business_process_id}" 
            data-name_full="${app.service_name}" 
            id="view_recieved_apps_by_sub_service"
            class="btn btn-secondary btn-md shadow-sm">
            <i class="fa fa-cogs"></i> More Details
          </a>`;

        return [service_name, count, percentage, action];
      });

      // Update dashboard summary stats
      updateSummaryStats(json_result.data, totalApplications, totalApplicationsSum);

      // Initialize DataTable with export buttons
      $('#main_service_table').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_On_Applications_Received_${new_date_start}_to_${new_date_end}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_On_Applications_Received_${new_date_start}_to_${new_date_end}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_On_Applications_Received_${new_date_start}_to_${new_date_end}`
          },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(
                  `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                   <p style="text-align:center; font-weight:bold; margin-bottom:30px;">This report is generated using the Enterprise Land Information System</p>`
                )
                .css('font-size', '18px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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
    },
    error: function (xhr, status, error) {
      console.error("Error fetching received applications:", error);
      alert("An error occurred while retrieving applications. Please try again.");
    }
  });
});








    ///subservices recieved

  $(document).off('click', '#view_recieved_apps_by_sub_service').on('click', '#view_recieved_apps_by_sub_service', function (e) {
  e.preventDefault();

  // Extract service info
  const business_process_id = $(this).data('id');
  const service_name = $(this).data('name_full');

  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  // Format modal title
  const title = `${service_name} - APPLICATIONS RECEIVED BETWEEN ${newdatestart} AND ${newdateend}`.toUpperCase();
  document.getElementById('sub_service_modalLabel').innerHTML = title;

  // Show modal
  $("#sub_service_modal").modal("show");

  // Reset DataTable
  $('#sub_service_table').DataTable().clear().destroy();

  // AJAX call to fetch sub-service data
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_apps_by_subservices_recieved',
      sub_serv_id: business_process_id,
      date_from: startDate,
      date_to: endDate
    },
    cache: false,
    success: function (response) {
      console.log("Sub-service response:", response);

      const json_result = JSON.parse(response);
      const apps_at_division = json_result.apps_at_division || [];

      const totalApplications = apps_at_division.length;
      const totalApplicationsSum = apps_at_division.reduce((sum, item) => sum + (item.total || 0), 0);

      console.log("Total apps:", totalApplications, "Sum:", totalApplicationsSum);

      if (apps_at_division.length === 0) {
        alert(`No ${service_name} applications were received within the selected date range.`);
        return;
      }

      // Build dataset for DataTable
      const dataSet = apps_at_division.map(app => {
        const sub_service_name = app.sub_service_name;
        const total = app.total;
        const percentage = totalApplicationsSum > 0 ? ((total / totalApplicationsSum) * 100).toFixed(1) + '%' : '0%';
        const action = `
          <a href="javascript:void(0)" 
             data-id="${app.business_process_sub_id}" 
             data-name_full="${app.sub_service_name}" 
             id="view_recieved_applications"
             class="btn btn-secondary btn-md shadow-sm">
             <i class="fas fa-clipboard-list"></i> View Applications
          </a>`;

        return [sub_service_name, total, percentage, action];
      });

      // Update summary stats
      updateSummaryStatsSubService(json_result.data, totalApplications, totalApplicationsSum);

      // Initialize DataTable with export options
      $('#sub_service_table').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_On_${service_name}_Received_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_On_${service_name}_Received_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_On_${service_name}_Received_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(
                  `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                   <p style="text-align:center; font-weight:bold; margin-bottom:30px;">This report is generated using the Enterprise Land Information System</p>`
                )
                .css('font-size', '18px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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
    },
    error: function (xhr, status, error) {
      console.error("Error loading sub-service data:", error);
      alert("An error occurred while fetching sub-service applications. Please try again.");
    }
  });
});




      //Applications recieved
$(document).off('click', '#view_recieved_applications').on('click', '#view_recieved_applications', function (e) {
  e.preventDefault();

  // Extract values
  const subprocessid = $(this).data('id');
  const SubServicename = $(this).data('name_full');
  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  // Build dynamic title
  const title = `${SubServicename} - APPLICATIONS RECEIVED BETWEEN ${newdatestart} AND ${newdateend}`.toUpperCase();
  document.getElementById('apps_modalLabel').innerHTML = title;

  // Show modal
  $("#apps_modal").modal("show");

  // Reset DataTable
  $('#apps_table').DataTable().clear().destroy();

  // AJAX call to get application details
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_applications_recieved',
      sub_serv_sub_id: subprocessid,
      date_from: startDate,
      date_to: endDate
    },
    cache: false,
    success: function (response) {
      console.log("Applications received response:", response);

      const json_result = JSON.parse(response);
      const apps_at_division = json_result.apps_at_division || [];

      const totalApplications = apps_at_division.length;

      if (totalApplications === 0) {
        alert(`No ${SubServicename} applications were received between ${newdatestart} and ${newdateend}.`);
        return;
      }

      // Prepare data for DataTable
      const dataSet = apps_at_division.map(app => {
        const job_number = app.job_number;
        const ar_name = app.ar_name;
        const business_process_name = app.business_process_name;
        const created_date = app.created_date;
        const days_due = app.days_due;
        const job_status = app.job_status;

        const action = `
          <div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
            </button>
            <div class="dropdown-menu">  
              <button 
                type="button" 
                class="dropdown-item" 
                id="btn_cabinet" 
                data-target-id="${job_number}" 
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
          </div>`;

        return [
          job_number,
          ar_name,
          business_process_name,
          created_date,
          days_due,
          job_status,
          action
        ];
      });

      // Update summary statistics
      updateSummaryStatsRecApplications(json_result.data, totalApplications, 0);

      // Initialize DataTable
      $('#apps_table').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_On_${SubServicename}_Applications_Received_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_On_${SubServicename}_Applications_Received_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_On_${SubServicename}_Applications_Received_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(
                  `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                   <p style="text-align:center; font-weight:bold; margin-bottom:30px;">This report is generated using the Enterprise Land Information System</p>`
                )
                .css('font-size', '18px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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
    },
    error: function (xhr, status, error) {
      console.error("Error loading applications received:", error);
      alert("An error occurred while fetching application data. Please try again.");
    }
  });
});

       


//APPLICATIONS PENDING 
      
  $(document).off('click', '#pending_apps').on('click', '#pending_apps', function (e) {
  e.preventDefault();

  // Capture selected date range
  const datefrom = startDate;
  const dateto = endDate;
  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  // Dynamic report title
  const title = `APPLICATIONS PENDING BETWEEN ${newdatestart} AND ${newdateend}`.toUpperCase();
  document.getElementById('recieved_applications_title').innerHTML = title;

  // Show reporting modal
  $("#recieved_reporting_modal").modal("show");

  // Clear any existing data
  $('#main_service_table').DataTable().clear().destroy();

  // AJAX Request
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_apps_pending',
      date_from: datefrom,
      date_to: dateto
    },
    cache: false,
    success: function (response) {
      console.log("Pending applications response:", response);

      const json_result = JSON.parse(response);
      const apps_at_division = json_result.apps_at_division || [];

      const totalApplications = apps_at_division.length;
      const totalApplicationsSum = apps_at_division.reduce((sum, item) => sum + (item.total || 0), 0);

      // If no data found
      if (totalApplications === 0) {
        alert(`No applications are pending between ${newdatestart} and ${newdateend}.`);
        return;
      }

      // Build dataset for DataTable
      const dataSet = apps_at_division.map(item => {
        const service_name = item.service_name;
        const count = item.total;
        const percentage = totalApplicationsSum > 0 ? ((count / totalApplicationsSum) * 100).toFixed(1) + '%' : '0%';

        const action = `
          <a href="javascript:void(0)" 
             data-id="${item.business_process_id}" 
             data-name_full="${item.service_name}" 
             id="view_pending_apps_by_sub_service"  
             class="btn btn-secondary btn-md shadow-sm px-3 py-2 rounded-lg">
             <i class="fa fa-cogs"></i> More Details
          </a>`;

        return [service_name, count, percentage, action];
      });

      // Update summary stats UI
      updateSummaryStats(json_result.data, totalApplications, totalApplicationsSum);

      // Initialize DataTable
      $('#main_service_table').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_On_Applications_Pending_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_On_Applications_Pending_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_On_Applications_Pending_${newdatestart}_to_${newdateend}`
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
                     This report is generated using the Enterprise Land Information System
                   </p>`
                )
                .css('font-size', '18px');
              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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
    },
    error: function (xhr, status, error) {
      console.error("Error loading pending applications:", error);
      alert("An error occurred while fetching pending application data. Please try again.");
    }
  });
});



    //PENDING BY SERVICES


        ///subservices recieved

$(document).off('click', '#view_pending_apps_by_sub_service').on('click', '#view_pending_apps_by_sub_service', function (e) {
  e.preventDefault();

  // Extract key data attributes
  const business_process_id = $(this).data('id');
  const service_name = $(this).data('name_full');

  // Get selected date range from inputs
  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  // Build a professional uppercase title
  const title = `${service_name} - PENDING BETWEEN ${newdatestart} AND ${newdateend}`.toUpperCase();
  document.getElementById('sub_service_modalLabel').innerHTML = title;

  // Display modal
  $("#sub_service_modal").modal("show");

  // Reset DataTable
  $('#sub_service_table').DataTable().clear().destroy();

  // AJAX call to load data
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_apps_by_subservices_pending',
      sub_serv_id: business_process_id,
      date_from: startDate,
      date_to: endDate
    },
    cache: false,
    success: function (response) {
      console.log("Pending sub-service response:", response);

      const json_result = JSON.parse(response);
      const apps_at_division = json_result.apps_at_division || [];

      const totalApplications = apps_at_division.length;
      const totalApplicationsSum = apps_at_division.reduce((sum, item) => sum + (item.total || 0), 0);

      if (totalApplications === 0) {
        alert(`No pending applications found for ${service_name} between ${newdatestart} and ${newdateend}.`);
        return;
      }

      // Prepare DataTable rows
      const dataSet = apps_at_division.map(item => {
        const sub_service_name = item.sub_service_name;
        const total = item.total;
        const percentage = totalApplicationsSum > 0 ? ((total / totalApplicationsSum) * 100).toFixed(1) + '%' : '0%';

        const action = `
          <a href="javascript:void(0)" 
             data-id="${item.business_process_sub_id}" 
             data-name_full="${item.sub_service_name}" 
             id="view_pending_applications"  
             class="btn btn-md btn-secondary shadow-sm px-3 py-2 rounded-lg">
             <i class="fas fa-clipboard-list"></i> View Applications
          </a>`;

        return [sub_service_name, total, percentage, action];
      });

      // Update summary stats
      updateSummaryStatsSubService(json_result.data, totalApplications, totalApplicationsSum);

      // Initialize DataTable
      $('#sub_service_table').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_On_${service_name}_Pending_Between_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_On_${service_name}_Pending_Between_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_On_${service_name}_Pending_Between_${newdatestart}_and_${newdateend}`
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
                     This report is generated using the Enterprise Land Information System
                   </p>`
                )
                .css('font-size', '18px');
              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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
    },
    error: function (xhr, status, error) {
      console.error("Error loading pending sub-service data:", error);
      alert("An error occurred while fetching sub-service pending data. Please try again later.");
    }
  });
});








            //Applications Pending

    $(document).off('click', '#view_pending_applications').on('click', '#view_pending_applications', function (e) {
  e.preventDefault();

  // Extract key data
  const subprocessid = $(this).data('id');
  const SubServicename = $(this).data('name_full');

  // Get selected date range
  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  // Build a professional title
  const title = `${SubServicename} - PENDING BETWEEN ${newdatestart} AND ${newdateend}`.toUpperCase();
  document.getElementById('apps_modalLabel').innerHTML = title;

  // Display modal
  $("#apps_modal").modal("show");

  // Reset DataTable
  $('#apps_table').DataTable().clear().destroy();

  // AJAX call to load applications data
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_applications_pending',
      sub_serv_sub_id: subprocessid,
      date_from: startDate,
      date_to: endDate
    },
    cache: false,
    success: function (response) {
      console.log("Pending applications response:", response);

      const json_result = JSON.parse(response);
      const apps_at_division = json_result.apps_at_division || [];

      const totalApplications = apps_at_division.length;

      if (totalApplications === 0) {
        alert(`No pending applications found for ${SubServicename} between ${newdatestart} and ${newdateend}.`);
        return;
      }

      // Prepare table rows
      const dataSet = apps_at_division.map(item => {
        const job_number = item.job_number;
        const ar_name = item.ar_name;
        const business_process_name = item.business_process_name;
        const created_date = item.created_date;
        const days_due = item.days_due;
        const job_status = item.job_status;

        const action = `
          <div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
            </button>
            <div class="dropdown-menu">
              <button type="button" class="dropdown-item" 
                id="btn_cabinet" 
                title="View Application Progress" 
                data-target-id="${item.job_number}" 
                data-target="#cabinetModal" 
                data-toggle="modal">
                Track <i class="fas fa-hdd"></i>
              </button>
              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" value="${item.transaction_number}">
                <input type="hidden" name="search_text" value="${item.case_number}">
                <input type="hidden" name="job_number" value="${item.job_number}">
                <input type="hidden" name="business_process_sub_name" value="${item.case_number}">
                <button type="submit" class="dropdown-item">
                  Application Details <i class="fas fa-info-circle"></i>
                </button>
              </form>
            </div>
          </div>`;

        return [job_number, ar_name, business_process_name, created_date, days_due, job_status, action];
      });

      // Update summary stats
      updateSummaryStatsRecApplications(json_result.data, totalApplications, 0);

      // Initialize DataTable
      $('#apps_table').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_On_${SubServicename}_Pending_BETWEEN_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_On_${SubServicename}_Pending_BETWEEN_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_On_${SubServicename}_Pending_BETWEEN_${newdatestart}_and_${newdateend}`
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
                     This report is generated using the Enterprise Land Information System
                   </p>`
                )
                .css('font-size', '18px');
              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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
    },
    error: function (xhr, status, error) {
      console.error("Error loading pending applications:", error);
      alert("An error occurred while loading pending applications. Please try again later.");
    }
  });
});






      //COMPLETED APPLICATIONS      
$(document).off('click', '#completed_apps').on('click', '#completed_apps', function (e) {
  e.preventDefault();

  // Retrieve selected date range
  const datefrom = startDate;
  const dateto = endDate;
  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  console.log("Completed Apps Date Range:", newdatestart, newdateend);

  // Build title dynamically
  const title = `APPLICATIONS COMPLETED BETWEEN ${newdatestart} AND ${newdateend}`.toUpperCase();
  document.getElementById('recieved_applications_title').innerHTML = title;

  // Show modal
  $("#recieved_reporting_modal").modal("show");

  // Clear any existing DataTable instance
  $('#main_service_table').DataTable().clear().destroy();

  // AJAX call to backend
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_apps_completed',
      date_from: datefrom,
      date_to: dateto
    },
    cache: false,
    success: function (response) {
      console.log("Completed apps response:", response);

      const json_result = JSON.parse(response);
      const apps_at_division = json_result.apps_at_division || [];

      const totalApplications = apps_at_division.length;
      const totalApplicationsSum = apps_at_division.reduce((sum, item) => sum + (item.total || 0), 0);

      if (totalApplications === 0) {
        alert(`No applications were completed between ${newdatestart} and ${newdateend}.`);
        return;
      }

      // Build table data dynamically
      const dataSet = apps_at_division.map(item => {
        const service_name = item.service_name;
        const count = item.total;
        const percentage = totalApplicationsSum > 0
          ? ((count / totalApplicationsSum) * 100).toFixed(1) + '%'
          : '0%';

        const action = `
          <a href="javascript:void(0)" 
             data-id="${item.business_process_id}" 
             data-name_full="${item.service_name}" 
             id="view_completed_apps_by_sub_service"  
             class="btn btn-md btn-secondary shadow-sm px-3 py-2 rounded-lg">
             <i class="fa fa-cogs"></i> More Details
          </a>`;

        return [service_name, count, percentage, action];
      });

      // Update summary statistics
      updateSummaryStats(json_result.data, totalApplications, totalApplicationsSum);

      // Initialize DataTable
      $('#main_service_table').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_On_Applications_Completed_Between_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_On_Applications_Completed_Between_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_On_Applications_Completed_Between_${newdatestart}_and_${newdateend}`
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
                     This report is generated using the Enterprise Land Information System
                   </p>`
                )
                .css('font-size', '18px');
              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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
    },
    error: function (xhr, status, error) {
      console.error("Error loading completed applications:", error);
      alert("An error occurred while fetching completed applications. Please try again later.");
    }
  });
});






       //Completed BY SERVICES
        ///Completed recieved
  $(document).off('click', '#view_completed_apps_by_sub_service').on('click', '#view_completed_apps_by_sub_service', function (e) {
  e.preventDefault();

  // Extract key data
  const business_process_id = $(this).data('id');
  const service_name = $(this).data('name_full');

  // Capture date range from inputs
  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  // Construct title
  const title = `${service_name} - COMPLETED BETWEEN ${newdatestart} AND ${newdateend}`.toUpperCase();
  document.getElementById('sub_service_modalLabel').innerHTML = title;

  // Show modal
  $("#sub_service_modal").modal("show");

  // Clear any existing table
  $('#sub_service_table').DataTable().clear().destroy();

  // Fetch data via AJAX
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_apps_by_subservices_completed',
      sub_serv_id: business_process_id,
      date_from: startDate,
      date_to: endDate
    },
    cache: false,
    success: function (response) {
      console.log("Completed sub-service response:", response);

      const json_result = JSON.parse(response);
      const apps_at_division = json_result.apps_at_division || [];

      const totalApplications = apps_at_division.length;
      const totalApplicationsSum = apps_at_division.reduce((sum, item) => sum + (item.total || 0), 0);

      if (totalApplications === 0) {
        alert(`No completed applications found for ${service_name} between ${newdatestart} and ${newdateend}.`);
        return;
      }

      // Build data for DataTable
      const dataSet = apps_at_division.map(item => {
        const sub_service_name = item.sub_service_name;
        const total = item.total;
        const percentage = totalApplicationsSum > 0
          ? ((total / totalApplicationsSum) * 100).toFixed(1) + '%'
          : '0%';

        const action = `
          <a href="javascript:void(0)" 
             data-id="${item.business_process_sub_id}" 
             data-name_full="${item.sub_service_name}" 
             id="view_completed_applications"  
             class="btn btn-md btn-secondary shadow-sm px-3 py-2 rounded-lg">
             <i class="fas fa-clipboard-list"></i> View Applications
          </a>`;

        return [sub_service_name, total, percentage, action];
      });

      // Update dashboard stats
      updateSummaryStatsSubService(json_result.data, totalApplications, totalApplicationsSum);

      // Initialize DataTable with modern configuration
      $('#sub_service_table').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_On_${service_name}_Completed_Between_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_On_${service_name}_Completed_Between_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_On_${service_name}_Completed_Between_${newdatestart}_and_${newdateend}`
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
                     This report is generated using the Enterprise Land Information System
                   </p>`
                )
                .css('font-size', '18px');
              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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
    },
    error: function (xhr, status, error) {
      console.error("Error loading completed sub-service data:", error);
      alert("An error occurred while fetching completed sub-service data. Please try again later.");
    }
  });
});







            //Applications Completed
$(document).off('click', '#view_completed_applications').on('click', '#view_completed_applications', function (e) {
  e.preventDefault();

  // Extract parameters
  const subprocessid = $(this).data('id');
  const SubServicename = $(this).data('name_full');

  // Capture date range
  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  // Set dynamic title
  const title = `${SubServicename} - COMPLETED BETWEEN ${newdatestart} AND ${newdateend}`.toUpperCase();
  document.getElementById('completed_apps_modalLabel').innerHTML = title;

  // Show modal
  $("#completed_apps_modal").modal("show");

  // Clear any existing data
  $('#completed_apps_table').DataTable().clear().destroy();

  // Fetch completed applications
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_applications_completed',
      sub_serv_sub_id: subprocessid,
      date_from: startDate,
      date_to: endDate
    },
    cache: false,
    success: function (response) {
      console.log("Completed Applications Response:", response);

      const json_result = JSON.parse(response);
      const apps = json_result.apps_at_division || [];

      const totalApplications = apps.length;
      if (totalApplications === 0) {
        alert(`No completed applications found for ${SubServicename} between ${newdatestart} and ${newdateend}.`);
        return;
      }

      // Build dataset
      const dataSet = apps.map(app => {
        const job_number = app.job_number;
        const ar_name = app.ar_name;
        const business_process_name = app.business_process_name;
        const created_date = app.created_date;
        const completed_date = app.completed_date;
        const turnaround_days = app.turnaround_days;

        const action = `
          <div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
              Actions
            </button>
            <div class="dropdown-menu shadow">
              <button type="button" 
                      class="dropdown-item text-primary fw-bold" 
                      id="btn_cabinet" 
                      title="View Application Stages" 
                      data-target-id="${job_number}" 
                      data-target="#cabinetModal" 
                      data-toggle="modal">
                Job Stages <i class="fas fa-hdd ms-1"></i>
              </button>
              <button type="button" 
                      class="dropdown-item text-success fw-bold" 
                      id="btn_cabinet" 
                      title="Track Application" 
                      data-target-id="${job_number}" 
                      data-target="#cabinetModal" 
                      data-toggle="modal">
                Track <i class="fas fa-route ms-1"></i>
              </button>
              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" value="${app.transaction_number}">
                <input type="hidden" name="search_text" value="${app.case_number}">
                <input type="hidden" name="job_number" value="${job_number}">
                <input type="hidden" name="business_process_sub_name" value="${app.business_process_name}">
                <button type="submit" class="dropdown-item text-info fw-bold">
                  Application Details <i class="fas fa-info-circle ms-1"></i>
                </button>
              </form>
            </div>
          </div>`;

        return [job_number, ar_name, business_process_name, created_date, completed_date, turnaround_days, action];
      });

      // Update summary section (if applicable)
      updateSummaryStatsRecApplicationsCompleted(json_result.data, totalApplications);

      // Initialize DataTable
      $('#completed_apps_table').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_On_${SubServicename}_Completed_Between_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_On_${SubServicename}_Completed_Between_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_On_${SubServicename}_Completed_Between_${newdatestart}_and_${newdateend}`
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
                     This report is generated using the Enterprise Land Information System
                   </p>`
                )
                .css('font-size', '18px');
              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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
    },
    error: function (xhr, status, error) {
      console.error("Error fetching completed applications:", error);
      alert("An error occurred while loading completed applications. Please try again later.");
    }
  });
});







//  RECEIVED AND COMPLETED APPLICATIONS
$(document).off('click', '#received_completed_apps').on('click', '#received_completed_apps', function (e) {
  e.preventDefault();

  // Extract date range
  const dateFrom = startDate;
  const dateTo = endDate;

  const newDateStart = $('#startdate').val();
  const newDateEnd = $('#enddate').val();

  console.log("Selected range:", newDateStart, newDateEnd);

  // Dynamic title
  const title = `APPLICATIONS RECEIVED AND COMPLETED BETWEEN ${newDateStart} AND ${newDateEnd}`.toUpperCase();
  document.getElementById('recieved_applications_title').innerHTML = title;

  // Show report modal
  $("#recieved_reporting_modal").modal("show");

  // Reset table
  $('#main_service_table').DataTable().clear().destroy();

  // Fetch data via AJAX
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_apps_recieved_completed',
      date_from: dateFrom,
      date_to: dateTo
    },
    cache: false,
    success: function (response) {
      console.log("Received & Completed response:", response);

      const json_result = JSON.parse(response);
      const apps = json_result.apps_at_division || [];

      const totalApplications = apps.length;
      const totalApplicationsSum = apps.reduce((sum, item) => sum + (item.total || 0), 0);

      if (totalApplications === 0) {
        alert(`No applications were received and completed between ${newDateStart} and ${newDateEnd}.`);
        return;
      }

      // Prepare dataset
      const dataSet = apps.map(item => {
        const service_name = item.service_name;
        const count = item.total;
        const percentage = totalApplicationsSum > 0 ? ((count / totalApplicationsSum) * 100).toFixed(1) + '%' : '0%';

        const action = `
          <a href="javascript:void(0)" 
             data-id="${item.business_process_id}" 
             data-name_full="${service_name}" 
             id="view_received_conpleted_apps_by_sub_service"
             class="btn btn-secondary btn-md shadow-sm px-3 py-2 rounded-lg">
             <i class="fa fa-cogs"></i> More Details
          </a>`;

        return [service_name, count, percentage, action];
      });

      // Update summary stats (if available)
      updateSummaryStats(json_result.data, totalApplications, totalApplicationsSum);

      // Initialize DataTable
      $('#main_service_table').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_On_Applications_Received_And_Completed_Between_${newDateStart}_and_${newDateEnd}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_On_Applications_Received_And_Completed_Between_${newDateStart}_and_${newDateEnd}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_On_Applications_Received_And_Completed_Between_${newDateStart}_and_${newDateEnd}`
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
                     This report is generated using the Enterprise Land Information System
                   </p>`
                )
                .css('font-size', '18px');
              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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
    },
    error: function (xhr, status, error) {
      console.error("Error fetching received and completed apps:", error);
      alert("An error occurred while loading received and completed applications. Please try again later.");
    }
  });
});








            ///Completed recieved

  // 📊 RECEIVED AND COMPLETED APPLICATIONS — BY SUB-SERVICE
$(document).off('click', '#view_received_conpleted_apps_by_sub_service').on('click', '#view_received_conpleted_apps_by_sub_service', function (e) {
  e.preventDefault();

  // Extract identifiers
  const business_process_id = $(this).data('id');
  const service_name = $(this).data('name_full');

  // Extract current date range
  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  // Build title
  const title = `${service_name} - RECEIVED AND COMPLETED BETWEEN ${newdatestart} AND ${newdateend}`.toUpperCase();
  document.getElementById('sub_service_modalLabel').innerHTML = title;

  // Display modal
  $("#sub_service_modal").modal("show");

  // Clear and reset table
  $('#sub_service_table').DataTable().clear().destroy();

  // AJAX request to fetch sub-service data
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_apps_by_subservices_received_completed',
      sub_serv_id: business_process_id,
      date_from: startDate,
      date_to: endDate
    },
    cache: false,
    success: function (response) {
      console.log("Received & Completed Sub-service Response:", response);

      const json_result = JSON.parse(response);
      const apps = json_result.apps_at_division || [];

      const totalApplications = apps.length;
      const totalApplicationsSum = apps.reduce((sum, item) => sum + (item.total || 0), 0);

      // Handle empty data
      if (totalApplications === 0) {
        alert(`No applications were received and completed for ${service_name} between ${newdatestart} and ${newdateend}.`);
        return;
      }

      // Prepare DataTable data
      const dataSet = apps.map(item => {
        const sub_service_name = item.sub_service_name;
        const total = item.total;
        const percentage = totalApplicationsSum > 0 ? ((total / totalApplicationsSum) * 100).toFixed(1) + '%' : '0%';

        const action = `
          <a href="javascript:void(0)" 
             data-id="${item.business_process_sub_id}" 
             data-name_full="${item.sub_service_name}" 
             id="view_received_completed_applications"
             class="btn btn-md btn-secondary shadow-sm px-3 py-2 rounded-lg">
             <i class="fas fa-clipboard-list"></i> View Applications
          </a>`;

        return [sub_service_name, total, percentage, action];
      });

      // Update summary widget
      updateSummaryStatsSubService(json_result.data, totalApplications, totalApplicationsSum);

      // Initialize DataTable
      $('#sub_service_table').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_On_${service_name}_Received_And_Completed_Between_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_On_${service_name}_Received_And_Completed_Between_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_On_${service_name}_Received_And_Completed_Between_${newdatestart}_and_${newdateend}`
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
                     This report is generated using the Enterprise Land Information System
                   </p>`
                )
                .css('font-size', '18px');
              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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
    },
    error: function (xhr, status, error) {
      console.error("Error loading received and completed sub-service data:", error);
      alert("An error occurred while fetching the received and completed sub-service data. Please try again later.");
    }
  });
});




    //RECEIVED COMPLETED APPLICATION
  //  VIEW APPLICATIONS - RECEIVED & COMPLETED (Detailed View)
$(document).off('click', '#view_received_completed_applications').on('click', '#view_received_completed_applications', function (e) {
  e.preventDefault();

  // Extract identifiers
  const subprocessid = $(this).data('id');
  const SubServicename = $(this).data('name_full');

  // Date range inputs
  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  // Build uppercase title
  const title = `${SubServicename} - RECEIVED AND COMPLETED BETWEEN ${newdatestart} AND ${newdateend}`.toUpperCase();
  document.getElementById('completed_apps_modalLabel').innerHTML = title;

  // Show modal
  $("#completed_apps_modal").modal("show");

  // Reset DataTable
  $('#completed_apps_table').DataTable().clear().destroy();

  // AJAX Request
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_applications_received_completed',
      sub_serv_sub_id: subprocessid,
      date_from: startDate,
      date_to: endDate
    },
    cache: false,
    success: function (response) {
      console.log("Received & Completed Applications Response:", response);

      const json_result = JSON.parse(response);
      const apps = json_result.apps_at_division || [];

      const totalApplications = apps.length;
      const totalApplicationsSum = apps.reduce((sum, item) => sum + (item.total || 0), 0);

      if (totalApplications === 0) {
        alert(`No applications found for ${SubServicename} between ${newdatestart} and ${newdateend}.`);
        return;
      }

      // Build DataTable rows
      const dataSet = apps.map(item => {
        const job_number = item.job_number;
        const ar_name = item.ar_name;
        const business_process_name = item.business_process_name;
        const created_date = item.created_date;
        const completed_date = item.completed_date;
        const turnaround_time = item.turnaround_days;

        const action = `
          <div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
            </button>
            <div class="dropdown-menu">
              <button type="button" class="dropdown-item" id="btn_cabinet"
                data-target-id="${job_number}"
                data-toggle="modal"
                data-target="#cabinetModal"
                title="View Application Progress">
                Track <i class="fas fa-hdd"></i>
              </button>
              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" value="${item.transaction_number}">
                <input type="hidden" name="search_text" value="${item.case_number}">
                <input type="hidden" name="job_number" value="${job_number}">
                <input type="hidden" name="business_process_sub_name" value="${item.case_number}">
                <button type="submit" name="save" class="dropdown-item">
                  Application Details <i class="fas fa-info-circle"></i>
                </button>
              </form>
            </div>
          </div>`;

        return [
          job_number,
          ar_name,
          business_process_name,
          created_date,
          completed_date,
          turnaround_time,
          action
        ];
      });

      // Update Summary Section
      updateSummaryStatsRecApplicationsCompleted(json_result.data, totalApplications, totalApplicationsSum);

      // Initialize DataTable
      $('#completed_apps_table').DataTable({
        data: dataSet,
        dom: 'Bfrtip',
        paging: true,
        lengthChange: true,
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
            title: title,
            filename: `Report_on_${SubServicename}_RECEIVED_COMPLETED_BETWEEN_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_on_${SubServicename}_RECEIVED_COMPLETED_BETWEEN_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_on_${SubServicename}_RECEIVED_COMPLETED_BETWEEN_${newdatestart}_and_${newdateend}`
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
                     This report is generated using the Enterprise Land Information System
                   </p>`
                )
                .css('font-size', '18px');
              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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
    },
    error: function (xhr, status, error) {
      console.error("Error fetching received & completed applications:", error);
      alert("An error occurred while fetching application data. Please try again later.");
    }
  });
});

      







               //QUERIED APPLICATIONS      

   $(document).off('click', '#queried_apps').on('click', '#queried_apps', function (e) {                  
      // $('#queried_apps').on('click', function(e) {
        e.preventDefault();


        let datefrom = startDate;
        let dateto = endDate;

 var new_date_start = $('#startdate').val();
   var new_date_end = $('#enddate').val();



        console.log(new_date_start,new_date_end);
   
        // let date_fromm = new_date_start;
        // let date_too = new_date_end;


        // console.log(date_from,date_to);

     var title = "APPLICATIONS QUERIED";    
    document.getElementById('recieved_applications_title').innerHTML = title;
    
     $("#recieved_reporting_modal").modal("show");  
    
    //  var regional_code = $('#csau_manager_regional_code').val();
    //  console.log(regional_code);
    
     $.ajax({
         type : "POST",
         url : "executive_dashboard",
         data : {
             request_type : 'executive_dashboard_apps_queried',
              date_from : datefrom,
            date_to : dateto
         },
         cache: false,
         success: function(response) {
             console.log(response);
    
             var json_result = JSON.parse(response);


             totalApplications = json_result.apps_at_division?.length ?? 0;
             totalApplicationsSum = json_result.apps_at_division
    ? json_result.apps_at_division.reduce((sum, item) => sum + (item.total || 0), 0)
    : 0;

console.log(totalApplicationsSum);

            console.log(json_result.apps_at_division);

            console.log(totalApplications);



             if (json_result.apps_at_division == null){

                alert ("No applications has been Queried within Selected Dates. Please check back later")
    
                //  console.log("data not found");       
    
    }else {
    
    
    let dataSet8 = [];
    let num8 = 0;
    
    $('#main_service_table').DataTable().clear().destroy();
    
    
       for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num8 = +num8 + 1;
    
        let service_name = json_result.apps_at_division[i].service_name;
        let count = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].business_process_id}" data-name_full="${json_result.apps_at_division[i].service_name}" id="view_queried_apps_by_sub_service"  
        class="btn btn-secondary btn-md"> <i class="fa fa-cogs"></i> More details </a> `
      let percentage = totalApplicationsSum > 0 ? ((count / totalApplicationsSum) * 100).toFixed(1) + '%' : '0%';

    //   console.log(percentage);

    
    
        
    
        html.push(service_name);
        html.push(count);
        html.push(percentage);
        html.push(action);
      
    
        dataSet8.push(html);
    
      //console.log(dataSet)
      }

      updateSummaryStats(json_result.data, totalApplications,totalApplicationsSum );

    
    
      $('#main_service_table').DataTable().clear().destroy();
                    
      $('#main_service_table').DataTable({ data: dataSet8,
        dom: 'Blfrtip',   // <-- added "l" to show length menu
    paging: true,
        lengthMenu : [
            [ 10, 25, 50, -1 ],
            [ '10 rows', '25 rows',
                '50 rows', 'Show all' ] ],
        
                buttons: [   
                    {
                        extend: 'csv',
                        title: `Report On Applications Queried  Between ${new_date_start} and ${new_date_end}`,
                        filename: `Report_On_Applications_queried_Between_${new_date_start}_and_${new_date_end}`
                    },
                    {
                        extend: 'excel',
                        title: `Report On Applications Queried  Between ${new_date_start} and ${new_date_end}`,
                        filename: `Report_On_Applications_queried_Between_${new_date_start}_and_${new_date_end}`
                    },
                    {
                        extend: 'pdf',
                        title: `Report On Applications Queried  Between ${new_date_start} and ${new_date_end}`,
                        filename: `Report_On_Applications_queried_Between_${new_date_start}_and_${new_date_end}`
                    },
                    {
                        extend: 'print',
                      title: `<h3>Report on Applications Queried BETWEEN ${newdatestart} and ${newdateend}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ]
        
        
        
        }).draw();
    
    
    }
    
    
         }
     })
    
    
    }) 






            ///Queried by sub Services
$(document).off('click', '#view_queried_apps_by_sub_service').on('click', '#view_queried_apps_by_sub_service', function (e) {                  
// $(document).on('click','#view_queried_apps_by_sub_service',function(e){
        e.preventDefault();
        var business_process_id=$(this).data('id');
       
        var service_name=$(this).data('name_full');

        var title = service_name+"'S"+ " " + "QUERIED";    

      
        document.getElementById('sub_service_modalLabel').innerHTML = title;
      

      $("#sub_service_modal").modal("show");  

      
       let dataSet11 = [];
       let num11 = 0;
      
      $('#sub_service_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "executive_dashboard",
           data : {
               request_type : 'executive_dashboard_apps_by_subservices_queried',
               sub_serv_id : business_process_id,
                date_from :startDate,
            date_to : endDate
           },
           cache: false,
           success: function(response) {
      
        //    console.log(response)
      
               var json_result = JSON.parse(response);
              console.log(json_result)

               totalApplications = json_result.apps_at_division?.length ?? 0;
             totalApplicationsSum = json_result.apps_at_division
    ? json_result.apps_at_division.reduce((sum, item) => sum + (item.total || 0), 0)
    : 0;

console.log(totalApplicationsSum);


      
               if (json_result.apps_at_division == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num11 = +num11 + 1;
      
          let sub_service_name = json_result.apps_at_division[i].sub_service_name;
          let total = json_result.apps_at_division[i].total;
          let percentage = totalApplicationsSum > 0 ? ((total / totalApplicationsSum) * 100).toFixed(1) + '%' : '0%';
           let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].business_process_sub_id}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_queried_applications"  
        class="btn btn-md btn-secondary"> <i class="fas fa-clipboard-list"></i> View Applications </a> `
          
      
          html.push(sub_service_name);
          html.push(total);
           html.push(percentage);
          html.push(action);
         
         
      
          dataSet11.push(html);
      
        
        }

    

       updateSummaryStatsSubService(json_result.data, totalApplications,totalApplicationsSum );

     
        $('#sub_service_table').DataTable().clear().destroy();
                      
        $('#sub_service_table').DataTable({ data: dataSet11,
            dom : 'Blfrtip',
                paging: true,
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],

                    // var title = user_created_name+ " " + " RECIEVED BETWEEN"+ ' ' + startDate + ' ' +"AND "+ " " +endDate;    
                    buttons: [   
                        {
                            extend: 'csv',
                            title: `Report on ${service_name} QUERIED BETWEEN ${newdatestart} and ${newdateend}`,
                            filename: `Report_On_${service_name}_queried_Between_${newdatestart}_and_${newdateend}`
                        },
                        {
                            extend: 'excel',
                            title: `Report on ${service_name} QUERIED BETWEEN ${newdatestart} and ${newdateend}`,
                            filename: `Report_On_${service_name}_queried_Between_${newdatestart}_and_${newdateend}`
                        },
                        {
                            extend: 'pdf',
                            title: `Report on ${service_name} QUERIED BETWEEN ${newdatestart} and ${newdateend}`,
                            filename: `Report_On_${service_name}_queried_Between_${newdatestart}_and_${newdateend}`
                        },
                        {
                            extend: 'print',
                            title: `<h3>Report on ${service_name} QUERIED BETWEEN ${newdatestart} and ${newdateend}</h3>`,
                            message: 'This report is generated using the Enterprise Land Information System'
                        }
                    ]
            
            
            }).draw();
      
      }
              
      
      
           }
       })
       
      
      });





          // QUERIED APPLICATION
$(document).on('click','#view_queried_applications',function(e){
        e.preventDefault();
       
        var subprocessid=$(this).data('id');
       
        var SubServicename=$(this).data('name_full');


        var title = SubServicename + " "+ "QUERIED";  
      
        document.getElementById('apps_modalLabel').innerHTML = title;

        
        $("#apps_modal").modal("show");  


      
       let dataSet2 = [];
       let num2 = 0;
      
      $('#apps_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "executive_dashboard",
           data : {
               request_type : 'executive_dashboard_applications_queried',
               sub_serv_sub_id : subprocessid,
               date_from : startDate,
           date_to : endDate
           },
           cache: false,
           success: function(response) {
      
            console.log(response)
      
               var json_result = JSON.parse(response);
               console.log(json_result.apps_at_division)

              totalApplications = json_result.apps_at_division?.length ?? 0;

      
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num2 = +num2 + 1;
      
          let job_number = json_result.apps_at_division[i].job_number;
          let ar_name = json_result.apps_at_division[i].ar_name;
          let business_process_name = json_result.apps_at_division[i].business_process_name;
          let created_date = json_result.apps_at_division[i].created_date;
          let days_due = json_result.apps_at_division[i].days_due;
          let daysdue = json_result.apps_at_division[i].days_due;
          let days_since_received = json_result.apps_at_division[i].days_since_received;
         let action = `<div class="btn-group" role="group">
         <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
           Actions
         </button>
         <div class="dropdown-menu">  
         <button type="button" class="dropdown-item" href="#" id="btn_cabinet" data-staff_name="" data-staff_id="" data-job_number="" title="View Application Progress" data-target-id="${json_result.apps_at_division[i].job_number}" data-target="#cabinetModal" data-toggle="modal">Track <i class="fas fa-hdd"></i></button>
         <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
           <input type="hidden" name="case_number" id="case_number" value="${json_result.apps_at_division[i].transaction_number}">
           <input type="hidden" name="search_text" id="search_text" value="${json_result.apps_at_division[i].case_number}">
           <input type="hidden" name="job_number" id="job_number" value=""${json_result.apps_at_division[i].job_number}">
           <input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value=""${json_result.apps_at_division[i].case_number}">
           <button type="submit" name="save" class="dropdown-item" >Application Details <i class="fas fa-info-circle"></i></button>
         </form> 
         </div>
       </div>`;
    
      
          html.push(job_number);
          html.push(ar_name);
          html.push(business_process_name);
          html.push(created_date);
          html.push(days_due);
          html.push(daysdue);
          html.push(days_since_received);
          html.push(action);
      
          dataSet2.push(html);
      
        //console.log(dataSet)
        }
      
   
      
        $('#apps_table').DataTable().clear().destroy();
                      
        $('#apps_table').DataTable({ data: dataSet2,
          dom : 'Blfrtip',
              paging: true,
            lengthChange: true,   // <-- ensure this is enabled
          lengthMenu : [
              [ 10, 25, 50, -1 ],
              [ '10 rows', '25 rows',
                  '50 rows', 'Show all' ] ],

                //   servicetobankname + " "+ "Recieved From"+ " " + bank_name+ " " + "Between" + ' ' + startDate + ' ' +"AND "+ " " +endDate;
         
                  buttons: [   
                    {
                        extend: 'csv',
                        title: `Report on ${SubServicename} QUERIED  BETWEEN ${newdatestart} and ${newdateend}`,
                        filename: `Report_on_${SubServicename}_QUERIED_BETWEEN_${newdatestart}_and_${newdateend}`
                    },
                    {
                        extend: 'excel',
                        title: `Report on ${SubServicename} QUERIED BETWEEN ${newdatestart} and ${newdateend}`,
                        filename: `Report_on_${SubServicename}_QUERIED_BETWEEN_${newdatestart}_and_${newdateend}`
                    },
                    {
                        extend: 'pdf',
                        title: `Report on ${SubServicename} QUERIED ${newdatestart} and ${newdateend}`,
                        filename: `Report_on_${SubServicename}_QUERIED_BETWEEN_${newdatestart}_and_${newdateend}`
                    },
                    {
                        extend: 'print',
                        title: `<h3>Report on ${SubServicename} QUERIED ${newdatestart} and ${newdateend}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ]

            
            
            }).draw();
      
    //  }
              
     
      
      
           }
       })
      
      });






//  APPLICATIONS STATUS BY REGIONS (Pending vs Received)
$(document).off('click', '#pending_received_apps').on('click', '#pending_received_apps', function (e) {
  e.preventDefault();

  // Extract selected dates
  const dateFrom = startDate;
  const dateTo = endDate;
  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  console.log(`Selected Dates: ${newdatestart} to ${newdateend}`);

  // Modal title
  const title = `APPLICATIONS STATUS BY REGIONS (${newdatestart} - ${newdateend})`;
  document.getElementById('status_title').innerHTML = title;

  // Show modal
  $("#status_modal").modal("show");

  // Reset DataTable
  $('#status_table').DataTable().clear().destroy();

  // AJAX request
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_report_received_vs_pending',
      date_from: dateFrom,
      date_to: dateTo
    },
    cache: false,
    success: function (response) {
      console.log("📩 AJAX Response:", response);

      const json_result = JSON.parse(response);
      console.log("✅ Parsed Result:", json_result);

      // Calculate totals
      const received = json_result.received ?? 0;
      const pending = json_result.pending ?? 0;
      const completed = json_result.completed ?? 0;
      const recCompleted = json_result.rec_completed ?? 0;

      const totalApplicationsSum = received + pending + completed + recCompleted;
      const totalApplications = totalApplicationsSum;

      console.log("Total Applications Sum:", totalApplicationsSum);

      // Handle empty response
      if (
        json_result.success === false ||
        (received === 0 && pending === 0 && completed === 0 && recCompleted === 0)
      ) {
        alert("⚠️ No records found within the selected date range. Please check back later.");
        return;
      }

      // Helper: create "More Details" button
      const buildActionButton = (statusKey, statusLabel) => `
        <a href="javascript:void(0)"
           data-id="${statusKey}"
           data-name_full="${statusLabel}"
           id="view_regional_applications"
           class="btn btn-md btn-secondary">
           <i class="fa fa-cogs"></i> More Details
        </a>`;

      // Prepare data for DataTable
      const dataSet = [
        ["Received Applications", received, buildActionButton("received", "Received Applications")],
        ["Pending Applications", pending, buildActionButton("pending", "Pending Applications")],
        ["Completed Applications", completed, buildActionButton("completed", "Completed Applications")],
        ["Received & Completed Applications", recCompleted, buildActionButton("receivedcompleted", "Received & Completed Applications")]
      ];

      // Update summary stats
      updateSummaryStatusRegions(json_result.data, totalApplications, totalApplicationsSum);

      // Initialize DataTable
      $('#status_table').DataTable({
        data: dataSet,
        columns: [
          { title: "Status" },
          { title: "Count" },
          { title: "Action", orderable: false, searchable: false }
        ],
        dom: 'Bfrtip',
        paging: true,
        lengthChange: true,
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
            title: title,
            filename: `Report_on_Applications_Status_By_Regions_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_on_Applications_Status_By_Regions_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_on_Applications_Status_By_Regions_${newdatestart}_to_${newdateend}`
          },
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
                  </p>`)
                .css('font-size', '18px');
              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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
    },
    error: function (xhr, status, error) {
      console.error("Error loading status data:", error);
      alert("An error occurred while fetching application status data. Please try again later.");
    }
  });
});




$(document).off('click', '#com_received_apps').on('click', '#com_received_apps', function (e) {                  

        e.preventDefault();


        let datefrom = startDate;
        let dateto = endDate;

 var new_date_start = $('#startdate').val();
   var new_date_end = $('#enddate').val();



        console.log(new_date_start,new_date_end);
   
        // let date_fromm = new_date_start;
        // let date_too = new_date_end;


        // console.log(date_from,date_to);

     var title = "APPLICATIONS STATUS BY REGIONS";    
    document.getElementById('status_title').innerHTML = title;
    
     $("#status_modal").modal("show");  
    
    //  var regional_code = $('#csau_manager_regional_code').val();
    //  console.log(regional_code);
    
     $.ajax({
         type : "POST",
         url : "executive_dashboard",
         data : {
             request_type : 'executive_dashboard_report_received_vs_pending',
              date_from : datefrom,
            date_to : dateto
         },
         cache: false,
         success: function(response) {
             console.log(response);
    
             var json_result = JSON.parse(response);

             console.log(json_result);


           totalApplicationsSum =
  (json_result.received ?? 0) + (json_result.pending ?? 0) +(json_result.completed ?? 0) +(json_result.rec_completed ?? 0) ;

  totalApplications =
  (json_result.received ?? 0) + (json_result.pending ?? 0) + (json_result.completed ?? 0) + (json_result.rec_completed ?? 0);


console.log(totalApplicationsSum);
             

            // console.log(json_result.apps_at_division);

            console.log(totalApplications);



if (json_result.success === false || 
    (json_result.received == null && json_result.pending == null)) {
    
    alert("No Record within Selected Dates. Please check back later");

} else {
    let dataSet8 = [];

    $('#status_table').DataTable().clear().destroy();

    // Example action button template
    function buildActionButton(statusKey, statusLabel) {
        return `<a href="javascript:void(0)" 
                   data-id="${statusKey}" 
                   data-name_full="${statusLabel}" 
                   id="view_regional_applications"  
                   class="btn btn-md btn-secondary">
                   <i class="fa fa-cogs"></i> More Details
                </a>`;
    }

    // Build dataset with action buttons
    dataSet8.push(["Received Applications", json_result.received, buildActionButton("received", "Received Applications")]);
    dataSet8.push(["Pending Applications", json_result.pending, buildActionButton("pending", "Pending Applications")]);
    dataSet8.push(["Completed Applications", json_result.completed, buildActionButton("completed", "Pending Applications")]);
    dataSet8.push(["Received & Completed Applications", json_result.rec_completed, buildActionButton("receivedcompleted", "Received & Applications")]);

     updateSummaryStatusRegions(json_result.data, totalApplications,totalApplicationsSum );



    $('#status_table').DataTable({
        data: dataSet8,
        columns: [
            { title: "Status" },
            { title: "Count" },
            { title: "Action", orderable: false, searchable: false }
        ],
        dom: 'Blfrtip',
        paging: true,
        lengthMenu: [
            [10, 25, 50, -1],
            ['10 rows', '25 rows', '50 rows', 'Show all']
        ],
        buttons: [
            {
                extend: 'csv',
                title: `Report On Applications Between ${new_date_start} and ${new_date_end}`,
                filename: `Report_On_Applications_Between_${new_date_start}_and_${new_date_end}`
            },
            {
                extend: 'excel',
                title: `Report On Applications Between ${new_date_start} and ${new_date_end}`,
                filename: `Report_On_Applications_Between_${new_date_start}_and_${new_date_end}`
            },
            {
                extend: 'pdf',
                title: `Report On Applications Between ${new_date_start} and ${new_date_end}`,
                filename: `Report_On_Applications_Between_${new_date_start}_and_${new_date_end}`
            },
            {
                extend: 'print',
                title: `<h3>Report on Applications BETWEEN ${new_date_start} and ${new_date_end}</h3>`,
                message: 'This report is generated using the Enterprise Land Information System'
            }
        ]
    }).draw();
}
    
    
         }
     })
    
    
    }) 






   
              // Regional APPLICATIONs
$(document).off('click', '#view_regional_applications').on('click', '#view_regional_applications', function (e) {                  

// $(document).on('click','#view_regional_applications',function(e){
        e.preventDefault();
       
        var status=$(this).data('id');
       
        var Statustitle=$(this).data('name_full');


        console.log(status,Statustitle);


        var title = status + " "+ "APPLICATIONS BY REGIONS";  
      
        document.getElementById('region_title').innerHTML = title.toUpperCase();

        
        $("#regional_modal").modal("show");  


       let dataSet2 = [];
       let num2 = 0;
      
      $('#regions_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "executive_dashboard",
           data : {
               request_type : 'executive_dashboard_apps_by_regions',
               status : status,
               date_from : startDate,
           date_to : endDate
           },
           cache: false,
           success: function(response) {
      
            console.log(response)
      
               var json_result = JSON.parse(response);
               console.log(json_result.apps_at_division)

totalApplications = json_result.apps_at_division?.length ?? 0;
             totalApplicationsSum = json_result.apps_at_division
    ? json_result.apps_at_division.reduce((sum, item) => sum + (item.total || 0), 0)
    : 0;
      
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num2 = +num2 + 1;
      
          let ord_region_name = json_result.apps_at_division[i].ord_region_name;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].ord_region_code}" data-name_full="${json_result.apps_at_division[i].ord_region_name}" data-stats="${status}" id="view_regional_applications_by_divisions"  
        class="btn btn-md btn-secondary"> <i class="fas fa-clipboard-list"></i> View Divisions </a> `;
    
      
          html.push(ord_region_name);
          html.push(total);
          html.push(action);
      
          dataSet2.push(html);
      
        //console.log(dataSet)
        }
      

        updateSummaryStatusRegionsData(json_result.data, totalApplications,totalApplicationsSum );

   
      
        $('#regions_table').DataTable().clear().destroy();
                      
        $('#regions_table').DataTable({ data: dataSet2,
          dom : 'Blfrtip',
              paging: true,
            lengthChange: true,   // <-- ensure this is enabled
          lengthMenu : [
              [ 10, 25, 50, -1 ],
              [ '10 rows', '25 rows',
                  '50 rows', 'Show all' ] ],

                //   servicetobankname + " "+ "Recieved From"+ " " + bank_name+ " " + "Between" + ' ' + startDate + ' ' +"AND "+ " " +endDate;
         
                  buttons: [   
                    {
                        extend: 'csv',
                        title: `Report on ${Statustitle} APPLICATIONS  BETWEEN ${newdatestart} and ${newdateend}`,
                        filename: `Report_on_${Statustitle}_APPLICATIONS_BETWEEN_${newdatestart}_and_${newdateend}`
                    },
                    {
                        extend: 'excel',
                        title: `Report on ${Statustitle} APPLICATIONS  BETWEEN ${newdatestart} and ${newdateend}`,
                        filename: `Report_on_${Statustitle}_APPLICATIONS_BETWEEN_${newdatestart}_and_${newdateend}`
                    },
                    {
                        extend: 'pdf',
                        title: `Report on ${Statustitle} APPLICATIONS  BETWEEN ${newdatestart} and ${newdateend}`,
                        filename: `Report_on_${Statustitle}_APPLICATIONS_BETWEEN_${newdatestart}_and_${newdateend}`
                    },
                    {
                        extend: 'print',
                        title: `<h3>Report on ${Statustitle} APPLICATIONS ${newdatestart} and ${newdateend}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ]

            
            
            }).draw();
      
    //  }
              
     
      
      
           }
       })



      
      });




                    // Regional APPLICATIONs

$(document).off('click', '#view_regional_applications_by_divisions').on('click', '#view_regional_applications_by_divisions', function (e) {                  

// $(document).on('click','#view_regional_applications_by_divisions',function(e){
        e.preventDefault();
       
        var regionid=$(this).data('id');
       
        var regionName=$(this).data('name_full');
         var AppStatus=$(this).data('stats');

        


        console.log(regionid,regionName);


        var title = regionName + " "+ AppStatus+ " "+ "APPLICATIONS";  
      
        document.getElementById('regional_divisions_title').innerHTML = title.toUpperCase();

        
        $("#regional_divisions_modal").modal("show");  


       let dataSet2 = [];
       let num2 = 0;
      
      $('#regional_divisions_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "executive_dashboard",
           data : {
               request_type : 'executive_dashboard_apps_by_regions_to_divisions',
               region_code : regionid,
               status : AppStatus,
               date_from : startDate,
           date_to : endDate
           },
           cache: false,
           success: function(response) {
      
            console.log(response)
      
               var json_result = JSON.parse(response);
               console.log(json_result.apps_at_division)

totalApplications = json_result.apps_at_division?.length ?? 0;
             totalApplicationsSum = json_result.apps_at_division
    ? json_result.apps_at_division.reduce((sum, item) => sum + (item.total || 0), 0)
    : 0;
      
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num2 = +num2 + 1;
      
          let division = json_result.apps_at_division[i].division;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${regionid}" data-name_full="${json_result.apps_at_division[i].division}" data-status="${AppStatus}" data-regionname="${regionName}"  id="view_regional_applications_by_divisions_by_services"  
        class="btn btn-md btn-secondary"> <i class="fas fa-cogs"></i> View Services </a> `;
    
      
          html.push(division);
          html.push(total);
          html.push(action);
      
          dataSet2.push(html);
      
        //console.log(dataSet)
        }
      

        updateSummaryStatusRegionsDivisionsNew(json_result.data, totalApplications,totalApplicationsSum );

   
      
        $('#regional_divisions_table').DataTable().clear().destroy();
                      
        $('#regional_divisions_table').DataTable({ data: dataSet2,
          dom : 'Blfrtip',
              paging: true,
            lengthChange: true,   // <-- ensure this is enabled
          lengthMenu : [
              [ 10, 25, 50, -1 ],
              [ '10 rows', '25 rows',
                  '50 rows', 'Show all' ] ],

                //   servicetobankname + " "+ "Recieved From"+ " " + bank_name+ " " + "Between" + ' ' + startDate + ' ' +"AND "+ " " +endDate;
         
                  buttons: [   
                    {
                        extend: 'csv',
                        title: `Report on ${regionName} APPLICATIONS  BETWEEN ${newdatestart} and ${newdateend}`,
                        filename: `Report_on_${regionName}_APPLICATIONS_BETWEEN_${newdatestart}_and_${newdateend}`
                    },
                    {
                        extend: 'excel',
                        title: `Report on ${regionName} APPLICATIONS  BETWEEN ${newdatestart} and ${newdateend}`,
                        filename: `Report_on_${regionName}_APPLICATIONS_BETWEEN_${newdatestart}_and_${newdateend}`
                    },
                    {
                        extend: 'pdf',
                        title: `Report on ${regionName} APPLICATIONS  BETWEEN ${newdatestart} and ${newdateend}`,
                        filename: `Report_on_${regionName}_APPLICATIONS_BETWEEN_${newdatestart}_and_${newdateend}`
                    },
                    {
                        extend: 'print',
                        title: `<h3>Report on ${regionName} APPLICATIONS ${newdatestart} and ${newdateend}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ]

            
            
            }).draw();
      
    //  }
              
     
      
      
           }
       })



      
      });




  //. RE 
// REGIONAL DIVISION → SERVICES (View Sub-Services)
$(document)
  .off('click', '#view_regional_applications_by_divisions_by_services')
  .on('click', '#view_regional_applications_by_divisions_by_services', function (e) {
    e.preventDefault();

    // Extract dataset info
    const regionId = $(this).data('id');
    const division = $(this).data('name_full');
    const AppStatus = $(this).data('status');
    const regionName = $(this).data('regionname');

    console.log("🌍 Region:", regionName, "| ID:", regionId, "| Division:", division, "| Status:", AppStatus);

    // Build and display title
    const title = `${division} ${regionName} ${AppStatus} BY SERVICES`.toUpperCase();
    document.getElementById('recieved_applications_title').innerHTML = title;
    $("#recieved_reporting_modal").modal("show");

    // Selected date range
    const newdatestart = $('#startdate').val();
    const newdateend = $('#enddate').val();

    // Reset table before load
    $('#main_service_table').DataTable().clear().destroy();

    // AJAX call
    $.ajax({
      type: "POST",
      url: "executive_dashboard",
      data: {
        request_type: 'executive_dashboard_divisions_services',
        region_code: regionId,
        division: division,
        status: AppStatus,
        date_from: startDate,
        date_to: endDate
      },
      cache: false,
      success: function (response) {
        console.log("Division → Services Response:", response);

        const json_result = JSON.parse(response);
        const services = json_result.apps_at_division || [];

        const totalApplications = services.length;
        const totalApplicationsSum = services.reduce((sum, item) => sum + (item.total || 0), 0);

        if (services.length === 0) {
          alert(`⚠️ No ${AppStatus.toLowerCase()} applications found for ${division} (${regionName}) between ${newdatestart} and ${newdateend}.`);
          return;
        }

        // Prepare data for DataTable
        const dataSet = services.map(item => {
          const serviceName = item.service_name;
          const total = item.total;
          const percentage = totalApplicationsSum > 0 ? ((total / totalApplicationsSum) * 100).toFixed(1) + '%' : '0%';
          const action = `
            <a href="javascript:void(0)" 
               data-id="${item.business_process_id}" 
               data-name_full="${item.service_name}" 
               data-status="${AppStatus}" 
               data-region="${regionId}"  
               data-regionname="${regionName}"  
               data-division="${division}"  
               id="view_regional_applications_by_divisions_by_subservices"
               class="btn btn-md btn-secondary shadow-sm px-3 py-2 rounded-lg">
               <i class="fas fa-cogs"></i> View Sub Services
            </a>`;

          return [serviceName, total, percentage, action];
        });

        // Update summary stats
        updateSummaryStats(json_result.data, totalApplications, totalApplicationsSum);

        // Initialize DataTable
        $('#main_service_table').DataTable({
          data: dataSet,
          columns: [
            { title: "Service Name" },
            { title: "Total Applications" },
            { title: "Percentage" },
            { title: "Action", orderable: false, searchable: false }
          ],
          dom: 'Bfrtip',
          paging: true,
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
              title: title,
              filename: `Report_on_${division}_${regionName}_${AppStatus}_Applications_Between_${newdatestart}_and_${newdateend}`
            },
            {
              extend: 'excel',
              title: title,
              filename: `Report_on_${division}_${regionName}_${AppStatus}_Applications_Between_${newdatestart}_and_${newdateend}`
            },
            {
              extend: 'pdf',
              title: title,
              filename: `Report_on_${division}_${regionName}_${AppStatus}_Applications_Between_${newdatestart}_and_${newdateend}`
            },
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
                    </p>`)
                  .css('font-size', '18px');
                $(win.document.body).find('table')
                  .addClass('compact')
                  .css('font-size', '16px')
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
      },
      error: function (xhr, status, error) {
        console.error("Error loading division services data:", error);
        alert("An error occurred while loading division services data. Please try again later.");
      }
    });
  });


      



   // REGIONAL DIVISION → SUB-SERVICES
$(document)
  .off('click', '#view_regional_applications_by_divisions_by_subservices')
  .on('click', '#view_regional_applications_by_divisions_by_subservices', function (e) {
    e.preventDefault();

    // Extract key dataset attributes
    const businessProcessId = $(this).data('id');
    const serviceName = $(this).data('name_full');
    const regionId = $(this).data('region');
    const status = $(this).data('status');
    const division = $(this).data('division');
    const regionName = $(this).data('regionname');

    // Retrieve selected date range
    const newdatestart = $('#startdate').val();
    const newdateend = $('#enddate').val();

    console.log("🌍 Division → Sub-Services:", { regionId, regionName, division, serviceName, status });

    // Create title
    const title = `${division} ${regionName} - ${serviceName} (${status})`.toUpperCase();
    document.getElementById('sub_service_modalLabel').innerHTML = title;

    // Show modal
    $("#sub_service_modal").modal("show");

    // Reset existing DataTable
    $('#sub_service_table').DataTable().clear().destroy();

    // AJAX request
    $.ajax({
      type: "POST",
      url: "executive_dashboard",
      data: {
        request_type: 'executive_dashboard_divisions_sub_services',
        status: status,
        region_code: regionId,
        sub_service_id: businessProcessId,
        division: division,
        date_from: startDate,
        date_to: endDate
      },
      cache: false,
      success: function (response) {
        console.log("Sub-Service Response:", response);

        const json_result = JSON.parse(response);
        const subServices = json_result.apps_at_division || [];

        const totalApplications = subServices.length;
        const totalApplicationsSum = subServices.reduce((sum, item) => sum + (item.total || 0), 0);

        if (subServices.length === 0) {
          alert(` No ${status.toLowerCase()} applications found for ${serviceName} under ${division} (${regionName}) between ${newdatestart} and ${newdateend}.`);
          return;
        }

        // Build dataset
        const dataSet = subServices.map(item => {
          const subServiceName = item.sub_service_name;
          const total = item.total;
          const percentage = totalApplicationsSum > 0
            ? ((total / totalApplicationsSum) * 100).toFixed(1) + '%'
            : '0%';
          const action = `
            <a href="javascript:void(0)" 
               data-id="${item.business_process_sub_id}" 
               data-name_full="${item.sub_service_name}" 
               data-status="${status}" 
               data-region="${regionId}"  
               data-regionname="${regionName}"  
               data-division="${division}"  
               id="view_regional_by_divisions_by_subservices_apps"  
               class="btn btn-md btn-secondary shadow-sm px-3 py-2 rounded-lg">
               <i class="fas fa-clipboard-list"></i> View Applications
            </a>`;

          return [subServiceName, total, percentage, action];
        });

        // Update stats summary
        updateSummaryStatsSubService(json_result.data, totalApplications, totalApplicationsSum);

        // Initialize DataTable
        $('#sub_service_table').DataTable({
          data: dataSet,
          columns: [
            { title: "Sub-Service Name" },
            { title: "Total Applications" },
            { title: "Percentage" },
            { title: "Action", orderable: false, searchable: false }
          ],
          dom: 'Bfrtip',
          paging: true,
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
              title: title,
              filename: `Report_on_${division}_${regionName}_${serviceName}_${status}_Subservices_Between_${newdatestart}_and_${newdateend}`
            },
            {
              extend: 'excel',
              title: title,
              filename: `Report_on_${division}_${regionName}_${serviceName}_${status}_Subservices_Between_${newdatestart}_and_${newdateend}`
            },
            {
              extend: 'pdf',
              title: title,
              filename: `Report_on_${division}_${regionName}_${serviceName}_${status}_Subservices_Between_${newdatestart}_and_${newdateend}`
            },
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
                    </p>`)
                  .css('font-size', '18px');
                $(win.document.body).find('table')
                  .addClass('compact')
                  .css('font-size', '16px')
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
      },
      error: function (xhr, status, error) {
        console.error("Error loading sub-service data:", error);
        alert("An error occurred while loading sub-service data. Please try again later.");
      }
    });
  });  



      //View Applications by regions

// REGIONAL DIVISION → SUB-SERVICE → APPLICATIONS
$(document)
  .off('click', '#view_regional_by_divisions_by_subservices_apps')
  .on('click', '#view_regional_by_divisions_by_subservices_apps', function (e) {
    e.preventDefault();

    // Extract key attributes
    const businessProcessId = $(this).data('id');
    const subServiceName = $(this).data('name_full');
    const regionId = $(this).data('region');
    const status = $(this).data('status');
    const division = $(this).data('division');
    const regionName = $(this).data('regionname');

    // Get date range
    const newdatestart = $('#startdate').val();
    const newdateend = $('#enddate').val();

    console.log("🌍 Sub-Service → Applications:", { regionId, regionName, division, subServiceName, status });

    // Construct title dynamically
    const title = `${division} ${regionName} - ${subServiceName} (${status})`.toUpperCase();

    // Determine which modal to show
    const isCompleted = status === 'completed' || status === 'receivedcompleted';
    const modalId = isCompleted ? '#completed_apps_modal' : '#apps_modal';
    const tableId = isCompleted ? '#completed_apps_table' : '#apps_table';
    const modalLabelId = isCompleted ? '#completed_apps_modalLabel' : '#apps_modalLabel';

    $(modalId).modal("show");
    document.querySelector(modalLabelId).innerHTML = title;

    // Reset DataTable
    $(tableId).DataTable().clear().destroy();

    // AJAX Request
    $.ajax({
      type: "POST",
      url: "executive_dashboard",
      data: {
        request_type: 'executive_dashboard_divisions_sub_services_applications',
        status: status,
        region_code: regionId,
        business_process_sub_id: businessProcessId,
        division: division,
        date_from: startDate,
        date_to: endDate
      },
      cache: false,
      success: function (response) {
        console.log("Applications Response:", response);

        const json_result = JSON.parse(response);
        const applications = json_result.apps_at_division || [];
        const totalApplications = applications.length;

        if (applications.length === 0) {
          alert(`No ${status} applications found for ${subServiceName} under ${division} (${regionName}) between ${newdatestart} and ${newdateend}.`);
          return;
        }

        // Build dataset for table
        const dataSet = applications.map(app => {
          const {
            job_number,
            ar_name,
            business_process_name,
            created_date,
            completed_date,
            turnaround_days,
            job_status,
            days_due,
            transaction_number,
            case_number
          } = app;

          const action = `
            <div class="btn-group" role="group">
              <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Actions
              </button>
              <div class="dropdown-menu">
                <button type="button" class="dropdown-item" 
                        id="btn_cabinet" 
                        title="View Application Progress" 
                        data-target-id="${job_number}" 
                        data-target="#cabinetModal" 
                        data-toggle="modal">
                  Track <i class="fas fa-hdd"></i>
                </button>
                <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                  <input type="hidden" name="case_number" value="${transaction_number}">
                  <input type="hidden" name="search_text" value="${case_number}">
                  <input type="hidden" name="job_number" value="${job_number}">
                  <input type="hidden" name="business_process_sub_name" value="${case_number}">
                  <button type="submit" class="dropdown-item">
                    Application Details <i class="fas fa-info-circle"></i>
                  </button>
                </form>
              </div>
            </div>`;

          if (isCompleted) {
            return [job_number, ar_name, business_process_name, created_date, completed_date, turnaround_days, action];
          } else {
            return [job_number, ar_name, business_process_name, created_date, days_due, job_status, action];
          }
        });

        // Update summary stats
        if (isCompleted) {
          updateSummaryStatsRecApplicationsCompleted(json_result.data, totalApplications, totalApplicationsSum);
        } else {
          updateSummaryStatsRecApplications(json_result.data, totalApplications, totalApplicationsSum);
        }

        // Define column headers
        const columns = isCompleted
          ? [
              { title: "Job Number" },
              { title: "Applicant Name" },
              { title: "Process Name" },
              { title: "Date Received" },
              { title: "Date Completed" },
              { title: "Turnaround (Days)" },
              { title: "Action", orderable: false, searchable: false }
            ]
          : [
              { title: "Job Number" },
              { title: "Applicant Name" },
              { title: "Process Name" },
              { title: "Date Received" },
              { title: "Days Due" },
              { title: "Status" },
              { title: "Action", orderable: false, searchable: false }
            ];

        // Initialize DataTable
        $(tableId).DataTable({
          data: dataSet,
          columns: columns,
          dom: 'Bfrtip',
          paging: true,
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
              title: title,
              filename: `Report_on_${division}_${regionName}_${subServiceName}_${status}_Between_${newdatestart}_and_${newdateend}`
            },
            {
              extend: 'excel',
              title: title,
              filename: `Report_on_${division}_${regionName}_${subServiceName}_${status}_Between_${newdatestart}_and_${newdateend}`
            },
            {
              extend: 'pdf',
              title: title,
              filename: `Report_on_${division}_${regionName}_${subServiceName}_${status}_Between_${newdatestart}_and_${newdateend}`
            },
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
                    </p>`)
                  .css('font-size', '18px');
                $(win.document.body).find('table')
                  .addClass('compact')
                  .css('font-size', '16px')
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
      },
      error: function (xhr, status, error) {
        console.error("Error fetching applications:", error);
        alert("An error occurred while loading applications. Please try again later.");
      }
    });
  });
       



      



     
               //QUERIED APPLICATIONS      
$(document).off('click', '#pastdue_apps').on('click', '#pastdue_apps', function (e) {
  e.preventDefault();

  // Get the current date range
  let datefrom = startDate;
  let dateto = endDate;
  let newdatestart = $('#startdate').val();
  let newdateend = $('#enddate').val();

  // Define title and apply it to modal header
  const title = `APPLICATIONS PAST DUE WITHIN DIVISIONS FROM ${newdatestart} TO ${newdateend}`.toUpperCase();
  document.getElementById('divisions_title').innerHTML = title;

  // Show modal
  $("#divisions_modal").modal("show");

  // Initialize empty dataset
  let dataSet2 = [];
  $('#divisions_table').DataTable().clear().destroy();

  // AJAX call
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_apps_past_due',
      date_from: datefrom,
      date_to: dateto
    },
    cache: false,
    success: function (response) {
      console.log(response);

      const json_result = JSON.parse(response);
      console.log(json_result.apps_at_division);

      const totalApplications = json_result.apps_at_division?.length ?? 0;
      const totalApplicationsSum = json_result.apps_at_division
        ? json_result.apps_at_division.reduce((sum, item) => sum + (item.total || 0), 0)
        : 0;

      if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
        console.log("No data found");
        return;
      }

      // Build table rows
      json_result.apps_at_division.forEach((item, index) => {
        const division = item.division;
        const total = item.total;
        const action = `
          <a href="javascript:void(0)" 
             data-id="${item.division}" 
             id="view_past_due_apps_regions"  
             class="btn btn-md btn-secondary shadow-sm px-3 py-2 rounded-lg">
             <i class="fas fa-map-marker-alt"></i> View Regions
          </a>
        `;

        dataSet2.push([division, total, action]);
      });

      // Update summary stats if needed
      updateSummaryStatusRegionsDivisions(json_result.data, totalApplications, totalApplicationsSum);

      // Initialize DataTable with styled export options
      $('#divisions_table').DataTable({
        data: dataSet2,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_on_Applications_Past_Due_Between_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_on_Applications_Past_Due_Between_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_on_Applications_Past_Due_Between_${newdatestart}_and_${newdateend}`
          },
          {
            extend: 'print',
            text: 'Print',
            title: '', // Custom title below
            customize: function (win) {
              $(win.document.body)
                .prepend(
                  `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                   <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                     This report is generated using the Enterprise Land Information System
                   </p>`
                )
                .css('font-size', '18px');
              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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


 // Past Due Apps By Division 
    $(document).off('click', '#view_past_due_apps_regions').on('click', '#view_past_due_apps_regions', function (e) {
      e.preventDefault();

      // Extract data attributes
      const divisionName = $(this).data('id');
      const newdatestart = $('#startdate').val();
      const newdateend = $('#enddate').val();

      // Define and apply title
      const title = `${divisionName} REGIONAL APPLICATIONS PAST DUE FROM ${newdatestart} TO ${newdateend}`.toUpperCase();
      document.getElementById('region_title').innerHTML = title;

      // Show modal
      $("#regional_modal").modal("show");

      // Initialize table
      $('#regions_table').DataTable().clear().destroy();

      // AJAX request
      $.ajax({
        type: "POST",
        url: "executive_dashboard",
        data: {
          request_type: 'executive_dashboard_apps_past_due_regions',
          vrdivision: divisionName,
          date_from: startDate,
          date_to: endDate
        },
        cache: false,
        success: function (response) {
          const json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

          const totalApplications = json_result.apps_at_division?.length ?? 0;
          const totalApplicationsSum = json_result.apps_at_division
            ? json_result.apps_at_division.reduce((sum, item) => sum + (item.total || 0), 0)
            : 0;

          // Exit if no data
          if (!json_result.apps_at_division || json_result.apps_at_division.length === 0) {
            console.log("No data found");
            return;
          }

          // Build dataset
          const dataSet2 = json_result.apps_at_division.map((item, index) => {
            const ord_region_name = item.ord_region_name;
            const total = item.total;
            const action = `
              <a href="javascript:void(0)" 
                data-id="${item.region_code}" 
                data-name_full="${divisionName}" 
                data-region="${ord_region_name}" 
                id="view_regional_applications_by_units"  
                class="btn btn-md btn-secondary shadow-sm px-3 py-2 rounded-lg">
                <i class="fas fa-sitemap"></i> View Unit
              </a>`;
            return [ord_region_name, total, action];
          });

          // Update summary (if applicable)
          updateSummaryStatusRegionsData(json_result.data, totalApplications, totalApplicationsSum);

          // Initialize DataTable
          $('#regions_table').DataTable({
            data: dataSet2,
            dom: 'Bfrtip',
            paging: true,
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
                title: title,
                filename: `Report_on_${divisionName}_Past_Due_Applications_Between_${newdatestart}_and_${newdateend}`
              },
              {
                extend: 'excel',
                title: title,
                filename: `Report_on_${divisionName}_Past_Due_Applications_Between_${newdatestart}_and_${newdateend}`
              },
              {
                extend: 'pdf',
                title: title,
                filename: `Report_on_${divisionName}_Past_Due_Applications_Between_${newdatestart}_and_${newdateend}`
              },
              {
                extend: 'print',
                text: 'Print',
                title: '', // Prevent default DataTables title
                customize: function (win) {
                  $(win.document.body)
                    .prepend(
                      `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                      <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
                        This report is generated using the Enterprise Land Information System
                      </p>`
                    )
                    .css('font-size', '18px');
                  $(win.document.body).find('table')
                    .addClass('compact')
                    .css('font-size', '16px')
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


    

 $(document).off('click', '#view_regional_applications_by_units').on('click', '#view_regional_applications_by_units', function (e) {
  e.preventDefault();

  // Extract required values
  const regionID = $(this).data('id');
  const regionName = $(this).data('region');
  const divisionName = $(this).data('name_full');

  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  console.log(regionID, divisionName);

  // Prepare title
  const title = `${divisionName} | ${regionName} APPLICATIONS PAST DUE FROM ${newdatestart} TO ${newdateend}`.toUpperCase();

  // Apply title
  document.getElementById('units_title').innerHTML = title;

  // Show modal
  $("#units_modal").modal("show");

  // Reset datatable
  $('#units_table').DataTable().clear().destroy();

  // AJAX request
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_apps_pastdue_units',
      region_id: regionID,
      division: divisionName,
      date_from: startDate,
      date_to: endDate
    },
    cache: false,
    success: function (response) {
      console.log(response);
      const json_result = JSON.parse(response);
      console.log(json_result.apps_at_division_unit);

      const totalApplications = json_result.apps_at_division_unit?.length ?? 0;
      const totalApplicationsSum = json_result.apps_at_division_unit
        ? json_result.apps_at_division_unit.reduce((sum, item) => sum + (item.total || 0), 0)
        : 0;

      if (!json_result.apps_at_division_unit || json_result.apps_at_division_unit.length === 0) {
        console.log("No data found");
        return;
      }

      // Prepare DataTable data
      const dataSet2 = json_result.apps_at_division_unit.map((item) => {
        const unit_name = item.unit_name;
        const total = item.total;
        const action = `
          <a href="javascript:void(0)" 
             data-id="${item.unit_id}" 
             data-name_full="${item.unit_name}" 
             data-region="${regionID}" 
             data-division="${divisionName}" 
             data-regionname="${regionName}"  
             id="view_regional_applications_by_units_staff"  
             class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
             <i class="fas fa-user"></i> View Staff & Unit
          </a>`;
        return [unit_name, total, action];
      });

      // Update summary
      updateSummaryStatusUnitsData(json_result.data, totalApplications, totalApplicationsSum);

      // Initialize DataTable with modern exports
      $('#units_table').DataTable({
        data: dataSet2,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_on_${divisionName}_${regionName}_Past_Due_Applications_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_on_${divisionName}_${regionName}_Past_Due_Applications_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_on_${divisionName}_${regionName}_Past_Due_Applications_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'print',
            text: 'Print',
            title: '', // prevent default header
            customize: function (win) {
              $(win.document.body)
                .prepend(
                  `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                   <p style="text-align:center; font-weight:bold; margin-bottom:30px;">This report is generated using the Enterprise Land Information System</p>`
                )
                .css('font-size', '18px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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



$(document).off('click', '#view_regional_applications_by_units_staff').on('click', '#view_regional_applications_by_units_staff', function (e) {
  e.preventDefault();

  // Extract values
  const unitID = $(this).data('id');
  const regionID = $(this).data('region');
  const unitName = $(this).data('name_full');
  const DivisionName = $(this).data('division');
  const regionname = $(this).data('regionname');

  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  console.log(regionID, DivisionName, unitName);

  // Build title
  const title = `${unitName} | ${regionname} APPLICATIONS PAST DUE FROM ${newdatestart} TO ${newdateend}`.toUpperCase();

  // Apply to modal header
  document.getElementById('officers_title').innerHTML = title;

  // Show modal
  $("#officers_modal").modal("show");

  // Reset DataTable
  $('#officers_table').DataTable().clear().destroy();

  // AJAX call
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_apps_pastdue_within_unit',
      region_id: regionID,
      division: DivisionName,
      unit: unitName,
      date_from: startDate,
      date_to: endDate
    },
    cache: false,
    success: function (response) {
      console.log(response);

      const json_result = JSON.parse(response);
      console.log(json_result.apps_at_unit);

      const totalApplications = json_result.apps_at_unit?.length ?? 0;
      const totalApplicationsSum = json_result.apps_at_unit
        ? json_result.apps_at_unit.reduce((sum, item) => sum + (item.total || 0), 0)
        : 0;

      if (!json_result.apps_at_unit || json_result.apps_at_unit.length === 0) {
        console.log("No data found");
        return;
      }

      // Build dataset
      const dataSet2 = json_result.apps_at_unit.map((item) => {
        const staff = item.staff;
        const total = item.total;
        const action = `
          <a href="javascript:void(0)" 
             data-id="${item.staff_id}" 
             data-name_full="${item.staff}" 
             data-div="${DivisionName}"  
             data-regid="${regionID}"  
             data-regname="${regionname}"  
             id="view_regional_applications_by_units_staff_apps"  
             class="btn btn-secondary shadow-sm px-3 py-2 rounded-lg">
             <i class="fas fa-file-alt"></i> View Applications
          </a>`;
        return [staff, total, action];
      });

      // Update summary section
      updateSummaryStatusUnitsStaffData(json_result.data, totalApplications, totalApplicationsSum);

      // Initialize DataTable with styled exports
      $('#officers_table').DataTable({
        data: dataSet2,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_on_${unitName}_${regionname}_Past_Due_Applications_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_on_${unitName}_${regionname}_Past_Due_Applications_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_on_${unitName}_${regionname}_Past_Due_Applications_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(
                  `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                   <p style="text-align:center; font-weight:bold; margin-bottom:30px;">This report is generated using the Enterprise Land Information System</p>`
                )
                .css('font-size', '18px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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


      
      
$(document).off('click', '#view_regional_applications_by_units_staff_apps').on('click', '#view_regional_applications_by_units_staff_apps', function (e) {
  e.preventDefault();

  // Extract data attributes
  const staffID = $(this).data('id');
  const StaffName = $(this).data('name_full');
  const regionId = $(this).data('regid');
  const Division = $(this).data('div');
  const RegionNAme = $(this).data('regname');

  

  const newdatestart = $('#startdate').val();
  const newdateend = $('#enddate').val();

  console.log(staffID, StaffName, regionId, Division);

  // Build report title
  const title = `${RegionNAme} | ${StaffName} APPLICATIONS PAST DUE FROM ${newdatestart} TO ${newdateend}`.toUpperCase();
  document.getElementById('staffapps_modalLabel').innerHTML = title;

  // Show modal
  $("#staffapps_modal").modal("show");

  // Reset DataTable
  $('#staffapps_table').DataTable().clear().destroy();

  // AJAX request
  $.ajax({
    type: "POST",
    url: "executive_dashboard",
    data: {
      request_type: 'executive_dashboard_apps_pastdue_with_officer',
      division: Division,
      date_from: startDate,
      date_to: endDate,
      staff_id: staffID,
      region_code: regionId
    },
    cache: false,
    success: function (response) {
      console.log(response);

      const json_result = JSON.parse(response);
      const applications = json_result.apps_with_staff || [];

      const totalApplications = applications.length ?? 0;
      console.log("Total Applications:", totalApplications);

      if (applications.length === 0) {
        console.log("No past due applications found for this officer.");
        return;
      }

      let jobNumbers = [];
      const dataSet2 = applications.map(app => {
        jobNumbers.push(app.job_number);

        const checkbox = `
          <div class="text-center">
            <input type="checkbox" class="app-checkbox form-check-input" value="${app.job_number}">
          </div>`;

        const action = `
          <div class="btn-group" role="group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Actions
            </button>
            <div class="dropdown-menu">
              <button type="button" class="dropdown-item" 
                id="btn_cabinet" 
                data-job_number="${app.job_number}" 
                title="View Application Progress" 
                data-target-id="${app.job_number}" 
                data-target="#cabinetModal" 
                data-toggle="modal">
                Track <i class="fas fa-hdd"></i>
              </button>

              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" value="${app.transaction_number}">
                <input type="hidden" name="search_text" value="${app.case_number}">
                <input type="hidden" name="job_number" value="${app.job_number}">
                <input type="hidden" name="business_process_sub_name" value="${app.business_process_name}">
                <button type="button" 
                  class="dropdown-item" 
                  data-staff_name="${StaffName}" 
                  data-staff_id="${staffID}" 
                  data-job_number="${app.job_number}" 
                  data-target="#sendMessageModal_FocalCompliance" 
                  data-toggle="modal">
                  Send Message
                </button>
                <button type="submit" name="save" class="dropdown-item">
                  Application Details <i class="fas fa-info-circle"></i>
                </button>
              </form>
            </div>
          </div>`;

        return [
          checkbox,
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

      // Generate “Send Message” button for all jobs
      const jobNumbersString = jobNumbers.join(",");
      const sendMsgButton = `
        <button 
          class="sendMessage btn btn-primary d-flex align-items-center shadow-sm px-4 py-2 ml-auto"
          id="send_message"
          data-staffid="${staffID}"
          data-staff="${StaffName}"
          data-jobnumber="${jobNumbersString}"
          type="button"
        >
          <i class="fas fa-paper-plane mr-2"></i> Send Message
        </button>`;
      document.getElementById("sendmsg").innerHTML = sendMsgButton;

      // Update summary
      updateSummaryStatusUnitsStaffApps(json_result.data, totalApplications, totalApplications);

      // Initialize DataTable with export features
      $('#staffapps_table').DataTable({
        data: dataSet2,
        dom: 'Bfrtip',
        paging: true,
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
            title: title,
            filename: `Report_on_${StaffName}_Past_Due_Applications_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Report_on_${StaffName}_Past_Due_Applications_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Report_on_${StaffName}_Past_Due_Applications_${newdatestart}_to_${newdateend}`
          },
          {
            extend: 'print',
            text: 'Print',
            title: '',
            customize: function (win) {
              $(win.document.body)
                .prepend(
                  `<h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">${title}</h3>
                   <p style="text-align:center; font-weight:bold; margin-bottom:30px;">This report is generated using the Enterprise Land Information System</p>`
                )
                .css('font-size', '18px');

              $(win.document.body).find('table')
                .addClass('compact')
                .css('font-size', '16px')
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


    updateDisplayedDateRange();


    // Unbind the previous event first
$('#cabinetModal').off('show.bs.modal');

// Then bind fresh
$('#cabinetModal').on('show.bs.modal', function(event) {
  const job_number = $(event.relatedTarget).data('target-id');
  const table = $('#cabinet-tracking');

  // Clear previous data
  table.find("tbody tr").remove();
  $("#enq_applicant_name, #enq_applicant_type, #enq_cabinet_name, #enq_job_status").val("");

  console.log("Job Number:", job_number);

  $.ajax({
    type: "POST",
    url: "Case_Management_Serv",
    data: {
      request_type: 'load_application_cabinet_details_by_job_number',
      job_number: job_number
    },
    cache: false,
    beforeSend: function() {
      // You can show a loader/spinner here if needed
    },
    success: function(jobdetails) {
      try {
        const json_p = JSON.parse(jobdetails);

        // Fill tracking table
        $(json_p.cabinet_tracking).each(function() {
          table.append(`
            <tr>
              <td>${this.officers_general_comments}</td>
              <td>${this.division}</td>
              <td>${this.created_by}</td>
              <td>${this.created_date}</td>
            </tr>
          `);
        });

        // Fill form fields
        $(json_p.cabinet_data).each(function() {
          $("#enq_applicant_name").val(this.ar_name);
          $("#enq_applicant_type").val(this.business_process_sub_name);
          $("#enq_cabinet_name").val(this.file_number);
          $("#enq_job_purpose").val(this.job_purpose);
          $("#enq_job_status").val(this.job_status);
          $("#enq_current_application_status").val(this.current_application_status);
        });
      } catch (err) {
        console.error("Error parsing response:", err);
      }
    },
    error: function(xhr, status, error) {
      console.error("AJAX Error:", status, error);
    }
  });
});

    }
});




function loadAllCount(startDate, endDate) {
    return $.ajax({
        type: "POST",
        url: "executive_dashboard",
        data: {
            request_type: 'executive_dashboard_report_all_count',
            date_from: startDate,
            date_to: endDate
        },
        cache: false
    });
}

function loadDivisionCount(startDate, endDate) {
    return $.ajax({
        type: "POST",
        url: "executive_dashboard",
        data: {
            request_type: 'executive_dashboard_get_division_totals',
            date_from: startDate,
            date_to: endDate
        },
        cache: false
    });
}
   

function loadCharts(startDate, endDate) {
    return $.ajax({
        type: "POST",
        url: "executive_dashboard",
        data: {
            request_type: 'executive_dashboard_report_charts',
            date_from: startDate,
            date_to: endDate
        },
        cache: false
    });
}
   
function loadRegionalData(startDate, endDate) {
    return $.ajax({
        type: "POST",
        url: "executive_dashboard",
        data: {
            request_type: 'executive_dashboard_get_regional_received',
            date_from: startDate,
            date_to: endDate
        },
        cache: false
    });
}

   
function loadSubservicesData(startDate, endDate) {
    return $.ajax({
        type: "POST",
        url: "executive_dashboard",
        data: {
            request_type: 'executive_dashboard_get_apps_by_subservices_for_barchart',
            date_from: startDate,
            date_to: endDate
        },
        cache: false
    });
}
   

function loadCompletedRegionalData(startDate, endDate) {
    return $.ajax({
        type: "POST",
        url: "executive_dashboard",
        data: {
            request_type: 'executive_dashboard_get_regional_completed_stats',
            date_from: startDate,
            date_to: endDate
        },
        cache: false
    });
}


function updateSummaryStats(data, totalApplications, totalApplicationsSum) {

    var date_start = $('#startdate').val();
    var date_end = $('#enddate').val();


    console.log(date_start,date_end);


        
    $('#totalApplications').text(totalApplications.toLocaleString());
    $('#totalServices').text(totalApplicationsSum.toLocaleString());
    
    $('#dateRange').text(`${date_start} to ${date_end}`);
    $('#totalCount').text(totalApplications.toLocaleString());
}



function updateSummaryStatsSubService(data, totalApplications, totalApplicationsSum) {

    var date_start = $('#startdate').val();
    var date_end = $('#enddate').val();


    console.log(date_start,date_end);


        
    $('#totalApplicationsSub').text(totalApplications.toLocaleString());
    $('#totalServicesSub').text(totalApplicationsSum.toLocaleString());
    
    $('#dateRangeSub').text(`${date_start} to ${date_end}`);
    $('#totalCountSub').text(totalApplications.toLocaleString());
}


function updateSummaryStatsRecApplications(data, totalApplications, totalApplicationsSum) {

    var date_start = $('#startdate').val();
    var date_end = $('#enddate').val();


    console.log(date_start,date_end);

    $('#totalApplicationsRecApps').text(totalApplications.toLocaleString());
    
    $('#dateRangeSubRecApps').text(`${date_start} to ${date_end}`);
    // $('#totalCountSub').text(totalApplications.toLocaleString());
}


function updateSummaryStatsRecApplicationsCompleted(data, totalApplications, totalApplicationsSum) {

    var date_start = $('#startdate').val();
    var date_end = $('#enddate').val();


    console.log(date_start,date_end);

    $('#completed_totalApplicationsRecApps').text(totalApplications.toLocaleString());
    
    $('#completed_dateRangeSubRecApps').text(`${date_start} to ${date_end}`);
    // $('#totalCountSub').text(totalApplications.toLocaleString());
}


function updateSummaryStatusRegions(data, totalApplications, totalApplicationsSum) {

    var date_start = $('#startdate').val();
    var date_end = $('#enddate').val();


    console.log(date_start,date_end);

    $('#totalRegApps').text(totalApplications.toLocaleString());
    
    $('#dateRangeRegApps').text(`${date_start} to ${date_end}`);
    // $('#totalCountSub').text(totalApplications.toLocaleString());
}


function updateSummaryStatusRegionsData(data, totalApplications, totalApplicationsSum) {

    var date_start = $('#startdate').val();
    var date_end = $('#enddate').val();


    console.log(date_start,date_end);

    $('#totalregionApps').text(totalApplicationsSum.toLocaleString());
    
    $('#dateRangeRegions').text(`${date_start} to ${date_end}`);
    $('#totalRegionalCount').text(totalApplications.toLocaleString());
}


function updateSummaryStatusRegionsDivisions(data, totalApplications, totalApplicationsSum) {

    var date_start = $('#startdate').val();
    var date_end = $('#enddate').val();


    console.log(date_start,date_end);

    $('#totalDivisionalApps').text(totalApplicationsSum.toLocaleString());
    
    $('#dateRangeDivision').text(`${date_start} to ${date_end}`);
    $('#totalDivisionCount').text(totalApplications.toLocaleString());
}



function updateSummaryStatusRegionsDivisionsNew(data, totalApplications, totalApplicationsSum) {

    var date_start = $('#startdate').val();
    var date_end = $('#enddate').val();


    console.log(date_start,date_end);

    
					

    $('#totalDivisionalAppsNew').text(totalApplicationsSum.toLocaleString());
    
    $('#dateRangeDivisionNew').text(`${date_start} to ${date_end}`);
    // $('#totalDivisionCount').text(totalApplications.toLocaleString());
}


function updateSummaryStatusUnitsData(data, totalApplications, totalApplicationsSum) {

    var date_start = $('#startdate').val();
    var date_end = $('#enddate').val();


    console.log(date_start,date_end);

    $('#totalDivisionalUnits').text(totalApplicationsSum.toLocaleString());
    
    $('#dateRangeDivisionUnit').text(`${date_start} to ${date_end}`);
    $('#totalDivisionUnit').text(totalApplications.toLocaleString());
}


function updateSummaryStatusUnitsStaffData(data, totalApplications, totalApplicationsSum) {

    var date_start = $('#startdate').val();
    var date_end = $('#enddate').val();


    console.log(date_start,date_end);

    $('#totalDivisionalAppsStaff').text(totalApplicationsSum.toLocaleString());
    
    $('#dateRangeDivisionStaff').text(`${date_start} to ${date_end}`);
    $('#totalDivisionCountStaff').text(totalApplications.toLocaleString());
}

function updateSummaryStatusUnitsStaffApps(data, totalApplications, totalApplicationsSum) {

    var date_start = $('#startdate').val();
    var date_end = $('#enddate').val();


    console.log(date_start,date_end);

    $('#totalStaffApps').text(totalApplications.toLocaleString());
    
    $('#dateRangeStaffApps').text(`${date_start} to ${date_end}`);
    // $('#totalDivisionCountStaff').text(totalApplications.toLocaleString());
}



     function updateDisplayedDateRange() {
  const date_start = $('#startdate').val();
  const date_end = $('#enddate').val();

  console.log(date_start,date_end);
  $('#displayDateRange').text(`${date_start} - ${date_end}`);

}


		

// Set default dates on page load
$(document).ready(function() {

    const currentDate = new Date();
    const januaryFirst = new Date(currentDate.getFullYear(), 0, 1);
    
    // Format as YYYY-MM-DD
    const formatDate = (date) => date.toISOString().split('T')[0];
    
    const startDate = formatDate(januaryFirst);
    const endDate = formatDate(currentDate);
    
    // Set the date picker values
    $('#datefrom').val(startDate);
    $('#dateto').val(endDate);
    
    // Set the hidden fields
    $('#start_date').val(startDate);
    $('#end_date').val(endDate);
    
    // Format display dates
    const startDisplay = januaryFirst.toLocaleDateString('en-US', { 
        day: 'numeric', 
        month: 'long', 
        year: 'numeric' 
    });
    const endDisplay = currentDate.toLocaleDateString('en-US', { 
        day: 'numeric', 
        month: 'long', 
        year: 'numeric' 
    });
    
    $('#startdate').val(startDisplay);
    $('#enddate').val(endDisplay);
    
    // Trigger the dateto change event after a short delay to ensure everything is loaded
    setTimeout(() => {
        if (dateToPicker) {
            dateToPicker.setDate(endDate, true); // This should trigger the onChange
        }
    }, 2000);

     updateDisplayedDateRange();
     
});
 
        });










  