$(function () {
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

    let sendMessageModal = $("#sendMessageModal");

    let staff = $(this).data("staff");
    console.log(staff)

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
    let iconClass = item.data("icon");
    let modal = $("#divisionModal");

    let title = item.data("title");
    let date = item.data("date") ?? "";

    let url = item.data("url");

    let method = item.data("method");
    let period = item.data("period");

    let by = item.data("by");

    let action =
      method +
      (period ? `_${period}` : "") +
      (typeof by === "undefined" ? "" : `_${by}`);

    submitAjax(url, action, {}, function (data) {
      divisionsNotFound = divisions.filter(function (division) {
        return !data.apps_at_division.some(function (item) {
          return item.division == division.division;
        });
      });

      let newColors = [...colors];

      divisionHtml = [...data.apps_at_division, ...divisionsNotFound].reduce(
        function (sum, current) {
          let selectedColorIndex = Math.floor(Math.random() * newColors.length);
          let color = newColors[selectedColorIndex];
          newColors.splice(selectedColorIndex, 1);

          let html = `<div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-${color} shadow ">
                  <div class="card-body">
                    <div class="row no-gutters align-items-center">
                      <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> ${current.division}</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800">${current.total}</div>
                      </div>
                      <div class="col-auto">
                        <i class="fas fa-2x text-gray-300 ${iconClass}"></i>
                      </div>
                      <a href="#" data-method="${method}" data-period="${period}" data-by="service_type" data-url="${url}" data-type="${current.division}" data-title="${title}" data-date="${date}" class="showServiceTypeModal text-decoration-none stretched-link">
            </a>
                    </div>
                  </div>
                </div>
              </div>`;

          return (sum += html);
        },
        ""
      );

      modal.find(".modal-body > .row").html(divisionHtml);
    });

    modal
      .find("#divisionModalLabel")
      .html(`${title} <span class="text-primary">${date}</span>`);

    modal.modal("show");
  });

  $(document).on("click", ".showServiceTypeModal", function (event) {
    event.preventDefault();

    let item = $(this);
    let modal = $("#serviceTypeModal");
    let type = item.data("type") ?? "";

    let title = item.data("title");
    let date = item.data("date") ?? "";

    let url = item.data("url");

    let method = item.data("method");
    let period = item.data("period");
    let by = item.data("by");

    let action =
      method +
      (period ? `_${period}` : "") +
      (typeof by === "undefined" ? "" : `_${by}`);

    submitAjax(url, action, { division: type }, function (data) {
      let serviceTypeData = data.apps_at_division.map(function (item) {
        return {
          name: item.service_type,
          total: item.total,
          action: `<a href="#" 
            class="modalButton showApplicationsModal text-decoration-none"
            data-method="${method}" 
          ${typeof period === "undefined" ? "" : `data-period="${period}"`}
          data-url="${url}"
          ${typeof by === "undefined" ? "" : `data-by="${by}"`}
          data-key="service"
          data-value="${item.service_type}"
          data-type="${item.service_type}"
          data-title="${title}" 
          data-date="${date}" 
        >View</a>`,
        };
      });

      modal
        .find(".modal-body table")
        .DataTable({ destroy: true, responsive: true, data: serviceTypeData });
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
    let title = (item.data("title") === "Applications With Divisions") ? "Applications" : item.data("title");
    let date = item.data("date") ?? "";

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
            class="modalButton showOfficerModal text-decoration-none"
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
        >View</a>`,
        };
      });

      modal
        .find(".modal-body table")
        .DataTable({ destroy: true, responsive: true, data: unitsData });
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
                    class="btn btn-sm btn-info showApplicationsModal"
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
                >View</a>`,
            };
        });

        // Destroy existing DataTable if it exists
        if ($.fn.DataTable.isDataTable(modal.find(".modal-body table"))) {
            modal.find(".modal-body table").DataTable().destroy();
        }

        // Initialize new DataTable
        let table = modal.find(".modal-body table").DataTable({
            responsive: true,
            data: officersData,
            columns: [
                { data: "name" },
                { data: "total" },
                { data: "action" }
            ],
            order: [[1, "desc"]],
            buttons: [
                { 
                    extend: "excel", 
                    exportOptions: { columns: [0, 1] } 
                },
                { 
                    extend: "print", 
                    exportOptions: { columns: [0, 1] } 
                },
                // "colvis"
            ],
            dom: '<"row"<"col-sm-4"l><"col-sm-4"B><"col-sm-4"f>>rtip',
            pageLength: 25,
            lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
            pageLength: 10,
            language: {
                //emptyTable: "No compliance applications found",
                info: "Showing _START_ to _END_ of _TOTAL_ entries",
                infoEmpty: "Showing 0 to 0 of 0 entries",
                infoFiltered: "(filtered from _MAX_ total entries)",
                lengthMenu: "Show _MENU_ entries",
                loadingRecords: "Loading...",
                processing: "Processing...",
                search: "",
                searchPlaceholder: "Search Officers...",
                zeroRecords: "No matching records found"
            }
        });
    });

    modal.find("#officerModalLabel")
        .html(`${type}'s Officers ${title} <span class="text-primary">${date}</span>`);

    modal.modal("show");
});

  // Function to initialize DataTable with common settings
