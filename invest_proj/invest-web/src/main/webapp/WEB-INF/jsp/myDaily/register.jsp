<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
<link
	href="${pageContext.request.contextPath }/static/wx/css/mui.min.css"
	rel="stylesheet" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/wx/css/common.css" />
			
<script type="text/javascript"
	src="${pageContext.request.contextPath }/static/wx/js/jquery-1.11.3.min.js"></script>
 <script type="text/javascript"
	src="${pageContext.request.contextPath }/static/js/layout.js"></script>
<script src="static/js/basedao.js" type="text/javascript"
	charset="utf-8"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/css/paging.css" />
	<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/css/bc.css" /> 

<style type="text/css">
#code {
	width: 0.8rem;
	height: 0.8rem;
	position: absolute;
	right: 4.25rem;
	top: 0.30rem;
	display: block;
}
</style>
<title>用户注册</title>
</head>
<body >
	<div >
		<div class="forgot_password" style="position:absolute;top: 0;bottom: 0;left:0">
		
			<p style='margin-top:0px;'>
				<input type="text" id="username"  placeholder="请输入 用户昵称 (选填)"
						value="${sessionScope.snsUserInfo.nickname}"
					maxlength="11" name="phone" />
			</p>
		
			<p>
				<input type="hidden"  value="${sessionScope.snsUserInfo.openId}"  id="openid">
				<input type="text" id="phonetext" placeholder="请输入手机号"
					maxlength="11" name="phone"
					oninput="value=value.replace(/[^\d]/g,'')"
					onkeyup="value=value.replace(/[^\d]/g,'')"
					onkeydown="value=value.replace(/[^\d]/g,'')" /> 
			</p>
			
			
			
			<p>
				<input type="text" id="codetext" placeholder="请输入验证码" maxlength="11"
					name="code" style="width: 9.5rem" /> <a id="code"
					style="right: 3.8rem;"><img id="vcode" style="display: inline;"
					width="80" height="35"></a>
			</p>
			<p>
				<input type="text" id="phonecodetext" placeholder="请输入短信验证码"
					maxlength="11" name="dxyzm" /> <a class="getCode" id="sendsms">点击获取</a>
			</p>
			<a class="enter" id="reg" style="width: 14.75rem;">绑定</a>
		</div>
	</div>
	<script
		src="${pageContext.request.contextPath}/static/wx/js/Second menu.js"></script>
	<script
		src="${pageContext.request.contextPath }/static/wx/js/mui.min.js"></script>
	<script>
		//初始化
		$(document).ready(function() {
			getcode();
			var openid=$.trim($("#openid").val());
		});
		var time = 60;
		//给手机号输入框的焦点去除事件
		$("#phonetext").blur(function() {
			var phonetext = $.trim($("#phonetext").val());
			if (null != phonetext && "" != phonetext) {
				if (!checkMobile()) {
					return false;
				}
			}
		});
		//图片验证码的点击事件
		$("#code").bind("click", function() {
			getcode();
			$("#codetext").val("");
			$("#codetext").focus();
		});
		//绑定按钮的点击事件
		$("#reg").bind("click", function() {
			reg();
		});
		//发送验证码按钮的点击事件
		$("#sendsms").bind("click", function() {
			getsmscode();
		});
		var boolcheck = false;
		
		//用户端检验事件，检查非空
		function secondcheck(){
			var phonetext = $.trim($("#phonetext").val());
			var codetext = $.trim($("#codetext").val());
			if (null == phonetext || "" == phonetext) {
				$("#clean").css("color", "red");
				mui.alert("请输入手机号", "提示", "确定");
				$("#phonetext").val("");
				$("#phonetext").focus();
				boolcheck = false;
				time = 0;
				return boolcheck;
			}
			if (null == codetext || "" == codetext) {
				mui.alert("请输入验证码", "提示", "确定");
				$("#codetext").val("");
				$("#codetext").focus();
				boolcheck = false;
				time = 0;
				return boolcheck;
			}
			boolcheck = true;
			return boolcheck;
		}
		function check() {
			if(!secondcheck()){
				boolcheck = false;
				time = 0;
				return boolcheck;
			}
			var phonecodetext = $.trim($("#phonecodetext").val());
			if (null == phonecodetext || "" == phonecodetext) {
				mui.alert("请输入手机验证码", "提示", "确定");
				$("#phonecodetext").val("");
				$("#phonecodetext").focus();
				boolcheck = false;
				time = 0;
				return boolcheck;
			}
			boolcheck = true;
			return boolcheck;
		}

		//服务端验证事件
		function serverCheck() {
			//首先检查非空
			if (!check()) {
				boolcheck = false;
				time = 0;
				return boolcheck;
			}
			//检查图片验证码是否正确
			if (!vcodeCheck()) {
				boolcheck = false;
				time = 0;
				return boolcheck;
			}
			//服务端检查手机号，是否数据库已经存在该手机号
			if (!phoneCheck()) {
				boolcheck = false;
				time = 0;
				return boolcheck;
			}
			//短信验证码检查
			if (!smscodeCheck()) {
				boolcheck = false;
				time = 0;
				return boolcheck;
			}
			boolcheck = true;
			return boolcheck;
		}

		function smscodeCheck() {
			var VALIDATION_CODE = $.trim($("#phonecodetext").val());
			var VALIDATION_PHONE = $.trim($("#phonetext").val());
			boolcheck = false;
			$
					.ajax({
						type : "POST",
						url : '${pageContext.request.contextPath }/userbinding/checkphonecodetext',
						dataType : 'json',
						data : {
							VALIDATION_CODE : VALIDATION_CODE,
							VALIDATION_PHONE : VALIDATION_PHONE
						},
						cache : false,
						async : false,
						success : function(data) {
							boolcheck = true;
							if ("ok" == data.errorinfo) {
								boolcheck = true;
							} else if ("error" == data.errorinfo) {
								mui.alert(data.msg, "提示", "确定");
								$("#phonecodetext").val("");
								$("#phonecodetext").focus();
								boolcheck = false;
							} else if ("empty" == data.errorinfo) {
								mui.alert(data.msg, "提示", "确定");
								$("#phonecodetext").focus();
								boolcheck = false;
							} else if ("timeout" == data.errorinfo) {
								mui.alert(data.msg, "提示", "确定");
								$("#phonecodetext").val("");
								boolcheck = false;
							}
						}
					});
			return boolcheck;
		}

		function phoneCheck() {
			boolcheck = false;
			var phonetext = $.trim($("#phonetext").val());
			$
					.ajax({
						type : "POST",
						url : '${pageContext.request.contextPath }/userbinding/getvalidphone',
						data : {
							VALIDATION_PHONE : phonetext
						},
						dataType : 'json',
						cache : false,
						async : false,
						success : function(data) {
							if ("success" == data.result) {
								boolcheck = true;
							} else if ("numerror" == data.result) {
								mui.alert("请输入正确的手机号", "提示", "确定");
								$("#phonetext").val("");
								getcode();
								$("#codetext").val("");
								$("#phonetext").focus();
								boolcheck = false;
								time = 0;
							} else if ("nullnum" == data.result) {
								mui.alert("请输入手机号", "提示", "确定");
								$("#phonetext").focus();
								boolcheck = false;
								time = 0;
							} else if ("hasphone" == data.result) {
								mui.alert("该手机号已被注册", "提示", "确定");
								$("#phonetext").val("");
								getcode();
								$("#codetext").val("");
								$("#phonetext").focus();
								boolcheck = false;
								time = 0;
							} else if ("login" == data.result) {
								mui.alert(
												"您已经注册,请勿重复操作",
												"提示",
												function(e) {
													if (e.index == 0) {
														var url = "${pageContext.request.contextPath }/activity/goActivity";
														window.location.href = url;
													}
												});
							}else if ("notwechat" == data.result){
								mui.alert(
										"对不起,网络无响应!",
										"提示",
										function(e) {
											if (e.index == 0) {
												window.close();
											}
										});
							}
						}
					});
			return boolcheck;
		}
		function vcodeCheck() {
			boolcheck = false;
			var codetext = $.trim($("#codetext").val());
			$
					.ajax({
						type : "POST",
						url : '${pageContext.request.contextPath }/userbinding/getvalidimg',
						data : {
							KEYDATA : codetext
						},
						dataType : 'json',
						cache : false,
						async : false,
						success : function(data) {
							if ("success" == data.result) {
								boolcheck = true;
							} else if ("codeerror" == data.result) {
								mui.alert("验证码输入有误", "提示", "确定");
								getcode();
								$("#codetext").val("");
								$("#codetext").focus();
								boolcheck = false;
								time = 0;
							} else if ("nullcode" == data.result) {
								mui.alert("请输入验证码", "提示", "确定");
								$("#codetext").focus();
								boolcheck = false;
								time = 0;
							}
						}
					});
			return boolcheck;
		}
		function getcode() {
			$("#vcode").attr(
					"src",
					"${pageContext.request.contextPath }/userbinding/vcodeimg.do?t="
							+ Math.random());
			boolcheck = false;
		}
		function reg() {
			var phonetext = $.trim($("#phonetext").val());
			var USERS_WECHAT_NICKNAME= $.trim($("#username").val());
			if (!serverCheck()) {
				return false;
			}
			$.ajax({
						type : "POST",
						url : '${pageContext.request.contextPath }/userbinding/getreg',
						data : {
							VALIDATION_PHONE : phonetext,
							USERS_WECHAT_NICKNAME:USERS_WECHAT_NICKNAME
						},
						dataType : 'json',
						cache : false,
						success : function(data) {
							if ("login" == data.msg) {
								mui.alert(
												"您已经注册,请勿重复操作",
												"提示",
												function(e) {
													if (e.index == 0) {
														var url = "${pageContext.request.contextPath }/activity/goActivity";
														window.location.href = url;
													}
												});
							} else if ("error" == data.msg) {
								mui.alert("对不起,龟速网络导致接收不到信息啦!", "提示", "确定");
							} else if ("ok" == data.msg) {
								mui
										.alert(
												"绑定成功,即将跳转页面",
												"提示",
												function(e) {
													if (e.index == 0) {
														var url = "${pageContext.request.contextPath }/activity/goActivity";
														window.location.href = url;
													}
												});
							} else if ("wait" == data.msg) {
								mui.alert("您的操作频率太快啦,请15分钟后重试!", "提示", "确定");
							}
						}
					});
		}
		function sendSms() {
			var VALIDATION_PHONE = $.trim($("#phonetext").val());
			$
					.ajax({
						type : "POST",
						url : '${pageContext.request.contextPath }/userbinding/getsmsvaild',
						dataType : 'json',
						cache : false,
						async : false,
						data : {
							VALIDATION_PHONE : VALIDATION_PHONE
						},
						cache : false,
						success : function(data) {
							if ("error" == data.errorinfo) {
// 															mui.alert(data.msg, "提示", "确定");
								mui.alert("对不起,龟速网络导致接收不到信息啦!", "提示", "确定");
								boolcheck = false;
								time = 0;
							} else if ("ok" == data.errorinfo) {
								mui.alert("验证码已经发到请注意查收哦!", "提示", "确定");
								boolcheck = true;
							}else if("hassms" == data.errorinfo){
								mui.alert("验证码15分钟内都有效哦!", "提示", "确定");
								boolcheck = false;
								time = 0;
							}
						}
					});
			//return bo;
		}
		var booldxyzmcheck = true;
		//页面60秒等待
		
		function countDown(obj) {
			if (time == 0) {
				$(obj).html("获取验证码").css("color", "green");
				booldxyzmcheck = true;
				time = 60;
			} else {
				booldxyzmcheck = false;
				$(obj).text(time + "s后获取").css("color", "red");
				time--;
				setTimeout(function() {
					countDown(obj);
				}, 1000)
			}
			return booldxyzmcheck;
		}
		function getsmscode() {
			if (booldxyzmcheck != false) {
				if (!secondcheck()) {
					boolcheck = false;
					return boolcheck;
				}
				if (phoneCheck()) {
					if (vcodeCheck()) {
						sendSms();
					} else {
						time = 0;
					}
					countDown($("#sendsms"));
				}
			}
		}
		function checkMobile() {
			boolcheck = false;
			var phonetext = $.trim($("#phonetext").val());
			if (!(/^1[3|4|5|7|8][0-9]{9}$/.test(phonetext))) {
				mui.alert("请输入正确的手机号", "提示", "确定");
				$("#phonetext").val("");
				$("#phonetext").focus();
				return boolcheck;
			}
			boolcheck = true;
			return boolcheck;
		}
	</script>
</body>
</html>