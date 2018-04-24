<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/common/top.jsp"%>

<%@ include file="../weixin/WxChatShare.jsp"%>
<%
	Object obj=application.getAttribute("uploadfPath");
%>
<!DOCTYPE html>
<html>
	<head>
	<base href="<%=basePath%>">
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
		<script type="text/javascript" src="static/js/jquery-1.11.3.min.js" ></script>
		<script type="text/javascript" src="static/js/layout.js" ></script>
		<script src="static/js/basedao.js" type="text/javascript" charset="utf-8"></script>
		<link rel="stylesheet" href="static/css/paging.css" />
		<link rel="stylesheet" href="static/css/bc.css" />
		<link rel="stylesheet" href="static/css/pagedown.css" />
		<title>实时资讯</title>
	</head>
	<body>
		<div class="wrapper">
			<div class="news">
				<ul class="nav navtype">
					<c:forEach items="${newstype }" var="t" varStatus="index">
						<c:choose>
							<c:when test="${index.index==0}">
								<li class="cur" lang="${t.DICTIONARIES_ID }">${ t.NAME}</li>
							</c:when>
							<c:otherwise>
								<li lang="${t.DICTIONARIES_ID }">${ t.NAME}</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</ul>
				<div class="pages">
					<div class="page" style="display: block;">
						<ul class="newspage1">
							
						</ul>
						<!--分页1-->
						<a class="btn_down" id="fy1" href="javascript:;">加载更多...</a>
					</div>
					<div class="page">
						<ul class="newspage2">
							
						</ul>
						<!--分页2-->
						<a class="btn_down" id="fy2" href="javascript:;">加载更多...</a>
					</div>
					<div class="page">
						<ul class="newspage3">
							
						</ul>
						<!--分页3-->
						<a class="btn_down" id="fy3" href="javascript:;">加载更多...</a>
					</div>
				</div>
				<footer>
					<ul>
						<li>
							<a href="index/toindex">首页</a>
						</li>
						<li>
							<a href="dictionaries/findProperty">资产配置</a>
						</li>
						<li class="cur">
							<a href="newsinfo/toTypeNews">实时资讯</a>
						</li>
						<li>
							<a href="userinfo/toUserCentre">个人中心</a>
						</li>
					</ul>
				</footer>
			</div>
