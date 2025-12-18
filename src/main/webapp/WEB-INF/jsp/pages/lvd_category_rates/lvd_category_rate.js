$(document)
		.ready(
				function() {
					$('#cbo_main_category').change(
						function() {
						
							//$('#cbo_main_category').val($(this).val());
							
					        //  alert($(this).val());


								var main_category =$(this).val();

							 $
												.ajax({
													type : "POST",
													url : "category_and_rate_serv",
													data : {
														request_type : 'get_list_sub_category',
														mc_code : main_category
													},
													cache : false,
													
													success : function(
															jobdetails) {

														var select = $("#cbo_sub_category");
														//var select2 = $("#new_bill_application_district");
														select.empty();
													//	select2.empty();

														var json_p = JSON
																.parse(jobdetails);
														$(json_p.data)
																.each(
																		function() {
																		
																			select
																					.append('<option value="'
																							+ this.sc_code
																							+ '">'
																							+ this.sub_category
																							+ '</option>');

																		});

													}
												});

						});




						$('#cbo_sub_category').change(
							function() {
							
								//$('#cbo_main_category').val($(this).val());
								
								// alert($(this).val());
	
	
									var sub_category =$(this).val();
	
								
						var table = $('#sub_category_details_datatable');
						table
								.find(
										"tbody tr")
								.remove();
						$
								.ajax({
									type : "POST",
									url : 'category_and_rate_serv',
									data : {
										request_type : 'sub_category_model_by_sub_category_code',
										sub_category : sub_category
									},
									cache : false,
								
									success : function(
											serviceresponse) {

										var json_p = JSON
												.parse(serviceresponse);
										console.log(json_p)

										
										$('#txt_cost_per_square_meter').text('Cost Per Square Meter - ' + json_p.sub_details.cost_per_square_meter);
										$('#txt_gross_floor_area').text('Gross Floor Area - ' + json_p.sub_details.gross_floor_area);
										$('#txt_number_of_floors').text('Number of Floors - ' + json_p.sub_details.number_of_floors);


										$('#lbl_electrical_installation_rate').text('Number of Floors - ' + json_p.sub_details.electrical_installation_rate);

										$('#lbl_preliminaries_rate').text('Preliminaries Rate - ' + json_p.sub_details.preliminaries_rate);
										$('#lbl_professional_charges_rate').text('Professional Charges Rate - ' + json_p.sub_details.professional_charges_rate);
										$('#lbl_plumbing_installation_rate').text('Plumbing Installation Rate - ' + json_p.sub_details.plumbing_installation_rate);
										$('#lbl_nhil_covid_levy_rate').text('NHIL/COVID Levy - ' + json_p.sub_details.nhil_covid_levy_rate);
										$('#lbl_vat_nhil_rate').text('Vat/NHIL - ' + json_p.sub_details.vat_nhil_rate);
										$('#lbl_developers_profit').text('Developers Profit - ' + json_p.sub_details.developers_profit);

									
										$(
												json_p.sub_model)
												.each(
														function() {

															table
																	.append("<tr><td>"
																			+ this.building_part_description
																			+ "</td><td>"
																			+ this.building_part_category
																			+ "</td><td>"
																			+ this.quantity
																			+ "</td><td>"
																			+ this.amount
																			+ "</td>"

																			
																			+ "</tr>");
														});

									}
								});

	
							});
	
	
									

				});