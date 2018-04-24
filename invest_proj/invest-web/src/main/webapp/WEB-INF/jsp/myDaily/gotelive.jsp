<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ include file="/common/top.jsp"%>
<%@ include file="../weixin/WxChatShare.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>实时课堂</title>
</head>
<body>
<script src="${pageContext.request.contextPath}/static/wx/js/jquery-1.11.3.min.js"></script>

<c:if test="${sessionScope.loginuser!=null}">
<script type="text/javascript">
		$(function(){
			location.href="${pageContext.request.contextPath}/gotye/goGotyeLive";
		});
</script>
</c:if>
</body>
</html>