<%-- 		<input type="hidden" id="DICTIONARIES_ID1" value="${newstype[0].DICTIONARIES_ID }">
			<input type="hidden" id="DICTIONARIES_ID2" value="${newstype[1].DICTIONARIES_ID }">
			<input type="hidden" id="DICTIONARIES_ID3" value="${newstype[0].DICTIONARIES_ID }"> 
 --%>			
 			<input type="hidden" id="cp1" value="0"> 
		    <input type="hidden" id="tp1" value="1">
		    <input type="hidden" id="cp2" value="0"> 
		    <input type="hidden" id="tp2" value="1">
		    <input type="hidden" id="cp3" value="0"> 
		    <input type="hidden" id="tp3" value="1">
		</div>
		<script type="text/javascript" src="static/js/query.js" ></script>
		<script type="text/javascript" src="static/js/paging.js" ></script>
		<script type="text/javascript">
			
		;(function($){
			var news=function(){
				var mytool = new MyTool();
				var $DICTIONARIES_ID1=$("#DICTIONARIES_ID1");
				var $DICTIONARIES_ID2=$("#DICTIONARIES_ID2");
				var $DICTIONARIES_ID3=$("#DICTIONARIES_ID3");
				var $cp1=$("#cp1");var $tp1=$("#tp1");var $fy1=$("#fy1");
				var $cp2=$("#cp2");var $tp2=$("#tp2");var $fy2=$("#fy2");
				var $cp3=$("#cp3");var $tp3=$("#tp3");var $fy3=$("#fy3");
				$cp1.val(0);$cp2.val(0);$cp3.val(0);
				$tp1.val(1);$tp2.val(1);$tp3.val(1);
				var $newspage1=$(".newspage1"); var $newspage2=$(".newspage2");var $newspage3=$(".newspage3");
				var loadEven=function(){
					//跳转新闻详情
					$(".pages").on('click','li[name=newsinfo]',function(){
						var id=$(this).attr("lang");
						open('newsinfo/tonews_detail?NEWSINFO_ID='+id,'_self');
					})
					//类型切换显示新闻
					$(".news").on("click","ul.navtype li",function(){
						$DICTIONARIES_ID.val(this.lang);
						/* var index = $(this).index();
						if(index==0){
							 getfy1();
						}else if(index==1){
							 getfy2();
						}else{
							 getfy3();
						} */
					});
					//投资活动分页加载
					$fy1.on("click",function(){
						 getfy1();
					});
					//资讯解读分页加载
					$fy2.on("click",function(){
						 getfy2();
					});
					//实时资讯加载
					$fy3.on("click",function(){
						 getfy3();
					});
				}
				//投资活动分页加载
				function getfy1(ccp){
					var conddata=getconddata($cp1,$tp1,$fy1);
					if(ccp){
						conddata.currentPage=1;
					}
					conddata.NEWINFO_TYPE_ID=$("ul.navtype li:eq(0)").attr("lang");
					getnewsinfos(conddata,$newspage1,$cp1,$tp1,$fy1);
				}
				//资讯解读分页加载
				function getfy2(ccp){
					var conddata=getconddata($cp2,$tp2,$fy2);
					if(ccp){
						conddata.currentPage=1;
					}
					conddata.NEWINFO_TYPE_ID=$("ul.navtype li:eq(1)").attr("lang");
					getnewsinfos(conddata,$newspage2,$cp2,$tp2,$fy2);
				}
				//实时资讯加载
				function getfy3(ccp){
					var conddata=getconddata($cp3,$tp3,$fy3);
					if(ccp){
						conddata.currentPage=1;
					}
					conddata.NEWINFO_TYPE_ID=$("ul.navtype li:eq(2)").attr("lang");
					getnewsinfos(conddata,$newspage3,$cp3,$tp3,$fy3);
				}
				//获得查询条件
				var getconddata=function($cp,$tp,$btn_down){
					var cp=$cp.val();
					var tp=$tp.val();
					var conddata={};
					//debugger
					cp++;
					if(cp>tp){
						cp==tp;
						$btn_down.text("全部加载完毕");
						return null;
					}
					conddata.currentPage=cp;
					//conddata.NEWINFO_TYPE_ID=$DICTIONARIES_ID.val();
					return conddata;
				}
				//获得新闻
				var getnewsinfos = function(conddata,$content,$cp,$tp,$fy) {
					if(conddata == null){
						return ;
					}
					var cfg = {
						url : 'newsinfo/list',
					};
					cfg.data = conddata;
					var baseDao = new BaseDao(cfg);
					var rdata = baseDao.getResponseData();
					if(rdata.list.length<8){
						$fy.text("全部加载完毕");
					}
					if (rdata.list != null && rdata.list != '') {
						$cp.val(rdata.page.currentPage);
						$tp.val(rdata.page.totalPage);
						$.each(rdata.list,function(index, news) {
							var str = ""
							if (mytool.isShowNew(news.NEWINFO_CREATETIME)) {
								str = '<i class="tip"></i>';
							};
							$content.append(
									'<li name="newsinfo" lang="'+news.NEWSINFO_ID+'">'+
										'<img src="<%=obj%>'+news.THUMBNAIL+'"  onerror="this.src='+"'static/img/error.jpg'"+';this.onerror=null" />'+
										'<div class="text">'+
											'<h1>'+
												'<span>'+ news.NEWINFO_TITLE+ '</span>'+
											str+
											'</h1>'+
											'<label>'+ mytool.formatDate(news.NEWINFO_CREATETIME)+'</label>'+
											'<p>'+ news.NEWINFO_SECONDTITLE+ '</p>' +
										'</div>'+
									 '</li>'
									);
						});
					}
				}
				return {
					init:function(){
						//window.location.reload();
						//console.info(1);
						//初始化新闻类型
						//$DICTIONARIES_ID.val($(".navtype li.cur").attr("lang"));
						loadEven();
						//初始化页面
						getfy1(1);
						getfy2(1);
						getfy3(1);
					}
				}
			}();
			news.init();
		})(jQuery);
		
		</script>
		
		<script>
			//tab
		 	$(".nav li").on("click",function(){
		 		var index = $(this).index();
				$(this).addClass("cur").siblings().removeClass("cur");
				$(".page").hide().eq(index).fadeIn();
			}) 
			 
			/* //分页  api:http://www.jq22.com/jquery-info9832
			$('#pageTool1').Paging({pagesize:20,count:100,firstPage: false,});
			$('#pageTool2').Paging({pagesize:20,count:100,firstPage: false,});
			$('#pageTool3').Paging({pagesize:20,count:100,firstPage: false,}); */
		</script>
	</body>
</html>