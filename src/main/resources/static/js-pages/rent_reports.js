// Chart instances
let trendChart = null;
let distributionChart = null;
let performanceChart = null;
let customRangeModal = null;
let customDateFrom = null;
let customDateTo = null;
let rentTable;



// Initialize date pickers
flatpickr("#start_date", {
    dateFormat: "Y-m-d",
    defaultDate: "2025-01-01"
});

flatpickr("#end_date", {
    dateFormat: "Y-m-d",
    defaultDate: "2025-02-28"
});

// Initialize all charts when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    initTrendChart();
    initDistributionChart();
    initPerformanceChart();
    initResponsiveCharts();
    
    // Initialize custom range modal HTML
    createCustomRangeModal();
    
    // Load data for current month by default
    loadDefaultMonthData();
});


$(document).ready(function () {
    rentTable = $("#tbl_rent_records").DataTable({
        stateSave: true,
        responsive: false,
        createdRow: function (row, data, dataIndex) {
            // row styling logic if needed
        }
    });
});



// Function to load default month data
function loadDefaultMonthData() {
    const today = new Date();
    const firstDayOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);

    const formatDate = (d) => d.toISOString().split("T")[0];

    const startDateStr = formatDate(firstDayOfMonth);
    const endDateStr   = formatDate(today);   // 👈 today, not last day

    console.log("Start:", startDateStr, "End:", endDateStr);

    // Store the current range
    currentDateRange = {
        start: startDateStr,
        end: endDateStr,
        type: 'month'
    };

    const btn = document.querySelector('.btn-primary.dropdown-toggle');
    btn.innerHTML = `<i class="ri-calendar-line me-2"></i>This Month`;

    updateCardsWithCustomRange(startDateStr, endDateStr);
    updateChartsWithCustomRange(startDateStr, endDateStr);

    document.getElementById('start_date').value = startDateStr;
    document.getElementById('end_date').value   = endDateStr;
}



// Rent Collection Trend Chart (Line Chart)
function initTrendChart() {
    const chartDom = document.getElementById('rent-collection-trend');
    if (!chartDom) return;
    
    trendChart = echarts.init(chartDom);
    
    const option = {
        tooltip: {
            trigger: 'axis',
            backgroundColor: 'rgba(255, 255, 255, 0.95)',
            borderColor: '#e4e6ef',
            borderWidth: 1,
            textStyle: {
                color: '#6c757d',
                fontSize: 12
            },
            axisPointer: {
                type: 'shadow',
                shadowStyle: {
                    color: 'rgba(150, 150, 150, 0.1)'
                }
            },
            formatter: function(params) {
                let result = `<div style="font-weight: 600; margin-bottom: 5px; color: #495057">${params[0].axisValue}</div>`;
                params.forEach(item => {
                    const icon = item.seriesName === 'Rent Collected' ? '●' : '●';
                    const color = item.color;
                    const value = 'GHS ' + item.value.toLocaleString();
                    result += `
                        <div style="display: flex; align-items: center; margin: 5px 0;">
                            <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%; background: ${color}; margin-right: 8px;"></span>
                            <span style="flex: 1; color: #6c757d">${item.seriesName}</span>
                            <span style="font-weight: 600; color: #495057">${value}</span>
                        </div>
                    `;
                });
                return result;
            }
        },
        legend: {
            top: 10,
            right: 10,
            itemWidth: 12,
            itemHeight: 12,
            textStyle: {
                fontSize: 12,
                color: '#6c757d'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            top: '15%',
            containLabel: true
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            data: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            axisLine: {
                lineStyle: {
                    color: '#e4e6ef'
                }
            },
            axisLabel: {
                color: '#6c757d',
                fontSize: 11
            }
        },
        yAxis: {
            type: 'value',
            name: 'Amount (GHS)',
            nameTextStyle: {
                color: '#6c757d',
                fontSize: 12,
                padding: [0, 0, 0, -40]
            },
            axisLine: {
                lineStyle: {
                    color: '#e4e6ef'
                }
            },
            axisLabel: {
                color: '#6c757d',
                fontSize: 11,
                formatter: function(value) {
                    if (value >= 1000000) {
                        return (value / 1000000).toFixed(1) + 'M';
                    } else if (value >= 1000) {
                        return (value / 1000).toFixed(0) + 'K';
                    }
                    return value;
                }
            },
            splitLine: {
                lineStyle: {
                    color: '#f2f6f7',
                    type: 'dashed'
                }
            }
        },
        series: [
            {
                name: 'Rent Collected',
                type: 'line',
                smooth: true,
                symbol: 'circle',
                symbolSize: 6,
                lineStyle: {
                    width: 3,
                    color: '#0d6efd'
                },
                itemStyle: {
                    color: '#0d6efd',
                    borderColor: '#ffffff',
                    borderWidth: 2
                },
                areaStyle: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                        { offset: 0, color: 'rgba(13, 110, 253, 0.3)' },
                        { offset: 1, color: 'rgba(13, 110, 253, 0.05)' }
                    ])
                },
                data: [45000, 52000, 48000, 61000, 58000, 72000, 68000, 75000, 82000, 78000, 85000, 92000]
            },
            {
                name: 'Rent Outstanding',
                type: 'line',
                smooth: true,
                symbol: 'circle',
                symbolSize: 6,
                lineStyle: {
                    width: 3,
                    color: '#dc3545'
                },
                itemStyle: {
                    color: '#dc3545',
                    borderColor: '#ffffff',
                    borderWidth: 2
                },
                areaStyle: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                        { offset: 0, color: 'rgba(220, 53, 69, 0.3)' },
                        { offset: 1, color: 'rgba(220, 53, 69, 0.05)' }
                    ])
                },
                data: [12000, 15000, 18000, 14000, 16000, 13000, 17000, 15000, 12000, 14000, 11000, 9000]
            }
        ]
    };
    
    trendChart.setOption(option);
}

// Rent Distribution Chart (Donut/Pie Chart)
function initDistributionChart() {
    const chartDom = document.getElementById('rent-distribution-chart');
    if (!chartDom) return;
    
    distributionChart = echarts.init(chartDom);
    
    // Set initial empty option
    const option = {
        tooltip: {
            trigger: 'item',
            backgroundColor: 'rgba(255, 255, 255, 0.95)',
            borderColor: '#e4e6ef',
            borderWidth: 1,
            textStyle: {
                color: '#6c757d',
                fontSize: 12
            },
            // In the initDistributionChart function, update the tooltip formatter:
formatter: function(params) {
    const amount = params.value.toLocaleString('en-GH', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    });
    return `
        <div style="font-weight: 600; margin-bottom: 5px; color: #495057">${params.name}</div>
        <div style="display: flex; align-items: center;">
            <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%; background: ${params.color}; margin-right: 8px;"></span>
            <span style="color: #6c757d">Percentage: </span>
            <span style="font-weight: 600; margin-left: 5px; color: #495057">${params.percent}%</span>
        </div>
        <div style="margin-top: 5px; color: #6c757d">
            Outstanding: <span style="font-weight: 600; color: #495057">GHS ${amount}</span>
        </div>
    `;
}
        },
        legend: {
            show: false
        },
        series: [
            {
                name: 'Rent Distribution',
                type: 'pie',
                radius: ['40%', '70%'],
                center: ['50%', '50%'],
                avoidLabelOverlap: false,
                itemStyle: {
                    borderRadius: 8,
                    borderColor: '#fff',
                    borderWidth: 2
                },
                label: {
                    show: false
                },
                emphasis: {
                    label: {
                        show: true,
                        fontSize: '10',
                        fontWeight: 'bold',
                        formatter: '{b}'
                    }
                },
                labelLine: {
                    show: false
                },
                data: [] // Empty initially
            }
        ]
    };
    
    distributionChart.setOption(option);
}





function updateDistributionChart(estateOutstandingData) {
    if (!distributionChart) return;
    
    // If no data or empty array, show a message or fallback data
    if (!estateOutstandingData || !Array.isArray(estateOutstandingData) || estateOutstandingData.length === 0) {
        const fallbackData = [
            { value: 0, name: 'No data available', itemStyle: { color: '#6c757d' } }
        ];
        
        distributionChart.setOption({
            series: [{
                data: fallbackData
            }]
        });
        
        console.log('No estate data available for distribution chart');
        return;
    }
    
    // Define a color palette
    const colorPalette = [
        '#0d6efd', // Blue
        '#198754', // Green
        '#ffc107', // Yellow
        '#dc3545', // Red
        '#0dcaf0', // Cyan
        '#6f42c1', // Purple
        '#fd7e14', // Orange
        '#20c997', // Teal
        '#6610f2', // Indigo
        '#e83e8c'  // Pink
    ];
    
    // Process the estate data - sort by outstanding amount (descending)
    const sortedData = [...estateOutstandingData].sort((a, b) => {
        return (parseFloat(b.total_outstanding_for_estate) || 0) - (parseFloat(a.total_outstanding_for_estate) || 0);
    });
    
    const chartData = sortedData.map((estate, index) => {
        return {
            value: parseFloat(estate.total_outstanding_for_estate) || 0,
            name: estate.estate_name,
            itemStyle: {
                color: colorPalette[index % colorPalette.length]
            }
        };
    });
    
    // Update the chart
    distributionChart.setOption({
        series: [{
            data: chartData
        }]
    });
    
    console.log('Distribution chart updated with', chartData.length, 'estates');
}



function calculatePercentages(estateData) {
    if (!estateData || !Array.isArray(estateData)) return estateData;
    
    // Calculate total outstanding across all estates
    const totalOutstanding = estateData.reduce((sum, estate) => {
        return sum + (parseFloat(estate.total_outstanding_for_estate) || 0);
    }, 0);
    
    // Add percentage to each estate
    return estateData.map(estate => {
        const estateOutstanding = parseFloat(estate.total_outstanding_for_estate) || 0;
        const percentage = totalOutstanding > 0 ? (estateOutstanding / totalOutstanding * 100).toFixed(1) : 0;
        
        return {
            ...estate,
            percentage: percentage
        };
    });
}




function updateEstateList(estateOutstandingData) {
    const container = document.getElementById('estate-list-container');
    if (!container) return;
    
    // Clear existing content
    container.innerHTML = '';
    
    // If no data or empty array, show a message
    if (!estateOutstandingData || !Array.isArray(estateOutstandingData) || estateOutstandingData.length === 0) {
        container.innerHTML = `
            <div class="text-center text-muted py-3">
                <i class="ri-information-line me-1"></i>
                No estate data available
            </div>
        `;
        return;
    }
    
    // Define color palette for bullets
    const colorClasses = [
        'bg-primary',    // Blue
        'bg-success',    // Green
        'bg-warning',    // Yellow
        'bg-info',       // Cyan
        'bg-danger',     // Red
        'bg-purple',     // Purple
        'bg-orange',     // Orange
        'bg-teal',       // Teal
        'bg-indigo',     // Indigo
        'bg-pink'        // Pink
    ];
    
    // Sort estates by outstanding amount (descending)
    const sortedEstates = [...estateOutstandingData].sort((a, b) => {
        return (parseFloat(b.total_outstanding_for_estate) || 0) - (parseFloat(a.total_outstanding_for_estate) || 0);
    });
    
    // Create HTML for each estate
    sortedEstates.forEach((estate, index) => {
        const colorClass = colorClasses[index % colorClasses.length];
        const estateName = estate.estate_name || `Estate ${estate.estate_id}`;
        
        // Format the amount with Ghanaian currency formatting
        const formattedAmount = new Intl.NumberFormat('en-GH', {
            style: 'currency',
            currency: 'GHS',
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        }).format(parseFloat(estate.total_outstanding_for_estate) || 0);
        
        // Create estate item
        const estateItem = document.createElement('div');
        estateItem.className = 'd-flex justify-content-between align-items-center mb-2';
        estateItem.innerHTML = `
            <div class="d-flex align-items-center">
                <span class="bullet ${colorClass} me-2"></span>
                <span class="fs-12">${estateName}</span>
            </div>
            <span class="fs-12 fw-medium">${formattedAmount}</span>
        `;
        
        // Optional: Add click handler to highlight in chart
        estateItem.style.cursor = 'pointer';
        estateItem.addEventListener('click', function() {
            highlightEstateInChart(estate.estate_id);
        });
        
        container.appendChild(estateItem);
    });
    
    // Add total summary at the bottom
    const totalOutstanding = sortedEstates.reduce((sum, estate) => {
        return sum + (parseFloat(estate.total_outstanding_for_estate) || 0);
    }, 0);
    
    const totalFormatted = new Intl.NumberFormat('en-GH', {
        style: 'currency',
        currency: 'GHS',
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    }).format(totalOutstanding);
    
    const totalItem = document.createElement('div');
    totalItem.className = 'd-flex justify-content-between align-items-center mt-3 pt-3 border-top';
    totalItem.innerHTML = `
        <div class="d-flex align-items-center">
            <span class="bullet bg-dark me-2"></span>
            <span class="fs-12 fw-bold">Total Outstanding</span>
        </div>
        <span class="fs-12 fw-bold">${totalFormatted}</span>
    `;
    
    container.appendChild(totalItem);
}



// function updateEstatesTable(estateOutstandingData) {
//     const tableBody = document.querySelector('#estates-table tbody');
//     if (!tableBody) return;
    
//     // Clear existing rows
//     tableBody.innerHTML = '';
    
//     // If no data or empty array, show a message
//     if (!estateOutstandingData || !Array.isArray(estateOutstandingData) || estateOutstandingData.length === 0) {
//         const emptyRow = document.createElement('tr');
//         emptyRow.innerHTML = `
//             <td colspan="3" class="text-center py-4 text-muted">
//                 <i class="ri-information-line me-1"></i>
//                 No estate data available
//             </td>
//         `;
//         tableBody.appendChild(emptyRow);
//         return;
//     }
    
