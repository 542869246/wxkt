$(function(){

//日期时间
	(function() {
		var dayNames = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");
		var date = new Date();
		var nowDate = date.getFullYear() + "年" + (date.getMonth() + 1) + "月" + date.getDate() + "日";
		var weekday = dayNames[date.getDay()];
		$(".p-time span").text(nowDate + '(' + weekday + ')');
		//值班日期
		var year = date.getFullYear().toString();
		var month = (date.getMonth() + 1).toString().length == 2 ? (date.getMonth() + 1).toString() : '0' + (date.getMonth() + 1);
		var d = date.getDate().toString().length == 2 ? date.getDate().toString() : '0' + date.getDate();
		var html = '<li><em>' + year.substring(0, 1) + '</em></li><li><em>' + year.substring(1, 2) + '</em></li><li><em>' + year.substring(2, 3) + '</em></li><li><em>' + year.substring(3, 4) + '</em></li><li class="dw"><em>年</em></li><li><em>' + month.substring(0, 1) + '</em></li><li><em>' + month.substring(1, 2) + '</em></li><li class="dw"><em>月</em></li><li><em>' + d.substring(0, 1) + '</em></li><li><em>' + d.substring(1, 2) + '</em></li><li class="dw"><em>日</em></li>';
		$(".time-sty").html(html);
	})();


//tab选项卡切换
(function(){
    fnTab($('.nav-big'),$('.g-mn1c'),'hover');//导航切换
	fnTab($('.nav-main'),$('.nav-list-wrap'),'hover');// 首页 公安 导航切换
	fnTab($('.index-mod-fw .tab-news'),$('.index-mod-fw .tab-news-main'),'hover');// 首页 服务 导航切换
	fnTab($('.jw-tab-01 .tab-news'),$('.jw-tab-01 .tab-news-main'),'hover');// 首页 警务 导航切换
	fnTab($('.jw-tab-02 .tab-news'),$('.jw-tab-02 .tab-news-main'),'hover');// 首页 警务 导航切换
	fnTab($('.jw-tab-03 .tab-news'),$('.jw-tab-03 .tab-news-main'),'hover');// 首页 警务 导航切换
	fnTab($('.fx-tab'),$('.img-group-wrap'),'hover');// 首页 图片 导航切换
	fnTab($('.hz-ul'),$('.hz-ul-main'),'hover');// 首页 警务 导航切换
	function fnTab( oNav, aCon, sEvent ) {
		var aElem = oNav.children();
		aCon.children().hide().eq(0).show();
		aElem.each(function(index){
		   $(this).on(sEvent, function (){
				$(this).addClass('active').siblings().removeClass('active');
				aCon.children().hide().eq(index).show();
			});
		   
		});
   }
})();

	$('.xl_main .xl_sj').on("click", 'a', function() {
		$(this).addClass('active').siblings().removeClass('active');
		//set-font-size
		var fontSize = $(this).attr('set-font-size');
		$('.xl_main .artile-wrap').css('font-size', fontSize + 'px');
	})
	
	
	/*var browser=navigator.appName 
	var b_version=navigator.appVersion 
	var version=b_version.split(";"); 
	var trim_Version=version[1].replace(/[ ]/g,""); 
	if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0") 
	{ 
	alert("IE 6.0"); 
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0") 
	{ 
	alert("IE 7.0"); window.location.href="http://xxxx.com";
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0") 
	{ 
	alert("IE 8.0"); 
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE9.0") 
	{ 
	alert("IE 9.0"); 
	} */
	var localObj = window.location;

	var contextPath = localObj.pathname.split("/")[1];
	
	if (navigator.userAgent.indexOf("MSIE 7.0")>0){ 
		window.location.href="/"+contextPath+"/webpage/version_forward.jsp"
	} else if (navigator.userAgent.indexOf("MSIE 8.0")>0){ 
		window.location.href="/"+contextPath+"/webpage/version_forward.jsp"
	} else if (navigator.userAgent.indexOf("MSIE 6.0")>0){ 
		window.location.href="/"+contextPath+"/webpage/version_forward.jsp"
	} else if (window.navigator.userAgent.indexOf('compatible') != -1) {
		window.location.href="/"+contextPath+"/webpage/version_forward.jsp"
	}
	
});
//打印
function doPrint() {
	$("#print").printArea();
}