<%@page import="org.springframework.context.ApplicationContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/common/top.jsp"%>
<%
	Object imgUrl = application.getAttribute("uploadfPath");
%>

<%@ include file="../../weixin/WxChatShare.jsp"%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
<script type="text/javascript" src="static/js/echarts.min.js"></script>
<script type="text/javascript" src="static/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="static/js/layout.js"></script>
<script type="text/javascript" src="static/js/basedao.js"></script>
<script type="text/javascript" src="static/js/jquery.media.js"></script>
<link rel="stylesheet" href="static/css/bc.css" />
<link rel="stylesheet" href="static/css/pagedown.css" />
<title>投资详情</title>
<style type="text/css">
#btn_down {
	height: 1rem;
	width: 4rem;
	text-align: center;
	margin: 1rem auto 0;
	display: block;
	font-size: 8px;
	color: #666;
}
</style>
</head>
<body>
	<div class="wrapper">
		<div class="investment">
			<header
				style="background: url('<%=imgUrl%>/${img.TYPEIMG_IMGURL}'),url('static/img/error.jpg');background-size:100% 100%;background-repeat:no-repeat;">
				<h1>${obj.PRODUCTS_NAME}</h1>
				<ul>
					<li>
						<p>${obj.PRODUCTS_INCOME}</p> <label>预期收益</label>
					</li>
					<li>
						<p>${obj.PRODUCTS_START}</p> <label>投资起点</label>
					</li>
					<li>
						<p>${obj.PRODUCTS_SQJFBI}%</p> <label>首期缴费比例</label>
					</li>
				</ul>
			</header>
			<!--main-->
			<div class="main">
				<c:if test="${not empty  obj.PRODUCTS_ZEXIANTU}">
					<div id="main" style="width: 100%; height: 100px">
						<img alt="背景图片" src="<%=imgUrl%>/${obj.PRODUCTS_ZEXIANTU}"
							
							style="width: 100%; height: 100px">
					</div>
				</c:if>
				<div class="tip" style="height: auto;">
					<h1>基本要素</h1>
					<table border="1px">
						<c:forEach var="list" items="${attrList}">
							<tr>
								<td style="width: 30%;">${list.ATTR_NAME}</td>
								<td style="width: 70%;">${list.PRO_ATTR_VAL}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="tip info">
					<h1>详细资料</h1>
					<ul style="height: auto;">
						<c:forEach var="pdf" items="${pdfObj}" varStatus="go">
							<c:if test="${go.count == 1}">
								<span style="display: none;" class="span_typeId">${pdf.DETAILS_INFO_ID}</span>
							</c:if>
							<li onclick="window.location.href='inormation/toshowpdf?DETAILS_ID=${pdf.DETAILS_ID }'">
							    <%-- <a href="details/getPdfFile?DETAILS_ID=${pdf.DETAILS_ID}" target="_blank">${pdf.DETAILS_TITLE}</a>  --%>
								${pdf.DETAILS_TITLE}
							</li>
						</c:forEach>
					</ul>
					<c:choose>
						<c:when test="${page1.currentPage < page1.totalPage}">
							<a id="btn_down" href="javascript:;">加载更多...</a>
						</c:when>
						<c:otherwise>
							<a id="btn_down" href="javascript:;">全部加载完毕</a>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="tip related_news">
					<h1>相关新闻</h1>
					<ul style="height: auto;">
						<c:forEach var="newList" items="${newList}">
							<!-- 控制时间格式 -->
							<fmt:formatDate value="${newList.NEWS_INSERTTIME}"
								pattern="yyyy-MM" var="data" />
							<fmt:formatDate value="${newList.NEWS_INSERTTIME}" pattern="dd"
								var="day" />
							<li onclick="window.location.href='${newList.NEWS_URL}'">
								<dl>
									<dt>${day}</dt>
									<dd>${data}</dd>
								</dl>
								<p>
									${newList.NEWS_TITLE}
								</p>
							</li>
						</c:forEach>
					</ul>
					<c:choose>
						<c:when test="${page2.currentPage < page2.totalPage}">
							<a id="btn_down" class="btn_downs" href="javascript:;">加载更多...</a>
						</c:when>
						<c:otherwise>
							<a id="btn_down" class="btn_downs" href="javascript:;">全部加载完毕</a>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
			<div>
				<c:choose>
					<c:when test="${pdflag.USER_GROUPID == grouppd.GROUPBY_USER_ID }">
							<a class="toPersistence"
									href="productsinfo/flag?PRODUCTSINFO_ID=${obj.PRODUCTSINFO_ID}">存续基金</a>
					</c:when>
					<c:otherwise>
							<c:if test="${not empty INVEST_ID}">
								<a class="toPersistence"
									href="productsinfo/flag?PRODUCTSINFO_ID=${obj.PRODUCTSINFO_ID}">存续基金</a>
							</c:if>
					</c:otherwise>
				</c:choose>
				
		</div>
	</div>
	<!-- PDF模板-->
	<ul class="ul_li" style="display: none;">
		<li><a href="details/getPdfFile?upload={DETAILS_URL}"
			target="_blank">{DETAILS_TITLE}</a></li>
	</ul>
	<!-- 分页模板  -->
	<input type="hidden" id="cp" value="${page1.currentPage }">
	<input type="hidden" id="tp" value="${page1.totalPage }">


	<!-- DPF新闻模板 -->
	<ul class="ul_news" style="display: none;">
		<li>
			<dl>
				<dt>{day}</dt>
				<dd>{yearData}</dd>
			</dl>
			<p>
				<a href="{news_url}">{NEWS_TITLE}</a>
			</p>
		</li>
	</ul>
	<!-- 新闻分页模板  -->
	<input type="hidden" id="cps" value="${page2.currentPage}">
	<input type="hidden" id="tps" value="${page2.totalPage}">
	<!-- javaScript 模板 -->
	<script type="text/javascript">
		$(document).on("click",".showpdf",function(){
			open("inormation/toshowpdf?DETAILS_ID="+this.lang,"_blank");
		});
		// PDF模板展开
		$("#btn_down").on(
				"click",
				function() {
					var conddata = {};
					var cp = $("#cp").val();
					var tp = $("#tp").val();
					var span_typeId = $(".span_typeId").text();
					cp++;
					if (cp > tp) {
						cp == tp;
						$("#btn_down").html("全部加载完毕");
						return null;
					}
					var cfg = {};
					cfg.url = 'details/listpdf';
					cfg.data = {
						'currentPage' : cp,
						'PRODUCTSINFO_ID' : span_typeId
					};
					var baseDao = new BaseDao(cfg);
					var rdata = baseDao.getResponseData();
					// 拿到当前的模板
					var ul_li = $(".ul_li").html();
					// 拿到当前分页的数据
					var list = rdata.list;
					$("#cp").val(rdata.page.currentPage);
					
					// 遍历数据
					for (var i = 0; i < list.length; i++) {						
						$(".info ul").append(
								ul_li.replace("{DETAILS_URL}",
										list[i].DETAILS_URL).replace(
										"{DETAILS_TITLE}",
										list[i].DETAILS_TITLE));
					}
					;
				})
		// 新闻模板展开
		$(".btn_downs").on(
				"click",
				function() {
					var conddata = {};
					var cp = $("#cps").val();
					var tp = $("#tps").val();
					var span_typeId = $(".span_typeId").text();
					cp++;
					if (cp > tp) {
						cp == tp;
						$(".btn_downs").html("全部加载完毕");
						return null;
					}
					var cfg = {};
					cfg.url = 'news/newsList';
					cfg.data = {
						'currentPage' : cp,
						'PRODUCTSINFO_ID' : span_typeId
					};
					var baseDao = new BaseDao(cfg);
					var rdata = baseDao.getResponseData();
					console.log(rdata);
					// 拿到当前的模板
					var ul_li = $(".ul_news").html();
					// 拿到当前分页的数据
					var list = rdata.list;
					$("#cps").val(rdata.page2.currentPage);
					// 遍历数据
					var mytool = new MyTool();
					for (var i = 0; i < list.length; i++) {
						var strdate = list[i].NEWS_INSERTTIME;
						var data = mytool.formatDate(strdate);
						var yearData = data.substring(0, 7);
						var day = data.substring(8, 10);
						//alert(strdate.indexOf("-"));
						$(".related_news ul").append(
								ul_li.replace("{yearData}", yearData).replace(
										"{day}", day).replace("{NEWS_TITLE}",
										list[i].NEWS_TITLE).replace(
										"{news_url}", list[i].NEWS_URL));
					}
					;
				})
	</script>
</body>
</html>
