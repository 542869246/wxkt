<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/common/top.jsp"%>
<% 
%>

<%@ include file="../weixin/WxChatShare.jsp"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
<script type="text/javascript" src="static/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="static/js/layout.js"></script>
<link rel="stylesheet" href="static/css/bc.css" />
<title>保险</title>
<style type="text/css">
</style>
</head>
<body>
	${secure.USER_BAOXIAN}
</body>
</html>