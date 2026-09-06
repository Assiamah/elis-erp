<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>

<%-- ============================================
     SAFE DATE FORMATTING
     ============================================ --%>
<%
    java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("dd MMM yyyy | HH:mm:ss");
    java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("dd MMM yyyy");
    java.text.SimpleDateFormat timeFormat = new java.text.SimpleDateFormat("HH:mm");
    
    String[] dateAttrs = {
        "created_date", "date_of_registration", "publicity_date", 
        "date_of_issue", "commencement_date", "date_of_document", "modified_date"
    };
    
    for (String attr : dateAttrs) {
        Object value = request.getAttribute(attr);
        String strValue = (value != null) ? value.toString() : null;
        String formatted = "--";
        String formattedTime = "--";
        
        if (strValue != null && !strValue.trim().isEmpty() && !"null".equalsIgnoreCase(strValue.trim())) {
            try {
                java.util.Date parsed = inputFormat.parse(strValue);
                formatted = outputFormat.format(parsed);
                formattedTime = timeFormat.format(parsed);
            } catch (Exception e) {
                try {
                    java.text.SimpleDateFormat altInput = new java.text.SimpleDateFormat("dd MMM yyyy");
                    java.util.Date parsed = altInput.parse(strValue);
                    formatted = outputFormat.format(parsed);
                } catch (Exception ex) {
                    formatted = strValue;
                }
            }
        }
        
        pageContext.setAttribute("fmt_" + attr, formatted);
        pageContext.setAttribute("time_" + attr, formattedTime);
    }
    
    // Calculate days since creation
    Object createdObj = request.getAttribute("created_date");
    String createdStr = (createdObj != null) ? createdObj.toString() : null;
    long daysSince = 0;
    if (createdStr != null && !createdStr.trim().isEmpty() && !"null".equalsIgnoreCase(createdStr.trim())) {
        try {
            java.util.Date createdDate = inputFormat.parse(createdStr);
            long diff = System.currentTimeMillis() - createdDate.getTime();
            daysSince = diff / (1000 * 60 * 60 * 24);
        } catch (Exception e) {
            daysSince = 0;
        }
    }
    pageContext.setAttribute("daysSince", daysSince);
%>


