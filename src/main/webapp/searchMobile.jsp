<%@ page contentType="text/html" %>
<%@ page pageEncoding = "utf-8" %>

<HEAD>
<%@ include file="txt/vscode1.txt" %>    <!--引入顶栏-->
</HEAD>

<title>查询页面</title>
<style>
   #tom{
      font-family:宋体;font-size:26;color:black; 
   }
</style>
<HTML><body background =image/11.jpg >    <!--引入名为11的图像-->
<div align="center">
<br>
<p id=tom>欢迎查询！</p>
<p id=tom>查询时可以输入书籍的编号，名称或者价格区间。<br>
书籍名支持模糊查询。
</p>
<form action="searchByConditionServlet" id =tom method="post" >  <!--交给searchByConditionServlet-->
<!-- action属性定义了表单提交时请求发送到的URL -->

输入查询信息:<input type=text id=tom name="searchMess"><br>    <!--searchMess和servlet相连-->
<!-- 这个输入框允许用户输入查询信息。'name' 属性 'searchMess' 会在提交表单时标识这个输入框的内容。 -->

   <input type =radio name="radio" id =tom value="ISBN"/>      <!--radio和servlet相连-->
   <!-- 这个单选按钮允许用户选择 '书籍编号'。当选择时，'value' 属性 'ISBN' 的值将会传递到服务器端。 -->
    
    书籍编号
   <input type =radio name="radio" id =tom value="book_name">   <!--radio和servlet相连-->
   <!-- 这段文本显示了 '书籍编号' 单选按钮的标签。 -->
    
    书籍名
   <input type =radio name="radio" value="book_price" checked>   <!--radio和servlet相连-->
   	<!-- 这段文本显示了 '书籍名' 单选按钮的标签。 -->
   	<!-- 这个单选按钮允许用户选择 '书籍价格区间'。当选择时，'value' 属性 'book_price' 的值将会传递到服务器端。'checked' 属性让它默认被选中。 -->
   	
    书籍价格区间
   <br><input type=submit id =tom value="提交">
</form>
</div></body></HTML>