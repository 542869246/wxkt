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

<title>学生评价</title>
<style>
* {
	touch-action: none;
}

p {
	font-size: 15px;
}

.zyf_stats {
	display: block; 
	z-index: 1;
	top: 0px;
	right: 0;
	width: 59px;
	height: 59px;
	color: #999;
	position: absolute;
	text-align: center;
}

.mui-icon-help,.mui-icon-checkmarkempty {
	font-size: 30px;
	display: block; 
	margin:2px auto 0;
	z-index: 1;
	width: 40px;
	height: 40px;
	text-align: center;
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
		<h1 class="mui-title">学生评价</h1>
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
					<p>学生：</p>
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
					style="font-size: 17px;" class="mui-card-link" id="save">保存</a>
			</div>
		</div>
	</div>


</body>

<script>
	mui.init();
	mui('.mui-scroll-wrapper').scroll({
		deceleration: 0.0005 //flick 减速系数，系数越大，滚动速度越慢，滚动距离越小，默认值0.0006
	});

	//补零
	function p(num) {
		return num < 10 ? '0' + num : num;
	}
	mui('.mui-scroll-wrapper').scroll({
		deceleration: 0.0005 //flick 减速系数，系数越大，滚动速度越慢，滚动距离越小，默认值0.0006
	});
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
		console.log(lesson_id)
		$('#nowDate').html(getNowDate())
		
		function showAll(){
			
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
				
				//排序所有学生
				//未评价的学生在前面展示
				//返回负数则a在b前
				//返回正数b在a之前
				//返回0 b=a
				date.allList2.sort(function(a,b){
					//返回第一个符合条件的数组元素的位置，如果所有元素都不符合条件，则返回-1。 
					var isEval = date.evalList.findIndex(function(value,index,arr){
						return value.STUDENT_ID==a.student_id	
					})
					//如果a<0 则为未评价，返回-1 a排在b之前
					if(isEval<0){
						return -1
					}else{
						return 1
					}
					
				})
				
				$('#OA_task_1').html("")
				var str=``
				//遍历所有学生
				$.each(date.allList2,function(index,item){
					var eval
					//当前学生是否评价
					$.each(date.evalList,function(index1,item1){  
						if(item1.STUDENT_ID==item.student_id){
							eval=item1
						}
					})
					
					
					str+=`<li class="mui-table-view-cell mui-media leave_list" `+(typeof(eval) == "undefined"?'':'eid='+eval.EVALUATE_ID)+` sid=`+item.student_id+`>
					
						<div class="mui-input-row mui-checkbox mui-left">
						<span class='zyf_stats' >
							<span class=`+(typeof(eval) == "undefined"?"'mui-icon mui-icon-help'":"'mui-icon mui-icon-checkmarkempty'")+`></span>
							<span style='font-size:12px;'>`+(typeof(eval) == "undefined"?'未评价':'已评价')+`</span>
						</span>
						<label style='padding-left:8px;'><p style="font-size:15px;color:black;" class="mui-ellipsis">`+item.student_name+`</p></label>
						

					
					
					
					<div class="mui-slider-handle">
			<div class="mui-table">
				<div class="mui-table-cell mui-col-xs-10">
					<p style="padding-left:8px;" class="mui-h6 mui-ellipsis leavecause">`+(typeof(eval) == "undefined"?'点击录入评价内容':'评价内容：' +eval.EVALUATE_CONTENT)+`</p>
				</div>
			</div>
					</div>
					
					</div>
					
				</li>`
				})
				if(date.allList2==0){
					str=`<br/><center><p>无数据</p></center>`
				}
				
				$('#OA_task_1').html(str)
				
			})
			.fail(function(){
				mui.alert('数据加载失败，请刷新')
			})	
			
		}
		
		showAll()
		
		$('#back')
				.on(
						'click',
						function() {
							mask.show()
							mask.clickClose=false;
							location.href = '${pageContext.request.contextPath}/teacherHome/tologin'
						})
			
		
		
		//点击录入请假原因
		$('.leavecause').off('click').on('click', bindListClick);
		
		function bindListClick(e){
			var $self = $(this)
			//e.detail.gesture.preventDefault(); //修复iOS 8.x平台存在的bug，使用plus.nativeUI.prompt会造成输入法闪一下又没了
			var btnArray = ['确定', '取消'];
			
			var strLength=$self.text().length
			var oldstr = ''
			if($self.text()!='点击录入评价内容'){
				oldstr = $self.text().substring(5,strLength)
			}
			
			mui.prompt('请输入评价内容', '评价内容(25字内)', '提示', btnArray, function(e) {
				if (e.index == 0) {
					if(e.value.length>25){
						mui.alert('字数越界！')
						$self.html('点击录入评价内容')
						return
					}
					if(e.value.length<1){
						mui.alert('评价内容为空，不做任何操作！')
						//$self.html('点击录入评价内容')
						return
					}

					var ic = $self.parent().parent().parent().parent().find('.zyf_stats').children(':first')
					var isAdd = ic.hasClass('mui-icon-help')//后台判断新增&修改
					
					
					var sid = $self.parent().parent().parent().parent().parent().attr('sid')//学生id
					var eid =  $self.parent().parent().parent().parent().parent().attr('eid')//评价id
					
					$.ajax({
						url:'${pageContext.request.contextPath}/teacherHome/evaladd',
						data:{
							isAdd:isAdd,
							EVALUATE_CONTENT:e.value,
							EVALUATE_ID:eid,
							STUDENT_ID:sid,
							LESSONS_ID:lesson_id
						},
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
						if(ic.hasClass('mui-icon-help')){
							ic.removeClass('mui-icon-help')
							ic.addClass('mui-icon-checkmarkempty')
							ic.next().text('已评价')
						}
						mui.toast('编辑成功')
						showAll()
						$('.leavecause').off('click').on('click', bindListClick);
						//slocation.href='${pageContext.request.contextPath}/teacherHome/goeval?LESSONS_ID='+lesson_id
					})
					.fail(function(){
				
						mui.toast('编辑失败')
					})
					
					
					
					
					$self.html('评价内容：' + e.value)
				} else {
					//$self.html('点击录入请假原因')
				}
			},'div')
			//回显之前的值
			document.querySelector('.mui-popup-input input').value=oldstr
			
		}
		
		$('#save').hide()
		//保存
		$('#save').on('click', function() {
			
			var model='{"leaves":['
			var length = $('#OA_task_1>li>div input').length
			var checkedNum=0
			for(var i=0;i<length;i++){
				if($('#OA_task_1>li>div input')[i].checked){
					checkedNum++
					var $checkedStu = $($('#OA_task_1>li>div input')[i])
					//请假理由
					var leavecause = $checkedStu.next().find('.leavecause').text()
					var strLength = leavecause.length
					
					
					if(leavecause=='点击录入评价内容'){
						mui.toast('必须录入评价内容！')
						return
					}
					
					
					
					leavecause=leavecause.substring(5,strLength)
					//学生id
					var sid = $checkedStu.attr('sid')
					//console.log(leavecause,sid,lesson_id)
					if(model=='{"leaves":[') model += '{"student_id":"'+sid+'","lessons_id":"'+lesson_id+'","leavecause":"'+leavecause+'","leavedate":"'+new Date().getTime()+'"}'
				  	else model += ',' + '{"student_id":"'+sid+'","lessons_id":"'+lesson_id+'","leavecause":"'+leavecause+'","leavedate":"'+new Date().getTime()+'"}'
						
				}
				
			}
			model+=']}'
			console.log(model)
			if(model!='{"leaves":[]}'){
				$.ajax({
					url:'${pageContext.request.contextPath }/teacherHome/addLeaveAll',
					data:{model:model},
					beforeSend:function(){
						mask.show()
						mask.clickClose=false;
						},
					complete:function(){
						mask.clickClose=true;	
						mask.close()
						}
				}).done(function(date){
					mui.alert('添加成功!',function(){
						location.href = "${pageContext.request.contextPath }/teacherHome/goleaveadd?COURSES_ID="+course_id+"&lessons_id="+lesson_id
					})
					//location.href = "${pageContext.request.contextPath }/teacherHome/tologin"
				}).fail(function(){
					mui.alert('error')
				})
			}
			
			
			if(checkedNum==0){
				mui.toast('至少选择一个学生')
				return
			}
			
			
			

		})
	})
</script>
</html>