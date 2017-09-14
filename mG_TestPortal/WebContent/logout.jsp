<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LogOut</title>
</head>
<body>
<%
try{
request.getSession(false);
if(session != null)
    {
	String name=session.getAttribute("loginuser").toString();
    session.removeAttribute("loginuser");
    session.removeAttribute("enroll");
    session.removeAttribute("pwd");
    session.invalidate();
    System.out.println(name+" : Logged OUT.");
    System.out.println(".............................");
    
    
    
    }
response.sendRedirect("index.html");
}catch(Exception e)
{
response.sendRedirect("index.html");
}
%>
</body>
</html>