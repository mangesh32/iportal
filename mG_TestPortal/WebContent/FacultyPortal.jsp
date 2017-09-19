
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.*"%>
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
<script src="js/bootstrap.min.js"></script>
<script src="js/facjs.js"></script>
<link rel="stylesheet" type="text/css"
	href="sweetalert-master/dist/sweetalert.css">
<script type="text/javascript">
var e=[],m=[];
</script>

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
    		  if(session.getAttribute("loginuser")!=null&&session.getAttribute("post")!=null){
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
          String name="";
   		  String sql;
   		  String sql2;
          String sql3;
          String sql4;
          Connection connection,con2;
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
      st=connection.createStatement();
      sql="select name from auth_table_fac where userid=\""+userid+"\"";
      rs=st.executeQuery(sql);
      if(rs.next()){
    	  name=rs.getString("name");    	  
      }
      rs.close();
      
      //............................Start Body................................
      %>


	<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#myNavbar">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">Portal</a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav">
				<li id="home" class="active"><a href="#">Home</a></li>
				<li><a href="#">Profile</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="logout.jsp"><span
						class="glyphicon glyphicon-log-in"></span> LogOut</a></li>
			</ul>
		</div>
	</div>
	</nav>

	<div class="container">


		<div class="polaroid">

			<div id="records" class="row">
				<div class="col-sm-3">
					<p id="changepass" class="icons">
						<img src="img/changepass.png" class="icon-links"></img> Change
						Password
					</p>
				</div>

				<div class="col-sm-3">
					<p id="sessmarks" class="icons">
						<img src="img/anssheet.png" class="icon-links"></img> Sessionals
					</p>
				</div>
			</div>

			<div id="ChangePassFrame">

				<h4
					style="color: white; font-weight: bold; text-align: center; font-family: Georgia;">
					<img src="img/changepass.png" class="icon-links"></img>Change
					Password
				</h4>
				<br>

				<form class="form-signin" action="ChangePass.jsp" method="post">
					<input type="hidden" name="userid" value=<%=userid %>>
					<div class="row">
						<input type="password" name="currentpass"
							class="form-control pass-field" placeholder="Current Password"
							title="Your Current Password" required autofocus>
					</div>
					<div class="row">
						<input type="password" name="newpass"
							class="form-control pass-field" placeholder="New Password"
							title="Your New Password" required autofocus>
					</div>
					<div class="row">
						<br>
						<div class=row>
							<div class="col-sm-5">
								<button class="btn btn-backhome pull-right " type="button">
									<span class="glyphicon glyphicon-arrow-left">
								</button>
							</div>
							<div class="col-sm-7">
								<button class="btn btn-next-frgt" id="submit_chpass"
									type="submit">
									Submit<span class="glyphicon glyphicon-arrow-right"></span>
								</button>
							</div>

						</div>
					</div>
				</form>
			</div>
			<!-- ..................Sess-Frame......................... -->
			<div id="sess-frame">
				<div class="btn-group row">
					<button class="btn btn-primary col-sm-6 " id="sessbtn1">Review
						Requests</button>
					<button class="btn btn-primary col-sm-6 " id="sessbtn2">Upload
						sheet</button>
				</div>
				<div id="sess-contents">
					<div class="table-responsive">
					<table id="Reviewtable" class="table">

						<thead>
							<th>Name</th>
							<th>Enroll</th>
							<th>Branch</th>
							<th>Semester</th>
							<th>Subject</th>
							<th>Msg</th>
							<th>Delete Option</th>
						</thead>
						<tbody>
						<%  con2=DriverManager.getConnection(url_db2,id_db,pass_db);
							st2=con2.createStatement(); 
							sql2="select * from `com` where faculty='"+name+"'"; 
							rs2=st2.executeQuery(sql2); 
							int count=1; 
							while(rs2.next()) { %>
							<script> 
						e[<%=count%>] = "<%=rs2.getString("Enroll")%>";
						m[<%=count%>] = "<%=rs2.getString("Msg")%>";
								
							</script>


							<tr>
								<td><%=rs2.getString("Name") %></td>
								<td><%=rs2.getString("Enroll") %></td>
								<td><%=rs2.getString("Branch") %></td>
								<td><%=rs2.getString("Semester") %></td>
								<td><%=rs2.getString("Subject") %></td>
								<td><%=rs2.getString("Msg") %></td>
								<td><button class="delselected">Delete</button></td>
							</tr>
							<%
count++;
}
%>
							
											
						</tbody>
					</table>
					</div>
					<div id="uploadSheet">

						<div class="row">
							<div class="col-sm-12">
								<div class="card card-container" id="signup_frame">

									<form class="form-signin" action="uploader.jsp" method="post"
										enctype="multipart/form-data">


										<div class="form-group">
											<label for="sub">Subject:</label> <input type="text"
												class="form-control" name="subject" id="sub"
												placeholder="Enter Subject" required>
										</div>
										<div class="row">
											<div class="col-sm-3">
												<div class="form-group">
													<label for="branch">Branch:</label> <select
														class=".selectpicker" id="branch" name="branch" required>
														<option value="CSE">CSE</option>
														<option value="IT">IT</option>
														<option value="EC">EC</option>
														<option value="EX">EX</option>
														<option value="ME">ME</option>
														<option value="CE">CE</option>

													</select>
												</div>
											</div>
											<div class="col-sm-3">
												<div class="form-group">
													<label for="semester">Semester:</label> <select
														class=".selectpicker" id="semester" name="semester"
														required>
														<option value="1">I</option>
														<option value="2">II</option>
														<option value="3">III</option>
														<option value="4">IV</option>
														<option value="5">V</option>
														<option value="6">VI</option>
														<option value="7">VII</option>
														<option value="8">VIII</option>

													</select>

												</div>
											</div>
											<div class="col-sm-6">
												<div class="form-group">
													<label for="section">Section:</label> <input type="text"
														class="form-control" title="Provide Section"
														name="section" maxlength="1" id="section"
														placeholder="Enter Section" required>
												</div>
											</div>
										</div>


										<input type="hidden" name="fac_name" value="<%=name%>"/>

							<div class="form-group">

								<label for="file-3">Upload DataSheet in csv format:</label>
								<button type="button" id="samplesheet"
									class="btn btn-default btn-block">Download
									SampleSheet.csv</button>
								<input style="z-index: 1;" type="file" name="file" size="50"
									id="file-3" class="btn btn-success form-control"
									data-multiple-caption="{count} files selected" accept=".csv"
									required />
							</div>

							<div class="row">

								<div class="col-sm-2">
									<button class="btn btn-loginback" id="back_login" disabled>
										<span class="glyphicon glyphicon-arrow-left"></span>
									</button>
								</div>
								<div class="col-sm-10">
									<button class="btn btn-success btn-block" id="signup_submit"
										type="submit">
										Deploy <span class="glyphicon glyphicon-share-alt"></span>
									</button>
								</div>
							</div>




							</form>

							</div>
							<!-- /card-container -->
							</div>
							</div>


							</div>
				</div>

			</div>









			<!-- ..................Sess-Frame-End......................... -->
		</div>




	</div>

	<%
	  //............................End Body................................
connection.close();
}catch(Exception e)
{System.out.println(e);%><script type="text/javascript">
	swal("Connection Error!!", "You're being directed to login page..", "error");
	setTimeout(function() {
		window.location = "index.html";
	}, 2000);
</script>
	<%} 
}catch(Exception fec){
	//System.out.println(fec);
	%>
	<script type="text/javascript">
		swal("Access Denied!!", "You're being directed to login page..",
				"error");
		setTimeout(function() {
			window.location = "index.html";
		}, 1000);
	</script>
	<%}%>
</body>

</html>