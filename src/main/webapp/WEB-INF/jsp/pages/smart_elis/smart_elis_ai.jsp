<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>

<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>

<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>


<style>

    :root {

        --ai-primary: #4F46E5;
        --ai-primary-dark: #3730A3;
        --ai-secondary: #7C3AED;

        --ai-success: #10B981;
        --ai-warning: #F59E0B;
        --ai-danger: #EF4444;
        --ai-info: #3B82F6;

        --ai-gray-50: #F8FAFC;
        --ai-gray-100: #F1F5F9;
        --ai-gray-200: #E2E8F0;
        --ai-gray-300: #CBD5E1;
        --ai-gray-400: #94A3B8;
        --ai-gray-500: #64748B;
        --ai-gray-600: #475569;
        --ai-gray-700: #334155;
        --ai-gray-800: #1E293B;
        --ai-gray-900: #0F172A;

        --ai-radius: 14px;

        --ai-shadow-sm:
            0 1px 3px rgba(15,23,42,.06);

        --ai-shadow:
            0 5px 20px rgba(15,23,42,.08);

        --ai-gradient:
            linear-gradient(
                135deg,
                #4F46E5 0%,
                #7C3AED 100%
            );

    }


    /* =========================================================
       CARD
       ========================================================= */

    .ai-modern-card {

        background: #fff;

        border:
            1px solid var(--ai-gray-200);

        border-radius:
            var(--ai-radius);

        box-shadow:
            var(--ai-shadow-sm);

        overflow: hidden;

    }


    .ai-modern-card-header {

        padding:
            15px 18px;

        border-bottom:
            1px solid var(--ai-gray-200);

        background:
            var(--ai-gray-50);

        display: flex;

        align-items: center;

        justify-content:
            space-between;

        gap: 10px;

        flex-wrap: wrap;

    }


    .ai-modern-card-body {

        padding:
            18px;

    }


    /* =========================================================
       SOURCE CARDS
       ========================================================= */

    .ai-source-item {

        display: flex;

        gap: 12px;

        padding:
            12px;

        margin-bottom:
            9px;

        border:
            1px solid var(--ai-gray-200);

        border-radius:
            10px;

        background:
            white;

        transition:
            all .2s ease;

    }


    .ai-source-item:hover {

        border-color:
            var(--ai-primary);

        background:
            #F8F7FF;

    }


    .ai-source-icon {

        width: 38px;

        height: 38px;

        min-width: 38px;

        border-radius:
            10px;

        display: flex;

        align-items: center;

        justify-content:
            center;

        font-size:
            16px;

    }


    .ai-source-title {

        font-size:
            13px;

        font-weight:
            600;

        color:
            var(--ai-gray-800);

    }


    .ai-source-description {

        font-size:
            11px;

        color:
            var(--ai-gray-500);

        margin-top:
            2px;

    }


    /* =========================================================
       EXAMPLE QUESTIONS
       ========================================================= */

    .ai-example-question {

        width: 100%;

        text-align: left;

        font-size:
            12px;

        white-space:
            normal;

        line-height:
            1.4;

    }


    /* =========================================================
       CHAT
       ========================================================= */

    .ai-chat-wrapper {

        display: flex;

        flex-direction:
            column;

        min-height:
            610px;

    }


    .ai-chat-header {

        padding:
            16px 20px;

        background:
            var(--ai-gradient);

        color: white;

        display: flex;

        justify-content:
            space-between;

        align-items:
            center;

        gap: 10px;

        flex-wrap:
            wrap;

    }


    .ai-chat-title {

        display: flex;

        align-items:
            center;

        gap: 12px;

    }


    .ai-chat-title-icon {

        width: 42px;

        height: 42px;

        border-radius:
            50%;

        background:
            rgba(255,255,255,.2);

        display: flex;

        align-items:
            center;

        justify-content:
            center;

        font-size:
            18px;

    }


    .ai-chat-title h5 {

        margin: 0;

        color: white;

        font-weight:
            600;

    }


    .ai-chat-title small {

        color:
            rgba(255,255,255,.8);

    }


    .ai-chat-messages {

        flex: 1;

        overflow-y:
            auto;

        background:
            var(--ai-gray-50);

        padding:
            20px;

        min-height:
            375px;

        max-height:
            510px;

    }


    .ai-chat-messages::-webkit-scrollbar {

        width:
            5px;

    }


    .ai-chat-messages::-webkit-scrollbar-thumb {

        background:
            var(--ai-gray-300);

        border-radius:
            5px;

    }


    .ai-chat-message {

        display: flex;

        gap: 10px;

        margin-bottom:
            17px;

        animation:
            aiMessageIn .25s ease;

    }


    @keyframes aiMessageIn {

        from {

            opacity: 0;

            transform:
                translateY(6px);

        }

        to {

            opacity: 1;

            transform:
                translateY(0);

        }

    }


    .ai-chat-message.user {

        justify-content:
            flex-end;

    }


    .ai-chat-avatar {

        width: 34px;

        height: 34px;

        min-width: 34px;

        border-radius:
            50%;

        display: flex;

        align-items:
            center;

        justify-content:
            center;

        font-size:
            12px;

        font-weight:
            600;

        background:
            var(--ai-gradient);

        color:
            white;

    }


    .ai-chat-message.user
    .ai-chat-avatar {

        background:
            var(--ai-gray-800);

        order: 2;

    }


    .ai-chat-message-content {

        max-width:
            82%;

        padding:
            11px 15px;

        border-radius:
            12px;

        font-size:
            13px;

        line-height:
            1.6;

        background:
            white;

        border:
            1px solid var(--ai-gray-200);

        color:
            var(--ai-gray-800);

        box-shadow:
            var(--ai-shadow-sm);

        word-break:
            break-word;

    }


    .ai-chat-message.user
    .ai-chat-message-content {

        background:
            var(--ai-gradient);

        color:
            white;

        border:
            none;

    }


    .ai-message-time {

        display: block;

        margin-top:
            5px;

        font-size:
            9px;

        opacity:
            .6;

    }


    /* =========================================================
       TYPING
       ========================================================= */

    .ai-typing-indicator {

        display: none;

        align-items:
            center;

        gap:
            10px;

        margin-bottom:
            15px;

    }


    .ai-typing-indicator.active {

        display: flex;

    }


    .ai-typing-dots {

        display: flex;

        gap: 4px;

        padding:
            11px 15px;

        background:
            white;

        border:
            1px solid var(--ai-gray-200);

        border-radius:
            12px;

    }


    .ai-typing-dots span {

        width:
            7px;

        height:
            7px;

        border-radius:
            50%;

        background:
            var(--ai-gray-400);

        animation:
            aiTyping 1.2s infinite;

    }


    .ai-typing-dots span:nth-child(2) {

        animation-delay:
            .15s;

    }


    .ai-typing-dots span:nth-child(3) {

        animation-delay:
            .30s;

    }


    @keyframes aiTyping {

        0%,
        60%,
        100% {

            transform:
                translateY(0);

            opacity:
                .4;

        }

        30% {

            transform:
                translateY(-4px);

            opacity:
                1;

        }

    }


    /* =========================================================
       CHAT INPUT
       ========================================================= */

    .ai-chat-input-area {

        border-top:
            1px solid var(--ai-gray-200);

        padding:
            15px 18px;

        background:
            white;

    }


    .ai-chat-input-wrapper {

        display: flex;

        gap: 10px;

        align-items:
            flex-end;

    }


    #ai_user_input {

        flex: 1;

        resize: none;

        min-height:
            46px;

        max-height:
            130px;

        border:
            2px solid var(--ai-gray-200);

        border-radius:
            10px;

        padding:
            10px 14px;

        font-size:
            13px;

        background:
            var(--ai-gray-50);

    }


    #ai_user_input:focus {

        border-color:
            var(--ai-primary);

        background:
            white;

        box-shadow:
            0 0 0 4px rgba(79,70,229,.10);

        outline:
            none;

    }


    .ai-send-btn {

        min-width:
            92px;

        height:
            46px;

        border:
            none;

        border-radius:
            10px;

        background:
            var(--ai-gradient);

        color:
            white;

        font-weight:
            600;

        padding:
            0 18px;

    }


    .ai-send-btn:disabled {

        opacity:
            .55;

    }


    .ai-send-spinner {

        display:
            none;

        width:
            16px;

        height:
            16px;

        border:
            2px solid rgba(255,255,255,.35);

        border-top-color:
            white;

        border-radius:
            50%;

        animation:
            aiSpin .6s linear infinite;

    }


    .ai-send-btn.loading
    .ai-send-text {

        display:
            none;

    }


    .ai-send-btn.loading
    .ai-send-spinner {

        display:
            inline-block;

    }


    @keyframes aiSpin {

        to {

            transform:
                rotate(360deg);

        }

    }


    /* =========================================================
       RESULT AREA
       ========================================================= */

    .ai-result-tabs .nav-link {

        font-size:
            12px;

        font-weight:
            500;

    }


    .ai-result-table {

        font-size:
            12px;

        white-space:
            nowrap;

    }


    .ai-empty-result {

        text-align:
            center;

        color:
            var(--ai-gray-400);

        padding:
            45px 15px;

    }


    .ai-empty-result i {

        font-size:
            34px;

        display:
            block;

        margin-bottom:
            10px;

    }


    .ai-query-code {

        min-height:
            100px;

        max-height:
            280px;

        overflow:
            auto;

        white-space:
            pre-wrap;

        word-break:
            break-word;

        padding:
            14px;

        border-radius:
            9px;

        background:
            #111827;

        color:
            #D1FAE5;

        font-size:
            11px;

        font-family:
            Monaco,
            Consolas,
            monospace;

    }


    .ai-route-chip {

        display:
            inline-block;

        margin-right:
            5px;

        margin-bottom:
            5px;

        padding:
            4px 9px;

        border-radius:
            999px;

        background:
            #EEF2FF;

        color:
            var(--ai-primary);

        font-size:
            10px;

        font-weight:
            600;

    }


    /* =========================================================
       MAP
       ========================================================= */

    #ai_database_map {

        height:
            470px;

        width:
            100%;

        background:
            #f4f6f8;

        border-radius:
            8px;

    }


    /* =========================================================
       EVIDENCE
       ========================================================= */

    .ai-evidence-item {

        padding:
            14px;

        border:
            1px solid var(--ai-gray-200);

        border-radius:
            10px;

        margin-bottom:
            10px;

        background:
            white;

    }


    .ai-evidence-score {

        font-size:
            10px;

        border-radius:
            999px;

        padding:
            3px 8px;

        background:
            #DCFCE7;

        color:
            #166534;

    }


    /* =========================================================
       STATS
       ========================================================= */

    .ai-stat-box {

        border:
            1px solid var(--ai-gray-200);

        border-radius:
            10px;

        padding:
            12px;

        text-align:
            center;

        height:
            100%;

    }


    .ai-stat-label {

        font-size:
            10px;

        color:
            var(--ai-gray-500);

    }


    .ai-stat-value {

        font-weight:
            700;

        font-size:
            20px;

        color:
            var(--ai-gray-900);

    }


    @media(max-width: 767px) {

        .ai-chat-input-wrapper {

            flex-direction:
                column;

        }


        .ai-send-btn {

            width:
                100%;

        }


        .ai-chat-message-content {

            max-width:
                88%;

        }

    }

