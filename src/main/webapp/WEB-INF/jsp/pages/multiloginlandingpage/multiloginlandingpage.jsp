
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>





<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>DLREV - LANDING PAGE</title>
    <link rel="stylesheet" href="lib/assets/css/login.css" type="text/css">
    <link rel="stylesheet" href="lib/assets/bootstrap4/css/landing.css">
    <link rel="stylesheet" href="lib/assets/bootstrap4/css/flatbuttons.css">
    <link rel="stylesheet" href="lib/assets/bootstrap4/css/themify-icons.css">
    
 <!--    <link href="lib/assets/bootstrap4/css/landing.css" rel="stylesheet" type="text/css" />
    <link href="lib/assets/css/login.css" rel="stylesheet" type="text/css" />
     -->
    <script src="lib/assets/bootstrap4/js/csi.min.js"></script>
</head>

<body>
    <div class="container-fluid p-0 d-flex flex-column" id="Page1">
        <div class="row no-gutters text-center align-items-center mb-2 mb-md-5" id="header">
            <div class="col-12">
                <h1 class="h1 font-weight-bold">Welcome DLREV</h1>
                <p class="h4 mb-4">Choose your sign in option</p>
                <hr>
            </div>
        </div>
        <div class="row no-gutters" id="signInOption">
            <div class="container">
                <div class="row ">
                    <div class="col-md-3 col-sm-6  scale-lg mb-2 mb-md-0">
                        <a href="login2.php?app=dLRev" class="option-card d-flex flex-column text-center">
                            <div class="label d-flex justify-content-center align-items-center">
                                <span>A</span>
                            </div>
                            <div class="body py-2 px-1 d-flex justify-content-center align-items-center mx-auto">
                                <p class="type h5 m-0" id="desktopLink">Desktop</p>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-3 col-sm-6 scale-lg mb-2 mb-md-0">
                        <a href="login2.php?app=mobile" class="option-card d-flex flex-column text-center">
                            <div class="label d-flex justify-content-center align-items-center">
                                <span>B</span>
                            </div>
                            <div class="body py-2 px-1 d-flex justify-content-center align-items-center mx-auto">
                                <p class="type h5 m-0" id="mobileLink">Mobile</p>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-3 col-sm-6 scale-lg mb-2 mb-md-0">
                        <a href="login2.php?app=mlgrd" class="option-card d-flex flex-column text-center">
                            <div class="label d-flex justify-content-center align-items-center">
                                <span>C</span>
                            </div>
                            <div class="body py-2 px-1 d-flex justify-content-center align-items-center mx-auto">
                                <p class="type h5 m-0" id="mlgrdLink" >MLGRD</p>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-3 col-sm-6 scale-lg mb-2 mb-md-0">
                        <a href="login2.php?app=gra" class="option-card d-flex flex-column text-center">
                            <div class="label d-flex justify-content-center align-items-center">
                                <span>D</span>
                            </div>
                            <div class="body py-2 px-1 d-flex justify-content-center align-items-center mx-auto">
                                <p class="type h5 m-0" id="graLink">GRA</p>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
