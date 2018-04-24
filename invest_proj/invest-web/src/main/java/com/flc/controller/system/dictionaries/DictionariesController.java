package com.flc.controller.system.dictionaries;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

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
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.web.userinfo.UserinfoManager;
import com.flc.typeEnums.TypeEnums;
import com.flc.util.AppUtil;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;

/** 
 * 说明：字典表
 * 创建人：FLC
 * 创建时间：2017-10-20
 */	
@Controller
@RequestMapping(value="/dictionaries")
public class DictionariesController extends BaseController {

//		String menuUrl = "dictionaries/list.do"; //菜单地址(权限用)
		@Resource(name="dictionariesService")
		private DictionariesManager dictionariesService;
		@Value("${uploadfPath}")
		private String uploadfPath;
		@Resource(name="userinfoService")
		private UserinfoManager userinfoService;
		/**保存
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/save")
		public ModelAndView save() throws Exception{
//			logBefore(logger, Jurisdiction.getUsername()+"新增Dictionaries");
//			if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("DICTIONARIES_ID", this.get32UUID());	//主键
			dictionariesService.save(pd);
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
//			logBefore(logger, Jurisdiction.getUsername()+"删除Dictionaries");
//			if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
			PageData pd = new PageData();
			pd = this.getPageData();
			dictionariesService.delete(pd);
			out.write("success");
			out.close();
		}
		
		/**修改
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/edit")
		public ModelAndView edit() throws Exception{
//			logBefore(logger, Jurisdiction.getUsername()+"修改Dictionaries");
//			if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			dictionariesService.edit(pd);
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
//			logBefore(logger, Jurisdiction.getUsername()+"列表Dictionaries");
			//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			String keywords = pd.getString("keywords");				//关键词检索条件
			System.out.println(keywords);
			if(null != keywords && !"".equals(keywords)){
				pd.put("keywords", keywords.trim());
			}
			page.setPd(pd);
			List<PageData>	varList = dictionariesService.list(page);	//列出Dictionaries列表
			mv.setViewName("system/dictionaries/dictionaries_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
//			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
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
			mv.setViewName("system/dictionaries/dictionaries_edit");
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
			pd = dictionariesService.findById(pd);	//根据ID读取
			mv.setViewName("system/dictionaries/dictionaries_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
			return mv;
		}
		
		 /**获取所有能力值类型
			 * @param
			 * @throws Exception
			 */
			@RequestMapping(value="/getAbilityType")
			@ResponseBody
			public List<PageData> getAbility()throws Exception{
				PageData pd = new PageData();
				pd = this.getPageData();
				
				//获取当前时间
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				pd.put("COURSE_TIME", df.format(new Date()));
				
				pd.put("PARENT_ID", "e6f62d095964410593593e58470ab234");
				pd.put("USER_ID", "f0115a0b74b44d2ca81c7332d7802e39");
				List<PageData> pds = dictionariesService.findListById(pd);	//根据ID读取
				return pds;
			}
		
		 /**批量删除
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/deleteAll")
		@ResponseBody
		public Object deleteAll() throws Exception{
//			logBefore(logger, Jurisdiction.getUsername()+"批量删除Dictionaries");
//			if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
			PageData pd = new PageData();		
			Map<String,Object> map = new HashMap<String,Object>();
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				dictionariesService.deleteAll(ArrayDATA_IDS);
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
//			logBefore(logger, Jurisdiction.getUsername()+"导出Dictionaries到excel");
//			if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
			ModelAndView mv = new ModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("备注1");	//1
			titles.add("备注2");	//2
			titles.add("备注3");	//3
			titles.add("备注4");	//4
			titles.add("备注5");	//5
			titles.add("备注6");	//6
			titles.add("备注7");	//7
			titles.add("备注8");	//8
			dataMap.put("titles", titles);
			List<PageData> varOList = dictionariesService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("DICTIONARIES_ID"));	    //1
				vpd.put("var2", varOList.get(i).getString("NAME"));	    //2
				vpd.put("var3", varOList.get(i).getString("NAME_EN"));	    //3
				vpd.put("var4", varOList.get(i).getString("BIANMA"));	    //4
				vpd.put("var5", varOList.get(i).get("ORDER_BY").toString());	//5
				vpd.put("var6", varOList.get(i).getString("PARENT_ID"));	    //6
				vpd.put("var7", varOList.get(i).getString("BZ"));	    //7
				vpd.put("var8", varOList.get(i).getString("TBSNAME"));	    //8
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
			return mv;
		}
		
		/**
		 * 查询所有产品的所有模块产品
		 * @return 返回所有产品的中的模块产品
		 * @throws Exception
		 */
		@RequestMapping(value="/findProperty")
		public ModelAndView findProperty(HttpSession session) throws Exception{
			logBefore(logger,"所有产品下的模块 例如:花椒直播");
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			
			PageData pd1=(PageData)this.getRequest().getSession().getAttribute("loginuser");
			PageData loginuser =(PageData)userinfoService.findById(pd1);
			session.setAttribute("loginuser",loginuser);
			session.getServletContext().setAttribute("uploadfPath", uploadfPath);
			long USER_ATTESTATION=(long)loginuser.get("USER_ATTESTATION");
			
			if(USER_ATTESTATION==0){
				mv.addObject("title", "资产配置");
				mv.addObject("msg", "你还未经过认证哦!");
				mv.setViewName("space/space_list");
			}else{
				// 产品下的所有模块
				pd.put("PARENT_ID", TypeEnums.PRODUCTS_TYPE.getCode());
				List<PageData>	varList = dictionariesService.findProperty(pd);
				PageData pds = new PageData();
				pds.put("PARENT_ID", varList.get(0).get("DICTIONARIES_ID"));
				session.setAttribute("pdimg",pds.get("PARENT_ID"));
				Map map= dictionariesService.selectProperty(pds);
				System.out.println(map);
				mv.addObject("varList",varList);
				mv.addObject("map",map);
				mv.addObject("parent_id",pds.get("PARENT_ID"));
				mv.setViewName("system/property/property");
			}
			return mv;
		}
//		/**
//		 * 查询所有产品的所有模块产品中的子模块
//		 * @return 返回所有产品的中的模块中的子模块
//		 * @throws Exception
//		 */
//		@RequestMapping(value="/findParentId")
//		@ResponseBody
//		public Map findParentId(String parent_id,HttpSession session) throws Exception{
//			logBefore(logger,"所有产品下的模块 例如:花椒直播");
//			ModelAndView mv = this.getModelAndView();
//			PageData pd = new PageData();
//			pd.put("PARENT_ID", parent_id);
//			session.setAttribute("pdimg", parent_id);
//			// 查询所有模块
//			Map map= dictionariesService.selectProperty(pd);
//			return map;
//		}
		
		/*public static void main(String[] args) {
			System.out.println();
		}*/
		
		@InitBinder	
		public void initBinder(WebDataBinder binder){
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
		}

}
