<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ include file="/common/top.jsp"%>

<%@ include file="../weixin/WxChatShare.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.11.3.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/layout.js" ></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bc.css" />
		<title>我的等级</title>
	</head>
	<body>
		<c:if test="${not empty varList}">
			<div class="wrapper">
				<div class="my_grade">
					<header class="jewel">
						<label>${sessionScope.loginuser.USER_NICKNAME }</label>
					</header>
					<h1>会员权限</h1>
						<p>${varList.LEVEL_CONTENT }</p>
				</div>
			</div>
		</c:if>
	</body>
</html>
