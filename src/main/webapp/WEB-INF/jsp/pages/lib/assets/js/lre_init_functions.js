$(document).ready(function(){
  console.log('start foo bar');
  // window.onload = function(){
  // here we adjust the display to match the screen dimensions
    // if (window.innerWidth <= 1180){
    // document.getElementById("map").style.width = window.innerWidth*0.75+"px";
    // } else {
    // document.getElementById("map").style.width = window.innerWidth*0.82+"px";
    // }
    // if (window.innerHeight < 650){
    // document.getElementById("map").style.height = window.innerHeight*0.75+"px";
    // } else {
    // document.getElementById("map").style.height = window.innerHeight*0.80+"px";
    // }
    document.getElementById("controls").style.visibility="hidden";
    init();
  //};
      //slides the element with class "menu_body" when paragraph with class "menu_head" is clicked
    // 		$("#menuContainer p.menu_head").click(function()
    // 		{
    // 			$(this).css({backgroundImage:"url(icons/down.png)"}).next("div.menu_body").slideToggle(300).siblings("div.menu_body").slideUp("slow");
    // 			$(this).siblings().css({backgroundImage:"url(icons/left.png)"});
    // 		});

$("select#dropregion").change(function(){
  console.log('drop region');
  var region_id = $("select#dropregion option:selected").attr('value');
  $("#district").html( "" );
  if (typeof region_id != 'undefined'){
    if (region_id.length > 0 ) {
      $.ajax({
        type: "POST",
        url: "php/getdistrict2.php",
        data: "region_id="+region_id,
        cache: false,
        beforeSend: function () {
          $('#district').html('<img src="img/loading.gif" alt="" width="24" height="24">');
        },
        success: function(html) {
          $("#district").html( html );
            document.getElementById("selectedDistrict").innerHTML="<strong>Selected District: "+$("select#dropdistrict option:selected").text()+"</strong>";
          $("#dropdistrict").change(function(e) {
            document.getElementById("selectedDistrict").innerHTML="<strong>Selected District: "+$("select#dropdistrict option:selected").text()+"</strong>";
          });
        }
     });
   }
 }
});

});


function overlay() {
  console.log('foo bar');
  el = document.getElementById("overlay");
  var offset1 = document.getElementById('stats').getBoundingClientRect();
  var offset2 = document.getElementById('fisprop').getBoundingClientRect();
  var offset3 = document.getElementById('fisbus').getBoundingClientRect();
  var offset4 = document.getElementById('fisother').getBoundingClientRect();
  var offseticons = document.getElementById('icon-section').getBoundingClientRect();
  var top = offseticons.top+ -200;
  var left = offset4.left+30;
  // 	el.style.margin = "'.top.' '. left'";
  el.style.top = top+'px';
  el.style.left = left+'px';
  el.value = 1;
  console.log(el.style.visibility);
  el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
}
function overlayadmin() {
  console.log('pop it');
  el = document.getElementById("overlayadmin");
  var offset1 = document.getElementById('stats').getBoundingClientRect();
  var offset2 = document.getElementById('fisprop').getBoundingClientRect();
  var offset3 = document.getElementById('fisbus').getBoundingClientRect();
  var offset4 = document.getElementById('fisother').getBoundingClientRect();
  var offseticons = document.getElementById('icon-section').getBoundingClientRect();
  var top = offseticons.top+10;
  var left = offset4.left+30;
  // 	el.style.margin = "'.top.' '. left'";
  el.style.top = top+'px';
  el.style.left = left+'px';
  el.value = 1;
  el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
}
function overlayxls() {
  el = document.getElementById("overlayxls");
  var offset1 = document.getElementById('stats').getBoundingClientRect();
  var offset2 = document.getElementById('fisprop').getBoundingClientRect();
  var offset3 = document.getElementById('fisbus').getBoundingClientRect();
  var offset4 = document.getElementById('fisother').getBoundingClientRect();
  var offseticons = document.getElementById('icon-section').getBoundingClientRect();
  var top = offseticons.top+10;
  var left = offset4.left+30;
  // 	el.style.margin = "'.top.' '. left'";
  el.style.top = top+'px';
  el.style.left = left+'px';
  el.value = 1;
  el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
}
function overlayreports() {
  el = document.getElementById("overlayreports");
  var offset1 = document.getElementById('stats').getBoundingClientRect();
  var offset2 = document.getElementById('fisprop').getBoundingClientRect();
  var offset3 = document.getElementById('fisbus').getBoundingClientRect();
  var offset4 = document.getElementById('fisother').getBoundingClientRect();
  var offseticons = document.getElementById('icon-section').getBoundingClientRect();
  var top = offseticons.top+10;
  var left = offset4.left+30;
  // 	el.style.margin = "'.top.' '. left'";
  el.style.top = top+'px';
  el.style.left = left+'px';
  el.value = 1;
  el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
}
function overlaysearch() {
  el = document.getElementById("overlaysearch");
  var offset1 = document.getElementById('stats').getBoundingClientRect();
  var offset2 = document.getElementById('fisprop').getBoundingClientRect();
  var offset3 = document.getElementById('fisbus').getBoundingClientRect();
  var offset4 = document.getElementById('fisother').getBoundingClientRect();
  var offseticons = document.getElementById('icon-section').getBoundingClientRect();
  var top = offseticons.top+10;
  var left = offset4.left+30;
  // 	el.style.margin = "'.top.' '. left'";
  el.style.top = top+'px';
  el.style.left = left+'px';
  el.value = 1;
  el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
}
function overlayeasteregg() {
  el = document.getElementById("overlayeasteregg");
  var w = 800;
  var h = 330;
    var left = (screen.width/2)-w;
    var top = (screen.height/2)-h;
  // 	el.style.margin = "'.top.' '. left'";
  el.style.top = top+'px';
  el.style.left = left+'px';
  el.value = 1;
  el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
}
function overlayAdminLogin() {
    el = document.getElementById("overlayAdminLogin");
    var offset1 = document.getElementById('stats').getBoundingClientRect();
    var offset2 = document.getElementById('fisprop').getBoundingClientRect();
    var offset3 = document.getElementById('fisbus').getBoundingClientRect();
    var offset4 = document.getElementById('fisother').getBoundingClientRect();
    var offseticons = document.getElementById('icon-section').getBoundingClientRect();
    // 	var w = 300;
    // 	var h = 300;
    var top = offseticons.top+10;
    var left = offset4.left+30;
    //     var left = (screen.width/2)-w;
    //     var top = (screen.height/2)-h;
    // 	el.style.margin = "'.top.' '. left'";
    el.style.top = top+'px';
    el.style.left = left+'px';
    el.value = 1;
    el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
}
//the next function is the handler for overlayAdminLogin
function goToSelectedDistrict(){
    el = document.getElementById("overlayAdminLogin");
    el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";

      odistrictid = $("select#dropdistrict");
      districtid  = odistrictid.val();
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("debug1").innerHTML =
        this.responseText+' -200- '+districtid;
      }else {
        document.getElementById("debug1").innerHTML =
        this.responseText+' -nil- '+districtid;;
        }
      };
      xhttp.open("POST", "php/Admin/changeDistrict.php", true);
      xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xhttp.send("selectedDistrictid="+districtid);
}
