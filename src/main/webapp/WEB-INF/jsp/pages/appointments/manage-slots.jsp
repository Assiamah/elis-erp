<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.gcsez-slot-management {
    background: #f8fafc;
    min-height: calc(100vh - 70px);
    margin-top: 70px;
    margin-left: 260px;
    padding: 24px;
    font-family: 'Rubik', sans-serif;
}

.gcsez-breadcrumb {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 24px;
}

.gcsez-breadcrumb-title {
    color: #111827;
    font-size: 1.5rem;
    font-weight: 600;
    margin: 0;
}

.gcsez-breadcrumb-nav {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 0.875rem;
    color: #6b7280;
}

.gcsez-breadcrumb-nav a {
    color: #6b7280;
    text-decoration: none;
}

.gcsez-breadcrumb-nav a:hover {
    color: #326573;
}

.gcsez-action-buttons {
    display: flex;
    gap: 12px;
    margin-bottom: 24px;
    flex-wrap: wrap;
}

.gcsez-btn {
    background: #326573;
    color: white;
    border: none;
    border-radius: 8px;
    padding: 10px 20px;
    font-size: 0.875rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
    gap: 6px;
    text-decoration: none;
}

.gcsez-btn:hover {
    background: #2a5561;
    transform: translateY(-1px);
    color: white;
    text-decoration: none;
}

.gcsez-btn.success {
    background: #57a394;
}

.gcsez-btn.success:hover {
    background: #4a8c7e;
}

.gcsez-btn.info {
    background: #c5bb85;
}

.gcsez-btn.info:hover {
    background: #b4a972;
}

.gcsez-main-grid {
    display: grid;
    grid-template-columns: 1fr 320px;
    gap: 24px;
    align-items: start;
}

.gcsez-main-card {
    background: #ffffff;
    border: 1px solid #e5e7eb;
    border-radius: 12px;
    overflow: hidden;
}

.gcsez-card-header {
    padding: 20px 24px;
    border-bottom: 1px solid #e5e7eb;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.gcsez-card-title {
    font-size: 1.125rem;
    font-weight: 400;
    color: #111827;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 8px;
}

.gcsez-calendar-controls {
    display: flex;
    align-items: center;
    gap: 12px;
}

.gcsez-control-group {
    display: flex;
    align-items: center;
    gap: 4px;
}

.gcsez-btn-sm {
    padding: 6px 12px;
    font-size: 0.75rem;
    border: 1px solid #d1d5db;
    background: white;
    color: #374151;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.2s ease;
}

.gcsez-btn-sm:hover {
    background: #f9fafb;
    border-color: #9ca3af;
}

.gcsez-select-sm {
    padding: 6px 32px 6px 12px;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    font-size: 0.75rem;
    background: white;
    color: #374151;
}

.gcsez-card-body {
    padding: 0;
}

/* Calendar Styling */
#calendar {
    padding: 20px;
}

.fc {
    font-family: 'Rubik', sans-serif;
}

.fc .fc-toolbar-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #111827;
}

.fc .fc-button {
    background: #326573;
    border-color: #326573;
    font-size: 0.875rem;
    font-weight: 500;
    padding: 6px 12px;
}

.fc .fc-button:hover {
    background: #2a5561;
    border-color: #2a5561;
}

.fc .fc-button-primary:not(:disabled).fc-button-active {
    background: #2a5561;
    border-color: #2a5561;
}

/* Sidebar Cards */
.gcsez-sidebar-cards {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.gcsez-summary-card {
    background: #ffffff;
    border: 1px solid #e5e7eb;
    border-radius: 12px;
    padding: 20px;
}

.gcsez-summary-title {
    font-size: 1rem;
    font-weight: 600;
    color: #111827;
    margin: 0 0 16px 0;
    display: flex;
    align-items: center;
    gap: 8px;
}

.gcsez-summary-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 12px 0;
    border-bottom: 1px solid #f3f4f6;
}

.gcsez-summary-item:last-child {
    border-bottom: none;
}

.gcsez-summary-label {
    color: #6b7280;
    font-size: 0.875rem;
    font-weight: 100;
}

.gcsez-badge {
    padding: 4px 8px;
    border-radius: 6px;
    font-size: 0.75rem;
    font-weight: 500;
    min-width: 40px;
    text-align: center;
}

