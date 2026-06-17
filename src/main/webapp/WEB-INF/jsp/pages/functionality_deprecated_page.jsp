 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

  
  

<div class="main-content app-content">
    <div class="container-fluid page-container">

        <div class="row">
            <div class="col-lg-12">
                <div class="card mb-3">
                    <div class="card-header bg-danger text-white">
                        <i class="fas fa-exclamation-triangle"></i> Page Deprecated
                    </div>
                    <div class="card-body">
                        <div class="text-center py-5">
                            <i class="fas fa-exclamation-circle fa-5x text-danger mb-4"></i>
                            <h1 class="display-4 text-danger">This Page Has Been Deprecated</h1>
                            <p class="lead text-muted mt-3">
                                This page is no longer maintained and will be removed in a future version.
                            </p>
                            <div class="alert alert-warning mt-4" role="alert">
                                <strong>Reason:</strong> The functionality has been moved to a new, enhanced interface.
                            </div>
                            <div class="alert alert-info mt-3" role="alert">
                                <strong>Recommendation:</strong> Please use the updated version below.
                            </div>
                            
                            
                            
                            <div class="mt-5">
                                <a href="${pageContext.request.contextPath}/new-frrv-dashboard" class="btn btn-success btn-lg mr-2">
                                    <i class="fas fa-arrow-right"></i> Go to New Version
                                </a>
                                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary btn-lg mr-2">
                                    <i class="fas fa-home"></i> Dashboard
                                </a>
                                <button onclick="window.history.back()" class="btn btn-secondary btn-lg">
                                    <i class="fas fa-undo"></i> Go Back
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>   
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            console.log('This page has been deprecated. Please use the new version.');
        });
    </script>

     

 
 
