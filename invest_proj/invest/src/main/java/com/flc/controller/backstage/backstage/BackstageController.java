package com.flc.controller.backstage.backstage;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.flc.controller.base.BaseController;
import com.flc.entity.system.Dictionaries;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;
import com.flc.util.UuidUtil;
import com.flc.util.Jurisdiction;
import com.flc.service.backstage.backstage.BackstageManager;
import com.flc.service.system.dictionaries.DictionariesManager;

/** 
 * 说明：亲加后台表
 * 创建人：FLC
 * 创建时间：2017-12-06
 */
@Controller
@RequestMapping(value="/backstage")
public class BackstageController extends BaseController {
	
	String menuUrl = "backstage/goEdit.do"; //菜单地址(权限用)
	@Resource(name="backstageService")
	private BackstageManager backstageService;
	@Resource
	private DictionariesManager dictionariesService;
	
	/**保存
	 * @param
	 * @throws Exception
	 *//*
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Backstage");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("BACKSTAGE_ID", this.get32UUID());	//主键
		backstageService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}*/
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	/*@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Backstage");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		backstageService.delete(pd);
		out.write("success");
		out.close();
	}*/
	
	/**
	 * 当直播平台变动时  把所有的教室房间的直播平台也给变动
	 */
	@RequestMapping(value="/toUpdateAllType")
	public void toUpdateAllType()throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		backstageService.toUpdateAllType(pd);
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public String edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Backstage");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SECRETID", "1");
		List<PageData> varList=backstageService.listAll(pd);
		String pdBId=pd.getString("BACKSTAGE_ID");
		if(varList.size()==0){
			pd.put("BACKSTAGE_ID", this.get32UUID());	//主键
			backstageService.save(pd);
		}else{
			backstageService.edit(pd);
			String txsecret=null;
			String bizid=null;
			String backstage_id=null;
			for (PageData pageData : varList) {
				String BId=pageData.getString("BACKSTAGE_ID");
				if(pdBId!=null && BId!=null &&!"".equals(pdBId)&&!"".equals(BId)&&!pdBId.equals(BId)){
					txsecret=pageData.getString("TXSECRET");
					bizid=pageData.getString("BIZID");
					backstage_id=pageData.getString("BACKSTAGE_ID");
					pageData=pd;
					pageData.put("SECRETID", "0");
					pageData.put("BACKSTAGE_ID", backstage_id);
					pageData.put("TXSECRET", txsecret);
					pageData.put("BIZID", bizid);
					backstageService.edit(pageData);
				}
			}
		}
		pd.put("BACKSTAGE_ID", pdBId);
		backstageService.toUpdateAllTencent(pd);
		return "redirect:goEdit";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	/*@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Backstage");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = backstageService.list(page);	//列出Backstage列表
		mv.setViewName("backstage/backstage/backstage_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}*/
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	/*@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("backstage/backstage/backstage_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	*/
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData txpd=new PageData();
		txpd.put("BIANMA", "txzh");
		PageData dicpd=dictionariesService.findByBianma(txpd);
		List<Dictionaries> diclist=dictionariesService.listSubDictByParentId(dicpd.getString("DICTIONARIES_ID"));
		mv.addObject("diclist", diclist);
		//----------------腾讯账号 end-----------------
		List<String> checkEmailSmsList = null;
		try {
			List<PageData> varList=backstageService.listAll(pd);
			PageData dicvar=new PageData();
			checkEmailSmsList = null;
			if(varList.size()>0){
				if(diclist.size()>0){
					if(diclist.size()>varList.size()){//达到数量相同
						for(int i=0;i<diclist.size()-varList.size();i++){
							dicvar.put("BACKSTAGE_ID", varList.get((varList.size()-1)).getString("BACKSTAGE_ID"));
							dicvar= backstageService.findById(dicvar);	//根据ID读取
							dicvar.put("TENCENTADMIN", null);
							dicvar.put("TXSECRET", null);
							dicvar.put("BIZID", null);
							dicvar.put("SECRETID", "0");
							dicvar.put("BACKSTAGE_ID",this.get32UUID());
							backstageService.save(dicvar);
							varList.add(dicvar);
						}
					}
					if(diclist.size()==varList.size()){//给每一条数据复制关联类型维护
						for (int i=0;i<varList.size();i++) {
							PageData var=varList.get(i);
							String str=var.getString("TENCENTADMIN");
								var.put("TENCENTADMIN", diclist.get(i).getBIANMA());
								backstageService.edit(var);
						}
					}	
				}
				if(pd.getString("TENCENTADMIN")!=null&&!"".equals(pd.getString("TENCENTADMIN"))){
					for (PageData pageData : varList) {
						if(pageData.getString("TENCENTADMIN").equals(pd.getString("TENCENTADMIN"))){
							pageData.put("SECRETID", "1");
							backstageService.edit(pageData);
							pd=pageData;
							backstageService.toUpdateAllTencent(pageData);
						}
					}
				}else{
					boolean flag=false;
					for (PageData pageData : varList) {//遍历查询默认的一条
						String secretId=pageData.getString("SECRETID");
						if(secretId!=null &&"1".equals(secretId)){
							flag=true;
						}
						if(flag){
							pd=pageData;
							break;
						}
					}
					if(!flag){
						varList.get(0).put("SECRETID", "1");
						backstageService.edit(varList.get(0));
						pd=varList.get(0);
					}
				}
				if(pd.getString("CHECK_EMAIL_SMS")!=null){ 
					String emailorsms[]=pd.getString("CHECK_EMAIL_SMS").split(",");
					checkEmailSmsList=Arrays.asList(emailorsms);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.setViewName("backstage/backstage/backstage_edit");
		mv.addObject("checkEmailSmsList", checkEmailSmsList);
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	/*@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Backstage");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			backstageService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}*/
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Backstage到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("主键");	//1
		titles.add("账号");	//2
		titles.add("密码");	//3
		titles.add("access_secret");	//4
		titles.add("appid");	//5
		titles.add("appsecret");	//6
		titles.add("阿里云短信账号");	//7
		titles.add("阿里云短信密码");	//8
		titles.add("阿里云短信模板号");	//9
		titles.add("阿里云短信签名名称");	//10
		dataMap.put("titles", titles);
		List<PageData> varOList = backstageService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("BACKSTAGE_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("GOTYE_EMAIL"));	    //2
			vpd.put("var3", varOList.get(i).getString("GOTYE_PASSWORD"));	    //3
			vpd.put("var4", varOList.get(i).getString("GOTYE_ACCESS_SECRET"));	    //4
			vpd.put("var5", varOList.get(i).getString("GOTYE_WX_APPID"));	    //5
			vpd.put("var6", varOList.get(i).getString("GOTYE_WX_SECRET"));	    //6
			vpd.put("var7", varOList.get(i).getString("ALI_DX_APPID"));	    //7
			vpd.put("var8", varOList.get(i).getString("ALI_DX_SECRET"));	    //8
			vpd.put("var9", varOList.get(i).getString("ALI_TECODE"));	    //9
			vpd.put("var10", varOList.get(i).getString("ALI_SIGN_NAME"));	    //10
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
