<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:choose>
<c:when test="${section == 'jobs'}">
											<c:forEach items="${job_details}" var="job_row">
												<tr>
													<td>${fn:escapeXml(job_row.job_number)}</td>
													<td>${fn:escapeXml(job_row.business_process_sub_name)}</td>
												</tr>
											</c:forEach>
										
<c:if test="${empty job_details}"><tr><td colspan="2" class="text-muted text-center py-3">No records found.</td></tr></c:if>
</c:when>
<c:when test="${section == 'parties'}">
                                            <c:forEach items="${parties}" var="parties_row">
                                                <tr>
                                                    <td class="fw-medium">${fn:escapeXml(parties_row.ar_name)}</td>
                                                    <td>
                                                        <span class="badge bg-light text-dark">
                                                            ${fn:escapeXml(parties_row.ar_gender)}
                                                        </span>
                                                    </td>
                                                    <td>${fn:escapeXml(parties_row.ar_cell_phone)}</td>
                                                    <td>
                                                        <span class="badge bg-info">
                                                            ${fn:escapeXml(parties_row.type_of_party)}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        
<c:if test="${empty parties}"><tr><td colspan="4" class="text-muted text-center py-3">No records found.</td></tr></c:if>
</c:when>
<c:when test="${section == 'payments'}">
                                            <c:forEach items="${payment_invoice}" var="payment_bill_row">
                                                <tr>
                                                    <td>
                                                        <button class="btn btn-sm btn-primary"
                                                                data-bs-toggle="modal" 
																data-bs-target="#generateEGCRModal"
                                                                data-egcr_id="${fn:escapeXml(payment_bill_row.payment_slip_number)}"
                                                                data-ref_number="${fn:escapeXml(payment_bill_row.ref_number)}">
                                                            <i class="bi bi-eye"></i>
                                                        </button>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-light text-dark">
                                                            ${fn:escapeXml(payment_bill_row.payment_mode)}
                                                        </span>
                                                    </td>
                                                    <td class="fw-medium">${fn:escapeXml(payment_bill_row.bill_amount)}</td>
                                                    <td>${fn:escapeXml(payment_bill_row.payment_slip_number)}</td>
                                                    <td>${fn:escapeXml(payment_bill_row.payment_date)}</td>
                                                </tr>
                                            </c:forEach>
                                        
<c:if test="${empty payment_invoice}"><tr><td colspan="5" class="text-muted text-center py-3">No records found.</td></tr></c:if>
</c:when>
<c:when test="${section == 'minutes'}">
                                            <c:forEach items="${application_munites}" var="application_munites_row">
                                                <tr>
                                                    <td class="fs-15">${fn:escapeXml(application_munites_row.am_description)}</td>
                                                    <td class="fs-12">${fn:escapeXml(application_munites_row.am_from_officer)}</td>
                                                    <td class="fs-12">${fn:escapeXml(application_munites_row.am_to_officer)}</td>
                                                    <td class="fs-12">${fn:escapeXml(application_munites_row.am_activity_date)}</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-info text-dark view-minute-btn"
															data-bs-toggle="modal" 
															data-bs-target="#viewMinutesModal"
															data-minute-id="${fn:escapeXml(application_munites_row.am_id)}"
															data-minute-description="${fn:escapeXml(application_munites_row.am_description)}"
															data-minute-from="${fn:escapeXml(application_munites_row.ar_name)}"
															data-minute-to="${fn:escapeXml(application_munites_row.am_to_officer)}"
															data-minute-date="${fn:escapeXml(application_munites_row.am_activity_date)}"
															data-minute-case-number="${case_number}"
															data-minute-job-number="${job_number}"
															data-minute-status="${empty application_munites_row.status ? 'active' : fn:escapeXml(application_munites_row.status)}">
                                                            <i class="bi bi-eye"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        
