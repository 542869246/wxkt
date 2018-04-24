package com.flc.controller.system.teacherin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.entity.system.User;
import com.flc.service.school.courses_subject.Courses_subjectManager;
import com.flc.service.school.courses_teacher.Courses_teacherManager;
import com.flc.service.school.schoolarrange.SchoolArrangeManager;
import com.flc.service.school.schoolcourse.SchoolCourseManager;
import com.flc.service.school.schoolsubject.SchoolSubjectManager;
import com.flc.service.school.shcoolschedule.ShcoolScheduleManager;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.system.evaluate.EvaluateManager;
import com.flc.service.system.leave.LeaveManager;
import com.flc.service.system.user.UserManager;
import com.flc.service.web.webability.WebAbilityManager;
import com.flc.service.web.webschedule.WebScheduleManager;
import com.flc.service.web.webstudent.WebStudentManager;
import com.flc.service.web.webusers.WebUsersManager;
import com.flc.util.Const;
import com.flc.util.PageData;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

/**
 * 教师首页
 * 
 * @author 于江东 修改日期：2017/12/26
 */

@Api(value = "teacherHome", tags = "教师首页")
@Controller
@RequestMapping(value = "/teacherHome")
public class TeacherHomeController extends BaseController {
	@Autowired
	private WebUsersManager webUserService;
	@Autowired
	private UserManager userService;
	@Resource(name = "courses_teacherService")
	private Courses_teacherManager courses_teacherService;
	@Autowired
	private SchoolCourseManager schoolCourseService;
	@Autowired
	private SchoolArrangeManager schoolArrangeService;
	@Autowired
	private WebStudentManager webStudentService;
	@Resource
	private DictionariesManager dictionariesService;
	@Resource
	private WebScheduleManager webScheduleService;
	@Resource
	private Courses_subjectManager courses_subjectService;
	@Resource
	private SchoolSubjectManager SchoolSubjectService;
	@Autowired
	private WebUsersManager webUsers;// 家长表
	@Resource(name = "leaveService")
	private LeaveManager leaveService;// 请假表
	@Resource(name = "shcoolscheduleService")
	private ShcoolScheduleManager shcoolScheduleService;// 课表
	@Resource(name = "webabilityService")
	private WebAbilityManager webAbilityService;
	@Resource(name = "evaluateService")
	private EvaluateManager evaluateService;// 学生评价