//     // Sort estates by total_outstanding_for_estate (descending)
//     const sortedEstates = [...estateOutstandingData].sort((a, b) => {
//         return (parseFloat(b.total_outstanding_for_estate) || 0) - (parseFloat(a.total_outstanding_for_estate) || 0);
//     });
    
//     // Create a row for each estate
//     sortedEstates.forEach((estate, index) => {
//         const row = document.createElement('tr');
        
//         // Estate name and details
//         const estateName = estate.estate_name || `Estate ${estate.estate_id}`;
//         const activeLeases = estate.total_parcels_in_estate || 0;
        
//         // Format amounts
//         const formatCurrency = (amount) => {
//             return new Intl.NumberFormat('en-GH', {
//                 style: 'currency',
//                 currency: 'GHS',
//                 minimumFractionDigits: 2,
//                 maximumFractionDigits: 2
//             }).format(parseFloat(amount) || 0);
//         };
        
//         const totalOutstanding = formatCurrency(estate.total_outstanding_for_estate);
//         const maxOutstanding = formatCurrency(estate.max_outstanding_rent);
        
//         row.innerHTML = `
//             <td class="ps-4">
//                 <div class="d-flex align-items-center">
//                     <div class="me-3">
//                         <span class="avatar avatar-xs bg-light text-primary rounded-2 d-flex align-items-center justify-content-center">
//                             ${index + 1}
//                         </span>
//                     </div>
//                     <div>
//                         <span class="d-block fw-medium">${estateName}</span>
//                         <span class="text-muted fs-11">${activeLeases} active ${activeLeases === 1 ? 'lease' : 'leases'}</span>
//                     </div>
//                 </div>
//             </td>
//             <td class="text-end">
//                 <span class="fw-medium">${totalOutstanding}</span>
//             </td>
//             <td class="text-end">
//                 <span class="text-danger fw-medium">${maxOutstanding}</span>
//             </td>
//         `;
        
//         // Optional: Add click handler to view estate details
//         row.style.cursor = 'pointer';
//         row.addEventListener('click', function() {
//             viewEstateDetails(estate.estate_id);
//         });
        
//         tableBody.appendChild(row);
//     });
// }




function updateEstatesTable(estateOutstandingData) {
    const tableBody = document.querySelector('#estates-table tbody');
    if (!tableBody) return;
    
    // Clear existing rows
    tableBody.innerHTML = '';
    
    // If no data or empty array, show a message
    if (!estateOutstandingData || !Array.isArray(estateOutstandingData) || estateOutstandingData.length === 0) {
        const emptyRow = document.createElement('tr');
        emptyRow.innerHTML = `
            <td colspan="4" class="text-center py-4 text-muted">
                <i class="ri-information-line me-1"></i>
                No estate data available
            </td>
        `;
        tableBody.appendChild(emptyRow);
        return;
    }
    
    // Sort estates by total_outstanding_for_estate (descending)
    const sortedEstates = [...estateOutstandingData].sort((a, b) => {
        return (parseFloat(b.total_outstanding_for_estate) || 0) - (parseFloat(a.total_outstanding_for_estate) || 0);
    });
    
    // Create a row for each estate
    sortedEstates.forEach((estate, index) => {
        const row = document.createElement('tr');
        
        // Estate name and details
        const estateName = estate.estate_name || `Estate ${estate.estate_id}`;
        const activeLeases = estate.total_parcels_in_estate || 0;
        
        // Format amounts
        const formatCurrency = (amount) => {
            return new Intl.NumberFormat('en-GH', {
                style: 'currency',
                currency: 'GHS',
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }).format(parseFloat(amount) || 0);
        };
        
        const totalOutstanding = formatCurrency(estate.total_outstanding_for_estate);
        const maxOutstanding = formatCurrency(estate.max_outstanding_rent);
        
        row.innerHTML = `
            <td class="ps-4">
                <div class="d-flex align-items-center">
                    <div class="me-3">
                        <span class="avatar avatar-xs bg-light text-primary rounded-2 d-flex align-items-center justify-content-center">
                            ${index + 1}
                        </span>
                    </div>
                    <div>
                        <span class="d-block fw-medium">${estateName}</span>
                        <span class="text-muted fs-11">${activeLeases} active ${activeLeases === 1 ? 'lease' : 'leases'}</span>
                    </div>
                </div>
            </td>
            <td class="text-end">
                <span class="fw-medium">${totalOutstanding}</span>
            </td>
            <td class="text-end">
                <span class="text-danger fw-medium">${maxOutstanding}</span>
            </td>
            <td class="text-end pe-4">
                <button class="btn btn-sm btn-outline-primary view-details-btn" data-estate-id="${estate.estate_id}" data-estate-name="${estateName}">
                    <i class="ri-eye-line me-1"></i>View Details
                </button>
            </td>
        `;
        
        tableBody.appendChild(row);
    });
    
    // Add event listeners to all view details buttons
    addViewDetailsEventListeners();
}



function updateRecentPaymentsTable(paymentDetailsArray) {
    const tableBody = document.querySelector('#recent-payments-table tbody');
    if (!tableBody) return;
    
    // Clear existing rows
    tableBody.innerHTML = '';
    
    // If no data or empty array, show a message
    if (!paymentDetailsArray || !Array.isArray(paymentDetailsArray) || paymentDetailsArray.length === 0) {
        const emptyRow = document.createElement('tr');
        emptyRow.innerHTML = `
            <td colspan="5" class="text-center py-4 text-muted">
                <i class="ri-information-line me-1"></i>
                No payment data available
            </td>
        `;
        tableBody.appendChild(emptyRow);
        return;
    }
    
    // Sort payments by date (descending - most recent first)
    const sortedPayments = [...paymentDetailsArray].sort((a, b) => {
        return new Date(b.payment_date) - new Date(a.payment_date);
    });
    
    // Create a row for each payment (limit to 5 or 10 most recent)
    const recentPayments = sortedPayments.slice(0, 10); // Show last 10 payments
    
    recentPayments.forEach((payment, index) => {
        const row = document.createElement('tr');
        
        // Extract first initial of lessee's name
        const lesseeInitial = payment.lessees_name ? payment.lessees_name.trim().charAt(0).toUpperCase() : '?';
        
        // Format lessee name - truncate if too long
        const lesseeName = formatLesseeName(payment.lessees_name);
        
        // Extract account number from customer_id or use payment_slip_number
        const accountNumber = extractAccountNumber(payment);
        
        // Parse property details from customer_id
        const propertyDetails = parsePropertyDetails(payment.customer_id);

         const ref_number = parsePropertyDetails(payment.ref_number);
        
        
        // Format date
        const formattedDate = formatPaymentDate(payment.payment_date);
        
        // Format amount
        const formattedAmount = formatCurrency(payment.payment_amount);
        
        row.innerHTML = `
            <td class="ps-4">
                <div class="d-flex align-items-center">
                    <div class="me-3">
                        <span class="avatar avatar-xs bg-primary-transparent text-primary rounded-circle d-flex align-items-center justify-content-center">
                            ${lesseeInitial}
                        </span>
                    </div>
                    <div>
                        <span class="d-block fw-medium fs-13">${lesseeName}</span>
                        <span class="text-muted fs-11">${accountNumber}</span>
                    </div>
                </div>
            </td>
            <td>
                <span class="d-block fs-13">${propertyDetails.plot}</span>
                <span class="text-muted fs-11">${propertyDetails.area}</span>
            </td>
            <td>
                <span class="fs-13">${formattedDate}</span>
            </td>
            <td class="text-end">
                <span class="fw-medium">${formattedAmount}</span>
            </td>
            <td class="text-end pe-4">
                <button class="btn btn-sm btn-outline-primary view-details-btn" data-estate-id="${ref_number}">
                    <i class="ri-eye-line me-1"></i> Details
                </button>
            </td>
        `;
        
        // Add click handler to view payment details
        row.style.cursor = 'pointer';
        row.addEventListener('click', function() {
            viewPaymentDetails(payment);
        });
        
        tableBody.appendChild(row);
    });
}

// Helper function to format lessee name
function formatLesseeName(fullName) {
    if (!fullName) return 'Unknown Lessee';
    
    // Remove extra spaces and limit length
    const trimmedName = fullName.trim();
    
    // Extract the main name (before any additional info in parentheses or special characters)
    let name = trimmedName;
    
    // If name contains " - " (like in your example: "FRANCISCAN MISSIONARIES OF  - MARY")
    if (name.includes(' - ')) {
        name = name.split(' - ')[0];
    }
    
    // Remove multiple spaces
    name = name.replace(/\s+/g, ' ');
    
    // Truncate if too long
    if (name.length > 30) {
        name = name.substring(0, 27) + '...';
    }
    
    // Capitalize each word
    return name.split(' ')
        .map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
        .join(' ');
}

// Helper function to extract account number
function extractAccountNumber(payment) {
    // Try to get from payment_slip_number
    if (payment.payment_slip_number) {
        return payment.payment_slip_number;
    }
    
    // Try to extract from customer_id
    if (payment.customer_id) {
        // Look for patterns like ACC-001245 in the customer_id
        const accMatch = payment.customer_id.match(/ACC[-\s]*(\d+)/i);
        if (accMatch) {
            return `ACC-${accMatch[1]}`;
        }
        
        // Look for any other identification number
        const idMatch = payment.customer_id.match(/([A-Z]{2}\d+)/);
        if (idMatch) {
            return idMatch[0];
        }
    }
    
    // Default fallback
    return 'N/A';
}

// Helper function to parse property details from customer_id
function parsePropertyDetails(customerId) {
    if (!customerId) return { plot: 'N/A', area: 'N/A' };
    
    let plot = 'N/A';
    let area = 'N/A';
    
    try {
        // Split by "PLOT NO" or "PLOT"
        const plotMatch = customerId.match(/PLOT\s*(?:NO\.?\s*)?([^,.]*)/i);
        if (plotMatch && plotMatch[1]) {
            plot = 'Plot ' + plotMatch[1].trim();
            
            // Clean up plot number (remove extra words)
            plot = plot.replace(/\s+/g, ' ');
            
            // If plot is too long, truncate
            if (plot.length > 20) {
                plot = plot.substring(0, 17) + '...';
            }
        }
        
        // Extract area/residential area name
        // Look for common area patterns
        const areaKeywords = [
            'EAST LEGON', 'AIRPORT RES', 'CANTONMENTS', 'ROMAN RIDGE', 'LABONE',
            'ACHIMOTA', 'RIDGE', 'CONCAM', 'RESIDENTIAL', 'AREA'
        ];
        
        for (const keyword of areaKeywords) {
            if (customerId.toUpperCase().includes(keyword)) {
                // Extract the area name more precisely
                const areaMatch = customerId.match(new RegExp(`([A-Z\\s]*${keyword}[A-Z\\s]*)`, 'i'));
                if (areaMatch) {
                    area = areaMatch[0].trim();
                    
                    // Clean up area name
                    area = area.replace(/\s+/g, ' ');
                    area = area.replace(/\./g, '');
                    
                    // If area is too long, truncate
                    if (area.length > 25) {
                        area = area.substring(0, 22) + '...';
                    }
                    break;
                }
            }
        }
        
        // If no area found, try to extract the last part of the customer_id
        if (area === 'N/A') {
            const parts = customerId.split(' ');
            if (parts.length > 2) {
                // Take the last few words
                area = parts.slice(-3).join(' ');
                if (area.length > 25) {
                    area = area.substring(0, 22) + '...';
                }
            }
        }
    } catch (error) {
        console.error('Error parsing property details:', error);
    }
    
    return { plot, area };
}

// Helper function to format payment date
function formatPaymentDate(dateString) {
    if (!dateString) return 'N/A';
    
    try {
        const date = new Date(dateString);
        
        // Format as YYYY-MM-DD
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        
        return `${year}-${month}-${day}`;
    } catch (error) {
        console.error('Error formatting date:', error);
        return 'Invalid Date';
    }
}

// Reusable currency formatter
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-GH', {
        style: 'currency',
        currency: 'GHS',
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    }).format(parseFloat(amount) || 0);
}

// Function to view payment details
function viewPaymentDetails(payment) {
    console.log('Viewing payment details:', payment);
    
    // Show payment details in a modal
    showPaymentDetailsModal(payment);
}

// Function to show payment details modal
function showPaymentDetailsModal(payment) {
    // Create modal HTML
    const modalHTML = `
    <div class="modal fade" id="paymentDetailsModal" tabindex="-1" aria-labelledby="paymentDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="paymentDetailsModalLabel">
                        <i class="ri-money-dollar-circle-line me-2"></i>Payment Details
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm mb-3">
                                <div class="card-body">
                                    <h6 class="card-title mb-3">Payment Information</h6>
                                    <div class="mb-2">
                                        <small class="text-muted">Payment Slip Number</small>
                                        <div class="fw-medium">${payment.payment_slip_number || 'N/A'}</div>
                                    </div>
                                    <div class="mb-2">
                                        <small class="text-muted">Payment Date</small>
                                        <div class="fw-medium">${formatPaymentDate(payment.payment_date)}</div>
                                    </div>
                                    <div class="mb-2">
                                        <small class="text-muted">Amount</small>
                                        <div class="fw-medium text-success">${formatCurrency(payment.payment_amount)}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm mb-3">
                                <div class="card-body">
                                    <h6 class="card-title mb-3">Lessee Information</h6>
                                    <div class="mb-2">
                                        <small class="text-muted">Lessee Name</small>
                                        <div class="fw-medium">${payment.lessees_name || 'N/A'}</div>
                                    </div>
                                    <div class="mb-2">
                                        <small class="text-muted">Customer ID</small>
                                        <div class="fw-medium">${payment.customer_id || 'N/A'}</div>
                                    </div>
                                    <div class="mb-2">
                                        <small class="text-muted">Locality</small>
                                        <div class="fw-medium">${payment.locality || 'N/A'}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <h6 class="card-title mb-3">Property Details</h6>
                            <div class="mb-3">
                                <small class="text-muted">Full Customer ID/Description</small>
                                <div class="border rounded p-3 bg-light">
                                    <small>${payment.customer_id || 'No details available'}</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="printPaymentReceipt('${payment.payment_slip_number}')">
                        <i class="ri-printer-line me-1"></i>Print Receipt
                    </button>
                </div>
            </div>
        </div>
    </div>
    `;
    
    // Remove existing modal if any
    const existingModal = document.getElementById('paymentDetailsModal');
    if (existingModal) {
        existingModal.remove();
    }
    
    // Add modal to body
    document.body.insertAdjacentHTML('beforeend', modalHTML);
    
    // Show the modal
    const modal = new bootstrap.Modal(document.getElementById('paymentDetailsModal'));
    modal.show();
}

