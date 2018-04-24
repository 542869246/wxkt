    //加载教室号
    function loadRoom(){
    	var countid=0;
    	var roomList;
		$.ajax({
			url:basePath+'gotye/goGotyeLive',
			type:'get',
			datatype:'json',
			async:false,
			success:function(data){
				roomList=data.roomList;
				if(roomList==""||roomList==null){
					if(data.message!="查看直播时，登陆用户名为空"){
						alert("您当前没有可以观看的直播教室");
					}
					return;
				}
				for(var i=0;i<roomList.length;i++){
					createchildbtn(roomList[i].CLASSROOM_ID,roomList[i].CLASSROOM_NAME,roomList[i].CLASSROOM_ROOMID,roomList[i].CHANNELID,roomList[i].CHECK_TYPE,countid++,roomList[i].starttime,roomList[i].endtiem);
				}
				//点击列表
				$('.mui-table-view-cell').on('tap', function() {
				mui('#topPopover').popover('hide');//show hide toggle 关闭弹出菜单
				$(this).parent().find('li').removeClass('clickclassli')//移除选中
				$(this).addClass('clickclassli')//添加选中样式
				myonload($(this).find("[class='view_classid']").text(),$(this).find("[class='view_id']").text(),$(this).find("[class='CHECK_TYPE']").text());
			})
			}
		});
		return roomList;
    }
    //创建节点
    function createchildbtn(roomid,roomname,room_id,channelId,CHECK_TYPE,countid,startitme,endtitme){
 	   var str='<li class="mui-table-view-cell"><span class="view_id" style="display: none">'+roomid+'</span><span class="view_classid" style="display: none">'+room_id+'</span><span class="channelId" style="display: none">'+channelId+'</span><span class="CHECK_TYPE" style="display: none">'+CHECK_TYPE+'</span><span class="view_name">'+roomname+'</span><span class="view_startitme" style="display: none">'+startitme+'</span><span class="view_endtitme" style="display: none">'+endtitme+'</span></li>'
 	   if("${roomId}"==room_id){
 		  $('.mui-table-view').eq(countid).toggleClass('clickclassli').children("span:last-child").show()
 	   }
				$(".mui-table-view").eq(0).append(str);
	}
//节点点击事件
function myonload(id,roomCLassId,CHECK_TYPE) {
	if(CHECK_TYPE==0){
		loadGotye(id);//亲加房间id
	}else{
		loadTencent(roomCLassId);//腾讯传教室id
	}
}
//加载亲加
function loadGotye(id){
	location.href=basePath+"live/"+id;
}
//加载腾讯
function loadTencent(id){
	location.href=basePath+"tencentPlay/getPlayUrl/"+id;
}
////监听时间
function timevalid(starttime,endTime){
	   if(starttime==""||endTime==""){
		   return;
	   }
	var iCount=setInterval(function() {
		var currentTime=new Date();
	/*	$.ajax({
		      async: false,
		      type: "POST",
		      success: function(result, status, xhr) {
		     currentTime = new Date( xhr.getResponseHeader("Date"));
		     }
		});*/
		if(currentTime.getTime()>=endTime){//判断时间
				mui.alert("直播时间结束", "提示", "确定");
				//location.href=basePath+"activity/goActivity";
				clearInterval(iCount)
				return;
		}
	},1000);
} 
//默认验证密码
	function passwordva(roomid,type){
		var flag=false;
	  mui.prompt("请输入直播间密码！","登录",function(e){
		  if(e.value==""||e.value==null){
			 if(type==0){
				 loadGotye(0);
			 }else{
				 loadTencent(0);
			 }
			return;
		  }
			var state=3;//判断是否有异常:0无
			var message="";
			$.ajax({
			url:basePath+'gotye/passwordVali',
			type:'post',
			dataType:'json',
			async:false,
			data:{"BACKSTAGE_PASSWORD":e.value,"CLASSROOM_ID":roomid},
			success:function(obj){
				state=obj.state;
				message=obj.message;
			}
		});
			if(state==1){
				mui.alert(message,"系统提示","确认");
				 if(type==0){
					 loadGotye(0);
				 }else{
					 loadTencent(0);
				 }
		}
	  })
	}