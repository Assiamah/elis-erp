let startDate = null;
let endDate = null;


const dateFromPicker =   flatpickr("#datefrom", {
        dateFormat: "Y-m-d", // Internal value format (YYYY-MM-DD)
        altInput: true, // Enables an alternative input field for display
        altFormat: "j F Y", // Display format (e.g., "1 February 2025")
        allowInput: true, // Allows manual input
        onChange: function(selectedDates, dateStr, instance) {
            let formattedDate = instance.formatDate(selectedDates[0], "j F Y"); // Format in "1 February 2025"
            
            // console.log("Selected date (YYYY-MM-DD):", dateStr); 
            // console.log("Selected date (j F Y):", formattedDate); 
    
            $('#start_date').val(dateStr);

            $('#startdate').val(formattedDate);

            // 🔹 Set minDate of "Date To" dynamically
        dateToPicker.set('minDate', dateStr);

                startDate = dateStr;


        }
    });



const dateToPicker = flatpickr("#dateto", {
  dateFormat: "Y-m-d",
  altInput: true,
  altFormat: "j F Y",
  allowInput: true,
  onChange: async function (selectedDates, dateStr, instance) {
    // Ensure "Date From" is selected first
    if (!$('#datefrom').val()) {
      alert("Please select 'Date From' before selecting 'Date To'.");
      $('#dateto').val('');
      return;
    }

    // Validate date order
    let dateFromVal = $('#datefrom').val();
    if (new Date(dateStr) < new Date(dateFromVal)) {
      alert("End date cannot be earlier than start date.");
      $('#dateto').val('');
      return;
    }

    // Set hidden/formatted values
    let formattedDate = instance.formatDate(selectedDates[0], "j F Y");
    $('#end_date').val(dateStr);
    $('#enddate').val(formattedDate);

    // let startDate = $('#start_date').val();
    // let endDate = $('#end_date').val();

            endDate = dateStr;

    console.log("Fetching dashboard stats from:", startDate, "to ", endDate);

          var StrD = $('#startdate').val();
          var EndD = $('#enddate').val();



    var title = "Applications Received From " + StrD + " to "+ " "+ EndD;
     var title_ = "From" + StrD + " to"+ " "+  EndD;

    

    document.getElementById('RecTitle').innerHTML = title;
    document.getElementById('RecComp').innerHTML = title;
    document.getElementById('CompTitle').innerHTML = title;
    document.getElementById('pastDueTitle').innerHTML = title_;
    document.getElementById('AppsWithDivTitle').innerHTML = title_;

    
    

   

    const card      = document.querySelector('.card-body[data-method="apps_created"]');
    const card1     = document.querySelector('.card-body[data-method="apps_received_completed"]');
    const card2     = document.querySelector('.card-body[data-method="apps_completed"]');
    const card3     = document.querySelector('.card-body[data-method="apps_past_due"]');
    const card4     = document.querySelector('.card-body[data-method="apps_with_division"]');

    
   
    const start_Date = document.getElementById("startdate").value;
    const end_Date   = document.getElementById("enddate").value;
    
    console.log(start_Date)
    if (start_Date && end_Date && card) {
        card.dataset.date = `from ${start_Date} to ${end_Date}`;
    }
    if (start_Date && end_Date && card1) {
        card1.dataset.date = `from ${start_Date} to ${end_Date}`;
    }
    if (start_Date && end_Date && card2) {
        card2.dataset.date = `from ${start_Date} to ${end_Date}`;
    }
     if (start_Date && end_Date && card3) {
        card3.dataset.date = `from ${start_Date} to ${end_Date}`;
    }
     if (start_Date && end_Date && card4) {
        card4.dataset.date = `from ${start_Date} to ${end_Date}`;
    }





    $(function () {





function getServiceTypeButtons(title_) {
  return [
    {
      extend: 'copy',
      title: title_,
      documentTitle: title_,
      exportOptions: {
        columns: [0, 1],
        format: {
          body: data => $('<div>').html(data).text()
        }
      }
    },
    {
      extend: 'csv',
      title: title_,
      documentTitle: title_,
      filename: title_.replace(/\s+/g, '_'),
      exportOptions: {
        columns: [0, 1],
        format: {
          body: data => $('<div>').html(data).text()
        }
      }
    },
    {
      extend: 'excel',
      title: title_,
      documentTitle: title_,
      filename: title_.replace(/\s+/g, '_'),
      exportOptions: {
        columns: [0, 1],
        format: {
          body: data => $('<div>').html(data).text()
        }
      }
    },
    {
      extend: 'pdf',
      title: title_,
      documentTitle: title_,
      filename: title_.replace(/\s+/g, '_'),
      exportOptions: {
        columns: [0, 1],
        format: {
          body: data => $('<div>').html(data).text()
        }
      }
    },
    {
      extend: 'print',
      text: 'Print',
      title: '',
      documentTitle: '',
      exportOptions: {
        columns: [0, 1],
        format: {
          body: data => $('<div>').html(data).text()
        }
      },
      customize: function (win) {
        $(win.document.body).prepend(`
          <h3 style="text-align:center; font-weight:bold; margin-bottom:20px;">
            ${title_}
          </h3>
          <p style="text-align:center; font-weight:bold; margin-bottom:30px;">
            This report is generated using the Enterprise Land Information System
          </p>
        `);
      }
    },
    'pageLength'
  ];
}

        

  let divisions = [
    { division: "SMD", total: 0 },
    { division: "LRD", total: 0 },
    { division: "PVLMD", total: 0 },
    { division: "LVD", total: 0 },
    { division: "RLO", total: 0 },
  ];

  let colors = ["danger", "warning", "default", "info", "success", "secondary"];

 


    $(document).on("click", ".sendMessage", function (event) {
  event.preventDefault();

  const table = $("#applicationsTable").DataTable();

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
  const staff = $(this).data("receiver_name");
  const staffid = $(this).data("officer_id");


  //  data-receiver_name="${StaffName}" 
  //                data-officer_name="${StaffName}"
  //                 data-receiver_name="${StaffName}"
  //                 data-="${staffID}"> 

  console.log(staff);

  // ✅ Populate modal hidden fields
  const sendMessageModal = $("#sendMessageModal");
  sendMessageModal.find("#officer_id").val(staffid);
  sendMessageModal.find("#officer_name").val(staff);
  sendMessageModal.find("#job_numbers").val(JSON.stringify(selectedRows));



  //  console.log(data);
    
        // Update modal title
    const titleText = staff ? 
        `Send Message to <span class="text-primary">${staff}</span>` : 
        'Send Message';
    sendMessageModal.find("#modalTitleText").html(titleText);
    
    // Update recipient info card
    if (staff) {
        sendMessageModal.find("#recipientNameDisplay").text(staff);
    } else if (staff) {
        sendMessageModal.find("#recipientNameDisplay").text(staff);
    } else {
        sendMessageModal.find("#recipientNameDisplay").text('Select a recipient');
    }
    
    // Update recipient info
    if (staffid) {
        sendMessageModal.find("#recipientInfo").text(`ID: ${staffid}`);
    } else {
        sendMessageModal.find("#recipientInfo").text('No ID available');
    }
    
    // Update job count badge
    const jobCount = Array.isArray(selectedRows) ? selectedRows.length : 0;
    sendMessageModal.find("#jobCountBadge").text(`${jobCount} ${jobCount === 1 ? 'job' : 'jobs'}`);
    
    // Reset form to clean state    
    // Show the modal (Bootstrap 5)
    // const bsModal = new bootstrap.Modal(modal);
    // bsModal.show();



  

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
  sendMessageModal.find(".rec-table").prepend(selectedTable);

  // ✅ Update modal title and show
  sendMessageModal
    .find("#sendMessageModalLabel")
    .html(`Send Message To <span class="text-primary">${staff}</span>`);

  sendMessageModal.modal("show");


    resetMessageForm();

});







  $(document).on("click", ".sendMessageToAll", function (event) {
    event.preventDefault();
    
    const officerName = $(this).data('officer_name');
    const receiverName = $(this).data('receiver_name');
    const jobNumber = $(this).data('job_number');
    const officerId = $(this).data('officer_id');
    
    // Parse job numbers (could be a single job number or array)
    let jobNumbers = $(this).data("job-number");
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
    
    // Update modal with data
    updateSendMessageModal({
        officer_id: officerId,
        officer_name: officerName,
        receiver_name: receiverName,
        job_numbers: jobNumbers
    });
});

  $("#sendMessageModal").css("z-index", 90000);

  $(document).on("click", "#sendMessage", function (event) {
    event.preventDefault();

    let sendMessageModal = $("#sendMessageModal");

    let staff = $(this).data("staff");

    let jobNumbers = $(this).data("job-number");
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
    sendMessageModal.find("#officer_id").val(staff.staff_id);
    sendMessageModal.find("#officer_name").val(staff.staff);

    sendMessageModal
      .find("#sendMessageModalLabel")
      .html(`Send Message To <span class="text-primary">${staff.staff}</span>`);

    console.log(staff.staff_id, staff.staff, jobNumbers)

    sendMessageModal.modal("show");
  });

  // $("#message-form").on("submit", function (event) {
  //   event.preventDefault();

  //   let form = $(this);
  //   let data = form.serializeArray();

  //   data = {
  //     "request_type": $("#sendMessageModal").find("#request_type").val(),
  //     "officer_id": $("#sendMessageModal").find("#officer_id").val(),
  //     "officer_name": $("#sendMessageModal").find("#officer_name").val(),
  //     "job_numbers" : $("#sendMessageModal").find("#job_numbers").val(),
  //   "message_type":$("#sendMessageModal").find("#message_type").val(),
  //   "message": $("#sendMessageModal").find("#message").val()
  //   }


  //   submitAjax(
  //     $(this).attr("action"),
  //     "send_compliance_message",
  //     data,
  //     function () {
  //       form.trigger("reset");
  //       form.parents(".modal").modal("hide");
  //       alert("Message sent successfully.");
  //     },
  //     function () {
  //       alert(
  //         "We were not able to send your message. Please contact IT support if issue persists."
  //       );
  //     }
  //   );
  // });

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

      groupedData[foundIndex] = {
        ...groupedData[foundIndex],
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

  $(document).on("click", ".showDivisionModal", function (event) {
    event.preventDefault();

    let item = $(this);
    let iconClass = item.data("icon") || "ri-bar-chart-2-fill";
    let modal = $("#divisionModal");
    let title = item.data("title");
    let date = item.data("date") || "";
    let url = item.data("url");
    let method = item.data("method");
    let period = item.data("period");
    let by = item.data("by");


    console.log(url);

    // Update modal header
    modal.find("#divisionModalLabel").html(title);
    modal.find("#divisionModalSubtitle").html(date);
    modal.find("#currentPeriod").text(period ? period.charAt(0).toUpperCase() + period.slice(1) : "All Time");
    
    // Update load time
    const now = new Date();
    modal.find("#dataLoadTime").text(now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }));

    // Show loading state
    modal.find("#divisionGrid").html(`
        <div class="col-12">
            <div class="card border-light shadow-sm">
                <div class="card-body text-center py-5">
                    <div class="spinner-border text-primary mb-3" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="text-muted mb-0">Loading division data...</p>
                </div>
            </div>
        </div>
    `);
    modal.find("#emptyDivisionState").addClass("d-none");
    modal.find("#divisionStats").html("");

    // Prepare action
    let action = method + 
        (period ? `_${period}` : "") + 
        (typeof by === "undefined" ? "" : `_${by}`);
      console.log(action);

    // console.log(action);
    // Fetch data
    submitAjax(url, action, {}, function (data) {

        console.log(data);
        // Calculate totals
        const totalApplications = data.apps_at_division.reduce((sum, item) => sum + parseInt(item.total), 0);
        const totalDivisions = data.apps_at_division.length;
        
        // Update stats
        updateDivisionStats(modal, totalApplications, totalDivisions, date);
        
        // Handle empty data
        if (data.apps_at_division.length === 0) {
            modal.find("#divisionGrid").html("");
            modal.find("#emptyDivisionState").removeClass("d-none");
            return;
        }
        
        // Prepare division data
        const allDivisions = [
  document.getElementById('director_division').value
];
        // const allDivisions = ['LRD', 'LVD', 'PVLMD', 'SMD', 'RLO'];
        const divisionsData = allDivisions.map(division => {
            const found = data.apps_at_division.find(item => item.division === division);
            return {
                division: division,
                total: found ? found.total : 0,
                color: getDivisionColor(division),
                icon: getDivisionIcon(division)
            };
        });
        
        // Generate division cards
        const divisionHtml = divisionsData.reduce((html, current) => {
            const percentage = totalApplications > 0 ? 
                Math.round((current.total / totalApplications) * 100) : 0;
            
            return html + `
                <div class="col-xl-3 col-lg-6">
                    <div class="card division-card border-0 shadow-sm h-100 transition-all ${current.total === 0 ? 'opacity-75' : ''}"
                         data-division="${current.division}"
                         data-count="${current.total}">
                        <div class="card-body position-relative">
                            <!-- Division Header -->
                            <div class="d-flex align-items-center mb-3">
                                <div class="division-icon ${current.color} rounded-circle p-2 me-3">
                                    <i class="${current.icon} fs-4"></i>
                                </div>
                                <div>
                                    <h6 class="mb-0 fw-bold">${current.division}</h6>
                                    <span class="text-muted small">${getDivisionFullName(current.division)}</span>
                                </div>
                            </div>
                            
                            <!-- Count Display -->
                            <div class="mb-3">
                                <h4 class="fw-bold mb-1">${current.total.toLocaleString()}</h4>
                                <div class="text-muted small">Applications</div>
                            </div>
                            
                            <!-- Progress Bar -->
                            <div class="mb-3">
                                <div class="d-flex justify-content-between mb-1">
                                    <span class="small text-muted">Percentage</span>
                                    <span class="badge fw-bold ${current.color}">${percentage}%</span>
                                </div>
                                <div class="progress" style="height: 6px;">
                                    <div class="progress-bar ${current.color}" 
                                         role="progressbar" 
                                         style="width: ${percentage}%"
                                         aria-valuenow="${percentage}" 
                                         aria-valuemin="0" 
                                         aria-valuemax="100"></div>
                                </div>
                            </div>
                            
                            <!-- Quick Stats -->
                            <div class="d-flex justify-content-between small text-muted mb-3 mt-3 pt-3 border-top">
                                <span>Rank: #${getDivisionRank(current.division, divisionsData)}</span>
                                <span>Avg: ${calculateAverage(current.division, divisionsData)}</span>
                            </div>
                            
                            <!-- View Details Link -->
                            ${current.total > 0 ? `
                                <a href="#" 
                                   data-method="${method}" 
                                   data-period="${period}" 
                                   data-by="service_type" 
                                   data-url="${url}" 
                                   data-type="${current.division}" 
                                   data-title="${title}" 
                                   data-date="${date}" 
                                   class="showServiceTypeModal stretched-link text-decoration-none">
                                    <div class="position-absolute bottom-0 end-0 m-3 mt-2">
                                        <span class="btn btn-sm ${current.color} px-3">
                                            View Details <i class="ri-arrow-right-line ms-1"></i>
                                        </span>
                                    </div>
                                </a>
                            ` : ''}
                        </div>
                    </div>
                </div>
            `;
        }, "");

        // Update modal content
        modal.find("#divisionGrid").html(divisionHtml);
        modal.find("#emptyDivisionState").addClass("d-none");
        
        // Initialize division card interactions
        initializeDivisionCards();
    });

    // Show modal
    modal.modal("show");
});

// Helper Functions
function updateDivisionStats(modal, totalApplications, totalDivisions, date) {
    // const periodText = period ? period.charAt(0).toUpperCase() + period.slice(1) : "All Time";
    
    modal.find("#divisionStats").html(`
        <div class="col-lg-4">
            <div class="card custom-card testimonial-style-2-card danger border-0">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="avatar bg-danger bg-opacity-10 rounded-circle p-3 me-3">
                            <i class="ri-file-text-line text-danger fs-3"></i>
                        </div>
                        <div>
                            <div class="text-muted small">Total Applications</div>
                            <h5 class="mb-0 fw-bold">${totalApplications.toLocaleString()}</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card custom-card testimonial-style-2-card success border-0">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="avatar bg-success bg-opacity-10 rounded-circle p-3 me-3">
                            <i class="ri-building-line text-success fs-3"></i>
                        </div>
                        <div>
                            <div class="text-muted small">Active Divisions</div>
                            <h5 class="mb-0 fw-bold">${totalDivisions}/5</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card custom-card testimonial-style-2-card info border-0">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="avatar bg-info bg-opacity-10 rounded-circle p-3 me-3">
                            <i class="ri-calendar-line text-info fs-3"></i>
                        </div>
                        <div>
                            <div class="text-muted small">Period</div>
                            <h5 class="mb-0 fw-bold">${date}</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `);
}

function getDivisionColor(division) {
    const colorMap = {
        'LRD': 'bg-primary',
        'LVD': 'bg-success',
        'PVLMD': 'bg-warning',
        'SMD': 'bg-danger',
        'RLO': 'bg-info'
    };
    return colorMap[division] || 'bg-secondary';
}

function getDivisionIcon(division) {
    const iconMap = {
        'LRD': 'ri-landscape-line',
        'LVD': 'ri-road-map-line',
        'PVLMD': 'ri-home-5-line',
        'SMD': 'ri-building-line',
        'RLO': 'ri-rocket-line'
    };
    return iconMap[division] || 'ri-question-line';
}

function getDivisionFullName(division) {
    const nameMap = {
        'LRD': 'Land Registration Division',
        'LVD': 'Land Valuation Division',
        'PVLMD': 'Public & Vested Land Management Division',
        'SMD': 'Survey & Mapping Division',
        'RLO': 'Regional Lands Officer'
    };
    return nameMap[division] || 'Unknown Division';
}

function getDivisionRank(division, divisionsData) {
    const sorted = [...divisionsData].sort((a, b) => b.total - a.total);
    return sorted.findIndex(item => item.division === division) + 1;
}

function calculateAverage(division, divisionsData) {
    const divisionData = divisionsData.find(item => item.division === division);
    const total = divisionsData.reduce((sum, item) => sum + item.total, 0);
    return total > 0 ? Math.round(divisionData.total / (total / divisionsData.length)) : 0;
}

function initializeDivisionCards() {
    // Add hover effects and click handlers
    $('.division-card').hover(
        function() {
            $(this).addClass('shadow-lg').css('transform', 'translateY(-4px)');
        },
        function() {
            $(this).removeClass('shadow-lg').css('transform', 'translateY(0)');
        }
    );
    
    // Add click tracking
    $('.division-card').on('click', function() {
        const division = $(this).data('division');
        const count = $(this).data('count');
        console.log(`Clicked on ${division} with ${count} applications`);
    });
}

// Export functionality
$('#exportDivisionData').on('click', function() {
    // Implement export logic here
    alert('Export feature would be implemented here');
});

  $(document).on("click", ".showServiceTypeModal", function (event) {
    event.preventDefault();

    let item = $(this);
    let modal = $("#serviceTypeModal");
    let type = item.data("type") ?? "";

    let title = item.data("title");
    let date = item.data("date") ?? "";
     console.log(date);

    let title_ = "";

    if (date == ""){
     title_ = title + " " +" From " + StrD + " to "+ " "+ EndD;

    }else {
      title_ =title +" " + date;
    }


    let url = item.data("url");

    let method = item.data("method");
    let period = item.data("period");
    let by = item.data("by");

    let action =
      method +
      (period ? `_${period}` : "") +
      (typeof by === "undefined" ? "" : `_${by}`);
    //    console.log(url);
    //   console.log(action);

    submitAjax(url, action, { division: type }, function (data) {

        //  console.log(data);
      let serviceTypeData = data.apps_at_division.map(function (item) {
        return {
          name: `<span class="small">${item.service_type}</span>`,
          total: `<span class="small">${item.total}</span>`,
          action: `<a href="#" 
            class="modalButton btn btn-sm btn-outline-primary showApplicationsModal text-decoration-none"
            data-method="${method}" 
          ${typeof period === "undefined" ? "" : `data-period="${period}"`}
          data-url="${url}"
          ${typeof by === "undefined" ? "" : `data-by="${by}"`}
          data-key="service"
          data-value="${item.service_type}"
          data-type="${item.service_type}"
          data-title="${title}" 
          data-date="${date}" 
        ><i class="ri-eye-line me-2"></i>View</a>`,
        };
      });

    //   modal
    //     .find(".modal-body table")
    //     .DataTable({ destroy: true, responsive: true, data: serviceTypeData });
      modal.find(".modal-body table").DataTable({
        destroy: true,
        responsive: true,
        data: serviceTypeData,
        dom: "<'row'<'col-sm-4'l><'col-sm-4'B><'col-sm-4'f>>" +
            "<'row'<'col-sm-12'tr>>" +
            "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        buttons: getServiceTypeButtons(title_)
        });



    });

    modal.find(".modal-body table").DataTable();

    modal
      .find("#serviceTypeModalLabel")
      .html(`${type}'s ${title} <span class="text-primary">${date}</span>`);

    modal.modal("show");
  });

  $(document).on("click", ".showUnitModal", function (event) {
    event.preventDefault();

    let item = $(this);
    let modal = $("#unitModal");
    let type = item.data("type") ?? "";

    // let title = item.data("title");
    let title = (item.data("title"));
    let date = item.data("date") ?? "";

         console.log(date);

    let title_ = "";

    if (date == ""){
     title_ = title + " " +" From " + StrD + " to "+ " "+ EndD;

    }else {
      title_ = (item.data("title") === "Applications With Divisions") ? "Applications" : item.data("title") + date;
    }


     


    let url = item.data("url");

    let method = item.data("method");
    let period = item.data("period");
    let by = item.data("by");

    let action =
      method +
      (typeof period === "undefined" ? "" : `_${period}`) +
      (typeof by === "undefined" ? "" : `_${by}`) +
      "_units";

    submitAjax(url, action, { division: type }, function (data) {
      let unitsData = data.apps_at_division_unit.map(function (item) {
        return {
          name: item.unit,
          total: item.total,
          action: `<a href="#" 
            class="modalButton btn btn-sm btn-outline-primary showOfficerModal text-decoration-none"
            data-method="${method}" 
            data-count="${item.total}" 
          ${typeof period === "undefined" ? "" : `data-period="${period}"`}
          data-url="${url}"
          ${typeof by === "undefined" ? "" : `data-by="${by}"`}
          data-type="${item.unit}"
          data-title="${title}" 
          data-date="${date}" 
            data-unit-id="${item.unit_id}"
          data-division="${type}"
        ><i class="ri-eye-line me-2"></i>View</a>`,
        };
      });

    //   modal
    //     .find(".modal-body table")
    //     .DataTable({ destroy: true, responsive: true, data: unitsData });
    modal.find(".modal-body table").DataTable({
        destroy: true,
        responsive: true,
        data: unitsData,
        dom: "<'row'<'col-sm-4'l><'col-sm-4'B><'col-sm-4'f>>" +
            "<'row'<'col-sm-12'tr>>" +
            "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        buttons: getServiceTypeButtons(title_)
        });
    });

    modal
      .find("#unitModalLabel")
      .html(
        `${type}'s Units ${title} <span class="text-primary">${date}</span>`
      );

    modal.find(".modal-body table").DataTable();

    modal.modal("show");
  });

  $(document).on("click", ".showOfficerList", function (event) {
    event.preventDefault();
    let item = $(this);
    let url = item.data("url");
    let method = item.data("method");
    let division = item.data("division");
    let unit = item.data("unit-id");
    let action =
      method +
      (typeof period === "undefined" ? "" : `_${period}`) +
      (typeof by === "undefined" ? "" : `_${by}`) +
      "_officers";

    // AJAX call to get top 10 data
    submitAjax(url, action, { division, unit }, function (data) {
        // Process and display top 10 data in the card
        let topOfficersData = data.apps_at_unit.map(function (item, index) {
            return {
                name: item.staff,
                total: item.total,
                rank: index + 1
            };
        });

        // Update the card content with top 10 data
        updateOfficerCard(topOfficersData, item.data("type"));
    });
});

function updateOfficerCard(officersData, unitName) {
    const cardBody = $(".card.custom-card .card-body");
    const listContainer = cardBody.find(".top-country-sales-list");
    
    // Clear existing content
    listContainer.empty();
    
    // Create new list items for top 10 officers
    officersData
    .sort((a, b) => b.total - a.total)   // 🔥 sort by total DESC
    .slice(0, 10)                        // 🔥 take top 10
    .forEach((officer, index) => {

        const listItem = `
            <li ${index === 9 ? 'class="mb-0"' : ''}>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center lh-1 gap-2">
                        <span class="avatar avatar-xs avatar-rounded bg-warning text-white">
                            <i class="ri-user-line"></i>
                        </span>
                        <span class="small">${officer.name}</span>
                    </div>
                    <div>
                        ${officer.total}
                    </div>
                </div>
            </li>
        `;

        listContainer.append(listItem);
    });
    
    // Update card title
    $(".card.custom-card .card-title").text(`Unit Monitoring - Top 10 Officers`);
}

// Modified showOfficerModal function (for showing all in modal)
$(document).on("click", ".showOfficerModal", function (event) {
    event.preventDefault();
    let item = $(this);
    
    let modal = $("#officerModal");
    let type = item.data("type") ?? "";
    let title = item.data("title");
    let date = item.data("date") ?? "";
    let url = item.data("url");
    let method = item.data("method");
    let period = item.data("period");
    let by = item.data("by");
    let division = item.data("division");
    let unit = item.data("unit-id");
    let count = item.data("count");


        let title_ = "";

    if (date == ""){
     title_ = title + " " +" From " + StrD + " to "+ " "+ EndD;

    }else {
      title_ = (item.data("title") === "Applications With Divisions") ? "Applications" : item.data("title") + date;
    }



    //let action = method + "_officers_all"; // Action for all data
    let action =
      method +
      (typeof period === "undefined" ? "" : `_${period}`) +
      (typeof by === "undefined" ? "" : `_${by}`) +
      "_officers";

    // Show loading in modal
    modal.find(".modal-body table tbody").html('<tr><td colspan="3" class="text-center">Loading...</td></tr>');

    submitAjax(url, action, { division, unit }, function (data) {
        let officersData = data.apps_at_unit.map(function (item) {
            return {
                name: item.staff,
                total: item.total,
                action: `<a href="#" 
                    class="btn btn-sm btn-outline-primary showApplicationsModal"
                    data-staff='${JSON.stringify(item)}'
                    data-method="${method}" 
                    ${typeof period === "undefined" ? "" : `data-period="${period}"`}
                    data-url="${url}"
                    ${typeof by === "undefined" ? "" : `data-by="${by}"`}
                    data-type="${item.staff}'s"
                    data-title="${title}" 
                    data-date="${date}"
                    data-key="staff"
                    data-value="${item.staff_id}"
                ><i class="ri-eye-line me-2"></i>View</a>`,
            };
        });

        // Destroy existing DataTable if it exists
        if ($.fn.DataTable.isDataTable(modal.find(".modal-body table"))) {
            modal.find(".modal-body table").DataTable().destroy();
        }

        // Initialize new DataTable
        // let table = modal.find(".modal-body table").DataTable({
        //     responsive: true,
        //     data: officersData,
        //     columns: [
        //         { data: "name" },
        //         { data: "total" },
        //         { data: "action" }
        //     ],
        //     order: [[1, "desc"]],
        //     buttons: [
        //         { 
        //             extend: "excel", 
        //             exportOptions: { columns: [0, 1] } 
        //         },
        //         { 
        //             extend: "print", 
        //             exportOptions: { columns: [0, 1] } 
        //         },
        //         // "colvis"
        //     ],
        //     dom: '<"row"<"col-sm-4"l><"col-sm-4"B><"col-sm-4"f>>rtip',
        //     pageLength: 25,
        //     lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
        //     pageLength: 10,
        //     language: {
        //         //emptyTable: "No compliance applications found",
        //         info: "Showing _START_ to _END_ of _TOTAL_ entries",
        //         infoEmpty: "Showing 0 to 0 of 0 entries",
        //         infoFiltered: "(filtered from _MAX_ total entries)",
        //         lengthMenu: "Show _MENU_ entries",
        //         loadingRecords: "Loading...",
        //         processing: "Processing...",
        //         search: "",
        //         searchPlaceholder: "Search Officers...",
        //         zeroRecords: "No matching records found"
        //     }
        // });
        // modal.find(".modal-body table").DataTable({
        // destroy: true,
        // responsive: true,
        // data: officersData,
        // dom: "<'row'<'col-sm-4'l><'col-sm-4'B><'col-sm-4'f>>" +
        //     "<'row'<'col-sm-12'tr>>" +
        //     "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        // buttons: getServiceTypeButtons(title_)
        // });

        modal.find(".modal-body table").DataTable({
  destroy: true,
  responsive: true,
  data: officersData,

  columns: [
    { data: 'name', title: 'Officer' },
    { data: 'total', title: 'Count' },
    { data: 'action', title: 'Action', orderable: false }
  ],

  dom: "<'row'<'col-sm-4'l><'col-sm-4'B><'col-sm-4'f>>" +
       "<'row'<'col-sm-12'tr>>" +
       "<'row'<'col-sm-5'i><'col-sm-7'p>>",

  buttons: getServiceTypeButtons(title_)
});



    });

    modal.find("#officerModalLabel")
        .html(`${type}'s Officers ${title} <span class="text-primary">${date}</span>`);

    modal.modal("show");
});

  // Function to initialize DataTable with common settings
function initializeApplicationsDataTable(tableId, columns, data, title_) {

    // Destroy existing DataTable if it exists
    if ($.fn.DataTable.isDataTable(tableId)) {
        $(tableId).DataTable().destroy();
    }

    return $(tableId).DataTable({
        responsive: true,
        data: data,
        columns: columns,
        order: [[1, "desc"]],

        // ✅ CENTRALIZED BUTTONS
        buttons: getServiceTypeButtons(title_),

        dom: '<"row"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6"f>>' +
             '<"row"<"col-sm-12"tr>>' +
             '<"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',

        pageLength: 10,
        lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
        language: {
            search: "Search:",
            lengthMenu: "Show _MENU_ entries",
            info: "Showing _START_ to _END_ of _TOTAL_ entries",
            paginate: {
                first: "First",
                last: "Last",
                next: "Next",
                previous: "Previous"
            }
        }
    });
}

// Event handler for showing applications modal
$(document).on("click", ".showApplicationsModal", function (event) {
    event.preventDefault();
    
    let item = $(this);
    let modal = $("#applicationsModal");
    let type = item.data("type") ?? "";
    let title = item.data("title").toUpperCase();
    let date = item.data("date") ?? "";
    let url = item.data("url");
    let method = item.data("method");
    let period = item.data("period");
    let by = item.data("by");
    let key = item.data("key");
    let value = item.data("value");

           let title_ = "";

    if (date == ""){
     title_ = title + " " +" From " + StrD + " to "+ " "+ EndD;

    }else {
      title_ = (item.data("title") === "Applications With Divisions") ? "Applications" : item.data("title") + date;
    }



    console.log(url);

   let modalType = item.data("modal-type") || "applications";


   if (title.toLowerCase().includes("completed"))  {
     modalType = "completed"
   }else {

    modalType = item.data("modal-type") || "applications";

   }


    
    // Determine which modal to use based on method or data attribute
        console.log(modalType);
    
    if (modalType === "completed") {
        modal = $("#completedapplicationsModal");
    } else if (modalType === "new") {
        modal = $("#applicationsModal");
    }

    console.log(modalType)
    
    // Set modal title
    modal.find(".modal-title").html(
        `${type} ${title} <span class="text-primary">${date}</span>`
    );
    
    // Show loading state
    modal.find("table tbody").html('<tr><td colspan="8" class="text-center"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></td></tr>');
    
    // Prepare AJAX request
    let action = method + (period ? "_" + period : "") + (by ? "_" + by : "") + "_applications";
    
    let requestData = {};
    requestData[key] = value;
    
    // Get staff data if available
    let staff = null;
    try {
        staff = JSON.parse(item.data("staff"));
    } catch (e) {
        staff = item.data("staff");
    }
    
    // Show modal
    let bsModal = new bootstrap.Modal(modal[0]);
    bsModal.show();

    console.log(url);
    console.log(action);
    
    // Make AJAX request
    submitAjax(url, action, requestData, function (data) {

        console.log(data);

      data = data.apps_with_staff || data.apps_at_division || [];

      function escapeHtml(unsafe) {
        if (typeof unsafe !== 'string') return unsafe;
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }


        let applicationsData = data.map(function (app) {
             let actionButton = `            
             <td class="text-end">
					<div class="dropdown">
						<a href="javascript:void(0);"
						class="btn btn-icon btn-sm btn-primary border action-btn""
						data-bs-toggle="dropdown"
						data-bs-display="static"
						aria-expanded="false">
							<i class="ri-more-2-line"></i>
						</a>

						<ul class="dropdown-menu dropdown-menu-end table-dropdown" data-popper-placement="bottom-end">

							<!-- Cabinet -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								data-bs-toggle="modal"
								data-bs-target="#cabinetModal"
								data-target-id="${escapeHtml(app.job_number || '')}">
									<i class="ri-hard-drive-2-line me-2"></i>
									Cabinet
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>
						
					

							<!-- Application Details (Form Submit) -->
							<li>
								<a class="dropdown-item"
								href="javascript:void(0);"
								onclick="viewApplicationDetails('${app.job_number}','${app.transaction_number}','${app.case_number}','${app.business_process_sub_name}')">
									<i class="ri-information-line me-2"></i>
									Application Details
								</a>
							</li>

							<li><hr class="dropdown-divider"></li>
							

						</ul>
					</div>
				</td>`;


            // let actionButton = `<a href="#" onclick="viewApplicationDetails('${app.job_number}','${app.transaction_number}','${app.case_number}','${app.business_process_sub_name}')" class="btn btn-sm btn-outline-primary">
            //   <i class="ri-eye-line"></i>
            // </a>`;

            // console.log(staff)
            
            // Add send message button if staff data is available

            // actionButton += ` <button class="btn btn-sm btn-outline-warning sendMessage_unit_case" data-receiver_name="${staff.staff}" data-officer_name="${staff.staff}" data-officer_id="${staff.staff_id}" data-job_number="${app.job_number}">
            //       <i class="ri-send-plane-line"></i>
            //     </button>`;
            
            if (staff && staff.staff_id) {
                // actionButton += ` <button class="btn btn-sm btn-outline-warning sendMessage_unit_case" data-receiver_name="${staff.staff}" data-officer_name="${staff.staff}" data-officer_id="${staff.staff_id}" data-job_number="${app.job_number}">
                //   <i class="ri-send-plane-line"></i>
                // </button>`;

                                actionButton += `
<button 
  class="btn btn-sm btn-outline-warning messageReply"
  data-receiver_name="${staff.staff}" 
  data-officer_name="${staff.staff}" 
  data-officer_id="${staff.staff_id}" 
  data-job_number="${app.job_number}"
  title="Notices & Replies">
    <i class="ri-reply-line"></i>
</button>`;

            }

            
                function formatDate(dateString) {
                    if (!dateString) return '';

                    // Trim hidden characters
                    const clean = dateString.toString().trim();

                    // Force ISO format
                    const iso = clean.includes('T')
                        ? clean
                        : `${clean}T00:00:00`;

                    const date = new Date(iso);

                    return isNaN(date.getTime())
                        ? ''
                        : date.toLocaleDateString('en-US', {
                            year: 'numeric',
                            month: 'short',
                            day: 'numeric'
                        });
                    }

                     const checkbox = `
          <div class="text-center">
            <input type="checkbox" class="app-checkbox" value="${app.job_number}">
          </div>`;

                                            
            return {
                 checkbox :checkbox,
                job_number: app.job_number,
                ar_name: app.ar_name,
                business_process_sub_name: app.business_process_sub_name,
                created_date: formatDate(app.created_date),
                due_date: formatDate(app.due_date),
                // due_date: app.due_date ? new Date(app.due_date).toLocaleDateString() : '',
                // completed_date: app.completed_date ? new Date(app.completed_date).toLocaleDateString() : '',
                completed_date: formatDate(app.completed_date),
                days_due: app.days_due,
                days_since_batched: app.days_since_batched || '',
                job_purpose: app.job_purpose || '',
                action: actionButton
            };
        });
        
        // Define columns based on modal type
        let columns = [];
        
        if (modalType === "completed") {
            columns = [
                { 
                  data: "job_number",
                  render: function(data, type, row) {
                      return `<span class="fw-medium text-primary small">${data}</span>`;
                  }
                },
                { 
                  data: "ar_name",
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  }
                },
                { 
                  data: "business_process_sub_name" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                  data: "created_date" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${formatDate(data)}</span>`;
                  }
                },
                { 
                  data: "completed_date" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${formatDate(data)}</span>`;
                  }
                },
                { 
                  data: "days_due" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                    data: "action", 
                    className: "text-end",
                    render: function(data, type, row) {
                        return `<div class="d-flex justify-content-end gap-2">${data}</div>`;
                    }
                }
            ];
        } else if (modalType === "new") {
            columns = [
                { 
                  data: "job_number",
                  render: function(data, type, row) {
                      return `<span class="fw-medium text-primary small">${data}</span>`;
                  }
                },
                { 
                  data: "ar_name" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                  data: "business_process_sub_name" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                  data: "created_date" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${formatDate(data)}</span>`;
                  } 
                },
                { 
                  data: "due_date" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${formatDate(data)}</span>`;
                  }
                },
                { 
                  data: "days_due" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  }
                },
                { 
                  data: "days_since_batched" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  }
                },
                { 
                  data: "job_purpose" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                    data: "action", 
                    className: "text-end",
                    render: function(data, type, row) {
                        return  `<div class="d-flex justify-content-end gap-2">${data}</div>`;
                    }
                }
            ];
        } else {
            columns = [
                 { 
                  data: "checkbox",
                  render: function(data, type, row) {
                      return `<span class="fw-medium text-primary small">${data}</span>`;
                  }
                },
                { 
                  data: "job_number",
                  render: function(data, type, row) {
                      return `<span class="fw-medium text-primary small">${data}</span>`;
                  }
                },
                { 
                  data: "ar_name" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  }
                },
                { 
                  data: "business_process_sub_name" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                  data: "created_date" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${formatDate(data)}</span>`;
                  } 
                },
                { 
                  data: "due_date" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${formatDate(data)}</span>`;
                  } 
                },
                { 
                  data: "days_due" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                  data: "days_since_batched" ,
                  render: function(data, type, row) {
                      return `<span class="fw-medium small">${data}</span>`;
                  } 
                },
                { 
                    data: "action", 
                    className: "text-end",
                    render: function(data, type, row) {
                        return `<div class="d-flex justify-content-end gap-2">${data}</div>`;
                    }
                }
            ];
        }
        
        // Initialize DataTable
        let tableId = modalType === "completed" ? "#completedApplicationsTable" : 
                     modalType === "new" ? "#newApplicationsTable" : "#applicationsTable";
        
        // initializeApplicationsDataTable(tableId, columns, applicationsData);
        initializeApplicationsDataTable(
    tableId,
    columns,
    applicationsData,
    `${type} ${title} ${date}`
);
        
        // Add send message button to modal header if staff data exists
        if (staff && staff.staff_id) {
            let sendMessageBtn = $(`
                <button class="btn btn-primary ms-auto sendMessage" 
                        data-officer_id="${staff.staff_id}"
                        data-receiver_name="${staff.staff || 'Officer'}"
                        data-officer_name="${staff.staff || 'Officer'}"
                  >
                    <i class="bi bi-chat-text"></i> Select & Send Message
                </button>
            `);
            
            // Remove existing send message button if any
            modal.find(".sendMessage").remove();
            
            // Add new button to modal header
            modal.find(".modal-header").append(sendMessageBtn);
        }
    });
});

