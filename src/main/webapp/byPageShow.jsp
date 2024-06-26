<%@ page contentType="text/html" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="java.sql.*" %>

<HEAD>
<%@ include file="txt/vscode1.txt" %>   <!--引入顶栏-->
</HEAD>
<title>分页浏览页面</title>
<style>
   #tom{
      font-family:宋体;font-size:26;color:black 
   }
</style>

<jsp:useBean id="dataBean" class="save.data.Record_Bean" scope="session"/>

<HTML><body background =image/11.jpg>
<jsp:setProperty name="dataBean" property="pageSize" param="pageSize"/>
<jsp:setProperty name="dataBean" property="currentPage" param="currentPage"/>


<center>
<table id =tom border=1>
<%  String [][] table=dataBean.getTableRecord();

    if(table==null) {
       out.print("没有记录");
       return;
    }
%>  <tr>
      <th>图书ISBN</th>
      <th>图书名</th>
      <th>图书出版社</th>
      <th>图书价格</th>
      <th>查看细节</th>
      <td>添加到购物车</td>
    </tr>
<%  int totalRecord = table.length;
// 计算总记录数、总页数，并设置相关属性到 `dataBean` 中。这部分逻辑是为了分页显示数据做准备。
    int pageSize=dataBean.getPageSize();  //每页显示的记录数。
// 从 dataBean 中获取每页显示的记录数
    int totalPages = dataBean.getTotalPages();
// 从 dataBenas 中获得总页数
    if(totalRecord%pageSize==0)
         totalPages = totalRecord/pageSize;//总页数。
    else
         totalPages = totalRecord/pageSize+1;
    dataBean.setPageSize(pageSize);
    //
    dataBean.setTotalPages(totalPages);
    // 将每页显示的记录数设置到 dataBean 这个对象中；
    
    
    // 检查是否有页可以展示
    if(totalPages>=1)
    //// 确保当前页码不超出范围，更新页码
    {
         if(dataBean.getCurrentPage()<1)
             dataBean.setCurrentPage(dataBean.getTotalPages());
         if(dataBean.getCurrentPage()>dataBean.getTotalPages())
             dataBean.setCurrentPage(1);
             
      // 计算当前页数据的起始位置
         int index=(dataBean.getCurrentPage()-1)*pageSize;
         int start=index;  //table的currentPage页起始位置。
         
      // 遍历并打印当前页的数据到页面上
         for(int i=index;i<pageSize+index;i++) { 
            if(i==totalRecord)
               break;
            out.print("<tr>");
            
         // 打印每行数据的各个属性
            for(int j=0;j<table[0].length;j++) {
               out.print("<td>"+table[i][j]+"</td>");
            }
   
         // 打印图书详细信息和添加到购物车的链接
            String detail =
            "<a href ='showDetail.jsp?ISBN="+table[i][0]+"'>图书详情</a>";
            out.print("<td>"+detail+"</td>");
            String shopping =
            "<a href ='putGoodsServlet?ISBN="+table[i][0]+"'>添加到购物车</a>";
            out.print("<td>"+shopping+"</td>"); 
            out.print("</tr>");
        }
    }
%>
</table>
<center>


<center>
<p id =tom>全部记录数:<jsp:getProperty name="dataBean" property="totalRecords"/>。
<br>每页最多显示<jsp:getProperty name="dataBean" property="pageSize"/>
条记录。
<br>当前显示第<jsp:getProperty name="dataBean" property="currentPage"/>页
(共有<jsp:getProperty name="dataBean" property="totalPages"/>页)。</p>
<table id =tom>
<tr>
  <td><form  action="" method=post>
     <input type=hidden name="currentPage" 
                   value="<%=dataBean.getCurrentPage()-1 %>"/>
     <input type=submit id =tom value="上一页"/></form>
  </td>
  <td><form action="" method=post>
     <input type=hidden name="currentPage" 
                   value="<%=dataBean.getCurrentPage()+1 %>"/>
     <input type=submit id =tom  value="下一页"></form>
  </td>
   <td> <form action="" id =tom method=post>
     输入页码：<input type=text id =tom  name="currentPage" size=2 >
     <input type=submit id =tom value="提交"></form>
   </td>
</tr>
<tr><td></td><td></td>
  <td><form action="" id =tom method=post>
  每页显示<input type=text id =tom name="pageSize" value =<%=dataBean.getPageSize()%> size=1>
  条记录<input type=submit id =tom value="确定"></form></td>
</tr>
</table>
</center>
</body></HTML> 
