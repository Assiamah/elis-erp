<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="d" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.*" %>
<jsp:include page="../legal/includes/header.jsp"></jsp:include>
<!-- Begin Page Content -->
   <div class="container-fluid">
	<section class="section dashboard">
		 <!-- Page Heading -->
                <div class="row mb-4">
                	 <div class="col-md-12">
		                <div class=" ">
		                   
					         <nav>
				                <ol class="breadcrumb">
				                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
				                  <li class="breadcrumb-item active">Case Management</li>
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div>
	
	
     	<div class="row mb-4">
      		<!-- Left side columns -->
        <div class="col-lg-12">
          <div class="row">

            <!-- Unit Cases Card -->
            <div class="col-xl-3 col-md-6" id="unit_cases_unassigned" >
              <div class="card border-left-primary shadow h-100 py-2" id="body-bg-1">

                <div class="card-body">
	                  		<h5 class="card-title">Cases | <span>Unassigned</span></h5>
					
							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<i class="fas fa-calendar fa-2x text-primary"></i>
								</div>
								 <div class="">	
		                     	 	<h4 id="unit_count"><c:out value="${unassigned_count}"></c:out></h4>
								 </div>
		                    </div>
                </div>

              </div>
            </div><!-- Assigned Cases Card -->
            
            <div class="col-xl-3 col-md-6" id="unit_cases">
              <div class="card border-left-success shadow h-100 py-2" id="body-bg-2">

                <div class="card-body">
	                  		<h5 class="card-title">Cases | <span>Assigned</span></h5>
					
							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<i class="fas fa-calendar fa-2x text-success"></i>
								</div>
								 <div class="">	
		                     	 	<h4 id="unit_count"><c:out value="${assigned_count}"></c:out></h4>
								 </div>
		                    </div>
                </div>

              </div>
            </div>

            <!-- Unit Cases Card -->
            <div class="col-xl-3 col-md-6" id="officer_cases">
              <div class="card border-left-info shadow h-100 py-2" id="body-bg-3">

               <div class="card-body">
                  <h5 class="card-title">Cases <span>| Inbox</span></h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="fas fa-calendar fa-2x text-info"></i>
                    </div>
                    <div class="">
                      <h4 id="assigned_count"><c:out value="${assigned_user_count}"></c:out></h4>

                    </div>
                  </div>
                </div>

              </div>
            </div><!-- Unit Cases Card -->

            <!-- Archived Cases Card -->
            <div class="col-xl-3 col-md-6" id="pending">
			 
              <div class="card border-left-warning shadow h-100 py-2" id="body-bg-4">

                <div class="card-body">
                    <h5 class="card-title">Cases <span>| Pending Action</span></h5>

                <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="fas fa-calendar fa-2x text-warning"></i>
                    </div>
                    <div class="ps-3">
                      <h4 id="total_count"><c:out value="${unit_count}"></c:out></h4>

                    </div>
                  </div>

                </div>
              </div>
			 
            </div><!-- Archived Cases Card -->
     	
     
     </div>
    </div>
  </div>
	
	<div class="row">
	<h6>Table Background Indicators</h6>
			<span class="mb-2 small"><i class="fas fa-dot-circle text-white" style="border: 1px solid black; border-radius: 50%"></i>Case without both further entries and uploaded document.</span>
	<span class="mb-2 small"><i class="fas fa-dot-circle text-danger"></i>Case with only uploaded document.</span>
		<span class="mb-2 small"><i class="fas fa-dot-circle text-warning"></i>Case with only further entries.</span>
		<span class="mb-2 small"><i class="fas fa-dot-circle text-success"></i>Case with both further entries and uploaded document.</span>
	</div>
	
	      <div class="row mb-4">
	            <div class="col-md-12">
	              <div class="card">
	              <div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i>Process Details <span
						class="col-md-3 float-right ">
						<button class="btn btn-success btn-icon-split float-right "
							id="btnViewUpcomingCases">
							<span class="icon text-white-50"> <i class="fas fa-calendar"></i></span><span
								class="text">View Calendar</span>
						</button>
					</span>
					</div>
	                <div class="card-body">
	                	  <h5 class="card-title">Cases | <span id="card_title"></span></h5>
	                  <div class="tab-content">
					            <div id="" class="table-responsive">
					                <table class="table" id="table_list"   width="100%" cellspacing="0">
	              						<thead>
	              							 <tr>
										        <th>#</th>
										        <th>Suit Number</th>
										        <th>Nature of Case</th>
										         <th>Court Process</th>
										        <th>Court</th>
										        <th>Court Region</th>
										        <th>Plaintiff(s)</th>
										        <th>Defendant(s)</th>
										        <th>Date of Document</th>
										        <th>Date Received</th>
										        <th>Assigned To</th>
										        <th>Reminder</th>
												<th>Actions</th>
										    </tr>
	              						</thead>
	              						<tbody>
	              					
	              						</tbody>
		                   	        </table>
					            </div>
					    </div>
	                </div>
	              </div>
	              
	              <%-- <div class="card mt-3">
	                <div class="card-body">
	                  <h4 class="card-title"></h4>
	                  <div id="calendar" class="full-calendar"></div>
	                </div>
	              </div> --%>
              
	            </div>
	            <!-- Timelines -->
	            <%-- <div class="col-lg-3">

          <!-- Recent Activity -->
          <div class="card">
          
            <div class="card-body">
              <h5 class="card-title">Upcoming <span>| Timeline </span></h5>
				<ul class="timeline-3" id="upcoming">
			       
			       
			      </ul>
            </div>
          </div><!-- End Recent Activity -->

         <!-- Recent Activity -->
          <div class="card mt-4">
            <div class="filter">
              <a class="icon" href="#" ><i class="bi bi-three-dots"></i></a>
            </div>

            <div class="card-body">
              <h5 class="card-title">Past <span>| Timeline</span></h5>
				<ul class="timeline-3" id="past">
			       
			      </ul>
           

            </div>
          </div><!-- End Recent Activity -->
         


        </div> --%>
        
        <!-- End Right side columns -->
	            
	           </div>
	           <%-- <div class="row">
	            <div class="col-md-12 mb-4">
		            <div class="card">
		                <div class="card-body">
		            	  <div id="menu">
					        <span id="menu-navi">
					        
					           <button type="button" class="btn btn-default btn-sm move-prev" >
          						<i class="calendar-icon ic-arrow-line-left" >Previous</i>
        					  </button>
					        
					          <button type="button" class="btn btn-default btn-sm move-today">Today</button>
					       
					          <button type="button" class="btn btn-default btn-sm move-next">
					            <i class="calendar-icon ic-arrow-line-right" >next</i>
					          </button>
					        </span>
					        <span id="renderRange" class="render-range"></span>
					      </div>
					
					    <div id="calendar" style="height: 800px;"></div>
		            	</div>
		            </div>
	            </div>
	          </div> --%>
	          
	           <div class="col-md-9">
              
            </div>

     </section>

	</div>
