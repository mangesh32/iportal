<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>Creator</title>
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

	    //entry in sheet1
			/* needed:-
			whole sheet */
		//current test entry
			/* needed:-
					subject
					regstudents
					time(in seconds)
					branch
					sem
					total_qu */					
					
					
					
		//entry in test_records_admin	
			/* needed:-
					date
					subject
					semester
					branch
					registeredStudents
					appearedStudents (set to 0)*/
		//enable testFlags
		
		
		
		
		/*overall we need from admin
					subject
					branch
					semester
					time
					sheet */
	//taking all required parameters------->
	Boolean allgood=true;
	Statement st1;
	ResultSet rs1;
	String query_count;
	String subject="",branch="";
	int time=0,semester=0;
		/*String subject=request.getParameter("subject");//subject
		String branch=request.getParameter("branch");//branch
		String semesterstring=request.getParameter("semester");//semester
		System.out.println(subject+branch+semesterstring);
		int semester=Integer.parseInt(semesterstring);//semester-int
		String timestring=request.getParameter("time");//time
		int time=Integer.parseInt(timestring);//time in second
		time=time*60;*/
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
         String tarik=dateFormat.format(date);//date
         
         
         
	//...........upload sheet 1...........
	
	File file ;
	int maxFileSize = 25000 * 1024;
	int maxMemSize = 25000 * 1024;
	
	String filePath = context.getInitParameter("file-upload");

   // Verify the content type
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

   DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("c:\\temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      try{ 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();
         
         
         while ( i.hasNext () ) 
         {
         FileItem fi = (FileItem)i.next();
         if ( !fi.isFormField () )	
         {
            // Get the uploaded file parameters
            String fieldName = fi.getFieldName();
            String fileName = fi.getName();
            boolean isInMemory = fi.isInMemory();
            long sizeInBytes = fi.getSize();
            // Write the file
            if( fileName.lastIndexOf("\\") >= 0 ){
            file = new File( filePath + fileName.substring( fileName.lastIndexOf("\\"))) ;
        }else{
        file = new File( filePath + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
    }
    fi.write( file ) ;
    
    
    
            //out.println("Uploaded Filename: " + filePath + fileName + "<br>");
            
            String cmd="";
            System.out.println("------------------------------------------------");
           // System.out.println("Path: "+filePath);
           // System.out.println("File: "+fileName);
            System.out.println(">>>>> "+fileName+" Uploaded !!!");
        	//------------------file compilation----------------------
        	String ext=fileName.substring(fileName.lastIndexOf(".")+1);
        	
        	if(ext.equals("csv"))
        	{
        	Statement csheetst=connection.createStatement();
        	csheetst.executeUpdate("TRUNCATE TABLE `sheet1`");
        	
        	// csv modification acc to sql import...
        	
        			try {
			FileReader fin=new FileReader(filePath+fileName);
			System.out.println("file-open-read");
			FileWriter fout=new FileWriter(filePath+"sheet1.csv");
			System.out.println("file-open-write");
			BufferedReader bufferedReader = new BufferedReader(fin);
			String line;
			while((line=bufferedReader.readLine() )!= null)
			{
				fout.write("@:");
				fout.write(line);
				fout.write(":@");
				fout.write("\n");
			}
				
			
			System.out.println("file-written");
			
				fin.close();
				fout.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	
        	
        	
        	
        	//......................................	
        	Statement st_up=connection.createStatement();
        	String up_query="load data local infile '"+filePath+"sheet1.csv"+"' into table code.sheet1 columns terminated by ',' enclosed by '\"'  lines starting by '@:' terminated by ':@' ignore 1 lines";
        	
        	st_up.executeUpdate(up_query);   
        	System.out.println("DataSheet uploaded !!");
        	
        }
        else{allgood=false;throw new Exception("wrong file format!! ");}
        
    }else{
    
 
    if((fi.getFieldName()).equals("subject")){subject=fi.getString().toUpperCase();}
    if((fi.getFieldName()).equals("branch")){branch=fi.getString().toUpperCase();}
    if((fi.getFieldName()).equals("semester")){semester=Integer.parseInt(fi.getString());}
    if((fi.getFieldName()).equals("time")){time=Integer.parseInt(fi.getString())*60;}
    
}             
}	//while
st1=connection.createStatement();
query_count="select count(*) as rowcount from auth_table where branch=\""+branch+"\" and semester="+semester;
rs1=st1.executeQuery(query_count);rs1.next();
int regStudents=rs1.getInt("rowcount");//regStudents

query_count="select count(*) as rowcount from sheet1";
rs1=st1.executeQuery(query_count);
rs1.next();
     	int total_qu=rs1.getInt("rowcount");//total_qu
     	st1.close();
     	rs1.close();
     	
     	//Current test Entry:----->>>
     	Statement st_clear=connection.createStatement();
     	st_clear.executeUpdate("TRUNCATE TABLE `current_test`");
     	st_clear.close();
     	PreparedStatement ps1=connection.prepareStatement("insert into current_test values(?,?,?,?,?,?,?)");
     	ps1.setString(1,tarik);
     	ps1.setString(2,subject);
     	ps1.setInt(3,regStudents);
     	ps1.setInt(4,time);
     	ps1.setString(5,branch);
     	ps1.setInt(6,semester);
     	ps1.setInt(7,total_qu);
     	ps1.executeUpdate();	
     	ps1.close();
     	System.out.println("current_test entry done!!");
     	
     	//test_records_admin entry:---->>>
     	PreparedStatement ps2=connection.prepareStatement("insert into test_records_admin values(?,?,?,?,?,?)");
     	ps2.setString(1,tarik);
     	ps2.setString(2,subject);
     	ps2.setInt(3,semester);
     	ps2.setString(4,branch);
     	ps2.setInt(5,regStudents);	
     	ps2.setInt(6,0);
     	ps2.executeUpdate();	
     	ps2.close();
     	System.out.println("test_records_admin entry done!!");
     	//set testFlags
     	//set testFlag 0
			Statement st4=connection.createStatement();
			String str4="UPDATE `auth_table` SET `testFlag`=false ";
			st4.executeUpdate(str4);
			st4.close();
     	Statement flagst=connection.createStatement();
     	String flag_query="UPDATE `auth_table` SET `testFlag`=true WHERE branch=\""+branch+"\" and semester="+semester;
     	flagst.executeUpdate(flag_query);
     	flagst.close();
     	connection.close();
     	
     	
     	
     }catch(Exception ex){System.out.println(ex);}
 }else{System.out.println("parameter error");}
 
	//..................................
	
	
	
	
	if(allgood){

     	System.out.println("\nDetails:--\n  Subject: "+subject+"\n   Branch: "+branch+"\n   Semester: "+semester+"\n   Time: "+time);
		System.out.println("Test Deployed!!");
		System.out.println("-------------------------------------");
		
		
		
	%>
	<script>
		swal("Success","Test Deployed !!","success");
		setTimeout(function(){ window.location="admin.jsp?pass=cold_2000"; }, 2000);
	
		
		
	</script>
	<%}
}
catch(Exception e)
{	e.printStackTrace();
	System.out.println("Creator "+e);
	%>
	<script>
		swal("Oops","Test Deployer Failed!!","error");
		setTimeout(function(){ window.location="index.html"; }, 2000);
	</script>
	<%
}
%>
</body>
</html>