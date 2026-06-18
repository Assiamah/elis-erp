<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
    .login-gradient-bg {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
    }

    .glass-effect {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .input-group-custom {
        transition: all 0.3s ease;
        border-radius: 8px;
    }

    .input-group-custom:focus-within {
        border-color: #10b981;
        box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
        transform: translateY(-1px);
    }

    .btn-primary-gradient {
        background: linear-gradient(to right, #10b981, #059669);
        border: none;
        transition: all 0.3s ease;
        color: white;
    }

    .btn-primary-gradient:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(16, 185, 129, 0.3);
        background: linear-gradient(to right, #059669, #047857);
    }

    .btn-primary-gradient:disabled {
        background: linear-gradient(to right, #a7f3d0, #6ee7b7);
        transform: none;
        box-shadow: none;
    }

    .floating-label {
        position: absolute;
        top: 50%;
        left: 12px;
        transform: translateY(-50%);
        transition: all 0.3s ease;
        pointer-events: none;
        color: #6b7280;
        font-size: 14px;
    }

    .floating-input {
        padding-top: 24px !important;
        padding-bottom: 8px !important;
    }

    .floating-input:focus + .floating-label,
    .floating-input:not(:placeholder-shown) + .floating-label {
        top: 2px;
        left: 10px;
        font-size: 12px;
        color: #059669;
        background: white;
        padding: 0 5px;
        font-weight: 500;
    }

    .auth-sidebar {
        position: relative;
        overflow: hidden;
    }

    .auth-sidebar::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(135deg, rgba(16, 185, 129, 0.9), rgba(5, 150, 105, 0.9));
        z-index: 1;
    }

    .auth-sidebar-content {
        position: relative;
        z-index: 2;
        min-height: 100vh;
    }

    .pulse-animation {
        animation: pulse 2s infinite;
    }

    @keyframes pulse {
        0% {
            box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.4);
        }
        70% {
            box-shadow: 0 0 0 10px rgba(16, 185, 129, 0);
        }
        100% {
            box-shadow: 0 0 0 0 rgba(16, 185, 129, 0);
        }
    }

    .pattern-dots {
        background-image: radial-gradient(rgba(255, 255, 255, 0.1) 1px, transparent 1px);
        background-size: 20px 20px;
        height: 100%;
    }
    
    .glass-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        transition: all 0.3s ease;
        border-radius: 12px;
    }
    
    .glass-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1) !important;
        border-color: rgba(16, 185, 129, 0.3);
    }
    
    .icon-wrapper {
        transition: all 0.3s ease;
    }
    
    .glass-card:hover .icon-wrapper {
        transform: scale(1.1);
        background-color: rgba(16, 185, 129, 0.15) !important;
    }
    
    .auth-sidebar {
        background: linear-gradient(135deg, #0d966b 0%, #0a7c56 100%);
    }
    
    .auth-sidebar::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(135deg, 
            rgba(13, 150, 107, 0.95), 
            rgba(10, 124, 86, 0.95));
        z-index: 1;
    }
    
    .auth-sidebar-content {
        position: relative;
        z-index: 2;
    }
    
    .bg-opacity-10 {
        background-color: rgba(var(--bs-white-rgb), 0.1) !important;
    }
    
    .bg-opacity-25 {
        background-color: rgba(var(--bs-white-rgb), 0.25) !important;
    }
    
    .border-opacity-25 {
        border-color: rgba(var(--bs-white-rgb), 0.25) !important;
    }
    
    .badge {
        border-radius: 8px;
        font-weight: 500;
    }
    
    .alert-light {
        background-color: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
    }

    .auth-left-container {
    min-height: 100vh;
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 24px;
    position: relative;
    font-family: 'Inter', sans-serif;
}

.auth-left-container::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -50%;
    width: 100%;
    height: 100%;
    background: linear-gradient(
        45deg,
        rgba(16,185,129,0.06),
        rgba(16,185,129,0.02)
    );
    transform: rotate(30deg);
}

.auth-card {
    max-width: 460px;
    width: 100%;
    background: #ffffff;
    border-radius: 16px;
    box-shadow: 0 12px 45px rgba(0,0,0,0.1);
    border: 1px solid rgba(16,185,129,0.15);
    overflow: hidden;
    z-index: 2;
}

.auth-card-header {
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
    padding: 28px;
    text-align: center;
}

.auth-card-body {
    padding: 36px;
}


.auth-logo {
    background: #ffffff;
    width: 64px;
    height: 64px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
     margin: 0 auto 16px;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}

.auth-logo img {
    border-radius: 50%;
}




.auth-title {
    color: #ffffff;
    font-weight: 800;
    font-size: 1.35rem;
    letter-spacing: 0.5px;
    font-family: "Inter", "Segoe UI", "Roboto", system-ui, -apple-system, sans-serif;
    text-shadow: 0 2px 8px rgba(0, 0, 0, 0.25);
}

.auth-subtitle {
    color: rgba(255, 255, 255, 0.85);
    font-size: 0.9rem;
    font-weight: 500;
    letter-spacing: 0.6px;
    text-transform: uppercase;
}
.auth-subtitle::before {
    content: "";
    display: block;
    width: 40px;
    height: 2px;
    background: rgba(255, 255, 255, 0.4);
    margin: 8px auto 6px;
    border-radius: 2px;
}

