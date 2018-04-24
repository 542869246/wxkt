<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/common/top.jsp"%>
<% 
	Object obj=application.getAttribute("uploadfPath");
%>
<%@ include file="../weixin/WxChatShare.jsp"%>
<!DOCTYPE html>
<html>
	<head>
	<base href="<%=basePath%>">
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
		<script type="text/javascript" src="static/js/jquery-1.11.3.min.js" ></script>
		<script type="text/javascript" src="static/js/layout.js" ></script>
		<script src="static/js/basedao.js" type="text/javascript" charset="utf-8"></script>
		<link rel="stylesheet" href="static/css/bc.css" />
		<link rel="stylesheet" href="static/css/pagedown.css" />
		<c:choose>
			<c:when test="${whereCome == 'user_collect'}">
				<title>我的收藏</title>
			</c:when>
			<c:otherwise>
				<title>新闻搜索</title>
			</c:otherwise>
		</c:choose>
		
	</head>
	<body>
		<div class="wrapper">
			<div class="my_collect">
				<ul class="nav">
					<!-- <li>产品收藏</li> -->
					<li class="cur">新闻列表</li>
				</ul>
				<div class="pages">
					<div class="page" style="display:block; ">
						<ul class="newscontent">
							<!-- <li>
								<img src="static/img/news1.png" />
								<div class="text">
									<h1>
										<span>中国经济今年大增长1</span>
										<i class="tip"></i>
									</h1>
									<label>2017-02-27</label>
									<p>今天“网易财富大讲堂·易金经专家全国巡回演讲”活动在北京举行。</p>
								</div>
							</li> -->
						</ul>
					<a class="btn_down" href="javascript:;">加载更多...</a>
					</div>
				</div>
				<input type="hidden" id="whereCome" value="${whereCome}">
				<input type="hidden" id="NEWINFO_TITLE" value="${NEWINFO_TITLE}">
				<input type="hidden" id="cp" value="${page.currentPage }" > 
			    <input type="hidden" id="tp" value="${page.totalPage }">
			</div>
		</div>
		<script type="text/javascript">
		;(function($){
			var flag=true;
			var mycollect=function(){
				var mytool = new MyTool();
				var $newscontent=$(".newscontent");
				var $NEWINFO_TITLE=$("#NEWINFO_TITLE");
				var $btn_down=$(".btn_down");
				var $whereCome=$("#whereCome");
				var $cp=$("#cp");
				var $tp=$("#tp");
				var loadEvent=function(){
					//跳转新闻详情
					$(".pages").on('click','li[name=newsinfo]',function(){
						var id=$(this).attr("lang");
						open('newsinfo/tonews_detail?NEWSINFO_ID='+id,'_self');
					})
					//下拉框
					$btn_down.on('click',function(){
						var cp=getconddata();
						if(cp!=null)
							getnewsinfos(cp);
					});
				}
				//获取新闻
				var getnewsinfos = function(cp) {
					var cfg={};
					var data = {
						'currentPage' : cp
					};
					var whereCome=$whereCome.val();
					if(whereCome=="indexSearch"){
						cfg.url='newsinfo/list';
						data.NEWINFO_TITLE=$NEWINFO_TITLE.val();
					}else if(whereCome=="user_collect"){
						cfg.url='collect/list';
					}
					cfg.data = data;
					var baseDao = new BaseDao(cfg);
					var rdata = baseDao.getResponseData();
					console.info(rdata);
					
					if(flag&&rdata.list.length==0){
						open("space/toSpace?title=我的收藏&msg=您还没有收藏新闻哦!","_self");
						return;
					}
					
					if(rdata.list.length<8){
						$btn_down.text("全部加载完毕");
					}
					if (rdata.list != null && rdata.list != '') {
						$cp.val(rdata.page.currentPage);
						$tp.val(rdata.page.totalPage);
						$.each(rdata.list,function(index, news) {
							//var str = ""
							/* if (mytool.isShowNew(news.NEWINFO_CREATETIME)&& news.NEWINFO_STATE == 0) {
								str = '<i class="tip"></i>';
							} */
							$newscontent.append(
									'<li name="newsinfo" lang="'+news.NEWSINFO_ID+'">'+
										'<img src="<%=obj%>'+news.THUMBNAIL+'"  onerror="this.src='+"'static/img/error.jpg'"+';this.onerror=null" />'+
										'<div class="text">'+
											'<h1>'+
												'<span>'+ news.NEWINFO_TITLE+ '</span>'+
											//str+
											'</h1>'+
											'<label>'+ mytool.formatDate(news.NEWINFO_CREATETIME)+'</label>'+
											'<p>'+ news.NEWINFO_SECONDTITLE+ '</p>' +
										'</div>'+
									 '</li>'
									);
						});
					}
				}
				//获得查询条件
				var getconddata=function(){
					var conddata={};
					var cp=$cp.val();
					var tp=$tp.val();
					cp++;
					if(cp>tp){
						cp==tp;
						$btn_down.text("全部加载完毕");
						return null;
					}
					return cp;
				}
				return {
					init:function(){
						loadEvent();
						getnewsinfos(1);
					}
					
				}
			}()
			mycollect.init();
		})(jQuery);
			
		</script>
		<script>
			/* $(".nav li").on("click",function(){
				var index = $(this).index();
				$(this).addClass("cur").siblings().removeClass("cur");
				$(".page").hide().eq(index).fadeIn();
			}) */
		</script>
	</body>
</html>