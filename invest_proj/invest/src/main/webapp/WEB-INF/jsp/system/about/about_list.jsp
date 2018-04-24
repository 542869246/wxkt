<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=i448Ael87DblTA0sytQCE10mPuGjkSAe"></script>
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					
					<!-- 城市名: <input id="cityName" type="text" style="width:100px; margin-right:10px;" />
					<input type="button" value="查询" onclick="theLocation()" />
					 -->
					
					<form action="about/edit.do" name="Form" id="Form" method="post">
					
					
						<input type="hidden" name="ABOUT_ID" id="ABOUT_ID" value="${pd.ABOUT_ID}"/>
						<input type="hidden" name="ABOUT_CONTENT" id="ABOUT_CONTENT"/>
						<code id="testcon" style="display:none;">${pd.ABOUT_CONTENT}</code>
						<div id="zhongxin" style="padding-top: 13px;">
						
						<div style="float:left; width: 90%;" >
						
						<div style="margin-top: 10px;margin-left: 20px;">
			            </div>
						</div>
							 
					
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<!-- <tr>
								<td style="width:75px;text-align: right;padding-top: 18px;">内容:</td>
								<td>
								 <script id="editor" type="text/plain" style="width:42%;height:20%;"></script>
								</td>
							</tr>
							 -->
							 <tr>
								<td colspan="2">
									<div  id="allmap" style="width: 100%; height: 300px;" ></div>
								</td>
							</tr>
							 <tr>
								<td style="width:75px;text-align: right;padding-top: 18px;">经纬度:</td>
								<td>
									 经度<input type="text" id="longitude" name="ABOUT_LNG" />
			                                                            纬度 <input type="text" id="latitude" name="ABOUT_LAT" />
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 18px;">电话:</td>
								<td><input type="text" name="ABOUT_PHONE" id="ABOUT_PHONE" value="${pd.ABOUT_PHONE}" maxlength="50" placeholder="这里输入电话" title="电话" style="width:77%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 18px;">邮箱:</td>
								<td><input type="text" name="ABOUT_EMAIL" id="ABOUT_EMAIL" value="${pd.ABOUT_EMAIL}" maxlength="100" placeholder="这里输入邮箱" title="邮箱" style="width:77%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 18px;">地址:</td>
								<td><input type="text" name="ABOUT_ADDRESS" id="ABOUT_ADDRESS" value="${pd.ABOUT_ADDRESS}" maxlength="200" placeholder="这里输入地址" title="地址" style="width:77%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 18px;">公司简介:</td>
								<td>
									<script id="editor" type="text/plain" style="width:90%;height:200px;float: left;"></script>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
								<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="window.location.reload()">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- 编辑框-->
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="static/js/myjs/fhsms.js"></script>
	
	<script type="text/javascript">
	$(function(){
		if(${pd.ABOUT_CONTENT!=null}){
		    window.setTimeout(setContent,1000);//一秒后再调用赋值方法
			}
	})
		//给ueditor插入值
	    function setContent(){
	        UE.getEditor('editor').execCommand('insertHtml', $('#testcon').html());
	        
	    	}
		//ueditor-html
		    function getAllHtml() {
	
		        return UE.getEditor('editor').getAllHtml();
		    }
		$(top.hangge());
		
		function close(){

		}
		
		//保存
		function save(){
			if($("#ABOUT_PHONE").val()==""){
				$("#ABOUT_PHONE").tips({
					side:3,
		            msg:'请输入电话',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ABOUT_PHONE").focus();
			return false;
			}
			if($("#ABOUT_EMAIL").val()==""){
				$("#ABOUT_EMAIL").tips({
					side:3,
		            msg:'请输入邮箱',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ABOUT_EMAIL").focus();
			return false;
			}
			if($("#ABOUT_ADDRESS").val()==""){
				$("#ABOUT_ADDRESS").tips({
					side:3,
		            msg:'请输入地址',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ABOUT_ADDRESS").focus();
			return false;
			}
			/*if($("#ABOUT_CONTENT").val()==""){
				$("#ABOUT_CONTENT").tips({
					side:3,
		            msg:'请输入内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ABOUT_CONTENT").focus();
			return false;
			}*/
			if($("#ABOUT_LNG").val()==""){
				$("#ABOUT_LNG").tips({
					side:3,
		            msg:'请输入经度',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ABOUT_LNG").focus();
			return false;
			}
			if($("#ABOUT_LAT").val()==""){
				$("#ABOUT_LAT").tips({
					side:3,
		            msg:'请输入纬度',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ABOUT_LAT").focus();
			return false;
			}
			var getall=getAllHtml();
			$("#ABOUT_CONTENT").val(getall);
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
		<script type="text/javascript">
	var x=${pd.ABOUT_LNG};
	var y=${pd.ABOUT_LAT};
	// 百度地图API功能
	var map = new BMap.Map("allmap");  // 创建Map实例
    map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_LEFT, type: BMAP_NAVIGATION_CONTROL_SMALL}));  //左上角，仅包含平移和缩放按钮。
    var point = new BMap.Point(x,y);
		$("#longitude").val(point.lng);
		$("#latitude").val(point.lat);
		map.addControl(new BMap.NavigationControl());    //添加控件：缩放地图的控件，默认在左上角；
		map.addControl(new BMap.MapTypeControl());        //添加控件：地图类型控件，默认在右上方；
		map.addControl(new BMap.ScaleControl());        //添加控件：地图显示比例的控件，默认在左下方；
		map.addControl(new BMap.OverviewMapControl());  //添加控件：地图的缩略图的控件，默认在右下方； TrafficControl
		map.centerAndZoom(point, 14);
		var marker = new BMap.Marker(point);  // 创建标注
		map.addOverlay(marker);              // 将标注添加到地图中
		marker.enableDragging();    //可拖拽
		map.enableScrollWheelZoom();//可以鼠标滚动 缩放比例尺	
		
		
		
		map.addEventListener("click",function(e){
		//alert('经度:'+e.point.lng+' , 纬度: '+e.point.lat);
		var now_point =  new BMap.Point(e.point.lng, e.point.lat );
		marker.setPosition(now_point);//设置覆盖物位置
			$("#longitude").val(e.point.lng);
			$("#latitude").val(e.point.lat);
});
		
		  marker.addEventListener("dragend",function(e){
		    var p = marker.getPosition();//获取marker的位置
		   //$("#x").val();
			//alert("你的的位置是" + p.lng + "," + p.lat); 
		   	$("#longitude").val(p.lng);
			$("#latitude").val(p.lat);
		    //alert(e.point.lng+"----"+e.point.lat);
			//parent.document.getElementById("vlong").value=(e.point.lng);
			//parent.document.getElementById("vlat").value=(e.point.lat);

}); 
	function theLocation(){
		var city = document.getElementById("cityName").value;
		if(city != ""){
			map.centerAndZoom(city,13);      // 用城市名设置地图中心点
		}
	}
</script>
</body>
</html>