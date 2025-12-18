<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.gcsez-appointment-management {
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

.gcsez-btn.info {
    background: #c5bb85;
}

.gcsez-btn.info:hover {
    background: #b4a972;
}

.gcsez-main-card {
    background: #ffffff;
    border: 1px solid #e5e7eb;
    border-radius: 12px;
    overflow: hidden;
}

.gcsez-card-header {
    padding: 24px;
    border-bottom: 1px solid #e5e7eb;
}

.gcsez-card-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #111827;
    margin: 0 0 8px 0;
}

.gcsez-card-description {
    color: #6b7280;
    font-size: 0.875rem;
    margin: 0;
    line-height: 1.5;
    font-weight: 100;
}

.gcsez-card-body {
    padding: 24px;
}

/* DataTable Customization */
#appointments-datatable_wrapper {
    font-family: 'Rubik', sans-serif;
}

#appointments-datatable {
    border: 1px solid #e5e7eb;
    border-radius: 8px;
    overflow: hidden;
}

#appointments-datatable thead th {
    background: #f9fafb;
    border-bottom: 1px solid #e5e7eb;
    padding: 12px 16px;
    font-weight: 600;
    color: #374151;
    font-size: 0.875rem;
}

#appointments-datatable tbody td {
    padding: 12px 16px;
    border-bottom: 1px solid #f3f4f6;
    font-size: 0.875rem;
    color: #6b7280;
}

#appointments-datatable tbody tr:hover {
    background: #f9fafb;
}

/* Status Badges */
.gcsez-badge {
    padding: 4px 8px;
    border-radius: 6px;
    font-size: 0.75rem;
    font-weight: 500;
    text-transform: capitalize;
}

.gcsez-badge.success { 
    background: #d1fae5; 
    color: #065f46; 
}

.gcsez-badge.warning { 
    background: #fef3c7; 
    color: #92400e; 
}

.gcsez-badge.danger { 
    background: #fee2e2; 
    color: #991b1b; 
}

.gcsez-badge.info { 
    background: #dbeafe; 
    color: #1e40af; 
}

/* Action Buttons */
.gcsez-btn-group {
    display: flex;
    gap: 6px;
    justify-content: flex-end;
}

.gcsez-btn-icon {
    width: 32px;
    height: 32px;
    border: 1px solid #e5e7eb;
    border-radius: 6px;
    background: white;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.2s ease;
    font-size: 0.875rem;
}

.gcsez-btn-icon:hover {
    background: #f9fafb;
    border-color: #d1d5db;
    transform: translateY(-1px);
}