// Function to print payment receipt
function printPaymentReceipt(paymentSlipNumber) {
    console.log('Printing receipt for:', paymentSlipNumber);
    // Implement print functionality here
    showToast('Print functionality would be implemented here', 'info');
}





// Function to add event listeners to view details buttons
function addViewDetailsEventListeners() {
    const viewDetailsButtons = document.querySelectorAll('.view-details-btn');
    
    viewDetailsButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.stopPropagation(); // Prevent row click event from firing
            const estateId = this.getAttribute('data-estate-id');
            const estateName = this.getAttribute('data-estate-name');
            viewEstateDetails(estateId, estateName);
        });
    });
    
    // Also add click event to entire row for navigation
    const tableRows = document.querySelectorAll('#estates-table tbody tr');
    tableRows.forEach(row => {
        // Skip if it's the empty row message
        if (row.querySelector('.view-details-btn')) {
            row.addEventListener('click', function(e) {
                // Don't trigger if clicking on the button
                if (!e.target.closest('.view-details-btn')) {
                    const button = this.querySelector('.view-details-btn');
                    if (button) {
                        const estateId = button.getAttribute('data-estate-id');
                        viewEstateDetails(estateId);
                    }
                }
            });
        }
    });
}

// Function to handle view estate details
function viewEstateDetails(estateId) {
    console.log('Viewing details for estate:', estateId);
    
    // Show loading state
    showLoading(true);
    
    // You can fetch estate details from your API
    fetchEstateDetails(estateId);
    
    // Or navigate to a details page
    // window.location.href = `estate-details.html?id=${estateId}`;
    
    // Or show a modal with estate details
    // showEstateDetailsModal(estateId);
}

// Function to fetch estate details (example)
function fetchEstateDetails(estateId) {
    var region_id = $('#sel_change_region_compliance').val();
    
    if (region_id != undefined) {
        region_id = region_id.replace(".0", "");
    }
    
    $.ajax({
        type: "POST",
        url: "rent_mgt_serv", // Your backend endpoint
        data: {
            request_type: 'select_estate_details',
            estate_id: estateId,
            office_region: region_id
        },
        cache: false,
        success: function(response) {
            try {
                const json_result = JSON.parse(response);
                showEstateDetailsModal(json_result);
            } catch (error) {
                console.error("Error parsing estate details:", error);
                showToast('Error loading estate details', 'danger');
            } finally {
                showLoading(false);
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading estate details:", error);
            showToast('Error loading estate details', 'danger');
            showLoading(false);
        }
    });
}

// Function to show estate details in a modal
function showEstateDetailsModal(estateData) {
    // Create modal HTML
    const modalHTML = `
    <div class="modal fade" id="estateDetailsModal" tabindex="-1" aria-labelledby="estateDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="estateDetailsModalLabel">
                        <i class="ri-building-line me-2"></i>${estateData.estate_name || 'Estate Details'}
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm mb-3">
                                <div class="card-body">
                                    <h6 class="card-title mb-3">Overview</h6>
                                    <div class="mb-2">
                                        <small class="text-muted">Estate ID</small>
                                        <div class="fw-medium">${estateData.estate_id || 'N/A'}</div>
                                    </div>
                                    <div class="mb-2">
                                        <small class="text-muted">Total Parcels</small>
                                        <div class="fw-medium">${estateData.total_parcels || 0}</div>
                                    </div>
                                    <div class="mb-2">
                                        <small class="text-muted">Active Leases</small>
                                        <div class="fw-medium">${estateData.active_leases || 0}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm mb-3">
                                <div class="card-body">
                                    <h6 class="card-title mb-3">Financial Summary</h6>
                                    <div class="mb-2">
                                        <small class="text-muted">Total Outstanding</small>
                                        <div class="fw-medium">${formatCurrency(estateData.total_outstanding || 0)}</div>
                                    </div>
                                    <div class="mb-2">
                                        <small class="text-muted">Maximum Outstanding</small>
                                        <div class="fw-medium text-danger">${formatCurrency(estateData.max_outstanding || 0)}</div>
                                    </div>
                                    <div class="mb-2">
                                        <small class="text-muted">Total Collected</small>
                                        <div class="fw-medium text-success">${formatCurrency(estateData.total_collected || 0)}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Additional details can be added here -->
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <h6 class="card-title mb-3">Lease Details</h6>
                            <div class="table-responsive">
                                <table class="table table-sm table-hover">
                                    <thead>
                                        <tr>
                                            <th>Parcel ID</th>
                                            <th>Tenant</th>
                                            <th class="text-end">Outstanding</th>
                                            <th class="text-end">Due Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        ${estateData.lease_details && estateData.lease_details.length > 0 
                                            ? estateData.lease_details.map(lease => `
                                                <tr>
                                                    <td>${lease.parcel_id || 'N/A'}</td>
                                                    <td>${lease.tenant_name || 'N/A'}</td>
                                                    <td class="text-end">${formatCurrency(lease.outstanding || 0)}</td>
                                                    <td class="text-end">${lease.due_date || 'N/A'}</td>
                                                </tr>
                                            `).join('')
                                            : '<tr><td colspan="4" class="text-center text-muted">No lease details available</td></tr>'
                                        }
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="exportEstateReport('${estateData.estate_id}')">
                        <i class="ri-download-line me-1"></i>Export Report
                    </button>
                </div>
            </div>
        </div>
    </div>
    `;
    
    // Remove existing modal if any
    const existingModal = document.getElementById('estateDetailsModal');
    if (existingModal) {
        existingModal.remove();
    }
    
    // Add modal to body
    document.body.insertAdjacentHTML('beforeend', modalHTML);
    
    // Show the modal
    const modal = new bootstrap.Modal(document.getElementById('estateDetailsModal'));
    modal.show();
}




function showEstateDetModal(json_result, estateName) {
    // Clear any existing estate name
    window.currentEstateName = null;
    
    console.log("Showing estate details modal for:", estateName);
    console.log("JSON result:", json_result);
    
    // Check if we have valid data
    if (!json_result || !json_result.success) {
        console.error('Invalid estate details data:', json_result);
        showToast('Error loading estate details', 'danger');
        return;
    }
    
    // Create modal HTML structure
    const modalHTML = `
        <div class="modal fade" id="estateLeaseDetailsModal" tabindex="-1" aria-labelledby="estateLeaseDetailsModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="estateLeaseDetailsModalLabel">
                            <i class="ri-building-line me-2"></i>${estateName} - Lease Details
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Estate Summary Cards -->
                        <div class="row mb-4" id="estateLeaseSummaryCards">
                            <!-- Summary cards will be populated dynamically -->
                        </div>
                        
                        <!-- Lease Details Table -->
                        <div class="card border-0 shadow-sm">
                            <div class="card-header bg-transparent border-bottom d-flex justify-content-between align-items-center">
                                <h6 class="card-title mb-0">
                                    <i class="ri-file-list-line me-2"></i>Lease Records
                                    <span class="badge bg-primary ms-2" id="totalLeasesCount">0</span>
                                </h6>
                                <div class="d-flex align-items-center">
                                    <div class="input-group input-group-sm me-2" style="width: 200px;">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="ri-search-line"></i>
                                        </span>
                                        <input type="text" class="form-control border-start-0" id="estateLeaseSearch" placeholder="Search leases...">
                                    </div>
                                    
                                </div>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0" id="estateLeasesDetailsTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="ps-4">Actions</th>
                                                <th>Account No.</th>
                                                <th>Plot Details</th>
                                                <th>Owner/Lessee</th>
                                                <th>File No.</th>
                                                <th>Comm. Date</th>
                                                <th>Term</th>
                                                <th>Plot Size</th>
                                                <th>Last Review</th>
                                                <th>Last Payment</th>
                                                <th class="text-end">Amount Status</th>
                                            </tr>
                                        </thead>
                                        <tbody id="estateLeasesTableBody">
                                            <!-- Lease rows will be populated here -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer bg-transparent border-top">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="text-muted small" id="estateLeaseSummaryText">
                                        Showing <span id="showingCount">0</span> of <span id="totalCount">0</span> leases
                                    </div>
                                    <div class="btn-group" role="group" id="estateLeasePagination">
                                        <!-- Pagination buttons will be added here -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="ri-close-line me-1"></i>Close
                        </button>
                        <button type="button" class="btn btn-primary" onclick="exportEstateLeaseReport()">
                            <i class="ri-download-line me-1"></i>Export Report
                        </button>
                    </div>
                </div>
            </div>
        </div>
    `;
    
    // Remove existing modal if any
    const existingModal = document.getElementById('estateLeaseDetailsModal');
    if (existingModal) {
        existingModal.remove();
    }
    
    // Add modal to body
    document.body.insertAdjacentHTML('beforeend', modalHTML);
    
    // Get the modal element
    const modalElement = document.getElementById('estateLeaseDetailsModal');
    
    // Show the modal
    const modal = new bootstrap.Modal(modalElement);
    modal.show();
    
    // Add event listener for when modal is fully shown
    modalElement.addEventListener('shown.bs.modal', function() {
        console.log('Modal shown, populating data...');
        // Populate the modal with data
        populateEstateLeaseDetails(json_result);
        
        // Add event listener for search
        const searchInput = document.getElementById('estateLeaseSearch');
        if (searchInput) {
            searchInput.addEventListener('input', function(e) {
                filterEstateLeases(e.target.value);
            });
        }
    });
    
    // Add modal close event to clean up
    modalElement.addEventListener('hidden.bs.modal', function() {
        modalElement.remove();
        window.currentEstateLeases = null;
    });
}

// Function to populate estate lease details
function populateEstateLeaseDetails(data) {
    // Wait for modal to be fully shown
    setTimeout(() => {
        // Get leases from data.data instead of data.leasees
        const leasees = data.data || [];
        
        console.log('Populating estate lease details with:', leasees.length, 'leases');
        
        // Update summary cards
        updateEstateLeaseSummaryCards(leasees);
        
        // Update leases table
        updateEstateLeasesTableBody(leasees);
        
        // Update summary text
        updateEstateLeaseSummaryText(leasees);
    }, 100); // Small delay to ensure modal is in DOM
}

// Function to update summary cards
function updateEstateLeaseSummaryCards(leasees) {
    const summaryCardsContainer = document.getElementById('estateLeaseSummaryCards');
    if (!summaryCardsContainer) return;
    
    // Calculate statistics
    const totalLeases = leasees.length;
    const totalOutstanding = leasees.reduce((sum, lease) => {
        const amount = parseFloat(lease.rent_outstanding) || 0;
        return sum + (amount > 0 ? amount : 0);
    }, 0);
    
    const paidLeases = leasees.filter(lease => {
        const amount = parseFloat(lease.rent_outstanding) || 0;
        return amount <= 0;
    }).length;
    
    const overdueLeases = leasees.filter(lease => {
        const amount = parseFloat(lease.rent_outstanding) || 0;
        return amount > 0;
    }).length;
    
    summaryCardsContainer.innerHTML = `
        <div class="col-md-3 col-6 mb-3">
            <div class="card border-0 bg-primary bg-opacity-10 shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0">
                            <div class="avatar-sm bg-primary bg-opacity-25 rounded-3 p-2">
                                <i class="ri-file-list-line fs-18 text-primary"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <h6 class="mb-1 text-primary">Total Leases</h6>
                            <h4 class="mb-0">${totalLeases}</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
            <div class="card border-0 bg-success bg-opacity-10 shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0">
                            <div class="avatar-sm bg-success bg-opacity-25 rounded-3 p-2">
                                <i class="ri-checkbox-circle-line fs-18 text-success"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <h6 class="mb-1 text-success">Paid Leases</h6>
                            <h4 class="mb-0">${paidLeases}</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
            <div class="card border-0 bg-danger bg-opacity-10 shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0">
                            <div class="avatar-sm bg-danger bg-opacity-25 rounded-3 p-2">
                                <i class="ri-alert-line fs-18 text-danger"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <h6 class="mb-1 text-danger">Overdue Leases</h6>
                            <h4 class="mb-0">${overdueLeases}</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
            <div class="card border-0 bg-warning bg-opacity-10 shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0">
                            <div class="avatar-sm bg-warning bg-opacity-25 rounded-3 p-2">
                                <i class="ri-money-dollar-circle-line fs-18 text-warning"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <h6 class="mb-1 text-warning">Total Outstanding</h6>
                            <h4 class="mb-0">GHS ${formatNumber(totalOutstanding)}</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `;
}

// Function to update leases table body
// Function to update leases table body - FIXED VERSION
function updateEstateLeasesTableBody(leasees) {
    // Get the table body from the estate lease details modal
    const modal = document.getElementById('estateLeaseDetailsModal');
    let tableBody = null;
    
    if (modal) {
        tableBody = modal.querySelector('#estateLeasesTableBody');
    } else {
        console.error('Estate lease details modal not found');
        return;
    }
    
    console.log('Table body element:', tableBody);
    console.log('Number of leases:', leasees.length);
    console.log('Sample lease data:', leasees[0]);
    
    // Clear existing rows
    if (tableBody) {
        tableBody.innerHTML = '';
    } else {
        console.error('Table body not found in modal');
        return;
    }
    
    if (!Array.isArray(leasees) || leasees.length === 0) {
        console.log('No lease data available');
        tableBody.innerHTML = `
            <tr>
                <td colspan="12" class="text-center py-5 text-muted">
                    <div class="py-4">
                        <i class="ri-information-line display-6 text-muted"></i>
                        <p class="mt-2 mb-0">No lease records found</p>
                        <small class="text-muted">No lease data available for this estate</small>
                    </div>
                </td>
            </tr>
        `;
        return;
    }
    
    // Process each lease and add to table
    leasees.forEach((lease, index) => {
        console.log(`Creating row for lease ${index}:`, lease.owners_name);
        try {
            const row = createEstateLeaseTableRow(lease, index);
            tableBody.appendChild(row);
        } catch (error) {
            console.error(`Error creating row for lease ${index}:`, error);
        }
    });
    
    console.log('Total rows in table:', tableBody.children.length);
    
    // Store the lease data globally for filtering
    window.currentEstateLeases = leasees;
    
    // Update total count in the modal
    const totalCountElement = modal.querySelector('#totalLeasesCount');
    if (totalCountElement) {
        totalCountElement.textContent = leasees.length;
    }
    
    // Initialize tooltips
    initializeLeaseTooltips();
}


// Helper function to create lease reminder badge
function createLeaseReminderBadge(lease) {
    // Use the last payment date or create a date based on period in arrears
    const lastPaymentDate = lease.last_payment_date || lease.comm_date;
    const periodInArrears = lease.period_in_arrears || 0;
    
    if (!lastPaymentDate || lastPaymentDate === '-') {
        return '<span class="text-muted">-</span>';
    }
    
    try {
        const lastPayment = new Date(lastPaymentDate);
        const today = new Date();
        
        // Calculate months difference
        let monthsDiff = (today.getFullYear() - lastPayment.getFullYear()) * 12;
        monthsDiff += today.getMonth() - lastPayment.getMonth();
        
        if (monthsDiff <= 0) {
            return `<span class="badge bg-success text-white">Up to date</span>`;
        } else if (monthsDiff <= 1) {
            return `<span class="badge bg-info text-white">1 month overdue</span>`;
        } else if (monthsDiff <= 3) {
            return `<span class="badge bg-warning text-dark">${monthsDiff} months overdue</span>`;
        } else {
            return `<span class="badge bg-danger text-white">${monthsDiff} months overdue</span>`;
        }
    } catch (e) {
        return `<span class="badge bg-light text-dark">Check date</span>`;
    }
}




// Function to update summary text
function updateEstateLeaseSummaryText(leasees) {
    const showingCount = document.getElementById('showingCount');
    const totalCount = document.getElementById('totalCount');
    
    if (!showingCount || !totalCount) return;
    
    const total = leasees.length;
    
    showingCount.textContent = total;
    totalCount.textContent = total;
}

// Function to update leases table body


// Function to create a lease table row
function createEstateLeaseTableRow(lease, index) {
    const row = document.createElement('tr');

    console.log("Outsdide");
    
    // Create action dropdown
    const dropdownHtml = createLeaseActionDropdown(lease);
    
    // Calculate term years
    const termYears = calculateLeaseTermYears(lease);
    
    // Format amount and determine status
    const amount = parseFloat(lease.amount) || 0;
    const formattedAmount = formatCurrency(Math.abs(amount));
    const isOutstanding = amount > 0;
    
    // Format dates
    const formatLeaseDate = (dateStr) => {
        if (!dateStr) return '-';
        try {
            const date = new Date(dateStr);
            return date.toLocaleDateString('en-GH', {
                day: '2-digit',
                month: 'short',
                year: 'numeric'
            });
        } catch (e) {
            return dateStr;
        }
    };
    
    // Create reminder badge
    const displayReminder = createLeaseReminderBadge(lease);
    
    // Truncate owner name if too long
    const ownerName = lease.owners_name || lease.lessee_name || '-';
    const truncatedOwnerName = ownerName.length > 25 ? ownerName.substring(0, 22) + '...' : ownerName;
    
    row.innerHTML = `
        <td class="ps-4">
            ${dropdownHtml}
        </td>
        <td>
            <div class="fw-medium small text-primary">${lease.account_number || lease.acc_number || '-'}</div>
        </td>
        <td>
            <div>
                <div class="fw-medium small">${lease.plot_number || lease.plot_no || '-'}</div>
                ${lease.plot_location ? `<small class="text-muted">${lease.plot_location}</small>` : ''}
            </div>
        </td>
        <td>
            <div class="text-truncate" style="max-width: 180px;" 
                 data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" 
                 title="${ownerName}">
                <small>${truncatedOwnerName}</small>
            </div>
        </td>
        <td>
            <small class="badge bg-light text-dark">${lease.file_number || '-'}</small>
        </td>
        <td>
            <small>${formatLeaseDate(lease.comm_date || lease.commencement_date)}</small>
        </td>
        <td>
            <span class="badge bg-light text-dark">${termYears}</span>
        </td>
        <td>
            ${lease.plot_size ? `<small>${lease.plot_size} ${lease.plot_unit || 'Acres'}</small>` : '-'}
        </td>
        <td>
            <small>${formatLeaseDate(lease.last_review_date)}</small>
        </td>
        <td>
            <small class="badge bg-light">${lease.file_number}</small>
        </td>
        <td class="text-end">
            <div class="fw-bold ${isOutstanding ? 'text-danger' : 'text-success'}">
                ${formattedAmount}
                <br>
                <span class="badge ${isOutstanding ? 'bg-danger-transparent text-danger' : 'bg-success-transparent text-success'}">
                    ${isOutstanding ? 'Outstanding' : 'Paid'}
                </span>
            </div>
        </td>
       
    `;
    
    return row;
}

// Helper function to create lease action dropdown
function createLeaseActionDropdown(lease) {
    const leaseId = lease.id || lease.lease_id || '';
    const dropdownId = `lease-dropdown-${leaseId || Math.random().toString(36).substr(2, 9)}`;
    
    return `
        <div class="dropdown">
            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" 
                    id="${dropdownId}" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="ri-more-2-line"></i>
            </button>
            <ul class="dropdown-menu" aria-labelledby="${dropdownId}">
                <li>
                    <a class="dropdown-item" href="#" onclick="viewSingleLeaseDetails('${leaseId}')">
                        <i class="ri-eye-line me-2"></i>View Details
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="#" onclick="editLeaseRecord('${leaseId}')">
                        <i class="ri-edit-line me-2"></i>Edit Lease
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="#" onclick="recordPayment('${leaseId}')">
                        <i class="ri-money-dollar-circle-line me-2"></i>Record Payment
                    </a>
                </li>
                <li><hr class="dropdown-divider"></li>
                <li>
                    <a class="dropdown-item text-danger" href="#" onclick="deleteLeaseRecord('${leaseId}')">
                        <i class="ri-delete-bin-line me-2"></i>Delete
                    </a>
                </li>
            </ul>
        </div>
    `;
}

// Helper function to calculate lease term years
function calculateLeaseTermYears(lease) {
    const term = lease.term_years || lease.lease_term || '';
    if (!term) return '-';
    
    // Try to extract years from string
    const yearsMatch = term.toString().match(/(\d+)/);
    if (yearsMatch) {
        const years = parseInt(yearsMatch[1]);
        return `${years} Year${years !== 1 ? 's' : ''}`;
    }
    
    return term;
}

// Helper function to create lease reminder badge
function createLeaseReminderBadge(lease) {
    const reminderDate = lease.reminder_date || lease.next_payment_date;
    if (!reminderDate) return '<span class="text-muted">-</span>';
    
    try {
        const reminder = new Date(reminderDate);
        const today = new Date();
        const diffTime = reminder - today;
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        
        if (diffDays < 0) {
            return `<span class="badge bg-danger text-white">Overdue ${Math.abs(diffDays)}d</span>`;
        } else if (diffDays <= 7) {
            return `<span class="badge bg-warning text-dark">${diffDays}d left</span>`;
        } else if (diffDays <= 30) {
            return `<span class="badge bg-info text-white">${diffDays}d left</span>`;
        } else {
            return `<span class="badge bg-light text-dark">${diffDays}d left</span>`;
        }
    } catch (e) {
        return `<span class="badge bg-light text-dark">${reminderDate}</span>`;
    }
}

// Helper function to format number (without currency symbol)
function formatNumber(number) {
    return new Intl.NumberFormat('en-GH', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    }).format(number);
}

