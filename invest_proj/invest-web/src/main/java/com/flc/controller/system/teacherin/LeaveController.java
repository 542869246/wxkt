package com.flc.controller.system.teacherin;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.util.HSSFColor.BLACK;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;  
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.service.school.schoolsubject.SchoolSubjectManager;
import com.flc.service.system.leave.LeaveManager;
import com.flc.service.system.user.UserManager;
import com.flc.service.web.webusers.WebUsersManager;
import com.flc.util.PageData;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/** 
 * 说明：请假表
 * 创建人：FLC
 * 创建时间：2018-03-26
 */
@Controller
@RequestMapping(value="/leave")
public class LeaveController extends BaseController {
	
	String menuUrl = "leave/list.do"; //菜单地址(权限用)
	@Resource(name="leaveService")
	private LeaveManager leaveService;
	@Resource(name="webusersService")
	private WebUsersManager webusersService;
	@Resource(name="schoolsubjectService")
	private SchoolSubjectManager schoolSubjectService;
	@Resource(name="userService")
	private UserManager userService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public Object save() throws Exception{
		//需要添加获取users_id
		
		int result = 0;
		PageData pd = new PageData();
		pd = this.getPageData();
		
		//获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		
		//虚拟的users_id,需要删掉
		pd.put("USER_ID","f0115a0b74b44d2ca81c7332d7802e39");
		pd.put("CREATEBY", userService.findById(pd).getString("NAME"));
		pd.put("CREATEDATE", df.format(new Date()));
		String[] LESSONS_IDs = pd.getString("LESSONS").split(",");
		for (int i = 0; i < LESSONS_IDs.length; i++) {
			pd.put("LESSONS_ID", LESSONS_IDs[i]);
			pd.put("LEAVE_ID", this.get32UUID());	//主键
			result = leaveService.save(pd);
		}
		Gson gson = new Gson();
		return gson.toJson(result);
	}
	
	/**删除学生某一时间的所有记录
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Object delete() throws Exception{
		
		PageData pd = new PageData();
		pd = this.getPageData();
		int res = leaveService.delete(pd);
		return res;
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		leaveService.edit(pd);
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
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = leaveService.list(page);	//列出Leave列表
		mv.setViewName("school/leave/leave_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**学生请假总览列表json
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/listAll")
	@ResponseBody
	public PageData listAll() throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		
		pd.put("USER_ID", "f0115a0b74b44d2ca81c7332d7802e39");
		
		//获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		pd.put("NOW", df.format(new Date()));
		
		List<PageData>	varList = leaveService.listAll(pd);	//列出Leave列表
		
		PageData pdInfo = new PageData();
		pdInfo.put("varList", varList);
		
		return pdInfo;
	}
	
	/**学生请假具体信息列表json
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/listStudent")
	@ResponseBody
	public Object listByStudent() throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		
		pd.put("USER_ID", "f0115a0b74b44d2ca81c7332d7802e39");
		
		List<PageData>	stuList = leaveService.selByIdTime(pd);	//列出Leave列表
		
		PageData pdInfo = new PageData();
		pdInfo.put("stuList", stuList);
		
		return pdInfo;
	}
	
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	@ResponseBody
	public PageData goAdd()throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		
		HttpSession session = this.getRequest().getSession();
		
//		前台获取users_id需要添加
		
//		后期删除
		pd.put("USER_ID","f0115a0b74b44d2ca81c7332d7802e39");
		List<PageData> stus = leaveService.findByUserId(pd);
		PageData pds = new PageData();
		pds.put("stus", stus);
		
		return pds;
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
		pd = leaveService.findById(pd);	//根据ID读取
		mv.setViewName("school/leave/leave_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面json
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/goEditJson")
		@ResponseBody
		public Object goEditJson()throws Exception{
			
			PageData pd = new PageData();
			pd = this.getPageData();
			pd = leaveService.findById(pd);	//根据ID读取
			
			return pd;
		}	
		
		/**获取科目信息
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/getSubject")
		@ResponseBody
		public Object getSubject()throws Exception{
			
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("USER_ID", "f0115a0b74b44d2ca81c7332d7802e39");
			
			//获取当前时间
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			int res = 0;
			
			List<PageData> subs = leaveService.findByTimeAndId(pd);
			List<PageData> leavestus = leaveService.selByIdTime(pd);
			List<PageData> lessons = new ArrayList<PageData>();
			for (PageData pdsub : subs) {
				for (PageData pdleave : leavestus) {
					if(pdsub.get("subject_name").equals(pdleave.get("subject_name")) && 
							df.format((Date)pdsub.get("lesson_starttime")).equals(df.format((Date)pdleave.get("lesson_starttime")))){
						res++;
						break;
					}                                       
				}
				if(res > 0){
					res--;
					continue;
				}else{
					lessons.add(pdsub);
				}
			}
			Gson gson = new GsonBuilder().setDateFormat("HH:mm:ss").create();
			return gson.toJson(lessons);
		}	
		
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		int res = leaveService.deleteAll(pd);
		return res;
	}
	
	/**
	 * 批量添加请假
	 */
	@RequestMapping("/addLeaveAll")
	@ResponseBody
	public Object addLeaveAll() throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		String DATA_IDS = pd.getString("DATA_IDS");
		String str = pd.getString("model");
		System.out.println("str:" + str);
		PageData pd2 = JSON.parseObject(str, new TypeReference<PageData>() {
		});
		
		List<PageData> list = (List<PageData>) pd2.get("leaves");
		
		for (int i = 0; i < list.size(); i++) {
			JSONObject jo2 = new JSONObject(list.get(i));
			System.out.println(jo2.get("lessons_id") + "--" + jo2.get("student_id") + "--" + jo2.get("leavecause")+ "--" + jo2.get("leavedate"));
			PageData pd3 = new PageData();
			pd3.put("leave_id", this.get32UUID()); // 主键
			pd3.put("lessons_id", jo2.get("lessons_id")); 
			pd3.put("student_id", jo2.get("student_id")); 
			pd3.put("leavecause", jo2.get("leavecause")); 
			pd3.put("leavedate", jo2.get("leavedate"));
			leaveService.saveAllLeave(pd3);
		}
		return "success";
	}
	
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
