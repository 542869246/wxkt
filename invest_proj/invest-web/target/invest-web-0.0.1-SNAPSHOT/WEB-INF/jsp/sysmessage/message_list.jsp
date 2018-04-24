<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<%@ include file="/common/top.jsp"%>

<%@ include file="../weixin/WxChatShare.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.11.3.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/layout.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/basedao.js" ></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bc.css" />
		<style type="text/css">
			.btn_down {
				height: 1rem;
				width: 4rem;
				text-align: center;
				margin: 1rem auto 0;
				display: block;
				font-size: 8px;
				color: #666;
			}

			.btn_down.up {
				transform: rotate(180deg);
				-ms-transform: rotate(180deg); /* IE 9 */
				-moz-transform: rotate(180deg); /* Firefox */
				-webkit-transform: rotate(180deg); /* Safari 和 Chrome */
				-o-transform: rotate(180deg); /* Opera */
			}
</style>
		<title>消息中心</title>
	</head>
	<body>
			<div class="wrapper">
				<div class="message">
					<ul class="nav">
						<li class="cur" id="one">系统消息</li>
						<li id="two">存续信息</li>
					</ul>
					<div class="pages">
						<div class="page" style="display: block;">
							<ul id="sys">
							</ul>
							<input type="hidden" value="1" id="xtcurrentPage" />
							<input type="hidden" id="xttotalPage" />
							<a class="btn_down azx" id="asys" href="javascript:;">加载更多...</a>
						</div>
						<div class="page">
							<ul id="server"></ul>
							<a class="btn_down agw" id="aserver" href="javascript:;">加载更多...</a>
							<input type="hidden" value="1" id="cxcurrentPage" />
							<input type="hidden" id="cxtotalPage" />
						</div>
					</div>
				</div>
			</div>
		<script>
			$(".nav li").on("click",function(){
				var index = $(this).index();
				$(this).addClass("cur").siblings().removeClass("cur");
				$(".page").hide().eq(index).fadeIn();
			})
				//列表展开
			$(".btn_down").on("click",function(){
				//$(this).toggleClass("up").siblings("ul").toggleClass("down");
			})
		</script>
		<script type="text/javascript">
			$(function(){
				var currentPage=$("#xtcurrentPage").val();
				var xttotalPage=$("#xttotalPage").val();
				if(currentPage===xttotalPage){
					$("#xtcurrentPage").val(1);
				}
				aj();
				//系统消息点击事件
				$("#one").bind("click",function(){
					var page=$("#sys");
					//清空
					page.empty();
					$("#xtcurrentPage").val(1);
					$("#asys").text("加载更多...");
					aj();
				});
				//加载更多点击事件事件
				$("#asys").bind("click",function(){
					//获取系统当前页
					var xtcurrentPage=$("#xtcurrentPage").val();
					//获取系统总页数
					var xttotalpage=$("#xttotalPage").val();
					if(xttotalpage>xtcurrentPage){
						xtcurrentPage++;
						$("#xtcurrentPage").val(xtcurrentPage);
						aj();
						//获取当前页
						var xtcurrentPage=$("#xtcurrentPage").val();
						if(xtcurrentPage===xttotalpage){
							$("#asys").text("全部加载完成");
						}
					}
				});
				//未读消息点击事件
				$("body").delegate("#lisys","click",function(){
					//获取当前消息的uuid
					var messageid=$(this).attr("lang");
					read(messageid);
				});
				//点击系统消息进入详细信息页面
				$("body").delegate(".xt","click",function(){
					//获取当前消息的ID
					var messageid=$(this).attr("lang");
					window.location.href="message/single?MESSAGE_ID="+messageid;
				});
				//点击存续列表消息
				$(document).on("click",".liserver",function(){
					//获取当前消息ID
					var messageinfoid=$(this).attr('lang');
					$(this).removeClass("not_read");
					$(this).removeClass("liserver");
					cxread(messageinfoid);
				});
				
				//存续消息点击事件
				$("#two").bind("click",function(){
					var page =$("#server");
					$("#cxcurrentPage").val(1);
						$("#aserver").text("加载更多...");
					page.empty();
					cx();
				});
				//cx消息加载更多
				$("#aserver").bind("click",function(){
					//获取当前页
					var cxcurrent=$("#cxcurrentPage").val();
					var cxcxtotalPage=$("#cxtotalPage").val();
					if(cxcurrent<cxcxtotalPage){
						cxcurrent++;
						$("#cxcurrentPage").val(cxcurrent);
						cx();
						var cxcurrent=$("#cxcurrentPage").val();
						if(cxcurrent===cxcxtotalPage){
							$("#aserver").text("全部加载完成")
						}
					}
				});
			});
				//插入已读
				function read(messageid){
					var setting = {url:'read/save',data:{READ_MESSAGE_ID:messageid}}
					var dao = new BaseDao(setting);
					dao.getResponseData();
				}
				//存续消息插入已读
				function cxread(messageinfoid){
					console.log(messageinfoid);
					var setting = {url:'read/cxsave',data:{READ_MESSAGEINFO_ID:messageinfoid}}
					var dao = new BaseDao(setting);
					dao.getResponseData();
				}
			//时间格式转化
			function getdata(){
				//具体的时间传入
				var date = new Date(arguments[0]);
				//根据修改的显示要求yyyy-MM-dd
				if(arguments.length>1){
					//获取第二个参数
					var param2=arguments[1];
					return date.getFullYear()+param2.charAt(4)+("0"+(date.getMonth()+1)).slice(-2)+
					param2.charAt(7)+("0"+date.getDate()).slice(-2)+param2.charAt(10);
				}else{
					return date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日";
				}
			}
			//ajax调用获取存续信息
			function aj(){
				var currentPage=$("#xtcurrentPage").val();
				var xttotalPage=$("#xttotalPage").val();
				var page={'currentPage':currentPage,'showCount':5,};
				var setting={url:'${pageContext.request.contextPath}/message/list',data:page};
				var dao=new BaseDao(setting);
				//获取值
				var data=dao.getResponseData();
				var page=$("#sys");
				//清空
				//page.empty();
				var str='';
				//循环拼接
				for (var i=0;i<data.varList.length;i++) {
					if(data.varList[i].readcount==1){
						str+="<li class='xt' lang='"+data.varList[i].MESSAGE_ID+"'><input type='hidden' lang='"+data.varList[i].SERVER_STATE+"'/><i></i><h1>"+data.varList[i].SERVER_TITLE+"</h1><label>"+getdata(data.varList[i].SERVER_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].SERVER_CONTENT+"</p></li>";
					}else{
						str+="<li class='not_read xt' id='lisys' lang='"+data.varList[i].MESSAGE_ID+"'><input type='hidden' lang='"+data.varList[i].SERVER_STATE+"'/><i></i><h1>"+data.varList[i].SERVER_TITLE+"</h1><label>"+getdata(data.varList[i].SERVER_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].SERVER_CONTENT+"</p></li>";
					}
				}
				$("#xttotalPage").val(data.page.totalPage);
				page.append(str);
			}
			//ajax调取存续消息
			function cx(){
				var cxcurrent=$("#cxcurrentPage");
				var cxcxtotalPage=$("#cxtotalPage");
				var page={'currentPage':cxcurrent.val(),'showCount':5,};
				var setting={url:'messageinfo/list',data:page};
				var server=$("#server");
				var dao=new BaseDao(setting);
				//获取值
				var data=dao.getResponseData();
				//console.log(data)
				var str='';
				$.each(data.varList,function(i){
				console.log(data.varList[i].MESSAGEINFO_URL);
					if(data.varList[i].readCount==1){
						str+="<a href='messageinfo/getPdfFile?MESSAGEINFO_URL="+data.varList[i].MESSAGEINFO_URL+"' target='_blank'><li><i></i><h1>"+data.varList[i].MESSAGEINFO_TITLE+"</h1><label>"+getdata(data.varList[i].MESSAGEINFO_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].MESSAGEINFO_CONTEXT+"</p></li></a>";
					}else{
						str+="<a href='messageinfo/getPdfFile?MESSAGEINFO_URL="+data.varList[i].MESSAGEINFO_URL+"' target='_blank'><li class='not_read liserver' lang='"+data.varList[i].MESSAGEINFO_ID+"'><i></i><h1>"+data.varList[i].MESSAGEINFO_TITLE+"</h1><label>"+getdata(data.varList[i].MESSAGEINFO_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].MESSAGEINFO_CONTEXT+"</p></li></a>";
					}
				});
				cxcxtotalPage.val(data.page.totalPage);
				server.append(str);
			}
		</script>
	</body>
</html>

