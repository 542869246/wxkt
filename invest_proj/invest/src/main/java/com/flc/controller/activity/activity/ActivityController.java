package com.flc.controller.activity.activity;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;
import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.util.AppUtil;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;
import com.flc.util.Jurisdiction;
import com.flc.util.Tools;
import com.flc.service.activity.activity.ActivityManager;
import com.flc.service.system.dictionaries.DictionariesManager;

/** 
 * 说明：最新活动模块（趣味英语、一周体验、活动集锦、活动预告公用）
 * 创建人：FLC
 * 创建时间：2017-11-30
 */
@Controller
@RequestMapping(value="/activity")
public class ActivityController extends BaseController {
	
	String menuUrl = "activity/list.do"; //菜单地址(权限用)
	@Resource(name="activityService")
	private ActivityManager activityService;
	
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Activity");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("CREATEDATE", new Date());
		pd.put("ACTIVITY_ID", this.get32UUID());	//主键
		activityService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Activity");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		activityService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Activity");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MODIFYBY",Jurisdiction.getUsername());
		pd.put("MODIFYDATE", new Date());
		activityService.edit(pd);
		mv.addObject("msg","success");
		//mv.addObject("id",pd.get("id"));
		mv.setViewName("save_result");
		
		
		
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page,String ACTIVITY_TYPE_ID,String ACTIVITY_TITLE) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Activity");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)

		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = activityService.list(page);	//列出Activity列表
		List<Dictionaries> activityList=dictionariesService.listSubDictByParentId("6d47a7f0ce3a4f0b889362b9e7e0776d");//列出课程状态列表
		mv.setViewName("activity/activity/activity_list");
		mv.addObject("varList", varList);
		mv.addObject("activityList", activityList);
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
		List<Dictionaries> activityList=dictionariesService.listSubDictByParentId("6d47a7f0ce3a4f0b889362b9e7e0776d");//列出课程状态列表
		mv.setViewName("activity/activity/activity_edit");
		mv.addObject("msg", "save");
		mv.addObject("activityList", activityList);
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
		pd = activityService.findById(pd);	//根据ID读取
		List<Dictionaries> activityList=dictionariesService.listSubDictByParentId("6d47a7f0ce3a4f0b889362b9e7e0776d");//列出课程状态列表
		mv.setViewName("activity/activity/activity_edit");
		mv.addObject("msg", "edit");
		mv.addObject("activityList", activityList);
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Activity");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			activityService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Activity到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("活动资讯ID");	//1
		titles.add("活动标题");	//2
		titles.add("活动简介");	//3
		titles.add("活动内容");	//4
		titles.add("活动开始时间");	//5
		titles.add("活动的标题图片");	//6
		titles.add("活动类型");	//7
		titles.add("回复者");	//8
		titles.add("回复内容");	//9
		titles.add("评论者");	//10
		titles.add("评论内容");	//11
		titles.add("修改人");	//12
		titles.add("修改时间");	//13
		titles.add("创建人");	//14
		titles.add("创建时间");	//15
		dataMap.put("titles", titles);
		List<PageData> varOList = activityService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("ACTIVITY_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("ACTIVITY_TITLE"));	    //2
			vpd.put("var3", varOList.get(i).getString("ACTIVITY_INFO"));	    //3
			vpd.put("var4", varOList.get(i).getString("ACTIVITY_CONTENT"));	    //4
			vpd.put("var5", varOList.get(i).getString("ACTIVITY_TIME"));	    //5
			vpd.put("var6", varOList.get(i).getString("ACTIVITY_IMGSRC"));	    //6
			vpd.put("var7", varOList.get(i).getString("ACTIVITY_TYPE_ID"));	    //7
			vpd.put("var8", varOList.get(i).getString("ACTIVITY_REPLY"));	    //8
			vpd.put("var9", varOList.get(i).getString("ACTIVITY_REPLY_CONTENT"));	    //9
			vpd.put("var10", varOList.get(i).getString("ACTIVITY_COMMENT"));	    //10
			vpd.put("var11", varOList.get(i).getString("ACTIVITY_COMMENT_CONTENT"));	    //11
			vpd.put("var12", varOList.get(i).getString("MODIFYBY"));	    //12
			vpd.put("var13", varOList.get(i).getString("MODIFYDATE"));	    //13
			vpd.put("var14", varOList.get(i).getString("CREATEBY"));	    //14
			vpd.put("var15", varOList.get(i).getString("CREATEDATE"));	    //15
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
