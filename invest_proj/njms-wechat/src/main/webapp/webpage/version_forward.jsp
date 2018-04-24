<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.8.3.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>css/public.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>css/index.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>css/main.css"/>
<style type="text/css">
	*{
		margin: 0px;
		padding: 0px;
	}
	body{
		letter-spacing: 1px;
		background-color: #d9edee;
		font-family: 微软雅黑;
	}
	.white_background{
		width:785px;
		height:218px;
		background: url("<%=request.getContextPath()%>/images/juxing.png") no-repeat 0 0;
	}
	p{
		width:95%;
		padding-left: 25px;
		padding-top: 29px;
		line-height: 50px;
		
	}
	table {
		margin: 15% auto;
	}
	
	p span,a{
		color: #0299ce;
	}
	a{
		text-decoration: none;
	}
	.left_img{
		padding-right: 80px;
	}
	.text_img, .text{
		padding-left: 10px;
	}
</style>
<title>Insert title here</title>
</head>
<body>
   <table cellpadding="0" >
   		<tr>
   			<td rowspan="3" class="left_img"><img src="<%=request.getContextPath()%>/images/ae75f28af1a7752321c53bf563701a47.png" /></td>
   			<td><img class="text_img" src="<%=request.getContextPath()%>/images/ketongwenzi.png"/></td>
   		</tr>
   		<tr>
   			<td ><div class="white_background"><p >亲，如果您的网页打不开，或有其他情况不能浏览，请使用“360极速浏览器（<span>下载</span>）”，选择地址栏或的“极速模式”。<br/>
						<a href="">点击查看</a>更多浏览器帮助</p></div></td>
   		</tr>
   		<tr>
   			<td><span class="text">新版网页可采用极速模式，新警综可采用IE8模式，PKI系统可根据需要选择兼容模式</span></td>
   		</tr>
<%--    		<img src="<%=request.getContextPath()%>/images/juxing.png"/> --%>
   </table>
</body>
</html>