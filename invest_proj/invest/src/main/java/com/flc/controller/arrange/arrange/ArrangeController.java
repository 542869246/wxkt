package com.flc.controller.arrange.arrange;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.support.json.JSONUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.fasterxml.jackson.annotation.JacksonInject;
import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.util.AppUtil;
import com.flc.util.JsonUtils;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;
import com.flc.util.Jurisdiction;
import com.flc.util.Tools;
import com.flc.service.arrange.arrange.ArrangeManager;

/**
 * 说明：课程安排表 创建人：FLC 创建时间：2017-12-02
 */
@Controller
@RequestMapping(value = "/arrange")
public class ArrangeController extends BaseController {

	String menuUrl = "arrange/list.do"; // 菜单地址(权限用)
	@Resource(name = "arrangeService")
	private ArrangeManager arrangeService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增Arrange");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ARRANGE_ID", this.get32UUID()); // 主键
		arrangeService.save(pd);
		mv.addObject("pd", pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "删除Arrange");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		arrangeService.delete(pd);
		out.write("success");
		out.close();
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改Arrange");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		arrangeService.edit(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表Arrange");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords);
		}
		page.setPd(pd);
		List<PageData> varList = arrangeService.list(page); // 列出Arrange列表
		mv.setViewName("arrange/arrange/arrange_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/listJSON")
	@ResponseBody
	public Object listJSON() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表ArrangeJSON");
		PageData pd = new PageData();
		pd = this.getPageData();
		Page page = new Page();
		page.setPd(pd);
		List<PageData> varList = arrangeService.list(page); // 列出Arrange列表
		List<PageData> leaveList = arrangeService.leaveList(pd);
		PageData pd2 = new PageData();
		pd2.put("varList", varList);
		pd2.put("leaveList", leaveList);
		return pd2;
	}

	/**
	 * 这个lessons没请假的学生
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/lessonsNoLeaveList")
	@ResponseBody
	public Object lessonsNoLeaveList() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表ArrangeJSON");
		PageData pd = new PageData();
		pd = this.getPageData();
		Page page = new Page();
		page.setPd(pd);
		// List<PageData> varList = arrangeService.list(page); //列出Arrange列表
		List<PageData> leaveList = arrangeService.lessonsNoLeaveList(pd);
		PageData pd2 = new PageData();
		// pd2.put("varList", varList);
		pd2.put("leaveList", leaveList);
		return pd2;
	}

	/**
	 * 去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("arrange/arrange/arrange_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 去修改页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = arrangeService.findById(pd); // 根据ID读取
		mv.setViewName("arrange/arrange/arrange_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	@RequestMapping("/findStudentByArrangeId")
	@ResponseBody
	public Object findStudentByArrangeId() throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		String DATA_IDS = pd.getString("DATA_IDS");
		String ArrayDATA_IDS[] = DATA_IDS.split(",");
		List<String> stus = arrangeService.findStudentByArrangeId(ArrayDATA_IDS);
		return stus;
	}

	/**
	 * 批量添加
	 */
	@RequestMapping("/addall")
	@ResponseBody
	public Object addall() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "批量添加Courses_teacher");
		PageData pd = new PageData();
		pd = this.getPageData();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			if (pd.getString("COURSE_ID") != null && !"".equals(pd.getString("COURSE_ID"))) {
				for (String s : ArrayDATA_IDS) {
					pd.put("STUDENT_ID", s);
					pd.put("ARRANGE_ID", this.get32UUID()); // 主键
					arrangeService.save(pd);
				}
			} else if (pd.getString("STUDENT_ID") != null && !"".equals(pd.getString("STUDENT_ID"))) {
				for (String s : ArrayDATA_IDS) {
					pd.put("COURSE_ID", s);
					pd.put("ARRANGE_ID", this.get32UUID()); // 主键
					arrangeService.save(pd);
				}
			}
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		return pd;
	}

	/**
	 * 批量添加请假
	 */
	@RequestMapping("/addLeaveAll")
	@ResponseBody
	public Object addLeaveAll() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "批量添加school_leave");
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
			arrangeService.saveAllLeave(pd3);
		}

		return "success";
	}

	/**
	 * 批量删除
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "批量删除Arrange");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		} // 校验权限
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			arrangeService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 导出到excel
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出Arrange到excel");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("主键"); // 1
		titles.add("课程id"); // 2
		titles.add("学生id"); // 3
		titles.add("课程名"); // 4
		titles.add("创建人"); // 5
		titles.add("创建时间"); // 6
		titles.add("修改人"); // 7
		titles.add("修改时间"); // 8
		dataMap.put("titles", titles);
		List<PageData> varOList = arrangeService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("ARRANGE_ID")); // 1
			vpd.put("var2", varOList.get(i).getString("COURSE_ID")); // 2
			vpd.put("var3", varOList.get(i).getString("STUDENT_ID")); // 3
			vpd.put("var4", varOList.get(i).getString("ARRANGE_NAME")); // 4
			vpd.put("var5", varOList.get(i).getString("CREATEBY")); // 5
			vpd.put("var6", varOList.get(i).getString("CREATEDATE")); // 6
			vpd.put("var7", varOList.get(i).getString("MODIFYBY")); // 7
			vpd.put("var8", varOList.get(i).getString("MODIFYDATE")); // 8
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv, dataMap);
		return mv;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