window.viewApplicationDetails = function(job_number, transaction_number, case_number, business_process_sub_name) {
     
      // Create a form dynamically
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = 'front_office_view_application';
      form.target = '_blank'
      form.style.display = 'none'; // Hide the form
      
      // Add the case number as an input field
      const caseNumberInput = document.createElement('input');
      caseNumberInput.type = 'hidden';
      caseNumberInput.name = 'search_text';
      caseNumberInput.value = case_number;
      form.appendChild(caseNumberInput);

      // Add the case number as an input field
      const jobNumberInput = document.createElement('input');
      jobNumberInput.type = 'hidden';
      jobNumberInput.name = 'search_text';
      jobNumberInput.value = job_number;
      form.appendChild(jobNumberInput);

      // Add the case number as an input field
      const transactionNumberInput = document.createElement('input');
      transactionNumberInput.type = 'hidden';
      transactionNumberInput.name = 'search_text';
      transactionNumberInput.value = transaction_number;
      form.appendChild(transactionNumberInput);

      // Add the case number as an input field
      const businessProcessSubNameInput = document.createElement('input');
      businessProcessSubNameInput.type = 'hidden';
      businessProcessSubNameInput.name = 'search_text';
      businessProcessSubNameInput.value = business_process_sub_name;
      form.appendChild(businessProcessSubNameInput);
      
      // Add the form to the body and submit it
      document.body.appendChild(form);
      form.submit();
};

  let chart;

  $(".clear-chart").on("click", function () {
    $(this).parents(".generate-chart").trigger("reset");

    echarts.init($(this).parents(".modal").find(".chart")[0]).dispose();

    $(this).parents(".modal").find(".chart").width(0).height(0);
  });

  $(".modal").on("shown.bs.modal", function () {
    $(this).attr("data-position", $(".modal:visible").length);

    $('.modal').each(function () {
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

  
//   function generateChart(modalBody, title, type, tableData) {
//   let data = null;
//   let labels = null;

//   function stripHtml(value) {
//   if (value == null) return '';
//   return $("<div>").html(value).text().trim();
// }


//   console.log(tableData);

//   switch (type) {
//     case "pie":
//     case "doughnut":
//         data = tableData.map(item => ({
//   name: stripHtml(item.name),
//   value: Number(stripHtml(item.total)) || 0
// }));

//     //   data = tableData.map(({ name, total }) => ({
//     //     name,
//     //     value: Number(total) || 0
//     //   }));
//       break;

//     case "bar":
//       labels = tableData.map(item => item.name);
//       data = tableData.map(item => Number(item.total) || 0);
//       break;

//     default:
//       Swal.fire({
//         title: 'Oops!',
//         text: 'Please select one option.',
//         icon: 'warning'
//       });
//       return;
//   }

//   if (chart) {
//     chart.dispose();
//   }

//   modalBody.find(".chart").css({
//     width: "100%",
//     height: type === "bar" ? "700px" : "400px"
//   });

//   chart = echarts.init(modalBody.find(".chart")[0]);


//   let options = {
//   title: { text: title },
//   animation: true,
//   animationDuration: 800,
//   animationEasing: 'cubicOut',
//   toolbox: {
//     right: "5%",
//     feature: { saveAsImage: {} }
//   }
// };


//   if (type === "pie") {
//     options = { ...options, ...getPieOptions(data, "70%") };
//   } else if (type === "doughnut") {
//     options = { ...options, ...getPieOptions(data, ["40%", "70%"]) };
//   } else {
//     options = { ...options, ...getBarOptions(labels, data) };
//   }

//   chart.setOption(options);

//   // 🔥 FORCE RENDER
//   setTimeout(() => chart.resize(), 50);
// }

function generateChart(modalBody, title, type, tableData) {
    console.log("=== START generateChart ===");
    console.log("Chart type:", type);
    console.log("Table data length:", tableData.length);
    console.log("Full tableData:", tableData);
    
    if (!type) {
        swal.fire({
            title: 'Ops!',
            text: 'Please select one option.',
            icon: 'warning',
            confirmButtonText: 'OK'
        });
        return;
    }

    // Clear existing chart
    let chartContainer = modalBody.find(".chart");
    if (window.currentChart && window.currentChart.dispose) {
        window.currentChart.dispose();
    }
    
    // Validate data
    if (!tableData || tableData.length === 0) {
        swal.fire({
            title: 'No Data!',
            text: 'There is no data to display in the chart.',
            icon: 'info',
            confirmButtonText: 'OK'
        });
        return;
    }
    
    let data = null;
    let labels = null;
    let seriesData = [];

    switch (type) {
        case "pie":
        case "doughnut":
            console.log("Processing pie/doughnut data...");
            tableData.forEach((item, index) => {
                console.log(`Item ${index}:`, item);
                console.log(`Item ${index} name:`, item.name);
                console.log(`Item ${index} total:`, item.total);
                
                // Extract text from HTML
                let nameText = $("<div>").html(item.name).text().trim();
                console.log(`Item ${index} cleaned name:`, nameText);
                
                // Parse total - handle different formats
                let totalValue = 0;
                if (item.total !== undefined && item.total !== null) {
                    if (typeof item.total === 'number') {
                        totalValue = item.total;
                    } else if (typeof item.total === 'string') {
                        // Remove any non-numeric characters except decimal point
                        let cleanTotal = item.total.replace(/[^\d.-]/g, '');
                        totalValue = parseFloat(cleanTotal) || 0;
                    }
                }
                console.log(`Item ${index} parsed total:`, totalValue);
                
                seriesData.push({
                    name: nameText || `Item ${index + 1}`,
                    value: totalValue
                });
            });
            console.log("Final seriesData:", seriesData);
            break;
            
        case "bar":
            console.log("Processing bar chart data...");
            labels = tableData.map((item, index) => {
                let nameText = $("<div>").html(item.name).text().trim();
                console.log(`Label ${index}:`, nameText);
                return nameText || `Item ${index + 1}`;
            });
            
            seriesData = tableData.map((item, index) => {
                let totalValue = 0;
                if (item.total !== undefined && item.total !== null) {
                    if (typeof item.total === 'number') {
                        totalValue = item.total;
                    } else if (typeof item.total === 'string') {
                        let cleanTotal = item.total.replace(/[^\d.-]/g, '');
                        totalValue = parseFloat(cleanTotal) || 0;
                    }
                }
                console.log(`Data ${index}:`, totalValue);
                return totalValue;
            });
            
            console.log("Bar labels:", labels);
            console.log("Bar seriesData:", seriesData);
            break;
    }

    // Set chart dimensions
    let height = (type === "pie" || type === "doughnut") ? 400 : 500;
    chartContainer.css({
        width: "100%",
        height: height + "px",
        // minHeight: "300px",
        border: "1px solid #ddd" // Add border for visibility
    });

    // Initialize chart
    let chart = echarts.init(chartContainer[0]);
    window.currentChart = chart; // Store globally for cleanup

    // Base options
    let options = {
        title: {
            text: title || 'Chart',
            left: 'center',
            textStyle: {
                fontSize: 16,
                fontWeight: 'bold'
            }
        },
        tooltip: {
            trigger: type === 'bar' ? 'axis' : 'item',
            formatter: type === 'bar' ? '{b}: {c}' : '{a}<br/>{b}: {c} ({d}%)'
        },
        toolbox: {
            show: true,
            feature: {
                saveAsImage: {
                    title: "Save as Image",
                    show: true
                }
            },
            right: 20,
            top: 20
        },
        backgroundColor: '#f8f9fa'
    };

    // Add series based on chart type
    if (type === "pie" || type === "doughnut") {
        options.series = [{
            name: title || 'Data',
            type: 'pie',
            radius: type === 'pie' ? '65%' : ['40%', '70%'],
            center: ['50%', '50%'],
            data: seriesData,
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            },
            label: {
                formatter: '{b}: {c} ({d}%)'
            }
        }];
        
        // options.legend = {
        //     orient: 'vertical',
        //     left: 10,
        //     top: 'center',
        //     data: seriesData.map(item => item.name)
        // };
    } 
    else if (type === "bar") {
        options.xAxis = {
            type: 'category',
            data: labels,
            axisLabel: {
                rotate: 45
            }
        };
        options.yAxis = {
            type: 'value',
            name: 'Count'
        };
        options.series = [{
            name: title || 'Data',
            type: 'bar',
            data: seriesData,
            itemStyle: {
                color: '#1890ff'
            },
            label: {
                show: true,
                position: 'top'
            }
        }];
    }

    console.log("ECharts options:", options);
    
    // Set options and render
    try {
        chart.setOption(options);
        console.log("Chart rendered successfully");
    } catch (error) {
        console.error("Error rendering chart:", error);
        swal.fire({
            title: 'Chart Error!',
            text: 'Failed to render chart: ' + error.message,
            icon: 'error',
            confirmButtonText: 'OK'
        });
    }
    
    console.log("=== END generateChart ===");
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





//   $('#sel_change_region_compliance').change(function () {
//     //console.log("selection made " + $(this).val() );


//     submitAjax("ComplianceReport", "report_dashboard_all", {}, function (data) {


//       let totalRec = data.total_apps_rec[0].total;
//       let totalRecComp = data.total_comp_divisional_year[0].total;

//       let totalpercentage = ((totalRecComp / totalRec) * 100).toFixed(2) + '%';
//       //console.log(totalpercentage);


//       $("#app-received-today").html(
//         new Intl.NumberFormat().format(data.apps_rec_day[0].total)
//       );
//       $("#app-received-month").html(
//         new Intl.NumberFormat().format(data.apps_rec_month[0].total)
//       );
//       $("#app-completed-today").html(
//         new Intl.NumberFormat().format(data.apps_comp_day[0].total)
//       );
//       $("#app-completed-month").html(
//         new Intl.NumberFormat().format(data.apps_comp_month[0].total)
//       );

//       // applications received for the year
//       showDivisionSummaryUpdatedQ("#app-received-year", data.apps_rec_divisional, 'info');

//       // applications completed for the year
//       showDivisionSummaryUpdatedQ("#app-completed-year", data.apps_comp_divisional, 'success');

//       // applications received and completed for the year
//       showDivisionSummaryUpdatedQ(
//         "#app-received-completed-year",
//         data.apps_comp_divisional_year,
//         'default'
//       );

//       // applications past due for the year
//       showDivisionSummary(
//         "#app-past-due-year",
//         data.apps_past_due_dates_divisional,
//         'danger'
//       );

//       // applications with divisions
//       showDivisionSummary("#app-with-divisions", data.apps_at_division, 'warning');

//       document.getElementById('pec_id').innerHTML = totalpercentage;

//     });
//   });




  if ($("#page_name").text() === "focal_compliance_person") {
    // console.log("pagen complaince")
    setTimeout(
      function () {

        submitAjax("focal_compliance", "compliance_focal_report_dashboard_all", {}, function (data) {
          let totalRec = data.total_apps_rec[0].total;
          let totalRecComp = data.total_comp_divisional_year[0].total;
          //  let totalpercentage = totalRec*totalRecComp/100

          let totalpercentage = ((totalRecComp / totalRec) * 100).toFixed(2) + '%';
          // console.log(totalpercentage);



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
      }, 200);

  }





  // if ($("#page_name").text() === "compliance") {
  //   setTimeout(
  //     function () {
  //       submitAjax("ComplianceReport", "report_dashboard_all", {}, function (data) {
  //         let totalRec = data.total_apps_rec[0].total;
  //         let totalRecComp = data.total_comp_divisional_year[0].total;
  //         let totalpercentage = ((totalRecComp / totalRec) * 100).toFixed(2) + '%';
  //         $("#app-received-today").html(new Intl.NumberFormat().format(data.apps_rec_day[0].total));
  //         $("#app-received-month").html(new Intl.NumberFormat().format(data.apps_rec_month[0].total));
  //         $("#app-completed-today").html(new Intl.NumberFormat().format(data.apps_comp_day[0].total));
  //         $("#app-completed-month").html(new Intl.NumberFormat().format(data.apps_comp_month[0].total));

  //         // applications received for the year
  //         showDivisionSummaryUpdatedQ("#app-received-year", data.apps_rec_divisional, 'info');

  //         // applications completed for the year
  //         showDivisionSummaryUpdatedR("#app-completed-year", data.apps_comp_divisional, 'success');

  //         // applications received and completed for the year
  //         showDivisionSummaryUpdated("#app-received-completed-year", data.apps_comp_divisional_year, 'default');

  //         // applications past due for the year
  //         showDivisionSummary("#app-past-due-year", data.apps_past_due_dates_divisional, 'danger');

  //         // applications with divisions
  //         showDivisionSummary("#app-with-divisions", data.apps_at_division, 'warning');

  //         document.getElementById('pec_id').innerHTML = totalpercentage;
  //       });
  //     }, 5000); // 60000 milliseconds = 1 minute
  // }



  function showDivisionSummary(id, data, color) {
    // console.log(data[0]); // Logging the first data item

    let total = data.reduce(function (sum, current) {

      return (sum += current.total);
    }, 0);
    //console.log(total);

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

      // console.log(percent);

      let html = `<div class="item">
        <h4 class="small font-weight-bold">
          <a href="#" data-method="${method}" data-url="${url}" ${typeof period === "undefined" ? "" : `data-period="${period}"`
        } data-action="report_dashboard_${method}${periodToAdd}" data-type="${current.division
        }" data-date="${date}" data-title="${title}" class="${nextLevelModal} text-decoration-none text-muted">
            ${current.division} (${current.total})
          </a>
          <span class="float-right">${percent}%</span>
        </h4>
        <div class="progress progress-sm mb-4">
          <div class="progress-bar bg-${color}" role="progressbar" style="width: ${percent}%" aria-valuenow="${percent}"
            aria-valuemin="0" aria-valuemax="100"></div>
        </div>
      </div>`;

      return (sum += html);
    }, "");

    contentBody.html(dataHtml);
  }


function showDivisionSummaryUpdatedQ(id, data, color) {
    // Define all 4 divisions
    // const allDivisions = ['LRD', 'LVD', 'PVLMD', 'SMD'];
    const allDivisions = [
  document.getElementById('director_division').value
];
    
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



  function showDivisionSummaryUpdated(id, data, color) {

    //console.log(firmList);

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
          <a href="#" data-method="${method}" data-url="${url}" ${typeof period === "undefined" ? "" : `data-period="${period}"`
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
          <a href="#" data-method="${method}" data-url="${url}" ${typeof period === "undefined" ? "" : `data-period="${period}"`
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
          <a href="#" data-method="${method}" data-url="${url}" ${typeof period === "undefined" ? "" : `data-period="${period}"`
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
          <a href="#" data-method="${method}" data-url="${url}" ${typeof period === "undefined" ? "" : `data-period="${period}"`
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




//   var firmList = 0; // global variable



  function submitAjax(
    url,
    requestType,
    data = {},
    success = function () { },
    error = function () { }
  ) {

    var region_id = $('#sel_change_region_compliance').val();
    var user_division = $('#director_division').val();

    //console.log(region_id)

    if (region_id != undefined) {
      region_id = region_id.replace(".0", "");
    }

    $.ajax({
      type: "POST",
      url,
      data: {
        request_type: requestType,
        region_id: region_id,
        start_date: startDate,
         end_date: endDate,
        ...data,
      },
      cache: false,
      success: function (response) {
        //console.log(response)
        //  let totalPerRec = reccc.apps_rec_divisional[0].total;
        // let lrdData = reccc.apps_at_division.find(item => item.division === "LRD");
        // let  lrdTotal = lrdData.total;
        //console.log(lrdTotal);
        try {

          var reccc = JSON.parse(response);
          firmList = reccc;
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

   // Global DataTable variable
  let reminderAppsTable = null;

  $(document).on("click", ".loadReminderApps", function (event) {
      event.preventDefault();

      let item = $(this);
      let modal = $("#reminderAppsModal");
      let type = item.data("type") ?? "";
      let title = item.data("title");
      let date = item.data("date") ?? "";
      let url = item.data("url");
      let method = item.data("method");
      let period = item.data("period");
      
      // Update modal title
      modal.find("#reminderAppsModalLabel").html(
          `${type}'s Reminder ${title} <span class="text-primary">${date}</span>`
      );

      let action =
        method +
        (typeof period === "undefined" ? "" : `_${period}`) +
        (typeof by === "undefined" ? "" : `_${by}`) +
        "_officers";

      // Submit AJAX request
      submitAjax(url, action, {}, function (data) {
          data = data.reminder_app_count || [];

          // Process data for DataTables
          let applicationsData = data.map(function (item) {
              return {
                  job_number: item.job_number || 'N/A',
                  business_process_sub_name: item.business_process_sub_name || 'N/A',
                  receiver_name_: item.receiver_name_ || 'N/A',
                  division_name: item.division_name || 'N/A',
                  tat: item.tat || 0,
                  created_date: formatDate(item.created_date) || 'N/A',
                  notice_id: item.notice_id,
                  transaction_number: item.transaction_number,
                  case_number: item.case_number,
                  // Additional data for actions
                  _details: item.details,
                  _notice_type: item.notice_type,
                  _status: item.status,
                  _region_name: item.region_name
              };
          });

          // Initialize DataTable
          initializeReminderAppsTable(applicationsData);
          
          // Update send message button action
          modal.find('.sendReminderMsg').data('action', action);
      });

      // Show modal
      const bsModal = new bootstrap.Modal(document.getElementById('reminderAppsModal'));
      bsModal.show();
  });

  function initializeReminderAppsTable(data) {

      // Initialize new DataTable
      $('#reminderAppsTable').DataTable({
          data: data,
          destroy: true, // This is the key - destroys previous instance
          responsive: true,
          dom: 'Bfrtip',
          buttons: [
              {
                  extend: 'excel',
                  text: '<i class="ri-file-excel-line me-1"></i>Excel',
                  className: 'btn btn-outline-primary btn-sm',
                  exportOptions: {
                      columns: ':visible'
                  }
              },
              {
                  extend: 'print',
                  text: '<i class="ri-printer-line me-1"></i>Print',
                  className: 'btn btn-outline-secondary btn-sm',
                  exportOptions: {
                      columns: ':visible'
                  }
              },
              // {
              //     extend: 'colvis',
              //     text: '<i class="ri-eye-line me-1"></i>Columns',
              //     className: 'btn btn-outline-info btn-sm'
              // }
          ],
          columns: [
              { 
                  data: 'job_number',
                  render: function(data, type, row) {
                      return `<span class="fw-medium text-primary small">${data}</span>`;
                  }
              },
              { 
                  data: 'business_process_sub_name',
                  render: function(data, type, row) {
                      return `<span class="text-muted small">${data}</span>`;
                  }
              },
              { 
                  data: 'receiver_name_',
                  render: function(data, type, row) {
                      return `
                          <div class="d-flex align-items-center">
                              <div class="avatar avatar-xs bg-light rounded-circle me-2">
                                  <i class="ri-user-line text-muted"></i>
                              </div>
                              <div>
                                  <div class="fw-medium small">${data}</div>
                              </div>
                          </div>
                      `;
                  }
              },
              { 
                  data: 'division_name',
                  render: function(data, type, row) {
                      return `<span class="badge bg-light text-dark">${data}</span>`;
                  }
              },
              { 
                  data: 'tat',
                  render: function(data, type, row) {
                      let badgeClass = 'bg-success';
                      let badgeText = 'Normal';
                      
                      if (data > 700) {
                          badgeClass = 'bg-danger';
                          badgeText = 'Critical';
                      } else if (data > 500) {
                          badgeClass = 'bg-warning';
                          badgeText = 'Warning';
                      }
                      
                      return `
                          <div class="d-flex align-items-center">
                              <span class="badge ${badgeClass}">${badgeText}</span>
                              <small class="text-muted ms-2 small">${data} days</small>
                          </div>
                      `;
                  }
              },
              { 
                  data: 'created_date',
                  render: function(data, type, row) {
                      return `<span class="small">${data}</span>`;
                  }
              },
              { 
                  data: null,
                  orderable: false,
                  searchable: false,
                  render: function(data, type, row) {
                      return `
                          <div class="btn-group" role="group">
                              <button type="button" class="btn btn-sm btn-outline-primary dropdown-toggle" 
                                      data-bs-toggle="dropdown" aria-expanded="false">
                                  <i class="ri-settings-3-line"></i>
                              </button>
                              <ul class="dropdown-menu">
                                  <li>
                                      <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                                          <input type="hidden" name="case_number" value="${row.transaction_number}">
                                          <input type="hidden" name="search_text" value="${row.case_number}">
                                          <input type="hidden" name="job_number" value="${row.job_number}">
                                          <input type="hidden" name="business_process_sub_name" value="${row.business_process_sub_name}">
                                          <button type="submit" name="save" class="dropdown-item">
                                              <i class="ri-eye-line me-1"></i>View Application
                                          </button>
                                      </form>
                                  </li>
                                  <!--<li>
                                      <a class="dropdown-item sendMessage" href="#" 
                                        data-job_number="${row.job_number}" 
                                        data-staff='${JSON.stringify(row.receiver_name_)}'>
                                          <i class="ri-message-2-line me-1"></i>Send Message
                                      </a>
                                  </li>
                                  <li><hr class="dropdown-divider"></li>
                                  <li>
                                      <a class="dropdown-item text-danger" href="#" 
                                        data-notice-id="${row.notice_id}">
                                          <i class="ri-delete-bin-line me-1"></i>Dismiss Warning
                                      </a>
                                  </li>-->
                              </ul>
                          </div>
                      `;
                  }
              }
          ],
          order: [[4, 'desc']], // Sort by TAT descending by default
          pageLength: 10,
          language: {
              emptyTable: "No reminder applications found",
              info: "Showing _START_ to _END_ of _TOTAL_ entries",
              infoEmpty: "Showing 0 to 0 of 0 entries",
              infoFiltered: "(filtered from _MAX_ total entries)",
              lengthMenu: "Show _MENU_ entries",
              loadingRecords: "Loading...",
              processing: "Processing...",
              search: "",
              searchPlaceholder: "Search applications...",
              zeroRecords: "No matching records found",
              paginate: {
                  first: '<i class="ri-arrow-left-s-line"></i>',
                  last: '<i class="ri-arrow-right-s-line"></i>',
                  next: '<i class="ri-arrow-right-s-line"></i>',
                  previous: '<i class="ri-arrow-left-s-line"></i>'
              }
          },
          initComplete: function() {
              // Add custom search input
              $('#reminderAppsTableSearch').off('keyup').on('keyup', function() {
                  reminderAppsTable.search(this.value).draw();
              });
          },
          drawCallback: function() {
              // Update any dynamic content after table draw
              // updateTableStats();
          }
      });
  }

  $('#reminderAppsModal').on('hidden.bs.modal', function() {
    if (reminderAppsTable) {
        reminderAppsTable.destroy();
        reminderAppsTable = null;
    }
});

  // Global DataTable variable
  let warningAppsTable = null;

  $(document).on("click", ".loadWarningApps", function (event) {
      event.preventDefault();

      let item = $(this);
      let modal = $("#warningAppsModal");
      let type = item.data("type") ?? "";
      let title = item.data("title");
      let date = item.data("date") ?? "";
      let url = item.data("url");
      let method = item.data("method");
      let period = item.data("period");
      
      // Update modal title
      modal.find("#modalTitleText").html(
          `${type}'s Reminder ${title} <span class="text-primary">${date}</span>`
      );

      let action =
        method +
        (typeof period === "undefined" ? "" : `_${period}`) +
        (typeof by === "undefined" ? "" : `_${by}`) +
        "_officers";

      // Submit AJAX request
      submitAjax(url, action, {}, function (data) {
          data = data.reminder_app_count || [];

          // Process data for DataTables
          let applicationsData = data.map(function (item) {
              return {
                  job_number: item.job_number || 'N/A',
                  business_process_sub_name: item.business_process_sub_name || 'N/A',
                  receiver_name_: item.receiver_name_ || 'N/A',
                  division_name: item.division_name || 'N/A',
                  tat: item.tat || 0,
                  created_date: formatDate(item.created_date) || 'N/A',
                  notice_id: item.notice_id,
                  transaction_number: item.transaction_number,
                  case_number: item.case_number,
                  // Additional data for actions
                  _details: item.details,
                  _notice_type: item.notice_type,
                  _status: item.status,
                  _region_name: item.region_name
              };
          });

          // Initialize DataTable
          initializeWarningAppsTable(applicationsData);
          
          // Update send message button action
          modal.find('.sendReminderMsg').data('action', action);
      });

      // Show modal
      const bsModal = new bootstrap.Modal(document.getElementById('warningAppsModal'));
      bsModal.show();
  });

  // Initialize DataTable with the data
  function initializeWarningAppsTable(data) {

      // Initialize new DataTable
      $('#warningAppsTable').DataTable({
          data: data,
          destroy: true, // This is the key - destroys previous instance
          responsive: true,
          dom: 'Bfrtip',
          buttons: [
              {
                  extend: 'excel',
                  text: '<i class="ri-file-excel-line me-1"></i>Excel',
                  className: 'btn btn-outline-primary btn-sm',
                  exportOptions: {
                      columns: ':visible'
                  }
              },
              {
                  extend: 'print',
                  text: '<i class="ri-printer-line me-1"></i>Print',
                  className: 'btn btn-outline-secondary btn-sm',
                  exportOptions: {
                      columns: ':visible'
                  }
              },
              // {
              //     extend: 'colvis',
              //     text: '<i class="ri-eye-line me-1"></i>Columns',
              //     className: 'btn btn-outline-info btn-sm'
              // }
          ],
          columns: [
              { 
                  data: 'job_number',
                  render: function(data, type, row) {
                      return `<span class="fw-medium text-primary small">${data}</span>`;
                  }
              },
              { 
                  data: 'business_process_sub_name',
                  render: function(data, type, row) {
                      return `<span class="text-muted small">${data}</span>`;
                  }
              },
              { 
                  data: 'receiver_name_',
                  render: function(data, type, row) {
                      return `
                          <div class="d-flex align-items-center">
                              <div class="avatar avatar-xs bg-light rounded-circle me-2">
                                  <i class="ri-user-line text-muted"></i>
                              </div>
                              <div>
                                  <div class="fw-medium small">${data}</div>
                              </div>
                          </div>
                      `;
                  }
              },
              { 
                  data: 'division_name',
                  render: function(data, type, row) {
                      return `<span class="badge bg-light text-dark">${data}</span>`;
                  }
              },
              { 
                  data: 'tat',
                  render: function(data, type, row) {
                      let badgeClass = 'bg-success';
                      let badgeText = 'Normal';
                      
                      if (data > 90) {
                          badgeClass = 'bg-danger';
                          badgeText = 'Critical';
                      } else if (data > 20) {
                          badgeClass = 'bg-warning';
                          badgeText = 'Warning';
                      }
                      
                      return `
                          <div class="d-flex align-items-center">
                              <span class="badge ${badgeClass}">${badgeText}</span>
                              <small class="text-muted ms-2 small">${data} days</small>
                          </div>
                      `;
                  }
              },
              { 
                  data: 'created_date',
                  render: function(data, type, row) {
                      return `<span class="small">${data}</span>`;
                  }
              },
              { 
                  data: null,
                  orderable: false,
                  searchable: false,
                  render: function(data, type, row) {
                      return `
                          <div class="btn-group" role="group">
                              <button type="button" class="btn btn-sm btn-outline-primary dropdown-toggle" 
                                      data-bs-toggle="dropdown" aria-expanded="false">
                                  <i class="ri-settings-3-line"></i>
                              </button>
                              <ul class="dropdown-menu">
                                  <li>
                                      <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                                          <input type="hidden" name="case_number" value="${row.transaction_number}">
                                          <input type="hidden" name="search_text" value="${row.case_number}">
                                          <input type="hidden" name="job_number" value="${row.job_number}">
                                          <input type="hidden" name="business_process_sub_name" value="${row.business_process_sub_name}">
                                          <button type="submit" name="save" class="dropdown-item">
                                              <i class="ri-eye-line me-1"></i>View Application
                                          </button>
                                      </form>
                                  </li>
                                  <!--<li>
                                      <a class="dropdown-item sendMessage" href="#" 
                                        data-job_number="${row.job_number}" 
                                        data-staff='${JSON.stringify(row.receiver_name_)}'>
                                          <i class="ri-message-2-line me-1"></i>Send Message
                                      </a>
                                  </li>
                                  <li><hr class="dropdown-divider"></li>
                                  <li>
                                      <a class="dropdown-item text-danger" href="#" 
                                        data-notice-id="${row.notice_id}">
                                          <i class="ri-delete-bin-line me-1"></i>Dismiss Warning
                                      </a>
                                  </li>-->
                              </ul>
                          </div>
                      `;
                  }
              }
          ],
          order: [[4, 'desc']], // Sort by TAT descending by default
          pageLength: 10,
          language: {
              emptyTable: "No warning applications found",
              info: "Showing _START_ to _END_ of _TOTAL_ entries",
              infoEmpty: "Showing 0 to 0 of 0 entries",
              infoFiltered: "(filtered from _MAX_ total entries)",
              lengthMenu: "Show _MENU_ entries",
              loadingRecords: "Loading...",
              processing: "Processing...",
              search: "",
              searchPlaceholder: "Search applications...",
              zeroRecords: "No matching records found",
              paginate: {
                  first: '<i class="ri-arrow-left-s-line"></i>',
                  last: '<i class="ri-arrow-right-s-line"></i>',
                  next: '<i class="ri-arrow-right-s-line"></i>',
                  previous: '<i class="ri-arrow-left-s-line"></i>'
              }
          },
          initComplete: function() {
              // Add custom search input
              $('#warningAppsTableSearch').off('keyup').on('keyup', function() {
                  warningAppsTable.search(this.value).draw();
              });
          },
          drawCallback: function() {
              // Update any dynamic content after table draw
              //updateTableStats();
          }
      });
  }

  // Helper function to format date
  function formatDate(dateString) {
    if (!dateString) return '';

    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  }

  // Update table statistics
  // function updateTableStats() {
  //   if (warningAppsTable) {
  //     const total = warningAppsTable.data().count();
  //     const critical = warningAppsTable.column(4).data().toArray()
  //       .filter(tat => tat > 700).length;
  //     const warning = warningAppsTable.column(4).data().toArray()
  //       .filter(tat => tat > 500 && tat <= 700).length;

  //     // You can display these stats somewhere if needed
  //     // console.log(`Total: ${total}, Critical: ${critical}, Warning: ${warning}`);
  //   }
  // }

  // Clean up when modal closes
$('#warningAppsModal').on('hidden.bs.modal', function() {
    if (warningAppsTable) {
        warningAppsTable.destroy();
        warningAppsTable = null;
    }
});

  $(document).on("click", ".sendReminderMsg", function (event) {
    event.preventDefault();
    
    const $button = $(this);
    const modal = $button.closest(".modal");
    let dataTable;
    
    // Try to get the DataTable
    try {
        dataTable = modal.find("table").DataTable();
        if (!dataTable) {
            throw new Error("DataTable not found");
        }
    } catch (error) {
        console.error("Error accessing DataTable:", error);
        Swal.fire({
            title: "Error!",
            text: "Unable to access application data. Please try refreshing the table.",
            icon: "error",
            confirmButtonText: "OK",
            confirmButtonColor: "#0d6efd"
        });
        return;
    }
    
    // Get job numbers from DataTable
    const jobNumbers = dataTable
        .rows()
        .data()
        .toArray()
        .map((currentItem) => {
            return { 
                job_number: currentItem.job_number || '',
                receiver_name: currentItem.receiver_name_ || 'Unknown'
            };
        })
        .filter(item => item.job_number); // Filter out empty job numbers
    
    // Check if there are any job numbers
    if (jobNumbers.length === 0) {
        Swal.fire({
            title: "No Applications",
            text: "There are no applications to send reminders for.",
            icon: "warning",
            confirmButtonText: "OK",
            confirmButtonColor: "#0d6efd"
        });
        return;
    }
    
    // Count unique receivers
    const uniqueReceivers = [...new Set(jobNumbers.map(item => item.receiver_name))];
    
    // Prepare confirmation message
    const confirmationMessage = `
        <div class="text-start">
            <p>You are about to send reminders for:</p>
            <ul class="mb-3">
                <li><strong>${jobNumbers.length}</strong> application(s)</li>
                <li><strong>${uniqueReceivers.length}</strong> recipient(s)</li>
            </ul>
            <div class="alert alert-warning small">
                <i class="ri-alert-line me-1"></i>
                This action will send reminder messages to all selected recipients.
            </div>
        </div>
    `;
    
    // Show confirmation dialog
    Swal.fire({
        title: "Send Reminder Messages",
        html: confirmationMessage,
        icon: "question",
        showCancelButton: true,
        confirmButtonText: "Yes, Send Messages",
        cancelButtonText: "Cancel",
        confirmButtonColor: "#0d6efd",
        cancelButtonColor: "#6c757d",
        reverseButtons: true,
        showLoaderOnConfirm: true,
        preConfirm: () => {
            return new Promise((resolve, reject) => {
                const data = {
                    "job_numbers": JSON.stringify(jobNumbers.map(item => ({ job_number: item.job_number })))
                };
                
                submitAjax(
                    "DashboardAppsWithDivision",
                    "send_reminder_jobs_to_active",
                    data,
                    function (response) {
                        resolve(response);
                    },
                    function (error) {
                        reject(error);
                    }
                );
            });
        },
        allowOutsideClick: () => !Swal.isLoading()
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire({
                title: "Success!",
                text: "Reminder messages sent successfully.",
                icon: "success",
                confirmButtonText: "OK",
                confirmButtonColor: "#0d6efd",
                timer: 3000,
                timerProgressBar: true,
                didOpen: () => {
                    const timer = Swal.getPopup().querySelector("b");
                    if (timer) {
                        timerInterval = setInterval(() => {
                            timer.textContent = `${Swal.getTimerLeft()}`;
                        }, 100);
                    }
                },
                willClose: () => {
                    clearInterval(timerInterval);
                }
            }).then(() => {
                // Optional: Refresh the table data after successful send
                // dataTable.ajax.reload();
            });
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            Swal.fire({
                title: "Cancelled",
                text: "Reminder messages were not sent.",
                icon: "info",
                confirmButtonText: "OK",
                confirmButtonColor: "#6c757d",
                timer: 2000
            });
        }
    }).catch((error) => {
        console.error("Error sending reminders:", error);
        
        let errorMessage = "We were not able to send your messages. ";
        if (error && error.message) {
            errorMessage += error.message;
        } else {
            errorMessage += "Please contact IT support if the issue persists.";
        }
        
        Swal.fire({
            title: "Error!",
            text: errorMessage,
            icon: "error",
            confirmButtonText: "OK",
            confirmButtonColor: "#dc3545"
        });
    });
});

  let complianceTable = null;

$(document).on("click", ".loadComplianceQueriesApps", function (e) {
    e.preventDefault();
    loadComplianceApplications();
});

// Function to load compliance applications
function loadComplianceApplications() {

    const modalEl = document.getElementById('unitComplianceModal');

    // 1️⃣ Check if instance already exists
    let bsModal = bootstrap.Modal.getInstance(modalEl);

    if (bsModal) {
        // 2️⃣ Kill existing modal completely
        bsModal.hide();
        bsModal.dispose();
    }

    // 3️⃣ Create a fresh modal instance
    bsModal = new bootstrap.Modal(modalEl, {
        backdrop: 'static',
        keyboard: false
    });

    // 4️⃣ Open modal
    bsModal.show();
    
    // Show loading state
    $('#complianceLoading').show();
    $('#complianceEmpty').hide();
    $('#complianceTable').closest('.table-responsive').show();
    
    // Load data
    $.ajax({
        type: "POST",
        url: "DashboardAppsWithDivision",
        data: {
            request_type: 'select_compliance_application_notice_by_unit'
        },
        cache: false,
        success: function (result) {
            try {
                const response = JSON.parse(result);
                
                // Hide loading
                $('#complianceLoading').hide();
                
                if (response.compliance_application_notice && response.compliance_application_notice.length > 0) {
                    // Process data
                    const dataSet = processComplianceData(response.compliance_application_notice);
                    
                    // Initialize or update DataTable
                    initializeComplianceTable(dataSet);
                    
                    // Show table
                    $('#complianceTable').closest('.table-responsive').show();
                    $('#complianceEmpty').hide();
                } else {
                    // Show empty state
                    $('#complianceTable').closest('.table-responsive').hide();
                    $('#complianceEmpty').show();
                }
                
                // Show modal
                bsModal.show();
                
            } catch (error) {
                console.error('Error processing compliance data:', error);
                $('#complianceLoading').hide();
                $('#complianceEmpty').show();
                
                // Show error notification
                Swal.fire({
                    title: 'Error',
                    text: 'Failed to load compliance applications',
                    icon: 'error',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#dc3545'
                });
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX error:', error);
            $('#complianceLoading').hide();
            $('#complianceEmpty').show();
            
            Swal.fire({
                title: 'Connection Error',
                text: 'Unable to load data. Please check your connection.',
                icon: 'error',
                confirmButtonText: 'OK',
                confirmButtonColor: '#dc3545'
            });
        }
    });
}

// Process compliance data
function processComplianceData(data) {
    const userid = $('#userid').val();

    // console.log(data)
    
    return data.map((item, index) => {
        const noticeId = item.notice_id;
        const jobNumber = item.job_number || 'N/A';
        const details = item.details || 'No details';
        const receiverName = item.receiver_name_ || 'N/A';
        const divisionName = item.division_name || 'N/A';
        const regionName = item.region_name || 'N/A';
        const createdBy = item.created_by || 'N/A';
        const reply = item.reply || 0;
        const noticeType = item.notice_type || 'Unknown';
        const tat = item.tat || 0;
        const createdDate = convertDate(item.created_date?.slice(0, 10)) || 'N/A';
        
        // Determine row class based on notice type and reply
        let rowClass = '';
        if (reply > 0) {
            rowClass = 'table-primary';
        } else if (noticeType.toLowerCase() === 'query') {
            rowClass = 'table-danger';
        } else if (noticeType === 'Warning') {
            rowClass = 'table-warning';
        } else if (noticeType === 'Reminder') {
            rowClass = 'table-info';
        } else {
            rowClass = 'table-success';
        }
        
        // Create action buttons
        const actions = createActionButtons(item, userid);
        
        return {
            index: index + 1,
            job_number: jobNumber,
            details: details,
            receiver_name: receiverName,
            division_name: divisionName,
            region_name: regionName,
            created_by: createdBy,
            reply: reply,
            notice_type: noticeType,
            tat: tat,
            created_date: createdDate,
            actions: actions,
            row_class: rowClass,
            // Additional data for actions
            _notice_id: noticeId,
            _case_number: item.case_number,
            _created_by_id: item.created_by_id,
            _transaction_number: item.transaction_number,
            _business_process_sub_name: item.business_process_sub_name
        };
    });
}

// Create action buttons
function createActionButtons(item, userId) {
    const isOwner = userId == item.created_by_id;
    
    return `
        <div class="dropdown action-dropdown">
            <button class="btn btn-sm btn-outline-primary dropdown-toggle" type="button" 
                    data-bs-toggle="dropdown" aria-expanded="false">
                <i class="ri-settings-3-line"></i>
            </button>
            <ul class="dropdown-menu dropdown-menu-end">
                <li>
                    <form action="front_office_view_application" method="post" target="_blank">
                        <input type="hidden" name="case_number" value="${item.transaction_number}">
                        <input type="hidden" name="search_text" value="${item.case_number}">
                        <input type="hidden" name="job_number" value="${item.job_number}">
                        <input type="hidden" name="business_process_sub_name" value="${item.business_process_sub_name}">
                        <button type="submit" class="dropdown-item">
                            <i class="ri-eye-line me-2"></i>View Application
                        </button>
                    </form>
                </li>
                <li>
                    <button type="button" class="dropdown-item view-messages" 
                            data-notice_id="${item.notice_id}">
                        <i class="ri-message-2-line me-2"></i>View Messages
                    </button>
                </li>
                <li>
                    <button type="button" class="dropdown-item sendMessage_unit_case" 
                            data-receiver_name="${item.receiver_name_}"
                            data-officer_name="${item.receiver_name_}"
                            data-job_number="${item.job_number}"
                            data-officer_id="${item.receiver_id}">
                        <i class="ri-send-plane-line me-2"></i>Send Message
                    </button>
                </li>
                ${isOwner ? `
                <li>
                    <button type="button" class="dropdown-item set-inactive" 
                            data-job-number="${item.job_number}">
                        <i class="ri-toggle-line me-2"></i>Set To Inactive
                    </button>
                </li>
                ` : ''}
            </ul>
        </div>
    `;
}

// Initialize DataTable
function initializeComplianceTable(dataSet) {

  // console.log(dataSet)
    
    // Initialize DataTable
    $('#complianceTable').DataTable({
        data: dataSet,
        destroy: true, // This is the key - destroys previous instance
        responsive: true,
        dom: 'Bfrtip',
          buttons: [
              {
                  extend: 'excel',
                  text: '<i class="ri-file-excel-line me-1"></i>Excel',
                  className: 'btn btn-outline-primary btn-sm',
                  exportOptions: {
                      columns: ':visible'
                  }
              },
              {
                  extend: 'print',
                  text: '<i class="ri-printer-line me-1"></i>Print',
                  className: 'btn btn-outline-secondary btn-sm',
                  exportOptions: {
                      columns: ':visible'
                  }
              },
              // {
              //     extend: 'colvis',
              //     text: '<i class="ri-eye-line me-1"></i>Columns',
              //     className: 'btn btn-outline-info btn-sm'
              // }
          ],
        columns: [
            { 
                data: 'index',
                className: 'text-center'
            },
            { 
                data: 'job_number',
                render: function(data) {
                    return `<span class="fw-medium text-primary">${data}</span>`;
                }
            },
            { 
                data: 'details',
                render: function(data) {
                    return `<span class="small" data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" title="${data}" data->${truncateText(data, 80)}</span>`;
                }
            },
            { 
                data: 'receiver_name',
                render: function(data) {
                    return `<span class="small">${data}</span>`;
                }
            },
            { 
                data: 'created_by',
                render: function(data) {
                    return `<span class="small">${data}</span>`;
                }
            },
            { 
                data: 'tat',
                render: function(data) {
                    let badgeClass = 'bg-success';
                    let badgeText = 'Normal';
                    
                    if (data > 90) {
                        badgeClass = 'bg-danger';
                        badgeText = 'Critical';
                    } else if (data > 20) {
                        badgeClass = 'bg-warning';
                        badgeText = 'Warning';
                    }
                    
                    return `
                        <div class="d-flex align-items-center">
                            <span class="badge ${badgeClass}">${badgeText}</span>
                            <small class="text-muted ms-2">${data}d</small>
                        </div>
                    `;
                }
            },
            { 
                data: 'created_date',
                render: function(data) {
                    return `<span class="small">${data}</span>`;
                }
            },
            { 
                data: 'actions',
                orderable: false,
                searchable: false,
                className: 'text-end'
            }
        ],
        createdRow: function(row, data) {
            if (data.row_class) {
                $(row).addClass(data.row_class);
            }
        },
        order: [[4, 'desc']], // Sort by TAT descending by default
          pageLength: 10,
          language: {
              emptyTable: "No warning applications found",
              info: "Showing _START_ to _END_ of _TOTAL_ entries",
              infoEmpty: "Showing 0 to 0 of 0 entries",
              infoFiltered: "(filtered from _MAX_ total entries)",
              lengthMenu: "Show _MENU_ entries",
              loadingRecords: "Loading...",
              processing: "Processing...",
              search: "",
              searchPlaceholder: "Search applications...",
              zeroRecords: "No matching records found",
              paginate: {
                  first: '<i class="ri-arrow-left-s-line"></i>',
                  last: '<i class="ri-arrow-right-s-line"></i>',
                  next: '<i class="ri-arrow-right-s-line"></i>',
                  previous: '<i class="ri-arrow-left-s-line"></i>'
              }
          },
          initComplete: function() {
              // Add custom search input
              $('#complianceTable').off('keyup').on('keyup', function() {
                  warningAppsTable.search(this.value).draw();
              });
          },
          drawCallback: function() {
              // Update any dynamic content after table draw
              //updateTableStats();
          }
    });

    setTimeout(function() {
      window.initializeTooltips();
    }, 50);
}

// Helper function to truncate text
function truncateText(text, maxLength) {
    if (!text) return '';
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
}

// Helper function to convert date
function convertDate(dateString) {
    if (!dateString) return '';
    
    try {
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric'
        });
    } catch (e) {
        return dateString;
    }
}

// Event handlers for action buttons
$(document).on('click', '.view-messages', function() {
    $('#viewresponseModal').modal('show');

    // Load messages for this noticeId
    const noticeId = $(this).data('notice_id');
    const modal = $('#viewresponseModal');
    
    // Show loading state
    modal.find('#responseLoading').removeClass('d-none');
    modal.find('#responseContainer').addClass('d-none');
    modal.find('#responseEmpty').addClass('d-none');
    
    // Clear previous content
    modal.find('#response_list').empty();
    modal.find('#responseCount').text('0 responses');
    
    // Prepare data
    const data = {
        "notice_id": noticeId,
        "request_type": "select_responses_on_compliance_application_notice",
    };
    
    // Make AJAX request
    $.ajax({
        type: "POST",
        url: "/SendComplianceMessage",
        data: data,
        cache: false,
        success: function(result) {
            try {
                const response = JSON.parse(result);
                
                // Hide loading
                modal.find('#responseLoading').addClass('d-none');
                
                if (response.data && response.data.length > 0) {
                                   response.data.sort((a, b) => {
                        return new Date(b.created_date) - new Date(a.created_date);
                    });

                    let html = '';
                    let responseCount = response.data.length;

                    response.data.forEach((item, index) => {
                        html += `
                            <li>
                            <div class="d-flex align-items-start gap-3">
                                <div>
                                    <span class="avatar avatar-md bg-warning rounded-circle me-2">
                                        <i class="ri-user-line"></i>
                                    </span>
                                </div>
                                <div class="flex-fill">
                                    <div class="d-flex align-items-start justify-content-between mb-1 flex-wrap">
                                        <div class="d-block fw-semibold">${item.created_by || 'Unknown User'}</div>
                                        <span class="badge bg-light text-muted border">
                                            ${convertDate(item.created_date.slice(0,10))}
                                        </span>
                                    </div>
                                    <div class="descrption">
                                        ${item.reply_details || 'No details provided'}
                                    </div>
                                </div>
                            </div>
                            </li>
                        `;
                    });

                    modal.find('#responseCount').text(
                        `${responseCount} ${responseCount === 1 ? 'response' : 'responses'}`
                    );

                    modal.find('#response_list').html(html);
                    modal.find('#responseContainer').removeClass('d-none');
                    
                    // Add animation to timeline items
                    setTimeout(() => {
                        modal.find('.timeline-item').each(function(index) {
                            $(this).css({
                                'opacity': '0',
                                'transform': 'translateX(-20px)'
                            }).delay(100 * index).animate({
                                'opacity': '1',
                                'transform': 'translateX(0)'
                            }, 300);
                        });
                    }, 100);
                    
                } else {
                    // Show empty state
                    modal.find('#responseEmpty').removeClass('d-none');
                }
                
            } catch (error) {
                console.error('Error parsing response:', error);
                modal.find('#responseLoading').addClass('d-none');
                modal.find('#response_list').html(`
                    <div class="alert alert-danger">
                        <i class="bi bi-exclamation-triangle me-2"></i>
                        Error loading responses. Please try again.
                    </div>
                `);
                modal.find('#responseContainer').removeClass('d-none');
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', error);
            modal.find('#responseLoading').addClass('d-none');
            modal.find('#response_list').html(`
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    Failed to load responses. Please check your connection and try again.
                </div>
            `);
            modal.find('#responseContainer').removeClass('d-none');
        }
    });
});

$(document).on('click', '.set-inactive', function() {
    const jobNumber = $(this).data('job-number');
    
    Swal.fire({
        title: 'Set Application Inactive?',
        text: `Are you sure you want to set application ${jobNumber} to inactive?`,
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Yes, Set Inactive',
        cancelButtonText: 'Cancel',
        confirmButtonColor: '#dc3545',
        cancelButtonColor: '#6c757d',
        reverseButtons: true
    }).then((result) => {
        if (result.isConfirmed) {
            // Submit to change status
            $.ajax({
                type: "POST",
                url: "YourEndpointHere",
                data: {
                    request_type: 'set_application_inactive',
                    job_number: jobNumber
                },
                success: function(response) {
                    Swal.fire({
                        title: 'Success!',
                        text: 'Application status updated to inactive',
                        icon: 'success',
                        confirmButtonText: 'OK',
                        confirmButtonColor: '#0d6efd',
                        timer: 3000
                    }).then(() => {
                        // Refresh the table
                        loadComplianceApplications();
                    });
                },
                error: function() {
                    Swal.fire({
                        title: 'Error!',
                        text: 'Failed to update application status',
                        icon: 'error',
                        confirmButtonText: 'OK',
                        confirmButtonColor: '#dc3545'
                    });
                }
            });
        }
    });
});

// Refresh button handler
$('#btnRefreshCompliance').on('click', loadComplianceApplications);

// Clean up when modal closes
$('#unitComplianceModal').on('hidden.bs.modal', function() {
    // Optional: Clear any temporary data
});


$(document).on("click", ".sendMessage_unit_case", function (event) {
    event.preventDefault();
    
    const officerName = $(this).data('officer_name');
    const receiverName = $(this).data('receiver_name');
    const jobNumber = $(this).data('job_number');
    const officerId = $(this).data('officer_id');
    
    // Parse job numbers (could be a single job number or array)
    let jobNumbersArray = [];
    if (jobNumber) {
        if (Array.isArray(jobNumber)) {
            jobNumbersArray = jobNumber.map(job => ({ job_number: job }));
        } else {
            jobNumbersArray = [{ job_number: jobNumber }];
        }
    }
    
    // Update modal with data
    updateSendMessageModal({
        officer_id: officerId,
        officer_name: officerName,
        receiver_name: receiverName,
        job_numbers: jobNumbersArray
    });
});



$(document).on("click", ".messageReply", function (event) {
  event.preventDefault();

  const staffName = $(this).data('staffName');
  const staffId = $(this).data('staff_id');
  const jobNumber = $(this).data('job_number');

  console.log("Job Number:", jobNumber);
  console.log("Modal element exists:", $("#previousNoticesModal").length > 0);

   let title = "Notice(s) sent on Appication With Job Number "+jobNumber
  document.getElementById('previousNoticesModalLabel').innerHTML = title;

//   sendMessageModal.find("#modalTitleText").html(titleText);


  previousNoticesModalLabel
  
  // Try showing modal
  var modalElement = document.getElementById('previousNoticesModal');
  if (modalElement) {
    var modal = new bootstrap.Modal(modalElement);
    modal.show();
  } else {
    console.error("Modal element not found!");
  }

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






// Function to update the send message modal with data
function updateSendMessageModal(data) {
    const modal = document.getElementById('sendMessageModal');
    const sendMessageModal = $(modal);

    console.log(data);
    
    // Update hidden fields
    sendMessageModal.find("#officer_id").val(data.officer_id || '');
    sendMessageModal.find("#officer_name").val(data.officer_name || '');
    sendMessageModal.find("#job_numbers").val(JSON.stringify(data.job_numbers || []));
    
    // Update modal title
    const titleText = data.receiver_name ? 
        `Send Message to <span class="text-primary">${data.receiver_name}</span>` : 
        'Send Message';
    sendMessageModal.find("#modalTitleText").html(titleText);
    
    // Update recipient info card
    if (data.receiver_name) {
        sendMessageModal.find("#recipientNameDisplay").text(data.receiver_name);
    } else if (data.officer_name) {
        sendMessageModal.find("#recipientNameDisplay").text(data.officer_name);
    } else {
        sendMessageModal.find("#recipientNameDisplay").text('Select a recipient');
    }
    
    // Update recipient info
    if (data.officer_id) {
        sendMessageModal.find("#recipientInfo").text(`ID: ${data.officer_id}`);
    } else {
        sendMessageModal.find("#recipientInfo").text('No ID available');
    }
    
    // Update job count badge
    const jobCount = Array.isArray(data.job_numbers) ? data.job_numbers.length : 0;
    sendMessageModal.find("#jobCountBadge").text(`${jobCount} ${jobCount === 1 ? 'job' : 'jobs'}`);
    
    // Reset form to clean state
    resetMessageForm();
    
    // Show the modal (Bootstrap 5)
    const bsModal = new bootstrap.Modal(modal);
    bsModal.show();
    
    // Log for debugging
    // console.log('Send message modal data:', {
    //     officer_id: data.officer_id,
    //     officer_name: data.officer_name,
    //     receiver_name: data.receiver_name,
    //     job_count: jobCount,
    //     job_numbers: data.job_numbers
    // });
}

// Reset message form function
function resetMessageForm() {
    // const form = $('#message-form')[0];
    // if (form) {
    //     form.reset();
    // }
    
    // Reset character count
    $('#charCount').text('0/1000 characters').removeClass('warning danger');
    
    // Reset preview
    $('#messagePreview').html('<small class="text-muted">Start typing to see preview</small>');
    $('#previewCard').hide();
    
    // Set default message type to "query" (since this is for compliance)
    $('#message_type_query').prop('checked', true);
    updateSubmitButton();
    
    // Clear any validation states
    $('.form-control').removeClass('is-invalid is-valid');
    $('#message-form').removeClass('was-validated');
    
    // Clear the message textarea
    $('#message').val('');
}

// Update submit button text based on message type
function updateSubmitButton() {
    const messageType = $('input[name="message_type"]:checked').val();
    let buttonText = 'Send Message';
    
    switch(messageType) {
        case 'query':
            buttonText = 'Send Query';
            break;
        case 'reminder':
            buttonText = 'Send Reminder';
            break;
        case 'message':
        default:
            buttonText = 'Send Message';
    }
    
    $('#submitButtonText').text(buttonText);
}

// Handle form submission
$(document).on('submit', '#message-form', function(e) {
    e.preventDefault();
    
    const form = $(this);
    const officerId = form.find('#officer_id').val();
    const officerName = form.find('#officer_name').val();
    const jobNumbers = form.find('#job_numbers').val();
    const messageType = form.find('input[name="message_type"]:checked').val();
    const message = form.find('#message').val().trim();
    
    // Validation
    if (!message) {
        Swal.fire({
            title: 'Message Required',
            text: 'Please enter a message to send.',
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#ffc107'
        });
        return false;
    }
    
    if (!officerId) {
        Swal.fire({
            title: 'No Recipient',
            text: 'No recipient selected for the message.',
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#ffc107'
        });
        return false;
    }
    
    // Parse job numbers
    let jobNumbersArray;
    try {
        jobNumbersArray = JSON.parse(jobNumbers);
    } catch (error) {
        console.error('Error parsing job numbers:', error);
        jobNumbersArray = [];
    }
    
    if (jobNumbersArray.length === 0) {
        Swal.fire({
            title: 'No Applications',
            text: 'No applications selected to send message for.',
            icon: 'warning',
            confirmButtonText: 'OK',
            confirmButtonColor: '#ffc107'
        });
        return false;
    }
    
    // Prepare confirmation message
    const jobCount = jobNumbersArray.length;
    const confirmationMessage = `
        <div class="text-start">
            <p>You are about to send a <strong>${messageType}</strong> to:</p>
            <ul class="mb-2">
                <li><strong>${officerName}</strong></li>
                <li><strong>${jobCount}</strong> application(s)</li>
            </ul>
            <div class="alert alert-light border small mt-3">
                <i class="ri-information-line me-1"></i>
                Message: "${message.substring(0, 100)}${message.length > 100 ? '...' : ''}"
            </div>
        </div>
    `;
    
    // Show confirmation dialog
    Swal.fire({
        title: 'Send Message?',
        html: confirmationMessage,
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Yes, Send Message',
        cancelButtonText: 'Cancel',
        confirmButtonColor: '#0d6efd',
        cancelButtonColor: '#6c757d',
        reverseButtons: true,
        showLoaderOnConfirm: true,
        preConfirm: () => {
            return new Promise((resolve, reject) => {
                // const formData = form.serialize();

                const formData = {
                  "request_type": $("#sendMessageModal").find("#request_type").val(),
                  "officer_id": officerId,
                  "officer_name": officerName,
                  "job_numbers" : jobNumbers,
                  "message_type" : messageType,
                  "message" : message
                }
                
                $.ajax({
                    type: "POST",
                    url: "SendComplianceMessage",
                    data: formData,
                    dataType: 'json',
                    success: function(response) {
                        if (response && response.success !== false) {
                            resolve(response);
                        } else {
                            reject(new Error(response?.message || 'Failed to send message'));
                        }
                    },
                    error: function(xhr, status, error) {
                        reject(new Error(`Server error: ${status}`));
                    }
                });
            });
        },
        allowOutsideClick: () => !Swal.isLoading()
    }).then((result) => {
        if (result.isConfirmed) {
            // Success handling
            const response = result.value;
            
            Swal.fire({
                title: 'Success!',
                html: `
                    <div class="text-center">
                        <div class="mb-3">
                            <i class="ri-checkbox-circle-line text-success" style="font-size: 4rem;"></i>
                        </div>
                        <h5 class="fw-semibold">Message Sent Successfully</h5>
                        <p class="text-muted">
                            Your ${messageType} has been sent to ${officerName}
                        </p>
                        ${response?.message_id ? `
                        <div class="alert alert-light border small mt-3">
                            <i class="ri-information-line me-1"></i>
                            Reference ID: <strong>${response.message_id}</strong>
                        </div>
                        ` : ''}
                    </div>
                `,
                icon: 'success',
                confirmButtonText: 'Done',
                confirmButtonColor: '#0d6efd',
                timer: 4000,
                timerProgressBar: true,
                willClose: () => {
                    // Close the modal after success
                    const modal = bootstrap.Modal.getInstance(document.getElementById('sendMessageModal'));
                    if (modal) {
                        modal.hide();
                    }
                    
                    // Reset the form for next use
                    resetMessageForm();
                }
            });
            
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            Swal.fire({
                title: 'Cancelled',
                text: 'Message was not sent.',
                icon: 'info',
                confirmButtonText: 'OK',
                confirmButtonColor: '#6c757d',
                timer: 2000
            });
        }
    }).catch((error) => {
        // Error handling
        console.error('Error sending message:', error);
        
        Swal.fire({
            title: 'Sending Failed',
            html: `
                <div class="text-center">
                    <div class="mb-3">
                        <i class="ri-error-warning-line text-danger" style="font-size: 4rem;"></i>
                    </div>
                    <h5 class="fw-semibold">Unable to Send Message</h5>
                    <p class="text-muted">
                        ${error.message || 'An unexpected error occurred. Please try again.'}
                    </p>
                    <div class="mt-3">
                        <button class="btn btn-outline-secondary me-2" onclick="Swal.close()">
                            Close
                        </button>
                        <button class="btn btn-primary" onclick="retrySendMessage()">
                            <i class="ri-refresh-line me-1"></i> Try Again
                        </button>
                    </div>
                </div>
            `,
            icon: 'error',
            showConfirmButton: false,
            showCancelButton: false
        });
    });
    
    return false;
});

// Retry function for error case
function retrySendMessage() {
    Swal.close();
    // Trigger form submission again after a delay
    setTimeout(() => {
        $('#message-form').trigger('submit');
    }, 500);
}

// Initialize message modal functionality on page load
$(document).ready(function() {
    // Character counter
    $('#message').on('input', function() {
        const length = $(this).val().length;
        $('#charCount').text(`${length}/1000 characters`);
        
        // Update character count styling
        $('#charCount').removeClass('warning danger');
        if (length > 800) {
            $('#charCount').addClass('warning');
        }
        if (length > 950) {
            $('#charCount').addClass('danger');
        }
        
        // Update preview
        updateMessagePreview();
    });
    
    // Template buttons
    $('.template-btn').on('click', function() {
        const template = $(this).data('template');
        insertTemplate(template);
    });
    
    // Message type radio buttons
    $('input[name="message_type"]').on('change', function() {
        updateMessagePreview();
        updateSubmitButton();
    });
    
    // Reset form button
    $('#btnResetForm').on('click', function() {
        resetMessageForm();
    });
});

// Helper function to update message preview
function updateMessagePreview() {
    const message = $('#message').val();
    const messageType = $('input[name="message_type"]:checked').val();
    const recipient = $('#recipientNameDisplay').text() || 'Recipient';
    
    let preview = '';
    
    if (message) {
        preview = `<strong>To:</strong> ${recipient}\n`;
        preview += `<strong>Type:</strong> ${messageType || 'Message'}\n\n`;
        preview += message.substring(0, 200);
        
        if (message.length > 200) {
            preview += '...';
        }
        
        // Show preview card
        $('#previewCard').show();
    } else {
        preview = '<small class="text-muted">Start typing to see preview</small>';
        $('#previewCard').hide();
    }
    
    $('#messagePreview').html(preview.replace(/\n/g, '<br>'));
}

// Helper function to insert template text
function insertTemplate(template) {
    const templates = {
        query: "Dear Officer,\n\nPlease provide an update on the status of the application mentioned above. This requires urgent attention.\n\nBest regards,\n[Your Name]",
        followup: "Dear Officer,\n\nFollowing up on the previous communication regarding this application. Please advise on the current status and any pending actions.\n\nRegards,\n[Your Name]",
        reminder: "Dear Officer,\n\nThis is a reminder that the application is approaching/passed its TAT deadline. Kindly expedite action to avoid further delays.\n\nThank you,\n[Your Name]",
        update: "Dear Officer,\n\nPlease update the status of this application in the system as soon as possible. If there are any issues, please let us know immediately.\n\nSincerely,\n[Your Name]"
    };
    
    const $textarea = $('#message');
    const currentText = $textarea.val();
    const templateText = templates[template] || '';
    
    // Insert template, preserving existing text
    if (currentText && !currentText.includes(templateText)) {
        $textarea.val(currentText + '\n\n' + templateText);
    } else if (!currentText) {
        $textarea.val(templateText);
    }
    
    // Trigger input event for character count and preview
    $textarea.trigger('input');
    
    // Show success notification
    Swal.fire({
        title: 'Template Inserted',
        text: `"${template}" template has been inserted`,
        icon: 'success',
        confirmButtonText: 'OK',
        confirmButtonColor: '#0d6efd',
        timer: 2000
    });
}

  $('#sendMessageModal').on('shown.bs.modal', function () {
    $("#unitComplianceModal").css("z-index", "1029");
  })

  // $('#sendMessageModal').on('hidden.bs.modal', function () {
  //   $("#unitComplianceModal").css("z-index", "");
  // })

  // $('#viewresponseModal').on('shown.bs.modal', function () {
  //   $("#unitComplianceModal").css("z-index", "1029");
  // })

  // $('#viewresponseModal').on('hidden.bs.modal', function () {
  //   $("#unitComplianceModal").css("z-index", "");
  // })

  // $('#changequerystatusModal').on('shown.bs.modal', function () {
  //   $("#unitComplianceModal").css("z-index", "1029");
  // })

  // $('#changequerystatusModal').on('hidden.bs.modal', function () {
  //   $("#unitComplianceModal").css("z-index", "");
  // })


  // $("#message-form").on("submit", function (event) {
  //   event.preventDefault();

  //   let form = $(this);
  //   let data = form.serializeArray();
  //   let csd_compliance = $('#csd_compliance').val()

  //   data = {
  //     "request_type": $("#sendMessageModal").find("#request_type").val(),
  //     "officer_id": $("#sendMessageModal").find("#officer_id").val(),
  //     "officer_name": $("#sendMessageModal").find("#officer_name").val(),
  //     "job_numbers": $("#sendMessageModal").find("#job_numbers").val(),
  //     "message_type": $("#sendMessageModal").find("#message_type").val(),
  //     "message": $("#sendMessageModal").find("#message").val(),
  //     "csd_compliance": csd_compliance
  //   }

  //   // console.log(data);


  //   // submitAjax(
  //   //   $(this).attr("action"),
  //   //   "send_compliance_message",
  //   //   data,
  //   //   function () {
  //   //     form.trigger("reset");
  //   //     form.parents(".modal").modal("hide");
  //   //     alert("Message sent successfully.");
  //   //   },
  //   //   function () {
  //   //     alert(
  //   //       "We were not able to send your message. Please contact IT support if issue persists."
  //   //     );
  //   //   }
  //   // );

  //   $.ajax({
  //     type: "POST",
  //     url: "/SendComplianceMessage",
  //     data: data,
  //     cache: false,
  //     beforeSend: function () {
  //       // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
  //     },
  //     success: function (result) {
  //       var response = JSON.parse(result);
  //       console.log(response);

  //       if (response.success == 'true') {

  //         form.trigger("reset");
  //         form.parents(".modal").modal("hide");
  //         alert("Message sent successfully.");

  //       } else {
  //         alert("We were not able to send your message. Please contact IT support if issue persists.");
  //       }
  //     }

  //   })
  // });

  $('#changequerystatusModal').on('show.bs.modal', function(event) {
            const button = $(event.relatedTarget);
            const jobNumber = button.data('job_number');
            
            // Update hidden input
            $('#changequerystatusModal #job_number').val(jobNumber);
            
            // Update display
            $('#displayJobNumber').text(jobNumber);
            
            // Update modal title with job number
            $('#changequerystatusModalLabel').html(`
                Set Query as Inactive
                <small class="text-muted d-block fw-normal mt-1">Job #${jobNumber}</small>
            `);
            
            // Reset form state
            const form = $('#update-query-form')[0];
            form.classList.remove('was-validated');
            $('#confirmInactive').prop('checked', false);
            $('#confirmSubmit').prop('disabled', true);
        });

        // Enable/disable submit button based on checkbox
        $('#changequerystatusModal').on('change', '#confirmInactive', function() {
            $('#confirmSubmit').prop('disabled', !this.checked);
        });

        $("#update-query-form").on("submit", function (event) {
        event.preventDefault();
        
        const form = $(this);
        const modal = $("#changequerystatusModal");
        const submitBtn = form.find('button[type="submit"]');
        const originalBtnText = submitBtn.html();
        
        // Get form data
        const formData = {
            "request_type": "update_compliance_application_notice",
            "job_number": modal.find("#job_number").val()
        };
        
        // Validate
        if (!formData.job_number) {
            showAlert("error", "Error", "Job number is required.");
            return;
        }
        
        // Show loading state
        submitBtn.prop("disabled", true).html(`
            <span class="mdi mdi-spin mdi-loading me-1" role="status" aria-hidden="true"></span>
            Processing...
        `);
        
        // Disable cancel button during submission
        modal.find('button[data-bs-dismiss="modal"]').prop("disabled", true);
        
        $.ajax({
            type: "POST",
            url: "/SendComplianceMessage",
            data: formData,
            cache: false,
            //dataType: "json", // Expect JSON response
            timeout: 30000, // 30 second timeout
            
            success: function(response) {
            // console.log("API Response:", response);
                
                if (response === "Success") {
                    submitBtn.html('<i class="ri-check-circle-fill me-1"></i> Success!');
                    submitBtn.removeClass("btn-warning").addClass("btn-success");

                    showSwalNotification(
                        "success",
                        "Query Updated",
                        response.message
                    );

                    setTimeout(() => {
                        modal.modal("hide");

                        setTimeout(() => {
                            submitBtn.html(originalBtnText).prop("disabled", false);
                            submitBtn.removeClass("btn-success").addClass("btn-warning");
                            modal.find('button[data-bs-dismiss="modal"]').prop("disabled", false);
                            form[0].reset();

                            if (typeof window.refreshQueryTable === "function") {
                                window.refreshQueryTable();
                            }

                            $(document).trigger(
                                "queryStatusUpdated",
                                [formData.job_number, "inactive"]
                            );
                        }, 300);
                    }, 1500);

                } else {
                    handleError(
                        response.message || "Update failed. Please try again.",
                        submitBtn,
                        originalBtnText
                    );
                    modal.find('button[data-bs-dismiss="modal"]').prop("disabled", false);
                }
            },
            
            error: function(xhr, status, error) {
                console.error("AJAX Error:", status, error);
                
                let errorMessage = "Network error. Please check your connection.";
                
                if (xhr.status === 0) {
                    errorMessage = "Cannot connect to server. Please check your network.";
                } else if (xhr.status === 404) {
                    errorMessage = "Request endpoint not found.";
                } else if (xhr.status === 500) {
                    errorMessage = "Server error. Please try again later.";
                } else if (xhr.responseJSON && xhr.responseJSON.message) {
                    errorMessage = xhr.responseJSON.message;
                }
                
                handleError(errorMessage, submitBtn, originalBtnText);
                modal.find('button[data-bs-dismiss="modal"]').prop("disabled", false);
            },
            
            complete: function() {
                // Re-enable cancel button if still in error state
                setTimeout(() => {
                    if (submitBtn.prop("disabled")) {
                        modal.find('button[data-bs-dismiss="modal"]').prop("disabled", false);
                    }
                }, 2000);
            }
        });
    });

// Helper function for error handling with SweetAlert2
async function handleError(message, submitBtn = null, originalBtnText = null) {
    if (submitBtn && originalBtnText) {
        submitBtn.html('<i class="ri-error-warning-line me-1"></i> Failed');
        submitBtn.removeClass("btn-warning").addClass("btn-danger");
    }
    
    // Show SweetAlert2 error notification
    await showSwalNotification('error', 'Update Failed', message);
    
    // Reset button after delay if provided
    if (submitBtn && originalBtnText) {
        setTimeout(() => {
            submitBtn.html(originalBtnText).prop("disabled", false);
            submitBtn.removeClass("btn-danger").addClass("btn-warning");
        }, 3000);
    }
}

// SweetAlert2 notification function (replaces toast)
function showSwalNotification(type, title, message, options = {}) {
    const defaultOptions = {
        icon: type,
        title: title,
        text: message,
        // toast: true,
        // position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer);
            toast.addEventListener('mouseleave', Swal.resumeTimer);
        }
    };
    
    // Merge custom options
    const finalOptions = { ...defaultOptions, ...options };
    
    return Swal.fire(finalOptions);
}

// Print functionality
// $(document).on('click', '#printResponses', function() {
//     const modal = $('#viewresponseModal');
//     const noticeId = modal.data('current-notice-id');
//     const responses = modal.find('#response_list').html();
    
//     // Create print window
//     const printWindow = window.open('', '_blank');
//     printWindow.document.write(`
//         <html>
//             <head>
//                 <title>Query Responses - Print</title>
//                 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
//                 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
//                 <style>
//                     body { padding: 20px; }
//                     .timeline-item { margin-bottom: 20px; }
//                     .timeline-content { 
//                         border: 1px solid #dee2e6; 
//                         padding: 15px; 
//                         border-radius: 5px; 
//                     }
//                     .timeline-header { 
//                         display: flex; 
//                         justify-content: space-between; 
//                         margin-bottom: 10px; 
//                         border-bottom: 1px solid #eee; 
//                         padding-bottom: 10px;
//                     }
//                     .print-header { 
//                         text-align: center; 
//                         margin-bottom: 30px; 
//                         border-bottom: 2px solid #007bff; 
//                         padding-bottom: 15px;
//                     }
//                     @media print {
//                         .no-print { display: none; }
//                     }
//                 </style>
//             </head>
//             <body>
//                 <div class="print-header">
//                     <h2>Query Responses</h2>
//                     <p class="text-muted">Notice ID: ${noticeId}</p>
//                     <p class="text-muted">Printed on: ${new Date().toLocaleDateString()}</p>
//                 </div>
//                 <div class="responses-container">
//                     ${responses}
//                 </div>
//                 <div class="text-center mt-4 no-print">
//                     <button onclick="window.print()" class="btn btn-primary">
//                         <i class="bi bi-printer me-2"></i>Print
//                     </button>
//                     <button onclick="window.close()" class="btn btn-secondary ms-2">
//                         Close
//                     </button>
//                 </div>
//                 <script>
//                     window.onload = function() {
//                         setTimeout(function() {
//                             window.print();
//                         }, 500);
//                     };
//                 <\/script>
//             </body>
//         </html>
//     `);
//     printWindow.document.close();
// });

// Modal hidden event - cleanup
$('#viewresponseModal').on('hidden.bs.modal', function() {
    // Clear data to prevent memory leaks
    $(this).find('#response_list').empty();
    $(this).removeData('current-notice-id');
});


// Optional: Add keyboard shortcuts
$(document).on('keydown', function(e) {
    const modal = $('#viewresponseModal');
    if (modal.hasClass('show')) {
        // ESC key closes modal
        if (e.keyCode === 27) {
            modal.modal('hide');
        }
        // Ctrl+P for print
        if (e.ctrlKey && e.keyCode === 80) {
            e.preventDefault();
            $('#printResponses').click();
        }
    }
});

    const $cabinetModal = $('#cabinetModal');
    // ==================== CABINET MODAL FUNCTIONALITY ====================
    $cabinetModal.on('show.bs.modal', handleCabinetModalShow);


        function clearTableRows($table) {
        $table.find("tbody tr").remove();
    }

       function handleAjaxError(xhr, status, error) {
        console.error('AJAX Error:', error);
        showNotification(
            `Error loading data. Please try again.`,
            'error'
        );
    }

          function escapeHtml(unsafe) {
        if (typeof unsafe !== 'string') return unsafe;
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    function updateRefreshTime() {
		const now = new Date();
		const timeString = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
		$('#lastRefreshTime').text(timeString);
	}

    function handleCabinetModalShow(event) {
        const jobNumber = $(event.relatedTarget).data('target-id');
        
        if (!jobNumber) {
            console.error('No job number provided for cabinet modal');
            return;
        }

        resetCabinetModal();
        loadCabinetDetails(jobNumber);
    }

    function resetCabinetModal() {
        const fields = [
            '#enq_applicant_name',
            '#enq_applicant_type',
            '#enq_cabinet_name',
            '#enq_job_purpose',
            '#enq_job_status',
            '#enq_current_application_status'
        ];
        
        fields.forEach(selector => $(selector).val(''));
        clearTableRows($('#cabinet-tracking'));
    }

    function loadCabinetDetails(jobNumber) {
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'load_application_cabinet_details_by_job_number',
                job_number: jobNumber
            },
            cache: false,
            success: function(response) {
                populateCabinetData(response);
				updateRefreshTime();
            },
            error: handleAjaxError
        });
    }

    function populateCabinetData(response) {
        try {
            const data = JSON.parse(response);
            // console.log(data);
            // Populate cabinet tracking table
            if (data.cabinet_tracking && Array.isArray(data.cabinet_tracking)) {
                const table = $('#cabinet-tracking');
				table.empty();
                data.cabinet_tracking.forEach(tracking => {
                    table.append(createCabinetTrackingRow(tracking));
                });

				// Update last update date
				if (data.cabinet_tracking && data.cabinet_tracking.length > 0) {
					const lastUpdate = data.cabinet_tracking[data.cabinet_tracking.length - 1].created_date;
					$('#lastUpdateDate').text(lastUpdate);
				}

				const trackingCount = Array.isArray(data.cabinet_tracking) ? data.cabinet_tracking.length : 0;
				$('#trackingEntriesCount').text(trackingCount);
				$('#historyCount').text(trackingCount + ' entries');
            }

            // Populate cabinet data fields
            if (data.cabinet_data) {
                const cabinet = data.cabinet_data;
                $('#enq_applicant_name').val(cabinet.ar_name || '');
                $('#enq_applicant_type').val(cabinet.business_process_sub_name || '');
                $('#enq_cabinet_name').val(cabinet.file_number || '');
                $('#enq_job_purpose').val(cabinet.job_purpose || '');
                $('#enq_job_status').val(cabinet.job_status || '');
                $('#enq_current_application_status').val(cabinet.current_application_status || '');
            }
        } catch (error) {
            console.error('Error parsing cabinet data:', error);
        }
    }

    function createCabinetTrackingRow(tracking) {
        return `
            <tr>
                <td class="small">${escapeHtml(tracking.officers_general_comments || '')}</td>
                <td class="small">${escapeHtml(tracking.division || '')}</td>
                <td class="small">${escapeHtml(tracking.created_by || '')}</td>
                <td class="small">${formatDate(tracking.created_date)}</td>
            </tr>
        `;
    }



});



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
    




  }

  


})


