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
					
					<form action="backstage/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="BACKSTAGE_ID" id="BACKSTAGE_ID" value="${pd.BACKSTAGE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:150px;text-align: right;padding-top: 13px;">亲加账号:</td>
								<td><input type="text" name="GOTYE_EMAIL" id="GOTYE_EMAIL" value="${pd.GOTYE_EMAIL}" maxlength="50" placeholder="这里输入账号" title="账号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">亲加密码:</td>
								<td><input type="text" name="GOTYE_PASSWORD" id="GOTYE_PASSWORD" value="${pd.GOTYE_PASSWORD}" maxlength="50" placeholder="这里输入密码" title="密码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">亲加access_secret:</td>
								<td><input type="text" name="GOTYE_ACCESS_SECRET" id="GOTYE_ACCESS_SECRET" value="${pd.GOTYE_ACCESS_SECRET}" maxlength="50" placeholder="这里输入access_secret" title="access_secret" style="width:98%;"/></td>
							</tr>
							<tr>
							<td style="width:75px;text-align: right;padding-top: 13px;">腾讯账号选择:</td>
								<td>
												<select name="TENCENTADMIN" id="TENCENTADMIN" onchange='btnChange(this[selectedIndex].value,this[selectedIndex].text);'>
													<option value="0">请选择</option>
													<c:forEach items="${diclist}" var="dic">
														<option value=${dic.BIANMA} <c:if test="${pd.TENCENTADMIN==dic.BIANMA}">selected="selected"</c:if>>${dic.NAME}</option>
													</c:forEach>
												</select>
											</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">腾讯推流防盗链Key:</td>
								<td><input type="text" name="TXSECRET" id="TXSECRET" value="${pd.TXSECRET}" maxlength="50" placeholder="这里输入腾讯推流防盗链Key" title="腾讯推流防盗链Key" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">腾讯直播bizid:</td>
								<td><input type="text" name="BIZID" id="BIZID" value="${pd.BIZID}" maxlength="50" placeholder="这里输入腾讯直播bizid" title="腾讯直播bizid" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">微信appid:</td>
								<td><input type="text" name="GOTYE_WX_APPID" id="GOTYE_WX_APPID" value="${pd.GOTYE_WX_APPID}" maxlength="50" placeholder="这里输入appid" title="appid" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">微信appsecret:</td>
								<td><input type="text" name="GOTYE_WX_SECRET" id="GOTYE_WX_SECRET" value="${pd.GOTYE_WX_SECRET}" maxlength="50" placeholder="这里输入appsecret" title="appsecret" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">阿里云短信appid:</td>
								<td><input type="text" name="ALI_DX_APPID" id="ALI_DX_APPID" value="${pd.ALI_DX_APPID}" maxlength="50" placeholder="这里输入阿里云短信账号" title="阿里云短信账号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">阿里云短信secret:</td>
								<td><input type="text" name="ALI_DX_SECRET" id="ALI_DX_SECRET" value="${pd.ALI_DX_SECRET}" maxlength="50" placeholder="这里输入阿里云短信密码" title="阿里云短信密码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">阿里云验证码短信模板号:</td>
								<td><input type="text" name="ALI_TECODE" id="ALI_TECODE" value="${pd.ALI_TECODE}" maxlength="50" placeholder="这里输入阿里云验证码短信模板号" title="阿里云验证码短信模板号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">阿里云老师短信模板号:</td>
								<td><input type="text" name="TEACHER_SMS" id="TEACHER_SMS" value="${pd.TEACHER_SMS}" maxlength="50" placeholder="这里输入阿里云老师短信模板号" title="阿里云老师短信模板号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">阿里云学生短信模板号:</td>
								<td><input type="text" name="STUDENT_SMS" id="STUDENT_SMS" value="${pd.STUDENT_SMS}" maxlength="50" placeholder="这里输入阿里云学生短信模板号" title="阿里云学生短信模板号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">阿里云短信签名名称:</td>
								<td><input type="text" name="ALI_SIGN_NAME" id="ALI_SIGN_NAME" value="${pd.ALI_SIGN_NAME}" maxlength="20" placeholder="这里输入阿里云短信签名名称" title="阿里云短信签名名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" class="bitianxiang">使用类型选择</td>
								<td><input type="radio" name="CHECK_TYPE" value="0" <c:if test="${pd.CHECK_TYPE==0 }">checked</c:if>>亲加直播 <input type="radio" name="CHECK_TYPE" value="1" <c:if test="${pd.CHECK_TYPE==1 }">checked</c:if>>腾讯直播</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发送课表的时间:</td>
								<td><input class="span10 date-picker checkTeacherAddClassroom"
												name="EMAIL_SCHEDULE_TIME" id="EMAIL_SCHEDULE_TIME"
												value="${pd.EMAIL_SCHEDULE_TIME}" type="text"
												data-date-format="HH:mm:ss" readonly="readonly"
												placeholder="发送课表的时间" title="发送课表的时间" style="width: 98%;" /></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发送未评价课程的时间:</td>
								<td>
									<input class="span10 date-picker checkTeacherAddClassroom"
												name="EMAIL_WEB_SCHEDULE_TIME" id="EMAIL_WEB_SCHEDULE_TIME"
												value="${pd.EMAIL_WEB_SCHEDULE_TIME}" type="text"
												data-date-format="HH:mm:ss" readonly="readonly"
												placeholder="发送未评价课程的时间" title="发送未评价课程的时间" style="width: 98%;" />
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">邮件发送/短信发送:</td>
								<td>
									<input type="checkbox" value="1" name="check_email_sms" <c:forEach items="${checkEmailSmsList}" var="email_sms"><c:if test="${email_sms eq 1 }">checked</c:if></c:forEach>/>邮箱
									<input type="checkbox" value="2" name="check_email_sms" <c:forEach items="${checkEmailSmsList}" var="email_sms"><c:if test="${email_sms eq 2 }">checked</c:if></c:forEach>/>短信
									<input type="hidden" name="CHECK_EMAIL_SMS" id="CHECK_EMAIL_SMS" />
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
			
			 var list= $('input:radio[name="CHECK_TYPE"]:checked').val();
				if(list!='${pd.CHECK_TYPE}'){//选择直播平台radio  变动时的操作
						$.ajax({
							url : '/invest/backstage/toUpdateAllType',
							type : 'POST',
							data : {
								'CHECK_TYPE' :list
							},
							dataType : 'json'
						});
				}
			
			if(list=="0"){  //当选择亲加时  判断亲加的三个非空
					if($("#GOTYE_EMAIL").val()==""){
					$("#GOTYE_EMAIL").tips({
						side:3,
			            msg:'请输入账号',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#GOTYE_EMAIL").focus();
				return false;
				}
				if($("#GOTYE_PASSWORD").val()==""){
					$("#GOTYE_PASSWORD").tips({
						side:3,
			            msg:'请输入密码',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#GOTYE_PASSWORD").focus();
				return false;
				}
				if($("#GOTYE_ACCESS_SECRET").val()==""){
					$("#GOTYE_ACCESS_SECRET").tips({
						side:3,
			            msg:'请输入access_secret',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#GOTYE_ACCESS_SECRET").focus();
				return false;
				}
			}else if(list=="1"){   //当选择腾讯时  判断腾讯的七个非空
				if($("#TENCENTADMIN").val()==0){
					$("#TENCENTADMIN").tips({
						side:3,
			            msg:'请选择腾讯账号',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#TENCENTADMIN").focus();
				return false;
				}
				if($("#TXSECRET").val()==""){
					$("#TXSECRET").tips({
						side:3,
			            msg:'请输入腾讯推流防盗链Key',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#TXSECRET").focus();
				return false;
				}
				if($("#BIZID").val()==""){
					$("#BIZID").tips({
						side:3,
			            msg:'请输入腾讯直播BIZID',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#BIZID").focus();
				return false;
				}
			}
			
			
			if($("#GOTYE_WX_APPID").val()==""){
				$("#GOTYE_WX_APPID").tips({
					side:3,
		            msg:'请输入appid',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#GOTYE_WX_APPID").focus();
			return false;
			}
			if($("#GOTYE_WX_SECRET").val()==""){
				$("#GOTYE_WX_SECRET").tips({
					side:3,
		            msg:'请输入appsecret',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#GOTYE_WX_SECRET").focus();
			return false;
			}
			if($("#ALI_DX_APPID").val()==""){
				$("#ALI_DX_APPID").tips({
					side:3,
		            msg:'请输入阿里云短信账号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ALI_DX_APPID").focus();
			return false;
			}
			if($("#ALI_DX_SECRET").val()==""){
				$("#ALI_DX_SECRET").tips({
					side:3,
		            msg:'请输入阿里云短信密码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ALI_DX_SECRET").focus();
			return false;
			}
			if($("#ALI_TECODE").val()==""){
				$("#ALI_TECODE").tips({
					side:3,
		            msg:'请输入阿里云短信模板号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ALI_TECODE").focus();
			return false;
			}
			if($("#ALI_SIGN_NAME").val()==""){
				$("#ALI_SIGN_NAME").tips({
					side:3,
		            msg:'请输入阿里云短信签名名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ALI_SIGN_NAME").focus();
			return false;
			}
			
			//循环获取选择的发送类型  拼接到字符串中
			var emailorsms="";
			var nodes=$("[name='check_email_sms']:checked");
			
			for(var i=0;i<nodes.length;i++){
				emailorsms+= nodes[i].value;
				if(i<nodes.length-1){
					emailorsms+=",";
				}
			}
			$("#CHECK_EMAIL_SMS").val(emailorsms);
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		function btnChange(value,text){
			if(value!=0){
				location.href="${pageContext.request.contextPath}/backstage/goEdit?TENCENTADMIN="+value;
			}
		}
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		
/* 		var email_sms= $("[name='CHECK_EMAIL_SMS'] :checked");
		if(email_sms.length>0){
			console.log(email_sms.eq(0).val());
		}
		 */
		
		</script>
		<script src="static/ace/js/laydate/laydate.js"></script>
		<script type="text/javascript">
			laydate.render({
				elem : '#EMAIL_SCHEDULE_TIME'
				,type: 'time'
					,theme: '#76ACCD'
				})
		</script>
		<script type="text/javascript">
			laydate.render({
				elem : '#EMAIL_WEB_SCHEDULE_TIME'
				,type: 'time'
					,theme: '#76ACCD'
				})
		</script>
</body>
</html>