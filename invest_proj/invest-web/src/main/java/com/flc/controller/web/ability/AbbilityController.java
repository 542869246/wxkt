package com.flc.controller.web.ability;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flc.controller.base.BaseController;
import com.flc.service.school.shcoolschedule.ShcoolScheduleManager;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.web.webability.WebAbilityManager;
import com.flc.service.web.webstudent.WebStudentManager;
import com.flc.util.PageData;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/** 
 * 说明：学生能力积分值
 * 创建人：wbc
 * 创建时间：2017-12-01
 */
@Controller
@RequestMapping(value="/ability")
public class AbbilityController extends BaseController {

	@Resource(name="shcoolscheduleService")
	private ShcoolScheduleManager schoolScheduleService;
	@Resource(name="webstudentService")
	private WebStudentManager webStudentService;
	@Resource(name="webabilityService")
	private WebAbilityManager webAbilityService;
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	
	/**根据老师id和时间查询当日课程
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/listSchedule")
	@ResponseBody
	public Object listSchedule()throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USER_ID", "f0115a0b74b44d2ca81c7332d7802e39");
		
		//获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		pd.put("TODAY", df.format(new Date()));
		
		List<PageData> lessons = schoolScheduleService.findByUserIdAndTime(pd);
		
		Gson gson = new GsonBuilder().setDateFormat("HH:mm:ss").create();
		
		return gson.toJson(lessons);
	}
	
	/**根据科目id和老师id、上课时间获取学生信息
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/listStudent")
	@ResponseBody
	public Object listStudent()throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USER_ID", "f0115a0b74b44d2ca81c7332d7802e39");
		
		//获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		pd.put("TODAY", df.format(new Date())+" "+pd.get("START_TIME"));
		
		List<PageData> students = webStudentService.findBySubAndUser(pd);
		
		Gson gson = new GsonBuilder().setDateFormat("HH:mm:ss").create();
		
		return gson.toJson(students);
	}
	
	/**根据学生id，课程id和时间段查询能力值列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/findAbility")
	@ResponseBody
	public Object findAbility()throws Exception{
		
		PageData pd = new PageData();
		pd = this.getPageData();
		
		//获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		pd.put("COURSE_TIME", df.format(new Date()));
		
		List<PageData> abilitys = webAbilityService.findByIdAndTime(pd);
		
		Gson gson = new GsonBuilder().setDateFormat("HH:mm:ss").create();
		
		pd.put("abilitys", abilitys);
		
		return gson.toJson(pd);
	}
	
	/** 保存能力值信息
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public Object save()throws Exception{
		
		PageData pd = new PageData();
		pd = this.getPageData();
		
		//获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//		pd.put("COURSE_TIME", df.format(new Date())+" "+pd.get("COURSE_TIME"));
		
		
		pd.put("CREATEBY", "f0115a0b74b44d2ca81c7332d7802e39");
		pd.put("CREATEDATE", df.format(new Date()));
		pd.put("COURSE_TIME", df.format(new Date()));
		
		
		Object[] ABILITY_VALUES = pd.getString("ABILITY_VALUE").split(",");
		Object[] SCORE_VALUES = pd.getString("SCORE_VALUE").split(",");
		Object[] ABILITY_TYPE_ID = pd.getString("TYPEID").split(",");
		
		int res = 0;
		for (int i = 0; i < SCORE_VALUES.length; i++) {
			pd.put("ABILITY_VALUE", ABILITY_VALUES[i]);
			pd.put("SCORE_VALUE", SCORE_VALUES[i]);
			pd.put("ABILITY_TYPE_ID", ABILITY_TYPE_ID[i]);
			pd.put("ABILITY_ID", this.get32UUID());
			
			res = webAbilityService.save(pd);
		}
		
		Gson gson = new Gson();
		
		return gson.toJson(res);
	}
	
	/** 能力值部分修改
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/editvalue")
	@ResponseBody
	public Object editvalue()throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		
		//获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		pd.put("MODIFYDATE", df.format(new Date()));
		pd.put("MODIFYBY", "f0115a0b74b44d2ca81c7332d7802e39");
		int res  = webAbilityService.editvalue(pd);
		
		Gson gson = new Gson();
		
		return gson.toJson(res);
	}
	
	/**根据科目id和老师id、上课时间获取未添加能力值学生信息
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/unValueStudent")
	@ResponseBody
	public Object UnValueStudent()throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USER_ID", "f0115a0b74b44d2ca81c7332d7802e39");
		
		//获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		pd.put("TODAY", df.format(new Date()));
		pd.put("START_TIME", pd.get("TODAY")+" "+pd.get("START_TIME"));
		
		List<PageData> students = webStudentService.findUnValue(pd);
		
		Gson gson = new GsonBuilder().setDateFormat("HH:mm:ss").create();
		
		return gson.toJson(students);
	}
	
	/**根据ability_id查找详细信息
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/findById")
	@ResponseBody
	public Object findById()throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		
		PageData ability = webAbilityService.findById(pd);
		
		return ability;
	}
}
