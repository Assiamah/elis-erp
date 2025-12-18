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

// Parse the JSON string back into an object
  // var staffObject = JSON.parse(staff);

// Access the 'fullname' property
    var fullName = staff.fullname;

     console.log(fullName);  // Outputs: "EMMANUEL EGYAM"


      // console.log(staff);
  
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
        .html(`Send Message To <span class="text-primary">${fullName}</span>`);
  
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
        (typeof by === "undefined" ? "" : `_${by}`) + `-${corp_id}`;

        console.log(action);
  
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
  
      $("#officerModal").modal("hide");
      
      let item = $(this);
      let modal = $("#serviceTypeModal");
      let type = item.data("type") ?? "";

      let servname = item.data("servname") ?? "";

      
  
      let title = item.data("title");
  
      console.log(type);
      
      let date = item.data("date") ?? "";
  
      let url = item.data("url");
  
      let method = item.data("method");
      let period = item.data("period");
      let by = item.data("by");

      // var corp_id = item.data("value");

      var corp_id = $('#bank_id').val();

      
      
      
  
      let action =
        method +
        (period ? `_${period}` : "") +
        (typeof by === "undefined" ? "" : `_${by}`)+ `-${type}`+"+"+corp_id;


       console.log(action)


  
      submitAjax(url, action, { division: type,servname }, function (data) {
        let serviceTypeData = data.apps_at_division.map(function (item) {
          return {
            name: item.sub_service_name,
            total: item.total,
            action: `<a href="#" 
              class="modalButton showApplicationsModal text-decoration-none"
              data-method="${method}" 
            ${typeof period === "undefined" ? "" : `data-period="${period}"`}
            data-url="${url}"
            ${typeof by === "undefined" ? "" : `data-by="${by}"`}
            data-key="service"
            data-value="${item.sub_service_name}"
            data-type="${item.sub_service_name}"
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
        .html(`${servname} ${title} <span class="text-primary">${date}</span>`);
  
      modal.modal("show");
    });







    $(document).on("click", ".showServiceTypeModal2", function (event) {
      event.preventDefault();
  
      $("#officerModal").modal("hide");
      
      let item = $(this);
      let modal = $("#serviceTypeModal");
      let type = item.data("type") ?? "";

      let servname = item.data("servname") ?? "";

  
      let title = type + " "+  item.data("title");
  
      console.log(type);
      
      let date = item.data("date") ?? "";
  
      let url = item.data("url");
  
      let method = item.data("method");
      let period = item.data("period");
      let by = item.data("by");

      var corp_id = item.data("value");
      

      $("#service_user_id").val(corp_id);
            
  
      let action =
        method +
        (period ? `_${period}` : "") +
        (typeof by === "undefined" ? "" : `_${by}`)+ "_services" + `-${corp_id}`;


       console.log(action)


  
      submitAjax(url, action, { division: type,servname }, function (data) {
        let serviceTypeData = data.apps_at_division.map(function (item) {
          return {
            name: item.sub_service_name,
            total: item.total,
            action: `<a href="#" 
              class="modalButton showApplicationsModal2 text-decoration-none"
              data-method="${method}" 
            ${typeof period === "undefined" ? "" : `data-period="${period}"`}
            data-url="${url}"
            ${typeof by === "undefined" ? "" : `data-by="${by}"`}
            data-key="service"
            data-value="${item.sub_id}"
            data-type="${item.sub_service_name}"
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
        .html(`${servname} ${title} <span class="text-primary">${date}</span>`);
  
      modal.modal("show");
    });







    $(document).on("click", ".showCorporateStaffModal", function (event) {
      event.preventDefault();
  
      let item = $(this);
      let modal = $("#officerModal");
      let type = item.data("type") ?? "";

      let servname = "Past Due Application With"+" " +item.data("servname") +" " +"Within" + " " ?? "";
  
      let title = item.data("title");
  
      console.log(servname);
      
      let date = item.data("date") ?? "";
  
      let url = item.data("url");
  
      let method = item.data("method");
      let period = item.data("period");
      let by = item.data("by");

      var corp_id = $('#bank_id').val();
      
  
      let action =
        method +
        (period ? `_${period}` : "") +
        (typeof by === "undefined" ? "" : `_${by}`) + `-${type}`;


       console.log(action)


  
       submitAjax(url, action, { division: type }, function (data) {
        let unitsData = data.apps_at_division.map(function (item) {
          return {
            name: item.fullname,
            total: item.count,
            action: `<a href="#" 
              class="modalButton showApplicationsModal text-decoration-none"
              data-staff='${JSON.stringify(item)}'
              data-method="${method}" 
            ${typeof period === "undefined" ? "" : `data-period="${period}"`}
            data-url="${url}"
            ${typeof by === "undefined" ? "" : `data-by="${by}"`}
            data-type="${item.fullname}'s"
            data-title="${title}" 
            data-date="${date}"
            data-key="staff"
            data-value="${item.userid}"
          >View</a>`,
          };
        });
  
        modal
          .find(".modal-body table")
          .DataTable({ destroy: true, responsive: true, data: unitsData });
      });
  
      modal.find(".modal-body table").DataTable();
  
      modal
        .find("#officerModalLabel")
        .html(`${servname}  <span class="text-primary">${date}</span>`);
  
      modal.modal("show");
    });






    $(document).on("click", ".showCorporateStaffModal2", function (event) {
      event.preventDefault();
  
      let item = $(this);
      let modal = $("#officerModal");
      let type = item.data("type") ?? "";

      let servname = "Applications With"+" " +item.data("servname")+ " " + "Within" + " " ?? "";
  
      let title = item.data("title");
  
      console.log(servname);
      
      let date = item.data("date") ?? "";
  
      let url = item.data("url");
  
      let method = item.data("method");
      let period = item.data("period");
      let by = item.data("by");

      var corp_id = $('#bank_id').val();
      
  
      let action =
        method +
        (period ? `_${period}` : "") +
        (typeof by === "undefined" ? "" : `_${by}`) + `-${type}`;


       console.log(action)


  
       submitAjax(url, action, { division: type }, function (data) {
        let unitsData = data.apps_at_division.map(function (item) {
          return {
            name: item.fullname,
            total: item.count,
            action: `<a href="#" 
              class="modalButton showServiceTypeModal2 text-decoration-none"
              data-staff='${JSON.stringify(item)}'
              data-method="${method}" 
            ${typeof period === "undefined" ? "" : `data-period="${period}"`}
            data-url="${url}"
            ${typeof by === "undefined" ? "" : `data-by="${by}"`}
            data-type="${item.fullname}'s"
            data-title="${title}" 
            data-date="${date}"
            data-key="staff"
            data-value="${item.userid}"
          >View</a>`,
          };
        });
  
        modal
          .find(".modal-body table")
          .DataTable({ destroy: true, responsive: true, data: unitsData });
      });
  
      modal.find(".modal-body table").DataTable();
  
      modal
        .find("#officerModalLabel")
        .html(`${servname}  <span class="text-primary">${date}</span>`);
  
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

      var corp_id = $('#bank_id').val();
      
      let action =
        method +
        (typeof period === "undefined" ? "" : `_${period}`) +
        (typeof by === "undefined" ? "" : `_${by}`) +
        "_units" + `-${corp_id}`;
  
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

      var corp_id = $('#bank_id').val();
      
      // let action =
      //   method +
      //   (typeof period === "undefined" ? "" : `_${period}`) +
      //   (typeof by === "undefined" ? "" : `_${by}`) +
      //   "_units" + `-${corp_id}`;
  
      let action =
        method +
        (typeof period === "undefined" ? "" : `_${period}`) +
        (typeof by === "undefined" ? "" : `_${by}`) +
        "_officers" + `-${corp_id}`;
  
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

      var corp_id = item.data("value");  

      var bank_id = $('#bank_id').val();

      
      
      
  
      // let action =
      //   method +
      //   (period ? `_${period}` : "") +
      //   (typeof by === "undefined" ? "" : `_${by}`)+ `-${type}`+"+"+corp_id;



     
      let action =
        method +
        (period ? `_${period}` : "") +
        (typeof by === "undefined" ? "" : `_${by}`) + 
        "_applications" + `-${corp_id}`+"+"+bank_id;;

      
      // let action =
      //   method +
      //   (period ? `_${period}` : "") +
      //   (typeof by === "undefined" ? "" : `_${by}`) + `-${corp_id}`;
        
        console.log(action);


      submitAjax(url, action, data, function (data) {
        
        
        data = data.apps_with_staff || data.apps_at_division || [];

        console.log(data);
        
        let applicationsData = data.map(function (item) {
          let sendMessageAction =
            typeof staff === "undefined"
              ? ""
              : `<a data-job-number="${
                  item.job_number
                }" data-staff='${JSON.stringify(
                  staff
                )}' class="dropdown-item sendMessage" href="#">Send Message <i class="fas fa-comment-alt"></i></a>`;
          
          let page_name_title = $("#page_name").text();
  
          return {
            ...item,
            action: `<div class="btn-group" role="group">
              <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Actions
              </button>
              <div class="dropdown-menu">
             <button type="button" class="dropdown-item" href="#" id="btn_cabinet" data-staff_name="" data-staff_id="" data-job_number="" title="View Application Progress" data-target-id="${item.job_number}" data-target="#cabinetModal" data-toggle="modal">Track <i class="fas fa-hdd"></i></button>

              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" id="case_number" value="${item.transaction_number}">
                <input type="hidden" name="search_text" id="search_text" value="${item.case_number}">
                <input type="hidden" name="job_number" id="job_number" value="${item.job_number}">
                <input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="${item.business_process_sub_name}">
                <button type="submit" name="save" class="dropdown-item" >Application Details <i class="fas fa-info-circle"></i></button>
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
        typeof fullname === "undefined"
          ? ""
          : `<button data-staff='${JSON.stringify(
            fullname
            )}' class="sendMessage btn btn-primary ml-auto" type="button">Send Message <i class="fas fa-comment-alt"></i></button>`;
  
      $(sendMessageAction).insertAfter(modal.find("#applicationsModalLabel"));
  
      modal.find(".modal-body table").DataTable();
  
      modal.modal("show");
    });





    $(document).on("click", ".showApplicationsModal2", function (event) {
      event.preventDefault();
  
      let item = $(this);
      // let modal = $("#applicationsModal");
      let type = item.data("type") ?? "";
  
      let title = item.data("title");
      console.log(title);


      var staff_id = $('#service_user_id').val();

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

      var corp_id = item.data("value");  
     
      let action =
        method +
        (period ? `_${period}` : "") +
        (typeof by === "undefined" ? "" : `_${by}`) + 
        "_applications" + `-${corp_id}` + `+${staff_id}`;

      
      // let action =
      //   method +
      //   (period ? `_${period}` : "") +
      //   (typeof by === "undefined" ? "" : `_${by}`) + `-${corp_id}`;
        
        console.log(action);


      submitAjax(url, action, data, function (data) {
        
        
        data = data.apps_with_staff || data.apps_at_division || [];

        console.log(data);
        
        let applicationsData = data.map(function (item) {
          let sendMessageAction =
            typeof staff === "undefined"
              ? ""
              : `<a data-job-number="${
                  item.job_number
                }" data-staff='${JSON.stringify(
                  staff
                )}' class="dropdown-item sendMessage" href="#">Send Message <i class="fas fa-comment-alt"></i></a>`;
          
          let page_name_title = $("#page_name").text();
  
          return {
            ...item,
            action: `<div class="btn-group" role="group">
              <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Actions
              </button>
              <div class="dropdown-menu">
             <button type="button" class="dropdown-item" href="#" id="btn_cabinet" data-staff_name="" data-staff_id="" data-job_number="" title="View Application Progress" data-target-id="${item.job_number}" data-target="#cabinetModal" data-toggle="modal">Track <i class="fas fa-hdd"></i></button>

              <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
                <input type="hidden" name="case_number" id="case_number" value="${item.transaction_number}">
                <input type="hidden" name="search_text" id="search_text" value="${item.case_number}">
                <input type="hidden" name="job_number" id="job_number" value="${item.job_number}">
                <input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="${item.business_process_sub_name}">
                <button type="submit" name="save" class="dropdown-item" >Application Details <i class="fas fa-info-circle"></i></button>
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
        typeof fullname === "undefined"
          ? ""
          : `<button data-staff='${JSON.stringify(
            fullname
            )}' class="sendMessage btn btn-primary ml-auto" type="button">Send Message <i class="fas fa-comment-alt"></i></button>`;
  
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





  





    $('#lrd_applications').on('click', function(e) { 
      e.preventDefault();

   $("#serviceTypeModal1").modal("show");  

   var user_division=$(this).data('id');
   

   var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

  //  var created_for_id = $('#bank_id').val();


  //  console.log(created_for_id === "" ? null : $('#bank_id').val());


   console.log(created_for_id);


   var title  = user_division+"'s"+" "+"Applications By Services";
        
   document.getElementById('serviceTypeModalLabel1').innerHTML = title;

   


      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_division_apps',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {

              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);

  //             if (json_result.data == null){

  //               alert('Sorry Data Not Found');

  
  // }else {

      let dataSet1 = [];
      let num1 = 0;

    $('#services_table').DataTable().clear().destroy();



      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;

          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          

          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);

          dataSet1.push(html);

        //console.log(dataSet)
        }

      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })

        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        

   //}

             

             


          }
      })
  })






  $(document).on('click','#view_service_apps',function(e){
    e.preventDefault();
    var service_name=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

   

    $("#applicationsModal1").modal("show");  

   
    var title  = service_name+" "+"APPLICATIONS";
        
    document.getElementById('applicationsModalLabel1').innerHTML = title;

  
    console.log(service_name,created_for_id);
   
 
   
  
   let dataSet2 = [];
   let num2 = 0;
  
  $('#services_applications').DataTable().clear().destroy();
  
   $.ajax({
       type : "POST",
       url : "corporate_applications",
       data : {
           request_type : 'corporate_applications_division_apps_by_service',
           created_for_id : created_for_id,
           service_type : service_name
       },
       cache: false,
       success: function(response) {
  
        console.log(response)
  
           var json_result = JSON.parse(response);
           console.log(json_result.apps_at_division)
  
  
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



   
      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      
  
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
  
  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })
  
    $('#services_applications').DataTable().clear().destroy();
                  
    $('#services_applications').DataTable({ data: dataSet2,
      dom : 'Bfrtip',
      lengthMenu : [
          [ 10, 25, 50, -1 ],
          [ '10 rows', '25 rows',
              '50 rows', 'Show all' ] ],
      buttons : [ 'pageLength', 'copy',
          'csv', 'excel', 'pdf', 'print' ] }).draw();
  
//  }
          
  
           
  
  
       }
   })
  
  });

  




  $('#smd_applications').on('click', function(e) {
    e.preventDefault();

 $("#serviceTypeModal1").modal("show");  

 var user_division=$(this).data('id');
 var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();


 console.log(created_for_id);


 var title  = user_division+"'s"+" "+"Applications By Services";
      
 document.getElementById('serviceTypeModalLabel1').innerHTML = title;

 


    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_applications_division_apps',
            created_for_id: created_for_id,
            division : user_division,
        },
        cache: false,
        success: function(response) {

            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

    let dataSet1 = [];
    let num1 = 0;

  $('#services_table').DataTable().clear().destroy();



    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;

        let service_type = json_result.apps_at_division[i].service_type;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        

        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);

        dataSet1.push(html);

      //console.log(dataSet)
      }

    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })

      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      

 //}

           

           


        }
    })
})





    




