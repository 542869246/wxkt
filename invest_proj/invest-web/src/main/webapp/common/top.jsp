<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+path+"/";
	String urlPath = request.getRequestURL().toString();
	request.setAttribute("path", path);							// 如"/html5"
	request.setAttribute("basePath", basePath);					// 如"http://localhost:8080/html5/"
	request.setAttribute("urlPath", urlPath);					// 如"http://localhost:8080/html5/common/top.jsp"
	String visitPath = request.getServletPath().substring(0,request.getServletPath().lastIndexOf("/")+1);
%>
<script type="text/javascript" src="${path }/js/jquery-1.11.3.min.js" ></script>
<script type="text/javascript" src="${path }/js/njms.mycookie.js" ></script>
<%-- <script type="text/javascript" src="${path }/layer/layer.js" ></script> --%>
<%-- <link rel="stylesheet" href="${path }/css/ths.css?v1.2" /> --%>
<!-- <script type="text/javascript" src="layer/layer.js?v1.1" ></script> -->
<!-- 		<link rel="stylesheet" href="layer/need/layer.css" /> -->
<script type="text/javascript">
	/**判断是否存在学校,true->存在,false->不存在*/
	function isExistSchool(){
		var school = MyCookie.getCookie("_s_c_h_o_o_l_n_a_m_e");
		if(null==school||school==''){
			return false
		}
		return true;
	}
 	function to_access(param){
		var STATE = (undefined==param||""==param||null==param)?"":param;
		var jump = window.document.location.href;
		
		jump = "/"+jump.replace("${basePath}","");
// 		alert("jump:"+jump);
		jump = jump.replace(/\//g,"|").replace("?","$");
// 		alert("jump:"+jump);
		var _j_url = "${basePath}authentication/security/"+jump;
		//var _j_url = "${basePath}authentication/security";
		
		$.ajax({
			type: "POST",
			url: '<%=basePath%>gotye/getBackstage.do',
			dataType:'json',
			//beforeSend: validateData,
			cache: false,
			success: function(data){
				 var wx_appid = data.GOTYE_WX_APPID;
				 var src = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+wx_appid+"&redirect_uri="+urlencode(_j_url)+"&response_type=code&scope=snsapi_userinfo&state="+STATE+"#wechat_redirect";
				location.replace(src);
			}
		});
		
		
	}
	function urlencode (str) {  
	    str = (str + '').toString();   
	    return encodeURIComponent(str).replace(/!/g, '%21').replace(/'/g, '%27').replace(/\(/g, '%28').  
	    replace(/\)/g, '%29').replace(/\*/g, '%2A').replace(/%20/g, '+');  
	}
	$(function(){
		var m = MyCookie.getCookByJson();
// 		if("${empty sessionScope.loginuser}" == "true"){
// 			layer.open({type: 2,shadeClose:false});//弹出遮照
// 			to_access();
// 		}
		
		//触发即时通讯
		$(".ke").on("click",function(){
			$(".FENBOT-CHATBTN-ROUND").click();
			beginTimer();
			
			$(".FENBOT-BTN-HIDE").unbind();
			$(".FENBOT-BTN-HIDE").on("click", function() {
// 				console.log(1);
	            $(".FENBOT-PANEL").hide(),
	            $(".FENBOT-CHATBTN-ROUND").show(),
	            $("body").removeClass("FENBOT-FULL-BODY"),
	            $("HTML").removeClass("FENBOT-FULL-HTML")
	        }).css("z-index","10000000000");
			getOrderInfo();
		});
	});
	
	//触发即时通讯时会用定时器去判断入口按钮样式是否被改成显示 ，如果改成了显示 ，重新将其隐藏，然后将定时器关闭。
	function beginTimer(){
		var count = 0;
		var timer = setInterval(function(){
			if($(".FENBOT-CHATBTN-ROUND").css("display")!="none"){
				$(".FENBOT-CHATBTN-ROUND").hide();
				window.clearInterval(timer);
			}
		}, 50);
	}
	function getOrderInfo(){
		var member = MyCookie.getCookByJson();
		var userinfo={};
		var goodsinfo={};
		var orderinfo = {};
		if(member&&member!=null){
			userinfo.data={
	            "nickname":(null==member.OPEN_ID?"-":member.OPEN_ID),//会员昵称
	            "userid":(null==member.MEMBER_ID?"-":member.MEMBER_ID),//会员id
	            "phone":(null==member.MOBILE?"-":member.MOBILE),//会员手机号码
	            "register_time":(null==member.CREATE_TIME?"-":member.CREATE_TIME),//注册时间
	            "point":"-",//会员拥有积分总数
	            "consume":"-",//会员消费额度
	            "balance":(null==member.BALANCE?"0":member.BALANCE)//会员账户余额
	        };
		}
		
		if(${ps!=null}){
			goodsinfo.data={
                "imgurl":"${null==ps.PRODUCT_IMAGE?'':ps.PRODUCT_IMAGE }",//商品图片
                "link":"${null==wxPath?'':wxPath}",//商品链接地址
                "title":"${null==ps.PRODUCT_NAME?'':ps.PRODUCT_NAME}",//商品标题
                "price":"${null==ps.default_price?'':ps.default_price}"//商品价格
            };
		}
		var order_status = ["取消","待支付","待验光","加工中","已发货","租期中","已完成","申请退款"];
		if(${order!=null}){
			orderinfo.data={
					"number": "${order.ORDER_ID}", //订单编号
		            "express": "${order.PAY_TYPE=='0'?'全额付款':'押金租借'}", //订单快递单号
		            "datetime": "order.CREATE_TIME", //订单创建时间
		            "status": order_status[new Number("${order.ORDER_STATUS}")], //订单状态
		            "total_price": "${order.REAL_PRICE}", //订单总价
		            "goods": [ //请以数组方式传输商品
// 		                {
// 		                    "imgurl": "", //商品图片
// 		                    "link": "", //商品链接地址
// 		                    "title": "", //商品标题
// 		                    "price": "" //商品价格
// 		                }
		            ]
	            };
		}
		
		_FENBOT_API("apiInfo","11783",{"userinfo":userinfo,"goodsinfo":goodsinfo});
	}
</script>
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?a4c69b0cd1f3f367842d6d08cc1f4725";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>
<style type="text/css">
</style>