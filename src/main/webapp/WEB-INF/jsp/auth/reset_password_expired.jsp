<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
    .expired-container {
        min-height: 100vh;
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        position: relative;
        overflow: hidden;
    }
    
    .expired-container::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 100%;
        height: 100%;
        background: linear-gradient(45deg, rgba(220, 53, 69, 0.05) 0%, rgba(220, 53, 69, 0.02) 100%);
        transform: rotate(30deg);
    }
    
    .expired-card {
        max-width: 500px;
        width: 100%;
        background: white;
        border-radius: 20px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.08);
        border: 1px solid rgba(220, 53, 69, 0.15);
        overflow: hidden;
        animation: slideUp 0.6s ease-out;
        position: relative;
        z-index: 2;
    }
    
    @keyframes slideUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .expired-header {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
        padding: 40px 30px 30px;
        text-align: center;
        position: relative;
        overflow: hidden;
    }
    
    .expired-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.1'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
    }
    
    .expired-icon {
        width: 80px;
        height: 80px;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px;
        border: 2px solid rgba(255, 255, 255, 0.3);
        backdrop-filter: blur(10px);
    }
    
    .expired-icon i {
        font-size: 36px;
    }
    
    .expired-body {
        padding: 40px;
        text-align: center;
    }
    
    .expired-content {
        margin-bottom: 30px;
    }
    
    .expired-alert {
        background: linear-gradient(135deg, #fff5f5 0%, #fee2e2 100%);
        border: 2px solid #fecaca;
        border-radius: 16px;
        padding: 25px;
        margin-bottom: 30px;
        text-align: left;
    }
    
    .expired-alert-icon {
        font-size: 32px;
        color: #dc3545;
        margin-bottom: 15px;
        animation: shake 0.5s ease-in-out;
    }
    
    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-5px); }
        75% { transform: translateX(5px); }
    }
    
    .action-buttons {
        display: flex;
        flex-direction: column;
        gap: 10px;
        margin-top: 30px;
    }
    
    .btn-new-request {
        background: linear-gradient(to right, #10b981, #059669);
        border: none;
        padding: 16px 32px;
        font-size: 16px;
        font-weight: 600;
        border-radius: 12px;
        width: 100%;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }
    
    .btn-new-request:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 24px rgba(16, 185, 129, 0.3);
    }
    
    .btn-login {
        background: white;
        border: 2px solid #e5e7eb;
        padding: 14px 32px;
        font-size: 16px;
        font-weight: 600;
        border-radius: 12px;
        width: 100%;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        color: #374151;
    }
    
    .btn-login:hover {
        border-color: #10b981;
        color: #10b981;
        transform: translateY(-2px);
    }
    
    .btn-support {
        background: #6c757d;
        border: none;
        padding: 14px 32px;
        font-size: 16px;
        font-weight: 600;
        border-radius: 12px;
        width: 100%;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        color: white;
    }
    
    .btn-support:hover {
        background: #5a6268;
        transform: translateY(-2px);
    }
    
    .security-info {
        background: #fff3cd;
        border: 1px solid #ffecb5;
        border-radius: 12px;
        padding: 20px;
        margin-top: 30px;
        text-align: left;
    }
    
    .security-info h6 {
        color: #856404;
        font-weight: 600;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .timer-display {
        font-size: 14px;
        font-weight: 600;
        color: #dc3545;
        background: white;
        padding: 8px 16px;
        border-radius: 50px;
        display: inline-block;
        border: 2px solid #f8d7da;
        margin: 15px 0;
    }
    
    .help-section {
        margin-top: 25px;
        padding-top: 20px;
        border-top: 1px solid #e5e7eb;
    }
    
    .help-link {
        color: #10b981;
        font-weight: 600;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: all 0.3s ease;
    }
    
    .help-link:hover {
        color: #047857;
        text-decoration: underline;
    }

    .back-to-login {
        text-align: center;
        margin-top: 25px;
        padding-top: 20px;
        border-top: 1px solid #e5e7eb;
    }
    
    @media (max-width: 576px) {
        .expired-card {
            margin: 0 15px;
        }
        
        .expired-body {
            padding: 30px 20px;
        }
        
        .expired-header {
            padding: 25px 20px 20px;
        }
        
        .action-buttons {
            gap: 8px;
        }
    }
</style>

<div class="expired-container">
    <div class="expired-card">
        <!-- Header -->
        <div class="expired-header">
            <div class="expired-icon">
                <i class="ri-time-line"></i>
            </div>
            <h4 class="h4 fw-bold mb-2">Link Expired</h4>
            <p class="mb-0 opacity-90">This password reset link is no longer valid</p>
        </div>
        
        <!-- Body -->
        <div class="expired-body">
            <!-- Alert Box -->
            <div class="expired-alert">
                <div class="text-center mb-3">
                    <div class="expired-alert-icon">
                        <i class="ri-error-warning-fill"></i>
                    </div>
                    <h6 class="fw-bold text-dark mb-2">Reset Link Has Expired</h6>
                </div>
                
                <div class="expired-content">
                    <p class="text-muted small fw-light mb-3">
                        <strong>For security reasons,</strong> password reset links are only valid for 
                        <span class="fw-semibold text-danger">24 hours</span>. This link has expired and 
                        can no longer be used to reset your password.
                    </p>
                    
                    <div class="timer-display small">
                        <i class="ri-time-line me-2"></i>
                        Link validity: 24 hours (expired)
                    </div>
                    
                    <p class="text-muted mb-0 fs-13 fw-light">
                        If you still need to reset your password, please request a new reset link below.
                    </p>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="action-buttons">
                <a href="forgot_password" class="btn btn-new-request">
                    <i class="ri-refresh-line"></i>
                    <span>Request New Reset Link</span>
                </a>
                
                <div class="back-to-login">
                    <a href="/" class="back-link">
                        <i class="ri-arrow-left-line"></i>
                        <span>Back to Login</span>
                    </a>
                </div>
                
                <!-- <button type="button" class="btn btn-support" onclick="contactSupport()">
                    <i class="ri-customer-service-line"></i>
                    <span>Contact IT Support</span>
                </button> -->
            </div>
            
            <!-- Security Information -->
            <div class="security-info">
                <h6>
                    <i class="ri-shield-keyhole-line"></i>
                    Why Links Expire
                </h6>
                <div class="fs-13">
                    <p class="mb-2">Password reset links expire for your security to:</p>
                    <ul class="mb-0 ps-3">
                        <li class="mb-1">Prevent unauthorized access if the link is intercepted</li>
                        <li class="mb-1">Limit the time window for potential attacks</li>
                        <li>Ensure timely password updates</li>
                    </ul>
                </div>
            </div>
            
            <!-- Help Section -->
            <div class="help-section">
                <p class="text-muted fs-13 mb-3">
                    If you continue to experience issues with password reset, our IT support team is available to assist you.
                </p>
                
                <div class="d-flex flex-column align-items-center">
                    <a href="#" class="help-link mb-2" onclick="showSupportDetails()">
                        <i class="ri-information-line"></i>
                        <span>View Support Details</span>
                    </a>
                    
                    <a href="#" class="help-link" onclick="showFAQ()">
                        <i class="ri-question-line"></i>
                        <span>Password Reset FAQ</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Security warning
        console.log("%c⚠️ LINK EXPIRED ⚠️", "color: #dc3545; font-size: 18px; font-weight: bold;");
        console.log("%cThis password reset link has expired for security reasons.", "color: #fff; background: #dc3545; padding: 5px;");
    });
    
    // Contact support function
    function contactSupport() {
        Swal.fire({
            title: 'Contact IT Support',
            html: `
                <div class="text-center">
                    <div class="mb-4">
                        <i class="ri-headphone-line fs-48 text-success"></i>
                    </div>
                    <h5 class="fw-bold mb-3">IT Support Desk</h5>
                    <div class="contact-info mb-4">
                        <p class="mb-2"><i class="ri-mail-line me-2 text-success"></i>itsupport@landscommission.gov.gh</p>
                        <p class="mb-2"><i class="ri-phone-line me-2 text-success"></i>+233 30 123 4567</p>
                        <p class="mb-0"><i class="ri-time-line me-2 text-success"></i>Mon-Fri, 8:00 AM - 5:00 PM</p>
                    </div>
                    <div class="alert alert-light border text-muted fs-12 p-2">
                        <i class="ri-information-line me-1"></i>Please mention "Password Reset Expired" when contacting support
                    </div>
                </div>
            `,
            icon: 'info',
            confirmButtonText: 'Copy Email',
            confirmButtonColor: '#10b981',
            showCancelButton: true,
            cancelButtonText: 'Close',
            cancelButtonColor: '#6c757d',
            width: '400px',
            preConfirm: () => {
                navigator.clipboard.writeText('itsupport@landscommission.gov.gh');
                Swal.fire({
                    title: 'Copied!',
                    text: 'Email address copied to clipboard',
                    icon: 'success',
                    timer: 1500,
                    showConfirmButton: false
                });
            }
        });
    }
    
    // Show support details
    function showSupportDetails() {
        Swal.fire({
            title: 'IT Support Information',
            html: `
                <div class="text-start">
                    <div class="mb-4">
                        <h6 class="text-primary fw-semibold mb-3">For password reset assistance:</h6>
                        
                        <div class="mb-3">
                            <div class="fw-medium text-muted fs-13 mb-1">Email Support</div>
                            <div class="fw-semibold">itsupport@landscommission.gov.gh</div>
                        </div>
                        
                        <div class="mb-3">
                            <div class="fw-medium text-muted fs-13 mb-1">Phone Support</div>
                            <div class="fw-semibold">+233 30 123 4567 (Ext. 123)</div>
                        </div>
                        
                        <div class="mb-3">
                            <div class="fw-medium text-muted fs-13 mb-1">Office Hours</div>
                            <div class="fw-semibold">Monday - Friday</div>
                            <div class="text-muted fs-13">8:00 AM - 5:00 PM (GMT)</div>
                        </div>
                        
                        <div class="mb-3">
                            <div class="fw-medium text-muted fs-13 mb-1">Urgent Issues</div>
                            <div class="fw-semibold">+233 50 123 4567 (24/7 Emergency)</div>
                        </div>
                    </div>
                    
                    <div class="alert alert-warning border-warning border-start-3 border-0 bg-light p-3">
                        <div class="d-flex">
                            <i class="ri-information-line fs-18 text-warning me-2"></i>
                            <div class="fs-13">
                                <strong>Note:</strong> For faster assistance, please have your employee ID and the error details ready when contacting support.
                            </div>
                        </div>
                    </div>
                </div>
            `,
            icon: 'info',
            confirmButtonText: 'Got it',
            confirmButtonColor: '#10b981',
            width: '500px'
        });
    }
    
    // Show FAQ
    function showFAQ() {
        Swal.fire({
            title: 'Password Reset FAQ',
            html: `
                <div class="text-start">
                    <div class="accordion" id="faqAccordion">
                        <div class="mb-2">
                            <div class="fw-semibold text-primary cursor-pointer" onclick="toggleFAQ(1)">
                                <i class="ri-arrow-right-s-line me-1"></i> Why do reset links expire?
                            </div>
                            <div id="faq1" class="mt-1 text-muted fs-13" style="display: none;">
                                For security reasons. Expiring links prevent unauthorized access if someone else gets the link.
                            </div>
                        </div>
                        
                        <div class="mb-2">
                            <div class="fw-semibold text-primary cursor-pointer" onclick="toggleFAQ(2)">
                                <i class="ri-arrow-right-s-line me-1"></i> How long are reset links valid?
                            </div>
                            <div id="faq2" class="mt-1 text-muted fs-13" style="display: none;">
                                Password reset links are valid for 24 hours from the time they are sent.
                            </div>
                        </div>
                        
                        <div class="mb-2">
                            <div class="fw-semibold text-primary cursor-pointer" onclick="toggleFAQ(3)">
                                <i class="ri-arrow-right-s-line me-1"></i> Can I request multiple reset links?
                            </div>
                            <div id="faq3" class="mt-1 text-muted fs-13" style="display: none;">
                                Yes, you can request a new link as needed. Each link is valid for 24 hours.
                            </div>
                        </div>
                        
                        <div class="mb-2">
                            <div class="fw-semibold text-primary cursor-pointer" onclick="toggleFAQ(4)">
                                <i class="ri-arrow-right-s-line me-1"></i> What if I didn't receive any reset email?
                            </div>
                            <div id="faq4" class="mt-1 text-muted fs-13" style="display: none;">
                                Check your spam/junk folder. If not there, contact IT support for assistance.
                            </div>
                        </div>
                    </div>
                    
                    <div class="mt-4 pt-3 border-top">
                        <small class="text-muted">
                            <i class="ri-lightbulb-line me-1"></i>
                            Still have questions? Contact IT support for further assistance.
                        </small>
                    </div>
                </div>
            `,
            icon: 'question',
            confirmButtonText: 'Close',
            confirmButtonColor: '#10b981',
            width: '500px'
        });
    }
    
    // Toggle FAQ answers
    function toggleFAQ(num) {
        const answer = $('#faq' + num);
        const icon = $('.cursor-pointer').eq(num - 1).find('i');
        
        if (answer.is(':visible')) {
            answer.slideUp();
            icon.removeClass('ri-arrow-down-s-line');
            icon.addClass('ri-arrow-right-s-line');
        } else {
            answer.slideDown();
            icon.removeClass('ri-arrow-right-s-line');
            icon.addClass('ri-arrow-down-s-line');
        }
    }
</script>