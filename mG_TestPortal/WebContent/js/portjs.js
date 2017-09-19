
var problem="";
var txt="";
var review_status="No Review Requested";
var ssub="",sfaculty="",smsg="";







$(document).ready(function(){
	
	for (var i =0 ; i<sub.length; i++) {
		$("#sub-frame-tbody").append("<tr><td><button class=\"btn sel-sub\" val=\""+i+"\">"+sub[i]+"</button></td><td>"+sumOfOutof[i]+"</td><td>"+sumOfObtained[i]+"</td><td>"+review_status+"</td></tr>");
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
	var problem="";
	var txt="";
	
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
	ssub=sub[$(this).attr("val")];
	sfaculty=fac[$(this).attr("val")];
	load_data($(this).attr("val"));
	




})

$("#back").hover(function(){
	$(this).toggleClass("whiteback");
})

$("#back").click(function(){
	
	$("#marks-frame").hide();
	$("#sub-frame").fadeIn();
 
})

$("#Review").click(function(){
	swal({
		  title: "Provide details!",
		  text: "Write ur problem here..:",
		  type: "input",
		  showCancelButton: true,
		  closeOnConfirm: false,
		  animation: "slide-from-top",
		  inputPlaceholder: "Write something"
		},
		function(inputValue){
		  if (inputValue === false) return false;
		  
		  if (inputValue === "") {
		    swal.showInputError("You need to write something!");
		    return false
		  }
		  smsg=inputValue;
		  swal("Request Registered!!", "You wrote: " + inputValue, "success");
		  $.post("virtual.jsp",
				    {
				        subject: ssub,
				        faculty: sfaculty,
				        msg:smsg
				    });
		});
	
});

})


