        <%@ page import="java.io.*" %>
    <%@ page import="java.text.*" %>
    <%@ page import="java.util.*" %>
    <%@ page import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager;"%>
<!DOCTYPE html>
<html>
<head>
    <title>TEST</title>
    <link rel="shortcut icon" href="img/mg.png">
<link rel="icon" href="img/mg.png">
<script src="js/jquery.min.js"></script>
	
	<!-- Bootstrap +Bootstrap-Select -->
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<script src="js/bootstrap.min.js"></script>
	<link href="css/bootstrap-select.css" rel="stylesheet">
	<script src="js/bootstrap-select.js"></script>	
	<!-- SweetAlert + Page -->
	<script src="sweetalert-master/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="sweetalert-master/dist/sweetalert.css">
	
	
	<link rel="stylesheet" type="text/css" href="css/style_main.css">	
  	<script src="js/main.js"></script>  
   
   
    <%try{
    	String token=request.getParameter("token");
 %>
    <script type="text/javascript">
    var time=1800,atmp=0;var q,pts=0; var  questions=[];var res,ttaken;var arr1=[];var arr2=[];var arr3=[];


    
    //...................
         var MAX;
    //...................
    


        function dtime()
        {   
            if(time>0)time--;
            var m=Math.floor(time/60);
            var s=time%60;
            document.getElementById("tm").innerHTML=m+":"+s;
            if(time==0)window.location=String("ranks.jsp?token="+"<%=token%>"+"&rank="+pts+"&timetaken="+ttaken);
            if(time<60)document.getElementById("tm").style.color="#990000";
        }
     
        function qu(elmt)
        {   elmt.style.border="4px groove #5379fa";

             q=elmt.value;

             document.getElementsByClassName("qhead")[0].innerHTML="<qh>Question "+q+".</qh><br><br>";
             document.getElementById("qus").innerHTML = arr1[q-1];
             var xxx=document.getElementsByClassName("qno");
             for(var i=0;i<xxx.length;i++)
                {
                    if(i==q-1 || xxx[i].getAttribute("onclick")=="null")continue;
                    xxx[i].style.border="4px groove #990000";
                }
             
             document.getElementById("radio1").setAttribute("value",arr2[q-1][0]);
             document.getElementById("radio2").setAttribute("value",arr2[q-1][1]);
             document.getElementById("radio3").setAttribute("value",arr2[q-1][2]);
             document.getElementById("radio4").setAttribute("value",arr2[q-1][3]);
             
             document.getElementById("rd1").innerHTML=document.getElementById("radio1").getAttribute("value");
             document.getElementById("rd2").innerHTML=document.getElementById("radio2").getAttribute("value");
             document.getElementById("rd3").innerHTML=document.getElementById("radio3").getAttribute("value");
             document.getElementById("rd4").innerHTML=document.getElementById("radio4").getAttribute("value");
                            
           
        }
      
        
        function fnarr()
        {
             
                if(questions[q-1].ans==arr3[q-1]&&q<=MAX)
                    {pts+=1;document.getElementById("fnlrnk").setAttribute("value",pts);}

        }

        function next()
        {

        if(atmp!=MAX){

            if(q==MAX)q=0;
            while(document.getElementsByClassName("qno")[q].getAttribute("onclick")=="null")
                {q++;if(q==MAX)q=0;}
            if(q<MAX)
            qu(document.getElementsByClassName("qno")[q]);}
            else {swal("All Questions answered successfully!!", "You're being redirected to result page...", "success");

            window.location=String("ranks.jsp?token="+"<%=token%>"+"&rank="+pts+"&timetaken="+ttaken); }
        }



        function fnsmt(){
            atmp++;
             ttaken=1800-time;
            document.getElementById("ttaken").setAttribute("value",ttaken);
            document.getElementsByClassName("qno")[q-1].style.border="4px groove green";
            document.getElementsByClassName("qno")[q-1].setAttribute("onclick","null");
            document.getElementsByClassName("qno")[q-1].style.cursor="not-allowed";
            questions[q-1].ans=getRvalue("qans");
            fnarr();
            if(atmp!=MAX){
            if(q==MAX)q=0;
            while(document.getElementsByClassName("qno")[q].getAttribute("onclick")=="null")
                {q++;if(q==MAX)q=0;}
            if(q<MAX)
            qu(document.getElementsByClassName("qno")[q]);}
            else {
                  swal({
                     title: "All Questions answered successfully!!",
                    text: "You're being redirected to result page...",
                      closeOnCancel: false,
                      timer:4000,
                      closeOnConfirm: false
  
                        },
                        function(isConfirm){
                         
                        window.location=String("ranks.jsp?token="+"<%=token%>"+"&rank="+pts+"&timetaken="+ttaken);
                         
                      });

              

           
            }
            
        }
       function getRvalue(rgrp)

    {
       elements=document.getElementsByName(rgrp);
       for(var i=0;i<elements.length;i++)
        {
            if(elements[i].checked)
                return elements[i].value;
        }
    } 

    function attachtime()
    {
        ttaken=1800-time;
            document.getElementById("ttaken").setAttribute("value",ttaken);        
    }  

  /*  document.onmousedown=disableclick;
status="Right Click Disabled";
function disableclick(event)
{
  if(event.button==2)
   {
     //alert(status);
     return false;    
   }
}  */  

    </script>
</head>
<body oncontextmenu="return false">
<% 
              try{
            	  response.setHeader("Cache-Control","no-cache");
    			  response.setHeader("Cache-Control","no-store");
    			  response.setHeader("Pragma","no-cache");
    			  response.setDateHeader ("Expires", 0);
            	  ServletContext context = pageContext.getServletContext();
            		String url_db = context.getInitParameter("address");
            		String id_db = context.getInitParameter("id");
            		String pass_db = context.getInitParameter("pass");
            	 Class.forName("com.mysql.jdbc.Driver"); 
                Connection connection = DriverManager.getConnection(url_db,id_db,pass_db);
            

           String name=new String(Base64.getDecoder().decode(token),"utf-8");
           name=name.substring(0,name.length()-5);
           System.out.println(name+" : code_frame");
           Statement validst=connection.createStatement();
           ResultSet validrs=validst.executeQuery("select enrollment from auth_table where name=\""+name+"\"");
			if(validrs.next()){

            Statement statement2 = connection.createStatement();
                    String st2="SELECT subject,time FROM current_test ";
                              
                     ResultSet rs2=statement2.executeQuery(st2); 
                    if(rs2.next()){ %><script>time=<%=rs2.getInt("time")%>;</script><%}


            Statement statement3 = connection.createStatement();
                    String st3="SELECT * FROM sheet1";
                              
                     ResultSet rs3=statement3.executeQuery(st3); 
                    while(rs3.next()){
                    String newField1=rs3.getString("Question").trim();
                    String newField2=rs3.getString("CorrectAnswer").trim();
                    String newField3=rs3.getString("Choice-1").trim();
                    String newField4=rs3.getString("Choice-2").trim();
                    String newField5=rs3.getString("Choice-3").trim();
                    String newField6=rs3.getString("Choice-4").trim();
                    %>
                    <script>
           arr1.push("<%=newField1%>");
           arr3.push("<%=newField2%>");
                    var temparr=[];
            temparr.push("<%=newField3%>");
            temparr.push("<%=newField4%>");
            temparr.push("<%=newField5%>");
            temparr.push("<%=newField6%>");

                    arr2[<%=rs3.getRow()%>-1]=temparr;
                    


                    
                    </script><%}
            %><script> MAX=arr1.length; 
            for(var i=0;i<MAX;i++)
              {var f=new Object();
                f.ans="";
                questions.push(f);}


            </script>
             <script type="text/javascript">
     setInterval(dtime,1000);
     

</script>

<div class="headertop">
</div>
<div class="timeleft">
    Time Left:<div id="tm">Gud Luck!!</div>
</div>
<div class="qhead" ></div>
<div>
<div class="question" id="qus"></div>

</div>
<div id="choices">
      

<div>
<input type="radio" name="qans" id="radio1"  class="radio" checked/>
<label id="rd1" for="radio1"></label>
</div>

<div>
<input type="radio" name="qans" id="radio2"  class="radio"/>
<label  id="rd2" for="radio2"></label>
</div>

<div>   
<input type="radio" name="qans" id="radio3"  class="radio"/>
<label  id="rd3" for="radio3"></label>
</div>

<div>   
<input type="radio" name="qans" id="radio4"  class="radio"/>
<label  id="rd4" for="radio4"></label>
</div>
<input id="qsubmit" type="submit" value="Save" onclick="fnsmt()">
<input id="next" type="submit" value="Next" onclick="next()">

</div>

<div id="sel" class="sel" >

</div>
<script>

for(var i=1;i<=MAX;i++)
{
qemt=document.createElement("input");
qemt.setAttribute("type","button");
qemt.setAttribute("class","qno");
qemt.setAttribute("onclick","qu(this)");
qemt.value=i;
document.getElementById("sel").appendChild(qemt);
}


</script>

<script type="text/javascript">qu(document.getElementsByClassName("qno")[0]);</script>

<script type="text/javascript"></script>
<div class="name"><%=rs2.getString("subject")%></div>

<div id="time"></div>




<form action="ranks.jsp" >
    <input type="hidden" name="token" value="<%=token%>">
    <input id="fnlrnk" type="hidden" name="rank" >
    <input id="ttaken" type="hidden" name="timetaken" >
    <input id="submit_final" type="submit" onclick="attachtime()" value="Submit">
</form>
             <%
         
         }else{
            	 %>
            	 <script>
            	 swal("Forbidden 403!!","login again","error");
            	 setTimeout(function(){ window.location="index.html"; }, 4000);
            	 </script><%
             }

         }catch(Exception e)
         {%><script type="text/javascript">
                
         swal("Forbidden 403!!","login again","error");
         setTimeout(function(){ window.location="index.html"; }, 4000);
             </script><%
         }
             %> 


</body>
<%
    }catch(Exception abc)
    {
    	 %>
    	 <script>
    	 swal("Forbidden 403!!","login again","error");
    	 setTimeout(function(){ window.location="index.html"; }, 4000);
    	 </script><%
    }
%>
</html>