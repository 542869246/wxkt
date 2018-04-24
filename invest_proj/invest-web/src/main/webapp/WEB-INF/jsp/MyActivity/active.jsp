<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%-- <%@ include file="../weixin/WxChatShare.jsp"%>  --%>
<!DOCTYPE html>
<html class="ui-page-login">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title><c:if test="${activity_type_id==null}">活动集锦</c:if><c:if
		test="${activity_type_id==0}">趣味英语</c:if><c:if
		test="${activity_type_id==1}">一周体验</c:if><c:if
		test="${activity_type_id==2}">活动预告</c:if> <c:if
		test="${activity_type_id==3}">历史记录</c:if></title>
<link
	href="${pageContext.request.contextPath}/static/wx/css/mui.min.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/static/wx/css/style.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/wx/css/common.css" />
<br />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/wx/css/font-awesome-4.7.0/css/font-awesome.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/wx/js/jquery-1.11.3.min.js">
		</script>
</head>
<!--    -->
<body class="main">
	<div style="position: absolute; right: 0px; top: 0px; z-index: 999">

			<a href="#popover" id="openPopover" class="mui-action-menu mui-icon mui-icon-bars mui-pull-right" style="color:	#EEC591 "></a>

	</div>
	<div id="popover" class="mui-popover">
		<ul class="mui-table-view">
			<li class="mui-table-view-cell"><a href="../activity/goActivity?activity_type_id=3&create=1">近一周历史活动记录</a></li>
			<li class="mui-table-view-cell"><a href="../activity/goActivity?activity_type_id=3&create=2">近一月历史活动记录</a></li>
			<li class="mui-table-view-cell"><a href="../activity/goActivity?activity_type_id=3&create=3">近六个月历史活动记录</a></li>
				<li class="mui-table-view-cell"><a href="../activity/goActivity?activity_type_id=3&create=0">所有历史活动记录</a></li>
			<li class="mui-table-view-cell"><a href="../activity/goActivity">返回</a></li>
			<!-- <li class="mui-table-view-cell"><a href="#">Item3</a></li>
			<li class="mui-table-view-cell"><a href="#">Item4</a></li>
			<li class="mui-table-view-cell"><a href="#">Item5</a></li> -->
		</ul>
	</div>

	<!-- 主页面容器 -->
	<div class="mui-inner-wrap adapt_to_offcanvas">

		<!--下拉刷新容器-->
		<div class="mui-scroll-wrapper content1" id="refreshContainer"
			style="position: absolute; top: 0; bottom: 61px;">
			<div class="mui-scroll" style="">

				<!--数据列表-->
				<div id="mycontent"
					class="mui-table-view mui-table-view-chevron main"
					style="background-color: #FFF3DD;"></div>
			</div>
		</div>
	</div>

	<script
		src="${pageContext.request.contextPath}/static/wx/js/Second menu.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/wx/js/mui.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/wx/js/app.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/wx/js/jquery-1.11.3.min.js"></script>
	<c:if test="${state==1}">
		<script type="text/javascript">
				mui.alert("${message}","系统提示","确认");
			</script>
	</c:if>
	<script>
	
			var navdiv = document.getElementById('mycontent')
			mui.init({
				pullRefresh: {
					container: "#refreshContainer", //待刷新区域标识，querySelector能定位的css选择器均可，比如：id、.class等
					up: {
						height: 50, //可选.默认50.触发上拉加载拖动距离
						auto: true, //可选,默认false.(true自动上拉加载一次)
						contentrefresh: "正在加载...", //可选，正在加载状态时，上拉加载控件上显示的标题内容
						contentnomore: '没有更多数据了', //可选，请求完毕若没有更多数据时显示的提醒内容；
						callback: pullupRefresh //必选，刷新函数，根据具体业务来编写，比如通过ajax从服务器获取新数据；
					}
				}
			});
			

			//默认第一页	
		    var next=1;
			  $(function(){
					$.ajax({
						url:"${pageContext.request.contextPath}/schoolactivity/activity",
						type:"post",
						dataType:"json",
						data:{
							"activity_type_id":"${activity_type_id}",
							"create":"${create}",
							"next":next
						},
						success:function(data){
							var message=data.pageDatas;
							for(var i = 0; i <message.length ; i++) {
							creatediv(message[i].ACTIVITY_ID,data.uploadfPath+message[i].ACTIVITY_IMGSRC,message[i].ACTIVITY_TITLE,message[i].ACTIVITY_INFO)
							}
							$('.nav').on('tap', function() {
								var activity_id = $(this).children(':first').text()
								location.href="${pageContext.request.contextPath}/activity/goActivityInfo?activity_id="+activity_id+"&activity_type_id="+"${activity_type_id}";
							})
						}
					 })
				}) 
			//上拉数据处理方法
			function pullupRefresh() {
				setTimeout(function() {
					$.ajax({
						url:"${pageContext.request.contextPath}/schoolactivity/activity",
						type:"post",
						dataType:"json",
						data:{
							"activity_type_id":"${activity_type_id}",
							"create":"${create}",
							"next":++next
							},
						success:function(data){
							mui('#refreshContainer').pullRefresh().endPullupToRefresh(data.pageDatas.length<6);
							var message=data.pageDatas;
							for(var i = 0; i <message.length ; i++) {
								creatediv(message[i].ACTIVITY_ID,data.uploadfPath+message[i].ACTIVITY_IMGSRC,message[i].ACTIVITY_TITLE,message[i].ACTIVITY_INFO)
							}
							$('.nav').on('tap', function() {
								var activity_id = $(this).children(':first').text()
								location.href="${pageContext.request.contextPath}/activity/goActivityInfo?activity_id="+activity_id+"&activity_type_id="+"${activity_type_id}";
							})
						}
					});
				}, 1500);
			}

				//创建一条活动
				function creatediv(id, imgsrc, title, content) {
					 var div = document.createElement("div");
					 div.innerHTML = `
									<div class="nav" style='font-size: 0.7rem;width:100%;'>
						<div class='zyf_activityid' style='display:none'>`+id+`</div>
										<div class="nav_bimg">
											<img class="nav_bimg_img" src="`+imgsrc+`" onerror="this.src='${pageContext.request.contextPath}/static/wx/img/lu.png'"/>
										</div>
										<div class="nav_font">
											<ul class="nav_font_ul">
											
												<li class="nav_font_ul_liOne">`+title+`</li>
												<li class="nav_font_ul_liTwo" style="word-wrap:break-word">`+content+`</li>
												<li class="nav_font_fontawesome"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i></li>
											</ul>
										</div>
									</div>
						 			`;  
						
					navdiv.appendChild(div);
				}
			createMenu();
			$(function(){
				console.log(document.getElementById("ads")	)
				document.getElementById("ads").addEventListener("click",function(){
				
					location.href="";
				},false)
			})
		
		</script>

</body>

</html>