.gcsez-btn-icon.view { color: #326573; }
.gcsez-btn-icon.edit { color: #57a394; }
.gcsez-btn-icon.cancel { color: #b48478; }

/* DataTable Controls */
.dt-buttons {
    margin-bottom: 16px;
}

.dt-buttons .btn {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 12px;
    font-size: 0.875rem;
    margin-right: 8px;
    margin-bottom: 8px;
}

.dataTables_filter {
    margin-bottom: 16px;
}

.dataTables_filter label {
    font-size: 0.875rem;
    color: #6b7280;
}

.dataTables_filter input {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 12px;
    font-size: 0.875rem;
    margin-left: 8px;
}

.dataTables_info {
    font-size: 0.875rem;
    color: #6b7280;
    padding-top: 12px;
}

.dataTables_paginate {
    padding-top: 12px;
}

.dataTables_paginate .paginate_button {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 12px;
    margin-left: 4px;
    font-size: 0.875rem;
    color: #374151;
    text-decoration: none;
}

.dataTables_paginate .paginate_button.current {
    background: #326573;
    color: white;
    border-color: #326573;
}

.dataTables_paginate .paginate_button:hover {
    background: #f3f4f6;
    border-color: #9ca3af;
}

/* Mobile Responsiveness */
@media (max-width: 768px) {
    .gcsez-appointment-management {
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
    
    .gcsez-btn-group {
        justify-content: center;
    }
    
    #appointments-datatable_wrapper {
        overflow-x: auto;
    }
}

/* Loading State */
.gcsez-loading {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px;
    color: #6b7280;
    font-size: 0.875rem;
}

/* Empty State */
.gcsez-empty-state {
    text-align: center;
    padding: 40px;
    color: #6b7280;
}

.gcsez-empty-state i {
    font-size: 3rem;
    margin-bottom: 16px;
    color: #d1d5db;
}

.gcsez-empty-state h4 {
    color: #6b7280;
    margin-bottom: 8px;
}

/* Tooltip Customization */
.tooltip-white .tooltip-inner {
    background: white;
    color: #374151;
    border: 1px solid #e5e7eb;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
</style>

<link href="https://fonts.googleapis.com/css2?family=Rubik:wght@300;400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<main class="gcsez-appointment-management">
    <div class="gcsez-breadcrumb">
        <h1 class="gcsez-breadcrumb-title">Manage Appointments</h1>
        <nav class="gcsez-breadcrumb-nav">
            <a href="javascript:void(0)">Appointments</a>
            <span>/</span>
            <span>Manage Appointments</span>
        </nav>
    </div>

    <!-- Action buttons -->
    <div class="gcsez-action-buttons">
        <button type="button" class="gcsez-btn info" data-bs-toggle="modal" data-bs-target="#creatappointmentModal">
            <i class="fas fa-calendar-plus"></i> Schedule Appointment
        </button>
    </div>

    <div class="gcsez-main-card">
        <div class="gcsez-card-header">
            <h2 class="gcsez-card-title">Appointment Management</h2>
            <p class="gcsez-card-description">
                Manage appointments with this interactive DataTable. View, schedule, update, or cancel client bookings easily.
            </p>
        </div>
        <div class="gcsez-card-body">
            <div class="table-responsive">
                <table id="appointments-datatable" class="table table-striped dt-responsive w-100">
                    <thead>
                        <tr>
                            <th>Client</th>
                            <th>Appointment Type</th>
                            <th>Time Slot</th>
                            <th>Status</th>
                            <th>Created Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Data will be populated by JavaScript -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>


<script>
document.addEventListener('DOMContentLoaded', function() {
    const submitButton = document.getElementById('submitUserForm');
    const addUserForm = document.getElementById('addUserForm');

    window.showUserModal = function(){
        document.getElementById('addUserModalLabel').innerHTML = 'Add User';
        document.getElementById('addUserForm').dataset.userId = '';
        document.getElementById('addUserForm').dataset.isEdit = 'false';
        document.getElementById('submitUserForm').innerHTML = '<i class="mdi mdi-content-save me-2"></i> Add User';
        
        const modalEl = document.getElementById('addUserModal');
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.show();
        addUserForm.reset();
    }
    
    submitButton.addEventListener('click', function(e) {
        e.preventDefault();
        const text = submitButton.textContent;

        Swal.fire({
            title: 'Are you sure?',
            icon: 'warning',
            showCancelButton: true,
            cancelButtonColor: '#d33',
            confirmButtonText: text == 'Update User' ? 'Yes, Update it' : 'Yes, Save it'
        }).then(function(result) {
            if (result.isConfirmed) {
                handleFormSubmission();
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire("Cancelled", "No action performed.", "error");
            }
        });
    });
    
    function handleFormSubmission() {
        if (!validateForm()) return;
        
        const formData = prepareFormData();
        showLoader("Processing...");
        
        submitFormData(formData)
            .then(response => {
                if(response.message == "SESSION_INVALID") {
                    window.location.href = "login?session=invalid"
                    return;
                }

                if(response.message == 'Missing required fields.' || response.message == 'Invalid request type.') {
                    showNotification(response.message, 'error');
                    return;
                }

                if(response.success == false) {
                    showNotification(response.message, 'error');
                    return;
                }
                
                showNotification(response.message, 'success');
                const modal = bootstrap.Modal.getInstance(document.getElementById('addUserModal'));
                modal.hide();
                addUserForm.reset();
                loadappointmentsForDataTable();
            })
            .catch(error => {
                showNotification('Error adding user: ' + error.message, 'error');
            })
            .finally(() => {
                hideLoader()
            });
    }
    
    function validateForm() {
        let isValid = true;
        const requiredFields = addUserForm.querySelectorAll('[required]');
        
        requiredFields.forEach(field => {
            if (!field.value.trim()) {
                isValid = false;
                highlightError(field, 'This field is required');
            } else {
                removeErrorHighlight(field);
            }
        });
        
        const emailField = document.getElementById('email');
        if (emailField.value && !isValidEmail(emailField.value)) {
            isValid = false;
            highlightError(emailField, 'Please enter a valid email address');
        }
        
        const passwordField = document.getElementById('password');
        const confirmPasswordField = document.getElementById('confirm_password');
        if (passwordField.value !== confirmPasswordField.value) {
            isValid = false;
            highlightError(confirmPasswordField, 'Passwords do not match');
        }
        
        const phoneField = document.getElementById('phone_number');
        if (phoneField.value && !isValidPhoneNumber(phoneField.value)) {
            isValid = false;
            highlightError(phoneField, 'Please enter a valid phone number');
        }
        
        return isValid;
    }
    
    function prepareFormData() {
        const twoFactorSms = document.querySelector('.two_factor').checked;
        const twoFactorEmail = document.querySelector('.email_auth').checked;
        const loginNotifications = document.querySelector('.login_notifications').checked;
        
        const el = document.getElementById("addUserForm");
        const isEdit = JSON.parse(el.dataset.isEdit);
        const userId = el.dataset.userId;

        return {
            title: document.getElementById('title').value,
            first_name: document.getElementById('first_name').value,
            last_name: document.getElementById('last_name').value,
            middle_name: document.getElementById('middle_name').value,
            dob: document.getElementById('dob').value,
            gender: document.getElementById('gender').value,
            username: document.getElementById('username').value,
            email: document.getElementById('email').value,
            password: document.getElementById('password').value,
            role: document.getElementById('role').value,
            level: document.getElementById('level').value,
            country_code: document.getElementById('country_code').value,
            phone_number: document.getElementById('phone_number').value,
            country: document.getElementById('country').value,
            address: document.getElementById('address').value,
            zip_code: document.getElementById('zip_code').value,
            city: document.getElementById('city').value,
            two_factor_auth: twoFactorSms || twoFactorEmail,
            two_factor_method: twoFactorSms ? 'SMS' : (twoFactorEmail ? 'Email' : 'None'),
            login_notification: loginNotifications,
            status: document.getElementById('status').value,
            expire_pass: document.getElementById('expire_pass').checked,
            user_id: isEdit ? userId : '',
            requestType: isEdit ? 'updateUser' : 'addUser'
        };
    }
    
    function submitFormData(formData) {
        return new Promise((resolve, reject) => {
            fetch('/api/users', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(formData)
            })
            .then(response => {
                if (!response.ok) throw new Error('Server returned an error: ' + response.status);
                return response.json();
            })
            .then(data => resolve(data))
            .catch(error => reject(error));
        });
    }
    
    function isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }
    
    function isValidPhoneNumber(phone) {
        const phoneRegex = /^[0-9+\-\s()]{10,20}$/;
        return phoneRegex.test(phone);
    }
    
    function highlightError(field, message) {
        field.classList.add('is-invalid');
        let errorElement = field.parentNode.querySelector('.invalid-feedback');
        if (!errorElement) {
            errorElement = document.createElement('div');
            errorElement.className = 'invalid-feedback';
            field.parentNode.appendChild(errorElement);
        }
        errorElement.textContent = message;
    }
    
    function removeErrorHighlight(field) {
        field.classList.remove('is-invalid');
        const errorElement = field.parentNode.querySelector('.invalid-feedback');
        if (errorElement) errorElement.remove();
    }
    
    function generateUniqueId() {
        return 'user_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
    }
    
    const style = document.createElement('style');
    style.textContent = `
        .is-invalid { border-color: #b48478 !important; }
        .invalid-feedback {
            display: block; width: 100%; margin-top: 0.25rem;
            font-size: 0.875em; color: #b48478;
        }
        .gcesz-btn-primary { background: #326573; color: white; }
        .gcesz-btn-primary:hover { background: #2a5561; }
        .gcesz-btn-secondary { background: #928d89; color: white; }
        .gcesz-btn-secondary:hover { background: #7a7571; }
        .gcesz-btn-accent { background: #eb8471; color: white; }
        .gcesz-btn-accent:hover { background: #e76a55; }
        .gcesz-btn-success { background: #57a394; color: white; }
        .gcesz-btn-success:hover { background: #4a8c7e; }
        .gcesz-btn-warning { background: #c5bb85; color: #212121; }
        .gcesz-btn-warning:hover { background: #b4a972; }
        .gcesz-btn-danger { background: #b48478; color: white; }
        .gcesz-btn-danger:hover { background: #a07064; }
        .gcesz-badge { padding: 0.25em 0.4em; font-size: 0.75em; font-weight: 600; line-height: 1; text-align: center; white-space: nowrap; vertical-align: baseline; border-radius: 0.25rem; }
        .gcesz-badge-success { background: #57a394; color: white; }
        .gcesz-badge-warning { background: #c5bb85; color: #212121; }
        .gcesz-badge-danger { background: #b48478; color: white; }
        .gcesz-badge-info { background: #326573; color: white; }
        .gcesz-badge-secondary { background: #928d89; color: white; }
        .gcesz-card { background: white; border: 1px solid #e5e7eb; border-radius: 8px; }
        .gcesz-modal-header { background: #f8fafc; border-bottom: 1px solid #e5e7eb; }
        .gcesz-text-primary { color: #326573; }
        .gcesz-text-secondary { color: #928d89; font-weight: 100;}
        .gcesz-text-accent { color: #eb8471; }
        .gcesz-bg-light { background: #f8fafc; }
        .gcesz-border { border: 1px solid #e5e7eb; }
    `;
    document.head.appendChild(style);
});

window.showNotification = function(message, type = 'success') {
    const backgroundColor = type === 'success' ? 
        'linear-gradient(to right, #57a394, #326573)' : 
        'linear-gradient(to right, #b48478, #eb8471)';
    
    Toastify({
        text: message,
        duration: 10000,
        close: true,
        gravity: "top",
        position: "right",
        stopOnFocus: true,
        avatar: type === 'success' ? '../assets/images/notification/ok-48.png' : '../assets/images/notification/high_priority-48.png',
        style: { background: backgroundColor, fontSize: "13px" },
    }).showToast();
}

const appointmentApiEndpoint = '/api/appointments/all-appointments';

function setLoadingState(isLoading) {
    const tableBody = document.querySelector('#appointments-datatable tbody');
    if (isLoading) {
        tableBody.innerHTML = `<tr><td colspan="8" class="text-center py-4">Loading appointments...</td></tr>`;
    }
}

function formatDateShort(dateString) {
    if (!dateString) return { formattedDate: 'N/A', formattedTime: '' };
    const date = new Date(dateString);
    return {
        formattedDate: date.toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' }),
        formattedTime: date.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', hour12: true })
    };
}

let appointmentTable = null;

function initAppointmentsDataTable() {
    if ($.fn.DataTable.isDataTable('#appointments-datatable')) {
        $('#appointments-datatable').DataTable().destroy();
        $('#appointments-datatable tbody').empty();
    }

    appointmentTable = new DataTable('#appointments-datatable', {
        data: [],
        columns: [
            { data: 'full_name', orderable: true },
            { data: 'appointment_type_name', orderable: true },
            {
                data: 'start_time',
                render: function (data, type, row) {
                    if (!data) return '';
                    const d = formatDateShort(data);
                    return d.formattedDate + ' ' + d.formattedTime;
                }
            },
            { 
                data: 'status', 
                orderable: true,
                render: function(data, type, row) {
                    const statusClass = data === 'confirmed' ? 'gcesz-badge-success' : 
                                     data === 'scheduled' ? 'gcesz-badge-warning' : 
                                     'gcesz-badge-danger';
                    return `<span class="gcesz-badge `+statusClass+`">`+data+`</span>`;
                }
            },
            {
                data: 'created_at',
                render: function (data, type, row) {
                    if (!data) return '';
                    const d = formatDateShort(data);
                    return d.formattedDate;
                }
            },
            {
                data: null,
                orderable: false,
                className: 'text-end',
                render: function (data, type, row) {
                    return `
                        <div class="d-flex gap-2 justify-content-end">
                            <button type="button" class="gcesz-btn-primary btn btn-sm btn-view" 
                                data-appointment-id="`+row.id+`" data-bs-toggle="tooltip" 
                                title="View Appointment">
                                <i class="mdi mdi-eye"></i>
                            </button>
                            <button type="button" class="gcesz-btn-success btn btn-sm btn-edit" 
                                data-appointment-id="`+row.id+`" data-bs-toggle="tooltip" 
                                title="Reschedule Appointment">
                                <i class="mdi mdi-calendar-clock"></i>
                            </button>
                            <button type="button" class="gcesz-btn-danger btn btn-sm btn-cancel" 
                                data-appointment-id="`+row.id+`" data-bs-toggle="tooltip" 
                                title="Cancel Appointment">
                                <i class="mdi mdi-calendar-remove"></i>
                            </button>
                        </div>
                    `;
                }
            }
        ],
        dom: "<'d-flex align-items-center mb-2'<'btn-left'B><'ms-auto'f>>" +
             "<'row'<'col-sm-12'tr>>" +
             "<'row mt-2'<'col-sm-12 col-md-6'i><'col-sm-12 col-md-6'p>>",
        buttons: [
            {
                extend: 'copyHtml5',
                text: '<i class="mdi mdi-content-copy me-1"></i> Copy',
                className: 'gcesz-btn-secondary btn btn-sm me-1'
            },
            {
                extend: 'csvHtml5',
                text: '<i class="mdi mdi-file-excel me-1"></i> CSV',
                className: 'gcesz-btn-success btn btn-sm me-1'
            },
            {
                extend: 'print',
                text: '<i class="bi bi-printer me-1"></i> Print',
                className: 'gcesz-btn-primary btn btn-sm me-1'
            }
        ]
    });
}

async function loadappointmentsForDataTable() {
    try {
        const resp = await fetch(appointmentApiEndpoint, { method: 'GET', headers: { 'Content-Type': 'application/json' } });
        if (!resp.ok) throw new Error('Server returned ' + resp.status);
        const json = await resp.json();
        const users = Array.isArray(json) ? json : (json.users || json.data || []);
        const normalized = users.map(u => Object.assign({}, u, { id: u.id || u.user_id || null }));

        if (!appointmentTable) initAppointmentsDataTable();

        appointmentTable.clear();
        appointmentTable.rows.add(normalized);
        appointmentTable.draw();

    } catch (err) {
        console.error('Error loading appointments for DataTable:', err);
        showNotification('Error loading appointments', 'error');
    } finally {
        setLoadingState(false);
    }
}

$(document).ready(function() {
    initAppointmentsDataTable();
    loadappointmentsForDataTable().then(() => addActionListeners());
});

function addActionListeners() {
    document.querySelectorAll('.btn-view').forEach(btn => {
        btn.addEventListener('click', function() {
            const appointmentId = this.getAttribute('data-appointment-id');
            viewAppointment(appointmentId);
        });
    });
    
    document.querySelectorAll('.btn-edit').forEach(btn => {
        btn.addEventListener('click', function() {
            const appointmentId = this.getAttribute('data-appointment-id');
            rescheduleAppointment(appointmentId);
        });
    });
    
    document.querySelectorAll('.btn-cancel').forEach(btn => {
        btn.addEventListener('click', function() {
            const appointmentId = this.getAttribute('data-appointment-id');
            cancelAppointment(appointmentId);
        });
    });
}

function viewAppointment(appointmentId) {
    fetch('/api/appointments/' + appointmentId)
        .then(response => response.json())
        .then(appointment => showAppointmentViewModal(appointment))
        .catch(error => {
            console.error('Error fetching appointment details:', error);
            showNotification('Failed to load appointment details', 'error');
        });
}

function showAppointmentViewModal(appointment) {
    const clientName = appointment.client_name || 'Unknown Client';
    const appointmentType = appointment.appointment_type || 'N/A';
    const status = appointment.status || 'pending';
    const statusClass = status === 'confirmed' ? 'gcesz-badge-success' : 
                       status === 'scheduled' ? 'gcesz-badge-warning' : 
                       'gcesz-badge-danger';
    const startTime = appointment.start_time ? new Date(appointment.start_time).toLocaleString() : 'N/A';
    const endTime = appointment.end_time ? new Date(appointment.end_time).toLocaleString() : 'N/A';
    const notes = appointment.notes || 'No notes added';

    const modalHTML = `
        <div class="modal fade modal-blur" id="viewAppointmentModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content gcesz-card shadow-lg">
                    <div class="modal-header gcesz-modal-header">
                        <h5 class="modal-title gcesz-text-primary">
                            <i class="bi bi-calendar-check me-2"></i> Appointment Details
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body p-4">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <h6 class="fw-bold gcesz-text-primary mb-2"><i class="bi bi-person me-1"></i> Client Information</h6>
                                <div class="gcesz-card gcesz-bg-light">
                                    <div class="card-body p-3">
                                        <p class="mb-2">Client: <span class="gcesz-text-secondary float-end">`+clientName+`</span></p>
                                        <p class="mb-2">Type: <span class="gcesz-text-secondary float-end">`+appointmentType+`</span></p>
                                        <p class="mb-0">Status: <span class="gcesz-badge `+statusClass+` float-end">`+status+`</span></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <h6 class="fw-bold gcesz-text-primary mb-2"><i class="bi bi-clock me-1"></i> Timing</h6>
                                <div class="gcesz-card gcesz-bg-light">
                                    <div class="card-body p-3">
                                        <p class="mb-2">Start: <span class="gcesz-text-secondary float-end">`+startTime+`</span></p>
                                        <p class="mb-0">End: <span class="gcesz-text-secondary float-end">`+endTime+`</span></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <h6 class="fw-bold gcesz-text-primary mb-2"><i class="bi bi-journal-text me-1"></i> Notes</h6>
                                <div class="gcesz-card gcesz-bg-light">
                                    <div class="card-body p-3">
                                        <p class="mb-0 gcesz-text-secondary">`+notes+`</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="gcesz-btn-secondary btn" data-bs-dismiss="modal">
                            <i class="mdi mdi-close me-2"></i> Close
                        </button>
                    </div>
                </div>
            </div>
        </div>
    `;

    const existingModal = document.getElementById('viewAppointmentModal');
    if (existingModal) existingModal.remove();

    const tempContainer = document.createElement('div');
    tempContainer.innerHTML = modalHTML;
    const modalElement = tempContainer.firstElementChild;
    document.body.appendChild(modalElement);

    setTimeout(() => {
        const modal = new bootstrap.Modal(document.getElementById('viewAppointmentModal'));
        modal.show();

        modalElement.addEventListener('hidden.bs.modal', function() {
            if (document.body.contains(modalElement)) document.body.removeChild(modalElement);
        });
    }, 50);
}

function rescheduleAppointment(appointmentId) {
    fetch('/api/appointments/' + appointmentId)
        .then(response => response.json())
        .then(appointment => showAppointmentRescheduleModal(appointment))
        .catch(error => {
            showNotification('Failed to load appointment details', 'error');
        });
}

function showAppointmentRescheduleModal(appointment) {
    const Oldappointmentid = appointment.id;
    const notes = appointment.notes || 'No notes added';

    const modalHTML = `
        <div class="modal fade modal-blur" id="rescheduleAppointmentModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content gcesz-card shadow-lg">
                    <div class="modal-header gcesz-modal-header">
                        <h5 class="modal-title gcesz-text-primary">Reschedule Appointment</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="rescheduleAppointmentForm">
                            <input type="hidden" class="form-control" id="Appontment_id" value="`+Oldappointmentid+`">
                            
                            <div class="mb-3">
                                <label for="rescheduleslotDate" class="form-label">Select Date <span class="gcesz-text-accent">*</span></label>
                                <input type="date" class="form-control gcesz-border" id="rescheduleslotDate" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="scheduleavailableSlots" class="form-label">Available Slots <span class="gcesz-text-accent">*</span></label>
                                <select class="form-select gcesz-border" id="scheduleavailableSlots" required>
                                    <option value="">-- Select Available Slot --</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="appointmentStatus" class="form-label">Appointment Status</label>
                                <select class="form-select gcesz-border" id="appointmentStatus">
                                    <option value="confirmed">Confirmed</option>
                                    <option value="pending">Pending</option>
                                    <option value="cancelled">Cancelled</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="appointment_notes" class="form-label">Appointment Note</label>
                                <input type="text" class="form-control gcesz-border" id="appointment_notes" value="`+notes+`" required>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="gcesz-btn-secondary btn" data-bs-dismiss="modal">
                            <i class="mdi mdi-close me-2"></i> Close
                        </button>
                        <button type="submit" class="gcesz-btn-primary btn" id="rescheduleBtn">
                            <i class="bi bi-arrow-repeat me-1"></i> Reschedule
                        </button>
                    </div>
                </div>
            </div>
        </div>
    `;

    const existingModal = document.getElementById('rescheduleAppointmentModal');
    if (existingModal) existingModal.remove();

    const tempContainer = document.createElement('div');
    tempContainer.innerHTML = modalHTML;
    const modalElement = tempContainer.firstElementChild;
    document.body.appendChild(modalElement);

    document.getElementById("appointment_notes").value = notes;

    setTimeout(() => {
        const modal = new bootstrap.Modal(document.getElementById('rescheduleAppointmentModal'));
        modal.show();

        modalElement.addEventListener('hidden.bs.modal', function() {
            if (document.body.contains(modalElement)) document.body.removeChild(modalElement);
        });
    }, 50);

    const slotDateInput = document.getElementById("rescheduleslotDate");
    const availableSlotsSelect = document.getElementById("scheduleavailableSlots");

    slotDateInput.addEventListener("change", function() {
        const selectedDate = this.value;
        if (!selectedDate) return;

        availableSlotsSelect.innerHTML = '<option value="">-- Select Available Slot --</option>';

        const payload = { date: selectedDate, appointment_type_id: 1 };

        fetch("/api/appointments/get-available-slots", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload)
        })
        .then(response => response.json())
        .then(responseData => {
            const slots = responseData.data;

            if (!Array.isArray(slots) || slots.length === 0) {
                const option = document.createElement("option");
                option.value = "";
                option.textContent = "No available slots";
                availableSlotsSelect.appendChild(option);
                return;
            }

            slots.forEach(slot => {
                const start = new Date(slot.start_time);
                const end = new Date(slot.end_time);

                const startTime = start.toLocaleTimeString([], { 
                    hour: 'numeric', minute: '2-digit', hour12: true
                });
                const endTime = end.toLocaleTimeString([], { 
                    hour: 'numeric', minute: '2-digit', hour12: true
                });

                const option = document.createElement("option");
                option.value = slot.id;
                option.textContent = startTime+` - `+endTime+` (Capacity: `+slot.available_capacity+`)`;
                availableSlotsSelect.appendChild(option);
            });
        })
        .catch(error => {
            console.error("Error fetching slots:", error);
            const option = document.createElement("option");
            option.value = "";
            option.textContent = "Error loading slots";
            availableSlotsSelect.appendChild(option);
        });
    });

    $(document).on("click", "#rescheduleBtn", function(e) {
        e.preventDefault();

        const formData = {
            my_appointment_id: $('#Appontment_id').val(),
            new_slot_id: $('#scheduleavailableSlots').val(),
            notes: $('#appointment_notes').val(),
            status: $('#appointmentStatus').val()
        };

        if (!formData.my_appointment_id || !formData.new_slot_id || !formData.notes) {
            showNotification('Please fill in all required fields', 'error');
            return;
        }

        Swal.fire({
            title: 'Confirm Reschedule',
            text: 'Do you want to reschedule this appointment?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes, reschedule!',
            cancelButtonText: 'No, cancel',
            cancelButtonColor: '#d33'
        }).then(result => {
            if (result.isConfirmed) {
                fetch('/api/appointments/reschedule', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(formData)
                })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        $('#rescheduleAppointmentModal').modal('hide');
                        showNotification('Appointment rescheduled successfully', 'success');
                        loadappointmentsForDataTable();
                    } else {
                        showNotification('Error: ' + data.message, 'error');
                    }
                })
                .catch(err => {
                    console.error('Error:', err);
                    showNotification('Error rescheduling appointment', 'error');
                });
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire("Cancelled", "No action performed.", "error");
            }
        });
    });
}

