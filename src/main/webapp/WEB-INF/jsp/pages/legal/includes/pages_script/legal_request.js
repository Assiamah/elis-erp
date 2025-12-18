$(function(){

		 $('#table_list').DataTable();
	
		 $('#incoming').on('click', function() {
			
			let dataSet =[];
			let num ="";
			let division =  $('input[name="division"]').val();
			let regional_code =  $('input[name="regional_code"]').val();
			let unit_name =  $('input[name="unit_name"]').val();
			
			console.log(division,regional_code,unit_name)
			
			$.ajax({
				url:"legal_request_serv",
				method:"POST",
				data:{"request_type":"load_data",
					  "division":division,
					  "regional_code":regional_code,
					  "unit_name":unit_name,
					  "movement":"incoming" 
				},
				success:function(response){
					console.log(response);
					
					let json_result = JSON.parse(response);
				
				 	if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
					                let html=[];
					                num = (+num + 1);
					                let check=`<div class="form-check"> <input class="form-check-input" type="checkbox" id="gridCheck" data_id="${json_result.data[i].id}" ></div>`
					                //let id=json_result.data[i].id;
					                let suit_number= json_result.data[i].suit_number;
					                //let case_number= json_result.data[i].case_number;
					                let subject= json_result.data[i].subject;
					                let description= json_result.data[i].description;
					               	let requested_by=json_result.data[i].requested_by;
					               	let deadline=convertDate(json_result.data[i].deadline.slice(0,10));
					               	let requested_date=(json_result.data[i].requested_date).split('.')[0];
					              	let actions=`<div>
					              	  	<form  action="work_record_info" method="post">
					              	  		<input type="hidden" name="case_id" value="${json_result.data[i].id}">
											<input type="hidden"  name="suit_number" value="${json_result.data[i].suit_number}">
											<input type="hidden"  name="request_type" value="load_case">
					              	    	<button type="submit" class="btn btn-success btn-sm"><i class="fas fa-edit me-2"></i>Work</button>
					              	    </form>
					        
					              	  </div>`;
					                
					               //html.push(check);
					               html.push(num);
					               //html.push(id);
					               html.push(suit_number);
					               //html.push(case_number); 
					               html.push(subject);  
					               html.push(description); 
					               html.push(requested_by); 
					               html.push(deadline); 
					               html.push(requested_date); 
					               html.push(actions); 
				
					                dataSet.push(html);
					}
				
					}
					
					$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet
							
							}).draw();
							
							
				 }
				}
		})
		
		$("#body-bg-1").addClass('bg-active');
		$("#body-bg-2").removeClass('bg-active')
		
		document.getElementById("request_date").innerHTML = 'Date Received';
	})
	
	
	$('#outgoing').on('click', function() {
			
			let dataSet =[];
			let division =  $('input[name="division"]').val();
			let regional_code =  $('input[name="regional_code"]').val();
			let unit_name =  $('input[name="unit_name"]').val();
			
			console.log(division,regional_code,unit_name)
			
			$.ajax({
				url:"legal_request_serv",
				method:"POST",
				data:{"request_type":"load_data",
					  "division":division,
					  "regional_code":regional_code,
					  "unit_name":unit_name,
					  "movement":"outgoing"
				},
				success:function(response){
					console.log(response);
					
					let json_result = JSON.parse(response);
				
				 	if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
					                let html=[];
					                let check=`<div class="form-check"> <input class="form-check-input" type="checkbox" id="gridCheck" data_id="${json_result.data[i].id}" ></div>`
					                //let id=json_result.data[i].id;
					                let suit_number= json_result.data[i].suit_number;
					                //let case_number= json_result.data[i].case_number;
					                let subject= json_result.data[i].subject;
					                let description= json_result.data[i].description;
					               	let requested_by=json_result.data[i].requested_by;
					               	let deadline=convertDate(json_result.data[i].deadline.slice(0,10));
					               	let provided_date=json_result.data[i].provided_date;
					              	let actions=`
					              	  <div>
					              	  	<form  action="work_record_info" method="post">
					              	  		<input type="hidden" name="case_id" value="${json_result.data[i].id}">
											<input type="hidden"  name="suit_number" value="${json_result.data[i].suit_number}">
											<input type="hidden"  name="request_type" value="load_case">
					              	    	<button type="submit" class="btn btn-success btn-sm" disabled><i class="fas fa-edit me-2"></i>Work</button>
					              	    </form>
					        
					              	  </div>
					              	`;
					                
					               html.push(check);
					               //html.push(id);
					               html.push(suit_number);
					               //html.push(case_number); 
					               html.push(subject);  
					               html.push(description); 
					               html.push(requested_by); 
					               html.push(deadline); 
					               html.push(provided_date); 
					               html.push(actions); 
				
					                dataSet.push(html);
					}
				
					}
					
					$('#table_list').DataTable().clear().destroy();
								
							$('#table_list').DataTable({ data: dataSet
							
							}).draw();
							
							
				 }
				}
		})
		
		$("#body-bg-2").addClass('bg-active');
		$("#body-bg-1").removeClass('bg-active')
		
		document.getElementById("request_date").innerHTML = 'Date Sent';
	})

})