// Initialize tooltips for lease table
function initializeLeaseTooltips() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('#estateLeasesDetailsTable [data-bs-toggle="tooltip"]'));
    tooltipTriggerList.forEach(function(tooltipTriggerEl) {
        new bootstrap.Tooltip(tooltipTriggerEl);
    });
}

// Function to update summary text
function updateEstateLeaseSummaryText(data) {
    const summaryText = document.getElementById('estateLeaseSummaryText');
    const showingCount = document.getElementById('showingCount');
    const totalCount = document.getElementById('totalCount');
    
    if (!summaryText || !showingCount || !totalCount) return;
    
    const leasees = data.leasees || data.data || [];
    const total = leasees.length;
    
    showingCount.textContent = total;
    totalCount.textContent = total;
}

// Function to filter leases based on search
function filterEstateLeases(searchTerm) {
    // Get the modal first
    const modal = document.getElementById('estateLeaseDetailsModal');
    if (!modal) return;
    
    const tableBody = modal.querySelector('#estateLeasesTableBody');
    if (!tableBody || !window.currentEstateLeases) return;
    
    searchTerm = searchTerm.toLowerCase().trim();
    
    if (searchTerm === '') {
        // Show all leases
        updateEstateLeasesTableBody(window.currentEstateLeases);
        updateEstateLeaseSummaryText(window.currentEstateLeases);
        return;
    }
    
    console.log('Filtering leases with term:', searchTerm);
    console.log('Current leases:', window.currentEstateLeases);
    
    // Filter leases - using properties that actually exist in your data
    const filteredLeases = window.currentEstateLeases.filter(lease => {
        // Check multiple properties that might contain the search term
        const searchableFields = [
            lease.account_number || '',
            lease.owners_name || '',
            lease.file_number || '',
            lease.plot_number || '',
            lease.parcel_address || '',
            lease.last_payment_period || ''
        ].map(field => field.toString().toLowerCase());
        
        return searchableFields.some(field => field.includes(searchTerm));
    });
    
    console.log('Filtered leases:', filteredLeases.length);
    
    // Update table with filtered results
    updateEstateLeasesTableBody(filteredLeases);
    
    // Update summary text in the modal
    const showingCount = modal.querySelector('#showingCount');
    const totalCount = modal.querySelector('#totalCount');
    if (showingCount && totalCount) {
        showingCount.textContent = filteredLeases.length;
        totalCount.textContent = window.currentEstateLeases.length;
    }
}


// Function to refresh estate leases
function refreshEstateLeases() {
    console.log('Refreshing estate leases...');
    showToast('Refreshing lease data...', 'info');
    
    // Get the search term
    const modal = document.getElementById('estateLeaseDetailsModal');
    if (!modal) return;
    
    const searchInput = modal.querySelector('#estateLeaseSearch');
    const searchTerm = searchInput ? searchInput.value : '';
    
    if (searchTerm) {
        // Re-apply filter
        filterEstateLeases(searchTerm);
    } else {
        // Reset to all leases
        if (window.currentEstateLeases) {
            updateEstateLeasesTableBody(window.currentEstateLeases);
            updateEstateLeaseSummaryText(window.currentEstateLeases);
        }
    }
    
    showToast('Lease data refreshed', 'success');
}

// Function to export estate lease report
function exportEstateLeaseReport() {
    console.log('Exporting estate lease report...');
    showToast('Export functionality would generate a PDF/Excel report', 'info');
    
    // Implementation would go here
    // Example: window.open(`/export/estate-leases?estate_id=${currentEstateId}`, '_blank');
}

// Action functions for dropdown items
function viewSingleLeaseDetails(leaseId) {
    console.log('Viewing single lease details:', leaseId);
    showToast(`Opening lease ${leaseId} details`, 'info');
    // Implement single lease view
}

function editLeaseRecord(leaseId) {
    console.log('Editing lease record:', leaseId);
    showToast(`Editing lease ${leaseId}`, 'info');
    // Implement lease edit
}

function recordPayment(leaseId) {
    console.log('Recording payment for lease:', leaseId);
    showToast(`Recording payment for lease ${leaseId}`, 'info');
    // Implement payment recording
}

function deleteLeaseRecord(leaseId) {
    if (confirm('Are you sure you want to delete this lease record? This action cannot be undone.')) {
        console.log('Deleting lease record:', leaseId);
        showToast(`Deleting lease ${leaseId}`, 'warning');
        // Implement lease deletion
    }
}




// Helper function to format currency (reusable)
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-GH', {
        style: 'currency',
        currency: 'GHS',
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    }).format(parseFloat(amount) || 0);
}

