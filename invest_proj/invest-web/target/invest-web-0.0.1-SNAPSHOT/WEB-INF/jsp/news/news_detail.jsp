<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" import="java.util.*"%>

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
		<script type="text/javascript" src="static/js/simpleAlert.js"></script>
		
		<link rel="stylesheet" href="static/css/simpleAlert.css" />
		<link rel="stylesheet" href="static/css/bc.css" />
		<link rel="stylesheet" href="static/css/pagedown.css" />
		<title>资讯详情</title>
		<script type="text/javascript">
		</script>
	</head>
	<body style="margin: 0px;">
		<div class="wrapper">
			<div class="news_detail">
				<h1>${news.NEWINFO_TITLE }</h1>
				<label>${news.NEWINFO_CREATETIME }</label>
				<p>${news.NEWINFO_SECONDTITLE }</p>
				<!-- <p>6日发布的美联储6月议息会议纪要显示，多位联邦公开市场委员会(FOMC)成员倾向于在“数月内”开始缩减总规模达4.5万亿美元的资产负债表，分析人士预计美联储最早可能在9月议息会上宣布启动缩表计划的具体时间。</p>
				<img src="img/news_detail.jpg" />
				<p>在6月议息会议上，美联储今年内第二次上调了利率。会议纪要显示美联储决策层对加息背景下金融环境仍持续宽松感到担忧，因而支持渐进式的加息。对于备受关注的通胀问题，大多数决策层成员将物价疲软归咎于特殊因素，对中期内通胀将重新走升抱有信心。</p> -->
				<div class="content">
					${news.NEWINFO_CONTENT }
				</div>
				<c:if test="${mycollect==null }">
					<a class="laud" href="javascript:;"></a>
				</c:if>
				<c:if test="${mycollect!=null }">
					<a class="laud cur" href="javascript:;" lang="${mycollect.COLLECT_ID }"></a>
				</c:if>
			</div>
			<div class="comment">
				<div class="input">
					<input type="text" placeholder="写评论…" name="COMMENT_CONTENT" />
					<a href="javascript:;" class="madkcomment">发表</a>
				</div>
				<ul class="new_comment">
					<%-- <c:forEach items="${news_comment}" var="r">
						<li>
							<img src="${r.USER_PHOTO }" />
							<dl style="padding: 5px;">
								<dt>${r.USER_NICKNAME }
									<label style="padding-right: 5px;">
										<fmt:formatDate value="${r.COMMENT_CREATETIME }" pattern="yyyy-MM-dd HH:mm:ss"/>
									</label>
								</dt>
								<dd>${r.COMMENT_CONTENT }</dd>
							</dl>
							<b class="zan" style="margin-right: 5px;" lang="${r.COMMENT_ID }">${r.zan }</b>
						</li>
					</c:forEach> --%>
				</ul>
				<a class="btn_down" href="javascript:;" style="margin-bottom: 20px;">加载更多...</a>
			</div>
			<input type="hidden" id="NEWSINFO_ID"  value="${news.NEWSINFO_ID }"> 
			<input type="hidden" id="cp" value="${page.currentPage }" > 
			<input type="hidden" id="tp" value="${page.totalPage }">
		</div>
		<script type="text/javascript" src="static/js/query.js" ></script>
		<script type="text/javascript" src="static/js/paging.js" ></script>
		<script type="text/javascript" src="static/js/basedao.js"></script>
		<script type="text/javascript">
			;(function($){
				var news_detail=function(){
					var mytool = new MyTool();
					var $btn_down=$(".btn_down");
					//当前页隐藏域
					var $cp = $("#cp");
					//总页隐藏域
					var $tp = $("#tp");
					var $btn_down=$(".btn_down");
					var $NEWSINFO_ID=$("#NEWSINFO_ID");
					var $new_comment=$(".new_comment");
					var $laud=$(".laud");
					var $madkcomment=$(".madkcomment");
					var $COMMENT_CONTENT=$("input[name='COMMENT_CONTENT']");
					//获得查询条件
					var getconddata=function(){
						var conddata={
							NEWSINFO_ID:$NEWSINFO_ID.val()	
						};
						var cp=$cp.val();
						var tp=$tp.val();
						cp++;
						if(cp>tp){
							cp==tp;
							$btn_down.text("全部加载完毕");
							return null;
						}
						conddata.currentPage=cp;
						return conddata;
					}
					var loadEvent=function(){
						//点赞
						$(".new_comment").on("click",".zan",function(){
							if(($(this).attr("class")).indexOf("cur")>0){
								return;
							}
							var conddata={
								ZAN_COMMENT_ID:this.lang	
							}
							var cfg={
								url:'zan/save',
							}
							cfg.data=conddata;
							var baseDao = new BaseDao(cfg);
							var rdata = baseDao.getResponseData();
							console.info(rdata);
							$(this).text(rdata.zancount);
							$(this).toggleClass("cur");
						})
						//评论
						$madkcomment.on('click',function(){
							var content=$COMMENT_CONTENT.val();
							if($.trim(content)==""){
								//单次单选弹框
				                var onlyChoseAlert = simpleAlert({
				                    "content":"请填写评论内容!",
				                    "buttons":{
				                        "确定":function () {
				                            onlyChoseAlert.close();
				                        }
				                    }
				                })
								return ;
							}
							var conddata={
								COMMENT_NEWS_ID:$NEWSINFO_ID.val(),	
								COMMENT_CONTENT:content
							}
							var cfg={
								url:'comment/save',
							}
							cfg.data=conddata;
							var baseDao = new BaseDao(cfg);
							var rdata = baseDao.getResponseData();
							getCommetn({NEWSINFO_ID:$NEWSINFO_ID.val(),currentPage:1,new_comment:"clean"});
							$COMMENT_CONTENT.val("")
						});
						//下拉框
						$btn_down.on('click',function(){
							var conddata=getconddata();
							//console.info(conddata);
							if(conddata!=null){
								getCommetn(conddata);
							}
						});
						//收藏
						$laud.on('click',function(){
							var conddata={
								COLLECT_INFO_ID:$NEWSINFO_ID.val(),
								COLLECT_ID:this.lang
							};
							 var cfg = {
								url :'collect/saveAndDelete',
							};
							cfg.data = conddata;
							//console.info(cfg)
							var baseDao = new BaseDao(cfg);
							var rdata = baseDao.getResponseData();
							$(this).toggleClass("cur");
							if(rdata==null){
								this.lang="";
							}else{
								this.lang=rdata.COLLECT_ID;
							}
						});
					}
					//获取评论
					var getCommetn=function(conddata){
						    var cfg = {
								url :'comment/list',
							};
							cfg.data = conddata;
							var baseDao = new BaseDao(cfg);
							var rdata = baseDao.getResponseData();
							console.info(rdata.news_comment);
							if(rdata.news_comment.length<3){
								$btn_down.text("全部加载完毕");
							}
							$cp.val(rdata.page.currentPage);
							$tp.val(rdata.page.totalPage);
							if(conddata.new_comment=="clean"){
								$new_comment.empty();
							}
							$.each(rdata.news_comment,function(index,data){
								var str='<b  class="zan" style="margin-right: 5px;" lang="'+data.COMMENT_ID+'">'+data.zan +'</b>';
								if(data.iszan){
									str='<b  class="zan cur" style="margin-right: 5px;" lang="'+data.COMMENT_ID+'">'+data.zan +'</b>';
								}
								$new_comment.append(
									'<li>'+
										'<img src="'+data.USER_PHOTO+'"  onerror="this.src='+"'static/img/error.jpg'"+';this.onerror=null" />'+
										'<dl style="padding: 5px;">'+
											'<dt>'+data.USER_NICKNAME +'<label style="padding-right: 5px;">'+mytool.formatDate(data.COMMENT_CREATETIME) +'</label></dt>'+
											'<dd>'+data.COMMENT_CONTENT +'</dd>'+
										'</dl>'+
										str+
									'</li>'	
								);
							});
							
					}
					return {
						init:function(){
							loadEvent();
							getCommetn({NEWSINFO_ID:$NEWSINFO_ID.val(),currentPage:1});
						}
						
					}
				}();
				news_detail.init();
			})(jQuery);
		</script>
		<script>
			//文章收藏
			/* $(".laud").on("click",function(){
				$(this).toggleClass("cur");
			}) */
			
			//留言点赞
		/* 	$(".new_comment").on("click",".zan",function(){
				$(this).toggleClass("cur");
			}) */
			
			//分页  api:http://www.jq22.com/jquery-info9832
			//$('#pageTool').Paging({pagesize:20,count:100,firstPage: false,});
		</script>
	</body>
</html>