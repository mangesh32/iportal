<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ page import="java.sql.*" %>
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

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
 				<%
 					String enrollment=request.getParameter("enrollment").toUpperCase();
                    String name=request.getParameter("name").toUpperCase();
                    String pass=request.getParameter("pass");
                    String branch=request.getParameter("branch").toUpperCase();
                    String semester=request.getParameter("semester");
                    String mobile=request.getParameter("mobile");
                    String question=request.getParameter("seq_ques");
                    String answer=request.getParameter("seq_ans");
                    
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
            String st="select name from auth_table where enrollment=\""+enrollment+"\"";
                      
            ResultSet rs=statement.executeQuery(st); 
            if(rs.next()){
            	%>
            	   <script type="text/javascript">
            	   swal("Already Registered!!", "You're being directed to login page..", "error");
            	   </script>
            	<%
            	}
            else{
            	st="INSERT INTO auth_table VALUES ('"+name+"','"+enrollment+"','"+branch+"','"+semester+"','"+pass+"','"+question+"','"+answer+"','"+mobile+"',0)";
           		statement.executeUpdate(st);
           		%>
           		<script type="text/javascript">
           		swal("You're In!", "Successfully Registered, Login Now!!!", "success");
           		</script>
           		<%
            
            }
             
             connection.close();
     
         }catch(Exception e)
         {%><script type="text/javascript">
         swal("Connection Error!!", "You're being directed to login page..", "error");
             </script><%
         }
             %>     
     <script> setTimeout(function(){ window.location="index.html"; }, 2000);</script>
     <script src="js/jquery.min.js"></script>
  		<script src="js/bootstrap.min.js"></script>
</body>
</html>