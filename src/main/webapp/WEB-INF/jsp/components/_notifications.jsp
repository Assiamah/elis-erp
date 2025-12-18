<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="toast-container position-fixed top-0 end-0 p-3">
    <div id="success-toast" class="toast colored-toast bg-primary-transparent text-primary" role="alert" aria-live="assertive"
        aria-atomic="true">
        <div class="toast-header bg-primary">
            <i class="ri-notification-3-line me-2 text-white"></i>
            <strong class="me-auto text-fixed-white">Success</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast"
                aria-label="Close"></button>
        </div>
        <div class="toast-body">
            <span id="success-toast-message"></span>
        </div>
    </div>
</div>

<div id="error-toast" class="toast colored-toast bg-danger-transparent text-danger" role="alert" aria-live="assertive"
    aria-atomic="true">
    <div class="toast-header bg-danger">
        <i class="ri-notification-3-line"></i>
        <strong class="me-auto text-fixed-white">Error</strong>
        <button type="button" class="btn-close" data-bs-dismiss="toast"
            aria-label="Close"></button>
    </div>
    <div class="toast-body">
        <span id="error-toast-message"></span>
    </div>
</div>
