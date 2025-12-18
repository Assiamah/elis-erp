$(document).ready(function() {


        // Function to capture element as image
        function captureElement(element, fileName) {
            return new Promise((resolve) => {
                html2canvas(element, {
                    scale: 2, // Higher quality
                    logging: false,
                    useCORS: true,
                    allowTaint: true,
                    onclone: (clonedDoc) => {
                        // Fix any styling issues in the cloned document
                        const clonedElement = clonedDoc.getElementById(element.id);
                        if (clonedElement) {
                            clonedElement.style.boxShadow = 'none';
                            clonedElement.style.border = '1px solid #ddd';
                        }
                    }
                }).then(canvas => {
                    canvas.toBlob(blob => {
                        resolve({blob, fileName});
                    }, 'image/png');
                });
            });
        }
    
        // Download full report as images
        $('#downloadFullReport').click(async function() {
            // Show loading state
            const btn = $(this);
            btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin mr-1"></i> Preparing...');
    
            try {
                // Capture all sections
                const summaryImage = await captureElement(document.querySelector('.card.shadow-sm'), 'Report_Summary.png');
                const barChartImage = await captureElement(document.getElementById('bankChart'), 'Applications_by_Bank.png');
                const pieChartImage = await captureElement(document.getElementById('distributionChart'), 'Distribution_Chart.png');
                const tableImage = await captureElement(document.getElementById('banks_table'), 'Detailed_Report.png');
    
                // Create zip file with all images
                const zip = new JSZip();
                zip.file(summaryImage.fileName, summaryImage.blob);
                zip.file(barChartImage.fileName, barChartImage.blob);
                zip.file(pieChartImage.fileName, pieChartImage.blob);
                zip.file(tableImage.fileName, tableImage.blob);
    
                // Generate zip file
                const content = await zip.generateAsync({type: 'blob'});
                saveAs(content, 'Full_Report.zip');
    
            } catch (error) {
                console.error('Error generating report:', error);
                Swal.fire('Error', 'Failed to generate report download', 'error');
            } finally {
                btn.prop('disabled', false).html('<i class="fas fa-download mr-1"></i> Download Full Report');
            }
        });
    
        // For browsers that don't support zip downloads, offer individual downloads
        $(document).on('click', '.download-section', function() {
            const section = $(this).data('section');
            const element = document.querySelector(section === 'table' ? '#banks_table' : `#${section}`);
            const fileName = $(this).data('filename');
            
            html2canvas(element, {
                scale: 2,
                logging: false,
                useCORS: true
            }).then(canvas => {
                const link = document.createElement('a');
                link.download = fileName;
                link.href = canvas.toDataURL('image/png');
                link.click();
            });
        });
   



    $('#selchangeregioncompliance').change(function(){


        const selectedOption = this.options[this.selectedIndex];


        const surveyorName = selectedOption.getAttribute('data-name') || 'All Regions';


        upperCaseVariable = surveyorName.toUpperCase();



        console.log(surveyorName);


       $('#getRegioname').val(surveyorName);


       



    })
    

    $('#selchangebank').change(function () {
        const select = $(this);
        const selected = select.val() || [];
        const allValue = 'All';
    
        const isAllSelected = selected.includes(allValue);
        const otherSelected = selected.filter(val => val !== allValue);
    
        if (isAllSelected && otherSelected.length > 0) {
            // If All Banks selected with other banks, keep only All
            select.val([allValue]).trigger('change.select2');
        } else if (!isAllSelected && otherSelected.length > 0) {
            // If other banks selected, ensure All is removed
            select.find('option[value="' + allValue + '"]').prop('selected', false);
            select.trigger('change.select2');
        }
    
        // Update input field
        const selectedBankOptions = select.find('option:selected');
        const isAllBanksSelected = selectedBankOptions.filter(function () {
            return $(this).val() === 'All';
        }).length > 0;
    
        let bankNamesString;
    
        if (isAllBanksSelected) {
            bankNamesString = 'All Banks';
        } else {
            const selectedBankNames = selectedBankOptions.map(function () {
                return $(this).data('bankname');
            }).get();
    
            bankNamesString = selectedBankNames.join(', ');
        }
    
        $('#bankNAme').val(bankNamesString);
    });

    $('#main_service_rpt').on('change', function () {
        if ($(this).val() === '0') { // Check if 'All Services' is selected
          $('#subServ').hide(); // Hide the dropdown
        } else {
          $('#subServ').show(); // Show the dropdown
        }
      });


      $('#main_service_modal').on('show.bs.modal', function () {
        // Ensure banks_modal stays in background
        $('#banks_modal1').css('z-index', 1040); // Lower than default modal (1050)
        $(this).css('z-index', 1055); // Ensure this modal is above
      }).on('hidden.bs.modal', function () {
        // Reset z-index when closed
        $('#banks_modal1').css('z-index', '');
      });




      $('#sub_service_modal1').on('show.bs.modal', function () {
        // Ensure banks_modal stays in background
        $('#main_service_modal').css('z-index', 1040); // Lower than default modal (1050)
        $(this).css('z-index', 1055); // Ensure this modal is above
      }).on('hidden.bs.modal', function () {
        // Reset z-index when closed
        $('#main_service_modal').css('z-index', '');
      });




      $('#banks_apps_modal').on('show.bs.modal', function () {
        // Ensure banks_modal stays in background
        $('#sub_service_modal1').css('z-index', 1040); // Lower than default modal (1050)
        $(this).css('z-index', 1055); // Ensure this modal is above
      }).on('hidden.bs.modal', function () {
        // Reset z-index when closed
        $('#sub_service_modal1').css('z-index', '');
      });

      

      
      


  
    $('#sub_service_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#main_service_modal").css("z-index", "1029");
      })
      
      $('#sub_service_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#main_service_modal").css("z-index", "");
      })
  



        
    $('#banks_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#sub_service_modal").css("z-index", "1029");
      })
      
      $('#banks_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#sub_service_modal").css("z-index", "");
      })





      $('#banks_apps_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#banks_modal").css("z-index", "1029");
      })
      
      $('#banks_apps_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#banks_modal").css("z-index", "");
      })
  




      $('#cabinetModal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#banks_apps_modal").css("z-index", "1029");
      })
      
      $('#cabinetModal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#banks_apps_modal").css("z-index", "");
      })
  


      $('#banks_apps_completed_modal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#banks_modal").css("z-index", "1029");
      })
      
      $('#banks_apps_completed_modal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#banks_modal").css("z-index", "");
      })
  






      $('#cabinetModal').on('shown.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#banks_apps_completed_modal").css("z-index", "1029");
      })
      
      $('#cabinetModal').on('hidden.bs.modal', function () {
        //$('#myInput').trigger('focus')
        //$("#eventDetails").modal({backdrop: true});
        $("#banks_apps_completed_modal").css("z-index", "");
      })
  






      

      

      
      
      



    //   $("#banks_modal").modal("show");  



    //   $("#main_service_modal").modal("hide");  


    //   $("#sub_service_modal").modal("show");  



// Declare global state variables
var currentPage = 1;   // Start on the first page
var pageSize = 10;      // Show 10 items per page
var totalPages; 
var totalPage1;         // Will be calculated later based on data        // Will be calculated later based on data
var autoScrollInterval; // Variable to hold the setInterval ID

var appsatdivision1 = []
let appsatdivision = [];


   var startDate;
    var endDate;

    var startdate;
    var enddate;


// Function to change the page
function changePage(direction) {
    currentPage += direction;

    // If current page exceeds total pages, reset to page 1
    if (currentPage > totalPages) {
        currentPage = 1;
    } else if (currentPage < 1) {
        currentPage = totalPages; // Prevent going below page 1
    }

    // Update chart with new page data
    updateChart(currentPage);
}

// Function to update the chart data for the current page
function updateChart(page) {
    var startIndex = (page - 1) * pageSize;  // Calculate the start index
    var endIndex = page * pageSize;          // Calculate the end index

    var pageData = appsatdivision.slice(startIndex, endIndex); // Get data for the current page

    var bankNames = pageData.map(function(item) {
        return item.created_for || 'Unknown Bank';
    });

    var submittedData = pageData.map(function(item) {
        return item.submitted || 0;
    });

    var pendingData = pageData.map(function(item) {
        return item.pending || 0;
    });

    var completedData = pageData.map(function(item) {
        return item.completed || 0;
    });

    var queriedData = pageData.map(function(item) {
        return item.queried || 0;
    });

    // Initialize or update the chart
    var myChart_new = echarts.init(document.getElementById('barChart'));

    // Define chart options
    var option = {
        title: { text: '', left: 'center' },
        tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
        legend: { data: ['Submitted', 'Pending', 'Completed', 'Queried'], left: 'left' },
        xAxis: {
            type: 'category',
            data: bankNames,
            axisLabel: {
                rotate: 25,  // Rotate labels to prevent overlap
                interval: 0, // Show all labels (no skipping)
                fontWeight: 'bold',
                color: '#000',
                formatter: function(value) {
                    return value.length > 20 ? value.substring(0, 20) + '...' : value;
                }
            }
        },
        yAxis: { type: 'value' },
        series: [
            { name: 'Submitted', type: 'bar', data: submittedData, itemStyle: { color: '#5470C6' } },
            { name: 'Pending', type: 'bar', data: pendingData, itemStyle: { color: '#36B8CC' } },
            { name: 'Completed', type: 'bar', data: completedData, itemStyle: { color: '#1BC88A' } },
            { name: 'Queried', type: 'bar', data: queriedData, itemStyle: { color: '#E74A3A' } }
        ]
    };

    // Set the options for the chart
    myChart_new.setOption(option);

    // Update page number display
    document.getElementById('pageNum').textContent = page;
}

// Function to start auto-scroll
function startAutoScroll() {
    if (!autoScrollInterval) {
        autoScrollInterval = setInterval(function() {
            changePage(1); // Go to the next page
        }, 30000); // Change page every 30 seconds (30000 milliseconds)

        // Disable the start button while auto-scrolling
        document.getElementById('startAutoScroll').disabled = true;
        document.getElementById('stopAutoScroll').disabled = false;
    }
}

// Function to stop auto-scroll
function stopAutoScroll() {
    clearInterval(autoScrollInterval);
    autoScrollInterval = null;

    // Enable the start button again
    document.getElementById('startAutoScroll').disabled = false;
    document.getElementById('stopAutoScroll').disabled = true;
}