.env-card-banner {
    width: 100%;
    padding: 8px 12px;
    text-align: center;
    font-weight: 700;
    font-size: 0.85rem;
    letter-spacing: 1px;
    color: #fff;
    border-top-left-radius: 12px;
    border-top-right-radius: 12px;
}

/* TEST */
.env-test {
    background: linear-gradient(90deg, #ff9800, #f44336);
    animation: blink 1.2s infinite;
}

/* PRE-PROD */
.env-preprod {
    background: linear-gradient(90deg, #fb8c00, #e53935);
    animation: blink 1.2s infinite;
}

/* PROD – no blinking */
.env-prod {
    background: linear-gradient(90deg, #2e7d32, #66bb6a);
}

/* Blink */
@keyframes blink {
    0%   { opacity: 1; }
    50%  { opacity: 0.4; }
    100% { opacity: 1; }
}

</style>

<div class="container-fluid min-vh-100 p-0">
    <div class="row g-0 h-100">
        <!-- Left Side - Login Form -->
        <div class="col-lg-6 p-0">
            <div class="auth-left-container">
                <div class="auth-card">
<!-- 🔴 ENV BANNER -->
    <div class="env-card-banner env-test">${server_version}</div>
                    <!-- Header -->
                    <div class="auth-card-header">
                        <div class="auth-logo">
                            <img src="${pageContext.request.contextPath}/assets/images/NewLogo.jpg"
                                width="42" class="rounded-circle" alt="logo">
                        </div>
                    <h1 class="auth-title mb-1">Enterprise Land Information System</h1>
                        <p class="auth-subtitle mb-0">Secure Access</p>
                    </div>

                    <!-- Body -->
                    <div class="auth-card-body">

                        <div class="text-center mb-4">
                            <h2 class="h5 fw-semibold text-dark mb-1">Welcome Back</h2>
                            <p class="text-muted fs-14 mb-0">
                                Sign in with your official credentials
                            </p>
                        </div>

                        <!-- 🔴 KEEP YOUR EXISTING LOGIN FORM HERE -->
                        <!-- (email, password, remember me, submit button) -->

                        <!-- Error Alert -->
                                <c:if test="${login == 'failed'}">
                                    <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center mb-4" role="alert">
                                        <div class="flex-shrink-0">
                                            <i class="ri-error-warning-line fs-20"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="alert-heading fw-semibold mb-1">Authentication Failed</h6>
                                            <p class="mb-0 fs-13">Invalid credentials. Please check your email and password.</p>
                                        </div>
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <!-- Login Form -->
                                <form name="loginForm" id="loginForm" method="POST" action="two_factor_verification" novalidate>
                                    <!-- Email Field -->
                                    <div class="mb-3">
                                        <div class="position-relative">
                                            <input type="email" 
                                                class="form-control floating-input ps-4" 
                                                name="email" 
                                                id="email" 
                                                placeholder=""
                                                pattern="[a-zA-Z0-9._%+-]+@lc\.gov\.gh$"
                                                title="Email must be a valid @lc.gov.gh address"
                                                required>
                                            <label for="email" class="floating-label">
                                                <i class="ri-user-line me-2"></i>User ID
                                            </label>
                                            <!-- <div class="position-absolute end-0 top-50 translate-middle-y me-4">
                                                <i class="ri-user-3-line text-muted"></i>
                                            </div> -->
                                        </div>
                                        <small class="text-muted fw-light small"><i class="ri-information-line me-1"></i>User ID is your official email address</small>
                                    </div>

                                    <!-- Password Field -->
                                    <div class="mb-4">
                                        <div class="position-relative">
                                            <input type="password" 
                                                class="form-control floating-input ps-4" 
                                                name="password" 
                                                id="password" 
                                                placeholder=" "
                                                required>
                                            <label for="password" class="floating-label">
                                                <i class="ri-lock-line me-2"></i>Password
                                            </label>
                                            <button type="button" 
                                                    class="btn btn-link position-absolute end-0 top-50 translate-middle-y text-decoration-none"
                                                    onclick="togglePassword('password', this)">
                                                <i class="ri-eye-off-line align-middle text-muted"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Remember Me & Forgot Password -->
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="rememberMe">
                                            <label class="form-check-label fs-14" for="rememberMe">
                                                Remember this device
                                            </label>
                                        </div>
                                        <a href="forgot_password" class="text-decoration-none fs-14 text-primary fw-medium">
                                            Forgot Password?
                                        </a>
                                    </div>

                                    <!-- Submit Button -->
                                <!-- Submit Button -->
                                <button type="submit" 
                                        id="btn-login" 
                                        class="btn btn-primary btn-lg w-100 shadow-lg">
                                    <span class="login-text">
                                        <i class="ri-login-circle-line me-2"></i> Sign In
                                    </span>
                                    <span class="loading-text d-none">
                                        <span class="spinner-border spinner-border-sm me-2" role="status"></span>
                                        Authenticating...
                                    </span>
                                </button>

                                
                                </form>

                    </div>
                </div>
            </div>
        </div>
        <!-- Right Side - Welcome Panel -->
        <div class="col-lg-6 p-0 d-none d-lg-flex flex-column position-relative">
            <!-- Background Image with Overlay -->
            <div class="position-absolute top-0 start-0 w-100 h-100">
                <img src="${pageContext.request.contextPath}/assets/images/login/login-bg.jpeg" 
                     alt="Enterprise Land Information System Dashboard" 
                     class="w-100 h-100 object-fit-cover">
                <!-- Dark Overlay on Top of Image -->
                <div class="position-absolute top-0 start-0 w-100 h-100 bg-dark" style="opacity: 0.6;"></div>
            </div>
            
            <!-- Content Container -->
            <div class="position-relative z-1 d-flex flex-column justify-content-center align-items-center text-white h-100 p-5">
                <!-- System Description -->
                <div class="text-start mb-5">
                    <h2 class="display-5 fw-bold mb-3 text-white">Enterprise Land Information System</h2>
                    <p class="fs-6 fw-light mb-4" style="max-width: 600px;">
                        A comprehensive platform for managing land records, property information, 
                        and spatial data across municipalities. Streamline operations with our 
                        secure, integrated land information system.
                    </p>
                </div>

                <!-- Features/Highlights -->
                <div class="row g-4 mt-4" style="max-width: 800px;">
                    <div class="col-md-4 text-center">
                        <div class="p-4 rounded-3" style="background: rgba(255,255,255,0.1); backdrop-filter: blur(10px);">
                            <i class="ri-map-pin-line fs-1 mb-3 text-success"></i>
                            <h4 class="h5 fw-semibold text-warning mb-2">Spatial Data</h4>
                            <p class="small opacity-75 mb-0">Advanced GIS mapping and spatial analysis tools</p>
                        </div>
                    </div>
                    <div class="col-md-4 text-center">
                        <div class="p-4 rounded-3" style="background: rgba(255,255,255,0.1); backdrop-filter: blur(10px);">
                            <i class="ri-database-2-line fs-1 mb-3 text-success"></i>
                            <h4 class="h5 fw-semibold text-warning mb-2">Centralized Records</h4>
                            <p class="small opacity-75 mb-0">Unified land registry and property database</p>
                        </div>
                    </div>
                    <div class="col-md-4 text-center">
                        <div class="p-4 rounded-3" style="background: rgba(255,255,255,0.1); backdrop-filter: blur(10px);">
                            <i class="ri-shield-check-line fs-1 mb-3 text-success"></i>
                            <h4 class="h5 fw-semibold text-warning mb-2">Secure Access</h4>
                            <p class="small opacity-75 mb-0">Role-based permissions and audit trails</p>
                        </div>
                    </div>
                </div>

                <!-- Additional Information -->
                <div class="text-center mt-5 pt-4 border-top border-white-25" style="max-width: 700px;">
                    <p class="mb-2 opacity-75">
                        <i class="ri-government-line me-2"></i>
                        Official Lands Commission System
                    </p>
                    <p class="small opacity-50 mb-0">
                        Version 5.0 • For authorized personnel only
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Optional: Add some custom CSS if needed -->
<style>
    .object-fit-cover {
        object-fit: cover;
    }
    .border-white-25 {
        border-color: rgba(255, 255, 255, 0.25) !important;
    }
</style>

<script>
    $(document).ready(function() {
        // Security warning
        console.log("%c⚠️ SECURITY WARNING ⚠️", "color: #ff6b6b; font-size: 20px; font-weight: bold;");
        console.log("%cThis is a browser feature intended for developers. Do not enter any information here.", "color: #fff; background: #dc3545; padding: 5px;");
        
        // Password toggle
        window.togglePassword = function(inputId, button) {
            const input = document.getElementById(inputId);
            const icon = button.querySelector('i');
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('ri-eye-off-line');
                icon.classList.add('ri-eye-line');
            } else {
                input.type = 'password';
                icon.classList.remove('ri-eye-line');
                icon.classList.add('ri-eye-off-line');
            }
        };
        
        // Form submission handler
        $('#loginForm').on('submit', function(e) {
            const btn = $('#btn-login');
            const loginText = btn.find('.login-text');
            const loadingText = btn.find('.loading-text');
            
            if (this.checkValidity()) {
                loginText.addClass('d-none');
                loadingText.removeClass('d-none');
                btn.prop('disabled', true).addClass('disabled');
            }
        });
        
        // Input validation styling
        // $('.floating-input').on('blur', function() {
        //     if (this.value) {
        //         $(this).addClass('is-valid');
        //     } else {
        //         $(this).removeClass('is-valid');
        //     }
        // });
        
        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            $('.alert-dismissible').alert('close');
        }, 5000);

        $('.alternate-link').on('click', function(e) {
            e.preventDefault();
            
            Swal.fire({
                title: '<strong>Contact System Administrator</strong>',
                html: `
                    <div class="text-start">
                        <div class="mb-4">
                            <h6 class="text-primary fw-semibold mb-2">For login assistance, contact:</h6>
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
    });
</script>