	/**
	 * 访问
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/tologin")
	@ApiOperation(value = "访问", notes = "访问")
	public ModelAndView toLogin() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		HttpSession session = this.getRequest().getSession();
		// SNSUserInfo snsUserInfo
		// =(SNSUserInfo)session.getAttribute("snsUserInfo");
		PageData loginuser = (PageData) session.getAttribute("loginuser");
		// ===============
		PageData pd2 = new PageData();
		pd2.put("USERS_ID", "66cas171qw234e167c07bejf3g0cfbdv");
		loginuser = (PageData) webUsers.findById(pd2);
		// ===============

		if (loginuser != null) {
			pd.put("USERS_OPENID", loginuser.get("USERS_OPENID"));
			// pd.put("USERS_OPENID","ooxeC0-SHdQ8d_GSJML2ASv-Ule0");

			PageData teainfo = webUserService.findisTeacher(pd);
			if (null == teainfo || teainfo.get("USER_ID").equals("")) {
				mv.setViewName("redirect:/activity/goActivity");
				System.out.println("此处应该跳回");
				return mv;
			}
			List<PageData> teachCourseList = shcoolScheduleService.findByTeachAndDate(teainfo);
			mv.addObject("teainfo", teainfo);
			mv.addObject("teachCourseList", teachCourseList);
			mv.setViewName("system/teacherin/teacherHome");

			return mv;
		}
		return mv;
	}

	// 去上课内容
	@RequestMapping(value = "/gozylr")
	@ApiOperation(value = "去上课内容", notes = "去上课内容")
	public ModelAndView gozylr() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData pd2 = (PageData) shcoolScheduleService.findByIdMore(pd);
		pd.put("SCHEDULE_TASKTYPE", "zylr");
		pd.put("LESSON_ID", pd.get("LESSONS_ID"));
		ArrayList<PageData> list = (ArrayList<PageData>) webScheduleService.getListByTypeAndLes(pd);
		if (list.size() > 0) {
			String content = ((PageData) (list.get(0))).get("schedule_content").toString();
			mv.addObject("content", content);
		}

		mv.addObject("lesson", pd2);
		mv.setViewName("system/teacherin/zylr_add");
		return mv;
	}

	// 去课后小结
	@RequestMapping(value = "/gozyys")
	@ApiOperation(value = "去课后小结", notes = "去课后小结")
	public ModelAndView gozyys() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("SCHEDULE_TASKTYPE", pd.get("SCHEDULE_TASKTYPE"));
		PageData pd2 = (PageData) shcoolScheduleService.findByIdMore(pd);
		List<PageData> pd3 = schoolArrangeService.findByCourseid(pd);
		mv.addObject("course", pd3);
		mv.addObject("lesson", pd2);
		mv.setViewName("system/teacherin/zyys_add");
		return mv;
	}

	// 去学生评价列表
	@RequestMapping(value = "/goeval")
	@ApiOperation(value = "去学生评价列表", notes = "去学生评价列表")
	public ModelAndView goeval() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData pd2 = (PageData) shcoolScheduleService.findByIdMore(pd);
		// List<PageData> allList = schoolArrangeService.findByICourseid(pd);//
		// 这个lessons所有的学生

		mv.addObject("lesson", pd2);
		mv.setViewName("system/teacherin/eval_list");
		return mv;
	}

	// 添加&编辑学生评价
	@ApiOperation(value = "保存", notes = "保存")
	@RequestMapping(value = "/evaladd")
	@ResponseBody
	public Object goevaladd() throws Exception {
		PageData pd = this.getPageData();
		pd.put("EVALUATEDATE", new Date());
		// 添加&修改
		if (null != pd.getString("isAdd") && pd.getString("isAdd").equals("true")) {
			pd.put("EVALUATE_ID", this.get32UUID()); // 主键
			evaluateService.save(pd);
		} else {
			evaluateService.edit(pd);
		}
		return "";
	}

	// 去能力值
	@RequestMapping(value = "/goability")
	@ApiOperation(value = "去能力值", notes = "去能力值")
	public ModelAndView goability() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData pd2 = (PageData) shcoolScheduleService.findByIdMore(pd);
		List<PageData> pd3 = schoolArrangeService.findByCourseid(pd);
		List<Dictionaries> abilityList = dictionariesService.listSubDictByParentId("e6f62d095964410593593e58470ab234");
		mv.addObject("course", pd3);
		mv.addObject("lesson", pd2);
		mv.addObject("abilityList", abilityList);
		mv.setViewName("system/teacherin/ability_add");
		return mv;
	}

	// 去到达时间
	@RequestMapping(value = "/godzsj")
	@ApiOperation(value = "去到离时间", notes = "去到离时间")
	public ModelAndView godzsj() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String dlsj = (String) pd.get("dlsj");
		String schedule_tasktype;
		if (dlsj.equals("0")) {
			schedule_tasktype = "dzsj";
			pd.put("SCHEDULE_TASKTYPE", schedule_tasktype);
		} else {
			schedule_tasktype = "lksj";
			pd.put("SCHEDULE_TASKTYPE", schedule_tasktype);
		}
		PageData pd2 = (PageData) shcoolScheduleService.findByIdMore(pd);
		List<PageData> pd3 = schoolArrangeService.findByCourseid(pd);
		mv.addObject("course", pd3);
		mv.addObject("lesson", pd2);
		mv.addObject("dlsj", pd.get("dlsj"));
		mv.setViewName("system/teacherin/dzsj_add");
		return mv;
	}

	/*
	 * // 去离开时间
	 * 
	 * @RequestMapping(value = "/golksj") public ModelAndView golksj() throws
	 * Exception { ModelAndView mv = this.getModelAndView(); PageData pd =
	 * this.getPageData(); PageData pd2 = (PageData)
	 * shcoolScheduleService.findByIdMore(pd);
	 * 
	 * mv.addObject("lesson", pd2); mv.setViewName("system/teacherin/lksj_add");
	 * return mv; }
	 */

	// 去请假信息
	@RequestMapping(value = "/goleave")
	@ApiOperation(value = "去请假信息", notes = "去请假信息")
	public ModelAndView goleave() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData pd2 = (PageData) shcoolScheduleService.findByIdMore(pd);

