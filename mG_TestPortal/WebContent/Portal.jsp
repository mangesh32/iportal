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
  <title>User Portal</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/portalstyle.css">
  <script src="sweetalert-master/dist/sweetalert.min.js"></script>
      <script src="js/jquery.min.js"></script>
      <link rel="stylesheet" type="text/css" href="sweetalert-master/dist/sweetalert.css">

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
      
<script>

var data=[];
var outof=[];
var temp=[];
var temp1=[];
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



function load_data(subval){
	$("#table-body").html("");
	//alert(subval);
		for(var p=0;p<c.length;p++){
	  	    $("#table-body").append("<tr class=\"active\" style=\"text-align:center;font-family:georgia;font-weight:bold;\"><td>"+c[p]+"</td><td>"+outof[subval][p]+"</td><td>"+data[subval][p]+"</td></tr>");
			}
	}

</script>
    </head>
    <body>
      <% 
      try{
    	  String enrollment="";
    	  String pass="";
    	  if(session!=null){
    		  if(session.getAttribute("loginuser")!=null){
    			  enrollment=session.getAttribute("enroll").toString();
    			  pass=session.getAttribute("pwd").toString();
    			  System.out.println(".............................");
    			  System.out.println(session.getAttribute("loginuser")+" : Logged IN.");
    			  
    		  }else{
    			  throw new Exception("Invalid User Login");
    		  }
    		 
    	  }else{
    		  throw new Exception("Invalid User Login");
    	  }
          //String enrollment=request.getParameter("userid").toLowerCase();
         // String pass=request.getParameter("key");
          // its working!!!
     //................................Variables...................................
          String name;
          String brnch;
          String sql3;
          String sql4;
          int sem;
          boolean testFlag;
          Connection connection;
          Statement st_exp;
          Statement statement;
          Statement st_ctest;
          Statement st2;
          Statement st3;
          Statement st4;
          ResultSet rs4;
          ResultSet rs3;
          ResultSet rs_exp;
          ResultSet rs;
          ResultSet rs2;
          ResultSet rs_ctest;
     //.............................................................................     

      try{
    	  ServletContext context = pageContext.getServletContext();
  		String url_db = context.getInitParameter("address");
  		String url_db2 = context.getInitParameter("address2");
  		String id_db = context.getInitParameter("id");
  		String pass_db = context.getInitParameter("pass");
  	 Class.forName("com.mysql.jdbc.Driver"); 
      connection = DriverManager.getConnection(url_db,id_db,pass_db);

      //check date for 1 day expiration of test
 		st_exp=connection.createStatement();
		rs_exp=st_exp.executeQuery("SELECT date from current_test");   
 		if(rs_exp.next())
 		{ DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
      Date date = new Date();
      String tarik=dateFormat.format(date);
 			if(!tarik.equals(rs_exp.getDate("date").toString()))
 			{
 				Statement st_clearflags=connection.createStatement();
 				st_clearflags.executeUpdate("UPDATE `auth_table` SET `testFlag`=false");
 				st_clearflags.executeUpdate("TRUNCATE TABLE `current_test`");
 				st_clearflags.executeUpdate("TRUNCATE TABLE `sheet1`");
 				st_clearflags.close();
 				System.out.println("Test Expired...records reset");
 			}
 		}st_exp.close();
 		rs_exp.close();
 	
 	//......................................
		

      statement = connection.createStatement();
      String st="select name,testFlag,semester,branch from auth_table where enrollment=\""+enrollment+"\" and password=\""+pass+"\"";

      rs=statement.executeQuery(st); 
      if(rs.next()){
    	 
    	  
    	  //.........................
      name=rs.getString("name");
      brnch=rs.getString("branch");
      sem=rs.getInt("semester");
      
      //System.out.println(name+" : portal");
      testFlag=rs.getBoolean("testFlag");
      if(testFlag==true)	
      {
    	  //.................................CODE-FRAME START......................................
    	  String token=Base64.getEncoder().encodeToString((name+"coded").getBytes("utf-8")); 
    	  
    	  %>
    	  	<script>
    	  		swal("Hey!!","You are enrolled for a test today..","success");
              	  			
    	  	</script>
    	  	<body>
    	  	<div class="container">
    	  		
    	  		<div class="code_frame" >
    	  		 
                <div class="row" >
                 
                   <h1 style="text-align:center">Test Details</h1>
             	<%
             	
             	
             	
             	st_ctest=connection.createStatement();
				rs_ctest=st_ctest.executeQuery("select * from current_test");
				rs_ctest.next();
				String ctest_subject=rs_ctest.getString("subject");
				String ctest_branch=rs_ctest.getString("branch");
				int ctest_semester=rs_ctest.getInt("sem");
			
				int ctest_time=rs_ctest.getInt("time")/60;
				rs_ctest=st_ctest.executeQuery("select count(*) as rowcount from sheet1");
				rs_ctest.next();int ctest_tqus=rs_ctest.getInt("rowcount");
				st_ctest.close();
				rs_ctest.close();
					
					
					%>
				<br>
				<table class="table table-responsive">
				<thead>
					<tr>
						<th>Subject</th>
						<th><%=ctest_subject%></th>
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
						<th>Time-period</th>
						<th><%=ctest_time%> minutes</th>
					</tr>
					<tr>
						<th>Total Questions</th>
						<th><%=ctest_tqus%></th>
					</tr>
				</thead>
				<tbody>
				</tbody>
				</table>
                </div>
                 
               
    	  		   
    	  		</div>
    	  		<div class="row" >
    	  		<div class="col-sm-12">
            <form action="main.jsp" method="post" >
                  <input type="hidden" value="<%=token%>" name="token" />
                 <button type="submit" id="start_test" class="btn btn-success pos-center" >Start</button>   
            </form>
                 </div>              
                </div>
    	  </div>
    	  <%
    	  //..............................CODE-FRAME-END.................................
       }
      else{
      %>

      <!-- ......................start body........................ -->
     
      <div class="container">
        <div class="row header-row">
        	
              <div class="col-sm-11 col-xs-10">
                      <div class="btn-group btn-group-justified ">
                          <a href="#" class="btn btn-success" id="btn-home">Home</a>
                          <a href="#" class="btn btn-success" id="btn-history">History</a>
                         <!--  <a href="#" class="btn btn-success" id="btn-feed">Feed</a>  -->
                      </div>
              </div>
              <div class="col-sm-1 col-xs-2 ">
                      <button class="btn btn-next " id="lgout" ><span class="glyphicon glyphicon-log-out"></span></button>
              </div>
        </div>
        
		<!-- .................................HOME-START........................................ -->
		
        <div class="frames frame-1" id="frame-1">
        <div id="blur-bg">
        </div>
		
          <div class="row">
                  <div class="col-sm-3 ">
                        <img id="profile-img" class="profile-img-card" src="img/users/default.png" />
                         <p id="profile-name" class="profile-name-card"><%=name%></p><br>
                         <p style="font-size:14px;font-weight:bold;text-align:center;"><%=enrollment.toUpperCase()%></p>
                         <p style="font-size:14px;font-weight:bold;text-align:center;"><%=sem%>th Sem</p>
						 <p style="font-size:14px;font-weight:bold;text-align:center;"><%=brnch%></p>

                   </div>

                  <div class="col-sm-9" >
                  <!-- .................................Links....................... -->
                          <div id="records">
                          	<div class="row">
                          	<div class="col-sm-4">
                          		<p id="changepass" class="icons"><img src="img/changepass.png" class="icon-links"></img> Change Password</p>
                          	</div>
                          	<div class="col-sm-4">
                          		<p id="anssheet" class="icons"><img src="img/anssheet.png" class="icon-links"></img> Answer Sheets</p> 
                          	</div>
                          	<div class="col-sm-4">
                          		<p id="sessmarks" class="icons"><img src="img/anssheet.png" class="icon-links"></img> Sessionals</p>
                          	</div>
                          		  
                            	      
                          	</div>
                          	<br><br>
                      
                          </div>
                          
                  <!-- ........................Frames............................... -->
                          
                          <div id="ChangePassFrame">
                          		
                          		<h4 style="color:white;font-weight:bold;text-align:center;font-family:Georgia;"> <img src="img/changepass.png" class="icon-links"></img>Change Password</h4><br>
                          		<form class="form-signin" action="ChangePass.jsp" method="post">
                          			<input type="hidden" name="userid" value=<%=enrollment %>>
  									<div class="row">
  											<input type="password" name="currentpass" class="form-control pass-field" placeholder="Current Password" title="Your Current Password" required autofocus>
  					 		        </div>
  					 		        <div class="row">
  											<input type="password" name="newpass" class="form-control pass-field" placeholder="New Password" title="Your New Password" required autofocus>
  					 		        </div>
  									<div class="row">
  									<br>
  									<div class=row>
  									<div class="col-sm-5"><button class="btn btn-backhome pull-right " type="button"><span class="glyphicon glyphicon-arrow-left"></button></div>
  									<div class="col-sm-7"><button class="btn btn-next-frgt" id="submit_chpass" type="submit">Submit<span class="glyphicon glyphicon-arrow-right"></span></button></div>
  									
  									
  									</div></div>
  								</form><!-- /form -->
                          		
                          		
                          
                          </div>
                          
                          
                          
                          
                          
                 </div>
           </div>
       </div>
       
       <!-- .................................HOME-END........................................ -->
       
       <!-- .................................HISTORY-START........................................ -->
       <div class="frames frame-2" id="frame-2">
       		
       		<div class="row">
       			<div class="col-sm-6">
       			<div class="rcd">Total Test</div>
       			</div>
       			<div class="col-sm-6">
       			<div class="rcd">Attemped Test</div>
       			</div>
       			
       		</div>
       		<div class="row">
       			<div class="col-sm-6">
       			<div class="rcd-val" id="ttest">##</div>
       			</div>
       			<div class="col-sm-6">
       			<div class="rcd-val" id="attempted">##</div>
       			</div>
       			
       		</div>
       		<br>
       		<div class=row >
       		<div id="table">
       		   <table class="table table-responsive" id="frame-2-table">
    <thead>
      <tr>
        <th>Date</th>
        <th>Semester</th>
        <th>Subject</th>
        <th>Questions</th>
        <th>Correct Answers</th>
      </tr>
    </thead>
    <tbody>
    
       <%
       st2=connection.createStatement();
       String rcd_query="Select * from test_records where enrollment=\""+enrollment+"\" order by date desc";
       rs2=st2.executeQuery(rcd_query);
       int count=0;
       while(rs2.next())
       {count++;
    	   String date=rs2.getString("date");
    	   int semester=rs2.getInt("semester");
    	   String subject=rs2.getString("subject");
    	   int total_qu=rs2.getInt("total_qu");
    	   int correct_ans=rs2.getInt("correct_ans");
    	   %>
    	    
    	   <tr class="active" style="text-align:center;font-family:georgia;font-weight:bold;">
        	 <td class="field-1"><%=date %></td>
       		 <td class="field-2"><%=semester %></td>
       		 <td class="field-3"><%=subject%></td>
      		 <td class="field-4" style="color:red"><%=total_qu%></td>
      		 <td class="field-5" style="color:green"><%=correct_ans%></td>
           </tr>
    	   
    	   <% 
    	   
    	   
       }
       String ttest="select count(*) as rowcount from test_records_admin where semester="+sem+" and branch=\""+brnch+"\"";
    	rs2=st2.executeQuery(ttest);
    	rs2.next();
    	int totaltest=rs2.getInt("rowcount");
    	st2.close();
    	rs2.close();
  
    	Connection con2=DriverManager.getConnection(url_db2,id_db,pass_db);
    	Statement st_Sess=con2.createStatement();
    	ResultSet rs_Sess=st_Sess.executeQuery("SELECT `table-name`,`subject`,`faculty` FROM `table-details` WHERE branch=\""+brnch+"\" and semester=\""+sem+"\"");
    	%>
    	<script>
    		var sub=[];
    		var fac=[];
    		var tableName=[];
    		
    	</script>
    	<% 
    	int count2=0;
    	while(rs_Sess.next()){
    		%>
    		<script> 
    			sub[<%=count2%>] = "<%=rs_Sess.getString("subject")%>";
    			fac[<%=count2%>] = "<%=rs_Sess.getString("faculty")%>";
    			tableName[<%=count2%>] = "<%=rs_Sess.getString("table-name")%>";
    		</script>
    
    		<%
    		sql4="select * from `"+rs_Sess.getString("table-name")+"` where ClassRoll='0'";
    		sql3="select * from `"+rs_Sess.getString("table-name")+"` where Enroll=\""+enrollment+"\"";
    		st4=con2.createStatement();
    		st3=con2.createStatement();
    		rs4=st4.executeQuery(sql4);
    		rs3=st3.executeQuery(sql3);
			while(rs4.next()){
    			
    			for(int j=1;j<=20;j++){
    			%>
    			<script>
    				temp1.push("<%=rs4.getString(3+j)%>");
    			</script>
    			<%	
    		}
    			%>
        		<script>
        			outof.push(temp1);
        			temp1=[];
        		</script>
        		
        		<%
			}
    		while(rs3.next()){
    			
    			for(int j=1;j<=20;j++){
    			%>
    			<script>
    				temp.push("<%=rs3.getString(3+j)%>");
    			</script>
    			<%	
    		}
    		%>
    		<script>
    			data.push(temp);
    			temp=[];
    		</script>
    		
    		<%
    		
    		
    		}
    		
    		count2++;
    	}
    	con2.close();
       %>
      
    </tbody>
  </table>
  
 
  </div>
       		</div>
       		 
       </div>  
	<!-- .................................HISTORY-END........................................ -->
  
  <!-- .................................Sessionals Frame........................................ -->
    <div class="frames frame-sess" id="sess-frame">



            <div  class="frames frame-sub" id="sub-frame">
            <div class="panel panel-info">
            <div class="panel-heading">Select Subject for Detailed View.</div>
  				<table class="table">
  					<thead>
  					<th>Subject</th>
  					<th>Out of</th>
  					<th>Obtained</th>
  					</thead>
  					<tbody id="sub-frame-tbody">
  					</tbody>
  				</table>
			</div>
            </div>

            <div  class="frame-marks" id="marks-frame">
                
                
      <div  id="sess-table">  
      <table class="table" >
 			    <thead>
 			    
 				<th><button class="btn btn-loginback pull-left" id="back"><span class="glyphicon glyphicon-arrow-left"></span></button>
 				CRITERIA
 				</th>
 				<th>OUT OF</th>
 				<th>OBTAINED MARKS</th>
 				</thead>
			<tbody id="table-body">
			</tbody>
		
      </table>
      <script>
     
      </script>
      
      </div>
       </div>
    </div>
 
    

    

 <!-- .................................END Sessionals Frame........................................ -->
   

    </div>




     <!-- ......................end body........................ -->
     <%
   }}
   else{

   %>
   <script type="text/javascript">
    swal("Wrong Credentials!!", "You're being directed to login page..", "error");
    setTimeout(function(){ window.location="index.html"; }, 2000);
  </script>
  <%

}

connection.close();

}catch(Exception e)
{System.out.println(e);%><script type="text/javascript">
swal("Connection Error!!", "You're being directed to login page..", "error");
setTimeout(function(){ window.location="index.html"; }, 2000);
</script><%
}
%>    
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script> 
<script src="js/portjs.js"></script>
<%}catch(Exception fec){
	//System.out.println(fec);
	%>
	<script type="text/javascript">
	swal("403 Forbidden!!", "You're being directed to login page..", "error");
	setTimeout(function(){ window.location="index.html"; }, 1000);
	//window.location="index.html";
	</script><%
}


%>
</body>

</html>