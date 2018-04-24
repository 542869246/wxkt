package com.flc.controller.news.newsinfo;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.entity.system.User;
import com.flc.service.news.newsinfo.NewsinfoManager;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.util.AppUtil;
import com.flc.util.Const;
import com.flc.util.Jurisdiction;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;

/** 
 * 说明：新闻信息
 * 创建人：FLC
 * 创建时间：2017-10-18
 */
@Controller
@RequestMapping(value="/newsinfo")
public class NewsinfoController extends BaseController {
	
	String menuUrl = "newsinfo/list.do"; //菜单地址(权限用)
	@Resource(name="newsinfoService")
	private NewsinfoManager newsinfoService;
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	
	

	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(HttpServletResponse response) throws Exception{
		HttpServletRequest request=this.getRequest();
		
		logBefore(logger, Jurisdiction.getUsername()+"新增Newsinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("NEWSINFO_ID", this.get32UUID());	//主键
		Date date = new Date();   
		Timestamp timestamp = new Timestamp(date.getTime());
		pd.put("NEWINFO_CREATETIME",timestamp);                  //时间
		
		User user=(User)request.getSession().getAttribute(Const.SESSION_USER);
		pd.put("NEWINFO_CREATEBY",user.getUSER_ID());           //创建人id
		newsinfoService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	
	
	/**
	 * 图片上传
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
				// int pre = (int) System.currentTimeMillis();//��ʼʱʱ��
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					String myFileName = file.getOriginalFilename();
					System.out.println(myFileName);
					if (myFileName.trim() != "") {
						String fileName = file.getOriginalFilename();
						String fileExt = fileName.substring(
								fileName.lastIndexOf(".") + 1).toLowerCase();
						SimpleDateFormat df = new SimpleDateFormat(
								"yyyyMMddHHmmss");
						String newFileName = df.format(new Date());
						String fileNames = newFileName
								+ new Random().nextInt(1000) + "." + fileExt;
						// String path = "d:/upload/" + fileNames;//�ϴ�·��
						String  path =
								 request.getSession().getServletContext()
								 .getRealPath("static"+File.separator+"login"+File.separator+"upload")
								 + File.separator + fileNames;
						 System.out.println("path:"+path);
						
						File localFile = new File(path);
						if (!localFile.exists()) {// ����ļ��в����ڣ��Զ�����
							localFile.mkdirs();
						}
						file.transferTo(localFile);
						//src=request.getContextPath()+"/upload/img/"+fileNames;
						src="/static/login/upload/"+fileNames;
						System.out.println("src:"+src);
					}
				}
			}
			
		}
		return src;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Newsinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		newsinfoService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		HttpServletRequest request=this.getRequest();
		logBefore(logger, Jurisdiction.getUsername()+"修改Newsinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		/*Date date = new Date();   
		Timestamp timestamp = new Timestamp(date.getTime());
		pd.put("NEWINFO_CREATETIME",timestamp);                  //时间
		*/
		User user=(User)request.getSession().getAttribute(Const.SESSION_USER);
		pd.put("NEWINFO_CREATEBY",user.getUSER_ID());           //创建人id
		newsinfoService.edit(pd);
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
		HttpServletRequest request = this.getRequest();
		
		logBefore(logger, Jurisdiction.getUsername()+"列表Newsinfo");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		/*String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}*/
		String lastLoginStart = pd.getString("lastLoginStart");	//开始时间
		String lastLoginEnd = pd.getString("lastLoginEnd");		//结束时间
		if(lastLoginStart != null && !"".equals(lastLoginStart)){
			pd.put("lastLoginStart", lastLoginStart+" 00:00:00");
		}
		if(lastLoginEnd != null && !"".equals(lastLoginEnd)){
			pd.put("lastLoginEnd", lastLoginEnd+" 23:59:00");
		}
		page.setPd(pd);
		List<PageData>	varList = newsinfoService.list(page);	//列出Newsinfo列表
		List<Dictionaries> dicList=dictionariesService.listSubDictByParentId("6c44ebb8ad0c4e9eac5f3c5e82ca622a");
		if(request.getSession().getServletContext().getAttribute("dicList")==null){
			request.getSession().getServletContext().setAttribute("dicList", dicList);
		}
		mv.setViewName("news/newsinfo/newsinfo_list");
		//mv.addObject("dicList",dicList);
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
		mv.setViewName("news/newsinfo/newsinfo_edit");
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
		pd = newsinfoService.findById(pd);	//根据ID读取
		mv.setViewName("news/newsinfo/newsinfo_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Newsinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			newsinfoService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Newsinfo到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("新闻编号");	//1
		titles.add("新闻标题");	//2
		titles.add("新闻内容");	//3
		titles.add("新闻子标题");	//4
		titles.add("缩略图");	//5
		titles.add("新闻类型编号");	//6
		titles.add("新闻状态");	//7
		titles.add("新闻创建人");	//8
		titles.add("新闻创建时间");	//9
		dataMap.put("titles", titles);
		List<PageData> varOList = newsinfoService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("NEWSINFO_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("NEWINFO_TITLE"));	    //2
			vpd.put("var3", varOList.get(i).getString("NEWINFO_CONTENT"));	    //3
			vpd.put("var4", varOList.get(i).getString("NEWINFO_SECONDTITLE"));	    //4
			vpd.put("var5", varOList.get(i).getString("THUMBNAIL"));	    //5
			vpd.put("var6", varOList.get(i).getString("NEWINFO_TYPE_ID"));	    //6
			vpd.put("var7", varOList.get(i).getString("NEWINFO_STATE"));	    //7
			vpd.put("var8", varOList.get(i).getString("NEWINFO_CREATEBY"));	    //8
			vpd.put("var9", varOList.get(i).get("NEWINFO_CREATETIME").toString());	    //9
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}

}
