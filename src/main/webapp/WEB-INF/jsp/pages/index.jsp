<!doctype html>
<html lang="en">

<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<head>

    <meta charset="utf-8">

    <title>ELIS | Login</title>

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1"
    >

    <link
        rel="shortcut icon"
        href="favicon-16x16.png"
    >

    <link
        rel="stylesheet"
        href="assets/login/css/bootstrap.min.css"
    >

    <link
        rel="stylesheet"
        href="assets/login/css/fontawesome-all.min.css"
    >

    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700&family=Inter:wght@400;500;600&display=swap"
        rel="stylesheet"
    >


    <style>

        :root {

            --lc-green: #0f7a3d;
            --lc-green-dark: #075c2c;
            --lc-green-darker: #054622;
            --lc-green-deep: #033a1c;
            --lc-green-light: #28a65a;

            --lc-green-soft: #edf8f1;
            --lc-green-soft-2: #f5fbf7;
            --lc-green-border: #c7e8d2;

            --lc-gold: #f4c430;
            --lc-gold-light: #ffe58b;

            --lc-dark: #101828;
            --lc-text: #344054;
            --lc-muted: #667085;

            --lc-border: #e4e7ec;

            --lc-white: #ffffff;

        }


        /* =====================================================
           GENERAL
        ===================================================== */

        * {
            box-sizing: border-box;
        }


        html,
        body {
            margin: 0;
            min-height: 100%;
        }


        body {

            min-height: 100vh;

            font-family:
                'Inter',
                sans-serif;

            background:
                #f4f8f5;

            color:
                var(--lc-text);

        }


        .login-wrapper {

            display: flex;

            min-height: 100vh;

        }


        /* =====================================================
           LEFT BRANDING PANEL
        ===================================================== */

        .login-hero {

            position: relative;

            overflow: hidden;

            flex: 1.08;

            min-height: 100vh;

            display: flex;

            flex-direction: column;

            justify-content: center;

            padding:
                4rem 5rem;

            color:
                #ffffff;

            background:

                linear-gradient(
                    115deg,
                    rgba(3,58,28,.95) 0%,
                    rgba(5,70,34,.91) 40%,
                    rgba(15,122,61,.82) 100%
                ),

                url(
                    "assets/login/img/land-bg.jpg"
                )
                center / cover
                no-repeat;

        }


        /* Gold top accent */

        .login-hero::before {

            content: "";

            position: absolute;

            top: 0;
            left: 0;
            right: 0;

            height: 5px;

            background:

                linear-gradient(
                    90deg,
                    #f4c430,
                    #ffe58b,
                    #f4c430
                );

        }


        /* Decorative circle */

        .login-hero::after {

            content: "";

            position: absolute;

            width: 430px;
            height: 430px;

            top: -230px;
            right: -160px;

            border:

                65px solid
                rgba(255,255,255,.035);

            border-radius:
                50%;

        }


        .hero-content {

            position: relative;

            z-index: 2;

            max-width: 620px;

        }


        /* =====================================================
           BRAND ICON
        ===================================================== */

        .brand-icon {

            position: relative;

            width: 64px;
            height: 64px;

            display: flex;

            align-items: center;
            justify-content: center;

            margin-bottom:
                24px;

            border:

                1px solid
                rgba(255,255,255,.17);

            border-radius:
                16px;

            background:

                rgba(255,255,255,.10);

            color:
                #ffffff;

            font-size:
                1.65rem;

            box-shadow:

                inset 0 1px 0
                rgba(255,255,255,.08);

        }


        .brand-icon::after {

            content: "";

            position: absolute;

            top: 10px;
            right: 10px;

            width: 8px;
            height: 8px;

            border:

                2px solid
                var(--lc-green-dark);

            border-radius:
                50%;

            background:
                var(--lc-gold);

        }


        /* =====================================================
           HERO TEXT
        ===================================================== */

        .hero-eyebrow {

            margin-bottom:
                7px;

            color:

                rgba(255,255,255,.57);

            font-size:
                .68rem;

            font-weight:
                700;

            letter-spacing:
                .12em;

            text-transform:
                uppercase;

        }


        .login-hero h1 {

            margin:
                0;

            font-family:
                'Poppins',
                sans-serif;

            color:
                #ffffff;

            font-size:
                2.55rem;

            font-weight:
                700;

            letter-spacing:
                -.025em;

        }


        .login-hero h1 span {

            color:
                #74df9d;

        }


        .hero-description {

            max-width:
                560px;

            margin:
                17px 0 0;

            color:

                rgba(255,255,255,.75);

            font-size:
                .98rem;

            line-height:
                1.75;

        }


        .hero-description strong {

            color:
                #ffffff;

            font-weight:
                600;

        }


        /* =====================================================
           SYSTEM FEATURES
        ===================================================== */

        .hero-features {

            display: flex;

            flex-wrap: wrap;

            gap:
                10px;

            margin-top:
                30px;

        }


        .hero-feature {

            display:
                inline-flex;

            align-items:
                center;

            gap:
                8px;

            padding:
                8px 12px;

            border:

                1px solid
                rgba(255,255,255,.13);

            border-radius:
                30px;

            background:

                rgba(255,255,255,.075);

            color:

                rgba(255,255,255,.82);

            font-size:
                .72rem;

        }


        .hero-feature i {

            color:
                #80e6a7;

        }


        /* =====================================================
           SECURITY NOTICE
        ===================================================== */

        .security-notice {

            max-width:
                520px;

            display:
                flex;

            align-items:
                flex-start;

            gap:
                11px;

            margin-top:
                30px;

            padding:
                12px 14px;

            border:

                1px solid
                rgba(244,196,48,.22);

            border-radius:
                10px;

            background:

                rgba(244,196,48,.075);

        }


        .security-notice i {

            margin-top:
                2px;

            color:
                var(--lc-gold);

            font-size:
                .95rem;

        }


        .security-notice div {

            color:

                rgba(255,255,255,.76);

            font-size:
                .7rem;

            line-height:
                1.55;

        }


        .security-notice strong {

            color:
                #ffe58b;

        }


        /* =====================================================
           LEFT FOOTER
        ===================================================== */

        .hero-footer {

            position:
                absolute;

            z-index:
                2;

            bottom:
                30px;

            left:
                5rem;

            color:

                rgba(255,255,255,.46);

            font-size:
                .68rem;

        }


        /* =====================================================
           RIGHT PANEL
        ===================================================== */

        .login-form-wrapper {

            position:
                relative;

            overflow:
                hidden;

            flex:
                .92;

            min-height:
                100vh;

            display:
                flex;

            align-items:
                center;

            justify-content:
                center;

            padding:
                40px;

            background:

                radial-gradient(
                    circle at 90% 8%,
                    rgba(15,122,61,.10),
                    transparent 25%
                ),

                radial-gradient(
                    circle at 10% 90%,
                    rgba(40,166,90,.08),
                    transparent 28%
                ),

                linear-gradient(
                    145deg,
                    #f5fbf7 0%,
                    #ffffff 48%,
                    #edf8f1 100%
                );

        }


        /* Green decorative effect */

        .login-form-wrapper::before {

            content: "";

            position:
                absolute;

            width:
                380px;

            height:
                380px;

            top:
                -240px;

            right:
                -180px;

            border:

                55px solid
                rgba(15,122,61,.035);

            border-radius:
                50%;

        }


        .login-form-wrapper::after {

            content: "";

            position:
                absolute;

            width:
                270px;

            height:
                270px;

            bottom:
                -190px;

            left:
                -130px;

            border-radius:
                50%;

            background:

                rgba(15,122,61,.035);

        }


        /* =====================================================
           LOGIN CARD
        ===================================================== */

        .login-card {

            position:
                relative;

            z-index:
                2;

            overflow:
                hidden;

            width:
                100%;

            max-width:
                425px;

            padding:
                34px 36px 32px;

            border:

                1px solid
                rgba(15,122,61,.13);

            border-radius:
                17px;

            background:

                rgba(255,255,255,.96);

            box-shadow:

                0 20px 50px
                rgba(7,92,44,.10),

                0 5px 15px
                rgba(16,24,40,.04);

        }


        /* Green/gold card header effect */

        .login-card::before {

            content: "";

            position:
                absolute;

            top:
                0;

            left:
                0;

            width:
                100%;

            height:
                5px;

            background:

                linear-gradient(
                    90deg,
                    #054622 0%,
                    #075c2c 35%,
                    #0f7a3d 75%,
                    #f4c430 100%
                );

        }


        /* =====================================================
           LOGIN CARD BRAND
        ===================================================== */

        .login-card-brand {

            display:
                flex;

            align-items:
                center;

            gap:
                10px;

            margin-bottom:
                24px;

        }


        .login-card-brand-icon {

            width:
                40px;

            height:
                40px;

            display:
                flex;

            align-items:
                center;

            justify-content:
                center;

            border-radius:
                10px;

            background:

                linear-gradient(
                    145deg,
                    #075c2c,
                    #0f7a3d
                );

            color:
                #ffffff;

            font-size:
                1rem;

            box-shadow:

                0 5px 12px
                rgba(7,92,44,.18);

        }


        .login-card-brand-title {

            margin:
                0;

            color:
                var(--lc-green-dark);

            font-family:
                'Poppins',
                sans-serif;

            font-size:
                .78rem;

            font-weight:
                700;

        }


        .login-card-brand-subtitle {

            margin:
                1px 0 0;

            color:
                var(--lc-muted);

            font-size:
                .59rem;

        }


        /* =====================================================
           LOGIN HEADING
        ===================================================== */

        .login-card h2 {

            margin:
                0 0 5px;

            color:
                var(--lc-dark);

            font-family:
                'Poppins',
                sans-serif;

            font-size:
                1.45rem;

            font-weight:
                650;

        }


        .login-card > .text-muted {

            margin-bottom:
                25px;

            color:
                var(--lc-muted) !important;

            font-size:
                .78rem;

        }


        /* =====================================================
           FORM LABELS
        ===================================================== */

        .form-label {

            margin-bottom:
                7px;

            color:
                var(--lc-text);

            font-size:
                .72rem;

            font-weight:
                600;

        }


        /* =====================================================
           INPUT GROUP
        ===================================================== */

        .login-input {

            position:
                relative;

        }


        .login-input-icon {

            position:
                absolute;

            z-index:
                2;

            top:
                50%;

            left:
                14px;

            color:
                #98a2b3;

            font-size:
                .88rem;

            transform:
                translateY(-50%);

            pointer-events:
                none;

        }


        .form-control {

            width:
                100%;

            height:
                48px;

            padding:

                9px
                13px
                9px
                42px;

            border:

                1px solid
                #d0d5dd;

            border-radius:
                10px;

            background:
                #ffffff;

            color:
                var(--lc-dark);

            font-size:
                .82rem;

            box-shadow:
                none !important;

            transition:

                border-color .2s ease,
                box-shadow .2s ease,
                background .2s ease;

        }


        .form-control::placeholder {

            color:
                #98a2b3;

        }


        .form-control:hover {

            border-color:
                #a9d5b9;

        }


        .form-control:focus {

            border-color:
                var(--lc-green);

            background:
                #fbfefc;

            box-shadow:

                0 0 0
                3px
                rgba(15,122,61,.08)
                !important;

        }


        .login-input:focus-within
        .login-input-icon {

            color:
                var(--lc-green);

        }


        /* =====================================================
           PASSWORD VISIBILITY
        ===================================================== */

        .password-input
        .form-control {

            padding-right:
                44px;

        }


        .password-toggle {

            position:
                absolute;

            z-index:
                3;

            top:
                50%;

            right:
                13px;

            border:
                0;

            background:
                transparent;

            color:
                #98a2b3;

            font-size:
                .9rem;

            transform:
                translateY(-50%);

            cursor:
                pointer;

        }


        .password-toggle:hover {

            color:
                var(--lc-green);

        }


        /* =====================================================
           FORGOT PASSWORD
        ===================================================== */

        .forgot-link {

            color:
                var(--lc-green);

            font-size:
                .7rem;

            font-weight:
                600;

            text-decoration:
                none;

        }


        .forgot-link:hover {

            color:
                var(--lc-green-dark);

            text-decoration:
                underline;

        }


        /* =====================================================
           LOGIN BUTTON
        ===================================================== */

        .btn-login {

            position:
                relative;

            overflow:
                hidden;

            width:
                100%;

            height:
                48px;

            display:
                flex;

            align-items:
                center;

            justify-content:
                center;

            gap:
                8px;

            border:
                0;

            border-radius:
                10px;

            background:

                linear-gradient(
                    135deg,
                    #054622 0%,
                    #075c2c 50%,
                    #0f7a3d 100%
                );

            color:
                #ffffff;

            font-size:
                .78rem;

            font-weight:
                600;

            box-shadow:

                0 7px 16px
                rgba(7,92,44,.18);

            transition:
                all .22s ease;

        }


        .btn-login:hover,
        .btn-login:focus {

            background:

                linear-gradient(
                    135deg,
                    #033a1c,
                    #075c2c,
                    #118546
                );

            color:
                #ffffff;

            transform:
                translateY(-1px);

            box-shadow:

                0 10px 20px
                rgba(7,92,44,.23);

        }


        .btn-login i {

            font-size:
                .78rem;

        }


        /* =====================================================
           ALERTS
        ===================================================== */

        .login-alert {

            display:
                flex;

            align-items:
                flex-start;

            gap:
                9px;

            margin-bottom:
                18px;

            padding:
                11px 12px;

            border-radius:
                9px;

            font-size:
                .69rem;

            line-height:
                1.5;

        }


        .login-alert-danger {

            border:
                1px solid #f4c7c3;

            background:
                #fff4f3;

            color:
                #9c2e2e;

        }


        .login-alert-success {

            border:
                1px solid
                var(--lc-green-border);

            background:
                var(--lc-green-soft);

            color:
                var(--lc-green-dark);

        }


        .login-alert i {

            margin-top:
                2px;

        }


        /* =====================================================
           SECURE ACCESS NOTE
        ===================================================== */

        .secure-access {

            display:
                flex;

            align-items:
                center;

            justify-content:
                center;

            gap:
                6px;

            margin-top:
                20px;

            color:
                #98a2b3;

            font-size:
                .61rem;

        }


        .secure-access i {

            color:
                var(--lc-green);

        }


        /* =====================================================
           MOBILE
        ===================================================== */

        @media (max-width: 991px) {

            .login-hero {

                display:
                    none;

            }


            .login-form-wrapper {

                flex:
                    1;

                padding:
                    25px;

                background:

                    radial-gradient(
                        circle at 100% 0%,
                        rgba(15,122,61,.12),
                        transparent 35%
                    ),

                    linear-gradient(
                        145deg,
                        #edf8f1,
                        #ffffff
                    );

            }

        }


        @media (max-width: 576px) {

            .login-form-wrapper {

                align-items:
                    center;

                padding:
                    18px;

            }


            .login-card {

                max-width:
                    100%;

                padding:
                    29px 23px 26px;

                border-radius:
                    14px;

            }


            .login-card h2 {

                font-size:
                    1.3rem;

            }

        }

    </style>

