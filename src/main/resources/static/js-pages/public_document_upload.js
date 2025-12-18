$(document).ready(function() {
	
	
	/*
	 * ======================================== Actions for Public Document Management==================
	 */
	
	
	
	// $("#btn_upload_public_case_file").click(function(event) {
	// 	// $('form').submit(function(event) {
	// 	// stop submit the form, we will post it
	// 	// manually.
	// 	event.preventDefault();
	// 	//console.log("CLicekd me")
	// 	// Get form
	// 	// var form = $('#fileUploadForm')[0];

	// 	// var form =
	// 	// $('#fileUploadForm')[0].files[0];
	// 	var case_number = $(
	// 			"#public_file_upload_case_number")
	// 			.val();

	// 	// var sampleFile = document
	// 	// 		.getElementById("publicFileUploadForm").files[0];

	// 	// var fileInput =
	// 	// document.getElementById('upload');
	// 	var filename = document
	// 			.getElementById("publicFileUploadForm").files[0].name;

	// 	console.log(filename);

	// 	var formdata = new FormData();

	// 	formdata.append("case_number",
	// 			case_number);
	// 	formdata.append("file_name", filename);

	// 	// formdata.append("sampleFile",
	// 	// 		sampleFile);

	// 			$('.fileUpload input[name="samplePublicFile"]').each(function(index, element) {
	// 				var sampleFile = element.files[0];
	// 				console.log(sampleFile);
	// 				formdata.append('sampleFile', sampleFile);
	// 			});

	// 	// Create an FormData object
	// 	// var data = new FormData(form);
	// 	// console.log(data);
	// 	// If you want to add an extra field for
	// 	// the FormData
	// 	// data.append("case_number",
	// 	// case_number);
	// 	// console.log(data);
	// 	// // disabled the submit button
	// 	$("#btn_upload_public_case_file").prop(
	// 			"disabled", true);
	// 	////console.log(formdata); 
	// 	$
	// 			.ajax({
	// 				type : "POST",
	// 				enctype : 'multipart/form-data',
	// 				//url : "document_upload_public_new",
	// 				url : "document_upload_multiple_public_new",
	// 				data : formdata,
	// 				processData : false,
	// 				contentType : false,
	// 				cache : false,
	// 				timeout : 600000,
	// 				success : function(data) {

	// 					// $("#result").text(data);
	// 					alert(data);

	// 					$('#publicFileUploadModal').modal('hide');
	// 					console.log("SUCCESS : ",data);
	// 					$("#btn_upload_public_case_file").prop("disabled",false);

	// 				},
	// 				error : function(e) {

	// 					// $("#result").text(e.responseText);
	// 					console.log("ERROR : ",e);
	// 					$("#btn_upload_public_case_file").prop("disabled",false);

	// 				}
	// 			});

	// });


	$("#btn_upload_public_case_file").click(function(event) {
        event.preventDefault();
        
        var case_number = $("#public_file_upload_case_number").val();
		var document_type = $("#file_type_pu").val();
        var formdata = new FormData();
        formdata.append("case_number", case_number);

        // Get all files from all file inputs
        $('.fileUpload input[name="samplePublicFile"]').each(function(index, element) {
            if (element.files && element.files.length > 0) {
                // Append each file with a unique index
                formdata.append('sampleFile', element.files[0]);
                // formdata.append('file_name', element.files[0].name);
        		formdata.append("file_name", document_type);
            }
        });

        $("#btn_upload_public_case_file").prop("disabled", true);

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "document_upload_multiple_public_new",
            data: formdata,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function(data) {
                alert(data);
                $('#publicFileUploadModal').modal('hide');
                console.log("SUCCESS : ", data);
                $("#btn_upload_public_case_file").prop("disabled", false);
            },
            error: function(e) {
                console.log("ERROR : ", e);
                $("#btn_upload_public_case_file").prop("disabled", false);
            }
        });
    });

	
	
	
	/* $('#lrd_btn_add_new_public_document')
	.on(
			'click',
			function(e) {

				var case_number = $(
						"#cs_main_case_number").val();

				$("#fileUploadModalPublic").modal({
					backdrop : 'static',
					keyboard : false
				});
				$('#fileUploadModalPublic #file_upload_case_number_pu')
						.val(case_number);
			}); */



	$('#btn_load_scanned_documents_public').on('click', function(e) { 
		   
		
		 var table_docs_mains = $('#lc_public_documents_dataTable');
		 table_docs_mains.find("tbody tr").remove(); 

 	var case_number = $("#cs_main_case_number").val();

	if(!case_number){

		alert('Please enter a case number');
		return;
	}
 	//console.log(case_number);
		 $.ajax({
			 type: "POST",
			 url: "LoadLRDJackets",
			 data: {
             	request_type: 'load_case_scanned_document_public_new',
             	case_number:case_number},
			 cache: false,
			 beforeSend: function () {
				// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
			 },
			 success: function(serviceresponse) {

				// if(!serviceresponse) {
				// 	return;
				// }
				try{
				 var json_p = JSON.parse(serviceresponse);
					console.log(json_p)
										
					
					 $(json_p).each(function () {
					  table_docs_mains.append('<tr><td> <a class="link-post" href="' + this.doc_uuid + '">' + this.doc_description+ '</a></td><td>' +this.doc_extension + '</td>' 
					    + "</tr>");
			         
		    
					 });

					}catch(e){
						console.log(e)
					}
				  
			 }
			 }); 
 //	
 });

 $('#btn_load_scanned_documents_public_, #btn_load_scanned_documents_public__,  #btn_load_scanned_documents_public___').on('click', function(e) { 
		  
	console.log('hefjberjhre')
		
	var table_docs_mains = $('#lc_public_documents_dataTable_, #lc_public_documents_dataTable__,  #lc_public_documents_dataTable___');
	table_docs_mains.find("tbody tr").remove(); 

var case_number = $("#cs_main_case_number").val();

if(!case_number){

   alert('Please enter a case number');
   return;
}
//console.log(case_number);
	$.ajax({
		type: "POST",
		url: "LoadLRDJackets",
		data: {
			request_type: 'load_case_scanned_document_public_new',
			case_number:case_number},
		cache: false,
		beforeSend: function () {
		   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		},
		success: function(serviceresponse) {

		   // if(!serviceresponse) {
		   // 	return;
		   // }
		   try{
			var json_p = JSON.parse(serviceresponse);
			   console.log(json_p)
								   
			   
				$(json_p).each(function () {
				 table_docs_mains.append('<tr><td> <a class="link-post" href="' + this.doc_uuid + '">' + this.doc_description+ '</a></td><td>' +this.doc_extension + '</td>' 
				   + "</tr>");
				
	   
				});

			   }catch(e){
				   console.log(e)
			   }
			 
		}
		}); 
//	
});



 $('#btn_new_load_scanned_documents_public').on('click', function(e) { 
		   
		
	var table_docs_mains = $('#lc_public_documents_dataTable');
	table_docs_mains.find("tbody tr").remove(); 

var case_number = $("#cs_main_case_number").val();

var enq_search_type = "";
var request_type = "";

var selected_rbtn = $("input[name='rbtn_search_type']:checked");
if (selected_rbtn.length > 0) {
	enq_search_type = selected_rbtn.val();
	//console.log("selected " + enq_search_type);
}

if(!case_number){

   //alert('Please enter a case number');

   $.notify({
	message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter a case number</span>',
}, { type : 'danger' , z_index: 9999  });

   return;
}else if (enq_search_type.length <= 0){
	$.notify({
		message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
	}, { type : 'danger' , z_index: 9999  });

	return;
	
}

if(enq_search_type == "public_docs") {
	request_type = "load_case_scanned_document_public_new_admin"
} else {
	request_type = "load_case_scanned_document_new_admin"
}
//console.log(case_number);
	$.ajax({
		type: "POST",
		url: "LoadLRDJackets",
		data: {
			request_type: request_type,
			case_number:case_number},
		cache: false,
		beforeSend: function () {
		   // $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
		},
		success: function(serviceresponse) {

		   // if(!serviceresponse) {
		   // 	return;
		   // }
		   try{
			var json_p = JSON.parse(serviceresponse);
			   console.log(json_p)
								   
			   
			   $(json_p).each(function () {
				table_docs_mains.append(
					'<tr class="' + (this.doc_deleted ? 'bg-danger text-white' : '') + '">' +
					'<td><a class="link-post" href="' + this.doc_uuid + '">' + this.doc_description + '</a></td>' +
					'<td>' + this.doc_extension + '</td>' +
					'<td><button class="btn ' + (this.doc_deleted ? 'btn-warning btn_reverse_doc' : 'btn-danger btn_delete_doc') + ' " data-doc_uuid="' + this.doc_uuid + '">' +
					'<i class="fas ' + (this.doc_deleted ? 'fa-check-circle' : 'fa-trash') + '  mr-1"></i>' + (this.doc_deleted ? 'Reverse' : 'Delete') + ' </button></td>' +
					'</tr>'
				);
			});

			   }catch(e){
				   console.log(e)
			   }
			 
		}
		}); 
//	
});

