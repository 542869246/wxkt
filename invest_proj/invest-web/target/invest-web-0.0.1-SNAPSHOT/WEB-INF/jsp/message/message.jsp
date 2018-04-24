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
		<base href="<%=basePath%>">
		<meta charset="UTF-8">
		<meta name="viewport" content="wispanh=device-wispanh,initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
		<META HTTP-EQUIV="Expires" CONTENT="0">
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
		<script type="text/javascript">
		$(function(){
			pushHistory();
			//苹果手机返回按钮触发事件
			window.addEventListener("popstate", function(e) { 
				window.location.href="<%=basePath%>/userinfo/toUserCentre";
			}, false);
			//安卓手机返回按钮触发事件
			function pushHistory() { 
				var state = { 
					title: "title", 
					url: "userinfo/toUserCentre"
				}; 
				window.history.pushState(state, "title", state.url); 
			} 
		});
			
		</script>
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
					var xttotalPage=$("#xttotalPage").val();
					var xtcurrentpage=$("#xtcurrentPage").val();
					if(xtcurrentpage==xttotalPage){
						$("#asys").text("全部加载完毕");
					}
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
							$("#asys").text("全部加载完毕");
						}
					}
				});
				
				//未读消息点击事件
				$(document).on("click","#lisys",function(){
					//获取当前消息的uuid
					var messageid=$(this).attr("lang");
					$(this).removeClass('not_read');
					read(messageid);
				});
				//存续消息点击事件
				$("#two").bind("click",function(){
					
					var dao=new BaseDao({"url":"message/getuserrenzheng"});
					var result=dao.getResponseData();
					//console.info(result);
					if(result.USER_ATTESTATION==0){
						open('message/tospace','_self');
						return false;
					}else{
						var page =$("#server");
						$("#cxcurrentPage").val(1);
						$("#aserver").text("加载更多...");
						page.empty();
						cx();	
					}
					
				});
				//cx消息加载更多
				$("#aserver").bind("click",function(){
					//获取当前页
					var cxcurrent=$("#cxcurrentPage").val();
					var cxtotalPage=$("#cxtotalPage").val();
					if(cxcurrent<cxtotalPage){
						cxcurrent++;
						$("#cxcurrentPage").val(cxcurrent);
						cx();
						var cxcurrent=$("#cxcurrentPage").val();
						if(cxcurrent===cxtotalPage){
							$("#aserver").text("全部加载完毕")
						}
					}else if(cxcurrent==cxtotalPage){
						$("#aserver").text("全部加载完毕")
					}
				});
			});
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
			//ajax调用获取系统消息
			function aj(){
				var currentPage=$("#xtcurrentPage").val();
				var xttotalPage=$("#xttotalPage").val();
				var page={'currentPage':currentPage,'showCount':5,};
				var setting={url:'message/list',data:page};
				var dao=new BaseDao(setting);
				//获取值
				var data=dao.getResponseData();
				var page=$("#sys");
				//清空
				//page.empty();
				var str='';
				//循环拼接
				for (var i=0;i<data.varList.length;i++) {
					if(data.varList[i].readcount>=1){
						str+="<a href='${pageContext.request.contextPath}/message/single?MESSAGE_ID="+data.varList[i].MESSAGE_ID+"'><li class='xt' lang='"+data.varList[i].MESSAGE_ID+"'><input type='hidden' lang='"+data.varList[i].SERVER_STATE+"'/><i></i><h1>"+data.varList[i].SERVER_TITLE+"</h1><label>"+getdata(data.varList[i].SERVER_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].SERVER_CONTENT+"</p></li></a>";
					}else{
						str+="<a href='${pageContext.request.contextPath}/message/single?MESSAGE_ID="+data.varList[i].MESSAGE_ID+"&READ_MESSAGE_ID="+data.varList[i].MESSAGE_ID+"'><li class='not_read xt' id='lisys' lang='"+data.varList[i].MESSAGE_ID+"'><input type='hidden' lang='"+data.varList[i].SERVER_STATE+"'/><i></i><h1>"+data.varList[i].SERVER_TITLE+"</h1><label>"+getdata(data.varList[i].SERVER_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].SERVER_CONTENT+"</p></li></a>";
					}
				}
				$("#xttotalPage").val(data.page.totalPage);
				if(data.page.totalPage==data.page.currentPage){
					$("#asys").text("全部加载完毕");
				}
				if(data.varList==""){
					$("#asys").text("您还没有系统消息");
				}
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
				var str='';
				var set={url:'messageinfo/single'};
				var base=new BaseDao(set);
				var result=base.getResponseData();
				$.each(data.varList,function(i){
					var isok=false;
						if(data.varList[i].readCount>=1){							
							if(data.varList[i].MESSAGEINFO_STATE==0 && isok==false){
								str+="<a href='${pageContext.request.contextPath}/messageinfo/getPdfFile?MESSAGEINFO_ID="+data.varList[i].MESSAGEINFO_ID+"' target='_blank'><li><i></i><h1>"+data.varList[i].MESSAGEINFO_TITLE+"</h1><label>"+getdata(data.varList[i].MESSAGEINFO_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].MESSAGEINFO_CONTEXT+"</p></li></a>";
									isok=true;
							}else if(data.varList[i].MESSAGEINFO_STATE==1 && isok==false){
								$.each(result.info,function(j) {
									if(data.varList[i].MESSAGEINFO_INFORMATION_ID==result.info[j].INFORMATION_ID){
										str+="<a href='${pageContext.request.contextPath}/messageinfo/getPdfFile?INFORMATION_ID="+result.info[j].INFORMATION_ID+"' target='_blank'><li><i></i><h1>"+data.varList[i].MESSAGEINFO_TITLE+"</h1><label>"+getdata(data.varList[i].MESSAGEINFO_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].MESSAGEINFO_CONTEXT+"</p></li></a>";
										isok=true;
									}
								});
							}
						}else{
								if(data.varList[i].MESSAGEINFO_STATE==0 && isok==false){
								str+="<a onclick='clearclass(this)' href='${pageContext.request.contextPath}/messageinfo/getPdfFile?MESSAGEINFO_ID="+data.varList[i].MESSAGEINFO_ID+"&READ_MESSAGEINFO_ID="+data.varList[i].MESSAGEINFO_ID+"' target='_blank'><li class='not_read' id='liserver' lang='"+data.varList[i].MESSAGEINFO_ID+"'><i></i><h1>"+data.varList[i].MESSAGEINFO_TITLE+"</h1><label>"+getdata(data.varList[i].MESSAGEINFO_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].MESSAGEINFO_CONTEXT+"</p></li></a>";
								isok=true;
							}else if(data.varList[i].MESSAGEINFO_STATE==1 && isok==false){
								$.each(result.info, function(j) {
									if(data.varList[i].MESSAGEINFO_INFORMATION_ID==result.info[j].INFORMATION_ID){
										str+="<a onclick='clearclass(this)' href='${pageContext.request.contextPath}/messageinfo/getPdfFile?INFORMATION_ID="+result.info[j].INFORMATION_ID+"&READ_MESSAGEINFO_ID="+data.varList[i].MESSAGEINFO_ID+"' target='_blank'><li class='not_read' id='liserver' lang='"+data.varList[i].MESSAGEINFO_ID+"'><i></i><h1>"+data.varList[i].MESSAGEINFO_TITLE+"</h1><label>"+getdata(data.varList[i].MESSAGEINFO_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].MESSAGEINFO_CONTEXT+"</p></li></a>";
										isok=true;
									}
								});
							}
						}
				});
				cxcxtotalPage.val(data.page.totalPage);
				if(data.page.totalPage==data.page.currentPage){
					$("#aserver").text("全部加载完毕");
				}
				if(str==""){
					$("#aserver").text("你还没有存续消息!")
				}
				server.append(str);
			}

			
			
			/* function cx(){
				var cxcurrent=$("#cxcurrentPage");
				var cxcxtotalPage=$("#cxtotalPage");
				var page={'currentPage':cxcurrent.val(),'showCount':5,};
				var setting={url:'${pageContext.request.contextPath}/messageinfo/list',data:page};
				var server=$("#server");
				var dao=new BaseDao(setting);
				//获取值
				var data=dao.getResponseData();
				var str='';
				var set={url:'${pageContext.request.contextPath}/messageinfo/single'};
				var base=new BaseDao(set);
				var result=base.getResponseData();
				$.each(data.varList,function(i){
					var isok=false;
					$.each(result.info, function(j) {
						if(data.varList[i].readCount>=1){
							if(data.varList[i].MESSAGEINFO_STATE==0 && isok==false){
								str+="<a href='${pageContext.request.contextPath}/messageinfo/getPdfFile?MESSAGEINFO_ID="+data.varList[i].MESSAGEINFO_ID+"' target='_blank'><li><i></i><h1>"+data.varList[i].MESSAGEINFO_TITLE+"</h1><label>"+getdata(data.varList[i].MESSAGEINFO_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].MESSAGEINFO_CONTEXT+"</p></li></a>";
									isok=true;
							}else if(data.varList[i].MESSAGEINFO_STATE==1 && isok==false){
								if(data.varList[i].MESSAGEINFO_INFORMATION_ID==result.info[j].INFORMATION_ID){
									str+="<a href='${pageContext.request.contextPath}/messageinfo/getPdfFile?INFORMATION_ID="+result.info[j].INFORMATION_ID+"' target='_blank'><li><i></i><h1>"+data.varList[i].MESSAGEINFO_TITLE+"</h1><label>"+getdata(data.varList[i].MESSAGEINFO_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].MESSAGEINFO_CONTEXT+"</p></li></a>";
									isok=true;
								}
							}
						}else{
								if(data.varList[i].MESSAGEINFO_STATE==0 && isok==false){
								str+="<a onclick='clearclass(this)' href='${pageContext.request.contextPath}/messageinfo/getPdfFile?INFORMATION_ID="+data.varList[i].INFORMATION_ID+"&READ_MESSAGEINFO_ID="+data.varList[i].MESSAGEINFO_ID+"' target='_blank'><li class='not_read' id='liserver' lang='"+data.varList[i].MESSAGEINFO_ID+"'><i></i><h1>"+data.varList[i].MESSAGEINFO_TITLE+"</h1><label>"+getdata(data.varList[i].MESSAGEINFO_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].MESSAGEINFO_CONTEXT+"</p></li></a>";
								isok=true;
							}else if(data.varList[i].MESSAGEINFO_STATE==1 && isok==false){
								if(data.varList[i].MESSAGEINFO_INFORMATION_ID==result.info[j].INFORMATION_ID){
									str+="<a onclick='clearclass(this)' href='${pageContext.request.contextPath}/messageinfo/getPdfFile?INFORMATION_ID="+result.info[j].INFORMATION_ID+"&READ_MESSAGEINFO_ID="+data.varList[i].MESSAGEINFO_ID+"' target='_blank'><li class='not_read' id='liserver' lang='"+data.varList[i].MESSAGEINFO_ID+"'><i></i><h1>"+data.varList[i].MESSAGEINFO_TITLE+"</h1><label>"+getdata(data.varList[i].MESSAGEINFO_CREATETIME,'yyyy-MM-dd')+"</label><p>"+data.varList[i].MESSAGEINFO_CONTEXT+"</p></li></a>";
									isok=true;
								}
							}
						}
					});	
				});
				cxcxtotalPage.val(data.page.totalPage);
				if(data.page.totalPage==data.page.currentPage){
					$("#aserver").text("全部加载完毕");
				}
				if(str==""){
					$("#aserver").text("你还没有存续消息!")
				}
				server.append(str);
			} */
			//清除系统消息未读样式
			function clearclass(obj){
				$(obj).find('#liserver').removeClass("not_read");
			}
			
		</script>
	</body>
</html>

