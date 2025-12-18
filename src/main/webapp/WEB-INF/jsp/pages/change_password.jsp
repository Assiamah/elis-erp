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

    <style>
         .progress-bar-container {
    width: 100%;
    background-color: #e0e0e0;
    border-radius: 5px;
    margin-top: 10px;
    height: 10px;
    overflow: hidden;
}

.progress-bar {
    height: 100%;
    width: 0;
    border-radius: 5px;
    transition: width 0.3s;
}

#strengthMessage {
    margin-top: 10px;
    font-weight: bold;
}
    </style>
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
                        <h2 class="fxt-page-title">Change Passowrd</h2>
                        <p class="fxt-description"></p>
                        ${password_not_match == 'failed' ? '
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
                               Passwords do not match. Please try again.
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
                        <form name="loginForm" method="POST" action="select_self_change_user_password">
                            <div class="form-group">
                                <!-- <label for="email" class="mb-1">Username</label> -->
                                <input type="password" id="new_password" class="form-control" name="new_password" oninput="checkPasswordStrength()"  placeholder="Enter New Password" required="required" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*!]).{14,}$">
                            </div>

                            <div class="progress-bar-container">
                                <div id="strengthBar" class="progress-bar"></div>
                            </div>
                    
                            <div class="mb-4 text-muted" id="strengthMessage"></div>
                            
                            <div class="form-group">
                                <!-- <label for="email" class="mb-1">Username</label> -->
                                <input type="password" id="confirm_password" class="form-control" name="confirm_password" placeholder="Enter Confirm Passwprd" required="required" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*!]).{14,}$">
                            </div>

                            <div class="form-group mb-3">
                                <button type="submit" class="fxt-btn-fill">Confirm</button>
                            </div>
                            <div class="form-group">
                                <a href="/" class="fxt-switcher-text"><i class="fas fa-arrow-left me-2"></i>Go Back</a>
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

    <div class="modal fade modal-animate anim-blur" id="publicNotice" tabindex="-1" aria-labelledby="publicNotice" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
          <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="pdfPreviewModalLabel">Public Notice<i class="fa fa-bullhorn ms-2 text-success" aria-hidden="true"></i></h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body text-sm">
            <div class="align-items-center d-flex flex-wrap gap-2 mb-3">
              <div class="badge bg-danger f-12">Alert</div>
              <p class="mb-0 text-muted" id="annoucementDate"></p>
              <span class="badge dot bg-warning"></span>
             </div>
             <h6 class="mb-3">NOTICE TO ALL USERS: IMMEDIATE PASSWORD UPDATE REQUIRED</h6>
             <!-- <p class="text-muted">Dear Valued Client,</p> -->
             <p class="text-muted text-sm">As part of ongoing efforts to enhance security and protect user accounts, all users of the Lands Commission Corporate Portal are required to immediately update their passwords to meet the following requirements:</p>
             <p class="text-warning">Mandatory Password Requirements:</p>
             <ul class="text-muted px-4 mb-3" style="list-style-type: disc;">
                <li>Minimum of <b>14 characters</b></li>
                <li>At least <b>one uppercase letter (A-Z)</b></li>
                <li>At least <b>one lowercase letter (a-z)</b></li>
                <li>At least <b>one number (0-9)</b></li>
                <li>At least <b>one special character (e.g., @, #, $, %, &)</b></li>
              </ul>
             <!-- <p class="text-success">What&#39;s New?</p> -->
             <p class="text-muted text-sm">Failure to update your password by <b>Wednesday, 12th February 2025</b> may result in restricted access to the portal.</p>
             <!-- <p class="text-muted text-sm">To update your password, please follow these steps:</p>
             <ul class="text-muted">
              <li>Log in to your account on the <b>Lands Commission</b> Online at onlineservices.lc.gov.gh</li>
              <li>Navigate to the <b>Change Password</b> section under your account settings.</li>
              <li>Follow the instructions to create a new password that meets the stated requirements.</li>
              <li>Save the changes and log in with your new password.</li>
             </ul> -->
              <p class="text-muted text-sm">For assistance, please contact <a href="mailto:info@lc.gov.gh">info@lc.gov.gh</a> or call 
                <a href="tel:0302429760">0302 429760</a> / <a href="tel:0302429762">0302 429762</a>.</p>
              <p class="text-muted text-sm">Thank you for your cooperation.</p>
             <p class=" text-sm">Lands Commission ICT Unit<br>Date: 12th February, 2025</p>
          </div>
          </div>
        </div>
        </div>

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

          document.addEventListener("DOMContentLoaded", function () {

$('#publicNotice').modal('show')

function formatTimestamp(timestamp) {
  const now = new Date();
  const time = new Date(timestamp);

  const diffInMs = now - time;
  const diffInMinutes = Math.floor(diffInMs / (1000 * 60));
  const diffInHours = Math.floor(diffInMs / (1000 * 60 * 60));
  const diffInDays = Math.floor(diffInMs / (1000 * 60 * 60 * 24));

  const isToday = now.toDateString() === time.toDateString();
  const isYesterday = diffInDays === 1 && now.getDate() - time.getDate() === 1;

  if (diffInMinutes < 1) {
    return "Just now";
  } else if (diffInMinutes === 1) {
    return "A minute ago";
  } else if (diffInMinutes < 60) {
    return diffInHours+" Minutes ago";
  } else if (diffInHours === 1) {
    return "An hour ago";
  } else if (diffInHours < 24 && isToday) {
    return diffInHours+" Hours ago";
  } else if (isYesterday) {
    return "Yesterday";
  } else {
    // Return specific date for older timestamps
    return time.toLocaleDateString(undefined, { year: 'numeric', month: 'long', day: 'numeric' });
  }
}

document.getElementById('annoucementDate').innerText = formatTimestamp('2025-02-12 17:00:00');
//console.log(formatTimestamp('2024-11-18 00:00:00'));
})

function checkPasswordStrength() {
          const passwordInput = document.getElementById('new_password');
          const strengthBar = document.getElementById('strengthBar');
          const strengthMessage = document.getElementById('strengthMessage');
          const password = passwordInput.value;

          let strength = 0;

          // Check the strength of the password
          if (password.length >= 14) {
              strength++;
          }
          if (/[A-Z]/.test(password)) {
              strength++;
          }
          if (/[a-z]/.test(password)) {
              strength++;
          }
          if (/[0-9]/.test(password)) {
              strength++;
          }
          if (/[!@#$%^&*()_\-=\[\]{};':"\\|,.<>\/?]/.test(password)) {
              strength++;
          }

          // Update the progress bar and strength message based on password strength
          switch (strength) {
              case 0:
                  strengthBar.style.width = '0%';
                  strengthBar.style.backgroundColor = 'transparent';
                  strengthMessage.textContent = '';
                  break;
              case 1:
                  strengthBar.style.width = '20%';
                  strengthBar.style.backgroundColor = 'red';
                  strengthMessage.textContent = 'Weak';
                  break;
              case 2:
                  strengthBar.style.width = '40%';
                  strengthBar.style.backgroundColor = 'red';
                  strengthMessage.textContent = 'Keep going';
                  break;
              case 3:
                  strengthBar.style.width = '60%';
                  strengthBar.style.backgroundColor = 'orange';
                  strengthMessage.textContent = 'Keep going';
                  break;
              case 4:
                  strengthBar.style.width = '80%';
                  strengthBar.style.backgroundColor = 'orange';
                  strengthMessage.textContent = 'Almost there';
                  break;
              case 5:
                  strengthBar.style.width = '100%';
                  strengthBar.style.backgroundColor = 'green';
                  strengthMessage.textContent = 'Passed';
                  break;
          }
        }
       
        </script>

</body>

</html>