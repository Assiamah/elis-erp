
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


    // console.log("Fetching dashboard stats from:", startDate, "to", endDate);

    // ✅ AJAX call
$.ajax({
  type: "POST",
  url: "audit_reporting",
  data: {
    request_type: "get_advanced_activity_logs_summary",
    start_date_ar: startDate,
    end_date_ar: endDate,
  },
  cache: false,
  success: function (response) {
    try {
      const json_result = typeof response === "string" ? JSON.parse(response) : response;
    //   console.log("Dashboard data:", json_result);

      if (json_result.success) {
        const data = json_result.data || [];

        // First, reset all counts to 0 before updating
        $(".advanced-activity-logs-card .h5").text("0");

        // Safely loop through the response data
        data.forEach(item => {
          if (!item.activity_type || item.count == null) return; // skip incomplete data

          const activity = item.activity_type.trim();
          const count = parseInt(item.count, 10) || 0;

          // Use case-insensitive selector to avoid mismatch
          const card = $(`.advanced-activity-logs-card[data-activity="${activity}"]`);

          if (card.length) {
            card.find(".h5").text(count.toLocaleString());
          } else {
            console.warn(`No card found for activity: "${activity}"`);
          }
        });
      } else {
        // showNotification('error', json_result.message || "Failed to load dashboard data");
      }
    } catch (err) {
      console.error("Failed to parse response:", err);
    //   showNotification('error', "Error processing server response");
    }
  },
  error: function (xhr, status, error) {
    console.error("AJAX error:", error);
    // showNotification('error', "Network error while loading dashboard data");
  }
});


