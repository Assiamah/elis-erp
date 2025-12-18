<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- <%@ page import="com.report_class.cls_reports" %> --%>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<jsp:include page="../includes/_header.jsp"></jsp:include>
<jsp:useBean id="now" class="java.util.Date" />


<style>


    body {
        margin-top: 20px;
        background: #FAFAFA;
    }
    
    .order-card {
        color: #fff;
    }
    
    .card {
    
        border-radius: 15px !important; /* Ensures rounded edges */
        overflow: hidden; /* Ensures child elements follow the border-radius */
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    
    
        
        /* border-radius: 15px; Increased for smoother rounded edges */
        /* border-radius: 5px; */
        -webkit-box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
        box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
        border: none;
        margin-bottom: 30px;
        -webkit-transition: all 0.3s ease-in
    }
    
    
    .card .card-block {
        padding: 25px;
    }
    
    /* Softer Gradients */
    
    .bg-c-blue {
        background: linear-gradient(135deg, #3a7bd5, #3a6073);
        color: white;
    }
    
    .bg-c-green {
        background: linear-gradient(135deg, #A8E063, #56AB2F); /* Lime green to deep leaf green */
        color: white;
    }
    
    .bg-c-yellow {
        background: linear-gradient(135deg, #ffb347, #ffcc33);
        color: white;
    }
    
    .bg-c-pink {
        background: linear-gradient(135deg, #4CAF50, #2E8B57); /* Lighter to deeper green */
        color: white;
    }
    
    /* Card Styling */
    .order-card {
        border-radius: 10px;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    }
    
    .card-block {
        padding: 20px;
    }
    
    /* Float helpers */
    .f-left {
        float: left;
    }
    
    .f-right {
        float: right;
    }
    .card:hover {
        transform: translateY(-10px); /* Moves the card slightly up */
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); /* Stronger shadow on hover */
    }
    
    </style>



<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800">Delivery and Compliance Reports
    
    <select id="sel_change_region_compliance" class="">
        <option value=${regional_code}>${regional_name}</option>
                                    
        <c:forEach items="${officeregionlist}" var="officeregion">
            <option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
  </c:forEach>

                                </select>
    
    
    
    </h1>

    <!-- <div class="row">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"> Applications
                                Received</div>
                            <div class="text-xs  text-dark text-uppercase">today (
                                <fmt:formatDate value="${now}" type="date" />)</div>
                            <div id="app-received-today" class="h5 mb-0 font-weight-bold text-gray-800">0
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-file fa-2x text-gray-300"></i>
                        </div>
                        <a href="#" data-method="summary_created" data-period="day" 
                        data-url="DashboardDivisionSummary" data-icon="fa-file" 
                        data-title="Applications Received" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" 
                        class="showDivisionModal text-decoration-none stretched-link">
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">

                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Applications
                                Received</div>
                            <div class="text-xs  text-dark text-uppercase">this month (
                                <fmt:formatDate value="${now}" pattern="MMMM" />)</div>
                            <div id="app-received-month" class="h5 mb-0 font-weight-bold text-gray-800">0</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-file fa-2x text-gray-300"></i>
                        </div>
                        <a href="#" data-method="summary_created" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-file" data-title="Applications Received" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
                        </a>
                    </div>
                </div>

            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Applications Completed
                            </div>
                            <div class="text-xs  text-dark text-uppercase">today (
                                <fmt:formatDate value="${now}" type="date" />)</div>

                            <div class="row no-gutters align-items-center">
                                <div class="col-auto">
                                    <div id="app-completed-today" class="h5 mb-0 mr-3 font-weight-bold text-gray-800">0</div>
                                </div>

                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-clock fa-2x text-gray-300"></i>
                        </div>
                        <a href="#" data-method="summary_completed" data-period="day" data-url="DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" class="showDivisionModal text-decoration-none stretched-link">
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Applications
                                Completed</div>
                            <div class="text-xs  text-dark text-uppercase">this month (
                                <fmt:formatDate value="${now}" pattern="MMMM" />)</div>
                            <div id="app-completed-month" class="h5 mb-0 font-weight-bold text-gray-800">0</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-clock fa-2x text-gray-300"></i>
                        </div>
                        <a href="#" data-method="summary_completed" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div> -->
    


    <div id="cardsCarousel" class="carousel slide" data-ride="carousel" data-interval="0">
        <div class="carousel-inner">
            <!-- First Slide -->
            <div class="carousel-item active">
                <br>
                <div class="row">
                    <!-- Card 1 -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-c-blue order-card">
                            <div class="card-block">
                                <h6 class="m-b-20 text-uppercase">Applications Received</h6>
                                <div class="text-xs text-uppercase">Today (<fmt:formatDate value="${now}" type="date" />)</div>
                                <h2 class="text-left"><i class="fa fa-calendar-day f-right"></i><span id="app-received-today">0</span></h2>
                            </div>
                            <a href="#" data-method="summary_created" data-period="day" 
                        data-url="DashboardDivisionSummary" data-icon="fa-file" 
                        data-title="Applications Received" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" 
                        class="showDivisionModal text-decoration-none stretched-link">
                        </a>
                        </div>
                    </div>
                    <!-- Card 2 -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-c-yellow order-card">
                            <div class="card-block">
                                <h6 class="m-b-20 text-uppercase">Applications Received</h6>
                                <div class="text-xs text-uppercase">This month (<fmt:formatDate value="${now}" pattern="MMMM" />)</div>
                                <h2 class="text-left"><i class="fa fa-calendar-plus f-right"></i><span id="app-received-month">0</span></h2>
                            </div>
                            <a href="#" data-method="summary_created" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-file" data-title="Applications Received" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
                            </a>
                        </div>
                    </div>
    
                    <!-- Card 3 -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-c-pink order-card">
                            <div class="card-block">
                                <h6 class="m-b-20 text-uppercase">Applications Completed</h6>
                                <div class="text-xs text-uppercase">Today (<fmt:formatDate value="${now}" type="date" />)</div>
                                <h2 class="text-left"><i class="fa fa-check-circle f-right"></i><span id="app-completed-today">0</span></h2>
                            </div>
                            <a href="#" data-method="summary_completed" data-period="day" data-url="DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" class="showDivisionModal text-decoration-none stretched-link">
                        </a>
                        </div>
                    </div>
    
                    <!-- Card 4 -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-c-green order-card">
                            <div class="card-block">
                                <h6 class="m-b-20 text-uppercase">Applications Completed</h6>
                                <div class="text-xs text-uppercase">This month (<fmt:formatDate value="${now}" pattern="MMMM" />)</div>
                                <h2 class="text-left"><i class="fa fa-calendar-check f-right"></i><span id="app-completed-month">0</span></h2>
                            </div>
                            <a href="#" data-method="summary_completed" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
                        </a>
                        </div>
                    </div>
                </div>
            </div>
    
            <!-- Second Slide (Duplicate) -->
            <div class="carousel-item">
                <br>
                <div class="row">
                    <!-- Repeat the same four cards -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-c-blue order-card">
                            <div class="card-block">
                                <h6 class="m-b-20 text-uppercase">Applications Received</h6>
                                <div class="text-xs text-uppercase">Today (<fmt:formatDate value="${now}" type="date" />)</div>
                                <h2 class="text-left"><i class="fa fa-calendar-day f-right"></i><span id="app-received-today">0</span></h2>
                            </div>
                            <a href="#" data-method="summary_created" data-period="day" 
                        data-url="DashboardDivisionSummary" data-icon="fa-file" 
                        data-title="Applications Received" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" 
                        class="showDivisionModal text-decoration-none stretched-link">
                        </a>
                        </div>
                    </div>
    
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-c-yellow order-card">
                            <div class="card-block">
                                <h6 class="m-b-20 text-uppercase">Applications Received</h6>
                                <div class="text-xs text-uppercase">This month (<fmt:formatDate value="${now}" pattern="MMMM" />)</div>
                                <h2 class="text-left"><i class="fa fa-calendar-plus f-right"></i><span id="app-received-month">0</span></h2>
                            </div>
                            <a href="#" data-method="summary_created" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-file" data-title="Applications Received" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
                            </a>
                        </div>
                    </div>
    
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-c-pink order-card">
                            <div class="card-block">
                                <h6 class="m-b-20 text-uppercase">Applications Completed</h6>
                                <div class="text-xs text-uppercase">Today (<fmt:formatDate value="${now}" type="date" />)</div>
                                <h2 class="text-left"><i class="fa fa-check-circle f-right"></i><span id="app-completed-today">0</span></h2>
                            </div>
                            <a href="#" data-method="summary_completed" data-period="day" data-url="DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date="Today (<fmt:formatDate value="${now}" type="date" />)" class="showDivisionModal text-decoration-none stretched-link">
                        </a>
                        </div>
                    </div>
    
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card bg-c-green order-card">
                            <div class="card-block">
                                <h6 class="m-b-20 text-uppercase">Applications Completed</h6>
                                <div class="text-xs text-uppercase">This month (<fmt:formatDate value="${now}" pattern="MMMM" />)</div>
                                <h2 class="text-left"><i class="fa fa-calendar-check f-right"></i><span id="app-completed-month">0</span></h2>
                            </div>
                            <a href="#" data-method="summary_completed" data-period="month" data-url="DashboardDivisionSummary" data-icon="fa-clock" data-title="Applications Completed" data-date="This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)" class="showDivisionModal text-decoration-none stretched-link">
                        </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
        <!-- Carousel Controls -->
        <!-- <a class="carousel-control-prev" href="#cardsCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#cardsCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a> -->
    </div>



    <div id="yearlyCardsCarousel" class="carousel slide" data-ride="carousel" data-interval="0">
        <div class="carousel-inner">
            <!-- First Slide -->
            <div class="carousel-item active">
                <div class="row">
                    <!-- Applications Received -->
                    <div id="app-received-year" class="col-lg-4 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black">Applications Received</h6>
                                <span class="small text-primary"><span class="count">0</span> Applications for
                                    <fmt:formatDate value="${now}" pattern="Y" /></span>
                            </div>
                            <div data-method="apps_created" data-period="year" data-url="DashboardAppsReceived" data-next-level-modal="showServiceTypeModal" data-title="Applications Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
                        </div>
                    </div>
    
                    <!-- Applications Received and Completed -->
                    <div id="app-received-completed-year" class="col-lg-4 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black">Applications Received and Completed in
                                    <fmt:formatDate value="${now}" pattern="Y" />
                                </h6>
                                <span class="small text-primary"><span class="count">0</span> Applications</span>
                                <span class="small text-primary float-right" id="pec_id">0%</span>
                            </div>
                            <div data-method="apps_received_completed" data-period="year" data-url="DashboardAppsReceivedAndCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Received and Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
                        </div>
                    </div>
    
                    <!-- Applications Completed -->
                    <div id="app-completed-year" class="col-lg-4 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black">Applications Completed</h6>
                                <span class="small text-primary"><span class="count">0</span> Applications for
                                    <fmt:formatDate value="${now}" pattern="Y" /></span>
                            </div>
                            <div data-method="apps_completed" data-period="year" data-url="DashboardAppsCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
                        </div>
                    </div>
                </div>
            </div>
    
            <!-- Second Slide (Duplicate for looping effect) -->
            <div class="carousel-item">
                <div class="row">
                    <!-- Repeat the same three cards -->
                    <div id="appreceivedyear" class="col-lg-4 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black">Applications Received</h6>
                                <span class="small text-primary"><span class="count">0</span> Applications for
                                    <fmt:formatDate value="${now}" pattern="Y" /></span>
                            </div>
                            <div data-method="apps_created" data-period="year" data-url="DashboardAppsReceived" data-next-level-modal="showServiceTypeModal" data-title="Applications Received" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
                        </div>
                    </div>
    
                    <div id="appreceivedcompletedyear" class="col-lg-4 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black">Applications Received and Completed in
                                    <fmt:formatDate value="${now}" pattern="Y" />
                                </h6>
                                <span class="small text-primary"><span class="count">0</span> Applications</span>
                                <span class="small text-primary float-right" id="pec_id">0%</span>
                            </div>
                            <div data-method="apps_received_completed" data-period="year" data-url="DashboardAppsReceivedAndCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Received and Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
                        </div>
                    </div>
    
                    <div id="appcompletedyear" class="col-lg-4 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black">Applications Completed</h6>
                                <span class="small text-primary"><span class="count">0</span> Applications for
                                    <fmt:formatDate value="${now}" pattern="Y" /></span>
                            </div>
                            <div data-method="apps_completed" data-period="year" data-url="DashboardAppsCompleted" data-next-level-modal="showServiceTypeModal" data-title="Applications Completed" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
        <!-- Carousel Controls -->
        <!-- <a class="carousel-control-prev" href="#yearlyCardsCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#yearlyCardsCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a> -->
    </div>



<!-- 
    <div id="app-past-due-year" class="col-lg-6 mb-4">
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-black">Applications Past Due Date </h6>
                <span class="small text-primary"><span class="count">0</span> Applications for
                    <fmt:formatDate value="${now}" pattern="Y" /></span>
            </div>
            <div data-method="apps_past_due" data-period="year" data-url="DashboardAppsPastDueDate" data-next-level-modal="showUnitModal" data-title="Applications Past Due Date" data-date="This Year (<fmt:formatDate value="${now}" pattern="Y" />)" class="content-body card-body"></div>
        </div>
    </div>
    <div id="app-with-divisions" class="col-lg-6 mb-4"> -->




  
    <div id="pastDueCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
        <div class="carousel-inner">
            <!-- First Slide -->
            <div class="carousel-item active">
                <div class="row">
                    <!-- Applications Past Due -->
                    <div id="app-past-due-year"  class="col-lg-6 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black">Applications Past Due Date</h6>
                                <span class="small text-primary">
                                    <span class="count">0</span> Applications for 
                                    <fmt:formatDate value="${now}" pattern="Y" />
                                </span>
                            </div>
                            <div 
                                data-method="apps_past_due" 
                                data-period="year" 
                                data-url="DashboardAppsPastDueDate" 
                                data-next-level-modal="showUnitModal" 
                                data-title="Applications Past Due Date" 
                                data-date="This Year (<fmt:formatDate value='${now}' pattern='Y' />)" 
                                class="content-body card-body">
                            </div>
                        </div>
                    </div>
    
                    <!-- Applications With Divisions -->
                    <div id="app-with-divisions" class="col-lg-6 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black">Applications With Divisions</h6>
                                <span class="small text-primary">
                                    <span class="count">0</span> Applications
                                </span>
                            </div>
                            <div 
                                data-method="apps_with_division" 
                                data-url="DashboardAppsWithDivision" 
                                data-next-level-modal="showUnitModal" 
                                data-title="Applications With Divisions" 
                                class="content-body card-body">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    
            <!-- Second Slide (Duplicate for looping effect) -->
            <div class="carousel-item">
                <div class="row">
                    <!-- Applications Past Due -->
                    <div id="apppastdueyear"  class="col-lg-6 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black">Applications Past Due Date</h6>
                                <span class="small text-primary">
                                    <span class="count">0</span> Applications for 
                                    <fmt:formatDate value="${now}" pattern="Y" />
                                </span>
                            </div>
                            <div 
                                data-method="apps_past_due" 
                                data-period="year" 
                                data-url="DashboardAppsPastDueDate" 
                                data-next-level-modal="showUnitModal" 
                                data-title="Applications Past Due Date" 
                                data-date="This Year (<fmt:formatDate value='${now}' pattern='Y' />)" 
                                class="content-body card-body">
                            </div>
                        </div>
                    </div>
                
    
                    <!-- Applications With Divisions -->
                    <div id="appwithdivisions" class="col-lg-6 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black">Applications With Divisions</h6>
                                <span class="small text-primary">
                                    <span class="count">0</span> Applications
                                </span>
                            </div>
                            <div 
                                data-method="apps_with_division" 
                                data-url="DashboardAppsWithDivision" 
                                data-next-level-modal="showUnitModal" 
                                data-title="Applications With Divisions" 
                                class="content-body card-body">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
        <!-- Carousel Controls
        <button class="carousel-control-prev" type="button" data-bs-target="#pastDueCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#pastDueCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button> -->
    </div>

</div>
<!-- /.container-fluid -->
<!-- End of Main Content -->

<jsp:include page="../includes/_footer.jsp"></jsp:include>

<script>

// $(document).ready(function () {
 
// });

</script>