</head>


<body>


<div class="login-wrapper">


    <%-- =====================================================
         LEFT SIDE
    ====================================================== --%>

    <section class="login-hero">


        <div class="hero-content">


            <div class="brand-icon">

                <i class="fas fa-map-marked-alt"></i>

            </div>


            <div class="hero-eyebrow">

                Enterprise Land Information System

            </div>


            <h1>

                <span>LANDS</span> COMMISSION

            </h1>


            <p class="hero-description">

                Welcome to the
                <strong>
                    Enterprise Land Information System (ELIS)
                </strong>.

                Securely manage land records, application
                workflows and spatial information through
                a unified digital platform.

            </p>


            <div class="hero-features">

                <div class="hero-feature">

                    <i class="fas fa-shield-alt"></i>

                    Secure Access

                </div>


                <div class="hero-feature">

                    <i class="fas fa-map"></i>

                    Spatial Data

                </div>


                <div class="hero-feature">

                    <i class="fas fa-project-diagram"></i>

                    Digital Workflows

                </div>

            </div>


            <div class="security-notice">

                <i class="fas fa-lock"></i>


                <div>

                    <strong>Security Notice</strong><br>

                    Never share your ELIS username,
                    password or verification code with anyone.

                </div>

            </div>

        </div>


        <div class="hero-footer">

            &copy; Lands Commission
            <script>
                document.write(
                    new Date().getFullYear()
                );
            </script>

            &nbsp;&bull;&nbsp;

            Enterprise Land Information System

        </div>


    </section>


    <%-- =====================================================
         RIGHT SIDE
    ====================================================== --%>

    <section class="login-form-wrapper">


        <div class="login-card">


            <%-- SYSTEM BRAND --%>

            <div class="login-card-brand">

                <div class="login-card-brand-icon">

                    <i class="fas fa-landmark"></i>

                </div>


                <div>

                    <p class="login-card-brand-title">

                        ELIS

                    </p>

                    <p class="login-card-brand-subtitle">

                        Lands Commission

                    </p>

                </div>

            </div>


            <h2>

                Welcome Back

            </h2>


            <p class="text-muted">

                Sign in using your official
                ELIS credentials to continue.

            </p>


            <%-- =================================================
                 LOGIN FAILED
            ================================================== --%>

            <c:if test="${login eq 'failed'}">

                <div
                    class="
                        login-alert
                        login-alert-danger
                    "
                >

                    <i class="fas fa-exclamation-circle"></i>

                    <div>

                        <strong>
                            Authentication Failed
                        </strong>

                        <br>

                        Please check your username
                        or password and try again.

                    </div>

                </div>

            </c:if>


            <%-- =================================================
                 SESSION EXPIRED
            ================================================== --%>

            <c:if test="${login eq 'failed_session'}">

                <div
                    class="
                        login-alert
                        login-alert-danger
                    "
                >

                    <i class="fas fa-clock"></i>

                    <div>

                        <strong>
                            Session Expired
                        </strong>

                        <br>

                        Please sign in again
                        to continue.

                    </div>

                </div>

            </c:if>


            <%-- =================================================
                 PASSWORD RESET
            ================================================== --%>

            <c:if test="${password_changed eq 'passed'}">

                <div
                    class="
                        login-alert
                        login-alert-success
                    "
                >

                    <i class="fas fa-check-circle"></i>

                    <div>

                        <strong>
                            Password Reset Successful
                        </strong>

                        <br>

                        You can now sign in using
                        your new password.

                    </div>

                </div>

            </c:if>


            <%-- =================================================
                 LOGIN FORM
            ================================================== --%>

            <form
                method="POST"
                action="two_factor_verification"
            >


                <%-- EMAIL --%>

                <div class="mb-3">

                    <label
                        for="username"
                        class="form-label"
                    >

                        Official Email Address

                    </label>


                    <div class="login-input">

                        <i
                            class="
                                fas
                                fa-envelope
                                login-input-icon
                            "
                        ></i>


                        <input
                            type="email"
                            id="username"
                            name="username"
                            class="form-control"
                            placeholder="Enter your official email"
                            autocomplete="username"
                            required
                        >

                    </div>

                </div>


                <%-- PASSWORD --%>

                <div class="mb-2">

                    <label
                        for="password"
                        class="form-label"
                    >

                        Password

                    </label>


                    <div
                        class="
                            login-input
                            password-input
                        "
                    >

                        <i
                            class="
                                fas
                                fa-lock
                                login-input-icon
                            "
                        ></i>


                        <input
                            type="password"
                            id="password"
                            name="password"
                            class="form-control"
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            required
                        >


                        <button
                            type="button"
                            class="password-toggle"
                            id="togglePassword"
                            aria-label="Show or hide password"
                        >

                            <i class="fas fa-eye"></i>

                        </button>

                    </div>

                </div>


                <%-- FORGOT PASSWORD --%>

                <div class="mb-4 text-end">

                    <a
                        href="forgot_password"
                        class="forgot-link"
                    >

                        Forgot password?

                    </a>

                </div>


                <%-- LOGIN BUTTON --%>

                <button
                    type="submit"
                    class="btn btn-login"
                    id="loginButton"
                >

                    <span>
                        Sign In
                    </span>

                    <i class="fas fa-arrow-right"></i>

                </button>


            </form>


            <div class="secure-access">

                <i class="fas fa-shield-alt"></i>

                Secure access to the
                Enterprise Land Information System

            </div>


        </div>


    </section>


