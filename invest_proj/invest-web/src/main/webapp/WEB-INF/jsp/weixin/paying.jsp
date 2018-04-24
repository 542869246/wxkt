<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta name="viewport"
	　content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<title>微信安全支付中</title>
<style type="text/css">
html, body {
	height: 100%;
	width: 100%;
	margin: 0;
	padding: 0;
}

.center {
	width: 100%;
	text-align: center;
	margin: 0 auto;
	position: relative; /*脱离文档流*/
	top: 40%; /*偏移*/
	font-size: 4rem;
	text-shadow: 0.2rem 0.2rem 0.6rem #8a7979;
}

.center:AFTER {
	content: "";
	font-size: 2rem;
	display: block;
	color: #000000;
}

span {
	display: block; 
	margin: 0 auto;
	margin-bottom: 2rem;
	text-shadow: 0.2rem 0.2rem 0.6rem #8a7979;
}

span[class*="l-"] {
	height: 1.5rem; width: 1.5rem;
	background: #000;
	display: inline-block;
	margin: 12px 2px;
	
	border-radius: 100%;
	-webkit-border-radius: 100%;
	-moz-border-radius: 100%;
	
	-webkit-animation: loader 4s infinite;
	-webkit-animation-timing-function: cubic-bezier(0.030, 0.615, 0.995, 0.415);
	-webkit-animation-fill-mode: both;
	-moz-animation: loader 4s infinite;
	-moz-animation-timing-function: cubic-bezier(0.030, 0.615, 0.995, 0.415);
	-moz-animation-fill-mode: both;
	-ms-animation: loader 4s infinite;
	-ms-animation-timing-function: cubic-bezier(0.030, 0.615, 0.995, 0.415);
	-ms-animation-fill-mode: both;
	animation: loader 4s infinite;
	animation-timing-function: cubic-bezier(0.030, 0.615, 0.995, 0.415);
	animation-fill-mode: both;
	text-shadow: 0.2rem 0.2rem 0.6rem #8a7979;
}

span.l-1 {-webkit-animation-delay: 1s;animation-delay: 1s;-ms-animation-delay: 1s;-moz-animation-delay: 1s;}
span.l-2 {-webkit-animation-delay: 0.8s;animation-delay: 0.8s;-ms-animation-delay: 0.8s;-moz-animation-delay: 0.8s;}
span.l-3 {-webkit-animation-delay: 0.6s;animation-delay: 0.6s;-ms-animation-delay: 0.6s;-moz-animation-delay: 0.6s;}
span.l-4 {-webkit-animation-delay: 0.4s;animation-delay: 0.4s;-ms-animation-delay: 0.4s;-moz-animation-delay: 0.4s;}
span.l-5 {-webkit-animation-delay: 0.2s;animation-delay: 0.2s;-ms-animation-delay: 0.2s;-moz-animation-delay: 0.2s;}
span.l-6 {-webkit-animation-delay: 0;animation-delay: 0;-ms-animation-delay: 0;-moz-animation-delay: 0;}

@-webkit-keyframes loader {
	0% {-webkit-transform: translateX(-30px); opacity: 0;}
	25% {opacity: 1;}
	50% {-webkit-transform: translateX(30px); opacity: 0;}
	100% {opacity: 0;}
}

@-moz-keyframes loader {
	0% {-moz-transform: translateX(-30px); opacity: 0;}
	25% {opacity: 1;}
	50% {-moz-transform: translateX(30px); opacity: 0;}
	100% {opacity: 0;}
}

@-keyframes loader {
	0% {-transform: translateX(-30px); opacity: 0;}
	25% {opacity: 1;}
	50% {-transform: translateX(30px); opacity: 0;}
	100% {opacity: 0;}
}

@-ms-keyframes loader {
	0% {-ms-transform: translateX(-30px); opacity: 0;}
	25% {opacity: 1;}
	50% {-ms-transform: translateX(30px); opacity: 0;}
	100% {opacity: 0;}
}
</style>
</head>
<body>
		<div class=" center htmleaf-content">
			<span>微信安全支付中</span>
			<span class="l-1"></span>
			<span class="l-2"></span>
			<span class="l-3"></span>
			<span class="l-4"></span>
			<span class="l-5"></span>
			<span class="l-6"></span>
		</div>
</body>

<%@include file="./include_wxpay.jsp"%>
<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.3.min.js" ></script>
<script type="text/javascript">
	$(function(){
		$.ajax({
			url:"<%=request.getContextPath()%>/wxpay/testPay",
			dataType:"json",
			data:{ORDER_ID:'${ORDER_ID}',MEMBER_ID:'${MEMBER_ID}',PAY_STATUS:'${wxPayType}',RECHARGE_ID:'${RECHARGE_ID}'},
			success:function(reg){
// 				console.log(reg);
				if(reg.data.PAY_STATUS == 0){
					location.replace("<%=request.getContextPath()%>/order/payResult/" + reg.data.ORDER_ID);
				} else {
					location.replace("<%=request.getContextPath()%>/users/wallet");
				}
			}
		})
	})
</script> --%>

</html>
