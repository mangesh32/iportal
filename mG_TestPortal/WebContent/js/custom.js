function validID(loginid)
{var regex=/\d{4}(cs|it|ec|ex|me|ce|CS|IT|EC|EX|ME|CE)\d{6}/g;
	return regex.test(loginid);
}
function warn(el)
{
	document.getElementById(el).style.borderColor="red";
}
$(document).ready(function(){
	$('select').selectpicker();	
	
	$("#fstbtn").click(function(){
		console.log(validID($("#inputEmail").val()));
		if(validID($("#inputEmail").val()))
			{
				$('.txt-email').hide();							
				$('.txt-password').fadeIn();
				$("#fstbtn").hide();	
				$("#lstbtn").show();

			}
			else{
				
				$("#success-alert").fadeTo(5000, 50).slideUp(500, function(){
    			$("#success-alert").slideUp(500);
				});
			}	
		})
	$("#signupbtn").click(function(){
		$("#login_frame").hide();
		$("#signup_frame").fadeIn();
	})
	$(".btn-loginback").click(function(){
		$("#signup_frame").hide();
		$("#forgot_frame").hide();
		$("#login_frame").fadeIn();
	})
	
	$("#forgotbtn").click(function(){
		$("#login_frame").hide();
		$("#forgot_frame").fadeIn();
	})
	
	
	$("#signup_submit").click(function(){
		var flag=true;
		if(!validID($("#enrollment").val()))
		{warn("enrollment");flag=false;}

		return flag;
	})
	$(".btn_student").click(function(){
		
		$("#admin_frame").hide();
		$("#login_frame").fadeIn();
	})
	$(".btn_faculty").click(function(){
		
		$("#login_frame").hide();
		$("#admin_frame").fadeIn();
		
	})
	
})