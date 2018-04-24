package com.flc.controller.system.products.productsinfo;

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

import org.apache.commons.io.FilenameUtils;
import org.apache.xmlbeans.impl.xb.xsdschema.Attribute.Use;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.flc.service.system.products.productsinfo.ProductsinfoManager;

/** 
 * 说明：产品管理
 * 创建人：FLC
 * 创建时间：2017-10-24
 */
@Controller
@RequestMapping(value="/productsinfo")
public class ProductsinfoController extends BaseController {
	
	String menuUrl = "productsinfo/list.do"; //菜单地址(权限用)
	@Resource(name="productsinfoService")
	private ProductsinfoManager productsinfoService;
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	@Resource(name="informationService")
	private InformationManager informationService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")//@RequestParam("uploadFile")MultipartFile uploadFile,HttpServletRequest req
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Productsinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
	 	HttpServletRequest request = this.getRequest();
		User user=(User)request.getSession().getAttribute(Const.SESSION_USER);
		pd.put("PRODUCTS_CREATEBY",user.getUSER_ID());           
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
		pd.put("PRODUCTS_CREATETIME", sf.format(date));
		pd.put("PRODUCTSINFO_ID", this.get32UUID());	//主键
		/*pd.put("ATTR_TYPEID", req.getParameter("ATTR_TYPEID"));
		pd.put("PRODUCTS_NAME", req.getParameter("PRODUCTS_NAME"));
		pd.put("PRODUCTS_TYPE1_ID", req.getParameter("PRODUCTS_TYPE1_ID"));
		pd.put("PRODUCTS_COUNTERSTATE", req.getParameter("PRODUCTS_COUNTERSTATE"));
		pd.put("PRODUCTS_PAPERSTATE", req.getParameter("PRODUCTS_PAPERSTATE"));req.getParameter("PRODUCTS_SQJFBI")*/
		if (!pd.getString("PRODUCTS_SQJFBI").equals("")) {
			pd.put("PRODUCTS_SQJFBI", pd.getString("PRODUCTS_SQJFBI") );
		}else {
			pd.put("PRODUCTS_SQJFBI",0);
		}
		pd.put("PRODUCTS_YJBJJZ", pd.getString("PRODUCTS_YJBJJZ"));
		if (!pd.getString("PRODUCTS_START").equals("")) {
			pd.put("PRODUCTS_START", pd.getString("PRODUCTS_START"));
		}else{
			pd.put("PRODUCTS_START", 0);
		}
		pd.put("PRODUCTS_ZEXIANTU", pd.getString("PRODUCTS_ZEXIANTU"));
		/*pd.put("PRODUCTS_ATTRIBUTE", req.getParameter("PRODUCTS_ATTRIBUTE"));
		pd.put("PRODUCTS_TERM", req.getParameter("PRODUCTS_TERM"));
		pd.put("PRODUCTS_AMOUT", req.getParameter("PRODUCTS_AMOUT"));
		pd.put("PRODUCTS_NHSR", req.getParameter("PRODUCTS_NHSR"));
		pd.put("PRODUCTS_TEXT", req.getParameter("PRODUCTS_TEXT"));
		pd.put("PRODUCTS_INCOME", req.getParameter("PRODUCTS_INCOME"));*/
		//#{PRODUCTSINFO_ID},#{PRODUCTS_NAME},#{PRODUCTS_TYPE1_ID},
		//#{PRODUCTS_COUNTERSTATE},#{PRODUCTS_SQJFBI},#{upfile},#{PRODUCTS_YJBJJZ},
		 //#{PRODUCTS_START},"",#{NEWINFO_CREATEBY},
		//#{PRODUCTS_CREATETIME},#{PRODUCTS_ATTRIBUTE},#{PRODUCTS_TERM},
		//#{PRODUCTS_AMOUT},#{PRODUCTS_NHSR},#{PRODUCTS_TEXT},#{PRODUCTS_INCOME}
		
		//上传
		/*String idPicPath =null;
		
		if(!uploadFile.isEmpty()){
			String uploadPath=request.getSession().getServletContext().getRealPath("static"+File.separator+"login"+File.separator+"upload");
			//String uploadPath=request.getSession().getServletContext().getRealPath("/");
			System.out.println(uploadPath);
			String oldName=uploadFile.getOriginalFilename();
			String prefix=FilenameUtils.getExtension(oldName);
				Date dates = new Date();//时间戳
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String strDate = sdf.format(dates);
				String name = strDate+"_img."+prefix;
				File newFile = new File(uploadPath,name);
				if(!newFile.exists()){
					//创建文件夹
					newFile.mkdirs();
				}
				try {
					uploadFile.transferTo(newFile);
					idPicPath="/static/login/upload"+name;
//					System.out.println("----"+request.getContextPath());
//					System.out.println("/static/product/pdf/"+name);
					pd.put("PRODUCTS_ZEXIANTU", pd.getString("PRODUCTS_START"));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			 
			}	*/
		
		
		
		
		productsinfoService.save(pd);
		informationService.groupUser(pd);//新增产品放入默认组中
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
						// String path = "d:/upload/" + fileNames;//�ϴ�·��
						String  path =
								 request.getSession().getServletContext()
								 .getRealPath("static"+File.separator+"login"+File.separator+"upload")
								 + File.separator + fileNames;
						// System.out.println("path:"+path);
						
