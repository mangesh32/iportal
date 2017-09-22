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
            	   setTimeout(function(){ window.location="index.html"; }, 2000);
            	   </script>
            	<%
            	}
            else{
            	Random RANDOM = new SecureRandom();
            	String letters = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789+@";

                String pw = "";
                for (int i=0; i<8; i++)
                {
                    int index = (int)(RANDOM.nextDouble()*letters.length());
                    pw += letters.substring(index, index+1);
                }
             PreparedStatement ps0=connection.prepareStatement( "select * FROM `gen_key` WHERE enrollement =?");
           	 ps0.setString(1,enrollment);
           	 ResultSet rs0=ps0.executeQuery();
           	 if(rs0.next())
           	 {
           	 PreparedStatement ps3=connection.prepareStatement( "DELETE FROM `gen_key` WHERE enrollement =?");
           	 ps3.setString(1,enrollment);
           	 ps3.executeUpdate();
           		 
           	 }
                PreparedStatement ps1=connection.prepareStatement("insert into `gen_key` values (?,?)");
                ps1.setString(1,enrollment);
                ps1.setString(2,pw);
                ps1.executeUpdate();
                
                
            	//st="INSERT INTO auth_table VALUES ('"+name+"','"+enrollment+"','"+branch+"','"+semester+"','"+pass+"','"+question+"','"+answer+"','"+mobile+"',0)";
           		//statement.executeUpdate(st);
           		%>
           		<form action="SignUp2.jsp" method="post" id="target">
           			<input type="hidden" value="<%=enrollment%>" name="enrollment" >
           			<input type="hidden" value="<%=name%>" name="name" >
           			<input type="hidden" value="<%=pass%>" name="pass" >
           			<input type="hidden" value="<%=branch%>" name="branch" >
           			<input type="hidden" value="<%=semester%>" name="semester" >
           			<input type="hidden" value="<%=email%>" name="email" >
           			<input type="hidden" value="<%=question%>" name="seq_ques" >
           			<input type="hidden" value="<%=answer%>" name="seq_ans" >           			
           			<input id="keyfield" type="hidden" value="" name="userkey" >
           		</form>
           		
           		
           		
           		<script type="text/javascript">
           		
           		          		
           		
           		$.post("http://<%=request.getServerName()%>/mail/index.php",
    				    {
    				        email: "<%=email%>",
    				        pw: "<%=pw%>"
    				    });
           		swal({
          		  title: "Enter Security Key!",
          		  text: "A security key has been mailed to your registered email..:",
          		  type: "input",
          		  showCancelButton: false,
          		  closeOnConfirm: false,
          		  animation: "slide-from-top",
          		  inputPlaceholder: "Activation Key here..."
          		},
          		function(inputValue){
          		  if (inputValue === false) return false;
          		  
          		  if (inputValue === "") {
          		    swal.showInputError("You need to write something!");
          		    return false
          		  }
          		  $("#keyfield").val(inputValue);
          		  $("#target").submit();
          		});
           		
           		
           		
           		
           		
           		
           		</script>
           	     	
           		<%
            
            }
             
             connection.close();
     
         }catch(Exception e)
         {System.out.println(e);
         %><script type="text/javascript">
         swal("Connection Error!!", "You're being directed to login page..", "error");
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