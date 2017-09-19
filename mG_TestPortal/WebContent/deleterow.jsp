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
Statement st=con.createStatement();

	String sql="delete from `com` where Enroll='"+enroll+"'and Msg='"+msg+"'";
	st.executeUpdate(sql);


}
catch(Exception e)
{e.printStackTrace();}

%>

</body>
</html>