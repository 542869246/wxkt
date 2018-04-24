package com.flc.controller.dep.messageinfo;

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
import com.flc.service.dep.messageinfo.messageinfoManager;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.system.products.information.InformationManager;
import com.flc.service.system.products.productsinfo.ProductsinfoManager;
import com.flc.util.AppUtil;
import com.flc.util.Const;
import com.flc.util.Jurisdiction;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;

import net.sf.json.JSONArray;

/** 
 * 说明：系统存续信息
 * 创建人：FLC
 * 创建时间：2017-10-24
 */
@Controller
@RequestMapping(value="/messageinfo")
public class messageinfoController extends BaseController {
	
	String menuUrl = "messageinfo/list.do"; //菜单地址(权限用)
	@Resource(name="messageinfoService")
	private messageinfoManager messageinfoService;
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	@Resource(name="productsinfoService")
	private ProductsinfoManager productsinfoService;
	@Resource(name="informationService")
	private InformationManager informationService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(MultipartFile uploadFile,
			String MESSAGEINFO_TITLE,String MESSAGEINFO_CONTEXT,
			String MESSAGEINFO_STATE,String MESSAGEINFO_PRODUCTS_ID,String MESSAGEINFO_GROUP_ID,
			String MESSAGEINFO_INFORMATION_ID) throws Exception{
		HttpServletRequest request=this.getRequest();
		logBefore(logger, Jurisdiction.getUsername()+"新增messageinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();		
		pd.put("MESSAGEINFO_ID", this.get32UUID());	//主键
		pd.put("MESSAGEINFO_TITLE", MESSAGEINFO_TITLE);
		pd.put("MESSAGEINFO_CONTEXT", MESSAGEINFO_CONTEXT);
		pd.put("MESSAGEINFO_STATE", MESSAGEINFO_STATE);
		pd.put("MESSAGEINFO_PRODUCTS_ID", MESSAGEINFO_PRODUCTS_ID);
		pd.put("MESSAGEINFO_GROUP_ID", MESSAGEINFO_GROUP_ID);
		
		Date date = new Date();   
		Timestamp timestamp = new Timestamp(date.getTime());
		pd.put("MESSAGEINFO_CREATETIME",timestamp);                  //时间
		User user=(User)request.getSession().getAttribute(Const.SESSION_USER);
		pd.put("MESSAGEINFO_CREATEBY",user.getUSER_ID());           //创建人
		if(pd.getString("MESSAGEINFO_STATE").equals("0")){
			String idPicPath =null;
			if(!uploadFile.isEmpty()){
				String uploadPath=request.getSession().getServletContext().getRealPath("static"+File.separator+"login"+File.separator+"pdf");
				System.out.println(uploadPath);
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
						idPicPath="/static/login/pdf/"+name;
						pd.put("MESSAGEINFO_URL", idPicPath);
					} catch (IllegalStateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				 
				}
		}else if(pd.getString("MESSAGEINFO_STATE").equals("1")){
			pd.put("MESSAGEINFO_INFORMATION_ID", MESSAGEINFO_INFORMATION_ID);
		}
			
		messageinfoService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除messageinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		messageinfoService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit(MultipartFile uploadFile,String MESSAGEINFO_ID,String MESSAGEINFO_TITLE,String MESSAGEINFO_CONTEXT,
			String MESSAGEINFO_STATE,String MESSAGEINFO_PRODUCTS_ID,String MESSAGEINFO_GROUP_ID,
			String MESSAGEINFO_INFORMATION_ID,String MESSAGEINFO_URL) throws Exception{
		HttpServletRequest request =this.getRequest();
		logBefore(logger, Jurisdiction.getUsername()+"修改messageinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Date date = new Date();   
		Timestamp timestamp = new Timestamp(date.getTime());
		pd.put("BANNER_CREATETIME",timestamp);                  //时间
		User user=(User)request.getSession().getAttribute(Const.SESSION_USER);
		pd.put("BANNER_CREATEBY",user.getUSER_ID());           //创建人
		
		pd.put("MESSAGEINFO_ID", MESSAGEINFO_ID);
		pd.put("MESSAGEINFO_TITLE", MESSAGEINFO_TITLE);
		pd.put("MESSAGEINFO_CONTEXT", MESSAGEINFO_CONTEXT);
		pd.put("MESSAGEINFO_STATE", MESSAGEINFO_STATE);
		pd.put("MESSAGEINFO_PRODUCTS_ID", MESSAGEINFO_PRODUCTS_ID);
		pd.put("MESSAGEINFO_GROUP_ID", MESSAGEINFO_GROUP_ID);
		
		if(pd.getString("MESSAGEINFO_STATE").equals("0")){
			String idPicPath =null;
			if(!uploadFile.isEmpty()){
				String uploadPath=request.getSession().getServletContext().getRealPath("static"+File.separator+"login"+File.separator+"pdf");
				System.out.println(uploadPath);
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
						idPicPath="/static/login/pdf/"+name;
						pd.put("MESSAGEINFO_URL", idPicPath);
					} catch (IllegalStateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				 
				}else{
					pd.put("MESSAGEINFO_URL", MESSAGEINFO_URL);
				}
		}else if(pd.getString("MESSAGEINFO_STATE").equals("1")){
			pd.put("MESSAGEINFO_INFORMATION_ID", MESSAGEINFO_INFORMATION_ID);
		}
		
		
		
		
		
		messageinfoService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表messageinfo");
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
			pd.put("lastLoginEnd", lastLoginEnd+" 59:59:00");
		}
		page.setPd(pd);
		List<PageData>	varList = messageinfoService.list(page);	//列出messageinfo列表
		mv.setViewName("dep/messageinfo/messageinfo_list");
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
		try{
			//获取下拉列表
			JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDictForAttr("690745a213774651a563f127c6c1ebd9"));
			String json = arr.toString();
			model.addAttribute("zTreeNodes", json);
			mv.setViewName("dep/messageinfo/messageinfo_edit");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return mv;
	}	
	
	
	@RequestMapping(value="/goPdf")
	public ModelAndView goPdf(String messUrl)throws Exception{
		ModelAndView mv=this.getModelAndView();
		mv.addObject("messUrl", messUrl);
		mv.setViewName("dep/messageinfo/messPdf");
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
		try {
			pd = messageinfoService.findById(pd);	//根据ID读取
			
			//获取下拉列表
			JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDictForAttr("690745a213774651a563f127c6c1ebd9"));
			String json = arr.toString();
			mv.addObject("zTreeNodes", json);
			

			//分组名称
			String group =pd.getString("MESSAGEINFO_GROUP_ID");
			if(!group.equals("")){
				String [] groupAll=null;
				String name="";
				groupAll=group.split(",");
				for (String s : groupAll) {
					pd.put("DICTIONARIES_ID", s);
					PageData p= dictionariesService.findById(pd);
					name+=p.getString("NAME")+",";
				}
				mv.addObject("groupName", name);
			}
			
			//产品名称
			String proid=pd.getString("MESSAGEINFO_PRODUCTS_ID");
			if(!proid.equals("")){
				pd.put("PRODUCTSINFO_ID", proid);
				PageData pa=productsinfoService.findById(pd);
				if(pa!=null){
					String proName=pa.getString("PRODUCTS_NAME");
					mv.addObject("proName", proName);
				}
			}
			
			//续存内容
			String mationid=pd.getString("MESSAGEINFO_INFORMATION_ID");
			if(mationid !=null){
			pd.put("INFORMATION_ID", mationid);
			PageData pg=informationService.findById(pd);
			if(pg!=null){
				String mationName=pg.getString("INFORMATION_CONTENT");
				mv.addObject("mationName",mationName);
			}
			}
			
			System.out.println(pd.get("MESSAGEINFO_STATE"));

			mv.setViewName("dep/messageinfo/messageinfo_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}	
	
	
	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除messageinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			messageinfoService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出messageinfo到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("系统存续编号");	//1
		titles.add("标题");	//2
		titles.add("摘要");	//3
		titles.add("文件上传");	//4
		titles.add("产品编号");	//5
		titles.add("状态");	//6
		titles.add("分组编号");	//7
		titles.add("产品存续信息");	//8
		titles.add("创建人");	//9
		titles.add("创建时间");	//10
		dataMap.put("titles", titles);
		List<PageData> varOList = messageinfoService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("MESSAGEINFO_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("MESSAGEINFO_TITLE"));	    //2
			vpd.put("var3", varOList.get(i).getString("MESSAGEINFO_CONTEXT"));	    //3
			vpd.put("var4", varOList.get(i).getString("MESSAGEINFO_URL"));	    //4
			vpd.put("var5", varOList.get(i).getString("MESSAGEINFO_PRODUCTS_ID"));	    //5
			vpd.put("var6", varOList.get(i).get("MESSAGEINFO_STATE").toString());	//6
			vpd.put("var7", varOList.get(i).getString("MESSAGEINFO_GROUP_ID"));	    //7
			vpd.put("var8", varOList.get(i).getString("MESSAGEINFO_INFORMATION_ID"));	    //8
			vpd.put("var9", varOList.get(i).getString("MESSAGEINFO_CREATEBY"));	    //9
			vpd.put("var10", varOList.get(i).getString("MESSAGEINFO_CREATETIME"));	    //10
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
