<%@ page import="save.data.Login" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding = "utf-8" %>

<jsp:useBean id="loginBean" class="save.data.Login" scope="session"/>

<HEAD>
<%@ include file="txt/vscode1.txt" %>  <!--引入顶栏-->
</HEAD>

<title>查看购物车</title>

<style>
   #tom{
      font-family:微软雅黑;font-size:26;color:break
   }
</style>

<HTML>
<body background =image/11.jpg >  <!--引入名为11的图像-->

<div align="center">
<%  if(loginBean==null){
        response.sendRedirect("txt/login.jsp");//重定向到登录页面。
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
    Context  context = new InitialContext();
    Context  contextNeeded = (Context)context.lookup("java:comp/env");
    DataSource  ds = (DataSource)contextNeeded.lookup("mobileConn");//获得连接池。
    Connection con =null;
    Statement sql; 
    ResultSet rs;
    
    //打印表头信息
    out.print("<table border=1>");
    out.print("<tr>");
    out.print("<th id=tom width=120>"+"图书ISBN");
    out.print("<th id=tom width=120>"+"图书名");
    out.print("<th id=tom width=120>"+"图书价格");
    out.print("<th id=tom width=120>"+"购买数量");
    out.print("<th id=tom width=50>"+"修改数量");
    out.print("<th id=tom width=50>"+"删除图书");
    out.print("</tr>"); 
    try{
       con = ds.getConnection();//使用连接池中的连接。
       sql=con.createStatement(); 
       String SQL = 
      "SELECT goodsId,goodsName,goodsPrice,goodsAmount FROM shoppingForm"+
      " where logname ='"+loginBean.getLogname()+"'";
       rs=sql.executeQuery(SQL);//查shoppingForm表。
     //在mysql中开始查询，查询的表是shoppingForm
       /** 用于表示SQL查询结果集的对象。
       * 当执行SQL查询语句时，如果查询成功并返回了结果，这些结果被存储在ResultSet对象中。
       * 这个对象提供了一种方式来逐行逐列地遍历和访问查询返回的数据。
       */
       
       String goodsId="";
       String name="";
       float price=0;
       int amount=0;
       String orderForm =null; //订单。
       while(rs.next()) {
          goodsId = rs.getString(1);
          name = rs.getString(2);
          price =rs.getFloat(3);
          amount =rs.getInt(4);
          
          
          out.print("<tr>");
          out.print("<td id=tom>"+goodsId+"</td>"); 
          out.print("<td id=tom>"+name+"</td>");
          out.print("<td id=tom>"+price+"</td>");
          out.print("<td id=tom>"+amount+"</td>");
          
         /*
         之后的两个String update为每个商品生成了两个表单。
         第一个表单用于更新商品的数量，而第二个表单用于删除商品。
         */
          String update="<form  action='updateServlet' method = 'post'>"+	   //构建一个表单字符串，该表单将通过 POST 方法提交到 updateServlet，updateServlet 是处理更新商品数量的后端代码。
                     "<input type ='text'id=tom name='update' size =3 value= "+amount+" />"+	//在表单中添加一个文本框，用于输入更新后的商品数量。amount 变量的值被放置在这个文本框中，作为默认值。
                      "<input type ='hidden' name='goodsId' value= "+goodsId+" />"+	  //这里使用了一个隐藏的输入字段来存储商品的ID（goodsId）。这个字段对用户不可见，但会随表单提交到服务器。
                     "<input type ='submit' id=tom value='更新数量'  ></form>";	   //添加一个提交按钮，点击它将触发表单提交。
          
                     
          String del="<form  action='deleteServlet' method = 'post'>"+			// 表单的提交目标是 deleteServlet，通过 POST 方法提交。
                     "<input type ='hidden' name='goodsId' value= "+goodsId+" />"+ //这个隐藏的输入字段存储了商品的ID（goodsId）。它对用户不可见，但在提交表单时会将商品ID一同发送到后端服务。
                     "<input type ='submit' id=tom value='删除该商品' /></form>";  // 这是一个提交按钮，点击它将触发表单的提交，通知后端服务删除与该商品ID相关的商品。
          out.print("<td id=tom>"+update+"</td>");
          out.print("<td id=tom>"+del+"</td>");
          out.print("</tr>") ;
       }
       out.print("</table>");
       orderForm = "<form action='buyServlet' method='post'>"+
       "<input type ='hidden' name='logname' value= '"+loginBean.getLogname()+"'/>"+
       "<input type ='submit' id=tom value='生成订单(同时清空购物车)'></form>";
       out.print(orderForm);
       /*
        创建了一个表单，将数据提交到 buyServlet 这个后端服务，使用 POST 方法提交。
        创建了一个隐藏的输入字段，名为 logname，用于向后端提交用户的登录名称信息。
        生成了一个提交按钮，其 ID 被设置为 tom，显示的文本为 "生成订单(同时清空购物车)"。
       */
       /*
       页面加载时，用户可以看到一个包含了隐藏登录名字段和提交按钮的表单。
       当用户点击 "生成订单(同时清空购物车)" 按钮时，这个表单数据将提交到 buyServlet，
       服务器端将能够获取到用户的登录名信息并处理订单。
	   */
       
       con.close() ;//把连接返回连接池。
    }
    catch(SQLException e) { 
       out.print("<h1>"+e+"</h1>");
    }
    finally{
       try{
          con.close();
       }
       catch(Exception ee){}
    }
%>
</div></body></HTML>