// Function to export estate report
function exportEstateReport(estateId) {
    console.log('Exporting report for estate:', estateId);
    // Implement export functionality here
    // Example: window.location.href = `export-estate-report.php?estate_id=${estateId}`;
    showToast('Export functionality would be implemented here', 'info');
}



// Function to handle estate row click
function viewEstateDetails(estateId, estateName) {

  var estatename = $('#estate_id').val();

    console.log('Viewing details for estate:', estateId, estatename , estateName);
    // You can implement navigation to estate details page


    $.ajax({
        type: "POST",
        url: "rent_mgt_serv", // Your backend endpoint
        data: {
            request_type: 'select_rent_leasee_details',
            select_type: estatename,
          estate: estateId,
        },
        cache: false,
        // In viewEstateDetails function, update the AJAX success handler:
            success: function(response) {
                try {
                    const json_result = JSON.parse(response);
                    // Get the estate name from somewhere (you might need to store it when clicking)
                    // var estateName = $('#estate_id option:selected').text() || `Estate ${estateId}`;
                    showEstateDetModal(json_result, estateName);
                } catch (error) {
                    console.error("Error parsing estate details:", error);
                    showToast('Error loading estate details', 'danger');
                } finally {
                    showLoading(false);
                }
            },
                    error: function(xhr, status, error) {
            console.error("Error loading estate details:", error);
            showToast('Error loading estate details', 'danger');
            showLoading(false);
        }
    });



}



// Optional: Function to highlight estate in chart when clicked
function highlightEstateInChart(estateId) {
    console.log('Highlighting estate:', estateId);
    
    // You can implement chart highlighting here
    // For example, emphasize the corresponding segment in the pie chart
    if (distributionChart) {
        distributionChart.dispatchAction({
            type: 'highlight',
            seriesIndex: 0,
            name: `Estate ${estateId}` // Or use actual estate name
        });
    }
}



// Performance Analysis Chart (Bar Chart)
function initPerformanceChart() {
    const chartDom = document.getElementById('performance-analysis-chart');
    if (!chartDom) return;
    
    performanceChart = echarts.init(chartDom);
    
    const option = {
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            },
            backgroundColor: 'rgba(255, 255, 255, 0.95)',
            borderColor: '#e4e6ef',
            borderWidth: 1,
            textStyle: {
                color: '#6c757d',
                fontSize: 12
            },
            formatter: function(params) {
                let result = `<div style="font-weight: 600; margin-bottom: 5px; color: #495057">${params[0].axisValue}</div>`;
                params.forEach(item => {
                    const color = item.color;
                    const value = item.value + '%';
                    result += `
                        <div style="display: flex; align-items: center; margin: 5px 0;">
                            <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%; background: ${color}; margin-right: 8px;"></span>
                            <span style="flex: 1; color: #6c757d">${item.seriesName}</span>
                            <span style="font-weight: 600; color: #495057">${value}</span>
                        </div>
                    `;
                });
                return result;
            }
        },
        legend: {
            top: 10,
            right: 10,
            itemWidth: 12,
            itemHeight: 12,
            textStyle: {
                fontSize: 12,
                color: '#6c757d'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            top: '15%',
            containLabel: true
        },
        xAxis: {
            type: 'category',
            data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            axisLine: {
                lineStyle: {
                    color: '#e4e6ef'
                }
            },
            axisLabel: {
                color: '#6c757d',
                fontSize: 11
            }
        },
        yAxis: {
            type: 'value',
            name: 'Collection Rate (%)',
            nameTextStyle: {
                color: '#6c757d',
                fontSize: 12,
                padding: [0, 0, 0, -40]
            },
            axisLine: {
                lineStyle: {
                    color: '#e4e6ef'
                }
            },
            axisLabel: {
                color: '#6c757d',
                fontSize: 11,
                formatter: '{value}%'
            },
            splitLine: {
                lineStyle: {
                    color: '#f2f6f7',
                    type: 'dashed'
                }
            }
        },
        series: [
            {
                name: 'Target',
                type: 'bar',
                barWidth: '30%',
                itemStyle: {
                    color: 'rgba(13, 110, 253, 0.3)',
                    borderRadius: [4, 4, 0, 0]
                },
                data: [80, 85, 82, 88, 90, 92, 95]
            },
            {
                name: 'Actual',
                type: 'bar',
                barWidth: '30%',
                itemStyle: {
                    color: '#0d6efd',
                    borderRadius: [4, 4, 0, 0]
                },
                data: [75, 80, 78, 85, 87, 90, 93]
            }
        ]
    };
    
    performanceChart.setOption(option);
}

// Make charts responsive
function initResponsiveCharts() {
    window.addEventListener('resize', function() {
        if (trendChart) trendChart.resize();
        if (distributionChart) distributionChart.resize();
        if (performanceChart) performanceChart.resize();
    });
}



// Add this right after the other chart instances
let currentDateRange = {
    start: null,
    end: null,
    type: 'month' // 'today', 'week', 'month', 'quarter', 'year', 'custom'
};




// Modified setTimeRange function to load data
function setTimeRange(range) {
    const btn = document.querySelector('.btn-primary.dropdown-toggle');
    let text = 'This Month';

    const today = new Date();
    let startDate, endDate;

    switch (range) {
        case 'today':
            text = 'Today';
            startDate = new Date(today.getFullYear(), today.getMonth(), today.getDate());
            endDate   = new Date(today.getFullYear(), today.getMonth(), today.getDate());
            break;

        case 'week':
            text = 'This Week';
            const firstDayOfWeek = new Date(today);
            firstDayOfWeek.setDate(today.getDate() - today.getDay()); // Sunday
            startDate = new Date(
                firstDayOfWeek.getFullYear(),
                firstDayOfWeek.getMonth(),
                firstDayOfWeek.getDate()
            );
            endDate = new Date(today.getFullYear(), today.getMonth(), today.getDate());
            break;

        case 'month':
            text = 'This Month';
            startDate = new Date(today.getFullYear(), today.getMonth(), 1);
            endDate   = new Date(today.getFullYear(), today.getMonth() + 1, 0);
            break;

        case 'quarter':
            text = 'This Quarter';
            const quarter = Math.floor(today.getMonth() / 3);
            const startMonth = quarter * 3;
            startDate = new Date(today.getFullYear(), startMonth, 1);
            endDate   = new Date(today.getFullYear(), startMonth + 3, 0);
            break;

        case 'year':
            text = 'This Year';
            startDate = new Date(today.getFullYear(), 0, 1);
            endDate   = new Date(today.getFullYear(), 11, 31);
            break;

        default:
            text = 'This Month';
            startDate = new Date(today.getFullYear(), today.getMonth(), 1);
            endDate   = new Date(today.getFullYear(), today.getMonth() + 1, 0);
    }

    // 🔒 Normalize to YYYY-MM-DD
    const startStr = startDate.toISOString().split('T')[0];
    const endStr   = endDate.toISOString().split('T')[0];

    btn.innerHTML = `<i class="ri-calendar-line me-2"></i>${text}`;

    // Store the current range
    currentDateRange = {
        start: startStr,
        end: endStr,
        type: range
    };

    // Always send clean strings downstream
    fetchDataForCustomRange(startStr, endStr);

    // Update date inputs
    const startInput = document.getElementById('start_date');
    const endInput   = document.getElementById('end_date');

    if (startInput && endInput) {
        startInput.value = startStr;
        endInput.value   = endStr;
    }

    console.log('Time range set:', startStr, '→', endStr);
}



function showCustomRange() {
    // Show the custom range modal
    if (!document.getElementById('customRangeModal')) {
        createCustomRangeModal();
    }
    
    customRangeModal = new bootstrap.Modal(document.getElementById('customRangeModal'), {
        keyboard: false,
        backdrop: 'static'
    });
    customRangeModal.show();
    
    initializeCustomDatePickers();
}

function createCustomRangeModal() {
    // Create modal element if it doesn't exist
    if (document.getElementById('customRangeModal')) return;
    
    const modalHTML = `
    <div class="modal fade" id="customRangeModal" tabindex="-1" aria-labelledby="customRangeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="customRangeModalLabel">Select Custom Date Range</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body">
                                    <label class="form-label fw-semibold">Date From</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-calendar-alt text-primary"></i>
                                        </span>
                                        <input type="text" id="datefrom" class="form-control" placeholder="Select Date From">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body">
                                    <label class="form-label fw-semibold">Date To</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-calendar-alt text-primary"></i>
                                        </span>
                                        <input type="text" id="dateto" class="form-control" placeholder="Select Date To">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Preset date ranges -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <label class="form-label fw-semibold">Quick Select</label>
                            <div class="d-flex flex-wrap gap-2">
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="setQuickRange('today')">
                                    Today
                                </button>
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="setQuickRange('yesterday')">
                                    Yesterday
                                </button>
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="setQuickRange('last7days')">
                                    Last 7 Days
                                </button>
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="setQuickRange('last30days')">
                                    Last 30 Days
                                </button>
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="setQuickRange('lastmonth')">
                                    Last Month
                                </button>
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="setQuickRange('thisyear')">
                                    This Year
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Date validation -->
                    <div id="dateValidation" class="alert alert-danger d-none" role="alert">
                        <i class="ri-alert-line me-2"></i>
                        <span id="validationMessage"></span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="applyCustomRange" onclick="applyCustomRange()">
                        <i class="ri-check-line me-1"></i>Apply Range
                    </button>
                </div>
            </div>
        </div>
    </div>
    `;
    
    document.body.insertAdjacentHTML('beforeend', modalHTML);
    
    // Add modal event listeners
    document.getElementById('customRangeModal').addEventListener('hidden.bs.modal', function() {
        document.getElementById('dateValidation').classList.add('d-none');
    });
}


function initializeCustomDatePickers() {
    // Destroy existing instances
    if (customDateFrom) {
        customDateFrom.destroy();
    }
    if (customDateTo) {
        customDateTo.destroy();
    }
    
    // Use the current date range if it exists, otherwise use defaults
    let defaultStartDate, defaultEndDate;
    
    if (currentDateRange.start && currentDateRange.end) {
        defaultStartDate = currentDateRange.start;
        defaultEndDate = currentDateRange.end;
    } else {
        // Get from date inputs as fallback
        const startInput = document.getElementById('start_date');
        const endInput = document.getElementById('end_date');
        
        defaultStartDate = startInput ? startInput.value : null;
        defaultEndDate = endInput ? endInput.value : null;
        
        if (!defaultStartDate) {
            defaultStartDate = new Date(new Date().setMonth(new Date().getMonth() - 1));
        } else {
            defaultStartDate = new Date(defaultStartDate);
        }
        
        if (!defaultEndDate) {
            defaultEndDate = new Date();
        } else {
            defaultEndDate = new Date(defaultEndDate);
        }
    }
    
    // Initialize date pickers with current dates
    customDateFrom = flatpickr("#datefrom", {
        dateFormat: "Y-m-d",
        defaultDate: defaultStartDate,
        maxDate: "today",
        onChange: function(selectedDates, dateStr) {
            if (customDateTo) {
                customDateTo.set('minDate', dateStr);
            }
            validateDateRange();
        }
    });
    
    customDateTo = flatpickr("#dateto", {
        dateFormat: "Y-m-d",
        defaultDate: defaultEndDate,
        maxDate: "today",
        onChange: function(selectedDates, dateStr) {
            if (customDateFrom) {
                customDateFrom.set('maxDate', dateStr);
            }
            validateDateRange();
        }
    });
    
    // Set initial min/max based on selected dates
    customDateTo.set('minDate', customDateFrom.input.value);
    customDateFrom.set('maxDate', customDateTo.input.value);
    
    // Validate the range
    validateDateRange();
}



function setQuickRange(rangeType) {
    console.log('setQuickRange called with:', rangeType);
    
    const today = new Date();
    let fromDate, toDate;
    
    switch(rangeType) {
        case 'today':
            fromDate = new Date(today);
            toDate = new Date(today);
            break;
        case 'yesterday':
            const yesterday = new Date(today);
            yesterday.setDate(today.getDate() - 1);
            fromDate = yesterday;
            toDate = new Date(yesterday);
            break;
        case 'last7days':
            const sevenDaysAgo = new Date(today);
            sevenDaysAgo.setDate(today.getDate() - 6);
            fromDate = sevenDaysAgo;
            toDate = new Date(today);
            break;
        case 'last30days':
            const thirtyDaysAgo = new Date(today);
            thirtyDaysAgo.setDate(today.getDate() - 29);
            fromDate = thirtyDaysAgo;
            toDate = new Date(today);
            break;
        case 'thismonth':
            fromDate = new Date(today.getFullYear(), today.getMonth(), 1);
            toDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
            break;
        case 'lastmonth':
            const lastMonthYear = today.getMonth() === 0 ? today.getFullYear() - 1 : today.getFullYear();
            const lastMonth = today.getMonth() === 0 ? 11 : today.getMonth() - 1;
            fromDate = new Date(lastMonthYear, lastMonth, 1);
            toDate = new Date(lastMonthYear, lastMonth + 1, 0);
            break;
        case 'thisquarter':
            const quarter = Math.floor((today.getMonth() + 3) / 3);
            const startMonth = (quarter - 1) * 3;
            fromDate = new Date(today.getFullYear(), startMonth, 1);
            toDate = new Date(today.getFullYear(), startMonth + 3, 0);
            break;
        case 'thisyear':
            fromDate = new Date(today.getFullYear(), 0, 1);
            toDate = new Date(today.getFullYear(), 11, 31);
            break;
        default:
            const defaultDaysAgo = new Date(today);
            defaultDaysAgo.setDate(today.getDate() - 29);
            fromDate = defaultDaysAgo;
            toDate = new Date(today);
    }

    console.log(`Calculated dates - From: ${fromDate}, To: ${toDate}`);
    console.log(`Formatted - From: ${fromDate.toISOString().split('T')[0]}, To: ${toDate.toISOString().split('T')[0]}`);

    // Set dates in the date pickers
    if (customDateFrom && customDateTo) {
        console.log('Setting dates in pickers...');
        customDateFrom.setDate(fromDate, true);
        customDateTo.setDate(toDate, true);
        console.log('Dates set successfully');
        
        // Force update the input fields
        document.getElementById('datefrom').value = fromDate.toISOString().split('T')[0];
        document.getElementById('dateto').value = toDate.toISOString().split('T')[0];
    } else {
        console.error('Date pickers not initialized');
    }
    
    // Validate
    validateDateRange();
}



