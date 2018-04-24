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
		<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.11.3.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/layout.js" ></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/bc.css" />
		<title>系统消息</title>
		<style>
			.message_details{ width: 100%; height: 100%; background: #fff; padding: 0.5rem 0.9rem;}
			.message_details h1{ width: 100%; height: 1rem; line-height: 1rem; font-size: 0.75rem; color: #333; font-weight: normal;}
			.message_details h2{ width: 100%; height: 1rem; line-height: 1rem; font-size: 0.5rem; color: #999; font-weight: normal;}
			.message_details p{ width: 100%; font-size: 0.6rem; color: #808080; line-height: 1rem; text-align: justify;}
		</style>
	</head>
	<body>
		<c:if test="${not empty message}">
			<div class="wrapper">
				<div class="message_details">
					<h1>${message.SERVER_TITLE }</h1>
					<h2>${message.SERVER_CREATETIME }</h2>
					<p>${message.SERVER_CONTENT }</p>
				</div>	
			</div>
		</c:if>
	</body>
</html>
