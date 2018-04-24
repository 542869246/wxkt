<!doctype html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.weixin.util.WxUtil"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
	Object wxPath = request.getAttribute("wxPath");
	//转发前的URL全路径
	String before_forward_url = null;
	if(null != wxPath && !"".equals(wxPath)){
		if(wxPath.toString().contains("index/toindex")){
			wxPath = basePath+"index/toindex";
		}
	}
	if(null!=wxPath){
		before_forward_url = wxPath.toString();
	}else{
		before_forward_url = request.getScheme()+"://"+request.getServerName()+request.getRequestURI();
	}
	Map<String,Object> wxcfgmap = WxUtil.getWxConfig(before_forward_url,basePath);
	
%>
<script type="text/javascript"
src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
ctx="<%=request.getContextPath() %>";

basePath = "<%=basePath%>";//全局变量。

wx.config({
    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
    appId: "<%=wxcfgmap.get("appId") %>",// 必填，公众号的唯一标识
    timestamp:<%=wxcfgmap.get("timestamp") %>,// 必填，生成签名的时间戳
    nonceStr: "<%=wxcfgmap.get("noncestr") %>", // 必填，生成签名的随机串
    signature: "<%=wxcfgmap.get("signature") %>",// 必填，签名，见附录1
    jsApiList: [ 'checkJsApi',
                 'hideOptionMenu',
                 'getLocation',
                 'onMenuShareTimeline',
 			     'onMenuShareAppMessage',
 			     'onMenuShareQQ',
 			     'onMenuShareWeibo',
 			     'scanQRCode',
 			     'showOptionMenu'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
}); 
wx.error(function(res){
	// config信息验证失败会执行error函数，如签名过期导致验证失败，
	//具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
	//alert("请关闭重新进入应用:"+JSON.stringify(res));
// 	console.log(JSON.stringify(res));
});

var share_title = "学鹿教育--微信课堂";
var share_desc = "用心服务，唯客户与爱不可辜负";
<%-- var share_url = "<%=basePath%>index"; --%>
var share_url = "<%=basePath%>index/toindex";
var share_ico = "<%=basePath%>/img/ico/default.jpg";

wx.ready(function() {
	wx.showOptionMenu();
	wx.onMenuShareAppMessage({//发送给朋友
		  title: share_title,
		  desc: share_desc,
		  link: share_url,
		  imgUrl: share_ico,
		  success: function (res) {// TODO
		  },
		  cancel: function (res) {// TODO
		  },
		  fail: function (res) {// TODO
		  }
		});

		wx.onMenuShareTimeline({//分享到朋友圈
		  title: share_title,
		  desc: share_desc,
		  link: share_url,
		  imgUrl: share_ico,
		  success: function (res) {// TODO
		  },
		  cancel: function (res) {// TODO
		  },
		  fail: function (res) {// TODO
		  }
		});

		wx.onMenuShareQQ({//分享到QQ
		  title: share_title,
		  desc: share_desc,
		  link: share_url,
		  imgUrl: share_ico,
		  trigger: function (res) {// TODO
		  },
		  complete: function (res) {// TODO
		  },
		  success: function (res) {// TODO
		  },
		  cancel: function (res) {// TODO
		  },
		  fail: function (res) {// TODO
		  }
		});

		wx.onMenuShareWeibo({//分享到微博
		  title: share_title,
		  desc: share_desc,
		  link: share_url,
		  imgUrl: share_ico,
		  trigger: function (res) {// TODO
		  },
		  complete: function (res) {// TODO
		  },
		  success: function (res) {// TODO
		  },
		  cancel: function (res) {// TODO
		  },
		  fail: function (res) {// TODO
		  }
		});
		
        wx.checkJsApi({  
            jsApiList : ['scanQRCode'],  
            success : function(res) {  
            }  
        });
        
        //扫描二维码  
        try {
        	document.querySelector('#scanQRCode').onclick = function() {  
                wx.scanQRCode({  
                    needResult : 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，  
                    scanType : [ "qrCode", "barCode" ], // 可以指定扫二维码还是一维码，默认二者都有  
                    success : function(res) {  
                        var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果 
                       	window.location=result;
                    }
                });  
            };
		} catch (e) {
		}
        
});

/**
 * 正则判断字符串是否为url
 */
function IsURL(str_url) {
	var strRegex = "^((https|http|ftp|rtsp|mms)?://)"
			+ "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@ 
			+ "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184 
			+ "|" // 允许IP和DOMAIN（域名）
			+ "([0-9a-z_!~*'()-]+\.)*" // 域名- www. 
			+ "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名 
			+ "[a-z]{2,6})" // first level domain- .com or .museum 
			+ "(:[0-9]{1,4})?" // 端口- :80 
			+ "((/?)|" // a slash isn't required if there is no file name 
			+ "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";
	var re = new RegExp(strRegex);
	//re.test()
	if (re.test(str_url)) {
		return (true);
	} else {
		return (false);
	}
}
</script>
