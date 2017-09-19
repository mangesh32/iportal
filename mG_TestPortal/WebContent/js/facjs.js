$(document).ready(function(){
	
	$("#changepass").click(function(){
		$("#records").hide();
		$("#ChangePassFrame").fadeIn();
		
	});
	$(".btn-backhome").click(function(){
		$("#ChangePassFrame").hide();
		$("#records").fadeIn();
	});
	
	$("#sessmarks").click(function(){
		$("#records").hide();
		
		$("#sess-frame").fadeIn();
			
	});
	$("#home").click(function(){
		$("#ChangePassFrame").hide();
		$("#sess-frame").hide();
		
		$("#records").fadeIn();
			
	});
	
	$("#sessbtn2").click(function(){
		$("#Reviewtable").hide();
		$("#uploadSheet").fadeIn();
		
	});
	
	$("#sessbtn1").click(function(){
		$("#uploadSheet").hide();
		$("#Reviewtable").fadeIn();		
		
	});
	
	$("#signup_submit").click(function(){
		var flag=false;
		
		if($("#file-3").val().slice($("#file-3").val().lastIndexOf(".")+1)=="csv")
		flag=true;
		if(flag==false)swal("Error","Wrong File Format !!!","error");
		return flag;
	})


	$("#samplesheet").click(function(){
		
		window.open("final_sample_sheet.csv","_blank");
	})
	
	$(".delselected").click(function(){
		var c = this.parentNode.parentNode.rowIndex;
		var currEnroll = this.parentNode.parentNode.children[1].innerHTML;
		var currMsg = this.parentNode.parentNode.children[5].innerHTML;
		
		del_this(currEnroll,currMsg);								
		
		document.getElementById("Reviewtable").deleteRow(c);
	});
	
	function del_this(c,m)
	{
	    $.post("deleterow.jsp",
		    {
		        Enroll: c,
		        Msg: m
		    });
	}
	
	
})
