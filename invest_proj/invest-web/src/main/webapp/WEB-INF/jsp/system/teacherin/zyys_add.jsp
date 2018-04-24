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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/wx/css/mui.picker.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/wx/js/mui.picker.min.js"></script>
<title>课堂小结</title>
<style>
* {
	touch-action: none;
}

p {
	font-size: 15px;
}

#mySwitch {
	margin-left: 80px;
	margin-top: -35px;
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

.student {
	width: 100%;
	height: 100px;
	text-align: center;
	line-height: 100px;
}
</style>
</head>
<body style="background: #FFF3DD;">
	<header class="mui-bar mui-bar-nav">
		<h1 class="mui-title">课堂小结 </h1>
	</header>

	<div class="mui-content" style="background: #FFF3DD;">


		<div class="mui-card" style="margin-top: 20px;">
			<div class="mui-card-header mui-card-media">

				<div class="mui-media-body" style="margin-left: 0px;">
					<h4 style="font-size: 16px;" id="nowDate">4月9日</h4>
				</div>

			</div>
			<div class="mui-card-content" style="height: 490px;">
				<div class="mui-card-content-inner" sid=${lesson.subject_id }
					lid=${lesson.lessons_id } cid=${lesson.course_id }>
					<p>
						科目：<span>${lesson.subject_name }</span>
					</p>
					<p>
						时间：<span><fmt:formatDate
								value="${lesson.lesson_starttime }" pattern="HH:mm" /> - <fmt:formatDate
								value="${lesson.lesson_endtime }" pattern="HH:mm" /></span>
					</p>
					<p>是否达标:
					<div class="mui-input-row mui-checkbox mui-left mui-scroll-wrapper"
						style="width: 100%; height: 160px;">
						<div class="mui-scrol" style="padding-bottom: 20px;" id="course">
							<c:choose>
								<c:when test="${not empty course }">

									<c:forEach items="${course}" var="course">
										<div>
											<div
												style="position: relative; height: 30px; width: 160px; margin-top: 20px;">

												<p style="margin-left: 70px; line-height: 30px; width: 60px">${course.student_name}</p>
												<input name="stucheck" value="${course.student_id}"
													type="checkbox" id="cr" />
											</div>
											<span style="display: none;"><div id="mySwitch"
													class="mui-switch mui-active"
													data-id="${course.student_id}">
													<div class="mui-switch-handle"></div>
												</div> <span>
										</div>

									</c:forEach>
								</c:when>
								<c:otherwise>
									<p class="student">无学生信息</P>
								</c:otherwise>
							</c:choose>
						</div>
					</div>

					</p>


					<p style="margin-top: 10px;">上课内容：
					<div class="mui-input-row" style="margin-top: 10px;">
						<textarea id="schedule_content" type="text" style="height: 150px;"
							placeholder="请输入上课内容"></textarea>
					</div>

					</p>

				</div>

				<div id="stats" style="display: none;"></div>
			</div>
			<div class="mui-card-footer">
				<a class="mui-card-link" style="font-size: 17px;" id="back">返回</a> <a
					style="font-size: 17px;" class="mui-card-link" id="save">保存</a> <a
					style="font-size: 17px;" class="mui-card-link" id="onsave">批量保存</a>

			</div>
		</div>
	</div>


</body>

<script>
mui.init();
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
mui('.mui-switch')['switch']()
var lessons_id = $('div[lid]').attr('lid')
//科目id
var subject_id = $('div[sid]').attr('sid')
//课程id
var course_id = $('div[cid]').attr('cid')
//内容
var schedule_content = $('#schedule_content').val()
//学习时长
var minutes=getTimeDifference('<fmt:formatDate value="${lesson.lesson_starttime }" pattern="yyyy-MM-dd HH:mm:ss" />','<fmt:formatDate value="${lesson.lesson_endtime }" pattern="yyyy-MM-dd HH:mm:ss" />')

