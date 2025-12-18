$(document)
		.ready(
				function() {

					$('#smd_btn_search_by_transaction_reference_number')
							.on(
									'click',
									function(e) {

										var reference_number = $(
												'#smd_search_by_text').val();

										var table = $('#smd_transaction_dataTable');
										table.find("tbody tr").remove();
										var table = $('#smd_transaction_dataTable');
										table.find("tbody tr").remove();
										$
												.ajax({
													type : "POST",
													url : 'Maps',
													data : {
														request_type : 'select_lc_spatial_objects_smd_transaction_by_reference_number',
														reference_number : reference_number
													},
													cache : false,
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt=""
														// width="24"
														// height="24">');
													},
													success : function(
															serviceresponse) {

														var json_p = JSON
																.parse(serviceresponse);
														console.log(json_p)

														/*
														 * $(
														 * '#lrd_txt_wkt_polygon')
														 * .val( json_p.wkt);
														 */

														$(json_p.data)
																.each(
																		function() {

																			table
																					.append("<tr><td>"
																							+ this.applicant_name
																							+ "</td><td>"
																							+ this.grantor_name
																							+ "</td><td>"
																							+ this.mul_claim
																							+ "</td><td>"
																							+ this.remarks
																							+ "</td>"

																							+ '<td><p data-placement="top" data-toggle="tooltip" title="Details"><button class="btn btn-info btn-icon-split" data-dismiss="modal" data-toggle="modal" href="#addsmdtransaction" data-target-id="'
																							+ this.gid
																							+ '"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Details</span></button></p></td>'

																							+ "</tr>");
																		});

													}
												});

									});

				});