function validateDateRange() {
    const dateFrom = document.getElementById('datefrom').value;
    const dateTo = document.getElementById('dateto').value;
    const validationDiv = document.getElementById('dateValidation');
    const validationMessage = document.getElementById('validationMessage');
    
    if (!dateFrom || !dateTo) {
        validationDiv.classList.remove('d-none');
        validationMessage.textContent = 'Please select both start and end dates';
        document.getElementById('applyCustomRange').disabled = true;
        return false;
    }
    
    const fromDate = new Date(dateFrom);
    const toDate = new Date(dateTo);
    
    if (fromDate > toDate) {
        validationDiv.classList.remove('d-none');
        validationMessage.textContent = 'Start date cannot be later than end date';
        document.getElementById('applyCustomRange').disabled = true;
        return false;
    }
    
    // Hide validation and enable button
    validationDiv.classList.add('d-none');
    document.getElementById('applyCustomRange').disabled = false;
    return true;
}

function applyCustomRange() {
    if (!validateDateRange()) {
        return;
    }
    
    const dateFrom = document.getElementById('datefrom').value;
    const dateTo = document.getElementById('dateto').value;
    
    // Store the custom range
    currentDateRange = {
        start: dateFrom,
        end: dateTo,
        type: 'custom'
    };
    
    // Update the main dropdown button text
    const btn = document.querySelector('.btn-primary.dropdown-toggle');
    const fromFormatted = formatDateForDisplay(dateFrom);
    const toFormatted = formatDateForDisplay(dateTo);
    btn.innerHTML = `<i class="ri-calendar-line me-2"></i>${fromFormatted} - ${toFormatted}`;
    
    // Update main date inputs
    if (document.getElementById('start_date') && document.getElementById('end_date')) {
        document.getElementById('start_date').value = dateFrom;
        document.getElementById('end_date').value = dateTo;
    }
    
    // Close modal
    if (customRangeModal) {
        customRangeModal.hide();
    }
    
    // Fetch data for custom range
    fetchDataForCustomRange(dateFrom, dateTo);
}




function formatDateForDisplay(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { 
        month: 'short', 
        day: 'numeric',
        year: 'numeric'
    });
}


function fetchDataForCustomRange(startDate, endDate) {
    // Convert to Date objects if they're strings
    const start = startDate instanceof Date ? startDate : new Date(startDate);
    const end = endDate instanceof Date ? endDate : new Date(endDate);
    
    console.log('Fetching data for custom range:', start, 'to', end);
    
    // Show loading state
    showLoading(true);
    
    // Update cards and charts
    updateCardsWithCustomRange(startDate, endDate);
    updateChartsWithCustomRange(startDate, endDate);
    
    // Hide loading after a short delay
    setTimeout(() => {
        showLoading(false);
        showToast('Date range applied successfully', 'success');
    }, 500);
}



function getMonthYearString(date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    const d = date instanceof Date ? date : new Date(date);
    return `${months[d.getMonth()]} ${d.getFullYear()}`;
}

function showLoading(show) {
    if (show) {
        // Create loading overlay
        const overlay = document.createElement('div');
        overlay.id = 'loadingOverlay';
        overlay.className = 'position-fixed top-0 start-0 w-100 h-100 d-flex justify-content-center align-items-center bg-dark bg-opacity-25 z-1050';
        overlay.innerHTML = `
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
        `;
        document.body.appendChild(overlay);
    } else {
        const overlay = document.getElementById('loadingOverlay');
        if (overlay) {
            overlay.remove();
        }
    }
}