<c:if test="${empty application_munites}"><tr><td colspan="5" class="text-muted text-center py-3">No records found.</td></tr></c:if>
</c:when>
<c:when test="${section == 'records'}">
                                            <c:forEach items="${application_notes}" var="application_notes_row">
                                                <tr class="${application_notes_row.an_status == false ? 'table-danger' : ''}" 
                                                    ${application_notes_row.an_status == false ? "data-bs-toggle='tooltip' data-bs-placement='top' title='Note has been disabled'" : ""}>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <!-- <i class="fas fa-comment text-muted me-2"></i> -->
                                                            <span class="text-truncate" style="max-width: 200px;">
                                                                ${fn:escapeXml(application_notes_row.an_description)}
                                                            </span>
                                                            ${application_notes_row.an_status == false ? 
                                                                '<span class="badge bg-danger ms-2">Disabled</span>' : ''}
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span>${fn:escapeXml(application_notes_row.created_by)}</span>
                                                    </td>
                                                    <td>
                                                        <span>${fn:escapeXml(application_notes_row.created_date)}</span>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-secondary bg-opacity-10 text-dark">
                                                            ${fn:escapeXml(application_notes_row.division)}
                                                        </span>
                                                    </td>
                                                    <td class="text-center">
                                                        <button class="btn btn-outline-primary btn-sm viewNotesModal" 
                                                                data-target-id="${fn:escapeXml(application_notes_row.an_id)}"
                                                                data-an_description="${fn:escapeXml(application_notes_row.an_description)}"
                                                                data-created_by="${fn:escapeXml(application_notes_row.created_by)}"
                                                                data-created_date="${fn:escapeXml(application_notes_row.created_date)}"
                                                                data-modified_by="${fn:escapeXml(application_notes_row.created_by)}"
                                                                data-modified_date="${fn:escapeXml(application_notes_row.created_date)}"
                                                                data-division="${fn:escapeXml(application_notes_row.division)}"
                                                                data-job_number="${fn:escapeXml(application_notes_row.job_number)}"
                                                                ${application_notes_row.an_status == false ? "disabled" : ""}>
                                                            <i class="fas fa-eye me-1"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        
<c:if test="${empty application_notes}"><tr><td colspan="5" class="text-muted text-center py-3">No records found.</td></tr></c:if>
</c:when>
<c:when test="${section == 'queries'}">
                                            <c:forEach items="${case_query}" var="case_query_row">
                                                <tr>
                                                    <td>${fn:escapeXml(case_query_row.query_general_reason)}</td>
                                                    <td>${fn:escapeXml(case_query_row.created_date)}</td>
                                                    <td>
                                                        <span class="badge ${case_query_row.status == 1 ? 'bg-danger text-white' : 'bg-success text-white'}">
                                                            ${case_query_row.status == 1 ? 'Pending' : 'Resolved'}
                                                        </span>
                                                    </td>
                                                    <td class="text-nowrap">
                                                        <div class="d-flex gap-1">
                                                            <!-- View / Edit Button -->
                                                            <button class="btn btn-sm ${case_query_row.status == 1 ? 'btn-warning' : 'btn-outline-info'}"
                                                                    data-bs-toggle="modal" 
                                                                    data-bs-target="#viewQueryModal"
                                                                    data-action="${case_query_row.status == 1 ? 'edit' : 'view'}"
                                                                    data-id="${fn:escapeXml(case_query_row.qid)}"
                                                                    data-job_number="${fn:escapeXml(case_query_row.job_number)}"
                                                                    data-case_number="${fn:escapeXml(case_query_row.case_number)}"
                                                                    data-reasons="${fn:escapeXml(case_query_row.reasons)}"
                                                                    data-remarks="${fn:escapeXml(case_query_row.remarks)}"
                                                                    data-general_reason="${fn:escapeXml(case_query_row.query_general_reason)}"
                                                                    data-query_response="${fn:escapeXml(case_query_row.query_response)}"
                                                                    data-status="${fn:escapeXml(case_query_row.status)}"
                                                                    data-created_by="${fn:escapeXml(case_query_row.created_by)}"
                                                                    data-created_date="${fn:escapeXml(case_query_row.created_date)}"
                                                                    data-modified_by="${fn:escapeXml(case_query_row.modified_by)}"
                                                                    data-modified_date="${fn:escapeXml(case_query_row.modified_date)}"
                                                                    data-attachment_required="${fn:escapeXml(case_query_row.attachment_required)}">
                                                                <i class="bi bi-eye"></i>
                                                            </button>

                                                            <!-- Edit Button -->
                                                            <button class="btn btn-sm btn-outline-danger"
                                                                    data-bs-toggle="modal" 
                                                                    data-bs-target="#newQueryModal"
                                                                    data-action="edit"
                                                                    data-id="${fn:escapeXml(case_query_row.qid)}"
                                                                    data-job_number="${fn:escapeXml(case_query_row.job_number)}"
                                                                    data-case_number="${fn:escapeXml(case_query_row.case_number)}"
                                                                    data-reasons="${fn:escapeXml(case_query_row.reasons)}"
                                                                    data-remarks="${fn:escapeXml(case_query_row.remarks)}"
                                                                    data-general_reason="${fn:escapeXml(case_query_row.query_general_reason)}"
                                                                    data-query_response="${fn:escapeXml(case_query_row.query_response)}"
                                                                    data-status="${fn:escapeXml(case_query_row.status)}"
                                                                    data-created_by="${fn:escapeXml(case_query_row.created_by)}"
                                                                    data-created_date="${fn:escapeXml(case_query_row.created_date)}"
                                                                    data-modified_by="${fn:escapeXml(case_query_row.modified_by)}"
                                                                    data-modified_date="${fn:escapeXml(case_query_row.modified_date)}"
                                                                    data-attachment_required="${fn:escapeXml(case_query_row.attachment_required)}">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        
