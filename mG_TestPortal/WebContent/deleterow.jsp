<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String enroll=request.getParameter("Enroll");
String msg=request.getParameter("Msg");


try{
	
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/sessional", "root", "");


	PreparedStatement ps=con.prepareStatement("delete from `com` where Enroll=? and Msg=?");
	ps.setString(1,enroll);
	ps.setString(2,msg);
	ps.executeUpdate();
	ps.close();


}
catch(Exception e)
{System.out.println("DeleteReview: "+e);}

%>

</body>
</html>