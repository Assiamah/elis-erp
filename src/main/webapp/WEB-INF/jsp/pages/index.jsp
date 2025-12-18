<!doctype html>
<html class="no-js" lang="">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>ELIS | Login</title>
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
    <div id="preloader" class="preloader">
        <div class='inner'>
            <div class='line1'></div>
            <div class='line2'></div>
            <div class='line3'></div>
        </div>
    </div>
    <section class="fxt-template-animation fxt-template-layout33">
        <div class="fxt-content-wrap">
            <div class="fxt-heading-content">
                <div class="fxt-inner-wrap fxt-transformX-R-50 fxt-transition-delay-3">
                    <div class="fxt-transformX-R-50 fxt-transition-delay-10">
                        <!-- <a href="login-33.html" class="fxt-logo"><img src="assets/login/img/logo-33.png" alt="Logo"></a> -->
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
                        <h2 class="fxt-page-title">Log In</h2>
                        <p class="fxt-description">Start your session with valid credentials.</p>
                        ${login == 'failed' ? '
                        <!-- <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-10 alert" role="alert">
                            <strong class="font-bold">Authentication Failed!</strong>
                            <span class="block sm:inline">Please check your username or password.</span>
                            <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                            <svg class="fill-current h-6 w-6 text-red-500" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>Close</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/></svg>
                            </span>
                        </div> -->
                        <div class="alert alert-danger d-flex align-items-center" role="alert">
                            <!-- <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg> -->
                            <div>
                                Authentication Failed! Please check your username or password.
                            </div>
                          </div>
                        ' : ''}

                        ${login == 'failed_session' ? '
                        <div class="alert alert-danger d-flex align-items-center" role="alert">
                            <!-- <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg> -->
                            <div>
                                Authentication Failed! Session has expired.
                            </div>
                          </div>
                        ' : ''}

                        ${password_changed == 'passed' ? '
                        <!-- <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-10 alert" role="alert">
                            <strong class="font-bold">Authentication Failed!</strong>
                            <span class="block sm:inline">Please check your username or password.</span>
                            <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                            <svg class="fill-current h-6 w-6 text-red-500" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>Close</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/></svg>
                            </span>
                        </div> -->
                        <div class="alert alert-success d-flex align-items-center" role="alert">
                            <!-- <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg> -->
                            <div>
                                Your password has been successfully reset. Please log in with your new credentials.
                            </div>
                          </div>
                        ' : ''}

                        
                        ${login == 'failedverificationcode' ? '
                        <!-- <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-10 alert" role="alert">
                            <strong class="font-bold">Authentication Failed!</strong>
                            <span class="block sm:inline">Please check your username or password.</span>
                            <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                            <svg class="fill-current h-6 w-6 text-red-500" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>Close</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/></svg>
                            </span>
                        </div> -->
                        <div class="alert alert-danger d-flex align-items-center" role="alert">
                            <!-- <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg> -->
                            <div>
                                Authentication Failed! Please check your username or password.
                            </div>
                          </div>
                        ' : ''}


                        <!-- <form name="loginForm" method="POST" action="Login"> -->
                        <form name="loginForm" method="POST" action="two_factor_verification">
                            <div class="form-group">
                                <!-- <label for="email" class="mb-1">Username</label> -->
                                <input type="email" id="email" class="form-control" name="username" placeholder="Enter your official email address" required="required">
                            </div>
                            <div class="form-group">
                                <!-- <label for="password" class="mb-1">Password</label> -->
                                <input id="password" type="password" class="form-control" name="password" placeholder="Enter Password" required="required">
                            </div>
                            <div class="form-group">
                                <a href="forgot_password" class="fxt-switcher-text">Forgot Password</a>
                            </div>
                            <div class="form-group mb-3">
                                <button type="submit" class="fxt-btn-fill">Log in</button>
                            </div>
                        </form>
                        <!-- <div class="fxt-divider-text">OR</div>
                        <div id="fxt-login-option" class="fxt-login-option">
                            <ul>
                                <li class="fxt-google active">
                                    <a href="#">
                                        <span class="fxt-option-icon"><i class="fab fa-google"></i></span>
                                        <span class="fxt-option-text ml-2">Continue with Google</span>
                                    </a>
                                </li>
                                <li class="fxt-facebook">
                                    <a href="#">
                                        <span class="fxt-option-icon"><i class="fab fa-facebook-f"></i></span>
                                        <span class="fxt-option-text ml-2">Continue with Facebook</span>
                                    </a>
                                </li>
                                <li class="fxt-apple">
                                    <a href="#">
                                        <span class="fxt-option-icon"><i class="fab fa-apple"></i></span>
                                        <span class="fxt-option-text ml-2">Continue with Apple</span>
                                    </a>
                                </li>
                            </ul>
                        </div> -->
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

    <script>
        $(document).ready(function() {
            //console.log('reayuhhggg');
            setTimeout(function () {
               $('.alert').fadeOut(1000);
            }, 10000);
          });
       
    </script>

</body>

</html>