						File localFile = new File(path);
						if (!localFile.exists()) {// ����ļ��в����ڣ��Զ�����
							localFile.mkdirs();
						}
						file.transferTo(localFile);
						//src=request.getContextPath()+"/upload/img/"+fileNames;
						src="/static/login/upload/"+fileNames;
						//System.out.println("src:"+src);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Productsinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		productsinfoService.delete(pd);
		informationService.delGroup(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Productsinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		HttpServletRequest request = this.getRequest();
		User user=(User)request.getSession().getAttribute(Const.SESSION_USER);
		pd.put("PRODUCTS_CREATEBY",user.getUSER_ID());           
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
		pd.put("PRODUCTS_CREATETIME", sf.format(date));
		/*pd.put("PRODUCTSINFO_ID", req.getParameter("PRODUCTSINFO_ID"));	//主键
		pd.put("PRODUCTS_NAME", req.getParameter("PRODUCTS_NAME"));
		pd.put("PRODUCTS_TYPE1_ID", req.getParameter("PRODUCTS_TYPE1_ID"));
		pd.put("PRODUCTS_COUNTERSTATE", req.getParameter("PRODUCTS_COUNTERSTATE"));
		pd.put("PRODUCTS_PAPERSTATE", req.getParameter("PRODUCTS_PAPERSTATE"));
		pd.put("ATTR_TYPEID", req.getParameter("ATTR_TYPEID"));
		pd.put("GROUPBY_ID", req.getParameter("GROUPBY_ID"));*/
		if (!pd.getString("PRODUCTS_SQJFBI").equals("")) {
			pd.put("PRODUCTS_SQJFBI", pd.getString("PRODUCTS_SQJFBI") );
		}else {
			pd.put("PRODUCTS_SQJFBI",0);
		}
		pd.put("PRODUCTS_YJBJJZ", pd.getString("PRODUCTS_YJBJJZ"));
		if (!pd.getString("PRODUCTS_START").equals("")) {
			pd.put("PRODUCTS_START", pd.getString("PRODUCTS_START"));
		}else{
			pd.put("PRODUCTS_START", 0);
		}
		pd.put("PRODUCTS_ZEXIANTU", pd.getString("PRODUCTS_ZEXIANTU"));
		/*pd.put("PRODUCTS_ATTRIBUTE", req.getParameter("PRODUCTS_ATTRIBUTE"));
		pd.put("PRODUCTS_TERM", req.getParameter("PRODUCTS_TERM"));
		pd.put("PRODUCTS_AMOUT", req.getParameter("PRODUCTS_AMOUT"));
		pd.put("PRODUCTS_NHSR", req.getParameter("PRODUCTS_NHSR"));
		pd.put("PRODUCTS_TEXT", req.getParameter("PRODUCTS_TEXT"));
		pd.put("PRODUCTS_INCOME", req.getParameter("PRODUCTS_INCOME"));*/
		//#{PRODUCTSINFO_ID},#{PRODUCTS_NAME},#{PRODUCTS_TYPE1_ID},
		//#{PRODUCTS_COUNTERSTATE},#{PRODUCTS_SQJFBI},#{upfile},#{PRODUCTS_YJBJJZ},
		 //#{PRODUCTS_START},"",#{NEWINFO_CREATEBY},
		//#{PRODUCTS_CREATETIME},#{PRODUCTS_ATTRIBUTE},#{PRODUCTS_TERM},
		//#{PRODUCTS_AMOUT},#{PRODUCTS_NHSR},#{PRODUCTS_TEXT},#{PRODUCTS_INCOME}
		
		//上传
		/*String idPicPath =null;
		
		if(!uploadFile.isEmpty()){
			String uploadPath=request.getSession().getServletContext().getRealPath("static"+File.separator+"login"+File.separator+"upload");
			//String uploadPath=request.getSession().getServletContext().getRealPath("/");
			System.out.println(uploadPath);
			String oldName=uploadFile.getOriginalFilename();
			String prefix=FilenameUtils.getExtension(oldName);
				Date dates = new Date();//时间戳
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String strDate = sdf.format(dates);
				String name = strDate+"_img."+prefix;
				File newFile = new File(uploadPath,name);
				if(!newFile.exists()){
					//创建文件夹
					newFile.mkdirs();
				}
				try {
					uploadFile.transferTo(newFile);
					idPicPath="/static/login/upload"+name;
//					System.out.println("----"+request.getContextPath());
//					System.out.println("/static/product/pdf/"+name);
					pd.put("PRODUCTS_ZEXIANTU", idPicPath);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			 
			}	*/
		
		
		
		informationService.editGroupUser(pd);
		productsinfoService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
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
			JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDict1("50b463cdb2df11e7bfc600163e1a9d37"));
			String json = arr.toString();
			json = json.replaceAll("DICTIONARIES_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("NAME", "name").replaceAll("subDict", "nodes").replaceAll("hasDict", "checked").replaceAll("treeurl", "url");
			//System.out.println(json);
			model.addAttribute("zTreeNodes", json);
			mv.addObject("DICTIONARIES_ID",DICTIONARIES_ID);
			mv.addObject("pd", pd);	
			mv.setViewName("system/productsinfo/productsinfo_ztree");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**系统续存 调用
	 * 显示列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/listAllMess")
	public ModelAndView listAllMess(Model model,String DICTIONARIES_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		boolean flag = true;
		try{
			JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDict2("50b463cdb2df11e7bfc600163e1a9d37"));
			String json = arr.toString();
			json = json.replaceAll("DICTIONARIES_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("NAME", "name").replaceAll("subDict", "nodes").replaceAll("hasDict", "checked").replaceAll("treeurl", "url");
			//System.out.println("######"+json);
			model.addAttribute("zTreeNodes", json);
			mv.addObject("DICTIONARIES_ID",DICTIONARIES_ID);
			mv.addObject("pd", pd);	
			mv.setViewName("dep/messageinfo/messageinfo_ztree");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**系统续存 调用
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/listMess")
	public ModelAndView listMess(Model model,Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Productsinfo");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//String attrType = pd.getString("attrType");
		String keywords = pd.getString("keywords");				//关键词检索条件
		String ATTR_TYPEID = pd.getString("ATTR_TYPEID");
		if(null != ATTR_TYPEID && !"".equals(ATTR_TYPEID)){
			pd.put("ATTR_TYPEID", ATTR_TYPEID.trim());
		}
//		if(null == attrType || "".equals(attrType)){
//			pd.put("ATTR_TYPEID", null);
//		}
		
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		
		page.setPd(pd);
		List<PageData>	varList = productsinfoService.list(page);	//列出Attribute列表
		JzZtree(model);//调用JzZtree方法
		mv.setViewName("dep/messageinfo/messProducts_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	
	
	//加载产品类型ztree数据
	public void JzZtree(Model model){
		try{
			//获取下拉列表
			JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDictForAttr("50b463cdb2df11e7bfc600163e1a9d37"));
			String json = arr.toString();
			model.addAttribute("zTreeNodes", json);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}
	//加载产品属性ztree数据//943e53d418784a5094a5e67ef6838587
		public void JzAttrZtree(Model model){
			try{
				//获取下拉列表
				JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDictForAttr("690745a213774651a563f127c6c1ebd9"));
				String json = arr.toString();
				model.addAttribute("zTreeAttrNodes", json);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
		}
		//加载投资分组ztree数据//4b9e9c84c8a2471eae114b1711c848b4
				public void JzInvestZtree(Model model){
					try{
						//获取下拉列表
						JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDictForAttr("4b9e9c84c8a2471eae114b1711c848b4"));
						String json = arr.toString();
						model.addAttribute("zTreeInvestNodes", json);
					} catch(Exception e){
						logger.error(e.toString(), e);
					}
				}
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Model model,Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Productsinfo");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//String attrType = pd.getString("attrType");
		String keywords = pd.getString("keywords");				//关键词检索条件
		String ATTR_TYPEID = pd.getString("ATTR_TYPEID");
		if(null != ATTR_TYPEID && !"".equals(ATTR_TYPEID)){
			pd.put("ATTR_TYPEID", ATTR_TYPEID.trim());
		}
//		if(null == attrType || "".equals(attrType)){
//			pd.put("ATTR_TYPEID", null);
//		}
		
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		
		page.setPd(pd);
		List<PageData>	varList = productsinfoService.list(page);	//列出Attribute列表
		JzZtree(model);//调用JzZtree方法
		JzAttrZtree(model);
		mv.setViewName("system/productsinfo/productsinfo_list");
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
	public ModelAndView goAdd(Model model)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		JzZtree(model);//调用基金zTree方法
		JzAttrZtree(model);
		JzInvestZtree(model);
		mv.setViewName("system/productsinfo/productsinfo_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
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
		String GROUPBY_ID = pd.getString("GROUPBY_ID");
		pd = productsinfoService.findById(pd);	//根据ID读取产品
		List varsList = productsinfoService.findAttrById(pd);//根据ID读取产品所有属性
		JzZtree(model);//调用基金zTree方法
		JzAttrZtree(model);//调用属性Ztree方法
		JzInvestZtree(model);//调用投资分组Ztree方法
		mv.setViewName("system/productsinfo/productsinfo_edit");
		mv.addObject("GROUPBY_ID", GROUPBY_ID);
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		mv.addObject("varsList", varsList);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Productsinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			productsinfoService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Productsinfo到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("产品ID");	//1
		titles.add("产品名称");	//2
		titles.add("模块类型");	//3
		dataMap.put("titles", titles);
		List<PageData> varOList = productsinfoService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("PRODUCTSINFO_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("PRODUCTS_NAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("PRODUCTS_TYPE1_ID"));	    //3
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
