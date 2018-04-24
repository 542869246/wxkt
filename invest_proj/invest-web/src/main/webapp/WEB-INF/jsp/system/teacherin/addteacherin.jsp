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
	width: 25%;
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
	height: 40px;
	margin-top: 0px;
	border-radius: 5px;
	line-height: 38px;
	box-shadow: 2px 2px 20px 5px #F1E0CE;
	position: relative;
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
	line-height: 38px;
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

.mui-badge {
	position: absolute;
	right: 0px;
	top: 3px;
}
</style>

<title>教师操作</title>
</head>

<body>

	<div class="mui-content">
		<div id="slider" class="mui-slider"
			style="position: absolute; top: 0px; bottom: 0px; left: 0px; right: 0px;">
			<div id="sliderSegmentedControl" style="height: 60px;"
				class="mui-slider-indicator mui-segmented-control mui-segmented-control-inverted">
				<a class="mui-control-item" href="#item1mobile"
					style="height: 60px; line-height: 60px;"> 日报管理 <span
					class="mui-badge mui-badge-primary">99+</span>
				</a> <a class="mui-control-item" href="#item2mobile"> 请假管理 <span
					class="mui-badge mui-badge-purple">99+</span>
				</a> <a class="mui-control-item" href="#item3mobile"> 学生评价 <span
					class="mui-badge mui-badge-danger">99+</span>
				</a> <a class="mui-control-item" href="#item4mobile"> 能力值 <span
					class="mui-badge mui-badge-danger">99+</span>
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
						<div class="mui-scroll">




							<form class="mui-input-group" style="background-color: #FFF3DD;">
								<input type="hidden"
									value="${sessionScope.loginteacher.USER_ID}" id="teaid">

								<div class="details_comment "
									style="margin-top: 5px; background-color: #FFF3DD;">
									<div class="details_comment_div">
										<select id="coursesel"
											style="font-size: 10px; text-indent: 8px; height: 100%; margin-top: 0px; width: 80%;"
											onchange='btnCoursesel(this[selectedIndex].text)'>
											<option value="0" selected="selected">点击选择课程</option>
											<c:if test="${requestScope.courses != null }">
												<c:forEach items="${requestScope.courses}" var="course">
													<option value="${course.COURSES_ID}">${course.COURSES_NAME }</option>
												</c:forEach>
											</c:if>
										</select>
										<div class="zyf_takein_btn" id="">选择课程</div>
									</div>
								</div>
								<div class="details_comment mui-input-row"
									style="margin-top: 5px; background-color: #FFF3DD;">
									<div class="details_comment_div">
										<div class="zyf_takein_btn">评价时间</div>
										<input id="SCHEDULR_INPUTTIME" type="text"
											class="search_input" placeholder="点击选择时间"
											style="border: none;" required="required">
									</div>
								</div>

								<div class="details_comment "
									style="margin-top: 5px; background-color: #FFF3DD;">
									<div class="details_comment_div">
										<select id="SCHEDULE_TASKTYPE"
											onchange='btnChange(this[selectedIndex].text,this[selectedIndex].value);'
											style="font-size: 10px; text-indent: 8px; height: 100%; margin-top: 0px; width: 80%;">
											<option value="0">请选择作业类型</option>
											<c:forEach items="${schList }" var="sch">
												<option value="${sch.BIANMA }">${sch.NAME }</option>
											</c:forEach>
										</select>
										<div class="zyf_takein_btn" id="">作业类型</div>
									</div>
								</div>
								<div class="details_comment "
									style="margin-top: 5px; background-color: #FFF3DD;">
									<div class="details_comment_div">
										<select id="subject"
											style="font-size: 10px; text-indent: 8px; height: 100%; margin-top: 0px; width: 80%;">
											<option value="0">点击选择科目</option>
										</select>
										<div class="zyf_takein_btn" id="">选择科目</div>
									</div>
								</div>
								<div class="details_comment mui-input-row"
									style="margin-top: 5px; background-color: #FFF3DD;">
									<div class="details_comment_div">
										<div class="zyf_takein_btn">到达时间</div>
										<input id="ARRIVELEAVETIME" type="text" class="search_input1"
											placeholder="点击选择时间" style="border: none;"
											required="required">
									</div>
								</div>
								<div class="details_comment mui-input-row"
									style="margin-top: 5px; background-color: #FFF3DD;">
									<div class="details_comment_div">
										<div class="zyf_takein_btn" id="">学习时长</div>
										<input type="number" class="mui-input-clear"
											placeholder="请输入学习时长/分" maxlength="32" id="SCHEDULE_TIMEDIFF"
											required="required" />
									</div>
								</div>

								<div class="details_comment mui-input-row"
									style="margin-top: 5px; background-color: #FFF3DD;">
									<div class="details_comment_div">
										<div class="zyf_takein_btn" id="">学习内容</div>
										<input type="text" class="mui-input-clear"
											placeholder="请输入学习内容" maxlength="32" id="SCHEDULE_CONTENT"
											required="required" />
									</div>
								</div>

								<div class="details_comment "
									style="margin-top: 5px; background-color: #FFF3DD;">
									<div class="details_comment_div">
										<select id="SCHEDULE_ADOPT"
											style="font-size: 10px; text-indent: 8px; height: 100%; margin-top: 0px; width: 80%;">
											<option value="">请选择是否达标</option>
											<option value="0">达标</option>
											<option value="1">不达标</option>
										</select>
										<div class="zyf_takein_btn" id="">是否达标</div>
									</div>
								</div>


								<!-- 			<div class="details_comment mui-input-row" style="margin-top: 5px;"> -->
								<!-- 				<div class="details_comment_div"> -->
								<!-- 					<div class="zyf_takein_btn" id="comment_value_submit">评语</div> -->
								<!-- 					<input type="text" class="mui-input-clear" maxlength="100" placeholder="选中学生输入评语" id="pingyu" required="required"/> -->
								<!-- 				</div> -->
								<!-- 			</div> -->

								<div style="margin-left: 20px; margin-top: 10px;">
									<div style="width: 84%; margin-left: 5.5%;" class="stusee"
										id="showstus">
										<div class="mui-input-row mui-checkbox mui-left ">
											<label
												style="color: red; width: 100%; margin-left: 10px; margin-top: 3px;"
												id="labletishi">选择课程获得学生信息</label>
										</div>
									</div>
								</div>

								<div id="stats" style="display: none;"></div>
								<div class="details_partake">
									<div class="details_partake_button" id="reg" onclick="reg()">确认</div>
								</div>
							</form>

						</div>
					</div>
				</div>
				<div id="item2mobile" class="mui-slider-item mui-control-content">
					<div id="scroll2" class="mui-scroll-wrapper"
						style="background-color: #FFF3DD;">
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
						<div class="mui-scroll">
							<div class="mui-loading">
								<div class="mui-spinner"></div>
							</div>
						</div>
					</div>
				</div>
				<div id="item4mobile" class="mui-slider-item mui-control-content">
					<div id="scroll4" class="mui-scroll-wrapper"
						style="background-color: #FFF3DD;">
						<div class="mui-scroll">
							<div class="mui-loading">
								<div class="mui-spinner"></div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>

		<div id="stats" style="display: none;"></div>

	</div>
	<script
		src="${pageContext.request.contextPath}/static/wx/js/mui.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/wx/js/mui.picker.min.js"></script>
	<script>
			mui.init({
				swipeBack: false
			});

			$('.mui-scroll-wrapper').scroll({
				indicators: true //是否显示滚动条
			});
			var item2 = document.getElementById('item2mobile');
			var item3 = document.getElementById('item3mobile');
			var item4 = document.getElementById('item4mobile');
			document.getElementById('slider').addEventListener('slide', function(e) {
				if(e.detail.slideNumber === 1) {
					//					if(item2.querySelector('.mui-loading')) {
					setTimeout(function() {
						//item2.querySelector('.mui-scroll').innerHTML = html2;
						$.ajax({
							type: "get",
							url: "${pageContext.request.contextPath}/static/html/leave.html",
							dataType: 'html',
							async: true,
							success: function(res) {
								//console.log(res)
								//item2.querySelector('.mui-scroll').innerHTML = res;
								$(item2.querySelector('.mui-scroll')).html(res)
								
							}
						});
					}, 500);
					//					}
				} else if(e.detail.slideNumber === 2) {
					//					if(item3.querySelector('.mui-loading')) {
					setTimeout(function() {
						//item3.querySelector('.mui-scroll').innerHTML = html3;
						$.ajax({
							type: "get",
							url: "${pageContext.request.contextPath}/static/html/studentevaluation.html",
							dataType: 'html',
							async: true,
							success: function(res) {
								//console.log(res)
								$(item3.querySelector('.mui-scroll')).html(res)

							}
						});
					}, 500);
					//					}
				} else if(e.detail.slideNumber === 3) {
					//					if(item4.querySelector('.mui-loading')) {
					setTimeout(function() {
						//item4.querySelector('.mui-scroll').innerHTML = html4;
						$.ajax({
							type: "get",
							url: "${pageContext.request.contextPath}/static/html/ability.html",
							dataType: 'html',
							async: true,
							success: function(res) {
								//console.log(res)
								$(item4.querySelector('.mui-scroll')).html(res)
							}
						});
					}, 500);
					//					}
				}
			});

			 var btns = mui('.search_input');
			console.log(btns.length)
			btns.each(function(i, btn) {
				btn.addEventListener('tap', function() {　
					var dtPicker = new mui.DtPicker({　　　　
						"type": "date"　　　
					});　　
					dtPicker.show(function(rs) {
						$(".search_input").attr("placeholder", rs.text);
						loaddata(rs.text);
					});　
				}, false);
			});
			 
			function btnCoursesel(values){
				if(values=='点击选择课程'){
					$("#subject").parent().parent().hide();		
					$("#SCHEDULE_ADOPT").parent().parent().hide();
					$("#ARRIVELEAVETIME").parent().parent().hide();
					$("#SCHEDULE_TIMEDIFF").parent().parent().hide();
					$("#SCHEDULE_CONTENT").parent().parent().hide();
					$("#subject").val("0");
					$("#ARRIVELEAVETIME").val("");
					$("#SCHEDULE_ADOPT").val("");
					$("#SCHEDULE_TIMEDIFF").val("");
					$("#SCHEDULE_CONTENT").val("");
					$("#SCHEDULE_TASKTYPE").val("0");
					
				}
				
				 var c=$("#coursesel").val();
					console.log(c);
					  $.ajax({
						url:'${pageContext.request.contextPath }/teacherin/stats',
						data:{"COURSES_ID":c},
						type:"POST",
						success:function(data){
							if(data==0){
								$("#stats").html('');
								var option=`<tr><td>
							<input type="text" value="1" id="STATE" name="STATE"/>
								</td></tr>`;
								
							$("#stats").append(option)
							}
							
							else{
								$("#stats").html('');
								var option=`<tr>
									<td>            
									<input type="text" value="0" id="STATE" name="STATE"/>
								</td></tr>`;
								$("#stats").append(option)
								
							}
						}
						
					});  
			}
			//选择作业类型
			function btnChange(typeName,values){
				$("#subject").parent().parent().hide();		
				$("#SCHEDULE_ADOPT").parent().parent().hide();
				$("#ARRIVELEAVETIME").parent().parent().hide();
				$("#SCHEDULE_TIMEDIFF").parent().parent().hide();
				$("#SCHEDULE_CONTENT").parent().parent().hide();
				$("#subject").val("0");
				$("#ARRIVELEAVETIME").val("");
				$("#SCHEDULE_ADOPT").val("");
				$("#SCHEDULE_TIMEDIFF").val("");
				$("#SCHEDULE_CONTENT").val("");
				 var courseid = $("#coursesel").val();
				 var currentTime =new Date().Format("yyyy-MM-dd HH:mm");
				if(values=="zylr"){
					if(courseid==0){
						mui.alert("请先选择课程");
						$("#SCHEDULE_TASKTYPE option").eq(0).attr("selected",true);
						return;
					}				
					$("#SCHEDULE_TIMEDIFF").parent().parent().show();
					$("#SCHEDULE_CONTENT").parent().parent().show();
					$("#subject").parent().parent().show();		
					<c:if test="${requestScope.courses != null }">
						<c:forEach items="${requestScope.courses}" var="course">
							if("${course.COURSES_ID}"==courseid){
								$("#subject option").eq(0).siblings().remove();
								<c:forEach items="${course.subjectList}" var="subject">	
								$('#subject').append('<option value="${subject.SUBJECT_ID}">${subject.SUBJECT_NAME}</option>');
								</c:forEach>
							}
						</c:forEach>
					</c:if>
				}else
				if(values=="zyys"){
					if(courseid==0){
						mui.alert("请先选择课程");
						$("#SCHEDULE_TASKTYPE option").eq(0).attr("selected",true);
						return;
				}
					$("#SCHEDULE_ADOPT").parent().parent().show();
					$("#SCHEDULE_TIMEDIFF").parent().parent().show();
					$("#SCHEDULE_CONTENT").parent().parent().show();
					$("#subject").parent().parent().show();		
					<c:if test="${requestScope.courses != null }">
						<c:forEach items="${requestScope.courses}" var="course">
							if("${course.COURSES_ID}"==courseid){
								$("#subject option").eq(0).siblings().remove();
								<c:forEach items="${course.subjectList}" var="subject">	
								$('#subject').append('<option value="${subject.SUBJECT_ID}">${subject.SUBJECT_NAME}</option>');
								</c:forEach>
							}
						</c:forEach>
					</c:if>
				}else
				if(values=="3"){
					$("#ARRIVELEAVETIME").val(currentTime);
					$("#ARRIVELEAVETIME").siblings(".zyf_takein_btn").text(typeName)
					$("#ARRIVELEAVETIME").parent().parent().show();
				} else
				if(values=="4"){
					$("#ARRIVELEAVETIME").val(currentTime);
					$("#ARRIVELEAVETIME").siblings(".zyf_takein_btn").text(typeName)
					$("#ARRIVELEAVETIME").parent().parent().show();
				}else{
					$("#SCHEDULE_CONTENT").parent().parent().show();
				}
			}
			<!--日期-->
			var btns = mui('.search_input');//评价时间
			btns.each(function(i, btn) {
				btn.addEventListener('tap',function(){　
					var dtPicker = new mui.DtPicker({
						"type": "datetime",
						beginDate: new Date(1996, 12, 20),//设置开始日期 
					    endDate: new Date(2100, 12, 20)//设置结束日期 　　　
					});　　
					dtPicker.show(function(rs){
						$('.search_input').val(rs.text)
						dtPicker.dispose();
					});
				}, false);
			}); 
			var btns1 = mui('.search_input1');//到达时间
			btns1.each(function(i, btn) {
				btn.addEventListener('tap',function(){　
					var dtPicker = new mui.DtPicker({
						"type": "datetime",
						beginDate: new Date(1996, 12, 20),//设置开始日期 
					    endDate: new Date(2100, 12, 20)//设置结束日期 　　　
					});　　
					dtPicker.show(function(rs){
						$('.search_input1').val(rs.text)
						dtPicker.dispose();
					});
				}, false);
			});
			
			 mui.init();  
			$(function(){
				init();
				
				$("#leave").click(function(){
					location.href="${pageContext.request.contextPath }/leave/goleave"
				})
			})
			function init(){
				$("#subject").parent().parent().hide();
				$("#SCHEDULE_ADOPT").parent().parent().hide();
				$("#ARRIVELEAVETIME").parent().parent().hide();
				$("#SCHEDULE_TIMEDIFF").parent().parent().hide();
				$("#SCHEDULE_CONTENT").parent().parent().hide();
			}
			$("#coursesel").bind("change",function(){
//		 		alert($("#coursesel").val());
//		 		alert($("#coursesel").find("option:selected").text());
				getStudents();
			})
		Date.prototype.Format = function (fmt) { //author: meizz   
				//var time2 = new Date().Format("yyyy-MM-dd HH:mm:ss");
		    var o = {  
		        "M+": this.getMonth() + 1, //月份   
		        "d+": this.getDate(), //日   
		        "H+": this.getHours(), //小时   
		        "m+": this.getMinutes(), //分   
		        "s+": this.getSeconds(), //秒   
		        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
		        "S": this.getMilliseconds() //毫秒   
		    };  
		    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
		    for (var k in o)  
		    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
		    return fmt;  
		}  
			
		    
			 function getStudents(){
				 var courseid = $("#coursesel").val();
				 $(".studentNo").remove();
				 if(courseid ==0){
					 return false;}
				 $.ajax({
						type : "POST",
						url : '${pageContext.request.contextPath }/teacherin/getStudents',
						data : {
							COURSE_ID:courseid
						},
						traditional : true,
						dataType : 'json',
						cache : false,
						success : function(data) {
							var strVar = "";
							for(var i=0;i<data.stus.length;i++){
								//data.stus[i].STUDENT_NAME  data.stus[i].STUDENT_ID
//		 						alert(data.stus[i]);
								var studentname = data.stus[i].STUDENT_NAME;
								var studentid = data.stus[i].STUDENT_ID;
								  strVar += "<div class=\"mui-input-row mui-checkbox mui-left studentNo\" style=''line-height:40px;\">";
								    strVar += "	<label style=\"width: 100%; margin-left: 30px;\">";
								    strVar += studentname;
								    strVar += "<\/label>";
								    strVar += "<input name=\"stucheck\" ";
								    strVar += "	value=\"";
								    strVar += studentid;
								    strVar += "\" type=\"checkbox\">";
								    strVar += "<\/div>";
							}
							$("#showstus").append(strVar);
						}
				 })
			}
			 function reg() {
					var SCHEDULE_TIMEDIFF = $.trim($("#SCHEDULE_TIMEDIFF").val());
					var SCHEDULE_CONTENT = $.trim($("#SCHEDULE_CONTENT").val());
					var SCHEDULR_INPUTTIME = $.trim($("#SCHEDULR_INPUTTIME").val());
					var SCHEDULE_TASKTYPE = $.trim($("#SCHEDULE_TASKTYPE").val());
					var ARRIVELEAVETIME = $.trim($("#ARRIVELEAVETIME").val());//到达时间
					var subject=$.trim($("#subject").val());
					var typeName=$.trim($("#SCHEDULE_TASKTYPE").text());;
					var CREATEBY = $.trim($("#teaid").val());
					var SCHEDULE_ADOPT = $.trim($("#SCHEDULE_ADOPT").val());
					var coursesel = $.trim($("#coursesel").val());
					var STATE=$.trim($("#STATE").val());
				//	alert(SCHEDULE_TIMEDIFF+"  "+SCHEDULE_CONTENT+"  "+SCHEDULR_INPUTTIME+"  "+SCHEDULE_TASKTYPE+"  "+SCHEDULE_ADOPT+"  1")
					if(coursesel==0){
						mui.alert("请选择课程");
						return false;
					}
					if(SCHEDULR_INPUTTIME==""){
						mui.alert("请选择时间");
						return false;
					}
					
					if(SCHEDULE_TASKTYPE=="" ||SCHEDULE_TASKTYPE==0){
						mui.alert("请作业类型");
						return false;
					}
					if(SCHEDULE_TASKTYPE=="zylr"){
						if(subject==0){
							mui.alert("请选择科目");
							return false;
						}
						if(SCHEDULE_TIMEDIFF==""){
							mui.alert("请输入学习时长");
							return false;
						}
						if(SCHEDULE_CONTENT==""){
							mui.alert("请输入学习内容");
							return false;
						}
					}
					if(SCHEDULE_TASKTYPE=="zyys"){
						if(subject==0){
							mui.alert("请选择科目");
							return false;
						}
						if(SCHEDULE_TIMEDIFF==""){
							mui.alert("请输入学习时长");
							return false;
						}
						if(SCHEDULE_CONTENT==""){
							mui.alert("请输入学习内容");
							return false;
						}
						if(SCHEDULE_ADOPT==""){
							mui.alert("请输入是否达标");
							return false;
						}
					}
					if(SCHEDULE_TASKTYPE=="3" || SCHEDULE_TASKTYPE=="4"){
						if(ARRIVELEAVETIME==""){
							mui.alert("请选择"+typeName);
							return false;
						}
					}
					var obj =document.getElementsByName("stucheck");
					var stu='您选择的学生是：';
					var stus = '';
					for(var i =0;i<obj.length;i++){
						if(obj[i].checked){
							stu+=obj[i].value+',';
							stus+=obj[i].value+'|';
						}
					}
//		 			stu=stu.substring(0,stu.length-1);
					if(stu=='您选择的学生是：'){
						mui.alert("您还没有选择学生");
						return false;
					}
//		 			mui.alert(stu=='您选择的学生是：'?"您还没有选择学生":stu.substring(0,stu.length-1));
					stus=stus.substring(0,stus.length-1);
					$.ajax({
								type : "POST",
								url : '${pageContext.request.contextPath }/teacherin/getreg',
								data : {
		                             SCHEDULE_TIMEDIFF     :  SCHEDULE_TIMEDIFF     ,
		                             SCHEDULE_CONTENT      :  SCHEDULE_CONTENT      ,
		                             ARRIVELEAVETIME    :  ARRIVELEAVETIME	  ,
									 SCHEDULE_INPUTTIME :  SCHEDULR_INPUTTIME ,
									 SCHEDULE_TASKTYPE  :  SCHEDULE_TASKTYPE  ,
									 stus               :  stus               ,
									 SUBJECT_ID			:	subject			  ,
									 SCHEDULE_ADOPT     :  SCHEDULE_ADOPT     ,
									 COURSES_ID          :  coursesel          ,
									 CREATEBY:CREATEBY,
									 STATE:STATE
								},    
								dataType : 'json',
								cache : false,
								success : function(data) {
									 if ("error" == data.msg) {
										mui.confirm("对不起,龟速网络导致接收不到信息啦!", "提示",["返回","确定"], function(e){
											if(e.index==0){
												window.location.reload();
											}
										});
									} else if ("ok" == data.msg) {
										mui.alert("添加成功,重新加载页面!", "提示", function(e){
											if(e.index==0){
												//location.href="${pageContext.request.contextPath}/activity/goActivityInfo?activity_id="+activity_id;
												window.location.reload();
											}
										});
									} 
								}
							});
				}
				
		</script>


</body>
</html>