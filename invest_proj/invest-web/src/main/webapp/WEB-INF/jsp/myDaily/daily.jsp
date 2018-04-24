<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ include file="/common/top.jsp"%> 
<%@ include file="../weixin/WxChatShare.jsp"%> --%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title class="student_name">家长日报</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1 user-scalable=no">
<link
	href="${pageContext.request.contextPath}/static/wx/css/mui.min.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/static/wx/js/mui.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/wx/css/example.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/wx/css/stroll.css">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/wx/css/common.css" />
<script
	src="${pageContext.request.contextPath}/static/wx/js/jquery-1.8.3.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/wx/js/echarts.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/wx/js/echarts-all.js"></script>
<style type="text/css">
.android-only p {
	text-indent: 22px;
}

span.mui-icon {
	font-size: 14px;
	color: #007aff;
	margin-left: -15px;
	padding-right: 10px;
}

.mui-off-canvas-left {
	color: #fff;
}

.title {
	margin: 15px 15px 10px;
}

.title+.content {
	margin: 10px 15px 5px;
	color: #707070;
	text-indent: 1em;
	font-size: 14px;
	line-height: 24px;
}

.mui-table-hover {
	background-color: #3B3B3B;
}

.mui-scroll-wrapper_css {
	background-color: #EECFA1;
	/*background:url(images/0d1dd1355b337d46943d6f4f3f3f6f12.jpg)  no-repeat;
	background-size: 1000px;*/
}

.mui-content-padded .childisselected {
	display: none;
	font-size: 40px;
	color: #007AFF;
	position: absolute;
	top: 2px;
	right: 0px;
}

.mui-btn-outlined {
	color: white;
}
</style>
</head>

