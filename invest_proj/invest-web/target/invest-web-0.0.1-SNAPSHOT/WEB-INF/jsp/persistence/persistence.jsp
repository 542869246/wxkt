<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/common/top.jsp"%>
<% 
	Object imgUrl = application.getAttribute("uploadfPath");
%>

<%@ include file="../weixin/WxChatShare.jsp"%>
<!DOCTYPE html>
<html>

<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
<script type="text/javascript" src="static/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="static/js/layout.js"></script>
<link rel="stylesheet" href="static/css/bc.css" />
<link rel="stylesheet" href="static/css/bc.css" />
<!-- <link rel="stylesheet" href="static/css/load.css" /> -->
<link rel="stylesheet" href="static/css/pagedown.css" />
<title>存续信息</title>
</head>

<body>
	<div class="wrapper">
		<div class="persistence">
			<header style="background: url('<%=imgUrl%>/${img.TYPEIMG_IMGURL}'),url('static/img/error.jpg') ;background-size:100% 100%;background-repeat:no-repeat;"></header>
			<div class="info"></div>
		</div>
	</div>
	<!--
    	作者：
    	时间：2017-10-25
    	描述：标头控制模板
    -->
	<header class="head" style="display: none;">
		<h1>{PRODUCTS_NAME}</h1>
		<ul>
			<li>
				<p>{PRODUCTS_NHSR}</p> <label>年化收益</label>
			</li>
			<li>
				<p>{PRODUCTS_TERM}</p> <label>投资期限</label>
			</li>
			<li>
				<p>{PRODUCTS_AMOUT}</p> <label>投入资金</label>
			</li>
		</ul>
	</header>
	<!-- 加载内容模板 -->
	<div class="context" style="display: none;">
		<h1>{yearMoney}</h1>
	</div>
	<div class="ul_li" style="display: none;">
		<ul>
			<a href ="inormation/getFile?DETAILS_ID={DETAILS_ID}" target="_blank"><li><label>{moneyDay}</label>
				<p>{INFORMATION_CONTENT}</p></li></a>
		</ul>
	</div>
	<script type="text/javascript" src="static/js/flickity.pkgd.min.js"></script>
	<script type="text/javascript" src="static/js/query.js"></script>
	<%-- <script type="text/javascript" src="static/js/paging.js" ></script> --%>
	<!-- <script type="text/javascript" src="static/js/load-min.js" ></script> -->
	<script src="static/js/basedao.js" type="text/javascript"
		charset="utf-8"></script>
	<script type="text/javascript">
			;
			(function($) {
				this.Persistence = function() {
					// 属性加载区
					var initAttribute = function() {

					};
					// 事件加载区
					var onClick = function() {

					};
					//页面加载区
					var upload = function() {
						var set = {};
						set.url = "inormation/findAll";
						var baseDAO = new BaseDao(set);
						var result = baseDAO.getResponseData();
						//创建时间对象
						var mytool = new MyTool();
						//拿到当前的时间
						var datetime = result.dateList;
						// 拿到当前时间的产品信息
						var info = result.list;
						var ul_li = $(".ul_li").html();
						var head = $(".head").html();
						// 查询产品的基本信息
						var proinfos = result.pb;
						// 标头配置基本信息
						$(".persistence header").append(head.replace("{PRODUCTS_NHSR}",proinfos.PRODUCTS_NHSR)
															.replace("{PRODUCTS_TERM}",proinfos.PRODUCTS_TERM)
															.replace("{PRODUCTS_AMOUT}",proinfos.PRODUCTS_AMOUT)
															.replace("{PRODUCTS_NAME}",proinfos.PRODUCTS_NAME));
						//时间循环
						for(var i = 0; i < datetime.length; i++) {
							$(".info").append($(".context").html().replace("{yearMoney}",datetime[i].INFORMATION_CREATETIME));
							// 信息产品信息
							for(var j = 0; j < info.length; j++) {
								var dataMoney = mytool.formatDate(info[j].INFORMATION_MESSAGETIME);
								// 处理年份
								var yearDataMoney = dataMoney.substring(0, 7);
								// 处理月份
								var moneyDay = dataMoney.substring(5, 10);
								if(datetime[i].INFORMATION_CREATETIME == yearDataMoney) {
									$(".info").append(ul_li.replace("{moneyDay}",moneyDay)
															  .replace("{INFORMATION_CONTENT}",info[j].INFORMATION_CONTENT)
															  .replace("{DETAILS_ID}",info[j].INFORMATION_ID));
								}
							};
						};

					};
					return {
						init: function() {
							initAttribute();
							onClick();
							upload();
						}
					}
				}();
				Persistence.init();
			})(jQuery);
		</script>
</body>

</html>