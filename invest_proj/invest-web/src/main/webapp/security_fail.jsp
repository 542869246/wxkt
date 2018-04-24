<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*,com.flc.util.DbFH,java.io.InputStream,java.io.IOException"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
<title>鉴权失败</title>
<style type="text/css">

html, body {
	height: 100%;
	width: 100%;
	margin: 0;
	padding: 0;
}

.center {
	width: 100%;
	text-align:center;
	margin: 0 auto;
	position: relative; /*脱离文档流*/	
	top: 25%; /*偏移*/
	font-size: 5rem;
	text-shadow: 0.2rem 0.2rem 0.6rem #8a7979;
}
.center:AFTER {
	content: "鉴权失败!";
    font-size: 5rem;
    display: block;
    color: #EFEFEF;
}
</style>
</head>
<body>
	<div class="center">
		SECURITY FAIL
	</div>
</body>
</html>