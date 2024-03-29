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
					
					<form action="typeimg/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="TYPEIMG_ID" id="TYPEIMG_ID" value="${pd.TYPEIMG_ID}"/>
						<input type="hidden" name="TYPEIMG_IMGURL" id="TYPEIMG_IMGURL">
						<input type="hidden" name="TYPEIMG_PRODUCTSTYPE_ID" id="TYPEIMG_PRODUCTSTYPE_ID" value='${pd.TYPEIMG_PRODUCTSTYPE_ID}'>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">产品类型:</td>
								<td><input readonly="readonly" type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="40" placeholder="这里输入产品类型" title="产品类型" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">轮播图片:</td>
								<td>
									<div id="uploader-demo">
										<!--用来存放item-->
										<div id="filePicker" style="float: left;"  class="uploader-list fileList">选择图片</div>
									</div>
									<div id='zmy'>
										<c:if test="${pd.TYPEIMG_IMGURL!=null}">
												<img src="<%=basePath%>${pd.TYPEIMG_IMGURL}" class="center-block" width="100" height="100" onerror="javascript:this.src='static/images/404error.jpg';this.onerror=null" alt="pic" />
												<input type="hidden" name="TYPEIMG_IMGURL" id="TYPEIMG_IMGURL" value="${pd.TYPEIMG_IMGURL}"/>
										</c:if>
									</div>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
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


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!--图片上传-->
	<script type="text/javascript" src="plugins/imguploader/tool/webuploader/webuploader.js"></script>
	<script type="text/javascript" src="plugins/imguploader/js/uploadTypei mg.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#TYPEIMG_PRODUCTSTYPE_ID").val()==""){
				$("#TYPEIMG_PRODUCTSTYPE_ID").tips({
					side:3,
		            msg:'请输入产品类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TYPEIMG_PRODUCTSTYPE_ID").focus();
			return false;
			}
			if($("#TYPEIMG_IMGURL").val()==""){
				$("#TYPEIMG_IMGURL").tips({
					side:3,
		            msg:'请输入产品图片',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TYPEIMG_IMGURL").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>