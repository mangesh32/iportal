<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
	String id="";
    String name="";
    String branch="";
    String sem="";
    String msg=request.getParameter("msg");
    String sub=request.getParameter("subject");
    String faculty=request.getParameter("faculty");

try{
	if(session!=null){
		  if(session.getAttribute("loginuser")!=null){
			  id=session.getAttribute("enroll").toString();
			  name=session.getAttribute("loginuser").toString();
			  branch=session.getAttribute("branch").toString();
			  sem=session.getAttribute("semester").toString();
			  //String loginuser=session.getAttribute("loginuser").toString();
			  //System.out.println(".............................");
			  //System.out.println(session.getAttribute("loginuser")+" : Logged IN.");
			  response.setHeader("Cache-Control","no-cache");
			  response.setHeader("Cache-Control","no-store");
			  response.setHeader("Pragma","no-cache");
			  response.setDateHeader ("Expires", 0);
			  
		  }else{
			  throw new Exception("Invalid User Login");
		  }
		 
	  }else{
		  throw new Exception("Invalid User Login");
	  }
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/sessional", "root", "");
	Statement st=con.createStatement();
	
    String sql ="insert into `com` values('"+name+"','"+id+"','"+branch+"','"+sem+"','"+msg+"','"+sub+"','"+faculty+"')" ;
	st.executeUpdate(sql);
	out.print("Request Registered!!");
	
	
}
catch(Exception e)
{
System.out.println(e);
out.print("Failed to Register Request");
}

%>