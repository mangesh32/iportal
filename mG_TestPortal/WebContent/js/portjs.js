
var ssub="",sfaculty="",smsg="";


$(document).ready(function(){
	$('select').selectpicker();	
	for (var i =0 ; i<sub.length; i++) {
		$("#sub-frame-tbody").append("<tr><td><button class=\"btn sel-sub\" val=\""+i+"\">"+sub[i]+"</button></td><td>"+sumOfOutof[i]+"</td><td>"+sumOfObtained[i]+"</td><td><button class=\"btn btn-success Review\" val=\""+i+"\">Ask For Review</button></td></tr>");
	}
	
	for(var l=0;l<statusdata.length;l++)
		 {
		
		 var tbody=document.getElementById("sub-frame-tbody");
		  	for(var u=0;u<tbody.childElementCount;u++)
		 	{
		 		var btnvalue=tbody.children[u].children[0].children[0].innerHTML;
		 		var statusvalue=tbody.children[0].children[3];
		 		if(btnvalue==statusdata[l].sub){
		 			statusvalue.innerHTML=statusdata[l].status;
		 		}
		 			
		 	}
		 
		 
		 }
	
$("#frame-2").hide();
$("#btn-history").click(function(){
	$("#frame-1").hide();
	$("#sess-frame").hide();
	$("#frame-2").fadeIn();
});
$("#btn-home").click(function(){
	$("#frame-2").hide();
	$("#sess-frame").hide();
	$("#frame-1").fadeIn();
	
});
$("#changepass").click(function(){
	$("#records").hide();
	$("#ChangePassFrame").fadeIn();
	
});
$("#midsem").click(function(){
	$("#records").hide();
	$("#MidsemFrame").fadeIn();
	
});
$("#sessmarks").click(function(){
	$("#frame-1").hide();
	$("#frame-2").hide();
	$("#sess-frame").fadeIn();
});
$(".btn-backhome").click(function(){
	$("#ChangePassFrame").hide();
	$("#MidsemFrame").hide();
	$("#records").fadeIn();
});


$("#lgout").click(function(){
	window.location="logout.jsp";
});


$(".sel-sub").click(function(){

	$("#sub-frame").hide();
	$("#marks-frame").fadeIn();
	
	load_data($(this).attr("val"));
});

$("#back").hover(function(){
	$(this).toggleClass("whiteback");
});

$("#back").click(function(){
	
	$("#marks-frame").hide();
	$("#sub-frame").fadeIn();
 
});

$(".Review").click(function(){
	ssub=sub[$(this).attr("val")];
	sfaculty=fac[$(this).attr("val")];
		
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
				        msg:smsg,
				        status:"Requested"
				    });
		});
	
});

});


