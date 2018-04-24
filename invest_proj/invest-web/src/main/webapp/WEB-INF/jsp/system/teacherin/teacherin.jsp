	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@ include file="/common/top.jsp"%> 
<%@ include file="../../weixin/WxChatShare.jsp"%> --%>
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
	<script type="text/javascript"
	src="${pageContext.request.contextPath }/static/wx/js/loadAjax.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/wx/css/mui.picker.min.css" />


<style>
* {
	touch-action: none;
}

.mui-control-content {
	background-color: white;
	min-height: 215px;
}

.mui-control-content .mui-loading {
	margin-top: 50px;
}

.mui-col-xs-4 {
	width: 33.333333%;
}

.mui-control-item {
	font-size: 100%;
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
	height: 50px;
	margin-top: 0px;
	border-radius: 5px;
	line-height: 38px;
	box-shadow: 2px 2px 20px 5px #F1E0CE;
	position: relative;
}
.details_comment_div_title{
	margin: 0px auto;
    width: 100%;
    height: 30px;
    margin-top: 0px;
    border-radius: 5px;
    line-height: 35px;
/*     position: relative; */
    font-size: 20px;
    text-align: center;
    color: #999;
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
	line-height: 50px;
	border-radius: 4px 0px 0px 4px;
	background-color: #F17484;
}

.details_partake {
	border: 1px solid #F17484;
	background-color: #F17484;
	width: 75%;
	height: 40px;
	margin: 25px auto;
	border-radius: 20px;
	box-shadow: 2px 2px 10px 5px #F1E0CE;
	float: left;
	margin-left: 13%;
}

.stusee {
	height: 100%;
	font-size: 0.7em;
	text-indent: 15px;
	width: 100%;
	border-radius: 5px;
	border: 0px;
	background-color: #FFF3DD;
	padding-left: 5px;
	padding-right: 25px;
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
.mui-pull-top-pocket {
	visibility: visible;
	bottom: 0;
	height: 100%;
}

.mui-pull {
	top: 35%;
}

.mui-pull-caption {
	width: 100%;
}

.mui-pull-loading {
	margin-bottom: 10px;
}

.mui-backdrop {
	background-color: rgba(0, 0, 0, .2);
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

.mui-bar-tab {
	padding-top: 0px !important;
}

.mui-tab-item {
	border-right: 1px solid #999 !important;
}

.mui-tab-item:ACTIVE {
	background-color: gray;
	color: white !important;
}

.mui-control-item {
	position: relative;
}

.mui-control-item>.mui-badge {
	position: absolute;
	right: 0px;
	top: 3px;
}

.mui-icon-plus {
	font-size: 30px;
}

#leavetouch, #dailytouch,#scheduletouch {
	color: #fff;
	width: 38px;
	height: 38px;
	line-height: 38px;
	position: absolute;
	top: 23px;
	right: 7px;
	z-index: 999999;
	border-radius: 4px;
	background-color: #007aff;
	opacity: 0.6;
}

#touchcontent {
	width: 30px;
	height: 30px;
	margin: 4px auto;
}

#popoverleave, #popoverdaily {
	width: 180px;
}
h4{
	line-height: 20px;
}
.mui-pull-top-pocket {
	visibility: visible;
	bottom: 0;
	height: 100%;
}

.mui-pull {
	top: 35%;
}

.mui-pull-caption {
	width: 100%;
}

.mui-pull-loading {
	margin-bottom: 10px;
}

.mui-backdrop {
	background-color: rgba(0, 0, 0, .2);
}
</style>


<title>教师操作</title>
</head>

