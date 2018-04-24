
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="../weixin/WxChatShare.jsp"%> 
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title><c:if test="${activity_type_id==''}">活动集锦</c:if><c:if test="${activity_type_id=='0'}">趣味英语</c:if><c:if test="${activity_type_id==1}">一周体验</c:if><c:if test="${activity_type_id==2}">活动预告</c:if></title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link href="${pageContext.request.contextPath}/static/wx/css/mui.min.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/wx/css/common.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/static/wx/css/details.css" />
		<script src="${pageContext.request.contextPath}/static/wx/js/Second menu.js"></script>
		<script src="${pageContext.request.contextPath}/static/wx/js/mui.min.js"></script>
		<script src="${pageContext.request.contextPath}/static/wx/js/jquery-1.11.3.min.js"></script>
		<style>
		.mui-table-view:before {
    position: absolute;
    right: 0;
    left: 0;
    height: 0; 
    content: '';
    -webkit-transform: scaleY(.5);
    transform: scaleY(.5);
    background-color: #c8c7cc;
    top: -1px;
}
.mui-table-view:after {
    position: absolute;
    right: 0;
    bottom: 0;
    left: 0;
    height: 0;
    content: '';
    -webkit-transform: scaleY(.5);
    transform: scaleY(.5);
    background-color: #c8c7cc;
}

