<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

 <!-- app-header -->
 <header class="app-header sticky" id="header">

    <!-- Start::main-header-container -->
    <div class="main-header-container container-fluid">

        <!-- Start::header-content-left -->
        <div class="header-content-left">

            <!-- Start::header-element -->
            <div class="header-element">
                <div class="horizontal-logo">
                    <a href="index.html" class="header-logo">
                        <img src="${pageContext.request.contextPath}/assets/images/brand-logos/desktop-logo.png" alt="logo" class="desktop-logo">
                        <img src="${pageContext.request.contextPath}/assets/images/brand-logos/toggle-logo.png" alt="logo" class="toggle-logo">
                        <img src="${pageContext.request.contextPath}/assets/images/brand-logos/desktop-dark.png" alt="logo" class="desktop-dark">
                        <img src="${pageContext.request.contextPath}/assets/images/brand-logos/toggle-dark.png" alt="logo" class="toggle-dark">
                    </a>
                </div>
            </div>
            <!-- End::header-element -->

            <!-- Start::header-element -->
            <div class="header-element mx-lg-0 mx-2">
                <a aria-label="Hide Sidebar" class="sidemenu-toggle header-link animated-arrow hor-toggle horizontal-navtoggle" data-bs-toggle="sidebar" href="javascript:void(0);"><span></span></a>
            </div>
            <!-- End::header-element -->

            <div class="header-element  header-search header-search-content d-md-block d-none">
                <!-- Start::header-link -->
                <input type="text" class="header-search-bar form-control bg-white" id="header-search" placeholder="Search" spellcheck=false autocomplete="off" autocapitalize="off">
                <a href="javascript:void(0);" class="header-search-icon border-0">
                    <i class="bi bi-search fs-12 mb-1"></i>
                </a>
                <!-- End::header-link -->
            </div>

        </div>
        <!-- End::header-content-left -->

        <!-- Start::header-content-right -->
        <ul class="header-content-right">

            <!-- Start::header-element -->
            <li class="header-element d-md-none d-block">
                <a href="javascript:void(0);" class="header-link" data-bs-toggle="modal" data-bs-target="#header-responsive-search">
                    <!-- Start::header-link-icon -->
                    <svg xmlns="http://www.w3.org/2000/svg" class="header-link-icon" viewBox="0 0 256 256"><rect width="256" height="256" fill="none"/><circle cx="112" cy="112" r="80" opacity="0.2"/><circle cx="112" cy="112" r="80" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><line x1="168.57" y1="168.57" x2="224" y2="224" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/></svg>
                    <!-- End::header-link-icon -->
                </a>  
            </li>
            <!-- End::header-element -->

            <!-- Start::header-element -->
            <li class="header-element header-theme-mode">
                <!-- Start::header-link|layout-setting -->
                <a href="javascript:void(0);" class="header-link layout-setting">
                    <span class="light-layout">
                        <!-- Start::header-link-icon -->
                        <svg xmlns="http://www.w3.org/2000/svg" class="header-link-icon" viewBox="0 0 256 256"><rect width="256" height="256" fill="none"/><path d="M108.11,28.11A96.09,96.09,0,0,0,227.89,147.89,96,96,0,1,1,108.11,28.11Z" opacity="0.2"/><path d="M108.11,28.11A96.09,96.09,0,0,0,227.89,147.89,96,96,0,1,1,108.11,28.11Z" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/></svg>
                        <!-- End::header-link-icon -->
                    </span>
                    <span class="dark-layout">
                        <!-- Start::header-link-icon -->
                        <svg xmlns="http://www.w3.org/2000/svg" class="header-link-icon" viewBox="0 0 256 256"><rect width="256" height="256" fill="none"/><circle cx="128" cy="128" r="56" opacity="0.2"/><line x1="128" y1="40" x2="128" y2="32" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><circle cx="128" cy="128" r="56" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><line x1="64" y1="64" x2="56" y2="56" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><line x1="64" y1="192" x2="56" y2="200" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><line x1="192" y1="64" x2="200" y2="56" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><line x1="192" y1="192" x2="200" y2="200" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><line x1="40" y1="128" x2="32" y2="128" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><line x1="128" y1="216" x2="128" y2="224" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><line x1="216" y1="128" x2="224" y2="128" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/></svg>
                        <!-- End::header-link-icon -->
                    </span>
                </a>
                <!-- End::header-link|layout-setting -->
            </li>
            <!-- End::header-element -->

            <!-- Start::header-element -->
            <li class="header-element notifications-dropdown d-xl-block d-none dropdown">
                <!-- Start::header-link|dropdown-toggle -->
                <a href="javascript:void(0);" class="header-link dropdown-toggle" data-bs-toggle="dropdown" data-bs-auto-close="outside" id="messageDropdown" aria-expanded="false">
                    <svg xmlns="http://www.w3.org/2000/svg" class="header-link-icon" viewBox="0 0 256 256"><rect width="256" height="256" fill="none"/><path d="M56,104a72,72,0,0,1,144,0c0,35.82,8.3,64.6,14.9,76A8,8,0,0,1,208,192H48a8,8,0,0,1-6.88-12C47.71,168.6,56,139.81,56,104Z" opacity="0.2"/><path d="M96,192a32,32,0,0,0,64,0" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><path d="M56,104a72,72,0,0,1,144,0c0,35.82,8.3,64.6,14.9,76A8,8,0,0,1,208,192H48a8,8,0,0,1-6.88-12C47.71,168.6,56,139.81,56,104Z" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/></svg>
                    <span class="header-icon-pulse bg-secondary rounded pulse pulse-secondary" id="notificationPulse"></span>
                </a>
                <!-- End::header-link|dropdown-toggle -->
                <!-- Start::main-header-dropdown -->
                <div class="main-header-dropdown dropdown-menu dropdown-menu-end" data-popper-placement="none">
                    <div class="p-3 bg-primary text-fixed-white">
                        <div class="d-flex align-items-center justify-content-between">
                            <p class="mb-0 fs-16">Notifications</p>
                            <a href="javascript:void(0);" class="badge bg-light text-default border" id="notificationBadgeCounter">0</a>
                        </div>
                    </div>
                    <div class="dropdown-divider"></div>
                    <ul class="list-unstyled mb-0" id="notificationList">
                        
                    </ul>
                    <div class="p-5 empty-item1 d-none" id="noNotificationList">
                        <div class="text-center">
                            <span class="avatar avatar-xl avatar-rounded bg-secondary-transparent">
                                <i class="ri-notification-off-line fs-2"></i>
                            </span>
                            <h6 class="fw-medium mt-3">No New Notifications</h6>
                        </div>
                    </div>
                </div>
                <!-- End::main-header-dropdown -->
            </li>
            <!-- End::header-element -->

            <!-- Start::header-element -->
            <li class="header-element header-fullscreen">
                <!-- Start::header-link -->
                <a onclick="openFullscreen();" href="javascript:void(0);" class="header-link">
                    <svg xmlns="http://www.w3.org/2000/svg" class="full-screen-open header-link-icon" viewBox="0 0 256 256"><rect width="256" height="256" fill="none"/><rect x="48" y="48" width="160" height="160" opacity="0.2"/><polyline points="168 48 208 48 208 88" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><polyline points="88 208 48 208 48 168" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><polyline points="208 168 208 208 168 208" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><polyline points="48 88 48 48 88 48" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/></svg>
                    <svg xmlns="http://www.w3.org/2000/svg" class="full-screen-close header-link-icon d-none" viewBox="0 0 256 256"><rect width="256" height="256" fill="none"/><rect x="32" y="32" width="192" height="192" rx="16" opacity="0.2"/><polyline points="160 48 208 48 208 96" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><line x1="144" y1="112" x2="208" y2="48" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><polyline points="96 208 48 208 48 160" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/><line x1="112" y1="144" x2="48" y2="208" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="16"/></svg>
                </a>
                <!-- End::header-link -->
            </li>
            <!-- End::header-element -->

            <!-- Start::header-element -->
            <li class="header-element dropdown">
                <!-- Start::header-link|dropdown-toggle -->
                <a href="javascript:void(0);" class="header-link dropdown-toggle" id="mainHeaderProfile" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
                    <div>
                        <img src="${pageContext.request.contextPath}/assets/images/faces/12.jpg" alt="img" class="header-link-icon">
                    </div>
                </a>
                <!-- End::header-link|dropdown-toggle -->
                <div class="main-header-dropdown dropdown-menu pt-0 overflow-hidden header-profile-dropdown dropdown-menu-end" aria-labelledby="mainHeaderProfile">
                    <div class="p-3 bg-primary text-fixed-white">
                        <div class="d-flex align-items-center justify-content-between">
                            <p class="mb-0 fs-16">Profile</p>
                            <a href="javascript:void(0);" class="text-fixed-white"><i class="ti ti-settings-cog"></i></a>
                        </div>
                    </div>
                    <div class="dropdown-divider"></div>
                    <div class="p-3">
                        <div class="d-flex align-items-start gap-2">
                            <div class="lh-1">
                                <span class="avatar avatar-sm bg-primary-transparent avatar-rounded">
                                    <img src="${pageContext.request.contextPath}/assets/images/faces/12.jpg" alt="">
                                </span>
                            </div>
                            <div>
                                <span class="d-block fw-medium fs-11 lh-1">${fullname}</span>
                                <span class="text-muted fs-12">${emailaddress}</span>
                            </div>
                        </div>
                    </div>
                    <div class="dropdown-divider"></div>
                    <ul class="list-unstyled mb-0">
                        <li>
                            <ul class="list-unstyled mb-0 sub-list">
                                <li>
                                    <a class="dropdown-item d-flex align-items-center" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#profileUpdate"><i class="ti ti-user-circle me-2 fs-18"></i>Profile Settings</a>
                                </li>
                            </ul>        
                        </li>
                        <li>
                            <ul class="list-unstyled mb-0 sub-list">
                                <li>
                                    <!-- <a class="dropdown-item d-flex align-items-center alternate-link" href="javascript:void(0);"><i class="ti ti-lifebuoy me-2 fs-18"></i>Support</a> -->
                                      <a class="dropdown-item d-flex align-items-center" target="_blank" href="https://helpdesk.lc.gov.gh"><i class="ti ti-lifebuoy me-2 fs-18"></i>Support</a>
                                </li>
                            </ul>        
                        </li>
                        <li><a class="dropdown-item d-flex align-items-center" href="#" onclick="logout()"><i class="ti ti-logout me-2 fs-18"></i>Log Out</a></li>
                    </ul>
                </div>
            </li>  
            <!-- End::header-element -->

        </ul>
        <!-- End::header-content-right -->

    </div>
    <!-- End::main-header-container -->