		mv.addObject("lesson", pd2);

		mv.setViewName("system/teacherin/leave_info");
		return mv;
	}

	// 去添加请假信息
	@RequestMapping(value = "/goleaveadd")
	@ApiOperation(value = "去课后小结", notes = "去课后小结")
	public ModelAndView goleaveadd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("LESSONS_ID", pd.getString("lessons_id"));
		PageData pd2 = (PageData) shcoolScheduleService.findByIdMore(pd);
		mv.addObject("lesson", pd2);
		// List<PageData> varList = schoolArrangeService.lessonsNoLeaveList(pd);
		// // 这个lessons没请假的学生
		// mv.addObject("varList", varList);
		mv.setViewName("system/teacherin/leave_add");
		return mv;
	}

	/**
	 * 这个lessons的请假&没请假的学生
	 * 
	 * @param page
	 * @throws Exception
	 */
	@ApiOperation(value = "这个lessons的请假&没请假的学生", notes = "这个lessons的请假&没请假的学生")
	@ApiImplicitParams({
			@ApiImplicitParam(name = "lessons_id", value = "课表id", dataType = "string", paramType = "query",defaultValue="763ecba5c54e40e4a1fc7c553909ec3f"),
			@ApiImplicitParam(name = "COURSES_ID", value = "课程id", dataType = "string", paramType = "query",defaultValue="58cb571de21a41b6a3f71b7741910688") })
	@RequestMapping(value = "/listJSON")
	@ResponseBody
	public Object listJSON() throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COURSE_ID", pd.getString("COURSES_ID"));
		Page page = new Page();
		page.setPd(pd);
		List<PageData> varList = schoolArrangeService.lessonsNoLeaveList(pd); // 这个lessons没请假的学生
		List<PageData> leaveList = schoolArrangeService.leaveList(pd);// 这个lessons请假的学生
		List<PageData> allList = schoolArrangeService.findByICourseid(pd);// 这个lessons所有的学生
		List<PageData> allList2 = schoolArrangeService.findByICourseid2(pd);// 这个lessons所有的学生2.0
		List<PageData> evalList = schoolArrangeService.lessonsEvalList(pd);// 这个lessons已评价的学生
		PageData pd2 = new PageData();
		pd2.put("varList", varList);
		pd2.put("leaveList", leaveList);
		pd2.put("allList", allList);
		pd2.put("allList2", allList2);
		pd2.put("evalList", evalList);
		return pd2;
	}

	/**
	 * 批量添加请假
	 */
	@RequestMapping("/addLeaveAll")
	@ResponseBody
	@ApiOperation(value = "批量添加请假", notes = "批量添加请假")
	public Object addLeaveAll() throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		String str = pd.getString("model");
		System.out.println("str:" + str);
		PageData pd2 = JSON.parseObject(str, new TypeReference<PageData>() {
		});

		List<PageData> list = (List<PageData>) pd2.get("leaves");

		for (int i = 0; i < list.size(); i++) {
			JSONObject jo2 = new JSONObject(list.get(i));
			System.out.println(jo2.get("lessons_id") + "--" + jo2.get("student_id") + "--" + jo2.get("leavecause"));
			PageData pd3 = new PageData();
			pd3.put("leave_id", this.get32UUID()); // 主键
			pd3.put("lessons_id", jo2.get("lessons_id"));
			pd3.put("student_id", jo2.get("student_id"));
			pd3.put("leavecause", jo2.get("leavecause"));
			pd3.put("leavedate", new Date());
			schoolArrangeService.saveAllLeave(pd3);
		}

		return "success";
	}

	/**
	 * 批量添加&修改上课内容
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addAllzylr")
	@ResponseBody
	@ApiOperation(value = "批量添加&修改上课内容", notes = "批量添加&修改上课内容")
	public Object addAllzylr() throws Exception {
		// ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// 获取该课程所有学生
		pd.put("COURSES_ID", pd.getString("COURSE_ID"));
		pd.put("lessons_id", pd.getString("LESSON_ID"));
		List<PageData> students = schoolArrangeService.findByICourseid(pd);
		List<PageData> students2 = schoolArrangeService.lessonsNoLeaveList(pd); // 这个lessons没请假的学生
		User user = (User) this.getRequest().getSession().getAttribute(Const.SESSION_USER);

		pd.put("SCHEDULE_TASKTYPE", "zylr");
		Integer num = webScheduleService.getListByTypeAndLes(pd).size();
		if (num == students2.size()) {

			webScheduleService.editByTypeAndLes(pd);
		} else {
			for (PageData pageData : students2) {
				PageData ws = new PageData();
				ws.put("SCHEDULE_ID", this.get32UUID()); // 主键
				ws.put("SCHEDULE_INPUTTIME", new Date());
				ws.put("CREATEDATE", new Date());
				// ws.put("CREATEBY", user.getUSER_ID());
				ws.put("SCHEDULE_CONTENT", pd.get("schedule_content"));
				ws.put("SCHEDULE_TIMEDIFF", pd.get("minutes"));
				ws.put("STUDENT_ID", pageData.get("STUDENT_ID"));
				ws.put("SUBJECT_ID", pd.get("subject_id"));
				ws.put("SCHEDULE_TASKTYPE", "zylr");
				ws.put("SCHEDULE_DATETIME", new Date());
				ws.put("STATE", pd.getString("state"));
				ws.put("LESSON_ID", pd.get("LESSON_ID"));
				webScheduleService.save(ws);
			}
		}
		return "";
	}

	/**
	 * 批量添加课后总结 批量一次添加课后总结达标是默认达标
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addAllzyys")
	@ResponseBody
	@ApiOperation(value = "批量添加课后总结 批量一次添加课后总结达标是默认达标", notes = "批量添加课后总结 批量一次添加课后总结达标是默认达标")
	public Object addAllzyys() throws Exception {
		// ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// 获取该课程所有学生
		pd.put("COURSES_ID", pd.getString("COURSE_ID"));
		pd.put("lessons_id", pd.getString("LESSON_ID"));
		// 获取该课程所有学生
		List<PageData> students = schoolArrangeService.findByICourseid(pd);
		List<PageData> students2 = schoolArrangeService.lessonsNoLeaveList(pd); // 这个lessons没请假的学生
		for (PageData pageData : students2) {
			PageData ws = new PageData();
			ws.put("SCHEDULE_ID", this.get32UUID()); // 主键
			ws.put("SCHEDULE_INPUTTIME", new Date());
			ws.put("CREATEDATE", new Date());
			// ws.put("CREATEBY", user.getUSER_ID());
			ws.put("SCHEDULE_CONTENT", pd.get("schedule_content"));
			ws.put("SCHEDULE_TIMEDIFF", pd.get("minutes"));
			ws.put("STUDENT_ID", pageData.get("STUDENT_ID"));
			ws.put("SUBJECT_ID", pd.get("subject_id"));
			ws.put("SCHEDULE_ADOPT", "0");
			ws.put("SCHEDULE_TASKTYPE", "zyys");
			ws.put("SCHEDULE_DATETIME", new Date());
			ws.put("STATE", pd.getString("state"));
			ws.put("LESSON_ID", pd.get("LESSON_ID"));
			webScheduleService.save(ws);
		}

		// mv.setViewName("system/teacherin/zylr_add");
		return "";
	}

	/**
	 * 批量添加课后总结
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addPiAllzyys")
	@ResponseBody
	@ApiOperation(value = "批量添加课后总结", notes = "批量添加课后总结")
	public Object addPiAllzyys() throws Exception {
		// ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();

		String schedule_timediff = (String) pd.get("minutes");
		String state = pd.getString("state");
		String subject_id = (String) pd.get("subject_id");
		String schedule_tasktype = (String) pd.get("schedule_tasktype");
		String stus = (String) pd.get("stus");
		String stuids[] = stus.split("\\|");
		for (String string : stuids) {
			System.out.println(string);
		}
		String schedule_adopt = (String) pd.get("adopt");
		String adopt[] = schedule_adopt.split("\\|");
		for (int i = 0; i < adopt.length; i++) {
			System.out.println(adopt[i]);

		}
		List<PageData> schedules = new ArrayList<PageData>();
		for (int i = 0; i < stuids.length; i++) {
			PageData schedule = new PageData();
			schedule.put("SCHEDULE_ID", this.get32UUID());// 日程id
			schedule.put("SCHEDULE_INPUTTIME", new Date());
			schedule.put("CREATEDATE", new Date());
			schedule.put("STUDENT_ID", stuids[i]);// 学生id
			schedule.put("SCHEDULE_ADOPT", adopt[i]);
			schedule.put("SCHEDULE_TIMEDIFF", schedule_timediff);
			schedule.put("SUBJECT_ID", subject_id);
			schedule.put("SCHEDULE_TASKTYPE", schedule_tasktype);
			schedule.put("SCHEDULE_DATETIME", new Date());
			schedule.put("STATE", state);
			schedule.put("SCHEDULE_TASKTYPE", "zyys");
			schedule.put("LESSON_ID", pd.get("LESSON_ID"));

			try {

				webScheduleService.save(schedule);
			} catch (Exception e) {

				pd.put("msg", "error");
				return pd;
			}
			schedules.add(schedule);
		}
		return "";

	}

	/**
	 * 批量添加到离时间
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addPiAlldzsj")
	@ResponseBody
	@ApiOperation(value = "批量添加到离时间", notes = "批量添加到离时间")
	public Object addPiAlldzsj() throws Exception {
		// ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		/*
		 * // 获取该课程所有学生 List<PageData> students =
		 * schoolArrangeService.findByICourseid(pd);
		 */
		User user = (User) this.getRequest().getSession().getAttribute(Const.SESSION_USER);
		String schedule_timediff = (String) pd.get("minutes");
		String state = pd.getString("state");
		String subject_id = (String) pd.get("subject_id");
		String schedule_tasktype = (String) pd.get("schedule_tasktype");
		String stus = (String) pd.get("stus");
		String stuids[] = stus.split("\\|");

		String puttimes = (String) pd.get("time");
		String times[] = puttimes.split("\\|");
		String LESSON_ID = (String) pd.get("LESSON_ID");
		List<PageData> schedules = new ArrayList<PageData>();
		for (int i = 0; i < stuids.length; i++) {
			PageData schedule = new PageData();
			schedule.put("SCHEDULE_ID", this.get32UUID());// 日程id
			schedule.put("SCHEDULE_INPUTTIME", new Date());
			schedule.put("CREATEDATE", new Date());
			schedule.put("STUDENT_ID", stuids[i]);// 学生id
			schedule.put("ARRIVELEAVETIME", times[i]);
			schedule.put("SCHEDULE_TIMEDIFF", schedule_timediff);
			schedule.put("SUBJECT_ID", subject_id);
			schedule.put("SCHEDULE_TASKTYPE", schedule_tasktype);
			schedule.put("SCHEDULE_DATETIME", new Date());
			schedule.put("STATE", state);
			schedule.put("LESSON_ID", LESSON_ID);

			try {

				webScheduleService.save(schedule);
			} catch (Exception e) {

				pd.put("msg", "error");
				return pd;
			}
			schedules.add(schedule);
		}
		return "";
	}

	/**
	 * 批量一次添加到离时间默认当前时间
	 * 
	 * @return
	 * @throws Exception
	 */

	@RequestMapping(value = "/addAlldzjs")
	@ResponseBody
	@ApiOperation(value = "批量一次添加到离时间默认当前时间", notes = "批量一次添加到离时间默认当前时间")
	public Object addAlldzjs() throws Exception {
		// ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// 获取该课程所有学生
		List<PageData> students = schoolArrangeService.findByICourseid(pd);
		User user = (User) this.getRequest().getSession().getAttribute(Const.SESSION_USER);
		SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (PageData pageData : students) {
			PageData ws = new PageData();
			ws.put("SCHEDULE_ID", this.get32UUID()); // 主键
			ws.put("SCHEDULE_INPUTTIME", new Date());
			ws.put("CREATEDATE", new Date());
			// ws.put("CREATEBY", user.getUSER_ID());
			ws.put("SCHEDULE_CONTENT", pd.get("schedule_content"));
			ws.put("SCHEDULE_TIMEDIFF", pd.get("minutes"));
			ws.put("STUDENT_ID", pageData.get("STUDENT_ID"));
			ws.put("SUBJECT_ID", pd.get("subject_id"));
			ws.put("SCHEDULE_TASKTYPE", pd.get("schedule_tasktype"));
			ws.put("ARRIVELEAVETIME", sim.format(new Date()));
			ws.put("SCHEDULE_DATETIME", new Date());
			ws.put("STATE", pd.getString("state"));
			ws.put("LESSON_ID", pd.getString("LESSON_ID"));
			webScheduleService.save(ws);
		}

		// mv.setViewName("system/teacherin/zylr_add");
		return "";
	}

	/**
	 * 批量添加能力值
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addAllabillity")
	@ResponseBody
	@ApiOperation(value = "批量添加能力值", notes = "批量添加能力值")
	public Object addAllabillity() throws Exception {
		// ModelAndView mv = this.getModelAndView();

		PageData pd = this.getPageData();
		String arr_stu = (String) pd.get("arr_stu");
		String subject_id = (String) pd.get("subject_id");

		List<PageData> parseArray = JSON.parseArray(arr_stu, PageData.class);
		/*
		 * User user = (User)
		 * this.getRequest().getSession().getAttribute(Const.SESSION_USER);
		 */
		for (PageData p : parseArray) {
			String pjson = JSON.toJSONString(p);
			System.out.println("student_id:" + p.getString("student_id"));
			String id = p.getString("student_id");
			JSONObject parseObject = JSON.parseObject(pjson);
			System.out.println(parseObject);
			List<PageData> pd2 = JSON.parseArray(parseObject.getString("arr"), PageData.class);
			for (PageData pageData : pd2) {
				System.out.println("dics:" + pageData.getString("dics"));
				System.out.println("ji:" + pageData.getString("ji"));
				System.out.println("neng:" + pageData.getString("neng"));

				PageData ws = new PageData();
				ws.put("ABILITY_ID", this.get32UUID());
				ws.put("ABILITY_TYPE_ID", pageData.getString("dics"));
				ws.put("SCORE_VALUE", pageData.getString("ji"));
				ws.put("ABILITY_VALUE", pageData.getString("neng"));
				ws.put("STUDENT_ID", id);
				ws.put("SUBJECT_ID", subject_id);
				ws.put("COURSE_TIME", new Date());
				ws.put("COURSE_CONTENT", "zyys");

				webAbilityService.save(ws);
			}

		}
		// 获取该课程所有学生
		/*
		 * List<PageData> students = schoolArrangeService.findByICourseid(pd);
		 */

		/*
		 * for (PageData pageData : students) { PageData ws = new PageData();
		 * ws.put("SCHEDULE_ID", this.get32UUID()); // 主键
		 * ws.put("SCHEDULE_INPUTTIME", new Date()); ws.put("CREATEDATE", new
		 * Date()); // ws.put("CREATEBY", user.getUSER_ID());
		 * ws.put("SCHEDULE_CONTENT", pd.get("schedule_content"));
		 * ws.put("SCHEDULE_TIMEDIFF", pd.get("minutes")); ws.put("STUDENT_ID",
		 * pageData.get("STUDENT_ID")); ws.put("SUBJECT_ID",
		 * pd.get("subject_id")); ws.put("SCHEDULE_TASKTYPE", "zylr");
		 * ws.put("SCHEDULE_DATETIME", new Date()); ws.put("STATE",
		 * pd.getString("state")); webScheduleService.save(ws); }
		 */

		// mv.setViewName("system/teacherin/zylr_add");
		return "";
	}

	/**
	 * ajax判断课程状态
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/stats")
	@ResponseBody
	@ApiOperation(value = "ajax判断课程状态", notes = "ajax判断课程状态")
	public int stats(Page page) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		if (pd.getString("COURSES_ID") != null && !"".equals(pd.getString("COURSES_ID"))) {
			pd.put("COURSES_ID", pd.getString("COURSES_ID"));

		}
		PageData COURSES = courses_teacherService.findByName(pd);
		if (COURSES != null && !"".equals(COURSES)) {
			return 1;
		}

		return 0;

	}

	/*
	 * 获得列表消息数量
	 */
	@ResponseBody
	@RequestMapping(value = "/getListNumAll")
	@ApiOperation(value = "获得列表消息数量", notes = "获得列表消息数量")
	public Object getListNumAll() throws Exception {
		PageData pd = this.getPageData();

		PageData result = new PageData();

		pd.put("user_id", "f0115a0b74b44d2ca81c7332d7802e39");

		List<PageData> numList = webScheduleService.getListNumAll(pd); // 列出Leave列表

		result.put("numList", numList);

		return result;
	}

}
