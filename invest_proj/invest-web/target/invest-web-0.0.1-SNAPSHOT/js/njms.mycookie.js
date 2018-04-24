/**
 * 记住密码
 */
var MyCookie;
try{
	MyCookie = {
		/**
		 * 以key获取cookie内容
		 */
		DEFAULT_KEY:'_n_j_m_s_c_o_o_k_i_e',
		getCookie:function(key){
			var arr,reg=new RegExp("(^| )"+(key?key:this.DEFAULT_KEY)+"=([^;]*)(;|$)");
			if(arr=document.cookie.match(reg)){
				return unescape(arr[2]);
			}
			else{
				return null;
			}
		},
		/**
		 * 以key,value设置到cookie
		 * life_time -> 生命周期(单位小时)
		 */
		setCookie:function(key,value,life_time){
			
			/**
			 * 设置cookie过期时间,如果未传值则默认为15天
			 */
			var time = (life_time&&!isNaN(life_time)&&life_time>0)?(life_time*60*60*1000):(15*24*60*60*1000);
			var exp = new Date();
			exp.setTime(exp.getTime() + time*1);
			document.cookie = key + "="+ escape (value) + ";path=/;expires=" + exp.toGMTString();
			
		},
		/**
		 * 根据key删除cookie
		 */
		delCookie:function(key){
			var exp = new Date();
			exp.setTime(exp.getTime() - 1);
			var cval=this.getCookie(key);
			if(cval!=null){
				document.cookie= key + "="+cval+";path=/;expires="+exp.toGMTString();
			}
		},
		/**
		 * 根据key获取cookie内容，并转换为json对象
		 */
		getCookByJson:function(key){
			try {
				var obj = eval('(' + MyCookie.getCookie(key) + ')');
				if(typeof obj=="string"){
					obj = eval("("+obj+")");
				}
				return obj;
			} catch (e) {
				return null;
			}
		}
	};
}catch (e) {
	// TODO: handle exception
}