<!-- End Page Content -->


 <!-- Pending Modal-->
   <div class="modal fade" id="pendingModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Pending | Cases</h5>
           
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>

          </div>
          <div class="modal-body">
	            <div class="row">
	                   <div id="" class="table-responsive">
		                  <table class="table" id="pending_list">
		                  
		                  </table>
	                  </div>
	            </div>

          	</div>
          	<div class="modal-footer">
            	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          	</div>
        </div>
      </div>
    </div>
<!-- Pending Modal-->


  
    <div class="modal fade" id="eventDetails" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Case Details</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form  action="case_details_post" method="post">
        
        <div class="modal-body" style="font-size: small;">
         <input class="form-control" type="text" id="case_id" name="case_id" hidden="" required>
          <div class="row mb-3">
			<label for="inputNumber">Suit Number:</label>
			<div class="col-sm-12">
              <input class="form-control" type="text" id="suit_number" name="suit_number" readonly required>
            </div>
		  </div>
		  	
		  <div class="row mb-3">
		  <label for="inputNumber" class="col-sm-4 col-form-label">Start Date</label>
			<div class="col-sm-12">
              <input class="form-control" type="text" id="start_date">
            </div>
		  </div>
		  
		  <div class="row mb-3">
		  <label for="inputNumber" class="col-sm-4 col-form-label">End Date</label>
			<div class="col-sm-12">
              <input class="form-control" type="text" id="end_date">
            </div>
		  </div>
		 
		   <div class="row mb-3">
		    <label for="inputNumber" class="col-sm-4 col-form-label">Description</label>
            <div class="col-sm-12">
              <textarea class="form-control" rows="5" id="description" readonly></textarea>
            </div>
          </div>
          <input type="hidden"  name="request_type" value="case_details">
			<%-- <input type="text" name="created_by" id="created_by" value="${sessionScope.userid}" hidden> --%>
        </div>
        <div class="modal-footer">
          <button type="submit" id="save_note" class="btn btn-primary">View Case</button>
        </div>
       </form>
      </div>
    </div>
  </div>

  <!-- Assign Modal -->
  <div class="modal fade" id="archiveCaseModal" tabindex="-1" data-focus-on="input:first">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Archive Case</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="archive_one" method="post">
        <div class="modal-body">
         <input type="text" name="suit_number" id="a_suit_number" hidden>
         <input type="text" name="case_id" id="a_case_id" hidden>
          <div class="row mb-3">
            <label for="inputNumber" class="col-sm-4 col-form-label">Reasons:</label>
            <div class="col-sm-8">
               <textarea class="form-control" id="archive_reasons" required=""></textarea>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Confirm</button>
        </div>
        </form>
      </div>
    </div>
  </div>
  <!-- Assign -->
  
  
  <div class="modal fade" id="upcomingcasesModal" tabindex="-1">
                <div class="modal-dialog modal-xl">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">Upcoming Cases</h5>
                      <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      	<%-- <div class="row">
                      		<div class="col-9"> --%>
                      			<div id="calendar" class="full-calendar"></div>
                      		<%-- </div>
                      		<div class="col-3 nav-stacked timeline-scroll">
                      			<div class="card">
          
					            <div class="card-body">
					              <h5 class="card-title">Upcoming <span>| Timeline </span></h5>
									<ul class="timeline-3" id="upcoming">
								       
								       
								      </ul>
					            </div>
					          </div><!-- End Recent Activity -->
					
					         <!-- Recent Activity -->
					          <div class="card mt-4">
					            <div class="filter">
					              <a class="icon" href="#" ><i class="bi bi-three-dots"></i></a>
					            </div>
					
					            <div class="card-body">
					              <h5 class="card-title">Past <span>| Timeline</span></h5>
									<ul class="timeline-3" id="past">
								       
								      </ul>
					           
					
					            </div>
					          </div>
                      		</div>
                      	</div> --%>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                    </div>
                  </div>
                </div>