$('#pvlmd_applications').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services";
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_division_apps',
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

         

         


      }
  })
})


    





$('#lvd_applications').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services";
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_division_apps',
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

         

         


      }
  })
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








  $('#recieved_apps_today').on('click', function(e) {
      e.preventDefault();

   $("#divisionModal1").modal("show");  

   var title_=$(this).data('id');

   var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();


   console.log(created_for_id);


   const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
   const currentDate = new Date();
   const day = currentDate.getDate();
   const monthIndex = currentDate.getMonth();
   const year = currentDate.getFullYear();
   const formattedDate = `${day} ${months[monthIndex]} ${year}`;



   var title  = "Applications Received"+ " " + title_+" "+formattedDate;
        
   document.getElementById('divisionModalLabel1').innerHTML = title;

   


      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_created_today',
              created_for_id: created_for_id,
          },
          cache: false,
          success: function(response) {

              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);

          // let Data_lrd = json_result.apps_at_division[0].total;
          // let Data_lrd = json_result.apps_at_division.find(item => item.division === "LRD");

          // console.log(Data_lrd);
          const consent = json_result.apps_at_division.find(function(service_name) {
            return service_name.service_name === 'APPLICATION FOR CONSENT';
          });
          const addConsent = consent ? consent.total : 0;

          const search = json_result.apps_at_division.find(function(service_name) {
            return service_name.service_name === 'APPLICATION FOR SEARCH';
          });
          const addsearch = search ? search.total : 0;

          


          const stamping = json_result.apps_at_division.find(function(service_name) {
            return service_name.service_name === 'APPLICATION FOR STAMPING';
          });
          const addstamping = stamping ? stamping.total : 0;


          const regnumber = json_result.apps_at_division.find(function(service_name) {
            return service_name.service_name === 'APPLICATION FOR REGISTRATION';
          });
          const addregnumber = regnumber ? regnumber.total : 0;



            console.log(addregnumber,addstamping,addsearch,addConsent);
          


            document.getElementById('lrd_count').innerHTML = addConsent;
            document.getElementById('lvd_count').innerHTML = addsearch;
            document.getElementById('pvlmd_count').innerHTML = addregnumber;
            document.getElementById('smd_count').innerHTML = addstamping;

            
       


          }
      })
  })






  $('#recieved_apps_month').on('click', function(e) {
    e.preventDefault();

 $("#divisionModal2").modal("show");  

 var title_=$(this).data('id');

 var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();



 const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
 const currentDate = new Date();
 const day = currentDate.getDate();
 const monthIndex = currentDate.getMonth();
 const year = currentDate.getFullYear();
 const formattedDate = `${months[monthIndex]}`;



 var title  = "Applications Received"+ " " + title_+" "+formattedDate;
      
 document.getElementById('divisionModalLabel2').innerHTML = title;

 


    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_applications_report_dashboard_created_month',
            created_for_id: created_for_id,
        },
        cache: false,
        success: function(response) {

            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);

        // let Data_lrd = json_result.apps_at_division[0].total;
        // let Data_lrd = json_result.apps_at_division.find(item => item.division === "LRD");

        // console.log(Data_lrd);
        const consent = json_result.apps_at_division.find(function(service_name) {
          return service_name.service_name === 'APPLICATION FOR CONSENT';
        });
        const addConsent = consent ? consent.total : 0;

        const search = json_result.apps_at_division.find(function(service_name) {
          return service_name.service_name === 'APPLICATION FOR SEARCH';
        });
        const addsearch = search ? search.total : 0;

        


        const stamping = json_result.apps_at_division.find(function(service_name) {
          return service_name.service_name === 'APPLICATION FOR STAMPING';
        });
        const addstamping = stamping ? stamping.total : 0;


        const regnumber = json_result.apps_at_division.find(function(service_name) {
          return service_name.service_name === 'APPLICATION FOR REGISTRATION';
        });
        const addregnumber = regnumber ? regnumber.total : 0;



          console.log(addregnumber,addstamping,addsearch,addConsent);
        


          document.getElementById('consent_count').innerHTML = addConsent;
          document.getElementById('search_count').innerHTML = addsearch;
          document.getElementById('stamping_count').innerHTML = addstamping;
          document.getElementById('regnum_count').innerHTML = addregnumber;

          
     


        }
    })
})





