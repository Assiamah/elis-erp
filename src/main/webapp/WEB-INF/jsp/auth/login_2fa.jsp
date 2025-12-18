<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<div class="row authentication authentication-cover-main mx-0">
    <div class="col-xxl-9 col-xl-9">
        <div class="row justify-content-center align-items-center h-100">
            <div class="col-xxl-4 col-xl-5 col-lg-6 col-md-6 col-sm-8 col-12">
                <div class="card custom-card border-0 shadow-none my-4">
                    <div class="card-body p-4">
                        <!-- <div class="text-center mb-5">
                            <img src="${pageContext.request.contextPath}/assets/images/NewLogo.jpg" width="100" alt="logo">
                        </div> -->
                        <div>
                            <p class="h4 mb-2 fw-semibold">Verify Your Account</p>
                            <h2 class="fw-medium">${otp_code}</h2>
                            <p class="text-muted fw-normal">Please enter the OTP (one time password) to verify your account. A Code has been sent to <span id="phone_number">${user_phone}</span> and <span id="user_emailaddress"></span></p>
                            <div class="h4 mt-2 mb-4 " id="timer">10:00</div>
                        </div>
                        <form name="loginForm" id="loginForm" method="POST" action="Login">
                            <div class="row gy-3">
                                <div class="col-xl-12 mb-2">
                                    <div class="row">
                                        <div class="col-2">
                                            <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input"  id="vc_1" name="vc_1" maxlength="1" onkeyup="clickEvent(this,'vc_2')">
                                        </div>
                                        <div class="col-2">
                                            <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_2" name="vc_2" maxlength="1" onkeyup="clickEvent(this,'vc_3')">
                                        </div>
                                        <div class="col-2">
                                            <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_3" name="vc_3" maxlength="1" onkeyup="clickEvent(this,'vc_4')">
                                        </div>
                                        <div class="col-2">
                                            <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_4" name="vc_4" maxlength="1" onkeyup="clickEvent(this,'vc_5')">
                                        </div>
                                        <div class="col-2">
                                            <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_5" name="vc_5" maxlength="1" onkeyup="clickEvent(this,'vc_6')">
                                        </div>
                                        <div class="col-2">
                                            <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_6" name="vc_6" maxlength="1">
                                        </div>
                                    </div>
                                    <div class="form-check mt-3">
                                        <label class="form-check-label" for="defaultCheck1">
                                            Did not recieve a code ?<a href="#" class="text-primary ms-2 d-inline-block fw-medium">Resend</a>
                                        </label>
                                    </div>
                                </div>
                                <div class="col-xl-12 d-grid mt-3">
                                    <button type="submit" id="btn-verify" class="btn btn-primary"><i class="ri-shield-check-line me-1"></i>Verify</button>
                                </div>
                            </div>
                        </form>
                
                        <div class="text-center mt-5 fw-medium">
                            Do you want to go back to login? <a href="/" class="text-primary">Click Here</a>
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

<!-- Bootstrap JS -->
<script src="${pageContext.request.contextPath}/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Internal Two Step Verification JS -->
<script src="${pageContext.request.contextPath}/assets/js/two-step-verification.js"></script>

<script>

    let str = document.getElementById("phone_number").innerHTML;
    let res = str.replace(/\d(?=\d{3})/g, "*");
    document.getElementById("phone_number").innerHTML = res;

    function maskEmail(email) {
        const [user, domain] = email.split("@");

        // Show first 2 characters, mask the rest
        const maskedUser = user.substring(0, 2) + "*".repeat(Math.max(user.length - 2, 0));

        // Optionally mask part of domain too
        const [domainName, domainExt] = domain.split(".");
        const maskedDomain = domainName.substring(0, 1) + "***" + "." + domainExt;

        return maskedUser + "@" + maskedDomain;
    }

    // Example usage
    const email = "${user_emailaddress}";
    document.getElementById("user_emailaddress").innerText = maskEmail(email);

    const KEY = "otpCountdownTarget"; // stores target timestamp (ms)
    const DURATION = 60*10; // seconds
    const timerEl = document.getElementById("timer");

    let intervalId = null;

    function formatMMSS(totalSeconds) {
        const m = Math.floor(totalSeconds / 60).toString().padStart(2, "0");
        const s = Math.floor(totalSeconds % 60).toString().padStart(2, "0");
        return m+':'+s;
    }

    function getOrCreateTarget(fromNowSeconds = DURATION) {
        let t = localStorage.getItem(KEY);
        const now = Date.now();
        if (!t || Number(t) <= now) {
            // create new target only if none exists or already expired
            t = String(now + fromNowSeconds * 1000);
            localStorage.setItem(KEY, t);
        }
        return Number(t);
    }

    function startCountdown() {
        const target = getOrCreateTarget();
        updateUI(target);
        if (intervalId) clearInterval(intervalId);
        intervalId = setInterval(() => updateUI(Number(localStorage.getItem(KEY))), 250);
    }

    function updateUI(targetTs) {
    const now = Date.now();
    const remaining = Math.max(0, Math.ceil((targetTs - now) / 1000));
    timerEl.textContent = formatMMSS(remaining);

        if (remaining <= 0 && intervalId) {
            clearInterval(intervalId);
            intervalId = null;
            localStorage.removeItem(KEY); // clear when expired
            // 👉 Here you can redirect, disable OTP input, or show a "Resend OTP" link
            timerEl.textContent = "Expired";
            $('#timer').addClass('text-danger');
        }
    }

    const otpInputs = document.querySelectorAll('.otp-input');

    otpInputs.forEach((input, index) => {
        // input.addEventListener('input', (e) => {
        //     const value = e.target.value;
        //     if (value.length === 1) {
        //         if (index < otpInputs.length - 1) {
        //         otpInputs[index + 1].focus();
        //         } else {
        //             $('#verify-indicator').removeClass('d-none');
        //             //$('#otp-timer-div').addClass('d-none');
        //             setTimeout(() => {
        //                 document.getElementById("btn-verify").click();
        //             }, 2000);
        //         }
        //     }
        // });

        input.addEventListener('keydown', (e) => {
            if (e.key === 'Backspace' && input.value === '' && index > 0) {
                otpInputs[index - 1].focus();
            }
        });
    });

    console.log("%cStop!", "color: red; font-size: 30px; font-weight: bold;");
    console.log("%cDO NOT TYPE OR PASTE ANYTHING HERE", "color: red; font-size: 16px; font-weight: bold;");

    document.getElementById('loginForm').addEventListener('submit', function (e) {
        var $this = $('#btn-verify');
        var loadingText = '<span class=""><i class="mdi mdi-spin mdi-loading me-1"></i>Verifying...</span>';

        if ($('#btn-verify').html() !== loadingText) {
            $this.data('original-text', $('#btn-verify').html());
            $this.html(loadingText);
            $('#btn-verify').prop('disabled', true);
        }
    });

    // Auto start/resume on page load
    window.addEventListener("load", startCountdown);

    // Keep multiple tabs/windows in sync
    window.addEventListener("storage", (e) => {
        if (e.key === KEY) {
            const t = localStorage.getItem(KEY);
            if (t) updateUI(Number(t));
        }
    });

</script>