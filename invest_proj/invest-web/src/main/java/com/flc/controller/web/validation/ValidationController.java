package com.flc.controller.web.validation;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.service.web.validation.ValidationManager;
import com.flc.util.PageData;
import com.flc.util.sms.request.SmsSendRequest;
import com.flc.util.sms.response.SmsSendResponse;
import com.flc.util.sms.util.ChuangLanSmsUtil;



/** 
 * 说明：用户短信验证码
 * 创建人：FLC
 * 创建时间：2017-10-24
 */
@Controller
@RequestMapping(value="/validation")
public class ValidationController extends BaseController {
	
	@Resource(name="validationService")
	private ValidationManager validationService;
	
	// 用户平台API账号
	@Value("${account}")
	private String account;
	// 用户平台API密码
	@Value("${pswd}")
	private String pswd;
	//请求地址
	@Value("${smsSingleRequestServerUrl}")
	private String smsSingleRequestServerUrl;
	/**保存
	 * @param
	 * @throws Exception
	 */
	
	@RequestMapping(value="/save")
	@ResponseBody
	public PageData save(HttpSession session) throws Exception{
		logBefore(logger,"新增Validation");
		PageData pd = this.getPageData();
		//手机号码
		String phone = this.getPageData().getString("VALIDATION_PHONE");
		PageData data = validationService.findByPhone(pd);
		PageData result=new PageData();
		if(data!=null){
			Date oldtime =(Date)data.get("VALIDATION_TIME");
			long min = getDatePoor(new Date(),oldtime);
			if(min<10){
				result.put("msg", "最小发送间隔为10分钟,请勿重复发送");
				return result;
			}
		}
		Random r=new Random();
		String str="";
		for (int i=0;i<4 ;i++) {
			str+=r.nextInt(10);
		}
		// 短信内容
	    String msg = "您的验证码为"+str;
		//状态报告
		String report= "true";
		SmsSendRequest smsSingleRequest = new SmsSendRequest(account, pswd, msg, phone,report);
		String requestJson = JSON.toJSONString(smsSingleRequest);
		String response = ChuangLanSmsUtil.sendSmsByPost(smsSingleRequestServerUrl, requestJson);
		SmsSendResponse smsSingleResponse = JSON.parseObject(response, SmsSendResponse.class);
		if(smsSingleResponse.getCode().equals("0")){
		//	System.out.println("response  toString is :" + smsSingleResponse);
			session.setAttribute("phone", str);
			pd.put("VALIDATION_ID", this.get32UUID());	//主键
			pd.put("VALIDATION_PHONE", phone);
			pd.put("VALIDATION_CODE", str);
			pd.put("VALIDATION_TIME",new Date());
			validationService.save(pd);
		}
		result.put("msg", "ok");
		return result;
	}
	
	//返回相差分钟
	public  long getDatePoor(Date endDate, Date nowDate) {
	    long diff = endDate.getTime() - nowDate.getTime();
	    long min = diff /60000;
	    return min;
	}
	
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger,"列表Validation");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = validationService.list(page);	//列出Validation列表
		mv.setViewName("web/validation/validation_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		return mv;
	}
	
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
