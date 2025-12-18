$(document).ready(function() {

  
    $("#sel_change_region_compliance").on('change', function() {
        var level = $(this).val();
        let code = Math.trunc(level); // 3
        
        console.log(code)
       
       $("#sel_change_region_compliance").prop("disabled", true);
 
       if (code) {
        $.ajax({
            type: 'POST',
            url: 'csau_manager_dashboard',
            data : {
                        request_type : 'compliance_executive_dashboard11',
                        regional_code : code
                    },
            success: function(server_response){

                $.ajax({
                    type: 'POST',
                    url: 'csau_manager_dashboard',
                    data : {
                                request_type : 'compliance_executive_dashboard13',
                                regional_code : code
                            },
                    success: function(percentage_response){
                
                        var percentage_response_res = JSON.parse(percentage_response);
                
                        let pending_pvlmd_percentage = percentage_response_res.pending_pvlmd_percentage;
                        let completed_pvlmd_percentage = percentage_response_res.completed_pvlmd_percentage;


                        let pending_lvd_percentage = percentage_response_res.pending_lvd_percentage;
                        let completed_lvd_percentage = percentage_response_res.completed_lvd_percentage;

                        let pending_lrd_percentage = percentage_response_res.pending_lrd_percentage;
                        let completed_lrd_percentage = percentage_response_res.completed_lrd_percentage;

                        let pending_smd_percentage = percentage_response_res.pending_smd_percentage;
                        let completed_smd_percentage = percentage_response_res.completed_smd_percentage;
                      
                
                        console.log(pending_pvlmd_percentage,completed_pvlmd_percentage);
                
                        let update_pvlmd = "";
                        let update_lvd = "";
                        let update_lrd = "";
                        let update_smd = "";
                
                        update_pvlmd = `
                          <div class="col-lg-12 text-right">
                          <div class="progress mb-4">
                          <div class="progress-bar bg-danger" role="progressbar" style="width:${pending_pvlmd_percentage}; background-color: #f50505;" aria-valuenow="70"
                          aria-valuemin="0" aria-valuemax="100">${pending_pvlmd_percentage}</div>
                          <div class="progress-bar" role="progressbar" style="width:${completed_pvlmd_percentage}; background-color: green;" aria-valuenow="70"
                          aria-valuemin="0" aria-valuemax="100">${completed_pvlmd_percentage}</div>
                          </div>
                      </div>
                      <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">
                          Pending <i class="fa fa-dot-circle text-danger"></i> </div>
                
                          <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">
                              Completed  <i class="fa fa-dot-circle" style="color: green;"></i> </div>
                              `

                         
                              update_lvd = `
                              <div class="col-lg-12 text-right">
                              <div class="progress mb-4">
                              <div class="progress-bar bg-danger" role="progressbar" style="width:${pending_lvd_percentage}; background-color: #f50505;" aria-valuenow="70"
                              aria-valuemin="0" aria-valuemax="100">${pending_lvd_percentage}</div>
                              <div class="progress-bar" role="progressbar" style="width:${completed_lvd_percentage}; background-color: green;" aria-valuenow="70"
                              aria-valuemin="0" aria-valuemax="100">${completed_lvd_percentage}</div>
                              </div>
                          </div>
                          <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">
                              Pending <i class="fa fa-dot-circle text-danger"></i> </div>
                    
                              <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">
                                  Completed  <i class="fa fa-dot-circle" style="color: green;"></i> </div>
                                  `
                                  
                                  
                                  update_lrd = `
                                  <div class="col-lg-12 text-right">
                                  <div class="progress mb-4">
                                  <div class="progress-bar bg-danger" role="progressbar" style="width:${pending_lrd_percentage}; background-color: #f50505;" aria-valuenow="70"
                                  aria-valuemin="0" aria-valuemax="100">${pending_lrd_percentage}</div>
                                  <div class="progress-bar" role="progressbar" style="width:${completed_lrd_percentage}; background-color: green;" aria-valuenow="70"
                                  aria-valuemin="0" aria-valuemax="100">${completed_lrd_percentage}</div>
                                  </div>
                              </div>
                              <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">
                                  Pending <i class="fa fa-dot-circle text-danger"></i> </div>
                        
                                  <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">
                                      Completed  <i class="fa fa-dot-circle" style="color: green;"></i> </div>
                                      `


                                      update_smd = `
                                      <div class="col-lg-12 text-right">
                                      <div class="progress mb-4">
                                      <div class="progress-bar bg-danger" role="progressbar" style="width:${pending_smd_percentage}; background-color: #f50505;" aria-valuenow="70"
                                      aria-valuemin="0" aria-valuemax="100">${pending_smd_percentage}</div>
                                      <div class="progress-bar" role="progressbar" style="width:${completed_smd_percentage}; background-color: green;" aria-valuenow="70"
                                      aria-valuemin="0" aria-valuemax="100">${completed_smd_percentage}</div>
                                      </div>
                                  </div>
                                  <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">
                                      Pending <i class="fa fa-dot-circle text-danger"></i> </div>
                            
                                      <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">
                                          Completed  <i class="fa fa-dot-circle" style="color: green;"></i> </div>
                                          `
                
            
                        document.getElementById("pvlmd_percentage").innerHTML = update_pvlmd;
                        document.getElementById("lvd_percentage").innerHTML = update_lvd;
                        document.getElementById("lrd_percentage").innerHTML = update_lrd;
                        document.getElementById("smd_percentage").innerHTML = update_smd;







                                        // do stuff
        
                // call next ajax function
                $.ajax({
                    type: 'POST',
                    url: 'csau_manager_dashboard',
                    data : {
                        request_type : 'compliance_executive_dashboard10',
                        regional_code : code
                    }, 
                success: function(data){
                //console.log(data)
                    var json_result = JSON.parse(data);
                  //  console.log(json_result)
                    let total_completed_january = json_result.total_completed_january[0].total;
                    let total_completed_february = json_result.total_completed_february[0].total;
                    let total_completed_march = json_result.total_completed_march[0].total;
                    let total_completed_april = json_result.total_completed_april[0].total;
                    let total_completed_may = json_result.total_completed_may[0].total;
                    let total_completed_june = json_result.total_completed_june[0].total;
                    let total_completed_july = json_result.total_completed_july[0].total;
                    let total_completed_august = json_result.total_completed_august[0].total;
                    let total_completed_september = json_result.total_completed_september[0].total;
                    let total_completed_october = json_result.total_completed_october[0].total;
                    let total_completed_november = json_result.total_completed_november[0].total;
                    let total_completed_december = json_result.total_completed_december[0].total;
                    let total_pending_january = json_result.total_pending_january[0].total;
                    let total_pending_february = json_result.total_pending_february[0].total;
                    let total_pending_march = json_result.total_pending_march[0].total;
                    let total_pending_april = json_result.total_pending_april[0].total;
                    let total_pending_may = json_result.total_pending_may[0].total;
                    let total_pending_june = json_result.total_pending_june[0].total;
                    let total_pending_july = json_result.total_pending_july[0].total;
                    let total_pending_august = json_result.total_pending_august[0].total;
                    let total_pending_september = json_result.total_pending_september[0].total;
                    let total_pending_october = json_result.total_pending_october[0].total;
                    let total_pending_november = json_result.total_pending_november[0].total;
                    let total_pending_december = json_result.total_pending_december[0].total;
                   // let total_pending_july = json_result.total_pending_july[0].total;



                // console.log(json_result)

              if (json_result='success'){


              var  mydata = {
                    labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul","Aug","Sep","Oct","Nov","Dec"],
                    datasets: [{
                        label: "Pending",
                        data: [total_pending_january,total_pending_february,total_pending_march,total_pending_april,total_pending_may,total_pending_june,
                            total_pending_july,total_pending_august,total_pending_september,total_pending_october,total_pending_november,total_pending_december],
                        borderColor: "#ffb0c1",
                        borderWidth: "0",
                        backgroundColor: "#ffb0c1"
                    }, {
                        label: "Completed",
                        data: [total_completed_january,total_completed_february,total_completed_march,total_completed_april,total_completed_may,total_completed_june,total_completed_july
                            ,total_completed_august,total_completed_september,total_completed_october,total_completed_november,total_completed_december],
                        borderColor: "#9ad0f5",
                        borderWidth: "0",
                        backgroundColor: "#9ad0f5"
                    }]
                };
              var  myoptions = {
                    responsive: true,
                    maintainAspectRatio: false,
                    legend: {
                        labels: {
                            fontColor: "#77778e"
                        },
                    },
                    scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
                }

                // myChart.destroy();
             var ctx = document.getElementById('searchChart');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: mydata,myoptions
        });


   myChart.update('active');

      
     }








     $.ajax({
        type: 'POST',
        url: 'csau_manager_dashboard',
        data : {
            request_type : 'compliance_executive_dashboard12',
            regional_code : code
        }, 
    success: function(data1){
       
        var json_result1 = JSON.parse(data1);
       // let total_completed_october = json_result.total_completed_october[0].total;
    
        //console.log(json_result1)

        let total_january = json_result1.total_january[0].total;
        let total_february = json_result1.total_february[0].total;
        let total_march = json_result1.total_march[0].total;
        let total_april = json_result1.total_april[0].total;
        let total_may = json_result1.total_may[0].total;
        let total_june = json_result1.total_june[0].total;
        let total_july = json_result1.total_july[0].total;
        let total_august = json_result1.total_august[0].total;
        let total_september = json_result1.total_september[0].total;
        let total_october = json_result1.total_october[0].total;
        let total_november = json_result1.total_november[0].total;
        let total_december = json_result1.total_december[0].total;

       // console.log(total_september)

  if (json_result='success'){

var yValues = [total_january,total_february,total_march,total_april,total_may,total_june,total_july,total_august,total_september,total_october,total_november,total_december];
var xValues = ["Jan","Feb","Mar","Apr", "May","Jun","Jul","Aug","Sep","Oct","Nov", "Dec"];


//$('#myChart').remove();

      var ctxx = document.getElementById('myChart');
       var myChartt = new Chart('myChart', {
           type: 'line',
             data: {
    labels: xValues,
    datasets: [{
      fill: false,
      lineTension: 0,
      backgroundColor: "#d4a983",
      borderColor: "#d4a983",
      data: yValues
    }]
  },
  options: {
    legend: {display: false},
    scales: {
				x: {
					stacked: true,
				},
				y: {
					stacked: true
				},
				yAxes: [{
            ticks: {
                beginAtZero: true
            }
        }]
			}

			
  }
        //   data: mydata,myoptions
       });


    document.getElementById('myChart').innerHTML = myChartt;

   // myChartt.update('active');

   

   $("#sel_change_region_compliance").prop("disabled", false);

    


}





    }

    

          });




                }

                      });

                      
                
                    }
                
                        })
                
        


                      var jsonresult = JSON.parse(server_response)
                      
                     // console.log(jsonresult)
                      let total_yearly_received = jsonresult.total_yearly_received[0].total;
                      let total_yearly_pending = jsonresult.total_yearly_pending[0].total;
                      let total_yearly_completed = jsonresult.total_yearly_completed[0].total;

                      let total_lrd_apps = jsonresult.total_lrd_apps[0].total;
                      let total_pvlmd_apps = jsonresult.total_pvlmd_apps[0].total;
                      let total_smd_apps = jsonresult.total_smd_apps[0].total;
                      let total_lvd_apps = jsonresult.total_lvd_apps[0].total;

                      
                      document.getElementById('app-received-today').innerHTML = total_yearly_received;
                      document.getElementById('app-pending-today').innerHTML = total_yearly_pending;
                      document.getElementById('app-completed-today').innerHTML = total_yearly_completed;

                      document.getElementById('app-receieved-lrd').innerHTML = total_lrd_apps;
                      document.getElementById('app-receieved-pvlmd').innerHTML = total_pvlmd_apps;
                      document.getElementById('app-receieved-smd').innerHTML = total_smd_apps;
                      document.getElementById('app-receieved-lvd').innerHTML = total_lvd_apps;

                      
            }

          
        });

    }

      


    });


    
   

})