function cancelAppointment(appointmentId) {
    fetch('/api/appointments/' + appointmentId)
        .then(response => response.json())
        .then(appointment => cancelAppointmentModal(appointment))
        .catch(error => {
            showNotification('Failed to load appointment details', 'error');
        });
}

function cancelAppointmentModal(appointment) {
    const Oldappointmentid = appointment.id;
    const startTime = new Date(appointment.start_time);
    const formattedDate = startTime.toLocaleDateString();
    const formattedTime = startTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

    const modalHTML = `
        <div class="modal fade modal-blur" id="cancelAppointmentModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content gcesz-card">
                    <div class="modal-header gcesz-modal-header">
                        <h5 class="modal-title gcesz-text-primary">Cancel Appointment</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p style="font-weight: 100">Are you sure you want to cancel this appointment?</p>
                        <div class="gcesz-card gcesz-bg-light p-3 mb-3">
                            <h6 class="mb-2" style="font-weight: 400">`+appointment.appointment_type+`</h6>
                            <div class="gcesz-text-secondary small">`+formattedDate+` at `+formattedTime+`</div>
                            <div class="gcesz-text-secondary small">With: `+appointment.client_name+`</div>
                        </div>

                        <input type="hidden" class="form-control" id="Appontment_id" value="`+Oldappointmentid+`">
                        <input type="hidden" class="form-control" id="ClientID" value="`+appointment.client_id+`">
                        
                        <div class="mb-3">
                            <label for="cancellationReason" class="form-label" style="font-weight: 300">Reason for cancellation (optional):</label>
                            <textarea class="form-control gcesz-border" id="cancellationReason" rows="3" 
                                placeholder="Please provide a reason for cancellation..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="gcesz-btn-secondary btn" data-bs-dismiss="modal">Keep Appointment</button>
                        <button type="button" class="gcesz-btn-danger btn" id="confirmCancelBtn">Cancel Appointment</button>
                    </div>
                </div>
            </div>
        </div>
    `;

    const existingModal = document.getElementById('cancelAppointmentModal');
    if (existingModal) existingModal.remove();

    const tempContainer = document.createElement('div');
    tempContainer.innerHTML = modalHTML;
    const modalElement = tempContainer.firstElementChild;
    document.body.appendChild(modalElement);

    setTimeout(() => {
        const modal = new bootstrap.Modal(document.getElementById('cancelAppointmentModal'));
        modal.show();

        modalElement.addEventListener('hidden.bs.modal', function() {
            if (document.body.contains(modalElement)) document.body.removeChild(modalElement);
        });
    }, 50);

    $(document).on("click", "#confirmCancelBtn", function(e) {
        e.preventDefault();

        const formData = {
            appointment_id: $('#Appontment_id').val(),
            client_id: $('#ClientID').val()
        };

        if (!formData.appointment_id || !formData.client_id) {
            showNotification('Missing required information', 'error');
            return;
        }

        Swal.fire({
            title: 'Confirm Cancellation',
            text: 'Do you want to cancel this appointment?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes, Continue!',
            cancelButtonText: 'No, cancel',
            cancelButtonColor: '#d33'
        }).then(result => {
            if (result.isConfirmed) {
                fetch('/api/appointments/cancel-appointment', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(formData)
                })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        $('#cancelAppointmentModal').modal('hide');
                        showNotification('Appointment cancelled successfully', 'success');
                        setTimeout(() => location.reload(), 1000);
                    } else {
                        showNotification('Error: ' + data.message, 'error');
                    }
                })
                .catch(err => {
                    console.error('Error:', err);
                    showNotification('Error cancelling appointment', 'error');
                });
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire("Cancelled", "No action performed.", "error");
            }
        });
    });
}