$('#completed_apps_today').on('click', function(e) {
  e.preventDefault();

$("#divisionModal3").modal("show");  

var title_=$(this).data('id');

var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();



const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${day} ${months[monthIndex]} ${year}`;



var title  = "Applications Completed"+ " " + title_+" "+formattedDate;
    
document.getElementById('divisionModalLabel3').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_report_dashboard_completed_today',
          created_for_id: created_for_id,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

      // let Data_lrd = json_result.apps_at_division[0].total;
      // let Data_lrd = json_result.apps_at_division.find(item => item.division === "LRD");

      // console.log(Data_lrd);
      const consent = json_result.apps_at_division.find(function(service_name) {
        return service_name.service_name === 'APPLICATION FOR CONSENT';
      });
      const addConsent = consent ? consent.total : 0;

      const search = json_result.apps_at_division.find(function(service_name) {
        return service_name.service_name === 'APPLICATION FOR SEARCH';
      });
      const addsearch = search ? search.total : 0;

      
      const stamping = json_result.apps_at_division.find(function(service_name) {
        return service_name.service_name === 'APPLICATION FOR STAMPING';
      });
      const addstamping = stamping ? stamping.total : 0;


      const regnumber = json_result.apps_at_division.find(function(service_name) {
        return service_name.service_name === 'APPLICATION FOR REGISTRATION';
      });
      const addregnumber = regnumber ? regnumber.total : 0;



        console.log(addregnumber,addstamping,addsearch,addConsent);
      


        document.getElementById('completed_day_consent_count').innerHTML = addConsent;
        document.getElementById('completed_day_search_count').innerHTML = addsearch;
        document.getElementById('completed_day_stamping_count').innerHTML = addstamping;
        document.getElementById('completed_day_regnumber_count').innerHTML = addregnumber;

        
   


      }
  })
})











$('#completed_apps_month').on('click', function(e) {
  e.preventDefault();

$("#divisionModal8").modal("show");  

var title_=$(this).data('id');

var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();



const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
const currentDate = new Date();
const day = currentDate.getDate();
const monthIndex = currentDate.getMonth();
const year = currentDate.getFullYear();
const formattedDate = `${months[monthIndex]}`;



var title  = "Applications Completed"+ " " + "in"+" "+formattedDate;
    
document.getElementById('divisionModalLabel8').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_report_dashboard_completed_month',
          created_for_id: created_for_id,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

      // let Data_lrd = json_result.apps_at_division[0].total;
      // let Data_lrd = json_result.apps_at_division.find(item => item.division === "LRD");

      // console.log(Data_lrd);
      const consent = json_result.apps_at_division.find(function(service_name) {
        return service_name.service_name === 'APPLICATION FOR CONSENT';
      });
      const addConsent = consent ? consent.total : 0;

      const search = json_result.apps_at_division.find(function(service_name) {
        return service_name.service_name === 'APPLICATION FOR SEARCH';
      });
      const addsearch = search ? search.total : 0;

      
      const stamping = json_result.apps_at_division.find(function(service_name) {
        return service_name.service_name === 'APPLICATION FOR STAMPING';
      });
      const addstamping = stamping ? stamping.total : 0;


      const regnumber = json_result.apps_at_division.find(function(service_name) {
        return service_name.service_name === 'APPLICATION FOR REGISTRATION';
      });
      const addregnumber = regnumber ? regnumber.total : 0;



        console.log(addregnumber,addstamping,addsearch,addConsent);
      


        document.getElementById('completed_month_consent_count').innerHTML = addConsent;
        document.getElementById('completed_month_search_count').innerHTML = addsearch;
        document.getElementById('completed_month_stamping_count').innerHTML = addstamping;
        document.getElementById('completed_month_regnumber_count').innerHTML = addregnumber;

        
   


      }
  })
})
  



  




  $('#Applications_by_subservice').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_created_today',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_today"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })





  $('#Applications_by_subservice1').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_created_today',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_today"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })
  





  $('#Applications_by_subservice2').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');

  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  = process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_created_today',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_today"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })








  $('#Applications_by_subservice3').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');

  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  = process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_created_today',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_today"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })
    




  $('#Applications_by_subservice_month').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_created_month',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_month"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })




  $('#Applications_by_subservice1_month').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_created_today',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_month"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })





  $('#Applications_by_subservice2_month').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_created_today',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_month"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })





  $('#Applications_by_subservice3_month').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_created_today',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_month"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })






  $('#completed_apps_by_subservice_day').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_completed_day',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_completed_day"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })





  $('#completed_apps_by_subservice_day1').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_completed_day',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_completed_day"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })





  $('#completed_apps_by_subservice_day2').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_completed_day',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_completed_day"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })







  $('#completed_apps_by_subservice_day3').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_completed_day',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_completed_day"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })







  $('#completed_apps_by_subservice_month').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_completed_month',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_completed_month"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })






  $('#completed_apps_by_subservice_month1').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_completed_month',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_completed_month"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })




  $('#completed_apps_by_subservice_month2').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_completed_month',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_completed_month"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })







  $('#completed_apps_by_subservice_month3').on('click', function(e) {
    e.preventDefault();
  
  $("#serviceTypeModal1").modal("show");  
  
  var process_id=$(this).data('id');
  var process_name=$(this).data('name');
  
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
  
  console.log(created_for_id);
  
  
  var title  =process_name;
      
  document.getElementById('serviceTypeModalLabel1').innerHTML = title;
  
  
  
  
    $.ajax({
        type : "POST",
        url : "corporate_applications",
        data : {
            request_type : 'corporate_sub_applications_report_dashboard_completed_month',
            created_for_id: created_for_id,
            process_id : process_id,
        },
        cache: false,
        success: function(response) {
  
            var json_result = JSON.parse(response);
            console.log(json_result.apps_at_division);
  
  //             if (json_result.data == null){
  
  //               alert('Sorry Data Not Found');
  
  
  // }else {
  
    let dataSet1 = [];
    let num1 = 0;
  
  $('#services_table').DataTable().clear().destroy();
  
  
  
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num1 = +num1 + 1;
  
        let service_type = json_result.apps_at_division[i].sub_service_name;
        let total = json_result.apps_at_division[i].total;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_completed_month"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
  
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        html.push(service_type);
        html.push(total);
        html.push(action);
        // html.push(payment_status);
        // html.push(buttons);
  
        dataSet1.push(html);
  
      //console.log(dataSet)
      }
  
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
  
      $('#services_table').DataTable().clear().destroy();
                    
      $('#services_table').DataTable({ data: dataSet1,
        dom : 'Bfrtip',
                      lengthMenu : [
                          [ 10, 25, 50, -1 ],
                          [ '10 rows', '25 rows',
                              '50 rows', 'Show all' ] ],
                      buttons : [ 'pageLength', 'copy',
                          'csv', 'excel', 'pdf', 'print' ] 
      }).draw();
      
  
  //}
  
           
  
           
  
  
        }
    })

    
  })


  
    
    
    $('#sel_change_bank').change(function(){
  // console.log("selection made " + $(this).val() );
       const selectedOptionValue = $(this).val();
                $('#bank_id').val(selectedOptionValue);
      
    
    submitAjax("corporate_applications", "corporate_applications_report_dashboard_all", {}, function (data) {
  
  
      let totalRec = data.total_apps_rec[0].total;
      let totalRecComp = data.total_comp_divisional_year[0].total;
  
      let totalpercentage = isNaN(((totalRecComp / totalRec) * 100).toFixed(2)) ? 0 : ((totalRecComp / totalRec) * 100).toFixed(2);
  
              //console.log(totalpercentage);

             $("#lrd-apps-rec").html(
              new Intl.NumberFormat().format(data.lrd_apps[0].total)
            );



            $("#smd-apps-rec").html(
              new Intl.NumberFormat().format(data.smd_apps[0].total)
            );



            $("#pvlmd-apps-rec").html(
              new Intl.NumberFormat().format(data.pvlmd_apps[0].total)
            );



            $("#lvd-apps-rec").html(
              new Intl.NumberFormat().format(data.lvd_apps[0].total)
            );

  
      
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
          
          //     // applications past due for the year
          //     showDivisionSummaryUpdated(
          //       "#app-past-due-year",
          //       data.apps_past_due_dates_divisional,
          // 'danger'
          //     );
          
              // applications with divisions
              showDivisionSummary("#app-with-divisions", data.apps_at_division, 'warning');
  
              document.getElementById('pec_id').innerHTML = totalpercentage;
  
            });
    });





    if($("#page_name").text() === "corporate_application_page"){
      // console.log("pagen complaince")
       setTimeout(
           function() 
           {
   
            submitAjax("corporate_applications", "corporate_applications_report_dashboard_past_due_apps", {}, function (data) {  



              showDivisionSummaryUpdated(
                "#app-past-due-year",
                data.apps_past_due_corprate_stamping,
          'danger'
              );


              showDivisionSummaryUpdated2(
                "#app-with-divisions",
                data.apps_past_due_corprate_stamping,
          'warning'
              );
               


              

   
              // total_comp_divisional_year
             });
           }, 2000);
       
     }

     
    
    



    $('#pvlmdToday').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_created_day_by_division',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_today"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}
    
             
    
             
    
    
          }
      })
    })
    





    $('#rloToday').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_created_day_by_division',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_today"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}
    
             
    
             
    
    
          }
      })
    })
    







    $('#lrdMonth').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_created_month_by_divisi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_month"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}
    
             
    
             
    
    
          }
      })
    })
    





    $('#lvdMonth').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_created_month_by_divisi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_month"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}
    
             
    
             
    
    
          }
      })
    })






    $('#pvlmdMonth').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_created_month_by_divisi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_month"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}
    
             
    
             
    
    
          }
      })
    })






    $('#smdMonth').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_created_month_by_divisi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_month"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}
    
             
    
             
    
    
          }
      })
    })








    $('#rloMonth').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_created_month_by_divisi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_month"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}

          }
      })
    })


    







    $('#smdDayCompleted').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_completed_day_by_divisi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_completed_day"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}

          }
      })
    })






    $('#lrdDayCompleted').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_completed_day_by_divisi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_completed_day"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}

          }
      })
    })


    




    $('#lvdDayCompleted').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_completed_day_by_divisi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_completed_day"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}

          }
      })
    })





    $('#pvlmdDayCompleted').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_completed_day_by_divisi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_completed_day"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}

          }
      })
    })





    $('#rloDayCompleted').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_completed_day_by_divisi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_completed_day"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}

          }
      })
    })




  


    $('#smdMonthCompleted').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_completed_month_by_divi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_completed_day"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}

          }
      })
    })







    $('#lrdMonthCompleted').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_completed_month_by_divi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_completed_day"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}

          }
      })
    })








    $('#pvlmdMonthCompleted').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_completed_month_by_divi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_completed_day"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}

          }
      })
    })






    $('#lvdMonthCompleted').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_completed_month_by_divi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_completed_day"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}

          }
      })
    })





    $('#rloMonthCompleted').on('click', function(e) {
      e.preventDefault();
    
    $("#serviceTypeModal1").modal("show");  
    
    var user_division=$(this).data('id');
    var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
    
    
    console.log(created_for_id);
    
    
    var title  = user_division+"'s"+" "+"Applications By Services";
        
    document.getElementById('serviceTypeModalLabel1').innerHTML = title;
    
    
    
    
      $.ajax({
          type : "POST",
          url : "corporate_applications",
          data : {
              request_type : 'corporate_applications_report_dashboard_completed_month_by_divi',
              created_for_id: created_for_id,
              division : user_division,
          },
          cache: false,
          success: function(response) {
    
              var json_result = JSON.parse(response);
              console.log(json_result.apps_at_division);
    
    //             if (json_result.data == null){
    
    //               alert('Sorry Data Not Found');
    
    
    // }else {
    
      let dataSet1 = [];
      let num1 = 0;
    
    $('#services_table').DataTable().clear().destroy();
    
    
    
      for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num1 = +num1 + 1;
    
          let service_type = json_result.apps_at_division[i].service_type;
          let total = json_result.apps_at_division[i].total;
          let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_completed_day"  
          class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
          // let payment_status = e[i].payment_status;
          // let buttons = e[i].buttons;
          
    
          html.push(service_type);
          html.push(total);
          html.push(action);
          // html.push(payment_status);
          // html.push(buttons);
    
          dataSet1.push(html);
    
        //console.log(dataSet)
        }
    
      // let dataTable_Obj = $('#recievedtoday').DataTable({
      //     data: dataSet1
      //   })
    
        $('#services_table').DataTable().clear().destroy();
                      
        $('#services_table').DataTable({ data: dataSet1,
          dom : 'Bfrtip',
                        lengthMenu : [
                            [ 10, 25, 50, -1 ],
                            [ '10 rows', '25 rows',
                                '50 rows', 'Show all' ] ],
                        buttons : [ 'pageLength', 'copy',
                            'csv', 'excel', 'pdf', 'print' ] 
        }).draw();
        
    
    //}

          }
      })
    })





    $(document).on('click','#view_service_apps_today',function(e){
      e.preventDefault();
      var service_name=$(this).data('id');
      var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
     
  
      $("#applicationsModal1").modal("show");  
  
     
      var title  = service_name+" "+"APPLICATIONS";
          
      document.getElementById('applicationsModalLabel1').innerHTML = title;
  
    
      console.log(service_name,created_for_id);
     
   
     
    
     let dataSet2 = [];
     let num2 = 0;
    
    $('#services_applications').DataTable().clear().destroy();
    
     $.ajax({
         type : "POST",
         url : "corporate_applications",
         data : {
             request_type : 'corporate_applications_report_dashboard_created_day_by_service',
             created_for_id : created_for_id,
             service_type : service_name
         },
         cache: false,
         success: function(response) {
    
          console.log(response)
    
             var json_result = JSON.parse(response);
             console.log(json_result.apps_at_division)
    
    
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
  
  
  
     
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        
    
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
    
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
    
      $('#services_applications').DataTable().clear().destroy();
                    
      $('#services_applications').DataTable({ data: dataSet2,
        dom : 'Bfrtip',
        lengthMenu : [
            [ 10, 25, 50, -1 ],
            [ '10 rows', '25 rows',
                '50 rows', 'Show all' ] ],
        buttons : [ 'pageLength', 'copy',
            'csv', 'excel', 'pdf', 'print' ] }).draw();
    
  //  }
            
    
         }
     })
    
    });


    





   
    

    $(document).on('click','#view_service_apps_month',function(e){
      e.preventDefault();
      var service_name=$(this).data('id');
      var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
     
  
      $("#applicationsModal1").modal("show");  
  
     
      var title  = service_name+" "+"APPLICATIONS";
          
      document.getElementById('applicationsModalLabel1').innerHTML = title;
  
    
      console.log(service_name,created_for_id);
     
   
     
    
     let dataSet2 = [];
     let num2 = 0;
    
    $('#services_applications').DataTable().clear().destroy();
    
     $.ajax({
         type : "POST",
         url : "corporate_applications",
         data : {
             request_type : 'corporate_applications_report_dashboard_created_month_by_servic',
             created_for_id : created_for_id,
             service_type : service_name
         },
         cache: false,
         success: function(response) {
    
          console.log(response)
    
             var json_result = JSON.parse(response);
             console.log(json_result.apps_at_division)
    
    
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
  
  
  
     
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        
    
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
    
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
    
      $('#services_applications').DataTable().clear().destroy();
                    
      $('#services_applications').DataTable({ data: dataSet2,
        dom : 'Bfrtip',
        lengthMenu : [
            [ 10, 25, 50, -1 ],
            [ '10 rows', '25 rows',
                '50 rows', 'Show all' ] ],
        buttons : [ 'pageLength', 'copy',
            'csv', 'excel', 'pdf', 'print' ] }).draw();
    
  //  }
            
    
         }
     })
    
    });








    $(document).on('click','#view_service_apps_completed_day',function(e){
      e.preventDefault();
      var service_name=$(this).data('id');
      var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
     
  
      $("#applicationsModal1").modal("show");  
  
     
      var title  = service_name+" "+"APPLICATIONS";
          
      document.getElementById('applicationsModalLabel1').innerHTML = title;
  
    
      console.log(service_name,created_for_id);
     
   
     
    
     let dataSet2 = [];
     let num2 = 0;
    
    $('#services_applications').DataTable().clear().destroy();
    
     $.ajax({
         type : "POST",
         url : "corporate_applications",
         data : {
             request_type : 'corporate_applications_report_dashboard_completed_day_by_servic',
             created_for_id : created_for_id,
             service_type : service_name
         },
         cache: false,
         success: function(response) {
    
          console.log(response)
    
             var json_result = JSON.parse(response);
             console.log(json_result.apps_at_division)
    
    
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
  
  
  
     
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        
    
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
    
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
    
      $('#services_applications').DataTable().clear().destroy();
                    
      $('#services_applications').DataTable({ data: dataSet2,
        dom : 'Bfrtip',
        lengthMenu : [
            [ 10, 25, 50, -1 ],
            [ '10 rows', '25 rows',
                '50 rows', 'Show all' ] ],
        buttons : [ 'pageLength', 'copy',
            'csv', 'excel', 'pdf', 'print' ] }).draw();
    
  //  }
            
    
         }
     })
    
    });




 
    
    $(document).on('click','#view_service_apps_completed_month',function(e){
      e.preventDefault();
      var service_name=$(this).data('id');
      var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  
     
  
      $("#applicationsModal1").modal("show");  
  
     
      var title  = service_name+" "+"APPLICATIONS";
          
      document.getElementById('applicationsModalLabel1').innerHTML = title;
  
    
      console.log(service_name,created_for_id);
     
   
     
    
     let dataSet2 = [];
     let num2 = 0;
    
    $('#services_applications').DataTable().clear().destroy();
    
     $.ajax({
         type : "POST",
         url : "corporate_applications",
         data : {
             request_type : 'corporate_applications_report_dashboard_completed_month_by_serv',
             created_for_id : created_for_id,
             service_type : service_name
         },
         cache: false,
         success: function(response) {
    
          console.log(response)
    
             var json_result = JSON.parse(response);
             console.log(json_result.apps_at_division)
    
    
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
  
  
  
     
        // let payment_status = e[i].payment_status;
        // let buttons = e[i].buttons;
        
  
        
    
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
    
    // let dataTable_Obj = $('#recievedtoday').DataTable({
    //     data: dataSet1
    //   })
    
      $('#services_applications').DataTable().clear().destroy();
                    
      $('#services_applications').DataTable({ data: dataSet2,
        dom : 'Bfrtip',
        lengthMenu : [
            [ 10, 25, 50, -1 ],
            [ '10 rows', '25 rows',
                '50 rows', 'Show all' ] ],
        buttons : [ 'pageLength', 'copy',
            'csv', 'excel', 'pdf', 'print' ] }).draw();
    
  //  }
            
    
         }
     })
    
    });


    


$('#apps_recieved_within_dates').on('click', function(e) {
  e.preventDefault();

$("#apps_recieved_within_dates_modal").modal("show");  

})




$('#apps_recieved_completed_within_dates').on('click', function(e) {
  e.preventDefault();

$("#apps_recieved_completed_within_dates_modal").modal("show");  

})



$('#apps_completed_within_dates').on('click', function(e) {
  e.preventDefault();

$("#apps_completed_within_dates_modal").modal("show");  

})








$('#submit_Btn').click(function(e){
  e.preventDefault();

  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  var start_date = $('#startDate').val();
   var end_date = $('#endDate').val();
   


   if (start_date === '' || end_date === '') {
    alert('Please fill in both Start Date and End Date fields.');

}
   else {


   $.ajax({
    type : "POST",
    url : "corporate_applications",
    data : {
        request_type : 'corporate_applications_report_dashboard_recieved_between_dates',
        created_for_id :created_for_id,
        start_date : start_date,
        end_date : end_date
    },
    cache: false,
    success: function(response) {

        var json_result = JSON.parse(response)

        console.log(json_result.apps_at_division);

        if (json_result.apps_at_division.length === 0) {

          alert('Sorry Data Not Found');
            // console.log("data not found");      

}else {


  $("#apps_recieved_within_dates_modal").modal("hide");  

  $("#divisionModal5").modal("show");  

  $("#officer_startDate").val(start_date);
  $("#officer_endDate").val(end_date);



  // officer_startDate


  var title = "Applications Recieved Between" + " "+ start_date+ " and " + end_date

  document.getElementById('divisionModalLabel5').innerHTML = title;



  let serviceDiv = "";

  

    for(let i=0; i<json_result.apps_at_division.length; i++) {

      let service_name = json_result.apps_at_division[i].service_name;
      let total = json_result.apps_at_division[i].total;
      let business_process_id = json_result.apps_at_division[i].business_process_id;

      serviceDiv += `<div class="col-xl-3 col-md-6 mb-4" id="rec_by_date" data-id="${service_name}" data-service-name="${service_name}" data-process_id="${business_process_id}">
                  <div class="card border-left-info shadow ">
                    <div class="card-body">
                      <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">${service_name}</div>
                          <div class="h5 mb-0 font-weight-bold text-gray-800" id="smd_count_apps_by_date">${total}</div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-2x text-gray-300 fa-file"></i>
                        </div>
                       
                      </div>
                    </div>
                  </div>
                </div>`;


                  
            
                 
                console.log(service_name)
        document.getElementById('services_row').innerHTML = serviceDiv; // Set the HTML content after the loop


                }            



}

       

       


    }
})

}


});









$('#submit_Btn2').click(function(e){
  e.preventDefault();

  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  var start_date = $('#rec_comp_startDate').val();
   var end_date = $('#rec_comp_endDate').val();
   


   if (start_date === '' || end_date === '') {
    alert('Please fill in both Start Date and End Date fields.');

}
   else {


   $.ajax({
    type : "POST",
    url : "corporate_applications",
    data : {
        request_type : 'corporate_apps_report_dashboard_recieved_completed_by_dates',
        created_for_id :created_for_id,
        start_date : start_date,
        end_date : end_date
    },
    cache: false,
    success: function(response) {

        var json_result = JSON.parse(response)

        console.log(json_result.apps_at_division);

        if (json_result.apps_at_division.length === 0) {

          alert('Sorry Data Not Found');
            // console.log("data not found");      

}else {


  $("#apps_recieved_completed_within_dates_modal").modal("hide");  

  $("#divisionModal6").modal("show");  

  $("#officer_rec_comp_startDate").val(start_date);
  $("#officer_rec_comp_endDate").val(end_date);



  // officer_startDate


  var title = "Applications Recieved and Completed Between" + " "+ start_date+ " and " + end_date

  document.getElementById('divisionModalLabel6').innerHTML = title;



  let serviceDiv1 = "";

  

  for(let i=0; i<json_result.apps_at_division.length; i++) {

    let service_name = json_result.apps_at_division[i].service_name;
    let total = json_result.apps_at_division[i].total;
    let business_process_id = json_result.apps_at_division[i].business_process_id;

    serviceDiv1 += `<div class="col-xl-3 col-md-6 mb-4" id="rec_comp_by_date" data-id="${service_name}" data-service-name="${service_name}" data-process_id="${business_process_id}">
                <div class="card border-left-info shadow ">
                  <div class="card-body">
                    <div class="row no-gutters align-items-center">
                      <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">${service_name}</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800" id="smd_count_apps_by_date">${total}</div>
                      </div>
                      <div class="col-auto">
                        <i class="fas fa-2x text-gray-300 fa-file"></i>
                      </div>
                     
                    </div>
                  </div>
                </div>
              </div>`;


                
          
               
              console.log(service_name)
      document.getElementById('services_row1').innerHTML = serviceDiv1; // Set the HTML content after the loop


              }    



  // const lrdDivision = json_result.apps_at_division.find(function(division) {
  //   return division.division === 'LRD';
  // });
  // const lrdTotal = lrdDivision ? lrdDivision.total : 0;

  // const lvdDivision = json_result.apps_at_division.find(function(division) {
  //   return division.division === 'LVD';
  // });
  // const lvdTotal = lvdDivision ? lvdDivision.total : 0;


  // const smdDivision = json_result.apps_at_division.find(function(division) {
  //   return division.division === 'SMD';
  // });
  // const smdTotal = smdDivision ? smdDivision.total : 0;


  // const pvlmdDivision = json_result.apps_at_division.find(function(division) {
  //   return division.division === 'PVLMD';
  // });
  // const pvlmdTotal = pvlmdDivision ? pvlmdDivision.total : 0;



  //   console.log(pvlmdTotal,smdTotal,lvdTotal,lrdTotal);
  


  //   document.getElementById('lrd_count_apps_rec_comp_by_date').innerHTML = lrdTotal;
  //   document.getElementById('lvd_count_apps_rec_comp_by_date').innerHTML = lvdTotal;
  //   document.getElementById('pvlmd_count_apps_rec_comp_by_date').innerHTML = pvlmdTotal;
  //   document.getElementById('smd_count_apps_rec_comp_by_date').innerHTML = smdTotal;



}

       

       


    }
})

}


});










$('#submit_Btn1').click(function(e){
  e.preventDefault();

  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();
  var start_date = $('#completed_startDate').val();
   var end_date = $('#completed_endDate').val();
   


   if (start_date === '' || end_date === '') {
    alert('Please fill in both Start Date and End Date fields.');

}
   else {


   $.ajax({
    type : "POST",
    url : "corporate_applications",
    data : {
        request_type : 'corporate_applications_report_dashboard_completed_by_dates',
        created_for_id :created_for_id,
        start_date : start_date,
        end_date : end_date
    },
    cache: false,
    success: function(response) {

        var json_result = JSON.parse(response)

        console.log(json_result.apps_at_division);

        if (json_result.apps_at_division.length === 0) {

          alert('Sorry Data Not Found');
            // console.log("data not found");      

}else {


  $("#apps_completed_within_dates_modal").modal("hide");  

  $("#divisionModal7").modal("show");  

  $("#officer_comp_startDate").val(start_date);
  $("#officer_comp_endDate").val(end_date);



  // officer_startDate


  var title = "Applications Completed Between" + " "+ start_date+ " and " + end_date

  document.getElementById('divisionModalLabel7').innerHTML = title;




  let serviceDiv2 = "";

  

  for(let i=0; i<json_result.apps_at_division.length; i++) {

    let service_name = json_result.apps_at_division[i].service_name;
    let total = json_result.apps_at_division[i].total;
    let business_process_id = json_result.apps_at_division[i].business_process_id;

    serviceDiv2 += `<div class="col-xl-3 col-md-6 mb-4" id="comp_by_date" data-id="${service_name}" data-service-name="${service_name}" data-process_id="${business_process_id}">
                <div class="card border-left-info shadow ">
                  <div class="card-body">
                    <div class="row no-gutters align-items-center">
                      <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">${service_name}</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800" id="smd_count_apps_by_date">${total}</div>
                      </div>
                      <div class="col-auto">
                        <i class="fas fa-2x text-gray-300 fa-file"></i>
                      </div>
                     
                    </div>
                  </div>
                </div>
              </div>`;


                
          
               
              console.log(service_name)
      document.getElementById('services_row2').innerHTML = serviceDiv2; // Set the HTML content after the loop


              }    





}

       

       


    }
})

}


});






$('#divisionModal5').on('click','#rec_by_date',function(){

 
  $("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('process_id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var service_name=$(this).data('service-name');


var new_startDate = $('#officer_startDate').val();
  var new_endDate = $('#officer_endDate').val();


console.log(user_division);


var title  = service_name+" "+"RECIEVED FROM " + new_startDate + " TO " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_report_dashboard_created_by_date_range',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let sub_service_name = json_result.apps_at_division[i].sub_service_name;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_recieved_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(sub_service_name);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })


}); 












$('#divisionModal6').on('click','#rec_comp_by_date',function(){

 
  $("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('process_id');
var service_name=$(this).data('service-name');



var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_rec_comp_startDate').val();
  var new_endDate = $('#officer_rec_comp_endDate').val();


console.log(user_division);


var title  = service_name+" "+"RECIEVED AND COMPLETED FROM " + new_startDate + " TO " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_apps_report_dashboard_created_comp_by_date_range',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let sub_service_name = json_result.apps_at_division[i].sub_service_name;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_recieved_comp_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(sub_service_name);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })


}); 







$('#divisionModal7').on('click','#comp_by_date',function(){

 
  $("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('process_id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var service_name=$(this).data('service-name');


var new_startDate = $('#officer_comp_startDate').val();
  var new_endDate = $('#officer_comp_endDate').val();


console.log(user_division);


var title  = service_name+" "+"COMPLETED FROM " + new_startDate + " TO " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_report_dashboard_completed_by_date',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let sub_service_name = json_result.apps_at_division[i].sub_service_name;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].sub_service_name}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_service_apps_comp_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(sub_service_name);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })


}); 





// $('#lrdAppsByDates').on('click', function(e) {
//   e.preventDefault();

// $("#serviceTypeModal1").modal("show");  

// var user_division=$(this).data('id');
// var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

// var new_startDate = $('#officer_startDate').val();
//   var new_endDate = $('#officer_endDate').val();


// console.log(created_for_id);


// var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
// document.getElementById('serviceTypeModalLabel1').innerHTML = title;




//   $.ajax({
//       type : "POST",
//       url : "corporate_applications",
//       data : {
//           request_type : 'corporate_applications_report_dashboard_created_by_date_range',
//           start_date:new_startDate,
//           end_date:new_endDate,
//           created_for_id: created_for_id,
//           division : user_division,
//       },
//       cache: false,
//       success: function(response) {

//           var json_result = JSON.parse(response);
//           console.log(json_result.apps_at_division);

// //             if (json_result.data == null){

// //               alert('Sorry Data Not Found');


// // }else {

//   let dataSet1 = [];
//   let num1 = 0;

// $('#services_table').DataTable().clear().destroy();



//   for(let i=0; i<json_result.apps_at_division.length; i++) {
//       let html = [];
//       num1 = +num1 + 1;

//       let service_type = json_result.apps_at_division[i].service_type;
//       let total = json_result.apps_at_division[i].total;
//       let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_recieved_dates"  
//       class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

//       // let payment_status = e[i].payment_status;
//       // let buttons = e[i].buttons;
      

//       html.push(service_type);
//       html.push(total);
//       html.push(action);
//       // html.push(payment_status);
//       // html.push(buttons);

//       dataSet1.push(html);

//     //console.log(dataSet)
//     }

//   // let dataTable_Obj = $('#recievedtoday').DataTable({
//   //     data: dataSet1
//   //   })

//     $('#services_table').DataTable().clear().destroy();
                  
//     $('#services_table').DataTable({ data: dataSet1,
//       dom : 'Bfrtip',
//                     lengthMenu : [
//                         [ 10, 25, 50, -1 ],
//                         [ '10 rows', '25 rows',
//                             '50 rows', 'Show all' ] ],
//                     buttons : [ 'pageLength', 'copy',
//                         'csv', 'excel', 'pdf', 'print' ] 
//     }).draw();
    

// //}

//       }
//   })
// })








$('#smdAppsByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_startDate').val();
var new_endDate = $('#officer_endDate').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_report_dashboard_created_by_date_range',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_recieved_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})






$('#lvdAppsByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_startDate').val();
  var new_endDate = $('#officer_endDate').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_report_dashboard_created_by_date_range',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_recieved_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})






$('#pvlmdAppsByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_startDate').val();
  var new_endDate = $('#officer_endDate').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_report_dashboard_created_by_date_range',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_recieved_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})





$('#rloAppsByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_startDate').val();
  var new_endDate = $('#officer_endDate').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_report_dashboard_created_by_date_range',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_recieved_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})






$(document).on('click','#view_service_apps_recieved_dates',function(e){
  e.preventDefault();
  var service_name=$(this).data('id');
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

  var new_startDate = $('#officer_startDate').val();
  var new_endDate = $('#officer_endDate').val();


 

  $("#applicationsModal1").modal("show");  

 
  var title  = service_name+" "+"APPLICATIONS FROM " +new_startDate + " TO " + new_endDate ;
      
  document.getElementById('applicationsModalLabel1').innerHTML = title;

  


  console.log(service_name,created_for_id);
 

 

 let dataSet2 = [];
 let num2 = 0;

$('#services_applications').DataTable().clear().destroy();

 $.ajax({
     type : "POST",
     url : "corporate_applications",
     data : {
         request_type : 'corporate_applications_division_apps_by_service_date_range',
         created_for_id : created_for_id,
         service_type : service_name,
         start_date : new_startDate,
         end_date : new_endDate
     },
     cache: false,
     success: function(response) {

      console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result.apps_at_division)


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



 
    // let payment_status = e[i].payment_status;
    // let buttons = e[i].buttons;
    

    

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

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

  $('#services_applications').DataTable().clear().destroy();
                
  $('#services_applications').DataTable({ data: dataSet2,
    dom : 'Bfrtip',
    lengthMenu : [
        [ 10, 25, 50, -1 ],
        [ '10 rows', '25 rows',
            '50 rows', 'Show all' ] ],
    buttons : [ 'pageLength', 'copy',
        'csv', 'excel', 'pdf', 'print' ] }).draw();

//  }
        

     }
 })

});








$(document).on('click','#view_service_apps_recieved_comp_dates',function(e){
  e.preventDefault();
  var service_name=$(this).data('id');
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

  var new_startDate = $('#officer_rec_comp_startDate').val();
  var new_endDate = $('#officer_rec_comp_endDate').val();


 

  $("#applicationsModal1").modal("show");  

 
  var title  = service_name+" "+"APPLICATIONS FROM " +new_startDate + " TO " + new_endDate ;
      
  document.getElementById('applicationsModalLabel1').innerHTML = title;

  


  console.log(service_name,created_for_id);
 

 

 let dataSet2 = [];
 let num2 = 0;

$('#services_applications').DataTable().clear().destroy();

 $.ajax({
     type : "POST",
     url : "corporate_applications",
     data : {
         request_type : 'corporate_app_division_apps_by_service_date_range_rec_comp',
         created_for_id : created_for_id,
         service_type : service_name,
         start_date : new_startDate,
         end_date : new_endDate
     },
     cache: false,
     success: function(response) {

      console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result.apps_at_division)


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



 
    // let payment_status = e[i].payment_status;
    // let buttons = e[i].buttons;
    

    

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

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

  $('#services_applications').DataTable().clear().destroy();
                
  $('#services_applications').DataTable({ data: dataSet2,
    dom : 'Bfrtip',
    lengthMenu : [
        [ 10, 25, 50, -1 ],
        [ '10 rows', '25 rows',
            '50 rows', 'Show all' ] ],
    buttons : [ 'pageLength', 'copy',
        'csv', 'excel', 'pdf', 'print' ] }).draw();

//  }
        

     }
 })

});


    




$(document).on('click','#view_service_apps_comp_dates',function(e){
  e.preventDefault();
  var service_name=$(this).data('id');
  var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

  var new_startDate = $('#officer_comp_startDate').val();
  var new_endDate = $('#officer_comp_endDate').val();


 

  $("#applicationsModal1").modal("show");  

 
  var title  = service_name+" "+"APPLICATIONS FROM " +new_startDate + " TO " + new_endDate ;
      
  document.getElementById('applicationsModalLabel1').innerHTML = title;

  


  console.log(service_name,created_for_id);
 

 

 let dataSet2 = [];
 let num2 = 0;

$('#services_applications').DataTable().clear().destroy();

 $.ajax({
     type : "POST",
     url : "corporate_applications",
     data : {
         request_type : 'corporate_applications_report_dashboard_completed_by_serv_dates',
         created_for_id : created_for_id,
         service_type : service_name,
         start_date : new_startDate,
         end_date : new_endDate
     },
     cache: false,
     success: function(response) {

      console.log(response)

         var json_result = JSON.parse(response);
         console.log(json_result.apps_at_division)


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



 
    // let payment_status = e[i].payment_status;
    // let buttons = e[i].buttons;
    

    

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

// let dataTable_Obj = $('#recievedtoday').DataTable({
//     data: dataSet1
//   })

  $('#services_applications').DataTable().clear().destroy();
                
  $('#services_applications').DataTable({ data: dataSet2,
    dom : 'Bfrtip',
    lengthMenu : [
        [ 10, 25, 50, -1 ],
        [ '10 rows', '25 rows',
            '50 rows', 'Show all' ] ],
    buttons : [ 'pageLength', 'copy',
        'csv', 'excel', 'pdf', 'print' ] }).draw();

//  }
        

     }
 })

});



$('#smdAppsRecCompByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_rec_comp_startDate').val();
var new_endDate = $('#officer_rec_comp_endDate').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_apps_report_dashboard_created_comp_by_date_range',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_recieved_comp_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})






$('#lvdAppsRecCompByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_rec_comp_startDate').val();
var new_endDate = $('#officer_rec_comp_endDate').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_apps_report_dashboard_created_comp_by_date_range',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_recieved_comp_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})






$('#lrdAppsRecCompByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_rec_comp_startDate').val();
var new_endDate = $('#officer_rec_comp_endDate').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_apps_report_dashboard_created_comp_by_date_range',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_recieved_comp_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})





$('#pvlmdAppsRecCompByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_rec_comp_startDate').val();
var new_endDate = $('#officer_rec_comp_endDate').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_apps_report_dashboard_created_comp_by_date_range',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_recieved_comp_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})





$('#rloAppsRecCompByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_rec_comp_startDate').val();
var new_endDate = $('#officer_rec_comp_endDate').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_apps_report_dashboard_created_comp_by_date_range',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_recieved_comp_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})






$('#smdAppsCompByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_comp_startDate').val();
var new_endDate = $('#officer_comp_endDate').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_report_dashboard_completed_by_date',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_comp_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})






$('#lrdAppsCompByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_comp_startDate').val();
var new_endDate = $('#officer_comp_endDate').val();



console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_report_dashboard_completed_by_date',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_comp_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})





$('#pvlmdAppsCompByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_comp_startDate').val();
var new_endDate = $('#officer_comp_endDate').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_report_dashboard_completed_by_date',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_comp_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})





$('#lvdAppsCompByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_comp_startDate').val();
var new_endDate = $('#officer_comp_endDate').val();



console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_report_dashboard_completed_by_date',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_comp_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})





$('#rloAppsCompByDates').on('click', function(e) {
  e.preventDefault();

$("#serviceTypeModal1").modal("show");  

var user_division=$(this).data('id');
var created_for_id = $('#bank_id').val() === "" ? "null" : $('#bank_id').val();

var new_startDate = $('#officer_comp_startDate').val();
var new_endDate = $('#officer_comp_endDate').val();


console.log(created_for_id);


var title  = user_division+"'s"+" "+"Applications By Services from " + new_startDate + " to " + new_endDate ;
    
document.getElementById('serviceTypeModalLabel1').innerHTML = title;




  $.ajax({
      type : "POST",
      url : "corporate_applications",
      data : {
          request_type : 'corporate_applications_report_dashboard_completed_by_date',
          start_date:new_startDate,
          end_date:new_endDate,
          created_for_id: created_for_id,
          division : user_division,
      },
      cache: false,
      success: function(response) {

          var json_result = JSON.parse(response);
          console.log(json_result.apps_at_division);

//             if (json_result.data == null){

//               alert('Sorry Data Not Found');


// }else {

  let dataSet1 = [];
  let num1 = 0;

$('#services_table').DataTable().clear().destroy();



  for(let i=0; i<json_result.apps_at_division.length; i++) {
      let html = [];
      num1 = +num1 + 1;

      let service_type = json_result.apps_at_division[i].service_type;
      let total = json_result.apps_at_division[i].total;
      let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].service_type}" data-name_full="${json_result.apps_at_division[i].service_type}" id="view_service_apps_comp_dates"  
      class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `

      // let payment_status = e[i].payment_status;
      // let buttons = e[i].buttons;
      

      html.push(service_type);
      html.push(total);
      html.push(action);
      // html.push(payment_status);
      // html.push(buttons);

      dataSet1.push(html);

    //console.log(dataSet)
    }

  // let dataTable_Obj = $('#recievedtoday').DataTable({
  //     data: dataSet1
  //   })

    $('#services_table').DataTable().clear().destroy();
                  
    $('#services_table').DataTable({ data: dataSet1,
      dom : 'Bfrtip',
                    lengthMenu : [
                        [ 10, 25, 50, -1 ],
                        [ '10 rows', '25 rows',
                            '50 rows', 'Show all' ] ],
                    buttons : [ 'pageLength', 'copy',
                        'csv', 'excel', 'pdf', 'print' ] 
    }).draw();
    

//}

      }
  })
})


    
   
  
    
  
  
  
  
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
     console.log(total);
  
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
          current.business_process_id
        }"  data-servname="${
          current.service_name 
 }"  data-type="${
          current.business_process_id
        }"  data-date="${date}" data-title="${title}" class="${nextLevelModal} text-decoration-none text-muted">
              ${current.service_name} (${current.total})
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
      
      let newtotal = firmList.apps_past_due_corprate_stamping[0].total;
      let regtotal = firmList.apps_past_due_corprate_registration[0].total;
      let estatetotal = firmList.apps_past_due_corprate_estate[0].total;


      let finaltotal = newtotal+ regtotal+estatetotal;
  

  
  
  
      let stampingpercentage = isNaN(((newtotal / finaltotal) * 100).toFixed(2)) ? 0 : ((newtotal / finaltotal) * 100).toFixed(2);
      let registrationercentage = isNaN(((regtotal / finaltotal) * 100).toFixed(2)) ? 0 : ((regtotal / finaltotal) * 100).toFixed(2);
      let estatepercentage = isNaN(((estatetotal / finaltotal) * 100).toFixed(2)) ? 0 : ((estatetotal / finaltotal) * 100).toFixed(2);
    
  
    
       
      let total = data.reduce(function (sum, current) {
       
        return (sum += current.newtotal);
      }, 0);
     // let total = totalPerRec;
     //console.log(newtotal);
  
      $(id).find(".count").html(new Intl.NumberFormat().format(finaltotal));
  
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
        } data-action="report_dashboard_${method}${periodToAdd}" data-type="4" data-date="${date}" data-servname="Corporate Stamping Unit" data-title="${title}" class="${nextLevelModal} text-decoration-none text-muted">
              CORPORATE STAMPING UNIT (${newtotal})
            </a>
            <span class="float-right">${stampingpercentage}%</span>
          </h4>
          <div class="progress mb-4">
            <div class="progress-bar bg-${color}" role="progressbar" style="width: ${stampingpercentage}%" aria-valuenow="${stampingpercentage}"
              aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
  
  
        <div class="item">
          <h4 class="small font-weight-bold">
            <a href="#" data-method="${method}" data-url="${url}" ${
          typeof period === "undefined" ? "" : `data-period="${period}"`
        } data-action="report_dashboard_${method}${periodToAdd}" data-type="4" data-date="${date}" data-servname="Corporate Registration Unit"  data-title="${title}" class="${nextLevelModal}
         text-decoration-none text-muted">
              CORPORATE REGISTRATION UNIT (${regtotal})
            </a>
            <span class="float-right">${registrationercentage}%</span>
          </h4>
          <div class="progress mb-4">
            <div class="progress-bar bg-${color}" role="progressbar" style="width: ${registrationercentage}%" aria-valuenow="${registrationercentage}"
              aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
  
  
        <div class="item">
          <h4 class="small font-weight-bold">
            <a href="#" data-method="${method}" data-url="${url}" ${
          typeof period === "undefined" ? "" : `data-period="${period}"`
        } data-action="report_dashboard_${method}${periodToAdd}" data-type="4" data-date="${date}" data-servname="Corporate Estate Unit" data-title="${title}" class="${nextLevelModal} text-decoration-none text-muted">
              CORPORATE ESTATE UNIT (${estatetotal})
            </a>
            <span class="float-right">${estatepercentage}%</span>
          </h4>
          <div class="progress mb-4">
            <div class="progress-bar bg-${color}" role="progressbar" style="width: ${estatepercentage}%" aria-valuenow="${estatepercentage}"
              aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
  
        `
        ;
  
        return (html);
      }, "");
  
      contentBody.html(dataHtml);
    }

    





    function showDivisionSummaryUpdated2(id, data,color) {
      
      let newtotal = firmList.apps_with_division_corporate_stamping[0].count;
      let regtotal = firmList.apps_with_division_corporate_registration[0].count;
      let estatetotal = firmList.apps_with_division_corporate_estate[0].count;


      let finaltotal = newtotal+ regtotal+estatetotal;
  

  
  
  
      let stampingpercentage = isNaN(((newtotal / finaltotal) * 100).toFixed(2)) ? 0 : ((newtotal / finaltotal) * 100).toFixed(2);
      let registrationercentage = isNaN(((regtotal / finaltotal) * 100).toFixed(2)) ? 0 : ((regtotal / finaltotal) * 100).toFixed(2);
      let estatepercentage = isNaN(((estatetotal / finaltotal) * 100).toFixed(2)) ? 0 : ((estatetotal / finaltotal) * 100).toFixed(2);
    
  
    
       
      let total = data.reduce(function (sum, current) {
       
        return (sum += current.newtotal);
      }, 0);
     // let total = totalPerRec;
     //console.log(newtotal);
  
      $(id).find(".count").html(new Intl.NumberFormat().format(finaltotal));
  
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
        } data-action="report_dashboard_${method}${periodToAdd}" data-type="4" data-date="${date}" data-servname="Corporate Stamping Unit" data-title="${title}" class="${nextLevelModal} text-decoration-none text-muted">
              CORPORATE STAMPING UNIT (${newtotal})
            </a>
            <span class="float-right">${stampingpercentage}%</span>
          </h4>
          <div class="progress mb-4">
            <div class="progress-bar bg-${color}" role="progressbar" style="width: ${stampingpercentage}%" aria-valuenow="${stampingpercentage}"
              aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
  
  
        <div class="item">
          <h4 class="small font-weight-bold">
            <a href="#" data-method="${method}" data-url="${url}" ${
          typeof period === "undefined" ? "" : `data-period="${period}"`
        } data-action="report_dashboard_${method}${periodToAdd}" data-type="4" data-date="${date}" data-servname="Corporate Registration Unit"  data-title="${title}" class="${nextLevelModal}
         text-decoration-none text-muted">
              CORPORATE REGISTRATION UNIT (${regtotal})
            </a>
            <span class="float-right">${registrationercentage}%</span>
          </h4>
          <div class="progress mb-4">
            <div class="progress-bar bg-${color}" role="progressbar" style="width: ${registrationercentage}%" aria-valuenow="${registrationercentage}"
              aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
  
  
        <div class="item">
          <h4 class="small font-weight-bold">
            <a href="#" data-method="${method}" data-url="${url}" ${
          typeof period === "undefined" ? "" : `data-period="${period}"`
        } data-action="report_dashboard_${method}${periodToAdd}" data-type="4" data-date="${date}" data-servname="Corporate Estate Unit" data-title="${title}" class="${nextLevelModal} text-decoration-none text-muted">
              CORPORATE ESTATE UNIT (${estatetotal})
            </a>
            <span class="float-right">${estatepercentage}%</span>
          </h4>
          <div class="progress mb-4">
            <div class="progress-bar bg-${color}" role="progressbar" style="width: ${estatepercentage}%" aria-valuenow="${estatepercentage}"
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
     
     var created_for_id =$('#sel_change_bank').val().trim();
     console.log(created_for_id)
  
     if(created_for_id != undefined){
      created_for_id =  created_for_id.replace(".0", "");
     }

      $.ajax({
        type: "POST",
        url,
        data: {
          request_type: requestType,
          created_for_id: created_for_id,
          ...data,
        },
        cache: false,
        success: function (response) {
       
        var reccc = JSON.parse(response);

        console.log(reccc);
        firmList = reccc;
        // console.log(reccc);
        // let totalPerRec = reccc.lrd_apps[0].total;
        // // let lrdData = reccc.apps_at_division.find(item => item.division === "LRD");
        // // let  lrdTotal = lrdData.total;
        //   console.log(totalPerRec);
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
  
  