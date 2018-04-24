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
					
					<form action="leave/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="LEAVE_ID" id="LEAVE_ID" value="${pd.leave_id}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学生:</td>
								<td><input type="text" name="student_name" id="student_name" value="${pd.student_name}" maxlength="32" placeholder="这里输入备注2" title="备注2" style="width:98%;"/>
								<input type="hidden" name="STUDENT_ID" id="STUDENT_ID" value="${pd.student_id}" maxlength="32" placeholder="这里输入备注2" title="备注2" style="width:98%;"/>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">课程:</td>
								<td><input type="text" name="LESSONS_ID" id="LESSONS_ID" value="${pd.lesson_name}" maxlength="32" placeholder="这里输入备注3" title="备注3" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">科目:</td>
								<td><input type="text" name="LEAVECAUSE" id="LEAVECAUSE" value="${pd.subject_name}" maxlength="20" placeholder="这里输入备注4" title="备注4" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">教室:</td>
								<td><input type="text" name="LEAVECAUSE" id="LEAVECAUSE" value="${pd.classroom_name}" maxlength="20" placeholder="这里输入备注4" title="备注4" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">老师:</td>
								<td><input type="text" name="LEAVECAUSE" id="LEAVECAUSE" value="${pd.NAME}" maxlength="20" placeholder="这里输入备注4" title="备注4" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">请假原因:</td>
								<td><input type="text" name="LEAVECAUSE" id="LEAVECAUSE" value="${pd.leavecause}" maxlength="20" placeholder="这里输入备注4" title="备注4" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">请假日期:</td>
								<td><input class="span10 date-picker" name="LEAVEDATE" id="LEAVEDATE" value="${pd.leavedate}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="备注5" title="备注5" style="width:98%;"/></td>
							</tr>
<!-- 							<tr> -->
<!-- 								<td style="width:75px;text-align: right;padding-top: 13px;">备注6:</td> -->
<%-- 								<td><input type="text" name="CREATEBY" id="CREATEBY" value="${pd.CREATEBY}" maxlength="32" placeholder="这里输入备注6" title="备注6" style="width:98%;"/></td> --%>
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td style="width:75px;text-align: right;padding-top: 13px;">备注7:</td> -->
<%-- 								<td><input class="span10 date-picker" name="CREATEDATE" id="CREATEDATE" value="${pd.CREATEDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="备注7" title="备注7" style="width:98%;"/></td> --%>
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td style="width:75px;text-align: right;padding-top: 13px;">备注8:</td> -->
<%-- 								<td><input type="text" name="MODIFYBY" id="MODIFYBY" value="${pd.MODIFYBY}" maxlength="32" placeholder="这里输入备注8" title="备注8" style="width:98%;"/></td> --%>
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td style="width:75px;text-align: right;padding-top: 13px;">备注9:</td> -->
<%-- 								<td><input class="span10 date-picker" name="MODIFYDATE" id="MODIFYDATE" value="${pd.MODIFYDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="备注9" title="备注9" style="width:98%;"/></td> --%>
<!-- 							</tr> -->
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
			if($("#STUDENT_ID").val()==""){
				$("#STUDENT_ID").tips({
					side:3,
		            msg:'请输入备注2',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STUDENT_ID").focus();
			return false;
			}
			if($("#LESSONS_ID").val()==""){
				$("#LESSONS_ID").tips({
					side:3,
		            msg:'请输入备注3',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LESSONS_ID").focus();
			return false;
			}
			if($("#LEAVECAUSE").val()==""){
				$("#LEAVECAUSE").tips({
					side:3,
		            msg:'请输入备注4',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LEAVECAUSE").focus();
			return false;
			}
			if($("#LEAVEDATE").val()==""){
				$("#LEAVEDATE").tips({
					side:3,
		            msg:'请输入备注5',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LEAVEDATE").focus();
			return false;
			}
			if($("#CREATEBY").val()==""){
				$("#CREATEBY").tips({
					side:3,
		            msg:'请输入备注6',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CREATEBY").focus();
			return false;
			}
			if($("#CREATEDATE").val()==""){
				$("#CREATEDATE").tips({
					side:3,
		            msg:'请输入备注7',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CREATEDATE").focus();
			return false;
			}
			if($("#MODIFYBY").val()==""){
				$("#MODIFYBY").tips({
					side:3,
		            msg:'请输入备注8',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MODIFYBY").focus();
			return false;
			}
			if($("#MODIFYDATE").val()==""){
				$("#MODIFYDATE").tips({
					side:3,
		            msg:'请输入备注9',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MODIFYDATE").focus();
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