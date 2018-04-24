package com.flc.controller.web.details;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.service.web.details.DetailsManager;
import com.flc.util.AppUtil;
import com.flc.util.DowenLoadUtil;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;

/** 
 * 说明：PDF模块
 * 创建人：FLC
 * 创建时间：2017-10-23
 */
@Controller
@RequestMapping(value="/details")
public class DetailsController extends BaseController {

	//String menuUrl = "details/list.do"; //菜单地址(权限用)
	@Resource(name="detailsService")
	private DetailsManager detailsService;

	@Value("${uploadfPath}")
	private String uploadfPath;
	
	@Value("${managerProjPath}")
	private String managerProjPath;
	
	

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, "列表Details");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = detailsService.list(page);	//列出Details列表
		mv.setViewName("web/details/details_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		//mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
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
		mv.setViewName("web/details/details_edit");
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
		mv.setViewName("web/details/details_edit");
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
		logBefore(logger, "批量删除Details");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
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
		logBefore(logger,"导出Details到excel");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("详细信息ID");	//1
		titles.add("产品ID");	//2
		titles.add("下载地址");	//3
		titles.add("信息标题");	//4
		titles.add("创建时间");	//5
		titles.add("创建人");	//6
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

	/**
	 * ajax调用查询pdf文件
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/listpdf")
	@ResponseBody
	public PageData listPdf(Page page) throws Exception{
		logBefore(logger, "PDF分页查查询全部的信息");
		PageData pd = new PageData();
		// 当前每页行数
		page.setShowCount(3);
		pd = this.getPageData();
		// 把当前的参数放入到实体类中去
		page.setPd(pd);
		// 返回当前的集合
		List<PageData> list = detailsService.list(page);
		PageData result = new PageData();

		result.put("list", list);
		result.put("page", page);
		return result;
	}

	/**
	 * 打开pdf
	 * @param id
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/getPdfFile")
	public String openPdfFileAndprocess(HttpServletResponse response,HttpServletRequest request,HttpSession session) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			response.setContentType("multipart/form-data");  
			response.setContentType("application/pdf");
			response.setCharacterEncoding("UTF-8");  
			response.setHeader("Content-Disposition", "inline; filename="+this.get32UUID()+".pdf");
			PageData pdf = detailsService.findById(pd);
			String pathname =pdf.getString("DETAILS_URL");
			String newPath=uploadfPath;
			newPath=newPath+pathname;
			System.out.println(newPath);
			ServletOutputStream out= response.getOutputStream();  
			DowenLoadUtil.dowenLoad(newPath, out);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}  
		return null;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
