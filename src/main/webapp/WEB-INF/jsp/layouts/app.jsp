<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en" dir="ltr" data-nav-layout="vertical" data-theme-mode="light" data-header-styles="transparent" data-width="fullwidth" data-menu-styles="transparent" data-page-style="regular" data-toggled="icon-hover-closed" data-vertical-style="overlay" loader="enable" style="--primary-rgb: 9 ,124, 103;">

<head>

    <!-- Meta Data -->
    <meta charset="UTF-8">
    <meta name='viewport' content='width=device-width, initial-scale=0.75'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title> ELIS 5.0 :: ${page_name} </title>
    <meta name="Description" content="">
    <meta name="Author" content="">
	<meta name="keywords" content="">
    
    <!-- include header-links.jsp"-->
    <jsp:include page="../components/_header-links.jsp"></jsp:include>

</head>

<body>
	<div class="progress-top-bar"></div>

    <div id="page_name" style="display:none">${page_name}</div>
	<div id="page_ready" style="display:none"></div>
	<div id="regional_code_general" style="display:none">${regional_code}</div>
    
    <!-- include switcher.jsp"-->
    <jsp:include page="../components/_switcher.jsp"></jsp:include>

    <!-- include loader.jsp"-->
    <jsp:include page="../components/_loader.jsp"></jsp:include>

    <div class="page">

        <!-- include header.jsp"-->
        <jsp:include page="../components/_header.jsp"></jsp:include>

        <!-- include sidebar.jsp"-->
        <jsp:include page="../components/_sidebar.jsp"></jsp:include>

        <!-- Start::app-content -->
        <jsp:include page="${content}" />
        <!-- End::app-content -->

        <!-- include modal.jsp"-->
        <jsp:include page="../components/_modal.jsp"></jsp:include>

        <!-- include notifications.jsp"-->
        <jsp:include page="../components/_notifications.jsp"></jsp:include>

        <!-- include footer.jsp"-->
        <jsp:include page="../components/_footer.jsp"></jsp:include>

    </div>

    <!-- include commonjs.jsp"-->
    <jsp:include page="../components/_commonjs.jsp"></jsp:include>

    
    
</body>

</html> 