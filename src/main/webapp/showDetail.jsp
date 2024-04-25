<%@ page contentType="text/html" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="save.data.Login" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="java.sql.*" %>


<jsp:useBean id="loginBean" class="save.data.Login" scope="session"/>

<HEAD>
<%@ include file="txt/vscode1.txt" %>   <!--引入顶栏-->
</HEAD>

<title>商品详情</title>

<style>
   #tom{
      font-family:宋体;font-size:26;color:black 
   }
</style>

<HTML>
<center>
<body background =image/11.jpg >    <!--引入名为11的图像-->
<%  try{ 
         loginBean = (Login)session.getAttribute("loginBean");
         //通过 session.getAttribute("loginBean") 获取登录信息。
         
         if(loginBean==null){
           response.sendRedirect("txt/login.jsp");//重定向到登录页面.
           return;
         }
         else {
           boolean b =loginBean.getLogname()==null||
                   loginBean.getLogname().length()==0;
           if(b){
              response.sendRedirect("txt/login.jsp");//重定向到登录页面。
              return;
           }
         }
      }
      catch(Exception exp){
           response.sendRedirect("txt/login.jsp");//重定向到登录页面。
           return;
      }
   String ISBN = request.getParameter("ISBN"); 
   // 通过 request.getParameter("ISBN") 获取名为 "ISBN" 的参数，以检索特定的产品信息。
   // 再解释一下，由于ISBN相当于是产品的主键，所以用ISBN直接检索产品。
   if(ISBN==null) {
       out.print("没有产品号，无法查看细节");
       return;
   } 
   
   
   //在这里添加到了连接池里
   Context context = new InitialContext();
   Context contextNeeded = (Context)context.lookup("java:comp/env");
   DataSource ds = (DataSource)contextNeeded.lookup("mobileConn");//获得连接池。
   Connection con = null;
   Statement sql; 
   ResultSet rs;
   try{ 
     con= ds.getConnection();//使用连接池中的连接。
     // 从连接池获取数据库连接（DataSource），这里使用了 JNDI 来检索连接池资源。
     
     sql=con.createStatement();
     String query="SELECT * FROM mobileForm where ISBN = '"+ISBN+"'";
     // 使用获取的连接创建了一个 SQL 语句并执行查询。
     // 查询了一个名为 mobileForm 的表，以特定的 ISBN 来检索产品的详细信息。
     
     
     // 在这里开始打印表格的第一行
     rs=sql.executeQuery(query);
     //在mysql中开始查询
     /** 用于表示SQL查询结果集的对象。
     * 当执行SQL查询语句时，如果查询成功并返回了结果，这些结果被存储在ResultSet对象中。
     * 这个对象提供了一种方式来逐行逐列地遍历和访问查询返回的数据。
     */
     out.print("<table id=tom border=1>");
     out.print("<tr>");
     out.print("<th>图书ISBN");
     out.print("<th>图书名");
     out.print("<th>出版社");
     out.print("<th>图书价格");
     out.print("<th>放入购物车<th>");
     out.print("</tr>");
     // 在这里表示换行
     String picture="background.jpg";
     String detailMess="";
     while(rs.next()){
       ISBN=rs.getString(1);
       String name=rs.getString(2);
       String maker=rs.getString(3);
       String price=rs.getString(4);
       detailMess=rs.getString(5);
       picture=rs.getString(6); 
       /**
       getstring从结果集中获取指定列的值，
       并将其以字符串的形式返回。
       rs.getString(x)从当前行中获取第x列数据。
       */
       
       
       out.print("<tr>");
       out.print("<td>"+ISBN+"</td>");
       out.print("<td>"+name+"</td>");
       out.print("<td>"+maker+"</td>");
       out.print("<td>"+price+"</td>");
       String shopping =
       "<a href ='putGoodsServlet?ISBN="+ISBN+"'>添加到购物车</a>";
       out.print("<td>"+shopping+"</td>"); 
       out.print("</tr>");
     } 
     out.print("</table>");
     out.print("<br>");
     out.print("<p id=tom>产品详情:</p>");
     out.println("<div align=center id=tom>"+"出版日期："+detailMess+"<div>");
     String pic ="<img src='image/"+picture+"' width=260 height=350 ></img>";
     out.print(pic); //产片图片
     con.close(); //连接返回连接池。                
  }
  catch(SQLException exp){}
  finally{
     try{
          con.close();
     }
     catch(Exception ee){}
  } 
%>
</center>
</body></HTML>
