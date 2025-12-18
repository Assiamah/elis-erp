<!doctype html>
<html class="no-js" lang="">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>ELIS | Two-Step Verification</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="favicon-16x16.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="assets/login/css/bootstrap.min.css">
    <!-- Fontawesome CSS -->
    <link rel="stylesheet" href="assets/login/css/fontawesome-all.min.css">
    <!-- Flaticon CSS -->
    <link rel="stylesheet" href="assets/login/font/flaticon.css">
    <!-- Google Web Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/login/style.css">
</head>

<body>
    <!--[if lt IE 8]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->
    <!-- <div id="preloader" class="preloader">
        <div class='inner'>
            <div class='line1'></div>
            <div class='line2'></div>
            <div class='line3'></div>
        </div>
    </div> -->
    <section class=" fxt-template-layout33">
        <div class="fxt-content-wrap">
            <div class="fxt-heading-content">
                <div class="fxt-inner-wrap fxt-transformX-R-50 fxt-transition-delay-3">
                    <div class="fxt-transformX-R-50 fxt-transition-delay-10">
                        <p class="text-bold text-white h1"><span class="text-success h1">LANDS</span> COMMISSION</p>
                    </div>
                    <div class="fxt-transformX-R-50 fxt-transition-delay-10">
                        <div class="fxt-middle-content">
                            <div class="fxt-sub-title">Welcome to</div>
                            <h1 class="fxt-main-title">Enterprise Land Information System (ELIS)</h1>
                            <p class="fxt-description"><span class="text-danger">NB:</span> Please do not share your password with anyone.</p>
                        </div>
                    </div>
                    <div class="fxt-transformX-R-50 fxt-transition-delay-10">
                        <div class="fxt-switcher-description">Copyright &copy; Lands Commission <script>document.write(new Date().getFullYear())</script> </div>
                    </div>
                </div>
            </div>
            <div class="fxt-form-content">
                <div class="fxt-main-form">
                    <div class="fxt-inner-wrap fxt-opacity fxt-transition-delay-13">
                        <h2 class="fxt-page-title">Validate OTP</h2>
                        <h2 class="fxt-page-title">${otp_code}</h2>
                        <p class="fxt-description">Please enter the OTP (one time password) to verify your account. A Code has been sent to <span id="phone_number">${user_phone}</span></p>
                        <form  name="loginForm" method="post" action="change_password_rs"  autocomplete="off" id="otp-form">
                            <label for="reset" class="fxt-label">Enter OTP Code Here</label>
                            <div class="fxt-otp-row">
                                <input type="text" class="fxt-otp-col otp-input form-control" style="border: 1px solid rgb(46, 46, 46);" id="vc_1" name="vc_1" maxlength="1" required="required" autofocus>
                                <input type="text" class="fxt-otp-col otp-input form-control" style="border: 1px solid rgb(46, 46, 46);" id="vc_2" name="vc_2" maxlength="1" required="required">
                                <input type="text" class="fxt-otp-col otp-input form-control" style="border: 1px solid rgb(46, 46, 46);" id="vc_3" name="vc_3" maxlength="1" required="required">
                                <input type="text" class="fxt-otp-col otp-input form-control" style="border: 1px solid rgb(46, 46, 46);" id="vc_4" name="vc_4" maxlength="1" required="required">
                                <input type="text" class="fxt-otp-col otp-input form-control" style="border: 1px solid rgb(46, 46, 46);" id="vc_5" name="vc_5" maxlength="1" required="required">
                                <input type="text" class="fxt-otp-col otp-input form-control" style="border: 1px solid rgb(46, 46, 46);" id="vc_6" name="vc_6" maxlength="1" required="required">
                            </div>
                            <!-- <div class="fxt-otp-btn">
                                <button type="submit" class="fxt-btn-fill">Verify</button>
                            </div> -->
                        </form>
                        <div class="fxt-switcher-description mt-5">
                            <!-- Not received your code?<button class="fxt-switcher-text ms-1" type="submit">Resend code</button><span class="ms-1">or</span><button class="fxt-switcher-text ms-1" type="submit">Call</button> -->
                            <form name="loginForm" method="POST" action="send_code_for_password_reset">
                                <input type="hidden" name="username" value="${user}" />
                                <!-- <input type="hidden" name="password" value="${pass}" /> -->
                                <p class="fxt-resend-wrap">Not received your code?<button class="fxt-switcher-text ms-1 text-success" type="submit">Resend code</button><span class="ms-1">or</span><a href="/" class="fxt-switcher-text ms-1 text-danger" type="submit">Login</a></p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- jquery-->
    <script src="assets/login/js/jquery-3.5.0.min.js"></script>
    <!-- Bootstrap js -->
    <script src="assets/login/js/bootstrap.min.js"></script>
    <!-- Imagesloaded js -->
    <script src="assets/login/js/imagesloaded.pkgd.min.js"></script>
    <!-- Validator js -->
    <script src="assets/login/js/validator.min.js"></script>
    <!-- Custom Js -->
    <script src="assets/login/js/main.js"></script>

    <script src="js/service_querys/services.js"></script>

    <script>

        let str = document.getElementById("phone_number").innerHTML;
        let res = str.replace(/\d(?=\d{3})/g, "*");
        document.getElementById("phone_number").innerHTML = res;
    
    </script>
</body>

</html>