<style>
    /* ============================================
       MODERN ENHANCED STYLES
       ============================================ */
    :root {
        --primary: #4F46E5;
        --primary-light: #818CF8;
        --primary-dark: #3730A3;
        --primary-gradient: linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%);
        --success: #10B981;
        --warning: #F59E0B;
        --danger: #EF4444;
        --info: #3B82F6;
        --gray-50: #F8FAFC;
        --gray-100: #F1F5F9;
        --gray-200: #E2E8F0;
        --gray-300: #CBD5E1;
        --gray-400: #94A3B8;
        --gray-500: #64748B;
        --gray-600: #475569;
        --gray-700: #334155;
        --gray-800: #1E293B;
        --gray-900: #0F172A;
        --radius: 16px;
        --shadow-sm: 0 1px 2px rgba(0,0,0,0.05);
        --shadow: 0 4px 16px rgba(0,0,0,0.08);
        --shadow-lg: 0 8px 32px rgba(0,0,0,0.12);
        --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    body {
        background: var(--gray-50);
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    }

    /* ============================================
       MODERN CARDS
       ============================================ */
    .modern-card {
        background: white;
        border-radius: var(--radius);
        box-shadow: var(--shadow-sm);
        border: 1px solid var(--gray-200);
        transition: var(--transition);
        overflow: hidden;
    }

    .modern-card:hover {
        box-shadow: var(--shadow);
    }

    .modern-card-header {
        padding: 16px 20px;
        background: var(--gray-50);
        border-bottom: 1px solid var(--gray-200);
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 8px;
    }

    .modern-card-body {
        padding: 20px;
    }

    /* ============================================
       AI COMMAND CENTER
       ============================================ */
    .ai-command-center {
        background: linear-gradient(135deg, #EEF2FF 0%, #E0E7FF 100%);
        border: 1px solid #C7D2FE;
        border-radius: var(--radius);
        padding: 20px 24px;
        margin-bottom: 20px;
    }

    .ai-command-center .ai-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 4px 14px;
        border-radius: 999px;
        font-size: 11px;
        font-weight: 600;
        background: white;
        color: var(--primary);
        border: 1px solid #C7D2FE;
    }

    .ai-command-center .quick-action-btn {
        border: 1px solid var(--gray-200);
        background: white;
        border-radius: 8px;
        padding: 6px 14px;
        font-size: 12px;
        color: var(--gray-700);
        transition: var(--transition);
        cursor: pointer;
    }

    .ai-command-center .quick-action-btn:hover {
        border-color: var(--primary);
        color: var(--primary);
        background: white;
        transform: translateY(-1px);
        box-shadow: var(--shadow-sm);
    }

    /* ============================================
       STATS ROW
       ============================================ */
    .stat-modern {
        background: white;
        border-radius: 12px;
        padding: 16px 20px;
        border: 1px solid var(--gray-200);
        transition: var(--transition);
    }

    .stat-modern:hover {
        transform: translateY(-2px);
        box-shadow: var(--shadow);
    }

    .stat-modern .stat-icon {
        width: 44px;
        height: 44px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
        flex-shrink: 0;
    }

    .stat-modern .stat-number {
        font-size: 22px;
        font-weight: 700;
        color: var(--gray-900);
        line-height: 1.2;
    }

    .stat-modern .stat-label {
        font-size: 12px;
        color: var(--gray-500);
        font-weight: 500;
    }

    /* ============================================
       PROCESS STEPS - MODERN
       ============================================ */
    .step-modern {
        background: white;
        border-radius: 12px;
        padding: 16px 20px;
        margin-bottom: 12px;
        border: 1px solid var(--gray-200);
        transition: var(--transition);
        position: relative;
    }

    .step-modern:hover {
        border-color: var(--primary-light);
        box-shadow: var(--shadow-sm);
    }

    .step-modern .step-number {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        font-size: 13px;
        flex-shrink: 0;
    }

    .step-modern .step-number.completed {
        background: #DCFCE7;
        color: #166534;
    }

    .step-modern .step-number.ongoing {
        background: #FEF3C7;
        color: #92400E;
        animation: pulse-step 2s infinite;
    }

    .step-modern .step-number.pending {
        background: #FEE2E2;
        color: #991B1B;
    }

    @keyframes pulse-step {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.08); }
    }

    .step-modern .step-actions .btn {
        padding: 4px 12px;
        font-size: 11px;
        border-radius: 6px;
    }

    .step-modern .step-connector {
        width: 2px;
        height: 16px;
        background: linear-gradient(to bottom, var(--gray-300), var(--gray-400));
        margin: 4px auto 0;
    }

    /* ============================================
       AI CHAT PANEL
       ============================================ */
    .ai-chat-panel {
        position: fixed;
        top: 0;
        right: -520px;
        width: 500px;
        max-width: 95vw;
        height: 100vh;
        background: white;
        box-shadow: -8px 0 40px rgba(0,0,0,0.15);
        z-index: 99999;
        display: flex;
        flex-direction: column;
        transition: right 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .ai-chat-panel.open {
        right: 0;
    }

    .ai-chat-header {
        padding: 16px 20px;
        border-bottom: 1px solid var(--gray-200);
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: white;
        flex-shrink: 0;
    }

    .ai-chat-header .ai-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: var(--primary-gradient);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        flex-shrink: 0;
    }

    .ai-chat-messages {
        flex: 1;
        overflow-y: auto;
        padding: 20px;
        background: var(--gray-50);
    }

    .ai-chat-messages::-webkit-scrollbar {
        width: 4px;
    }
    .ai-chat-messages::-webkit-scrollbar-track {
        background: transparent;
    }
    .ai-chat-messages::-webkit-scrollbar-thumb {
        background: var(--gray-300);
        border-radius: 4px;
    }

    .ai-message {
        display: flex;
        margin-bottom: 16px;
        gap: 10px;
        animation: messageIn 0.3s ease;
    }

    @keyframes messageIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .ai-message.user {
        justify-content: flex-end;
    }

    .ai-message-avatar {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        flex-shrink: 0;
        background: var(--gray-200);
        color: var(--gray-600);
    }

    .ai-message.user .ai-message-avatar {
        background: var(--primary);
        color: white;
    }

    .ai-message-content {
        max-width: 82%;
    }

    .ai-message-bubble {
        background: white;
        border-radius: 12px;
        padding: 12px 16px;
        box-shadow: var(--shadow-sm);
        font-size: 13px;
        line-height: 1.6;
        word-break: break-word;
    }

    .ai-message.user .ai-message-bubble {
        background: var(--primary-gradient);
        color: white;
    }

    .ai-message-bubble .message-time {
        font-size: 10px;
        opacity: 0.6;
        margin-top: 6px;
        display: block;
    }

    .ai-message.user .message-time {
        text-align: right;
    }

    .ai-suggestions {
        display: flex;
        flex-direction: column;
        gap: 6px;
        margin-top: 10px;
    }

    .ai-suggestions button {
        text-align: left;
        border: 1px solid var(--gray-200);
        background: white;
        border-radius: 8px;
        padding: 8px 12px;
        font-size: 12px;
        color: var(--gray-700);
        cursor: pointer;
        transition: var(--transition);
    }

    .ai-suggestions button:hover {
        border-color: var(--primary);
        color: var(--primary);
        background: #EEF2FF;
    }

    .ai-chat-input {
        padding: 12px 16px 16px;
        border-top: 1px solid var(--gray-200);
        background: white;
        flex-shrink: 0;
    }

    #aiChatInput {
        resize: none;
        max-height: 100px;
        border: 2px solid var(--gray-200);
        border-radius: 10px;
        padding: 8px 14px;
        font-size: 13px;
        transition: var(--transition);
    }

    #aiChatInput:focus {
        border-color: var(--primary);
        box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
    }

    .ai-thinking {
        display: flex;
        align-items: center;
        gap: 6px;
        padding: 8px 0;
    }

    .ai-thinking span {
        width: 7px;
        height: 7px;
        border-radius: 50%;
        background: var(--gray-400);
        animation: thinking 1.2s infinite;
    }

    .ai-thinking span:nth-child(2) { animation-delay: 0.15s; }
    .ai-thinking span:nth-child(3) { animation-delay: 0.3s; }

    @keyframes thinking {
        0%, 60%, 100% { opacity: 0.3; transform: translateY(0); }
        30% { opacity: 1; transform: translateY(-4px); }
    }

    /* ============================================
       FLOATING AI BUTTON
       ============================================ */
    .ai-floating-button {
        position: fixed;
        right: 24px;
        bottom: 24px;
        z-index: 9998;
        border-radius: 999px;
        padding: 12px 20px;
        background: var(--primary-gradient);
        color: white;
        border: none;
        box-shadow: 0 4px 20px rgba(79, 70, 229, 0.4);
        font-weight: 600;
        transition: var(--transition);
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .ai-floating-button:hover {
        transform: scale(1.05);
        box-shadow: 0 6px 30px rgba(79, 70, 229, 0.5);
    }

    .ai-floating-button .badge-dot {
        position: absolute;
        top: -4px;
        right: -4px;
        width: 14px;
        height: 14px;
        background: var(--danger);
        border-radius: 50%;
        border: 2px solid white;
        animation: pulse-dot 2s infinite;
    }

    @keyframes pulse-dot {
        0%, 100% { opacity: 1; transform: scale(1); }
        50% { opacity: 0.5; transform: scale(0.8); }
    }

    /* ============================================
       RESPONSIVE
       ============================================ */
    @media (max-width: 768px) {
        .ai-chat-panel {
            width: 100vw;
            max-width: 100vw;
            right: -100vw;
        }

        .ai-chat-panel.open {
            right: 0;
        }

        .ai-command-center .quick-action-btn {
            font-size: 11px;
            padding: 4px 10px;
        }

        .stat-modern .stat-number {
            font-size: 18px;
        }

        .ai-floating-button {
            padding: 10px 16px;
            font-size: 13px;
            right: 16px;
            bottom: 16px;
        }
    }

    /* ============================================
       UTILITY
       ============================================ */
    .text-gradient {
        background: var(--primary-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .gap-1 { gap: 4px; }
    .gap-2 { gap: 8px; }
    .gap-3 { gap: 12px; }
    .gap-4 { gap: 16px; }

    .badge-modern {
        padding: 4px 14px;
        border-radius: 999px;
        font-weight: 500;
        font-size: 11px;
    }

    .scrollable-col {
        overflow-y: auto;
        max-height: calc(100vh - 280px);
        padding-right: 4px;
    }

    .scrollable-col::-webkit-scrollbar {
        width: 4px;
    }
    .scrollable-col::-webkit-scrollbar-track {
        background: transparent;
    }
    .scrollable-col::-webkit-scrollbar-thumb {
        background: var(--gray-300);
        border-radius: 4px;
    }

    /* Process Timeline */
    .process-timeline {
        position: relative;
    }

    .process-step-card {
        position: relative;
        padding: 1.5rem;
        background: #fff;
        border-radius: 0.75rem;
        border: 1px solid #e9ecef;
        transition: all 0.3s ease;
        background: rgba(0, 0, 0, 0.06);
    }

    .process-step-card[data-status="completed"] {
        border-left: 4px solid #198754;
        background: rgba(25, 135, 84, 0.02);
    }

    .process-step-card[data-status="ongoing"] {
        border-left: 4px solid #ffc107;
        background: rgba(255, 193, 7, 0.02);
    }

    .process-step-card[data-status="pending"] {
        border-left: 4px solid #f36060;
        background: rgba(243, 96, 96, 0.02);
    }

    .timeline-connector {
        position: absolute;
        left: 2rem;
        bottom: -1.5rem;
        width: 2px;
        height: 1.5rem;
        background: linear-gradient(to bottom, #dee2e6, #6c757d);
    }

    .avatar {
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }

    .avatar-sm { width: 32px; height: 32px; }
    .avatar-md { width: 48px; height: 48px; }
    .avatar-lg { width: 64px; height: 64px; }

    .step-details {
        border-left: 2px dashed #dee2e6;
        padding-left: 2rem;
        margin-left: 2rem;
    }

    .bg-pink {
        background-color: #e83e8c !important;
        color: white !important;
    }

    .bg-light-primary {
        background-color: rgba(13, 110, 253, 0.1) !important;
    }
    .bg-light-success {
        background-color: rgba(25, 135, 84, 0.1) !important;
    }
    .bg-light-warning {
        background-color: rgba(255, 193, 7, 0.1) !important;
    }
    .bg-light-info {
        background-color: rgba(13, 202, 240, 0.1) !important;
    }

    .table-hover tbody tr:hover {
        background-color: rgba(13, 110, 253, 0.05);
    }

    #lc-map__ {
        height: 450px !important;
        width: 100% !important;
        position: relative !important;
    }

    /* ============================================
       SIDEBAR ACCORDION
       ============================================ */
    .accordion-modern .accordion-item {
        border: none;
        margin-bottom: 8px;
        border-radius: 12px !important;
        overflow: hidden;
        border: 1px solid var(--gray-200);
    }

    .accordion-modern .accordion-button {
        padding: 12px 16px;
        font-weight: 600;
        font-size: 13px;
        background: white;
        border: none;
        transition: var(--transition);
    }

    .accordion-modern .accordion-button:not(.collapsed) {
        background: var(--gray-50);
        color: var(--primary);
        box-shadow: none;
    }

    .accordion-modern .accordion-button:focus {
        box-shadow: none;
        border-color: transparent;
    }

    .accordion-modern .accordion-body {
        padding: 12px 16px;
        background: white;
    }
</style>


<!-- =========================================================
     CSS STYLES FOR CHAT INTERFACE
     ========================================================= -->
<style>
    /* Chat Interface Wrapper */
    .chat-interface-wrapper {
        display: flex;
        flex-direction: column;
        height: 100%;
        min-height: 500px;
    }

    /* Chat Header */
    .chat-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 16px 20px;
        background: linear-gradient(135deg, #4F46E5, #7C3AED);
        border-radius: 12px 12px 0 0;
        flex-shrink: 0;
    }

    .chat-header-left {
        display: flex;
        align-items: center;
        gap: 14px;
    }

    .chat-header-left .ai-icon {
        width: 44px;
        height: 44px;
        background: rgba(255,255,255,0.2);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 20px;
    }

    .chat-header-left h2 {
        color: white;
        font-size: 18px;
        font-weight: 600;
        margin: 0;
    }

    .chat-header-left p {
        color: rgba(255,255,255,0.8);
        font-size: 12px;
        margin: 0;
    }

    .chat-header-actions {
        display: flex;
        gap: 8px;
    }

    .chat-header-actions button {
        padding: 6px 14px;
        border: none;
        border-radius: 6px;
        font-size: 12px;
        cursor: pointer;
        transition: all 0.2s;
        background: rgba(255,255,255,0.15);
        color: white;
    }

    .chat-header-actions button:hover {
        background: rgba(255,255,255,0.25);
        transform: translateY(-1px);
    }

    .chat-header-actions .btn-danger:hover {
        background: #EF4444;
    }

    /* Chat Messages Area */
    .chat-messages {
        flex: 1;
        overflow-y: auto;
        padding: 20px;
        background: #F8FAFC;
        min-height: 320px;
        max-height: 420px;
    }

    .chat-messages::-webkit-scrollbar {
        width: 4px;
    }
    .chat-messages::-webkit-scrollbar-track {
        background: transparent;
    }
    .chat-messages::-webkit-scrollbar-thumb {
        background: #CBD5E1;
        border-radius: 4px;
    }

    /* Chat Message */
    .chat-message {
        display: flex;
        gap: 12px;
        margin-bottom: 16px;
        animation: messageIn 0.3s ease;
    }

    @keyframes messageIn {
        from {
            opacity: 0;
            transform: translateY(10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .chat-message.user {
        justify-content: flex-end;
    }

    .chat-message .avatar {
        width: 36px;
        height: 36px;
        min-width: 36px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        font-size: 13px;
        flex-shrink: 0;
    }

    .chat-message.assistant .avatar {
        background: linear-gradient(135deg, #4F46E5, #7C3AED);
        color: white;
    }

    .chat-message.user .avatar {
        background: #1E293B;
        color: white;
    }

    .chat-message .message-content {
        max-width: 78%;
        padding: 12px 16px;
        border-radius: 12px;
        font-size: 13px;
        line-height: 1.6;
        word-wrap: break-word;
        position: relative;
    }

    .chat-message.assistant .message-content {
        background: white;
        color: #1E293B;
        border-bottom-left-radius: 4px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.06);
    }

    .chat-message.user .message-content {
        background: linear-gradient(135deg, #4F46E5, #7C3AED);
        color: white;
        border-bottom-right-radius: 4px;
    }

    .chat-message .message-content ul {
        margin: 6px 0;
        padding-left: 20px;
    }

    .chat-message .message-content ul li {
        margin-bottom: 2px;
    }

    .chat-message .timestamp {
        display: block;
        font-size: 10px;
        opacity: 0.6;
        margin-top: 6px;
    }

    .chat-message.user .timestamp {
        text-align: right;
        color: rgba(255,255,255,0.7);
    }

    .chat-message.assistant .timestamp {
        color: #94A3B8;
    }

    /* Typing Indicator */
    .typing-indicator {
        display: none;
        align-items: center;
        gap: 12px;
        margin-bottom: 16px;
    }

    .typing-indicator.active {
        display: flex;
    }

    .typing-indicator .avatar {
        width: 36px;
        height: 36px;
        min-width: 36px;
        border-radius: 50%;
        background: linear-gradient(135deg, #4F46E5, #7C3AED);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        font-size: 13px;
    }

    .typing-dots {
        display: flex;
        gap: 4px;
        padding: 10px 16px;
        background: white;
        border-radius: 12px;
        border-bottom-left-radius: 4px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.06);
    }

    .typing-dots span {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background: #94A3B8;
        animation: typingBounce 1.4s infinite both;
    }

    .typing-dots span:nth-child(1) { animation-delay: 0s; }
    .typing-dots span:nth-child(2) { animation-delay: 0.2s; }
    .typing-dots span:nth-child(3) { animation-delay: 0.4s; }

    @keyframes typingBounce {
        0%, 60%, 100% { transform: translateY(0); }
        30% { transform: translateY(-6px); }
    }

    /* Chat Input Area */
    .chat-input-area {
        padding: 16px 20px;
        background: white;
        border-top: 1px solid #E2E8F0;
        flex-shrink: 0;
        border-radius: 0 0 12px 12px;
    }

    .chat-input-wrapper {
        display: flex;
        gap: 10px;
        align-items: flex-end;
    }

    .chat-input-wrapper textarea {
        flex: 1;
        border: 2px solid #E2E8F0;
        border-radius: 10px;
        padding: 10px 16px;
        font-size: 13px;
        font-family: inherit;
        resize: none;
        min-height: 44px;
        max-height: 120px;
        transition: all 0.2s;
        background: #F8FAFC;
    }

    .chat-input-wrapper textarea:focus {
        outline: none;
        border-color: #4F46E5;
        box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        background: white;
    }

    .chat-input-wrapper textarea::placeholder {
        color: #94A3B8;
    }

    .chat-input-wrapper .send-btn {
        padding: 10px 20px;
        border: none;
        border-radius: 10px;
        background: linear-gradient(135deg, #4F46E5, #7C3AED);
        color: white;
        font-weight: 600;
        font-size: 14px;
        height: 44px;
        min-width: 80px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        cursor: pointer;
        transition: all 0.2s;
        white-space: nowrap;
    }

    .chat-input-wrapper .send-btn:hover {
        transform: scale(1.02);
        box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
    }

    .chat-input-wrapper .send-btn:disabled {
        opacity: 0.5;
        cursor: not-allowed;
        transform: none;
    }

    .chat-input-wrapper .send-btn .spinner {
        display: none;
        width: 16px;
        height: 16px;
        border: 2px solid rgba(255,255,255,0.3);
        border-top-color: white;
        border-radius: 50%;
        animation: spin 0.6s linear infinite;
    }

    .chat-input-wrapper .send-btn.loading .btn-text {
        display: none;
    }

    .chat-input-wrapper .send-btn.loading .spinner {
        display: block;
    }

    @keyframes spin {
        to { transform: rotate(360deg); }
    }

    .chat-input-hint {
        margin-top: 6px;
        font-size: 0.7rem;
        color: #94A3B8;
        text-align: center;
    }

    .chat-input-hint kbd {
        padding: 1px 6px;
        background: #F1F5F9;
        border: 1px solid #E2E8F0;
        border-radius: 3px;
        font-size: 10px;
        font-family: inherit;
    }

    /* Process Summary */
    .process-summary {
        padding-top: 16px;
        margin-top: 16px;
        border-top: 1px solid #E2E8F0;
    }

    .process-summary .avatar {
        width: 40px;
        height: 40px;
        min-width: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
    }

    .process-summary h6 {
        font-size: 12px;
        font-weight: 600;
        color: #64748B;
        margin-bottom: 2px;
    }

    .process-summary p {
        font-size: 18px;
        font-weight: 700;
        color: #0F172A;
        margin: 0;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .chat-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 10px;
        }

        .chat-header-actions {
            width: 100%;
            justify-content: flex-start;
        }

        .chat-header-actions button {
            font-size: 11px;
            padding: 4px 10px;
        }

        .chat-message .message-content {
            max-width: 85%;
            font-size: 12px;
        }

        .chat-input-wrapper {
            flex-direction: column;
        }

        .chat-input-wrapper textarea {
            width: 100%;
        }

        .chat-input-wrapper .send-btn {
            width: 100%;
            height: 40px;
        }

        .chat-messages {
            min-height: 200px;
            max-height: 300px;
        }

        .process-summary .row {
            gap: 8px;
        }

        .process-summary .col-6 {
            flex: 0 0 50%;
            max-width: 50%;
        }
    }

    @media (max-width: 480px) {
        .chat-header-left h2 {
            font-size: 15px;
        }

        .chat-header-left .ai-icon {
            width: 36px;
            height: 36px;
            font-size: 16px;
        }

        .chat-message .avatar {
            width: 28px;
            height: 28px;
            min-width: 28px;
            font-size: 11px;
        }

        .chat-message .message-content {
            font-size: 11px;
            padding: 8px 12px;
        }
    }
</style>

<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- ============================================
             PAGE HEADER
             ============================================ -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-items-center justify-content-between flex-wrap">
                <div class="d-flex align-items-center gap-3">
                    <h1 class="page-title fw-bold fs-22 mb-0">
                        <span class="text-gradient">Application Details</span>
                    </h1>
                    <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill">
                        <i class="bi bi-stars me-1"></i> AI-Enhanced
                    </span>
                </div>
                <ol class="breadcrumb mb-0 bg-white px-3 py-2 rounded-pill shadow-sm">
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-decoration-none">ELIS</a></li>
                    <li class="breadcrumb-item active text-primary fw-semibold" aria-current="page">Application Details</li>
                </ol>
            </div>
        </div>

        <!-- ============================================
             APPLICATION HEADER
             ============================================ -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 bg-white p-3 rounded-3 shadow-sm">
                    <div>
                        <div class="d-flex align-items-center gap-3">
                            <span class="badge bg-primary fs-6 px-4 py-2 rounded-pill">${job_number}</span>
                            <h4 class="mb-0 fw-bold">${ar_name}</h4>
                            <span class="badge bg-light text-dark border rounded-pill px-3">
                                <i class="bi bi-calendar3 me-1"></i>${fmt_date_of_registration}
                            </span>
                            <span class="badge bg-light text-dark border rounded-pill px-3">
                                <i class="bi bi-clock me-1"></i>${daysSince} days active
                            </span>
                        </div>
                    </div>
                    <div class="d-flex gap-2">
                        <button onclick="javascript:history.go(-1)" 
                                class="btn btn-outline-secondary d-flex align-items-center gap-2 rounded-pill px-4">
                            <i class="bi bi-arrow-left"></i> Back
                        </button>
                        <button class="btn btn-primary d-flex align-items-center gap-2 rounded-pill px-4" 
                                onclick="toggleAIChat()">
                            <i class="bi bi-robot"></i> AI Assistant
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- ============================================
             HIDDEN INPUTS
             ============================================ -->
        <input type="hidden" id="cs_main_case_number" name="cs_main_case_number" value="${case_number}">
        <input type="hidden" id="cs_main_job_number" name="cs_main_job_number" value="${job_number}">
        <input type="hidden" id="cs_main_business_process_id" value="${business_process_id}">
        <input type="hidden" id="cs_main_business_process_name" value="${business_process_name}">
        <input type="hidden" id="cs_main_business_process_sub_id" value="${business_process_sub_id}">
        <input type="hidden" id="cs_main_business_process_sub_name" value="${business_process_sub_name}">
        <input type="hidden" id="cs_main_client_number" value="${phone_number}">
        <input type="hidden" id="cs_main_transaction_number" name="cs_main_transaction_number" value="${transaction_number}">
        <input type="hidden" id="txt_new_lc_registration_district_number" name="txt_new_lc_registration_district_number" value="${registration_district_number}">
        <input type="hidden" id="txt_new_lc_registration_section_number" name="txt_new_lc_registration_section_number" value="${registration_section_number}">
        <input type="hidden" id="txt_new_lc_registration_block_number" name="txt_new_lc_registration_block_number" value="${registration_block_number}">

        <c:forEach items="${mother_to_child_link_list}" var="mother_to_child_link_row">
            <input type="hidden" name="es_case_number" value="${mother_to_child_link_row.mc_case_number}">
            <input type="hidden" name="es_job_number" value="${mother_to_child_link_row.mc_job_number}">
        </c:forEach>

      

        <!-- ============================================
             MAIN CONTENT
             ============================================ -->
        <div class="row g-4">
            
            <!-- LEFT COLUMN -->
            <div class="col-lg-8">
                
                <!-- Process Status Card -->
                <div class="modern-card mb-4">
                    <div class="modern-card-header bg-primary text-white" style="border-radius: var(--radius) var(--radius) 0 0;">
                        <div class="d-flex align-items-center gap-3">
                            <div class="avatar avatar-md bg-white text-primary rounded-circle">
                                <i class="bi bi-clipboard-check fs-5"></i>
                            </div>
                            <div>
                                <h6 class="mb-0 fw-semibold text-white">Process Workflow</h6>
                                <p class="mb-0 small opacity-75">
                                    <i class="bi bi-info-circle me-1"></i>
                                    ${job_number} - ${ar_name}
                                </p>
                            </div>
                        </div>
                        <div class="d-flex gap-2 flex-wrap">
                            <button class="btn btn-sm btn-light" onclick="askAI('What are the next steps for this application?')">
                                <i class="bi bi-robot me-1"></i> AI Next Steps
                            </button>
                            <button class="btn btn-sm btn-info"
                                    data-job_number="${job_number}" 
                                    data-ar_name="${ar_name}"
                                    data-req_id="${rq_id}"
                                    data-business_process_sub_name="${business_process_sub_name}"
                                    onclick="showArchiveConfirmation(this)">
                                <i class="bi bi-check-circle me-1"></i> Complete
                            </button>
                            <button class="btn btn-sm btn-warning"
                                    data-bs-toggle="modal" 
                                    data-bs-target="#askForPurposeOfBatching"
                                    data-job_number="${job_number}" 
                                    data-ar_name="${ar_name}"
                                    data-business_process_sub_name="${business_process_sub_name}">
                                <i class="bi bi-plus-circle me-1"></i> Add to Batch
                            </button>
                        </div>
                    </div>

                   <div class="modern-card-body">
    <!-- Chat Interface -->
    <div class="chat-interface-wrapper">
        
     

        <!-- Chat Messages -->
        <div class="chat-messages" id="chatMessages">
            <!-- Welcome Message -->
            <div class="chat-message assistant">
                <div class="avatar">AI</div>
                <div class="message-content">
                    👋 Hello! I'm your AI assistant. How can I help you today?
                    <span class="timestamp">Just now</span>
                </div>
            </div>

            <!-- Example User Message -->
            <div class="chat-message user">
                <div class="avatar">JD</div>
                <div class="message-content">
                    Can you help me understand the dashboard analytics?
                    <span class="timestamp">2 min ago</span>
                </div>
            </div>

            <!-- Example AI Response -->
            <div class="chat-message assistant">
                <div class="avatar">AI</div>
                <div class="message-content">
                    Absolutely! The dashboard shows key metrics for your business:
                    <ul>
                        <li><strong>Revenue:</strong> $48,295 (12.5% increase)</li>
                        <li><strong>Active Users:</strong> 2,847 (8.2% increase)</li>
                        <li><strong>Orders:</strong> 1,243 (18.7% increase)</li>
                    </ul>
                    Would you like me to dive deeper into any specific metric?
                    <span class="timestamp">1 min ago</span>
                </div>
            </div>

            <!-- Typing Indicator -->
            <div class="typing-indicator" id="typingIndicator">
                <div class="avatar">AI</div>
                <div class="typing-dots">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
        </div>

        <!-- Chat Input -->
        <div class="chat-input-area">
            <form id="chatForm" autocomplete="off">
                <div class="chat-input-wrapper">
                    <textarea id="userInput" rows="1" placeholder="Type your message here... (Press Enter to send)" required></textarea>
                    <button type="submit" class="send-btn" id="sendBtn">
                        <span class="btn-text"><i class="fas fa-paper-plane"></i> Send</span>
                        <span class="spinner"></span>
                    </button>
                </div>
                <div class="chat-input-hint">
                    <i class="fas fa-info-circle"></i> Press <kbd>Enter</kbd> to send, <kbd>Shift+Enter</kbd> for new line
                </div>
            </form>
        </div>
    </div>

   
</div>


                </div>
            </div>

            <!-- ============================================
                 RIGHT COLUMN - SIDEBAR
                 ============================================ -->
            <div class="col-lg-4">
                
                <!-- Map -->
                <div class="modern-card mb-3">
                    <div class="modern-card-header">
                        <span class="fw-semibold"><i class="bi bi-map me-2"></i>Map</span>
                        <span class="badge bg-primary bg-opacity-10 text-primary">AI Ready</span>
                    </div>
                    <div class="modern-card-body">
                        <div id="parcelMap" style="height: 260px; border-radius: 8px; overflow: hidden;"></div>
                        <small class="text-muted d-block mt-2 text-center">
                            <i class="bi bi-robot me-1"></i> Ask AI to analyze this parcel
                        </small>
                    </div>
                </div>

             
                <!-- Public Documents -->
                <div class="modern-card mb-3">
                    <div class="modern-card-header">
                        <span class="fw-semibold"><i class="bi bi-globe me-2"></i>Public Documents</span>
                    </div>
                    <div class="modern-card-body">
                        <div class="d-flex gap-2 mb-3">
                            <button class="btn btn-sm btn-outline-primary" id="btn_load_scanned_documents_public">
                                <i class="bi bi-eye"></i> Load
                            </button>
                            <button class="btn btn-sm btn-primary" id="btn_add_public_document"
                                    data-bs-toggle="modal" data-bs-target="#publicFileUploadModal">
                                <i class="bi bi-plus"></i> Add
                            </button>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-sm table-hover" id="lc_public_documents_dataTable">
                                <thead>
                                    <tr><th>Document Name</th><th>Type</th></tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>



  <!-- ===== SCRIPTS ===== -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {

            // ===== SIDEBAR TOGGLE =====
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            const toggleBtn = document.getElementById('sidebarToggle');

            if (toggleBtn) {
                toggleBtn.addEventListener('click', function() {
                    sidebar.classList.toggle('open');
                    if (overlay) overlay.classList.toggle('active');
                });
            }

            if (overlay) {
                overlay.addEventListener('click', function() {
                    sidebar.classList.remove('open');
                    overlay.classList.remove('active');
                });
            }

            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape' && sidebar && sidebar.classList.contains('open')) {
                    sidebar.classList.remove('open');
                    if (overlay) overlay.classList.remove('active');
                }
            });

            // ===== NAVIGATION ACTIVE STATE =====
            document.querySelectorAll('.sidebar-nav .nav-item').forEach(item => {
                item.addEventListener('click', function(e) {
                    e.preventDefault();
                    document.querySelectorAll('.sidebar-nav .nav-item').forEach(i => i.classList.remove('active'));
                    this.classList.add('active');

                    const page = this.getAttribute('data-page');
                    if (page === 'logout') {
                        alert('🔒 Logging out...');
                        return;
                    }

                    // Demo - show page change
                    const pageName = this.querySelector('span') ? this.querySelector('span').textContent : 'Page';
                    alert('📄 Navigating to: ' + pageName + '\n\nThis is a demo. In production, this would load the ' +
                        pageName + ' page.');
                });
            });

            // ===== CHAT FUNCTIONALITY =====
            const chatForm = document.getElementById('chatForm');
            const userInput = document.getElementById('userInput');
            const sendBtn = document.getElementById('sendBtn');
            const chatMessages = document.getElementById('chatMessages');
            const typingIndicator = document.getElementById('typingIndicator');

            // Auto-resize textarea
            userInput.addEventListener('input', function() {
                this.style.height = 'auto';
                this.style.height = Math.min(this.scrollHeight, 150) + 'px';
            });

            // Focus on textarea on load
            setTimeout(() => userInput.focus(), 100);

            // Generate AI response (simulated)
            function generateAIResponse(userMessage) {
                const responses = [
                    "That's a great question! Let me think about that for a moment.",
                    "I understand what you're saying. Here's what I think about that...",
                    "Interesting point! Have you considered looking at it from this perspective?",
                    "Based on what you've told me, I would suggest the following approach...",
                    "That's a complex topic. Let me break it down for you step by step.",
                    "I appreciate you asking that. The answer is quite fascinating!",
                    "Let me research that for you. In the meantime, here's what I know...",
                    "Great question! The short answer is yes, but let me explain why.",
                    "I see where you're coming from. Here's another way to think about it.",
                    "Thanks for sharing that. This reminds me of something similar I've seen before."
                ];

                const specificResponses = {
                    'hello': 'Hello there! How can I assist you today? 😊',
                    'hi': 'Hi! Great to see you. What can I help you with?',
                    'help': 'I\'m here to help! You can ask me about analytics, dashboard insights, or general questions about your business.',
                    'analytics': 'Analytics are fascinating! Your dashboard shows real-time metrics including revenue, user engagement, and conversion rates. Would you like specific details on any metric?',
                    'revenue': 'Your total revenue is $48,295 with a 12.5% increase from last month. This is driven primarily by your new product line and improved conversion rates.',
                    'users': 'You currently have 2,847 active users, which is up 8.2% from last month. Your user retention rate is 94%, which is excellent!',
                    'dashboard': 'The dashboard provides a comprehensive overview of your business metrics including revenue, users, orders, and conversion rates. You can customize it to show the metrics that matter most to you.',
                    'thanks': 'You\'re welcome! I\'m glad I could help. Is there anything else you\'d like to know?',
                    'thank you': 'You\'re very welcome! Feel free to ask if you need anything else.',
                };

                const lowerMsg = userMessage.toLowerCase();

                // Check for specific matches
                for (let [key, value] of Object.entries(specificResponses)) {
                    if (lowerMsg.includes(key)) {
                        return value;
                    }
                }

                // Random response
                return responses[Math.floor(Math.random() * responses.length)];
            }

            // Add message to chat
            function addMessage(role, content) {
                const messageDiv = document.createElement('div');
                messageDiv.className = 'chat-message ' + role;

                const avatar = document.createElement('div');
                avatar.className = 'avatar';
                avatar.textContent = role === 'user' ? 'JD' : 'AI';

                const contentDiv = document.createElement('div');
                contentDiv.className = 'message-content';

                // Convert text to HTML with line breaks
                const formattedContent = content.replace(/\n/g, '<br>');
                contentDiv.innerHTML = formattedContent;

                const timestamp = document.createElement('span');
                timestamp.className = 'timestamp';
                const now = new Date();
                timestamp.textContent = now.toLocaleTimeString('en-US', {
                    hour: 'numeric',
                    minute: '2-digit'
                });

                contentDiv.appendChild(timestamp);
                messageDiv.appendChild(avatar);
                messageDiv.appendChild(contentDiv);

                chatMessages.appendChild(messageDiv);
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }

            // Clear chat
            window.clearChat = function() {
                if (confirm('Are you sure you want to clear all chat messages?')) {
                    const messages = chatMessages.querySelectorAll('.chat-message');
                    messages.forEach(msg => msg.remove());

                    // Add welcome message back
                    const welcomeDiv = document.createElement('div');
                    welcomeDiv.className = 'chat-message assistant';
                    welcomeDiv.innerHTML = `
                                <div class="avatar">AI</div>
                                <div class="message-content">
                                    👋 Hello! I'm your AI assistant. How can I help you today?
                                    <span class="timestamp">Just now</span>
                                </div>
                            `;
                    chatMessages.appendChild(welcomeDiv);
                    chatMessages.scrollTop = chatMessages.scrollHeight;
                }
            };

            // Export chat
            window.exportChat = function() {
                const messages = document.querySelectorAll('.chat-message');
                let exportText = '=== AI Chat Conversation ===\n';
                exportText += 'Date: ' + new Date().toLocaleString() + '\n\n';

                messages.forEach(msg => {
                    const role = msg.classList.contains('user') ? 'User' : 'AI Assistant';
                    const content = msg.querySelector('.message-content');
                    if (content) {
                        const text = content.textContent.replace(/\n/g, ' ').trim();
                        exportText += role + ': ' + text + '\n\n';
                    }
                });

                const blob = new Blob([exportText], { type: 'text/plain' });
                const url = URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = 'chat-export-' + new Date().toISOString().slice(0, 10) + '.txt';
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
                URL.revokeObjectURL(url);
            };

            // // Handle form submission
            // chatForm.addEventListener('submit', function(e) {
            //     e.preventDefault();

            //     const message = userInput.value.trim();
            //     if (!message) return;

            //     // Add user message
            //     addMessage('user', message);
            //     userInput.value = '';
            //     userInput.style.height = 'auto';

            //     // Show typing indicator
            //     typingIndicator.classList.add('active');
            //     chatMessages.scrollTop = chatMessages.scrollHeight;

            //     // Disable send button
            //     sendBtn.classList.add('loading');
            //     sendBtn.disabled = true;

            //     // Simulate AI response (in production, this would call OpenAI API)
            //     setTimeout(() => {
            //         // Hide typing indicator
            //         typingIndicator.classList.remove('active');

            //         // Generate and add AI response
            //         const aiResponse = generateAIResponse(message);
            //         addMessage('assistant', aiResponse);

            //         // Enable send button
            //         sendBtn.classList.remove('loading');
            //         sendBtn.disabled = false;
            //         userInput.focus();

            //     }, 1500 + Math.random() * 1000);
            // });
chatForm.addEventListener('submit', function(e) {
    e.preventDefault();

    const message = userInput.value.trim();
    if (!message) return;

    // Get application context data
    const caseNumber = document.getElementById('cs_main_case_number')?.value || '';
    const jobNumber = document.getElementById('cs_main_job_number')?.value || '';
    const appType = document.getElementById('cs_main_business_process_sub_name')?.value || '';

    // Add user message to chat
    addMessage('user', message);
    userInput.value = '';
    userInput.style.height = 'auto';

    // Show typing indicator
    typingIndicator.classList.add('active');
    chatMessages.scrollTop = chatMessages.scrollHeight;

    // Disable send button
    sendBtn.classList.add('loading');
    sendBtn.disabled = true;

    // Prepare data for servlet
    const requestData = {
        action: 'chat',
        message: message,
        caseNumber: caseNumber,
        jobNumber: jobNumber,
        appType: appType,
        timestamp: new Date().toISOString()
    };

    // Send to servlet
    $.ajax({
        type: "POST",
        url: "ai_serv",
        data: {
            request_type: 'chat_with_agent',
            chat_message: message,
            case_number: caseNumber,
            job_number: jobNumber,
            business_process_sub_name: appType
        },
        //cache: false,
       // dataType: 'json',
       // timeout: 30000, // 30 second timeout
        success: function(response) {
            // Hide typing indicator
            typingIndicator.classList.remove('active');
            console.log('AI response received:', response);
             var result = JSON.parse(response);
            // Get AI response from servlet
            let aiResponse = '';
            if (result && result.success) {
                aiResponse = result.message || result.data || 'I received your message but no response was generated.';
                // If there's additional data, format it nicely
                if (result.data && typeof result.data === 'object') {
                    aiResponse = formatAIResponse(result.data, result.message);
                }
            } else {
                aiResponse = result?.message || 'Sorry, I encountered an error processing your request. Please try again.';
            }
            
            // Add AI response to chat
            addMessage('assistant', aiResponse);
            
            // Enable send button
            sendBtn.classList.remove('loading');
            sendBtn.disabled = false;
            userInput.focus();
        },
        error: function(xhr, status, error) {
            // Hide typing indicator
            typingIndicator.classList.remove('active');
            
            // Handle errors gracefully
            let errorMessage = 'Sorry, I encountered an error. Please try again.';
            
            if (status === 'timeout') {
                errorMessage = 'The request timed out. Please try again.';
            } else if (xhr.status === 0) {
                errorMessage = 'Network error. Please check your connection.';
            } else if (xhr.status === 403) {
                errorMessage = 'You don\'t have permission to use the AI chat.';
            } else if (xhr.status === 500) {
                errorMessage = 'Server error. Please try again later.';
            } else if (xhr.responseText) {
                try {
                    const errorResponse = JSON.parse(xhr.responseText);
                    if (errorResponse.message) {
                        errorMessage = errorResponse.message;
                    }
                } catch (e) {
                    // If response isn't JSON, use status text
                    errorMessage = `Error ${xhr.status}: ${xhr.statusText || 'Unknown error'}`;
                }
            }
            
            addMessage('assistant', '❌ ' + errorMessage);

        
            
            // Enable send button
            sendBtn.classList.remove('loading');
            sendBtn.disabled = false;
            userInput.focus();
        }
    });
});

            // Keyboard shortcuts
            userInput.addEventListener('keydown', function(e) {
                if (e.key === 'Enter' && !e.shiftKey) {
                    e.preventDefault();
                    const message = this.value.trim();
                    if (message) {
                        chatForm.dispatchEvent(new Event('submit'));
                    }
                }
            });

            // ===== USER PROFILE =====
            document.getElementById('userProfile').addEventListener('click', function() {
                alert('👤 User Profile\n\nName: ${full_name}\nRole: Administrator\n\nClick to view full profile');
            });

            // ===== NOTIFICATIONS =====
            document.querySelectorAll('.icon-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const icon = this.querySelector('i');
                    if (icon) {
                        if (icon.classList.contains('fa-bell')) {
                            alert('🔔 You have 3 new notifications');
                        } else if (icon.classList.contains('fa-envelope')) {
                            alert('📧 You have 5 unread messages');
                        }
                    }
                });
            });

            // ===== SEARCH =====
            document.querySelector('.header-search input').addEventListener('keydown', function(e) {
                if (e.key === 'Enter') {
                    const query = this.value.trim();
                    if (query) {
                        alert('🔍 Searching for: ' + query + '\n\nThis would search through your conversations.');
                    }
                }
            });

            // ===== STATS CARD CLICKS =====
            // Add this if you have stats cards in your dashboard
            document.querySelectorAll('.stat-card')?.forEach(card => {
                card.addEventListener('click', function() {
                    const label = this.querySelector('.stat-label')?.textContent || 'Stat';
                    const value = this.querySelector('.stat-value')?.textContent || '';
                    alert('📊 ' + label + '\n\nValue: ' + value + '\n\nClick to view detailed report.');
                });
            });

            console.log('🤖 AI Chat Dashboard loaded successfully!');
            console.log('📝 Messages: ' + document.querySelectorAll('.chat-message').length);
        });
    </script>

