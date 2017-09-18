
var problem="";
var txt="";
$(document).ready(function(){
	
	for (var i =0 ; i<sub.length; i++) {
		$("#sub-frame-tbody").append("<tr><td><button class=\"btn sel-sub\" val=\""+i+"\">"+sub[i]+"</button></td><td>"+sumOfOutof[i]+"</td><td>"+sumOfObtained[i]+"</td></tr>");
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
	txt=sub[$(this).attr("val")];
	window.alert(txt);
	
	load_data($(this).attr("val"));
	




})

$("#back").hover(function(){
	$(this).toggleClass("whiteback");
})

$("#back").click(function(){
	console.log("here");
	$("#marks-frame").hide();
	$("#sub-frame").fadeIn();
 
})


	
})


 function promptWindow() {
	
		    var person = prompt("Enter your problem:", "");
		    if (person == null || person == "") {
		        problem +=problem+ "";
		    } else {
		        problem +=problem+txt+" : "+person+"\n";
		       }
		   
		 
		}
 



var problem="";
var txt="";
$(document).ready(function(){
	
	for (var i =0 ; i<sub.length; i++) {
		$("#sub-frame-tbody").append("<tr><td><button class=\"btn sel-sub\" val=\""+i+"\">"+sub[i]+"</button></td><td>"+sumOfOutof[i]+"</td><td>"+sumOfObtained[i]+"</td></tr>");
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
	txt=sub[$(this).attr("val")];
	
	
	load_data($(this).attr("val"));
	




})

$("#back").hover(function(){
	$(this).toggleClass("whiteback");
})

$("#back").click(function(){
	console.log("here");
	$("#marks-frame").hide();
	$("#sub-frame").fadeIn();
 
})


	
})
 function promptWindow() {
	
		    var person = prompt("Enter your problem:", "");
		    if (person == null || person == "") {
		        problem += "";
		    } else {
		        problem +=txt+" : "+person+"\n";
		       
		    }
		   
		 
		}

