	<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
 <%@ page import="java.io.*" %>
    <%@ page import="java.text.*" %>
 <%@ page import="java.util.Date" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <title>Faculty Portal</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/facstyle.css">
  <script src="sweetalert-master/dist/sweetalert.min.js"></script>
  <script src="js/jquery.min.js"></script>
  <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script> 
  <script src="js/facjs.js"></script>
  <link rel="stylesheet" type="text/css" href="sweetalert-master/dist/sweetalert.css">

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->

    </head>
    <body>
      <% 
      try{
    	  String userid="";
    	  String pass="";
    	  if(session!=null){
    		  if(session.getAttribute("loginuser")!=null){
    			  userid=session.getAttribute("enroll").toString();
    			  pass=session.getAttribute("pwd").toString();
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
         
     //................................Variables...................................
          String name;
          String sql3;
          String sql4;
          Connection connection;
          Statement st;
          Statement st2;
          Statement st3;
          Statement st4;
          ResultSet rs;
          ResultSet rs2;
          ResultSet rs3;
          ResultSet rs4;
          
          
     //.............................................................................     

      try{
    	  ServletContext context = pageContext.getServletContext();
  		String url_db = context.getInitParameter("address");
  		String url_db2 = context.getInitParameter("address2");
  		String id_db = context.getInitParameter("id");
  		String pass_db = context.getInitParameter("pass");
  	 Class.forName("com.mysql.jdbc.Driver"); 
      connection = DriverManager.getConnection(url_db,id_db,pass_db);
      
      //............................Start Body................................
      %>
      
      
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">Portal</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Home</a></li>
        <li><a href="#">Profile</a></li>
     </ul>
      <ul class="nav navbar-nav navbar-right">
         <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-in"></span> LogOut</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container">
   
   
    	  <div class="polaroid">
 
 			<div class="row">
                          	<div class="col-sm-3">
                          		<p id="changepass" class="icons"><img src="img/changepass.png" class="icon-links"></img> Change Password</p>
                          	</div>
                          	
                          	<div class="col-sm-3">
                          		<p id="sessmarks" class="icons"><img src="img/anssheet.png" class="icon-links"></img> Sessionals</p>
                          	</div>
                          		  
                            	      
            </div>
 
 	   </div>
   
     
 
 
</div>
      
      <%
	  //............................End Body................................
connection.close();
}catch(Exception e)
{System.out.println(e);%><script type="text/javascript">
swal("Connection Error!!", "You're being directed to login page..", "error");
setTimeout(function(){ window.location="index.html"; }, 2000);
</script>
<%} 
}catch(Exception fec){
	//System.out.println(fec);
	%>
	<script type="text/javascript">
	swal("Access Denied!!", "You're being directed to login page..", "error");
	setTimeout(function(){ window.location="index.html"; }, 1000);	
	</script>	
<%}%>
</body>
	
</html>