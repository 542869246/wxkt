/**
 * Name:消息插件 V1.0
 * 
 * Author: zyf
 * 
 * Date:2017-12-08
 * 
 * Description:传入左右、内容、操作老师
 * 
 * Sample:
 *          window.mycreatemessage(true, myjson,'李四')
 * 
 */

(function(w) {

	w.getId=function (ele) {
			return document.getElementById(ele)
	}
	w.mycreatemessage = function(isleft,typeName,work, teacher,time,count) {
		//补零
		function zerofill(t) {
			return t < 10 ? ('0' + t) : t
		}

		function getid(ele) {
			return document.getElementById(ele)
		}

		function getclass(ele) {
			return document.getElementsByClassName(ele)[0]
		}

		function create(ele) {
			return document.createElement(ele)
		}
		let cmc_content = 'leftcmcc'
		let cmcc_time = 'leftmessage'
		let cmcc_title = 'leftcmccmarginleft'
		let titletext = typeName
		const content = getid("mycontent")
		if(count%2==0){
			cmc_content = 'rightcmcc'
				cmcc_time = 'rightmessage'
				cmcc_title = 'rightcmccmarginleft'
		}
	/*	if(isleft=="作业录入"){
				titletext = '作业录入'
		}else if(isleft=="作业验收"){
				cmc_content = 'rightcmcc'
				cmcc_time = 'rightmessage'
				cmcc_title = 'rightcmccmarginleft'
				titletext = '作业验收'
		}else if(isleft=="离开时间"){
			cmc_content = 'rightcmcc'
				cmcc_time = 'rightmessage'
				cmcc_title = 'rightcmccmarginleft'
				titletext = '离开时间'
		}*/
		let isok = ''
		let worklenght = 0
		let workall = ''
		/*for(var i = 0; i < worklenght; i++) {
			workcontent = `<div style="font-size: 12px;">
										[${work[i].name}][${work[i].time}min] ${work[i].content} ${isok}
									</div>`
			workall = workall + workcontent
		}*/
			

		for(var i in work) {
			if(isleft=="zyys"){
				if(work[i].isok==0){
					isok = '(达标)';
				}else{
					isok = '(不达标)';
				}
			}
			if(work[i].time==""||work[i].time==null||work[i].time=="undefined"){
				workcontent = `<div style="font-size: 12px;">
					[${work[i].name}] ${work[i].content} ${isok}
				</div>`
			}
			if(work[i].name==""||work[i].name==null||work[i].name=="undefined"){
				workcontent = `<div style="font-size: 12px;">
					[${work[i].time}min] ${work[i].content} ${isok}
				</div>`
			}
			if(work[i].name==""||work[i].name==null ||work[i].name=="undefined"&&work[i].time==""||work[i].time==null){
				workcontent = `<div style="font-size: 12px;">
					${work[i].content} ${isok}
				</div`
			}
			if(work[i].name!=""&&work[i].name!=null&&work[i].name!='undefined'&&work[i].time!=""&&work[i].time!=null){
				workcontent = `<div style="font-size: 12px;">
					[${work[i].name}][${work[i].time}min] ${work[i].content} ${isok}
				</div>`
			}
			
			workall = workall + workcontent
			worklenght++
		}

		workall += `<div style="font-size: 12px;">
										操作老师 : ${teacher}
									</div>`
		var dataTime=new Date(time);
		const hours = zerofill(dataTime.getHours())
		const minutes = zerofill(dataTime.getMinutes())
		const currenthours=zerofill(new Date().getHours())
		const currentminutes=zerofill(new Date().getMinutes());
		var time=TimeDifference(time);
		const message = create('div')
		var display=isNaN(parseInt(time).toString())?"display:none":"";
		message.innerHTML = `<div class="content_message_center" style="overflow:hidden;">
							<div class="cmc_content ${cmc_content}">
								<div class="cmcc_time ${cmcc_time}">
									<div class="fa fa-clock-o fa-flip-horizontal mytime" aria-hidden="true"></div>
									<div class="cmcct_t">
										<span>${hours}</span>:<span>${minutes}</span>分
									</div>
								</div>
								<div class="cmcc_title ${cmcc_title}">
									${titletext}
								</div>
								<div class="cmcc_content ${cmcc_title}">
									${workall}
								</div>
								<div class="cmcc_bottom ${cmcc_title}">
									<span class="cmcc_bottomtime" style='${display}'>${time}ago</span> 
								</div>
							</div>
						</div>`
				
		message.className = "content_message"
		message.style.height = 100+ 21 + ((worklenght - 1) * 19) + 'px'
		display="";
		return message

	}
	function TimeDifference(time2)
	{
	//定义两个变量time1,time分别保存开始和结束时间
	var time=new Date().Format("yyyy-MM-dd HH:mm:ss");
	var time1=new Date();
	time1.setTime(time2);
	time1=time1.Format("yyyy-MM-dd HH:mm:ss");
	//判断开始时间是否大于结束日期
	if(time1>time)
	{
	   return 0;
	}

	//截取字符串，得到日期部分"2009-12-02",用split把字符串分隔成数组
	var begin1=time1.substr(0,10).split("-");
	var end1=time.substr(0,10).split("-");

	//将拆分的数组重新组合，并实例成化新的日期对象
	var date1=new Date(begin1[1] + - + begin1[2] + - + begin1[0]);
	var date2=new Date(end1[1] + - + end1[2] + - + end1[0]);

	//得到两个日期之间的差值m，以分钟为单位
	//Math.abs(date2-date1)计算出以毫秒为单位的差值
	//Math.abs(date2-date1)/1000得到以秒为单位的差值
	//Math.abs(date2-date1)/1000/60得到以分钟为单位的差值
	var m=parseInt(Math.abs(date2-date1)/1000/60);

	//小时数和分钟数相加得到总的分钟数
	//time1.substr(11,2)截取字符串得到时间的小时数
	//parseInt(time1.substr(11,2))*60把小时数转化成为分钟
	var min1=parseInt(time1.substr(11,2))*60+parseInt(time1.substr(14,2));
	var min2=parseInt(time.substr(11,2))*60+parseInt(time.substr(14,2));

	//两个分钟数相减得到时间部分的差值，以分钟为单位
	var n=min2-min1;
	//将日期和时间两个部分计算出来的差值相加，即得到两个时间相减后的分钟数
	var minutes=m+n;
	minutes=toHourMinute(minutes);
	return minutes;
	}
	function toHourMinute(minutes){
		if(parseInt(minutes)>60){
			var hour= Math.floor(minutes/24);
			if(hour>60){
				return Math.floor(hour/60+ " day");
			}else{
				return Math.floor(minutes/60)+ " hour";
			}
		}else{
			return minutes+" minutes";
		}
		  //return (Math.floor(minutes/60) + " hour  " + (minutes%60) );
		  // 也可以转换为json，以方便外部使用
		  // return {hour:Math.floor(minutes/60),minute:(minutes%60)};
		}
})(window)