<body>
	<p id="user_id" style="display: none;">${teainfo.USER_ID}</p>
	<div class="mui-content">

		<div id="popoverleave" class="mui-popover">
			<ul class="mui-table-view">
				<li class="mui-table-view-cell" id="addLeave"><a href="#">添加请假</a></li>


				<li class="mui-table-view-cell"><a href="${pageContext.request.contextPath}/teacherHome/tologin">返回首页</a></li>

				<li class="mui-table-view-cell" id="flushLeaveList"><a href="#">刷新列表</a></li>
			</ul>
		</div>

		<div id="popoverdaily" class="mui-popover">
			<ul class="mui-table-view">
				<li class="mui-table-view-cell" id="addDaily"><a href="#">添加日报</a></li>


				<li class="mui-table-view-cell"><a href="${pageContext.request.contextPath}/teacherHome/tologin">返回首页</a></li>

				<li class="mui-table-view-cell" id="flushDailyList"><a href="#">刷新列表</a></li>
			</ul>
		</div>

		
		<div id="popoverschedule" class="mui-popover">
			<ul class="mui-table-view">
				<li class="mui-table-view-cell" id="return_back"><a href="#">返回</a></li>
				<li class="mui-table-view-cell"><a href="${pageContext.request.contextPath}/teacherHome/tologin">返回首页</a></li>
				<li class="mui-table-view-cell" id="flushscheduleList"><a href="#">刷新列表</a></li>
			</ul>
		</div>


		<div id="slider" class="mui-slider" 
			style="position: absolute; top: 1px; bottom: 0px; left: 0px; right: 0px;">
				
				<div id="sliderSegmentedControl" style="height: 60px;"
				class="mui-slider-indicator mui-segmented-control mui-segmented-control-inverted">
				<a class="mui-control-item" href="#item1mobile"
					style="height: 60px; line-height: 60px;"> 日报管理 <span
					class="mui-badge mui-badge-primary" id="dailyNum"
					style="display: none"></span>
				</a> <a class="mui-control-item" href="#item2mobile"> 请假管理 <span
					class="mui-badge mui-badge-purple" id="leaveNum"
					style="display: none"></span>
				</a> <a class="mui-control-item" href="#item3mobile"> 能力值 <span
					class="mui-badge mui-badge-danger" id="abilityNum"
					style="display: none"></span>
				</a>
			</div>
				
			<div id="sliderProgressBar"
				class="mui-slider-progress-bar mui-col-xs-4"></div>
			<div class="mui-slider-group"
				style="position: absolute; top: 60px; bottom: 0px; left: 0px; right: 0px;">
				<div id="item1mobile"
					class="mui-slider-item mui-control-content mui-active">
		

					<div id="scroll1" class="mui-scroll-wrapper"
						style="background-color: #FFF3DD;">

						<div id="dailytouch">
							<div id="touchcontent">
								<span class="mui-icon mui-icon-plus"></span>
							</div>
						</div>

						<div class="mui-scroll">

							<div class="mui-loading">
								<div class="mui-spinner"></div>
							</div>

						</div>
					</div>
				</div>
				<div id="item2mobile" class="mui-slider-item mui-control-content">
					<div id="scroll2" class="mui-scroll-wrapper"
						style="background-color: #FFF3DD;">


						<div id="leavetouch">
							<div id="touchcontent">
								<span class="mui-icon mui-icon-plus"></span>
							</div>
						</div>

						<div class="mui-scroll">
							<div class="mui-loading">
								<div class="mui-spinner"></div>
							</div>
						</div>
					</div>

				</div>
				<div id="item3mobile" class="mui-slider-item mui-control-content">
					<div id="scroll3" class="mui-scroll-wrapper"
						style="background-color: #FFF3DD;">
						
						<div id="scheduletouch">
							<div id="touchcontent">
								<span class="mui-icon mui-icon-plus"></span>
							</div>
						</div>
						
						<div class="mui-scroll mui-scroll3">
							<div class="mui-loading">
								<div class="mui-spinner"></div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>

		<div id="stats" style="display: none;"></div>
		<select style="height:60px;">
		
			<option ></option>
		</select>
	</div>
	<script
		src="${pageContext.request.contextPath}/static/wx/js/mui.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/wx/js/mui.picker.min.js"></script>
	<script>
			mui.init({
				swipeBack: false
			});
			//补零
			function p(num) {
				return num < 10 ? '0' + num : num;
			}

			//获得几月几号
			function getNowDate() {
				var da = new Date()
				var year = da.getFullYear()
				var month = da.getMonth() + 1
				var date = da.getDate()
				var hour = p(da.getHours())
				var min = p(da.getMinutes())
				var sec = p(da.getSeconds())
				var nowDate = [ year, month, date ].join('-') + ' '
						+ [ hour, min, sec ].join(':')//2018-04-03 10:10:47
				return month + "月" + date + "日"
			}

			//请假操作按钮
			mui(".mui-content").on("tap","#leavetouch",function(){
				mui('#popoverleave').popover('toggle',document.getElementById("leavetouch"));
			})
			
			//日报操作
			mui(".mui-content").on("tap","#dailytouch",function(){
				mui('#popoverdaily').popover('toggle',document.getElementById("dailytouch"));
			})
			
			//能力值日程操作按钮
			mui(".mui-content").on("tap","#scheduletouch",function(){
				mui('#popoverschedule').popover('toggle',document.getElementById("scheduletouch"));
			})
			
			
