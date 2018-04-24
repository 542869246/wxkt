<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
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
<meta name="viewport"
	content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
<script type="text/javascript" src="static/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="static/js/layout.js"></script>
<%-- link rel="stylesheet" href="static/css/paging.css" /> --%>
<link rel="stylesheet" href="static/css/bc.css" />
<!-- <link rel="stylesheet" href="static/css/load.css" /> -->
<link rel="stylesheet" href="static/css/pagedown.css" />
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
</style>

<title>首页</title>
</head>
<body>
	<div class="wrapper">
		<div class="index">
			<!--search-->
			<div class="search">
			<form action="newsinfo/toNewsList">
				<input type="search" placeholder="搜索" name="NEWINFO_TITLE"/>
				<input type="hidden" name="whereCome" value="indexSearch">
			</form>
			</div>
			<!--banner-->
			<div class="gallery"></div>
			<ul class="nav">
				<c:forEach items="${newstype }" var="t" varStatus="index">
					<c:choose>
						<c:when test="${index.index==0}">
							<li class="cur">${ t.NAME}</li>
						</c:when>
						<c:otherwise>
							<li>${ t.NAME}</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
			<div class="pages">
				<div class="page" style="display: block;">
					<ul class="zxzx">
					</ul>
					<a class="btn_down azx" href="javascript:;">加载更多...</a>
					<!--分页1-->
					<!-- <div id="pageTool1"></div> -->
				</div>
				<div class="page">
					<ul class="gwzx">
					</ul>
					<a class="btn_down agw" href="javascript:;">加载更多...</a>
					<!--分页2-->
					<!-- <div id="pageTool2"></div> -->
				</div>
			</div>
			<footer>
				<ul>
					<li class="cur"><a href="index/toindex">首页</a></li>
					<li><a href="dictionaries/findProperty">资产配置</a></li>
					<li><a href="newsinfo/toTypeNews">实时资讯</a></li>
					<li><a href="userinfo/toUserCentre">个人中心</a></li>
				</ul>
			</footer>
			<input type="hidden" id="zxcp"> 
			<input type="hidden" id="zxtp">
			<input type="hidden" id="gxcp"> 
			<input type="hidden" id="gxtp">
		</div>
	</div>
	<script type="text/javascript" src="static/js/flickity.pkgd.min.js"></script>
	<script type="text/javascript" src="static/js/query.js"></script>
	<%-- <script type="text/javascript" src="static/js/paging.js" ></script> --%>
	<!-- <script type="text/javascript" src="static/js/load-min.js" ></script> -->
	<script src="static/js/basedao.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		;
		(function($) {
			var index = function() {
				var mytool = new MyTool();
				var $gallery = $(".gallery");
				//最新资讯ul
				var $zxzx = $(".zxzx");
				//过往资讯ul
				var $gwzx = $(".gwzx");
				var $azx = $(".azx");
				var $agw = $(".agw");
				//最新资讯当前页隐藏域
				var $zxcp = $("#zxcp");
				//最新资讯总页隐藏域
				var $zxtp = $("#zxtp");
				//过往资讯当前页隐藏域
				var $gxcp = $("#gxcp");
				//过往资讯总页隐藏域
				var $gxtp = $("#gxtp");
				//var $search=$("input[name='search']")
				var loadEvent = function() {
					/*  $search.on('blur',function(){
						 var content=$search.val();
						 if($.trim(content)!=""){
							 open('newsinfo/toNewsList?NEWINFO_TITLE='+content,'_self')
						 }
					 }) */
					//最新资讯下拉菜单
					$azx.on("click", function() {
						var cp = $zxcp.val();
						var tp = $zxtp.val();
						cp++;
						if (cp > tp) {
							//$(this).addClass("up");
							$(this).text("全部加载完毕");
							return;
						}
						getnewsinfos(cp, 0);

					});
					//过往资讯下拉菜单
					$agw.on("click", function() {
						var cp = $gxcp.val();
						var tp = $gxtp.val();
						cp++;
						if (cp > tp) {
							//$(this).addClass("up");
							$(this).text("全部加载完毕");
							return;
						}
						getnewsinfos(cp, 1);
						
					});
					$gallery.on('click','img[name=banner]',function(){
						var url=$(this).attr("lang");
						if(url!="undefined"){
							open(url,'_self');
						}else{
							return;
						}
					});
					$(".pages").on('click','li[name=newsinfo]',function(){
						var id=$(this).attr("lang");
						open('newsinfo/tonews_detail?NEWSINFO_ID='+id,'_self');
					})
					
					
				}
				//初始化轮播图片
				var initBanner = function() {
					var cfg = {
						url : 'banner/getBanner',
					};
					var baseDao = new BaseDao(cfg);
					var rdata = baseDao.getResponseData();
					if (rdata != null && rdata != '') {
						$gallery.empty();
						$.each(rdata,function(index, banner) {
							$gallery.append('<div class="cell" >'
											+ '<img onerror="this.src='+"'static/img/error.jpg'"+';this.onerror=null" name="banner" src="<%=obj %>'+banner.BANNER_URL+'" lang="'+banner.BANNER_TOURL+'"/>'
											+ '<p>'	+ banner.BANNER_TITLE + '</p></div>')
						});
					}
				}
				$()
				
				//获取新闻
				var getnewsinfos = function(cp, state) {
					var cfg = {
						url : 'newsinfo/list',
					};
					var data = {
						'currentPage' : cp,
						'NEWINFO_STATE' : state
					};
					cfg.data = data;
					var baseDao = new BaseDao(cfg);
					var rdata = baseDao.getResponseData();
					if(rdata.list.length<8){
						if(state==0){
							$azx.text("全部加载完毕");
						}
						if(state==1){
							$agw.text("全部加载完毕");
						}
					}
					if (rdata.list != null && rdata.list != '') {
						
						var $document;
						if (state == 0) {
							$document = $zxzx
							$zxcp.val(rdata.page.currentPage);
							$zxtp.val(rdata.page.totalPage);
						} else {
							$document = $gwzx
							$gxcp.val(rdata.page.currentPage);
							$gxtp.val(rdata.page.totalPage);
						}
						$.each(rdata.list,function(index, news) {
							var str = ""
							if (mytool.isShowNew(news.NEWINFO_CREATETIME)&& state == 0) {
								str = '<i class="tip"></i>';
							}
							$document.append(
									'<li name="newsinfo" lang="'+news.NEWSINFO_ID+'">'+
									'<img src="<%=obj %>'+news.THUMBNAIL+'" onerror="this.src='+"'static/img/error.jpg'"+';this.onerror=null" />'+
									'<div class="text">'+
										'<h1>'+
											'<span>'+ news.NEWINFO_TITLE+ '</span>'+
										str+
										'</h1>'+
										'<label>'+ mytool.formatDate(news.NEWINFO_CREATETIME)+'</label>'+
										'<p>'+ news.NEWINFO_SECONDTITLE+ '</p>' +
									'</div>'+
								 '</li>'		
							)

						});
					}
				}

				return {
					init : function() {
						initBanner();
						loadEvent();
						getnewsinfos(1, 0);
						getnewsinfos(1, 1);
					}
				}
			}();
			index.init();

		})(jQuery);
	</script>
	<script>
		//列表展开
		$(".btn_down").on("click", function() {
			//$(this).toggleClass("up").siblings("ul").toggleClass("down");
		})
		//banner

		$(function() {

			var $carousel = $('.gallery').flickity({
				// options
				cellAlign : 'center',
				contain : false,
				freeScroll : false,
				prevNextButtons : false,
				wrapAround : true,
				autoPlay : 5000
			});

			$carousel.on('staticClick.flickity', function(event, pointer,
					cellElement, cellIndex) {
				//alert(cellElement)
			});

		})

		//tab
		$(".nav li").on("click", function() {
			var index = $(this).index();
			$(this).addClass("cur").siblings().removeClass("cur");
			$(".page").hide().eq(index).fadeIn();
		})

		//分页  api:http://www.jq22.com/jquery-info9832
		/* $('#pageTool1').Paging({pagesize:20,count:100,firstPage: false,});
		$('#pageTool2').Paging({pagesize:20,count:100,firstPage: false,}); */
	</script>
</body>
</html>