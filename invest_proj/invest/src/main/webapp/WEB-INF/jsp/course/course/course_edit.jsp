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
					
					<form action="course/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="COURSE_ID" id="COURSE_ID" value="${pd.COURSE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主键:</td>
								<td><input type="text" name="COURSE_ID" id="COURSE_ID" value="${pd.COURSE_ID}" maxlength="32" placeholder="这里输入主键" title="主键" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">科目id:</td>
								<td><input type="text" name="SUBJECT_ID" id="SUBJECT_ID" value="${pd.SUBJECT_ID}" maxlength="32" placeholder="这里输入科目id" title="科目id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">起始时间:</td>
								<td><input class="span10 date-picker" name="ARRANGE_STARTTIME" id="ARRANGE_STARTTIME" value="${pd.ARRANGE_STARTTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="起始时间" title="起始时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">终止时间:</td>
								<td><input class="span10 date-picker" name="ARRANGE_ENDTIME" id="ARRANGE_ENDTIME" value="${pd.ARRANGE_ENDTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="终止时间" title="终止时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">课程状态:</td>
								<td><input type="number" name="COURSE_STATUS" id="COURSE_STATUS" value="${pd.COURSE_STATUS}" maxlength="32" placeholder="这里输入课程状态" title="课程状态" style="width:98%;"/></td>
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
			if($("#COURSE_ID").val()==""){
				$("#COURSE_ID").tips({
					side:3,
		            msg:'请输入主键',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COURSE_ID").focus();
			return false;
			}
			if($("#SUBJECT_ID").val()==""){
				$("#SUBJECT_ID").tips({
					side:3,
		            msg:'请输入科目id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SUBJECT_ID").focus();
			return false;
			}
			if($("#ARRANGE_STARTTIME").val()==""){
				$("#ARRANGE_STARTTIME").tips({
					side:3,
		            msg:'请输入起始时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ARRANGE_STARTTIME").focus();
			return false;
			}
			if($("#ARRANGE_ENDTIME").val()==""){
				$("#ARRANGE_ENDTIME").tips({
					side:3,
		            msg:'请输入终止时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ARRANGE_ENDTIME").focus();
			return false;
			}
			if($("#COURSE_STATUS").val()==""){
				$("#COURSE_STATUS").tips({
					side:3,
		            msg:'请输入课程状态',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COURSE_STATUS").focus();
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