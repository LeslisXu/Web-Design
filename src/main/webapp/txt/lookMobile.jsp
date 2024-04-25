<%@ page contentType="text/html" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%--导入 Java 的 SQL 相关类和 JDBC 数据源相关的类 --%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%--导入 JNDI 相关的类 --%>

<title>浏览图书页面</title>

<style>
   #tom{
      font-family:宋体;font-size:26;color:black 
   }
</style>

<HTML><body background =image/11.jpg>   <!--引入11.jpg-->
<div align="center">
<br>

<p id=tom>选择你想要看的图书，来进入书屋吧！</p>
<% Connection con=null; 
   Statement sql;
   ResultSet rs;
   Context context = new InitialContext();
   Context contextNeeded=(Context)context.lookup("java:comp/env");
   DataSource ds=(DataSource)contextNeeded.lookup("mobileConn");// 获得连接池。
   
   
   try {
      con= ds.getConnection();// 使用连接池中的连接，通过数据源获取数据库的连接
      sql=con.createStatement();// 在这里创建了一个SQL对象
      // 读取mobileClassify表，获得分类：  
      rs=sql.executeQuery("SELECT * FROM mobileclassify");
      // mobileclassify：{教科书，课外书籍}
      out.print("<form action='queryServlet' id =tom method ='post'>") ;
      // 在html端打印了一个“表单开始标签”，该表单将提交到名为“queryServlet”的服务器端代码。
      out.print("<select id =tom name='fenleiNumber'>") ;
      // 打印了一个下拉列表框的开始标签，该列表框的名字为fenleiNumber。
      
      while(rs.next()){
         int id = rs.getInt(1);
         String mobileCategory = rs.getString(2);
         out.print("<option value ="+id+">"+mobileCategory+"</option>");
      }
      
      // 循环遍历结果集，将每个查询结果作为一个下拉列表选项打印到 HTML 页面中。
      
      out.print("</select>");
      // 打印下拉列表框的结束标签
      out.print("<input type ='submit' id =tom value ='提交'>");  
      // 打印提交按钮
      out.print("</form>");
      rs.close();
      // 关闭结果集
      con.close();
      //关闭数据库的链接，连接返回连接池。
   }
   catch(SQLException e){ 
      out.print(e);
   }
   // 如果发生 SQL 异常，将异常信息打印在页面上。
   finally{
     try{
        con.close();
     }
     catch(Exception ee){}
   } // 无论是否发生异常，最终关闭数据库连接。
%>
</div></body></HTML>