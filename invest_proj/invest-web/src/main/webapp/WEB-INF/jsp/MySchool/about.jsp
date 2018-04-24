<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="../weixin/WxChatShare.jsp"%> 
<!doctype html>
<html>
	<!--<header class="mui-bar mui-bar-nav">
	    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
	    <h1 class="mui-title">关于我们</h1>
	</header>-->

	<head>
		<meta charset="UTF-8">
		<title><c:if test="${type==0}">关于我们</c:if><c:if test="${type==1}">品牌入驻</c:if></title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link href="${pageContext.request.contextPath}/static/wx/css/mui.min.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/wx/css/common.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/wx/js/jquery-1.8.3.min.js"></script>
		<script
	src="${pageContext.request.contextPath }/static/wx/js/mui.min.js"></script>
		<style type="text/css">
			.zyfimg{
				overflow:hidden;
				width: 100%;
				margin-right: 1.1em;
			}
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
		<script type="text/javascript">
			$(function(){
				loadgoAbout();
			});
			function loadgoAbout(){
				$.ajax({
					url:'${pageContext.request.contextPath}/schoolabout/goAbout',
					type:'post',
					dataType:'json',
					data:{'type':'${type}'},
					success:function(obj){
						if(${type} == 0){
							$(".tabpanel").html(obj.SCHOOL_README);			
						}else{
							$(".tabpanel").html(obj.BRAND_CONTENT);
							$("#join_brand").show();		
						}
					}
				});
			}
		</script>
	</head>

<body class="main adapt_to_offcanvas">
		
		
		<div id="" style="position: absolute;top: 0;bottom: 0px;overflow-y: auto;">
		<div class="nv_mui-content">
			<div class="img_main HNH_IMG_one"></div>
			<div class="img_main HNH_IMG_two"></div>
			<div class="img_main HNH_IMG_three"></div>
			<div class="img_main HNH_IMG_four"></div>
		</div>
		
		<div class="tab htmlmain text_div" style="width: 100%;bottom: 0px;">
			<div class="tabpanel" style="max-width:100%">
			</div>
		</div>
		

			<div  id="join_brand"  style="display:none "> 
		
		<div class="mui-content"
		style="background-color: #FFF3DD; top: 0; bottom: 0px; left: 0; right: 0; overflow-y: auto;">

		<form class="mui-input-group" style="background-color: #FFF3DD;top: 0px;">
			<input type="hidden" value="${requestScope.ACTIVITY_ID}"
				id="activityid">
			<div class="details_comment mui-input-row"
				style="margin-top: 30px; background-color: #FFF3DD;">
				<div class="details_comment_div">
					<div class="zyf_takein_btn" id="comment_value_submit">姓名</div>
					<input type="text" class="mui-input-clear"
						placeholder="请输入 姓名 (必填)" name="phone"  maxlength="32"  id="nametext"   required="required"/>
				</div>
			</div>
		
		
			<div class="details_comment mui-input-row" style="margin-top: 5px;">
				<div class="details_comment_div">
					<div class="zyf_takein_btn" id="comment_value_submit">手机号</div>
					<input type="text" class="mui-input-clear" id="phonetext"
						placeholder="请输入 手机号 (必填)" maxlength="11" name="phone"  required="required"
						oninput="value=value.replace(/[^\d]/g,'')"
						onkeyup="value=value.replace(/[^\d]/g,'')"
						onkeydown="value=value.replace(/[^\d]/g,'')" />
				</div>
			</div>
			
					<div class="details_comment mui-input-row" style="margin-top: 5px;">
				<div class="details_comment_div">
					<div class="zyf_takein_btn" id="comment_value_submit">特殊说明</div>
					<input type="text" class="mui-input-clear"  maxlength="100"
						placeholder="请输入 特殊说明(选填)" id="desc" />
				</div>
			</div>
			
				<div class="details_comment mui-input-row" style="margin-top: 5px;">
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
			<div class="details_partake_button" id="reg">点击加盟</div>
		</div>
		
		</div>
		</div>
		
		
		
		
		</div>
		
		<script src="${pageContext.request.contextPath}/static/wx/js/Second menu.js"></script>
		<script>
			$(function(){
				setTimeout(function(){
					$('.tabpanel').eq(0).children().find('img').addClass('zyfimg');
				},400);
			})
		</script>
		<script src="${pageContext.request.contextPath}/static/wx/js/mui.min.js"></script>
		<script type="text/javascript">
			mui.init();
			$(document).ready(function() {
				getcode();
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
			});
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
					$("#clean").css("color", "red");
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
			function getcode() {
				$("#vcode").attr(
						"src",
						"${pageContext.request.contextPath }/schoolBrand/vcodeimg.do?t="
								+ Math.random());
			}
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
			
			$("#phonetext").blur(function() {
				var phonetext = $.trim($("#phonetext").val());
				if (null != phonetext && "" != phonetext) {
					if (!checkMobile()) {
						return false;
					}
				}
			});
			
			function phoneCheck() {
				boolcheck = false;
				var phonetext = $.trim($("#phonetext").val());
				$.ajax({
							type : "POST",
							url : '${pageContext.request.contextPath }/schoolBrand/getvalidphone',
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
							url : '${pageContext.request.contextPath }/schoolBrand/getvalidimg',
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
			
			
			function reg() {
				if (!serverCheck()) {
					return false;
				}
				var phonetext = $.trim($("#phonetext").val());
				var nametext = $.trim($("#nametext").val());
				var desc = $.trim($("#desc").val());
				$.ajax({
							type : "POST",
							url : '${pageContext.request.contextPath }/schoolBrand/getreg',
							data : {
								USERS_PHONE : phonetext,
								USERS_NAME : nametext,
								DESCRIPTION:desc
							},
							dataType : 'json',
							cache : false,
							success : function(data) {
								 if ("error" == data.msg) {
									mui.confirm("对不起,龟速网络导致接收不到信息啦!", "提示",["返回","确定"], function(e){
										if(e.index==0){
											window.location.reload();
										}
									});
								} else if ("ok" == data.msg) {
									mui.alert("报名成功,即将返回!", "提示", function(e){
										if(e.index==0){
											window.location.reload();
										}
									});
								} else if("hasuser" == data.msg){
									mui.alert("您已经报名!", "提示", function(e){
										if(e.index==0){
											window.location.reload();
										}
									});
								}
							}
						});
			}
		</script>
	</body>

</html>