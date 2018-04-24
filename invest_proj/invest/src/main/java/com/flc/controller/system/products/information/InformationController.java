package com.flc.controller.system.products.information;

import java.io.File;
import java.io.IOException;
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

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.flc.util.AppUtil;
import com.flc.util.Const;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;
import com.flc.util.Jurisdiction;
import com.flc.util.Tools;

import net.sf.json.JSONArray;

import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.system.products.information.InformationManager;
import com.flc.service.web.userinfo.UserinfoManager;

/** 
 * 说明：产品存蓄信息
 * 创建人：FLC
 * 创建时间：2017-10-26
 */
@Controller
@RequestMapping(value="/information")
public class InformationController extends BaseController {
	
	String menuUrl = "information/list.do"; //菜单地址(权限用)
	@Resource(name="informationService")
	private InformationManager informationService;
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(/*@RequestParam("uploadFile")MultipartFile uploadFile,HttpServletRequest request*/) throws Exception{
		
		//System.out.println(request.getParameterMap());
		logBefore(logger, Jurisdiction.getUsername()+"新增Information");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		/*pd.put("INFORMATION_INFO_ID", request.getParameter("INFORMATION_INFO_ID"));
		pd.put("INFORMATION_CONTENT", request.getParameter("INFORMATION_CONTENT"));
		pd.put("INFORMATION_MESSAGETIME", request.getParameter("INFORMATION_MESSAGETIME"));*/
		User user=(User)this.getRequest().getSession().getAttribute(Const.SESSION_USER);
		pd.put("INFORMATION_CREATEBY",user.getUSER_ID()); 
		pd.put("INFORMATION_ID", this.get32UUID());	//主键
		Date dates1 = new Date();//时间戳
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdf1.format(dates1);
		pd.put("INFORMATION_CREATETIME",date);//创建时间
		
		//上传
		/*String idPicPath =null;
		
		if(!uploadFile.isEmpty()){
			String uploadPath=request.getSession().getServletContext().getRealPath("static"+File.separator+"login"+File.separator+"upload");
			//String uploadPath=request.getSession().getServletContext().getRealPath("/");
			//System.out.println(uploadPath);
			String oldName=uploadFile.getOriginalFilename();
			String prefix=FilenameUtils.getExtension(oldName);
				Date dates = new Date();//时间戳
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String strDate = sdf.format(dates);
				String name = strDate+"_pdf."+prefix;
				File newFile = new File(uploadPath,name);
				if(!newFile.exists()){
					//创建文件夹
					newFile.mkdirs();
				}
				try {
					uploadFile.transferTo(newFile);
					idPicPath="/static/login/upload/"+name;
//					System.out.println("----"+request.getContextPath());
//					System.out.println("/static/product/pdf/"+name);
					pd.put("INFORMATION_PDFURL", idPicPath);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			 
			}	*/
		
		informationService.save(pd);
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
	
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Information");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		informationService.delete(pd);
		out.write("success");
		out.close();
	}
	
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
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit(/*@RequestParam("uploadFile")MultipartFile uploadFile,HttpServletRequest request*/) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Information");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		/*pd.put("INFORMATION_CONTENT",request.getParameter("INFORMATION_CONTENT"));
		pd.put("INFORMATION_ID",request.getParameter("INFORMATION_ID"));
		pd.put("INFORMATION_MESSAGETIME", request.getParameter("INFORMATION_MESSAGETIME"));
		//上传
				String idPicPath =null;
				