$('#lc_public_documents_dataTable').on('click', '.btn_delete_doc', function () {
    var file_to_open = $(this).data('doc_uuid'); // Fix for data retrieval
	console.log(file_to_open)
    if (!file_to_open) {
        alert('Document identifier is missing.');
        return;
    }

    if (!confirm("Are you sure you want to delete this document?")) {
        return;
    }

    $.ajax({
        type: "POST",
        url: "delete_document_by_doc_uuid",
        data: { file_to_open: file_to_open },
        cache: false,
        beforeSend: function () {
            // Optional: Add loader or disable button
        },
        success: function (serviceresponse) {
            alert("Document deleted successfully.");
            // Optionally, refresh the table or remove the row
        },
        error: function (xhr, status, error) {
            console.error("Error:", error);
            alert("Failed to delete the document.");
        }
    });
});

$('#lc_public_documents_dataTable').on('click', '.btn_reverse_doc', function () {
    var file_to_open = $(this).data('doc_uuid'); // Fix for data retrieval
	console.log(file_to_open)
    if (!file_to_open) {
        alert('Document identifier is missing.');
        return;
    }

    if (!confirm("Are you sure you want to reverse this document?")) {
        return;
    }

    $.ajax({
        type: "POST",
        url: "reverse_document_by_doc_uuid",
        data: { file_to_open: file_to_open },
        cache: false,
        beforeSend: function () {
            // Optional: Add loader or disable button
        },
        success: function (serviceresponse) {
            alert("Document reversed successfully.");
            // Optionally, refresh the table or remove the row
        },
        error: function (xhr, status, error) {
            console.error("Error:", error);
            alert("Failed to delete the document.");
        }
    });
});
  
  
  $('#lc_public_documents_dataTable, #lc_public_documents_dataTable_, #lc_public_documents_dataTable__,  #lc_public_documents_dataTable___').on('click', '.link-post', function(e){
		//  console.log(e)
		  e.preventDefault();

		   // Get row data
		   
		 // console.log(e.target);
	//  console.log(event.target.href);
		  
		  var file_to_open = e.target.href;
		 //C://gelisscans//scanpdf//LCGARGAPCN717422820190/APPLICATION_FOR_OFFICIAL_SEARCH_(CONSOLIDATED)_01436449.pdf
		 
		 	console.log(file_to_open);
		 //var str = "Visit Microsoft!";
		  var file_path = file_to_open.replace("file:///", "");
				console.log(file_path);

var URL_map = file_to_open;
var newURL = URL_map.replace(/^[a-z]{4,5}\:\/{2}[a-z]{1,}\:[0-9]{1,4}.(.*)/, '$1');

console.log('newURL');
console.log(newURL);
				



var urlObj = new URL(file_to_open);
var newURL1 = urlObj.href.replace(urlObj.origin, '');
console.log(newURL1);
				
				 var fileName, fileExtension;
	  //fileName = file_path;
	  fileName = file_path;
	  fileExtension = fileName.replace(/^.*\./, '');
	  console.log (fileExtension);
	  
			 $.ajax({
					 type: "POST",
					 url: "open_pdffile_new",
					// target:'_blank',
					 data: {
						 request_type: 'request_to_generate_batch_list',
						 file_path: newURL1,
						 file_extension: fileExtension,
						 file_to_open: newURL
		           },
					 cache: false,
					xhrFields:{
		                responseType: 'blob'
		            },
					 beforeSend: function () {
						// $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
					 },
					 success: function(jobdetails) {
						 console.log(jobdetails);
						// const arrayBuffer = _base64ToArrayBuffer(jobdetails);
							if(fileExtension==="zip"){
 						
							var blob = new Blob([jobdetails], {type: "application/zip"});
	          			        var objectUrl = URL.createObjectURL(blob);
	          			   		 window.open(objectUrl);
 							}else{

								$('#elisDocumentPreview').modal("show");
 							
 							$('#elisDocumentPreview').modal({
 		     	    	 			 backdrop: 'static',
 		     	    				});
 		          				
 		          					
 							//const file = new File([blob], 'untitled', { type: blob.type })
 							
 							var blob = new Blob([jobdetails], {type: "application/pdf"});
 		          			        var objectUrl = URL.createObjectURL(blob);
 		          			  // window.open(objectUrl);

 									$(
 											'#elisdovumentpreviewblobfile')
 											.attr('src',
 													objectUrl);
 									
 									$(
 									'#fedocumentPreviewblobfile')
 									.attr('src',
 											objectUrl);
 						}
						  
					 }
					 });  
		  
		});


	
	
	
	
	
	/*
	 * ======================================== ENDActions for Public Document Management==================
	 */

});