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
<link rel="stylesheet" href="static/css/bc.css" />
<link rel="stylesheet" href="static/css/property.css" />
<script type="text/javascript" src="static/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="static/js/layout.js"></script>
<script type="text/javascript" src="static/js/basedao.js"></script>
<style type="text/css">
	dl{
	
}
</style>
<title>资产配置</title>
</head>
<body>
	<div class="wrapper">
		<div class="property">
			<ul class="nav">
				<c:forEach var="listProperty" items="${varList}" varStatus="go">
					<c:choose>
						<c:when test="${go.count == 1}">
							<li class="cur" id="firstType">${listProperty.NAME}<label>${listProperty.DICTIONARIES_ID}</label></li>
						</c:when>
						<c:otherwise>
							<li>${listProperty.NAME}<label>${listProperty.DICTIONARIES_ID}</label></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
			<!-- 页面加载时加载 -->
			<div class="pages">
				<div class="page" style="display: block;">
					<!-- 加载子模块 -->
					<c:forEach var="item" items="${map.varList}">
						<div class="tip">
							<h1>
								${item.NAME} <a href="productsinfo/findAll?PRODUCTS_TYPE1_ID=${item.DICTIONARIES_ID}">更多></span></a>
							</h1>

					<!-- 循环详细信息 -->
					<c:forEach var="mp" items="${map}">
						<c:if test="${mp.key == item.DICTIONARIES_ID}">
							<c:forEach var="pro" items="${mp.value}" varStatus="go">
								<ul class="${go.count}">
									<a
										href="productsinfo/findById?PRODUCTSINFO_ID=${pro.PRODUCTSINFO_ID}">
										<li>
											<dl class="left">
												<dt>
													<span  style="margin-left: 5px">${pro.PRODUCTS_YJBJJZ}</span>%
												</dt>
												<dd>${pro.PRODUCTS_ATTRIBUTE}</dd>
											</dl>
											<div class="right">
												<h1>${pro.PRODUCTS_NAME}</h1>
												<p>${pro.PRODUCTS_TEXT}</p>
												<div class="tip">

													<c:if test="${pro.PRODUCTS_COUNTERSTATE != '' }">
														<label class="red">${pro.PRODUCTS_COUNTERSTATE}</label>
													</c:if>
													<c:if test="${pro.PRODUCTS_PAPERSTATE != '' }">
														<label class="yellow">${pro.PRODUCTS_PAPERSTATE}</label>
													</c:if>
												</div>
											</div>
									</li>
									</a>
								</ul>
							</c:forEach>
						</c:if>
					</c:forEach>
				</div>
				</c:forEach>
			</div>
		</div>
	</div>
	</div>
	<!-- map 集合中的详情属性 -->



	<!-- 基金模板 -->
	<div class="pd" style="display: none;">
		<div class="tip">
			<h1>
				{TITLE} <a
					href="productsinfo/findAll?PRODUCTS_TYPE1_ID={DICTIONARIES_ID}&parent_id={parent_id}">更多></a>
			</h1>
			<ul class="ul_li{index}"></ul>
		</div>

	</div>
	<footer>
		<ul>
			<li><a href="index/toindex">首页</a></li>
			<li class="cur"><a href="dictionaries/findProperty">资产配置</a></li>
			<li><a href="newsinfo/toTypeNews">实时资讯</a></li>
			<li><a href="userinfo/toUserCentre">个人中心</a></li>
		</ul>
	</footer>
	</div>
	</div>

	<!-- 基金详情模板 -->
	<ul id="temp" style="display: none;">
		<a href="productsinfo/findById?PRODUCTSINFO_ID={PRODUCTSINFO_ID}">
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
	</ul>
	<script>
		// 显示当前的子模块
		$(".nav li")
				.on(
						"click",
						function() {
							var index = $(this).index();
							$(".pages").html("");
							var parent_id = $(this).find("label").text();
							var set = {};
							set.url = "dictionaries/findParentId";
							set.data = {
								'parent_id' : parent_id
							};
							var baseDAO = new BaseDao(set);
							var parentData = baseDAO.getResponseData();
							var old = $(".pd").html();
							var liold = $("#temp").html();
							// 定义str接收值传参
							var str = "";
							// 清空pages数据
							// 模块循环
							for (var i = 0; i < parentData.varList.length; i++) {
								var curr = parentData.varList[i];
								str = old.replace("{TITLE}", curr.NAME)
										.replace("{index}", i).replace(
												"{DICTIONARIES_ID}",
												curr.DICTIONARIES_ID).replace(
												"{parent_id}", parent_id);
								$(".pages").append(str);
								//						// 循环Map集合
								for ( var k in parentData) {
									//判断键值
									if (k == curr.DICTIONARIES_ID) {
										// 循环详细信息
										for (var j = 0; j < parentData[k].length; j++) {
											// 循环取值
											var curr1 = parentData[k][j];
											if (curr1.PRODUCTS_PAPERSTATE != ''
													&& curr1.PRODUCTS_COUNTERSTATE != '') {

												$(".ul_li" + i)
														.append(
																liold
																		.replace(
																				"{PRODUCTS_NAME}",
																				curr1.PRODUCTS_NAME)
																		.replace(
																				"{PRODUCTSINFO_ID}",
																				curr1.PRODUCTSINFO_ID)
																		.replace(
																				"{PRODUCTS_YJBJJZ}",
																				curr1.PRODUCTS_YJBJJZ)
																		.replace(
																				"{DICTIONARIES_ID}",
																				curr1.DICTIONARIES_ID)
																		.replace(
																				"{PRODUCTS_TEXT}",
																				curr1.PRODUCTS_TEXT)
																		.replace(
																				"{PRODUCTS_COUNTERSTATE}",
																				curr1.PRODUCTS_COUNTERSTATE)
																		.replace(
																				"{PRODUCTS_PAPERSTATE}",
																				curr1.PRODUCTS_PAPERSTATE)
																		.replace(
																				"{PRODUCTS_ATTRIBUTE}",
																				curr1.PRODUCTS_ATTRIBUTE)
																		.replace(
																				"{red1}",
																				"red")
																		.replace(
																				"{yellow1}",
																				"yellow"));
											}
											;
											if (curr1.PRODUCTS_PAPERSTATE == ''
													&& curr1.PRODUCTS_COUNTERSTATE != '') {
												$(".ul_li" + i)
														.append(
																liold
																		.replace(
																				"{PRODUCTS_NAME}",
																				curr1.PRODUCTS_NAME)
																		.replace(
																				"{PRODUCTSINFO_ID}",
																				curr1.PRODUCTSINFO_ID)
																		.replace(
																				"{PRODUCTS_YJBJJZ}",
																				curr1.PRODUCTS_YJBJJZ)
																		.replace(
																				"{DICTIONARIES_ID}",
																				curr1.DICTIONARIES_ID)
																		.replace(
																				"{PRODUCTS_TEXT}",
																				curr1.PRODUCTS_TEXT)
																		.replace(
																				"{PRODUCTS_COUNTERSTATE}",
																				curr1.PRODUCTS_COUNTERSTATE)
																		.replace(
																				"{PRODUCTS_PAPERSTATE}",
																				"")
																		.replace(
																				"{PRODUCTS_ATTRIBUTE}",
																				curr1.PRODUCTS_ATTRIBUTE)
																		.replace(
																				"{red1}",
																				"red"));
											}
											;
											if (curr1.PRODUCTS_PAPERSTATE != ''
													&& curr1.PRODUCTS_COUNTERSTATE == '') {
												$(".ul_li" + i)
														.append(
																liold
																		.replace(
																				"{PRODUCTS_NAME}",
																				curr1.PRODUCTS_NAME)
																		.replace(
																				"{PRODUCTSINFO_ID}",
																				curr1.PRODUCTSINFO_ID)
																		.replace(
																				"{PRODUCTS_YJBJJZ}",
																				curr1.PRODUCTS_YJBJJZ)
																		.replace(
																				"{DICTIONARIES_ID}",
																				curr1.DICTIONARIES_ID)
																		.replace(
																				"{PRODUCTS_TEXT}",
																				curr1.PRODUCTS_TEXT)
																		.replace(
																				"{PRODUCTS_PAPERSTATE}",
																				curr1.PRODUCTS_PAPERSTATE)
																		.replace(
																				"{PRODUCTS_ATTRIBUTE}",
																				curr1.PRODUCTS_ATTRIBUTE)
																		.replace(
																				"{PRODUCTS_PAPERSTATE}",
																				"")
																		.replace(
																				"{yellow1}",
																				"yellow")
																		);
											}
											;
											if (curr1.PRODUCTS_PAPERSTATE == ''
												&& curr1.PRODUCTS_COUNTERSTATE == '') {
											$(".ul_li" + i)
													.append(
															liold
																	.replace(
																			"{PRODUCTS_NAME}",
																			curr1.PRODUCTS_NAME)
																	.replace(
																			"{PRODUCTSINFO_ID}",
																			curr1.PRODUCTSINFO_ID)
																	.replace(
																			"{PRODUCTS_YJBJJZ}",
																			curr1.PRODUCTS_YJBJJZ)
																	.replace(
																			"{DICTIONARIES_ID}",
																			curr1.DICTIONARIES_ID)
																	.replace(
																			"{PRODUCTS_TEXT}",
																			curr1.PRODUCTS_TEXT)
																	.replace(
																			"{PRODUCTS_PAPERSTATE}",
																			curr1.PRODUCTS_PAPERSTATE)
																	.replace(
																			"{PRODUCTS_ATTRIBUTE}",
																			curr1.PRODUCTS_ATTRIBUTE)
																	.replace(
																			"{PRODUCTS_PAPERSTATE}",
																			"")
																	.replace(
																			"{yellow1}",
																			"")
																	 .replace(
																					"{red1}",
																					""));
										}
										}
									}
								}
								;
							}
							$(this).addClass("cur").siblings().removeClass(
									"cur");
						})
	</script>
</body>
</html>