				if(!uploadFile.isEmpty()){
					String uploadPath=request.getSession().getServletContext().getRealPath("static"+File.separator+"login"+File.separator+"upload");
					//String uploadPath=request.getSession().getServletContext().getRealPath("/");
					//System.out.println(uploadPath);
					String oldName=uploadFile.getOriginalFilename();
					String prefix=FilenameUtils.getExtension(oldName);
						Date dates = new Date();//时间戳
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
						String strDate = sdf.format(dates);
						String name = strDate+"_pdf."+prefix;
						File newFile = new File(uploadPath,name);
						if(!newFile.exists()){
							//创建文件夹
							newFile.mkdirs();
						}
						try {
							uploadFile.transferTo(newFile);
							idPicPath="/static/login/upload/"+name;
//							System.out.println("----"+request.getContextPath());
//							System.out.println("/static/product/pdf/"+name);
							pd.put("INFORMATION_PDFURL", idPicPath);
						} catch (IllegalStateException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}
					 
					}	*/
		informationService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Model model,Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Information");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String proid = pd.getString("PRODUCTSINFO_ID");
		if(null != proid && !"".equals(proid)){
			pd.put("proid", proid.trim());
		}
		String ATTR_TYPEID = pd.getString("ATTR_TYPEID");
		if(null != ATTR_TYPEID && !"".equals(ATTR_TYPEID)){
			pd.put("ATTR_TYPEID", ATTR_TYPEID.trim());
		}
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String lastStart = pd.getString("lastStart");	//开始时间
		String lastEnd = pd.getString("lastEnd");		//结束时间
		if(lastStart != null && !"".equals(lastStart)){
			pd.put("lastStart", lastStart+" 00:00:00");
		}
		if(lastEnd != null && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd+" 23:59:59");
		}
		System.out.println();
		page.setPd(pd);
		JzZtree(model);//调用ztree
		List<PageData>	varList = informationService.list(page);	//列出Information列表
		if (null==pd.getString("flag")) {
			mv.setViewName("system/information/information_list");
		}else{
			mv.setViewName("system/information/information_groupList");
		}
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	public void JzZtree(Model model){
		try{
			//获取下拉列表
			JSONArray arr = JSONArray.fromObject(informationService.listAllDict("690745a213774651a563f127c6c1ebd9"));
			String json = arr.toString();
			model.addAttribute("zTreeNodes", json);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}
	
	
	
	/**
	 * 显示列表ztree
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/listAllDict")
	public ModelAndView listAllDict(Model model,String DICTIONARIES_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			JSONArray arr = JSONArray.fromObject(informationService.listAllDict1("690745a213774651a563f127c6c1ebd9"));
			String json = arr.toString();
			json = json.replaceAll("DICTIONARIES_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("NAME", "name").replaceAll("subDict", "nodes").replaceAll("hasDict", "checked").replaceAll("treeurl", "url");
			//System.out.println(json);
			model.addAttribute("zTreeNodes", json);
			mv.addObject("DICTIONARIES_ID",DICTIONARIES_ID);
			mv.addObject("pd", pd);	
			mv.setViewName("system/information/information_ztree");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/listMess")
	public ModelAndView listMess(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Information");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		String lastLoginStart = pd.getString("lastLoginStart");	//开始时间
		String lastLoginEnd = pd.getString("lastLoginEnd");		//结束时间
		if(lastLoginStart != null && !"".equals(lastLoginStart)){
			pd.put("lastLoginStart", lastLoginStart+" 00:00:00");
		}
		if(lastLoginEnd != null && !"".equals(lastLoginEnd)){
			pd.put("lastLoginEnd", lastLoginEnd+" 23:59:00");
		}
		
		
		page.setPd(pd);
		List<PageData>	varList = informationService.list1(page);	//列出Information列表
		mv.setViewName("dep/messageinfo/messageinfo_information");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**关联列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/goRel")
	public ModelAndView goRel(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Information");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String proRelId = pd.getString("PRODUCTSINFO_ID");
		if(null != proRelId && !"".equals(proRelId)){
			pd.put("proRelId", proRelId.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = informationService.list(page);	//列出Information列表
		mv.setViewName("system/information/information_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("msg", "goRel");
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
		mv.setViewName("system/information/information_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	
	
	/**修改存续组
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/editGroupUser")
	public ModelAndView editGroupUser(Model model)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		informationService.editGroupUser(pd);	//修改分组
			mv.setViewName("system/information/information_edit");
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}	
	
	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(Model model)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String flag=pd.getString("flag");
		pd = informationService.findById(pd);	//根据ID读取
		if (null==flag) {
			mv.setViewName("system/information/information_edit");
		}else{
			JzZtree(model);//调用ztree
			mv.setViewName("system/information/information_groupedit");
			pd.put("flag", flag);
		}
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Information");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			informationService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Information到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("编号");	//1
		titles.add("存蓄内容");	//2
		titles.add("产品名称");	//3
		titles.add("创建人");	//4
		titles.add("创建时间");	//5
		titles.add("PDF");	//6
		dataMap.put("titles", titles);
		List<PageData> varOList = informationService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("INFORMATION_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("INFORMATION_CONTENT"));	    //2
			vpd.put("var3", varOList.get(i).getString("INFORMATION_INFO_ID"));	    //3
			vpd.put("var4", varOList.get(i).getString("INFORMATION_CREATEBY"));	    //4
			vpd.put("var5", varOList.get(i).getString("INFORMATION_CREATETIME"));	    //5
			vpd.put("var6", varOList.get(i).getString("INFORMATION_PDFURL"));	    //6
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
