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
					
					<form action="takein/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="TAKEIN_ID" id="TAKEIN_ID" value="${pd.TAKEIN_ID}"/>
						<%-- <input type="hidden" name="USERS_ID" id="USERS_ID" value="${pd.USERS_ID}"/> --%>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">是否确定参加:</td>
								<td>
									<select name="IS_TAKEIN" id="USERS_ISMEMBER">
										<option value="0" <c:if test="${pd.IS_TAKEIN==0 }">selected</c:if> >待定</option>
										<option value="1" <c:if test="${pd.IS_TAKEIN==1 }">selected</c:if> >是</option>
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
			
			
			
			/* if($("#USERS_NAME").val()==""){
				$("#USERS_NAME").tips({
					side:3,
		            msg:'请输入用户姓名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USERS_ID").focus();
			return false;
			} */
			if($("#ACTIVITY_ID").val()==""){
				$("#ACTIVITY_ID").tips({
					side:3,
		            msg:'请输入活动标题',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ACTIVITY_ID").focus();
			return false;
			}
			if($("#IS_TAKEIN").val()==""){
				$("#IS_TAKEIN").tips({
					side:3,
		            msg:'请输入是否确定参加',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IS_TAKEIN").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			//console.log('takein_edit:',$("#ACTIVITY_ID").val())
		});
		</script>
</body>
</html>