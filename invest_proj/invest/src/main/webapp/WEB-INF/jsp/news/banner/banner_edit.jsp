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
	<link rel="stylesheet" href="plugins/datetimepicker/css/jquery.datetimepicker.css" />
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
					
					<form action="banner/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="BANNER_URL" id="BANNER_URL"/>
						<input type="hidden" name="BANNNER_ID" id="BANNNER_ID" value="${pd.BANNNER_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">轮播标题:</td>
								<td><input type="text" name="BANNER_TITLE" id="BANNER_TITLE" value="${pd.BANNER_TITLE}" maxlength="100" placeholder="这里输入轮播标题" title="轮播标题" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">链接网站:</td>
								<td><input type="text" name="BANNER_TOURL" id="BANNER_TOURL" value="${pd.BANNER_TOURL}" maxlength="200" placeholder="这里输入链接网站" title="链接网站" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">轮播状态:</td>
								<td>
								<input name="BANNER_STATE" type="radio" value="0" checked <c:if test="${pd.BANNER_STATE==0}">checked</c:if> />显示
								<input name="BANNER_STATE" type="radio" value="1" <c:if test="${pd.BANNER_STATE==1}">checked</c:if> />隐藏
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">轮播顺序:</td>
								<td><input type="text" name="BANNER_ORDERBY" id="BANNER_ORDERBY" value="${pd.BANNER_ORDERBY}" maxlength="200" placeholder="轮播顺序" title="轮播顺序" style="width:98%;"/></td>
							</tr>
							<!-- 
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">创建人:</td>
								<td><input type="text" name="BANNER_CREATEBY" id="BANNER_CREATEBY" value="${pd.BANNER_CREATEBY}" maxlength="20" placeholder="这里输入创建人" title="创建人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">创建时间:</td>
								<td>
								<input type="text" id="datetimepicker6" name="BANNER_CREATETIME"   value="<fmt:formatDate value="${pd.BANNER_CREATETIME}" pattern="yyyy-MM-dd HH:mm" /> "   placeholder="新闻创建时间" title="新闻创建时间" style="width:98%;" />
								</td>
							</tr>
							 -->
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">轮播图片:</td>
								<td>
											<div id="uploader-demo">
												<!--用来存放item-->
												<div id="filePicker" style="float: left;"  class="uploader-list fileList">选择图片</div>
											</div>
											<div id="zjt">
											<c:if test="${pd.BANNER_URL!=null}">
												<img src="<%=basePath%>${pd.BANNER_URL}" class="center-block" width="100" height="100" onerror="javascript:this.src='static/images/404error.jpg';this.onerror=null" alt="pic" />
												<input type="hidden" name="BANNER_URL" id="BANNER_URL" value="${pd.BANNER_URL}"/>
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
	<script type="text/javascript" src="plugins/datetimepicker/jquery.js" ></script>
	<script type="text/javascript" src="plugins/datetimepicker/build/jquery.datetimepicker.full.js" ></script>
	<!-- 图片上传 js-->
	<script type="text/javascript" src="plugins/imguploader/tool/webuploader/webuploader.js"></script>
	<script type="text/javascript" src="plugins/imguploader/js/uploadbanner.js"></script>
	<script>
	   $('#datetimepicker6').datetimepicker({lang:'ch'});
	</script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			/*if($("#BANNER_URL").val()==""){
				$("#BANNER_URL").tips({
					side:3,
		            msg:'轮播图片',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BANNER_URL").focus();
			return false;
			}*/
			if($("#BANNER_TITLE").val()==""){
				$("#BANNER_TITLE").tips({
					side:3,
		            msg:'请输入轮播标题',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BANNER_TITLE").focus();
			return false;
			}
			var re = /^[0-9]+.?[0-9]*$/; 
			var nubmer = document.getElementById("BANNER_ORDERBY").value;
			  if(!re.test(nubmer)){
				  document.getElementById("BANNER_ORDERBY").value = "";
				$("#BANNER_ORDERBY").tips({
					side:3,
		            msg:'请输入数字',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BANNER_ORDERBY").focus();
			return false;
			}
			if($("#BANNER_STATE").val()==""){
				$("#BANNER_STATE").tips({
					side:3,
		            msg:'请输入轮播状态',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BANNER_STATE").focus();
			return false;
			}
			/*if($("#BANNER_CREATEBY").val()==""){
				$("#BANNER_CREATEBY").tips({
					side:3,
		            msg:'请输入创建人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BANNER_CREATEBY").focus();
			return false;
			}
			if($("#BANNER_CREATETIME").val()==""){
				$("#BANNER_CREATETIME").tips({
					side:3,
		            msg:'请输入创建时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BANNER_CREATETIME").focus();
			return false;
			}*/
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