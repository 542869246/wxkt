package com.flc.controller.system.products.details;

import java.io.File;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.entity.system.User;
import com.flc.service.system.products.details.DetailsManager;
import com.flc.util.AppUtil;
import com.flc.util.Const;
import com.flc.util.Jurisdiction;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;

/** 
 * 说明：产品相关信息
 * 创建人：FLC
 * 创建时间：2017-10-27
 */
@Controller
@RequestMapping(value="/details")
public class DetailsController extends BaseController {
	
	String menuUrl = "details/list.do"; //菜单地址(权限用)
	@Resource(name="detailsService")
	private DetailsManager detailsService;
	
	
	@RequestMapping("savepdf")
	@ResponseBody
	public String savepdf(@RequestParam MultipartFile pdffile) throws Exception{
		String path=this.getRequest().getSession().getServletContext().getRealPath("/static/login/pdf");
		String pdfname=pdffile.getOriginalFilename();
		pdfname=this.get32UUID()+pdfname.substring(pdfname.lastIndexOf("."));
		File mkdir = new File(path);
		if(!mkdir.exists()){
			mkdir.mkdirs();
		}
		File newfile=new File(path+File.separator+pdfname);
		pdffile.transferTo(newfile);
		
		
		return "/static/login/pdf/"+pdfname;
	}
	
	
	
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(/*@RequestParam(value="DETAILS_URL") MultipartFile pdffile,String DETAILS_INFO_ID,String DETAILS_TITLE*/) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Details");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		/*String path=this.getRequest().getSession().getServletContext().getRealPath("/static/login/pdf");
		String pdfname=pdffile.getOriginalFilename();
		pdfname=this.get32UUID()+pdfname.substring(pdfname.lastIndexOf("."));
		File mkdir = new File(path);
		if(!mkdir.exists()){
			mkdir.mkdirs();
		}
		File newfile=new File(path+"\\"+pdfname);*/
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("DETAILS_ID", this.get32UUID());	//主键
		User user=(User)this.getRequest().getSession().getAttribute(Const.SESSION_USER);
		pd.put("DETAILS_CREATEBY",user.getUSER_ID());           //创建人id
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		pd.put("DETAILS_CREATETIME", sf.format(date));
		/*pd.put("DETAILS_URL", "");
		pd.put("DETAILS_CREATETIME",new Date());
		pd.put("DETAILS_INFO_ID",DETAILS_INFO_ID);
		pd.put("DETAILS_TITLE",DETAILS_TITLE);*/
		/*pdffile.transferTo(newfile);*/
		detailsService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Details");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		detailsService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit(/*@RequestParam(value="DETAILS_URL") MultipartFile pdffile,*/) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Details");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		/*
		String path=this.getRequest().getSession().getServletContext().getRealPath("/static/login/pdf");
		String pdfname=pdffile.getOriginalFilename();
		pdfname=this.get32UUID()+pdfname.substring(pdfname.lastIndexOf("."));
		File mkdir = new File(path);
		if(!mkdir.exists()){
			mkdir.mkdirs();
		}
		File newfile=new File(path+"\\"+pdfname);*/
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//pd.put("DETAILS_ID", DETAILS_ID);	//主键
		/*pd.put("DETAILS_URL", "/static/login/pdf/"+pdfname);*/
		//pd.put("DETAILS_TITLE",DETAILS_TITLE);
	/*	pdffile.transferTo(newfile);*/
		detailsService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	@RequestMapping(value="/goPdf")
	public ModelAndView goPdf(String pdfUrl)throws Exception{
		ModelAndView mv=this.getModelAndView();
		mv.addObject("messUrl", pdfUrl);
		mv.setViewName("dep/messageinfo/messPdf");
		return mv;
	}
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Details");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		/*pd.put("DETAILS_INFO_ID","4e460681b61d11e78ab100163e1a9d37");*/
		
		String DETAILS_INFO_ID = pd.getString("DETAILS_INFO_ID");				//关键词检索条件
		if(null != DETAILS_INFO_ID && !"".equals(DETAILS_INFO_ID)){
			pd.put("DETAILS_INFO_ID", DETAILS_INFO_ID.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = detailsService.list(page);	//列出Details列表
		mv.setViewName("system/details/details_list");
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
		mv.setViewName("system/details/details_edit");
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
		pd = detailsService.findById(pd);	//根据ID读取
		mv.setViewName("system/details/details_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Details");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			detailsService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Details到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("编号");	//1
		titles.add("产品编号");	//2
		titles.add("pdf路径");	//3
		titles.add("标题");	//4
		titles.add("创建时间");	//5
		titles.add("操作人");	//6
		dataMap.put("titles", titles);
		List<PageData> varOList = detailsService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("DETAILS_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("DETAILS_INFO_ID"));	    //2
			vpd.put("var3", varOList.get(i).getString("DETAILS_URL"));	    //3
			vpd.put("var4", varOList.get(i).getString("DETAILS_TITLE"));	    //4
			vpd.put("var5", varOList.get(i).getString("DETAILS_CREATETIME"));	    //5
			vpd.put("var6", varOList.get(i).getString("DETAILS_CREATEBY"));	    //6
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
