  $(document).ready(function() {
	  
	    $('#table_list').DataTable()
	    
	   $('#report_by_nature_of_case').on('submit',function(e){
		   e.preventDefault();
			
			let dataSet =[];
			let num = 0;	
				
			$("#btn_reports_by_nature_of_case").prop('disabled', true);
			
			let nature_of_case=$('#nature_of_case').find(":selected").val();
			let	court_region=$('#court_region').find(":selected").val();
			let	date_from=$('input[name="date_from"]').val();
			let	date_to=$('input[name="date_to"]').val();
			
			if(!date_from || !date_to) {
				
				toastr["error"]("Required fields cannot be empty", "Error");
				$("#btn_reports_by_nature_of_case").prop('disabled', false);
				
			} else {
				$.ajax({
				url:"legal_reports_serv",
				method:"POST",
				data:{"request_type":"report_by_nature_of_case",
					"nature_of_case": nature_of_case,
					"court_region": court_region,
					"date_from": date_from,
					"date_to": date_to					
					},
				success:function(response){
					
					console.log(response);
					
						$("#btn_reports_by_nature_of_case").prop('disabled', false);
					
						let json_result = JSON.parse(response);
						
						 if(json_result.success){
						if(json_result.cases !== null){
							
							for(let i=0; i<json_result.cases.length; i++){
			                let html=[];
			                num = +num + 1;
			                let id = num
			                let suit_number= json_result.cases[i].suit_number;
			                let nature_of_case= json_result.cases[i].nature_of_case;
			                //let plaintiffs=(json_result.cases[i].plaintiffs !==null)? json_result.cases[i].plaintiffs[0].plaintiffs_name:"";
			                //let defendants=(json_result.cases[i].defendants !==null)? json_result.cases[i].defendants[0].defendants_name:"";
			                let plaintiffs= "";
			                let defendants= "";
			                 if(json_result.cases[i].parties !== null){
								
								const plaintiffs_arr=get_plaintiffs(json_result.cases[i].parties);
								const defendants_arr=get_defendants(json_result.cases[i].parties);
								
								plaintiffs=plaintiffs_arr;
								defendants=defendants_arr;
							}
			               	let date_of_document=convertDate(json_result.cases[i].date_of_document.slice(0,10));
			               	let date_received=convertDate(json_result.cases[i].date_received.slice(0,10));
			               	let received_at=json_result.cases[i].secretariat;
			               	let assign_to_fullname=json_result.cases[i].assign_to_fullname;
			              	let actions=`
			              	  	<form  action="case_details" method="post">
				              	  		<input type="hidden" name="case_id" value="${json_result.cases[i].id}">
										<input type="hidden"  name="suit_number" value="${json_result.cases[i].suit_number}">
										<input type="hidden"  name="request_type" value="case_details">
				              	    	<button type="submit" class="btn btn-success btn-sm" href="#"> Details</button>
				              	    </form>
			              	 `;
			              	
			              	
			              	  	//<a class="dropdown-item summary" href="#" id="${json_result.cases[i].id}">Case Summary</a>
			              	  	
			                let court_name=json_result.cases[i].court_name;          
		       				let entry_complete=json_result.cases[i].entry_complete;
			                let attachment=json_result.cases[i].attachment;
			                let region=json_result.cases[i].region;
			                let status_of_case=json_result.cases[i].status_of_case;
			                
			               html.push(id);
			               html.push(suit_number);
			               html.push(nature_of_case); 
			               html.push(court_name);  
			               html.push(region); 
			               html.push(plaintiffs); 
			               html.push(defendants); 
			               html.push(date_of_document); 
			               html.push(date_received); 
			               html.push(status_of_case);
			               html.push(assign_to_fullname);
			               html.push(actions); 
			               //html.push(entry_complete);
			               //html.push(attachment);
		
			                dataSet.push(html);
		            		}

							} else {
								
								toastr["warning"]("Report not found", "REPORT");
							}
							
							$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ 
								data: dataSet,
								dom: 'Bfrtip',
						        buttons: [
						            'copy', 'csv', 'excel', 'pdf', 'print'
						        ]
													
						    }).draw();
							
							
							if(json_result.count !== null){
								
								document.getElementById('chart_html').style.visibility = 'visible' 
								document.getElementById('myPieChart').style.visibility = 'visible' 
								
								var officers = "";
								var off_count = "";
								var count_html = ""
								
								for(let i=0; i<json_result.count.length; i++){
									if(json_result.count.length <= 1) {
										console.log('1')
										officers += json_result.count[i].assign_to_fullname == null ? '"Unassigned"' :  '"'+(json_result.count[i].assign_to_fullname).trim()+'"';
									} else {
										console.log('2')
										officers += json_result.count[i].assign_to_fullname == null ? '"Unassigned",' :  '"'+(json_result.count[i].assign_to_fullname).trim()+'"'+ ", ";
									}
									off_count += json_result.count[i].num +", ";
									
									count_html += `
									<li>
										<div class="row">
											<div class="col-md-8">
												${json_result.count[i].assign_to_fullname == null ? "Unassigned" : json_result.count[i].assign_to_fullname}:
											</div>
											<div class="col-md-4">
												<span class="ms-5 text-end" href="">${json_result.count[i].num}</span>
											</div>
										</div>
								 	</li>
									`
								}
								console.log(officers);
								//officers = (officers).slice(0, -2) + '';
								officers = officers.replace(/,*$/, '');
								officers = JSON.parse("["+officers+"]");
								off_count = (off_count).slice(0, -2) + '';
								//off_count = off_count.replace(/,*$/, '');
								off_count = JSON.parse("["+off_count+"]");
								
								document.getElementById('chart_html').innerHTML = count_html;
								
								console.log(officers);
								console.log(off_count);
								
								//Set new default font family and font color to mimic Bootstrap's default styling
								Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
								Chart.defaults.global.defaultFontColor = '#858796';
								
								// Pie Chart Example
								var ctx = document.getElementById("myPieChart");
								var myPieChart = new Chart(ctx, {
								  type: 'doughnut',
								  data: {
								    labels: officers,
								    datasets: [{
								      data: off_count,
								      backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc'],
								      hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
								      hoverBorderColor: "rgba(234, 236, 244, 1)",
								    }],
								  },
								  options: {
								    maintainAspectRatio: false,
								    tooltips: {
								      backgroundColor: "rgb(255,255,255)",
								      bodyFontColor: "#858796",
								      borderColor: '#dddfeb',
								      borderWidth: 1,
								      xPadding: 15,
								      yPadding: 15,
								      displayColors: false,
								      caretPadding: 10,
								    },
								    legend: {
								      display: false
								    },
								    cutoutPercentage: 80,
								  },
								  
								});
							} else {
								
								document.getElementById('chart_html').style.visibility = 'hidden' 
								document.getElementById('myPieChart').style.visibility = 'hidden' 
							}
		              		
						}

					}
				})
			}
				

	   });
	   
	   $('#btnAddCourt').on('click', function() {
	        
	      $("#addCourtModal").modal('show');
	       
	
	    })
	    
	    
	    $('#addcourt').on('submit',function(e){
		   e.preventDefault();
			
			$("#save_court_btn").prop('disabled', true);
			
			
			let court_name=$('input[name="court_name"]').val();;
			let court_region=$('#court_region').find(":selected").val();
			let city=$('input[name="city"]').val();
			let description=$('input[name="description"]').val();

			
			$.ajax({
				url:"legal_settings_serv",
				method:"POST",
				data:{"request_type":"add_court",
					"court_name": court_name,
					"court_region": court_region,
					"city": city,
					"description": description,
					},
				success:function(response){
					
					console.log(response)
					
					let json_result = JSON.parse(response);

			 if(json_result.success){
				 toastr["success"]("Uploaded successfully", "File");
                } 
              else {
                        toastr["error"]("Error occurred uploading file", "File");
                 }

                    $("#addCourtModal").find('form').trigger('reset');
                    $("#addCourtModal").modal('hide');
                    $("#save_court_btn").prop('disabled', false);
                    
                     setTimeout(function(){
                        location.reload();
                    },1000); 
					}
				})
				

	   });
	   
	   
	   
	   const get_plaintiffs=(parties)=>{
		console.log(parties);
		let results=[];
		if(parties !== null){
		parties.forEach(function(parties){
			
			if(parties.party_type == "Plaintiff"){
				results.push(parties.party_name)
			}

		})
		}
		
		return results;
	}
	
	const get_defendants=(parties)=>{
		console.log(parties);
		let results=[];
		if(parties !== null){
		parties.forEach(function(parties){
			
			if(parties.party_type == "Defendant"){
				results.push(parties.party_name)
			}

		})
		}
		
		return results;
	}
	
	  
  })