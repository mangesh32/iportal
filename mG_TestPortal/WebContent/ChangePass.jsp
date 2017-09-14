<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ChangePassword</title>
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
	try{String id="";
		String currentpass="";
		String newpass=request.getParameter("newpass");
		if(session!=null){
			if(session.getAttribute("loginuser")!=null){
				id=session.getAttribute("enroll").toString();
				currentpass=session.getAttribute("pwd").toString();
				
			}else{
				session.invalidate();
				throw new Exception("UnAuthorized!!!");
			}
			
			
		}else{
			throw new Exception("UnAuthorized!!!");
		}
		
		
		
		
		
		String password="";
		 ServletContext context = pageContext.getServletContext();
	  		String url_db = context.getInitParameter("address");
	  		String id_db = context.getInitParameter("id");
	  		String pass_db = context.getInitParameter("pass");
	  	 Class.forName("com.mysql.jdbc.Driver"); 
	      Connection connection = DriverManager.getConnection(url_db,id_db,pass_db);
	      
	      PreparedStatement ps1=connection.prepareStatement("select password from auth_table where enrollment=? and password=?");
	      ps1.setString(1,id);
	      ps1.setString(2,currentpass);
	      ResultSet rs1=ps1.executeQuery();
	      if(rs1.next())
	      {		
	    	 password=rs1.getString("password");
	      	 if(currentpass.equals(password))
	      	 {
	      		 PreparedStatement ps2=connection.prepareStatement("update auth_table set password=? where enrollment=?");
	   	      ps2.setString(1,newpass);
	   	  	  ps2.setString(2,id);
	   	  	  ps2.executeUpdate();
	   	  	  ps2.close();
	   	  	  System.out.println(session.getAttribute("loginuser")+" : Changed Password.");
	   	   %>
	    	  <script>
					swal("Success","Password Changed !!","success");
					setTimeout(function(){ window.location="logout.jsp"; }, 1000);
	    	  </script>
	    	  <% 
	      	 }
		      }
	      else{
	    	  %>
	    	  <script>
					swal("Sorry","Wrong Password !!","warning");
					setTimeout(function(){ window.location="logout.jsp"; }, 1000);
	    	  </script>
	    	  <% 
	      }
	      ps1.close();rs1.close();connection.close();
	}catch(NullPointerException npe)
	{System.out.print(npe);
		%>
		<script>
			swal("Warning","Provide Valid ID","warning");
			setTimeout(function(){ window.location="index.html"; }, 1000);
		</script>
		<%
	}
catch(Exception fec){
	//System.out.println(fec);
	%>
	<script type="text/javascript">
	swal("403 Forbidden!!", "You're being directed to login page..", "error");
	setTimeout(function(){ window.location="index.html"; }, 1000);
	//window.location="index.html";
	</script><%
}

%>
</body>
</html>