.zyf_ueditimg{
max-width:100%;
}
table{
	border:1px;
}
th,td{border:1px solid #000000}
		</style>
	</head>

	<body class="main">
<script type="text/javascript">
window.onpageshow=function(e){
    if(e.persisted) {
        window.location.reload() 
    }
};
</script>
	<!-- 主页面容器 -->
		<div class="mui-inner-wrap adapt_to_offcanvas">

			<!--下拉刷新容器-->
			<div class="mui-scroll-wrapper content1" id="refreshContainer" style="position: absolute;top: 0;bottom: 61px;">
				<div class="mui-scroll" style="">

					<!--数据列表-->
					<div id="mycontent" class="mui-table-view mui-table-view-chevron main" style="background-color:#FFF3DD;">
					
						<div class="details_title">
			<div class="details_title_text"></div>
		</div>

		<div class="details_text">
			<div class="details_tabpanel" id="details_connent_nav">
			
			
			</div>
		</div>
		<div class="details_partake">
			<div class="details_partake_button" id="participate_button" onclick="details_partake_button_click()">立即参与</div>
		</div>
		<div class="details_comment">
			<div class="details_comment_div">
				<input type="text" placeholder="写评论......" name="comment_value"></input>
				<div class="details_comment_button" id="comment_value_submit">立即发表</div>
			</div>
		</div>
		<div id="comment_div">
			<div class="comment_nav">
			</div>
		</div>
					</div>
				</div>
			</div>
		</div>
	
	
	
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/wx/js/myAjax.js"></script>
<input type="hidden" id="SERVER_TIME" value="${activity_id}"/>
		<script>
		var navdiv = document.getElementById('comment_div')
		//var count = 0;
		//var i = 0;
		mui.init({
			pullRefresh: {
				container: "#refreshContainer", //待刷新区域标识，querySelector能定位的css选择器均可，比如：id、.class等
				up: {
					height: 50, //可选.默认50.触发上拉加载拖动距离
					auto: true, //可选,默认false.(true自动上拉加载一次)
					contentrefresh: "正在加载...", //可选，正在加载状态时，上拉加载控件上显示的标题内容
					contentnomore: '没有更多数据了', //可选，请求完毕若没有更多数据时显示的提醒内容；
					callback: pullupRefresh //必选，刷新函数，根据具体业务来编写，比如通过ajax从服务器获取新数据；
				}
			}
		});
		$(function() {
			myload();
		})
		 //默认第一页	
	       var next=1;
		function myload(){
			//ajax请求构建
			$.cc.ajax({
				url: "${pageContext.request.contextPath}/schoolactivity/goActivityDetails",
				type:"post",
				dataType:"json",
				data:{
					"activity_id":"${activity_id}",
					"next":next
					},
				success: function(data) {
					if(data.pdActivity.ACTIVITY_STATE==1){
					$(".details_partake").css('display','none');
					}
				var details_connent =data.pdActivity.ACTIVITY_CONTENT;
				$(".details_title_text").html(data.pdActivity.ACTIVITY_TITLE);
				build_activity_connent(details_connent);
					var commentList=data.pdComment;
					for(var i=0;i<commentList.length;i++){
						var newDate=new Date(commentList[i].CRITICISM_TIME);
						newDate=newDate.toLocaleDateString()+" "+newDate.toLocaleTimeString().substring(0, newDate.toLocaleTimeString().lastIndexOf(':'));
						var uname =commentList[i].pduser==null?"匿名人":commentList[i].pduser.USERS_WECHAT_NICKNAME==null?"匿名人":commentList[i].pduser.USERS_WECHAT_NICKNAME;
						var createtime =newDate;
			             var userHeadImg =commentList[i].pduser.USERS_PHOTO;
			             var comment_connent = htmlDecodeJQ(commentList[i].CRITICISM_CONTENT);
			             var replayConnent = commentList[i].REPLY_CONTENT;
			             build_comment_val(uname, userHeadImg, createtime, comment_connent, replayConnent,false)
				   }
					
				}
			})
		}
		
		 
			
			//上拉数据处理方法
		function pullupRefresh() {
			setTimeout(function() {
				$.ajax({
					url: "${pageContext.request.contextPath}/schoolactivity/goActivityDetails",
					type:"post",
					dataType:"json",
					data:{
						"activity_id":"${activity_id}",						
						"next":++next
					},
					success:function(data){
						mui('#refreshContainer').pullRefresh().endPullupToRefresh(data.pdComment.length<6);
						var commentList=data.pdComment;
						for(var i=0;i<commentList.length;i++){
							var newDate=new Date(commentList[i].CRITICISM_TIME);
							newDate=newDate.toLocaleDateString()+" "+newDate.toLocaleTimeString().substring(0, newDate.toLocaleTimeString().lastIndexOf(':'));
							var uname =commentList[i].pduser==null?"匿名人":commentList[i].pduser.USERS_WECHAT_NICKNAME==null?"匿名人":commentList[i].pduser.USERS_WECHAT_NICKNAME;
							var createtime =newDate;
				             var userHeadImg =commentList[i].pduser.USERS_PHOTO;
				             var comment_connent = htmlDecodeJQ(commentList[i].CRITICISM_CONTENT);
				             var replayConnent = commentList[i].REPLY_CONTENT;
				             build_comment_val(uname, userHeadImg, createtime, comment_connent, replayConnent,false)
					   }
						
					}
				});
			}, 1500);
		}
			//立即发布按钮提交与保存事件
			$('#comment_value_submit').on('tap', function() {
				if(!checkUser()) return false;
				if(!checkInput())return false;
				mui.confirm("是否发布评论", "选择", ["取消", "确定"], function(e) {
					if(e.index == 1) {
						var inputvalue=$("input[name=comment_value]").val();
						inputvalue=htmlEncodeJQ(inputvalue);
						mui.toast("评论发布成功!", {
							duration: 'long',
							type: 'div'
						})
						$("input[name=comment_value]").val("");
						$.cc.ajax({
							url: "${pageContext.request.contextPath}/schoolactivity/saveComment",
							type:"post",
							dataType:"json",
							data:{
								"ACTIVITY_ID":"${activity_id}",
								"CRITICISM_CONTENT":inputvalue,
								},
							success: function(data) {
								var newDate=new Date(data.CRITICISM_TIME);
								newDate=newDate.toLocaleDateString()+" "+newDate.toLocaleTimeString().substring(0, newDate.toLocaleTimeString().lastIndexOf(':'));
								 var uname =data.pduser==null?"匿名人":data.pduser.USERS_WECHAT_NICKNAME==null?"匿名人":data.pduser.USERS_WECHAT_NICKNAME;
					             var createtime =newDate;
					             var userHeadImg =data.pduser.USERS_PHOTO;
					             var comment_connent = data.CRITICISM_CONTENT;
					             var replayConnent="";
					             build_comment_val(uname, userHeadImg, createtime, comment_connent, replayConnent,true)
					             
							}
						})
						
					} else {
						return false;
					}
				});
			})
			
			
			//判断用户是否注册登录
			   function checkUser(){
				var flag=false;
				$.ajax({
					url:"${pageContext.request.contextPath}/schoolactivity/isLogin",
					async: false,
					success:function(data){
						 if(data=="error"){
							location.href="${pageContext.request.contextPath}/course/goToReg";
							flag=false;
						}else{
							flag=true;
						} 
					}
				})
				return flag;
			}  
			
			
			//评论框的提交验证
			function checkInput() {
				var inputvalue = $("input[name=comment_value]").val();
				if(inputvalue == "" || inputvalue == null || inputvalue == undefined) {
					mui.toast("请输入评论", {
						duration: 'long',
						type: 'div'
					})
					return false;
				} else {
					return true;
				}
			}

			//立即参与事件（跳转到用户绑定的页面）
			$('.details_partake').on('tap', function(){
				mui.confirm("参加活动前需要录入您的联系信息！", "选择", ["取消", "确定"], function(e) {
					if(e.index == 1) {
						location.href="${pageContext.request.contextPath}/activity/goActivitySign?activity_id="+"${activity_id}";
					}
				})
			})
			

			//解析构建活动内容块
			function build_activity_connent(details_connent) {
				details_connent = details_connent || "暂无活动详细内容，有关活动具体信息请联系我们"
				let details_p_top = $("<div></div>").addClass("details_p_top").append(details_connent);
				let details_connent_nav = $("#details_connent_nav");
				details_p_top.appendTo(details_connent_nav);
				$('#details_connent_nav').find('img').addClass('zyf_ueditimg')
			}

			//时间差处理函数
			function computeDate(startTime, endTime) {
				var stime = new Date(startTime.replace(/-/g, "\/"));
				var etime = new Date(endTime.replace(/-/g, "\/"));
				return(etime - stime) / (24 * 60 * 60 * 1000)
			}

			//解析JSON并构建评论块(参数为：用户昵称、用户头像、评论时间、评论内容、管理员的回复内容,true:評論/false)
			function build_comment_val(uname, userHeadImg, createtime, comment_connent, replayConnent,istop) {
				//用户微信昵称
				uname = uname || "我在山的那边";
				//回复内容
				replayConnent = replayConnent || "";

				//评论内容
				comment_connent = comment_connent || $("input[name=comment_value]").val();
				//用户的微信头像
				userHeadImg = userHeadImg || "${pageContext.request.contextPath}/static/wx/img/shulin.jpg";

				//回复人(默认为作者[管理员]回复)
				var replayName = "管理员回复";
				//评论发布时间(当前时间)
				var da = new Date();
				var reg = new RegExp("/", "g"); //g,表示全部替换(将时间中的/替换为-)。
				createtime = createtime.replace(reg, '-') || da.toLocaleDateString().replace(reg, '-') + " " +
					da.toLocaleTimeString().substring(0, da.toLocaleTimeString().lastIndexOf(':'));

				//回复时间(调用的计算函数，得出回复时间距离现在时间的时间差(天为单位))
				var tresult = computeDate(createtime.substring(0, createtime.indexOf(" ")), da.toLocaleDateString());
				var replayTime = (tresult <= 1 ? "今天" : tresult + "天前");
				//var replayTime = tresult;
				//头像块构建
				var comment_div = $("#comment_div")
				let comment_nav = $("<div></div>").addClass("comment_nav");
				let comment_nav_head = $("<div></div>").addClass("comment_nav_head");
				let comment_nav_headimg = $("<img></img>").addClass("comment_nav_headimg").attr("src", userHeadImg);

				//评论块构建
				let comment_nav_font = $("<div></div>").addClass("comment_nav_font");
				let ul = $("<ul></ul>");
				let comment_title = $("<div></div>").addClass("comment_title");
				let comment_nav_font_ul_time = $("<span></span>").addClass("comment_nav_font_ul_time").append(createtime);
				let comment_nav_font_ul_uname = $("<li></li>").addClass("comment_nav_font_ul_uname").append(uname).append(comment_nav_font_ul_time);
				let comment_nav_font_ul_connent = $("<li></li>").addClass("comment_nav_font_ul_connent").append(comment_connent);
				comment_title.append(comment_nav_font_ul_uname).append(comment_nav_font_ul_time);
				let div2 = comment_nav_font.append(ul.append(comment_title).append(comment_nav_font_ul_connent));
				//回复块构建
				let comment_reply = $("<div></div>").addClass("comment_reply");
				let reply_ul = $("<div></div>");
				let comment_reply_ul_respondent = $("<li></li>").addClass("comment_reply_ul_respondent comment_reply_ul_comment").append(replayName);
				let comment_reply_ul_respondent_connent = $("<li></li>").addClass("comment_reply_ul_respondent_connent").append(replayConnent);
				let comment_reply_ul_comment = $("<li></li>").addClass("comment_reply_ul_comment").append(replayTime);
				//追加评论回复（根据ajax的数据来选择是否追加回复块）
				if(replayConnent != "") {
					let replay = comment_reply.append(reply_ul.append(comment_reply_ul_respondent).append(comment_reply_ul_respondent_connent).append(comment_reply_ul_comment));
					div2.append(replay);
				}
				//追加最新的评论到评论块的第一条
				let div = comment_nav.append(comment_nav_head.append(comment_nav_headimg));
				div.append(div2)
				if(istop){
					div.prependTo(comment_div);
				}else{
					div.appendTo(comment_div);
				}
				
				return createtime;
			}
			createMenu();
			function htmlEncodeJQ ( str ) {  
			    return $('<span/>').text( str ).html();  
			}  
			function htmlDecodeJQ ( str ) {  
			    return $('<span/>').html( str ).text();  
			}  
		</script>
	</body>

</html>