<body class="main">
	<!-- 侧滑导航根容器 -->
	<div class="mui-off-canvas-wrap mui-draggable">
		<!-- 菜单容器 -->
		<aside class="mui-off-canvas-left">
			<div class="mui-scroll-wrapper">
				<div class="mui-scroll">
					<div class="title">提示详情</div>
					<div class="content">
						选择您的孩子来查看各自的各项数值状态。
					</div>
					<div class="title" style="margin-bottom: 25px;">切换孩子</div>

					<div class="mui-content-padded"
						style="overflow-y: auto; border-top: 1px solid #525252; height: 250px; padding: 20px 10px; border-radius: 2px;">
					</div>
				</div>
			</div>
		</aside>
		<!-- 主页面容器 -->
		<div class="mui-inner-wrap adapt_to_offcanvas">
			<div class="mui-off-canvas-backdrop"></div>

			<!--下拉刷新容器-->
			<div class="mui-content mui-scroll-wrapper">
				<header class="mui-bar mui-bar-nav"
					style="background-color: #FFF3DD; width: 10%;">
					<a class="mui-icon mui-action-menu mui-icon-bars mui-pull-left"
						id="offCanvasShow"></a>
				</header>
				<div class="mui-scroll" style="height: 100%;">
					<!--数据列表-->
					<div class="mui-table-view mui-table-view-chevron main"
						style="height: 100%">
						<div id="radar" class="radar_val"></div>
						<div class="aaa">
							<div class="cc_prompt_connent" style="border:1px soild red;margin: 0px auto;width: 90%;text-align: center;font-size: 0.6em;color: #A9A9A9;">解读：各项能力点离中心点越远代表此项能力值越高，反之越低</div>
						</div>
						<div class="cc_message_lu" id="refreshContainer2">

							<div id="main_down">
								<ul class="list_ul" id="ul_test">
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/wx/js/refresh.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/wx/js/myAjax.js"></script>
	<script type="text/javascript">


		document.getElementById('offCanvasShow').addEventListener('tap', function() {
			mui('.mui-off-canvas-wrap').offCanvas().show();
		});
		
		
			var option = {
				tooltip: { //提示框，鼠标悬浮交互时的信息提示
					show: true,
					trigger: 'axis'
				},
				legend: { //图例，每个图表最多仅有一个图例
					x: 'center', //水平居中
					data: []
				},
				polar: [{ //极坐标 
					indicator: [
						{
							text: '无数据',
						},
						{
							text: '无数据',
						},
						{
							text: '无数据',
						},
						{
							text: '无数据',
						},
						{
							text: '无数据',
						},
						{
							text: '无数据',
						},
						{
							text: '无数据',
						},
						{
							text: '无数据',
						},
						{
							text: '无数据',
						}
					],
					radius: judgeDisplay(),
					startAngle: 90 // 改变雷达图的旋转度数
				}],

				series: [{ // 驱动图表生成的数据内容数组，数组中每一项为一个系列的选项及数据
					name: '总点击量',
					type: 'radar',
					itemStyle: { //图形样式，可设置图表内图形的默认样式和强调样式（悬浮时样式）：
						normal: {
							areaStyle: {
								type: 'default'
							}
						}
					},
					data: [{
						value: [], //外部加载，也可以通过ajax去加载外部数据。
						name: ''
					}]
				}]
			};
			//侧边栏孩子列表构建
			function createchildbtn(name,id,countid) {
				var str = `<button type="button" class="mui-btn mui-btn-block mui-btn-outlined">
					<span class="studentname">`+name+`</span>
					<span style="display: none;" class="studentid">`+id+`</span>
					<span class="mui-icon mui-icon-checkmarkempty childisselected"></span>
				</button>`
				$('.mui-content-padded').eq(0).append(str)
				if(id=="${sessionScope.loginuser.STUDENT_ID}"){
					$('.mui-btn-outlined').eq(countid).toggleClass('mui-btn-primary').children("span:last-child").show()				
				}
				return str
			}
			//页面刷新
			function myonload(id) {
				location.href="${pageContext.request.contextPath}/schoolGetStudent/updateDefalutStudent?STUDENT_ID="+id+"&currenturl="+this.location.href;
			}

			$(function() {
				option.series[0].data[0].name = '当前值';
				let count=0;
				var counid=0;
				var abilityarr=new Array();
				var abilityTextJson=new Array();
				
				$.ajax({
					url: "${pageContext.request.contextPath }/schoolGetStudent/findStudent",
					type: "post",
					dataType:"json",
					cache : false,
					async : false,
					success:function(result){
						if(result.students==null)return;
						$.each(result.students, function(index,student) {
							console.log(student.STUDENT_NAME+"--"+student.STUDENT_ID)
							createchildbtn(student.STUDENT_NAME,student.STUDENT_ID,counid++);
						});
						$('.mui-btn').on('tap', function() {
							$('.mui-btn').children("span:last-child").hide()
								$(this).children("span:last-child").show()
								$(this).parent().children().removeClass('mui-btn-primary')
								$(this).toggleClass('mui-btn-primary')
								//mui.alert($(this).children('span').eq(1).text());
							window.myonload($(this).children('span').eq(1).text())
							mui('.mui-off-canvas-wrap').offCanvas().close()
						})
					}
				}),
				setTimeout(function(){$.cc.ajax({
					url: "${pageContext.request.contextPath}/schoolDailyLoad/dailyTypeConnent",
					type: "post",
					dataType:"json",
					cache : false,
					async : false,
					success: function(result) {
						console.log(result);
						if(result.stateCode=='100'){
							option.series[0].data[0].value = [60,60,60,60,60,60,60,60,60]; // 加载数据到data中
							var myChart = echarts.init(document.getElementById('radar'));
							myChart.setOption(option, true); //为echarts对象加载数据
							return;
						};
						var str="";
						$.each(result.abilityTypeList, function(index,abilityType) {
							console.log(abilityType.NAME+"--DICTIONARIES_ID:"+abilityType.DICTIONARIES_ID)
							var abilityText=new Object();
							abilityText.text=abilityType.NAME;
							abilityTextJson.push(abilityText);
							//abilityTest[0].text=abilityType.NAME;
							//option.polar[0].indicator[count].text=abilityType.NAME;
							  $.each(result.abilityValueList, function(index,abilityValue) {
									console.log(abilityValue.AbilityTotal+"--ability_type_id:"+abilityValue.ability_type_id)
									if(abilityType.DICTIONARIES_ID==abilityValue.ability_type_id){
									 	abilityarr[count]=abilityValue.AbilityTotal==""||abilityValue.AbilityTotal==null||abilityValue.AbilityTotal==undefined?0:abilityValue.AbilityTotal;
										console.log(abilityarr[count])
									}
							}); 
							count++;
						}); 
						console.log(abilityTextJson)
						option.polar[0].indicator=abilityTextJson;
						option.series[0].data[0].value = abilityarr;
						var myChart = echarts.init(document.getElementById('radar'));
						myChart.setOption(option, true); //为echarts对象加载数据
					}
					})
				},100)
			});
			
			//初始页面
			var page=0;
			//上拉加载数据处理方法
			function callback_endPullupToRefresh() {
				var message=null;
				//$("<li style='opacity: 1;'></li>").addClass("cc_message_li").append($("<a></a>").addClass("cc_message_li_a prevent_over_a").append(message[i])).appendTo("#ul_test");
				$.cc.ajax({
					url: "${pageContext.request.contextPath}/schoolDailyLoad/dailyconnent",
					type: "post",
					dataType:"json",
					data:{"page":page++},
					cache : false,
					async : false,
					success: function(result) {
					if(result.stateCode=='100'){
						mui.alert(result.prompt);
						mui('#refreshContainer2').pullRefresh().endPullupToRefresh(true);
						return;
					} 
					
						$.each(result.abilityList, function(index,ability) {
							message=ability.course_time+"["+ability.NAME+"]"+ability.course_content
							var newspaper_li = document.createElement("li");
							newspaper_li.className = "cc_message_li";
							let a_href = document.createElement("a");
							a_href.className = "cc_message_li_a prevent_over_a";
							a_href.style.color = "black";
							a_href.innerText = message;
							newspaper_li.appendChild(a_href);
							var countspan = document.createElement("span");
							countspan.className = "newspaper_div_right";
							var ability_value=ability.ability_value;
							countspan.innerText = ability.abilityTypeNAME+(ability_value>0?"↑":"↓");
							newspaper_li.appendChild(countspan);
							getByClass("list_ul")[0].appendChild(newspaper_li); 
						}); 
						if(message == "" || message == null || message == undefined){
							mui('#refreshContainer2').pullRefresh().endPullupToRefresh(true)
						}else{
							mui('#refreshContainer2').pullRefresh().endPullupToRefresh(false)
						} 
						$(".student_name").html(result.student.STUDENT_NAME+"的能力圈");
					}
				})
			}
			//下拉刷新数据处理函数
			function callback_endPulldownToRefresh() {
			}


			function getByClass(classname) {
				return document.getElementsByClassName(classname);
			}


			//根据手机屏幕的可见区域宽度和高度来判断雷达图的半径
			function judgeDisplay() {
				if(document.body.clientWidth > 350 && document.body.clientHeight > 650) {
					return 80
				} else {
					return 70
				}
			}
		</script>
	<script
		src="${pageContext.request.contextPath}/static/wx/js/stroll.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/wx/js/Second menu.js"></script>
	<script>
			window.createMenu();
		</script>

</body>

</html>