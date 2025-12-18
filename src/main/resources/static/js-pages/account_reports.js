$(document).ready(function() {
	
	//Draw graph
	try{
		let myChart = echarts.init(document.getElementById('main-echart'));
		let option;
		const acct_graph_data_values =  JSON.parse($('#acct_graph_data_values').html());
		
		const type = $('#type').val();
		const limit = parseInt($('#limit').val());
		const x_desc = type ==='count' ? "Total Quantities": "Total Amounts in GHS";
		const title = "Report from " + $('#date_from').val()+" to "+ $('#date_to').val();
		const sub_title= "Only top "+ $('#limit').val()+" are selected to show";
		

		//acct_graph_data_values = acct_graph_data_values.filter(i => i.total_value > 0)
		
		const limited_data = acct_graph_data_values.sort((a,b) => (b.total_value - a.total_value)).slice(0,limit).sort((a, b) => 0.5 - Math.random())
		
		const graph_labels =  limited_data.map((i) => i.business_process_sub_name);
		const graph_values =  limited_data.map((i) => i.total_value);
		//console.log ("labels:" +graph_labels +"Values:" + graph_values);

		option = {
				title: {
				    text: title,
				    subtext: sub_title,
				    left: "center",
				    top: 0,
				    textStyle: {
				      fontSize: 20
				    },
				    
				  },
			toolbox: {
		    show: true,
		    feature: {
		      
		      dataView: {
		        readOnly: true
		      },
		      magicType: {
		        type: ["line", "bar"]
		      },
		      restore: {},
		      saveAsImage: {}
		    }
		  },
		  legend: {}, 
		  color: ["#3398DB"],
		  tooltip: {
			    trigger: "axis",
			    axisPointer: {
			      type: "shadow"
			    }
			  },
				  
		    xAxis: {
		        type: 'category',
		        axisLabel: {
		            rotate: -25
		        },
		        data: graph_labels
				  
		    },
		    yAxis: {
		        type: 'value',
		        
		        nameLocation: "middle",
		        nameTextStyle: {
		          padding: [0, 0, 40, 0]
		        },
		        name: x_desc
		    },
		    series: [{
		        type: 'bar',
		        data: graph_values
		        
		    }]
		    
		};

		myChart.setOption(option);
		
	}catch(e){
		console.log(e)
	}
	
	
	
	$('#division, #t_division').multiselect({// Lable of Select All
        includeSelectAllOption: true,
        buttonWidth:'100%',

});

	//End of chart
	
	$('#rdb_export_type button').on('click', function(e){
		e.preventDefault();
	    var sel = $(this).data('title');
	    var tog = $(this).data('toggle');
	    $('#'+tog).prop('value', sel);
	    
	    $('button[data-toggle="'+tog+'"]').not('[data-title="'+sel+'"]').removeClass('active').addClass('notActive');
	    $('button[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').addClass('active');
	    
	    
	});
	
	/*$("#profile-tab").click(function(e){
		$("#summarize-tab" ).removeClass( 'active bg-dark text-white');
		$( "#profile-tab" ).addClass( 'active bg-dark text-white');
	});*/
	
	
	/*$("#summarize-tab").click(function(e){
		$("#profile-tab" ).removeClass( 'active bg-dark text-white');
		$( "#summarize-tab" ).addClass( 'active bg-dark text-white');
	});*/
	
	
	
	
	
	 $("#tbl_transactions_result")
	.DataTable({
		dom: 'Bfrtip',						
        buttons: [
        	'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
        ]
	});
	
	$("#btn_export_data").click(function(e) {
		e.preventDefault();
		var json_pre = acct_graph_data_values;
		const export_type = $('#export_type').val() ? $('#export_type').val() :'CSV';
		var downloadLink = document.createElement("a");

		switch (export_type){
		case 'CSV':
			var csv = JSON2CSV(json_pre);
			var blob = new Blob(["\ufeff", csv]);
			var url = URL.createObjectURL(blob);
			downloadLink.href = url;
			downloadLink.download = "Report from " + $('#date_from').val()+" to "+ $('#date_to').val() + ".csv";

			document.body.appendChild(downloadLink);
			downloadLink.click();
			document.body.removeChild(downloadLink);
			break;
		case 'PDF':
			
			var doc = new jsPDF();          
			var elementHandler = {
			  '#acct_graph_data_values': function (element, renderer) {
			    return true;
			  }
			};
			var source = window.document.getElementsByTagName("body")[0];
			doc.fromHTML(
			    source,
			    15,
			    15,
			    {
			      'width': 180,'elementHandlers': elementHandler
			    });

			doc.output("dataurlnewwindow");
			break;
		default:
		}
		
		
		//var json = $.parseJSON(json_pre);

		
	});
	
	
	
					


// ------ end of $(doc).ready
});