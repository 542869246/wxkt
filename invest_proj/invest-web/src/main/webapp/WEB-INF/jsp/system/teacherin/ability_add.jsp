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

<title>能力值</title>
<style>
* {
	touch-action: none;
}

p {
	font-size: 15px;
}
</style>
</head>
<body style="background: #FFF3DD;">
	<header class="mui-bar mui-bar-nav">
		<h1 class="mui-title">能力值</h1>
	</header>

	<div class="mui-content" style="background: #FFF3DD;">


		<div class="mui-card" style="margin-top: 20px;">
			<div class="mui-card-header mui-card-media">

				<div class="mui-media-body" style="margin-left: 0px;">
					<h4 style="font-size: 16px;" id="nowDate"></h4>
				</div>

			</div>
			<div class="mui-card-content" style="height: 450px;">
				<div class="mui-card-content-inner" sid=${lesson.subject_id }
					lid=${lesson.lessons_id } cid=${lesson.course_id }>
					<p>
						科目:<span>${lesson.subject_name }</span>
					</p>
					<p>
						时间:<span><fmt:formatDate
								value="${lesson.lesson_starttime }" pattern="HH:mm" /> - <fmt:formatDate
								value="${lesson.lesson_endtime }" pattern="HH:mm" /></span>
					</p>
					<p>
						能力值/积分值:
 					<div class="mui-input-row mui-checkbox mui-left mui-scroll-wrapper"style="width: 100%; height: 260px;">
					<ul class="mui-table-view ">
						<c:forEach items="${course}" var="course">
						<li class="mui-table-view-cell mui-collapse ">
						
           					 <a class="mui-navigate-right" href="#">
          
           					 <P>${course.student_name}</P></a>
          					  <div class="mui-collapse-content">
               				
               					 	<c:forEach items="${abilityList }" var="abi">
               					 	<div
										style="position: relative; height: 30px; width: 160px; margin-top: 10px">

										<p style="margin-left:60px;line-height: 35px; width: 60px">
										<input name="stucheck" value="${abi.DICTIONARIES_ID }"
											type="checkbox" id="cr"  />
										${abi.NAME }
										<p style="margin-left: 130px;width: 80px;margin-top: -27px">能
										<input type="number" name="ABILITY_VALUE" value="80"  id="ABILITY_VALUE" maxlength="99" style="width: 60px;height: 20px;">
										
										</p>
										<p style="margin-left: 220px;width: 80px;margin-top: -37px">积
										<input type="number" name="SCORE_VALUE"  value="80" id="SCORE_VALUE" maxlength="99" style="width: 60px;height: 20px;">
										
										</p>
										
										
									</div>
									
               					 	</c:forEach>
               					 <a style="margin-left:89%;font-size: 16px;margin-top:15px;" id="adisave" onclick="adisave('${course.student_id}')">保存</a>
           					 </div>
       					 </li>
       					 
						</c:forEach>
    				</ul>
 					</div>
					</p>
					

				</div>
			<div id="stats" style="display: none;"></div>
			</div>
			<div class="mui-card-footer">
				<a class="mui-card-link" style="font-size: 17px;" id="back">返回</a> <a
					style="font-size: 17px;" class="mui-card-link" id="save">保存</a>
			</div>
		</div>
	</div>


</body>

<script>
	mui.init();

	//补零
	function p(num) {
		return num < 10 ? '0' + num : num;
	}
	mui('.mui-scroll-wrapper').scroll({
		indicators: true //是否显示滚动条
	});
	var adopts=new Array();
	var obj =document.getElementsByName("stucheck");
	var dic='您选择的能力是:';
	var dics = '';
	var stusJson='';
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
	var arr_stu=new Array();
	const arr_name=["自制力","毅力","专注力","创造力","思维能力","社交力","学习能力","想象力","浮夸力"];
function adisave(student_id){
	var arr=new Array();
	/* for(var i =0;i<obj.length;i++){
		if(obj[i].checked){
			dic+=obj[i].value+',';
			dics+=obj[i].value+'|';
		}
	} */
	for(var j=0;j<arr_name.length;j++){
		if($("#adisave").parent().children().eq(j).children().eq(0).children().eq(0)[0].checked){
			arr[arr.length]={
					name:arr_name[j],
					neng:$("#adisave").parent().children().eq(j).children().eq(1).children().eq(0).val(),
					ji:$("#adisave").parent().children().eq(j).children().eq(2).children().eq(0).val(),
					dics:obj[j].value
			}
		}else{
			continue;
		}
	}
	if(arr_stu.length>0){
		for(var k=0;k<arr_stu.length;k++){
			if(student_id==arr_stu[k].student_id){
				arr_stu[k]={student_id:student_id,arr:arr};
			}
			if(k==arr_stu.length-1){
				arr_stu[arr_stu.length]={student_id:student_id,arr:arr};
				k++
			}
		}
	}else{
		arr_stu[arr_stu.length]={student_id:student_id,arr:arr};
	}
	stusJson=JSON.stringify(arr_stu);
	var jsonObj = $.parseJSON(stusJson)
	console.log(stusJson)
	 

}
/* var adopts=new Array();
$("[name='stucheck']").click(function(){
	if(this.checked){
		 for(var i=0;i<adopts.length;i++){
			  if(adopts[i].id===$(this).data("id")){
				  adopts[i].switch_id=schedule_adopt
				  break;
			  }
		  }
		  console.log(adopts)
		
	}
	
	
})
	 */
	
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
		console.log(course_id)
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
				
			}
			
		}); 
		$('#nowDate').html(getNowDate())
		$('#back')
				.on(
						'click',
						function() {
							location.href = "${pageContext.request.contextPath }/teacherHome/tologin"
						})
		$('#save').on('click', function() {
			//科目id
			var subject_id = $('div[sid]').attr('sid')
			//课程id
			var course_id = $('div[cid]').attr('cid')
			//内容
			var schedule_content = $('#schedule_content').val()
			//学习时长
			var minutes=getTimeDifference('<fmt:formatDate value="${lesson.lesson_starttime }" pattern="yyyy-MM-dd HH:mm:ss" />','<fmt:formatDate value="${lesson.lesson_endtime }" pattern="yyyy-MM-dd HH:mm:ss" />')
		
			console.log(minutes)
			$.ajax({
				url:'${pageContext.request.contextPath }/teacherHome/addAllabillity',
				data:{"COURSE_ID":course_id,
									"subject_id":subject_id,
									"minutes":minutes+'',
									"state":state,
									"arr_stu":stusJson
									}
			}).done(function(date){
				mui.alert('操作成功！点击确定返回')
				location.href = "${pageContext.request.contextPath }/teacherHome/tologin"
			}).fail(function(){
				mui.alert('error')
			})
		})
	})
</script>
</html>