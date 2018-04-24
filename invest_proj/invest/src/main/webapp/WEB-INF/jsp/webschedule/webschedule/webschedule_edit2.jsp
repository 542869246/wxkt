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
					
					<form action="webschedule/addAll.do" name="Form" id="Form" method="post">
						<input type="hidden" name="stuList" id="stuList" value="${pd.stuList}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">课后评价时间:</td>
								<td><input class="span10 date-picker" name="SCHEDULE_DATETIME" id="SCHEDULE_DATETIME" value="${pd.SCHEDULE_DATETIME}" type="text" data-date-format="yyyy-mm-dd hh:mm:ss" readonly="readonly" placeholder="课后评价时间" title="课后评价时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">作业类型:</td>
								<td>
									<select name="SCHEDULE_TASKTYPE" id="SCHEDULE_TASKTYPE" onchange='btnChange(this[selectedIndex].value,this[selectedIndex].text);'>
										<option value="">请选择</option>
										<c:forEach items="${schList }" var="sch">
											<option value="${sch.BIANMA }">${sch.NAME }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<c:if test="${pd.COURSES_ID==null || pd.COURSES_ID==''  }">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">选择课程:</td>
								<td>
									<select id="COURSES_ID" name="COURSES_ID"  onchange="changecourse(this.value)">
										<option value="">--请选择--</option>
										<c:forEach items="${courseslist }" var="course">
											<option value="${course.COURSE_ID }" <c:if test="${course.COURSES_ID==pd.COURSES_ID }">selected</c:if>>${course.COURSES_NAME }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							</c:if>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">选择科目:</td>
								<td>
									<select id="SUBJECT_ID" name="SUBJECT_ID">
										<option value="">--请选择--</option>
										<c:forEach items="${subjectList }" var="sub">
											<option value="${sub.SUBJECT_ID }" <c:if test="${sub.SUBJECT_ID==pd.SUBJECT_ID }">selected</c:if>>${sub.SUBJECT_NAME }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="ARRIVELEAVETIMEText" id="ARRIVELEAVETIMEText">到达时间:</td>
								<td><input class="span10 date-picker1" name="ARRIVELEAVETIME" id="ARRIVELEAVETIME" value="${pd.ARRIVELEAVETIME}" type="text" data-date-format="yyyy-mm-dd hh:mm:ss" readonly="readonly" placeholder="课后评价时间" title="课后评价时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">学习时长:</td>
								<td><input type="text" value="${pd.SCHEDULE_TIMEDIFF}" maxlength="32"  placeholder="" title="学习时长" style="width:98%;" id="SCHEDULE_TIMEDIFF" name="SCHEDULE_TIMEDIFF"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">学习内容:</td>
								<td><input type="text" value="${pd.SCHEDULE_CONTENT}" maxlength="32"  placeholder="" title="学习时长" style="width:98%;" id="SCHEDULE_CONTENT" name="SCHEDULE_CONTENT"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">是否达标:</td>
								<td>
									<select name="SCHEDULE_ADOPT" id="SCHEDULE_ADOPT">
										<option value="">请选择</option>
											<option value="0"<c:if test="${pd.SCHEDULE_ADOPT==0}">selected="selected"</c:if>>达标</option>
											<option value="1"<c:if test="${pd.SCHEDULE_ADOPT==0}">selected="selected"</c:if>>不达标</option>
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
	<!-- <script src="static/ace/js/date-time/bootstrap-datepicker.js"></script> -->
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		function init(){
			$("#SCHEDULE_ADOPT").parent().parent().hide();
			$("#ARRIVELEAVETIMEText").parent().hide();
			$("#SCHEDULE_TIMEDIFF").parent().parent().hide();
			$("#SCHEDULE_CONTENT").parent().parent().hide();
			$("#SUBJECT_ID").parent().parent().hide();
			//评论日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			//到达时间
			$('.date-picker1').datepicker({autoclose: true,todayHighlight: true});
		}
		function btnChange(values,showName){
			$("#SCHEDULE_ADOPT").parent().parent().hide();
			$("#ARRIVELEAVETIMEText").parent().hide();
			$("#SCHEDULE_TIMEDIFF").parent().parent().hide();
			$("#SCHEDULE_CONTENT").parent().parent().hide();
			$("#SUBJECT_ID").parent().parent().hide();
			$("#SUBEJCT_ID").val("");
			$("#ARRIVELEAVETIME").val("");
			$("#SCHEDULE_ADOPT").val("");
			$("#SCHEDULE_TIMEDIFF").val("");
			$("#SCHEDULE_CONTENT").val("");

			if(values=="zylr"){//作业录入
				$("#SCHEDULE_TIMEDIFF").parent().parent().show();
				$("#SCHEDULE_CONTENT").parent().parent().show();
				$("#SUBJECT_ID").parent().parent().show();
			}else if(values=="zyys"){//作业验收
				$("#SCHEDULE_ADOPT").parent().parent().show();
				$("#SCHEDULE_TIMEDIFF").parent().parent().show();
				$("#SUBJECT_ID").parent().parent().show();
				$("#SCHEDULE_CONTENT").parent().parent().show();
			}else if(values=="dzsj" ||values=="lksj"){//到达时间和离开时间
				alert(3);
				var currentTime =new Date().Format("yyyy-MM-dd HH:mm");
				$("#ARRIVELEAVETIME").val(currentTime);
				$(".ARRIVELEAVETIMEText").text(showName);
				$("#ARRIVELEAVETIMEText").parent().show();
			}else{
				$("#SCHEDULE_CONTENT").parent().parent().show();
			}
		}
		$(top.hangge()); 
		
		
		//选择课程后发生的事件
		function changecourse(c){
			$.ajax({
				url:'<%=basePath%>courses_subject/listAll.do',
				data:{"COURSES_ID":c},
				type:"POST",
				success:function(data){
					$("#SUBJECT_ID").html("");
					var str="<option value=''>--请选择--</option>";
					$.each(data,function(index,s){
						str+="<option value='"+s.SUBJECT_ID+"'>"+s.SUBJECT_NAME+"</option>";
					});
					$("#SUBJECT_ID").html(str);
				}
			});
		}
		
		//保存
		function save(){
			var SCHEDULE_TASKTYPE = $.trim($("#SCHEDULE_TASKTYPE").val());
			if($("#STUDENT_ID").val()==""){
				$("#STUDENT_ID").tips({
					side:3,
		            msg:'请输入学生',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STUDENT_ID").focus();
			return false;
			}
			var SCHEDULE_TIMEDIFF = $.trim($("#SCHEDULE_TIMEDIFF").val());
			var SCHEDULE_CONTENT = $.trim($("#SCHEDULE_CONTENT").val());
			var SUBJECT_ID = $("#SUBJECT_ID").val();
			var SCHEDULR_INPUTTIME = $.trim($("#SCHEDULR_INPUTTIME").val());
			var ARRIVELEAVETIME = $.trim($("#ARRIVELEAVETIME").val());//到达时间
			/* var typeName="";
			<c:forEach items="${schList}" var="sch">
			if('${sch.DICTIONARIES_ID }'==SCHEDULE_TASKTYPE){
				typeName='${sch.NAME}';
			}  
			</c:forEach>*/
			var CREATEBY = $.trim($("#teaid").val());
			var SCHEDULE_ADOPT = $.trim($("#SCHEDULE_ADOPT").val());
			var coursesel = $.trim($("#coursesel").val());
		//	alert(SCHEDULE_TIMEDIFF+"  "+SCHEDULE_CONTENT+"  "+SCHEDULR_INPUTTIME+"  "+SCHEDULE_TASKTYPE+"  "+SCHEDULE_ADOPT+"  1")
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
			if(SCHEDULE_TASKTYPE==""){
				$("#SCHEDULE_TASKTYPE").tips({
					side:3,
		            msg:'请输入作业类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCHEDULE_TASKTYPE").focus();
			return false;
			}
			if(SCHEDULE_TASKTYPE=="zylr"){
				if(SUBJECT_ID==""){
					$("#SUBJECT_ID").tips({
						side:3,
			            msg:'请选择科目',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#SUBJECT_ID").focus();
					return false;
				}
				if(SCHEDULE_TIMEDIFF==""){
					$("#SCHEDULE_TIMEDIFF").tips({
						side:3,
			            msg:'请输入学习时长',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#SCHEDULE_TIMEDIFF").focus();
					return false;
				}
				if(SCHEDULE_CONTENT==""){
					$("#SCHEDULE_CONTENT").tips({
						side:3,
			            msg:'请输入学习内容',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#SCHEDULE_CONTENT").focus();
					return false;
				}
			}
			if(SCHEDULE_TASKTYPE=="zyys"){
				if(SUBJECT_ID==""){
					$("#SUBJECT_ID").tips({
						side:3,
			            msg:'请选择科目',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#SUBJECT_ID").focus();
					return false;
				}
				if(SCHEDULE_TIMEDIFF==""){
					$("#SCHEDULE_TIMEDIFF").tips({
						side:3,
			            msg:'请输入学习时长',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#SCHEDULE_TIMEDIFF").focus();
					return false;
				}
				if(SCHEDULE_CONTENT==""){
					$("#SCHEDULE_CONTENT").tips({
						side:3,
			            msg:'请输入学习内容',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#SCHEDULE_CONTENT").focus();
					return false;
				}
				if(SCHEDULE_ADOPT==""){
					$("#SCHEDULE_ADOPT").tips({
						side:3,
			            msg:'请选择是否达标',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#SCHEDULE_ADOPT").focus();
					return false;
				}
			}
			if(SCHEDULE_TASKTYPE=="3" || SCHEDULE_TASKTYPE=="4"){
				if(ARRIVELEAVETIME==""){
					$("#ARRIVELEAVETIME").tips({
						side:3,
			            msg:'请选择'+typeName,
			            bg:'#AE81FF',
			            time:2
			        });
					$("#ARRIVELEAVETIME").focus();
					return false;
				}
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			init();
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
			//执行一个laydate实例
			laydate.render({
				elem : '#ARRIVELEAVETIME'
				,type: 'datetime'
					,theme: '#76ACCD'
			});
			Date.prototype.Format = function (fmt) { //author: meizz   
				//var time2 = new Date().Format("yyyy-MM-dd HH:mm:ss");
		    var o = {  
		        "M+": this.getMonth() + 1, //月份   
		        "d+": this.getDate(), //日   
		        "H+": this.getHours(), //小时   
		        "m+": this.getMinutes(), //分   
		        "s+": this.getSeconds(), //秒   
		        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
		        "S": this.getMilliseconds() //毫秒   
		    };  
		    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
		    for (var k in o)  
		    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
		    return fmt;  
		}  
		</script>
</body>
</html>