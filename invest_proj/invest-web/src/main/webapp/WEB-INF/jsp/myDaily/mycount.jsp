<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="/common/top.jsp"%>  --%>
<%-- <%@ include file="../weixin/WxChatShare.jsp"%>  --%>
<!doctype html>
<html>

	<head class="mui-bar mui-bar-nav">
		<meta charset="UTF-8">
		<title class="student_name">我的积分</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link href="${pageContext.request.contextPath}/static/wx/css/mui.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/static/wx/css/common.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/static/wx/css/example.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/static/wx/css/stroll.css">
		<script src="${pageContext.request.contextPath}/static/wx/js/mui.min.js"></script>
		<style type="text/css">
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
							可以选择您的孩子姓名来查看不同孩子的各项指标、作业、能力等数值。
						</div>
						<div class="title" style="margin-bottom: 25px;">切换孩子</div>

						<div class="mui-content-padded" style="overflow-y: auto;border-top: 1px solid #525252;height: 250px;padding: 20px 10px;border-radius: 2px;">
							
						</div>
					</div>
				</div>
			</aside>
			<!-- 主页面容器 -->
			<div class="mui-inner-wrap adapt_to_offcanvas">
				<div class="mui-off-canvas-backdrop"></div>
		<!--下拉刷新容器-->
		<div class="mui-content mui-scroll-wrapper main">
		<header class="mui-bar mui-bar-nav" style="background-color: #FFF3DD; width: 10%;">
						<a class="mui-icon mui-action-menu mui-icon-bars mui-pull-left" id="offCanvasShow"></a>
					</header>
			<div class="mui-scroll" style="height: 100%;">
				<div class="mui-content bodystyle">
					<div class="weui-tab new_weui_tab">
						<div class="weui-tab__panel">
							<div class="weui-cell__ft Title" id="test"  style="text-align: center;"></div>
							<div class="img_div">
							
								<img src="${pageContext.request.contextPath}/static/wx/images/jifen_03.png" class="img_jifen_03" />
								<img src="" onerror="this.src='${pageContext.request.contextPath}/static/wx/images/jifen1_03.png'" class="img_jifen1_03" />
							</div>
							<div class='now_data_div'>
								<div class="now_people_div">当前:<span class="now_people_number"></span></div>
								<div class="dream_people_div">心愿:${count}<span class="dream_people_number"></span></div>
								<div class="progressBar">
									<div class="Progress_instruction">
									<div class="Progress_instruction_Top"></div>
										<div class="Progress_instruction_Bottom"></div>
									</div>
									<div class="now_progressBar"></div>
								</div>
								</div>
							</div>

							<!--数据列表-->
							<div class="cc_message_lu" id="refreshContainer2" >
								<div>
								<ul class="list_ul" id="ul_test">
								</ul>
								</div>
							</div>
						</div>
					</div>
				</div></div>
				</div>
			</div>
		</div>
		<script src="${pageContext.request.contextPath}/static/wx/js/jquery-1.8.3.min.js"></script>
		<script src="${pageContext.request.contextPath}/static/wx/js/Second menu.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/wx/js/refresh.js"></script>
		<script type="text/javascript">
			mui.init()
			
			$(function(){
				var countid=0;
				$.ajax({
					url:'${pageContext.request.contextPath }/schoolGetStudent/findStudent',
					datatype:'json',
					type:'post',
					cache : false,
					async : false,
					success : function(data) {
						var students=data.students;
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
			})
			

			$('.mui-btn-outlined').eq(1).toggleClass('mui-btn-primary').children("span:last-child").show()

			function myonload(id) {
				location.href="${pageContext.request.contextPath}/schoolGetStudent/updateDefalutStudent?STUDENT_ID="+id+"&currenturl="+this.location.href;
			}
			
			function createchildbtn(name,id,countid) {
				var str = `<button type="button" class="mui-btn mui-btn-block mui-btn-outlined">
					<span class="studentname">`+name+`</span>
					<span style="display: none;" class="studentid">`+id+`</span>
					<span class="mui-icon mui-icon-checkmarkempty childisselected"></span>
				</button>`
				
				$('.mui-content-padded').eq(0).append(str);
				if(id=="${sessionScope.loginuser.STUDENT_ID}"){
					$('.mui-btn-outlined').eq(countid).toggleClass('mui-btn-primary').children("span:last-child").show()				
				}
				return str
			}

			document.getElementById('offCanvasShow').addEventListener('tap', function() {
				mui('.mui-off-canvas-wrap').offCanvas().show();
			});
		</script>
		<script>
		
			
			//默认第一页	
		    var next=1;
			var count=0;
			//上拉数据处理方法
			function callback_endPullupToRefresh() {
				
				$.ajax({
					url:"${pageContext.request.contextPath}/schoolcourse/integral",
					type:"post",
					dataType:"json",
					data:{"next":next++},
					success:function(data){
						if(data.stateCode=='100'){
							mui.alert(data.prompt);
							mui('#refreshContainer2').pullRefresh().endPullupToRefresh(true);
							return;
						} 
						var message=data.listAbility
						if(data.state==1){
							mui.alert(data.mes);
							mui('#refreshContainer2').pullRefresh().endPullupToRefresh(true);
							return;
						}
						if(count==0&&message.length==0){
							mui.alert("暂未录入您孩子的信息");
							mui('#refreshContainer2').pullRefresh().endPullupToRefresh(true);
							return;
						}else{
							count++;
						}
						for(var i = 0; i < message.length; i++) {
							var ss=message[i].course_time+"["+message[i].NAME+"]"+message[i].course_content
							var jf=message[i].score_value>0?"+"+message[i].score_value:message[i].score_value
							$("<li style='opacity: 1;'></li>").addClass("cc_message_li")
							.append($("<a></a>").addClass("cc_message_li_a prevent_over_a")
							.append(ss)).append($("<span></span>").addClass(message[i].score_value>0?"newspaper_div_right":"newspaper_div_right_error")
							.append("积分"+jf)).appendTo("#ul_test");
							showProgressBar(data.currentScore,${count});
						}
						if(message == "" || message == null || message == undefined){
							mui('#refreshContainer2').pullRefresh().endPullupToRefresh(true)
						}else{
							mui('#refreshContainer2').pullRefresh().endPullupToRefresh(false)
						}
						$(".student_name").html(data.student.STUDENT_NAME+"的积分");
						$("#test").html(data.student.STUDENT_NAME);
						$(".img_jifen1_03").attr("src",data.uploadfPath+data.student.IMG_SRC);
					}
				})
				
			}
			//下拉数据处理方法
			function callback_endPulldownToRefresh() {
				
			}

			//showProgressBar(nowscore+=2, 18913200);

			function showProgressBar(nowpeople, dreampeople) {
				nowpeople = nowpeople || 0;
				dreampeople = dreampeople || 0;
				get("now_people_number")[0].innerText = nowpeople;
				//get("dream_people_number")[0].innerHTML = dreampeople;
				if(nowpeople != 0 && dreampeople != 0) {
					var Speed_of_Progress = (nowpeople / dreampeople * 100).toFixed(2);
					let Progress_width = get('progressBar')[0].offsetWidth;
					let Progress_instruction = get("Progress_instruction")[0];
					let now_progressBar = get('now_progressBar')[0];
					get("Progress_instruction_Top")[0].innerText = (Speed_of_Progress) + "%";
					Progress_instruction.style.left = (Speed_of_Progress / 100 * Progress_width) - 25 + "px";
					now_progressBar.style.width = ((Speed_of_Progress / 100 * Progress_width)) + "px";
				}

				function get(type) {
					return document.getElementsByClassName(type);
				}
			}

			function get(classname) {
				return document.getElementsByClassName(classname);
			}
			createMenu();
		</script>
	</body>

</html>