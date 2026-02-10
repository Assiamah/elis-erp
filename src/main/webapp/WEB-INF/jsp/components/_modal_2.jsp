<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%> 
<jsp:useBean id="now" class="java.util.Date" />

<div class="modal fade effect-scale modal-blur" id="addNotesModal" tabindex="-1" aria-labelledby="addNotesModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <div>
                        <h5 class="modal-title text-white mb-0" id="addNotesModalLabel">
                            <i class="bi bi-journal-plus me-2"></i>Add Note or Report
                        </h5>
                        <p class="mb-0 small opacity-75">Create a new note or report entry</p>
                    </div>
                    <button type="button" class="btn-close btn-close-white ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <form id="form_add_notes">
                    <!-- Hidden Inputs -->
                    <input id="an_id" type="hidden" value="0">
                    <input type="hidden" id="an_job_number" value="${job_number}" class="form-control" required>
                    <input type="hidden" id="an_case_number" value="${case_number}" class="form-control" required>
                    <input type="hidden" id="an_type" value="Normal" class="form-control" required>

                    <!-- Main Content -->
                    <div class="row">
                        <!-- Description Field -->
                        <div class="col-12 mb-4">
                            <div class="card border">
                                <div class="card-header bg-light">
                                    <h6 class="mb-0 fw-semibold">
                                        <i class="bi bi-card-text me-2"></i>Description
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="form-floating">
                                        <textarea id="an_description" class="form-control" 
                                                  placeholder="Enter note description" 
                                                  style="height: 150px" required></textarea>
                                        <label for="an_description">Note Description *</label>
                                    </div>
                                    <div class="form-text">
                                        <i class="bi bi-info-circle me-1"></i>Provide a detailed description of the note or report
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Reference -->
                        <div class="col-12">
                            <div class="card border">
                                <div class="card-header bg-light">
                                    <h6 class="mb-0 fw-semibold">
                                        <i class="bi bi-link-45deg me-2"></i>Quick Reference
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label small fw-medium text-muted mb-1">
                                                <i class="bi bi-briefcase me-1"></i>Job Number
                                            </label>
                                            <div class="input-group input-group-sm">
                                                <input type="text" class="form-control bg-light" 
                                                       value="${job_number}" readonly>
                                                <button class="btn btn-outline-dark" type="button"
                                                        onclick="copyToClipboard('an_job_number')">
                                                    <i class="bi bi-clipboard"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label small fw-medium text-muted mb-1">
                                                <i class="bi bi-file-text me-1"></i>Case Number
                                            </label>
                                            <div class="input-group input-group-sm">
                                                <input type="text" class="form-control bg-light" 
                                                       value="${case_number}" readonly>
                                                <button class="btn btn-outline-dark" type="button"
                                                        onclick="copyToClipboard('an_case_number')">
                                                    <i class="bi bi-clipboard"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer -->
                    <div class="modal-footer bg-light mt-4">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-1"></i>Cancel
                        </button>
                        <button type="submit" id="btn_add_notes" class="btn btn-primary">
                            <i class="bi bi-save me-1"></i>Save Note
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>