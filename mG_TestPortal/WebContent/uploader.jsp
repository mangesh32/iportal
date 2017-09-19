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
		response.setHeader("Cache-Control","no-cache");
		  response.setHeader("Cache-Control","no-store");
		  response.setHeader("Pragma","no-cache");
		  response.setDateHeader ("Expires", 0);
		  ServletContext context = pageContext.getServletContext();
	  		
	  	 Class.forName("com.mysql.jdbc.Driver"); 
	      Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/sessional", "root", "");

	//taking all required parameters------->
	Boolean allgood=true;
	String fac_name="";
	Statement st1;
	ResultSet rs1;
	String query_count;
	String subject="",branch="",section="";
	int semester=0;
	String fieldName="",fileName="";
	
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
         String tarik=dateFormat.format(date);//date
         
         
         
	//...........upload sheet 1...........
	
	File file ;
	int maxFileSize = 25000 * 1024;
	int maxMemSize = 25000 * 1024;
	
	String filePath = context.getInitParameter("file-upload");
	//System.out.println("file path is ::"+filePath);
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
            fieldName = fi.getFieldName();
            fileName = fi.getName();
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
        	//csheetst.executeUpdate("TRUNCATE TABLE `sheet1`");
        	
        	// csv modification acc to sql import...
        	
        			try {
			FileReader fin=new FileReader(filePath+fileName);
			System.out.println("file-open-read");
			FileWriter fout=new FileWriter(filePath+"sheet2.csv");
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
	
		
        	
        	/*
        	
        	//......................................	
        	Statement st_up=connection.createStatement();
        	String up_query="load data local infile '"+filePath+"sheet1.csv"+"' into table code.sheet1 columns terminated by ',' enclosed by '\"'  lines starting by '@:' terminated by ':@' ignore 1 lines";
        	
        	st_up.executeUpdate(up_query);   
        	System.out.println("DataSheet uploaded !!");
        	
        	
        	*/
        	
        }
        else{allgood=false;throw new Exception("wrong file format!! ");}
        
    }else{
    
 
    if((fi.getFieldName()).equals("subject")){subject=fi.getString().toUpperCase();}
    if((fi.getFieldName()).equals("branch")){branch=fi.getString().toUpperCase();}
    if((fi.getFieldName()).equals("semester")){semester=Integer.parseInt(fi.getString());}
    if((fi.getFieldName()).equals("section")){section=fi.getString();}
    if((fi.getFieldName()).equals("fac_name")){fac_name=fi.getString();}
    
}             
}	//while
	
	
	
// Create table in database...........
st1=connection.createStatement();
String table_name=subject+"_"+branch+"_"+semester+"_"+section;
String query_createtable="CREATE TABLE `sessional`.`"+table_name+"` ( `ClassRoll` INT(11) NOT NULL , `Enroll` VARCHAR(45) NOT NULL , `NameofStudent` VARCHAR(50) NOT NULL , `ClassAttendedTh` VARCHAR(11) NOT NULL , `ClassAttendedPr` VARCHAR(11) NOT NULL , `Total` VARCHAR(11) NOT NULL , `Att. %` VARCHAR(11) NOT NULL , `Att.marks10` VARCHAR(11) NOT NULL , `Att.marks5` VARCHAR(11) NOT NULL , `Mid1out20` VARCHAR(11) NOT NULL , `Mid1out5` VARCHAR(11) NOT NULL , `Mid2 out of 20` VARCHAR(11) NOT NULL , `Mid2 out of 5` VARCHAR(11) NOT NULL , `Teachers marks out of 5` VARCHAR(11) NOT NULL , `Tutorial out of 5` VARCHAR(11) NOT NULL , `Minor1` VARCHAR(11) NOT NULL , `Minor2` VARCHAR(11) NOT NULL , `Quiz` VARCHAR(11) NOT NULL , `Assignment` VARCHAR(11) NOT NULL , `Problem Solving` VARCHAR(11) NOT NULL , `Lab Performance` VARCHAR(11) NOT NULL , `Lab Marks` VARCHAR(11) NOT NULL , `Viva` VARCHAR(11) NOT NULL , PRIMARY KEY (`Enroll`)) ENGINE = InnoDB";
st1.executeUpdate(query_createtable);
// table created!!!............

//upload CSV...........


			Statement st_up=connection.createStatement();
        	String up_query="load data local infile '"+filePath+"sheet2.csv"+"' into table sessional."+table_name+" columns terminated by ',' enclosed by '\"'  lines starting by '@:' terminated by ':@' ignore 1 lines";
        	
        	st_up.executeUpdate(up_query);   
        	System.out.println("DataSheet uploaded !!");

//........................................

//make entry in table_details
		PreparedStatement ps2=connection.prepareStatement("insert into `table-details` values(?,?,?,?,?,?)");
     	ps2.setString(1,branch);
     	ps2.setString(2,semester+"");
     	ps2.setString(3,section);
     	ps2.setString(4,subject);
     	ps2.setString(5,fac_name);	
     	ps2.setString(6,table_name);
     	ps2.executeUpdate();	
     	ps2.close();





//...................








     	connection.close();
     
     	
     	
     }catch(Exception ex){System.out.println(ex);}
 }else{System.out.println("parameter error");}
 
	//..................................
	
	
	
	
	if(allgood){

     	System.out.println("\nDetails:--\n  Subject: "+subject+"\n   Branch: "+branch+"\n   Semester: "+semester+"\n ");
		System.out.println("Test Deployed!!");
		System.out.println("-------------------------------------");
		
		
		
	%>
	<script>
		swal("Success","Test Deployed !!","success");
		setTimeout(function(){ window.location="FacultyPortal.jsp"; }, 2000);
	
		
		
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