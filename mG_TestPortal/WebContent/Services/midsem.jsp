<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Midsem Scrap</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Titillium+Web" rel="stylesheet">
<script src="../sweetalert-master/dist/sweetalert.min.js"></script>

<link rel="stylesheet" type="text/css" href="../sweetalert-master/dist/sweetalert.css">
<style>
	html,body{
		 height: 100%;
    background-repeat: no-repeat;
    /*background-image: linear-gradient(135deg, rgba(31,123,229,1) 0%, rgba(58,139,232,1) 47%, rgba(70,153,234,1) 92%, rgba(72,156,234,1) 100%);*/
    background-image: url("../img/wall.jpg"); 
    background-size: 100% 100%;
     background-attachment: fixed;
	font-family: 'Titillium Web', sans-serif;
  
	}
	#table{
	margin-top:70px;
	}
	td{
		color:black;
		text-align:center;
		font-weight:600;
		background-color:white;
	}
	.doblack td{
		background-color:#17191a;
		color:white;
		font-weight:600;
	}
	
</style>
</head>
<body>
<div class="container">
<div class="table-responsive" id="restable">
<%
try{
	String enrollment="";
	  String sem=request.getParameter("semesterMidtest");
	  String midtest=request.getParameter("mid_test");
	  if(session!=null){
		  if(session.getAttribute("loginuser")!=null){
			  enrollment=session.getAttribute("enroll").toString();
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
try {
    URL url = new URL("http://115.254.62.25:8080/College_Mid_Sem_March/Show_Result.jsp?enroll="+enrollment+"&semester="+sem+"&mid_test="+midtest);
    //URL url = new URL("http://localhost/midsem/index.html");

   URLConnection urlConnection = url.openConnection();
    HttpURLConnection connection = null;
    if(urlConnection instanceof HttpURLConnection) {
       connection = (HttpURLConnection) urlConnection;
    }else {
       out.println("Please enter an HTTP URL.");
   }
    
    BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
    String urlString = "<table class=\"table table-bordered\" id=\"table\">";
    String current;
    int count=0;
    int rowcount=0;
    
    while((current = in.readLine()) !=null ) {
    	int b=current.indexOf("<table");
    	
    	if(b>=0)
    	{	count++;
    		while((current=in.readLine()).indexOf("</table>")<0)
    		{
    			if(count==3)
    			{	
    				if((current.indexOf("<tr>")>=0) && (rowcount==0||rowcount==1))
    				{	rowcount++;   					
    					urlString+="<tr class=\"doblack\">";
    					
    				}
    				else
    				urlString += current;
    				
    			}
    		}
    	}continue;
       
    }urlString+="</table>";
    out.println(urlString);
    %>
   </div> 
    <script>
    
    
    $('td div').filter(function() {
        return $(this).children().length === 0;
    }).text(function(_, old) {
        return $.trim(old);
    });
    $('td div:empty').remove();
    $('td').filter(function() {
        return $(this).children().length === 0;
    }).text(function(_, old) {
        return $.trim(old);
    });
    $('td:empty').html("-");
   
    if($("table:has(tr)").length==0)
    	{
    	swal("Sorry","No Record Found!!","error");
    	setTimeout(function(){ window.location="../Portal.jsp"; }, 1000);
    	
    	}
    </script>
    
    
    <%
    
 }catch(IOException e) {
    System.out.println(e);
    %>
	<script type="text/javascript">
	swal("Connection Problem!!", "Try again later..", "error");
	setTimeout(function(){ window.location="../Portal.jsp"; }, 1000);
	//window.location="index.html";
	</script>
	<%
 }
}catch(Exception ex){
	System.out.println(ex);
	%>
	<script type="text/javascript">
	swal("Access Denied!!", "You're being directed to login page..", "error");
	setTimeout(function(){ window.location="../index.html"; }, 1000);
	//window.location="index.html";
	</script>
	<%
}
%>
</div>
</body>
</html>