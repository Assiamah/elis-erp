 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


  <jsp:include page="includes/_header.jsp"></jsp:include>
        <!-- End of Sidebar -->

  <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- 404 Error Text -->
                    <div class="text-center">
                        <div class="error mx-auto" data-text="<%= request.getParameter("error") %>"><%= request.getParameter("error") %></div>
                        <p class="lead text-gray-800 mb-5"><%= request.getParameter("message") %></p>
                        <p class="text-gray-500 mb-0">It looks like you found a glitch in the matrix...</p>
                        <a href="${pageContext.request.contextPath}/dashboard">&larr; Back to Dashboard</a>
                    </div>

                </div>
                <!-- /.container-fluid -->

    
  <jsp:include page="includes/_footer.jsp"></jsp:include>