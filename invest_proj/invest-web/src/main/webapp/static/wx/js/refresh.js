var count = 0;
mui.init({
	pullRefresh: {
		container: "#refreshContainer2", //下拉刷新容器标识，querySelector能定位的css选择器均可，比如：id、.class等
		down: {
			height: 40, //默认50.触发下拉刷新拖动距离,
			auto: false, //默认false.首次加载自动下拉刷新一次
			contentdown: "下拉可以刷新", //下拉刷新控件上显示的标题内容
			contentover: "释放立即刷新", //下拉刷新控件未释放显示的内容
			contentrefresh: "正在刷新...", //可选，正在刷新状态时，下拉刷新控件上显示的标题内容
			callback: function() {
				setTimeout(function() {
					callback_endPulldownToRefresh(); //ajax下拉请求处理方法
					mui('#refreshContainer2').pullRefresh().endPulldownToRefresh(); //refresh completed
				}, 1000);
			}
		},
		up: {
			height: 50,
			auto: true, //默认false.自动上拉加载一次
			contentrefresh: "正在加载...",
			contentnomore: '没有更多数据了', //请求完毕若没有更多数据时显示的提醒内容；
			callback: function() { //必选，回调的刷新函数，根据具体业务来编写，比如通过ajax从服务器获取新数据；
				setTimeout(function() {
					callback_endPullupToRefresh(); //ajax上拉请求处理方法
					//mui('#refreshContainer2').pullRefresh().endPullupToRefresh(true); //参数为true代表没有更多数据了。
				}, 1200);
			}
		}
	}
});
if(mui.os.plus) {
	mui.plusReady(function() {
		setTimeout(function() {
			mui('#refreshContainer2').pullRefresh().pullupLoading();
		}, 1000);

	});
} else {
	mui.ready(function() {
		mui('#refreshContainer2').pullRefresh().pullupLoading();
	});
}