</style>


<div class="main-content app-content">

    <div class="container-fluid page-container">


        <!-- =====================================================
             PAGE HEADER
             ===================================================== -->

        <div class="page-header-breadcrumb mb-4">

            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">


                <div>

                    <div class="d-flex align-items-center gap-2">

                        <h1 class="page-title fw-semibold fs-20 mb-1">

                            ELIS AI Database Assistant

                        </h1>


                        <span class="badge bg-primary bg-opacity-10 text-primary">

                            <i class="fas fa-robot me-1"></i>

                            AI Enhanced

                        </span>

                    </div>


                    <p class="text-muted mb-0">

                        <i class="ri-information-line me-1"></i>

                        Ask questions across transactional,
                        document, vector and geospatial databases

                    </p>

                </div>


                <div class="text-end">

                    <ol class="breadcrumb justify-content-end mb-2">

                        <li class="breadcrumb-item">

                            <a
                                href="javascript:void(0);"
                                class="text-decoration-none">

                                ELIS

                            </a>

                        </li>


                        <li class="breadcrumb-item">

                            AI Services

                        </li>


                        <li
                            class="breadcrumb-item active"
                            aria-current="page">

                            Database Assistant

                        </li>

                    </ol>


                    <span class="badge bg-success px-3 py-2 me-1">

                        <i class="fas fa-circle me-1"
                           style="font-size:6px;"></i>

                        AI Service

                    </span>


                    <span class="badge bg-primary px-3 py-2">

                        <i class="fas fa-database me-1"></i>

                        ELIS Data

                    </span>

                </div>

            </div>

        </div>


        <!-- =====================================================
             HIDDEN CONTEXT
             ===================================================== -->

        <input
            type="hidden"
            id="ai_context_type"
            value="database_assistant">


        <input
            type="hidden"
            id="ai_current_user"
            value="${full_name}">


        <input
            type="hidden"
            id="ai_current_region"
            value="${region}">


        <!-- =====================================================
             MAIN CONTENT
             ===================================================== -->

        <div class="row g-4">


            <!-- =================================================
                 LEFT SIDEBAR
                 ================================================= -->

            <div class="col-xl-3 col-lg-4">


                <!-- =============================================
                     DATA SOURCES
                     ============================================= -->

                <div class="ai-modern-card mb-3">

                    <div class="ai-modern-card-header">

                        <span class="fw-semibold">

                            <i class="fas fa-database me-2 text-primary"></i>

                            Search Sources

                        </span>

                        <span class="badge bg-success">

                            Connected

                        </span>

                    </div>


                    <div class="ai-modern-card-body">


                        <!-- TRANSACTION DB -->

                        <label class="ai-source-item">

                            <input
                                class="form-check-input mt-2"
                                type="checkbox"
                                id="ai_source_transaction"
                                checked>


                            <div class="ai-source-icon bg-primary bg-opacity-10 text-primary">

                                <i class="fas fa-table"></i>

                            </div>


                            <div class="flex-grow-1">

                                <div class="ai-source-title">

                                    Transaction Database

                                </div>

                                <div class="ai-source-description">

                                    Applications, clients, workflow,
                                    billing, registration and transactions.

                                </div>

                            </div>

                        </label>


                        <!-- SPATIAL -->

                        <label class="ai-source-item">

                            <input
                                class="form-check-input mt-2"
                                type="checkbox"
                                id="ai_source_spatial"
                                checked>


                            <div class="ai-source-icon bg-success bg-opacity-10 text-success">

                                <i class="fas fa-map-marked-alt"></i>

                            </div>


                            <div class="flex-grow-1">

                                <div class="ai-source-title">

                                    PostGIS / Spatial

                                </div>

                                <div class="ai-source-description">

                                    Parcels, boundaries, overlays,
                                    coordinates and spatial relationships.

                                </div>

                            </div>

                        </label>


                        <!-- VECTOR -->

                        <label class="ai-source-item">

                            <input
                                class="form-check-input mt-2"
                                type="checkbox"
                                id="ai_source_vector"
                                checked>


                            <div class="ai-source-icon bg-warning bg-opacity-10 text-warning">

                                <i class="fas fa-project-diagram"></i>

                            </div>


                            <div class="flex-grow-1">

                                <div class="ai-source-title">

                                    Vector Database

                                </div>

                                <div class="ai-source-description">

                                    Embeddings used for semantic
                                    document and knowledge retrieval.

                                </div>

                            </div>

                        </label>


                        <!-- DOCUMENT -->

                        <label class="ai-source-item">

                            <input
                                class="form-check-input mt-2"
                                type="checkbox"
                                id="ai_source_documents"
                                checked>


                            <div class="ai-source-icon bg-info bg-opacity-10 text-info">

                                <i class="fas fa-file-alt"></i>

                            </div>


                            <div class="flex-grow-1">

                                <div class="ai-source-title">

                                    Documents / OCR

                                </div>

                                <div class="ai-source-description">

                                    Deeds, letters, reports,
                                    scanned documents and OCR text.

                                </div>

                            </div>

                        </label>


                        <!-- KNOWLEDGE -->

                        <label class="ai-source-item">

                            <input
                                class="form-check-input mt-2"
                                type="checkbox"
                                id="ai_source_knowledge"
                                checked>


                            <div class="ai-source-icon bg-secondary bg-opacity-10 text-secondary">

                                <i class="fas fa-book"></i>

                            </div>


                            <div class="flex-grow-1">

                                <div class="ai-source-title">

                                    Knowledge Base

                                </div>

                                <div class="ai-source-description">

                                    Business rules, manuals,
                                    procedures and policies.

                                </div>

                            </div>

                        </label>

                    </div>

                </div>


                <!-- =============================================
                     QUERY OPTIONS
                     ============================================= -->

                <div class="ai-modern-card mb-3">

                    <div class="ai-modern-card-header">

                        <span class="fw-semibold">

                            <i class="fas fa-sliders-h me-2 text-primary"></i>

                            Query Options

                        </span>

                    </div>


                    <div class="ai-modern-card-body">


                        <div class="mb-3">

                            <label
                                for="ai_query_mode"
                                class="form-label small fw-semibold">

                                Query Mode

                            </label>


                            <select
                                id="ai_query_mode"
                                class="form-select form-select-sm">

                                <option
                                    value="auto"
                                    selected>

                                    Auto - AI Decides

                                </option>

                                <option value="hybrid">

                                    Hybrid Analysis

                                </option>

                                <option value="database">

                                    Transaction Database

                                </option>

                                <option value="spatial">

                                    Geospatial / PostGIS

                                </option>

                                <option value="rag">

                                    Documents / RAG

                                </option>

                                <option value="vector">

                                    Vector Search

                                </option>

                            </select>

                        </div>


                        <div class="mb-3">

                            <label
                                for="ai_result_limit"
                                class="form-label small fw-semibold">

                                Maximum Records

                            </label>


                            <select
                                id="ai_result_limit"
                                class="form-select form-select-sm">

                                <option value="10">

                                    10

                                </option>

                                <option
                                    value="25"
                                    selected>

                                    25

                                </option>

                                <option value="50">

                                    50

                                </option>

                                <option value="100">

                                    100

                                </option>

                            </select>

                        </div>


                        <div class="form-check">

                            <input
                                class="form-check-input"
                                type="checkbox"
                                id="ai_include_query_details"
                                checked>


                            <label
                                class="form-check-label small"
                                for="ai_include_query_details">

                                Show technical query details

                            </label>

                        </div>

                    </div>

                </div>


                <!-- =============================================
                     EXAMPLES
                     ============================================= -->

                <div class="ai-modern-card">

                    <div class="ai-modern-card-header">

                        <span class="fw-semibold">

                            <i class="fas fa-lightbulb me-2 text-warning"></i>

                            Suggested Questions

                        </span>

                    </div>


                    <div class="ai-modern-card-body">

                        <div class="d-grid gap-2">


                            <button
                                type="button"
                                class="btn btn-outline-secondary btn-sm ai-example-question"
                                data-question="Show all pending land registration applications older than 30 days">

                                Pending applications older than
                                30 days

                            </button>


                            <button
                                type="button"
                                class="btn btn-outline-secondary btn-sm ai-example-question"
                                data-question="Which applications are currently delayed and at what workflow stage?">

                                Find delayed applications and
                                workflow stages

                            </button>


                            <button
                                type="button"
                                class="btn btn-outline-secondary btn-sm ai-example-question"
                                data-question="Show parcels that overlap already registered parcels">

                                Find overlapping parcels

                            </button>


                            <button
                                type="button"
                                class="btn btn-outline-secondary btn-sm ai-example-question"
                                data-question="Who owns parcel GA-12345 and show all transactions and encumbrances affecting it">

                                Parcel ownership and
                                transaction history

                            </button>


                            <button
                                type="button"
                                class="btn btn-outline-secondary btn-sm ai-example-question"
                                data-question="Show the top 10 localities with the highest number of pending registrations">

                                Registration statistics by
                                locality

                            </button>


                            <button
                                type="button"
                                class="btn btn-outline-secondary btn-sm ai-example-question"
                                data-question="Search documents and explain common reasons applications are returned during quality control">

                                Analyse quality control
                                return reasons

                            </button>

                        </div>

                    </div>

                </div>

            </div>


            <!-- =================================================
                 MAIN AI AREA
                 ================================================= -->

            <div class="col-xl-9 col-lg-8">


                <!-- =============================================
                     CHAT
                     ============================================= -->

                <div class="ai-modern-card mb-4">

                    <div class="ai-chat-wrapper">


                        <!-- CHAT HEADER -->

                        <div class="ai-chat-header">

                            <div class="ai-chat-title">

                                <div class="ai-chat-title-icon">

                                    <i class="fas fa-robot"></i>

                                </div>


                                <div>

                                    <h5>

                                        ELIS AI Database Assistant

                                    </h5>

                                    <small>

                                        PostgreSQL + PostGIS +
                                        pgvector + RAG + LLM

                                    </small>

                                </div>

                            </div>


                            <div class="d-flex gap-2">


                                <button
                                    type="button"
                                    class="btn btn-sm btn-light"
                                    id="ai_btn_export_chat">

                                    <i class="fas fa-download me-1"></i>

                                    Export

                                </button>


                                <button
                                    type="button"
                                    class="btn btn-sm btn-light"
                                    id="ai_btn_clear_chat">

                                    <i class="fas fa-trash me-1"></i>

                                    Clear

                                </button>

                            </div>

                        </div>


                        <!-- CHAT MESSAGES -->

                        <div
                            class="ai-chat-messages"
                            id="ai_chat_messages">


                            <div class="ai-chat-message assistant">

                                <div class="ai-chat-avatar">

                                    AI

                                </div>


                                <div class="ai-chat-message-content">

                                    Hello. I can help you query ELIS
                                    information using natural language.

                                    <br><br>

                                    I can combine:

                                    <ul class="mb-1">

                                        <li>
                                            transactional database records;
                                        </li>

                                        <li>
                                            PostGIS parcel and spatial data;
                                        </li>

                                        <li>
                                            vector database searches;
                                        </li>

                                        <li>
                                            OCR and document content; and
                                        </li>

                                        <li>
                                            AI reasoning over the retrieved
                                            information.
                                        </li>

                                    </ul>

                                    Try asking:

                                    <strong>
                                        "Show pending applications older
                                        than 30 days and group them by
                                        workflow stage."
                                    </strong>


                                    <span class="ai-message-time">

                                        Just now

                                    </span>

                                </div>

                            </div>


                            <!-- TYPING INDICATOR -->

                            <div
                                class="ai-typing-indicator"
                                id="ai_typing_indicator">

                                <div class="ai-chat-avatar">

                                    AI

                                </div>


                                <div class="ai-typing-dots">

                                    <span></span>

                                    <span></span>

                                    <span></span>

                                </div>

                            </div>

                        </div>


                        <!-- CHAT INPUT -->

                        <div class="ai-chat-input-area">

                            <form
                                id="ai_chat_form"
                                autocomplete="off">


                                <div class="ai-chat-input-wrapper">


                                    <textarea
                                        id="ai_user_input"
                                        rows="1"
                                        placeholder="Ask a question about applications, parcels, ownership, workflows, documents, transactions or spatial data..."
                                        required></textarea>


                                    <button
                                        type="submit"
                                        class="ai-send-btn"
                                        id="ai_send_btn">

                                        <span class="ai-send-text">

                                            <i class="fas fa-paper-plane me-1"></i>

                                            Send

                                        </span>


                                        <span class="ai-send-spinner"></span>

                                    </button>

                                </div>


                                <div class="d-flex justify-content-between flex-wrap gap-2 mt-2">

                                    <small class="text-muted">

                                        <i class="fas fa-info-circle me-1"></i>

                                        Enter to send ·
                                        Shift + Enter for a new line

                                    </small>


                                    <small class="text-muted">

                                        <i class="fas fa-shield-alt me-1"></i>

                                        AI access follows your ELIS permissions

                                    </small>

                                </div>

                            </form>

                        </div>

                    </div>

                </div>


                <!-- =============================================
                     RESULT CARD
                     ============================================= -->

                <div class="ai-modern-card">


                    <div class="ai-modern-card-header">

                        <div>

                            <span class="fw-semibold">

                                <i class="fas fa-chart-bar me-2 text-primary"></i>

                                AI Analysis Results

                            </span>

                        </div>


                        <div id="ai_route_display">

                            <span class="text-muted small">

                                No query executed

                            </span>

                        </div>

                    </div>


                    <div class="ai-modern-card-body">


                        <!-- =========================================
                             SUMMARY STATS
                             ========================================= -->

                        <div
                            class="row g-2 mb-3"
                            id="ai_stats_row">


                            <div class="col-lg-3 col-6">

                                <div class="ai-stat-box">

                                    <div class="ai-stat-label">

                                        Records

                                    </div>

                                    <div
                                        class="ai-stat-value"
                                        id="ai_stat_records">

                                        0

                                    </div>

                                </div>

                            </div>


                            <div class="col-lg-3 col-6">

                                <div class="ai-stat-box">

                                    <div class="ai-stat-label">

                                        Documents

                                    </div>

                                    <div
                                        class="ai-stat-value"
                                        id="ai_stat_documents">

                                        0

                                    </div>

                                </div>

                            </div>


                            <div class="col-lg-3 col-6">

                                <div class="ai-stat-box">

                                    <div class="ai-stat-label">

                                        Parcels

                                    </div>

                                    <div
                                        class="ai-stat-value"
                                        id="ai_stat_parcels">

                                        0

                                    </div>

                                </div>

                            </div>


                            <div class="col-lg-3 col-6">

                                <div class="ai-stat-box">

                                    <div class="ai-stat-label">

                                        Confidence

                                    </div>

                                    <div
                                        class="ai-stat-value text-success"
                                        id="ai_stat_confidence">

                                        --

                                    </div>

                                </div>

                            </div>

                        </div>


                        <!-- =========================================
                             TABS
                             ========================================= -->

                        <ul
                            class="nav nav-tabs ai-result-tabs"
                            id="ai_result_tabs"
                            role="tablist">


                            <li class="nav-item">

                                <button
                                    class="nav-link active"
                                    id="ai_answer_tab"
                                    data-bs-toggle="tab"
                                    data-bs-target="#ai_answer_pane"
                                    type="button">

                                    <i class="fas fa-comment-alt me-1"></i>

                                    Answer

                                </button>

                            </li>


                            <li class="nav-item">

                                <button
                                    class="nav-link"
                                    id="ai_records_tab"
                                    data-bs-toggle="tab"
                                    data-bs-target="#ai_records_pane"
                                    type="button">

                                    <i class="fas fa-table me-1"></i>

                                    Records

                                </button>

                            </li>


                            <li class="nav-item">

                                <button
                                    class="nav-link"
                                    id="ai_map_tab"
                                    data-bs-toggle="tab"
                                    data-bs-target="#ai_map_pane"
                                    type="button">

                                    <i class="fas fa-map me-1"></i>

                                    Map

                                </button>

                            </li>


                            <li class="nav-item">

                                <button
                                    class="nav-link"
                                    id="ai_evidence_tab"
                                    data-bs-toggle="tab"
                                    data-bs-target="#ai_evidence_pane"
                                    type="button">

                                    <i class="fas fa-file-alt me-1"></i>

                                    Evidence

                                </button>

                            </li>


                            <li class="nav-item">

                                <button
                                    class="nav-link"
                                    id="ai_query_tab"
                                    data-bs-toggle="tab"
                                    data-bs-target="#ai_query_pane"
                                    type="button">

                                    <i class="fas fa-code me-1"></i>

                                    Query Details

                                </button>

                            </li>

                        </ul>


                        <div
                            class="tab-content pt-3"
                            id="ai_result_tab_content">


                            <!-- =====================================
                                 ANSWER
                                 ===================================== -->

                            <div
                                class="tab-pane fade show active"
                                id="ai_answer_pane">


                                <div
                                    id="ai_answer_empty"
                                    class="ai-empty-result">

                                    <i class="fas fa-robot"></i>

                                    Ask the assistant a question to
                                    begin analysis.

                                </div>


                                <div
                                    id="ai_answer_content"
                                    class="d-none">


                                    <div
                                        class="alert alert-primary border-0 mb-0"
                                        id="ai_answer_text">
                                    </div>

                                </div>

                            </div>


                            <!-- =====================================
                                 RECORDS
                                 ===================================== -->

                            <div
                                class="tab-pane fade"
                                id="ai_records_pane">


                                <div
                                    id="ai_records_empty"
                                    class="ai-empty-result">

                                    <i class="fas fa-table"></i>

                                    Database records returned by
                                    the AI query will appear here.

                                </div>


                                <div
                                    id="ai_records_content"
                                    class="d-none">


                                    <div class="table-responsive">

                                        <table
                                            class="table table-sm table-hover table-bordered ai-result-table"
                                            id="ai_result_table">


                                            <thead class="table-light">

                                                <tr
                                                    id="ai_result_table_header">
                                                </tr>

                                            </thead>


                                            <tbody
                                                id="ai_result_table_body">
                                            </tbody>

                                        </table>

                                    </div>

                                </div>

                            </div>


                            <!-- =====================================
                                 MAP
                                 ===================================== -->

                            <div
                                class="tab-pane fade"
                                id="ai_map_pane">


                                <div
                                    id="ai_database_map">
                                </div>


                                <div class="d-flex justify-content-between flex-wrap gap-2 mt-2">

                                    <small class="text-muted">

                                        <i class="fas fa-map-marker-alt me-1"></i>

                                        AI spatial results are displayed
                                        here when GeoJSON or WKT is returned.

                                    </small>


                                    <button
                                        type="button"
                                        class="btn btn-sm btn-outline-danger"
                                        id="ai_btn_clear_map">

                                        <i class="fas fa-eraser me-1"></i>

                                        Clear AI Layer

                                    </button>

                                </div>

                            </div>


                            <!-- =====================================
                                 EVIDENCE
                                 ===================================== -->

                            <div
                                class="tab-pane fade"
                                id="ai_evidence_pane">


                                <div
                                    id="ai_evidence_empty"
                                    class="ai-empty-result">

                                    <i class="fas fa-file-search"></i>

                                    Supporting documents, vector
                                    matches and references will
                                    appear here.

                                </div>


                                <div
                                    id="ai_evidence_list"
                                    class="d-none">
                                </div>

                            </div>


                            <!-- =====================================
                                 QUERY DETAILS
                                 ===================================== -->

                            <div
                                class="tab-pane fade"
                                id="ai_query_pane">


                                <div class="mb-3">

                                    <label class="form-label fw-semibold">

                                        Query Route

                                    </label>


                                    <div
                                        id="ai_query_route_details"
                                        class="border rounded p-2 bg-light">

                                        No query executed.

                                    </div>

                                </div>


                                <div class="mb-3">

                                    <label class="form-label fw-semibold">

                                        Generated SQL

                                    </label>


                                    <pre
                                        id="ai_generated_sql"
                                        class="ai-query-code">No SQL generated.</pre>

                                </div>


                                <div class="mb-3">

                                    <label class="form-label fw-semibold">

                                        Spatial / PostGIS Query

                                    </label>


                                    <pre
                                        id="ai_generated_spatial"
                                        class="ai-query-code">No spatial query generated.</pre>

                                </div>


                                <div>

                                    <label class="form-label fw-semibold">

                                        Vector Search

                                    </label>


                                    <pre
                                        id="ai_generated_vector"
                                        class="ai-query-code">No vector search performed.</pre>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>


