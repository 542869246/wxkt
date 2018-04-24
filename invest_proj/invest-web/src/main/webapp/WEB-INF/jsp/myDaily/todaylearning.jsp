<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ include file="/common/top.jsp"%> --%>
<%-- <%@ include file="../weixin/WxChatShare.jsp"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title class="student_name">今日学习</title>
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link
	href="${pageContext.request.contextPath}/static/wx/css/mui.min.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/wx/css/common.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/wx/css/font-awesome-4.7.0/css/font-awesome.min.css" />
<!--日期样式-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/wx/css/mui.picker.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/wx/css/todaylearning.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/wx/js/jquery-1.8.3.min.js"></script>
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
				color: #bbb;
				text-indent: 1em;
				font-size: 14px;
				line-height: 24px;
			}
			
			.mui-table-hover {
				background-color: #3B3B3B;
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

<body>

	<!-- 侧滑导航根容器 -->
		<div class="mui-off-canvas-wrap mui-draggable">
			<!-- 菜单容器 -->
			<aside class="mui-off-canvas-left">
				<div class="mui-scroll-wrapper">
					<div class="mui-scroll">
						<div class="title">提示详情</div>
						<div class="content">
							可以选择您的孩子姓名来查看不同孩子的学习情况
						</div>
						<div class="title" style="margin-bottom: 25px;">切换孩子</div>

						<div class="mui-content-padded" style="overflow-y: auto;border-top: 1px solid #525252;height: 250px;padding: 20px 10px;border-radius: 2px;">
							<!-- 学生数据 -->
						</div>
					</div>
				</div>
			</aside>
			<!-- 主页面容器 -->
			<div class="mui-inner-wrap adapt_to_offcanvas">

	<div class="mui-content">
		<div class="search">
			<div style="height: 1px;"></div>
			<header class="mui-bar mui-bar-nav">
						<a class="mui-icon mui-action-menu mui-icon-bars mui-pull-left" id="offCanvasShow"></a>
			</header>
			<div class="mui-input-row search_bor">
				<input type="text" class="search_input" placeholder="2014-11-19"
					style="border: none;"> <i class="fa fa-search search_ico"
					aria-hidden="true"></i>

			</div>
		</div>
	<!-- id,name~ -->
		<div class="mui-scroll-wrapper content1" id="pullrefresh">
						<div class="mui-scroll">
							<div id="mycontent" class="main_content mui-table-view">
								<div id="">
								<span id="azz"></span>
							</div>
							</div>
						</div>
					</div>

				</div>
				<div class="mui-off-canvas-backdrop"></div>
			</div>
		</div>
	<script
		src="${pageContext.request.contextPath}/static/wx/js/mui.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/wx/js/todaylearning.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/wx/js/Second menu.js"></script>
	<!--日期js-->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/wx/js/mui.picker.min.js"></script>
	<script type="text/javascript">
		var count=0;
			var btns = mui('.search_input');
			btns.each(function(i, btn) {
				btn.addEventListener('tap',function(){　
					var dtPicker = new mui.DtPicker({　　　　
						"type": "date"　　　
					});　　
					dtPicker.show(function(rs){
						$(".search_input").attr("placeholder",rs.text);
						loaddata(rs.text);
					});　
				}, false);
			});

			mui.init({
				pullRefresh: {
					container: "#pullrefresh", //下拉刷新容器标识，querySelector能定位的css选择器均可，比如：id、.class等
					down: {
						height: 50, //可选,默认50.触发下拉刷新拖动距离,
						auto: false, //可选,默认false.首次加载自动下拉刷新一次
						contentdown: "下拉可以刷新", //可选，在下拉可刷新状态时，下拉刷新控件上显示的标题内容
						contentover: "释放立即刷新", //可选，在释放可刷新状态时，下拉刷新控件上显示的标题内容
						contentrefresh: "正在刷新...", //可选，正在刷新状态时，下拉刷新控件上显示的标题内容
						callback: pulldownRefresh
					}
				}
			});
			function pulldownRefresh() {
				count=0;
				count++;
				setTimeout(function() {
					var time=GetDateStr(count);
					$(".search_input").attr("placeholder",time);
					var table = document.body.querySelector('.mui-table-view');
					var cells = document.body.querySelectorAll('.mui-table-view-cell');
					//for (var i = cells.length, len = i + 4; i < len; i++) {
					var aaa = (Math.ceil(Math.random() * 2) + 1) == 2 ? true : false;
					//let workjson1="";
					var teach="";
					var createtime="";
					$.ajax({
						url:'${pageContext.request.contextPath }/schoolcourse/goDaily',
						datatype:'json',
						data:'SCHEDULE_DATETIME='+time,
						type:'post',
						cache : false,
						async : false,
						success : function(data) {
							<c:if test="${sessionScope.loginuser != null}">
							if(data[0].state == 1){
								if(data[0].message=="您的孩子，当天没有学习日程"){
									mui.alert("您的孩子，上一天沒有学习日程", "提示", "确定");
									return;
								}else{
									mui.alert(data[0].message, "提示", "确定");
									return;
								}
							} 							
							</c:if>
							//console.log(data)
							//遍历所有消息
							for(var ii in data){
								//console.log(data[ii])
								//一条消息
								var message = data[ii]
								//遍历一条消息的所有作业
								if(message.type=='student'){
									$(".student_name").html(message.STUDENT_NAME+"的日程");
									continue
								}
								if(message.SCHEDULE_TASKTYPE==""||message.SCHEDULE_TASKTYPE==null||typeof(message.SCHEDULE_TASKTYPE)==undefined){
												continue;
								}
								//如果到达时间为空时则不会显示
								if(message.SCHEDULE_TASKTYPE=="3"||message.SCHEDULE_TASKTYPE=="4"){
									if(message.ARRIVELEAVETIME==""||message.ARRIVELEAVETIME==null){
										continue;								
									}
								}
								var workjson = '{'
									workjson +='work'+ ii +':{'
									if(message.SCHEDULE_TASKTYPE=="3"||message.SCHEDULE_TASKTYPE=="4"){
											var arriveLeavetime=new Date();
											arriveLeavetime.setTime(message.ARRIVELEAVETIME);
											workjson += 'content:"' +arriveLeavetime.Format("yyyy-MM-dd HH:mm:ss")+"</br>"
									}else{
										 workjson += 'name:"' +message.SUBJECTNAME+ '",'
										 workjson += 'time:"' +message.SCHEDULE_TIMEDIFF+ '",'
										workjson += 'isok:"' +message.SCHEDULE_ADOPT+ '",'
										workjson += 'content:"' +message.SCHEDULE_CONTENT								
									}
									workjson += '"}'
								workjson += '}'
								if(workjson!=null){
									//message.SCHEDULE_TASKTYPE,message.dictionarpd.NAME,eval('(' + workjson + ')'), message.sys_users_name,message.SCHEDULE_DATETIME,ii))
									if(message.dictionarpd!=undefined){
									var li =mycreatemessage(message.SCHEDULE_TASKTYPE,message.dictionarpd.NAME,eval('(' + workjson + ')'), message.sys_users_name,message.SCHEDULE_DATETIME,ii);
									table.insertBefore(li, table.firstChild);
									}
								} 
							}
						}
					});
					mui('#pullrefresh').pullRefresh().endPulldownToRefresh(); //refresh completed
				}, 1000);
			}
			document.getElementById('offCanvasShow').addEventListener('tap', function() {
				mui('.mui-off-canvas-wrap').offCanvas().show();
			});
		</script>

	<script type="text/javascript">
	
	//点击孩子，获得该孩子的id并关闭侧边栏进入主页面的myonload方法，根据id刷新该孩子的信息
	


	//$('.mui-btn-outlined').eq(1).toggleClass('mui-btn-primary').children("span:last-child").show()
	
	
	function myonload(id) {
		if(id!= null && id!= "" &&typeof(id)!=undefined){
			location.href="${pageContext.request.contextPath}/schoolGetStudent/updateDefalutStudent?STUDENT_ID="+id+"&currenturl="+this.location.href;			
		}
	}
	//createchildbtn('asdsad',12312321)
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
	
	
		$(function(){
			loadStudents();
			loaddata();
		});
		function loadStudents(){
			var date=new Date();
			$(".search_input").attr("placeholder",date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate());//设置默认显示为当前时间
			var countid=0;
			$.ajax({
				url:'${pageContext.request.contextPath }/schoolGetStudent/findStudent',
				datatype:'json',
				type:'post',
				cache : false,
				async : false,
				success : function(data) {
					var students=data.students;
					//console.log(students);
					for(var i=0;i<students.length;i++){
						createchildbtn(students[i].STUDENT_NAME,students[i].STUDENT_ID,countid++);
					}
					$('.mui-btn').on('tap', function() {
						$('.mui-btn').children("span:last-child").hide()
							$(this).children("span:last-child").show()
							$(this).parent().children().removeClass('mui-btn-primary')
							$(this).toggleClass('mui-btn-primary')
						window.myonload($(this).children('span').eq(1).text())
						mui('.mui-off-canvas-wrap').offCanvas().close()
					})
				}
			})
		}
		function loaddata(time){
			var datatime=time==null||time==''||time==undefined?$(".search_input").val():time;
			getId('mycontent').innerHTML="";
			let workjson1="";
			$.ajax({
				url:'${pageContext.request.contextPath }/schoolcourse/goDaily',
				datatype:'json',
				data:'SCHEDULE_DATETIME='+datatime,
				type:'post',
				cache : false,
				async : false,
				success : function(data) {
					<c:if test="${sessionScope.loginuser != null}">
					if(data[0].state == 1){
						if(data[0].message=="您的孩子，当天没有学习日程"){
							return;
						}else{
							mui.alert(data[0].message, "提示", "确定");
							return;
						}
					} 							
					</c:if>
					//console.log(data)
					//遍历所有消息
					for(var ii in data){
						//console.log(data[ii])
						//一条消息
						var message = data[ii]
						//遍历一条消息的所有作业
						if(message.type=='student'){
							$(".student_name").html(message.STUDENT_NAME+"的日程");
							continue
						}
						if(message.SCHEDULE_TASKTYPE==""||message.SCHEDULE_TASKTYPE==null||typeof(message.SCHEDULE_TASKTYPE)==undefined){
							continue;
						}
						//如果到达时间为空时则不会显示
						if(message.SCHEDULE_TASKTYPE=="3"||message.SCHEDULE_TASKTYPE=="4"){
							if(message.ARRIVELEAVETIME==""||message.ARRIVELEAVETIME==null){
								continue;								
							}
						}
						var arriveLeavetime=new Date();
						var workjson = '{'
							workjson +='work'+ ii +':{'
							if(message.SCHEDULE_TASKTYPE=="3"||message.SCHEDULE_TASKTYPE=="4"){
								arriveLeavetime.setTime(message.ARRIVELEAVETIME);
								workjson += 'content:"' +arriveLeavetime.Format("yyyy-MM-dd HH:mm:ss")+"</br>"
							}else{
								 workjson += 'name:"' +message.SUBJECTNAME+ '",'
								 workjson += 'time:"' +message.SCHEDULE_TIMEDIFF+ '",'
								workjson += 'isok:"' +message.SCHEDULE_ADOPT+ '",'
								workjson += 'content:"' +message.SCHEDULE_CONTENT								
							}
							workjson += '"}'
						workjson += '}'
						if(workjson!=null){
							if(message.dictionarpd!=undefined){
								var diname=message.dictionarpd.NAME;
								getId('mycontent').appendChild(mycreatemessage(message.SCHEDULE_TASKTYPE,diname,eval('(' + workjson + ')'), message.sys_users_name,message.SCHEDULE_DATETIME,ii))
							}
						} 
					}
				}
			});
		}
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
			 function GetDateStr(AddDayCount) {
				 var search_input=$('.search_input').attr("placeholder");
				 search_input=search_input.replace(/-/g,':').replace(' ',':');
				 search_input=search_input.split(':');
			     var dd = new Date(search_input[0],(search_input[1]-1),search_input[2]); 
			     dd.setDate(dd.getDate()-AddDayCount);//获取AddDayCount天后的日期 
			     var y = dd.getFullYear(); 
			     var m = dd.getMonth()+1;//获取当前月份的日期 
			     var d = dd.getDate(); 
			     return y+"-"+m+"-"+d; 
			} 
			 window.createMenu();
		</script>
</body>

</html>