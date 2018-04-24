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
	<!-- <link rel="stylesheet" href="static/ace/css/datepicker.css" /> -->
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
					
					<form action="ability/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ABILITY_ID" id="ABILITY_ID" value="${pd.ABILITY_ID}"/>
						<input type="hidden" name="STUDENT_ID" id="STUDENT_ID" value="${pd.STUDENT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"  class="bitianxiang">能力类型:</td>
								<td>
									<select name="ABILITY_TYPE_ID" id="ABILITY_TYPE_ID">
										<option value="0">请选择</option>
										<c:forEach items="${abilityList }" var="abi">
											<option value="${abi.DICTIONARIES_ID }" <c:if test="${abi.DICTIONARIES_ID==pd.ABILITY_TYPE_ID }">selected</c:if>>${abi.NAME }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;"  class="bitianxiang">学生姓名:</td>
								<td><input type="text" value="${pd.stuName.STUDENT_NAME}" maxlength="32" readonly="readonly" placeholder="" title="学生姓名" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">科目名称:</td>
								<td>
									<select name="SUBJECT_ID" id="SUBJECT_ID">
										<option value="0">请选择</option>
										<c:forEach items="${list }" var="l">
											<option value="${l.SUBJECT_ID }" <c:if test="${l.SUBJECT_ID==pd.SUBJECT_ID }">selected</c:if>>${l.SUBJECT_NAME }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">记录内容:</td>
								<td><input type="text" name="COURSE_CONTENT" id="COURSE_CONTENT" value="${pd.COURSE_CONTENT}" maxlength="100" placeholder="这里输入记录内容" title="记录内容" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">积分值:</td>
								<td><input type="number" name="SCORE_VALUE" id="SCORE_VALUE" value="${pd.SCORE_VALUE}" maxlength="6" placeholder="这里输入积分值" title="积分值" style="width:98%;" min="0"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">能力值:</td>
								<td><input type="number" name="ABILITY_VALUE" id="ABILITY_VALUE" value="${pd.ABILITY_VALUE}" maxlength="6" placeholder="这里输入能力值" title="能力值" style="width:98%;"  min="0"/></td>
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
<!-- 	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script> -->
<script type="text/javascript" src="static/js/layer/layer.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	
	
	<script type="text/javascript" src="static/ace/js/laydate/laydate.js"></script>
		<script>
			//执行一个laydate实例
			laydate.render({
				elem : '#COURSE_TIME'
				,type: 'datetime'
					,theme: '#76ACCD'
			});
		</script>
		<script>
		$(top.hangge());
		//保存
		function save(){
		
			if($("#ABILITY_TYPE_ID").val()=="0"){
				$("#ABILITY_TYPE_ID").tips({
					side:3,
		            msg:'请选择能力类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ABILITY_TYPE_ID").focus();
			return false;
			
			}
			if($("#SUBJECT_ID").val()=="0"){
				$("#SUBJECT_ID").tips({
					side:3,
		            msg:'请选择课程名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SUBJECT_ID").focus();
			return false;
			}
			if($("#COURSE_CONTENT").val()==""){
				$("#COURSE_CONTENT").tips({
					side:3,
		            msg:'请输入记录内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COURSE_CONTENT").focus();
			return false;
			}
			if($("#SCORE_VALUE").val()==""){
				$("#SCORE_VALUE").tips({
					side:3,
		            msg:'请输入积分值',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCORE_VALUE").focus();
			return false;
			}
			if($("#ABILITY_VALUE").val()==""){
				$("#ABILITY_VALUE").tips({
					side:3,
		            msg:'请输入能力值',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ABILITY_VALUE").focus();
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
		
		
</body>
</html>