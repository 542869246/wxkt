<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.weixin.untifycall.WechatUnifyService,java.util.*,com.weixin.util.*"%>
<%
String orderSequence = request.getParameter("orderSequence");
String payType = request.getParameter("payType");
String redId = request.getParameter("redId");
if(WechatUnifyService.isWechatBrowser(request)){

	String wxconfigbasepath = request.getScheme()+"://"+request.getServerName()+request.getContextPath()+"/";
	String currentjsppath = request.getScheme()+"://"+request.getServerName()+request.getRequestURI();
	if(request.getQueryString()!=null) {       //get param
		currentjsppath+="?"+request.getQueryString();
	}
	String prepayid ="prepay_id="+request.getAttribute("package").toString();
	System.out.println("==============================prepayid==========================================");
	System.out.println(prepayid);
	String wxPayType = request.getAttribute("wxPayType").toString();
	String ORDER_ID = (null==request.getAttribute("ORDER_ID")?null:request.getAttribute("ORDER_ID").toString());
	
	Object wxPath = request.getAttribute("wxPath");
	if(null==wxPath){
		System.out.println("wxPath null");
	}
	//wxConfig注入
	Map<String,Object> wxconfigmap = WxUtil.getWxConfig(wxPath.toString());
	//wx pay 参数注入
	Map<String,Object> wxpayparam = WxUtil.getWxpayParam(prepayid);
	
	System.out.println("pay param:\n"+wxpayparam);
	
	
	
	%>
	<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script type="text/javascript">
		
		wx.config({
			    debug: false,
			    appId: '<%=wxconfigmap.get("appId") %>',
			    timestamp: <%=wxconfigmap.get("timestamp") %>,
			    nonceStr: '<%=wxconfigmap.get("noncestr") %>',
			    signature: '<%=wxconfigmap.get("signature") %>',
			    jsApiList: [
				    'chooseWXPay','hideOptionMenu'
				    ]
		});
		wx.error(function(res){
				// config信息验证失败会执行error函数，如签名过期导致验证失败，
				//具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
				alert("请关闭重新进入应用:"+JSON.stringify(res));
		});
		wx.ready(function() {
			
		    //微信支付JS调用接口 appId, timeStamp, nonceStr, package, signType,paySign
		    wx.chooseWXPay({
			    timestamp: <%=wxpayparam.get("timeStamp") %>, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
			    nonceStr: '<%=wxpayparam.get("nonceStr") %>', // 支付签名随机串，不长于 32 位
			    package: '<%=wxpayparam.get("package") %>', // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
			    signType: '<%=wxpayparam.get("signType") %>', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
			    paySign: '<%=wxpayparam.get("paySign") %>', // 支付签名
			    trigger: function (res) {
		        	//alert('触发支付JS');
		      	},
			    success: function (res) {
// 			    	alert("支付成功！");
			    	<%
			    	if(wxPayType.equals("0")){//订单支付
			    	%>
			    		location.replace("<%=request.getContextPath()%>/order/payResult/<%=ORDER_ID%>");
			    	<%
			    	}
			    	else if(wxPayType.equals("1")){//充值
			    	%>
			    		location.replace("<%=request.getContextPath()%>/users/wallet");
			    	<%
			    	}else{
			    	%>
			    		history.back();
			    	<%
			    	}
			    	%>
			    },
			    cancel: function (res) {
			    	alert("放弃支付");
			    	history.back();
		      	},
			    fail: function (res) {
			    	alert("支付失败");
			    	history.back();
		     	}
			});
			
			//隐藏功能按钮
		    wx.hideOptionMenu();
	 	  });
	</script>
<%}else{
	out.print("<script>alert('无效请求');history.go(-1);</script>");
}%>