<script>
    // Define EPSG:2136 projection
    //   proj4.defs('EPSG:2136', '+proj=utm +zone=36 +south +ellps=clrk80 +units=m +no_defs');

    function editStep(stepId) {
        alert('Editing step with ID: '+stepId);
    }

    // Function to handle deleting a step
    function deleteStep(stepId) {
        const confirmation = confirm('Are you sure you want to delete the step with ID: '+stepId+'?');
        if (confirmation) {
            alert('Deleted step with ID: '+stepId);
            // Replace the alert with your logic for deleting
        }
    }

    function reviewStep(bse_id, job_number) {
        Swal.fire({
            title: 'Confirm Approval',
            text: 'Are you sure you want to approve this step?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, approve it!',
            cancelButtonText: 'Cancel',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                if (!bse_id || !job_number) {
                    Swal.fire({
                        title: 'Error!',
                        text: 'Sorry! An error occurred, try again.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                // Show loading state
                Swal.fire({
                    title: 'Processing...',
                    text: 'Please wait while we approve the step',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });

                $.ajax({
                    type: "POST",
                    url: "Case_Management_Serv",
                    data: {
                        request_type: 'select_review_baby_steps_check_for_completion',
                        bse_id: parseInt(bse_id),
                        job_number: job_number
                    },
                    cache: false,
                    success: function(response) {
                        //console.log(response);
                        //var json_result = JSON.parse(response);
                        
                        Swal.close();
                        
                        // if (json_result.success) {
                            Swal.fire({
                                title: 'Success!',
                                text: 'Step approved successfully',
                                icon: 'success',
                                confirmButtonText: 'OK',
                                timer: 2000,
                                timerProgressBar: true,
                                willClose: () => {
                                    location.reload();
                                }
                            });
                        // } else {
                        //     Swal.fire({
                        //         title: 'Failed!',
                        //         text: json_result.msg,
                        //         icon: 'error',
                        //         confirmButtonText: 'OK'
                        //     });
                        // }
                    },
                    error: function() {
                        Swal.fire({
                            title: 'Error!',
                            text: 'An error occurred while processing your request.',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                    }
                });
            }
        });
    }

    // Initialize the map when the DOM is fully loaded
    document.addEventListener('DOMContentLoaded', function() {
        // Placeholder coordinates (longitude, latitude) for the parcel
        // In a real implementation, these should be dynamically fetched based on GLPIN or other parcel data
        var parcel_lrd_dataSource = new ol.source.TileWMS({
            url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
            params : {
                'LAYERS' : 'csau_geospatial:lc_spatial_objects',
                'TILED' : true
            },
            serverType : 'geoserver',
            transition : 0
        }) 

        var lrd_parcels_dataLayer = new ol.layer.Tile({
            title : 'LRD Parcels Layer',
            source : parcel_lrd_dataSource

        })


        var lrd_certificate_region_dataSource = new ol.source.TileWMS({
            url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
            params : {
                'LAYERS' : 'csau_geospatial:lrd_certificate_region',
                'TILED' : true
            },

            serverType : 'geoserver',
            transition : 0
        })

        var lrd_certificate_region_dataLayer = new ol.layer.Tile({
            title : 'LRD Certificate Region',
            visible : false,
            source : lrd_certificate_region_dataSource

        })


        var lcfrs_grid_lrd_dataSource = new ol.source.TileWMS({
            url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
            params : {
                'LAYERS' : 'csau_geospatial:gng_grid',
                'TILED' : true
            },
            
            serverType : 'geoserver',
            transition : 0
        })
                    
        var lcfrs_grid_lrd_dataLayer = new ol.layer.Tile({
            title : 'Grid',
            visible : false,
            source : lcfrs_grid_lrd_dataSource
        })
                    
        var lcfrs_registration_district_dataSource = new ol.source.TileWMS({
            url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
            params : {
                'LAYERS' : 'csau_geospatial:district',
                'TILED' : true
            },
                    
            serverType : 'geoserver',
            transition : 0
        })
                    
        var lcfrs_registration_district_dataLayer = new ol.layer.Tile({
            title : 'Registration District',
            visible : false,
            source : lcfrs_registration_district_dataSource
        })

        var googleLayerHybrid = new ol.layer.Tile({
            title : "Google Satellite & Roads",
            // 'type': 'base',
            visible : false,
            opacity : 1.000000,
            source : new ol.source.XYZ({
                attributions : [ new ol.Attribution({
                    html : '<a href=""></a>'
                }) ],
                url : 'http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga'
            }),
        });  

        var projObj = new ol.proj.Projection({
            // code: 'EPSG:3857',
            code : 'EPSG:2136',
            extent : [ 80935.4497355444, 1209.0295731349593, 1711780.3060929566,
                    2358523.124783509 ],
            units : 'ft',
            axisOrientation : 'enu',
            global : false,
            // worldExtent: [-199,32,322,0],
            worldExtent : [ -3.79, 1.4, 2.1, 11.16 ],
            getPointResolution : function(r) {
                return r;
            },
            // worldExtent: [-118905.86588345, -1185221.57235827,
            // 2011055.53818079,
            // 2360318.82691170]
            // extent: [32000000,5900000,33000000,6000000]
            // extent: [32502277,5970203,32513486,5971984]
        });

        ol.proj.setProj4(proj4);
        proj4 .defs( "EPSG:2136",'+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs');


        const wktPolygon = '${parcel_wkt}';

        // console.log('wktPolygon')
        // console.log(wktPolygon)

        // Parse WKT to OpenLayers geometry
               
        //   vectorLayer.setSource(new ol.source.Vector({features : (new ol.format.WKT()).readFeatures(wktPolygon)}));
             
        // Initialize OpenLayers map
        const map = new ol.Map({
            target: 'parcelMap',
            controls : ol.control.defaults().extend(
			[ new ol.control.LayerSwitcher(),
			new ol.control.OverviewMap(),
			new ol.control.ZoomSlider(), new ol.control.Attribution(),
					new ol.control.MousePosition(),
					new ol.control.ZoomToExtent(), new ol.control.FullScreen()
			]),
	        renderer : 'canvas',
            layers: [
                new ol.layer.Tile({
                    source: new ol.source.OSM()
                })
            ],
            view: new ol.View({
              projection : projObj,
              extent : ol.proj.get('EPSG:2136').getExtent(),
                center : [ 1187433.58822084, 327091.107070208 ],
                zoom: 12
            })
        });

        // Add the polygon to the map
        // const vectorSource = new ol.source.Vector({
        //     features: [polygonFeature]
        // });

        const vectorLayer = new ol.layer.Vector({
            source: new ol.source.Vector(),
            style: new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color: '#ff0000',
                    width: 2
                }),
                fill: new ol.style.Fill({
                    color: 'rgba(255, 0, 0, 0.2)'
                })
            })
        });

        map.addLayer(googleLayerHybrid);
        map.addLayer(lcfrs_registration_district_dataLayer);
        map.addLayer(lrd_parcels_dataLayer);
        map.addLayer(vectorLayer);

        // console.log("wktPolygon")
        // console.log(wktPolygon)
        vectorLayer.setSource(new ol.source.Vector({features : (new ol.format.WKT()).readFeatures(wktPolygon)}));
        map.getView().fit(vectorLayer.getSource().getExtent(),{size : map.getSize(),maxZoom : 16})
        

    });

    
</script>
<jsp:include page="../../components/_gated_workflow_modal.jsp"></jsp:include>
<jsp:include page="../../components/_gated_workflow_modal_2.jsp"></jsp:include>
<jsp:include page="../../components/_gated_workflow_modal_3.jsp"></jsp:include>
