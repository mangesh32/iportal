<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ page import="java.sql.*" %>
 <%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logging In</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/portalstyle.css">
  <script src="sweetalert-master/dist/sweetalert.min.js"></script>
      <script src="js/jquery.min.js"></script>
      <link rel="stylesheet" type="text/css" href="sweetalert-master/dist/sweetalert.css">
</head>
<body>
<%
try{
	 String enrollment=request.getParameter("userid").toLowerCase();
     String pass=request.getParameter("key");
     
     ServletContext context = pageContext.getServletContext();
		String url_db = context.getInitParameter("address");
		String id_db = context.getInitParameter("id");
		String pass_db = context.getInitParameter("pass");
	 Class.forName("com.mysql.jdbc.Driver"); 
   Connection connection = DriverManager.getConnection(url_db,id_db,pass_db);
   Statement st=connection.createStatement();
   ResultSet rs=st.executeQuery("select name from auth_table where enrollment=\""+enrollment+"\" and password=\""+pass+"\"");
   if(rs.next())
   {
	   session=request.getSession(true);
	   session.setAttribute("loginuser", rs.getString("name"));
	   session.setAttribute("enroll", enrollment);
	   session.setAttribute("pwd", pass);
	   System.out.println(".............................");
	   System.out.println(session.getAttribute("loginuser")+" : Logged IN.");
	   response.sendRedirect("Portal.jsp");  
   }
   else{
	 //response.sendError(403, "Wrong Credentials");
	 %><script>
	   swal("Access Denied!!", "You're being directed to login page..", "error");
		setTimeout(function(){ window.location="index.html"; }, 1000);
		</script>
	   <%
   }
	
}
catch(Exception e){
	System.out.println("Database Connectivity Error!!");
 %><script>
	   swal("Sorry...", "Connectivity Error..", "error");
		setTimeout(function(){ window.location="index.html"; }, 2000);
		</script>
	   <%

}


%>
</body>
</html>