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
					
					<form action="invest/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="INVEST_ID" id="INVEST_ID" value="${pd.INVEST_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">关联ID:</td>
								<td><input type="text" name="INVEST_ID" id="INVEST_ID" value="${pd.INVEST_ID}" maxlength="40" placeholder="这里输入关联ID" title="关联ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">关联的用户:</td>
								<td><input type="text" name="INVEST_USER_ID" id="INVEST_USER_ID" value="${pd.INVEST_USER_ID}" maxlength="40" placeholder="这里输入关联的用户" title="关联的用户" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">关联的产品:</td>
								<td><input type="text" name="INVEST_PRODICTS_ID" id="INVEST_PRODICTS_ID" value="${pd.INVEST_PRODICTS_ID}" maxlength="40" placeholder="这里输入关联的产品" title="关联的产品" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">创建时间:</td>
								<td><input class="span10 date-picker" name="INVEST_CREATETIME" id="INVEST_CREATETIME" value="${pd.INVEST_CREATETIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="创建时间" title="创建时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">创建人:</td>
								<td><input type="text" name="INVEST_CREATEBY" id="INVEST_CREATEBY" value="${pd.INVEST_CREATEBY}" maxlength="20" placeholder="这里输入创建人" title="创建人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注6:</td>
								<td><input type="text" name="INVEST_DICTIONARIESID" id="INVEST_DICTIONARIESID" value="${pd.INVEST_DICTIONARIESID}" maxlength="40" placeholder="这里输入备注6" title="备注6" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注7:</td>
								<td><input type="number" name="INVEST_STATE" id="INVEST_STATE" value="${pd.INVEST_STATE}" maxlength="32" placeholder="这里输入备注7" title="备注7" style="width:98%;"/></td>
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
			if($("#INVEST_ID").val()==""){
				$("#INVEST_ID").tips({
					side:3,
		            msg:'请输入关联ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVEST_ID").focus();
			return false;
			}
			if($("#INVEST_USER_ID").val()==""){
				$("#INVEST_USER_ID").tips({
					side:3,
		            msg:'请输入关联的用户',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVEST_USER_ID").focus();
			return false;
			}
			if($("#INVEST_PRODICTS_ID").val()==""){
				$("#INVEST_PRODICTS_ID").tips({
					side:3,
		            msg:'请输入关联的产品',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVEST_PRODICTS_ID").focus();
			return false;
			}
			if($("#INVEST_CREATETIME").val()==""){
				$("#INVEST_CREATETIME").tips({
					side:3,
		            msg:'请输入创建时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVEST_CREATETIME").focus();
			return false;
			}
			if($("#INVEST_CREATEBY").val()==""){
				$("#INVEST_CREATEBY").tips({
					side:3,
		            msg:'请输入创建人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVEST_CREATEBY").focus();
			return false;
			}
			if($("#INVEST_DICTIONARIESID").val()==""){
				$("#INVEST_DICTIONARIESID").tips({
					side:3,
		            msg:'请输入备注6',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVEST_DICTIONARIESID").focus();
			return false;
			}
			if($("#INVEST_STATE").val()==""){
				$("#INVEST_STATE").tips({
					side:3,
		            msg:'请输入备注7',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVEST_STATE").focus();
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