$(document).ready(function(){
	if($("#sub_show").html()=="null")
		{$("#undeploy_btn").attr("class","btn btn-danger disabled");
		$("#undeploy_btn").attr("disabled","disabled");
		}
	$("#check_btn").click(function(){
		window.open("index.html");
	})
	
	$("#undeploy_btn").click(function(){
		if($("#undeploy_btn").attr("class")=="btn btn-danger"){
		window.location="UnDeploy.jsp";
		this.attr("class","btn btn-danger disabled");
		this.attr("disabled",'');}
	})

$("#btnTestRecords").click(function(){
	
	$("#frame-1").hide();
	$("#frame-3").hide();
	$(".trpback").hide();	
	$(".trpback").fadeIn();
	$("#frame-2").fadeIn();
	$("#btnUsers").attr("class","btn btn-primary");
	$("#btnTestCreator").attr("class","btn btn-primary ");
	$("#btnTestRecords").attr("class","btn btn-primary active");
});
$("#btnUsers").click(function(){
	
	$("#frame-2").hide();
	$("#frame-3").hide();
	$(".trpback").hide();	
	$(".trpback").fadeIn();
	$("#frame-1").fadeIn();
	$("#btnTestRecords").attr("class","btn btn-primary ");
	$("#btnTestCreator").attr("class","btn btn-primary ");
	$("#btnUsers").attr("class","btn btn-primary active ");
});
$("#btnTestCreator").click(function(){
	
	$("#frame-1").hide();
	$("#frame-2").hide();
	$(".trpback").hide();	
	$(".trpback").fadeIn();
	$("#frame-3").fadeIn();
	$("#btnTestRecords").attr("class","btn btn-primary ");
	$("#btnUsers").attr("class","btn btn-primary ");
	$("#btnTestCreator").attr("class","btn btn-primary active ");
});

$("#signup_submit").click(function(){
	var flag=false;
	
	if($("#file-3").val().slice($("#file-3").val().lastIndexOf(".")+1)=="csv")
	flag=true;
	if(flag==false)swal("Error","Wrong File Format !!!","error");
	return flag;
})

$('select').selectpicker();
$("#samplesheet").click(function(){
	
	window.open("samplesheet.csv","_blank");
})


});