.gcsez-badge.primary { background: #326573; color: white; }
.gcsez-badge.success { background: #57a394; color: white; }
.gcsez-badge.info { background: #c5bb85; color: white; }
.gcsez-badge.warning { background: #b48478; color: white; }

.gcsez-activity-card {
    background: #ffffff;
    border: 1px solid #e5e7eb;
    border-radius: 12px;
    overflow: hidden;
}

.gcsez-activity-header {
    padding: 16px 20px;
    border-bottom: 1px solid #e5e7eb;
}

.gcsez-activity-title {
    font-size: 1rem;
    font-weight: 600;
    color: #111827;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 8px;
}

.gcsez-activity-list {
    max-height: 200px;
    overflow-y: auto;
    padding: 0;
}

.gcsez-activity-item {
    padding: 12px 20px;
    border-bottom: 1px solid #f3f4f6;
    font-size: 0.875rem;
}

.gcsez-activity-item:last-child {
    border-bottom: none;
}

.gcsez-activity-time {
    color: #6b7280;
    font-size: 0.75rem;
    margin-bottom: 4px;
}

.gcsez-activity-message {
    color: #374151;
    line-height: 1.4;
}

.gcsez-empty-state {
    padding: 40px 20px;
    text-align: center;
    color: #6b7280;
}

.gcsez-empty-state i {
    font-size: 2rem;
    margin-bottom: 12px;
    color: #d1d5db;
}

/* Mobile Responsiveness */
@media (max-width: 1200px) {
    .gcsez-main-grid {
        grid-template-columns: 1fr;
    }
    
    .gcsez-sidebar-cards {
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        display: grid;
    }
}

@media (max-width: 768px) {
    .gcsez-slot-management {
        margin-left: 0;
        padding: 16px;
    }
    
    .gcsez-breadcrumb {
        flex-direction: column;
        align-items: flex-start;
        gap: 12px;
    }
    
    .gcsez-action-buttons {
        flex-direction: column;
        align-items: stretch;
    }
    
    .gcsez-btn {
        justify-content: center;
    }
    
    .gcsez-calendar-controls {
        flex-wrap: wrap;
        justify-content: center;
    }
    
    .gcsez-card-header {
        flex-direction: column;
        gap: 12px;
        align-items: stretch;
    }
}
</style>

<link href="https://fonts.googleapis.com/css2?family=Rubik:wght@300;400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<main class="gcsez-slot-management">
    <div class="gcsez-breadcrumb">
        <h1 class="gcsez-breadcrumb-title">Manage Time Slots</h1>
        <nav class="gcsez-breadcrumb-nav">
            <a href="javascript:void(0)">Appointments</a>
            <span>/</span>
            <span>Manage Slots</span>
        </nav>
    </div>
    
    <!-- Action buttons -->
    <div class="gcsez-action-buttons">
        <button type="button" class="gcsez-btn" data-bs-toggle="modal" data-bs-target="#createSlotModal">
            <i class="fas fa-plus-circle"></i> Create Single Slot
        </button>
        <button type="button" class="gcsez-btn success" data-bs-toggle="modal" data-bs-target="#batchSlotsModal">
            <i class="fas fa-layer-group"></i> Create Multiple Slots
        </button>
        <button type="button" class="gcsez-btn info" id="viewSlotsBtn">
            <i class="fas fa-sync-alt"></i> Refresh Slots
        </button>
    </div>

    <div class="gcsez-main-grid">
        <!-- Main Calendar Area -->
        <div class="gcsez-main-card">
            <div class="gcsez-card-header">
                <h2 class="gcsez-card-title">
                    <i class="fas fa-calendar-alt"></i> Calendar View
                </h2>
                <div class="gcsez-calendar-controls">
                    <div class="gcsez-control-group">
                        <button class="gcsez-btn-sm" id="todayBtn">Today</button>
                        <button class="gcsez-btn-sm" id="prevBtn">
                            <i class="fas fa-chevron-left"></i>
                        </button>
                        <button class="gcsez-btn-sm" id="nextBtn">
                            <i class="fas fa-chevron-right"></i>
                        </button>
                    </div>
                    <select class="gcsez-select-sm" id="viewSelector">
                        <option value="dayGridMonth">Month</option>
                        <option value="timeGridWeek" selected>Week</option>
                        <option value="timeGridDay">Day</option>
                        <option value="listWeek">List</option>
                    </select>
                </div>
            </div>
            <div class="gcsez-card-body">
                <div id="calendar"></div>
            </div>
        </div>
        
        <!-- Sidebar -->
        <div class="gcsez-sidebar-cards">
            <!-- Slot Summary Card -->
            <div class="gcsez-summary-card">
                <h3 class="gcsez-summary-title">
                    <i class="fas fa-chart-pie"></i> Slot Summary
                </h3>
                <div class="gcsez-summary-list">
                    <div class="gcsez-summary-item">
                        <span class="gcsez-summary-label">Total Slots</span>
                        <span class="gcsez-badge primary" id="totalSlots">0</span>
                    </div>
                    <div class="gcsez-summary-item">
                        <span class="gcsez-summary-label">Available Slots</span>
                        <span class="gcsez-badge success" id="availableSlots">0</span>
                    </div>
                    <div class="gcsez-summary-item">
                        <span class="gcsez-summary-label">Booked Slots</span>
                        <span class="gcsez-badge info" id="bookedSlots">0</span>
                    </div>
                    <div class="gcsez-summary-item">
                        <span class="gcsez-summary-label">Full Slots</span>
                        <span class="gcsez-badge warning" id="fullSlots">0</span>
                    </div>
                </div>
            </div>
            
            <!-- Recent Activity Card -->
            <div class="gcsez-activity-card">
                <div class="gcsez-activity-header">
                    <h3 class="gcsez-activity-title">
                        <i class="fas fa-history"></i> Recent Activity
                    </h3>
                </div>
                <div class="gcsez-activity-list" id="recentActivity">
                    <div class="gcsez-empty-state">
                        <i class="fas fa-inbox"></i>
                        <p>No recent activity</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- ALL JAVASCRIPT CODE FROM THE ORIGINAL FILE REMAINS EXACTLY THE SAME -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Initialize calendar
    const calendarEl = document.getElementById('calendar');
    const calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'timeGridWeek',
        height: 800,            // adjusts to content
        contentHeight: 600,        // fixed maximum content height
        expandRows: true, 
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        },
        events: '/api/appointments/slots',
        editable: true,
        selectable: true,
        selectMirror: true,
        dayMaxEvents: true,
        validRange: {
            start: new Date() // prevents selection before today
        },
        select: function(info) {
            $('#createSlotModal').modal('show');
            $('#slotDate').val(info.startStr.substring(0, 10));
            $('#startTime').val(info.startStr.substring(11, 16));
            $('#endTime').val(info.endStr.substring(11, 16));
        },
        eventClick: function(info) {
            showSlotOptions(info.event);
        }
    });
    calendar.render();

    // Navigation controls
    document.getElementById('todayBtn').addEventListener('click', function() {
        calendar.today();
    });
    
    document.getElementById('prevBtn').addEventListener('click', function() {
        calendar.prev();
    });
    
    document.getElementById('nextBtn').addEventListener('click', function() {
        calendar.next();
    });
    
    document.getElementById('viewSelector').addEventListener('change', function() {
        calendar.changeView(this.value);
    });

    // Create single slot
    document.getElementById('createSlotBtn').addEventListener('click', function() {
        const formData = {
            date: $('#slotDate').val(),
            appointment_type_id: $('#slotType').val() || null,
            max_capacity: $('#maxCapacity').val() || 1
        };
        const startTime = $('#startTime').val();
        const endTime = $('#endTime').val();

        // Build proper timestamps
        const startTimestamp = new Date(formData.date+'T'+startTime+':00');
        const endTimestamp   = new Date(formData.date+'T'+endTime+':00');

        // If you want to include them back into formData:
        formData.start_time = startTimestamp.toISOString();
        formData.end_time   = endTimestamp.toISOString();

        // Validate
        if (!formData.date || !formData.start_time || !formData.end_time) {
            //alert('Please fill in all required fields');
            showNotification('Please fill in all required fields', 'error');
            return;
        }

        Swal.fire({
            title: 'Are you sure?',
            text: 'Do you want to create slot?',
            icon: 'warning',
            showCancelButton: true,
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, Create it'
        }).then(function(result) {
            if (result.isConfirmed) {
                handleSingleSlotSubmission(formData, startTime, endTime);
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire("Cancelled", "No action performed.", "error");
            }
        });
    });

    function handleSingleSlotSubmission(formData, startTime, endTime){
        // Send AJAX request
        fetch('/api/appointments/slots', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                $('#createSlotModal').modal('hide');
                calendar.refetchEvents(); // Refresh calendar
                updateSlotSummary();
                addActivity('Created slot: ' + formData.date + ' ' + startTime + '-' + endTime);
                showNotification('Slot created successfully', 'success');
            } else {
                //alert('Error: ' + data.message);
                showNotification('Error: ' + data.message, 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            //alert('Error creating slot');
            showNotification('Error: ' + error, 'error');
        });
    }

    // Create multiple slots
    document.getElementById('createBatchSlotsBtn').addEventListener('click', function() {
        const excludedDays = [];
        if ($('#excludeSunday').is(':checked')) excludedDays.push(0);
        if ($('#excludeMonday').is(':checked')) excludedDays.push(1);
        if ($('#excludeTuesday').is(':checked')) excludedDays.push(2);
        if ($('#excludeWednesday').is(':checked')) excludedDays.push(3);
        if ($('#excludeThursday').is(':checked')) excludedDays.push(4);
        if ($('#excludeFriday').is(':checked')) excludedDays.push(5);
        if ($('#excludeSaturday').is(':checked')) excludedDays.push(6);
        
        const formData = {
            start_date: $('#startDate').val(),
            end_date: $('#endDate').val(),
            start_time: $('#dailyStartTime').val(),
            end_time: $('#dailyEndTime').val(),
            duration_minutes: $('#slotDuration').val(),
            exclude_days: excludedDays.length > 0 ? excludedDays : null,
            appointment_type_id: $('#batchSlotType').val() || null,
            max_capacity: $('#batchMaxCapacity').val() || 1
        };
        
        // Validate
        if (!formData.start_date || !formData.end_date || !formData.start_time || !formData.end_time) {
            // alert('Please fill in all required fields');
            showNotification('Please fill in all required fields', 'error');
            return;
        }

        Swal.fire({
            title: 'Are you sure?',
            text: 'Do you want to create slot?',
            icon: 'warning',
            showCancelButton: true,
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, Create it'
        }).then(function(result) {
            if (result.isConfirmed) {
                handleBatchSlotSubmission(formData);
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire("Cancelled", "No action performed.", "error");
            }
        });
    });

    function handleBatchSlotSubmission(formData){
        // Send AJAX request
        fetch('/api/appointments/slots/batch', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                $('#batchSlotsModal').modal('hide');
                calendar.refetchEvents(); // Refresh calendar
                updateSlotSummary();
                addActivity('Created ' + data.count + ' slots from ' + formData.start_date + ' to ' + formData.end_date);
                showNotification('Slots created successfully', 'success');
            } else {
                //alert('Error: ' + data.message);
                showNotification('Error: ' + data.message, 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            //alert('Error creating slots');
            showNotification('Error: ' + error, 'error');
        });
    }

    // View my slots
    document.getElementById('viewSlotsBtn').addEventListener('click', function() {
        calendar.refetchEvents();
        updateSlotSummary();
    });

    // Helper functions
    function updateSlotSummary() {
        fetch('/api/appointments/slots/summary')
        .then(response => response.json())
        .then(data => {
            // console.log(data)
            document.getElementById('totalSlots').textContent = data.total_slots;
            document.getElementById('availableSlots').textContent = data.available_slots;
            document.getElementById('bookedSlots').textContent = data.booked_slots;
            document.getElementById('fullSlots').textContent = data.full_slots;
        });
    }

    function addActivity(message) {
        const activityList = document.getElementById('recentActivity');
        if (activityList.children[0].textContent === 'No recent activity') {
            activityList.innerHTML = '';
        }
        
        const now = new Date().toLocaleTimeString();
        const li = document.createElement('li');
        li.className = 'gcsez-activity-item';
        li.innerHTML = `
            <div class="gcsez-activity-time">${now}</div>
            <div class="gcsez-activity-message">${message}</div>
        `;
        
        activityList.prepend(li);
        
        // Keep only the last 5 activities
        if (activityList.children.length > 5) {
            activityList.removeChild(activityList.lastChild);
        }
    }

    function showSlotOptions(event) {
        // Implement a modal or context menu for slot operations
        // (edit, delete, toggle availability, etc.)
        const appointmentProps = event._def.extendedProps;
        const appAvailability = appointmentProps.is_available ? "Available" : "Not Available";
        const modalHtml = `
            <div class="modal fade modal-blur" id="slotOptionsModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Slot Options</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <p>Slot: `+event.start.toLocaleString()+` - `+event.end.toLocaleString()+`</p>
                            <p>Status: `+appAvailability+`</p>
                            <p>Bookings: `+appointmentProps.current_bookings+`/`+appointmentProps.max_capacity+`</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-warning" id="toggleSlotBtn">Toggle Availability</button>
                            <button type="button" class="btn btn-danger" id="deleteSlotBtn">Delete Slot</button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        // Add modal to DOM and show it
        $('body').append(modalHtml);
        const modal = new bootstrap.Modal(document.getElementById('slotOptionsModal'));
        modal.show();
        
        // Set up event handlers
        document.getElementById('toggleSlotBtn').addEventListener('click', function() {
            toggleSlotAvailability(event.id);
            modal.hide();
        });
        
        document.getElementById('deleteSlotBtn').addEventListener('click', function() {
            deleteSlot(event.id);
            modal.hide();
        });
        
        // Remove modal from DOM when hidden
        $('#slotOptionsModal').on('hidden.bs.modal', function() {
            $(this).remove();
        });
    }

    function toggleSlotAvailability(slotId) {

        Swal.fire({
            title: 'Are you sure?',
            text: 'Do you want to toggle the availability of this slot?',
            icon: 'warning',
            showCancelButton: true,
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, Toggle it'
        }).then(function(result) {
            if (result.isConfirmed) {
                fetch('/api/appointments/slots/'+slotId+'/toggle', {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        calendar.refetchEvents();
                        updateSlotSummary();
                        addActivity('Toggled availability for slot ' + slotId);
                        showNotification('Toggled availability for slot ' + slotId, 'success');
                    } else {
                        //alert('Error toggling slot availability');
                        showNotification('Error toggling slot availability', 'error');
                    }
                });
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire("Cancelled", "No action performed.", "error");
            }
        });
    }

    function deleteSlot(slotId) {
        //if (!confirm('Are you sure you want to delete this slot?')) return;

        Swal.fire({
            title: 'Are you sure?',
            text: 'Do you want to delete this slot?',
            icon: 'warning',
            showCancelButton: true,
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, Delete it'
        }).then(function(result) {
            if (result.isConfirmed) {
                fetch('/api/appointments/slots/'+slotId, {
                    method: 'DELETE'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        calendar.refetchEvents();
                        updateSlotSummary();
                        addActivity('Deleted slot ' + slotId);
                        showNotification('Slot deleted successfully', 'success');
                    } else {
                        // alert('Error deleting slot');
                        showNotification('Error deleting slot', 'error');
                    }
                });
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire("Cancelled", "No action performed.", "error");
            }
        });
    }

    // Initialize page
    updateSlotSummary();
    
    // Set default dates in modals
    const today = new Date().toISOString().substring(0, 10);
    $('#slotDate').val(today);
    $('#startDate').val(today);
    $('#endDate').val(new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString().substring(0, 10));
});

window.showNotification = function(message, type = 'success') {
    // You can implement a toast notification system here
    Toastify({
        text: message,
        duration: 10000,
        close: true,
        gravity: "top",
        position: "right",
        stopOnFocus: true,
        avatar: type === 'success' ? '../assets/images/notification/ok-48.png' : '../assets/images/notification/high_priority-48.png', // small icon image
        style: {
            background: type === 'success' ? 'linear-gradient(to right, #00b09b, #96c93d)' : 'linear-gradient(to right, #ff5f6d, #ffc371)',
            fontSize: "13px",
        },
    }).showToast();
}
</script>