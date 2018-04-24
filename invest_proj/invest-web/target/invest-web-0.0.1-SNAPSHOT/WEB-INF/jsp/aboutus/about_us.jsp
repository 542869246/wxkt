<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=jIQATfXZvw7smkE08kEtTfapqSN47ENk"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bc.css" />
		<style type="text/css">
			.about_us .tip img {
			    width: 200%;
			    margin: 0.3rem 0;
				}
				.content{
					margin:0;
				}
		</style>
		<title>关于我们</title>
	</head>
	<body class="content">
		<div class="wrapper">
			<div class="about_us">
				<header>
					<img src="${pageContext.request.contextPath}/static/img/logo.png" />
				</header>
				<c:if test="${not empty pd}">
				<div class="tip">
					<h1>联系我们</h1>
					<div id="allmap" style="height:200px;width: 100%;margin: 0.3rem 0;"></div>
					<!--<img src="img/map.png" />-->
					<p>电话 : ${pd.ABOUT_PHONE }</p>
					<p>邮箱 : ${pd.ABOUT_EMAIL }</p>
					<p>地址 : ${pd.ABOUT_ADDRESS }</p>
				</div>
				<div class="tip">
					<h1>公司简介</h1>
					<p>${pd.ABOUT_CONTENT }</p>
				</div>
			</div>
			</c:if>	
		</div>
	</body>
	<script type="text/javascript">
		$(".wrapper").css("height","auto");
//		var myIcon = new BMap.Icon("http://api.map.baidu.com/img/markers.png", new BMap.Size(23, 25), {  
//		    offset: new BMap.Size(10, 25),  
//		    imageOffset: new BMap.Size(0, 0 - 10 * 25)  
//		  
//		  });  
//		var marker = new BMap.Marker(point, {icon: myIcon});  
		// 百度地图API功能
		var map = new BMap.Map("allmap");    // 创建Map实例
		var point = new BMap.Point(${pd.ABOUT_LNG}, ${pd.ABOUT_LAT}); //添加坐标
		map.centerAndZoom(point, 15);  // 初始化地图,设置中心点坐标和地图级别
		//map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
		map.setCurrentCity("南京");
        var marker = new BMap.Marker(point); //将点转化成标注点
       
		//map.centerAndZoom("南京",15);// 设置地图显示的城市 此项是必须设置的
		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		//开启拖拽
		map.enableDragging();
		map.addOverlay(marker);  //将标注点添加到地图上
		//marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
		//单击获取点击的经纬度
//		map.addEventListener("click",function(e){
//			alert(e.point.lng + "," + e.point.lat);
//		});
		 (function() {
            marker.addEventListener("click",
                function() {
                showInfo(this,point);
            });
         })();
		
		point.name ="百川谨信";
		point.address="${pd.ABOUT_ADDRESS}";
		function showInfo(thisMarker,point) {
		    //获取点的信息
		    var sContent = 
		    '<ul style="margin:0 0 5px 0;padding:0.2em 0">'  
		    +'<li style="line-height: 26px;font-size: 15px;">'  
		    +'<span style="width: 50px;display: inline-block;">名称：</span>' +point.name 
			+ '</li>'  
		    +'<li style="line-height: 26px;font-size: 15px;">'  
		    +'<span style="width: 50px;display: inline-block;">地址：</span>' + point.address + '</li>'  
//		    +'<li style="line-height: 26px;font-size: 15px;"><span style="width: 50px;display: inline-block;">查看：</span><a href="'+point.url+'">详情</a></li>'  
		    +'</ul>';
		    var infoWindow = new BMap.InfoWindow(sContent); //创建信息窗口对象
		    thisMarker.openInfoWindow(infoWindow); //图片加载完后重绘infoWindow
		}


	</script>
</html>