</div>


<script src="assets/login/js/jquery-3.5.0.min.js"></script>

<script src="assets/login/js/bootstrap.min.js"></script>


<script>

    $(function () {

        /*
         * Fade system messages after 8 seconds.
         */
        setTimeout(
            function () {

                $(".login-alert").fadeOut(800);

            },
            8000
        );


        /*
         * Show / hide password.
         */
        $("#togglePassword").on(
            "click",
            function () {

                const passwordInput =
                    $("#password");

                const icon =
                    $(this).find("i");


                if (
                    passwordInput.attr("type")
                    ===
                    "password"
                ) {

                    passwordInput.attr(
                        "type",
                        "text"
                    );

                    icon
                        .removeClass("fa-eye")
                        .addClass("fa-eye-slash");

                }
                else {

                    passwordInput.attr(
                        "type",
                        "password"
                    );

                    icon
                        .removeClass("fa-eye-slash")
                        .addClass("fa-eye");

                }

            }
        );


        /*
         * Login loading state.
         */
        $("form").on(
            "submit",
            function () {

                const button =
                    $("#loginButton");


                button
                    .prop(
                        "disabled",
                        true
                    )
                    .html(
                        '<span class="spinner-border spinner-border-sm mr-2" role="status"></span> Signing In...'
                    );

            }
        );

    });

</script>


</body>

</html>