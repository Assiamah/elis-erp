<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
    <meta charset="utf-8" />
    <title>ELIS - Login</title>
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta
      content="Tailwind Admin & Dashboard Template"
      name="description"
    />
    <meta content="" name="Themesbrand" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <!-- App favicon -->
    <link rel="shortcut icon" href="favicon-16x16.png" />


   <link rel="stylesheet" href="./assets/libs/swiper/swiper-bundle.min.css">


    <link rel="stylesheet" href="assets/css/icons.css" />
    <link rel="stylesheet" href="assets/css/tailwind.css" />



</head>
    
<body data-mode="light" data-sidebar-size="lg">


   
    <div class="container-fluid">
        <div class="h-screen md:overflow-hidden">
            <div class="grid grid-cols-1 md:grid-cols-12 ">



                <div class="col-span-12 md:col-span-7 lg:col-span-8 xl:col-span-7 relative z-50">
                    <div class="h-screen bg-cover relative p-5 bg-[url('../images/banner.jpg')]">
                        <!-- <div class="absolute inset-0 bg-green-500/90"> -->
                        <div class="absolute inset-0" style="background: url('../assets/images/lands_building.jpg'); min-height: 100%; background-size: cover; box-shadow: inset 0 0 0 2000px rgb(163, 230, 53,0.3);">
                            

                        </div>

                        <ul class="bg-bubbles absolute top-0 left-0 w-full h-full overflow-hidden animate-square">
                            <li class="h-10 w-10 rounded-3xl bg-white/10 absolute left-[10%] "></li>
                            <li class="h-28 w-28 rounded-3xl bg-white/10 absolute left-[20%]"></li>
                            <li class="h-10 w-10 rounded-3xl bg-white/10 absolute left-[25%]"></li>
                            <li class="h-20 w-20 rounded-3xl bg-white/10 absolute left-[40%]"></li>
                            <li class="h-24 w-24 rounded-3xl bg-white/10 absolute left-[70%]"></li>
                            <li class="h-32 w-32 rounded-3xl bg-white/10 absolute left-[70%]"></li>
                            <li class="h-36 w-36 rounded-3xl bg-white/10 absolute left-[32%]"></li>
                            <li class="h-20 w-20 rounded-3xl bg-white/10 absolute left-[55%]"></li>
                            <li class="h-12 w-12 rounded-3xl bg-white/10 absolute left-[25%]"></li>
                            <li class="h-36 w-36 rounded-3xl bg-white/10 absolute left-[90%]"></li>
                        </ul>

                         <div class="grid grid-cols-12 content-center h-screen">
                            <div class="col-span-8 col-start-3">
                                <div class="swiper login-slider">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide">
                                            <i class="bx bxs-quote-alt-left text-green-600 text-5xl"></i>
                                                <h3 class="mt-4 text-white text-22">“Please Do not Share Your Password with anyone.”</h3>
                                                <div class="flex mt-6 mb-10 pt-4">
                                                    <div class="flex-1 ltr:ml-3 rtl:mr-2 mb-4">
                                                        <h5 class="font-size-18 text-white"> - Management</h5>
                                                                                                            </div>
                                                </div>
                                        </div>
                                        <div class="swiper-slide">
                                            <i class="bx bxs-quote-alt-left text-green-600 text-5xl"></i>
                                                <h3 class="mt-4 text-white text-22">“Please refrain from saving your Password in the browser.”</h3>
                                                <div class="flex mt-6 mb-10 pt-4">
                                                    
                                                    <div class="flex-1 ltr:ml-3 rtl:mr-2 mb-4">
                                                        <h5 class="font-size-18 text-white"> - Management</h5>
                                                    
                                                    </div>
                                                </div>
                                        </div>
                                        <div class="swiper-slide">
                                            <i class="bx bxs-quote-alt-left text-green-600 text-5xl"></i>
                                                <h3 class="mt-4 text-white text-22">“Please Logout from your account when you leave your PC unattended to.”</h3>
                                                <div class="flex mt-6 mb-10 pt-4">
                                                    <div class="flex-1 ltr:ml-3 rtl:mr-2 mb-4">
                                                        <h5 class="font-size-18 text-white"> - Management</h5>
                                                        
                                                    </div>
                                                </div>
                                        </div>
                                    </div>
                                    <div class="swiper-pagination"></div>
                                </div>

                            </div>
                        </div>
                        
                    </div>
                </div>




                <div class="col-span-12 md:col-span-5 lg:col-span-4 xl:col-span-5">
                    <div class="w-full bg-white xl:p-12 p-10 dark:bg-zinc-800">
                        <div class="flex h-[90vh] flex-col">


                           <!--  <div class="text-center ms-2 mt-4 mb-5">
                              <a href="#"><img src="assets/images/NewLogo.jpg" style="width: 120px;" alt="img"></a>
                              
                            </div><br> -->
           <div class="card my-5 shadow-lg p-3 mb-5 bg-light bg-body rounded mt-10">
          <div class="card-body">
            ${login == 'failed' ? '
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-10 alert" role="alert">
                <strong class="font-bold">Authentication Failed!</strong>
                <span class="block sm:inline">Please check your username or password.</span>
                <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                  <svg class="fill-current h-6 w-6 text-red-500" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>Close</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/></svg>
                </span>
              </div>
            ' : ''}
            
                 <div class="flex justify-center items-center">
                                <a href="index.html" class="">
                                     <a href="#"><img src="assets/images/NewLogo.jpg" style="width: 140px;" alt="img"></a>  
                                </a>
                            </div>
                            

                            <div class="my-auto mt-5">
                                <div class="text-center">
                                    <h5 class="text-gray-600 dark:text-gray-100">Welcome to ELIS</h5>
                                </div>

                                <form class="mt-4 pt-2"  name="loginForm" method="post" action="Login">
                                    <div class="mb-4">
                                       
                                        <input type="text" class="w-full rounded placeholder:text-sm py-2 border-gray-100 dark:bg-zinc-700/50 dark:border-zinc-600 dark:text-gray-100 dark:placeholder:text-zinc-100/60" name="username" id="username" placeholder="Enter username">
                                    </div>
                                    <div class="mb-3">
                                        <div class="flex">
                                            <div class="flex-grow-1">
                                            </div>
                                            
                                        </div>
                                        
                                        <div class="flex">
                                            <input type="password" class="w-full rounded placeholder:text-sm py-2 border-gray-100 dark:bg-zinc-700/50 dark:border-zinc-600 dark:text-gray-100 dark:placeholder:text-zinc-100/60" name="password" id="password" placeholder="Enter Password">
                                        </div>
                                    </div>
                                    <div class="row mb-6">
                                        <div class="col">
                                            <div >
                                                <input type="checkbox" class="h-4 w-4 border border-gray-300 rounded bg-white checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain ltr:float-left rtl:float-right ltr:mr-2 rtl:ml-2 cursor-pointer focus:ring-offset-0">
                                                <label class="align-middle text-gray-600 dark:text-gray-100 font-medium">
                                                    Remember me
                                                </label>
                                            </div>  
                                        </div>
                                        
                                    </div>


                                    <div class="mb-3">
                                        <button class="btn border-transparent  w-full py-2.5 text-white w-100 waves-effect waves-light shadow-md  dark:shadow-zinc-600" style="background-color:#47af05;" type="submit">Login</button>
                                    </div>


                                </form>

                                

                               
                            </div>
                        </div>
                    </div>

                            
                            <div class=" text-center">
                                <p class="text-gray-500 dark:text-gray-100 relative mt-5">Copyright &copy; Lands Commission <script>document.write(new Date().getFullYear())</script> </p>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

        
    
       

    <script src="assets/libs/@popperjs/core/umd/popper.min.js"></script>
    <script src="assets/libs/feather-icons/feather.min.js"></script>
    <script src="assets/libs/metismenujs/metismenujs.min.js"></script>
    <script src="assets/libs/simplebar/simplebar.min.js"></script>
    <script src="assets/libs/feather-icons/feather.min.js"></script>

    <script src="./assets/libs/swiper/swiper-bundle.min.js"></script>
    
    <script src="assets/js/pages/login.init.js"></script>

    <script src="assets/js/app.js"></script>

    <script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="js/sb-admin-2.min.js"></script>
<script src="js/maps/maps.js" ></script>
<script src="js/service_querys/services.js"></script><script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="js/sb-admin-2.min.js"></script>
<script src="js/maps/maps.js" ></script>
<script src="js/service_querys/services.js"></script>

    <script type="text/javascript">
        var swiper = new Swiper('.login-slider', {
  slidesPerView: 1,
  spaceBetween: 30,
  centeredSlides: true,
  autoplay: {
    delay: 5500,
    disableOnInteraction: false,
  },
  // navigation: {
  //   nextEl: '.swiper-pagination',
  //   prevEl: '.swiper-pagination',
  // },
});
    </script>


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