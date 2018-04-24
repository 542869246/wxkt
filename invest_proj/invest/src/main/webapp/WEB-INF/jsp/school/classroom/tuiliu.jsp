<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<!-- 图片上传 -->
	<link rel="stylesheet" type="text/css" href="plugins/imguploader/tool/webuploader/webuploader.css">
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
						<c:if test="${address != '' }">
							<textarea id="tuiliudiv" style="text-align: center;font-size: 18px;width: 100% ;resize:none;overflow-y:hidden;
background-attachment:fixed;
background-repeat:no-repeat;
border-style:solid; 
border-color:#FFFFFF";rows="3" cols="20" readonly="readonly">${address}</textarea>
							<input type="button" value="复制" onclick="copyUrl2()">
						</c:if>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->

<script type="text/javascript">
 function copyUrl2(){ 
	 var Url2=document.getElementById("tuiliudiv");
 	Url2.select(); // 选择对象
 	document.execCommand("Copy"); // 执行浏览器复制命令
	 alert("已复制好，可贴粘。");}
 </script>
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		
		$(function() {
			//如果没有推流地址
			if('${address}'==""){
				alert("请输入正确的腾讯推流防盗链Key接和腾讯直播bizid");
			//关闭当前窗口
			top.Dialog.close();
			}
		});
		
		
		</script>
				<!-- 图片上传 js-->
	<script type="text/javascript" src="plugins/imguploader/tool/webuploader/webuploader.js"></script>
	<script type="text/javascript" src="plugins/imguploader/js/uploadClassroom.js"></script>
</body>
</html>