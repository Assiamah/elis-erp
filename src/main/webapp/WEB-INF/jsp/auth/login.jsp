<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<div class="row authentication authentication-cover-main mx-0">
    <div class="col-xxl-9 col-xl-9">
        <div class="row justify-content-center align-items-center h-100">
            <div class="col-xxl-4 col-xl-5 col-lg-6 col-md-6 col-sm-8 col-12">
                <div class="card custom-card border-0 shadow-none my-4">
                    <div class="card-body p-5">
                        <div class="text-center mb-5">
                            <img src="${pageContext.request.contextPath}/assets/images/NewLogo.jpg" width="100" alt="logo">
                        </div>
                        <div>
                            <h4 class="mb-1 fw-semibold">Login</h4>
                            <p class="mb-4 text-muted fw-normal">Please enter your credentials</p>
                        </div>
                        ${login == 'failed' ? '
                            <div class="alert alert-danger border border-danger mb-3 p-2">
                                <div class="d-flex align-items-start">
                                    <div class="me-2 svg-danger">
                                        <svg class="flex-shrink-0" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="1.5rem" viewBox="0 0 24 24" width="1.5rem" fill="#000000"><g><rect fill="none" height="24" width="24"></rect></g><g><g><g><path d="M15.73,3H8.27L3,8.27v7.46L8.27,21h7.46L21,15.73V8.27L15.73,3z M19,14.9L14.9,19H9.1L5,14.9V9.1L9.1,5h5.8L19,9.1V14.9z"></path><rect height="6" width="2" x="11" y="7"></rect><rect height="2" width="2" x="11" y="15"></rect></g></g></g></svg>
                                    </div>
                                    <div class="text-danger w-100">
                                        <div class="fw-medium d-flex justify-content-between">Authentication Failed!<button type="button" class="btn-close p-0" data-bs-dismiss="alert" aria-label="Close"><i class="bi bi-x"></i></button></div>
                                        <div class="fs-12 op-8 mb-1">Invalid email or password. Please check your email or password.</div>
                                    </div>
                                </div>
                            </div>
                        ' : ''}
                        <form name="loginForm" id="loginForm" method="POST" action="two_factor_verification">
                            <div class="row gy-3">
                                <div class="col-xl-12">
                                    <label for="signin-email" class="form-label text-default">Email <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" name="email" id="email" placeholder="Enter your official email" required>
                                </div>
                                <div class="col-xl-12 mb-2">
                                    <label for="signin-password" class="form-label text-default d-block">Password <span class="text-danger">*</span></label>
                                    <div class="position-relative">
                                        <input type="password" class="form-control" name="password" id="password" placeholder="Enter your password" required>
                                        <a href="javascript:void(0);" class="show-password-button text-muted" onclick="createpassword('password',this)" id="button-addon2"><i class="ri-eye-off-line align-middle"></i></a>
                                    </div>
                                    <div class="mt-2">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" value="" id="defaultCheck1" checked>
                                            <label class="form-check-label" for="defaultCheck1">
                                                Remember me
                                            </label>
                                            <a href="reset-password-basic.html" class="float-end link-danger fw-medium fs-12">Forget password ?</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="d-grid mt-3">
                                <button type="submit" id="btn-login" class="btn btn-primary"><i class="ri-login-box-line me-1"></i>Sign In</button>
                            </div>
                        </form>
                
                        <div class="text-center mt-5 fw-medium">
                            Having trouble with login? <a href="#" class="text-primary">Click Here</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xxl-3 col-xl-3 col-lg-12 d-xl-block d-none px-0">
        <div class="authentication-cover overflow-hidden">
            <!-- <div class="authentication-cover-logo">
                <a href="index.html">
                <img src="../assets/images/brand-logos/toggle-logo.png" alt="logo" class="desktop-dark"> 
                </a>
            </div> -->
            <div class="authentication-cover-background">
                <img src="../assets/images/media/backgrounds/9.png" alt="">
            </div>
            <div class="authentication-cover-content">
                <div class="p-5">
                    <h3 class="fw-semibold lh-base">Welcome to Enterprise Land Information System (ELIS)</h3>
                    <p class="mb-0 text-muted fw-medium"><span class="text-danger">NB:</span> Please do not share your password with anyone.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        console.log("%cStop!", "color: red; font-size: 30px; font-weight: bold;");
        console.log("%cDO NOT TYPE OR PASTE ANYTHING HERE", "color: red; font-size: 16px; font-weight: bold;");

        document.getElementById('loginForm').addEventListener('submit', function (e) {
            var $this = $('#btn-login');
            var loadingText = '<span class=""><i class="mdi mdi-spin mdi-loading me-1"></i>Authenticating...</span>';

            if ($('#btn-login').html() !== loadingText) {
                $this.data('original-text', $('#btn-login').html());
                $this.html(loadingText);
                $('#btn-login').prop('disabled', true);
            }
        });
    });
</script>