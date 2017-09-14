

$(document).ready(function(){
	for (var i =0 ; i<sub.length; i++) {
		$("#sub-frame").append("<center><button class=\"sel-sub\" val=\""+i+"\">"+sub[i]+"</button></center><br>");
	}
	
	

$("#frame-2").hide();
$("#btn-history").click(function(){
	$("#frame-1").hide();
	$("#sess-frame").hide();
	

	$("#frame-2").fadeIn();


})
$("#btn-home").click(function(){
	$("#frame-2").hide();
	$("#sess-frame").hide();
	$("#frame-1").fadeIn();




})
$("#changepass").click(function(){
	$("#records").hide();
	$("#ChangePassFrame").fadeIn();
	
})
$("#sessmarks").click(function(){
	$("#frame-1").hide();
	$("#frame-2").hide();
	$("#sess-frame").fadeIn();	
})
$(".btn-backhome").click(function(){
	$("#ChangePassFrame").hide();
	$("#records").fadeIn();
})


$("#lgout").click(function(){
	window.location="logout.jsp";
})


$(".sel-sub").click(function(){

	$("#sub-frame").hide();
	$("#marks-frame").fadeIn();
	
	load_data($(this).attr("val"));




})



$("#back").click(function(){
	console.log("here");
	$("#marks-frame").hide();
	$("#sub-frame").fadeIn();

})


	
})
 