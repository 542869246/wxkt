<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>  
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="../weixin/WxChatShare.jsp"%> 
<!doctype html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>联系我们</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link href="${pageContext.request.contextPath}/static/wx/css/mui.min.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/wx/css/common.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/wx/js/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=i448Ael87DblTA0sytQCE10mPuGjkSAe"></script>
		<script type="text/javascript">
			$(function(){
				loadgoAbout();
				loadaddress('${schoolInfo.LUG}','${schoolInfo.LAT}');
			});
			function loadgoAbout(){
				 $.ajax({
					url:'${pageContext.request.contextPath}/schoolabout/goContent',
					type:'post',
					dataType:'json',
					success:function(obj){
						var str="";
						if(obj.SCHOOL_PHONE.trim().indexOf(" ")>0){
							var strs= new Array(); //定义一数组 
							strs=obj.SCHOOL_PHONE.trim().split(" "); //字符分割 
							for(var i=0;i<strs.length;i++){
								str+="<a href='tel:"+strs[i]+"' style='display:inline;'>"+strs[i]+"</a>"
							}
						}else{
							str="<a href='tel:"+obj.SCHOOL_PHONE+"'>"+obj.SCHOOL_PHONE+"</a>";	
						}
						$(".content_ul .content_li .Phonediv").html(str);
						$(".content_ul .content_li .QQdiv").html(obj.SCHOOL_EMAIL);
						$(".content_ul .content_li .Addressdiv").html(obj.SCHOOL_ADDRESS);
						loadaddress(obj.LUG,obj.LAT);
					},error:function(e){
					}
				});
			}
		</script>
	</head>

	<body class="main">
		<div class="mui-contentone">
			<div class="img_contentmain HNH_IMG_o">
			</div>
			<div class="HNH_IMG_t_after">
				<div class="img_contentmain HNH_IMG_t" id="allmap">
			</div>
			</div>
			<ul class="content_ul">
				<li class="content_li Phoneli">
					<div class="contentdiv Phonediv"><a href='tel:${schoolInfo.SCHOOL_PHONE }#mp.weixin.qq.com'>${schoolInfo.SCHOOL_PHONE }</a></div>
				</li>
				<li class="content_li QQli">
					<div class="contentdiv QQdiv"><a href="mailto:${schoolInfo.SCHOOL_EMAIL }#mp.weixin.qq.com">${schoolInfo.SCHOOL_EMAIL }</a></div>
				</li>
				<li class="content_li Addressli">
					<div class="contentdiv Addressdiv">${schoolInfo.SCHOOL_ADDRESS }</div>
				</li>
			</ul>
		</div>
		<script src="${pageContext.request.contextPath}/static/wx/js/mui.min.js"></script>
		<script type="text/javascript">
			mui.init();
		</script>
<script type="text/javascript">
function loadaddress(x,y){
	// 百度地图API功能
	var map = new BMap.Map("allmap");    // 创建Map实例
	var new_point = new BMap.Point(x,y);
	map.centerAndZoom(new_point, 15);  // 初始化地图,设置中心点坐标和地图级别
	//添加地图类型控件
	map.addControl(new BMap.MapTypeControl({
		mapTypes:[
            BMAP_NORMAL_MAP,
            BMAP_HYBRID_MAP
        ]}));	  
	map.setCurrentCity("南京");          // 设置地图显示的城市 此项是必须设置的
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	// 用经纬度设置地图中心点
	var marker = new BMap.Marker(new_point);  // 创建标注
	map.addOverlay(marker);              // 将标注添加到地图中
	map.panTo(new_point);    
}
</script>

</script>
	</body>

</html>