<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+path+"/";
	Object obj=application.getAttribute("uploadfPath");
%>
<!DOCTYPE html>
<html>
	<head>
	<base href="<%=basePath%>">
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1,maximum-scale=1,minimum-scale=1 user-scalable=no,width=320">
		<script type="text/javascript" src="static/js/jquery-1.11.3.min.js" ></script>
		<script type="text/javascript" src="static/js/layout.js" ></script>
		<script src="static/js/basedao.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="static/js/simpleAlert.js"></script>
		<link rel="stylesheet" href="static/css/bc.css" />
		<link rel="stylesheet" href="static/css/simpleAlert.css" />
		<title>设置</title>
	</head>
	<body>
		<div class="cover-wrap upImg">
			<div class="centerDiv">
				<div id="clipArea"></div>
			</div>
			<button id="clipBtn">保存头像</button>
			<!--<div class="centerDiv" id="clipArea"></div>
			<button id="clipBtn">保存封面</button>-->
		</div>
		<div class="wrapper">
			<div class="setting">
			<!-- <form method="post" id="uploadForm" enctype="multipart/form-data">  -->
				<ul>
					<li>
						<a href="javascript:;">
							<label>头像</label>
							<!--头像图片-->
							<div id="view" class="head"></div>
							<input id="file" type="file" name="img" />
							<!--<img class="head" src="img/head.png" />-->
						</a>
					</li>
					<li class="no_link">
						<label>姓名</label>
						<span>${loginuser.USER_NICKNAME }</span>
					</li>
					<!-- <li>
						<a href="javascript:;">
							<label>重置密码</label>
						</a>
					</li> -->
				</ul>
			<!-- </form> -->
				<!-- <a class="log_out" href="userinfo/clearCache">清除缓存</a> -->
			</div>	
		</div>
		<script type="text/javascript" src="static/js/iscroll-zoom.js" ></script>
		<script type="text/javascript" src="static/js/hammer.js" ></script>
		<script type="text/javascript" src="static/js/lrz.all.bundle.js" ></script>
		<script type="text/javascript" src="static/js/jquery.photoClip.min.js" ></script>
		<script type="text/javascript">
		$(function(){
			$(".setting li .head").css({"background-image":"url(${loginuser.USER_PHOTO })"});
		});
	    //上传封面
	    //document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
		var clipArea = new bjj.PhotoClip("#clipArea", {
			size: [300, 300],// 截取框的宽和高组成的数组。默认值为[260,260]
			outputSize: [300, 300], // 输出图像的宽和高组成的数组。默认值为[0,0]，表示输出图像原始大小
			//outputType: "jpg", // 指定输出图片的类型，可选 "jpg" 和 "png" 两种种类型，默认为 "jpg"
			file: "#file", // 上传图片的<input type="file">控件的选择器或者DOM对象
			view: "#view", // 显示截取后图像的容器的选择器或者DOM对象
			ok: "#clipBtn", // 确认截图按钮的选择器或者DOM对象
			loadStart: function() {
				// 开始加载的回调函数。this指向 fileReader 对象，并将正在加载的 file 对象作为参数传入
				$('.cover-wrap').fadeIn();
				console.log("照片读取中");
			},
			loadComplete: function() {
				 // 加载完成的回调函数。this指向图片对象，并将图片地址作为参数传入
				console.log("照片读取完成");
			},
			//loadError: function(event) {}, // 加载失败的回调函数。this指向 fileReader 对象，并将错误事件的 event 对象作为参数传入
			clipFinish: function(dataURL) {
				 // 裁剪完成的回调函数。this指向图片对象，会将裁剪出的图像数据DataURL作为参数传入
				$('.cover-wrap').fadeOut();
				$('#view').css('background-size','100% 100%');
				console.log(dataURL);
				
				/* var file=$("#file")[0].files[0];
				if((file.size/1024)>500){
					var onlyChoseAlert = simpleAlert({
	                    "content":"请选择小于500k的图片!",
	                    "buttons":{
	                        "确定":function () {
	                            onlyChoseAlert.close();
	                        }
	                    }
	                })
	                return;
				} */
				/* var formData = new FormData($( "#uploadForm" )[0]);    */
				var cfg = {
					url : 'userinfo/setting',
					data:{'USER_PHOTO':dataURL},
				};
				var baseDao = new BaseDao(cfg);
				var rdata = baseDao.getResponseData();
				if(rdata.msg!=null){
					var onlyChoseAlert = simpleAlert({
	                    "content":rdata.msg,
	                    "buttons":{
	                        "确定":function () {
	                            onlyChoseAlert.close();
	                        }
	                    }
	                })
				}  
			}
		});
		//clipArea.destroy();
		
		//取消上传
		$(".upImg").on("click",function(){
			$(this).fadeOut();
		})
	    </script>
	</body>
</html>
