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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/wx/css/mui.picker.min.css" />

<style>
*{
	touch-action: none;
}
body {
	background: #FFF3DD;
}
.mui-input-group label {
	width: 100%;
}

.mui-card {
	border-radius: 2px;
}

.zyf_card1 {
	margin: 20px 15px 7px 15px;
	height: 50px;
	background-color: #FFF3DD;
	border: none;
	padding: 15px 0;
	box-shadow: none;
}

.zyf_card1 p {
	font-size: 18px;
}

.zyf_card2 {
	margin-top: 15px;
}

.zyf_card2 p {
	font-size: 15px;
}

.zyf_card2 .mui-table-view-cell {
	height: 53px;
	padding: 16px 15px;
}

.mui-card .mui-table-view .mui-table-view-cell:first-child, .mui-card .mui-table-view .mui-table-view-divider:first-child
	{
	top: 0;
	border-top-left-radius: 0px;
	border-top-right-radius: 0px;
}

.mui-card .mui-table-view .mui-table-view-cell:last-child, .mui-card .mui-table-view .mui-table-view-divider:last-child
	{
	border-bottom-right-radius: 0px;
	border-bottom-left-radius: 0px;
}

#popoverLessonDetails {
	width: 25%;
}

#popoverLessonDetails .mui-table-view {
	max-height: 500px;
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


<title>我的工作日程</title>
</head>