// Calendar functionality
document.addEventListener('DOMContentLoaded', function() {
    const calendarEl = document.getElementById('calendar');
    if (calendarEl) {
        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'timeGridWeek',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
            },
            events: '/api/appointments/slots',
            editable: true,
            selectMirror: true,
            dayMaxEvents: true,
            validRange: { start: new Date() },
            eventClick: function(info) { scheduleAppointment(info.event); }
        });
        calendar.render();

        $('#creatappointmentModal').on('shown.bs.modal', function() {
            if (calendar) calendar.updateSize();
        });
    }
});

function scheduleAppointment(event) {
    const appointmentProps = event._def.extendedProps;
    const slotID = event._def.publicId;
    const startDate = event.start;
    const endDate = event.end;

    const dateOnly = (startDate.getMonth() + 1).toString().padStart(2, '0') + '/' +
                     startDate.getDate().toString().padStart(2, '0') + '/' +
                     startDate.getFullYear();

    const startTime = startDate.toLocaleTimeString([], { hour: 'numeric', minute: '2-digit', hour12: true });
    const endTime = endDate.toLocaleTimeString([], { hour: 'numeric', minute: '2-digit', hour12: true });

    let modalHtml = appointmentProps.is_available ? createAvailableAppointmentModal() : createUnavailableAppointmentModal();

    $('#appointmentModal').remove();
    $('body').append(modalHtml);

    const modalEl = document.getElementById('appointmentModal');
    const modal = new bootstrap.Modal(modalEl);

    $('#appointment_type_name').val(appointmentProps.appointment_type_id);
    $('#slot_date').val(dateOnly);
    $('#slot_start_time').val(startTime);
    $('#slot_end_time').val(endTime);
    $('#time_slot_id').val(slotID);

    if (!$('#appointment_type_name').val()) {
        $("#appointment_type_name option").filter(function() {
            return $(this).text().trim().startsWith(appointmentProps.appointment_type_name);
        }).prop('selected', true);
    }

    modal.show();

    $(document).on('submit', '#appointmentForm', function(e) {
        e.preventDefault();
        handleAppointmentBooking();
    });

    $('#appointmentModal').on('hidden.bs.modal', function() { $(this).remove(); });
}

