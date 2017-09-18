<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>mG_TestPortal_ADMIN_TOOLS</title>
	<script src="js/jquery.min.js"></script>
	
	<!-- Bootstrap +Bootstrap-Select -->
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<script src="js/bootstrap.min.js"></script>
	<link href="css/bootstrap-select.css" rel="stylesheet">
	<script src="js/bootstrap-select.js"></script>	
	<!-- SweetAlert + Page -->
	<script src="sweetalert-master/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="sweetalert-master/dist/sweetalert.css">
	<script src="js/sorttable.js"></script>
	
	<link rel="stylesheet" type="text/css" href="css/style_admin.css">	
  	<script src="js/admin.js"></script>
	
	  

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
		 if(session!=null){
   		  if(session.getAttribute("loginuser")!=null){
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
	  ServletContext context = pageContext.getServletContext();
  		String url_db = context.getInitParameter("address");
  		String id_db = context.getInitParameter("id");
  		String pass_db = context.getInitParameter("pass");
  	 Class.forName("com.mysql.jdbc.Driver"); 
      Connection connection = DriverManager.getConnection(url_db,id_db,pass_db);
    




      //Statement statement = connection.createStatement();
      //String st="select name from auth_table where enrollment=\""+enrollment+"\" and password=\""+pass+"\"";

     // ResultSet rs=statement.executeQuery(st); 
    
    
      %>
        <!-- ......................start body........................ -->
     
	<div class="container">
		<div class="row">

			<div class="btn-group  btn-group-justified">
				<a href="#" class="btn btn-primary" id="btnUsers" >Users Records</a>
				<a href="#" class="btn btn-primary" id="btnTestRecords" >Test Records</a>
				<a href="#" class="btn btn-primary" id="btnTestCreator" >Test Creator &amp; Deployer</a>
			</div>
		</div><br>	
		<div class="row">
			<div class="trpback">		
			</div>
			<div class="content" id="frame-1">
				<div class="row">
					<div class="col-sm-9">

						<table class="table table-inverse" style="font-family:georgia;font-weight:bold;">
							<thead>
								<tr>
									<th>Enrollment</th>
									<th>Branch</th>
									<th>Semester</th>
									<th>Name</th>
								</tr>
							</thead>
							<tbody>
								
									<!-- .................Part Of JSP..............-->
								<%
								ResultSet rs2;
								String query_count;
								Statement countstmt=connection.createStatement();
								int regStudents=0;
								int cseStudents=0;
								int itStudents=0;
								int ecStudents=0;
								int exStudents=0;
								int meStudents=0;
								int ceStudents=0;
								
								//registered students
								query_count="select count(*) as rowcount from auth_table";
								rs2=countstmt.executeQuery(query_count);if(rs2.next())
								{regStudents=rs2.getInt("rowcount");}
								//cs-students
								query_count="select count(*) as rowcount from auth_table WHERE branch=\"CSE\"";
								rs2=countstmt.executeQuery(query_count);if(rs2.next())
								{cseStudents=rs2.getInt("rowcount");}
								//it-students
								query_count="select count(*) as rowcount from auth_table WHERE branch=\"IT\"";
								rs2=countstmt.executeQuery(query_count);if(rs2.next())
								{itStudents=rs2.getInt("rowcount");}
								//ec-students
								query_count="select count(*) as rowcount from auth_table WHERE branch=\"EC\"";
								rs2=countstmt.executeQuery(query_count);if(rs2.next())
								{ecStudents=rs2.getInt("rowcount");}
								//ex-students
								query_count="select count(*) as rowcount from auth_table WHERE branch=\"EX\"";
								rs2=countstmt.executeQuery(query_count);if(rs2.next())
								{exStudents=rs2.getInt("rowcount");}
								//me-students
								query_count="select count(*) as rowcount from auth_table WHERE branch=\"ME\"";
								rs2=countstmt.executeQuery(query_count);rs2.next();
								 {meStudents=rs2.getInt("rowcount");}
								//ce-students
								query_count="select count(*) as rowcount from auth_table WHERE branch=\"CE\"";
								rs2=countstmt.executeQuery(query_count);rs2.next();
								{ceStudents=rs2.getInt("rowcount");}
								rs2.close();
								
								
								PreparedStatement st1=connection.prepareStatement("SELECT enrollment,branch,semester,name from auth_table");
								ResultSet rs1=st1.executeQuery();
								while(rs1.next())
								{
								%>
								<tr>
									<td><%=rs1.getString("enrollment") %> </td>
									<td><%=rs1.getString("branch") %> </td>
									<td><%=rs1.getInt("semester") %> </td>
									<td><%=rs1.getString("name") %> </td>
								</tr>
								
								<% 
								}rs1.close();
								%>
							</tbody>
						</table>

					</div>
					<div class="col-sm-3 overview">
						<table class="table table-striped " id="usertable">
							<thead>
							
								<tr>
									<th>Registered Students</th>
									<th><%=regStudents %></th>
								</tr>
								<tr>
									<th >CS</th>
									<th><%=cseStudents %></th>
								</tr>
								<tr>
									<th>IT</th>
									<th><%=itStudents %></th>
								</tr>
								<tr>
									<th>EC</th>
									<th><%=ecStudents %></th>
								</tr>
								<tr>
									<th>EX</th>
									<th><%=exStudents %></th>
								</tr>
								<tr>
									<th>ME</th>
									<th><%=meStudents %></th>
								</tr>
								<tr>
									<th>CE</th>
									<th><%=ceStudents %></th>
								</tr>

							</thead>

						</table>

					</div>
				</div>


			</div>

			<div class="content" id="frame-2">

				<table id="table-2" style="font-family:georgia;font-weight:bold;" class="table sortable">
				<thead>
					<tr>
						<th>Date</th>
						<th>Subject</th>
						<th>Semester</th>
						<th>Branch</th>
						<th>Registered Students</th>
						<th>Appeared Students</th>
						
						
					</tr>
				</thead>
				<tbody>
					<%
						Statement testRecords=connection.createStatement();
						String st3="select * from test_records_admin order by date desc";
						ResultSet rs3=testRecords.executeQuery(st3);
						while(rs3.next())
						{
							%>
								<tr>
									<td><%=rs3.getDate("date")%></td>
									<td><%=rs3.getString("subject")%></td>
									<td><%=rs3.getInt("semester")%></td>
									<td><%=rs3.getString("branch")%></td>
									<td><%=rs3.getInt("registeredStudents")%></td>
									<td><%=rs3.getInt("appearedStudents")%></td>
								</tr>
													
							<%
							
						}	rs3.close();				
					%>
					
				</tbody>
					
				</table>
			</div>
			<div class="content" id="frame-3">
			<div class="row">
			<div class="col-sm-6">
			
			<div id="current_test">
				<%String ctest_subject="null",ctest_branch="null";
				  int ctest_semester=0,ctest_estu=0,ctest_time=0;
				
				Statement st_ctest=connection.createStatement();
				ResultSet rs_ctest=st_ctest.executeQuery("select * from current_test");
				if(rs_ctest.next())
				{ctest_subject=rs_ctest.getString("subject");
				 ctest_branch=rs_ctest.getString("branch");
				 ctest_semester=rs_ctest.getInt("sem");
				 ctest_estu=rs_ctest.getInt("regstudents");
				 ctest_time=rs_ctest.getInt("time")/60;}
				st_ctest.close();
				rs_ctest.close();
					
					
					%>
				<h1>Current Deployed Test:</h1>
				<br>
				<table class="table" >
				<thead>
					<tr>
						<th>Subject</th>
						<th id="sub_show"><%=ctest_subject%></th>
					</tr>					
					<tr>
						<th>Branch</th>
						<th><%=ctest_branch%></th>	
					</tr>
					<tr>
						<th>Semester</th>
						<th><%=ctest_semester%></th>
					</tr>
					<tr>
						<th>Eligible Students</th>
						<th><%=ctest_estu%></th>
					</tr>
					<tr>
						<th>Time-period</th>
						<th><%=ctest_time%> minutes</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
				</table>
			<p>#Current test will be expired after 1 day.</p>
			<button type="button" class="btn btn-default" id="check_btn" value=1>Go to Test</button>
			<button type="button" class="btn btn-danger" id="undeploy_btn" value=1>Undeploy</button>
			</div>
			
			
			</div>
			<div class="col-sm-6">
				<div class="card card-container" id="signup_frame">

  			<form class="form-signin" action="test_creator.jsp" method="post" 	enctype="multipart/form-data">
  				

  				<div class="form-group">
  					<label for="sub">Subject:</label>
  					<input type="text" class="form-control" name="subject" id="sub" placeholder="Enter Subject" required>
  				</div>
  				<div class="row">
  					<div class="col-sm-3" >
  						<div class="form-group">
  							<label for="branch">Branch:</label>
  							<select class=".selectpicker" id="branch" name="branch" required>
  								<option value="CSE">CSE</option>
  								<option value="IT">IT</option>
  								<option value="EC">EC</option>
  								<option value="EX">EX</option>
  								<option value="ME">ME</option>
  								<option value="CE">CE</option>
  								
  							</select>
  						</div>
  					</div>
            <div class="col-sm-3" >
              <div class="form-group">
                <label for="semester">Semester:</label>
                <select class=".selectpicker" id="semester" name="semester" required>
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
  					<div class="col-sm-6" >
  						<div class="form-group">
  							<label for="time">Time(minutes):</label>
  							<input type="text" class="form-control" pattern="[0-9]{1,3}" title="Provide time in minutes"  name="time"  maxlength="3" id="time" placeholder="Enter time" required>
  						</div>
  					</div>
  				</div>
  				
  						

  			
				<div class="form-group">
  				
  				<label for="file-3">Upload DataSheet in csv format:</label>
  				<button type="button" id="samplesheet" class="btn btn-default btn-block">Download SampleSheet.csv</button>
				<input style="z-index:1; "type="file" name="file" size="50" id="file-3" class="btn btn-success form-control"  data-multiple-caption="{count} files selected"  accept=".csv" required/>
				</div>
				
  				<div class="row">

  					<div class="col-sm-2">
  					<button class="btn btn-loginback" id="back_login" disabled><span class="glyphicon glyphicon-arrow-left"></span></button>
  					</div>
  					<div class="col-sm-10">
  					<button class="btn btn-success btn-block" id="signup_submit" type="submit"> Deploy  <span class="glyphicon glyphicon-share-alt"></span></button>
  					</div>
  				</div>	




  				</form>

  			</div><!-- /card-container -->
			</div>
			
			</div>
				
				

			</div>
		</div>
	</div>



     <!-- ......................end body........................ -->
     <%
 

connection.close();

}catch(Exception e)
{System.out.println(e);/*e.printStackTrace();*/%><script type="text/javascript">
swal("Connection Error!!", "You're being directed to login page..", "error");
setTimeout(function(){ window.location="index.html"; }, 1000);
</script><%
}
%> 


		

</body>
</html>
