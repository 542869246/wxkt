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
					
					<form action="evaluate/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="EVALUATE_ID" id="EVALUATE_ID" value="${pd.EVALUATE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">评价id:</td>
								<td><input type="text" name="EVALUATE_ID" id="EVALUATE_ID" value="${pd.EVALUATE_ID}" maxlength="100" placeholder="这里输入评价id" title="评价id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">学生id:</td>
								<td><input type="text" name="STUDENT_ID" id="STUDENT_ID" value="${pd.STUDENT_ID}" maxlength="100" placeholder="这里输入学生id" title="学生id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">schedule的id:</td>
								<td><input type="text" name="LESSONS_ID" id="LESSONS_ID" value="${pd.LESSONS_ID}" maxlength="100" placeholder="这里输入schedule的id" title="schedule的id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">评价内容:</td>
								<td><input type="text" name="EVALUATE_CONTENT" id="EVALUATE_CONTENT" value="${pd.EVALUATE_CONTENT}" maxlength="30" placeholder="这里输入评价内容" title="评价内容" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">评价时间:</td>
								<td><input class="span10 date-picker" name="EVALUATEDATE" id="EVALUATEDATE" value="${pd.EVALUATEDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="评价时间" title="评价时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">创建人:</td>
								<td><input type="text" name="CREATEBY" id="CREATEBY" value="${pd.CREATEBY}" maxlength="32" placeholder="这里输入创建人" title="创建人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">创建时间:</td>
								<td><input class="span10 date-picker" name="CREATEDATE" id="CREATEDATE" value="${pd.CREATEDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="创建时间" title="创建时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">修改人:</td>
								<td><input type="text" name="MODIFYBY" id="MODIFYBY" value="${pd.MODIFYBY}" maxlength="32" placeholder="这里输入修改人" title="修改人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">修改时间:</td>
								<td><input class="span10 date-picker" name="MODIFYDATE" id="MODIFYDATE" value="${pd.MODIFYDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="修改时间" title="修改时间" style="width:98%;"/></td>
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
			if($("#EVALUATE_ID").val()==""){
				$("#EVALUATE_ID").tips({
					side:3,
		            msg:'请输入评价id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EVALUATE_ID").focus();
			return false;
			}
			if($("#STUDENT_ID").val()==""){
				$("#STUDENT_ID").tips({
					side:3,
		            msg:'请输入学生id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STUDENT_ID").focus();
			return false;
			}
			if($("#LESSONS_ID").val()==""){
				$("#LESSONS_ID").tips({
					side:3,
		            msg:'请输入schedule的id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LESSONS_ID").focus();
			return false;
			}
			if($("#EVALUATE_CONTENT").val()==""){
				$("#EVALUATE_CONTENT").tips({
					side:3,
		            msg:'请输入评价内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EVALUATE_CONTENT").focus();
			return false;
			}
			if($("#EVALUATEDATE").val()==""){
				$("#EVALUATEDATE").tips({
					side:3,
		            msg:'请输入评价时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EVALUATEDATE").focus();
			return false;
			}
			if($("#CREATEBY").val()==""){
				$("#CREATEBY").tips({
					side:3,
		            msg:'请输入创建人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CREATEBY").focus();
			return false;
			}
			if($("#CREATEDATE").val()==""){
				$("#CREATEDATE").tips({
					side:3,
		            msg:'请输入创建时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CREATEDATE").focus();
			return false;
			}
			if($("#MODIFYBY").val()==""){
				$("#MODIFYBY").tips({
					side:3,
		            msg:'请输入修改人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MODIFYBY").focus();
			return false;
			}
			if($("#MODIFYDATE").val()==""){
				$("#MODIFYDATE").tips({
					side:3,
		            msg:'请输入修改时间',
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