<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
		<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.11.3.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/layout.js" ></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/bc.css" />
		<title>登录</title>
	</head>
	<body>
		<div class="wrapper">
			<div class="login">
				<img class="head" src="${pageContext.request.contextPath }/static/img/login.png" />
				<p>
					<input class="name" type="text" placeholder="请输入手机号" maxlength="11" />
					<a class="clean" href="javascript:;"></a>
				</p>
				<p>
					<input class="password" type="password" placeholder="请输入密码" />
					<a class="showPassword" href="javascript:;"></a>
				</p>
				<a class="enter" href="javascritp:;">登录</a>
				<div class="tip">
					<a href="javascript:;">立即注册</a>
					<a href="javascript:;">忘记密码</a>
				</div>
				<div class="or">
					<a class="wx" href="javascript::"></a>
				</div>
			</div>
		</div>
		<script>
			//清除手机号
			$("a.clean").on("click",function(){
				$(this).siblings("input").val("");
			})
			//显示隐藏密码
			$("a.showPassword").on("click",function(){
				if ($(this).hasClass("cur")) {
					$(this).removeClass("cur");
					$(this).siblings("input").attr('type','password');
				} else{
					$(this).addClass("cur");
					$(this).siblings("input").attr('type','text');
				}
			})
		</script>
	</body>
</html>