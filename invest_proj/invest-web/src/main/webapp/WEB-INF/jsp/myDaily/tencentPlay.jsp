<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/top.jsp"%> 
<%@ include file="../weixin/WxChatShare.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no">
    <title>实时课堂</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="format-detection" content="telephone=no">
    <script type="text/javascript" src="${basePath}static/wx/js/jquery-2.1.4.min.js"></script>
    <link rel="stylesheet" href="${basePath}static/wx/css/mobile.css?v=1.0.3">
		<link href="${basePath}static/wx/css/mui.min.css" rel="stylesheet"/>
    	<script src="${basePath}static/wx/js/mui.min.js"></script>
    	<script src="${basePath}static/wx/js/mui.view.js"></script>
    	<script type="text/javascript">
        	var basePath='<%=basePath%>'
        </script>
        	<style type="text/css">
.zyf_header{
position: absolute;
top:16px;
right:0;
color:#FFFFFF;
line-height:28px;
font-size: 17px;
}
.mui-table-view-cell{
text-align: center;
}
.clickclassli{
/* background-color: ; */
color:#007aff;
}
</style>
</head>
<body>
<div class="video-page">
    <!--视频部分 start-->
    <div class="video-play">
        <div id="id_test_video" style="width:100%; height:auto;"></div>
        <script src="//imgcache.qq.com/open/qcloud/video/live/h5/live_connect.js" charset="utf-8"></script>
        <script type="text/javascript" src="${basePath}static/wx/js/Myplay.js"></script>
        <!--下列图片可删除，在此做视频示意-->
<!--         <img id="defaultImg" src="../static/wx/img/back-img2.png" width="100%" height="100%">
 -->    </div>
    <!--视频部分 end-->
	
    <!--聊天部分 start-->
    <div class="video-pane">
        <div class="video-pane-head" style="position:relative;z-index=99">
            <div class="video-pane-info">
                <div class="video-info">
                    <div class="user-img">
                        <img src="${basePath}static/wx/img/user-img.png" onerror="${basePath}static/wx/img/user-img.png" width="45"><!-- 直播室头像 -->
                    </div>
                    <div class="user-info-text">
                        <div class="user-info-name"></div>
                        
                        <div class="user-info-num">
                            <i class="user-icon-like"></i><span id="user-icon-like">0</span>
                        </div>
                    </div>
                </div>
            </div>
            <!-- <div class='zyf_header show_classroomName' style="position:fixed;left:40%;top:5.2%"> -->
            <div class='zyf_header show_classroomName' style="top:32.2%;margin-right: 37%">
			</div>
            <div class='zyf_header' id="openPopover">
              	<a class="mui-action-menu mui-icon mui-icon-bars mui-pull-right" style="margin-right:10px;font-size: 17px;line-height:1.9999" href="#topPopover">&nbsp;选择教室</a>
			</div>
        </div>
        <div class="video-pane-body">
            <div class="video-discuss">
                <ul class="video-sms-list" id="video_sms_list">
                <!-- 评论列表 -->
                </ul>
                <div class="video-discuss-pane">
                    <div class="video-discuss-tool" id="video-discuss-tool">
                        <!--<span class="like-icon zoomIn green"></span>-->
                        <a href="javascript:void(0);" class="video-discuss-sms" onclick="smsPicClick()"></a>

                        <a href="javascript:void(0);" class="video-discuss-like" onclick="sendGroupLoveMsg()"></a>
                    </div>
                    <div class="video-discuss-form" id="video-discuss-form" style="display: none">
                        <input type="text" class="video-discuss-input" id="send_msg_text">
                        <button class="video-discuss-button" onclick="onSendMsg()">发送</button>
                    </div>
                    <div class="video-discuss-emotion" id="video-discuss-emotion" style="display: none">
                        <div class="video-emotion-pane">
                            <ul id="emotionUL">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--聊天部分 end-->
</div>
		                 <!--右上角弹出菜单-->
       <div id="topPopover" class="mui-popover" style='width:150px;'>
  		<ul class="mui-table-view">
    		  <!-- <li class="mui-table-view-cell"><span class='view_classname'>教室1</span><span class='view_classid' style='display: none'>1</span></li> -->
  		</ul>
	  </div>
<%-- <script type="text/javascript" src="${basePath}static/wx/js/sdk/json2.js"></script> --%>
<script type="text/javascript" src="${basePath}static/wx/js/tencentPlay/tencentComment.js"></script>
 <!-- <script src="//imgcache.qq.com/open/qcloud/video/vcplayer/TcPlayer-2.2.1.js" charset="utf-8"></script> --> 
 <script src="//qzonestyle.gtimg.cn/open/qcloud/video/live/h5/live_connect.js" charset="utf-8"></script>
 <c:if test="${loginuser!=null}">
         <script type="text/javascript">
         var PlayUrl="${PlayUrl}";
         var roomList="";
           $(function(){
        	   roomList=loadRoom();
        	   if(roomList!="" && roomList!=null){
        		   $('.show_classroomName').html(" ${CLASSROOM_NAME}");
        	   }
             })
 		</script>
 </c:if>
 <c:if test="${CLASSROOM_ID!=null}">
  <script type="text/javascript">
  if(PlayUrl==null||PlayUrl==""){
	  alert("视频无法播放,请联系学校老师");
  }
  if(PlayUrl!=""){
	  $('#user-icon-like').html("${GOODCOUNT}")	  
  }
  var USERS_NAME="${user.USERS_NAME}"
  var CLASSROOM_ID="${CLASSROOM_ID}";
  var USERS_ID="${user.USERS_ID}";
 $(function(){
	 var playWidth=$(window).width();
    	var playHeight=$(window).height();
	     var player = new qcVideo.Player('id_test_video', {
 		"live_url" : PlayUrl,
 		"width" : playWidth,//视频的显示宽度，请尽量使用视频分辨率宽度
 		"height" : playHeight//视频的显示高度，请尽量使用视频分辨率高度
 });
	     player.playStatus=function(status,type){
	    	 if(status=="播放结束"){
	    		 alert("直播结束")
	    	 }
	     }
   	if("${user.USERS_WHETHER}"==0 || "${user.USERS_WHETHER}"==2){
   		 $(".mui-table-view li").each(function(i,ele){
   			 if("${CLASSROOM_ID}"==$(ele).find(".view_id").text()){
   				 var starttime=$(ele).find(".view_startitme").text();
   				 var endtime=$(ele).find(".view_endtitme").text();
   				timevalid(starttime,endtime);
   			 }
   		});
   	}
 }); 
 </script>
 </c:if>
<c:if test="${status!=1 && CLASSROOM_ID==null}">
<script type="text/javascript">
$(function(){
    	var falg=true;
		for(var i=0;i<roomList.length;i++){
			if(roomList[i].CHECK_TYPE==1){ 
				falg=false;
				loadTencent(roomList[i].CLASSROOM_ID);//腾讯
	        	break;
	        }
		}
		if(falg){
			loadGotye(roomList[0].CLASSROOM_ROOMID);
		}
})
</script>
</c:if>
</body>
</html>
