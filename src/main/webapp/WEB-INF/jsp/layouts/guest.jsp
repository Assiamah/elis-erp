<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en" dir="ltr" data-nav-layout="vertical" data-vertical-style="overlay" data-theme-mode="light" data-header-styles="light" data-menu-styles="light"  style="--primary-rgb: 9 ,124, 103;" data-toggled="close">

<head>

    <!-- Meta Data -->
    <meta charset="UTF-8">
    <meta name='viewport' content='width=device-width, initial-scale=0.9'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title> ELIS 5.0 :: Authentication </title>
    <meta name="Description" content="">
    <meta name="Author" content="">
    <meta name="keywords" content="">
    <!-- Favicon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/NewLogo.jpg" type="image/x-icon">

    <!-- Main Theme Js -->
    <script src="${pageContext.request.contextPath}/assets/js/authentication-main.js"></script>

    <!-- Bootstrap Css -->
    <link id="style" href="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" >

    <!-- Style Css -->
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet" >

    <!-- Icons Css -->
    <link href="${pageContext.request.contextPath}/assets/css/icons.css" rel="stylesheet" >

    <!-- Remix Icon -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.css" rel="stylesheet" >

    <!-- Bootstrap Icon -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- Material Design Icon -->
    <link href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css" rel="stylesheet">

    <!-- Toastify CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/libs/toastify-js/src/toastify.css">

    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    

</head>

<body class="bg-white">

    <!-- Begin Main Content -->
    <jsp:include page="${content}" />
    <!-- End Main Content -->

    <!-- Bootstrap JS -->
    <script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Show Password JS -->
    <script src="${pageContext.request.contextPath}/assets/js/show-password.js"></script>
    
    <!-- Toastify JS -->
    <script src="${pageContext.request.contextPath}/assets/libs/toastify-js/src/toastify.js"></script>

</body>

</html>