// 			$('.mui-scroll-wrapper').scroll({
// 				indicators: true //是否显示滚动条
// 			});
			
			var item1 = document.getElementById('item1mobile');
			var item2 = document.getElementById('item2mobile');
			var item3 = document.getElementById('item3mobile');
			
		$(function(){
			
			var $numList=$.ajax({
				url:'${pageContext.request.contextPath}/teacherin/getListNum.do',
				dataType:'json'
			})
			
			//各消息个数
			function getNumList(){
			$.when($numList).done(function(res){
				$(res.numList).each(function(item){
					var obj = res.numList[item]
					if(obj.type==1){
						if(obj.num==0){
							$('#dailyNum').hide();
						}else{
							$('#dailyNum').show();
						}
						$('#dailyNum').text(obj.num)
					}else if(obj.type==2){
						if(obj.num==0){
							$('#leaveNum').hide();
						}else{
							$('#leaveNum').show();
						}
						$('#leaveNum').text(obj.num)
					}else{
						if(obj.num==0){
							$('#abilityNum').hide();
						}else{
							$('#abilityNum').show();
						}
						$('#abilityNum').text(obj.num)
					}
				})
				
			}).fail(function(){
				console.log('error')
			})
			
			}
			
			//2000毫秒请求一次
			getNumList()
			setInterval(function(){
				getNumList()
			},2000)
			
			
			$.ajax({
					type: "get",
					url: "${pageContext.request.contextPath}/static/html/daily.html",
					dataType: 'html',
					async: true,
					success: function(res) {
						
						setTimeout(function(){
							$(item1.querySelector('.mui-scroll')).html(res)
						},500)
						
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						if(textStatus.status>500){
							mui.alert('服务器错误','提示','确定')
						}else if(textStatus.status>400){
							mui.alert('客户端错误 ','提示','确定')
						}else if(textStatus.status>300){
							mui.alert('请刷新重试 ','提示','确定')
						}
						
					}
				});
			})
			//请假列表
			document.getElementById('slider').addEventListener('slide', function(e) {
				if(e.detail.slideNumber === 1) {
					//					if(item2.querySelector('.mui-loading')) {
// 					setTimeout(function() {
						//item2.querySelector('.mui-scroll').innerHTML = html2;
						$.ajax({
							type: "get",
							url: "${pageContext.request.contextPath}/static/html/leavelist.html",
							dataType: 'html',
							async: true,
							success: function(res) {
								$(item2.querySelector('.mui-scroll')).html(res)
							}
						});
// 					}, 500);
					//					}
					//能力值列表
				} else if(e.detail.slideNumber === 2) {
					//					if(item3.querySelector('.mui-loading')) {
// 					setTimeout(function() {
						//item3.querySelector('.mui-scroll').innerHTML = html3;
						$.ajax({
							type: "get",
							url: "${pageContext.request.contextPath}/static/html/ability.html",
							dataType: 'html',
							async: true,
							success: function(res) {
								$(item3.querySelector('.mui-scroll')).html(res)

							}
						});
// 					}, 500);
					//					}
					//日报列表
				} else if(e.detail.slideNumber === 0){
					$.ajax({
						type: "get",
						url: "${pageContext.request.contextPath}/static/html/daily.html",
						dataType: 'html',
						async: true,
						success: function(res) {
							$(item1.querySelector('.mui-scroll')).html(res)
						}
					});
				}
			});

			var btns = mui('.search_input');
			btns.each(function(i, btn) {
				btn.addEventListener('tap', function() {　
					var dtPicker = new mui.DtPicker({　　　　
						"type": "date"　　　
					});　　
					dtPicker.show(function(rs) {
						$(".search_input").attr("placeholder", rs.text);
						/*loaddata(rs.text);*/
					});　
				}, false);
			});
			
		
		</script>


</body>
</html>