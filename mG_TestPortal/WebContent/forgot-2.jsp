<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Forgot Password</title>
	<!-- Bootstrap -->
		<script src="js/jquery.min.js"></script>
	
	<!-- Bootstrap +Bootstrap-Select -->
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<script src="js/bootstrap.min.js"></script>
	<link href="css/bootstrap-select.css" rel="stylesheet">
	<script src="js/bootstrap-select.js"></script>	
	<!-- SweetAlert + Page -->
	<script src="sweetalert-master/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="sweetalert-master/dist/sweetalert.css">
		<link rel="stylesheet" type="text/css" href="css/style_forgot-1.css">
			<script src="js/forgot-1.js"></script>
	  		
</head>
<body>
<%
	try{String id=request.getParameter("userid");
		String userans=request.getParameter("answer");
		response.setHeader("Cache-Control","no-cache");
		  response.setHeader("Cache-Control","no-store");
		  response.setHeader("Pragma","no-cache");
		  response.setDateHeader ("Expires", 0);
		
		String password="";
		 ServletContext context = pageContext.getServletContext();
	  		String url_db = context.getInitParameter("address");
	  		String id_db = context.getInitParameter("id");
	  		String pass_db = context.getInitParameter("pass");
	  	 Class.forName("com.mysql.jdbc.Driver"); 
	      Connection connection = DriverManager.getConnection(url_db,id_db,pass_db);
	      
	      PreparedStatement ps1=connection.prepareStatement("select password from auth_table where enrollment=? and answer=?");
	      ps1.setString(1,id);
	      ps1.setString(2,userans);
	      ResultSet rs1=ps1.executeQuery();
	      if(rs1.next())
	      {		
	    	 password=rs1.getString("password");
	         %>
		      <div class="container">
		      	<div class="card card-container" id="forgot_frame">
	  			<h4 style="font-weight:bold;text-align:center;font-family:Georgia;"> Password Recovery</h4><br>
	  			<p style="color:#17191a;text-align:center;font-size:16px;">Your Password is <b><%=password %></b>.</p>
	  			<br>
	  			
	  				<div class="row">
	  				
	  				<button class="btn btn-loginback" style="margin-left: 40%;" type="button" ><span class="glyphicon glyphicon-arrow-left"></span></button>
	  						
	  			    </div>
	  					

	  		</div><!-- /card-container -->
		      	
		      
		     </div><!-- /container -->
		      
		
	    
	      
	      
	      <%
	        	
		      }
	      else{
	    	  %>
	    	  <script>
					swal("Sorry","Wrong Answer !!","warning");
					setTimeout(function(){ window.location="index.html"; }, 1000);
	    	  </script>
	    	  <% 
	      }
	      ps1.close();rs1.close();connection.close();
	}catch(NullPointerException npe)
	{
		%>
		<script>
			swal("Warning","Provide Valid ID","warning");
			setTimeout(function(){ window.location="index.html"; }, 1000);
		</script>
		<%
	}
	

%>
</body>
</html>