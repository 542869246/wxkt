function smsPicClick(){
	 hideDiscussTool(); //隐藏评论工具栏
     showDiscussForm(); //显示评论表单
}
//隐藏评论文本框

function hideDiscussForm() {
    $(".video-discuss-form").hide();
}
//显示评论文本框

function showDiscussForm() {
	if(PlayUrl==null&&roomList==null||roomList==""){
		return;
	 }
    $(".video-discuss-form").show();
}
//隐藏评论工具栏
function hideDiscussTool() {
	if(PlayUrl==null&&roomList==null||roomList==""){
		return;
	 }
    $(".video-discuss-tool").hide();
}
//显示评论工具栏

function showDiscussTool() {
    $(".video-discuss-tool").show();
}
//发送消息
function onSendMsg() {
	    //获取消息内容
	    var msgtosend = $("#send_msg_text").val();
	    if (msgtosend.length < 1) {
	        alert("发送的消息不能为空!");
	        return;
	    }
	    //解析文本和表情
	    var expr = /\[[^[\]]{1,3}\]/mg;
	    var emotions = msgtosend.match(expr);
		$.ajax({
			url: basePath+"Comment/AddComment",
			type: "post",
			dataType:"json",
			data:{"WEBUSERID":USERS_ID,"COMMENTCONTER":msgtosend},
			cache : false,
			async : false,
			success:function(data){
			}
		});
	        showMsg(msgtosend,USERS_NAME);
	        $("#send_msg_text").val('');
	        hideDiscussForm(); //隐藏评论表单
	        showDiscussTool(); //显示评论工具栏
}
//显示消息（群普通+点赞+提示+红包）

function showMsg(mag,userName) {
	var COMMENTCONTER=mag;
    var isSelfSend, fromAccount, fromAccountNick, sessType, subType;
    var ul, li, paneDiv, textDiv, nickNameSpan, contentSpan;
    ul = document.getElementById("video_sms_list");
    var maxDisplayMsgCount = 4;
    //var opacityStep=(1.0/4).toFixed(2);
    var opacityStep = 0.2;
    var opacity;
    var childrenLiList = $("#video_sms_list").children();
    if (childrenLiList.length == maxDisplayMsgCount) {
        $("#video_sms_list").children(":first").remove();
        for (var i = 0; i < maxDisplayMsgCount; i++) {
            opacity = opacityStep * (i + 1) + 0.2;
            $('#video_sms_list').children().eq(i).css("opacity", opacity);
        }
    }
    li = document.createElement("li");
    paneDiv = document.createElement("div");
    paneDiv.setAttribute('class', 'video-sms-pane');
    textDiv = document.createElement("div");
    textDiv.setAttribute('class', 'video-sms-text');
    nickNameSpan = document.createElement("span");

    var colorList = ['red', 'green', 'blue', 'org'];
    nickNameSpan.innerHTML = userName+":";//用户名称
    contentSpan = document.createElement("span");
    contentSpan.innerHTML = mag;//评论内容
    textDiv.appendChild(nickNameSpan);
    textDiv.appendChild(contentSpan);

    paneDiv.appendChild(textDiv);
    li.appendChild(paneDiv);
    ul.appendChild(li);
}
//加载评论
function loadComment(){
	if(PlayUrl==null){
		return;
	 	}
	setInterval(function() {
		$.ajax({
			url: basePath+"Comment/ListComment",
			type: "post",
			dataType:"json",
			data:{"CLASSROOM":CLASSROOM_ID},
			cache : false,
			async : false,
			success:function(data){
				var commentList=data.commentList;
				for(var i=0;i<commentList.length;i++){
					showMsg(commentList[i].COMMENTCONTER,commentList[i].USERS_WECHAT_NICKNAME);
				}
			}
		})
	},1000);
}
//把消息转换成Html

function convertMsgtoHtml(msg) {
    var html = "",
        elems, elem, type, content;
    elems = msg.getElems(); //获取消息包含的元素数组
    for (var i in elems) {
        elem = elems[i];
        type = elem.getType(); //获取元素类型
        content = elem.getContent(); //获取元素对象
        switch (type) {
            case webim.MSG_ELEMENT_TYPE.TEXT:
                html += convertTextMsgToHtml(content);
                break;
            case webim.MSG_ELEMENT_TYPE.FACE:
                html += convertFaceMsgToHtml(content);
                break;
            case webim.MSG_ELEMENT_TYPE.IMAGE:
                html += convertImageMsgToHtml(content);
                break;
            case webim.MSG_ELEMENT_TYPE.SOUND:
                html += convertSoundMsgToHtml(content);
                break;
            case webim.MSG_ELEMENT_TYPE.FILE:
                html += convertFileMsgToHtml(content);
                break;
            case webim.MSG_ELEMENT_TYPE.LOCATION: //暂不支持地理位置
                //html += convertLocationMsgToHtml(content);
                break;
            case webim.MSG_ELEMENT_TYPE.CUSTOM:
                html += convertCustomMsgToHtml(content);
                break;
            case webim.MSG_ELEMENT_TYPE.GROUP_TIP:
                html += convertGroupTipMsgToHtml(content);
                break;
            default:
                webim.Log.error('未知消息元素类型: elemType=' + type);
                break;
        }
    }
    return webim.Tool.formatHtml2Text(html);
}

//解析文本消息元素

function convertTextMsgToHtml(content) {
    return content.getText();
}
//点赞
function sendGroupLoveMsg() {
	if(PlayUrl==null||PlayUrl==""){
		return;
	 	}
	var GOODCOUNT= $('#user-icon-like').html();
	$.ajax({
		url: basePath+"gotye/updateGotype",
		type: "post",
		dataType:"json",
		data:{"CLASSROOM_ID":CLASSROOM_ID},
		cache : false,
		async : false,
		success:function(data){
			 $('#user-icon-like').html(parseInt(data.GOODCOUNT));
		}
	});
	showLoveMsgAnimation();
}
//展示点赞动画

function showLoveMsgAnimation() {
	showMsg("送了一个点赞",USERS_NAME);
	$.ajax({
		url: basePath+"Comment/AddComment",
		type: "post",
		dataType:"json",
		data:{"WEBUSERID":USERS_ID,"COMMENTCONTER":"送了一个点赞"},
		cache : false,
		async : false,
		success:function(data){
		}
	});
    //点赞数加1
    var loveCount = $('#user-icon-like').html();
    var toolDiv = document.getElementById("video-discuss-tool");
    var loveSpan = document.createElement("span");
    var colorList = ['red', 'green', 'blue'];
    var max = colorList.length - 1;
    var min = 0;
    var index = parseInt(Math.random() * (max - min + 1) + min, max + 1);
    var color = colorList[index];
    loveSpan.setAttribute('class', 'like-icon zoomIn ' + color);
    toolDiv.appendChild(loveSpan);
}