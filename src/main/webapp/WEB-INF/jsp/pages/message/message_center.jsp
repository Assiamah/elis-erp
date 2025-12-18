
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<jsp:include page="../includes/_header.jsp"></jsp:include>


<%
	
%>




<div class="content-wrapper">
	<div class="container-fluid">
		<!-- Breadcrumbs-->
		<div class="row">
            <input class="form-control" hidden id="userid" value="${userid}" />
            <input class="form-control" hidden id="receiver_name" value="" />
			<div class="col-lg-4">
				<!-- Example Bar Chart Card-->
				<div class="card mb-3">
					<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i>Message Center
					</div>
					<div class="card-body">
                        <button class="btn btn-info mt-2 w-100" data-toggle="modal" data-target="#composeMessageModal">
                            <!-- <span class="icon text-white-50"> 
                                <i class="fas fa-envelope"></i>
                            </span> -->
                            <span class="text">Compose New Message</span>
                        </button>
                        <hr>

                        <c:forEach items="${message_list}" var="msg">
                            <div class="card load_message_details" data-message_id="${msg.id}" data-receiver_name="${msg.receiver_name}">
                                <div class="card-body">
                                    <h6 class="small font-weight-bold">${userid == msg.send_id ? msg.receiver_name : msg.sender_name}</h6>
                                    <span class="">${fn:substring(msg.last_message, 0, 60)} ${fn:length(msg.last_message) >60 ? "..." : ""}</span><br>
                                    <i class="mt-2"><small>${msg.last_sent_date}</small></i>
                                </div>
                            </div>
                        </c:forEach>
						
					</div>
					<!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
				</div>
			</div>



			<!--   Here is the right Table -->
			<div class="col-lg-8">
				<!-- Example Pie Chart Card-->
				<div class="card mb-3">
					<div class="card-header bg-dark text-white">
						<i class="fa fa-pie-chart"></i> Message Details
					</div>
					<div class="card-body">

                        <div class="row" id="message_details">
                            <!-- <div> -->
                                <h1 class="text-secondary">No Message Selected</h1>
                            <!-- </div> -->
                        </div>
                        
                        <div class="d-none" id="text_message_div">
                            <textarea class="form-control" id="txt_reply_message" rows="5" placeholder="Type something here..."></textarea>
                        </div>
                        <div  class="d-none mt-3" id="send_button_div">
                            <button type="button" class="btn btn-success" id="btn_reply_message"><i class="fas fa-envelope mr-2"></i>Send</button>
                        </div>

					</div>
				</div>
				<!--   Here is the end of right table -->

			</div>

			</div>

		</div>

	</div>

    <div class="modal fade" id="composeMessageModal" tabindex="-1" role="dialog" aria-labelledby="appsPassedDueModal" aria-hidden="true">
        <div class="modal-dialog modal-md">
          <div class="modal-content">
            <div class="modal-header bg-danger text-light">
              <h5 class="modal-title" id="newQueryModalLabel">Compose New Message</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label for="" class="col-form-label">Division :</label>
                  <select id="unit_division_to_send_to_2" class="form-control" >
                     <option value="none">---Select Division---</option>
                     <option value="LVD">LVD</option>
                     <option value="LRD">LRD</option>
                     <option value="PVLMD">PVLMD</option>
                     <option value="SMD">SMD</option>
                      <option value="RLO">RLO</option>
                  </select>
                  </div>

                  <div class="form-group">
                    <label for="" class="col-form-label">Unit :</label>
                  <input autocomplete="off" class="form-control" id="unit_to_send_to_2"  type="text"  list="listofunitsbatching" class=""  placeholder="Select/Enter Unit" required  >
                  <datalist id="listofunitsbatching"></datalist>
                </div>
        
                <div class="form-group">
                    <label for="" class="col-form-label">User:</label>
                    <input class="form-control" id="am_to_officer"  name="am_to_officer" type="text" autocomplete="off" 
                    list="listofusersbatching" class="autocomplat"  placeholder="Enter Username" required  onmousedown="value = '';" >
                    <datalist id="listofusersbatching">
                        <c:forEach items="${userlist}" var="user">
                                <option data-value="${user.userid}" value="${user.fullname}"></option>
                    </c:forEach>
                    </datalist>
                </div>

                <div class="form-group">
                    <label for="" class="col-form-label">Message:</label>
                    <textarea class="form-control" rows="5" id="message_compose_text"></textarea>
                </div>
                 
            </div>
            <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                  <button type="button" class="btn btn-success" id="btn_send_message">Send</button>
             </div>
          </div>
        </div>
      </div>


	<jsp:include page="../includes/_footer.jsp"></jsp:include>