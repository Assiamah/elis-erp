$(function(){
	
	$("#purpose").on('change', function(e){
		e.preventDefault();
		
		let purpose = $('#purpose').find(":selected").val();
		
		if (purpose == 2) {
			$('#purpose_div').addClass("d-none");
		} else {
			$('#purpose_div').removeClass("d-none");
		}
	});
	
	$("#cica_reports_form").on('submit',function(e){
			e.preventDefault();
			
			let dataSet = [];
			let num = "";
			
			$("#apply_filter").prop('disabled', true);
			$("#apply_filter").text("Loading...");
			
			let start_date=$('input[name="start_date"]').val();
			let end_date=$('input[name="end_date"]').val();
			
			let purpose=$('#purpose').find(":selected").val();
			let division=$('#division').find(":selected").text();
			let region=$('#region_id').find(":selected").val();
			let status=$('#status').find(":selected").val();

			region = region.replace(".0", "");
			
			//console.log(purpose)

			$('#_show_column').removeClass('d-none');
			
		$.ajax({
			type:"POST",
			url:"cica_dashboard_serv",
			data:{"request_type":"reports",
				  "start_date":start_date,
				  "end_date":end_date,
				  "purpose":purpose,
				  "region":region,
				  "division":division,
				  "status":status
			},
			success:function(response){
				
			 console.log(response);
			 
			 let json_result = JSON.parse(response);
			 
			 /*let purpose = $('#purpose').find(":selected").val();
			 let division = $('#division').find(":selected").text();
			 let region = $('#region_id').find(":selected").val();*/
			 
			 console.log(purpose, region, status)
			 
			 switch(purpose) {
				 case '1':
					 
					 if(region == '0') {
						 if(status == '4') {
							 if(division == 'ALL') {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').removeClass('d-none');
								 
								 $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML=total;
										
									 let open = 0;
									 open = json_result.open;
									 document.getElementById("open").innerHTML=open;
										
									 let hold = 0;
									 hold = json_result.hold;
									 document.getElementById("hold").innerHTML=hold;
										
									 let pending = 0;
									 pending = json_result.pending;
									 document.getElementById("pending").innerHTML=pending;
										
									 let resolved = 0;
									 resolved = json_result.resolved;
									 document.getElementById("resolved").innerHTML=resolved;
								        
								     var pvlmd_open= json_result.pvlmd_open;
								     var pvlmd_pending= json_result.pvlmd_pending;
								     var pvlmd_hold= json_result.pvlmd_hold;
								     var pvlmd_resolved= json_result.pvlmd_resolved;
								        
								     var lrd_open= json_result.lrd_open;
								     var lrd_pending= json_result.lrd_pending;
								     var lrd_hold= json_result.lrd_hold;
								     var lrd_resolved= json_result.lrd_resolved;
								        
								     var smd_open= json_result.smd_open;
								     var smd_pending= json_result.smd_pending;
								     var smd_hold= json_result.smd_hold;
								     var smd_resolved= json_result.smd_resolved;
								        
								     var lvd_open= json_result.lvd_open;
								     var lvd_pending= json_result.lvd_pending;
								     var lvd_hold= json_result.lvd_hold;
								     var lvd_resolved= json_result.lvd_resolved;
								        
								     var corporate_open= json_result.corporate_open;
								     var corporate_pending= json_result.corporate_pending;
								     var corporate_hold= json_result.corporate_hold;
								     var corporate_resolved= json_result.corporate_resolved;
								     
								    var trace1 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_open, lrd_open, smd_open, lvd_open, corporate_open],
									  name: 'Open',
									  type: 'bar'
									};
									
									var trace2 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_pending, lrd_pending, smd_pending, lvd_pending, corporate_pending],
									  name: 'Pending',
									  type: 'bar'
									};
									
									var trace3 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_resolved, lrd_resolved, smd_resolved, lvd_resolved, corporate_resolved],
									  name: 'Resolved',
									  type: 'bar'
									};
									
									var trace4 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_hold, lrd_hold, smd_hold, lvd_hold, corporate_hold],
									  name: 'On Hold',
									  type: 'bar'
									};
									
									var data = [trace1, trace2, trace3, trace4];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
					
								}
							 }
							 else {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').removeClass('d-none');
								 
								 $('#cica_chart').removeClass('d-none');
									 
								 if(json_result.success){
									 
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML=total;
										
									 let open = 0;
									 open = json_result.open;
									 document.getElementById("open").innerHTML=open;
										
									 let hold = 0;
									 hold = json_result.hold;
									 document.getElementById("hold").innerHTML=hold;
										
									 let pending = 0;
									 pending = json_result.pending;
									 document.getElementById("pending").innerHTML=pending;
										
									 let resolved = 0;
									 resolved = json_result.resolved;
									 document.getElementById("resolved").innerHTML=resolved;
									 
								    var trace1 = {
									  x: ['Open', 'Pending', 'On Hold', 'Resolved'],
									  y: [open, pending, hold, resolved],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
							 }
						 }
						 else {
							 
							 if(division == 'ALL') {
									 
								 $('#div_division').removeClass('d-none');
								 $('#div_status').addClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total_d").innerHTML = total;
										
									 let pvlmd = 0;
									 pvlmd = json_result.pvlmd;
									 document.getElementById("pvlmd").innerHTML = pvlmd;
										
									 let smd = 0;
									 smd = json_result.smd;
									 document.getElementById("smd").innerHTML = smd;
										
									 let lrd = 0;
									 lrd = json_result.lrd;
									 document.getElementById("lrd").innerHTML = lrd;
										
									 let lvd = 0;
									 lvd = json_result.lvd;
									 document.getElementById("lvd").innerHTML = lvd;
									 
									 let corporate = 0;
									 corporate = json_result.corporate;
									 document.getElementById("corporate").innerHTML = corporate;
									 
								    var trace1 = {
									  x: ['PVMLD', 'SMD', 'LRD', 'LVD', 'CORPORATE'],
									  y: [pvlmd, smd, lrd, lvd, corporate],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
							 }
							 else {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').addClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML = total;
										
									 let gar = 0;
									 gar = json_result.gar;
									 //document.getElementById("gar").innerHTML = gar;
										
									 let wer = 0;
									 wer = json_result.wer;
									 //document.getElementById("wer").innerHTML = wer;
									 
									 let vol = 0;
									 vol = json_result.vol;
									 //document.getElementById("vol").innerHTML = vol;
										
									 let eas = 0;
									 eas = json_result.lrd;
									 //document.getElementById("eas").innerHTML = eas;
										
									 let ash = 0;
									 ash = json_result.ash;
									 //document.getElementById("ash").innerHTML = ash;
									 
									 let cen = 0;
									 cen = json_result.cen;
									 //document.getElementById("cen").innerHTML = cen;
									 
									 let nor = 0;
									 nor = json_result.nor;
									 //document.getElementById("nor").innerHTML = nor;
										
									 let uea = 0;
									 uea = json_result.uea;
									 //document.getElementById("uea").innerHTML = uea;
										
									 let uws = 0;
									 uws = json_result.lrd;
									 //document.getElementById("uws").innerHTML = uws;
										
									 let oti = 0;
									 oti = json_result.oti;
									 //document.getElementById("oti").innerHTML = oti;
									 
									 let boe = 0;
									 boe = json_result.boe;
									 //document.getElementById("boe").innerHTML = boe;
									 
									 let aha = 0;
									 aha = json_result.aha;
									 //document.getElementById("aha").innerHTML = aha;
									 
									 let bon = 0;
									 bon = json_result.bon;
									 //document.getElementById("bon").innerHTML = bon;
										
									 let nea = 0;
									 uea = json_result.nea;
									 //document.getElementById("nea").innerHTML = nea;
										
									 let sav = 0;
									 sav = json_result.sav;
									 //document.getElementById("sav").innerHTML = sav;
										
									 let wsn = 0;
									 wsn = json_result.wsn;
									 //document.getElementById("wsn").innerHTML = wsn;
									 
								    var trace1 = {
									  x: ['Greater Accra', 'Western', 'Volta', 'Eastern', 'Ashanti', 'Central', 'Northern', 'Upper East', 'Upper West', 'Oti', 'Bono East', 'Ahafo', 'Bono', 'North East', 'Savannah', 'Western North'],
									  y: [gar, wer, vol, eas, ash, cen, nor, uea, uws, oti, boe, aha, bon, nea, sav, wsn],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
								 
							 }
							 
						 }
					 } else {
						 if(status == '4') {
							 if(division == 'ALL') {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').removeClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML=total;
										
									 let open = 0;
									 open = json_result.open;
									 document.getElementById("open").innerHTML=open;
										
									 let hold = 0;
									 hold = json_result.hold;
									 document.getElementById("hold").innerHTML=hold;
										
									 let pending = 0;
									 pending = json_result.pending;
									 document.getElementById("pending").innerHTML=pending;
										
									 let resolved = 0;
									 resolved = json_result.resolved;
									 document.getElementById("resolved").innerHTML=resolved;
								        
								     var pvlmd_open= json_result.pvlmd_open;
								     var pvlmd_pending= json_result.pvlmd_pending;
								     var pvlmd_hold= json_result.pvlmd_hold;
								     var pvlmd_resolved= json_result.pvlmd_resolved;
								        
								     var lrd_open= json_result.lrd_open;
								     var lrd_pending= json_result.lrd_pending;
								     var lrd_hold= json_result.lrd_hold;
								     var lrd_resolved= json_result.lrd_resolved;
								        
								     var smd_open= json_result.smd_open;
								     var smd_pending= json_result.smd_pending;
								     var smd_hold= json_result.smd_hold;
								     var smd_resolved= json_result.smd_resolved;
								        
								     var lvd_open= json_result.lvd_open;
								     var lvd_pending= json_result.lvd_pending;
								     var lvd_hold= json_result.lvd_hold;
								     var lvd_resolved= json_result.lvd_resolved;
								        
								     var corporate_open= json_result.corporate_open;
								     var corporate_pending= json_result.corporate_pending;
								     var corporate_hold= json_result.corporate_hold;
								     var corporate_resolved= json_result.corporate_resolved;
								     
								    var trace1 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_open, lrd_open, smd_open, lvd_open, corporate_open],
									  name: 'Open',
									  type: 'bar'
									};
									
									var trace2 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_pending, lrd_pending, smd_pending, lvd_pending, corporate_pending],
									  name: 'Pending',
									  type: 'bar'
									};
									
									var trace3 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_resolved, lrd_resolved, smd_resolved, lvd_resolved, corporate_resolved],
									  name: 'Resolved',
									  type: 'bar'
									};
									
									var trace4 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_hold, lrd_hold, smd_hold, lvd_hold, corporate_hold],
									  name: 'On Hold',
									  type: 'bar'
									};
									
									var data = [trace1, trace2, trace3, trace4];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
					
								}
								 
							 }
							 else {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').removeClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML=total;
										
									 let open = 0;
									 open = json_result.open;
									 document.getElementById("open").innerHTML=open;
										
									 let hold = 0;
									 hold = json_result.hold;
									 document.getElementById("hold").innerHTML=hold;
										
									 let pending = 0;
									 pending = json_result.pending;
									 document.getElementById("pending").innerHTML=pending;
										
									 let resolved = 0;
									 resolved = json_result.resolved;
									 document.getElementById("resolved").innerHTML=resolved;
									 
								    var trace1 = {
									  x: ['Open', 'Pending', 'On Hold', 'Resolved'],
									  y: [open, pending, hold, resolved],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
								 
							 }
						 }
						 else {
							 if(division == 'ALL') {
								 
								 $('#div_division').removeClass('d-none');
								 $('#div_status').addClass('d-none');
								 
								 $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total_d").innerHTML = total;
										
									 let pvlmd = 0;
									 pvlmd = json_result.pvlmd;
									 document.getElementById("pvlmd").innerHTML = pvlmd;
										
									 let smd = 0;
									 smd = json_result.smd;
									 document.getElementById("smd").innerHTML = smd;
										
									 let lrd = 0;
									 lrd = json_result.lrd;
									 document.getElementById("lrd").innerHTML = lrd;
										
									 let lvd = 0;
									 lvd = json_result.lvd;
									 document.getElementById("lvd").innerHTML = lvd;
									 
									 let corporate = 0;
									 corporate = json_result.corporate;
									 document.getElementById("corporate").innerHTML = corporate;
									 
								    var trace1 = {
									  x: ['PVMLD', 'SMD', 'LRD', 'LVD', 'CORPORATE'],
									  y: [pvlmd, smd, lrd, lvd, corporate],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
								 
							 }
							 else {
								 
								 $('#cica_chart').addClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML = total;
										
									 
								}
								 
							 }
						 }
					 }
					 
					 
					$('#service_tbl').show()
					$('#other_service_tbl').hide()
					
					if(json_result.data !== null){
							
						for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                num = (+num + 1);
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
							let phone= json_result.data[i].client_phone;
			              	let email= json_result.data[i].client_email;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let division= json_result.data[i].division;
			              	let dcu_reply= json_result.data[i].dcu_reply;
			              	let focal_reply= json_result.data[i].focal_reply;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));		               	
			              	let created_by=json_result.data[i].created_by;;
			            
			                
			               html.push(num);
			               html.push(ticket_id);
			               html.push(name);
						   html.push(phone); 
			               html.push(email);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(division); 
			               html.push(region_name); 
			               html.push(created_by);
			               html.push(date_created);
		
			               dataSet.push(html);
		                
	            		}

					}
						
					$('#table_list').DataTable().clear().destroy();
						
					$('#table_list').DataTable({ 
						data: dataSet,
						/*"createdRow": function(row,data,dataIndex){
							if(data[10]){
								$(row).addClass('greenClass');
							}
						},*/
						dom: 'Bfrtip',
				        buttons: [
				            'copy', 'csv', 'excel', 'print',
				            {
				                extend: 'pdfHtml5',
				                orientation: 'landscape',
				                title: 'CAC - Service Enquiry Reports',
				                //titleAttr: 'Tabelle als PDF exportieren',
				                pageSize: 'A4'
				            }
				        ]
					}).draw();
									
					 break;
					 
				case '2':
					
					$('#other_service_tbl').show()
					$('#service_tbl').hide()
					
					$('#div_division').addClass('d-none');
					$('#div_status').addClass('d-none');
					
					$('#cica_chart').addClass('d-none');
					
					if(json_result.data !== null){
						
						let total = 0;
						total = json_result.total;
						document.getElementById("total").innerHTML=total;
						
						let open = 0;
						open = json_result.open;
						document.getElementById("open").innerHTML=open;
						
						let hold = 0;
						hold = json_result.hold;
						document.getElementById("hold").innerHTML=hold;
						
						let pending = 0;
						pending = json_result.pending;
						document.getElementById("pending").innerHTML=pending;
						
						let resolved = 0;
						resolved = json_result.resolved;
						document.getElementById("resolved").innerHTML=resolved;
							
						for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                num = (+num + 1);
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let phone= json_result.data[i].client_phone;
			              	let email= json_result.data[i].client_email;
			              	let reference_source= json_result.data[i].reference_source;
			              	let created_by= json_result.data[i].created_by;
			              	let milestone_status= json_result.data[i].milestone_status;
			              	let region= json_result.data[i].region_name;
			              	let nature_of_enquiry= json_result.data[i].nature_of_enquiry;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));   
							   let completed_date=convertDate(json_result.data[i].sent_date.slice(0,10));
			            
			                
			               html.push(num);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(phone); 
			               html.push(email);
			               html.push(reference_source); 
			               html.push(milestone_status);
			               html.push(nature_of_enquiry);
			               html.push(region);
			               html.push(created_by);
			               html.push(date_created);
						   html.push(completed_date);
		
			               dataSet.push(html);
		                
	            		}

					}
						
					$('#other_table_list').DataTable().clear().destroy();
						
					$('#other_table_list').DataTable({ 
						data: dataSet,
						dom: 'Bfrtip',
				        buttons: [
				            'copy', 'csv', 'excel', 'print',
				            {
				                extend: 'pdfHtml5',
				                orientation: 'landscape',
				                title: 'CICA - Other Enquiry Reports',
				                //titleAttr: 'Tabelle als PDF exportieren',
				                pageSize: 'A4'
				            }
				        ]
					}).draw();
					
					break;
					
				case '3':
					
					if(region == '0') {
						 if(status == '4') {
							 if(division == 'ALL') {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').removeClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML=total;
										
									 let open = 0;
									 open = json_result.open;
									 document.getElementById("open").innerHTML=open;
										
									 let hold = 0;
									 hold = json_result.hold;
									 document.getElementById("hold").innerHTML=hold;
										
									 let pending = 0;
									 pending = json_result.pending;
									 document.getElementById("pending").innerHTML=pending;
										
									 let resolved = 0;
									 resolved = json_result.resolved;
									 document.getElementById("resolved").innerHTML=resolved;
								        
								     var pvlmd_open= json_result.pvlmd_open;
								     var pvlmd_pending= json_result.pvlmd_pending;
								     var pvlmd_hold= json_result.pvlmd_hold;
								     var pvlmd_resolved= json_result.pvlmd_resolved;
								        
								     var lrd_open= json_result.lrd_open;
								     var lrd_pending= json_result.lrd_pending;
								     var lrd_hold= json_result.lrd_hold;
								     var lrd_resolved= json_result.lrd_resolved;
								        
								     var smd_open= json_result.smd_open;
								     var smd_pending= json_result.smd_pending;
								     var smd_hold= json_result.smd_hold;
								     var smd_resolved= json_result.smd_resolved;
								        
								     var lvd_open= json_result.lvd_open;
								     var lvd_pending= json_result.lvd_pending;
								     var lvd_hold= json_result.lvd_hold;
								     var lvd_resolved= json_result.lvd_resolved;
								        
								     var corporate_open= json_result.corporate_open;
								     var corporate_pending= json_result.corporate_pending;
								     var corporate_hold= json_result.corporate_hold;
								     var corporate_resolved= json_result.corporate_resolved;
								     
								    var trace1 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_open, lrd_open, smd_open, lvd_open, corporate_open],
									  name: 'Open',
									  type: 'bar'
									};
									
									var trace2 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_pending, lrd_pending, smd_pending, lvd_pending, corporate_pending],
									  name: 'Pending',
									  type: 'bar'
									};
									
									var trace3 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_resolved, lrd_resolved, smd_resolved, lvd_resolved, corporate_resolved],
									  name: 'Resolved',
									  type: 'bar'
									};
									
									var trace4 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_hold, lrd_hold, smd_hold, lvd_hold, corporate_hold],
									  name: 'On Hold',
									  type: 'bar'
									};
									
									var data = [trace1, trace2, trace3, trace4];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
					
								}
							 }
							 else {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').removeClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML=total;
										
									 let open = 0;
									 open = json_result.open;
									 document.getElementById("open").innerHTML=open;
										
									 let hold = 0;
									 hold = json_result.hold;
									 document.getElementById("hold").innerHTML=hold;
										
									 let pending = 0;
									 pending = json_result.pending;
									 document.getElementById("pending").innerHTML=pending;
										
									 let resolved = 0;
									 resolved = json_result.resolved;
									 document.getElementById("resolved").innerHTML=resolved;
									 
								    var trace1 = {
									  x: ['Open', 'Pending', 'On Hold', 'Resolved'],
									  y: [open, pending, hold, resolved],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
							 }
						 }
						 else {
							 
							 if(division == 'ALL') {
								 
								 $('#div_division').removeClass('d-none');
								 $('#div_status').addClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML = total;
										
									 let pvlmd = 0;
									 pvlmd = json_result.pvlmd;
									 document.getElementById("pvlmd").innerHTML = pvlmd;
										
									 let smd = 0;
									 smd = json_result.smd;
									 document.getElementById("smd").innerHTML = smd;
										
									 let lrd = 0;
									 lrd = json_result.lrd;
									 document.getElementById("lrd").innerHTML = lrd;
										
									 let lvd = 0;
									 lvd = json_result.lvd;
									 document.getElementById("lvd").innerHTML = lvd;
									 
									 let corporate = 0;
									 corporate = json_result.corporate;
									 document.getElementById("corporate").innerHTML = corporate;
									 
								    var trace1 = {
									  x: ['PVMLD', 'SMD', 'LRD', 'LVD', 'CORPORATE'],
									  y: [pvlmd, smd, lrd, lvd, corporate],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
							 }
							 else {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').addClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML = total;
										
									 let gar = 0;
									 gar = json_result.gar;
									 //document.getElementById("gar").innerHTML = gar;
										
									 let wer = 0;
									 wer = json_result.wer;
									 //document.getElementById("wer").innerHTML = wer;
									 
									 let vol = 0;
									 vol = json_result.vol;
									 //document.getElementById("vol").innerHTML = vol;
										
									 let eas = 0;
									 eas = json_result.lrd;
									 //document.getElementById("eas").innerHTML = eas;
										
									 let ash = 0;
									 ash = json_result.ash;
									 //document.getElementById("ash").innerHTML = ash;
									 
									 let cen = 0;
									 cen = json_result.cen;
									 //document.getElementById("cen").innerHTML = cen;
									 
									 let nor = 0;
									 nor = json_result.nor;
									 //document.getElementById("nor").innerHTML = nor;
										
									 let uea = 0;
									 uea = json_result.uea;
									 //document.getElementById("uea").innerHTML = uea;
										
									 let uws = 0;
									 uws = json_result.lrd;
									 //document.getElementById("uws").innerHTML = uws;
										
									 let oti = 0;
									 oti = json_result.oti;
									 //document.getElementById("oti").innerHTML = oti;
									 
									 let boe = 0;
									 boe = json_result.boe;
									 //document.getElementById("boe").innerHTML = boe;
									 
									 let aha = 0;
									 aha = json_result.aha;
									 //document.getElementById("aha").innerHTML = aha;
									 
									 let bon = 0;
									 bon = json_result.bon;
									 //document.getElementById("bon").innerHTML = bon;
										
									 let nea = 0;
									 uea = json_result.nea;
									 //document.getElementById("nea").innerHTML = nea;
										
									 let sav = 0;
									 sav = json_result.sav;
									 //document.getElementById("sav").innerHTML = sav;
										
									 let wsn = 0;
									 wsn = json_result.wsn;
									 //document.getElementById("wsn").innerHTML = wsn;
									 
								    var trace1 = {
									  x: ['Greater Accra', 'Western', 'Volta', 'Eastern', 'Ashanti', 'Central', 'Northern', 'Upper East', 'Upper West', 'Oti', 'Bono East', 'Ahafo', 'Bono', 'North East', 'Savannah', 'Western North'],
									  y: [gar, wer, vol, eas, ash, cen, nor, uea, uws, oti, boe, aha, bon, nea, sav, wsn],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
								 
							 }
							 
						 }
					 } else {
						 if(status == '4') {
							 if(division == 'ALL') {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').removeClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML=total;
										
									 let open = 0;
									 open = json_result.open;
									 document.getElementById("open").innerHTML=open;
										
									 let hold = 0;
									 hold = json_result.hold;
									 document.getElementById("hold").innerHTML=hold;
										
									 let pending = 0;
									 pending = json_result.pending;
									 document.getElementById("pending").innerHTML=pending;
										
									 let resolved = 0;
									 resolved = json_result.resolved;
									 document.getElementById("resolved").innerHTML=resolved;
								        
								     var pvlmd_open= json_result.pvlmd_open;
								     var pvlmd_pending= json_result.pvlmd_pending;
								     var pvlmd_hold= json_result.pvlmd_hold;
								     var pvlmd_resolved= json_result.pvlmd_resolved;
								        
								     var lrd_open= json_result.lrd_open;
								     var lrd_pending= json_result.lrd_pending;
								     var lrd_hold= json_result.lrd_hold;
								     var lrd_resolved= json_result.lrd_resolved;
								        
								     var smd_open= json_result.smd_open;
								     var smd_pending= json_result.smd_pending;
								     var smd_hold= json_result.smd_hold;
								     var smd_resolved= json_result.smd_resolved;
								        
								     var lvd_open= json_result.lvd_open;
								     var lvd_pending= json_result.lvd_pending;
								     var lvd_hold= json_result.lvd_hold;
								     var lvd_resolved= json_result.lvd_resolved;
								        
								     var corporate_open= json_result.corporate_open;
								     var corporate_pending= json_result.corporate_pending;
								     var corporate_hold= json_result.corporate_hold;
								     var corporate_resolved= json_result.corporate_resolved;
								     
								    var trace1 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_open, lrd_open, smd_open, lvd_open, corporate_open],
									  name: 'Open',
									  type: 'bar'
									};
									
									var trace2 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_pending, lrd_pending, smd_pending, lvd_pending, corporate_pending],
									  name: 'Pending',
									  type: 'bar'
									};
									
									var trace3 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_resolved, lrd_resolved, smd_resolved, lvd_resolved, corporate_resolved],
									  name: 'Resolved',
									  type: 'bar'
									};
									
									var trace4 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_hold, lrd_hold, smd_hold, lvd_hold, corporate_hold],
									  name: 'On Hold',
									  type: 'bar'
									};
									
									var data = [trace1, trace2, trace3, trace4];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
					
								}
								 
							 }
							 else {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').removeClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML=total;
										
									 let open = 0;
									 open = json_result.open;
									 document.getElementById("open").innerHTML=open;
										
									 let hold = 0;
									 hold = json_result.hold;
									 document.getElementById("hold").innerHTML=hold;
										
									 let pending = 0;
									 pending = json_result.pending;
									 document.getElementById("pending").innerHTML=pending;
										
									 let resolved = 0;
									 resolved = json_result.resolved;
									 document.getElementById("resolved").innerHTML=resolved;
									 
								    var trace1 = {
									  x: ['Open', 'Pending', 'On Hold', 'Resolved'],
									  y: [open, pending, hold, resolved],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
								 
							 }
						 }
						 else {
							 if(division == 'ALL') {
								 
								 $('#div_division').removeClass('d-none');
								 $('#div_status').addClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total_d").innerHTML = total;
										
									 let pvlmd = 0;
									 pvlmd = json_result.pvlmd;
									 document.getElementById("pvlmd").innerHTML = pvlmd;
										
									 let smd = 0;
									 smd = json_result.smd;
									 document.getElementById("smd").innerHTML = smd;
										
									 let lrd = 0;
									 lrd = json_result.lrd;
									 document.getElementById("lrd").innerHTML = lrd;
										
									 let lvd = 0;
									 lvd = json_result.lvd;
									 document.getElementById("lvd").innerHTML = lvd;
									 
									 let corporate = 0;
									 corporate = json_result.corporate;
									 document.getElementById("corporate").innerHTML = corporate;
									 
								    var trace1 = {
									  x: ['PVMLD', 'SMD', 'LRD', 'LVD', 'CORPORATE'],
									  y: [pvlmd, smd, lrd, lvd, corporate],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
								 
							 }
							 else {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').addClass('d-none');
								 
								  $('#cica_chart').addClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML = total;
										
									 
								}
								 
							 }
						 }
					 }
					 
					 
					$('#service_tbl').show()
					$('#other_service_tbl').hide()
					
					if(json_result.data !== null){
							
						for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                num = (+num + 1);
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
							let phone= json_result.data[i].client_phone;
			              	let email= json_result.data[i].client_email;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let division= json_result.data[i].division;
			              	let dcu_reply= json_result.data[i].dcu_reply;
			              	let focal_reply= json_result.data[i].focal_reply;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));		   
							   let completed_date=convertDate(json_result.data[i].sent_date.slice(0,10));	            	
			              	let created_by=json_result.data[i].created_by;;
			            
			                
			               html.push(num);
			               html.push(ticket_id);
			               html.push(name);
						   html.push(phone); 
			               html.push(email);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(division); 
			               html.push(region_name); 
			               html.push(created_by);
			               html.push(date_created);
						   html.push(completed_date);
		
			               dataSet.push(html);
		                
	            		}

					}
						
					$('#table_list').DataTable().clear().destroy();
						
					$('#table_list').DataTable({ 
						data: dataSet,
						/*"createdRow": function(row,data,dataIndex){
							if(data[10]){
								$(row).addClass('greenClass');
							}
						},*/
						dom: 'Bfrtip',
				        buttons: [
				            'copy', 'csv', 'excel', 'print',
				            {
				                extend: 'pdfHtml5',
				                orientation: 'landscape',
				                title: 'CICA - Service Complaint Reports',
				                pageSize: 'A4'
				            }
				        ]
					}).draw();
					
					break;
					
				default:
					
					if(region == '0') {
						 if(status == '4') {
							 if(division == 'ALL') {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').removeClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML=total;
										
									 let open = 0;
									 open = json_result.open;
									 document.getElementById("open").innerHTML=open;
										
									 let hold = 0;
									 hold = json_result.hold;
									 document.getElementById("hold").innerHTML=hold;
										
									 let pending = 0;
									 pending = json_result.pending;
									 document.getElementById("pending").innerHTML=pending;
										
									 let resolved = 0;
									 resolved = json_result.resolved;
									 document.getElementById("resolved").innerHTML=resolved;
								        
								     var pvlmd_open= json_result.pvlmd_open;
								     var pvlmd_pending= json_result.pvlmd_pending;
								     var pvlmd_hold= json_result.pvlmd_hold;
								     var pvlmd_resolved= json_result.pvlmd_resolved;
								        
								     var lrd_open= json_result.lrd_open;
								     var lrd_pending= json_result.lrd_pending;
								     var lrd_hold= json_result.lrd_hold;
								     var lrd_resolved= json_result.lrd_resolved;
								        
								     var smd_open= json_result.smd_open;
								     var smd_pending= json_result.smd_pending;
								     var smd_hold= json_result.smd_hold;
								     var smd_resolved= json_result.smd_resolved;
								        
								     var lvd_open= json_result.lvd_open;
								     var lvd_pending= json_result.lvd_pending;
								     var lvd_hold= json_result.lvd_hold;
								     var lvd_resolved= json_result.lvd_resolved;
								        
								     var corporate_open= json_result.corporate_open;
								     var corporate_pending= json_result.corporate_pending;
								     var corporate_hold= json_result.corporate_hold;
								     var corporate_resolved= json_result.corporate_resolved;
								     
								    var trace1 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_open, lrd_open, smd_open, lvd_open, corporate_open],
									  name: 'Open',
									  type: 'bar'
									};
									
									var trace2 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_pending, lrd_pending, smd_pending, lvd_pending, corporate_pending],
									  name: 'Pending',
									  type: 'bar'
									};
									
									var trace3 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_resolved, lrd_resolved, smd_resolved, lvd_resolved, corporate_resolved],
									  name: 'Resolved',
									  type: 'bar'
									};
									
									var trace4 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_hold, lrd_hold, smd_hold, lvd_hold, corporate_hold],
									  name: 'On Hold',
									  type: 'bar'
									};
									
									var data = [trace1, trace2, trace3, trace4];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
					
								}
							 }
							 else {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').removeClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML=total;
										
									 let open = 0;
									 open = json_result.open;
									 document.getElementById("open").innerHTML=open;
										
									 let hold = 0;
									 hold = json_result.hold;
									 document.getElementById("hold").innerHTML=hold;
										
									 let pending = 0;
									 pending = json_result.pending;
									 document.getElementById("pending").innerHTML=pending;
										
									 let resolved = 0;
									 resolved = json_result.resolved;
									 document.getElementById("resolved").innerHTML=resolved;
									 
								    var trace1 = {
									  x: ['Open', 'Pending', 'On Hold', 'Resolved'],
									  y: [open, pending, hold, resolved],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
							 }
						 }
						 else {
							 
							 if(division == 'ALL') {
								 
								 $('#div_division').removeClass('d-none');
								 $('#div_status').addClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total_d").innerHTML = total;
										
									 let pvlmd = 0;
									 pvlmd = json_result.pvlmd;
									 document.getElementById("pvlmd").innerHTML = pvlmd;
										
									 let smd = 0;
									 smd = json_result.smd;
									 document.getElementById("smd").innerHTML = smd;
										
									 let lrd = 0;
									 lrd = json_result.lrd;
									 document.getElementById("lrd").innerHTML = lrd;
										
									 let lvd = 0;
									 lvd = json_result.lvd;
									 document.getElementById("lvd").innerHTML = lvd;
									 
									 let corporate = 0;
									 corporate = json_result.corporate;
									 document.getElementById("corporate").innerHTML = corporate;
									 
								    var trace1 = {
									  x: ['PVMLD', 'SMD', 'LRD', 'LVD', 'CORPORATE'],
									  y: [pvlmd, smd, lrd, lvd, corporate],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
							 }
							 else {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').addClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML = total;
										
									 let gar = 0;
									 gar = json_result.gar;
									 //document.getElementById("gar").innerHTML = gar;
										
									 let wer = 0;
									 wer = json_result.wer;
									 //document.getElementById("wer").innerHTML = wer;
									 
									 let vol = 0;
									 vol = json_result.vol;
									 //document.getElementById("vol").innerHTML = vol;
										
									 let eas = 0;
									 eas = json_result.lrd;
									 //document.getElementById("eas").innerHTML = eas;
										
									 let ash = 0;
									 ash = json_result.ash;
									 //document.getElementById("ash").innerHTML = ash;
									 
									 let cen = 0;
									 cen = json_result.cen;
									 //document.getElementById("cen").innerHTML = cen;
									 
									 let nor = 0;
									 nor = json_result.nor;
									 //document.getElementById("nor").innerHTML = nor;
										
									 let uea = 0;
									 uea = json_result.uea;
									 //document.getElementById("uea").innerHTML = uea;
										
									 let uws = 0;
									 uws = json_result.lrd;
									 //document.getElementById("uws").innerHTML = uws;
										
									 let oti = 0;
									 oti = json_result.oti;
									 //document.getElementById("oti").innerHTML = oti;
									 
									 let boe = 0;
									 boe = json_result.boe;
									 //document.getElementById("boe").innerHTML = boe;
									 
									 let aha = 0;
									 aha = json_result.aha;
									 //document.getElementById("aha").innerHTML = aha;
									 
									 let bon = 0;
									 bon = json_result.bon;
									 //document.getElementById("bon").innerHTML = bon;
										
									 let nea = 0;
									 uea = json_result.nea;
									 //document.getElementById("nea").innerHTML = nea;
										
									 let sav = 0;
									 sav = json_result.sav;
									 //document.getElementById("sav").innerHTML = sav;
										
									 let wsn = 0;
									 wsn = json_result.wsn;
									 //document.getElementById("wsn").innerHTML = wsn;
									 
								    var trace1 = {
									  x: ['Greater Accra', 'Western', 'Volta', 'Eastern', 'Ashanti', 'Central', 'Northern', 'Upper East', 'Upper West', 'Oti', 'Bono East', 'Ahafo', 'Bono', 'North East', 'Savannah', 'Western North'],
									  y: [gar, wer, vol, eas, ash, cen, nor, uea, uws, oti, boe, aha, bon, nea, sav, wsn],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
								 
							 }
							 
						 }
					 } else {
						 if(status == '4') {
							 if(division == 'ALL') {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').removeClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML=total;
										
									 let open = 0;
									 open = json_result.open;
									 document.getElementById("open").innerHTML=open;
										
									 let hold = 0;
									 hold = json_result.hold;
									 document.getElementById("hold").innerHTML=hold;
										
									 let pending = 0;
									 pending = json_result.pending;
									 document.getElementById("pending").innerHTML=pending;
										
									 let resolved = 0;
									 resolved = json_result.resolved;
									 document.getElementById("resolved").innerHTML=resolved;
								        
								     var pvlmd_open= json_result.pvlmd_open;
								     var pvlmd_pending= json_result.pvlmd_pending;
								     var pvlmd_hold= json_result.pvlmd_hold;
								     var pvlmd_resolved= json_result.pvlmd_resolved;
								        
								     var lrd_open= json_result.lrd_open;
								     var lrd_pending= json_result.lrd_pending;
								     var lrd_hold= json_result.lrd_hold;
								     var lrd_resolved= json_result.lrd_resolved;
								        
								     var smd_open= json_result.smd_open;
								     var smd_pending= json_result.smd_pending;
								     var smd_hold= json_result.smd_hold;
								     var smd_resolved= json_result.smd_resolved;
								        
								     var lvd_open= json_result.lvd_open;
								     var lvd_pending= json_result.lvd_pending;
								     var lvd_hold= json_result.lvd_hold;
								     var lvd_resolved= json_result.lvd_resolved;
								        
								     var corporate_open= json_result.corporate_open;
								     var corporate_pending= json_result.corporate_pending;
								     var corporate_hold= json_result.corporate_hold;
								     var corporate_resolved= json_result.corporate_resolved;
								     
								    var trace1 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_open, lrd_open, smd_open, lvd_open, corporate_open],
									  name: 'Open',
									  type: 'bar'
									};
									
									var trace2 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_pending, lrd_pending, smd_pending, lvd_pending, corporate_pending],
									  name: 'Pending',
									  type: 'bar'
									};
									
									var trace3 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_resolved, lrd_resolved, smd_resolved, lvd_resolved, corporate_resolved],
									  name: 'Resolved',
									  type: 'bar'
									};
									
									var trace4 = {
									  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
									  y: [pvlmd_hold, lrd_hold, smd_hold, lvd_hold, corporate_hold],
									  name: 'On Hold',
									  type: 'bar'
									};
									
									var data = [trace1, trace2, trace3, trace4];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
					
								}
								 
							 }
							 else {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').removeClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML=total;
										
									 let open = 0;
									 open = json_result.open;
									 document.getElementById("open").innerHTML=open;
										
									 let hold = 0;
									 hold = json_result.hold;
									 document.getElementById("hold").innerHTML=hold;
										
									 let pending = 0;
									 pending = json_result.pending;
									 document.getElementById("pending").innerHTML=pending;
										
									 let resolved = 0;
									 resolved = json_result.resolved;
									 document.getElementById("resolved").innerHTML=resolved;
									 
								    var trace1 = {
									  x: ['Open', 'Pending', 'On Hold', 'Resolved'],
									  y: [open, pending, hold, resolved],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
								 
							 }
						 }
						 else {
							 if(division == 'ALL') {
								 
								 $('#div_division').removeClass('d-none');
								 $('#div_status').addClass('d-none');
								 
								  $('#cica_chart').removeClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total_d").innerHTML = total;
										
									 let pvlmd = 0;
									 pvlmd = json_result.pvlmd;
									 document.getElementById("pvlmd").innerHTML = pvlmd;
										
									 let smd = 0;
									 smd = json_result.smd;
									 document.getElementById("smd").innerHTML = smd;
										
									 let lrd = 0;
									 lrd = json_result.lrd;
									 document.getElementById("lrd").innerHTML = lrd;
										
									 let lvd = 0;
									 lvd = json_result.lvd;
									 document.getElementById("lvd").innerHTML = lvd;
									 
									 let corporate = 0;
									 corporate = json_result.corporate;
									 document.getElementById("corporate").innerHTML = corporate;
									 
								    var trace1 = {
									  x: ['PVMLD', 'SMD', 'LRD', 'LVD', 'CORPORATE'],
									  y: [pvlmd, smd, lrd, lvd, corporate],
									  name: 'Open',
									  type: 'bar'
									};
									
									var data = [trace1];
									
									var layout = {barmode: 'group'};
									
									Plotly.newPlot('barChart', data, layout);
								}
								 
							 }
							 else {
								 
								 $('#div_division').addClass('d-none');
								 $('#div_status').addClass('d-none');
								 
								  $('#cica_chart').addClass('d-none');
								 
								 if(json_result.success){
									 let total = 0;
									 total = json_result.total;
									 document.getElementById("total").innerHTML = total;
										
									 
								}
								 
							 }
						 }
					 }
					 
					 
					$('#service_tbl').show()
					$('#other_service_tbl').hide()
					
					if(json_result.data !== null){
							
						for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                num = (+num + 1);
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
							let phone= json_result.data[i].client_phone;
			              	let email= json_result.data[i].client_email;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let division= json_result.data[i].division;
			              	let dcu_reply= json_result.data[i].dcu_reply;
			              	let focal_reply= json_result.data[i].focal_reply;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));	
							let completed_date=convertDate(json_result.data[i].sent_date.slice(0,10));	               	
			              	let created_by=json_result.data[i].created_by;;
			            
			                
			               html.push(num);
			               html.push(ticket_id);
			               html.push(name);
						   html.push(phone); 
			               html.push(email);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(division); 
			               html.push(region_name); 
			               html.push(created_by);
			               html.push(date_created);
						   html.push(completed_date);
		
			               dataSet.push(html);
		                
	            		}

					}
						
					$('#table_list').DataTable().clear().destroy();
						
					$('#table_list').DataTable({ 
						data: dataSet,
						/*"createdRow": function(row,data,dataIndex){
							if(data[10]){
								$(row).addClass('greenClass');
							}
						},*/
						dom: 'Bfrtip',
				        buttons: [
				            'copy', 'csv', 'excel', 'print',
				            {
				                extend: 'pdfHtml5',
				                orientation: 'landscape',
				                title: 'CICA - Non Service Complaint Reports',
				                pageSize: 'A4'
				            }
				        ]
					}).draw();
			 }

			 /*if(json_result.success){
				
				let total = 0;
				total = json_result.total;
				document.getElementById("total").innerHTML=total;
				
				let open = 0;
				open = json_result.open;
				document.getElementById("open").innerHTML=open;
				
				let hold = 0;
				hold = json_result.hold;
				document.getElementById("hold").innerHTML=hold;
				
				let pending = 0;
				pending = json_result.pending;
				document.getElementById("pending").innerHTML=pending;
				
				let resolved = 0;
				resolved = json_result.resolved;
				document.getElementById("resolved").innerHTML=resolved;
		        
		        var pvlmd_open= json_result.pvlmd_open;
		        var pvlmd_pending= json_result.pvlmd_pending;
		        var pvlmd_hold= json_result.pvlmd_hold;
		        var pvlmd_resolved= json_result.pvlmd_resolved;
		        
		        var lrd_open= json_result.lrd_open;
		        var lrd_pending= json_result.lrd_pending;
		        var lrd_hold= json_result.lrd_hold;
		        var lrd_resolved= json_result.lrd_resolved;
		        
		        var smd_open= json_result.smd_open;
		        var smd_pending= json_result.smd_pending;
		        var smd_hold= json_result.smd_hold;
		        var smd_resolved= json_result.smd_resolved;
		        
		        var lvd_open= json_result.lvd_open;
		        var lvd_pending= json_result.lvd_pending;
		        var lvd_hold= json_result.lvd_hold;
		        var lvd_resolved= json_result.lvd_resolved;
		        
		        var corporate_open= json_result.corporate_open;
		        var corporate_pending= json_result.corporate_pending;
		        var corporate_hold= json_result.corporate_hold;
		        var corporate_resolved= json_result.corporate_resolved;
		        
				
				if(division == 'ALL') {
					var trace1 = {
					  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
					  y: [pvlmd_open, lrd_open, smd_open, lvd_open, corporate_open],
					  name: 'Open',
					  type: 'bar'
					};
					
					var trace2 = {
					  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
					  y: [pvlmd_pending, lrd_pending, smd_pending, lvd_pending, corporate_pending],
					  name: 'Pending',
					  type: 'bar'
					};
					
					var trace3 = {
					  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
					  y: [pvlmd_resolved, lrd_resolved, smd_resolved, lvd_resolved, corporate_resolved],
					  name: 'Resolved',
					  type: 'bar'
					};
					
					var trace4 = {
					  x: ['PVLMD', 'LRD', 'SMD', 'LVD', 'CORPORATE'],
					  y: [pvlmd_hold, lrd_hold, smd_hold, lvd_hold, corporate_hold],
					  name: 'On Hold',
					  type: 'bar'
					};
					
					var data = [trace1, trace2, trace3, trace4];
					
					var layout = {barmode: 'group'};
					
					Plotly.newPlot('barChart', data, layout);
					
				} else {
					var trace1 = {
					  x: ['Open', 'Pending', 'On Hold', 'Resolved'],
					  y: [open, pending, hold, resolved],
					  name: 'Open',
					  type: 'bar'
					};
					
					var data = [trace1];
					
					var layout = {barmode: 'group'};
					
					Plotly.newPlot('barChart', data, layout);
				}
				
				if(purpose == '2') {
					$('#other_service_tbl').show()
					$('#service_tbl').hide()
					
					if(json_result.data !== null){
							
						for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                num = (+num + 1);
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let phone= json_result.data[i].client_phone;
			              	let email= json_result.data[i].client_email;
			              	let reference_source= json_result.data[i].reference_source;
			              	let created_by= json_result.data[i].created_by;
			              	let milestone_status= json_result.data[i].milestone_status;
			              	let region= json_result.data[i].region_name;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));
			            
			                
			               html.push(num);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(phone); 
			               html.push(email);
			               html.push(reference_source); 
			               html.push(milestone_status);
			               html.push(region);
			               html.push(created_by);
			               html.push(date_created);
		
			               dataSet.push(html);
		                
	            		}

					}
						
					$('#other_table_list').DataTable().clear().destroy();
						
					$('#other_table_list').DataTable({ 
						data: dataSet,
						"createdRow": function(row,data,dataIndex){
							if(data[10]){
								$(row).addClass('greenClass');
							}
						},
						dom: 'Bfrtip',
				        buttons: [
				            'copy', 'csv', 'excel', 'pdf', 'print'
				        ]
					}).draw();
					
					
				} else if (purpose !== '2') {
					
					$('#service_tbl').show()
					$('#other_service_tbl').hide()
					
					if(json_result.data !== null){
							
						for(let i=0; i<json_result.data.length; i++){
			                let html=[];
			                num = (+num + 1);
			                let ticket_id= json_result.data[i].ticket_no;
			                let name= json_result.data[i].client_name;
			              	let priority= json_result.data[i].priority;
			              	let purpose= json_result.data[i].purpose;
			              	if(purpose == 1) {
								purpose = 'Service Enquiry'
							} else if (purpose == 3) {
								purpose = 'Service Complaint'
							} else {
								purpose = "Non-service Complaint"
							}
			              	let subject= json_result.data[i].subject;
			              	let status= json_result.data[i].status;
			              	if(status == 0) {
								status = 'Open'
							}
							if (status == 1) {
								status = 'Hold'
							} 
							if (status == 2) {
								status = 'Pending'
							}
							if (status == 3) {
								status = 'Resolved'
							}
			              	let region_name= json_result.data[i].region_name;
			              	let division= json_result.data[i].division;
			              	let dcu_reply= json_result.data[i].dcu_reply;
			              	let focal_reply= json_result.data[i].focal_reply;
			               	let date_created=convertDate(json_result.data[i].created_at.slice(0,10));		               	
			              	let created_by=json_result.data[i].created_by;;
			            
			                
			               html.push(num);
			               html.push(ticket_id);
			               html.push(name);
			               html.push(purpose); 
			               html.push(subject); 
			               html.push('<div class="text-center">'+status+'</div>'); 
			               html.push('<div class="text-center">'+priority+'</div>'); 
			               html.push(division); 
			               html.push(region_name); 
			               html.push(created_by);
			               html.push(date_created);
		
			               dataSet.push(html);
		                
	            		}

					}
						
					$('#table_list').DataTable().clear().destroy();
						
					$('#table_list').DataTable({ 
						data: dataSet,
						/*"createdRow": function(row,data,dataIndex){
							if(data[10]){
								$(row).addClass('greenClass');
							}
						},
						dom: 'Bfrtip',
				        buttons: [
				            'copy', 'csv', 'excel', 'pdf', 'print'
				        ]
					}).draw();
				}
				
			 } */
              
            $("#apply_filter").prop('disabled', false);
			$("#apply_filter").text("Apply Filter")
                  
			}	
		})
	})

   			
})