function createAvailableAppointmentModal() {
    return `
        <div class="modal fade modal-blur" id="appointmentModal" tabindex="-1">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content gcesz-card shadow-lg">
                    <form id="appointmentForm">
                        <div class="modal-header gcesz-modal-header">
                            <h5 class="modal-title gcesz-text-primary">Schedule Appointment</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="client_id" class="form-label">Client</label>
                                    <select class="form-select gcesz-border" id="client_id" required>
                                        <option value="">-- Select Client --</option>
                                        <c:forEach var="selusers" items="${userSelect}">
                                            <option value="${selusers.id}">${selusers.full_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="appointment_type_name" class="form-label">Appointment Type</label>
                                    <select class="form-select gcesz-border" id="appointment_type_name" required>
                                        <option value="">-- Select Type --</option>
                                        <c:forEach var="type" items="${appointmentTypes}">
                                            <option value="${type.id}">${type.name} (${type.duration_minutes} mins)</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <input type="hidden" id="time_slot_id">
                                <div class="col-md-6">
                                    <label class="form-label">Date</label>
                                    <input type="text" id="slot_date" class="form-control gcesz-border" disabled>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Start Time</label>
                                    <input type="text" id="slot_start_time" class="form-control gcesz-border" disabled>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">End Time</label>
                                    <input type="text" id="slot_end_time" class="form-control gcesz-border" disabled>
                                </div>
                                <div class="col-md-6">
                                    <label for="status" class="form-label">Status</label>
                                    <select class="form-select gcesz-border" id="status" required>
                                        <option value="Confirmed">Confirmed</option>
                                        <option value="Pending Confirmation">Pending Confirmation</option>
                                        <option value="Cancelled">Cancelled</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label for="notes" class="form-label">Notes</label>
                                    <textarea class="form-control gcesz-border" id="notes" rows="3"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="gcesz-btn-secondary btn" data-bs-dismiss="modal">
                                <i class="mdi mdi-close me-2"></i> Cancel
                            </button>
                            <button type="submit" class="gcesz-btn-primary btn" id="addAppointment">
                                <i class="mdi mdi-calendar-check me-2"></i> Save Appointment
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    `;
}

function handleAppointmentBooking() {
    const formData = {
        client_id: $('#client_id').val(),
        slot_id: $('#time_slot_id').val(),
        appointment_type_id: $('#appointment_type_name').val(),
        notes: $('#notes').val(),
        status: $('#status').val()
    };

    if (!formData.client_id || !formData.slot_id || !formData.appointment_type_id) {
        showNotification('Please fill in all required fields', 'error');
        return;
    }

    Swal.fire({
        title: 'Confirm Booking',
        text: 'Do you want to book this appointment?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, book it!',
        cancelButtonText: 'No, cancel',
        cancelButtonColor: '#d33'
    }).then(result => {
        if (result.isConfirmed) {
            fetch('/api/appointments/book', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    $('#appointmentModal').modal('hide');
                    if (window.calendar) window.calendar.refetchEvents();
                    showNotification('Appointment booked successfully', 'success');
                    loadappointmentsForDataTable();
                } else {
                    showNotification('Error: ' + data.message, 'error');
                }
            })
            .catch(err => {
                console.error('Error:', err);
                showNotification('Error booking appointment', 'error');
            });
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            Swal.fire("Cancelled", "No action performed.", "error");
        }
    });
}

</script>
