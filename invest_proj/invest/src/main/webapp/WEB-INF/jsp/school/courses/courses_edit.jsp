<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
<!-- Tab切换的样式 -->
<style type="text/css">
.mytab {
	border: 0;
	width: 90pt;
	height: 28px;
	line-height: 28px;
	background-color: #eef0ee;
	white-space: nowrap;
	z-index: 101;
	outline: 0;
}

.active {
	background-color: #438eb9;
	color: #fff;
}
</style>
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container" >
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">

							<form action="courses/${msg }.do" name="Form" id="Form"
								method="post">
								<input type="hidden" name="COURSES_ID" id="COURSES_ID"
									value="${pd.courses_id}" />
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;"
												class="bitianxiang">课程名称:</td>
											<td><input type="text" name="COURSES_NAME"
												id="COURSES_NAME" value="${pd.courses_name}" maxlength="100"
												placeholder="这里输入课程名称" title="课程名称" style="width: 98%;" /></td>
										</tr>
										<%-- <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">科目:</td>
								<td>
									<select name="SUBJECT_ID" id="SUBJECT_ID">
										<option value="">请选择</option>
										<c:forEach items="${SUBJECT_LIST }" var="SUB">
											<option value="${SUB.SUBJECT_ID }" <c:if test="${pd.subject_id==SUB.SUBJECT_ID }">selected</c:if>>${SUB.SUBJECT_NAME }</option>
										</c:forEach>
									</select>
								</td>
							</tr> --%>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;"
												class="bitianxiang">开始时间:</td>
											<td><input class="span10 date-picker"
												name="ARRANGE_STARTTIME" id="ARRANGE_STARTTIME"
												value="${pd.arrange_starttime}" type="text"
												data-date-format="yyyy-mm-dd" readonly="readonly"
												placeholder="开始时间" title="开始时间" style="width: 98%;" /></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;"
												class="bitianxiang">结束时间:</td>
											<td><input class="span10 date-picker"
												name="ARRANGE_ENDTIME" id="ARRANGE_ENDTIME"
												value="${pd.arrange_endtime}" type="text"
												data-date-format="yyyy-mm-dd" readonly="readonly"
												placeholder="结束时间" title="结束时间" style="width: 98%;" /></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;"
												class="bitianxiang">课程状态:</td>
											<td><select name="COURSE_STATUS" id="COURSE_STATUS">
													<option value="">请选择</option>
													<c:forEach items="${STATUS_LIST }" var="STA">
														<option value="${STA.DICTIONARIES_ID }"
															<c:if test="${pd.course_status == STA.DICTIONARIES_ID }">selected</c:if>>${STA.NAME }</option>
													</c:forEach>
											</select></td>
										</tr>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;"
												class="bitianxiang">是否审核:</td>
											<td><input type="radio" name="rd" id="aud"
												checked="checked">审核人 <input type="radio" name="rd"
												id="aus">无审核人</td>
										</tr>

										<tr id="auditors">
											
										</tr>

										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">备注:</td>
											<td><input type="text" name="COURSES_REMARK"
												id="COURSES_REMARK" value="${pd.courses_remark}"
												maxlength="100" placeholder="这里输入备注" title="备注"
												style="width: 98%;" /></td>
										</tr>

										<tr>
											<td style="text-align: center;" colspan="10"><a
												class="btn btn-mini btn-primary" onclick="save();">保存</a> <a
												class="btn btn-mini btn-danger"
												onclick="top.Dialog.close();">取消</a></td>
										</tr>
									</table>
								</div>
								<div id="zhongxin2" class="center" style="display: none">
									<br />
									<br />
									<br />
									<br />
									<br />
									<img src="static/images/jiazai.gif" /><br />
									<h4 class="lighter block green">提交中...</h4>
								</div>
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
	<!-- tab 切换选项卡 -->
	<c:if test="${pd.courses_id!=null}">
		<div
			style="height: 29px; width: 98%; margin: 0px auto; border-bottom: 1px solid #4F99C6; padding-left: 5px;">
			<button class="mytab active"
				onclick="javascript:mytab.active(this,mytab.courseStudent);">此课程的学生</button>
			<button class="mytab"
				onclick="mytab.active(this,mytab.courseTeacher);">此课程的老师</button>
			<button class="mytab"
				onclick="mytab.active(this,mytab.courseSubject);">此课程的科目</button>
			<button class="mytab"
				onclick="mytab.active(this,mytab.courseLesson);">此课程的课表</button>
		</div>
		<iframe id="myFrame" name="myFrame" frameBorder=0 scrolling=no
			width="100%" height="100%" onLoad="iFrameHeight()" src=""></iframe>
	</c:if>

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
		laydate.render({
			elem : '#ARRANGE_STARTTIME'
			,type: 'datetime'
				,theme: '#76ACCD'
				})
		laydate.render({
			elem : '#ARRANGE_ENDTIME'
			,type: 'datetime'
				,theme: '#76ACCD'
				})
		</script>
	<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#COURSES_NAME").val()==""){
				$("#COURSES_NAME").tips({
					side:3,
		            msg:'请输入课程名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COURSES_NAME").focus();
			return false;
			}
			if($("#ARRANGE_STARTTIME").val()==""){
				$("#ARRANGE_STARTTIME").tips({
					side:3,
		            msg:'请输入开始时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ARRANGE_STARTTIME").focus();
			return false;
			}
			if($("#ARRANGE_ENDTIME").val()==""){
				$("#ARRANGE_ENDTIME").tips({
					side:3,
		            msg:'请输入结束时间',
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
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		
		//页面tab初始化
		$(document).ready(function(){
			$(".active").click();
		});
		var mytab = {
				courseStudent:"<%=basePath%>arrange/list.do?COURSES_ID=${pd.courses_id}",
				courseTeacher:"<%=basePath%>courses_teacher/list.do?COURSES_ID=${pd.courses_id}",
				courseSubject:"<%=basePath%>courses_subject/list.do?COURSES_ID=${pd.courses_id}",
				courseLesson:"<%=basePath%>schedule/list.do?COURSES_ID=${pd.courses_id}",
				active:function(dom,param){
					if(!dom||!param||$.trim(param)==""){
						return;
					}
					$("#myFrame").prop("src",param);
					$(".active").removeClass("active");
					$(dom).addClass("active");
				}
		};
		
		/**iframe高度根据内容自适应*/
		function iFrameHeight() { 
			var ifm= document.getElementById("myFrame"); 
			var subWeb = document.frames ? document.frames["myFrame"].document : ifm.contentDocument; 
			if(ifm != null && subWeb != null) { 
				ifm.height = subWeb.body.scrollHeight; 
			} 
		};
		/* 有无审核人判断 */
	 	
		$(function(){
			var option=`<td
				style="width: 75px; text-align: right; padding-top: 13px;"
				class="bitianxiang">审核人:</td>
			<td><select name="user_id" id="user_id">
					<c:forEach items="${userList}" var="user">

						<option value="${user.USER_ID}"
							<c:if test="${user.USER_ID==pd.user_id}">selected</c:if>>${user.NAME}</option>
					</c:forEach>
			</select></td>`
		$("#auditors").append(option);
			
		})
		$("#aud").click(function(){
			$("#auditors").html('');
			var option=`<td
				style="width: 75px; text-align: right; padding-top: 13px;"
				class="bitianxiang">审核人:</td>
			<td><select name="user_id" id="user_id">
					<c:forEach items="${userList}" var="user">

						<option value="${user.USER_ID}"
							<c:if test="${user.USER_ID==pd.user_id}">selected</c:if>>${user.NAME}</option>
					</c:forEach>
			</select></td>`
				$("#auditors").append(option);
		
			
		})
		$("#aus").click(function(){
			$("#auditors").html('');
			var option=`<td>
				<input type="text" name="user_id" style="display: none;"/>
			</td>`;
			$("#auditors").append(option);
			
		}) 
		
		</script>
</body>
</html>