function initializeApplicationsDataTable(tableId, columns, data) {
    // Destroy existing DataTable if it exists
    if ($.fn.DataTable.isDataTable(tableId)) {
        $(tableId).DataTable().destroy();
    }

    // Initialize new DataTable
    return $(tableId).DataTable({
        responsive: true,
        data: data,
        columns: columns,
        order: [[1, "desc"]],
        buttons: [
            {
                extend: "excel",
                text: '<i class="bi bi-file-earmark-excel"></i> Excel',
                className: 'btn btn-outline-success btn-sm',
                exportOptions: { columns: ':visible' }
            },
            {
                extend: "print",
                text: '<i class="bi bi-printer"></i> Print',
                className: 'btn btn-outline-secondary btn-sm',
                exportOptions: { columns: ':visible' }
            },
            // {
            //     extend: "colvis",
            //     text: '<i class="bi bi-columns-gap"></i> Columns',
            //     className: 'btn btn-outline-info btn-sm'
            // }
        ],
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
    let title = item.data("title");
    let date = item.data("date") ?? "";
    let url = item.data("url");
    let method = item.data("method");
    let period = item.data("period");
    let by = item.data("by");
    let key = item.data("key");
    let value = item.data("value");
    
    // Determine which modal to use based on method or data attribute
    let modalType = item.data("modal-type") || "applications";
    
    if (modalType === "completed") {
        modal = $("#completedapplicationsModal");
    } else if (modalType === "new") {
        modal = $("#newApplicationModal");
    }
    
    // Set modal title
    modal.find(".modal-title").html(
        `${type} Applications ${title} <span class="text-primary">${date}</span>`
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
    
    // Make AJAX request
    submitAjax(url, action, requestData, function (data) {

      data = data.apps_with_staff || data.apps_at_division || [];

        let applicationsData = data.map(function (app) {
            let actionButton = `<a href="job-details?job_number=${app.job_number}" class="btn btn-sm btn-outline-primary" target="_blank">
              <i class="ri-eye-line"></i>
            </a>`;

            console.log(staff)
            
            // Add send message button if staff data is available
            if (staff && staff.staff_id) {
                actionButton += ` <button class="btn btn-sm btn-outline-warning sendMessage_unit_case" data-receiver_name="${staff.staff}" data-officer_name="${staff.staff}" data-officer_id="${staff.staff_id}" data-job_number="${app.job_number}">
                  <i class="ri-send-plane-line"></i>
                </button>`;
            }
            
            return {
                job_number: app.job_number,
                ar_name: app.ar_name,
                business_process_sub_name: app.business_process_sub_name,
                created_date: app.created_date ? new Date(app.created_date).toLocaleDateString() : '',
                due_date: app.due_date ? new Date(app.due_date).toLocaleDateString() : '',
                completed_date: app.completed_date ? new Date(app.completed_date).toLocaleDateString() : '',
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
                        return `<div class="button-group">${data}</div>`;
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
                        return  `<div class="button-group">${data}</div>`;
                    }
                }
            ];
        } else {
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
                    data: "action", 
                    className: "text-end",
                    render: function(data, type, row) {
                        return `<div class="button-group">${data}</div>`;
                    }
                }
            ];
        }
        
        // Initialize DataTable
        let tableId = modalType === "completed" ? "#completedApplicationsTable" : 
                     modalType === "new" ? "#newApplicationsTable" : "#applicationsTable";
        
        initializeApplicationsDataTable(tableId, columns, applicationsData);
        
        // Add send message button to modal header if staff data exists
        if (staff && staff.staff_id) {
            let sendMessageBtn = $(`
                <button class="btn btn-primary ms-auto sendMessageToAll" 
                        data-officer_id="${staff.staff_id}"
                        data-receiver_name="${staff.staff || 'Officer'}"
                        data-officer_name="${staff.staff || 'Officer'}"
                  >
                    <i class="bi bi-chat-text"></i> Send Message to All
                </button>
            `);
            
            // Remove existing send message button if any
            modal.find(".sendMessageToAll").remove();
            
            // Add new button to modal header
            modal.find(".modal-header").append(sendMessageBtn);
        }
    });
});

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

  function generateChart(modalBody, title, type, tableData) {
    let data = null;
    let labels = null;

    console.log(tableData);

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
        // alert("Please select one option.");
        swal.fire({
          title: 'Ops!',
          text: 'Please select one option.',
          icon: 'warning',
          confirmButtonText: 'OK'
        })

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
        className: "h6"
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





  $('#sel_change_region_compliance').change(function () {
    //console.log("selection made " + $(this).val() );


    submitAjax("ComplianceReport", "report_dashboard_all", {}, function (data) {


      let totalRec = data.total_apps_rec[0].total;
      let totalRecComp = data.total_comp_divisional_year[0].total;

      let totalpercentage = ((totalRecComp / totalRec) * 100).toFixed(2) + '%';
      //console.log(totalpercentage);


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
      showDivisionSummaryUpdated(
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




  if ($("#page_name").text() === "compliance") {
    // console.log("pagen complaince")
    setTimeout(
      function () {

        submitAjax("ComplianceReport", "report_dashboard_all", {}, function (data) {
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
          showDivisionSummary("#app-received-year", data.apps_rec_divisional, 'info');

          // applications completed for the year
          showDivisionSummary("#app-completed-year", data.apps_comp_divisional, 'success');

          // applications received and completed for the year
          showDivisionSummaryUpdated(
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
      }, 5000);

  }




  if ($("#page_name").text() === "compliance") {
    setTimeout(
      function () {
        submitAjax("ComplianceReport", "report_dashboard_all", {}, function (data) {
          let totalRec = data.total_apps_rec[0].total;
          let totalRecComp = data.total_comp_divisional_year[0].total;
          let totalpercentage = ((totalRecComp / totalRec) * 100).toFixed(2) + '%';
          $("#app-received-today").html(new Intl.NumberFormat().format(data.apps_rec_day[0].total));
          $("#app-received-month").html(new Intl.NumberFormat().format(data.apps_rec_month[0].total));
          $("#app-completed-today").html(new Intl.NumberFormat().format(data.apps_comp_day[0].total));
          $("#app-completed-month").html(new Intl.NumberFormat().format(data.apps_comp_month[0].total));

          // applications received for the year
          showDivisionSummary("#app-received-year", data.apps_rec_divisional, 'info');

          // applications completed for the year
          showDivisionSummary("#app-completed-year", data.apps_comp_divisional, 'success');

          // applications received and completed for the year
          showDivisionSummaryUpdated("#app-received-completed-year", data.apps_comp_divisional_year, 'default');

          // applications past due for the year
          showDivisionSummary("#app-past-due-year", data.apps_past_due_dates_divisional, 'danger');

          // applications with divisions
          showDivisionSummary("#app-with-divisions", data.apps_at_division, 'warning');

          document.getElementById('pec_id').innerHTML = totalpercentage;
        });
      }, 5000); // 60000 milliseconds = 1 minute
  }



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
        <div class="progress mb-4">
          <div class="progress-bar bg-${color}" role="progressbar" style="width: ${percent}%" aria-valuenow="${percent}"
            aria-valuemin="0" aria-valuemax="100"></div>
        </div>
      </div>`;

      return (sum += html);
    }, "");

    contentBody.html(dataHtml);
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




  var firmList = 0; // global variable



  function submitAjax(
    url,
    requestType,
    data = {},
    success = function () { },
    error = function () { }
  ) {

    var region_id = $('#sel_change_region_compliance').val();
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
                    let html = '';
                    let responseCount = response.data.length;
                    
                    // Create timeline items
                    response.data.forEach((item, index) => {

                        console.log(item);

                        const isFirst = index === 0;
                        const isLast = index === response.data.length - 1;
                        
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
                                          <span class="badge bg-light text-muted border">${convertDate(item.created_date.slice(0,10))}</span>
                                      </div>
                                      <div class="descrption">${item.reply_details || 'No details provided'}</div>
                                  </div>
                              </div>
                          </li>
                        `;
                    });
                    
                    // Update response count
                    modal.find('#responseCount').text(`${responseCount} ${responseCount === 1 ? 'response' : 'responses'}`);
                    
                    // Add to container
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

  $('#changequerystatusModal').on('show.bs.modal', function (event) {
    $("#changequerystatusModal #job_number").val($(event.relatedTarget).data('job_number'));
    document.getElementById('changequerystatusModalLabel').innerHTML = 'Confirmation: <span class="text-primary">' + $(event.relatedTarget).data('job_number') + '</span>'
  });

  $("#update-query-form").on("submit", function (event) {
    event.preventDefault();

    let form = $(this);
    let data = form.serializeArray();


    data = {
      "request_type": $("#changequerystatusModal").find("#request_type").val(),
      "job_number": $("#changequerystatusModal").find("#job_number").val(),
    }


    $.ajax({
      type: "POST",
      url: "/SendComplianceMessage",
      data: data,
      cache: false,
      beforeSend: function () {
        // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
      },
      success: function (result) {
        // var response = JSON.parse(result);
        console.log(result);

        if (result == 'Success') {

          //form.trigger("reset");
          form.parents(".modal").modal("hide");
          alert("Query updated successfully.");

        } else {
          alert("We were not able to send your message. Please contact IT support if issue persists.");
        }
      }

    })
  });

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
});