<c:if test="${empty case_query}"><tr><td colspan="4" class="text-muted text-center py-3">No records found.</td></tr></c:if>
</c:when>
<c:when test="${section == 'encumbrances'}">
                                             <c:forEach items="${lrd_encumbrances_section}" var="lrd_encumbrances_section_row">
												<tr>
                                                    <td>${fn:escapeXml(lrd_encumbrances_section_row.es_registered_number)}</td>
                                                    <td>${fn:escapeXml(lrd_encumbrances_section_row.es_date_of_instrument)}</td>
                                                    <td>${fn:escapeXml(lrd_encumbrances_section_row.es_date_of_registration)}</td>
                                                    <td>${fn:escapeXml(lrd_encumbrances_section_row.es_memorials)}</td>
                                                    <td>${fn:escapeXml(lrd_encumbrances_section_row.es_remarks)}</td>
                                                    <td>${fn:escapeXml(lrd_encumbrances_section_row.es_entry_number)}</td>
					                            </tr>
                                            </c:forEach>
                                        
<c:if test="${empty lrd_encumbrances_section}"><tr><td colspan="6" class="text-muted text-center py-3">No records found.</td></tr></c:if>
</c:when>
<c:when test="${section == 'links'}">
                                             <c:forEach items="${mother_to_child_link_list}" var="mother_to_child_link_row">
                                                <tr>
                                                
                                                    <td>${fn:escapeXml(mother_to_child_link_row.job_number)}</td>
                                                    <td>${fn:escapeXml(mother_to_child_link_row.mc_case_number)}</td>
                                                    <td>${fn:escapeXml(mother_to_child_link_row.mc_type_of_relationship)}</td>
                                                    <td>${fn:escapeXml(mother_to_child_link_row.created_date)}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty business_process_sub_name and fn:contains(fn:toLowerCase(business_process_sub_name), 'deed')}">
                                                                <button type="button"  
                                                                    data-job_number="${fn:escapeXml(mother_to_child_link_row.mc_job_number)}" 
                                                                    data-case_number="${fn:escapeXml(mother_to_child_link_row.mc_case_number)}" 
                                                                    data-transaction_number="${fn:escapeXml(mother_to_child_link_row.mc_transaction_number)}"
                                                                    class="btn btn-sm btn-warning btn-view-mother-Child-details-deed"
                                                                >
                                                                    <i class="fas fa-eye"></i>
                                                                </button> 
                                                            </c:when>

                                                            <c:otherwise>
                                                                <button type="button"  
                                                                    data-job_number="${fn:escapeXml(mother_to_child_link_row.mc_job_number)}" 
                                                                    data-case_number="${fn:escapeXml(mother_to_child_link_row.mc_case_number)}" 
                                                                    data-transaction_number="${fn:escapeXml(mother_to_child_link_row.mc_transaction_number)}"
                                                                    class="btn btn-sm btn-warning btn-view-mother-Child-details"
                                                                >
                                                                    <i class="fas fa-eye"></i>
                                                                </button> 
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        
<c:if test="${empty mother_to_child_link_list}"><tr><td colspan="5" class="text-muted text-center py-3">No records found.</td></tr></c:if>
</c:when>
<c:when test="${section == 'objections'}">
                                             <c:forEach items="${case_objection}" var="case_objection_row">
                                                <tr class="${case_objection_row.status == 'false' ? 'table-danger' : ''}">
                                                    <td>${fn:escapeXml(case_objection_row.objector_name)}</td>
                                                    <td>${fn:escapeXml(case_objection_row.objector_address)}</td>
                                                    <td>${fn:escapeXml(case_objection_row.objector_contact)}</td>
                                                    <td>${fn:escapeXml(case_objection_row.reasons)}</td>
                                                    <td>${fn:escapeXml(case_objection_row.remarks)}</td>
                                                    
                                                    <td>
                                                            <button type="button" 
                                                            
                                                            id="editOjectionModal"  
                                                            data-bs-toggle="modal" 
                                                            data-bs-target="#newObjectionModal"  
                                                            data-action="edit"  
                                                            data-target-id="${fn:escapeXml(case_objection_row.id)}"
                                                            data-objector_name= "${fn:escapeXml(case_objection_row.objector_name)}" 
                                                            data-objector_address="${fn:escapeXml(case_objection_row.objector_address)}" 
                                                            data-objector_contact="${fn:escapeXml(case_objection_row.objector_contact)}" 
                                                            data-reasons= "${fn:escapeXml(case_objection_row.reasons)}" 
                                                            data-remarks="${fn:escapeXml(case_objection_row.remarks)}" 
                                                            data-status="${fn:escapeXml(case_objection_row.status)}" 
                                                            

                                                            class="btn btn-danger btn-sm"
                                                            title="edit objection" >
                                                                <i class="fas fa-eye"></i>
                                                            </button> 
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        
<c:if test="${empty case_objection}"><tr><td colspan="6" class="text-muted text-center py-3">No records found.</td></tr></c:if>
</c:when>
<c:when test="${section == 'letters'}">
                                             <c:forEach items="${case_letters}" var="case_letters_row">
                                                <tr>
                                                    <td>${fn:escapeXml(case_letters_row.created_date)}</td>
                                                    <td>${fn:escapeXml(case_letters_row.letter_type)}</td>
                                                    <td>${fn:escapeXml(case_letters_row.created_by)}</td>
                                                    
                                                    
                                                    <td>
                                                        <button type="button" id="btn-view-letters"  
                                                        data-id="${fn:escapeXml(case_letters_row.id)}"
                                                        data-letter_type = "${fn:escapeXml(case_letters_row.letter_type)}" 
                                                        data-letter_template="${fn:escapeXml(case_letters_row.letter_template)}" 
                                                        data-carbon_copy="${fn:escapeXml(case_letters_row.carbon_copy)}" 
                                                        class="btn btn-primary btn-icon-split edit_letter_modal_open"  title="View Letter" >
                                                            <span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>
                                                        </button> 
                                                </td>
                                                </tr>
                                            </c:forEach>
                                        
