$(document)
		.ready(
				function() {
						$('#main_service_rpt').on('change', function () {
						if ($(this).val() === '0') { // Check if 'All Services' is selected
						  $('#subServ').hide(); // Hide the dropdown
						} else {
						  $('#subServ').show(); // Show the dropdown
						}
					  });


					  $('#type_of_report_name_rpt').on('change', function () {
						if ($(this).val() === 'Unit') { // Check if 'All Services' is selected
						  $('#userSelect').hide(); // Hide the dropdown
						} else {
						  $('#userSelect').show(); // Show the dropdown
						}
					  });


					  $('#report_count_main_service_rpt').on('change', function () {
						if ($(this).val() === '0') { // Check if 'All Services' is selected
						  $('#countSubServ').hide(); // Hide the dropdown
						} else {
						  $('#countSubServ').show(); // Show the dropdown
						}
					  });

					  




					  

					function formatReportExportDate(value) {
						if (!value) return '';
						var parts = value.split('-');
						if (parts.length !== 3) return value;
						var day = parseInt(parts[2], 10);
						var month = [ 'January', 'February', 'March', 'April', 'May', 'June',
								'July', 'August', 'September', 'October', 'November', 'December' ][parseInt(parts[1], 10) - 1];
						if (!day || !month) return value;
						var remainder = day % 100;
						var suffix = remainder >= 11 && remainder <= 13 ? 'th'
								: ({ 1: 'st', 2: 'nd', 3: 'rd' }[day % 10] || 'th');
						return day + suffix + ' ' + month + ', ' + parts[0];
					}

					function getGeneralReportExportTitle() {
						var reportType = $('#type_of_report_name option:selected').text().trim();
						var mainService = $('#main_service_rpt option:selected').text().trim();
						var subService = $('#sub_service_rpt option:selected').text().trim();
						var region = $('#sel_change_region_compliance option:selected').text().trim();
						var from = formatReportExportDate($('#date_from').val());
						var to = formatReportExportDate($('#date_to').val());
						var details = [];

						if (reportType && !/^select/i.test(reportType)) details.push(reportType);
						if (mainService && !/^select/i.test(mainService)) details.push(mainService);
						if (subService && !/^select/i.test(subService) && mainService !== 'All Services') details.push(subService);
						if (region && !/^select/i.test(region)) details.push(region);

						var title = 'Application Review Report';
						if (details.length) title += ' - ' + details.join(' - ');
						if (from && to) title += ' - ' + from + ' to ' + to;
						return title;
					}

					function getGeneralReportExportFilename() {
						return getGeneralReportExportTitle().replace(/[^a-z0-9]+/gi, '_').replace(/^_+|_+$/g, '');
					}

					function isGeneralReportExportColumn(index) {
						var table = $('#job_casemgtdetailsdataTable_elis_reports').DataTable();
						var actionColumnIndex = table.columns().count() - 1;
						return index !== 0 && index !== actionColumnIndex && table.column(index).visible();
					}

					var generalReportColumnViews = {
						overview: [0, 1, 2, 3, 4, 5, 7, 14, 17, 20],
						applicant: [0, 1, 2, 3, 4, 5, 11, 14, 20],
						property: [0, 1, 2, 6, 7, 9, 11, 12, 20],
						registration: [0, 1, 2, 8, 9, 10, 12, 13, 14, 20],
						timeline: [0, 1, 2, 4, 15, 16, 17, 18, 19, 20],
						all: Array.from({ length: 21 }, function(_, index) { return index; })
					};

					function applyGeneralReportColumnView(table, viewName) {
						var visibleColumns = generalReportColumnViews[viewName] || generalReportColumnViews.overview;
						table.columns().visible(false, false);
						table.columns(visibleColumns).visible(true, false);
						table.columns.adjust().draw(false);
						$('.view-presets [data-report-view]').removeClass('active')
								.filter('[data-report-view="' + viewName + '"]').addClass('active');
						try { window.localStorage.setItem('elisGeneralReportColumnView', viewName); } catch (error) {}
					}

					var datatable_cordinator = $(
							"#job_casemgtdetailsdataTable_elis_reports")
							.DataTable(
									{
						stateSave : true,
						scrollX : true,
						autoWidth : false,
						fixedColumns : { leftColumns : 3, rightColumns : 1 },
						initComplete : function() {
							var savedView = 'overview';
							try { savedView = window.localStorage.getItem('elisGeneralReportColumnView') || 'overview'; } catch (error) {}
							applyGeneralReportColumnView(this.api(), savedView);
						},
										"createdRow" : function(row, data,
												dataIndex) {
											if (data[0] == "1") {
												$(row).addClass(
														'tr-completed-work');
											}
										},
										dom : 'Bfrtip',
										lengthMenu : [
												[ 10, 25, 50, -1 ],
												[ '10 rows', '25 rows',
														'50 rows', 'Show all' ] ],
						columnDefs : [
							{ targets : 0, orderable : false, searchable : false, className : 'details-control no-export text-center', width : '36px' },
							{ targets : -1, className : 'no-export' }
						],
										buttons : [
												'pageLength',
												{
													extend : 'colvis',
													text : 'Choose Columns',
													collectionLayout : 'report-column-chooser',
													collectionTitle : 'Checked columns will be included in exports',
							columns : ':not(.no-export)'
												},
								{
									extend : 'copy',
									title : getGeneralReportExportTitle,
									exportOptions : { columns : isGeneralReportExportColumn }
								},
								{
									extend : 'csv',
									title : getGeneralReportExportTitle,
									filename : getGeneralReportExportFilename,
									exportOptions : { columns : isGeneralReportExportColumn }
								},
								{
									extend : 'excel',
									title : getGeneralReportExportTitle,
									filename : getGeneralReportExportFilename,
									exportOptions : { columns : isGeneralReportExportColumn }
								},
								{
									extend : 'pdf',
									title : getGeneralReportExportTitle,
									filename : getGeneralReportExportFilename,
									exportOptions : { columns : isGeneralReportExportColumn },
													orientation : 'landscape',
													pageSize : 'A3'
												},
								{
									extend : 'print',
									title : getGeneralReportExportTitle,
									exportOptions : { columns : isGeneralReportExportColumn },
									customize : function(win) {
										$(win.document.head).append(
												'<style>'
												+ '@page { size: A3 landscape; margin: 10mm; }'
												+ 'body { margin: 0; color: #000; }'
												+ 'h1 { font-size: 14pt; text-align: center; margin: 0 0 12px; }'
												+ 'table { width: 100% !important; table-layout: auto; border-collapse: collapse; font-size: 7pt; }'
												+ 'table th, table td { white-space: normal !important; overflow-wrap: anywhere; word-break: normal; padding: 4px !important; vertical-align: top; }'
												+ 'table th { background: #e9ecef !important; -webkit-print-color-adjust: exact; print-color-adjust: exact; }'
												+ '</style>'
										);
										$(win.document.body).find('table').removeClass('text-nowrap nowrap');
									}
								}
										]
									});

					datatable_cordinator.on('column-visibility.dt', function() {
						$('.view-presets [data-report-view]').removeClass('active');
					});

					var generalReportingRows = [];
					var generalReportingFilter = 'all';

					function isGeneralReportCompleted(item) {
						return item && (item.is_completed === true || item.is_completed === 'true'
								|| item.is_completed === 1 || item.is_completed === '1');
					}

					function normalizeNatureOfInstrument(value) {
						if (value === null || value === undefined) return '';
						var original = String(value).trim().replace(/\s+/g, ' ');
						var key = original.toUpperCase().replace(/[^A-Z0-9]/g, '');
						var canonicalNames = {
							SUBLEASE: 'Sub-Lease',
							STATUTORYDECLARATION: 'Statutory Declaration',
							MORTGAGE: 'Mortgage',
							MORTGAGES: 'Mortgage',
							DEEDOFASSIGNMENT: 'Deed of Assignment',
							ASSIGNMENT: 'Deed of Assignment'
						};
						return canonicalNames[key] || original;
					}

					function generalReportTableRow(item) {
						return [
							'<button type="button" class="btn btn-sm btn-light report-row-toggle" aria-label="Show row details" aria-expanded="false"><i class="ri-add-line"></i></button>',
							item.job_number || ' ', item.ar_name || ' ',
							item.business_process_sub_name || ' ', item.created_date || ' ',
							item.current_application_status || ' ', item.locality || ' ',
							item.regional_name || ' ', item.certicate_number || ' ',
							item.district || ' ', item.created_date || ' ',
							item.grantors_name || ' ', normalizeNatureOfInstrument(item.nature_of_instrument) || ' ',
							item.date_of_registration || ' ', item.case_number || ' ',
							item.days_since_received || ' ', item.days_since_batched || '',
							item.completed_date || '', item.days_completed || '',
							item.collected_date || '',
							'<button class="btn btn-info btn-icon-split" data-title="Add to List" id="btnAddToBatchlist-'
									+ (item.job_number || '') + '" data-jn_id="' + (item.jn_id || '')
									+ '" data-ar_name="' + (item.ar_name || '')
									+ '" data-business_process_sub_name="' + (item.business_process_sub_name || '')
									+ '" data-case_number="' + (item.case_number || '')
									+ '" data-case_status="' + (item.case_status || '')
									+ '" data-target="#applicationdetailsmodal" data-toggle="modal">'
									+ '<span class="icon text-white-50"><i class="fas fa-list"></i></span>'
									+ '<span class="text">View</span></button>'
						];
					}

					function renderGeneralReportTable() {
						var rows = generalReportingRows.filter(function(item) {
							if (generalReportingFilter === 'completed') return isGeneralReportCompleted(item);
							if (generalReportingFilter === 'pending') return !isGeneralReportCompleted(item);
							return true;
						}).map(generalReportTableRow);

						datatable_cordinator.clear().rows.add(rows).draw();
					}

					function escapeGeneralReportDetail(value) {
						return $('<div>').text(value === null || value === undefined || value === '' ? '—' : value).html();
					}

					function generalReportRowDetails(data) {
						var sections = [
							{ title: 'Application', fields: [[1, 'Job Number'], [2, 'Applicant'], [3, 'Application Type'], [5, 'Status'], [14, 'Case Number']] },
							{ title: 'Property', fields: [[6, 'Locality'], [7, 'Region'], [9, 'Registration District'], [11, 'Grantor'], [12, 'Nature of Instrument']] },
							{ title: 'Registration', fields: [[8, 'Certificate Number'], [10, 'Date of Instrument'], [13, 'Date of Registration']] },
							{ title: 'Timeline', fields: [[4, 'Date Received'], [15, 'Days Received'], [16, 'Days Batched'], [17, 'Date Completed'], [18, 'Days Completed'], [19, 'Date Collected']] }
						];
						return '<div class="row g-3 p-2">' + sections.map(function(section) {
							return '<div class="col-12 col-lg-6"><div class="card border shadow-none h-100"><div class="card-header py-2 fw-semibold">'
									+ section.title + '</div><div class="card-body py-2"><div class="row g-2">'
									+ section.fields.map(function(field) {
										return '<div class="col-12 col-md-6"><div class="report-detail-label">' + field[1]
												+ '</div><div class="report-detail-value">' + escapeGeneralReportDetail(data[field[0]]) + '</div></div>';
									}).join('') + '</div></div></div></div>';
						}).join('') + '</div>';
					}

					$(document).on('click', '.view-presets [data-report-view]', function() {
						applyGeneralReportColumnView(datatable_cordinator, $(this).data('report-view'));
					});

					$(document).on('change', '#report_table_density', function() {
						var wrapper = $('#job_casemgtdetailsdataTable_elis_reports_wrapper');
						wrapper.removeClass('report-density-compact report-density-comfortable');
						if (this.value !== 'standard') wrapper.addClass('report-density-' + this.value);
						datatable_cordinator.columns.adjust();
					});

					$('#job_casemgtdetailsdataTable_elis_reports tbody').on('click', '.report-row-toggle', function() {
						var button = $(this);
						var row = datatable_cordinator.row(button.closest('tr'));
						if (row.child.isShown()) {
							row.child.hide();
							button.attr({ 'aria-expanded': 'false', 'aria-label': 'Show row details' }).find('i').attr('class', 'ri-add-line');
						} else {
							row.child(generalReportRowDetails(row.data()), 'report-row-details').show();
							button.attr({ 'aria-expanded': 'true', 'aria-label': 'Hide row details' }).find('i').attr('class', 'ri-subtract-line');
						}
					});

					function renderGeneralReportBreakdown() {
						var field = $('#general_reporting_group_by').val() || 'business_process_sub_name';
						var emptyLabels = {
							business_process_sub_name: 'Unspecified Application Type',
							regional_name: 'Unspecified Region',
							locality: 'Unspecified Locality',
							district: 'Unspecified Registration District',
							nature_of_instrument: 'Unspecified Nature of Instrument'
						};
						var groups = {};

						generalReportingRows.forEach(function(item) {
							var rawName = item[field];
							var normalizedName = field === 'nature_of_instrument' ? normalizeNatureOfInstrument(rawName)
									: (rawName === null || rawName === undefined ? '' : String(rawName).trim());
							var name = normalizedName === '' || normalizedName === '0' || normalizedName === '-1'
									? emptyLabels[field] : normalizedName;
							if (!groups[name]) groups[name] = { total: 0, completed: 0 };
							groups[name].total += 1;
							if (isGeneralReportCompleted(item)) groups[name].completed += 1;
						});

						var names = Object.keys(groups).sort(function(a, b) {
							return groups[b].total - groups[a].total || a.localeCompare(b);
						});

						$('#general_reporting_breakdown_cards').html(names.map(function(name) {
							var group = groups[name];
							var groupRate = group.total ? Math.round((group.completed / group.total) * 100) : 0;
							return '<div class="col-12 col-md-6 col-xl-4"><div class="purpose-card p-3">'
									+ '<div class="purpose-card-title mb-3"></div><div class="row g-2 text-center">'
									+ '<div class="col-4"><div class="purpose-card-number">' + group.total + '</div><div class="purpose-card-label">Total</div></div>'
									+ '<div class="col-4"><div class="purpose-card-number text-success">' + group.completed + '</div><div class="purpose-card-label">Done</div></div>'
									+ '<div class="col-4"><div class="purpose-card-number text-warning">' + (group.total - group.completed) + '</div><div class="purpose-card-label">Pending</div></div>'
									+ '</div><div class="d-flex justify-content-between mt-3"><span class="purpose-card-label">Completion</span><strong>' + groupRate + '%</strong></div>'
									+ '<div class="other-report-progress mt-2"><span style="width:' + groupRate + '%"></span></div></div></div>';
						}).join(''));

						$('#general_reporting_breakdown_cards .purpose-card-title').each(function(index) {
							$(this).text(names[index]);
						});
					}

					function getGeneralReportBreakdownExportData() {
						var field = $('#general_reporting_group_by').val() || 'business_process_sub_name';
						var label = $('#general_reporting_group_by option:selected').text();
						var emptyLabels = {
							business_process_sub_name: 'Unspecified Application Type', regional_name: 'Unspecified Region',
							locality: 'Unspecified Locality', district: 'Unspecified Registration District',
							nature_of_instrument: 'Unspecified Nature of Instrument'
						};
						var groups = {};

						generalReportingRows.forEach(function(item) {
							var normalized = field === 'nature_of_instrument' ? normalizeNatureOfInstrument(item[field])
									: (item[field] === null || item[field] === undefined ? '' : String(item[field]).trim());
							var name = normalized === '' || normalized === '0' || normalized === '-1' ? emptyLabels[field] : normalized;
							if (!groups[name]) groups[name] = { name: name, total: 0, completed: 0 };
							groups[name].total += 1;
							if (isGeneralReportCompleted(item)) groups[name].completed += 1;
						});

						var rows = Object.keys(groups).map(function(name) {
							var group = groups[name];
							return {
								name: group.name, total: group.total, completed: group.completed,
								pending: group.total - group.completed,
								rate: group.total ? Math.round((group.completed / group.total) * 100) : 0
							};
						}).sort(function(a, b) { return b.total - a.total || a.name.localeCompare(b.name); });
						return { label: label, rows: rows };
					}

					function generalReportSummaryFilename(extension) {
						var groupLabel = $('#general_reporting_group_by option:selected').text();
						return (getGeneralReportExportFilename() + '_Grouped_by_' + groupLabel.replace(/[^a-z0-9]+/gi, '_')) + '.' + extension;
					}

					$(document).on('click', '#export_general_group_pdf', function() {
						var data = getGeneralReportBreakdownExportData();
						if (!data.rows.length) return;
						var body = [ [
							{ text: data.label, bold: true }, { text: 'Total', bold: true }, { text: 'Completed', bold: true },
							{ text: 'Pending', bold: true }, { text: 'Completion', bold: true }
						] ];
						data.rows.forEach(function(row) {
							body.push([ row.name, row.total, row.completed, row.pending, row.rate + '%' ]);
						});
						window.pdfMake.createPdf({
							pageSize: 'A4', pageOrientation: 'landscape', pageMargins: [30, 35, 30, 35],
							content: [
								{ text: getGeneralReportExportTitle(), style: 'title' },
								{ text: 'Grouped by ' + data.label, style: 'subtitle' },
								{ table: { headerRows: 1, widths: ['*', 60, 70, 60, 70], body: body }, layout: 'lightHorizontalLines' }
							],
							styles: { title: { fontSize: 15, bold: true, alignment: 'center', margin: [0, 0, 0, 8] },
								subtitle: { fontSize: 10, color: '#6c757d', alignment: 'center', margin: [0, 0, 0, 14] } },
							defaultStyle: { fontSize: 8 }
						}).download(generalReportSummaryFilename('pdf'));
					});

					$(document).on('click', '#export_general_group_image', function() {
						var data = getGeneralReportBreakdownExportData();
						if (!data.rows.length) return;
						var pageSize = 250;
						for (var offset = 0; offset < data.rows.length; offset += pageSize) {
							var pageRows = data.rows.slice(offset, offset + pageSize);
							var canvas = document.createElement('canvas');
							canvas.width = 1400;
							canvas.height = 175 + (pageRows.length * 38);
							var context = canvas.getContext('2d');
							context.fillStyle = '#ffffff'; context.fillRect(0, 0, canvas.width, canvas.height);
							context.fillStyle = '#212529'; context.font = 'bold 22px Arial';
							context.fillText(getGeneralReportExportTitle().substring(0, 110), 35, 40);
							context.fillStyle = '#6c757d'; context.font = '16px Arial'; context.fillText('Grouped by ' + data.label, 35, 70);
							var columns = [35, 930, 1040, 1160, 1270];
							context.fillStyle = '#e9ecef'; context.fillRect(25, 95, 1350, 40);
							context.fillStyle = '#212529'; context.font = 'bold 15px Arial';
							[data.label, 'Total', 'Completed', 'Pending', 'Rate'].forEach(function(text, index) { context.fillText(text, columns[index], 121); });
							pageRows.forEach(function(row, index) {
								var y = 160 + (index * 38);
								if (index % 2) { context.fillStyle = '#f8f9fa'; context.fillRect(25, y - 24, 1350, 36); }
								context.fillStyle = '#212529'; context.font = '14px Arial';
								context.fillText(row.name.substring(0, 105), columns[0], y);
								context.fillText(String(row.total), columns[1], y); context.fillText(String(row.completed), columns[2], y);
								context.fillText(String(row.pending), columns[3], y); context.fillText(row.rate + '%', columns[4], y);
							});
							var link = document.createElement('a');
							var pageSuffix = data.rows.length > pageSize ? '_Page_' + ((offset / pageSize) + 1) : '';
							link.download = generalReportSummaryFilename('png').replace('.png', pageSuffix + '.png');
							link.href = canvas.toDataURL('image/png'); link.click();
						}
					});

					function renderGeneralReportInsights() {
						var total = generalReportingRows.length;
						var completed = generalReportingRows.filter(isGeneralReportCompleted).length;
						var pending = total - completed;
						var rate = total ? Math.round((completed / total) * 100) : 0;
						var cards = [
							{ filter: 'all', label: 'Total Applications', value: total, icon: 'ri-stack-line', tone: 'total' },
							{ filter: 'completed', label: 'Completed', value: completed, icon: 'ri-checkbox-circle-line', tone: 'completed' },
							{ filter: 'pending', label: 'Pending', value: pending, icon: 'ri-time-line', tone: 'pending' },
							{ label: 'Completion Rate', value: rate + '%', icon: 'ri-line-chart-line', tone: 'rate' }
						];

						$('#general_reporting_summary_cards').html(cards.map(function(card) {
							var selectable = card.filter ? ' data-filter="' + card.filter + '" role="button" tabindex="0"' : '';
							var active = card.filter === generalReportingFilter ? ' active' : '';
							return '<div class="col-12 col-sm-6 col-xl-3"><div class="other-report-summary-card p-3'
									+ active + '"' + selectable + '><div class="d-flex justify-content-between align-items-start gap-3">'
									+ '<div><div class="metric-label mb-2">' + card.label + '</div><div class="metric-value">'
									+ card.value + '</div></div><div class="metric-icon ' + card.tone + '"><i class="'
									+ card.icon + ' fs-4"></i></div></div></div></div>';
						}).join(''));

						renderGeneralReportBreakdown();
						$('#general_reporting_breakdown').toggleClass('d-none', total === 0);
					}

					$(document).on('change', '#general_reporting_group_by', renderGeneralReportBreakdown);

					$(document).on('click keydown', '#general_reporting_summary_cards [data-filter]', function(event) {
						if (event.type === 'keydown' && event.key !== 'Enter' && event.key !== ' ') return;
						event.preventDefault();
						generalReportingFilter = $(this).data('filter');
						renderGeneralReportInsights();
						renderGeneralReportTable();
					});

					$('#main_service_rpt')
							.change(
									function() {
										// alert($(this).val());
										var select_id = document
												.getElementById("main_service_rpt");
										var main_service = select_id.options[select_id.selectedIndex].value;

										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										// console.log(main_service_name);

										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_sub_service_all',
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
															jobdetails) {

														// console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var options = $("#sub_service_rpt");

														// var options =
														// $("#selector");
														options.empty();
														options
																.append(new Option(
																		"All Subservices",
																		0));

														$(json_p)
																.each(
																		function() {

																			// console.log(select_id);
																			// console.log(this.business_process_id);

																			if (main_service_id == this.business_process_id) {
																				$(
																						'#sub_service_rpt')
																						.append(
																								'<option value="'
																										+ this.business_process_sub_id
																										+ '-'
																										+ this.business_process_sub_name
																										+ '">'
																										+ this.business_process_sub_name
																										+ '</option>');

																			}

																		});
														// business_process_id
													}
												});

										/*
										 * $.each(data, function() {
										 * 
										 * });
										 */

										// var sub_select_id =
										// document.getElementById("sub_service_on_case");
										// var
										// sub_service=sub_select_id.options[sub_select_id.selectedIndex].value;
									});

									


									$('#report_count_main_service_rpt')
									.change(
											function() {
												// alert($(this).val());
												var select_id = document
														.getElementById("report_count_main_service_rpt");
												var main_service = select_id.options[select_id.selectedIndex].value;
		
												const
												main_service_name_id = main_service
														.split('-');
		
												var main_service_id = main_service_name_id[0];
												var main_service_name = main_service_name_id[1];
		
												// console.log(main_service_name);
		
												$
														.ajax({
															type : "POST",
															url : "Case_Management_Serv",
															data : {
																request_type : 'get_lc_sub_service_all',
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
																	jobdetails) {
		
																// console.log(jobdetails);
																var json_p = JSON
																		.parse(jobdetails);
																var options = $("#report_count_sub_service_rpt");
		
																// var options =
																// $("#selector");
																options.empty();
																options
																		.append(new Option(
																				"-- Select --",
																				0));
		
																$(json_p)
																		.each(
																				function() {
		
																					// console.log(select_id);
																					// console.log(this.business_process_id);
		
																					if (main_service_id == this.business_process_id) {
																						$(
																								'#report_count_sub_service_rpt')
																								.append(
																										'<option value="'
																												+ this.business_process_sub_id
																												+ '-'
																												+ this.business_process_sub_name
																												+ '">'
																												+ this.business_process_sub_name
																												+ '</option>');
		
																					}
		
																				});
																// business_process_id
															}
														});
		
												/*
												 * $.each(data, function() {
												 * 
												 * });
												 */
		
												// var sub_select_id =
												// document.getElementById("sub_service_on_case");
												// var
												// sub_service=sub_select_id.options[sub_select_id.selectedIndex].value;
											});

											



					$('#btn_generate_details_reports_new')
							.on(
									'click',
									function(e) {

										var select_id = document
												.getElementById("main_service_rpt");
										var main_service = select_id.options[select_id.selectedIndex].value;
										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										var sub_select_id = document
												.getElementById("sub_service_rpt");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										sub_service_name_id = sub_service
												.split('-');
										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

										// console.log(main_service_id);

										main_service_id = main_service_id
												.replace('.0', '');

										var date_from = $("#date_from").val();
										var date_to = $("#date_to").val();
										var type_of_report_name = $(
												"#type_of_report_name").val();
										var regional_cod = $(
													"#sel_change_region_compliance").val();
										  let regional_code = Math.trunc(regional_cod);
											console.log(regional_code);

										if (sub_service_name == "") {

											alert("Please select a service.");
											$("#sub_service_rpt").focus();
											return false;
										}

										// console.log(type_of_report_name,main_service_id,sub_service_id,date_from,date_to,regional_code);
										console.log("type_of_report_name: "+type_of_report_name);
										console.log("main_service_id: "+main_service_id);
										console.log("sub_service_id: "+sub_service_id);
										console.log("regional_code: "+regional_code);

										var table = $("#job_casemgtdetailsdataTable_elis_reports");
										table.find("tbody tr").remove();

										datatable_cordinator.draw();
										datatable_cordinator.state.clear();
										datatable_cordinator.clear();

										$
												.ajax({
													type : "POST",
													url : "reports_api",
													// target:'_blank',
													
													data : {
														request_type : 'report_general_new',
														main_service_rpt : main_service_id,
														sub_service_rpt : sub_service_id,
														date_from : date_from,
														date_to : date_to,
														type_of_report_name : type_of_report_name,
														region_code:regional_code
													},
													cache : false,
													success : function(
															jobdetails) {
														// console.log("ddd: "+
														// jobdetails);
														// create Tabulator on
														// DOM element with id
														// "example-table"

												var json_p = JSON
														.parse(jobdetails);
												generalReportingRows = Array.isArray(json_p.data) ? json_p.data : [];
												generalReportingFilter = 'all';
												renderGeneralReportInsights();
												renderGeneralReportTable();

														var reportTable = document
																.getElementById("job_casemgtdetailsdataTable_elis_reports");
														if (reportTable) {
															window.requestAnimationFrame(function() {
																reportTable.scrollIntoView({
																	behavior : "smooth",
																	block : "start"
																});
															});
														}

													}
												});

									});


      


									$('#btn_generate_count_reports')
									.on(
											'click',
											function(e) {
		
												var select_id = document
														.getElementById("report_count_main_service_rpt");
												var main_service = select_id.options[select_id.selectedIndex].value;
												const
												main_service_name_id = main_service
														.split('-');
		
												var main_service_id = main_service_name_id[0];

												var MAINSERV = $("#report_count_main_service_rpt").val();

												console.log(MAINSERV + "Miain");

												if (MAINSERV == "0") {

													 var main_service_name = "All Services"

													}else {


												   var main_service_name = main_service_name_id[1];


													}

		
												var sub_select_id = document
														.getElementById("report_count_sub_service_rpt");
												var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;
		
												const
												sub_service_name_id = sub_service
														.split('-');
												var sub_service_id = sub_service_name_id[0];
												var sub_service_name = sub_service_name_id[1];
		
												// console.log(main_service_id);
		
												main_service_id = main_service_id
														.replace('.0', '');
		
												var date_from = $("#report_count_date_from").val();
												var date_to = $("#report_count_date_to").val();
												var type_of_report_name = $(
														"#type_of_report_name").val();
												var regional_cod = $(
															"#report_count_sel_change_region_compliance").val();
												  let regional_code = Math.trunc(regional_cod);
													console.log(main_service_id,sub_service_id);


		
												// if (sub_service_name == "") {
		
												// 	alert("Please select a service.");
												// 	$("#report_count_sub_service_rpt").focus();
												// 	return false;
												// }
		
												// var table = $("#job_casemgtdetailsdataTable_elis_reports");
												// table.find("tbody tr").remove();
		
												// datatable_cordinator.draw();
												// datatable_cordinator.state.clear();
												// datatable_cordinator.clear();
		
												
												if (date_from !== '' && date_to !== '' && regional_cod !== ''  && sub_select_id !== '') {

													$.ajax({
														type : "POST",
														url : "reports_api",
														// target:'_blank',
														
														data : {
															request_type : 'report_general_count',
															main_service_rpt : main_service_id,
															sub_service_rpt : sub_service_id,
															date_from : date_from,
															date_to : date_to,
															region_code:regional_code
														},
														cache : false,
														success : function(
																job_details) {



	
													$.ajax({
														type : "POST",
														url : "reports_api",
														// target:'_blank',
														
														data : {
															request_type : 'report_general_count_query',
															main_service_rpt : main_service_id,
															sub_service_rpt : sub_service_id,
															date_from : date_from,
															date_to : date_to,
															region_code:regional_code
														},
														cache : false,
														success : function(
																jobdetails) {
															// console.log("ddd: "+
															// jobdetails);
															// create Tabulator on
															// DOM element with id
															// "example-table"
	
															var json_p = JSON
																	.parse(jobdetails);
																	console.log(json_p.data[0].total);
														let queries = json_p.data[0].total		

														document.getElementById('app-queried').innerHTML = queries;
														

														}
													});



	
															var jsonp = JSON
																	.parse(job_details);
																	console.log(jsonp);
														

																	if (jsonp.data == null){
																		alert("Sorry Nothing Found");
																	}
																	else{

												// let totalpercentage = isNaN(((totalRecComp / totalRec) * 100).toFixed(2)) ? 0 : ((totalRecComp / totalRec) * 100).toFixed(2);

												 let pending_count = jsonp?.data?.[0]?.total ?? 0;
                                                 let completed_count = jsonp?.data?.[1]?.total ?? 0;

												 let total = pending_count + completed_count;
														    // let pending_count = jsonp.data[0].total;
															// let completed_count = jsonp.data[1].total;

															//console.log(pending_count);
															Swal.fire(
																	'Successful!',
																	'Your Report has been Generated.',
																	'success'
																);

															$("#reportCountModal").modal("show");  
															document.getElementById('app-pending').innerHTML = pending_count;
															document.getElementById('app-completed').innerHTML = completed_count;
															
															document.getElementById('totalApps').innerHTML = total;
														
															var report_Count  = (main_service_name+ "  " +"Report Count Between"+" "+date_from+ " "+"and"+" "+date_to).toUpperCase();
															document.getElementById('reportCountModalLabel').innerHTML = report_Count;


															
     															}
														
														}
													});

												}else{
													alert("Please Fill Required Fields")
												}
														
		
											});						




					$('#btn_generate_details_reports_new_csv')
							.on(
									'click',
									function(e) {

										var select_id = document
												.getElementById("main_service_rpt");
										var main_service = select_id.options[select_id.selectedIndex].value;
										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										var sub_select_id = document
												.getElementById("sub_service_rpt");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										sub_service_name_id = sub_service
												.split('-');
										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

										console.log(main_service_id);

										main_service_id = main_service_id
												.replace('.0', '');

										var date_from = $("#date_from").val();
										var date_to = $("#date_to").val();
										var type_of_report_name = $(
												"#type_of_report_name").val();
												var regional_cod = $(
													"#sel_change_region_compliance").val();
										  let regional_code = Math.trunc(regional_cod);

										if (sub_service_name == "") {

											alert("Please select a service.");
											$("#sub_service_rpt").focus();
											return false;
										}

									
										$
												.ajax({
													type : "POST",
													url : "reports_api",
													// target:'_blank',

													data : {
														request_type : 'report_general_new',
														main_service_rpt : main_service_id,
														sub_service_rpt : sub_service_id,
														date_from : date_from,
														date_to : date_to,
														type_of_report_name : type_of_report_name,
														region_code:regional_code
													},
													cache : false,
													// responseType:
													// 'arraybuffer',
													// dataType:'blob',
													xhrFields : {
														responseType : 'blob'
													},
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {
														console.log(jobdetails);
														// const arrayBuffer =
														// _base64ToArrayBuffer(jobdetails);
														var blob = new Blob(
																[ jobdetails ],
																{
																	type : "application/vnd.ms-excel"
																});
														var objectUrl = URL
																.createObjectURL(blob);
														window.open(objectUrl);

													}
												});

									});


					$('#btn_generate_details_reports')
							.on(
									'click',
									function(e) {

										var select_id = document
												.getElementById("main_service_rpt");
										var main_service = select_id.options[select_id.selectedIndex].value;
										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										var sub_select_id = document
												.getElementById("sub_service_rpt");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										sub_service_name_id = sub_service
												.split('-');
										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

										console.log(main_service_id);

										main_service_id = main_service_id
												.replace('.0', '');

										var date_from = $("#date_from").val();
										var date_to = $("#date_to").val();
										var type_of_report_name = $(
												"#type_of_report_name").val();
												var regional_cod = $(
													"#sel_change_region_compliance").val();
										  let regional_code = Math.trunc(regional_cod);

										if (sub_service_name == "") {

											alert("Please select a service.");
											$("#sub_service_rpt").focus();
											return false;
										}

										$
												.ajax({
													type : "POST",
													url : "reports_api",
													// target:'_blank',

													data : {
														request_type : 'report_general',
														main_service_rpt : main_service_id,
														sub_service_rpt : sub_service_id,
														date_from : date_from,
														date_to : date_to,
														type_of_report_name : type_of_report_name,
														region_code:regional_code
													},
													cache : false,
													// responseType:
													// 'arraybuffer',
													// dataType:'blob',
													xhrFields : {
														responseType : 'blob'
													},
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {
														console.log(jobdetails);
														// const arrayBuffer =
														// _base64ToArrayBuffer(jobdetails);
														var blob = new Blob(
																[ jobdetails ],
																{
																	type : "application/vnd.ms-excel"
																});
														var objectUrl = URL
																.createObjectURL(blob);
														window.open(objectUrl);

													}
												});

									});
									
									
										$('#btn_generate_details_based_on_users_csv')
							.on(
									'click',
									function(e) {

										var select_id = document
												.getElementById("main_service_rpt");
										var main_service = select_id.options[select_id.selectedIndex].value;
										const
										main_service_name_id = main_service
												.split('-');

										var main_service_id = main_service_name_id[0];
										var main_service_name = main_service_name_id[1];

										var sub_select_id = document
												.getElementById("sub_service_rpt");
										var sub_service = sub_select_id.options[sub_select_id.selectedIndex].value;

										const
										sub_service_name_id = sub_service
												.split('-');
										var sub_service_id = sub_service_name_id[0];
										var sub_service_name = sub_service_name_id[1];

										console.log(main_service_id);

										main_service_id = main_service_id
												.replace('.0', '');

										var date_from = $("#date_from").val();
										var date_to = $("#date_to").val();
										var type_of_report_name = $(
												"#type_of_report_name").val();
												var regional_cod = $(
													"#sel_change_region_compliance").val();
										  let regional_code = Math.trunc(regional_cod);

										if (sub_service_name == "") {

											alert("Please select a service.");
											$("#sub_service_rpt").focus();
											return false;
										}

										$
												.ajax({
													type : "POST",
													url : "reports_api",
													// target:'_blank',

													data : {
														request_type : 'report_general',
														main_service_rpt : main_service_id,
														sub_service_rpt : sub_service_id,
														date_from : date_from,
														date_to : date_to,
														type_of_report_name : type_of_report_name,
														region_code:regional_code
													},
													cache : false,
													// responseType:
													// 'arraybuffer',
													// dataType:'blob',
													xhrFields : {
														responseType : 'blob'
													},
													beforeSend : function() {
														// $('#district').html('<img
														// src="img/loading.gif"
														// alt="" width="24"
														// height="24">');
													},
													success : function(
															jobdetails) {
														console.log(jobdetails);
														// const arrayBuffer =
														// _base64ToArrayBuffer(jobdetails);
														var blob = new Blob(
																[ jobdetails ],
																{
																	type : "application/vnd.ms-excel"
																});
														var objectUrl = URL
																.createObjectURL(blob);
														window.open(objectUrl);

													}
												});

									});

					$('#unit_division_to_send_to_rpt')
							.change(
									function() {
										// alert("d");
										var selected_division = $(this).val();

										$("#unit_to_send_to_rpt").val("");
										// $("#get_change_region_compliance").val("");
										// $("#btn_process_batchlist").hide();
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_list_of_units',
													},
													cache : false,
													success : function(
															jobdetails) {

														console.log(jobdetails);
														var json_p = JSON
																.parse(jobdetails);
														var datalist = $("#listofunitsbatching_rpt");
														datalist.empty();

														$(json_p.data)
																.each(
																		function() {
																			// console.log("Outer
																			// " +
																			// this.unit_division
																			// + "
																			// - "
																			// +
																			// this.unit_name);
																			if (this.unit_division
																					.includes(selected_division)) {
																				// console.log("Inner
																				// " +
																				// this.unit_division
																				// + "
																				// - "
																				// +
																				// this.unit_name);
																				datalist
																						.append('<option data-name="'
																								+ this.unit_name
																								+ '" data-id="'
																								+ this.unit_id
																								+ '" value="'
																								+ this.unit_name
																								+ '" ></option>');
																			}
																		});
													}
												});

									});

					$('#unit_to_send_to_rpt')
							.change(
									function() {
										
										var selected_division = $(this).val();
										var region_cod = $(
											"#get_change_region_compliance").val();
								  let region_code = Math.trunc(region_cod);
								  var division_name = $(
											"#unit_division_to_send_to_rpt").val();
									var unit_id = $(
											"#unit_to_send_to_rpt").val();

								  console.log(region_code,division_name,unit_id);
										$("#user_to_send_to_rpt").val("");
										
										// $("#btn_process_batchlist").hide();
										$
												.ajax({
													type : "POST",
													url : "Case_Management_Serv",
													data : {
														request_type : 'get_lc_list_of_users_rpt',
														region_code : region_code,
														division_name : division_name,
														unit_id : unit_id
													},
													cache : false,
													success : function(
															jobdetails) {

																var json_p = JSON.parse(jobdetails);
																	console.log(json_p);

																	var datalist = $("#listofusersbatching_rpt");
																	datalist.empty();

																	if (json_p.success && json_p.data.length > 0) {
																		$.each(json_p.data, function () {
																			datalist.append(
																				`<option 
																					value="${this.fullname}" 
																					data-userid="${this.userid}"
																				></option>`
																			);
																		});
																	}

														
														// var json_p = JSON
														// 		.parse(jobdetails);
														// 		console.log(json_p);
														// var datalist = $("#listofusersbatching_rpt");
														// datalist.empty();

														// $(json_p.users)
														// 		.each(
														// 				function() {
														// 					// if (selected_division == this.unit_name) {
														// 						if (selected_division == this.unit_name) {

														// 						// console.log(this.division
														// 						// + "
														// 						// - "
														// 						// +
														// 						// this.userid);
														// 						datalist
														// 								.append('<option data-name="'
														// 										+ this.fullname
														// 										+ '" data-id="'
														// 										+ this.userid
														// 										+ '" value="'
														// 										+ this.fullname
														// 										+ '" ></option>');
														// 					}
														// 				});
													}
												});

									});

									
					$("#btn_generate_details_based_on_users")
							.click(
									function(event) {

										// alert(JSON.stringify(table));
										/*
										 * let request_type = ""; var
										 * list_of_application_new = JSON
										 * .stringify(table)
										 */
										datatable_cordinator.draw();
										datatable_cordinator.state.clear();
										datatable_cordinator.clear();

										var request_type = '';
										var type_of_report_name_rpt = $(
												"#type_of_report_name_rpt")
												.val();
										// btn_process_batchlist
										if ($('#type_of_report_name_rpt').val() === 'Unit') {

											 $('#user_to_send_to_rpt').hide();

												// if ($(this).val() === '0') { // Check if 'All Services' is selected
						//   $('#subServ').hide(); // Hide the dropdown
						// } else {
						//   $('#subServ').show(); // Show the dropdown
						// }


											request_type = 'report_dashboard_unit_for_each_staff';
											var userid_1 = $(
													"#unit_to_send_to_rpt")
													.val(); // $(
											// "#user_to_send_to
											// option:selected"
											// ).text();
											var send_to_id = $(
													'#listofunitsbatching_rpt option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('id');

											console.log(send_to_id + "Unit")				
											var send_to_name = $(
													'#listofunitsbatching_rpt option')
													.filter(
															function() {
																return this.value == userid_1;
															}).data('name');

										} else {
											request_type = 'report_dashboard_unit_for_each_staff';
											var userid_1 = $(
													"#user_to_send_to_rpt")
													.val(); // $(
											// "#user_to_send_to
											// option:selected"_rpt
											// ).text();
											// var send_to_id = $(
											// 		'#listofusersbatching_rpt option')
											// 		.filter(
											// 				function() {
											// 					return this.value == userid_1;
											// 				}).data('id');

															
												
												
												var inputVal = $("#user_to_send_to_rpt").val();

												// Find the matching option in the datalist
												var option = document.querySelector(
													`#listofusersbatching_rpt option[value="${inputVal}"]`
												);

												// if (!option) {
												// 	console.warn("No matching user found for:", inputVal);
												// 	return;
												// }

												// ✅ Extract userid
												var send_to_id = option.dataset.userid;
												var send_to_name = inputVal;


												// console.log(send_to_id + "Else")	
												// console.log(send_to_name + "Else")	


											// var send_to_name = $(
											// 		'#listofusersbatching_rpt option')
											// 		.filter(
											// 				function() {
											// 					return this.value == userid_1;
											// 				}).data('name');

										}

										$
												.ajax({
													type : "POST",
													url : "reports_api",
													// target:'_blank',

													data : {
														request_type : request_type,
														batch_to_id : send_to_id,

													},
													cache : false,
													success : function(
															jobdetails) {

														// create Tabulator on
														// DOM element with id
														// "example-table"
													    
														var json_p = JSON
																.parse(jobdetails);
																console.log(json_p)
														$(
																json_p.apps_with_staff)
																.each(
																		function() {

																			datatable_cordinator.row
																					.add(
																							[
																									this.job_number ? this.job_number
																											: "",

																									this.ar_name ? this.ar_name
																											: "",

																									this.business_process_sub_name ? this.business_process_sub_name
																											: "",

																									this.created_date ? this.created_date
																											: "",

																									this.current_application_status ? this.current_application_status
																											: "",
																									this.case_number ? this.case_number
																											: "",
																									this.days_since_received ? this.days_since_received
																											: "",
																									this.days_since_batched ? this.days_since_batched
																											: "",

																									this.completed_date ? this.completed_date
																											: "",

																									this.jobb_purpose ? this.jobb_purpose
																											: "",

																									
																									// this.days_completed ? this.days_completed
																									// 		: "",
																									this.collected_date ? this.collected_date
																											: "",
																									'<button  class="btn btn-info btn-icon-split"  data-title="Add to List"  id="btnAddToBatchlist-'
																											+ this.job_number
																											+ '" data-jn_id="'
																											+ this.jn_id
																											+ '" data-ar_name="'
																											+ this.ar_name
																											+ '" data-business_process_sub_name="'
																											+ this.business_process_sub_name
																											+ '" data-case_number="'
																											+ this.case_number
																											+ '" data-case_status="'
																											+ this.case_status
																											+ '" data-target="#applicationdetailsmodal" data-toggle="modal" >'
																											+ ' <span class="icon text-white-50"> <i class="fas fa-list"></i></span><span class="text">View</span>'
																											+ ' </button>'

																							])
																					.draw(
																							false);

																		});

													}
												});
									});



				});
