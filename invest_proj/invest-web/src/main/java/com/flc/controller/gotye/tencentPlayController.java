package com.flc.controller.gotye;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.controller.gotye.tencentPlay.IlvbGetPalyUrl;
import com.flc.service.gotyeBackstage.gotyebackstage.GotyeBackstageManager;
import com.flc.service.school.schoolclassroom.SchoolClassRoomManager;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.util.MD5;
import com.flc.util.PageData;
import com.weixin.util.StringUtil;

@Controller
@RequestMapping("tencentPlay")
public class tencentPlayController extends BaseController {
	private int count=0;
	private int c=0;
	@Autowired//教室
	private SchoolClassRoomManager scrm; 
	//账号
	@Autowired
	private GotyeBackstageManager gbs;
	@Autowired
	private DictionariesManager dic;
	//根据频道编号输出频道信息
	@RequestMapping("/getPlayUrl/{CLASSROOM_ID}")
	public ModelAndView getPlayUrl(@PathVariable String CLASSROOM_ID){
		PageData pd=new PageData();
		pd=this.getPageData();
		count=this.count+1;
		c=this.count;
		if(c==1){
			HttpSession sesion=this.getRequest().getSession();
			sesion.setAttribute("count", c);
		}
		
		HttpServletRequest req=this.getRequest();
		pd.put("CLASSROOM_ID", CLASSROOM_ID);
		ModelAndView mv=new ModelAndView();
		mv.setViewName("myDaily/tencentPlay");
		if(CLASSROOM_ID.equals(0)){//如果等于0则是密码错误不能播放等等
			mv.addObject("status", 1);
			return mv;
		}
		String PlayUrl="";
		PageData roompd=null;
		try {
			roompd=scrm.findById(pd);
			PageData loginuser = (PageData) req.getSession().getAttribute("loginuser");
			if(loginuser!=null){
				PageData classPd=new PageData();
				classPd.put("TENCENTADMIN",roompd.getString("CHANNELID"));
			PageData back = gbs.findByTencent(classPd);
			String bizid=back.get("BIZID").toString();
			PlayUrl="http://"+bizid+".liveplay.myqcloud.com/live/"+bizid+"_"+roompd.getString("TENCETLIVEKEY")+".m3u8";
			mv.addObject("CLASSROOM_ID", CLASSROOM_ID);
			//http://18131.liveplay.myqcloud.com/live/18131_017ce6823.flv
			mv.addObject("CLASSROOM_NAME", roompd.get("CLASSROOM_NAME"));
			mv.addObject("GOODCOUNT",roompd.get("GOODCOUNT"));
			mv.addObject("PlayUrl", PlayUrl);//频道id
			mv.addObject("user", loginuser);//用户
			}
			return mv;
		} catch (Exception e) {
			PlayUrl="";
		}
		return mv;
	}
	/*@ResponseBody
	@RequestMapping("/getTencentUrl/{CLASSROOMID}")
	*//**
	 * 根据教室编号获取推流地址
	 * @param CLASSROOM_ID
	 * @return
	 *//*
	public String getTencentUrl(@PathVariable String CLASSROOMID){
		PageData pd=new PageData();
		pd=this.getPageData();
		pd.put("CLASSROOM_ID", CLASSROOMID);
			PageData roompd = null;
			try {
				roompd = scrm.findById(pd);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			TreeMap<String, Object> params=new TreeMap<String,Object>();
			params.put("channelId", roompd.get("CHANNELID"));//10905947996253813573
			JSONObject jo=editRoom("DescribeLVBChannel",params,new UrlCvm());//腾讯sdk获取频道信息
			JSONArray channelInfos=jo.getJSONArray("channelInfo");//从返回结果获取频道信息
			JSONObject channelInfo = (JSONObject) channelInfos.get(0);
			JSONObject upstream=(JSONObject) channelInfo.getJSONArray("upstream_list").get(0);
			String str=(String) upstream.get("sourceAddress");
		return str;
	}
	*//**
	 * @param channelName频道名称
	 * @param channelDescribe 频道描述
	 * @param outputSourceType 输出源选择（1表示只有RTMP输出，2表示只有HLS输出，3表示两者都有）
	 * @param outputRate输出码率。注：参数数组，0表示原始码率；10表示550码率(即标准)；20表示900码率(即高清)。如需设置码率，0是必填
	 * @param SecretId id
	 * @param SecretKey key
	 * @param Action 接口指令名称
	 * @param Region 区域参数sh(上海)
	 * @return
	 *//*//HttpSession sesion=this.getRequest().getSession();
	//String channelName,String channelDescribe,String outputSourceType,String outputRate
	public JSONObject editRoom(String apiName,TreeMap<String, Object> params,Base base){
	     如果是循环调用下面举例的接口，需要从此处开始你的循环语句。切记！ 
	    TreeMap<String, Object> config = new TreeMap<String, Object>();
	    try {
			config.put("SecretId", getBackstage().getString("SECRETID"));
			config.put("SecretKey", getBackstage().getString("SECRETKEY"));//你的secretKey
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}//你的secretId
	     请求方法类型 POST、GET 
	    config.put("RequestMethod", "GET");
	     区域参数，可选: gz:广州; sh:上海; hk:香港; ca:北美;等。 
	    config.put("DefaultRegion", "sh");
	    QcloudApiModuleCenter module = new QcloudApiModuleCenter(base,config);
	    String result = null;
	    try {
	        result = module.call(apiName, params);
	        JSONObject json_result = new JSONObject(result);
	        return json_result;
	    } catch (Exception e) {
	       // System.out.println("error..." + e.getMessage());
	    }
	    return null;
	}*/
	public PageData getBackstage() throws Exception{
		PageData pd=gbs.findByOne();
		return pd;
	}
}
