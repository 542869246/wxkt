package com.flc.controller.school.classroom;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.service.backstage.backstage.BackstageManager;
import com.flc.service.school.classroom.ClassroomManager;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.util.AppUtil;
import com.flc.util.Jurisdiction;
import com.flc.util.MD5;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;
import com.flc.util.ilvb.IlvbGetPalyUrl;

/** 
 * 说明：学校教室
 * 创建人：FLC
 * 创建时间：2017-12-06
 */
@SuppressWarnings("deprecation")
@Controller
@RequestMapping(value="/classroom")
public class ClassroomController extends BaseController {
	
	String menuUrl = "classroom/list.do"; //菜单地址(权限用)
	@Resource(name="classroomService")
	private ClassroomManager classroomService;
	@Resource(name="backstageService")
	private BackstageManager backstageService;
	@Resource
	private DictionariesManager dictionariesService;
	
	@RequestMapping("/getTencentUrl/{TENCETLIVEKEY}")
	/**
	 * 根据教室编号获取推流地址
	 * @param CLASSROOM_ID
	 * @return
	 */
	public ModelAndView getTencentUrl(@PathVariable String TENCETLIVEKEY,HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("school/classroom/tuiliu");
		String qd="";
		/*	String url=request.getScheme()+"://" + request.getServerName()+ ":" +request.getServerPort()+ request.getContextPath();
		url=url.replace("invest", "invest-web/tencentPlay/getTlUrl/");
		String time=new SimpleDateFormat("yyyyMMddHH").format(new Date());
		url+=TENCETLIVEKEY+"?cmd=geturl&sid="+TENCETLIVEKEY+"&stream=main&authkey="+MD5.md5(MD5.md5(MD5.md5(TENCETLIVEKEY+time)));
		qd=url;*/
/*		try {
			PageData pd=this.getPageData();
				String cmd=pd.getString("cmd");
			String sid=pd.getString("sid");
			String stream=pd.getString("stream");
			String authkey=pd.getString("authkey");
			if(cmd==null || "".equals(cmd.trim())){
				mv.addObject("address", qd);
				return mv;
			}
			if(cmd.equals("gettime")){
				Date dt=new Date();
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				qd=sdf.format(dt);
				mv.addObject("address", qd);
				return mv;
			}
			if(stream==null || "".equals(stream.trim()) || authkey==null || "".equals(authkey.trim()) ||sid==null || "".equals(sid.trim())){
				mv.addObject("address", qd);
				return mv;
			}
			String sidAuthkey=MD5.md5(MD5.md5(MD5.md5(sid)));
			//if(cmd.equals("geturl")&&authkey.equals(sidAuthkey) && stream.equals("main")){
			if(cmd.equals("geturl")&& stream.equals("main")){
				
			}else{
				qd="";
			}
		} catch (Exception e) {
			qd="";
		}*/
		PageData pd=this.getPageData();
		PageData back;
		try {
			PageData classroom = classroomService.findById(pd);
			back = this.getCLassRoomBackstage(classroom.getString("CHANNELID"));
		String key=back.getString("TXSECRET");
		Long txTime=3755124610L;//设置时间2088年
		String bizid=back.get("BIZID").toString();
		String streamId=bizid+"_"+TENCETLIVEKEY;
		String backStr=IlvbGetPalyUrl.getSafeUrl(key, streamId, txTime);
		qd="rtmp://"+bizid+".livepush.myqcloud.com/live/"+streamId+"?bizid="+bizid+"&";
		//qd="ok:rtmp://"+bizid+".livepush.myqcloud.com/live/"+streamId+"?bizid="+bizid+"&";
		qd+=backStr;
		//qd+="<br/>playurl:http://test.qidun.cn/show/1231231231";
		} catch (Exception e) {
		}
			mv.addObject("address", qd);
			return mv;
	}
/*	*//**
	 * 根据教室id获取腾讯推流地址
	 * @param CLASSROOMID
	 * @return
	 *//*
	@RequestMapping("/getTlUrl/{CLASSROOMID}")
	@ResponseBody
	public String getTlUrl(@PathVariable String CLASSROOMID){
		String qd="";
		try {
			PageData back = this.getBackstage();
			String key=back.getString("TXSECRET");
			Long txTime=3755124610L;//设置时间2088年
			String bizid=back.get("BIZID").toString();
			String streamId=bizid+"_"+CLASSROOMID;
			String backStr=IlvbGetPalyUrl.getSafeUrl(key, streamId, txTime);
			qd="rtmp://"+bizid+".livepush.myqcloud.com/live/"+streamId+"?bizid="+bizid+"&";
			qd+=backStr;
		} catch (Exception e) {
			qd="";
		}
		return qd;
	}*/
	
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Classroom");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ISNOTSTATUS", 0);
		pd.put("CLASSROOM_ID", this.get32UUID());	//主键
		classroomService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	/**
	 * 查询默认帐号
	 * @return
	 * @throws Exception
	 */
	public PageData getBackstage() throws Exception{
		PageData p=new PageData();
		PageData pd=backstageService.findById(p);
		return pd;
	}
	
	/**
	 * 查询教室帐号
	 * @return
	 * @throws Exception
	 */
	public PageData getCLassRoomBackstage(String tencentadmin) throws Exception{
		PageData p=new PageData();
		p.put("TENCENTADMIN", tencentadmin);
		PageData pd=backstageService.findByTencent(p);
		
		return pd;
	}
	
	/**
	 * @param channelName频道名称
	 * @param channelDescribe 频道描述
	 * @param outputSourceType 输出源选择（1表示只有RTMP输出，2表示只有HLS输出，3表示两者都有）
	 * @param outputRate输出码率。注：参数数组，0表示原始码率；10表示550码率(即标准)；20表示900码率(即高清)。如需设置码率，0是必填
	 * @param SecretId id
	 * @param SecretKey key
	 * @param Action 接口指令名称
	 * @param Region 区域参数sh(上海)
	 * @return
	 *//*
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
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Classroom");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		pd=classroomService.findById(pd);
		classroomService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Classroom");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		classroomService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Classroom");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = classroomService.list(page);	//列出Classroom列表
		PageData defaultpd = this.getBackstage();
		for (PageData pageData : varList) {
			String channelid=pageData.getString("CHANNELID");
			if(channelid!=null && !"".equals(channelid)){
				if(defaultpd != null && !"".equals(defaultpd)){
					pageData.put("CHANNELID", defaultpd.getString("TENCENTADMIN"));
				}
				classroomService.edit(pageData);
			}
				
		}
		//显示账号类型
		PageData txpd=new PageData();
		txpd.put("BIANMA", "txzh");
		PageData dicpd=dictionariesService.findByBianma(txpd);
		List<Dictionaries> diclist = null;                                                                                                                                                                                                                 
		if(dicpd != null && !"".equals(dicpd)){
			diclist=dictionariesService.listSubDictByParentId(dicpd.getString("DICTIONARIES_ID"));
		}
		mv.addObject("diclist", diclist);
		//显示账号类型 end
		mv.setViewName("school/classroom/classroom_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//显示账号类型
		PageData txpd=new PageData();
		txpd.put("BIANMA", "txzh");
		PageData dicpd=dictionariesService.findByBianma(txpd);
		List<Dictionaries> diclist=dictionariesService.listSubDictByParentId(dicpd.getString("DICTIONARIES_ID"));
		mv.addObject("diclist", diclist);
		//显示账号类型 end
		mv.setViewName("school/classroom/classroom_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = classroomService.findById(pd);	//根据ID读取
		//显示账号类型
		PageData txpd=new PageData();
		txpd.put("BIANMA", "txzh");
		PageData dicpd=dictionariesService.findByBianma(txpd);
		List<Dictionaries> diclist=dictionariesService.listSubDictByParentId(dicpd.getString("DICTIONARIES_ID"));
		mv.addObject("diclist", diclist);
		//显示账号类型 end
		PageData back = this.getBackstage();
		String key=back.getString("TXSECRET");
		String bizid=back.get("BIZID").toString();
		pd.put("key", key);
		pd.put("bizid", bizid);
		mv.setViewName("school/classroom/classroom_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Classroom");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			classroomService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Classroom到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("主键");	//1
		titles.add("直播房间号");	//2
		titles.add("教室名称");	//3
		titles.add("教室图片");	//4
		titles.add("教室位置");	//5
		titles.add("直播密码");	//6
		titles.add("备注7");	//7
		titles.add("备注8");	//8
		titles.add("备注9");	//9
		titles.add("备注10");	//10
		dataMap.put("titles", titles);
		List<PageData> varOList = classroomService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("CLASSROOM_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("CLASSROOM_ROOMID"));	    //2
			vpd.put("var3", varOList.get(i).getString("CLASSROOM_NAME"));	    //3
			vpd.put("var4", varOList.get(i).getString("IMG_ID"));	    //4
			vpd.put("var5", varOList.get(i).getString("CLASSROOM_LOC"));	    //5
			vpd.put("var6", varOList.get(i).getString("BACKSTAGE_PASSWORD"));	    //6
			vpd.put("var7", varOList.get(i).getString("CREATEBY"));	    //7
			vpd.put("var8", varOList.get(i).getString("CREATEDATE"));	    //8
			vpd.put("var9", varOList.get(i).getString("MODIFYBY"));	    //9
			vpd.put("var10", varOList.get(i).getString("MODIFYDATE"));	    //10
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	
	/**
	 *图片上传
	 * @param request
	 * @param response
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("/upload")
	@ResponseBody
	public String addFile(HttpServletRequest request,HttpServletResponse response)
			throws IllegalStateException, IOException {
		String src="";
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		if (multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			Iterator<String> iter = multiRequest.getFileNames();
			while (iter.hasNext()) {
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					String myFileName = file.getOriginalFilename();
					//System.out.println(myFileName);
					if (myFileName.trim() != "") {
						String fileName = file.getOriginalFilename();
						String fileExt = fileName.substring(
								fileName.lastIndexOf(".") + 1).toLowerCase();
						SimpleDateFormat df = new SimpleDateFormat(
								"yyyyMMddHHmmss");
						String newFileName = df.format(new Date());
						String fileNames = newFileName
								+ new Random().nextInt(1000) + "." + fileExt;
						String  path =
								 request.getSession().getServletContext()
								 .getRealPath("static"+File.separator+"login"+File.separator+"upload")
								 + File.separator + fileNames;
						File localFile = new File(path);
						if (!localFile.exists()) {
							localFile.mkdirs();
						}
						file.transferTo(localFile);
						src="/static/login/upload/"+fileNames;
					}
				}
			}
			
		}
		return src;
	}
	
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
