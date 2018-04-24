<%@page import="org.springframework.context.ApplicationContext"%>
<%@
page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/common/top.jsp"%>
<% 
	//request.setAttribute("wxPath", request.getScheme()+"://"+request.getServerName()+"/index/toindex");
%>

<%@ include file="../weixin/WxChatShare.jsp"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
<script type="text/javascript" src="static/js/echarts.min.js"></script>
<script type="text/javascript" src="static/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="static/js/layout.js"></script>
<script type="text/javascript" src="static/js/basedao.js"></script>
<link rel="stylesheet" href="static/css/bc.css" />
<title>存续信息</title>
</head>
<body>
	<div class="wrapper">
		<div class="space_list">
			<p>您还没有认证哦！</p>
		</div>
	</div>
</body>
</html>