$(document).off('click', '.advanced-activity-logs-card').on('click', '.advanced-activity-logs-card', function (e) {
  e.preventDefault();

  const activityName = $(this).data('activity'); // e.g. "New User Added"
  const newDateStart = $('#startdate').val();
  const newDateEnd = $('#enddate').val();

  // Map activity names to log_type
  const activityMap = {
    "New Transaction Added": "Add Transaction",
    "New Parcel Added": "Add Parcel",
    "Parcel Update": "Update Parcel",
    "Transaction Update": "Upate Transaction",
    "New Plotting Created": "Plot Parcel",
    "User Update": "Upate User",
    "New User Added": "Add User",
    "Parcel Deleted": "Delete Parcel"
  };

  const logType = activityMap[activityName] || activityName;
  const title = `ACTIVITY SUMMARY OF ${activityName} - BETWEEN ${newDateStart} AND ${newDateEnd}`.toUpperCase();
  document.getElementById('audit_title').innerHTML = title;

  // Show modal
  $('#activityLogsModal').modal('show');

  // Reset table
  $('#activityLogsTable').DataTable().clear().destroy();

  // AJAX request
  $.ajax({
    type: "POST",
    url: "audit_reporting",
    data: {
      request_type: "get_advanced_activity_logs_summary_by_type",
      start_date_ar: startDate,
      end_date_ar: endDate,
      p_log_type: logType
    },
    cache: false,
    success: function (response) {
      try {
        const json_result = typeof response === "string" ? JSON.parse(response) : response;
        // console.log("✅ Parsed Response:", json_result);

        if (!json_result.data || json_result.data.length === 0) {
          alert("⚠️ No records found within the selected date range. Please check back later.");
          return;
        }

        // Prepare DataTable data
        const dataSet = json_result.data.map((row, index) => {
          const actionBtn = `
            <a href="javascript:void(0)"
               data-id="${row.user_id}"
               data-actv="${activityName}"
               data-name_full="${row.user_name}"
               data-logt="${logType}"
               id="view_activities_By_usser"
               class="btn btn-sm btn-secondary">
               <i class="fa fa-cogs"></i> More Details
            </a>`;

          return [
            row.user_name || 'N/A',
            row.division || 'N/A',
            row.designation || 'N/A',
            row.department || 'N/A',
            row.region || 'N/A',
            row.total || 0,
            actionBtn
          ];
        });

        // Initialize DataTable
        $('#activityLogsTable').DataTable({
          data: dataSet,
          columns: [
            { title: "User" },
            { title: "Division" },
            { title: "Designation" },
            { title: "Department" },
            { title: "Region" },
            { title: "Total" },
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
              filename: `Activity_Summary_${activityName}_${newDateStart}_to_${newDateEnd}`
            },
            {
              extend: 'excel',
              title: title,
              filename: `Activity_Summary_${activityName}_${newDateStart}_to_${newDateEnd}`
            },
            {
              extend: 'pdf',
              title: title,
              filename: `Activity_Summary_${activityName}_${newDateStart}_to_${newDateEnd}`
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

      } catch (err) {
        console.error("Failed to parse response:", err);
        alert("Error processing server response. Please check console for details.");
      }
    },
    error: function (xhr, status, error) {
      console.error("AJAX Error:", error);
      alert("An error occurred while loading activity logs. Please try again later.");
    }
  });
});




$(document).off('click', '#view_activities_By_usser').on('click', '#view_activities_By_usser', function (e) {
  e.preventDefault();

  const userid = $(this).data('id');
  const officername = $(this).data('name_full');
  const log_type = $(this).data('logt');
  const actname = $(this).data('actv');
    const newDateStart = $('#startdate').val();
  const newDateEnd = $('#enddate').val();

  const title = `Activity Summary OF ${actname} by ${officername} - BETWEEN ${newDateStart} AND ${newDateEnd}`.toUpperCase();
  document.getElementById('user_audit_title').innerHTML = title;

//   console.log(officername, userid);

  $("#USERactivityLogsModal").modal("show");

  $('#useractivityLogsTable').DataTable().clear().destroy();

  $.ajax({
    type: "POST",
    url: "audit_reporting",
    data: {
      request_type: "get_advanced_activity_logs_summary_by_type_by_userid",
      start_date_ar: startDate,
      end_date_ar: endDate,
      p_user_id: userid,
      p_log_type: log_type
    },
    cache: false,
    success: function (response) {
      const json_result = typeof response === "string" ? JSON.parse(response) : response;
    //   console.log(json_result);

      if (!json_result.data || json_result.data.length === 0) {
        alert("⚠️ No records found within the selected date range.");
        return;
      }

      let dataSet11 = [];

      json_result.data.forEach(item => {
        const description = item.description;
        const t_date = item.t_date;

        const action = `
          <a href="javascript:void(0)"
             data-id='${item.sal_id}'
             data-original-data='${JSON.stringify(item.original_data)}'
             data-changes-requested='${JSON.stringify(item.changes_requested)}'
             data-log-date='${item.log_date}'
             data-log-type='${log_type}'
             data-actname='${actname}'
             data-ofname='${officername}'
             class="btn btn-secondary btn-sm view-activity-details">
             <i class="fa fa-cogs"></i> More details
          </a>`;

        dataSet11.push([description, t_date, action]);
      });

      $('#useractivityLogsTable').DataTable({
        data: dataSet11,
        columns: [
          { title: "Description" },
          { title: "Transaction Date" },
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
            filename: `Activity_Summary_${officername}_${newDateStart}_to_${newDateEnd}`
          },
          {
            extend: 'excel',
            title: title,
            filename: `Activity_Summary_${officername}_${newDateStart}_to_${newDateEnd}`
          },
          {
            extend: 'pdf',
            title: title,
            filename: `Activity_Summary_${officername}_${newDateStart}_to_${newDateEnd}`
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
                  </p>
                `)
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
      console.error("AJAX error:", error);
      alert("An error occurred while loading user activity logs. Please try again later.");
    }
  });
});




function safeJsonParse(str) {
    try {
        // Only parse if str is a non-empty string and looks like JSON
        if (!str || str === "N/A") return null;
        return JSON.parse(str);
    } catch (err) {
        console.warn("Invalid JSON:", str);
        return null;
    }
}

$(document).off('click', '.view-activity-details').on('click', '.view-activity-details', function (e) {                  

// $(document).on('click', '.view-activity-details', function (e) {
    e.preventDefault();
    const p_sal_id = $(this).data('id');
    const logtype = $(this).data('log-type');
     const act_name = $(this).data('actname');
      const officer_name = $(this).data('ofname');



    // console.log(act_name,officer_name);

       
         

    // console.log(logtype,p_sal_id);


  const title = `${act_name} by ${officer_name}`.toUpperCase();
  document.getElementById('t_audit_title').innerHTML = title;
  document.getElementById('t_audit_title1').innerHTML = title;
    document.getElementById('t_audit_title_update_parcel').innerHTML = title;
   document.getElementById('t_audit_title_update_transaction').innerHTML = title;
   document.getElementById('t_audit_title_delete_transaction').innerHTML = title;
   




    $.ajax({
        type: "POST",
        url: "audit_reporting",
        data: {
            request_type: "get_advanced_activity_logs_summary_by_type_by_activity_id",
            start_date_ar: startDate,
            end_date_ar: endDate,
            p_sal_id: p_sal_id
        },
        cache: false,
        success: function (response) {
            try {
                const json_result = typeof response === "string" ? JSON.parse(response) : response;

                if (json_result.success && json_result.data && json_result.data.length > 0) {
                    const record = json_result.data[0];
                    const logDate = record.log_date;

                    const originalDataObj = safeJsonParse(record.original_data); // null for new records
                    const changesObj = safeJsonParse(record.changes_requested);


                    if (logtype === 'Add Transaction') {
                        AddTransactionDisplayActivityDetails(originalDataObj, changesObj, logDate);
                    }else if(logtype === 'Add Parcel'){
                      AddParcelDisplayActivityDetails(originalDataObj, changesObj, logDate);

                    }else if(logtype === 'Upate Transaction'){
                      addTransactionDetails(originalDataObj, changesObj, logDate);
                
                     }
                     else if(logtype === 'Upate User'){
                      addTransactionDetails(originalDataObj, changesObj, logDate);
                
                     }                     
                     else if(logtype === 'Add User'){
                      AddUserActivityDetails(originalDataObj, changesObj, logDate);
                
                     } 
                     else if(logtype === 'Plot Parcel'){
                      AddParcelDisplayActivityDetails(originalDataObj, changesObj, logDate);
                    } 
                    else if(logtype === 'Delete Parcel'){
                      deleteTransactionDetails(originalDataObj, changesObj, logDate);
                    }
                    else {
                        displayActivityDetails(originalDataObj, changesObj, logDate);
                    }
                } else {
                    // showNotification('error', json_result.message || "No data found.");
                }
            } catch (err) {
                console.error("Parse error:", err);
                // showNotification('error', "Error processing record details.");
            }
        },
        error: function (xhr, status, error) {
            console.error("AJAX Error:", error);
            // showNotification('error', "Network error while fetching details.");
        }
    });
});




// function displayActivityDetails(originalData, changesData, logDate) {
//   $('#activityDetailsModal').modal('show');

//   $('#logDateDisplay').text(new Date(logDate).toLocaleString());

//   $('#originalData').text(
//     originalData ? JSON.stringify(originalData, null, 2) : "No original data available"
//   );
//   $('#changesRequested').text(
//     changesData ? JSON.stringify(changesData, null, 2) : "No changes data available"
//   );

//   // ✅ Draw polygon only if valid geometry exists
//   const wkt = changesData?.wkt_polgon || originalData?.data?.geom?.coordinates;
//   if (wkt) {
//     drawPolygonOnMap(originalData?.data?.geom, changesData?.wkt_polgon);
//   } else {
//     console.log("No valid polygon data found.");
//   }
// }



let activityMap = null;
let addParcelActivityMap = null;
let overlayControl = null; // Keep track of polygon toggle control

function initializeMap(containerId) {
    const baseLayers = {
        "OpenStreet Map": L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }),
        "Google Satellite": L.tileLayer('https://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}', {
            maxZoom: 20,
            subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
            attribution: '© Google Maps'
        })
    };

    let mapInstance;
    if (containerId === 'activityMap' && !activityMap) {
        activityMap = L.map(containerId, {
            center: [5.55, -0.2],
            zoom: 13,
            layers: [baseLayers["OpenStreet Map"]]
        });
        mapInstance = activityMap;
    } else if (containerId === 'addParcelActivityMap' && !addParcelActivityMap) {
        addParcelActivityMap = L.map(containerId, {
            center: [5.55, -0.2],
            zoom: 13,
            layers: [baseLayers["OpenStreet Map"]]
        });
        mapInstance = addParcelActivityMap;
    } else {
        mapInstance = (containerId === 'activityMap') ? activityMap : addParcelActivityMap;
    }

    // Base layer control (only once)
    if (!mapInstance._hasBaseLayerControl) {
        L.control.layers(baseLayers, {}, { position: 'topright', collapsed: true }).addTo(mapInstance);
        mapInstance._hasBaseLayerControl = true;
    }

    return mapInstance;
}

function convertToLatLng(x, y, crs) {
    if (!crs || crs.properties?.name?.includes('4326')) return [y, x];
    return [y, x];
}

function parseWKT(wkt) {
    if (!wkt || !wkt.startsWith("POLYGON")) return null;
    return wkt
        .replace("POLYGON((", "")
        .replace("))", "")
        .trim()
        .split(",")
        .map(pair => pair.trim().split(" ").map(Number));
}

function drawPolygonOnMap(geomObj, wktPolygon, containerId = 'activityMap') {
    const map = initializeMap(containerId);

    // Remove previous polygons
    map.eachLayer(layer => {
        if (layer instanceof L.Polygon) map.removeLayer(layer);
    });

    // Remove old overlay control
    if (overlayControl) {
        overlayControl.remove();
        overlayControl = null;
    }

    let bounds = [];
    const overlayLayers = {};

    // Original polygon
    if (geomObj?.coordinates) {
        const coords = geomObj.coordinates[0].map(([x, y]) => {
            const latLng = convertToLatLng(x, y, geomObj.crs);
            bounds.push(latLng);
            return latLng;
        });

        const originalLayer = L.polygon(coords, {
            color: 'blue',
            weight: 3,
            fillColor: 'blue',
            fillOpacity: 0.2,
            opacity: 0.8
        }).bindPopup('Original Plotting');

        originalLayer.addTo(map);
        overlayLayers["Original Plotting"] = originalLayer;
    }

    // Updated polygon
    if (wktPolygon) {
        const wktCoords = parseWKT(wktPolygon);
        if (wktCoords?.length) {
            const latLngs = wktCoords.map(([x, y]) => {
                const latLng = convertToLatLng(x, y, geomObj?.crs);
                bounds.push(latLng);
                return latLng;
            });

            const updatedLayer = L.polygon(latLngs, {
                color: 'red',
                weight: 3,
                fillColor: 'red',
                fillOpacity: 0.2,
                opacity: 0.8,
                dashArray: '5,5'
            }).bindPopup('New Parcel');

            updatedLayer.addTo(map);
            overlayLayers["Current Plotting"] = updatedLayer;
        }
    }

    // Add overlay control only once
    if (Object.keys(overlayLayers).length > 0) {
        overlayControl = L.control.layers(null, overlayLayers, { position: 'topright', collapsed: false });
        overlayControl.addTo(map);
    }

    if (bounds.length > 0) map.fitBounds(bounds);
    else map.setView([5.55, -0.2], 13);
}


// function displayActivityDetails(originalData, changesData, logDate) {
//     // Update modal content
//     $('#logDateDisplay').text(new Date(logDate).toLocaleString());
    
//     // Format JSON for better display
//     $('#originalData').html(syntaxHighlight(JSON.stringify(originalData, null, 2)));
//     $('#changesRequested').html(syntaxHighlight(JSON.stringify(changesData, null, 2)));
    
//     // Update map status
//     $('#mapStatus').html('<i class="fas fa-map-marker-alt"></i> Drawing polygons...');
    
//     // Show modal first to ensure map container is visible
//     $('#activityDetailsModal').modal('show');
    
//     // Small delay to ensure modal is fully visible before drawing map
//     setTimeout(() => {
//         drawPolygonOnMap(originalData.data?.geom, changesData?.wkt_polgon);
//         $('#mapStatus').html('<i class="fas fa-check text-success"></i> Map loaded successfully');
//     }, 500);
// }

function displayActivityDetails(originalData, changesData, logDate) {
    // Update modal content
    $('#logDateDisplay').text(new Date(logDate).toLocaleString());
    
    // Display data in professional format instead of raw JSON
    $('#originalData').html(createProfessionalOriginalDisplay(originalData));
    $('#changesRequested').html(createProfessionalChangesDisplay(changesData, originalData));
    
    // Update map status
    $('#mapStatus').html('<i class="fas fa-map-marker-alt"></i> Drawing polygons...');
    
    // Show modal first to ensure map container is visible
    $('#activityDetailsModal').modal('show');
    
    // Small delay to ensure modal is fully visible before drawing map
    setTimeout(() => {
        drawPolygonOnMap(originalData.data?.geom, changesData?.wkt_polgon);
        $('#mapStatus').html('<i class="fas fa-check text-success"></i> Map loaded successfully');
    }, 500);
}




function addTransactionDetails(originalData, changesData, logDate) {
    // Update modal content
    $('#logDateDisplay_3').text(new Date(logDate).toLocaleString());
    
  
    // Display data in professional format instead of raw JSON
    $('#UpdateTransactionoriginalData').html(updateTransactionOriginalDisplay(originalData));
    $('#UpdateTransactionchangesRequested').html(updateTransactionChangesDisplay(changesData, originalData));
    
    
    // Show modal first to ensure map container is visible
    $('#transactionUpdateModal').modal('show');

}




function deleteTransactionDetails(originalData, changesData, logDate) {
    // Update modal content
    $('#logDateDisplay_4').text(new Date(logDate).toLocaleString());
    
  
    // Display data in professional format instead of raw JSON
    // $('#UpdateTransactionoriginalData').html(deleteTransactionOriginalDisplay(originalData));
    $('#deleteTransactionoriginalData').html(deleteTransactionChangesDisplay(changesData, originalData));
    
    
    // Show modal first to ensure map container is visible
    $('#transactionDeleteModal').modal('show');

}









function createProfessionalOriginalDisplay(originalData) {
    if (!originalData?.data) return '<div class="text-center text-muted p-4">No original data available</div>';
    
    const data = originalData.data;
    
    return `
        <div class="professional-data-view">
            <!-- Header -->
            <div class="data-header bg-primary text-white p-3 rounded-top">
                <div class="d-flex align-items-center">
                    <i class="fas fa-database fa-lg mr-2"></i>
                    <div>
                        <h6 class="mb-0 font-weight-bold">ORIGINAL PROPERTY RECORD</h6>
                        <small>System snapshot before changes</small>
                    </div>
                </div>
            </div>
            
            <!-- Property Details -->
            <div class="data-section p-3 border-bottom">
                <h6 class="section-title text-primary mb-3">
                    <i class="fas fa-map-pin mr-2"></i>Property Identification
                </h6>
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">FID</label>
                        <div class="value-display">${data.fid || '<span class="text-muted">Not set</span>'}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Parcel Identifier</label>
                        <div class="value-display">${data.parcel_identifier || '<span class="text-muted">Not assigned</span>'}</div>
                    </div>
                </div>
            </div>
            
            <!-- Location Information -->
            <div class="data-section p-3 border-bottom">
                <h6 class="section-title text-primary mb-3">
                    <i class="fas fa-location-arrow mr-2"></i>Location Details
                </h6>
                <div class="row">
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">District</label>
                        <div class="value-display">${formatValue(data.district)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Region</label>
                        <div class="value-display">${formatValue(data.region)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Block</label>
                        <div class="value-display">${formatValue(data.block)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Section</label>
                        <div class="value-display">${formatValue(data.section)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Registry Map</label>
                        <div class="value-display">${formatValue(data.registry_map_number)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Multiple Claim</label>
                        <div class="value-display">
                            ${data.mul_claim === 'Y' ? 
                                '<span class="badge badge-warning">Yes</span>' : 
                                '<span class="badge badge-secondary">No</span>'}
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Plotting Information -->
            <div class="data-section p-3 border-bottom">
                <h6 class="section-title text-primary mb-3">
                    <i class="fas fa-drafting-compass mr-2"></i>Plotting Information
                </h6>
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Plotted By</label>
                        <div class="value-display">${formatValue(data.plotted_by)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Date Plotted</label>
                        <div class="value-display">${formatDate(data.date_plott)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Checked By</label>
                        <div class="value-display">${formatValue(data.checked_by)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Plotting Type</label>
                        <div class="value-display">${formatValue(data.type_of_plotting)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Acreage</label>
                        <div class="value-display">${formatValue(data.acreage)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Status</label>
                        <div class="value-display">
                            ${data.status ? 
                                `<span class="badge badge-info">${data.status}</span>` : 
                                '<span class="text-muted">Not set</span>'}
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- System Information -->
            <div class="data-section p-3">
                <h6 class="section-title text-primary mb-3">
                    <i class="fas fa-info-circle mr-2"></i>System Information
                </h6>
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Created Date</label>
                        <div class="value-display">${formatDate(data.created_date)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Created By</label>
                        <div class="value-display">${formatValue(data.created_by)}</div>
                    </div>
                </div>
            </div>
        </div>
    `;
}





function createProfessionalChangesDisplay(changesData, originalData) {
    if (!changesData) return '<div class="text-center text-muted p-4">No change data available</div>';
    
    const originalLocality = originalData?.data?.locality;
    const changesLocality = changesData.locality;
    
    return `
        <div class="professional-data-view">
            <!-- Header -->
            <div class="data-header bg-warning text-dark p-3 rounded-top">
                <div class="d-flex align-items-center">
                    <i class="fas fa-edit fa-lg mr-2"></i>
                    <div>
                        <h6 class="mb-0 font-weight-bold">MODIFICATIONS MADE</h6>
                        <small>Modifications submitted for approval</small>
                    </div>
                </div>
            </div>
            
            <!-- Change Initiator -->
            <div class="data-section p-3 border-bottom">
                <h6 class="section-title text-warning mb-3">
                    <i class="fas fa-user-edit mr-2"></i>Change Initiator
                </h6>
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Officer Name</label>
                        <div class="value-display font-weight-bold text-dark">${changesData.fullname || 'Unknown'}</div>
                    </div>
                   
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">IP Address</label>
                        <div class="value-display">
                            <span class="badge badge-light border">${changesData.ip_address || 'N/A'}</span>
                        </div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Certificate Number</label>
                        <div class="value-display">${formatValue(changesData.certificate_number)}</div>
                    </div>
                </div>
            </div>
            
            <!-- Property Changes -->
            <div class="data-section p-3 border-bottom">
                <h6 class="section-title text-warning mb-3">
                    <i class="fas fa-sync-alt mr-2"></i>Property Modifications
                </h6>
                
                <!-- Locality Change -->
                <div class="change-item mb-3 p-2 bg-light rounded">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <label class="text-muted small mb-1">Locality</label>
                            <div class="change-comparison">
                                <span class="original-value">${formatValue(originalLocality)}</span>
                                <i class="fas fa-arrow-right mx-2 text-muted"></i>
                                <span class="new-value font-weight-bold text-success">${formatValue(changesLocality)}</span>
                            </div>
                        </div>
                        ${originalLocality !== changesLocality ? 
                            '<span class="badge badge-success ml-2">CHANGED</span>' : 
                            '<span class="badge badge-secondary ml-2">UNCHANGED</span>'}
                    </div>
                </div>
                
                <!-- Remarks -->
                ${changesData.remarks ? `
                <div class="change-item mb-3">
                    <label class="text-muted small mb-1">Remarks</label>
                    <div class="remarks-box p-2 bg-info text-white rounded">
                        <i class="fas fa-comment-dots mr-2"></i>
                        ${changesData.remarks}
                    </div>
                </div>
                ` : ''}
                
                
                    </div>
                </div>
            </div>
            
            <!-- Technical Details -->
            <div class="data-section p-3">
                <h6 class="section-title text-warning mb-3">
                    <i class="fas fa-cogs mr-2"></i>Technical Information
                </h6>
                <div class="row">
                    <div class="col-12 mb-2">
                        <label class="text-muted small mb-1">WKT Polygon</label>
                        <div class="technical-display p-2 bg-dark text-light rounded small font-monospace">
                            ${changesData.wkt_polgon ? 
                                changesData.wkt_polgon.substring(0, 80) + '...' : 
                                'No spatial data provided'}
                        </div>
                    </div>
                    <div class="col-12">
                        <label class="text-muted small mb-1">MAC Address</label>
                        <div class="value-display">${formatValue(changesData.mac_address)}</div>
                    </div>
                </div>
            </div>
        </div>
    `;
}



function updateTransactionOriginalDisplay(originalData) {
    if (!originalData?.data) return '<div class="text-center text-muted p-4">No original data available</div>';
    
    const data = originalData.data;
    
    return `
        <div class="professional-data-view">
            <!-- Header -->
            <div class="data-header bg-primary text-white p-3 rounded-top">
                <div class="d-flex align-items-center">
                    <i class="fas fa-database fa-lg mr-2"></i>
                    <div>
                        <h6 class="mb-0 font-weight-bold">ORIGINAL PROPERTY RECORD</h6>
                        <small>System snapshot before changes</small>
                    </div>
                </div>
            </div>
            
            <!-- Property Details -->
            <div class="data-section p-3 border-bottom">
                <h6 class="section-title text-primary mb-3">
                    <i class="fas fa-map-pin mr-2"></i>Property Identification
                </h6>
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">FID</label>
                        <div class="value-display">${data.fid || '<span class="text-muted">Not set</span>'}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Parcel Identifier</label>
                        <div class="value-display">${data.parcel_identifier || '<span class="text-muted">Not assigned</span>'}</div>
                    </div>
                </div>
            </div>
            
            <!-- Location Information -->
            <div class="data-section p-3 border-bottom">
                <h6 class="section-title text-primary mb-3">
                    <i class="fas fa-location-arrow mr-2"></i>Location Details
                </h6>
                <div class="row">
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">District</label>
                        <div class="value-display">${formatValue(data.district)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Region</label>
                        <div class="value-display">${formatValue(data.region)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Block</label>
                        <div class="value-display">${formatValue(data.block)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Section</label>
                        <div class="value-display">${formatValue(data.section)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Registry Map</label>
                        <div class="value-display">${formatValue(data.registry_map_number)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Multiple Claim</label>
                        <div class="value-display">
                            ${data.mul_claim === 'Y' ? 
                                '<span class="badge badge-warning">Yes</span>' : 
                                '<span class="badge badge-secondary">No</span>'}
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Plotting Information -->
            <div class="data-section p-3 border-bottom">
                <h6 class="section-title text-primary mb-3">
                    <i class="fas fa-drafting-compass mr-2"></i>Plotting Information
                </h6>
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Plotted By</label>
                        <div class="value-display">${formatValue(data.plotted_by)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Date Plotted</label>
                        <div class="value-display">${formatDate(data.date_plott)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Checked By</label>
                        <div class="value-display">${formatValue(data.checked_by)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Plotting Type</label>
                        <div class="value-display">${formatValue(data.type_of_plotting)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Acreage</label>
                        <div class="value-display">${formatValue(data.acreage)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Status</label>
                        <div class="value-display">
                            ${data.status ? 
                                `<span class="badge badge-info">${data.status}</span>` : 
                                '<span class="text-muted">Not set</span>'}
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- System Information -->
            <div class="data-section p-3">
                <h6 class="section-title text-primary mb-3">
                    <i class="fas fa-info-circle mr-2"></i>System Information
                </h6>
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Created Date</label>
                        <div class="value-display">${formatDate(data.created_date)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Created By</label>
                        <div class="value-display">${formatValue(data.created_by)}</div>
                    </div>
                </div>
            </div>
        </div>
    `;
}









function deleteTransactionOriginalDisplay(originalData) {
    if (!originalData?.data) return '<div class="text-center text-muted p-4">No original data available</div>';
    
    const data = originalData.data;
    
    return `
        <div class="professional-data-view">
            <!-- Header -->
            <div class="data-header bg-primary text-white p-3 rounded-top">
                <div class="d-flex align-items-center">
                    <i class="fas fa-database fa-lg mr-2"></i>
                    <div>
                        <h6 class="mb-0 font-weight-bold">ORIGINAL PROPERTY RECORD</h6>
                        <small>System snapshot before changes</small>
                    </div>
                </div>
            </div>
            
            <!-- Property Details -->
            <div class="data-section p-3 border-bottom">
                <h6 class="section-title text-primary mb-3">
                    <i class="fas fa-map-pin mr-2"></i>Property Identification
                </h6>
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">FID</label>
                        <div class="value-display">${data.fid || '<span class="text-muted">Not set</span>'}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Parcel Identifier</label>
                        <div class="value-display">${data.parcel_identifier || '<span class="text-muted">Not assigned</span>'}</div>
                    </div>
                </div>
            </div>
            
            <!-- Location Information -->
            <div class="data-section p-3 border-bottom">
                <h6 class="section-title text-primary mb-3">
                    <i class="fas fa-location-arrow mr-2"></i>Location Details
                </h6>
                <div class="row">
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">District</label>
                        <div class="value-display">${formatValue(data.district)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Region</label>
                        <div class="value-display">${formatValue(data.region)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Block</label>
                        <div class="value-display">${formatValue(data.block)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Section</label>
                        <div class="value-display">${formatValue(data.section)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Registry Map</label>
                        <div class="value-display">${formatValue(data.registry_map_number)}</div>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="text-muted small mb-1">Multiple Claim</label>
                        <div class="value-display">
                            ${data.mul_claim === 'Y' ? 
                                '<span class="badge badge-warning">Yes</span>' : 
                                '<span class="badge badge-secondary">No</span>'}
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Plotting Information -->
            <div class="data-section p-3 border-bottom">
                <h6 class="section-title text-primary mb-3">
                    <i class="fas fa-drafting-compass mr-2"></i>Plotting Information
                </h6>
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Plotted By</label>
                        <div class="value-display">${formatValue(data.plotted_by)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Date Plotted</label>
                        <div class="value-display">${formatDate(data.date_plott)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Checked By</label>
                        <div class="value-display">${formatValue(data.checked_by)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Plotting Type</label>
                        <div class="value-display">${formatValue(data.type_of_plotting)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Acreage</label>
                        <div class="value-display">${formatValue(data.acreage)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Status</label>
                        <div class="value-display">
                            ${data.status ? 
                                `<span class="badge badge-info">${data.status}</span>` : 
                                '<span class="text-muted">Not set</span>'}
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- System Information -->
            <div class="data-section p-3">
                <h6 class="section-title text-primary mb-3">
                    <i class="fas fa-info-circle mr-2"></i>System Information
                </h6>
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Created Date</label>
                        <div class="value-display">${formatDate(data.created_date)}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Created By</label>
                        <div class="value-display">${formatValue(data.created_by)}</div>
                    </div>
                </div>
            </div>
        </div>
    `;
}




// // Format readable field labels
// function formatLabel(key) {
//   return key
//     .replace(/_/g, " ")
//     .replace(/([a-z])([A-Z])/g, "$1 $2")
//     .replace(/\b\w/g, c => c.toUpperCase());
// }

// // Generate Original Data HTML (left side)
// function updateTransactionOriginalDisplay(originalData) {
//   const data = originalData?.data || {};
//   let html = `<div class="row">`;

//   Object.entries(data).forEach(([key, value]) => {
//     html += `
//       <div class="col-md-6 mb-2">
//         <div class="p-2 border-start border-primary border-4 bg-light bg-opacity-25 rounded">
//           <label class="text-primary small mb-1 text-capitalize">${formatLabel(key)}</label>
//           <div class="fw-bold text-dark">${value ?? 'N/A'}</div>
//         </div>
//       </div>
//     `;
//   });

//   html += `</div>`;
//   return html;
// }

// Generate Changes Data HTML (right side)
// Fields you want to hide
const HIDDEN_FIELDS = [
  'gid', 'userid','password','web_pass','old_web_pass',
  'modified_by_id' ,'created_by_id' , 'entered_by_id',
  't_id'
  
];

// Helper to format labels
function formatLabel(key) {
  return key
    .replace(/_/g, " ")
    .replace(/([a-z])([A-Z])/g, "$1 $2")
    .replace(/\b\w/g, c => c.toUpperCase());
}

// Original Data
// Original Data Display
function updateTransactionOriginalDisplay(originalData) {
  const originalItems = normalizeData(originalData?.data);
  if (!originalItems.length) return '<div class="text-center text-muted p-4">No original data available</div>';

  let html = '';
  originalItems.forEach(item => {
    html += `<div class="row mb-3">`;
    Object.entries(item).forEach(([key, value]) => {
      if (HIDDEN_FIELDS.includes(key)) return; // Skip hidden fields
      html += `
        <div class="col-md-6 mb-2">
          <div class="p-2 border-start border-primary border-4 bg-light bg-opacity-25 rounded">
            <label class="text-primary small mb-1 text-capitalize">${formatLabel(key)}</label>
            <div class="fw-bold text-dark">${value != null ? value : 'N/A'}</div>
          </div>
        </div>
      `;
    });
    html += `</div>`;
  });

  return html;
}



function normalizeData(data) {
  if (!data) return [];
  
  // If it’s a string (JSON inside a string), parse it
  if (typeof data === 'string') {
    try {
      data = JSON.parse(data);
    } catch (e) {
      console.error("Failed to parse JSON string", e);
      return [];
    }
  }

  // Return array
  if (Array.isArray(data)) return data;
  if (data && typeof data === 'object') return [data];
  return [];
}



function updateTransactionChangesDisplay(changesData, originalData) {
  const originalItems = normalizeData(originalData?.data);
  const changesItems = normalizeData(changesData);
  if (!changesItems.length) return '<div class="text-center text-muted p-4">No change data available</div>';

  let html = '';
  changesItems.forEach((changes, index) => {
    const original = originalItems[index] || originalItems[0] || {};
    const allKeys = new Set([...Object.keys(original), ...Object.keys(changes)]);

    html += `<div class="row mb-3">`;

    allKeys.forEach(key => {
      if (HIDDEN_FIELDS.includes(key)) return;

      const originalVal = original[key];
      const changedVal = changes[key];

      // Normalize for comparison
      const originalStr = originalVal != null ? String(originalVal).trim() : '';
      const changedStr = changedVal != null ? String(changedVal).trim() : '';

      let highlightClass = '';
      let labelColor = 'text-muted';
      let displayValue = changedVal ?? originalVal ?? 'N/A';


      if (originalStr === '' && changedStr !== '') {
  highlightClass = "bg-success bg-opacity-25 border-start border-success border-4"; // 🟩 new
  labelColor = "text-success fw-bold"; // make label bold and more visible
} else if (changedStr === '' && originalStr !== '') {
  highlightClass = "bg-light border-start border-secondary border-4"; // ⬜ removed
  labelColor = "text-dark fw-bold"; // use darker text for visibility
} else if (originalStr !== changedStr) {
  highlightClass = "bg-warning bg-opacity-25 border-start border-warning border-4"; // 🟨 changed
  labelColor = "text-dark fw-bold"; // switch from text-warning (too light) to text-dark
   displayValue = `${originalStr || 'N/A'} → ${changedStr || 'N/A'}`;

}

    //   if (originalStr === '' && changedStr !== '') {
    //     highlightClass = "bg-success bg-opacity-25 border-start border-success border-4"; // 🟩 new
    //     labelColor = "text-success";
    //   } else if (changedStr === '' && originalStr !== '') {
    //     highlightClass = "bg-light border-start border-secondary border-4"; // ⬜ removed
    //     labelColor = "text-secondary";
    //   } else if (originalStr !== changedStr) {
    //     highlightClass = "bg-warning bg-opacity-25 border-start border-warning border-4"; // 🟨 changed
    //     labelColor = "text-warning";
    //     displayValue = `${originalStr || 'N/A'} → ${changedStr || 'N/A'}`;
    //   }
      html += `
  <div class="col-md-6 mb-2">
    <div class="p-2 rounded ${highlightClass}">
      <label class="${labelColor} small mb-1 text-capitalize">
        ${formatLabel(key) || key}
      </label>
      <div class="fw-bold">${displayValue || 'N/A'}</div>
    </div>
  </div>
`;
    });

    html += `</div>`;
  });

  return html;
}



function deleteTransactionChangesDisplay(changesData, originalData) {
  const originalItems = normalizeData(originalData?.data);
  const changesItems = normalizeData(changesData);

//   console.log(originalItems);

  if (!changesItems.length) return '<div class="text-center text-muted p-4">No change data available</div>';

  let html = '';
  changesItems.forEach((changes, index) => {
    const original = originalItems[index] || originalItems[0] || {};
    const allKeys = new Set([...Object.keys(original), ...Object.keys(changes)]);

    html += `<div class="row mb-3">`;

    allKeys.forEach(key => {
      if (HIDDEN_FIELDS.includes(key)) return;

      const originalVal = original[key];
      const changedVal = changes[key];

      // Normalize for comparison
      const originalStr = originalVal != null ? String(originalVal).trim() : '';
      const changedStr = changedVal != null ? String(changedVal).trim() : '';

      let highlightClass = '';
      let labelColor = 'text-muted';
      let displayValue = changedVal ?? originalVal ?? 'N/A';

      if (originalStr === '' && changedStr !== '') {
        highlightClass = "bg-success bg-opacity-25 border-start border-success border-4"; // 🟩 new
        labelColor = "text-success";
      } else if (changedStr === '' && originalStr !== '') {
        highlightClass = "bg-light border-start border-secondary border-4"; // ⬜ removed
        labelColor = "text-secondary";
      } else if (originalStr !== changedStr) {
        highlightClass = "bg-warning bg-opacity-25 border-start border-warning border-4"; // 🟨 changed
        labelColor = "text-warning";
        displayValue = `${originalStr || 'N/A'} → ${changedStr || 'N/A'}`;
      }

      html += `
        <div class="col-md-6 mb-2">
          <div class="p-2 rounded ${highlightClass}">
            <label class="${labelColor} small mb-1 text-capitalize">${formatLabel(key)}</label>
            <div class="fw-bold">${displayValue || 'N/A'}</div>
          </div>
        </div>
      `;
    });

    html += `</div>`;
  });

  return html;
}




function AddTransactionDisplayActivityDetails(originalData, changesData, logDate) {
    $('#logDateDisplay_1').text(new Date(logDate).toLocaleString());

    // For new entries, original data is null → show "N/A" or default
    $('#changesRequestedd').html(AddTransactionCreateProfessionalDisplay(changesData));

    $('#newactivityDetailsModal').modal('show');
}



function AddUserActivityDetails(originalData, changesData, logDate) {
    $('#logDateDisplay_1').text(new Date(logDate).toLocaleString());

    // For new entries, original data is null → show "N/A" or default
    $('#changesRequestedd').html(AddUserDisplay(changesData));

    $('#newactivityDetailsModal').modal('show');
}




// function AddParcelDisplayActivityDetails(originalData, changesData, logDate) {
//     $('#logDateDisplay').text(new Date(logDate).toLocaleString());

//     // For new entries, original data is null → show "N/A" or default
//     $('#AddParcelchangesRequested').html(AddParcelDetailsDisplay(changesData));

//     $('#addParcelDetailsModal').modal('show');
// }



// function AddParcelDisplayActivityDetails(originalData, changesData, logDate) {
//     // Update modal content
//     $('#logDateDisplay').text(new Date(logDate).toLocaleString());
    
//     // Display data in professional format instead of raw JSON
//     $('#AddParcelchangesRequested').html(AddParcelDetailsDisplay(changesData));
    
//     // Update map status
//     $('#mapStatus_1').html('<i class="fas fa-map-marker-alt"></i> Drawing polygons...');
    
//     // Show modal first to ensure map container is visible
//     $('#addParcelDetailsModal').modal('show');
    
//     // Small delay to ensure modal is fully visible before drawing map
//     setTimeout(() => {
//         drawPolygonOnMap(changesData?.wkt_polgon);
//         $('#mapStatus_1').html('<i class="fas fa-check text-success"></i> Map loaded successfully');
//     }, 500);
// }


function AddParcelDisplayActivityDetails(originalData, changesData, logDate) {
    $('#logDateDisplay_2').text(new Date(logDate).toLocaleString());
    $('#AddParcelchangesRequested').html(AddParcelDetailsDisplay(changesData));
    
    // Use the correct map container and status elements
    $('#addParcelMapStatus').html('<i class="fas fa-map-marker-alt"></i> Drawing polygons...');
    
    $('#addParcelDetailsModal').modal('show');
    
    setTimeout(() => {
        // Pass both parameters (originalData will be null for new parcels)
        drawPolygonOnMap(originalData?.data?.geom, changesData?.wkt_polgon, 'addParcelActivityMap');
        $('#addParcelMapStatus').html('<i class="fas fa-check text-success"></i> Map loaded successfully');
    }, 500);
}



// Refresh map when modal is shown
$('#addParcelDetailsModal').on('shown.bs.modal', function () {
    if (addParcelActivityMap) {
        setTimeout(() => {
            addParcelActivityMap.invalidateSize();
        }, 100);
    }
});

$('#activityDetailsModal').on('shown.bs.modal', function () {
    if (activityMap) {
        setTimeout(() => {
            activityMap.invalidateSize();
        }, 100);
    }
});





function AddParcelDetailsDisplay(changesData, originalData) {
    if (!changesData) {
        return '<div class="text-center text-muted p-4">No change data available</div>';
    }

    // console.log(changesData);

    const originalLocality = originalData?.data?.locality || 'N/A';
    const changesLocality = changesData.locality || 'N/A';

    return `
        <div class="professional-data-view p-3">
            <!-- Change Initiator -->
            <div class="data-section p-3 border-bottom">
                <h6 class="section-title text-warning mb-3">
                    <i class="fas fa-user-edit mr-2"></i>Officer Information
                </h6>
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Officer Name</label>
                        <div class="value-display font-weight-bold text-dark">${changesData.fullname || 'Unknown'}</div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">IP Address</label>
                        <div class="value-display">
                            <span class="badge badge-light border">${changesData.ip_address || 'N/A'}</span>
                        </div>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Certificate Number</label>
                        <div class="value-display">${formatValue(changesData.certificate_number)}</div>
                    </div>


                    <div class="col-md-6 mb-2">
                        <label class="text-muted small mb-1">Locality</label>
                        <div class="value-display">${formatValue(changesData.locality)}</div>
                    </div>

                </div>
            </div>

            <!-- Technical Details -->
            <div class="data-section p-3">
                <h6 class="section-title text-warning mb-3">
                    <i class="fas fa-cogs mr-2"></i>Technical Information
                </h6>
                <div class="row">
                    <div class="col-12 mb-2">
                        <label class="text-muted small mb-1">WKT Polygon</label>
                        <div class="technical-display p-2 bg-dark text-light rounded small font-monospace">
                            ${changesData.wkt_polgon ? 
                                changesData.wkt_polgon.substring(0, 80) + '...' : 
                                'No spatial data provided'}
                        </div>
                    </div>
                    <div class="col-12">
                        <label class="text-muted small mb-1">MAC Address</label>
                        <div class="value-display">${formatValue(changesData.macAddress)}</div>
                    </div>
                </div>
            </div>
        </div>
    `;
}






function AddTransactionCreateProfessionalDisplay(changesData) {

    // console.log(changesData);
    if (!changesData || changesData.length === 0) {
        return '<div class="text-center text-muted p-4">No data provided</div>';
    }

    return changesData.map(item => `
        <div class="professional-data-view p-3 mb-3 border rounded bg-light">
            <div class="row">
                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Reference Number</label>
                    <div class="value-display font-weight-bold">${item.reference_number || 'N/A'}</div>
                </div>
                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Regional Number</label>
                    <div class="value-display">${item.regional_number || 'N/A'}</div>
                </div>
                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Plan Number</label>
                    <div class="value-display">${item.plan_number || 'N/A'}</div>
                </div>
                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">CC Number</label>
                    <div class="value-display">${item.cc_number || 'N/A'}</div>
                </div>
                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Applicant Name</label>
                    <div class="value-display">${item.applicant_name || 'N/A'}</div>
                </div>
                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Grantor Name</label>
                    <div class="value-display">${item.grantor_name || 'N/A'}</div>
                </div>
                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Job Number</label>
                    <div class="value-display">${item.job_number || 'N/A'}</div>
                </div>
                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Officer</label>
                    <div class="value-display font-weight-bold">${item.fullname || 'N/A'}</div>
                </div>
            </div>
        </div>
    `).join('');
}



function AddUserDisplay(changesData) {

    // console.log(changesData);
    if (!changesData || changesData.length === 0) {
        return '<div class="text-center text-muted p-4">No data provided</div>';
    }

    return changesData.map(item => `
        <div class="professional-data-view p-3 mb-3 border rounded bg-light">
            <div class="row">

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Full Name</label>
                    <div class="value-display font-weight-bold">${item.fullname || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Title</label>
                    <div class="value-display">${item.title || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Division</label>
                    <div class="value-display">${item.division || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Department</label>
                    <div class="value-display">${item.department_name || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Designation</label>
                    <div class="value-display">${item.designation || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">District</label>
                    <div class="value-display">${item.district_name || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Region</label>
                    <div class="value-display">${item.region || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Address</label>
                    <div class="value-display">${item.address || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Phone</label>
                    <div class="value-display">${item.phone || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Email</label>
                    <div class="value-display">${item.emailaddress || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">User Profile</label>
                    <div class="value-display">${item.userprofile || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">IP Address</label>
                    <div class="value-display">${item.ip_address || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Can Password Expire</label>
                    <div class="value-display">${item.canpasswordexpire || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Password Changed</label>
                    <div class="value-display">${item.passwordchanged || 'N/A'}</div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Password Expiry Date</label>
                    <div class="value-display">${item.passwordexpirydate || 'N/A'}</div>
                </div>

                 <div class="col-md-6 mb-2">
                    <label class="text-muted small mb-1">Created By</label>
                    <div class="value-display">${item.created_by || 'N/A'}</div>
                </div>


                

            </div>
        </div>
    `).join('');
}


// Utility functions
function formatValue(value) {
    if (value === null || value === undefined || value === '') {
        return '<span class="text-muted font-italic">Not provided</span>';
    }
    return value;
}

function formatDate(dateString) {
    if (!dateString) return '<span class="text-muted font-italic">Not set</span>';
    try {
        return new Date(dateString).toLocaleString();
    } catch (e) {
        return dateString;
    }
}






// Function to syntax highlight JSON
function syntaxHighlight(json) {
    if (!json) return '';
    
    json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, 
    function (match) {
        let cls = 'text-dark';
        if (/^"/.test(match)) {
            if (/:$/.test(match)) {
                cls = 'text-primary'; // key
            } else {
                cls = 'text-success'; // string value
            }
        } else if (/true|false/.test(match)) {
            cls = 'text-info'; // boolean
        } else if (/null/.test(match)) {
            cls = 'text-warning'; // null
        } else if (!isNaN(match)) {
            cls = 'text-danger'; // number
        }
        return '<span class="' + cls + '">' + match + '</span>';
    });
}




// Convert projected coordinates to lat/lng
function convertToLatLng(x, y, crs) {
    // If proj4 is available, use proper transformation
    if (typeof proj4 !== 'undefined' && crs && crs.properties && crs.properties.name === 'EPSG:2136') {
        // Define EPSG:2136 projection
        proj4.defs("EPSG:2136", "+proj=tmerc +lat_0=0 +lon_0=0 +k=0.9996 +x_0=0 +y_0=0 +a=6378137 +b=6356752.3142 +units=m +no_defs");
        
        // Transform coordinates
        const result = proj4("EPSG:2136", "EPSG:4326", [x, y]);
        return [result[1], result[0]]; // [lat, lng]
    }
    
    // Fallback to simple conversion
    const lat = 5.55 + (y - 364615) / 111000;
    const lng = -0.2 + (x - 1175500) / (111000 * Math.cos(5.55 * Math.PI / 180));
    return [lat, lng];
}


// Parse WKT polygon string
function parseWKT(wktString) {
    try {
        // Extract coordinates from WKT string: POLYGON((x y, x y, ...))
        const coordString = wktString
            .replace('POLYGON((', '')
            .replace('))', '');
        
        return coordString.split(',')
            .map(pair => pair.trim().split(' ').map(Number))
            .filter(coord => coord.length === 2 && !isNaN(coord[0]) && !isNaN(coord[1]));
    } catch (e) {
        console.error('WKT parsing error:', e);
        return null;
    }
}









  }
});





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

    //  updateDisplayedDateRange();
     
});