function updateChartsWithCustomRange(startDate, endDate) {
    // Convert dates to Date objects
    const start = new Date(startDate);
    const end = new Date(endDate);

    console.log(start,end)
    
    // Calculate months difference
    const monthsDiff = (end.getFullYear() - start.getFullYear()) * 12 + (end.getMonth() - start.getMonth());
    
    // Update trend chart
    if (trendChart) {
        let labels = [];
        let collectedData = [];
        let outstandingData = [];
        
        if (monthsDiff <= 1) {
            // Daily data for 1 month or less
            const daysDiff = Math.ceil((end - start) / (1000 * 60 * 60 * 24));
            for (let i = 0; i <= daysDiff; i++) {
                const date = new Date(start);
                date.setDate(start.getDate() + i);
                labels.push(date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' }));
                collectedData.push(Math.floor(Math.random() * 50000) + 20000);
                outstandingData.push(Math.floor(Math.random() * 20000) + 5000);
            }
        } else if (monthsDiff <= 6) {
            // Weekly data for up to 6 months
            const weeksDiff = Math.ceil(monthsDiff * 4.33);
            for (let i = 0; i < weeksDiff; i++) {
                labels.push(`Week ${i + 1}`);
                collectedData.push(Math.floor(Math.random() * 150000) + 50000);
                outstandingData.push(Math.floor(Math.random() * 50000) + 10000);
            }
        } else {
            // Monthly data for more than 6 months
            for (let i = 0; i <= monthsDiff; i++) {
                const date = new Date(start);
                date.setMonth(start.getMonth() + i);
                labels.push(date.toLocaleDateString('en-US', { month: 'short', year: 'numeric' }));
                collectedData.push(Math.floor(Math.random() * 300000) + 100000);
                outstandingData.push(Math.floor(Math.random() * 100000) + 20000);
            }
        }
        
        trendChart.setOption({
            xAxis: {
                data: labels
            },
            series: [
                {
                    data: collectedData
                },
                {
                    data: outstandingData
                }
            ]
        });
    }
    
    console.log('Charts updated for custom range');
}




function updateCardsWithCustomRange(startDate, endDate) {


    console.log("Dashbaord Stat"+startDate,endDate);


  var region_id = $('#sel_change_region_compliance').val();

  if (region_id != undefined) {
      region_id = region_id.replace(".0", "");
    }

  console.log(region_id)

    // Convert dates to Date objects

     $.ajax({
    type: "POST",
    url: "rent_mgt_serv",
    data: {
      request_type: 'select_rent_reporting_dashboard_stats',
      office_region: region_id,
      start_date: startDate,
      end_date: endDate
    },
    cache: false,
    success: function (response) {

    //   console.log("Applications received response:", response);
          const json_result = JSON.parse(response);

          console.log(json_result)

          const formatCurrency = val =>
    Number(val).toLocaleString("en-GH", {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2
    });

  const totalCollected = json_result.total_rent_collected || 0;
  const totalOutstanding = json_result.total_rent_outstanding || 0;
  const totalLeasee = json_result.total_leasee || 0;

//   const collectionRate =
//     totalCollected + totalOutstanding > 0
//       ? ((totalCollected / (totalCollected + totalOutstanding)) * 100).toFixed(1)
//       : 0;

  // Append values
  document.getElementById("total_rent_collected").textContent =
    formatCurrency(totalCollected);

  document.getElementById("total_rent_outstanding").textContent =
    formatCurrency(totalOutstanding);

  document.getElementById("total_leasee").textContent = totalLeasee;

//   document.getElementById("collection_rate").textContent =
//     collectionRate + "%";


            // Update distribution chart with estate outstanding data
                if (json_result.estate_outstanding_rent && Array.isArray(json_result.estate_outstanding_rent)) {
                    updateDistributionChart(json_result.estate_outstanding_rent);
                    updateEstateList(json_result.estate_outstanding_rent); // Added this line
                    updateEstatesTable(json_result.estate_outstanding_rent); // Update the table

                } else {
                    console.warn('No estate outstanding data available');
                    updateEstateList([]); 
                    updateEstatesTable([]); 

                }


                 // Update recent payments table if available
                if (json_result.payment_details && Array.isArray(json_result.payment_details)) {
                    updateRecentPaymentsTable(json_result.payment_details);
                } else {
                    console.warn('No payment details available');
                    updateRecentPaymentsTable([]);
                }


    },
    error: function (xhr, status, error) {
      console.error("Error loading applications received:", error);
      alert("An error occurred while fetching application data. Please try again.");
    }
  });


}

function showToast(message, type = 'info') {
    // Create toast
    const toastHTML = `
    <div class="toast-container position-fixed top-0 end-0 p-3">
        <div id="liveToast" class="toast align-items-center text-bg-${type} border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    <i class="ri-checkbox-circle-fill me-2"></i>
                    ${message}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>
    `;
    
    // Remove existing toasts
    const existingToasts = document.querySelectorAll('.toast-container');
    existingToasts.forEach(toast => toast.remove());
    
    // Add new toast
    document.body.insertAdjacentHTML('beforeend', toastHTML);
    
    // Show toast
    const toastEl = document.getElementById('liveToast');
    const toast = new bootstrap.Toast(toastEl);
    toast.show();
}

function changeTrendChartPeriod(period) {
    const btn = document.getElementById('trendChartPeriod');
    btn.textContent = period.charAt(0).toUpperCase() + period.slice(1);
    
    // Update chart data based on period
    console.log('Chart period changed to:', period);
}

function refreshDistributionChart() {
    if (distributionChart) {
        distributionChart.showLoading();
        setTimeout(() => {
            distributionChart.hideLoading();
            console.log('Distribution chart refreshed');
        }, 500);
    }
}

function applyAnalysisFilter() {
    const filter = document.getElementById('analysis_filter').value;
    const startDate = document.getElementById('start_date').value;
    const endDate = document.getElementById('end_date').value;
    
    console.log('Applying filter:', {
        estate: filter,
        startDate: startDate,
        endDate: endDate
    });
    
    if (performanceChart) {
        performanceChart.showLoading();
        setTimeout(() => {
            performanceChart.hideLoading();
            console.log('Performance chart updated with filter');
        }, 500);
    }
}

function generatePerformanceReport() {
    console.log('Generating performance report...');
    alert('Performance report generation started. This would typically generate a PDF or Excel file.');
}

// Export report functionality
document.getElementById('exportReport').addEventListener('click', function() {
    if (trendChart) {
        const trendChartImage = trendChart.getDataURL({
            type: 'png',
            pixelRatio: 2,
            backgroundColor: '#fff'
        });
        
        const link = document.createElement('a');
        link.href = trendChartImage;
        link.download = 'rent-trend-chart.png';
        link.click();
    }
    
    console.log('Exporting dashboard report...');
});




// Advanced Filtering Functions
let estateFilterOptions = [];
let currentFilterState = {};
let searchTimeout = null;

// Initialize advanced filters
function initializeAdvancedFilters() {
    // Initialize date pickers for analysis
    flatpickr("#analysis_start_date", {
        dateFormat: "Y-m-d",
        defaultDate: "2025-01-01",
        onChange: function(selectedDates, dateStr) {
            updateFilterStats();
        }
    });

    flatpickr("#analysis_end_date", {
        dateFormat: "Y-m-d",
        defaultDate: "2025-02-28",
        onChange: function(selectedDates, dateStr) {
            updateFilterStats();
        }
    });

    // Load estate options
    loadEstateOptions();
    
    // Initialize filter stats
    updateFilterStats();
}

// Load estate options dynamically
function loadEstateOptions(forceRefresh = false) {
    // If we already have data and not forcing refresh, just populate
    if (estateFilterOptions.length > 0 && !forceRefresh) {
        populateEstateOptions();
        return;
    }
    
    // Get region ID
    var region_id = $('#sel_change_region_compliance').val();
    if (region_id != undefined) {
        region_id = region_id.replace(".0", "");
    }
    
    // Get current filter values to pass to API
    const filters = {
        request_type: 'select_rent_reporting_dashboard_stats',
        office_region: region_id,
        start_date: document.getElementById('analysis_start_date')?.value || '2025-01-01',
        end_date: document.getElementById('analysis_end_date')?.value || '2025-02-28'
    };
    
    // Show loading state
    const selectedEstateText = document.getElementById('selectedEstateText');
    const originalText = selectedEstateText.textContent;
    selectedEstateText.textContent = 'Loading estates...';
    
    // Make API call
    $.ajax({
        type: "POST",
        url: "rent_mgt_serv",
        data: filters,
        cache: false,
        success: function(response) {
            try {
                const json_result = JSON.parse(response);
                
                if (json_result.filter_counts && json_result.filter_counts.success) {
                    // Use filter_counts data from API response
                    estateFilterOptions = json_result.filter_counts.estate_options || [];
                    
                    // Populate the dropdown
                    populateEstateOptions();
                    
                    // Update "All Estates" count
                    const totalCount = json_result.filter_counts.total_count || 
                                     estateFilterOptions.reduce((sum, estate) => sum + estate.count, 0);
                    document.getElementById('estateAllCount').textContent = totalCount;
                    
                    // Update global total count for reference
                    window.totalEstatesCount = totalCount;
                    
                    console.log('Estate options loaded from API:', estateFilterOptions);
                } else {
                    // Fallback to sample data
                    // loadFallbackEstateData();
                }
            } catch (error) {
                console.error("Error parsing estate data:", error);
                // loadFallbackEstateData();
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading estate data:", error);
            // loadFallbackEstateData();
        },
        complete: function() {
            // Restore original text
            selectedEstateText.textContent = originalText;
        }
    });
}



// Populate estate options dropdown
function populateEstateOptions() {
    const container = document.getElementById('estateOptionsList');
    if (!container) return;
    
    container.innerHTML = '';
    
    estateFilterOptions.forEach(estate => {
        const option = document.createElement('div');
        option.className = 'form-check mb-2';
        option.innerHTML = `
            <input class="form-check-input" type="radio" name="estateFilter" 
                   id="estate${estate.id}" value="${estate.id}" onchange="updateEstateFilter()">
            <label class="form-check-label w-100 d-flex justify-content-between" for="estate${estate.id}">
                <span class="text-truncate" style="max-width: 180px;">${estate.name}</span>
                <span class="badge bg-light text-dark">${estate.count}</span>
            </label>
        `;
        container.appendChild(option);
    });
    
    // Update "All Estates" count
    const totalCount = estateFilterOptions.reduce((sum, estate) => sum + estate.count, 0);
    document.getElementById('estateAllCount').textContent = totalCount;
}

// Filter estate options in dropdown
function filterEstateOptions() {
    const searchTerm = document.getElementById('estateSearchInput').value.toLowerCase();
    const options = document.querySelectorAll('#estateOptionsList .form-check');
    
    options.forEach(option => {
        const label = option.querySelector('.form-check-label span').textContent.toLowerCase();
        if (label.includes(searchTerm)) {
            option.style.display = 'block';
        } else {
            option.style.display = 'none';
        }
    });
}

// Update estate filter selection
function updateEstateFilter() {
    const selectedRadio = document.querySelector('input[name="estateFilter"]:checked');
    const selectedEstateText = document.getElementById('selectedEstateText');
    
    if (!selectedRadio) return;
    
    if (selectedRadio.value === 'all') {
        selectedEstateText.textContent = 'All Estates';
    } else {
        const selectedEstate = estateFilterOptions.find(e => e.id == selectedRadio.value);
        if (selectedEstate) {
            selectedEstateText.textContent = selectedEstate.name;
        }
    }
    
    updateFilterStats();
}

// Clear estate filter
function clearEstateFilter() {
    document.getElementById('estateAll').checked = true;
    updateEstateFilter();
    document.getElementById('estateSearchInput').value = '';
    filterEstateOptions();
}

// Show advanced date picker modal
function showAdvancedDatePicker() {
    // Create and show advanced date picker modal
    const modalHTML = `
        <div class="modal fade" id="advancedDatePickerModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Select Date Range</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="form-label">Start Date</label>
                                <input type="date" class="form-control" id="modalStartDate" value="2025-01-01">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">End Date</label>
                                <input type="date" class="form-control" id="modalEndDate" value="2025-02-28">
                            </div>
                        </div>
                        
                        <div class="mt-4">
                            <label class="form-label">Quick Select</label>
                            <div class="d-flex flex-wrap gap-2">
                                <button class="btn btn-sm btn-outline-secondary" onclick="setQuickDateRange('today')">Today</button>
                                <button class="btn btn-sm btn-outline-secondary" onclick="setQuickDateRange('yesterday')">Yesterday</button>
                                <button class="btn btn-sm btn-outline-secondary" onclick="setQuickDateRange('last7days')">Last 7 Days</button>
                                <button class="btn btn-sm btn-outline-secondary" onclick="setQuickDateRange('last30days')">Last 30 Days</button>
                                <button class="btn btn-sm btn-outline-secondary" onclick="setQuickDateRange('thismonth')">This Month</button>
                                <button class="btn btn-sm btn-outline-secondary" onclick="setQuickDateRange('lastmonth')">Last Month</button>
                                <button class="btn btn-sm btn-outline-secondary" onclick="setQuickDateRange('thisyear')">This Year</button>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" onclick="applyDateRangeFromModal()">Apply Range</button>
                    </div>
                </div>
            </div>
        </div>
    `;
    
    // Remove existing modal if any
    const existingModal = document.getElementById('advancedDatePickerModal');
    if (existingModal) existingModal.remove();
    
    // Add modal to body
    document.body.insertAdjacentHTML('beforeend', modalHTML);
    
    // Show modal
    const modal = new bootstrap.Modal(document.getElementById('advancedDatePickerModal'));
    modal.show();
}

// Set quick date range from modal
function setQuickDateRange(range) {
    const today = new Date();
    let startDate, endDate;
    
    switch(range) {
        case 'today':
            startDate = today;
            endDate = today;
            break;
        case 'yesterday':
            startDate = new Date(today.setDate(today.getDate() - 1));
            endDate = startDate;
            break;
        case 'last7days':
            endDate = new Date();
            startDate = new Date(endDate.setDate(endDate.getDate() - 6));
            break;
        case 'last30days':
            endDate = new Date();
            startDate = new Date(endDate.setDate(endDate.getDate() - 29));
            break;
        case 'thismonth':
            startDate = new Date(today.getFullYear(), today.getMonth(), 1);
            endDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
            break;
        case 'lastmonth':
            startDate = new Date(today.getFullYear(), today.getMonth() - 1, 1);
            endDate = new Date(today.getFullYear(), today.getMonth(), 0);
            break;
        case 'thisyear':
            startDate = new Date(today.getFullYear(), 0, 1);
            endDate = new Date(today.getFullYear(), 11, 31);
            break;
    }
    
    document.getElementById('modalStartDate').value = startDate.toISOString().split('T')[0];
    document.getElementById('modalEndDate').value = endDate.toISOString().split('T')[0];
}

// Apply date range from modal
function applyDateRangeFromModal() {
    const startDate = document.getElementById('modalStartDate').value;
    const endDate = document.getElementById('modalEndDate').value;
    
    document.getElementById('analysis_start_date').value = startDate;
    document.getElementById('analysis_end_date').value = endDate;
    
    // Close modal
    const modal = bootstrap.Modal.getInstance(document.getElementById('advancedDatePickerModal'));
    modal.hide();
    
    updateFilterStats();
}

// Apply advanced search with debouncing
function debouncedGlobalSearch() {
    clearTimeout(searchTimeout);
    searchTimeout = setTimeout(() => {
        applyAdvancedSearch();
    }, 500);
}

// Apply advanced search
function applyAdvancedSearch() {
    const searchTerm = document.getElementById('globalSearchInput').value.trim();
    
    if (searchTerm) {
        currentFilterState.searchTerm = searchTerm;
        applyAnalysisFilter();
    }
}

// Enhanced applyAnalysisFilter function
// function applyAnalysisFilter() {
//     // Collect all filter values
//     const filters = {
//         estateId: document.querySelector('input[name="estateFilter"]:checked')?.value || 'all',
//         paymentStatus: document.getElementById('paymentStatusFilter').value,
//         leaseType: document.getElementById('leaseTypeFilter').value,
//         startDate: document.getElementById('analysis_start_date').value,
//         endDate: document.getElementById('analysis_end_date').value,
//         amountRange: document.getElementById('amountRangeFilter').value,
//         searchTerm: document.getElementById('globalSearchInput').value.trim()
//     };
    
//     // Store current filter state
//     currentFilterState = filters;
    
//     // Show loading
//     showLoading(true);
    
//     console.log('Applying filters:', filters);
    
//     // Build query parameters
//     const queryParams = new URLSearchParams();
//     if (filters.estateId !== 'all') queryParams.append('estate_id', filters.estateId);
//     if (filters.paymentStatus !== 'all') queryParams.append('status', filters.paymentStatus);
//     if (filters.leaseType !== 'all') queryParams.append('lease_type', filters.leaseType);
//     if (filters.startDate) queryParams.append('start_date', filters.startDate);
//     if (filters.endDate) queryParams.append('end_date', filters.endDate);
//     if (filters.amountRange !== 'all') queryParams.append('amount_range', filters.amountRange);
//     if (filters.searchTerm) queryParams.append('search', filters.searchTerm);
    
//     // Make API call to get filtered data
//     fetchFilteredAnalyticsData(queryParams);
    
//     // Update filter stats
//     updateFilterStats();
// }

function applyAnalysisFilter() {
    const filters = {
        estate: document.querySelector('input[name="estateFilter"]:checked')?.value || 'all',
        select_type: 'Estate',


        
        // select_type: document.getElementById('paymentStatusFilter').value,
        // lease_type: document.getElementById('leaseTypeFilter').value,
        // start_date: document.getElementById('analysis_start_date').value,
        // end_date: document.getElementById('analysis_end_date').value,
        // amount_range: document.getElementById('amountRangeFilter').value,
        // search: document.getElementById('globalSearchInput').value.trim()
    };

    

    currentFilterState = filters;
    showLoading(true);

    console.log('Applying filters:', filters);

    fetchFilteredAnalyticsData(filters);
    updateFilterStats();
}



// Fetch filtered analytics data
// function fetchFilteredAnalyticsData(queryParams) {
//     var region_id = $('#sel_change_region_compliance').val();
//     if (region_id != undefined) {
//         region_id = region_id.replace(".0", "");
//     }

    
//     // Add region to query params
//     const fullQueryParams = new URLSearchParams(queryParams.toString());
//     fullQueryParams.append('office_region', region_id);
//     fullQueryParams.append('request_type', 'select_rent_leasee_details');

//     console.log(fullQueryParams)

    
//     $.ajax({
//         type: "POST",
//         url: "rent_mgt_serv",
//         data: Object.fromEntries(fullQueryParams),
//         cache: false,
//         success: function(response) {
//             try {
//                 const json_result = JSON.parse(response);
//                 updateAnalyticsWithFilteredData(json_result);
//             } catch (error) {
//                 console.error("Error parsing filtered data:", error);
//                 showToast('Error loading filtered data', 'danger');
//             } finally {
//                 showLoading(false);
//             }
//         },
//         error: function(xhr, status, error) {
//             console.error("Error loading filtered data:", error);
//             showToast('Error loading filtered data', 'danger');
//             showLoading(false);
//         }
//     });
// }


function fetchFilteredAnalyticsData(filters) {
    let region_id = $('#sel_change_region_compliance').val();
    if (region_id) {
        region_id = region_id.replace('.0', '');
    }

    $.ajax({
        type: "POST",
        url: "rent_mgt_serv",
        data: {
            request_type: 'select_rent_leasee_details_for_report',
            // office_region: region_id,

            // 🔹 spread filters cleanly
            ...filters
        },
        cache: false,
        success: function (response) {
            try {
                const json_result = JSON.parse(response);
                console.log(json_result);

    // var datatable = $("#tbl_rent_records").DataTable({
    //     // responsive: true,
    //     stateSave : true,
    //     "createdRow" : function(row, data, dataIndex) {
    //         // if (data[0] == "1") {
    //         // 	$(row).addClass('tr-completed-work');
    //         // }
    //         // if(data[6] == 'Approved'){
    //         //     $(row).addClass('bg-success text-white');
    //         // }
    //     },
    // });
                 rentTable.clear();

                     var json_p = JSON.parse(response);

                    // Close loading dialog
                    Swal.close();

                    // Update summary cards
                    // $("#total_leasee").html(json_p.total_leasee || 0);
                    
                    // Format currency for outstanding amount
                    const totalOutstanding = parseFloat(json_p.total_rent_oustanding || 0);
                    const formattedTotal = totalOutstanding.toLocaleString('en-GH', {
                        style: 'currency',
                        currency: 'GHS',
                        minimumFractionDigits: 2
                    });
                    $("#rentOutstanding").html(formattedTotal);

                    // Clear table if no data
                    if (!json_p.data || json_p.data.length === 0) {
                        Swal.fire({
                            icon: 'info',
                            title: 'No Results Found',
                            text: 'No records match your search criteria.',
                            confirmButtonColor: '#3085d6',
                            confirmButtonText: 'OK'
                        });
                        
                        rentTable.clear().draw();
                        return;
                    }

                    // Success notification
                    // Swal.fire({
                    //     icon: 'success',
                    //     title: 'Search Complete',
                    //     text: `Found ${json_p.data.length} record(s)`,
                    //     timer: 1500,
                    //     showConfirmButton: false
                    // });

                    // Clear and repopulate table
                    rentTable.clear();

                    $(json_p.data).each(function() {
                        const amount = parseFloat(this.rent_outstanding || 0);
                        const formattedAmount = amount.toLocaleString('en-GH', {
                            style: 'currency',
                            currency: 'GHS',
                            minimumFractionDigits: 2
                        });

                        // Format dates
                        const formatDate = (dateStr) => {
                            if (!dateStr) return '-';
                            return new Date(dateStr.replace(/-/g, '/')).toLocaleDateString('en-GH', {
                                day: '2-digit',
                                month: 'short',
                                year: 'numeric'
                            });
                        };

                        // Calculate unexpired term with improved logic
                        var endDate = new Date(this.expiry_date?.replace(/-/g, "/"));
                        var today = new Date();
                        var display_reminder = '-';
                        
                        if (this.expiry_date) {
                            const diffTime = endDate - today;
                            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                            const diffYears = Math.floor(diffDays / 365);
                            
                            if (diffDays < 0) {
                                const yearsPassed = Math.abs(diffYears);
                                display_reminder = `<span class="badge bg-danger py-1 px-2">
                                    <i class="fas fa-clock me-1"></i>${yearsPassed} Year(s) Expired
                                </span>`;
                            } else if (diffDays <= 365) {
                                display_reminder = `<span class="badge bg-warning text-dark py-1 px-2">
                                    <i class="fas fa-exclamation-triangle me-1"></i>${diffDays} Day(s) Left
                                </span>`;
                            } else {
                                display_reminder = `<span class="badge bg-success py-1 px-2">
                                    <i class="fas fa-check-circle me-1"></i>${diffYears} Year(s) Left
                                </span>`;
                            }
                        }

                        // Create dropdown actions with improved icons
                        const dropdownHtml = `
                        <div class="dropdown">
                            <button class="btn btn-outline-dark btn-sm dropdown-toggle" type="button"
                                    data-bs-toggle="dropdown" aria-expanded="false"
                                    title="Actions">
                                <i class="fas fa-ellipsis-v"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end p-2" style="min-width: 220px;">
                                <li>
                                    <h6 class="dropdown-header text-primary mb-1">
                                        <i class="fas fa-user-circle me-2"></i>${this.owners_name || 'Leasee'}
                                    </h6>
                                </li>
                                <li><hr class="dropdown-divider my-1"></li>
                                <li>
                                    <a class="dropdown-item d-flex align-items-center py-2 viewLedgerBtn" href="#"
                                        data-all='${JSON.stringify(this)}'>
                                        <i class="fas fa-eye text-info me-2"></i>
                                        <div>
                                            <div class="fw-medium">View Details</div>
                                            <small class="text-muted">Complete lease information</small>
                                        </div>
                                    </a>
                                </li>

                                <li><hr class="dropdown-divider my-1"></li>
                                <li>
                                    <a class="dropdown-item d-flex align-items-center py-2" href="#"
                                        data-bs-toggle="modal" data-bs-target="#paymenthistory"
                                        data-m_id="${this.rl_id}">
                                        <i class="fas fa-history text-secondary me-2"></i>
                                        <div>
                                            <div class="fw-medium">Payment History</div>
                                            <small class="text-muted">View all payments</small>
                                        </div>
                                    </a>
                                </li>
                                
                            </ul>
                        </div>`;

                        // Format term with years
                        const termYears = this.term ? `${this.term} Year(s)` : '-';

                        // Add row with improved formatting
                        rentTable.row.add([
                            dropdownHtml,
                            `<div class="fw-medium small text-primary">${this.account_number || '-'}</div>`,
                            `<div>
                                <div class="fw-medium small">${this.plot_number || '-'}</div>
                            </div>`,
                            `<div class="text-truncate" style="max-width: 200px;" data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" title="${this.owners_name || ''}">
                                <small>${this.owners_name || '-'}</small>
                            </div>`,
                            `<small>${this.file_number}</small>`,
                            `<small>${formatDate(this.comm_date)}</small>`,
                            `<span class="badge bg-light text-dark">${termYears}</span>`,
                            this.plot_size ? `<small>${this.plot_size} Acres</small>` : '-',
                            `<small>${formatDate(this.last_review_date)}</small>`,
                            `<small>${this.last_payment_period}</small>`,
                            `<div class="text-end fw-bold ${amount > 0 ? 'text-danger' : 'text-success'}">
                                ${formattedAmount}
                                ${amount > 0 ? '<br><small class="text-muted">Outstanding</small>' : '<br><small class="text-muted">Paid</small>'}
                            </div>`,
                            display_reminder
                        ]).draw(false);
                    });

                    // Add hover effects and improve table styling
                    $('.dataTable').addClass('table-hover');
     

    
                updateAnalyticsWithFilteredData(json_result);
            } catch (error) {
                console.error("Error parsing filtered data:", error);
                showToast('Error loading filtered data', 'danger');
            } finally {
                showLoading(false);
            }
        },
        error: function (xhr, status, error) {
            console.error("Error loading filtered data:", error);
            showToast('Error loading filtered data', 'danger');
            showLoading(false);
        }
    });
}




let currentLedgerData = {};

$(document).on("click", ".viewLedgerBtn", function () {
    // Get data from the button (passed as JSON string in data-all attribute)
    const dataStr = $(this).data('all');
    currentLedgerData = typeof dataStr === 'string' ? JSON.parse(dataStr) : $(this).data();
    
    console.log('Ledger data:', currentLedgerData);
    
    // Format currency
    const formatCurrency = (amount) => {
        if (!amount) return 'GHS 0.00';
        const num = parseFloat(amount);
        return num.toLocaleString('en-GH', {
            style: 'currency',
            currency: 'GHS',
            minimumFractionDigits: 2
        });
    };
    
    // Format date
    const formatDate = (dateStr) => {
        if (!dateStr) return '-';
        try {
            const date = new Date(dateStr.replace(/-/g, '/'));
            return date.toLocaleDateString('en-GH', {
                day: '2-digit',
                month: 'short',
                year: 'numeric'
            });
        } catch (e) {
            return dateStr;
        }
    };
    
    // Populate Lessee Information
    $("#view_leasee_name").text(currentLedgerData.all?.owners_name || "-");
    $("#view_email").text(currentLedgerData.all?.email || "-");
    $("#view_address").text(currentLedgerData.all?.address || "-");
    $("#view_digital_address").text(currentLedgerData.all?.digital_address || "-");
    $("#view_mobile1").text(currentLedgerData.all?.mobile || "-");
    $("#view_mobile2").text(currentLedgerData.all?.mobile_1 || "-");
    $("#view_account_number").text(currentLedgerData.all?.account_number || "-");
    $("#view_file_number").text(currentLedgerData.all?.file_number || "-");
    
    // Populate Property Details
    $("#view_plot_number").text(currentLedgerData.all?.plot_number || "-");
    $("#view_plot_size").text(currentLedgerData.all?.plot_size ? `${currentLedgerData.all?.plot_size} sqm` : "-");
    $("#view_estate").text(currentLedgerData.all?.estate || "-");
    $("#view_ls_number").text(currentLedgerData.all?.ls_number || "-");
    $("#view_parcel_address").text(currentLedgerData.all?.parcel_address || "-");
    $("#view_ledger").text(currentLedgerData.all?.ledger || "-");
    $("#view_folio").text(currentLedgerData.all?.folio || "-");
    $("#view_convenant_user").text(currentLedgerData.all?.covenanted_user || "-");
    $("#view_current_use").text(currentLedgerData.all?.current_use || "-");
    $("#view_nature_of_dev").text(currentLedgerData.all?.nature_of_devt || "-");
    
    // Populate Lease Terms
    $("#view_commencement_date").text(formatDate(currentLedgerData.all?.comm_date));
    $("#view_term").text(currentLedgerData.all?.term ? `${currentLedgerData.all?.term} Year(s)` : "-");
    $("#view_expiry_date").text(formatDate(currentLedgerData.all?.expiry_date));
    $("#view_nature_of_instrument").text(currentLedgerData.all?.nature_of_instrument || "-");
    
    // Populate Rent Information
    $("#view_rent_category").text(currentLedgerData.all?.rent_category || "-");
    $("#view_rent_passing").text(formatCurrency(currentLedgerData.all?.rent_passing));
    $("#view_location_rate").text(formatCurrency(currentLedgerData.all?.location_rate));
    $("#view_rent_review_clause").text(currentLedgerData.all?.rent_review_clause || "-");
    
    // Populate Payment Status
    $("#view_last_payment_date").text(formatDate(currentLedgerData.all?.last_payment_date));
    $("#view_last_payment_period").text(currentLedgerData.all?.last_payment_period || "-");
    $("#view_rent_outstanding").text(formatCurrency(currentLedgerData.all?.rent_outstanding));
    $("#view_period_in_arrears").text(currentLedgerData.all?.period_in_arrears || "0");
    
    // Populate Additional Information
    $("#view_glpin").text(currentLedgerData.all?.glpin || "-");
    $("#view_remarks").text(currentLedgerData.all?.remarks || "-");
    
    // Calculate and display lease status badge
    const updateStatusBadge = () => {
        if (!currentLedgerData.expiry_date) return;
        
        const endDate = new Date(currentLedgerData.expiry_date.replace(/-/g, "/"));
        const today = new Date();
        const diffTime = endDate - today;
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        
        let statusText = '';
        let statusClass = '';
        
        if (diffDays < 0) {
            statusText = 'Expired';
            statusClass = 'bg-danger';
        } else if (diffDays <= 30) {
            statusText = 'Expiring Soon';
            statusClass = 'bg-warning text-dark';
        } else if (parseFloat(currentLedgerData.all?.rent_outstanding || 0) > 0) {
            statusText = 'Payment Due';
            statusClass = 'bg-danger';
        } else {
            statusText = 'Active';
            statusClass = 'bg-success';
        }
        
        // Add status badge to modal title
        $('#viewLedgerModalLabel').append(`
            <span class="badge ${statusClass} ms-2">${statusText}</span>
        `);
    };
    
    // Clear any existing status badge
    $('#viewLedgerModalLabel .badge').remove();
    updateStatusBadge();
    
    // Show modal using Bootstrap 5
    const modal = new bootstrap.Modal(document.getElementById('viewLedgerModal'));
    modal.show();
});




// Update analytics with filtered data
function updateAnalyticsWithFilteredData(data) {
    // Update charts with filtered data
    if (trendChart && data.trend_data) {
        trendChart.setOption({
            series: [{
                data: data.trend_data.collected || []
            }, {
                data: data.trend_data.outstanding || []
            }]
        });
    }
    
    if (distributionChart && data.distribution_data) {
        updateDistributionChart(data.distribution_data);
    }
    
    if (performanceChart && data.performance_data) {
        performanceChart.setOption({
            series: [{
                data: data.performance_data.target || []
            }, {
                data: data.performance_data.actual || []
            }]
        });
    }
    
    // Update tables
    if (data.estates_data) {
        updateEstatesTable(data.estates_data);
    }
    
    if (data.payments_data) {
        updateRecentPaymentsTable(data.payments_data);
    }
    
    // Update stats
    updateFilterStats(data.stats || {});
    
    showToast('Filters applied successfully', 'success');
}

// Update filter statistics
function updateFilterStats(stats = {}) {
    // Update estate count
    const selectedEstate = document.querySelector('input[name="estateFilter"]:checked');
    const selectedEstateText = document.getElementById('selectedEstateText').textContent;
    document.getElementById('filteredEstateCount').textContent = selectedEstateText;
    
    // Update date range
    const startDate = document.getElementById('analysis_start_date').value;
    const endDate = document.getElementById('analysis_end_date').value;
    document.getElementById('filteredDateRange').textContent = 
        `${formatDateForDisplay(startDate)} - ${formatDateForDisplay(endDate)}`;
    
    // Update amount range
    const amountRange = document.getElementById('amountRangeFilter').value;
    if (amountRange === 'all') {
        document.getElementById('filteredAmountRange').textContent = 'All Amounts';
    } else {
        document.getElementById('filteredAmountRange').textContent = 
            amountRange === '50000+' ? 'Above GHS 50,000' : `GHS ${amountRange.replace('-', ' - ').replace('+', '+')}`;
    }
    
    // Update record count
    if (stats.total_records) {
        document.getElementById('totalFilteredRecords').textContent = 
            `${stats.total_records} records`;
    }
}

// Clear all filters
function clearAllFilters() {
    // Reset all filter controls
    clearEstateFilter();
    document.getElementById('paymentStatusFilter').value = 'all';
    document.getElementById('leaseTypeFilter').value = 'all';
    document.getElementById('amountRangeFilter').value = 'all';
    document.getElementById('globalSearchInput').value = '';
    document.getElementById('analysis_start_date').value = '2025-01-01';
    document.getElementById('analysis_end_date').value = '2025-02-28';
    
    // Reset flatpickr instances
    const startPicker = flatpickr("#analysis_start_date");
    const endPicker = flatpickr("#analysis_end_date");
    startPicker.setDate('2025-01-01');
    endPicker.setDate('2025-02-28');
    
    // Clear current filter state
    currentFilterState = {};
    
    // Update stats
    updateFilterStats();
    
    // Apply default filters
    applyAnalysisFilter();
    
    showToast('All filters cleared', 'info');
}

// Export filtered data
function exportFilteredData(format) {
    const filters = currentFilterState;
    
    // Build export URL with filters
    let exportUrl = `export_analytics.php?format=${format}`;
    
    if (filters.estateId !== 'all') exportUrl += `&estate_id=${filters.estateId}`;
    if (filters.paymentStatus !== 'all') exportUrl += `&status=${filters.paymentStatus}`;
    if (filters.leaseType !== 'all') exportUrl += `&lease_type=${filters.leaseType}`;
    if (filters.startDate) exportUrl += `&start_date=${filters.startDate}`;
    if (filters.endDate) exportUrl += `&end_date=${filters.endDate}`;
    if (filters.amountRange !== 'all') exportUrl += `&amount_range=${filters.amountRange}`;
    
    // Trigger download
    window.open(exportUrl, '_blank');
    
    showToast(`Exporting data as ${format.toUpperCase()}...`, 'info');
}

// Save filter preset
function saveFilterPreset() {
    const presetName = prompt('Enter a name for this filter preset:');
    if (!presetName) return;
    
    const preset = {
        name: presetName,
        filters: currentFilterState,
        timestamp: new Date().toISOString()
    };
    
    // Save to localStorage
    let presets = JSON.parse(localStorage.getItem('rent_filter_presets') || '[]');
    presets.push(preset);
    localStorage.setItem('rent_filter_presets', JSON.stringify(presets));
    
    showToast(`Filter preset "${presetName}" saved`, 'success');
}

// Load filter presets
function loadFilterPresets() {
    const presets = JSON.parse(localStorage.getItem('rent_filter_presets') || '[]');
    
    // Create presets dropdown if needed
    if (presets.length > 0) {
        console.log('Available presets:', presets);
        // You could create a dropdown to load presets here
    }
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // ... existing initialization code ...
    
    // Initialize advanced filters
    initializeAdvancedFilters();
    loadFilterPresets();
});