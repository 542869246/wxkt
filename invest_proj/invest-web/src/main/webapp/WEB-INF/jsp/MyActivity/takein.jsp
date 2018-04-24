<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
<link
	href="${pageContext.request.contextPath }/static/wx/css/mui.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/wx/css/common.css" />

<script type="text/javascript"
	src="${pageContext.request.contextPath }/static/wx/js/jquery-1.11.3.min.js"></script>
<script
	src="${pageContext.request.contextPath }/static/wx/js/mui.min.js"></script>
<style type="text/css">
.details_comment {
	width: 100%;
	height: 9%;
	margin-top: 30px;
}

.details_comment_div {
	border: 1px solid #F17484;
	margin: 0px auto;
	width: 80%;
	height: 40px;
	margin-top: 0px;
	border-radius: 5px;
	line-height: 38px;
	box-shadow: 2px 2px 20px 5px #F1E0CE;
	position: relative;
}

.details_comment input {
	float: left;
	height: 100%;
	font-size: 0.7em;
	text-indent: 15px;
	width: 80%;
	border-radius: 5px;
	border: 0px;
	background-color: #fff;
	padding-left: 5px;
	padding-right: 25px;
}

.details_comment_button {
	float: right;
	font-size: 0.7em;
	width: 20%;
	height: 100%;
	color: white;
	text-align: center;
	line-height: 100%;
	border-radius: 0px 4px 4px 0px;
	background-color: #F17484;
}

.zyf_takein_btn {
	float: left;
	font-size: 0.7em;
	width: 20%;
	height: 100%;
	color: white;
	text-align: center;
	line-height: 38px;
	border-radius: 4px 0px 0px 4px;
	background-color: #F17484;
}

.details_partake {
	border: 1px solid #F17484;
	background-color: #F17484;
	width: 50%;
	height: 40px;
	margin: 30px auto;
	border-radius: 20px;
	box-shadow: 2px 2px 10px 5px #F1E0CE;
}

.details_partake_button {
	height: 100%;
	width: 50%;
	line-height: 38px;
	margin: 0 auto;
	text-align: center;
	font-size: 0.9em;
	color: white;
}

.mui-input-group:before {
	border: 0;
	height: 0;
}

.mui-input-group .mui-input-row:after {
	border: 0;
	height: 0;
}

.mui-input-group:after {
	height: 0;
}
</style>
<title>活动报名</title>
</head>

