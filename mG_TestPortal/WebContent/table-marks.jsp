<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
 
  <script src="sweetalert-master/dist/sweetalert.min.js"></script>
      <script src="js/jquery.min.js"></script>
      <link rel="stylesheet" type="text/css" href="sweetalert-master/dist/sweetalert.css">

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
      <style type="text/css">
   
      
      </style>
	<script>
		var c=[];
		c.push("Class Attended TH");
		c.push("Class Attended PR");
		c.push("Total");
		c.push("Attendance %");
		c.push("Attendance Marks");
		c.push("Attendance Marks");
		c.push("MidSem 1 Marks");
		c.push("MidSem 1 Marks");
		c.push("MidSem 2 Marks");
		c.push("MidSem 2 Marks");
		c.push("Teachers Marks");
		c.push("Tutorial Assesments");
		c.push("Minor 1");
		c.push("Minor 2");
		c.push("Quiz");
		c.push("Assignment");
		c.push("Tutorials/Prob Solving");
		c.push("Lab Performance");
		c.push("Lab Work Marks");
		c.push("Vive Voce/ Assignments");
		var outof=[];
		outof.push("60");
		outof.push("20");
		outof.push("80");
		outof.push("100");
		outof.push("10");
		outof.push("5");
		outof.push("20");
		outof.push("5");
		outof.push("20");
		outof.push("5");
		outof.push("5");
		outof.push("5");
		outof.push("10");
		outof.push("10");
		outof.push("5");
		outof.push("5");
		outof.push("10");
		outof.push("5");
		outof.push("20");
		outof.push("20");
	var data=[[]];
	
	$(document).ready(function(){
		for(var i=0;i<c.length;i++){
		     $("#table-body").append("<tr><td>"+c[i]+"</td><td>"+outof[i]+"</td></tr>");
		
		}
		
	})
	
	
	
	</script>
</head>
<body>
 			<table class="table">
 			<thead>
 				<th>CRITERIA</th>
 				<th>OUT OF</th>
 				
 			</thead>
			<tbody id="table-body">
			
			</tbody>
		
</table>
</body>
</html>