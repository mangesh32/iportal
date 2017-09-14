    <%@ page import="java.io.*" %>
    <%@ page import="java.text.*" %>
    <%@ page import="java.util.*" %>
        <%@ page import="java.util.Date" %>
    <%@ page import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager;"%>

            <html>

            <head>
				 <script src="sweetalert-master/dist/sweetalert.min.js"></script>
				 <link rel="stylesheet" type="text/css" href="sweetalert-master/dist/sweetalert.css">
                <%
                try{
                    String token=request.getParameter("token");
                    String dir=application.getRealPath("/")+"ranks.txt";
                    String time=request.getParameter("timetaken");
                    String rank=request.getParameter("rank");
                    
                    if(token==null||time==null||rank==null)
                    throw new Exception("Invalid access");
                    
                    String name=new String(Base64.getDecoder().decode(token),"utf-8");
                    name=name.substring(0,name.length()-5);
                    System.out.println(name+" : ranks");
                %>   
      
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
            
            
            
//import enrollment,semester,date
            Statement statement = connection.createStatement();
            String checkUser="select enrollment,semester from auth_table where testFlag=1 and name=\""+name+"\"";
            ResultSet checkrs=statement.executeQuery(checkUser);
            if(!checkrs.next())
            {	%><script>swal("Not Allowed!!","Login Again","error");</script><%
            	throw new Exception("invalid token");
            }
            String enrollment=checkrs.getString("enrollment");
            int semester=checkrs.getInt("semester");
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            String tarik=dateFormat.format(date);
            statement.close();
            checkrs.close();
           
//import subject,total qu,correct ans
			Statement st2=connection.createStatement();
			String str2="select subject,total_qu from current_test";
			ResultSet stc=st2.executeQuery(str2);
			if(!stc.next())throw new Exception("invalid stc");
			String subject=stc.getString("subject");
			int total_qu=stc.getInt("total_qu");
			int correct_ans=Integer.parseInt(rank);
			st2.close();
			stc.close();
			
//check for duplicate
			Statement st3=connection.createStatement();
			String str3="select semester from test_records where subject=\""+subject+"\" and enrollment=\""+enrollment+"\" and date=\""+tarik+"\"";
			ResultSet rsdup=st3.executeQuery(str3);
			if(rsdup.next())
			{	System.out.println(name+" : Tried Dupe");
			Statement stflagdupe=connection.createStatement();
			String strflagdupe="UPDATE `auth_table` SET `testFlag`=false WHERE enrollment=\""+enrollment+"\"";
			stflagdupe.executeUpdate(strflagdupe);
			stflagdupe.close();
				 %><script type="text/javascript">   
				
		       	 setTimeout(function(){ window.location="index.html"; }, 2000);
		          </script><%
			}else{
//export to test_records
			PreparedStatement ps1=connection.prepareStatement("insert into test_records values(?,?,?,?,?,?)");
			ps1.setString(1,enrollment);
			ps1.setString(2,tarik);
			ps1.setInt(3,semester);
			ps1.setString(4,subject);
			ps1.setInt(5,total_qu);
			ps1.setInt(6,correct_ans);
			ps1.executeUpdate();	
			ps1.close();
			System.out.println(name+" : score uploaded");
//set testFlag 0
			Statement st4=connection.createStatement();
			String str4="UPDATE `auth_table` SET `testFlag`=false WHERE enrollment=\""+enrollment+"\"";
			st4.executeUpdate(str4);
			st4.close();
//update test_records_admin
			Statement st5=connection.createStatement();
			String str5="UPDATE `test_records_admin` SET appearedStudents=appearedStudents+1 WHERE date=\""+tarik+"\" and subject=\""+subject+"\"  and semester="+semester;
			st5.executeUpdate(str5);
			st5.close();
			}
			st3.close();
			rsdup.close();
            System.out.println("..............................");
             %> 
               <script type="text/javascript">
               setTimeout(function(){ window.location="success.html"; }, 1000);
             </script>
             
             
             <%
         }catch(Exception e)
         {System.out.println(e);
         %><script type="text/javascript">         
       	 setTimeout(function(){ window.location="index.html"; }, 1000);
             </script><%
         }
             %>          
            </body>
            <%}catch(Exception asa){
            	System.out.println(asa);
            %>
           	 <script>           	 
           	 setTimeout(function(){ window.location="index.html"; }, 1000);
           	 </script><%
            } %>

            </html>