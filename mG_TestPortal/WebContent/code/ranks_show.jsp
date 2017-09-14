        <%@ page import="java.io.*" %>
    <%@ page import="java.text.*" %>
    <%@ page import="java.util.*" %>
    <%@ page import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
            <html>

            <head>
                <title>TestResults</title>
             <link rel="shortcut icon" href="mg.png" >
<link rel="icon" href="mg.png" >
                <style>
                    body,
                    html {
                        background-image: url(backmain.jpg);
                        background-color: black;
                        color:#80ffaa;
                        background-size: cover;
                        background-attachment: fixed;
                

                    }
                    
                    .mainhead {
                        position: relative;
                        max-width: 200px;
                        text-shadow: 2px 2px 2px black;
                        
                        font-family: georgia;
                        top: 4%;
                        left: 45%;
                    }
                    .refh{
                       position: absolute;
                        max-width: 200px;
                        text-shadow: 2px 2px 2px black;
                       
                        font-family: georgia;
                        top: 5.5%;
                        left: 7%; 
                        cursor: pointer;
                    }
                    .anssheet{
                       position: absolute;
                        max-width: 200px;
                        text-shadow: 2px 2px 2px black;
                       
                        font-family: georgia;
                        top: 4%;
                        left: 85%; 
                        cursor: pointer;
                    }
                    
                    .reg {
                        position: absolute;
                        top: 15%;
                        left: 5%;
                        height: 200px;
                        

                    }
                    .tg {
border-collapse:collapse;
border-spacing:0;
border-color:#aabcfe;
} 
.tg td{
font-family:georgia;
font-size:25px;
width:200px;
padding:10px 5px;
border-style:solid;
border-width:0px;
overflow:hidden;
word-break:normal;
text-align: center;
border-color:#aabcfe;
color:green;
background:transparent;
border-top-width:1px;
border-bottom-width:1px;
} 
.tg th{
font-family:georgia;
font-size:25px;
font-weight:normal;
text-shadow: 2px 2px 5px black;
padding:10px 5px;
border-style:solid;
border-width:0px;
overflow:hidden;
word-break:normal;
border-color:#aabcfe;
color:#5379fa;
background:transparent;
border-top-width:1px;
border-bottom-width:1px;
} 
.tg .widespace{width: 400px;}
.tg .tg-yw4l{vertical-align:top} 
.tg .tg-6k2t{background-color:#17191a;vertical-align:top} 
table.sortable thead {
    background-color:#262626;
    color:green;
    font-size: 30px;
    width:450px;
    padding:7px;
    cursor: default;
}
                  

#tm{
    color:green;
}

        ::-webkit-scrollbar {
            width: 12px;
            z-index: 1;
        }
        
        ::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0px 2px 6px #5379fa;
            border-radius: 10px;
        }
        
        ::-webkit-scrollbar-thumb {
            border-radius: 10px;
            -webkit-box-shadow: inset 5px 0 6px #5379fa;
        }

div{padding: 7px;}
 .headertop{
            background-color: #17191a;
            height: 50px;
            top:3%;
            left:5%;
            width:90%;
               position: absolute;
             
            box-shadow: 7px 7px 1px black;
         

         }
         rd{color: red;font-size: 26px;}


                   
                </style>
                
                <script type="text/javascript">
                var t=4;var etr,etd0,etd1,etd2,etd3,textnode0,textnode1,textnode2,textnode3;var count=1;
                function ranks(){
                     <% 
                     
                     Class.forName("com.mysql.jdbc.Driver"); 
                    Connection connection = DriverManager.getConnection(
                "jdbc:mysql://127.0.0.1:3306/code","mangesh","hero007@");
                    
                    
                    

                    Statement statement = connection.createStatement();
                    String st="SELECT * FROM ranks ORDER by points DESC,time ASC";
                              
                     ResultSet rs=statement.executeQuery(st); 
                    while(rs.next()){
                        String name =rs.getString("name");
                        int pts =rs.getInt("points");
                        int time =rs.getInt("time");
                    
                     %>   etr=document.createElement("tr");
                     etd0=document.createElement("td");
                      etd1=document.createElement("td");
                      etd2=document.createElement("td");
                       etd3=document.createElement("td");
                       textnode0=document.createTextNode(count);
                       etd0.appendChild(textnode0);
                     etr.appendChild(etd0);
                     count++;
                      textnode1=document.createTextNode("<%=name%>");
                     etd1.appendChild(textnode1);
                     etr.appendChild(etd1);
                     textnode2=document.createTextNode("<%=pts%>");
                     var time=<%=time%>;
                        var m=Math.floor(time/60);
                       var s=time%60;

                     textnode3=document.createTextNode(m+" min "+s+" sec");
                     etd2.appendChild(textnode2);
                     etd3.appendChild(textnode3);
                     etd0.setAttribute("class","tg-6k2t");
                     etd2.setAttribute("class","tg-6k2t");
                     etr.appendChild(etd2);
                     etr.appendChild(etd3);
                     document.getElementById("tbl").appendChild(etr);<%}%>
                     
                    }
                    function ref(){
                        window.location="ranks_show.jsp";
                    }
                    function sort_rank(){
                        var myTH = document.getElementsByTagName("th")[1];
                        sorttable.innerSortFunction.apply(myTH, []);
                    }
                    function sort_name(){
                        var myTH = document.getElementsByTagName("th")[0];
                        sorttable.innerSortFunction.apply(myTH, []);
                    }
                    function opensheet(){
                        window.location="anssheet.pdf";
                    }
                    function delaysheet(){
                        swal({
                            title: "Wait!",
                            text: "AnswerSheet will be available after the test!!",
                            type: "error",
                            confirmButtonText: "Okey"
                            });
                    }
                    
                   
                </script>
                <script src="sweetalert-master/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="sweetalert-master/dist/sweetalert.css">
               <script src="sorttable.js"></script>
             

            </head>

            <body oncontextmenu="return false" onload="ranks()"">
           <script type="text/javascript">
               setInterval(ref,60000);
           </script>
                <div class="headertop"></div>
                <h1 class="mainhead"> Results</h1>
                <h4 class="refh" onclick="ref()">Refresh</h4>
                <h4 class="anssheet" onclick="delaysheet()">AnswerSheet<rd></rd></h4>


                <div class="reg">
                <table  class="tg" >
                    <thead>
                         <tr><th>Rank</th><th class="widespace">Name</th><th class="sorttable_numeric" id="rank">Correct Answers</th><th class="widespace">Time Taken</th></tr>
                    </thead>
                    <tbody id="tbl"></tbody>
                </table>
                </div>
                  
            </body>

            </html>