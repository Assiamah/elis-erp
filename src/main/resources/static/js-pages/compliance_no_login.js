$(function () {

  let updatedData = {};
  
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


    console.log(jobNumbers);

    // set hidden job_numbers input to job number array
    sendMessageModal.find("#job_numbers").val(JSON.stringify(jobNumbers));

    // set hidden staff input to staff id
    sendMessageModal.find("#officer_id").val(staff.staff_id);
    sendMessageModal.find("#officer_name").val(staff.staff);

    sendMessageModal
      .find("#sendMessageModalLabel")
      .html(`Send Message To <span class="text-primary">${staff.staff}</span>`);

    sendMessageModal.modal("show"); 
  });

  $("#message-form").on("submit", function (event) {
    event.preventDefault();

    let form = $(this);
    let data = form.serializeArray();
    
    
    
    
    
    data = {
      "request_type": $("#sendMessageModal").find("#request_type").val(),
      "officer_id": $("#sendMessageModal").find("#officer_id").val(),
      "officer_name": $("#sendMessageModal").find("#officer_name").val(),
      "job_numbers" : $("#sendMessageModal").find("#job_numbers").val(),
    "message_type":$("#sendMessageModal").find("#message_type").val(),
    "message": $("#sendMessageModal").find("#message").val()
    }
    
    
    submitAjax(
      $(this).attr("action"),
      "send_compliance_message",
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

    console.log(tableData);



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

    console.log(title);
    
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
    
    // console.log(title);

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

  $(document).on("click", ".showOfficerModal", function (event) {
    event.preventDefault();

    let item = $(this);
    let modal = $("#officerModal");
    let type = item.data("type") ?? "";

    let title = item.data("title");

    //  console.log(title);

    let date = item.data("date") ?? "";

    let url = item.data("url");

    let method = item.data("method");
    let period = item.data("period");
    let by = item.data("by");

    let division = item.data("division");
    let unit = item.data("unit-id");
    let count = item.data("count");

    let action =
      method +
      (typeof period === "undefined" ? "" : `_${period}`) +
      (typeof by === "undefined" ? "" : `_${by}`) +
      "_officers";

    submitAjax(url, action, { division, unit }, function (data) {
      let officersData = data.apps_at_unit.map(function (item) {
        return {
          name: item.staff,
          total: item.total,
          action: `<a href="#" 
            class="modalButton showApplicationsModal text-decoration-none"
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

      console.log(officersData);
      // let unassigned =
      //     count -
      //     data.apps_at_unit.reduce(function (sum, current) {
      //       return (sum += current.total);
      //     }, 0);

      //   officersData = [
      //     {
      //       name: "UNASSIGNED",
      //       total: unassigned,
      //       action: `<a href="#" 
      //        class="modalButton showApplicationsModal text-decoration-none"
      //        data-method="${method}" 
      //      ${typeof period === "undefined" ? "" : `data-period="${period}"`}
      //      data-url="${url}"
      //      ${typeof by === "undefined" ? "" : `data-by="${by}"`}
      //      data-type="Unassigned"
      //      data-title="${title}" 
      //      data-date="${date}"
      //      data-key="staff"
      //      data-value="${unit}"
      //    >View</a>`,
      //     },
      //     ...officersData,
      //   ];
        
      modal
        .find(".modal-body table")
        .DataTable({ destroy: true, responsive: true, data: officersData });
    });

    modal
      .find("#officerModalLabel")
      .html(
        `${type}'s Officers ${title} <span class="text-primary">${date}</span>`
      );

    modal.find(".modal-body table").DataTable();

    modal.modal("show");
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
console.log("selection made " + $(this).val() );
    
  
  submitAjax("ComplianceReport", "report_dashboard_all", {}, function (data) {


    let totalRec = data.total_apps_rec[0].total;
    let totalRecComp = data.total_comp_divisional_year[0].total;

    let totalpercentage = isNaN(((totalRecComp / totalRec) * 100).toFixed(2)) ? 0 : ((totalRecComp / totalRec) * 100).toFixed(2);

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
  
  
  
  
  if($("#page_name").text() === "compliance_no_login"){
   // console.log("pagen complaince")
    setTimeout(
        function() 
        {

          submitAjax("ComplianceReport", "report_dashboard_all", {}, function (data) {
           let totalRec = data.total_apps_rec[0].total;
           let totalRecComp = data.total_comp_divisional_year[0].total;
          //  let totalpercentage = totalRec*totalRecComp/100
            
            let totalpercentage = ((totalRecComp / totalRec) * 100).toFixed(2)+'%';

            // let totalpercentage = isNaN(((totalRecComp / totalRec) * 100).toFixed(2)) ? 0 : ((totalRecComp / totalRec) * 100).toFixed(2);

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


             // applications received for the year
             showDivisionSummary("#appreceivedyear", data.apps_rec_divisional, 'info');

            
        
            // applications completed for the year
            showDivisionSummary("#app-completed-year", data.apps_comp_divisional, 'success');


             // applications completed for the year
             showDivisionSummary("#appcompletedyear", data.apps_comp_divisional, 'success');
        
            // applications received and completed for the year
            showDivisionSummaryUpdated(
              "#app-received-completed-year",
              data.apps_comp_divisional_year,
        'default'
            );




            // applications received and completed for the year
            showDivisionSummaryUpdated(
              "#appreceivedcompletedyear",
              data.apps_comp_divisional_year,
        'default'
            );



        
            // applications past due for the year
            showDivisionSummary(
              "#app-past-due-year",
              data.apps_past_due_dates_divisional,
        'danger'
            );


            showDivisionSummary(
              "#apppastdueyear",
              data.apps_past_due_dates_divisional,
        'danger'
            );


        
            // applications with divisions
            showDivisionSummary("#app-with-divisions", data.apps_at_division, 'warning');



            showDivisionSummary("#appwithdivisions", data.apps_at_division, 'warning');

            
                    

            document.getElementById('pec_id').innerHTML = totalpercentage;

            

           // total_comp_divisional_year
          });
        }, 5000);
    
  }




  function fetchAndUpdateDashboardData() {
    console.log("Fetching updated dashboard data...");

    submitAjax("ComplianceReport", "report_dashboard_all", {}, function (data) {
        let totalRec = data.total_apps_rec[0]?.total || 0;
        let totalRecComp = data.total_comp_divisional_year[0]?.total || 0;
        let totalpercentage = totalRec !== 0 
            ? ((totalRecComp / totalRec) * 100).toFixed(2) + '%' 
            : '0%';

        // Store data temporarily to apply to the next slide
         updatedData = {
            receivedToday: new Intl.NumberFormat().format(data.apps_rec_day[0]?.total || 0),
            receivedMonth: new Intl.NumberFormat().format(data.apps_rec_month[0]?.total || 0),
            completedToday: new Intl.NumberFormat().format(data.apps_comp_day[0]?.total || 0),
            completedMonth: new Intl.NumberFormat().format(data.apps_comp_month[0]?.total || 0),
            totalpercentage: totalpercentage,
            divisions: {
                received: data.apps_rec_divisional,
                completed: data.apps_comp_divisional,
                receivedCompleted: data.apps_comp_divisional_year,
                pastDue: data.apps_past_due_dates_divisional,
                withDivisions: data.apps_at_division
            }
        };

        console.log("Data fetched, waiting for carousel to slide...");
        
        // Move to the next slide after fetching data
        // $("#cardsCarousel").carousel("next");
        setTimeout(function () {
          $("#cardsCarousel").carousel("next");
      }, 2000); // Wait 5 seconds before sliding

      setTimeout(function () {
        $("#yearlyCardsCarousel").carousel("next");
      }, 3000); // Wait 5 seconds before sliding

      setTimeout(function () {
        $("#pastDueCarousel").carousel("next");
      }, 4000); // Wait 5 seconds before sliding


      


    });
}

// When carousel finishes sliding, update content
$('#cardsCarousel').on('slid.bs.carousel', function () {
    console.log("Carousel slid, applying new data...");

    // Find the active slide
    let activeSlide = $('#cardsCarousel .carousel-item.active');

    // Apply new data to the active slide
    activeSlide.find("#app-received-today").html(updatedData.receivedToday);
    activeSlide.find("#app-received-month").html(updatedData.receivedMonth);
    activeSlide.find("#app-completed-today").html(updatedData.completedToday);
    activeSlide.find("#app-completed-month").html(updatedData.completedMonth);
    activeSlide.find("#pec_id").html(updatedData.totalpercentage);

    // Update division summaries
    showDivisionSummary(activeSlide.find("#app-received-year"), updatedData.divisions.received, 'info');
    showDivisionSummary(activeSlide.find("#appreceivedyear"), updatedData.divisions.received, 'info');
    showDivisionSummary(activeSlide.find("#app-completed-year"), updatedData.divisions.completed, 'success');
    showDivisionSummary(activeSlide.find("#appcompletedyear"), updatedData.divisions.completed, 'success');
    showDivisionSummaryUpdated(activeSlide.find("#app-received-completed-year"), updatedData.divisions.receivedCompleted, 'default');
    showDivisionSummaryUpdated(activeSlide.find("#appreceivedcompletedyear"), updatedData.divisions.receivedCompleted, 'default');
    showDivisionSummary(activeSlide.find("#app-past-due-year"), updatedData.divisions.pastDue, 'danger');
    showDivisionSummary(activeSlide.find("#apppastdueyear"), updatedData.divisions.pastDue, 'danger');
    showDivisionSummary(activeSlide.find("#app-with-divisions"), updatedData.divisions.withDivisions, 'warning');
    showDivisionSummary(activeSlide.find("#appwithdivisions"), updatedData.divisions.withDivisions, 'warning');


    // Show last updated time
    let updateTime = new Date().toLocaleTimeString();
    $("#last-updated").html("Last updated: " + updateTime);
    
    console.log("Updated slide with new data at:", updateTime);
});

// Fetch new data and trigger the first slide after 1 minute
// Fetch data every 60 seconds
if ($("#page_name").text() === "compliance_no_login") {
    // fetchAndUpdateDashboardData(); // Run immediately
    setInterval(fetchAndUpdateDashboardData, 1800000); // Repeat every 30 mins
}

// Fetch and slide every 30 seconds
// setInterval(fetchAndUpdateDashboardData, 30000);

// Instead of listening to carousel slide event, fetch data first and then slide
// setInterval(fetchAndUpdateDashboardData, 30000); // Fetch data and slide every 30 seconds

  




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
      </div>`;

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



  
  var firmList; // global variable



  function submitAjax(
    url,
    requestType,
    data = {},
    success = function () {},
    error = function () {}
  ) {
   
   var region_id =$('#sel_change_region_compliance').val();
   console.log(region_id)

   if(region_id != undefined || !region_id){
    region_id =  11;
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
      var reccc = JSON.parse(response);
      firmList = reccc;
      console.log(reccc);
      //  let totalPerRec = reccc.apps_rec_divisional[0].total;
      // let lrdData = reccc.apps_at_division.find(item => item.division === "LRD");
      // let  lrdTotal = lrdData.total;
        //console.log(lrdTotal);
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