</header>
<!-- /app-header -->

<script>
    $(document).ready(function() {
        $('.alternate-link').on('click', function(e) {
            e.preventDefault();
            
            Swal.fire({
                title: '<strong>Contact System Administrator</strong>',
                html: `
                    <div class="text-start">
                        <div class="mb-4">
                            <h6 class="text-primary fw-semibold mb-2">For any assistance, contact:</h6>
                        </div>
                        
                        <div class="contact-details mb-4">
                            <div class="d-flex align-items-start mb-3">
                                <div class="flex-shrink-0 me-3">
                                    <i class="ri-building-line fs-18 text-success"></i>
                                </div>
                                <div>
                                    <div class="fw-medium text-muted fs-13 mb-1">IT Support Department</div>
                                    <div class="fw-semibold">Lands Commission Headquarters</div>
                                </div>
                            </div>
                            
                            <div class="d-flex align-items-start mb-3">
                                <div class="flex-shrink-0 me-3">
                                    <i class="ri-mail-line fs-18 text-success"></i>
                                </div>
                                <div>
                                    <div class="fw-medium text-muted fs-13 mb-1">Email Address</div>
                                    <div class="fw-semibold">itsupport@lc.gov.gh</div>
                                </div>
                            </div>

                            <div class="d-flex align-items-start mb-3">
                                <div class="flex-shrink-0 me-3">
                                    <i class="ri-global-line fs-18 text-success"></i>
                                </div>
                                <div>
                                    <div class="fw-medium text-muted fs-13 mb-1">Helpdesk Link</div>
                                    <a class="text-secondary" style="text-decoration: underline" href="https://helpdesk.lc.gov.gh" target="blank_">helpdesk.lc.gov.gh<a/>
                                </div>
                            </div>
                            
                            <div class="d-flex align-items-start mb-3">
                                <div class="flex-shrink-0 me-3">
                                    <i class="ri-phone-line fs-18 text-success"></i>
                                </div>
                                <div>
                                    <div class="fw-medium text-muted fs-13 mb-1">Phone Number</div>
                                    <div class="fw-semibold">+233 30 123 4567</div>
                                </div>
                            </div>
                            
                            <div class="d-flex align-items-start">
                                <div class="flex-shrink-0 me-3">
                                    <i class="ri-time-line fs-18 text-success"></i>
                                </div>
                                <div>
                                    <div class="fw-medium text-muted fs-13 mb-1">Office Hours</div>
                                    <div class="fw-semibold">Monday - Friday</div>
                                    <div class="text-muted fs-13">8:00 AM - 5:00 PM (GMT)</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="alert alert-warning border-warning border-start-3 border-0 bg-light p-3 mt-3 mb-0">
                            <div class="d-flex">
                                <i class="ri-information-line fs-18 text-warning me-2"></i>
                                <div class="fs-13">
                                    <strong>Note:</strong> Please have your employee ID ready when contacting support for faster assistance.
                                </div>
                            </div>
                        </div>
                    </div>
                `,
                icon: 'info',
                showCloseButton: true,
                showCancelButton: false,
                confirmButtonText: 'Got it',
                confirmButtonColor: '#10b981',
                width: '500px',
                padding: '1.5rem',
                customClass: {
                    popup: 'border-radius-16',
                    title: 'mb-3',
                    htmlContainer: 'text-dark'
                }
            });
        });

        window.togglePassword_ = function(inputId, button) {
            const input = document.getElementById(inputId);
            const icon = button.querySelector('i');
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }

        // Password validation and strength check
        document.getElementById('pr_web_pass').addEventListener('input', function() {
            const password = this.value;
            const strengthBar = document.getElementById('passwordStrengthBar');
            const strengthText = document.getElementById('passwordStrengthText');
            
            let strength = 0;
            let color = 'bg-danger';
            
            // Check password strength
            if (password.length >= 14) strength += 25;
            if (/[A-Z]/.test(password)) strength += 25;
            if (/[0-9]/.test(password)) strength += 25;
            if (/[^A-Za-z0-9]/.test(password)) strength += 25;
            
            // Update progress bar
            strengthBar.style.width = strength + '%';
            
            // Update color and text
            if (strength >= 75) {
                color = 'bg-success';
                strengthText.textContent = 'Strong password';
                strengthText.className = 'text-success';
            } else if (strength >= 50) {
                color = 'bg-warning';
                strengthText.textContent = 'Medium password';
                strengthText.className = 'text-warning';
            } else if (strength >= 25) {
                color = 'bg-info';
                strengthText.textContent = 'Weak password';
                strengthText.className = 'text-info';
            } else {
                strengthText.textContent = 'Very weak password';
                strengthText.className = 'text-danger';
            }
            
            strengthBar.className = 'progress-bar ' + color;
            
            // Check password match
            const confirmPassword = document.getElementById('pr_web_pass_confirm').value;
            checkPasswordMatch(password, confirmPassword);
        });

        document.getElementById('pr_web_pass_confirm').addEventListener('input', function() {
            const password = document.getElementById('pr_web_pass').value;
            checkPasswordMatch(password, this.value);
        });

        function checkPasswordMatch(password, confirmPassword) {
            const feedback = document.getElementById('passwordMatchFeedback');
            
            if (!confirmPassword) {
                feedback.textContent = 'Please confirm your password';
                feedback.className = 'form-text text-muted';
                return;
            }
            
            if (password === confirmPassword) {
                feedback.innerHTML = '<i class="fas fa-check-circle text-success me-1"></i> Passwords match';
                feedback.className = 'form-text text-success';
            } else {
                feedback.innerHTML = '<i class="fas fa-times-circle text-danger me-1"></i> Passwords do not match';
                feedback.className = 'form-text text-danger';
            }
        }

        $(document).on('click', '#pr_save_updates', function(e){
            e.preventDefault();
            
            var userid = $("#pr_userid").val();
            var phone = $("#pr_phone").val();
            var phone2 = $("#pr_mobile").val();
            var password = $("#pr_web_pass").val();
            var confpassword = $("#pr_web_pass_confirm").val();
            
            // Validate password
            if(!password || password.trim() === '') {
                Swal.fire({
                    icon: 'warning',
                    title: 'Password Required',
                    html: `
                        <div class="text-center">
                            <i class="fas fa-exclamation-triangle fa-3x mb-3 text-warning"></i>
                            <p class="mb-0"><strong>Please enter a password</strong></p>
                            <p class="text-muted small mt-2">Password field cannot be empty.</p>
                        </div>
                    `,
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#ffc107'
                });
                return;
            }
            
            // Validate phone numbers (optional enhancement)
            if(phone && !/^[\d\s\-\+\(\)]{8,}$/.test(phone)) {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid Phone Number',
                    text: 'Please enter a valid primary phone number.',
                    confirmButtonText: 'OK'
                });
                return;
            }
            
            // Check if passwords match
            if(password !== confpassword) {
                Swal.fire({
                    icon: 'error',
                    title: 'Password Mismatch',
                    html: `
                        <div class="text-center">
                            <i class="fas fa-times-circle fa-3x mb-3 text-danger"></i>
                            <p class="mb-0"><strong>Passwords do not match</strong></p>
                            <p class="text-muted small mt-2">Please ensure both password fields contain the same value.</p>
                        </div>
                    `,
                    confirmButtonText: 'Try Again',
                    confirmButtonColor: '#dc3545'
                });
                return;
            }
            
            // Password strength check (optional)
            if(password.length < 8) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Weak Password',
                    html: `
                        <div class="text-start">
                            <p><strong>Password is too short</strong></p>
                            <p class="small">For better security, please use:</p>
                            <ul class="small text-start">
                                <li>At least 8 characters</li>
                                <li>Mix of letters and numbers</li>
                                <li>Special characters (optional)</li>
                            </ul>
                        </div>
                    `,
                    showCancelButton: true,
                    confirmButtonText: 'Continue Anyway',
                    cancelButtonText: 'Go Back',
                    confirmButtonColor: '#ffc107',
                    cancelButtonColor: '#6c757d'
                }).then((result) => {
                    if (result.isConfirmed) {
                        showUpdateConfirmation();
                    }
                });
                return;
            }
            
            showUpdateConfirmation();
            
            function showUpdateConfirmation() {
                // Show confirmation dialog
                Swal.fire({
                    title: 'Update Profile?',
                    html: `
                        <div class="text-start">
                            <p>Are you sure you want to update your profile with the following changes?</p>
                            <div class="alert alert-info">
                                <strong>Changes to be made:</strong>
                                <ul class="mb-0 ps-3">
                                    `+phone ? `<li><i class="fas fa-phone me-1"></i> Primary Phone: <strong>`+phone+`</strong></li>` : ''`
                                    `+phone2 ? `<li><i class="fas fa-mobile-alt me-1"></i> Mobile Phone: <strong>`+phone2+`</strong></li>` : ''`
                                    <li><i class="fas fa-key me-1"></i> Password: <strong>••••••••</strong></li>
                                </ul>
                            </div>
                        </div>
                    `,
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonText: '<i class="fas fa-save me-1"></i> Update Profile',
                    cancelButtonText: '<i class="fas fa-times me-1"></i> Cancel',
                    confirmButtonColor: '#0d6efd',
                    cancelButtonColor: '#6c757d',
                    reverseButtons: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return new Promise((resolve) => {
                            // Perform AJAX call
                            $.ajax({
                                type: "POST",
                                url: "Case_Management_Serv",
                                data: {
                                    request_type: 'update_user_profile',
                                    phone: phone,
                                    phone2: phone2,
                                    password: password,
                                    userid: userid // Added userid if needed
                                },
                                cache: false,
                                success: function(response) {
                                    console.log(response);
                                    resolve(response);
                                },
                                error: function(xhr, status, error) {
                                    resolve({ error: true, message: error });
                                }
                            });
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()
                }).then((result) => {
                    if (result.isConfirmed) {
                        const response = result.value;
                        
                        if(response === "Success" || response.success) {
                            // Success notification
                            Swal.fire({
                                title: 'Profile Updated!',
                                html: `
                                    <div class="text-center">
                                        <i class="fas fa-check-circle fa-4x mb-3 text-success"></i>
                                        <p class="mb-0"><strong>Your profile has been updated successfully</strong></p>
                                        <p class="text-muted small mt-2">Your changes have been saved.</p>
                                    </div>
                                `,
                                icon: 'success',
                                showConfirmButton: false,
                                timer: 2000,
                                timerProgressBar: true,
                                didClose: () => {
                                    // Close modal after success
                                    const profileModal = bootstrap.Modal.getInstance(document.getElementById('profileUpdate'));
                                    if(profileModal) {
                                        profileModal.hide();
                                    }
                                }
                            });
                            
                            // Optional: Show a follow-up toast notification
                            // const Toast = Swal.mixin({
                            //     toast: true,
                            //     //position: 'top-end',
                            //     showConfirmButton: false,
                            //     timer: 3000,
                            //     timerProgressBar: true,
                            //     didOpen: (toast) => {
                            //         toast.addEventListener('mouseenter', Swal.stopTimer);
                            //         toast.addEventListener('mouseleave', Swal.resumeTimer);
                            //     }
                            // });
                            
                            // Toast.fire({
                            //     icon: 'success',
                            //     title: 'Profile updated successfully'
                            // });
                            
                        } else if(response.error) {
                            // Error handling
                            Swal.fire({
                                icon: 'error',
                                title: 'Update Failed',
                                html: `
                                    <div class="text-center">
                                        <i class="fas fa-exclamation-circle fa-3x mb-3 text-danger"></i>
                                        <p class="mb-0"><strong>Failed to update profile</strong></p>
                                        <p class="text-muted small mt-2">`+response.message+` || 'An error occurred'}</p>
                                    </div>
                                `,
                                confirmButtonText: 'Try Again'
                            });
                        } else {
                            // Generic error
                            Swal.fire({
                                icon: 'error',
                                title: 'Update Failed',
                                text: 'An unexpected error occurred while updating your profile.',
                                confirmButtonText: 'OK'
                            });
                        }
                    }
                });
            }
        });

        setTimeout(() => {
            $.ajax({
                type : "POST",
                url : "Case_Management_Serv",
                data : {
                    request_type : 'get_lc_list_notifications',
                },
                cache : false,
                success : function(jobdetails) {

                    //console.log("User date:"+jobdetails);
                    
                    try {
                        if(jobdetails !== 'Data Not Received') {
                            var json_p = JSON.parse(jobdetails);
                            let counter = json_p.counter;
                            if (counter >= 1){
                                counter = counter > 9 ? "9+" : counter;
                                $("#notificationBadgeCounter").text(counter);

                                var datalist = $("#queried_list");
                                $(json_p.data).each(function(){
                                    datalist.append(`
                                    <div class="card card-body">
                                        <a class="text-secondary" style="text-decoration: none;" href="#" data-bs-toggle="modal" data-bs-target="#viewNotificationModal"
                                        data-notice_id="`+this.notice_id+`" data-notice_type="`+this.notice_type+`" data-status="`+this.status+`" data-case_number="`+this.case_number+`"
                                        data-job_number="`+this.job_number+`" data-created_by="`+this.created_by+`" data-details="`+this.details+`"
                                        data-date="`+this.created_date+`" data-transaction_number="`+this.transaction_number+`" data-notification_replies='`+JSON.stringify(this.replies)+`'
                                        >
                                            <div class="d-flex align-items-center gap-2 mb-3">
                                                <div class="fs-10 text-muted lh-1">
                                                    <i class="ti ti-circle align-middle text-success"></i>
                                                </div>
                                                <span class="fw-medium small text-dark" id="modalEventStart">`+this.job_number+`</span>
                                            </div> 
                                            <span class="d-block fw-light text-muted mb-3" id="modalEventDescription">`+this.details+`</span>
                                            <span class="fw-light small text-muted">`+this.created_date+`</span> 
                                        </a>
                                    </div>
                                    `)
                                }) 
            
                                $('#queriedNotificationModal').modal('show');

                                var datalist = $("#notificationList");
                                //datalist.empty();
                                $(json_p.data).each(function(){
                                    const noticeType = this.notice_type=='query' ? 'bg-danger-transparent' : 'bg-primary-transparent';
                                    datalist.append(`
                                        <li class="dropdown-item position-relative">
                                            <a href="#" data-bs-toggle="modal" data-bs-target="#viewNotificationModal" class="stretched-link"
                                                data-notice_id="`+this.notice_id+`" data-notice_type="`+this.notice_type+`" data-status="`+this.status+`" data-case_number="`+this.case_number+`"
                                                data-job_number="`+this.job_number+`" data-created_by="`+this.created_by+`" data-details="`+this.details+`"
                                                data-date="`+this.created_date+`" data-transaction_number="`+this.transaction_number+`" data-notification_replies='`+JSON.stringify(this.replies)+`'
                                            ></a>
                                            <div class="d-flex align-items-start gap-3">
                                                <div class="lh-1">
                                                    <span class="avatar avatar-sm avatar-rounded `+noticeType+` fs-5">
                                                        <i class="ri-notification-line fs-16"></i>
                                                    </span>
                                                </div>
                                                <div class="flex-fill">
                                                    <span class="d-block small fw-semibold">`+this.job_number+`</span>
                                                    <span class="d-block text-muted fw-light fs-12">`+this.details+`</span>
                                                </div>
                                                <div class="text-end">
                                                    <span class="d-block mb-1 fs-12 text-muted">`+this.created_date+`</span>
                                                    <span class="d-block text-primary"><i class="ri-circle-fill fs-9"></i></span>
                                                </div>
                                            </div>
                                        </li>
                                        `
                                    )
                                    
                                });

                                $("#noNotificationList").addClass('d-none');
                                $("#notificationPulse").removeClass('d-none');

                            } else {
                                $("#noNotificationList").removeClass('d-none');
                                $("#notificationPulse").addClass('d-none');
                            }
                            
                        }
                    }
                    catch (err) {
                        console.log(err.name);
                        console.log(err);
                    }
                    
                }
            });
        }, 500)

        // Helper function to format date
        function formatDate(dateString) {
            if (!dateString) return 'Unknown date';
            
            const date = new Date(dateString);
            if (isNaN(date.getTime())) return dateString;
            
            const now = new Date();
            const diffMs = now - date;
            const diffMins = Math.floor(diffMs / 60000);
            const diffHours = Math.floor(diffMs / 3600000);
            const diffDays = Math.floor(diffMs / 86400000);
            
            if (diffMins < 1) return 'Just now';
            if (diffMins < 60) return `${diffMins} min ago`;
            if (diffHours < 24) return `${diffHours} hours ago`;
            if (diffDays < 7) return `${diffDays} days ago`;
            
            return date.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric'
            });
        }

        $('#viewNotificationModal').on('shown.bs.modal', function (e) {
            // Initialize form state
            $("#replyFormContainer").hide();
            $("#notificationReplies").html('');
            $("#btnCancelReply").off('click').on('click', function() {
                $("#replyFormContainer").slideUp();
            });
            
            // Set text values from data attributes
            const relatedTarget = $(e.relatedTarget);
            
            // Set text values instead of input values
            $("#notice-frm-jobnumber-text").text(relatedTarget.data('job_number') || '-');
            $("#notice-frm-date-text").text(relatedTarget.data('date') || '-');
            $("#notice-frm-by-text").text(relatedTarget.data('created_by') || '-');
            $("#notice-frm-type-text").text(relatedTarget.data('notice_type') || '-');
            $("#notice-frm-details-text").text(relatedTarget.data('details') || '-');
            
            // Status with colored badge
            const status = relatedTarget.data('status') || '-';
            $("#notice-frm-status-text").text(status);
            updateStatusBadge(status);
            
            // Set hidden form values
            $("#nt_case_number").val(relatedTarget.data('case_number'));
            $("#nt_transaction_number").val(relatedTarget.data('transaction_number'));
            $("#nt_job_number").val(relatedTarget.data('job_number'));
            $("#reply-frm-notice-id").val(relatedTarget.data('notice_id'));
            
            // Handle Reply Notification button
            $("#btnReplyNotification").off('click').on('click', function() {
                $("#replyFormContainer").slideDown();
                $("#reply-frm-details").focus();
            });
            
            // Load replies
            loadReplies(JSON.parse(relatedTarget.data('notification_replies')));
        });

        // Function to update status badge color
        function updateStatusBadge(status) {
            const badge = $("#notice-frm-status-text");
            badge.removeClass('bg-info bg-success bg-warning bg-danger bg-secondary');
            
            const statusLower = status.toLowerCase();
            if (statusLower.includes('completed') || statusLower.includes('resolved') || statusLower.includes('closed')) {
                badge.addClass('bg-success');
            } else if (statusLower.includes('pending') || statusLower.includes('in progress') || statusLower.includes('processing')) {
                badge.addClass('bg-warning');
            } else if (statusLower.includes('urgent') || statusLower.includes('critical')) {
                badge.addClass('bg-danger');
            } else if (statusLower.includes('new') || statusLower.includes('open')) {
                badge.addClass('bg-info');
            } else {
                badge.addClass('bg-secondary');
            }
        }

        // Function to load replies
        function loadReplies(replies) {
            try {
                // Ensure replies is an array
                if (typeof replies === 'string') {
                    replies = JSON.parse(replies);
                }

                if (!Array.isArray(replies)) {
                    replies = [];
                }

                const repliesContainer = $("#notificationReplies");
                const replyCountBadge = $("#replyCountBadge");

                repliesContainer.empty();

                if (replies.length > 0) {
                    replyCountBadge.text(replies.length);

                    replies.forEach(reply => {
                        const replyBy = reply.by || 'Unknown User';
                        const replyText = reply.reply_details || 'No content';
                        const replyDate = reply.date || 'Unknown date';

                        const replyHtml = `
                            <div class="reply-item mb-3 p-3 bg-light rounded border">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-user-circle text-primary me-2"></i>
                                        <strong class="text-primary">`+replyBy+`</strong>
                                    </div>
                                    <div class="text-muted small">
                                        <i class="fas fa-clock me-1"></i>
                                        `+replyDate+`
                                    </div>
                                </div>
                                <div class="reply-content ps-4">
                                    <i class="fas fa-quote-left text-muted me-2"></i>
                                    `+replyText+`
                                </div>
                            </div>
                        `;

                        repliesContainer.append(replyHtml);
                    });
                } else {
                    repliesContainer.html(`
                        <div class="empty-replies text-center py-5">
                            <i class="fas fa-comment-slash fa-3x text-muted mb-3"></i>
                            <p class="text-muted mb-0">No replies yet</p>
                            <p class="small text-muted">Be the first to reply to this notification</p>
                        </div>
                    `);

                    replyCountBadge.text('0');
                }

            } catch (error) {
                console.error('Error loading replies:', error);
                $("#notificationReplies").html(`
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Error loading replies. Please try again.
                    </div>
                `);
            }
        }

        $("#frmNotificationReply").submit(function(e){
            e.preventDefault();
            
            let reply_message = $("#reply-frm-details").val().trim();
            let reply_notice_id = $("#reply-frm-notice-id").val();
            
            // Validate message
            if(!reply_message) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Message Required',
                    text: 'Please enter a reply message before submitting.',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#ffc107',
                    showClass: {
                        popup: 'animate__animated animate__shakeX'
                    }
                });
                return;
            }
            
            // Show confirmation dialog
            Swal.fire({
                title: 'Send Reply?',
                html: `
                    <div class="text-start">
                        <p>Are you sure you want to send this reply?</p>
                        <div class="alert alert-info mt-3">
                            <strong>Reply Message:</strong>
                            <div class="mt-2 p-2 bg-white rounded border">`+reply_message+`</div>
                        </div>
                        <p class="text-muted small mt-2">This reply will be sent to the notification sender and other recipients.</p>
                    </div>
                `,
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: '<i class="fas fa-paper-plane me-2"></i> Yes, Send Reply',
                cancelButtonText: '<i class="fas fa-times me-2"></i> Cancel',
                confirmButtonColor: '#198754',
                cancelButtonColor: '#6c757d',
                reverseButtons: true,
                showLoaderOnConfirm: true,
                preConfirm: () => {
                    return new Promise((resolve) => {
                        // Perform AJAX call
                        $.ajax({
                            type: "POST",
                            url: "Case_Management_Serv",
                            data: {
                                request_type: 'compliance_create_notice_reply',
                                notice_id: reply_notice_id,
                                message: reply_message
                            },
                            cache: false,
                            success: function(result) {
                                resolve({ success: true, data: result });
                            },
                            error: function(xhr, status, error) {
                                resolve({ success: false, error: error });
                            }
                        });
                    });
                },
                allowOutsideClick: () => !Swal.isLoading()
            }).then((result) => {
                if (result.isConfirmed) {
                    const response = result.value;
                    
                    if(response.success) {
                        // Success - parse and display new replies
                        try {
                            const jsonData = JSON.parse(response.data);
                            
                            // Clear and reload replies
                            $("#notificationReplies").html("");
                            if(jsonData.length > 0) {
                                jsonData.forEach(function(reply){
                                    const replyBy = reply.by || 'Unknown User';
                                    const replyText = reply.reply_details || 'No content';
                                    const replyDate = reply.date || 'Unknown date';

                                    $("#notificationReplies").append(`
                                        <div class="reply-item mb-3 p-3 bg-light rounded border">
                                            <div class="d-flex justify-content-between align-items-start mb-2">
                                                <div class="d-flex align-items-center">
                                                    <i class="fas fa-user-circle text-primary me-2"></i>
                                                    <strong class="text-primary">`+replyBy+`</strong>
                                                </div>
                                                <div class="text-muted small">
                                                    <i class="fas fa-clock me-1"></i>
                                                    `+replyDate+`
                                                </div>
                                            </div>
                                            <div class="reply-content ps-4">
                                                <i class="fas fa-quote-left text-muted me-2"></i>
                                                `+replyText+`
                                            </div>
                                        </div>
                                    `);
                                });
                            } else {
                                // No replies yet
                                $("#notificationReplies").html(`
                                    <div class="empty-replies text-center py-5">
                                        <i class="fas fa-comment-slash fa-3x text-muted mb-3"></i>
                                        <p class="text-muted mb-0">No replies yet</p>
                                        <p class="small text-muted">Be the first to reply to this notification</p>
                                    </div>
                                `);
                            }
                            
                            // Update reply count badge
                            const replyCount = jsonData.length || 0;
                            $("#replyCountBadge").text(replyCount);
                            
                            // Hide form and clear fields
                            $("#frmNotificationReply").slideUp();
                            $("#reply-frm-details").val("");
                            
                            // Show success message
                            Swal.fire({
                                title: 'Reply Sent!',
                                html: `
                                    <div class="text-center">
                                        <i class="fas fa-check-circle fa-4x text-success mb-3"></i>
                                        <p class="mb-0"><strong>Your reply has been sent successfully</strong></p>
                                        <p class="text-muted small mt-2">The notification recipients have been notified.</p>
                                    </div>
                                `,
                                showConfirmButton: true,
                                confirmButtonText: 'OK',
                                confirmButtonColor: '#198754'
                            });
                            
                        } catch(error) {
                            console.error("Error parsing reply data:", error);
                            
                            // Hide form and clear fields even if there's an error parsing
                            $("#frmNotificationReply").slideUp();
                            $("#reply-frm-details").val("");
                            
                            // Show error message for parsing failure
                            Swal.fire({
                                icon: 'warning',
                                title: 'Reply Sent',
                                text: 'Your reply was sent, but there was an issue loading the updated replies.',
                                confirmButtonText: 'OK',
                                confirmButtonColor: '#ffc107'
                            });
                        }
                        
                    } else {
                        // AJAX error
                        Swal.fire({
                            icon: 'error',
                            title: 'Failed to Send Reply',
                            html: `
                                <div class="text-center">
                                    <i class="fas fa-times-circle fa-3x text-danger mb-3"></i>
                                    <p class="mb-0"><strong>An error occurred while sending your reply</strong></p>
                                    <p class="text-muted small mt-2">`+response.error || 'Please try again later.'`+</p>
                                </div>
                            `,
                            confirmButtonText: 'Try Again',
                            confirmButtonColor: '#dc3545'
                        });
                    }
                }
            });
        });
    });
</script>