var schedule_adopt=''
var adopts=new Array();
var obj =document.getElementsByName("stucheck");
var stu='您选择的学生是：';
var stus = '';
$("[name='stucheck']").click(function(){
	if(this.checked){
		var d_a=$(this).parent().next().children().eq(0)[0];
		$(this).parent().next().children().eq(0).removeClass("mui-active");
		$(this).parent().next().show().children().eq(0).data("id",$(this).attr("value"));
		d_a.addEventListener("toggle",function(event){
			  if(event.detail.isActive){
				  schedule_adopt="0"
				
			  }else{
				  schedule_adopt="1"
					
			  }
			  for(var i=0;i<adopts.length;i++){
				  if(adopts[i].id===$(this).data("id")){
					  adopts[i].switch_id=schedule_adopt
					  break;
				  }
			  }
			  console.log(adopts)
		})
	}else{
		$(this).parent().next().hide().children().eq(0).data("id","");
	}
	
	
	for(var i =0;i<obj.length;i++){
		if(obj[i].checked){
			stu+=obj[i].value+',';
			stus+=obj[i].value+'|';
			
		}
	}
	
	var adopt= $(this).parent().next().children().eq(0).data("id")
	adopts[adopts.length]={
		id:adopt,
		switch_id:"1"
	}

})
	mui('.mui-scroll-wrapper').scroll({
		indicators: true //是否显示滚动条
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


//获取两个日期相差分钟
function getTimeDifference(time1,time2){
		var begin1=time1.substr(0,10).split("-");
		var end1=time2.substr(0,10).split("-");
		var date1=new Date(begin1[1] + - + begin1[2] + - + begin1[0]);
		var date2=new Date(end1[1] + - + end1[2] + - + end1[0]);
		var m=parseInt(Math.abs(date2-date1)/1000/60);
		var min1=parseInt(time1.substr(11,2))*60+parseInt(time1.substr(14,2));
		var min2=parseInt(time2.substr(11,2))*60+parseInt(time2.substr(14,2));
		var n=min2-min1;
		return m+n
}

$(function() {
	var course_id = $('div[cid]').attr('cid')
	var state="";
	/*通过课程查看审核状态  */
	  $.ajax({
		  url:'${pageContext.request.contextPath }/teacherHome/stats',
		data:{"COURSES_ID":course_id},
		type:"POST",
		success:function(data){
			if(data==0){
				$("#stats").html('');
				var option=`<p id="STATE">0</p>`;
				
			$("#stats").append(option)
			}
			
			else{
				$("#stats").html('');
				var option=`<p id="STATE">1</p>`;
				$("#stats").append(option)
				
			}
			
			
			
			state=$("#STATE").html();
			console.log(state)
			
		},
		beforeSend:function(){
			mask.show()
			mask.clickClose=false;
			},
		complete:function(){
			mask.clickClose=true;	
			mask.close()
			}
		
	}); 
	
	$('#nowDate').html(getNowDate())
	$('#back')
			.on(
					'click',
					function() {
						mask.show()
						mask.clickClose=false;
						location.href = "${pageContext.request.contextPath }/teacherHome/tologin"
					})
					
	/* 批量添加学生课堂总结 */				
	$('#onsave').on('click', function() {
		
		if($('#schedule_content').val().length==0||$('#schedule_content').val()==''){
			mui.toast('内容不能为空！')
			return
		}
		
	if(!$("#cr").is(':checked')){
		mui.toast('没有选中学生')
		return
	}

		   $.ajax({
			url:'${pageContext.request.contextPath }/teacherHome/addPiAllzyys',
			data:{"COURSE_ID":course_id,
								"subject_id":subject_id,
								"schedule_content":$('#schedule_content').val(),
								"minutes":minutes,
								"state":state,
								"stus":getstr().id,
								"adopt":getstr().switch_id,
								"LESSON_ID":lessons_id
								},
								beforeSend:function(){
									mask.show()
									mask.clickClose=false;
									},
								complete:function(){
									mask.clickClose=true;	
									mask.close()
									}
		}).done(function(date){

			mui.alert('操作成功!',function(){
				mask.show()
				mask.clickClose=false;
			location.href= '${pageContext.request.contextPath}/teacherHome/gozyys?LESSONS_ID='+lessons_id +'&COURSE_ID='+course_id+'&SCHEDULE_TASKTYPE=zyys'
			
			})

		}).fail(function(){
			mui.alert('error')
		})   
	})
	
	/* 一起添加学生课堂总结 默认是达标*/				
	$('#save').on('click', function() {
		
		if($('#schedule_content').val().length==0||$('#schedule_content').val()==''){
			mui.toast('内容不能为空！')
			return
		}
		$.ajax({
			url:'${pageContext.request.contextPath }/teacherHome/addAllzyys',
			data:{"COURSE_ID":course_id,
								"subject_id":subject_id,
								"schedule_content":schedule_content,
								"minutes":minutes,
								"state":state,
								"LESSON_ID":lessons_id
								},
								beforeSend:function(){
									mask.show()
									mask.clickClose=false;
									},
								complete:function(){
									mask.clickClose=true;	
									mask.close()
									}
		}).done(function(date){
			mui.alert('操作成功！',function(){
				location.href = "${pageContext.request.contextPath }/teacherHome/tologin"
			})
			
		}).fail(function(){
			mui.alert('error')
		})
	})
	
	function getstr(){
		var id='',switch_id='';
		for(var i=0;i<adopts.length;i++){
			id+=(adopts[i].id+"|");
			switch_id+=(adopts[i].switch_id+"|");
		}
		return {
			id:id,
			switch_id:switch_id
		}
	}
})
</script>
</html>