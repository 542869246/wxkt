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
					
					<form action="webschedule/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="stuList" id="stuList" value="${pd.stuList}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">作业类型:</td>
								<td>
									<select name="SCHEDULE_TASKTYPE" id="SCHEDULE_TASKTYPE">
										<option value="">请选择</option>
										<c:forEach items="${schList }" var="sch">
											<option value="${sch.DICTIONARIES_ID }">${sch.NAME }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">课后评价时间:</td>
								<td><input class="span10 date-picker" name="SCHEDULE_DATETIME" id="SCHEDULE_DATETIME" value="${pd.SCHEDULE_DATETIME}" type="text" data-date-format="yyyy-mm-dd hh:mm:ss" readonly="readonly" placeholder="课后评价时间" title="课后评价时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">下一步</a>
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
	<!-- <script src="static/ace/js/date-time/bootstrap-datepicker.js"></script> -->
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#SCHEDULE_TASKTYPE").val()==""){
				$("#SCHEDULE_TASKTYPE").tips({
					side:3,
		            msg:'请输入作业类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCHEDULE_TASKTYPE").focus();
			return false;
			}
			if($("#SCHEDULE_DATETIME").val()==""){
				$("#SCHEDULE_DATETIME").tips({
					side:3,
		            msg:'请输入课后评价时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCHEDULE_DATETIME").focus();
			return false;
			}
			//Ajax批量保存
			$.ajax({
				type: "POST",
				url: '<%=basePath%>webschedule/addAll.do?tm='+new Date().getTime(),
		    	data: {stuList:$("#stuList").val(),SCHEDULE_TASKTYPE:$("#SCHEDULE_TASKTYPE").val(),SCHEDULE_DATETIME:$("#SCHEDULE_DATETIME").val()},
				//beforeSend: validateData,
				cache: false,
				success: function(data){
					//再次弹窗找到学习内容的页面
								top.jzts();
								 var diag = new top.Dialog();
								 diag.Drag=true;
								 diag.Title ="新增";
								 diag.URL = '<%=basePath%>study/list.do?scheduleList='+data;
								 diag.Width = 1150;
								 diag.Height = 955;
								 diag.Modal = true;				//有无遮罩窗口
								 diag. ShowMaxButton = true;	//最大化按钮
							     diag.ShowMinButton = true;		//最小化按钮
								 diag.CancelEvent = function(){ //关闭事件
							    	 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
										  if('${page.currentPage}' == '0'){
											  top.jzts();
										 }else{
											 nextPage(${page.currentPage});
										 }
									} 
								 //关闭   打开新增学习内容窗口时  发生的事件
								 //      如果新增学习内容为0时  就把此批量录入订单给删除
									<%-- if(diag.innerFrame.contentWindow.document.getElementById('studySize').value=='0'){
										$.ajax({
											type: "POST",
											url: '<%=basePath%>webschedule/deleteAll.do',
									    	data: {DATA_IDS:data},
									    	success:function(){
									    	}
										});
									} --%>
									diag.close();
									top.Dialog.close();//关闭当前窗口
							     }
					 diag.show();
				}
			});
			
			
			//$("#zhongxin").hide();
			
			// $("#Form").submit();
			//$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
		<script type="text/javascript" src="static/ace/js/laydate/laydate.js"></script>
		<script type="text/javascript">
		//执行一个laydate实例
			laydate.render({
				elem : '#SCHEDULE_DATETIME'
				,type: 'datetime'
					,theme: '#76ACCD'
			});
		</script>
</body>
</html>