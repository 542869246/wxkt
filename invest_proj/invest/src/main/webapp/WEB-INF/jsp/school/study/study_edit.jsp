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
					
					<form action="study/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="STUDY_ID" id="STUDY_ID" value="${pd.STUDY_ID}"/>
						<input type="hidden" name="STUDY_IDS" id="STUDY_IDS" value="${pd.STUDY_IDS }" />
						<input type="hidden" name="scheduleList" id="scheduleList" value="${pd.scheduleList }">
						<input type="hidden" name="SCHEDULE_ID" id="SCHEDULE_ID" value="${pd.SCHEDULE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">课程名称:</td>
								<td>
									<select name="SUBJECT_ID" ID="SUBJECT_ID">
										<option value="">请选择</option>
										<c:forEach items="${subjectList }" var="var">
											<option value="${var.SUBJECT_ID }" <c:if test="${var.SUBJECT_ID==pd.SUBJECT_ID }">selected</c:if>>${var.SUBJECT_NAME }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">学习时长:</td>
								<td><input type="text" name="STUDY_TIMEDIFF" id="STUDY_TIMEDIFF" value="${pd.STUDY_TIMEDIFF}" maxlength="20" placeholder="这里输入学习时长" title="学习时长" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">学习内容:</td>
								<td><input type="text" name="STUDY_CONTENT" id="STUDY_CONTENT" value="${pd.STUDY_CONTENT}" maxlength="100" placeholder="这里输入学习内容" title="学习内容" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">是否达标:</td>
								<td>
									<select name="IS_SHOW" id="IS_SHOW">
										<option value="">请选择</option>
										<option value="0" <c:if test="${pd.IS_SHOW==0 }">selected</c:if>>达标</option>
										<option value="1" <c:if test="${pd.IS_SHOW==1 }">selected</c:if>>未达标</option>
									</select>
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
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#COURSES_ID").val()==""){
				$("#COURSES_ID").tips({
					side:3,
		            msg:'请输入课程名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COURSES_ID").focus();
			return false;
			}
			if($("#STUDY_TIMEDIFF").val()==""){
				$("#STUDY_TIMEDIFF").tips({
					side:3,
		            msg:'请输入学习时长',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STUDY_TIMEDIFF").focus();
			return false;
			}
			if($("#STUDY_CONTENT").val()==""){
				$("#STUDY_CONTENT").tips({
					side:3,
		            msg:'请输入学习内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STUDY_CONTENT").focus();
			return false;
			}
			if($("#IS_SHOW").val()==""){
				$("#IS_SHOW").tips({
					side:3,
		            msg:'请输入是否可见',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IS_SHOW").focus();
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