<body class="main adapt_to_offcanvas">
	<div class="mui-content"
		style="background-color: #FFF3DD; position: absolute; top: 0; bottom: 60px; left: 0; right: 0; overflow-y: auto;">

		<form class="mui-input-group" style="background-color: #FFF3DD;">
			<input type="hidden" value="${requestScope.ACTIVITY_ID}"
				id="activityid">
			<div class="details_comment mui-input-row"
				style="margin-top: 35px; background-color: #FFF3DD;">
				<div class="details_comment_div">
					<div class="zyf_takein_btn" id="comment_value_submit">姓名</div>
					<input type="text" class="mui-input-clear"
						placeholder="请输入 姓名 (必填)" name="phone"  maxlength="32"  id="nametext"   required="required"/>
				</div>
			</div>

			<div class="details_comment mui-input-row" style="margin-top: 6px;">
				<div class="details_comment_div">
					<div class="zyf_takein_btn" id="comment_value_submit">手机号</div>
					<input type="text" class="mui-input-clear" id="phonetext"
						placeholder="请输入 手机号 (必填)" maxlength="11" name="phone"  required="required"
						oninput="value=value.replace(/[^\d]/g,'')"
						onkeyup="value=value.replace(/[^\d]/g,'')"
						onkeydown="value=value.replace(/[^\d]/g,'')" />
				</div>
			</div>

			<div class="details_comment mui-input-row" style="margin-top: 6px;">
				<div class="details_comment_div">
					<div class="zyf_takein_btn" id="comment_value_submit">微信号</div>
					<input type="text" class="mui-input-clear"  maxlength="50"
						placeholder="请输入 微信号 (选填)" id="wechat" />
				</div>
			</div>

			<div class="details_comment mui-input-row" style="margin-top: 6px;">
				<div class="details_comment_div">
					<div class="zyf_takein_btn" id="comment_value_submit">孩子姓名</div>
					<input type="text" class="mui-input-clear"  maxlength="20"
						placeholder="请输入 孩子姓名 (选填)" id="childname" />
				</div>
			</div>

			<div class="details_comment mui-input-row" style="margin-top: 6px;">
				<div class="details_comment_div">
					<div class="zyf_takein_btn" id="comment_value_submit">所在学校</div>
					<input type="text" class="mui-input-clear"  maxlength="20"
						placeholder="请输入 孩子所在学校 (选填)" id="schoolname" />
				</div>
			</div>

			<div class="details_comment mui-input-row" style="margin-top: 6px;">
				<div class="details_comment_div">
					<div class="zyf_takein_btn" id="comment_value_submit">所在年级</div>
					<input type="text" class="mui-input-clear"  maxlength="50"
						placeholder="请输入 孩子所在年级 (选填)" id="gradename" />
				</div>
			</div>

			<div class="details_comment mui-input-row" style="margin-top: 6px;">
				<div class="details_comment_div">
					<div class="zyf_takein_btn" id="comment_value_submit">特殊说明</div>
					<input type="text" class="mui-input-clear"  maxlength="100"
						placeholder="请输入 特殊说明(选填)" id="desc" />
				</div>
			</div>

			<div class="details_comment mui-input-row" style="margin-top: 6px;">
				<div class="details_comment_div">
					<div class="zyf_takein_btn" id="comment_value_submit">验证码</div>
					<input type="text" id="codetext" placeholder="请输入 验证码(必填)" required="required"   maxlength="6"
						name="code" style="width: 55%" />
					<div class="details_comment_button" id="comment_value_submit"
						style="border-left: 1px solid #F17484; background-color: #fff; width: 25%;">
						<a id="code" style="width: 100%"><img id="vcode" src=""
							style="display: inline; width: 100%; border-radius: 0px 4px 4px 0px;"
							height="38"></a>
					</div>
				</div>
			</div>
		</form>



		<div class="details_partake">
			<div class="details_partake_button" id="reg">点击报名</div>
		</div>

	</div>
	<script
		src="${pageContext.request.contextPath}/static/wx/js/Second menu.js"></script>
	<script
		src="${pageContext.request.contextPath }/static/wx/js/mui.min.js"></script>
	<script>
	window.onpageshow=function(e){
		if(e.persisted) {
			window.location.reload() 
		}
	};
		//初始化
		$(document).ready(function() {
			getcode();
		});
		//给手机号输入框的焦点去除事件
		$("#phonetext").blur(function() {
			var phonetext = $.trim($("#phonetext").val());
			if (null != phonetext && "" != phonetext) {
				if (!checkMobile()) {
					return false;
				}
			}
		});
		
		$("#nametext").blur(function() {
			var nametext = $.trim($("#nametext").val());
			if (null != nametext && "" != nametext) {
				if (htmlEncodeJQ(nametext).length>32) {
					mui.alert("姓名过长或非法", "提示", "确定");
					$("#nametext").val(""); 
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
		var boolcheck = false;
		
		//用户端检验事件，检查非空
		function secondcheck(){
	
			boolcheck = true;
			return boolcheck;
		}
		function check() {
			var phonetext = $.trim($("#phonetext").val());
			var codetext = $.trim($("#codetext").val());
			var nametext = $.trim($("#nametext").val());
			if (null == nametext || "" == nametext) {
				mui.alert("请输入姓名", "提示", "确定");
				$("#nametext").val("");
				$("#nametext").focus();
				boolcheck = false;
				return boolcheck;
			}
			if (null == phonetext || "" == phonetext) {
				mui.alert("请输入手机号", "提示", "确定");
				$("#phonetext").val("");
				$("#phonetext").focus();
				boolcheck = false;
				return boolcheck;
			}
			if (null == codetext || "" == codetext) {
				mui.alert("请输入验证码", "提示", "确定");
				$("#codetext").val("");
				$("#codetext").focus();
				boolcheck = false;
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
				return boolcheck;
			}
			//检查图片验证码是否正确
			if (!vcodeCheck()) {
				boolcheck = false;
				return boolcheck;
			}
			//服务端检查手机号
			if (!phoneCheck()) {
				boolcheck = false;
				return boolcheck;
			}
			boolcheck = true;
			return boolcheck;
		}

		function phoneCheck() {
			boolcheck = false;
			var phonetext = $.trim($("#phonetext").val());
			$.ajax({
						type : "POST",
						url : '${pageContext.request.contextPath }/activetakein/getvalidphone',
						data : {
							USERS_PHONE : phonetext
						},
						dataType : 'json',
						cache : false,
						async : false,
						success : function(data) {
							if ("ok" == data.result) {
								boolcheck = true;
							} else if ("numerror" == data.result) {
								mui.alert("请输入正确的手机号", "提示", "确定");
								$("#phonetext").val("");
								getcode();
								$("#codetext").val("");
								$("#phonetext").focus();
								boolcheck = false;
							} else if ("nullnum" == data.result) {
								mui.alert("请输入手机号", "提示", "确定");
								$("#phonetext").focus();
								boolcheck = false;
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
						url : '${pageContext.request.contextPath }/activetakein/getvalidimg',
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
							} else if ("nullcode" == data.result) {
								mui.alert("请输入验证码", "提示", "确定");
								$("#codetext").focus();
								boolcheck = false;
							}
						}
					});
			return boolcheck;
		}
		function getcode() {
			$("#vcode").attr(
					"src",
					"${pageContext.request.contextPath }/activetakein/vcodeimg.do?t="
							+ Math.random());
			boolcheck = false;
		}
		function htmlEncodeJQ ( str ) {  
			return $('<span/>').text( str ).html();//输入后转义(gt..)
		}  
		function reg() {
			if (!serverCheck()) {
				return false;
			}
			var phonetext = $.trim($("#phonetext").val());
			var nametext = htmlEncodeJQ($.trim($("#nametext").val()));
			var ACTIVITY_ID=$.trim($("#activityid").val());
			var  activity_id= ACTIVITY_ID;
			
			var wechat = htmlEncodeJQ($.trim($("#wechat").val()));
			var childname = htmlEncodeJQ($.trim($("#childname").val()));
			var schoolname = htmlEncodeJQ($.trim($("#schoolname").val()));
			var gradename = htmlEncodeJQ($.trim($("#gradename").val()));
			var desc = htmlEncodeJQ($.trim($("#desc").val()));
			$.ajax({
						type : "POST",
						url : '${pageContext.request.contextPath }/activetakein/getreg',
						data : {
							USERS_PHONE : phonetext,
							USERS_NAME : nametext,
							ACTIVITY_ID:ACTIVITY_ID,
							USERS_WECHAT:wechat,
							STUDENT_NAME:childname,
							STUDENT_SCHOOL:schoolname,
							STUDENT_GRAND:gradename,
							DESCRIPTION:desc
						},
						dataType : 'json',
						cache : false,
						success : function(data) {
							 if ("error" == data.msg) {
								mui.confirm("对不起,龟速网络导致接收不到信息啦!", "提示",["返回","确定"], function(e){
									if(e.index==0){
// 										var url = "${pageContext.request.contextPath }/activity/goActivity";
// 										window.location.href = url;
										//window.history.back();
										location.href="${pageContext.request.contextPath}/activity/goActivityInfo?activity_id="+activity_id;
									}
								});
							} else if ("ok" == data.msg) {
								mui.alert("报名成功,即将返回!", "提示", function(e){
									if(e.index==0){
// 										var url = "${pageContext.request.contextPath }/activity/goActivity";
// 										window.location.href = url;
										//window.history.back();
										location.href="${pageContext.request.contextPath}/activity/goActivityInfo?activity_id="+activity_id;
									}
								});
							} else if("hasuser" == data.msg){
								mui.alert("您已经报名!", "提示", function(e){
									if(e.index==0){
										//var url = "${pageContext.request.contextPath }/activity/goActivity";
									location.href="${pageContext.request.contextPath}/activity/goActivityInfo?activity_id="+activity_id;
										//window.history.back();
									}
								});
							}
						}
					});
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
		createMenu();
	</script>
</body>
</html>