<body style="background: #FFF3DD;">
	<p id="user_id" style="display: none;">${teainfo.USER_ID}</p>
	<header id="header" class="mui-bar mui-bar-nav" style="height: 50px;">
		<h1 class="mui-title">我的工作日程</h1>
	</header>
	<div class="mui-content" style="background: #FFF3DD;">

		<div id="popoverLessonDetails" class="mui-popover" lid>
			<ul class="mui-table-view">
				<li class="mui-table-view-cell zyf_zylr"><a href="#">上课内容</a></li>
				<li class="mui-table-view-cell zyf_zyys"><a href="#">课后小结</a></li>
				<li class="mui-table-view-cell zyf_eval"><a href="#">学生评价</a></li>
				<li class="mui-table-view-cell zyf_ability"><a href="#">能力值</a></li>
				<li class="mui-table-view-cell zyf_dzsj"><a href="#">到达时间</a></li>
				<li class="mui-table-view-cell zyf_lksj"><a href="#">离开时间</a></li>
				<li class="mui-table-view-cell zyf_leave"><a href="#">请假信息</a></li>
			</ul>
		</div>

		<div class="mui-card zyf_card1">

			<p>
				<span id="nowDate"></span>前共 <span id="goMessage"
					style='color: #007aff; text-decoration: underline;'><span
					id="allListNum"></span>条</span> 未完成消息
			</p>

		</div>

		<div class="mui-card zyf_card2">
			<ul class="mui-table-view" id="OA_task_1">

				<c:forEach items="${teachCourseList }" var="course" varStatus="stat">
					<p id="course_id" style="display: none;">${course.course_id}</p>
					<p id="lesson_starttime" style="display: none;">${course.lesson_starttime}</p>
					<li class="mui-table-view-cell mui-transitioning" lid="${course.lessons_id }">
						
						<div class="mui-slider-handle"
							style="transform: translate(0px, 0px);">

							<p>
								<span class="mui-badge mui-badge-warning mui-badge-inverted"
									style='font-size: 16px;'>${stat.index+1 } </span><span
									style="display: inline-block; width: 10px;"></span>[
								<fmt:formatDate value="${course.lesson_starttime }"
									pattern="HH:mm" />
								-
								<fmt:formatDate value="${course.lesson_endtime }"
									pattern="HH:mm" />
								]<span style="display: inline-block; width: 10px;"></span>课程：<span
									style="display: inline-block; width: 40px;">${course.subject_name }</span>
								<span class='lessonDetails'
									style="display: inline-block; width: 50px; float: right; color: #007aff;">[ 详情 ]</span>
							</p>
						</div>
					</li>
				</c:forEach>

			</ul>
		</div>

	</div>
	<script
		src="${pageContext.request.contextPath}/static/wx/js/mui.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/wx/js/mui.picker.min.js"></script>
	<script>
		mui.init({
			swipeBack : false,
			 longtap: true
		});
		
		var mask = mui.createMask(function () {
			var flushStr=`<div class="mui-pull-top-pocket mui-block">
			<div class="mui-pull">
			<div class="mui-pull-loading mui-icon mui-spinner"></div>
			<div class="mui-pull-caption"><p>懂得静观大地开花结果的人</p></div>
			<div class="mui-pull-caption"><p>决不会为失去的一切而痛心</p></div>
			</div></div>`
			$(".mui-backdrop").html(flushStr);
	        return mask.clickClose;;
	    })
		mask.show()
		mask.clickClose = false;
	    mask.clickClose=true;
		mask.close();
		
		mui('.mui-scroll-wrapper').scroll({
			deceleration : 0.0005, //flick 减速系数，系数越大，滚动速度越慢，滚动距离越小，默认值0.0006
			indicators : true, //是否显示滚动条
			scrollY : true
		});
		var LESSON_STARTTIME="";
		var USER_ID=$("#user_id").html();
		//请假操作按钮
		$('.lessonDetails').click(function() {
			LESSON_STARTTIME=$(this).parent().parent().parent().prev().html();
			$('#popoverLessonDetails').attr('lid',$(this).parent().parent().parent().attr('lid'))
			mui('#popoverLessonDetails').popover('show', this);
		})

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

		$(function() {

			$('#nowDate').html(getNowDate())

			var $numList = $
					.ajax({
						url : '${pageContext.request.contextPath}/teacherHome/getListNumAll.do',
						dataType : 'json'
					})

			//各消息个数
			function getNumList() {
				$.when($numList).done(function(res) {
					$('#allListNum').html(res.numList[0].num)

				}).fail(function() {
					console.log('error')
				})

			}

			//2000毫秒请求一次
			getNumList()
			setInterval(function() {
				getNumList()
			}, 2000)
			
			var COURSE_ID=$("#course_id").html();
			$('#goMessage').on('tap',function() {
				mask.show()
				mask.clickClose=false;
				location.href = '${pageContext.request.contextPath}/teacherin/tologin'
			})
							
							
			$('.zyf_zylr').on('click',function(){
				mask.show()
				mask.clickClose=false;
				location.href= '${pageContext.request.contextPath}/teacherHome/gozylr?LESSONS_ID='+$(this).parent().parent().attr('lid')

			})	
			
			$('.zyf_zyys').on('click',function(){
				
				location.href= '${pageContext.request.contextPath}/teacherHome/gozyys?LESSONS_ID='+$(this).parent().parent().attr('lid')
				+'&COURSE_ID='+COURSE_ID+'&LESSON_STARTTIME='+LESSON_STARTTIME+'&SCHEDULE_TASKTYPE='+'zyys'
				+'&USER_ID='+USER_ID
			})
			
			$('.zyf_eval').on('click',function(){
				mask.show()
				mask.clickClose=false;
				location.href= '${pageContext.request.contextPath}/teacherHome/goeval?LESSONS_ID='+$(this).parent().parent().attr('lid')
			})
	
			$('.zyf_ability').on('click',function(){
				mask.show()
				mask.clickClose=false;
				location.href= '${pageContext.request.contextPath}/teacherHome/goability?LESSONS_ID='+$(this).parent().parent().attr('lid')
				+'&COURSE_ID='+COURSE_ID
			})
			
			
			$('.zyf_dzsj').on('click',function(){
				mask.show()
				mask.clickClose=false;
				location.href= '${pageContext.request.contextPath}/teacherHome/godzsj?LESSONS_ID='
						+$(this).parent().parent().attr('lid')+'&COURSE_ID='+COURSE_ID+'&dlsj='+0
						+'&LESSON_STARTTIME='+LESSON_STARTTIME+'&USER_ID='+USER_ID
			})
			
			$('.zyf_lksj').on('click',function(){
				mask.show()
				mask.clickClose=false;
				location.href= '${pageContext.request.contextPath}/teacherHome/godzsj?LESSONS_ID='
					+$(this).parent().parent().attr('lid')+'&COURSE_ID='+COURSE_ID+'&dlsj='+1
					+'&LESSON_STARTTIME='+LESSON_STARTTIME+'&USER_ID='+USER_ID
			})
			
			$('.zyf_leave').on('click',function(){
				mask.show()
				mask.clickClose=false;
				location.href= '${pageContext.request.contextPath}/teacherHome/goleave?LESSONS_ID='+$(this).parent().parent().attr('lid')
			})
			

		})
	</script>


</body>
</html>