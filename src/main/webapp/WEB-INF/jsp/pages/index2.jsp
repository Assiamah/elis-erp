 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>ELIS - Login</title>
  
    <link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="manifest" href="site.webmanifest">

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.min.css" rel="stylesheet">

 <link rel="stylesheet" href="openlayers/ol.css" type="text/css">
  <script src="openlayers/ol.js"></script>

   <link rel="stylesheet" href="openlayers/ol3-layerswitcher.css" type="text/css">
  <script src="openlayers/ol3-layerswitcher.js"></script>
 
  <script src="pdf/jspdf.min.js"></script>
  <script src="pdf/jspdf.plugin.autotable.js"></script>

</head>

<body class="bg-gradient-info">

  <div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-9">
		
		<c:if test = "${login == 'failed'}">
			<br><br>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
            
			  <strong>Failure !</strong> You should check Username or Password entered.
			  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
			    <span aria-hidden="true">&times;</span>
			  </button>
			</div>
	      </c:if>
	      
	      
	      <c:if test = "${login == 'sessionout'}">
			<br><br>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
            
			  <strong>Session Ended !</strong> Your session has timed out. Login.
			  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
			    <span aria-hidden="true">&times;</span>
			  </button>
			</div>
	      </c:if>
	      
	      <c:if test = "${login == 'Please this is not alllowed'}">
			<br><br>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
            
			  <strong>Failure !</strong> The page you are trying to load is not assigned to you Pls contact IT office for support.
			  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
			    <span aria-hidden="true">&times;</span>
			  </button>
			</div>
	      </c:if>
	      
        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <!-- <div class="col-lg-6 d-none d-lg-block bg-login-image"></div> -->
              
               <div class="col-lg-6 align-self-center text-center" >
             
              <img src="resources/NewLogo.jpg" alt="Lands Commission Logo" width="300" height="300">
              </div>
              
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Welcome to ELIS!</h1>
                  </div>
                  <form class="user" name="loginForm" method="post" action="Login">
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" id="username" name="username" placeholder="Enter User Name">
                    </div>
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" id="password" name="password" placeholder="Password">
                    </div>
                    <div class="form-group">
                      <div class="custom-control custom-checkbox small">
                        <input type="checkbox" class="custom-control-input" id="customCheck">
                        <label class="custom-control-label" for="customCheck">Remember Me</label>
                      </div>
                    </div>
                
                   <input type="submit" value="Login"  class="btn btn-info btn-user btn-block">
                   
                  </form>
                  <hr>
                  <div class="text-center">
                    <a class="small" href="forgot_password">Forgot Password?</a>
                  </div>
                  
                  
			      
			      
                 
                 
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin-2.min.js"></script>
 <script src="js/maps/maps.js" ></script>
 <script src="js/service_querys/services.js"></script>
   <script>
   $(document).ready(function() {
       //console.log('reayuhhggg');
     });

   </script>
</body>

</html>
