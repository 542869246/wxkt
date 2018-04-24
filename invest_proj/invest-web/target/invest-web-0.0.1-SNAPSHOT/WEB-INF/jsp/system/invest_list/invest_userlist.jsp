<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/common/top.jsp"%>

<%@ include file="../../weixin/WxChatShare.jsp"%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
<script type="text/javascript" src="static/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="static/js/layout.js"></script>
<script type="text/javascript" src="static/js/basedao.js"></script>
<link rel="stylesheet" href="static/css/bc.css" />
<link rel="stylesheet" href="static/css/property.css" />
<link rel="stylesheet" href="static/css/pagedown.css" />
<script type="text/javascript">
$(function(){
	pushHistory();
	//苹果手机返回按钮触发事件
	window.addEventListener("popstate", function(e) { 
		window.location.href="<%=basePath%>/investMain/userProdctsinfoMain";
	}, false);
	//安卓手机返回按钮触发事件
	function pushHistory() { 
		var state = { 
			title: "title", 
			url: "investMain/userProdctsinfoMain"
		}; 
		window.history.pushState(state, "title", state.url); 
	} 
})
</script>
<title>我的投资</title>
</head>
<body>
	<div class="wrapper">
		<div class="invest_list">

			<ul>
				<c:forEach var="varlist" items="${list}" varStatus="go">
					<a
						href="productsinfo/findById?PRODUCTSINFO_ID=${varlist.PRODUCTSINFO_ID}&INVEST_ID=${varlist.INVEST_ID}">
						<li><c:if test="${go.count == 1}">
								<!-- 根据 类型进行分页查询 -->
								<span class="span_typeId" style="display: none;">${varlist.PRODUCTS_TYPE1_ID}</span>
								<c:if
									test="${varlist.INVEST_USER_ID != null && varlist.INVEST_USER_ID != ''}">
									<span class="span_userid" style="display: none;">${varlist.INVEST_USER_ID}</span>
									<span class="span_prodicsid" style="display: none;">${varlist.INVEST_PRODICTS_ID}</span>
									<span class="span_dicTtoNarisId" style="display: none;">${varlist.INVEST_DICTIONARIESID}</span>
								</c:if>
							</c:if>

							<dl class="left">
								<dt>
									<span style="margin-left: 5px">${varlist.PRODUCTS_YJBJJZ}</span>%
								</dt>
								<dd>${varlist.PRODUCTS_ATTRIBUTE}</dd>
							</dl>
							<div class="right">
								<h1>${varlist.PRODUCTS_NAME}</h1>
								<p>${varlist.PRODUCTS_TEXT}</p>
								<div class="tip">
									<c:if test="${varlist.PRODUCTS_COUNTERSTATE != '' }">
										<label class="red">${varlist.PRODUCTS_COUNTERSTATE}</label>
									</c:if>
									<c:if test="${varlist.PRODUCTS_PAPERSTATE != '' }">
										<label class="yellow">${varlist.PRODUCTS_PAPERSTATE}</label>
									</c:if>
								</div>
							</div></li>
					</a>
				</c:forEach>

			</ul>
			<!--分页-->
			<c:choose>
				<c:when test="${page.currentPage < page.totalPage}">
					<a class="btn_down" href="javascript:;">加载更多...</a>
				</c:when>
				<c:otherwise>
					<a class="btn_down" href="javascript:;">全部加载完毕</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<input type="hidden" id="cp" value="${page.currentPage }">
	<input type="hidden" id="tp" value="${page.totalPage }">
	<!--定义模板-->
	<div id="model_view" style="display: none;">
		<a
			href="productsinfo/findById?PRODUCTSINFO_ID={PRODUCTSINFO_ID}&INVEST_ID={INVEST_ID}">
			<li>
				<dl class="left">
					<dt>
						<span style="margin-left: 5px">{PRODUCTS_YJBJJZ}</span>%
					</dt>
					<dd>{PRODUCTS_ATTRIBUTE}</dd>
				</dl>
				<div class="right">
					<h1>{PRODUCTS_NAME}</h1>
					<p>{PRODUCTS_TEXT}</p>
					<div class="tip">
						<label class="{red1}">{PRODUCTS_COUNTERSTATE}</label> <label
							class="{yellow1}">{PRODUCTS_PAPERSTATE}</label>
					</div>
				</div>
		</li>
		</a>
	</div>

	<script type="text/javascript" src="static/js/query.js"></script>
	<script type="text/javascript" src="static/js/paging.js"></script>
	<script>
		// PDF模板展开
		$(".btn_down")
				.on(
						"click",
						function() {
							var conddata = {};
							var cp = $("#cp").val();
							var tp = $("#tp").val();
							// 平台的产品
							var span_typeId = $(".span_typeId").text();
							//客户的产品
							var span_prodicsid = $(".span_prodicsid").text();
							var span_userid = $(".span_userid").text();
							var span_dicTtoNarisId = $(".span_dicTtoNarisId")
									.text();
							cp++;
							if (cp > tp) {
								cp == tp;
								$(".btn_down").html("全部加载完毕");
								return null;
							}
							var cfg = {};
							if (span_prodicsid != null && span_prodicsid != ''
									&& span_userid != null && span_userid != ''
									&& span_dicTtoNarisId != null
									&& span_dicTtoNarisId != '') {
								cfg.url = 'invest/listAll';
								cfg.data = {
									'currentPage' : cp,
									'INVEST_USER_ID' : span_userid,
									'INVEST_PRODICTS_ID' : span_prodicsid,
									'INVEST_DICTIONARIESID' : span_dicTtoNarisId,
								};
							} else {
								cfg.url = 'productsinfo/listAll';
								cfg.data = {
									'currentPage' : cp,
									'PRODUCTS_TYPE1_ID' : span_typeId
								};
							}
							var baseDao = new BaseDao(cfg);
							var rdata = baseDao.getResponseData();
							$("#cp").val(rdata.page.currentPage);
							$("#tp").val(rdata.page.totalPage);
							// 拿到模板的类型
							var model_ul = $("#model_view").html();
							if (rdata.list != null && rdata.list != '') {
								var list = rdata.list;
								$.each(list,function(i) {
													if (list[i].PRODUCTS_PAPERSTATE != ''
															&& list[i].PRODUCTS_COUNTERSTATE != '') {
														$(".invest_list ul")
																.append(
																		model_ul
																				.replace(
																						"{PRODUCTSINFO_ID}",
																						list[i].PRODUCTSINFO_ID)
																				.replace(
																						"{PRODUCTS_YJBJJZ}",
																						list[i].PRODUCTS_YJBJJZ)
																				.replace(
																						"{PRODUCTS_NAME}",
																						list[i].PRODUCTS_NAME)
																				.replace(
																						"{PRODUCTS_COUNTERSTATE}",
																						list[i].PRODUCTS_COUNTERSTATE)
																				.replace(
																						"{PRODUCTS_PAPERSTATE}",
																						list[i].PRODUCTS_PAPERSTATE)
																				.replace(
																						"{PRODUCTS_TEXT}",
																						list[i].PRODUCTS_TEXT)
																				.replace(
																						"{PRODUCTS_ATTRIBUTE}",
																						list[i].PRODUCTS_ATTRIBUTE)
																				.replace(
																						"{INVEST_ID}",
																						list[i].INVEST_ID)
																				.replace(
																						"{red1}",
																						"red")
																				.replace(
																						"{yellow1}",
																						"yellow"));
													}
													;
													if (list[i].PRODUCTS_PAPERSTATE == ''
															&& list[i].PRODUCTS_COUNTERSTATE != '') {
														$(".invest_list ul")
																.append(
																		model_ul
																				.replace(
																						"{PRODUCTSINFO_ID}",
																						list[i].PRODUCTSINFO_ID)
																				.replace(
																						"{PRODUCTS_YJBJJZ}",
																						list[i].PRODUCTS_YJBJJZ)
																				.replace(
																						"{PRODUCTS_NAME}",
																						list[i].PRODUCTS_NAME)
																				.replace(
																						"{PRODUCTS_COUNTERSTATE}",
																						list[i].PRODUCTS_COUNTERSTATE)
																				.replace(
																						"{PRODUCTS_TEXT}",
																						list[i].PRODUCTS_TEXT)
																				.replace(
																						"{PRODUCTS_ATTRIBUTE}",
																						list[i].PRODUCTS_ATTRIBUTE)
																				.replace(
																						"{PRODUCTS_ATTRIBUTE}",
																						list[i].PRODUCTS_ATTRIBUTE)
																				.replace(
																						"{PRODUCTS_PAPERSTATE}",
																						"")
																				.replace(
																						"{INVEST_ID}",
																						list[i].INVEST_ID)
																				.replace(
																						"{red1}",
																						"red"));
													}
													;
													if (list[i].PRODUCTS_PAPERSTATE != ''
															&& list[i].PRODUCTS_COUNTERSTATE == '') {
														$(".invest_list ul")
																.append(
																		model_ul
																				.replace(
																						"{PRODUCTSINFO_ID}",
																						list[i].PRODUCTSINFO_ID)
																				.replace(
																						"{PRODUCTS_YJBJJZ}",
																						list[i].PRODUCTS_YJBJJZ)
																				.replace(
																						"{PRODUCTS_NAME}",
																						list[i].PRODUCTS_NAME)
																				.replace(
																						"{PRODUCTS_COUNTERSTATE}",
																						"")
																				.replace(
																						"{INVEST_ID}",
																						list[i].INVEST_ID)
																				.replace(
																						"{PRODUCTS_TEXT}",
																						list[i].PRODUCTS_TEXT)
																				.replace(
																						"{PRODUCTS_ATTRIBUTE}",
																						list[i].PRODUCTS_ATTRIBUTE)
																				.replace(
																						"{PRODUCTS_PAPERSTATE}",
																						list[i].PRODUCTS_PAPERSTATE)
																				.replace(
																						"{yellow1}",
																						"yellow"));
													}
													;
													if (list[i].PRODUCTS_PAPERSTATE == ''
														&& list[i].PRODUCTS_COUNTERSTATE == '') {
													$(".invest_list ul")
															.append(
																	model_ul
																			.replace(
																					"{PRODUCTSINFO_ID}",
																					list[i].PRODUCTSINFO_ID)
																			.replace(
																					"{PRODUCTS_YJBJJZ}",
																					list[i].PRODUCTS_YJBJJZ)
																			.replace(
																					"{PRODUCTS_NAME}",
																					list[i].PRODUCTS_NAME)
																			.replace(
																					"{PRODUCTS_COUNTERSTATE}",
																					list[i].PRODUCTS_COUNTERSTATE)
																			.replace(
																					"{PRODUCTS_PAPERSTATE}",
																					list[i].PRODUCTS_PAPERSTATE)
																			.replace(
																					"{PRODUCTS_TEXT}",
																					list[i].PRODUCTS_TEXT)
																			.replace(
																					"{PRODUCTS_ATTRIBUTE}",
																					list[i].PRODUCTS_ATTRIBUTE)
																			.replace(
																					"{INVEST_ID}",
																					list[i].INVEST_ID)
																			.replace(
																					"{red1}",
																					"")
																			.replace(
																					"{yellow1}",
																					""));
												}
												;

												});

							}
							;
						})
	</script>
</body>
</html>