// AJAX Call to Fetch Data
window.onload = function() {
    $.ajax({
        type: "POST",
        url: "corporate_applications",
        data: {
            request_type: 'corporate_dashboard_two_all_barchart',
            date_from: startDate,
            date_to: endDate
        },
        cache: false,
        success: function(response) {




            $.ajax({
                type : "POST",
                url : "corporate_applications",
                data : {
                    request_type : 'corporate_dashboard_two_all',
                    date_from : startDate,
                    date_to : endDate
        
                },
                cache: false,
                success: function(response1) {
        
                    var json_result1 = JSON.parse(response1);
        
                    var completed = json_result1.completed;
                    var pending = json_result1.pending;
                    var queried = json_result1.queried;
                    var recieved = json_result1.recieved;
        
        
        
                    console.log(json_result1);
                    
                    document.getElementById('app-received').innerHTML = recieved;
                    document.getElementById('app-pending').innerHTML = pending;
                    document.getElementById('app-queried').innerHTML = queried;
                    document.getElementById('app-completed').innerHTML = completed;
        


                
                    $.ajax({
                        type: "POST",
                        url: "corporate_applications",
                        data: {
                            request_type: "corporate_dashboard_two_all_chart",
                            start_date: startDate,
                            end_date: endDate
                        },
                        cache: false,
                        success: function(response2) {

                        var json_result2 = JSON.parse(response2);

                            // Simulated response
                            // var json_result2 = {
                            //     "apps_at_division": [
                            //         { "bank_email": "info@firstnationalbank.com.gh", "total": 37, "created_for": "First National Bank Ghana Ltd" },
                            //         { "bank_email": "contact@ecobank.com.gh", "total": 45, "created_for": "Ecobank Ghana" },
                            //         { "bank_email": "support@zenithbank.com.gh", "total": 29, "created_for": "Zenith Bank Ghana" },
                            //         { "bank_email": "customercare@stanbicbank.com.gh", "total": 53, "created_for": "Stanbic Bank Ghana" },
                            //         { "bank_email": "info@republicbank.com.gh", "total": 18, "created_for": "Republic Bank Ghana" },
                            //         { "bank_email": "helpdesk@absa.com.gh", "total": 62, "created_for": "Absa Bank Ghana" }
                            //     ]
                            // };
                    
                            var appsatdivision_2 = json_result2.apps_at_division;



                                    
        
                    let dataSet11 = [];
                    let num11 = 0;
                   
                   $('#recent_submissions').DataTable().clear().destroy();
                   
                   
                          
                   if (json_result2.apps_at_division == []){
                   
                    console.log("data not found");       
            
            }else {
            
            for(let i=0; i<json_result2.apps_at_division.length; i++) {
              let html = [];
              num11 = +num11 + 1;
            
              let created_for = json_result2.apps_at_division[i].created_for;
              let total = json_result2.apps_at_division[i].total;
               let action = `<a href="javascript:void(0)" data-id="${json_result2.apps_at_division[i].bank_email}" data-name_full="${json_result2.apps_at_division[i].created_for}" id="view_applications_top5_recieved_by_banks"  
            class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
              
            
              html.push(created_for);
              html.push(total);
              html.push(action);
             
             
            
              dataSet11.push(html);
            
            
            }
            
            $('#recent_submissions').DataTable().clear().destroy();
                          
            $('#recent_submissions').DataTable({ data: dataSet11,
                dom : 'Bfrtip',
                lengthMenu : [
                    [ 10, 25, 50, -1 ],
                    [ '10 rows', '25 rows',
                        '50 rows', 'Show all' ] ],
                buttons : [ 'pageLength', 'copy',
                    'csv', 'excel', 'pdf', 'print' ] }).draw();
            
            }


                    
                            var pieChartData = appsatdivision_2.map(function(item) {
                                var bankName = item.created_for || "Unknown Bank";
                                var total = item.total || 0;
                                return { value: total, name: bankName };
                            });
                    
                            // Initialize the chart
                            var myChart = echarts.init(document.getElementById("pieChart"));
                    
                            var option = {
                                title: {
                                    text: "Banks",
                                    subtext: "",
                                    left: "center"
                                },
                                tooltip: {
                                    trigger: "item",
                                    formatter: "{b}: {c} ({d}%)"
                                },
                                legend: {
                                    orient: "horizontal", // Horizontal legend
                                    bottom: "0%", // Move legend below the chart
                                    align: "auto",
                                    textStyle: {
                                        fontSize: 12,
                                        color: "#333" // Ensure text is visible
                                    },
                                    itemWidth: 14, // **Legend color box width**
                                    itemHeight: 14, // **Legend color box height**
                                    itemGap: 10 // **Space between legend items**
                                },
                                series: [
                                    {
                                        name: "Applications Submitted",
                                        type: "pie",
                                        radius: "60%", // **Solid pie chart (no space in the middle)**
                                        center: ["50%", "45%"], // Center the chart above the legend
                                        label: {
                                            show: false // **Hides all labels inside the pie chart**
                                        },
                                        labelLine: {
                                            show: false // **Removes label lines**
                                        },
                                        emphasis: {
                                            label: {
                                                show: false // **Ensures no labels appear on hover**
                                            }
                                        },
                                        data: pieChartData
                                    }
                                ]
                            };
                    
                            myChart.setOption(option);
                    
                            // Ensure the chart resizes with the container
                            window.addEventListener("resize", function() {
                                myChart.resize();
                            });
                        }
                    });
        
   
        
        
                }
            })

            













            var json_result = JSON.parse(response);
            appsatdivision = json_result; // Assign fetched data to the global variable

            console.log("Fetched appsatdivision:", appsatdivision);

            // Calculate total pages
            totalPages = Math.ceil(appsatdivision.length / pageSize);

            // Initialize chart with the first page
            updateChart(currentPage);

            // Setup button event listeners
            document.getElementById('prevPage').addEventListener('click', function() {
                changePage(-1);
            });
            document.getElementById('nextPage').addEventListener('click', function() {
                changePage(1);
            });
            document.getElementById('startAutoScroll').addEventListener('click', startAutoScroll);
            document.getElementById('stopAutoScroll').addEventListener('click', stopAutoScroll);

            // Show/hide controls based on total pages
            if (totalPages <= 1) {
                document.getElementById('prevPage').style.display = 'none';
                document.getElementById('nextPage').style.display = 'none';
                document.getElementById('startAutoScroll').style.display = 'none';
                document.getElementById('stopAutoScroll').style.display = 'none';
            } else {
                document.getElementById('prevPage').style.display = 'inline-block';
                document.getElementById('nextPage').style.display = 'inline-block';
                document.getElementById('startAutoScroll').style.display = 'inline-block';
                document.getElementById('stopAutoScroll').style.display = 'inline-block';
            }
        },
        error: function(error) {
            console.error("Error fetching data:", error);
        }
    });
};





    $('#cabinetModal').on('show.bs.modal', function () {
        // $('#banks_apps_modal').modal('hide');  // Close the first modal when opening the second
    });
    
    // Initialize Select2
    $('#sel_change_bank').select2({
      placeholder: "Select Bank",
      allowClear: true,  // Enables the '×' clear button
    });

    // Hide the clear button immediately after Select2 initialization
    $('#sel_change_bank').on('select2:open', function() {
      // Ensure that the clear button is hidden when the dropdown is opened
      $('.select2-selection__clear').hide();
    });

    // If you want to hide the clear button on initialization, do it like this:
    $('#sel_change_bank').next('.select2-container').find('.select2-selection__clear').hide();



    $('#selchangebank').select2({
        placeholder: "Select Bank",
        allowClear: true,  // Enables the '×' clear button
      });
  
      // Hide the clear button immediately after Select2 initialization
      $('#selchangebank').on('select2:open', function() {
        // Ensure that the clear button is hidden when the dropdown is opened
        $('.select2-selection__clear').hide();
      });
  
      // If you want to hide the clear button on initialization, do it like this:
      $('#selchangebank').next('.select2-container').find('.select2-selection__clear').hide();





    // $(function() {
    //     // Set the default date range to "Today"
    //     var start = moment();
    //     var end = moment();
      
    //     // Callback function to update the date range display
    //     function cb(start, end) {
    //         $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    //     }
      
    //     // Initialize the date range picker
    //     $('#reportrange').daterangepicker({
    //         startDate: moment(),
    //         endDate: moment(),
    //         ranges: {
    //             'Today': [moment(), moment()],
    //             'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
    //             'Last 7 Days': [moment().subtract(6, 'days'), moment()],
    //             'Last 30 Days': [moment().subtract(29, 'days'), moment()],
    //             'This Month': [moment().startOf('month'), moment().endOf('month')],
    //             'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
    //         },
    //         locale: {
    //             format: 'YYYY-MM-DD',
    //         },
    //         opens: 'left', // Adjust dropdown open position (optional)
    //         drops: 'down', // Dropdown position (optional)
    //         showDropdowns: true, // Enable month and year selection via dropdowns
    //         minDate: '2000-01-01', // Set the minimum date to Jan 1, 2000
    //         maxDate: moment(), // Set the max date to the current date
    //         autoUpdateInput: false, // Prevent automatic update in the input field
    //         maxYear: moment().year(), // Allow selecting up to the current year
    //     }, function(start, end, label) {
    //         // Update the label manually when a custom date is selected
    //         cb(start, end);
            
    //         // Log the selected date range (for debugging)
    //         console.log("Selected date range: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));

    //          $('#start_date').val(start.format('YYYY-MM-DD'));
    //     $('#end_date').val(end.format('YYYY-MM-DD'));
    //     });
      
    //     // Trigger the callback to display the initial "Today" range
    //     cb(start, end);
      
    //     // Log the selected start and end dates (for debugging)
    //     console.log('Start Date: ', start.format('YYYY-MM-DD'));
    //     console.log('End Date: ', end.format('YYYY-MM-DD'));
      
    //     // Set the input fields to today's date
    //     $('#start_date').val(start.format('YYYY-MM-DD'));

    // flatpickr("#datefrom", {
    //     dateFormat: "Y-m-d", // Internal value format (YYYY-MM-DD)
    //     altInput: true, // Enables an alternative input field for display
    //     altFormat: "j F Y", // Display format (e.g., "1 February 2025")
    //     allowInput: true, // Allows manual input
    //     onClose: function(selectedDates, dateStr, instance) {
    //         let formattedDate = instance.formatDate(selectedDates[0], "j F Y"); // Format in "1 February 2025"
            
    //         console.log("Selected date (YYYY-MM-DD):", dateStr); 
    //         // console.log("Selected date (j F Y):", formattedDate); 
    
    //         $('#start_date').val(dateStr);

    //         $('#startdate').val(formattedDate);

    //     }
    // });


    //     $('#end_date').val(end.format('YYYY-MM-DD'));
    // });

    flatpickr("#datefrom", {
        dateFormat: "Y-m-d", // Internal value format (YYYY-MM-DD)
        altInput: true, // Enables an alternative input field for display
        altFormat: "j F Y", // Display format (e.g., "1 February 2025")
        allowInput: true, // Allows manual input
        onClose: function(selectedDates, dateStr, instance) {
            let formattedDate = instance.formatDate(selectedDates[0], "j F Y"); // Format in "1 February 2025"

            console.log("Selected date:", dateStr); // Logs in YYYY-MM-DD format
            console.log("Selected date (j F Y):", formattedDate); 

            $('#start_date').val(dateStr);
            $('#startdate').val(formattedDate);
    
        }
    });
    
    
    
    
    flatpickr("#dateto", {
        dateFormat: "Y-m-d", // Internal value format (YYYY-MM-DD)
        altInput: true, // Enables an alternative input field for display
        altFormat: "j F Y", // Display format (e.g., "1 February 2025")
        allowInput: true, // Allows manual input
        onClose: function(selectedDates, dateStr, instance) {
            let formattedDate = instance.formatDate(selectedDates[0], "j F Y"); // Format in "1 February 2025"
            console.log("Selected date:", dateStr); // Logs in YYYY-MM-DD format
            console.log("Selected date (j F Y):", formattedDate); 

            $('#end_date').val(dateStr);
            $('#enddate').val(formattedDate);

        // $('#sel_change_region_compliance').val('-1');

   







    document.getElementById('prevPage').style.display = 'none';
    document.getElementById('nextPage').style.display = 'none';
    document.getElementById('startAutoScroll').style.display = 'none';
    document.getElementById('stopAutoScroll').style.display = 'none';
  

//   $('#start_date').val(picker.startDate.format('YYYY-MM-DD'));
//   $('#end_date').val(picker.endDate.format('YYYY-MM-DD'));


   startDate = $('#start_date').val();
   endDate = $('#end_date').val();



    startdate = $('#startdate').val().toUpperCase();
    enddate = $('#enddate').val().toUpperCase();


//   alert(startDate + endDate);


$.ajax({
    type : "POST",
    url : "corporate_applications",
    data : {
        request_type : 'corporate_dashboard_two_all',
        date_from : startDate,
        date_to : endDate

    },
    cache: false,
    success: function(response1) {

        var json_result1 = JSON.parse(response1);

        var completed = json_result1.completed;
        var pending = json_result1.pending;
        var queried = json_result1.queried;
        var recieved = json_result1.recieved;



        // console.log(json_result1);
        
        document.getElementById('app-received').innerHTML = recieved;
        document.getElementById('app-pending').innerHTML = pending;
        document.getElementById('app-queried').innerHTML = queried;
        document.getElementById('app-completed').innerHTML = completed;





        $.ajax({
            type : "POST",
            url : "corporate_applications",
            data : {
                request_type : 'corporate_dashboard_two_all_chart',
                start_date : startDate,
                end_date : endDate
        
            },
            cache: false,
            success: function(response_7) {





                $.ajax({
                    type: "POST",
                    url: "corporate_applications",
                    data: {
                        request_type: 'corporate_dashboard_two_all_barchart',
                        date_from: startDate,
                        date_to: endDate,
                    },
                    cache: false,
                    success: function(response) {
                        // Parse the response and assign to the global variable
                        var json_result2 = JSON.parse(response);
                        appsatdivision1 = json_result2;
                      
                        console.log("appsatdivision1:", appsatdivision1);
                
                        // Recalculate total pages after updating the data
                        totalPage1 = Math.ceil(appsatdivision1.length / pageSize);
                
                        // Optionally, reset the current page to 1 (or any other logic you need)
                        currentPage = 1;
                
                        // Update the chart with the new data
                        updateChart1(currentPage);
                    },
                    error: function(error) {
                        console.error("Error fetching data:", error);
                    }
                });


          
                function updateChart1(page) {
                    var startIndex = (page - 1) * pageSize; // Calculate the start index
                    var endIndex = page * pageSize;       // Calculate the end index
                
                    // Slice the data for the current page
                    var pageData = appsatdivision1.slice(startIndex, endIndex);
                
                    console.log("Page data:", pageData); // Debugging
                
                    // Map data for chart
                    var bankNames = pageData.map(function(item) {
                        return item.created_for || 'Unknown Bank';
                    });
                
                    var submittedData = pageData.map(function(item) {
                        return item.submitted || 0;
                    });
                
                    var pendingData = pageData.map(function(item) {
                        return item.pending || 0;
                    });
                
                    var completedData = pageData.map(function(item) {
                        return item.completed || 0;
                    });
                
                    var queriedData = pageData.map(function(item) {
                        return item.queried || 0;
                    });
                
                    // Initialize or update the chart
                    var myChart_new = echarts.init(document.getElementById('barChart'));
                
                    // Define chart options
                    var option = {
                        title: { text: '', left: 'center' },
                        tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
                        legend: { data: ['Submitted', 'Pending', 'Completed', 'Queried'], left: 'left' },
                        xAxis: {
                            type: 'category',
                            data: bankNames,
                            axisLabel: {
                                rotate: 25, // Rotate labels to prevent overlap
                                interval: 0, // Show all labels (no skipping)
                                fontWeight: 'bold',
                                color: '#000',
                                formatter: function(value) {
                                    return value.length > 20 ? value.substring(0, 20) + '...' : value;
                                }
                            }
                        },
                        yAxis: { type: 'value' },
                        series: [
                            { name: 'Submitted', type: 'bar', data: submittedData, itemStyle: { color: '#5470C6' } },
                            { name: 'Pending', type: 'bar', data: pendingData, itemStyle: { color: '#36B8CC' } },
                            { name: 'Completed', type: 'bar', data: completedData, itemStyle: { color: '#1BC88A' } },
                            { name: 'Queried', type: 'bar', data: queriedData, itemStyle: { color: '#E74A3A' } }
                        ]
                    };
                
                    // Set the options for the chart
                    myChart_new.setOption(option);
                
                    // Update page number display
                    document.getElementById('pageNum').textContent = page;


                    updatePaginationControls();
                }
                
            
               // Keep track of button states
let isAutoScrollRunning = false;

function updatePaginationControls() {
    var controlContainer = document.getElementById('paginationControls');
    controlContainer.innerHTML = ''; // Clear previous buttons

    if (totalPage1 >= 1) {
        // Create a div for the button container
        var buttonContainer = document.createElement('div');
        buttonContainer.className = 'd-flex justify-content-between w-100'; // Ensures space between left and right buttons

        // Create a div for left-side buttons
        var leftControls = document.createElement('div');
        leftControls.className = 'd-flex'; // Flex container for left buttons, aligned horizontally

        // Create "Previous Page" button
        var prevButton = document.createElement('button');
        prevButton.id = 'prevPage';
        prevButton.className = 'btn btn-outline-primary me-2'; // Bootstrap classes for styling
        prevButton.innerHTML = '<i class="fa fa-arrow-left"></i>'; // Add icon
        prevButton.onclick = function () {
            if (currentPage > 1) {
                currentPage--;
                updateChart1(currentPage);
            }
        };
        leftControls.appendChild(prevButton);

        // Create "Next Page" button
        var nextButton = document.createElement('button');
        nextButton.id = 'nextPage';
        nextButton.className = 'btn btn-outline-primary'; // Bootstrap classes for styling
        nextButton.innerHTML = '<i class="fa fa-arrow-right"></i>'; // Add icon
        nextButton.onclick = function () {
            if (currentPage < totalPage1) {
                currentPage++;
                updateChart1(currentPage);
            }
        };
        leftControls.appendChild(nextButton);

        // Add left controls to the button container
        buttonContainer.appendChild(leftControls);

        // Create a div for right-side buttons
        var rightControls = document.createElement('div');
        rightControls.className = 'd-flex ml-auto'; // Flex container for right buttons, aligned horizontally

        // Create "Start Auto-Scroll" button
        var startAutoScroll = document.createElement('button');
        startAutoScroll.id = 'startAutoScroll';
        startAutoScroll.className = 'btn btn-outline-success me-2'; // Bootstrap classes for styling
        startAutoScroll.innerHTML = '<i class="fas fa-play"></i>'; // Add icon
        startAutoScroll.disabled = isAutoScrollRunning; // Disable if auto-scroll is running
        startAutoScroll.onclick = function () {
            startAutoScrollInterval();
            isAutoScrollRunning = true; // Update state
            updatePaginationControls(); // Refresh controls to reflect the state
        };
        rightControls.appendChild(startAutoScroll);

        // Create "Stop Auto-Scroll" button
        var stopAutoScroll = document.createElement('button');
        stopAutoScroll.id = 'stopAutoScroll';
        stopAutoScroll.className = 'btn btn-outline-danger'; // Bootstrap classes for styling
        stopAutoScroll.innerHTML = '<i class="fas fa-stop"></i>'; // Add icon
        stopAutoScroll.disabled = !isAutoScrollRunning; // Disable if auto-scroll is not running
        stopAutoScroll.onclick = function () {
            stopAutoScrollInterval();
            isAutoScrollRunning = false; // Update state
            updatePaginationControls(); // Refresh controls to reflect the state
        };
        rightControls.appendChild(stopAutoScroll);

        // Add right controls to the button container
        buttonContainer.appendChild(rightControls);

        // Add the button container to the pagination controls container
        controlContainer.appendChild(buttonContainer);
    } else {
        console.log('Single page detected, hiding controls.');
    }
}

                
                var autoScrollInterval;

                function startAutoScrollInterval() {
                    autoScrollInterval = setInterval(function () {
                        if (currentPage < totalPage1) {
                            currentPage++;
                        } else {
                            currentPage = 1; // Reset to the first page when reaching the last page
                        }
                        updateChart1(currentPage);
                    }, 30000); // Adjust the interval time as needed (2 seconds in this case)
                }
                
                function stopAutoScrollInterval() {
                    clearInterval(autoScrollInterval);
                }
                
          // Keep track of button states
// let isAutoScrollRunning = false;

function updatePaginationControls() {
    var controlContainer = document.getElementById('paginationControls');
    controlContainer.innerHTML = ''; // Clear previous buttons

    if (totalPage1 > 1) {
        // Create a div for the button container
        var buttonContainer = document.createElement('div');
        buttonContainer.className = 'd-flex justify-content-between w-100'; // Ensures space between left and right buttons

        // Create a div for left-side buttons
        var leftControls = document.createElement('div');
        leftControls.className = 'd-flex'; // Flex container for left buttons, aligned horizontally

        // Create "Previous Page" button
        var prevButton = document.createElement('button');
        prevButton.id = 'prevPage';
        prevButton.className = 'btn btn-outline-primary me-2'; // Bootstrap classes for styling
        prevButton.innerHTML = '<i class="fa fa-arrow-left"></i>'; // Add icon
        prevButton.onclick = function () {
            if (currentPage > 1) {
                currentPage--;
                updateChart1(currentPage);
            }
        };
        leftControls.appendChild(prevButton);

        // Create "Next Page" button
        var nextButton = document.createElement('button');
        nextButton.id = 'nextPage';
        nextButton.className = 'btn btn-outline-primary'; // Bootstrap classes for styling
        nextButton.innerHTML = '<i class="fa fa-arrow-right"></i>'; // Add icon
        nextButton.onclick = function () {
            if (currentPage < totalPage1) {
                currentPage++;
                updateChart1(currentPage);
            }
        };
        leftControls.appendChild(nextButton);

        // Add left controls to the button container
        buttonContainer.appendChild(leftControls);

        // Create a div for right-side buttons
        var rightControls = document.createElement('div');
        rightControls.className = 'd-flex ml-auto'; // Flex container for right buttons, aligned horizontally

        // Create "Start Auto-Scroll" button
        var startAutoScroll = document.createElement('button');
        startAutoScroll.id = 'startAutoScroll';
        startAutoScroll.className = 'btn btn-outline-success me-2'; // Bootstrap classes for styling
        startAutoScroll.innerHTML = '<i class="fas fa-play"></i>'; // Add icon
        startAutoScroll.disabled = isAutoScrollRunning; // Disable if auto-scroll is running
        startAutoScroll.onclick = function () {
            startAutoScrollInterval();
            isAutoScrollRunning = true; // Update state
            updatePaginationControls(); // Refresh controls to reflect the state
        };
        rightControls.appendChild(startAutoScroll);

        // Create "Stop Auto-Scroll" button
        var stopAutoScroll = document.createElement('button');
        stopAutoScroll.id = 'stopAutoScroll';
        stopAutoScroll.className = 'btn btn-outline-danger'; // Bootstrap classes for styling
        stopAutoScroll.innerHTML = '<i class="fas fa-stop"></i>'; // Add icon
        stopAutoScroll.disabled = !isAutoScrollRunning; // Disable if auto-scroll is not running
        stopAutoScroll.onclick = function () {
            stopAutoScrollInterval();
            isAutoScrollRunning = false; // Update state
            updatePaginationControls(); // Refresh controls to reflect the state
        };
        rightControls.appendChild(stopAutoScroll);

        // Add right controls to the button container
        buttonContainer.appendChild(rightControls);

        // Add the button container to the pagination controls container
        controlContainer.appendChild(buttonContainer);
    } else {
        console.log('Single page detected, hiding controls.');
    }
}
             
                





        
                var json_result = JSON.parse(response_7);
        
        
        
                let dataSet11 = [];
                let num11 = 0;
               
               $('#recent_submissions').DataTable().clear().destroy();
               
               
                      
               if (json_result.apps_at_division == null){
               
                // console.log("data not found");       
        
        }else {
        
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num11 = +num11 + 1;
        
          let created_for = json_result.apps_at_division[i].created_for;
          let total = json_result.apps_at_division[i].total;
           let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].bank_email}" data-name_full="${json_result.apps_at_division[i].created_for}" id="view_applications_top5_recieved_by_banks"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          
        
          html.push(created_for);
          html.push(total);
          html.push(action);
         
         
        
          dataSet11.push(html);
        
        
        }
        
        $('#recent_submissions').DataTable().clear().destroy();
                      
        $('#recent_submissions').DataTable({ data: dataSet11,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
                    buttons: [
                        {
                            extend: 'csv',
                            title: `Report On Application Submissions from Top 5 Banks from ${startdate} to ${enddate}`,
                            filename: `Report_On_Application_Submissions_from_Top_5_Banks_from_${startdate}_to_${enddate}`
                        },
                        {
                            extend: 'excel',
                            title: `Report On Application Submissions from Top 5 Banks from ${startdate} to ${enddate}`,
                            filename: `Report_On_Application_Submissions_from_Top_5_Banks_from_${startdate}_to_${enddate}`
                        },
                        {
                            extend: 'pdf',
                            title: `Report On Application Submissions from Top 5 Banks from ${startdate} to ${enddate}`,
                            filename: `Report_On_Application_Submissions_from_Top_5_Banks_from_${startdate}_to_${enddate}`
                        },
                        {
                            extend: 'print',
                            title: `<h3>Report On Application Submissions from Top 5 Banks from ${startdate} to ${enddate}</h3>`,
                            message: 'This report is generated using the Enterprise Land Information System'
                        }
                    ]

            }).draw();
        
        }
           
        


        

        // var appsatdivision7 = JSON.parse(response_7);


                var appsatdivision7 = json_result.apps_at_division;
        
        
                console.log(appsatdivision7);
        
        
        // Prepare the data for the pie chart
        var pieChartData = appsatdivision7.map(function(item) {
            // Check if bank_email or created_for is null or empty
            var bankName = item.created_for || 'Unknown Bank';
            var total = item.total || 0; // Default to 0 if total is null or undefined
            return {
                value: total,
                name: bankName
            };
        });
        
        // Initialize the chart
        var myChart = echarts.init(document.getElementById('pieChart'));
        
        // Define the chart options
        var option = {
            title: {
                text: '',
                subtext: '',
                left: 'center'
            },
            tooltip: {
                trigger: 'item'
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                top: 'top',
                width: 'auto', // Optional: adjusts the width of the legend
                height: 'auto' // Optional: adjusts the height of the legend
            },
            series: [
                {
                    name: 'Applications Submitted',
                    type: 'pie',
                    radius: '50%',
                    center: ['50%', '60%'],  // Centers the pie chart in the available space below the legend
                    data: pieChartData,  // Use the dynamically generated data
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        
        // Set the chart options
        myChart.setOption(option);

        window.addEventListener('resize', function() {
            myChart.resize();
        });
                
        
            }
        })

        










    }
})


    $('#recieved_apps').on('click', function(e) {
        e.preventDefault();

     var title = "APPLICATIONS RECIEVED BETWEEN"+ ' ' + startdate + ' ' +"and"+ " " +enddate;    


    document.getElementById('main_service_modal_title').innerHTML = title;

    
     $("#main_service_modal").modal("show");  
    
    //  var regional_code = $('#csau_manager_regional_code').val();
     //console.log(regional_code);
    
     $.ajax({
         type : "POST",
         url : "corporate_applications",
         data : {
             request_type : 'corporate_dashboard_two_apps_recieved',
              date_from : startDate,
            date_to : endDate
         },
         cache: false,
         success: function(response) {
             console.log(response);
    
             var json_result = JSON.parse(response);

             console.log(json_result.apps_at_division);

             if (json_result.apps_at_division == null){

                alert ("No applications has been received today. Please check back later")
    
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
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].business_process_id}" data-name_full="${json_result.apps_at_division[i].service_name}" id="view_recieved_apps_by_sub_service"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
    
        
    
        html.push(service_name);
        html.push(count);
        html.push(action);
      
    
        dataSet8.push(html);
    
      //console.log(dataSet)
      }
    
    
      $('#main_service_table').DataTable().clear().destroy();
                    
      $('#main_service_table').DataTable({ data: dataSet8,
        dom : 'Bfrtip',
        lengthMenu : [
            [ 10, 25, 50, -1 ],
            [ '10 rows', '25 rows',
                '50 rows', 'Show all' ] ],
                
                buttons: [
                    {
                        extend: 'csv',
                        title: `Report On Applications Recieved from  ${startdate} to ${enddate}`,
                        filename: `Report_On_Applications_Recieved_from_${startdate}_to_${enddate}`
                    },
                    {
                        extend: 'excel',
                        title: `Report On Applications Recieved from  ${startdate} to ${enddate}`,
                        filename: `Report_On_Applications_Recieved_from_${startdate}_to_${enddate}`
                    },
                    {
                        extend: 'pdf',
                        title: `Report On Applications Recieved from  ${startdate} to ${enddate}`,
                        filename: `Report_On_Applications_Recieved_from_${startdate}_to_${enddate}`
                    },
                    {
                        extend: 'print',
                        title: `Report On Applications Recieved from  ${startdate} to ${enddate}`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ]
        
        
        
        }).draw();
    
    
    }
    
    
         }
     })
    
    
    }) 


    $('#pending_apps').on('click', function(e) {
        e.preventDefault();



        var title = "APPLICATIONS PENDING BETWEEN"+ ' ' + startdate + ' ' +"and"+ " " +enddate;    


        document.getElementById('main_service_modal_title').innerHTML = title;
    
     $("#main_service_modal").modal("show");  
    
    //  var regional_code = $('#csau_manager_regional_code').val();
     //console.log(regional_code);
    
     $.ajax({
         type : "POST",
         url : "corporate_applications",
         data : {
             request_type : 'corporate_dashboard_two_apps_pending',
              date_from : startDate,
            date_to : endDate
         },
         cache: false,
         success: function(response) {
             console.log(response);
    
             var json_result = JSON.parse(response);

             console.log(json_result.apps_at_division);

             if (json_result.apps_at_division == null){

                alert ("No applications has been received today. Please check back later")
    
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
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].business_process_id}" data-name_full="${json_result.apps_at_division[i].service_name}" id="view_pending_apps_by_sub_service"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
    
        
    
        html.push(service_name);
        html.push(count);
        html.push(action);
      
    
        dataSet8.push(html);
    
      //console.log(dataSet)
      }
    
    
      $('#main_service_table').DataTable().clear().destroy();
                    
      $('#main_service_table').DataTable({ data: dataSet8,
        dom : 'Bfrtip',
        lengthMenu : [
            [ 10, 25, 50, -1 ],
            [ '10 rows', '25 rows',
                '50 rows', 'Show all' ] ],
        
                buttons: [   
                    {
                        extend: 'csv',
                        title: `Report On Applications Pending Between ${startdate} and ${enddate}`,
                        filename: `Report_On_Applications_Pending_Between_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'excel',
                        title: `Report On Applications Pending Between ${startdate} and ${enddate}`,
                        filename: `Report_On_Applications_Pending_Between_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'pdf',
                        title: `Report On Applications Pending Between ${startdate} and ${enddate}`,
                        filename: `Report_On_Applications_Pending_Between_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'print',
                        title: `<h3>Report On Applications Pending Between ${startdate} and ${enddate}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ]
        
        
        
        }).draw();
    
    
    }
    
    
         }
     })
    
    
    }) 



    $('#queried_apps').on('click', function(e) {
        e.preventDefault();



        var title = "APPLICATIONS QUERIED BETWEEN"+ ' ' + startdate + ' ' +"and"+ " " +enddate;    


        document.getElementById('main_service_modal_title').innerHTML = title;
    
     $("#main_service_modal").modal("show");  
    
    //  var regional_code = $('#csau_manager_regional_code').val();
     //console.log(regional_code);
    
     $.ajax({
         type : "POST",
         url : "corporate_applications",
         data : {
             request_type : 'corporate_dashboard_two_apps_queried',
              date_from : startDate,
            date_to : endDate
         },
         cache: false,
         success: function(response) {
             console.log(response);
    
             var json_result = JSON.parse(response);

             console.log(json_result.apps_at_division);

             if (json_result.apps_at_division == null){

                alert ("No applications has been received today. Please check back later")
    
                //  console.log("data not found");       
    
    }else {
    
    
    let dataSet8 = [];
    let num8 = 0;
    
    $('#main_service_table').DataTable().clear().destroy();
    
    
    for(let i=0; i<json_result.apps_at_division.length; i++) {
        let html = [];
        num8 = +num8 + 1;
    
        let service_name = json_result.apps_at_division[i].service_name;
        let count = json_result.apps_at_division[i].count;
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].business_process_id}" data-name_full="${json_result.apps_at_division[i].service_name}" id="view_queried_apps_by_sub_service"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
    
        
    
        html.push(service_name);
        html.push(count);
        html.push(action);
      
    
        dataSet8.push(html);
    
      //console.log(dataSet)
      }
    
    
      $('#main_service_table').DataTable().clear().destroy();


      $('#main_service_table').DataTable({ data: dataSet8,
        dom : 'Bfrtip',
        lengthMenu : [
            [ 10, 25, 50, -1 ],
            [ '10 rows', '25 rows',
                '50 rows', 'Show all' ] ],
        
                buttons: [   
                    {
                        extend: 'csv',
                        title: `Report On Applications Queried Between ${startdate} and ${enddate}`,
                        filename: `Report_On_Applications_Queried_Between_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'excel',
                        title: `Report On Applications Queried Between ${startdate} and ${enddate}`,
                        filename: `Report_On_Applications_Queried_Between_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'pdf',
                        title: `Report On Applications Queried Between ${startdate} and ${enddate}`,
                        filename: `Report_On_Applications_Queried_Between_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'print',
                        title: `<h3>Report On Applications Queried Between ${startdate} and ${enddate}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ]
        
        
        
        }).draw();
    
    
    }
    
    
         }
     })
    
    
    }) 


    $('#completed_apps').on('click', function(e) {
        e.preventDefault();


        var title = "APPLICATIONS COMPLETED BETWEEN"+ ' ' + startdate + ' ' +"and"+ " " +enddate;    


        document.getElementById('main_service_modal_title').innerHTML = title;
    
     $("#main_service_modal").modal("show");  
    
    //  var regional_code = $('#csau_manager_regional_code').val();
     //console.log(regional_code);
    
     $.ajax({
         type : "POST",
         url : "corporate_applications",
         data : {
             request_type : 'corporate_dashboard_two_apps_completed',
              date_from :startDate,
            date_to : endDate
         },
         cache: false,
         success: function(response) {
             console.log(response);
    
             var json_result = JSON.parse(response);

             console.log(json_result.apps_at_division);

             if (json_result.apps_at_division == null){

                alert ("No applications has been received today. Please check back later")
    
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
        let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].business_process_id}" data-name_full="${json_result.apps_at_division[i].service_name}" id="view_completed_apps_by_sub_service"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
    
    
        
    
        html.push(service_name);
        html.push(count);
        html.push(action);
      
    
        dataSet8.push(html);
    
      //console.log(dataSet)
      }
    
    
      $('#main_service_table').DataTable().clear().destroy();
                    
      $('#main_service_table').DataTable({ data: dataSet8,
        dom : 'Bfrtip',
        lengthMenu : [
            [ 10, 25, 50, -1 ],
            [ '10 rows', '25 rows',
                '50 rows', 'Show all' ] ],
      
                buttons: [   
                    {
                        extend: 'csv',
                        title: `Report On Applications Completed Between ${startdate} and ${enddate}`,
                        filename: `Report_On_Applications_Completed_Between_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'excel',
                        title: `Report On Applications Completed Between ${startdate} and ${enddate}`,
                        filename: `Report_On_Applications_Completed_Between_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'pdf',
                        title: `Report On Applications Completed Between ${startdate} and ${enddate}`,
                        filename: `Report_On_Applications_Completed_Between_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'print',
                        title: `<h3>Report On Applications Completed Between ${startdate} and ${enddate}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ]
        
        
        }).draw();
    
    
    }
    
    
         }
     })
    
    
    }) 


    $(document).on('click','#view_recieved_apps_by_sub_service',function(e){
        e.preventDefault();
        var business_process_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');
        //var user_created_name = $(e.currentTarget).data("name");

        var title = user_created_name+ " " + " RECIEVED BETWEEN"+ ' ' + startdate + ' ' +"AND "+ " " +enddate;    

      
        document.getElementById('sub_service_modalLabel').innerHTML = title;
      
        console.log(business_process_id,user_created_name);
       

        // $("#main_service_modal").modal("hide");  


      $("#sub_service_modal").modal("show");  

      
       let dataSet11 = [];
       let num11 = 0;
      
      $('#sub_service_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_apps_by_subservices_recieved',
               sub_serv_id : business_process_id,
                date_from :startDate,
            date_to : endDate
           },
           cache: false,
           success: function(response) {
      
        //    console.log(response)
      
               var json_result = JSON.parse(response);
              console.log(json_result)
      
               if (json_result.apps_at_division == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num11 = +num11 + 1;
      
          let sub_service_name = json_result.apps_at_division[i].sub_service_name;
          let total = json_result.apps_at_division[i].total;
           let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].business_process_sub_id}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_recieved_apps_by_banks"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          
      
          html.push(sub_service_name);
          html.push(total);
          html.push(action);
         
         
      
          dataSet11.push(html);
      
        
        }
     
        $('#sub_service_table').DataTable().clear().destroy();
                      
        $('#sub_service_table').DataTable({ data: dataSet11,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],

                    // var title = user_created_name+ " " + " RECIEVED BETWEEN"+ ' ' + startDate + ' ' +"AND "+ " " +endDate;    
                    buttons: [   
                        {
                            extend: 'csv',
                            title: `Report on ${user_created_name} RECIEVED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_recieved_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'excel',
                            title: `Report on ${user_created_name} RECIEVED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_recieved_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'pdf',
                            title: `Report on ${user_created_name} RECIEVED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_recieved_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'print',
                            title: `<h3>Report on ${user_created_name} RECIEVED BETWEEN ${startdate} and ${enddate}</h3>`,
                            message: 'This report is generated using the Enterprise Land Information System'
                        }
                    ]
            
            
            }).draw();
      
      }
              
      
      
           }
       })
       
      
      });


      $(document).on('click','#view_pending_apps_by_sub_service',function(e){
        e.preventDefault();
        var business_process_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');
        //var user_created_name = $(e.currentTarget).data("name");
      

        var title = user_created_name+ " " + " PENDING BETWEEN"+ ' ' + startdate + ' ' +"AND "+ " " +enddate;    

      
        document.getElementById('sub_service_modalLabel').innerHTML = title;


        console.log(business_process_id,user_created_name);

        // $("#main_service_modal").modal("hide");  

       
      $("#sub_service_modal").modal("show");  
       
       
      
       let dataSet11 = [];
       let num11 = 0;
      
      $('#sub_service_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_apps_by_subservices_pending',
               sub_serv_id : business_process_id,
                date_from : startDate,
            date_to : endDate
           },
           cache: false,
           success: function(response) {
      
        //    console.log(response)
      
               var json_result = JSON.parse(response);
              console.log(json_result)
      
               if (json_result.apps_at_division == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num11 = +num11 + 1;
      
          let sub_service_name = json_result.apps_at_division[i].sub_service_name;
          let total = json_result.apps_at_division[i].total;
           let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].business_process_sub_id}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_pending_apps_by_banks"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          
      
          html.push(sub_service_name);
          html.push(total);
          html.push(action);
         
         
      
          dataSet11.push(html);
      
        
        }
     
        $('#sub_service_table').DataTable().clear().destroy();
                      
        $('#sub_service_table').DataTable({ data: dataSet11,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
                    buttons: [   
                        {
                            extend: 'csv',
                            title: `Report on ${user_created_name} PENDING BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_pending_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'excel',
                            title: `Report on ${user_created_name} PENDING BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_pending_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'pdf',
                            title: `Report on ${user_created_name} PENDING BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_pending_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'print',
                            title: `<h3>Report on ${user_created_name} PENDING BETWEEN ${startdate} and ${enddate}</h3>`,
                            message: 'This report is generated using the Enterprise Land Information System'
                        }
                    ]
            
            }).draw();
      
      }
              
      
      
           }
       })
       
      
      });







      $(document).on('click','#view_queried_apps_by_sub_service',function(e){
        e.preventDefault();
        var business_process_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');
        //var user_created_name = $(e.currentTarget).data("name");
      

        var title = user_created_name+ " " + " QUERIED BETWEEN"+ ' ' + startdate + ' ' +"AND "+ " " +enddate;    

      
        document.getElementById('sub_service_modalLabel').innerHTML = title;


        console.log(business_process_id,user_created_name);

        // $("#main_service_modal").modal("hide");  

       
      $("#sub_service_modal").modal("show");  
       
       
      
       let dataSet11 = [];
       let num11 = 0;
      
      $('#sub_service_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_apps_by_subservices_queried',
               sub_serv_id : business_process_id,
                date_from : startDate,
            date_to : endDate
           },
           cache: false,
           success: function(response) {
      
        //    console.log(response)
      
               var json_result = JSON.parse(response);
              console.log(json_result)
      
               if (json_result.apps_at_division == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num11 = +num11 + 1;
      
          let sub_service_name = json_result.apps_at_division[i].sub_service_name;
          let total = json_result.apps_at_division[i].count;
           let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].business_process_sub_id}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_queried_apps_by_banks"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          
      
          html.push(sub_service_name);
          html.push(total);
          html.push(action);
         
         
      
          dataSet11.push(html);
      
        
        }
     
        $('#sub_service_table').DataTable().clear().destroy();
                      
        $('#sub_service_table').DataTable({ data: dataSet11,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
                    buttons: [   
                        {
                            extend: 'csv',
                            title: `Report on ${user_created_name} QUERIED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_queried_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'excel',
                            title: `Report on ${user_created_name} QUERIED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_queried_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'pdf',
                            title: `Report on ${user_created_name} QUERIED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_queried_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'print',
                            title: `<h3>Report on ${user_created_name} QUERIED BETWEEN ${startdate} and ${enddate}</h3>`,
                            message: 'This report is generated using the Enterprise Land Information System'
                        }
                    ]
            
            }).draw();
      
      }
              
      
      
           }
       })
       
      
      });






      



      $(document).on('click','#view_completed_apps_by_sub_service',function(e){
        e.preventDefault();
        var business_process_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');
      

        var title = user_created_name+ " " + " COMPLETED BETWEEN"+ ' ' + startdate + ' ' +"AND "+ " " +enddate;    

      
        document.getElementById('sub_service_modalLabel').innerHTML = title;


      
        console.log(business_process_id,user_created_name);

        // $("#main_service_modal").modal("hide");  

       
      $("#sub_service_modal").modal("show");  
       
       
      
       let dataSet11 = [];
       let num11 = 0;
      
      $('#sub_service_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_apps_by_subservices_completed',
               sub_serv_id : business_process_id,
                date_from : startDate,
            date_to : endDate
           },
           cache: false,
           success: function(response) {
      
        //    console.log(response)
      
               var json_result = JSON.parse(response);
              console.log(json_result)
      
               if (json_result.apps_at_division == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num11 = +num11 + 1;
      
          let sub_service_name = json_result.apps_at_division[i].sub_service_name;
          let total = json_result.apps_at_division[i].total;
           let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].business_process_sub_id}" data-name_full="${json_result.apps_at_division[i].sub_service_name}" id="view_completed_apps_by_banks"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          
      
          html.push(sub_service_name);
          html.push(total);
          html.push(action);
         
         
      
          dataSet11.push(html);
      
        
        }
     
        $('#sub_service_table').DataTable().clear().destroy();
                      
        $('#sub_service_table').DataTable({ data: dataSet11,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            
                    buttons: [   
                        {
                            extend: 'csv',
                            title: `Report on ${user_created_name} COMPLETED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_completed_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'excel',
                            title: `Report on ${user_created_name} COMPLETED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_completed_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'pdf',
                            title: `Report on ${user_created_name} COMPLETED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_completed_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'print',
                            title: `<h3>Report on ${user_created_name} COMPLETED BETWEEN ${startdate} and ${enddate}</h3>`,
                            message: 'This report is generated using the Enterprise Land Information System'
                        }
                    ]
            
            
            
            }).draw();
      
      }
              
      
      
           }
       })
       
      
      });

      

      $(document).on('click','#view_recieved_apps_by_banks',function(e){
        e.preventDefault();
        var business_process_sub_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');



        var title = user_created_name+ " " + " RECIEVED BETWEEN"+ ' ' + startdate + ' ' +"AND "+ " " +enddate;    

      
        document.getElementById('banks_modalLabel').innerHTML = title;



        $('#subprocessid').val(business_process_sub_id);

        $('#service_to_bank_name').val(user_created_name);

        


        //var user_created_name = $(e.currentTarget).data("name");
      
        // document.getElementById('staff_name4').innerHTML = user_created_name;
      
        console.log(business_process_sub_id,user_created_name);

        
       
        // $("#sub_service_modal").modal("hide");  


      $("#banks_modal").modal("show");  
       
       
      
       let dataSet11 = [];
       let num11 = 0;
      
      $('#banks_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_apps_by_subservices_recieved_from_banks',
               sub_serv_sub_id : business_process_sub_id,
                date_from : startDate,
            date_to : endDate
           },
           cache: false,
           success: function(response) {
      
        //    console.log(response)
      
               var json_result = JSON.parse(response);
              console.log(json_result)
      
               if (json_result.apps_at_division == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num11 = +num11 + 1;
      
          let created_for = json_result.apps_at_division[i].created_for;
          let total = json_result.apps_at_division[i].total;
           let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].bank_email}" data-name_full="${json_result.apps_at_division[i].created_for}" id="view_applications_recieved_by_banks"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          
      
          html.push(created_for);
          html.push(total);
          html.push(action);
         
         
      
          dataSet11.push(html);
      
        
        }
     
        $('#banks_table').DataTable().clear().destroy();
                      
        $('#banks_table').DataTable({ data: dataSet11,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            

                    buttons: [   
                        {
                            extend: 'csv',
                            title: `Report on ${user_created_name} RECIEVED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_recieved_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'excel',
                            title: `Report on ${user_created_name} RECIEVED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_recieved_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'pdf',
                            title: `Report on ${user_created_name} RECIEVED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_recieved_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'print',
                            title: `<h3>Report on ${user_created_name} RECIEVED BETWEEN ${startdate} and ${enddate}</h3>`,
                            message: 'This report is generated using the Enterprise Land Information System'
                        }
                    ]
            
            
            }).draw();
      
      }
              
      
      
           }
       })
       
      
      });


      $(document).on('click','#view_pending_apps_by_banks',function(e){
        e.preventDefault();
        var business_process_sub_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');
        //var user_created_name = $(e.currentTarget).data("name");



        var title = user_created_name+ " " + " RECIEVED BETWEEN"+ ' ' + startdate + ' ' +"AND "+ " " +enddate;    

      
        document.getElementById('banks_modalLabel').innerHTML = title;
      

        $('#subprocessid').val(business_process_sub_id);

        $('#service_to_bank_name').val(user_created_name);


        // document.getElementById('staff_name4').innerHTML = user_created_name;
      
        console.log(business_process_sub_id,user_created_name);

        // $("#sub_service_modal").modal("hide");  

       
      $("#banks_modal").modal("show");  
       
       
      
       let dataSet11 = [];
       let num11 = 0;
      
      $('#banks_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_apps_by_subservices_pending_from_banks',
               sub_serv_sub_id : business_process_sub_id,
                date_from : startDate,
            date_to : endDate
           },
           cache: false,
           success: function(response) {
      
        //    console.log(response)
      
               var json_result = JSON.parse(response);
              console.log(json_result)
      
               if (json_result.apps_at_division == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num11 = +num11 + 1;
      
          let created_for = json_result.apps_at_division[i].created_for;
          let total = json_result.apps_at_division[i].total;
           let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].bank_email}" data-name_full="${json_result.apps_at_division[i].created_for}" id="view_applications_pending_by_banks"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          
      
          html.push(created_for);
          html.push(total);
          html.push(action);
         
         
      
          dataSet11.push(html);
      
        
        }
     
        $('#banks_table').DataTable().clear().destroy();
                      
        $('#banks_table').DataTable({ data: dataSet11,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            
                    buttons: [   
                        {
                            extend: 'csv',
                            title: `Report on ${user_created_name} PENDING BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_pending_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'excel',
                            title: `Report on ${user_created_name} PENDING BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_pending_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'pdf',
                            title: `Report on ${user_created_name} PENDING BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_pending_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'print',
                            title: `<h3>Report on ${user_created_name} PENDING BETWEEN ${startdate} and ${enddate}</h3>`,
                            message: 'This report is generated using the Enterprise Land Information System'
                        }
                    ]
            
            
            }).draw();
      
      }
              
      
      
           }
       })
       
      
      });










      $(document).on('click','#view_pending_apps_by_banks',function(e){
        e.preventDefault();
        var business_process_sub_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');
        //var user_created_name = $(e.currentTarget).data("name");



        var title = user_created_name+ " " + " RECIEVED BETWEEN"+ ' ' + startdate + ' ' +"AND "+ " " +enddate;    

      
        document.getElementById('banks_modalLabel').innerHTML = title;
      

        $('#subprocessid').val(business_process_sub_id);

        $('#service_to_bank_name').val(user_created_name);


        // document.getElementById('staff_name4').innerHTML = user_created_name;
      
        console.log(business_process_sub_id,user_created_name);

        // $("#sub_service_modal").modal("hide");  

       
      $("#banks_modal").modal("show");  
       
       
      
       let dataSet11 = [];
       let num11 = 0;
      
      $('#banks_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_apps_by_subservices_pending_from_banks',
               sub_serv_sub_id : business_process_sub_id,
                date_from : startDate,
            date_to : endDate
           },
           cache: false,
           success: function(response) {
      
        //    console.log(response)
      
               var json_result = JSON.parse(response);
              console.log(json_result)
      
               if (json_result.apps_at_division == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num11 = +num11 + 1;
      
          let created_for = json_result.apps_at_division[i].created_for;
          let total = json_result.apps_at_division[i].total;
           let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].bank_email}" data-name_full="${json_result.apps_at_division[i].created_for}" id="view_applications_pending_by_banks"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          
      
          html.push(created_for);
          html.push(total);
          html.push(action);
         
         
      
          dataSet11.push(html);
      
        
        }
     
        $('#banks_table').DataTable().clear().destroy();
                      
        $('#banks_table').DataTable({ data: dataSet11,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            
                    buttons: [   
                        {
                            extend: 'csv',
                            title: `Report on ${user_created_name} PENDING BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_pending_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'excel',
                            title: `Report on ${user_created_name} PENDING BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_pending_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'pdf',
                            title: `Report on ${user_created_name} PENDING BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_pending_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'print',
                            title: `<h3>Report on ${user_created_name} PENDING BETWEEN ${startdate} and ${enddate}</h3>`,
                            message: 'This report is generated using the Enterprise Land Information System'
                        }
                    ]
            
            
            }).draw();
      
      }
              
      
      
           }
       })
       
      
      });


      






      $(document).on('click','#view_queried_apps_by_banks',function(e){
        e.preventDefault();
        var business_process_sub_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');
        //var user_created_name = $(e.currentTarget).data("name");



        var title = user_created_name+ " " + " QUERIED BETWEEN"+ ' ' + startdate + ' ' +"AND "+ " " +enddate;    

      
        document.getElementById('banks_modalLabel').innerHTML = title;
      

        $('#subprocessid').val(business_process_sub_id);

        $('#service_to_bank_name').val(user_created_name);


        // document.getElementById('staff_name4').innerHTML = user_created_name;
      
        console.log(business_process_sub_id,user_created_name);

        // $("#sub_service_modal").modal("hide");  

       
      $("#banks_modal").modal("show");  
       
       
      
       let dataSet11 = [];
       let num11 = 0;
      
      $('#banks_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_apps_by_subservices_queried_from_banks',
               sub_serv_sub_id : business_process_sub_id,
                date_from : startDate,
            date_to : endDate
           },
           cache: false,
           success: function(response) {
      
        //    console.log(response)
      
               var json_result = JSON.parse(response);
              console.log(json_result)
      
               if (json_result.apps_at_division == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num11 = +num11 + 1;
      
          let created_for = json_result.apps_at_division[i].created_for;
          let total = json_result.apps_at_division[i].count;
           let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].bank_email}" data-name_full="${json_result.apps_at_division[i].created_for}" id="view_applications_queried_by_banks"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          
      
          html.push(created_for);
          html.push(total);
          html.push(action);
         
         
      
          dataSet11.push(html);
      
        
        }
     
        $('#banks_table').DataTable().clear().destroy();
                      
        $('#banks_table').DataTable({ data: dataSet11,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            
                    buttons: [   
                        {
                            extend: 'csv',
                            title: `Report on ${user_created_name} QUERIED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_queried_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'excel',
                            title: `Report on ${user_created_name} QUERIED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_queried_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'pdf',
                            title: `Report on ${user_created_name} QUERIED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_queried_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'print',
                            title: `<h3>Report on ${user_created_name} QUERIED BETWEEN ${startdate} and ${enddate}</h3>`,
                            message: 'This report is generated using the Enterprise Land Information System'
                        }
                    ]
            
            
            }).draw();
      
      }
              
      
      
           }
       })
       
      
      });








      $(document).on('click','#view_completed_apps_by_banks',function(e){
        e.preventDefault();
        var business_process_sub_id=$(this).data('id');
       
        var user_created_name=$(this).data('name_full');
        //var user_created_name = $(e.currentTarget).data("name");


        var title = user_created_name+ " " + " COMPLETED BETWEEN"+ ' ' + startdate + ' ' +"AND "+ " " +enddate;    

      
        document.getElementById('banks_modalLabel').innerHTML = title;



        $('#completed_subprocessid').val(business_process_sub_id);

        $('#service_to_bank_name').val(user_created_name);


        

      
        // document.getElementById('staff_name4').innerHTML = user_created_name;
      
        console.log(business_process_sub_id);

        // $("#sub_service_modal").modal("hide");  
       
      $("#banks_modal").modal("show");  
       
       
      
       let dataSet11 = [];
       let num11 = 0;
      
      $('#banks_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_apps_by_subservices_completed_from_bank',
               sub_serv_sub_id : business_process_sub_id,
                date_from :startDate,
            date_to : endDate
           },
           cache: false,
           success: function(response) {
      
        //    console.log(response)
      
               var json_result = JSON.parse(response);
              console.log(json_result)
      
               if (json_result.apps_at_division == null){
      
                console.log("data not found");       
      
      }else {
      
        for(let i=0; i<json_result.apps_at_division.length; i++) {
          let html = [];
          num11 = +num11 + 1;
      
          let created_for = json_result.apps_at_division[i].created_for;
          let total = json_result.apps_at_division[i].total;
           let action = `<a href="javascript:void(0)" data-id="${json_result.apps_at_division[i].bank_email}" data-name_full="${json_result.apps_at_division[i].created_for}" id="view_applications_completed_by_banks"  
        class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
          
      
          html.push(created_for);
          html.push(total);
          html.push(action);
         
         
      
          dataSet11.push(html);
      
        
        }
     
        $('#banks_table').DataTable().clear().destroy();
                      
        $('#banks_table').DataTable({ data: dataSet11,
            dom : 'Bfrtip',
            lengthMenu : [
                [ 10, 25, 50, -1 ],
                [ '10 rows', '25 rows',
                    '50 rows', 'Show all' ] ],
            

                    buttons: [   
                        {
                            extend: 'csv',
                            title: `Report on ${user_created_name} COMPLETED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_completed_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'excel',
                            title: `Report on ${user_created_name} COMPLETED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_completed_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'pdf',
                            title: `Report on ${user_created_name} COMPLETED BETWEEN ${startdate} and ${enddate}`,
                            filename: `Report_On_${user_created_name}_completed_Between_${startdate}_and_${enddate}`
                        },
                        {
                            extend: 'print',
                            title: `<h3>Report on ${user_created_name} COMPLETED BETWEEN ${startdate} and ${enddate}</h3>`,
                            message: 'This report is generated using the Enterprise Land Information System'
                        }
                    ]

            
            }).draw();
      
      }
              
      
      
           }
       })
       
      
      });


      $(document).on('click','#view_applications_recieved_by_banks',function(e){
        e.preventDefault();
       
        var bank_email=$(this).data('id');
       
        var bank_name=$(this).data('name_full');



        var subprocessid = $('#subprocessid').val();


        var servicetobankname = $('#service_to_bank_name').val();


        var title = servicetobankname + " "+ "Recieved From"+ " " + bank_name+ " " + "Between" + ' ' + startdate + ' ' +"AND "+ " " +enddate;  
      
        document.getElementById('banks_apps_modalLabel').innerHTML = title;


        
    
        // $("#banks_modal").modal("hide");
        $("#banks_apps_modal").modal("show");  

    
       
        // var title  = service_name+" "+"APPLICATIONS";
            
        document.getElementById('exampleModalLabel').innerHTML = bank_name;
    
      
        console.log(bank_email,bank_name);
       
     
       
      
       let dataSet2 = [];
       let num2 = 0;
      
      $('#banks_apps_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_applications_recieved_from_bank',
               created_for_id : bank_email,
               sub_serv_sub_id : subprocessid,
               date_from : startDate,
           date_to : endDate
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
      
   
      
        $('#banks_apps_table').DataTable().clear().destroy();
                      
        $('#banks_apps_table').DataTable({ data: dataSet2,
          dom : 'Bfrtip',
          lengthMenu : [
              [ 10, 25, 50, -1 ],
              [ '10 rows', '25 rows',
                  '50 rows', 'Show all' ] ],

                //   servicetobankname + " "+ "Recieved From"+ " " + bank_name+ " " + "Between" + ' ' + startDate + ' ' +"AND "+ " " +endDate;
         
                  buttons: [   
                    {
                        extend: 'csv',
                        title: `Report on ${servicetobankname} Recieved From ${bank_name} BETWEEN ${startdate} and ${enddate}`,
                        filename: `Report_on_${servicetobankname}_Recieved_From_${bank_name}_BETWEEN_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'excel',
                        title: `Report on ${servicetobankname} Recieved From ${bank_name} BETWEEN ${startdate} and ${enddate}`,
                        filename: `Report_on_${servicetobankname}_Recieved_From_${bank_name}_BETWEEN_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'pdf',
                        title: `Report on ${servicetobankname} Recieved From ${bank_name} BETWEEN ${startdate} and ${enddate}`,
                        filename: `Report_on_${servicetobankname}_Recieved_From_${bank_name}_BETWEEN_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'print',
                        title: `<h3>Report on ${servicetobankname} Recieved From ${bank_name} BETWEEN ${startdate} and ${enddate}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ]

            
            
            }).draw();
      
    //  }
              
      
               
      
      
           }
       })
      
      });
       



      $(document).on('click','#view_applications_pending_by_banks',function(e){
        e.preventDefault();
       
        var bank_email=$(this).data('id');
       
        var bank_name=$(this).data('name_full');


        var subprocessid = $('#subprocessid').val();


        var servicetobankname = $('#service_to_bank_name').val();


        var title = servicetobankname + " "+ "Recieved From"+ " " + bank_name+ " " + "Between" + ' ' + startdate + ' ' +"AND "+ " " +enddate;  
      
        document.getElementById('banks_apps_modalLabel').innerHTML = title;
        
        

            // $("#banks_modal").modal("hide");

    
        $("#banks_apps_modal").modal("show");  
    
       
        
    
      
        console.log(bank_email,bank_name);
       
     
       
      
       let dataSet2 = [];
       let num2 = 0;
      
      $('#banks_apps_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_applications_pending_from_bank',
               created_for_id : bank_email,
               sub_serv_sub_id : subprocessid,
               date_from : startDate,
               date_to : endDate
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
      
      
        $('#banks_apps_table').DataTable().clear().destroy();
                      
        $('#banks_apps_table').DataTable({ data: dataSet2,
          dom : 'Bfrtip',
          lengthMenu : [
              [ 10, 25, 50, -1 ],
              [ '10 rows', '25 rows',
                  '50 rows', 'Show all' ] ],
          

                  buttons: [   
                    {
                        extend: 'csv',
                        title: `Report on ${servicetobankname} Pending From ${bank_name} BETWEEN ${startdate} and ${enddate}`,
                        filename: `Report_on_${servicetobankname}_Pending_From_${bank_name}_BETWEEN_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'excel',
                        title: `Report on ${servicetobankname} Pending From ${bank_name} BETWEEN ${startdate} and ${enddate}`,
                        filename: `Report_on_${servicetobankname}_Pending_From_${bank_name}_BETWEEN_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'pdf',
                        title: `Report on ${servicetobankname} Pending From ${bank_name} BETWEEN ${startdate} and ${enddate}`,
                        filename: `Report_on_${servicetobankname}_Pending_From_${bank_name}_BETWEEN_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'print',
                        title: `<h3>Report on ${servicetobankname} Pending From ${bank_name} BETWEEN ${startdate} and ${enddate}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ]

            
            
            }).draw();
      
    //  }
              
      
               
      
      
           }
       })
      
      });
       






      $(document).on('click','#view_applications_queried_by_banks',function(e){
        e.preventDefault();
       
        var bank_email=$(this).data('id');
       
        var bank_name=$(this).data('name_full');


        var subprocessid = $('#subprocessid').val();


        var servicetobankname = $('#service_to_bank_name').val();


        var title = servicetobankname + " "+ "Queried From"+ " " + bank_name+ " " + "Between" + ' ' + startdate + ' ' +"AND "+ " " +enddate;  
      
        document.getElementById('banks_apps_modalLabel').innerHTML = title;
        
        

            // $("#banks_modal").modal("hide");

    
        $("#banks_apps_modal").modal("show");  
    
       
        
    
      
        console.log(bank_email,bank_name);
       
     
       
      
       let dataSet2 = [];
       let num2 = 0;
      
      $('#banks_apps_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_applications_queried_from_bank',
               created_for_id : bank_email,
               sub_serv_sub_id : subprocessid,
               date_from : startDate,
               date_to : endDate
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
      
      
        $('#banks_apps_table').DataTable().clear().destroy();
                      
        $('#banks_apps_table').DataTable({ data: dataSet2,
          dom : 'Bfrtip',
          lengthMenu : [
              [ 10, 25, 50, -1 ],
              [ '10 rows', '25 rows',
                  '50 rows', 'Show all' ] ],
          

                  buttons: [   
                    {
                        extend: 'csv',
                        title: `Report on ${servicetobankname} Queried From ${bank_name} BETWEEN ${startdate} and ${enddate}`,
                        filename: `Report_on_${servicetobankname}_Queried_From_${bank_name}_BETWEEN_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'excel',
                        title: `Report on ${servicetobankname} Queried From ${bank_name} BETWEEN ${startdate} and ${enddate}`,
                        filename: `Report_on_${servicetobankname}_Queried_From_${bank_name}_BETWEEN_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'pdf',
                        title: `Report on ${servicetobankname} Queried From ${bank_name} BETWEEN ${startdate} and ${enddate}`,
                        filename: `Report_on_${servicetobankname}_Queried_From_${bank_name}_BETWEEN_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'print',
                        title: `<h3>Report on ${servicetobankname} Queried From ${bank_name} BETWEEN ${startdate} and ${enddate}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ]

            
            
            }).draw();
      
    //  }
              
      
               
      
      
           }
       })
      
      });
       







      



      $(document).on('click','#view_applications_completed_by_banks',function(e){
        e.preventDefault();
       
        var bank_email=$(this).data('id');
       
        var bank_name=$(this).data('name_full');


        var subprocessid = $('#completed_subprocessid').val();

        var servicetobankname = $('#service_to_bank_name').val();


        var title = servicetobankname + " "+ "Completed From"+ " " + bank_name+ " " + "Between" + ' ' + startdate + ' ' +"AND "+ " " +enddate;  
      
        document.getElementById('banks_apps_completed_modalLabel').innerHTML = title;

        // $("#banks_modal").modal("hide");

    
        $("#banks_apps_completed_modal").modal("show");  
    
       
       
    
      
        console.log(subprocessid);
 
      
       let dataSet2 = [];
       let num2 = 0;
      
      $('#banks_apps_completed_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_applications_completed_from_bank',
               created_for_id : bank_email,
               sub_serv_sub_id : subprocessid,
               date_from : startDate,
           date_to : endDate
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
          let completed_date = json_result.apps_at_division[i].completed_date;
          let days_completed = json_result.apps_at_division[i].days_completed;
          let collected_date = json_result.apps_at_division[i].collected_date;
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
          html.push(completed_date);
          html.push(days_completed);
          html.push(collected_date);
          html.push(action);
      
          dataSet2.push(html);
      
        }
    
      
        $('#banks_apps_completed_table').DataTable().clear().destroy();
                      
        $('#banks_apps_completed_table').DataTable({ data: dataSet2,
          dom : 'Bfrtip',
          lengthMenu : [
              [ 10, 25, 50, -1 ],
              [ '10 rows', '25 rows',
                  '50 rows', 'Show all' ] ],
          
                  buttons: [   
                    {
                        extend: 'csv',
                        title: `Report on ${servicetobankname} Completed From ${bank_name} BETWEEN ${startdate} and ${enddate}`,
                        filename: `Report_on_${servicetobankname}_Completed_From_${bank_name}_BETWEEN_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'excel',
                        title: `Report on ${servicetobankname} Completed From ${bank_name} BETWEEN ${startdate} and ${enddate}`,
                        filename: `Report_on_${servicetobankname}_Completed_From_${bank_name}_BETWEEN_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'pdf',
                        title: `Report on ${servicetobankname} Completed From ${bank_name} BETWEEN ${startdate} and ${enddate}`,
                        filename: `Report_on_${servicetobankname}_Completed_From_${bank_name}_BETWEEN_${startdate}_and_${enddate}`
                    },
                    {
                        extend: 'print',
                        title: `<h3>Report on ${servicetobankname} Completed From ${bank_name} BETWEEN ${startdate} and ${enddate}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ]

            
            }).draw();
      
    //  }
              
      
               
      
      
           }
       })
      
      });




      $(document).on('click','#view_applications_top5_recieved_by_banks',function(e){
        e.preventDefault();
       
        var bank_email=$(this).data('id');
       
        var bank_name=$(this).data('name_full');


        // var subprocessid = $('#completed_subprocessid').val();

        // var servicetobankname = $('#service_to_bank_name').val();


        var title ="Applications Submitted By"+ " " + bank_name+ " " + "Between" + ' ' + startdate + ' ' +"AND "+ " " +enddate;  
      
        document.getElementById('banks_apps_modalLabel').innerHTML = title;

        // $("#banks_modal").modal("hide");

    
        $("#banks_apps_modal").modal("show");  
        
      
        console.log(bank_email);
 
        let dataSet2 = [];
       let num2 = 0;
      
      $('#banks_apps_table').DataTable().clear().destroy();
      
       $.ajax({
           type : "POST",
           url : "corporate_applications",
           data : {
               request_type : 'corporate_dashboard_two_applications_top_five_banks',
               created_for_id : bank_email,
               date_from : startDate,
               date_to : endDate
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
      
      
        $('#banks_apps_table').DataTable().clear().destroy();
                      
        $('#banks_apps_table').DataTable({ data: dataSet2,
          dom : 'Bfrtip',
          lengthMenu : [
              [ 10, 25, 50, -1 ],
              [ '10 rows', '25 rows',
                  '50 rows', 'Show all' ] ],

                //   var title ="Applications Submitted By"+ " " + bank_name+ " " + "Between" + ' ' + startDate + ' ' +"AND "+ " " +endDate;  
        
                  buttons: [
                    {
                        extend: 'csv',
                        title: `Report On Applications Submitted By ${bank_name} Between ${startdate} to ${enddate}`,
                        filename: `Report_On_Applications_Submitted_By_${bank_name}_Between_${startdate}_to_${enddate}`
                    },
                    {
                        extend: 'excel',
                        title: `Report On Applications Submitted By ${bank_name} Between ${startdate} to ${enddate}`,
                        filename: `Report_On_Applications_Submitted_By_${bank_name}_Between_${startdate}_to_${enddate}`
                    },
                    {
                        extend: 'pdf',
                        title: `Report On Applications Submitted By ${bank_name} Between ${startdate} to ${enddate}`,
                        filename: `Report_On_Applications_Submitted_By_${bank_name}_Between_${startdate}_to_${enddate}`
                    },
                    {
                        extend: 'print',
                        title: `<h3>Report On Applications Submitted By ${bank_name} Between ${startdate} to ${enddate}</h3>`,
                        message: 'This report is generated using the Enterprise Land Information System'
                    }
                ]
            
            
            }).draw();
      
    //  }
              
      
               
      
      
           }
       })



      
      });





    }
       


});






$('#btn_generate_details_reports_new').click(function(e){
    e.preventDefault();

    var status_type = $('#status_type').val();
    var selchangeregioncompliance = $('#selchangeregioncompliance').val();
    var selchangebank = $('#selchangebank').val();
    var regionNAme = $('#getRegioname').val();
    var main_service_rpt = $('#main_service_rpt').val();
    var sub_service_rpt = $('#sub_service_rpt').val();

    var newBankNAme = $('#bankNAme').val();

    

    var select_id = document.getElementById("main_service_rpt");
    var main_service = select_id.options[select_id.selectedIndex].value;
    const main_service_name_id = main_service.split('-');

    var main_service_id = main_service_name_id[0];
    var main_service_name = main_service_name_id[1];

    var sub_select_id = document.getElementById("sub_service_rpt");
    var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

    const sub_service_name_id = sub_service.split('-');
    var sub_service_id = sub_service_name_id[0];
    var sub_service_name = sub_service_name_id[1];

    main_service_id = main_service_id.replace('.0', '');

    let selectedBanks;
    if (selchangebank && selchangebank.length > 0) {
        if (selchangebank.length === 1 && selchangebank[0] === "All") {
            selectedBanks = "All Banks";
        } else {
            selectedBanks = selchangebank.join(', ');
        }
    } else {
        selectedBanks = "All Banks";
    }

    var regional_cod = $("#selchangeregioncompliance").val();
    let regional_code = Math.trunc(regional_cod);

    if(sub_service_id == 0){
        var serviename = "All Services"
    } else {
        serviename = $('#sub_service_name_input').val();
    }
    
    if (!Array.isArray(selchangebank)) {
        try {
            selchangebank = JSON.parse(selchangebank);
        } catch (e) {
            selchangebank = selchangebank ? [selchangebank] : [];
        }
    }

    if (
        !status_type ||
        regional_code === null ||
        selchangebank === null || selchangebank.length === 0 ||
        !main_service_id || main_service_id === "-1" ||
        !startDate ||
        !endDate
    ) {
        alert("Please fill in all required fields before generating the report.");
        return;
    }

    let dataSet2 = [];
    let num2 = 0;
    $('#banks_table1').DataTable().clear().destroy();


    $.ajax({
        type: "POST",
        url: "corporate_applications",
        data: {
            request_type: 'report_on_the_corporate_applications',
            region_code: regional_code,
            type_of_report_name: status_type,
            business_process_sub_id: sub_service_id,
            'bank_email[]': selchangebank,
            date_from: startDate,
            date_to: endDate
        },
        cache: false,
        success: function(response) {
            console.log(response);
            var json_result = JSON.parse(response);
            console.log(json_result.data);

            if(json_result.data == null){
                alert('No Data Found');
            } else {
                // Calculate total for percentages
                const totalApplications = json_result.data.reduce((sum, item) => sum + parseInt(item.total), 0);
                
                let title = (
                    serviename + " Report – " +
                    status_type + " Applications from " + regionNAme +
                    " by " + newBankNAme +
                    " between " + startdate + " and " + enddate
                ).toUpperCase();

                document.getElementById('banks_modalLabel1').innerHTML = title;
                $("#banks_modal1").modal("show");  

                // Prepare data for table and charts
                let dataSet2 = [];
                let chartData = [];
                
                for(let i = 0; i < json_result.data.length; i++) {
                    let html = [];
                    let created_for = json_result.data[i].created_for;
                    let total = parseInt(json_result.data[i].total);
                    let percentage = totalApplications > 0 ? ((total / totalApplications) * 100).toFixed(1) + '%' : '0%';
                    
                    let action = `<a href="javascript:void(0)" 
                        data-id="${json_result.data[i].bank_email}" 
                        data-bankname="${json_result.data[i].created_for}" 
                        data-region="${regional_code}" 
                        data-status="${status_type}" 
                        data-subid="${sub_service_id}" 
                        data-mainid="${main_service_id}"  
                        data-reportregion="${regionNAme}"   
                        id="view_applications_banks_by_service"  
                        class="btn btn-secondary">
                        View <i class="fa fa-eye"></i>
                    </a>`;
                    
                    html.push(created_for);
                    html.push(total.toLocaleString());
                    html.push(percentage);
                    html.push(action);
                    
                    dataSet2.push(html);
                    chartData.push({
                        name: created_for,
                        value: total
                    });
                }

                // Update summary statistics
                updateSummaryStats(json_result.data, totalApplications);

                // Initialize DataTable
                let safeFilename = title.replace(/[^\w\s-]/g, '').replace(/\s+/g, '_');
                
                $('#banks_table1').DataTable({
                    data: dataSet2,
                    dom: 'lBfrtip',
                    lengthMenu: [
                        [10, 25, 50, -1],
                        ['10 rows', '25 rows', '50 rows', 'Show all']
                    ],
                    buttons: [
                        {
                            extend: 'csv',
                            title: title,
                            filename: safeFilename,
                            exportOptions: {
                                columns: ':not(:last-child)'
                            }
                        },
                        {
                            extend: 'excel',
                            title: title,
                            filename: safeFilename,
                            exportOptions: {
                                columns: ':not(:last-child)'
                            }
                        },
                        {
                            extend: 'pdf',
                            title: title,
                            filename: safeFilename,
                            exportOptions: {
                                columns: ':not(:last-child)'
                            }
                        },
                        {
                            extend: 'print',
                            title: `<h3>${title}</h3>`,
                            message: 'This report is generated using the Enterprise Land Information System',
                            exportOptions: {
                                columns: ':not(:last-child)'
                            }
                        }
                    ],
                    columnDefs: [
                        { targets: -1, orderable: false }
                    ],
                    initComplete: function() {
                        // Initialize ECharts after table is ready
                        initializeECharts(chartData, totalApplications);
                    }
                });
            }
        }
    });
});

// Function to update summary statistics
function updateSummaryStats(data, totalApplications) {
    $('#totalApplications').text(totalApplications.toLocaleString());
    
    if(data.length > 0) {
        const topBank = data.reduce((max, item) => 
            parseInt(item.total) > parseInt(max.total) ? item : max, 
            data[0]);
        
        $('#topBank').text(topBank.created_for);
        $('#topBankCount').text(`${parseInt(topBank.total).toLocaleString()} applications`);
    } else {
        $('#topBank').text('-');
        $('#topBankCount').text('0 applications');
    }
    
    const avgPerBank = data.length > 0 ? 
        Math.round(totalApplications / data.length) : 0;
    $('#avgPerBank').text(avgPerBank.toLocaleString());
    $('#dateRange').text(`${startdate} to ${enddate}`);
    $('#totalCount').text(totalApplications.toLocaleString());
}

// Function to initialize ECharts
function initializeECharts(chartData, totalApplications) {
    // Initialize bar chart
    const barChart = echarts.init(document.getElementById('bankChart'));
    
    const barOption = {
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            },
            formatter: '{b}: {c} applications'
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: {
            type: 'category',
            data: chartData.map(item => item.name),
            axisLabel: {
                rotate: 30,
                interval: 0
            }
        },
        yAxis: {
            type: 'value',
            name: 'Number of Applications'
        },
        series: [{
            name: 'Applications',
            type: 'bar',
            data: chartData.map(item => item.value),
            itemStyle: {
                color: function(params) {
                    const colorList = ['#5470C6', '#91CC75', '#FAC858', '#EE6666', '#73C0DE', '#3BA272', '#FC8452', '#9A60B4', '#EA7CCC'];
                    return colorList[params.dataIndex % colorList.length];
                }
            },
            label: {
                show: true,
                position: 'top'
            }
        }]
    };
    
    barChart.setOption(barOption);
    
    // Initialize pie chart
    const pieChart = echarts.init(document.getElementById('distributionChart'));
    
    const pieOption = {
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b}: {c} ({d}%)'
        },
        legend: {
            orient: 'vertical',
            right: 10,
            top: 'center',
            data: chartData.map(item => item.name)
        },
        series: [
            {
                name: 'Distribution',
                type: 'pie',
                radius: ['50%', '70%'],
                avoidLabelOverlap: false,
                itemStyle: {
                    borderRadius: 10,
                    borderColor: '#fff',
                    borderWidth: 2
                },
                label: {
                    show: false,
                    position: 'center'
                },
                emphasis: {
                    label: {
                        show: true,
                        fontSize: '18',
                        fontWeight: 'bold',
                        formatter: function(params) {
                            return params.name + '\n' + 
                                   params.value + ' (' + params.percent + '%)';
                        }
                    }
                },
                labelLine: {
                    show: false
                },
                data: chartData
            }
        ]
    };
    
    pieChart.setOption(pieOption);
    
    // Handle window resize
    window.addEventListener('resize', function() {
        barChart.resize();
        pieChart.resize();
    });
}

// Handle save report button
$('#saveReportBtn').click(function() {
    const reportTitle = $('#banks_modalLabel').text();

    const confirmed = confirm(`Are you sure you want to save "${reportTitle}"?`);
    
    if (confirmed) {
        // Implement actual save functionality here
        alert('Your report has been saved for future reference.');
    }
});




  $(document).on('click','#view_applications_banks_by_service',function(e){
    e.preventDefault();
   
    var bank_email=$(this).data('id');
   
    var bank_name=$(this).data('bankname');
    var region=$(this).data('region');
    var status=$(this).data('status');
    var subserviceid=$(this).data('subid');
    var mainserviceid=$(this).data('mainid');


    var REPORTREGION=$(this).data('reportregion');

    

    

    console.log('Sub Service' + subserviceid);
console.log('Main Service' + mainserviceid);



let title = (
    bank_name + " Report – " +
    status + " Applications from " + REPORTREGION +
    " between " + startdate + " and " + enddate
  ).toUpperCase();


  document.getElementById('main_service_modal_title').innerHTML = title;




    $("#main_service_modal").modal("show");  

    
    

  
   let dataSet2 = [];
   let num2 = 0;
  
  $('#main_service_table').DataTable().clear().destroy();

  
   $.ajax({
       type : "POST",
       url : "corporate_applications",
       data : {
        request_type : 'report_on_the_corporate_applications_by_services',
        region_code: region,
        type_of_report_name : status,
        business_process_sub_id:subserviceid,
        bank_email: bank_email,  // ✅ This is the fix
        date_from : startDate,
        date_to : endDate
    },
       cache: false,
       success: function(response) {
  
        console.log(response)
  
           var json_result = JSON.parse(response);
           console.log(json_result.data)
  
  
    for(let i=0; i<json_result.data.length; i++) {
      let html = [];
      num2 = +num2 + 1;
  
      let service_name = json_result.data[i].service_name;
      let total = json_result.data[i].total;
     let action = `<a href="javascript:void(0)" data-id="${bank_email}" data-bankname="${bank_name}" data-region="${region}" data-status="${status}"  data-status="${status_type}"  data-subid="${subserviceid}"  data-mainid="${mainserviceid}"   data-serviceid="${json_result.data[i].business_process_id}" data-report ="${json_result.data[i].service_name}"   id="view_applications_banks_by_sub_service"  
            class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
      
  
      html.push(service_name);
      html.push(total);
      html.push(action);
  
      dataSet2.push(html);
  
    }

  
    let safeFilename = title.replace(/[^a-z0-9]/gi, '_').toLowerCase();

    // Then apply to your DataTable
    $('#main_service_table').DataTable().clear().destroy();
    
    $('#main_service_table').DataTable({
      data: dataSet2,
      dom: 'lBfrtip', // 👈 lengthMenu (l) comes before buttons
      lengthMenu: [
        [10, 25, 50, -1],
        ['10 rows', '25 rows', '50 rows', 'Show all']
      ],
      buttons: [
        {
          extend: 'csv',
          title: title,
          filename: safeFilename
        },
        {
          extend: 'excel',
          title: title,
          filename: safeFilename
        },
        {
          extend: 'pdf',
          title: title,
          filename: safeFilename
        },
        {
          extend: 'print',
          title: `<h3>${title}</h3>`,
          message: 'This report is generated using the Enterprise Land Information System'
        }
      ]
    }).draw();
  
 }
          
  
    //    }
   })
  
  });







  $(document).on('click','#view_applications_banks_by_sub_service',function(e){
    e.preventDefault();
   
    var bankemail=$(this).data('id');
   
    var bank_name=$(this).data('bankname');
    var app_region=$(this).data('region');
    var app_status=$(this).data('status');
    var app_subserviceid=$(this).data('subid');
    var app_serviceid=$(this).data('serviceid');
    var app_mainserviceid=$(this).data('mainid');
    var ReportServicename=$(this).data('report');

    

    if (app_subserviceid != 0) {
        app_serviceid = 0;
    }
    

    


    console.log('bank email' + bankemail);
    console.log('bank name'+ bank_name);
    console.log('region' + app_region);
    console.log(' sub service id' + app_subserviceid);
    console.log('app status:'+ app_status);
    console.log('service id:'+app_serviceid);
    console.log('Main service id:'+app_mainserviceid);
    



    let title = (
        ReportServicename + " Report – " +
        app_status + " Applications from " + bank_name +
        " between " + startdate + " and " + enddate
      ).toUpperCase();
    
    
      document.getElementById('sub_service_modalLabel1').innerHTML = title;



    $("#sub_service_modal1").modal("show");  

    
    

  
   let dataSet2 = [];
   let num2 = 0;
  
  $('#sub_service_table1').DataTable().clear().destroy();

  
   $.ajax({
       type : "POST",
       url : "corporate_applications",
       data : {
        request_type : 'report_on_the_corporate_applications_by_sub_services',
        region_code: app_region,
        type_of_report_name : app_status,
        business_process_sub_id:app_subserviceid,
        business_process_id:app_serviceid,
        bank_email: bankemail,
        date_from : startDate,
        date_to : endDate
    },
       cache: false,
       success: function(response) {
  
        console.log(response)
  
           var json_result = JSON.parse(response);
           console.log(json_result.data)
  
  
    for(let i=0; i<json_result.data.length; i++) {
      let html = [];
      num2 = +num2 + 1;
  
      let sub_service_name = json_result.data[i].sub_service_name;
      let total = json_result.data[i].total;
     let action = `<a href="javascript:void(0)" data-id="${bankemail}" data-bankname="${bank_name}" data-region="${app_region}" data-status="${app_status}" data-mainid="${app_mainserviceid}"  data-subid="${app_subserviceid}"   data-serviceid="${json_result.data[i].business_process_sub_id}" data-reportservname="${json_result.data[i].sub_service_name}"   id="view_applications_banks_by_sub_serviceee"  
            class="btn btn-secondary">View <i class="fa fa-eye"></i></a> `
      
  
      html.push(sub_service_name);
      html.push(total);
      html.push(action);
  
      dataSet2.push(html);
  
    }

  
    let safeFilename = title.replace(/[^a-z0-9]/gi, '_').toLowerCase();

    // Initialize DataTable
    $('#sub_service_table1').DataTable().clear().destroy();
    
    $('#sub_service_table1').DataTable({
      data: dataSet2,
      dom: 'lBfrtip', // ⬅️ Show Length Menu before Buttons
      lengthMenu: [
        [10, 25, 50, -1],
        ['10 rows', '25 rows', '50 rows', 'Show all']
      ],
      buttons: [
        {
          extend: 'csv',
          title: title,
          filename: safeFilename
        },
        {
          extend: 'excel',
          title: title,
          filename: safeFilename
        },
        {
          extend: 'pdf',
          title: title,
          filename: safeFilename
        },
        {
          extend: 'print',
          title: `<h3>${title}</h3>`,
          message: 'This report is generated using the Enterprise Land Information System'
        }
      ]
    }).draw();
  
 }
          
  
    //    }
   })
  
  });







  $(document).on('click','#view_applications_banks_by_sub_serviceee',function(e){
    e.preventDefault();
   
    var bankemail_name=$(this).data('id');
   
    var application_bank_name=$(this).data('bankname');
    var app_region_name=$(this).data('region');
    var app_status_name=$(this).data('status');
    var app_subserviceid_name=$(this).data('subid');
    var app_serviceid_name=$(this).data('serviceid');
    var app_mainserviceid_name=$(this).data('mainid');
    var ReportService=$(this).data('reportservname');


    

    if (app_subserviceid_name != 0) {
        app_subserviceid_name = 0;
    }
    

    


    console.log('bank email' + bankemail_name);
    console.log('bank name'+ application_bank_name);
    console.log('region' + app_region_name);
    console.log(' sub service id' + app_subserviceid_name);
    console.log('app status:'+ app_status_name);
    console.log('service id:'+app_serviceid_name);
    console.log('Main service id:'+app_mainserviceid_name);
    



    let title = (
        ReportService + " Report – " +
        app_status_name + " Applications from " + application_bank_name +
        " between " + startdate + " and " + enddate
      ).toUpperCase();
    
    
      document.getElementById('banks_apps_modalLabel').innerHTML = title;





    $("#banks_apps_modal").modal("show");  

    
    

  
   let dataSet2 = [];
   let num2 = 0;
  
  $('#banks_apps_table').DataTable().clear().destroy();

  
   $.ajax({
       type : "POST",
       url : "corporate_applications",
       data : {
        request_type : 'report_on_the_corporate_applications_by_applications',
        region_code: app_region_name,
        type_of_report_name : app_status_name,
        business_process_sub_id:app_serviceid_name,
        business_process_id:app_subserviceid_name,
        bank_email: bankemail_name,
        date_from : startDate,
        date_to : endDate
    },
       cache: false,
       success: function(response) {
  
        console.log(response)
  
           var json_result = JSON.parse(response);
           console.log(json_result.data)
  
  
           for(let i=0; i<json_result.data.length; i++) {
            let html = [];
            num2 = +num2 + 1;
        
            let job_number = json_result.data[i].job_number;
            let ar_name = json_result.data[i].ar_name;
            let business_process_name = json_result.data[i].business_process_name;
            let created_date = json_result.data[i].created_date;
            let days_since_received = json_result.data[i].days_since_received;
            let days_due = json_result.data[i].days_due;
            let days_since_batched = json_result.data[i].days_since_batched;
           let action = `<div class="btn-group" role="group">
           <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
             Actions
           </button>
           <div class="dropdown-menu">  
           <button type="button" class="dropdown-item" href="#" id="btn_cabinet" data-staff_name="" data-staff_id="" data-job_number="" title="View Application Progress" data-target-id="${json_result.data[i].job_number}" data-target="#cabinetModal" data-toggle="modal">Track <i class="fas fa-hdd"></i></button>
           <form class="d-inline" target="_blank" action="front_office_view_application" method="post">
             <input type="hidden" name="case_number" id="case_number" value="${json_result.data[i].transaction_number}">
             <input type="hidden" name="search_text" id="search_text" value="${json_result.data[i].case_number}">
             <input type="hidden" name="job_number" id="job_number" value=""${json_result.data[i].job_number}">
             <input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value=""${json_result.data[i].case_number}">
             <button type="submit" name="save" class="dropdown-item" >Application Details <i class="fas fa-info-circle"></i></button>
           </form> 
           </div>
         </div>`;
      
            
        
            html.push(job_number);
            html.push(ar_name);
            html.push(business_process_name);
            html.push(created_date);
            html.push(days_since_received);
            html.push(days_due);
            html.push(days_since_batched);
            html.push(action);
        
            dataSet2.push(html);
        
          }
      
        
          let safeFilename = title.replace(/[^a-z0-9]/gi, '_').toLowerCase();

          // Initialize DataTable
          $('#banks_apps_table').DataTable().clear().destroy();
          
          $('#banks_apps_table').DataTable({
            data: dataSet2,
            dom: 'lBfrtip', // length menu before buttons
            lengthMenu: [
              [10, 25, 50, -1],
              ['10 rows', '25 rows', '50 rows', 'Show all']
            ],
            buttons: [
              {
                extend: 'csv',
                title: title,
                filename: safeFilename
              },
              {
                extend: 'excel',
                title: title,
                filename: safeFilename
              },
              {
                extend: 'pdf',
                title: title,
                filename: safeFilename
              },
              {
                extend: 'print',
                title: `<h3>${title}</h3>`,
                message: 'This report is generated using the Enterprise Land Information System'
              }
            ]
          }).draw();

  
 }
          
  
    //    }
   })
  
  });




 


  });