<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String serverUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
	Object obj=application.getAttribute("uploadfPath");
%>

<!DOCTYPE html>
<html>
	<head>
	<base href="<%=basePath%>">
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
		<script type="text/javascript" src="static/js/jquery-1.11.3.min.js" ></script>
		<script type="text/javascript" src="static/js/layout.js" ></script>
		<link rel="stylesheet" href="static/css/bc.css" />
		<title>${title}</title>
	</head>
	<body>
		<div class="wrapper">
			<div class="space_list">
				<p>${msg}</p>
			</div>
		</div>
	</body>
</html>
