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
					
					<form action="score/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="SCORE_ID" id="SCORE_ID" value="${pd.SCORE_ID}"/>
						<input type="hidden" name="STUDENT_ID" id="STUDENT_ID" value="${pd.STUDENT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">兑换者:</td>
								<td><input type="text" name="STUDENT_NAME" id="STUDENT_NAME" value="${pd.STUDENT_NAME}" maxlength="32" placeholder="这里输入兑换者" title="兑换者" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">礼物名称:</td>
								<td><input type="text" name="SCORE_GIFTNAME" id="SCORE_GIFTNAME" value="${pd.SCORE_GIFTNAME}" maxlength="32" placeholder="这里输入礼物名称" title="礼物名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">兑换时间:</td>
								<td><input class="span10 date-picker" name="SCORE_EXCTIME" id="SCORE_EXCTIME" value="${pd.SCORE_EXCTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="兑换时间" title="兑换时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">消耗积分值:</td>
								<td><input type="number" name="SCORE_EXPENDS" id="SCORE_EXPENDS" value="${pd.SCORE_EXPENDS}" maxlength="32" placeholder="这里输入消耗积分值" title="消耗积分值" style="width:98%;"/></td>
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
			if($("#SCORE_GIFTNAME").val()==""){
				$("#SCORE_GIFTNAME").tips({
					side:3,
		            msg:'请输入礼物名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCORE_GIFTNAME").focus();
			return false;
			}
			if($("#SCORE_EXCTIME").val()==""){
				$("#SCORE_EXCTIME").tips({
					side:3,
		            msg:'请输入兑换时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCORE_EXCTIME").focus();
			return false;
			}
			if($("#SCORE_EXPENDS").val()==""){
				$("#SCORE_EXPENDS").tips({
					side:3,
		            msg:'请输入消耗积分值',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCORE_EXPENDS").focus();
			return false;
			}
			if($("#STUDENT_ID").val()==""){
				$("#STUDENT_ID").tips({
					side:3,
		            msg:'请输入兑换者',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STUDENT_ID").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			$("#STUDENT_NAME").click(function(){//查找兑换礼物的学生
				top.jzts();
				 var diag = new top.Dialog();
				 diag.Drag=true;
				 diag.Title ="新增";
				 diag.URL = '<%=basePath%>student/list.do?is_show=search_student';
				 diag.Width = 950;
				 diag.Height = 1500;
				 diag.Modal = true;				//有无遮罩窗口
				 diag. ShowMaxButton = true;	//最大化按钮
			     diag.ShowMinButton = true;		//最小化按钮
				 diag.CancelEvent = function(){ //关闭事件
			    	 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
						 if('${page.currentPage}' == '0'){
							 top.jzts();
							 setTimeout("self.location=self.location",100);
							// $("#Form").submit();
						 }else{
							 nextPage(${page.currentPage});
						 }
					}
			    	$("#STUDENT_ID").val(diag.innerFrame.contentWindow.document.getElementById('stu').value);
			    	$("#STUDENT_NAME").val(diag.innerFrame.contentWindow.document.getElementById('stuName').value);
					diag.close();
				 };
				// top.Dialog.close();//关闭当前窗口
				 diag.show();
			});
			
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>