<script>

document.addEventListener(
    "DOMContentLoaded",
    function () {

        "use strict";


        /* =====================================================
           ELEMENTS
           ===================================================== */

        const chatForm =
            document.getElementById(
                "ai_chat_form"
            );


        const userInput =
            document.getElementById(
                "ai_user_input"
            );


        const sendBtn =
            document.getElementById(
                "ai_send_btn"
            );


        const chatMessages =
            document.getElementById(
                "ai_chat_messages"
            );


        const typingIndicator =
            document.getElementById(
                "ai_typing_indicator"
            );


        /* =====================================================
           OPENLAYERS VARIABLES
           ===================================================== */

        let aiDatabaseMap = null;

        let aiResultVectorSource = null;

        let aiResultVectorLayer = null;


        /* =====================================================
           TEXTAREA AUTO RESIZE
           ===================================================== */

        if (userInput) {

            userInput.addEventListener(
                "input",
                function () {

                    this.style.height =
                        "auto";


                    this.style.height =
                        Math.min(
                            this.scrollHeight,
                            130
                        ) + "px";

                }
            );


            userInput.addEventListener(
                "keydown",
                function (event) {

                    if (
                        event.key === "Enter" &&
                        !event.shiftKey
                    ) {

                        event.preventDefault();


                        if (
                            this.value.trim() !== ""
                        ) {

                            chatForm.dispatchEvent(
                                new Event(
                                    "submit"
                                )
                            );

                        }

                    }

                }
            );

        }


        /* =====================================================
           HTML ESCAPE
           ===================================================== */

        function escapeHtml(value) {

            return String(
                value == null
                    ? ""
                    : value
            )
            .replace(
                /&/g,
                "&amp;"
            )
            .replace(
                /</g,
                "&lt;"
            )
            .replace(
                />/g,
                "&gt;"
            )
            .replace(
                /"/g,
                "&quot;"
            )
            .replace(
                /'/g,
                "&#039;"
            );

        }


        /* =====================================================
           FORMAT AI TEXT
           ===================================================== */

        function formatMessageText(value) {

            if (
                value == null
            ) {

                return "";

            }


            let text =
                escapeHtml(
                    value
                );


            text =
                text.replace(
                    /\n/g,
                    "<br>"
                );


            return text;

        }


        /* =====================================================
           CHAT MESSAGE
           ===================================================== */

        function addMessage(
            role,
            content
        ) {

            const messageDiv =
                document.createElement(
                    "div"
                );


            messageDiv.className =
                "ai-chat-message " +
                role;


            const avatar =
                document.createElement(
                    "div"
                );


            avatar.className =
                "ai-chat-avatar";


            avatar.textContent =
                role === "user"
                    ? "YOU"
                    : "AI";


            const contentDiv =
                document.createElement(
                    "div"
                );


            contentDiv.className =
                "ai-chat-message-content";


            contentDiv.innerHTML =
                formatMessageText(
                    content
                );


            const timestamp =
                document.createElement(
                    "span"
                );


            timestamp.className =
                "ai-message-time";


            timestamp.textContent =
                new Date()
                    .toLocaleTimeString(
                        [],
                        {
                            hour:
                                "2-digit",

                            minute:
                                "2-digit"
                        }
                    );


            contentDiv.appendChild(
                timestamp
            );


            messageDiv.appendChild(
                avatar
            );


            messageDiv.appendChild(
                contentDiv
            );


            chatMessages.insertBefore(
                messageDiv,
                typingIndicator
            );


            chatMessages.scrollTop =
                chatMessages.scrollHeight;

        }


        /* =====================================================
           LOADING STATE
           ===================================================== */

        function setAiLoading(
            loading
        ) {

            if (loading) {

                typingIndicator.classList.add(
                    "active"
                );


                sendBtn.classList.add(
                    "loading"
                );


                sendBtn.disabled =
                    true;

            } else {

                typingIndicator.classList.remove(
                    "active"
                );


                sendBtn.classList.remove(
                    "loading"
                );


                sendBtn.disabled =
                    false;

            }


            chatMessages.scrollTop =
                chatMessages.scrollHeight;

        }


        /* =====================================================
           NORMALISE RESPONSE

           Supports:
           1. JSON already returned by jQuery
           2. JSON string
           3. plain text
           ===================================================== */

        function normaliseResponse(
            response
        ) {

            if (
                response == null
            ) {

                return {
                    success: false,
                    message:
                        "Empty response received."
                };

            }


            if (
                typeof response ===
                "object"
            ) {

                return response;

            }


            if (
                typeof response ===
                "string"
            ) {

                try {

                    return JSON.parse(
                        response
                    );

                } catch (error) {

                    return {

                        success: true,

                        message:
                            response

                    };

                }

            }


            return {

                success: true,

                message:
                    String(
                        response
                    )

            };

        }


        /* =====================================================
           EXTRACT ANSWER

           Handles different backend response formats.
           ===================================================== */

        function getAiAnswer(
            result
        ) {

            if (
                result.answer
            ) {

                return result.answer;

            }


            if (
                result.message &&
                typeof result.message ===
                    "string"
            ) {

                return result.message;

            }


            if (
                result.data
            ) {

                if (
                    typeof result.data ===
                        "string"
                ) {

                    return result.data;

                }


                if (
                    result.data.answer
                ) {

                    return result.data.answer;

                }


                if (
                    result.data.message
                ) {

                    return result.data.message;

                }

            }


            return "The AI query completed successfully.";

        }


        /* =====================================================
           RESULT DATA

           Some APIs may return data directly.
           Others may put everything under result.data.
           ===================================================== */

        function getResultPayload(
            result
        ) {

            if (
                result.data &&
                typeof result.data ===
                    "object" &&
                !Array.isArray(
                    result.data
                )
            ) {

                return Object.assign(
                    {},
                    result,
                    result.data
                );

            }


            return result;

        }


        /* =====================================================
           RECORD TABLE
           ===================================================== */

        function renderRecords(
            records
        ) {

            const empty =
                document.getElementById(
                    "ai_records_empty"
                );


            const content =
                document.getElementById(
                    "ai_records_content"
                );


            const header =
                document.getElementById(
                    "ai_result_table_header"
                );


            const body =
                document.getElementById(
                    "ai_result_table_body"
                );


            header.innerHTML = "";

            body.innerHTML = "";


            if (
                !Array.isArray(
                    records
                ) ||
                records.length === 0
            ) {

                empty.classList.remove(
                    "d-none"
                );


                content.classList.add(
                    "d-none"
                );


                return;

            }


            empty.classList.add(
                "d-none"
            );


            content.classList.remove(
                "d-none"
            );


            const columnSet =
                new Set();


            records.forEach(
                function (
                    record
                ) {

                    if (
                        record &&
                        typeof record ===
                            "object"
                    ) {

                        Object
                            .keys(
                                record
                            )
                            .forEach(
                                function (
                                    key
                                ) {

                                    /*
                                     * Exclude very large geometry
                                     * objects from the table.
                                     */
                                    if (
                                        key.toLowerCase() !==
                                            "geometry" &&
                                        key.toLowerCase() !==
                                            "geojson"
                                    ) {

                                        columnSet.add(
                                            key
                                        );

                                    }

                                }
                            );

                    }

                }
            );


            const columns =
                Array.from(
                    columnSet
                );


            columns.forEach(
                function (
                    column
                ) {

                    const th =
                        document.createElement(
                            "th"
                        );


                    th.textContent =
                        column;


                    header.appendChild(
                        th
                    );

                }
            );


            records.forEach(
                function (
                    record
                ) {

                    const tr =
                        document.createElement(
                            "tr"
                        );


                    columns.forEach(
                        function (
                            column
                        ) {

                            const td =
                                document.createElement(
                                    "td"
                                );


                            let value =
                                record[
                                    column
                                ];


                            if (
                                value != null &&
                                typeof value ===
                                    "object"
                            ) {

                                try {

                                    value =
                                        JSON.stringify(
                                            value
                                        );

                                } catch (
                                    ignored
                                ) {

                                    value =
                                        String(
                                            value
                                        );

                                }

                            }


                            td.textContent =
                                value == null
                                    ? ""
                                    : value;


                            tr.appendChild(
                                td
                            );

                        }
                    );


                    body.appendChild(
                        tr
                    );

                }
            );

        }


        /* =====================================================
           EVIDENCE
           ===================================================== */

        function renderEvidence(
            evidence
        ) {

            const empty =
                document.getElementById(
                    "ai_evidence_empty"
                );


            const container =
                document.getElementById(
                    "ai_evidence_list"
                );


            container.innerHTML = "";


            if (
                !Array.isArray(
                    evidence
                ) ||
                evidence.length === 0
            ) {

                empty.classList.remove(
                    "d-none"
                );


                container.classList.add(
                    "d-none"
                );


                return;

            }


            empty.classList.add(
                "d-none"
            );


            container.classList.remove(
                "d-none"
            );


            evidence.forEach(
                function (
                    item,
                    index
                ) {

                    if (
                        typeof item ===
                            "string"
                    ) {

                        item = {

                            text:
                                item

                        };

                    }


                    const div =
                        document.createElement(
                            "div"
                        );


                    div.className =
                        "ai-evidence-item";


                    const title =
                        item.title ||
                        item.document_name ||
                        item.source ||
                        (
                            "Evidence " +
                            (
                                index + 1
                            )
                        );


                    const type =
                        item.type ||
                        item.source_type ||
                        "Source";


                    const text =
                        item.text ||
                        item.content ||
                        item.chunk ||
                        item.summary ||
                        "";


                    let scoreHtml =
                        "";


                    if (
                        item.score != null
                    ) {

                        let score =
                            Number(
                                item.score
                            );


                        if (
                            score <= 1
                        ) {

                            score =
                                score * 100;

                        }


                        scoreHtml =

                            '<span class="ai-evidence-score">' +

                            escapeHtml(
                                score.toFixed(
                                    1
                                )
                            ) +

                            '% match</span>';

                    }


                    div.innerHTML =

                        '<div class="d-flex justify-content-between align-items-start gap-2 mb-2">' +

                            '<div>' +

                                '<div class="fw-semibold">' +

                                    escapeHtml(
                                        title
                                    ) +

                                '</div>' +

                                '<small class="text-muted">' +

                                    escapeHtml(
                                        type
                                    ) +

                                '</small>' +

                            '</div>' +

                            scoreHtml +

                        '</div>' +

                        '<div class="small text-muted">' +

                            formatMessageText(
                                text
                            ) +

                        '</div>';


                    container.appendChild(
                        div
                    );

                }
            );

        }


        /* =====================================================
           QUERY ROUTE
           ===================================================== */

        function renderRoute(
            route
        ) {

            const headerDisplay =
                document.getElementById(
                    "ai_route_display"
                );


            const details =
                document.getElementById(
                    "ai_query_route_details"
                );


            let routes =
                [];


            if (
                Array.isArray(
                    route
                )
            ) {

                routes =
                    route;

            } else if (
                typeof route ===
                    "string" &&
                route.trim() !== ""
            ) {

                routes =
                    route
                        .split(
                            /[,>|→]+/
                        )
                        .map(
                            function (
                                item
                            ) {

                                return item.trim();

                            }
                        )
                        .filter(
                            Boolean
                        );

            }


            if (
                routes.length === 0
            ) {

                headerDisplay.innerHTML =
                    '<span class="text-muted small">No route information</span>';


                details.textContent =
                    "No route information returned.";


                return;

            }


            let html =
                "";


            routes.forEach(
                function (
                    item
                ) {

                    html +=

                        '<span class="ai-route-chip">' +

                            escapeHtml(
                                item
                            ) +

                        '</span>';

                }
            );


            headerDisplay.innerHTML =
                html;


            details.textContent =
                routes.join(
                    " → "
                );

        }


        /* =====================================================
           STATS
           ===================================================== */

        function renderStats(
            payload
        ) {

            const records =
                Array.isArray(
                    payload.records
                )
                    ? payload.records.length
                    : (
                        payload.recordCount ||
                        payload.record_count ||
                        0
                    );


            const documents =
                Array.isArray(
                    payload.evidence
                )
                    ? payload.evidence.length
                    : (
                        payload.documentCount ||
                        payload.document_count ||
                        0
                    );


            const parcels =
                payload.parcelCount ||
                payload.parcel_count ||
                0;


            document
                .getElementById(
                    "ai_stat_records"
                )
                .textContent =
                records;


            document
                .getElementById(
                    "ai_stat_documents"
                )
                .textContent =
                documents;


            document
                .getElementById(
                    "ai_stat_parcels"
                )
                .textContent =
                parcels;


            let confidence =
                payload.confidence;


            if (
                confidence == null
            ) {

                document
                    .getElementById(
                        "ai_stat_confidence"
                    )
                    .textContent =
                    "--";


                return;

            }


            confidence =
                Number(
                    confidence
                );


            if (
                confidence <= 1
            ) {

                confidence =
                    confidence * 100;

            }


            document
                .getElementById(
                    "ai_stat_confidence"
                )
                .textContent =
                confidence.toFixed(
                    0
                ) + "%";

        }


        /* =====================================================
           QUERY DETAILS
           ===================================================== */

        function renderQueryDetails(
            payload
        ) {

            document
                .getElementById(
                    "ai_generated_sql"
                )
                .textContent =

                payload.sql ||
                payload.generatedSql ||
                payload.generated_sql ||
                "No SQL generated.";


            document
                .getElementById(
                    "ai_generated_spatial"
                )
                .textContent =

                payload.spatialQuery ||
                payload.spatial_query ||
                payload.postgisQuery ||
                payload.postgis_query ||
                "No spatial query generated.";


            document
                .getElementById(
                    "ai_generated_vector"
                )
                .textContent =

                payload.vectorQuery ||
                payload.vector_query ||
                payload.vectorSearch ||
                payload.vector_search ||
                "No vector search performed.";


            renderRoute(
                payload.route ||
                payload.queryRoute ||
                payload.query_route ||
                []
            );

        }


        /* =====================================================
           OPENLAYERS MAP
           ===================================================== */

        function initialiseAiMap() {

            if (
                typeof ol ===
                    "undefined"
            ) {

                console.warn(
                    "OpenLayers is not loaded."
                );


                return;

            }


            if (
                aiDatabaseMap
            ) {

                return;

            }


            try {

                /*
                 * Accra / Ghana National Grid projection
                 */
                if (
                    typeof proj4 !==
                        "undefined"
                ) {

                    proj4.defs(

                        "EPSG:2136",

                        "+proj=tmerc " +
                        "+lat_0=4.666666666666667 " +
                        "+lon_0=-1 " +
                        "+k=0.99975 " +
                        "+x_0=274319.7391633579 " +
                        "+y_0=0 " +
                        "+a=6378300 " +
                        "+b=6356751.689189189 " +
                        "+towgs84=-199,32,322,0,0,0,0 " +
                        "+to_meter=0.3047997101815088 " +
                        "+no_defs"

                    );


                    if (
                        typeof ol.proj.setProj4 ===
                            "function"
                    ) {

                        ol.proj.setProj4(
                            proj4
                        );

                    }

                }


                const projObj =
                    new ol.proj.Projection({

                        code:
                            "EPSG:2136",

                        extent: [

                            80935.4497355444,

                            1209.0295731349593,

                            1711780.3060929566,

                            2358523.124783509

                        ],

                        units:
                            "ft",

                        axisOrientation:
                            "enu",

                        global:
                            false,

                        worldExtent: [

                            -3.79,

                            1.4,

                            2.1,

                            11.16

                        ],

                        getPointResolution:
                            function (
                                resolution
                            ) {

                                return resolution;

                            }

                    });


                /* =============================================
                   BASE MAP
                   ============================================= */

                const osmLayer =
                    new ol.layer.Tile({

                        title:
                            "OpenStreetMap",

                        source:
                            new ol.source.OSM()

                    });


                /* =============================================
                   GOOGLE SATELLITE
                   ============================================= */

                const googleLayerHybrid =
                    new ol.layer.Tile({

                        title:
                            "Google Satellite & Roads",

                        visible:
                            false,

                        source:
                            new ol.source.XYZ({

                                url:
                                    "https://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga"

                            })

                    });


                /* =============================================
                   GEOSERVER LAYERS
                   ============================================= */

                let parcelLayer =
                    null;


                let districtLayer =
                    null;


                let gridLayer =
                    null;


                if (
                    typeof getGeoServerEndPoint ===
                        "function"
                ) {

                    parcelLayer =
                        new ol.layer.Tile({

                            title:
                                "LRD Parcels",

                            source:
                                new ol.source.TileWMS({

                                    url:
                                        getGeoServerEndPoint() +
                                        "/geoserver/csau_geospatial/wms",

                                    params: {

                                        "LAYERS":
                                            "csau_geospatial:lc_spatial_objects",

                                        "TILED":
                                            true

                                    },

                                    serverType:
                                        "geoserver",

                                    transition:
                                        0

                                })

                        });


                    districtLayer =
                        new ol.layer.Tile({

                            title:
                                "Registration District",

                            visible:
                                false,

                            source:
                                new ol.source.TileWMS({

                                    url:
                                        getGeoServerEndPoint() +
                                        "/geoserver/csau_geospatial/wms",

                                    params: {

                                        "LAYERS":
                                            "csau_geospatial:district",

                                        "TILED":
                                            true

                                    },

                                    serverType:
                                        "geoserver",

                                    transition:
                                        0

                                })

                        });


                    gridLayer =
                        new ol.layer.Tile({

                            title:
                                "Grid",

                            visible:
                                false,

                            source:
                                new ol.source.TileWMS({

                                    url:
                                        getGeoServerEndPoint() +
                                        "/geoserver/csau_geospatial/wms",

                                    params: {

                                        "LAYERS":
                                            "csau_geospatial:gng_grid",

                                        "TILED":
                                            true

                                    },

                                    serverType:
                                        "geoserver",

                                    transition:
                                        0

                                })

                        });

                }


                /* =============================================
                   AI RESULT VECTOR
                   ============================================= */

                aiResultVectorSource =
                    new ol.source.Vector();


                aiResultVectorLayer =
                    new ol.layer.Vector({

                        title:
                            "AI Query Result",

                        source:
                            aiResultVectorSource,

                        style:
                            new ol.style.Style({

                                stroke:
                                    new ol.style.Stroke({

                                        color:
                                            "#EF4444",

                                        width:
                                            3

                                    }),

                                fill:
                                    new ol.style.Fill({

                                        color:
                                            "rgba(239,68,68,0.18)"

                                    }),

                                image:
                                    new ol.style.Circle({

                                        radius:
                                            7,

                                        fill:
                                            new ol.style.Fill({

                                                color:
                                                    "#EF4444"

                                            }),

                                        stroke:
                                            new ol.style.Stroke({

                                                color:
                                                    "#ffffff",

                                                width:
                                                    2

                                            })

                                    })

                            })

                    });


                const layers =
                    [
                        osmLayer
                    ];


                layers.push(
                    googleLayerHybrid
                );


                if (
                    districtLayer
                ) {

                    layers.push(
                        districtLayer
                    );

                }


                if (
                    gridLayer
                ) {

                    layers.push(
                        gridLayer
                    );

                }


                if (
                    parcelLayer
                ) {

                    layers.push(
                        parcelLayer
                    );

                }


                layers.push(
                    aiResultVectorLayer
                );


                let controls =
                    ol.control.defaults();


                if (
                    ol.control.LayerSwitcher
                ) {

                    controls =
                        controls.extend(
                            [
                                new ol.control.LayerSwitcher()
                            ]
                        );

                }


                aiDatabaseMap =
                    new ol.Map({

                        target:
                            "ai_database_map",

                        controls:
                            controls,

                        renderer:
                            "canvas",

                        layers:
                            layers,

                        view:
                            new ol.View({

                                projection:
                                    projObj,

                                extent:
                                    ol.proj
                                        .get(
                                            "EPSG:2136"
                                        )
                                        .getExtent(),

                                center: [

                                    1187433.58822084,

                                    327091.107070208

                                ],

                                zoom:
                                    8

                            })

                    });


                /*
                 * Tab may initially be hidden.
                 */
                const mapTab =
                    document.getElementById(
                        "ai_map_tab"
                    );


                if (
                    mapTab
                ) {

                    mapTab.addEventListener(
                        "shown.bs.tab",
                        function () {

                            if (
                                aiDatabaseMap
                            ) {

                                window.setTimeout(
                                    function () {

                                        aiDatabaseMap.updateSize();

                                    },
                                    100
                                );

                            }

                        }
                    );

                }

            } catch (
                error
            ) {

                console.error(
                    "Unable to initialise AI map:",
                    error
                );

            }

        }


        /* =====================================================
           CLEAR MAP
           ===================================================== */

        function clearAiMap() {

            if (
                aiResultVectorSource
            ) {

                aiResultVectorSource.clear();

            }

        }


        /* =====================================================
           ADD GEOJSON
           ===================================================== */

        function renderGeoJson(
            geojson,
            projection
        ) {

            if (
                !geojson ||
                !aiResultVectorSource
            ) {

                return;

            }


            try {

                let geojsonObject =
                    geojson;


                if (
                    typeof geojson ===
                        "string"
                ) {

                    geojsonObject =
                        JSON.parse(
                            geojson
                        );

                }


                const sourceProjection =
                    projection ||
                    "EPSG:2136";


                const features =
                    new ol.format.GeoJSON()
                        .readFeatures(
                            geojsonObject,
                            {

                                dataProjection:
                                    sourceProjection,

                                featureProjection:
                                    "EPSG:2136"

                            }
                        );


                if (
                    features.length === 0
                ) {

                    return;

                }


                aiResultVectorSource.addFeatures(
                    features
                );


                zoomToAiFeatures();

            } catch (
                error
            ) {

                console.error(
                    "Unable to render GeoJSON:",
                    error
                );

            }

        }


        /* =====================================================
           ADD WKT
           ===================================================== */

        function renderWkt(
            wkt
        ) {

            if (
                !wkt ||
                !aiResultVectorSource
            ) {

                return;

            }


            try {

                const features =
                    new ol.format.WKT()
                        .readFeatures(
                            wkt
                        );


                aiResultVectorSource.addFeatures(
                    features
                );


                zoomToAiFeatures();

            } catch (
                error
            ) {

                console.error(
                    "Unable to render WKT:",
                    error
                );

            }

        }


        function zoomToAiFeatures() {

            if (
                !aiDatabaseMap ||
                !aiResultVectorSource
            ) {

                return;

            }


            const extent =
                aiResultVectorSource
                    .getExtent();


            if (
                !extent ||
                !isFinite(
                    extent[0]
                )
            ) {

                return;

            }


            aiDatabaseMap.updateSize();


            aiDatabaseMap
                .getView()
                .fit(
                    extent,
                    {

                        size:
                            aiDatabaseMap.getSize(),

                        padding: [

                            50,

                            50,

                            50,

                            50

                        ],

                        maxZoom:
                            17,

                        duration:
                            500

                    }
                );

        }


        /* =====================================================
           MAP RESPONSE
           ===================================================== */

        function renderSpatialResult(
            payload
        ) {

            clearAiMap();


            const geojson =

                payload.geojson ||

                payload.geoJson ||

                payload.geometry_geojson ||

                payload.spatialGeojson;


            const wkt =

                payload.wkt ||

                payload.geometry_wkt ||

                payload.spatialWkt;


            const projection =

                payload.geojsonProjection ||

                payload.geojson_projection ||

                payload.projection ||

                "EPSG:2136";


            if (
                geojson
            ) {

                renderGeoJson(
                    geojson,
                    projection
                );

            }


            if (
                wkt
            ) {

                renderWkt(
                    wkt
                );

            }

        }


        /* =====================================================
           COMPLETE RESPONSE RENDERER
           ===================================================== */

        function renderAiResult(
            result
        ) {

            const payload =
                getResultPayload(
                    result
                );


            const answer =
                getAiAnswer(
                    result
                );


            /* CHAT */

            addMessage(
                "assistant",
                answer
            );


            /* ANSWER TAB */

            document
                .getElementById(
                    "ai_answer_empty"
                )
                .classList
                .add(
                    "d-none"
                );


            document
                .getElementById(
                    "ai_answer_content"
                )
                .classList
                .remove(
                    "d-none"
                );


            document
                .getElementById(
                    "ai_answer_text"
                )
                .innerHTML =
                formatMessageText(
                    answer
                );


            /* RECORDS */

            renderRecords(
                payload.records ||
                payload.rows ||
                payload.results ||
                []
            );


            /* EVIDENCE */

            renderEvidence(
                payload.evidence ||
                payload.sources ||
                payload.documents ||
                []
            );


            /* QUERY DETAILS */

            renderQueryDetails(
                payload
            );


            /* STATS */

            renderStats(
                payload
            );


            /* MAP */

            renderSpatialResult(
                payload
            );

        }


        /* =====================================================
           AJAX CHAT SUBMIT

           Uses your existing ai_serv implementation.
           ===================================================== */

        if (
            chatForm
        ) {

            chatForm.addEventListener(
                "submit",
                function (
                    event
                ) {

                    event.preventDefault();


                    const message =
                        userInput
                            .value
                            .trim();


                    if (
                        !message
                    ) {

                        return;

                    }


                    addMessage(
                        "user",
                        message
                    );


                    userInput.value =
                        "";


                    userInput.style.height =
                        "auto";


                    setAiLoading(
                        true
                    );


                    /* =========================================
                       SOURCE OPTIONS
                       ========================================= */

                    const useTransaction =
                        document
                            .getElementById(
                                "ai_source_transaction"
                            )
                            .checked;


                    const useSpatial =
                        document
                            .getElementById(
                                "ai_source_spatial"
                            )
                            .checked;


                    const useVector =
                        document
                            .getElementById(
                                "ai_source_vector"
                            )
                            .checked;


                    const useDocuments =
                        document
                            .getElementById(
                                "ai_source_documents"
                            )
                            .checked;


                    const useKnowledge =
                        document
                            .getElementById(
                                "ai_source_knowledge"
                            )
                            .checked;


                    const queryMode =
                        document
                            .getElementById(
                                "ai_query_mode"
                            )
                            .value;


                    const resultLimit =
                        document
                            .getElementById(
                                "ai_result_limit"
                            )
                            .value;


                    const includeQueryDetails =
                        document
                            .getElementById(
                                "ai_include_query_details"
                            )
                            .checked;


                    /*
                     * Existing backend:
                     *
                     * request_type = chat_with_agent
                     *
                     * Additional fields below can be ignored
                     * by the old implementation until the
                     * servlet is enhanced.
                     */

                    $.ajax({

                        type:
                            "POST",

                        url:
                            "ai_serv",

                        data: {

                            request_type:
                                "chat_with_agent",

                            chat_message:
                                message,

                            /*
                             * Tell the agent this request
                             * is not tied to one application.
                             */
                            ai_context:
                                "database_assistant",

                            /*
                             * Query mode
                             */
                            query_mode:
                                queryMode,

                            result_limit:
                                resultLimit,

                            /*
                             * Sources
                             */
                            use_transaction_database:
                                useTransaction,

                            use_spatial_database:
                                useSpatial,

                            use_vector_database:
                                useVector,

                            use_documents:
                                useDocuments,

                            use_knowledge_base:
                                useKnowledge,

                            include_query_details:
                                includeQueryDetails,

                            /*
                             * Optional context
                             */
                            current_region:
                                document
                                    .getElementById(
                                        "ai_current_region"
                                    )
                                    ?.value ||
                                "",

                            timestamp:
                                new Date()
                                    .toISOString()

                        },


                        success:
                            function (
                                response
                            ) {

                                setAiLoading(
                                    false
                                );


                                console.log(
                                    "AI database response:",
                                    response
                                );


                                const result =
                                    normaliseResponse(
                                        response
                                    );


                                if (
                                    result &&
                                    (
                                        result.success ===
                                            true ||
                                        typeof result.success ===
                                            "undefined"
                                    )
                                ) {

                                    renderAiResult(
                                        result
                                    );

                                } else {

                                    const message =

                                        result.message ||

                                        "The AI service was unable to process the query.";


                                    addMessage(
                                        "assistant",
                                        "❌ " +
                                        message
                                    );

                                }


                                userInput.focus();

                            },


                        error:
                            function (
                                xhr,
                                status,
                                error
                            ) {

                                setAiLoading(
                                    false
                                );


                                console.error(
                                    "AI request failed:",
                                    status,
                                    error
                                );


                                let errorMessage =

                                    "Sorry, I encountered an error while processing your database question.";


                                if (
                                    status ===
                                        "timeout"
                                ) {

                                    errorMessage =

                                        "The AI query timed out. The database query may be too complex. Please try a more specific question.";

                                } else if (
                                    xhr.status ===
                                        0
                                ) {

                                    errorMessage =

                                        "Network error. Please check your connection.";

                                } else if (
                                    xhr.status ===
                                        403
                                ) {

                                    errorMessage =

                                        "You do not have permission to perform this AI database query.";

                                } else if (
                                    xhr.status ===
                                        500
                                ) {

                                    errorMessage =

                                        "The AI/database service encountered a server error.";

                                } else if (
                                    xhr.responseText
                                ) {

                                    try {

                                        const errorResult =
                                            JSON.parse(
                                                xhr.responseText
                                            );


                                        if (
                                            errorResult.message
                                        ) {

                                            errorMessage =
                                                errorResult.message;

                                        }

                                    } catch (
                                        ignored
                                    ) {

                                        /*
                                         * Keep friendly message.
                                         */

                                    }

                                }


                                addMessage(
                                    "assistant",
                                    "❌ " +
                                    errorMessage
                                );


                                userInput.focus();

                            }

                    });

                }
            );

        }


        /* =====================================================
           EXAMPLE QUESTIONS
           ===================================================== */

        document
            .querySelectorAll(
                ".ai-example-question"
            )
            .forEach(
                function (
                    button
                ) {

                    button.addEventListener(
                        "click",
                        function () {

                            const question =
                                this.getAttribute(
                                    "data-question"
                                );


                            userInput.value =
                                question ||
                                "";


                            userInput.focus();


                            userInput.dispatchEvent(
                                new Event(
                                    "input"
                                )
                            );

                        }
                    );

                }
            );


        /* =====================================================
           CLEAR CHAT
           ===================================================== */

        const clearChatBtn =
            document.getElementById(
                "ai_btn_clear_chat"
            );


        if (
            clearChatBtn
        ) {

            clearChatBtn.addEventListener(
                "click",
                function () {

                    if (
                        !confirm(
                            "Clear the AI conversation?"
                        )
                    ) {

                        return;

                    }


                    chatMessages
                        .querySelectorAll(
                            ".ai-chat-message"
                        )
                        .forEach(
                            function (
                                element
                            ) {

                                element.remove();

                            }
                        );


                    const welcome =
                        document.createElement(
                            "div"
                        );


                    welcome.className =
                        "ai-chat-message assistant";


                    welcome.innerHTML =

                        '<div class="ai-chat-avatar">AI</div>' +

                        '<div class="ai-chat-message-content">' +

                            'Conversation cleared. What would you like to ask about ELIS data?' +

                            '<span class="ai-message-time">Just now</span>' +

                        '</div>';


                    chatMessages.insertBefore(
                        welcome,
                        typingIndicator
                    );


                    clearAiMap();

                }
            );

        }


        /* =====================================================
           EXPORT CHAT
           ===================================================== */

        const exportChatBtn =
            document.getElementById(
                "ai_btn_export_chat"
            );


        if (
            exportChatBtn
        ) {

            exportChatBtn.addEventListener(
                "click",
                function () {

                    const messages =
                        chatMessages.querySelectorAll(
                            ".ai-chat-message"
                        );


                    let exportText =

                        "=== ELIS AI Database Assistant ===\n";


                    exportText +=

                        "Date: " +

                        new Date()
                            .toLocaleString() +

                        "\n\n";


                    messages.forEach(
                        function (
                            message
                        ) {

                            const role =

                                message.classList.contains(
                                    "user"
                                )

                                    ? "User"

                                    : "AI Assistant";


                            const content =

                                message.querySelector(
                                    ".ai-chat-message-content"
                                );


                            if (
                                !content
                            ) {

                                return;

                            }


                            const clone =
                                content.cloneNode(
                                    true
                                );


                            const timestamp =
                                clone.querySelector(
                                    ".ai-message-time"
                                );


                            if (
                                timestamp
                            ) {

                                timestamp.remove();

                            }


                            exportText +=

                                role +
                                ": " +
                                clone.textContent.trim() +
                                "\n\n";

                        }
                    );


                    const blob =
                        new Blob(

                            [
                                exportText
                            ],

                            {
                                type:
                                    "text/plain;charset=utf-8"
                            }

                        );


                    const url =
                        URL.createObjectURL(
                            blob
                        );


                    const link =
                        document.createElement(
                            "a"
                        );


                    link.href =
                        url;


                    link.download =

                        "elis-ai-database-chat-" +

                        new Date()
                            .toISOString()
                            .substring(
                                0,
                                10
                            ) +

                        ".txt";


                    document.body.appendChild(
                        link
                    );


                    link.click();


                    link.remove();


                    URL.revokeObjectURL(
                        url
                    );

                }
            );

        }


        /* =====================================================
           CLEAR MAP
           ===================================================== */

        const clearMapBtn =
            document.getElementById(
                "ai_btn_clear_map"
            );


        if (
            clearMapBtn
        ) {

            clearMapBtn.addEventListener(
                "click",
                clearAiMap
            );

        }


        /* =====================================================
           TOOLTIP
           ===================================================== */

        if (
            typeof bootstrap !==
                "undefined"
        ) {

            document
                .querySelectorAll(
                    '[data-bs-toggle="tooltip"]'
                )
                .forEach(
                    function (
                        element
                    ) {

                        if (
                            !bootstrap.Tooltip
                                .getInstance(
                                    element
                                )
                        ) {

                            new bootstrap.Tooltip(
                                element
                            );

                        }

                    }
                );

        }


        /* =====================================================
           INITIALISE MAP
           ===================================================== */

        initialiseAiMap();


        console.log(
            "ELIS AI Database Assistant loaded."
        );

    }
);

</script>


<script
    src="${pageContext.request.contextPath}/js-pages/gated_workflow.js">
</script>