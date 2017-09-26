<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ page import="java.sql.*" %>
  <%@ page import="java.security.SecureRandom" %>
  <%@ page import="java.util.Random" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Signing Up...</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Bootstrap -->
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<script src="js/jquery.min.js"></script>

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
 				<%	response.setHeader("Cache-Control","no-cache");
  			  response.setHeader("Cache-Control","no-store");
  			  response.setHeader("Pragma","no-cache");
  			  response.setDateHeader ("Expires", 0);
  			  
  			  
  			String enrollment=request.getParameter("enrollment").toUpperCase();
            String name=request.getParameter("name").toUpperCase();
            String pass=request.getParameter("pass");
            String branch=request.getParameter("branch").toUpperCase();
            String semester=request.getParameter("semester");
            String email=request.getParameter("email");
            String question=request.getParameter("seq_ques");
            String answer=request.getParameter("seq_ans");
            String userkey=request.getParameter("userkey");
                %>   
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
            
            
            

            Statement statement = connection.createStatement();
            PreparedStatement ps=connection.prepareStatement("select genkey from `gen_key` where enrollement=?");
            ps.setString(1,enrollment);
            ResultSet rs=ps.executeQuery(); 
            if(rs.next()){
            	if(userkey.equals(rs.getString("genkey")))
            	{
            	PreparedStatement ps1=connection.prepareStatement("INSERT INTO auth_table VALUES (?,?,?,?,?,?,?,?,?)");
            	ps1.setString(1,name);
            	ps1.setString(2,enrollment);
            	ps1.setString(3,branch);
            	ps1.setInt(4,Integer.parseInt(semester));
            	ps1.setString(5,pass);
            	ps1.setString(6,question);
            	ps1.setString(7,answer);
            	ps1.setString(8,email);
            	ps1.setInt(9,0);
            	ps1.executeUpdate();
            	 PreparedStatement ps3=connection.prepareStatement( "DELETE FROM `gen_key` WHERE enrollement =?");
            	 ps3.setString(1,enrollment);
            	 ps3.executeUpdate();
            	
            	%>
            	   <script type="text/javascript">
            	   swal("Registered!!", "You're being directed to login page..", "success");
            	   setTimeout(function(){ window.location="index.html"; }, 2000);
            	   </script>
            	<%
            	}
            else{
            	 PreparedStatement ps2=connection.prepareStatement( "DELETE FROM `gen_key` WHERE enrollement =?");
            	 ps2.setString(1,enrollment);
            	 ps2.executeUpdate();
            	 %>
            	   <script type="text/javascript">
            	   swal("Sorry!!", "Key MisMatch!!", "error");
            	   setTimeout(function(){ window.location="index.html"; }, 2000);
            	   </script>
            	 
            	 <%
            }
         }else{
        	 throw new Exception("Access Denied!!");
         } 
             connection.close();
     
         }catch(Exception e)
         {e.printStackTrace();
         %><script type="text/javascript">
         swal("Access Denied!!", "You're being directed to login page..", "error");
         setTimeout(function(){ window.location="index.html"; }, 2000);
             </script><%
         }
             %>     
     <script> 
     //setTimeout(function(){ window.location="index.html"; }, 2000);
     </script>
     <script src="js/jquery.min.js"></script>
  		<script src="js/bootstrap.min.js"></script>
</body>
</html>