<jsp:include page="../legal/includes/footer.jsp"></jsp:include>
<script type="text/javascript" src="legal/includes/pages_script/case_management.js"></script> 
     <script src="https://uicdn.toast.com/tui.code-snippet/v1.5.2/tui-code-snippet.min.js"></script>
    <script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.min.js"></script>
    <script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.min.js"></script>
    <!-- <script src="https://uicdn.toast.com/tui-calendar/latest/tui-calendar.js"></script> -->
<script>
$(document).ready(function() {
	
	  localStorage.clear();

	let events=JSON.parse(localStorage.getItem('events')) || [];
	  
	  $.ajax({
			url:"legal_case_management_serv",
			method:"POST",
			data:{"request_type":"scheduled_events"},
			success:function(response){
				console.log(response);
			}
	  })
	
	 /* function addToCalenderSchedules(cases){
			
		 //If appearance is filled
		 if(!cases.is_appearance_filed){

	 		let events=JSON.parse(localStorage.getItem('events')) || [];
			 
	 		let url="case_details?suit_number="+cases.suit_number;
	 		let date_received=cases.date_received;
	 		console.log(date_received);
	 		
	 		let endDate = new Date(date_received);
	 		endDate.setDate(endDate.getDate()+ 7);
	 		console.log(endDate);
	 		endDate =formatDate(endDate);

			 const event_item={
					          "title": "File Appearance",
					          "url":url,
					          "start": date_received,
					          "end": endDate
					        };
			 events.push(event_item);
			 
			 localStorage.removeItem('events');
			 localStorage.setItem('events',JSON.stringify(events));
					        
		 }
		 
	 } */
	 
		 
	
    var templates = {
        popupIsAllDay: function() {
          return 'All Day';
        },
        popupStateFree: function() {
          return 'Free';
        },
        popupStateBusy: function() {
          return 'Busy';
        },
        titlePlaceholder: function() {
          return 'Subject';
        },
        locationPlaceholder: function() {
          return 'Location';
        },
        startDatePlaceholder: function() {
          return 'Start date';
        },
        endDatePlaceholder: function() {
          return 'End date';
        },
        popupSave: function() {
          console.log("save");

          return 'Save';
        },
        popupUpdate: function() {
          return 'Update';
        },
        popupDetailDate: function(isAllDay, start, end) {
          var isSameDate = moment(start).isSame(end);
          var endFormat = (isSameDate ? '' : 'YYYY.MM.DD ') + 'hh:mm a';

          if (isAllDay) {
            return moment(start).format('YYYY.MM.DD') + (isSameDate ? '' : ' - ' + moment(end).format('YYYY.MM.DD'));
          }

          return (moment(start).format('YYYY.MM.DD hh:mm a') + ' - ' + moment(end).format(endFormat));
        },
        popupDetailLocation: function(schedule) {
          return 'Location : ' + schedule.location;
        },
        popupDetailUser: function(schedule) {
          return 'User : ' + (schedule.attendees || []).join(', ');
        },
        popupDetailState: function(schedule) {
          return 'State : ' + schedule.state || 'Busy';
        },
        popupDetailRepeat: function(schedule) {
          return 'Repeat : ' + schedule.recurrenceRule;
        },
        popupDetailBody: function(schedule) {
          return 'Body : ' + schedule.body;
        },
        popupEdit: function() {
          return 'Edit';
        },
        popupDelete: function() {
          return 'Delete';
        }
};

	var WEEKLY_CUSTOM_THEME = {
	// week header 'dayname'
	'week.dayname.height': '41px',
	'week.dayname.borderTop': '1px solid #ddd',
	'week.dayname.borderBottom': '1px solid #ddd',
	'week.dayname.borderLeft': '1px solid #ddd',
	'week.dayname.paddingLeft': '5px',
	'week.dayname.backgroundColor': 'inherit',
	'week.dayname.textAlign': 'left',
	'week.today.color': '#b857d8',
	'week.pastDay.color': '#999',
	
	// week vertical panel 'vpanel'
	'week.vpanelSplitter.border': '1px solid #ddd',
	'week.vpanelSplitter.height': '3px',
	
	// week daygrid 'daygrid'
	'week.daygrid.borderRight': '1px solid #ddd',
	'week.daygrid.backgroundColor': 'inherit',
	
	'week.daygridLeft.width': '77px',
	'week.daygridLeft.backgroundColor': '#a8def74d',
	'week.daygridLeft.paddingRight': '5px',
	'week.daygridLeft.borderRight': '1px solid #ddd',
	
	'week.today.backgroundColor': '#b857d81f',
	'week.weekend.backgroundColor': 'inherit',
	
	// week timegrid 'timegrid'
	'week.timegridLeft.width': '77px',
	'week.timegridLeft.backgroundColor': '#03a9f44d',
	'week.timegridLeft.borderRight': '1px solid #ddd',
	'week.timegridLeft.fontSize': '12px',
	'week.timegridLeftTimezoneLabel.height': '51px',
	'week.timegridLeftAdditionalTimezone.backgroundColor': '#fdfdfd',
	
	'week.timegridOneHour.height': '48px',
	'week.timegridHalfHour.height': '24px',
	'week.timegridHalfHour.borderBottom': '1px dotted #f9f9f9',
	'week.timegridHorizontalLine.borderBottom': '1px solid #eee',
	
	'week.timegrid.paddingRight': '10px',
	'week.timegrid.borderRight': '1px solid #ddd',
	'week.timegridSchedule.borderRadius': '0',
	'week.timegridSchedule.paddingLeft': '0',
	
	'week.currentTime.color': '#135de6',
	'week.currentTime.fontSize': '12px',
	'week.currentTime.fontWeight': 'bold',
	
	'week.pastTime.color': '#808080',
	'week.pastTime.fontWeight': 'normal',
	
	'week.futureTime.color': '#333',
	'week.futureTime.fontWeight': 'normal',
	
	'week.currentTimeLinePast.border': '1px solid rgba(19, 93, 230, 0.3)',
	'week.currentTimeLineBullet.backgroundColor': '#135de6',
	'week.currentTimeLineToday.border': '1px solid #135de6',
	'week.currentTimeLineFuture.border': '1px solid #135de6',
	
	// week creation guide style
	'week.creationGuide.color': '#135de6',
	'week.creationGuide.fontSize': '12px',
	'week.creationGuide.fontWeight': 'bold',
	
	// week daygrid schedule style
	'week.dayGridSchedule.borderRadius': '0',
	'week.dayGridSchedule.height': '18px',
	'week.dayGridSchedule.marginTop': '2px',
	'week.dayGridSchedule.marginLeft': '10px',
	'week.dayGridSchedule.marginRight': '10px'
	};


    var Calendar = tui.Calendar;
    let mycalendar = new Calendar('#calendar', {
        defaultView: 'week',
        template: templates,
        useCreationPopup: true,
        useDetailPopup: true,
        taskView: true,
        sheduleView:true,
        week:{
            workweek:true
        },
        });

        mycalendar.createSchedules(); 
        
     /*   [
            {
                id: '1',
                calendarId: '1',
                title: 'my schedule',
                category: 'time',
                dueDateClass: '',
                start: '2022-06-27T22:30:00+09:00',
                end: '2022-09-27T22:30:00+09:00'
            },
            {
                id: '2',
                calendarId: '1',
                title: 'second schedule',
                category: 'time',
                dueDateClass: '',
                start: '2022-06-27T22:30:00+09:00',
                end: '2022-09-27T22:30:00+09:00',
                isReadOnly: true    // schedule is read-only
            }
      ]  */

       mycalendar.on({
		'clickSchedule': function(e) {
		    console.log('clickSchedule', e);
		},
		'beforeCreateSchedule': function(e) {
		    console.log('beforeCreateSchedule', e);
		    
		    const schedule =e;
		    
		    const scheduleTitle=e.title;
		    const scheduleLocation=e.location;
		    const scheduleStart=e.start._date;
		    const scheduleEnd=e.end._date;
		    
		    const scheduleObject={
                calendarId: '1',
                title: scheduleTitle,
                category: 'time',
                dueDateClass: '',
                start: scheduleStart,
                end: scheduleEnd,
                isReadOnly: true    
            }
		    
		    const scheduleObjectstr = JSON.stringify(scheduleObject);
		    
		    $.ajax({
				url:"legal_case_management",
				method:"POST",
				data:{"request_type":"schedule_insert",
					  "scheduleObject":scheduleObjectstr},
				success:function(response){
					//console.log(response);
				}
		  })
		    
		    
		    
		   
		},
		'beforeUpdateSchedule': function(e) {
		    console.log('beforeUpdateSchedule', e);
		    e.schedule.start = e.start;
		    e.schedule.end = e.end;
		    cal.updateSchedule(e.schedule.id, e.schedule.calendarId, e.schedule);
		},
		'beforeDeleteSchedule': function(e) {
		    console.log('beforeDeleteSchedule', e);
		    cal.deleteSchedule(e.schedule.id, e.schedule.calendarId);
		}
		});
		
        $(".move-prev").on("click",function(){
        	mycalendar.prev();
        })
		$(".move-next").on("click",function(){
        	mycalendar.next();
        })
        $(".move-today").on("click",function(){
        	mycalendar.today();
        })


});
</script>