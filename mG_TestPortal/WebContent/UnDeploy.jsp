<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@page import="java.sql.*" %>
   <%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>UnDeployer</title>
	<script src="sweetalert-master/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="sweetalert-master/dist/sweetalert.css">
</head>
<body>
	<%
	try{
		  ServletContext context = pageContext.getServletContext();
	  		String url_db = context.getInitParameter("address");
	  		String id_db = context.getInitParameter("id");
	  		String pass_db = context.getInitParameter("pass");
	  	 Class.forName("com.mysql.jdbc.Driver"); 
	      Connection connection = DriverManager.getConnection(url_db,id_db,pass_db);
    Statement st1=connection.createStatement();
    st1.executeUpdate("truncate table sheet1");
    st1.executeUpdate("truncate table current_test");
    st1.executeUpdate("UPDATE `auth_table` SET `testFlag`=false");
    System.out.println("Test UnDeployed\n----------------");
    
    %><script>
	swal("Success","Test Undeployed !!","success");
	setTimeout(function(){ window.location="admin.jsp?pass=cold_2000"; }, 1000);
	</script><% 
	
	st1.close();
	connection.close();
    
    
	}catch(Exception e)
	{System.out.print(e);
	%><script>
	swal("Connection Error","try again !!","error");
	setTimeout(function(){ window.location="index.html"; }, 1000);
	</script><% 
	}
	%>
</body>
</html>