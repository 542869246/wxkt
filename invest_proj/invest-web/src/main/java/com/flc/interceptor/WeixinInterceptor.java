package com.flc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.support.logging.Log;
import com.alibaba.druid.support.logging.LogFactory;

public class WeixinInterceptor implements HandlerInterceptor {
	protected Log logger = LogFactory.getLog(getClass());
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object arg2, ModelAndView arg3)
			throws Exception {
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse arg1, Object arg2) throws Exception {
		String url = request.getScheme()+"://"; //请求协议 http 或 https    
		url+=request.getHeader("host");  // 请求服务器    
		url+=request.getRequestURI();     // 工程名      
		if(request.getQueryString()!=null) //判断请求参数是否为空  
		url+="?"+request.getQueryString();   // 参数   
//		wxPath = URLEncoder.encode(wxPath,"UTF-8");//URL转码
		/*System.out.println("当前访问的地址为："+url);
		logger.info("当前访问的地址为："+url);*/
		request.setAttribute("wxPath", url);
		return true;
	}

}
