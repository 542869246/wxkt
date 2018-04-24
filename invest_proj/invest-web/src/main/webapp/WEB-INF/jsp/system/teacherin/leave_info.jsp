<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@ include file="/common/top.jsp"%> 
<%@ include file="../../weixin/WxChatShare.jsp"%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1 user-scalable=no">
<link
	href="${pageContext.request.contextPath }/static/wx/css/mui.min.css"
	rel="stylesheet" />
<script
	src="${pageContext.request.contextPath }/static/wx/js/mui.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/wx/css/example.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/wx/css/stroll.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/static/wx/css/app.css">
<script
	src="${pageContext.request.contextPath }/static/wx/js/jquery-1.8.3.min.js"></script>

<title>请假信息</title>
<style>
* {
	touch-action: none;
}

p {
	font-size: 15px;
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
</head>
<body style="background: #FFF3DD;">
	<header class="mui-bar mui-bar-nav">
		<h1 class="mui-title">请假信息</h1>
	</header>

	<div class="mui-content"
		style="background: #FFF3DD; position: absolute; bottom: 0px; top: 0px; left: 0px; right: 0px;">


		<div class="mui-card"
			style="position: absolute; bottom: 10px; top: 50px; left: 0px; right: 0px;">
			<div class="mui-card-header mui-card-media">

				<div class="mui-media-body" style="margin-left: 0px;">
					<h4 style="font-size: 16px;" id="nowDate"></h4>
				</div>

			</div>
			<div class="mui-card-content"
				style="position: absolute; top: 60px; bottom: 60px; right: 0px; left: 0px;">
				<div class="mui-card-content-inner"
					style="position: absolute; left: 0px; right: 0px; top: 0px; bottom: 0px;"
					sid=${lesson.subject_id } lid=${lesson.lessons_id }
					cid=${lesson.course_id }>
					<p>
						科目：<span>${lesson.subject_name }</span>
					</p>
					<p>
						时间：<span><fmt:formatDate
								value="${lesson.lesson_starttime }" pattern="HH:mm" /> - <fmt:formatDate
								value="${lesson.lesson_endtime }" pattern="HH:mm" /></span>
					</p>
					<p>请假的学生：</p>
					<div class="mui-scroll-wrapper"
						style="top: 105px; right: 0px; left: 0px;">
						<div class="mui-scroll">
							<ul id="OA_task_1" class="mui-table-view">

							</ul>
						</div>
					</div>

				</div>

			</div>
			<div class="mui-card-footer"
				style="position: absolute; bottom: 0px; left: 0px; right: 0px;">
				<a class="mui-card-link" style="font-size: 17px;" id="back">返回</a> <a
					style="font-size: 17px;" class="mui-card-link" id="save">添加请假</a>
			</div>
		</div>
	</div>


</body>

<script>
	mui.init();
	mui('.mui-scroll-wrapper').scroll({
		deceleration: 0.0005 //flick 减速系数，系数越大，滚动速度越慢，滚动距离越小，默认值0.0006
	});
	var mask = mui.createMask(function () {
		var flushStr=`<div class="mui-pull-top-pocket mui-block">
		<div class="mui-pull">
		<div class="mui-pull-loading mui-icon mui-spinner"></div>
		<div class="mui-pull-caption"><p style="font-size: 13px;">loading...</p></div>
		<div class="mui-pull-caption"><p style="font-size: 13px;">懂得静观大地开花结果的人</p></div>
		<div class="mui-pull-caption"><p style="font-size: 13px;">决不会为失去的一切而痛心</p></div>
		</div></div>`
		$(".mui-backdrop").html(flushStr);
        return mask.clickClose;;
    })
	mask.show()
	mask.clickClose = false;
    mask.clickClose=true;
	mask.close();
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
		
		//科目id
		var subject_id = $('div[sid]').attr('sid')
		//课程id
		var course_id = $('div[cid]').attr('cid')
		//lessonid
		var lesson_id = $('div[lid]').attr('lid')
		console.log( 'course_id:'+course_id,'lessons_id:'+lesson_id,'subject_id:'+subject_id)
		$('#nowDate').html(getNowDate())
		
		$.ajax({
			url:"${pageContext.request.contextPath }/teacherHome/listJSON?COURSES_ID="+course_id+"&lessons_id="+lesson_id,
			async:false,
			beforeSend:function(){
				mask.show()
				mask.clickClose=false;
				},
			complete:function(){
				mask.clickClose=true;	
				mask.close()
				}
		})
		.done(function(date){
			$('#OA_task_1').html("")
			var str=``
			$.each(date.leaveList,function(index,item){
				
				str+=`<li class="mui-table-view-cell mui-media leave_list" >
				
				<div class="mui-slider-handle">
<div class="mui-table">
			<div class="mui-table-cell mui-col-xs-10">
				<h4 style="font-size:14px;" class="mui-ellipsis">学生姓名：`+item.student_name+`</h4>
			</div>
		</div>
		<div class="mui-table">
			<div class="mui-table-cell mui-col-xs-10">
				<p class="mui-h6 mui-ellipsis">请假原因：`+item.leavecause+`</p>
			</div>
		</div>
				</div>
			</li>`
			})
			if(date.leaveList==0){
				str=`<br/><center><p>无数据</p></center>`
			}
			
			$('#OA_task_1').html(str)
		})
		.fail(function(){
			
			mui.alert('数据加载失败，请刷新')
		})
		$('#back')
				.on(
						'click',
						function() {
							mask.show()
							mask.clickClose=false;
							location.href = "${pageContext.request.contextPath }/teacherHome/tologin"
						})
						
						
		$('#save').on('click', function() {
			mask.show()
			mask.clickClose=false;
			location.href = "${pageContext.request.contextPath }/teacherHome/goleaveadd?COURSES_ID="+course_id+"&lessons_id="+lesson_id
			
		})
	})
</script>
</html>