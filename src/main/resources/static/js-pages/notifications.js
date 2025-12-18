$(document).ready(function() {
					
				
//GET ALL NOTIFICATIONS FOR USER
	$.ajax({
		type : "POST",
		url : "Case_Management_Serv",
		data : {
			request_type : 'get_lc_list_notifications',
		},
		cache : false,
		success : function(
				jobdetails) {

			console.log("User date:"+jobdetails);
			

			try {
				if(jobdetails !== 'Data Not Received') {
					var json_p = JSON.parse(jobdetails);
					let counter = json_p.counter;
					if (counter >= 1){
						counter = counter > 9 ? "9+" : counter;
						
						txt = document.createTextNode(counter);
						document.getElementById("notificationBadgeCounter").appendChild(txt);
						$("#notificationBadgeCounter").show();
						//console.log("kk:", json_p.data)
						var datalist = $("#queried_list");
						$(json_p.data).each(function(){
							datalist.append(`
							<li>
								<a class="text-secondary" style="text-decoration: none;" href="#" data-toggle="modal" data-target="#viewNotificationModal"
								data-notice_id="${this.notice_id}" data-notice_type="${this.notice_type}" data-status="${this.status}" data-case_number="${this.case_number}"
								data-job_number="${this.job_number}" data-created_by="${this.created_by}" data-details="${this.details}"
								data-date="${this.created_date}" data-transaction_number="${this.transaction_number}" data-notification_replies='${this.replies}'
								>
									<h6>${this.job_number}</h6>
									<h6>${this.details}</h6>
									<i class="small">${this.created_date}</i>
									<hr>
								</a>
							</li>
							`)
						})
	
						//$('#queriedNotificationModal').modal('show');
						$('#queriedNotificationModal').modal({backdrop: 'static', keyboard: false})
					}
					
					var datalist = $("#notificationssDropdown");
					//datalist.empty();
					$(json_p.data).each(function(){
						datalist.append(`
						<a class="dropdown-item d-flex align-items-center" href="#" data-toggle="modal" data-target="#viewNotificationModal"
						data-notice_id="${this.notice_id}" data-notice_type="${this.notice_type}" data-status="${this.status}" data-case_number="${this.case_number}"
						data-job_number="${this.job_number}" data-created_by="${this.created_by}" data-details="${this.details}"
						data-date="${this.created_date}" data-transaction_number="${this.transaction_number}" data-notification_replies='${this.replies}'
						
						>
						
						<div>
							<div class="small ${this.notice_type=='query' ? 'text-danger' : 'text-warning'}">${this.created_date} | ${this.job_number}</div>
						${this.status ==="active" ? `<span class="font-weight-bold">${this.details} </span>` : `${this.details}`}
						</div>
						</a>
						`)
						
					});
				}
			  }
			  catch (err) {
				console.log(err.name);
				console.log(err);
			}
			
		}
	});
	
	
	$('#viewNotificationModal').on('shown.bs.modal', function (e) {
		  //set the values in the form
		//console.log("jjj")

		$("#frmNotificationReply").hide();
		$("#notificationReplies").html("");
		$("#notice-frm-jobnumber").val($(e.relatedTarget).data('job_number'));
		$("#notice-frm-date").val($(e.relatedTarget).data('date'));
		$("#notice-frm-by").val($(e.relatedTarget).data('created_by'));
		$("#notice-frm-type").val($(e.relatedTarget).data('notice_type'));
		$("#notice-frm-details").val($(e.relatedTarget).data('details'));
		$("#notice-frm-status").val($(e.relatedTarget).data('status'));
		$("#nt_case_number").val($(e.relatedTarget).data('case_number'));
		$("#nt_transaction_number").val($(e.relatedTarget).data('transaction_number'));
		$("#nt_job_number").val($(e.relatedTarget).data('job_number'));
		$("#reply-frm-notice-id").val($(e.relatedTarget).data('notice_id'))
		
		//console.log("elem : "  + $(e.relatedTarget).data('notification_replies'));
		//get replies
		try{
			
			//console.log("elem : " , $(e.relatedTarget).data('notification_replies'));
			//let json_p = JSON.parse($(e.relatedTarget).data('notification_replies'));
			//console.log("json : " , json_p);
			$($(e.relatedTarget).data('notification_replies')).each(function(){
				$("#notificationReplies").append(`
						<blockquote class="blockquote">
						  <span class="mb-0 small">${this.reply_details}</span>
						  <footer class="blockquote-footer"><span class="small">by ${this.by}  <cite> on ${this.date} </cite></span></footer>
						</blockquote>`						
				);
			});
		}catch(erro){
			console.error(erro)
		}
	});
	
	$("#btnReplyNotification").on("click", function(){
		//console.log("clicked")
		$("#frmNotificationReply").show();
	});
	
	$("#frmNotificationReply").submit(function(e){
		e.preventDefault();
		let reply_message =$("#reply-frm-details").val();
		let reply_notice_id =$("#reply-frm-notice-id").val()
		
		//console.log("j: " +reply_message +  "l: " +reply_notice_id);
		if(reply_message ==='undifined'){
			alert("Message details is required")
		}else{
			
			/*----------------------------------*/
			if (confirm("Do you want to send this reply?") == true) {
			
			$.ajax({
				type : "POST",
				url : "Case_Management_Serv",
				data : {
					request_type : 'compliance_create_notice_reply',
					
						notice_id: reply_notice_id,
						message: reply_message
					
				},
				cache : false,
				success : function(
						result) {

							//console.log(result)
							alert('Reply sent successfully')

					$("#notificationReplies").html("");

						 //console.log("User date:"+jobdetails);
					try{
						$(JSON.parse(result)).each(function(){
							$("#notificationReplies").append(`
							<blockquote class="blockquote">
							<span class="mb-0 small">${this.reply_details}</span>
							<footer class="blockquote-footer"><span class="small">by ${this.by}  <cite> on ${this.date} </cite></span></footer>
						  </blockquote>`						
							);
						});
						$("#frmNotificationReply").hide();
						$("#reply-frm-details").val("");
						$("#reply-frm-notice-id").val("")
					}catch(e){
						console.error(e)
					}
					
				}
			});
		}
			
			/*----------------------------------*/
		}
	});


	//GET ALL MESSAGES FOR USER
	$.ajax({
		type : "POST",
		url : "Case_Management_Serv",
		data : {
			request_type : 'get_lc_list_messages',
		},
		cache : false,
		success : function(
				jobdetails) {

			console.log("User date:"+jobdetails);

			try {
				if(jobdetails !== 'Data Not Received') {
					var json_p = JSON.parse(jobdetails);
					let counter = json_p.counter;
					if (counter >= 1){
						counter = counter > 9 ? "9+" : counter;
						
						txt = document.createTextNode(counter);
						document.getElementById("messageBadgeCounter").appendChild(txt);
						$("#messageBadgeCounter").show();
						//console.log("kk:", json_p.data)
						// var datalist = $("#queried_list");
						// $(json_p.data).each(function(){
						// 	datalist.append(`
						// 	<li>
						// 		<a class="text-secondary" style="text-decoration: none;" href="#" data-toggle="modal" data-target="#viewNotificationModal"
						// 		data-notice_id="${this.notice_id}" data-notice_type="${this.notice_type}" data-status="${this.status}" data-case_number="${this.case_number}"
						// 		data-job_number="${this.job_number}" data-created_by="${this.created_by}" data-details="${this.details}"
						// 		data-date="${this.created_date}" data-transaction_number="${this.transaction_number}" data-notification_replies='${this.replies}'
						// 		>
						// 			<h6>${this.job_number}</h6>
						// 			<h6>${this.details}</h6>
						// 			<i class="small">${this.created_date}</i>
						// 			<hr>
						// 		</a>
						// 	</li>
						// 	`)
						// })
	
						//$('#queriedNotificationModal').modal('show');
						//$('#queriedNotificationModal').modal({backdrop: 'static', keyboard: false})
					}
					
					var datalist = $("#messageDropdown");
					//datalist.empty();
					$(json_p.data).each(function(){
						datalist.append(`
						<a class="dropdown-item d-flex align-items-center" href="#" data-toggle="modal" data-target="#viewMessageModal" data-message_id="${this.message_id}" data-sender_name="${this.sender_name}">
						<div class="dropdown-list-image mr-3">
							<img class="rounded-circle" src="../lib/assets/img/user.png" alt="">
							<div class="status-indicator"></div>
						</div>
						<div>
							<div class="text-truncate">${this.message}</div>
							<div class="small text-gray-500">${this.sender_name} · ${this.event_duration}</div>
						</div>
						</a>
						`)
						
					});
				}
			  }
			  catch (err) {
				console.log(err.name);
				console.log(err);
			}
			
		}
	});


	$('#viewMessageModal').on('shown.bs.modal', function (e) {
		
	  var message_id = $(e.relatedTarget).data('message_id');
	  $("#sender_name_text").val($(e.relatedTarget).data('sender_name'));
	  var userid = $('#userid_text').val()

	  let html = "";
	  
	 // message_id = message_id.replace('.0', '')

	  $.ajax({
		  type : "POST",
		  url : "Case_Management_Serv",
		  data : {
			  request_type : 'select_load_message_details',
			  message_id : message_id,
		  },
		  cache : false,
		  beforeSend : function() {
			  // $('#district').html('<img
			  // src="img/loading.gif"
			  // alt="" width="24"
			  // height="24">');
		  },
		  success : function(jobdetails) {

			  let json_result = JSON.parse(jobdetails);
			  //console.log(json_result)
			  if(json_result.success){
				  if(json_result.data !== null){
					  for(let i=0; i<json_result.data.length; i++){
						  let id= json_result.data[i].id;
						  let message_id= json_result.data[i].message_id;
						  let sent_by_id= json_result.data[i].sent_by_id;
						  let message= json_result.data[i].message;
						  let sender_name= json_result.data[i].sender_name;
						  let sent_date= json_result.data[i].sent_date;

						  html+= userid == sent_by_id ? '<div class="col-md-12">'
								  +'<div class="card mb-2 d-flex justify-content-start">'
									  +'<div class="card-body">'
										  +'<span>'+message+'</span><br><br>'
										  +'<i><small>From: Me</small></i><br>'
										  +'<i><small> Date: '+sent_date+'</small></i>'
									  +'</div>'
								  +'</div>'
							  +'</div>' : '<div class="col-md-12">'
							  +'<div class="card mb-2 bg-info">'
								  +'<div class="card-body">'
									  +'<span>'+message+'</span><br><br>'
									  +'<i><small>From: '+sender_name+'</small></i><br>'
									  +'<i><small> Date: '+sent_date+'</small></i>'
								  +'</div>'
							  +'</div>'
						  +'</div>'
					  }

					  document.getElementById("message_alert_details").innerHTML = html;
				  }
			  }

		  }
	  })
  	});

	
	 
	//End function document ready
});