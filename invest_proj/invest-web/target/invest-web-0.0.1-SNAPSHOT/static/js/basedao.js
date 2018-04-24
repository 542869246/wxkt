;(function($){
	this.BaseDao=function(cfg){
		var set={
			url:'default',
			data:{}
		}
		if(cfg!=null){
			$.extend(set,cfg);
		}
		this.getResponseData=function(){
		//	console.info("14："+set.url);
			if(set.url=='default'){
				throw new Error("请正确设置配置参数");
			}
			var rData=null;
			//console.info(set);
			$.ajax({
				type:"post",
				url:set.url,
				data:set.data,
				async:false,
				dataType:"json",
				processData:set.pc,
				contentType:set.pc,
				beforeSend:function(){
					//console.info("show");
				},
				success:function(data){
					rData=data;
				},
				complete:function(){
					//console.info("hide");
				}
			});
			return rData;
		}
	}
	this.MyTool=function(){
		this.formatDate=function(date){
			var time=new Date(date);
			return time.getFullYear()+"-"+("0"+(time.getMonth()+1)).slice(-2)+"-"+("0"+time.getDate()).slice(-2)+" "+
			(time.getHours() < 10 ? "0" + time.getHours() : time.getHours())+":"+
			(time.getMinutes() < 10 ? "0" + time.getMinutes() : time.getMinutes())+":"+
			(time.getSeconds() < 10 ? "0" + time.getSeconds() : time.getSeconds());
		}
		//判断新闻是否需要显示new小图标
		this.isShowNew = function(date) {
			var date1 = new Date(date); //开始时间
			var date2 = new Date(); //结束时间
			var date3 = date2.getTime() - date1.getTime() //时间差的毫秒数

			//计算出相差天数
			var days = Math.floor(date3 / (24 * 3600 * 1000))
			//console.info(days);
			if (days > 7) {
				return false;
			} else {
				return true;
			}
		}
	}
})(jQuery);