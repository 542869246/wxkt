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
					
					<form action="school_lesson_time/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="LESSON_TIME_ID" id="LESSON_TIME_ID" value="${pd.LESSON_TIME_ID}"/>
						<input type="hidden" name="LESSON_TYPE" id="LESSON_TYPE" value="${pd.LESSON_TYPE}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">开始时间:</td>
											<td><input class="span10 date-picker checkTeacherAddClassroom"
												name="LESSON_STARTTIME" id="LESSON_STARTTIME"
												value="${pd.LESSON_STARTTIME}" type="text"
												data-date-format="yyyy-mm-dd" readonly="readonly"
												placeholder="开始时间" title="开始时间" style="width: 98%;" /></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;" class="bitianxiang">结束时间:</td>
											<td><input class="span10 date-picker checkTeacherAddClassroom"
												name="LESSON_ENDTIME" id="LESSON_ENDTIME"
												value="${pd.LESSON_ENDTIME}" type="text"
												data-date-format="yyyy-mm-dd" readonly="readonly"
												placeholder="结束时间" title="结束时间" style="width: 98%;" /></td>
										</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="LESSON_REMARK" id="LESSON_REMARK" value="${pd.LESSON_REMARK}" maxlength="100" placeholder="这里输入备注4" title="备注4" style="width:98%;"/></td>
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
	<script src="static/js/layer/layer.js"></script>
	<script src="static/ace/js/laydate/laydate.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#LESSON_STARTTIME").val()==""){
				$("#LESSON_STARTTIME").tips({
					side:3,
		            msg:'请选择开始时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LESSON_STARTTIME").focus();
			return false;
			}
			if($("#LESSON_ENDTIME").val()==""){
				$("#LESSON_ENDTIME").tips({
					side:3,
		            msg:'请选择结束时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LESSON_ENDTIME").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			/* $('.date-picker').datepicker({autoclose: true,todayHighlight: true}); */
		});
		</script>
		
		<script type="text/javascript">
		laydate.render({
			elem : '#LESSON_STARTTIME'
			,type: 'time'
				,theme: '#76ACCD'
				})
		laydate.render({
			elem : '#LESSON_ENDTIME'
			,type: 'time'
				,theme: '#76ACCD'
				})
		</script>
</body>
</html>