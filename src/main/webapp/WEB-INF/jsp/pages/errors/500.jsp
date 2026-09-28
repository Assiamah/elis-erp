<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="main-content app-content"><div class="container-fluid page-container py-5">
    <div class="card custom-card text-center mx-auto" style="max-width: 620px;"><div class="card-body p-5">
        <i class="ri-error-warning-line text-danger" style="font-size: 3rem;"></i>
        <h2 class="mt-3"><c:out value="${error_title}" default="Something went wrong"/></h2>
        <p class="text-muted mb-0"><c:out value="${error_message}" default="Please try again later."/></p>
    </div></div>
</div></div>