<c:if test="${empty case_letters}"><tr><td colspan="4" class="text-muted text-center py-3">No records found.</td></tr></c:if>
</c:when>
<c:when test="${section == 'workflow'}">
                                <c:forEach items="${baby_step_milestone_list}" var="milestone">

                                    <%-- ==============================
                                        INITIALIZE STATUS FLAGS
                                    =============================== --%>
                                    <c:set var="hasOngoing" value="false" />
                                    <c:set var="allCompleted" value="true" />

                                    <%-- ==============================
                                        EVALUATE BABY STEPS
                                    =============================== --%>
                                    <c:forEach items="${milestone.baby_steps}" var="process">
                                        <c:if test="${process.bse_status == 'Ongoing'}">
                                            <c:set var="hasOngoing" value="true" />
                                        </c:if>

                                        <c:if test="${process.bse_status != 'Completed'}">
                                            <c:set var="allCompleted" value="false" />
                                        </c:if>
                                    </c:forEach>

                                    <%-- ==============================
                                        DETERMINE MILESTONE STATUS
                                    =============================== --%>
                                    <c:choose>
                                        <c:when test="${allCompleted}">
                                            <c:set var="milestoneStatus" value="Completed" />
                                            <c:set var="milestoneBadge" value="bg-success" />
                                        </c:when>
                                        <c:when test="${hasOngoing}">
                                            <c:set var="milestoneStatus" value="Ongoing" />
                                            <c:set var="milestoneBadge" value="bg-warning" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="milestoneStatus" value="Pending" />
                                            <c:set var="milestoneBadge" value="bg-danger" />
                                        </c:otherwise>
                                    </c:choose>

                                    <%-- ==============================
                                        MILESTONE HEADER
                                    =============================== --%>
                                    <h6 class="mb-2 d-flex justify-content-between">
                                        ${fn:escapeXml(milestone.milestone_description)}
                                        
                                        <span class="badge ${milestoneBadge} text-white">
                                            ${milestoneStatus}
                                        </span>
                                    </h6>

                                    <%-- ==============================
                                        BABY STEPS CARD
                                    =============================== --%>
                                    <div class="card card-body mb-3">
                                        <ul class="list-unstyled projects-recent-activity-list">

                                            <c:forEach items="${milestone.baby_steps}" var="process">
                                                <li class="mb-2">
                                                    <div class="d-flex align-items-start gap-3">

                                                        <%-- STATUS ICON --%>
                                                        <div>
                                                            <i class="fas
                                                                ${process.bse_status == 'Completed' ? 'fa-check-circle text-success' :
                                                                process.bse_status == 'Ongoing' ? 'fa-spinner text-warning' :
                                                                'fa-times-circle text-danger'}">
                                                            </i>
                                                        </div>

                                                        <%-- CONTENT --%>
                                                        <div class="flex-fill">
                                                            <div class="d-flex align-items-start justify-content-between mb-1 flex-wrap">
                                                                <div class="fw-semibold text-truncate"
                                                                    style="max-width: 200px;"
                                                                    data-bs-toggle="tooltip"
                                                                    data-bs-custom-class="tooltip-primary"
                                                                    data-bs-placement="top"
                                                                    title="${fn:escapeXml(process.bse_description)}">
                                                                    ${fn:escapeXml(process.bse_description)}
                                                                </div>

                                                                <span class="badge bg-light text-muted border">
                                                                    Date &amp; Time:
                                                                    <c:choose>
                                                                        <c:when test="${process.complete_by_date != null}">
                                                                            ${fn:escapeXml(process.complete_by_date)}
                                                                        </c:when>
                                                                        <c:otherwise>N/A</c:otherwise>
                                                                    </c:choose>
                                                                </span>
                                                            </div>

                                                            <div class="descrption">
                                                                Performed by:
                                                                <strong>
                                                                    ${process.completed_by != null ? process.completed_by : 'Pending'}
                                                                </strong>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </li>
                                            </c:forEach>

                                        </ul>
                                    </div>

                                </c:forEach><c:if test="${empty baby_step_milestone_list}"><p class="text-muted">No process steps found.</p></c:if></c:when>
</c:choose>
