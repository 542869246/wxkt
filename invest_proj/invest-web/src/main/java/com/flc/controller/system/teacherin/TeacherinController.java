package com.flc.controller.system.teacherin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.service.school.courses_subject.Courses_subjectManager;
import com.flc.service.school.courses_teacher.Courses_teacherManager;
import com.flc.service.school.schoolarrange.SchoolArrangeManager;
import com.flc.service.school.schoolcourse.SchoolCourseManager;
import com.flc.service.school.schoolref.SchoolRefManager;
import com.flc.service.school.schoolsubject.SchoolSubjectManager;
import com.flc.service.school.shcoolschedule.ShcoolScheduleManager;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.system.leave.LeaveManager;
import com.flc.service.system.user.UserManager;
import com.flc.service.web.webschedule.WebScheduleManager;
import com.flc.service.web.webstudent.WebStudentManager;
import com.flc.service.web.webusers.WebUsersManager;
import com.flc.util.PageData;
import com.weixin.util.StringUtil;

/**
 * 教师入口
 * 
 * @author 于江东 修改日期：2017/12/26
 */

@Controller
@RequestMapping(value = "/teacherin")
public class TeacherinController extends BaseController {
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
	@Resource(name="leaveService")
	private LeaveManager leaveService;//请假表
	@Resource(name = "shcoolscheduleService")
	private ShcoolScheduleManager shcoolScheduleService;// 课表
	/**
	 * 访问
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/tologin")
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
			mv.addObject("teainfo",teainfo);
			mv.setViewName("system/teacherin/teacherin");

			return mv;
		}
		return mv;
	}

	@RequestMapping(value = "/addsatas")
	@ResponseBody
	public Object addStats() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		/*pd.put("student_id", pd.getString("student_id"));
		
		
		System.out.println(pd.getString("student_id"));
		List<PageData> courses=webScheduleService.CoursekelistPage(pd);*/
		
		//pd.put("USER_ID", "f0115a0b74b44d2ca81c7332d7802e39");
		PageData teainfo = userService.findById(pd);
		
	
		/* session.setAttribute("loginteacher", teainfo); */
		List<PageData> teachCourseList = shcoolScheduleService.findByTeachAndDate(teainfo);
		List<PageData> courses =shcoolScheduleService.findByTeachAndDateTset(teainfo);
	
		PageData pd2 = new PageData();
		List<Dictionaries> schList = dictionariesService.listSubDictByParentId("de839d04c7bf4694934e68a94da6b602");
		pd2.put("teachCourseList", teachCourseList);
		pd2.put("schList", schList);
		pd2.put("courses", courses);

		return pd2;

	}
	
	
	
	@RequestMapping(value = "/subjectlist")
	@ResponseBody
	public Object subjectlist() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		List<PageData> subjest= webScheduleService.subjectlist(pd);
		System.out.println(subjest);
		return subjest;

	}

	@RequestMapping(value = "/editsatas")
	@ResponseBody
	public Object editStats() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		Object count=webScheduleService.edit(pd);
		System.out.println(count);
		return count;

	}

	@RequestMapping(value = "/toindex")
	public String toindex() throws Exception {
		// PageData seachMemberPd = new PageData();
		/*
		 * seachMemberPd.put("OPEN_ID", "ooxeC0-SHdQ8d_GSJML2ASv-Ule0");
		 * HttpSession session = this.getRequest().getSession();
		 * session.setAttribute("loginuser", seachMemberPd);
		 */
		return "system/teacherin/toIndex";
	}

	
	
	/*
	 * 通过教师选择的课程时间来动态的获取学生
	 */
	@ResponseBody
	@RequestMapping(value = "/getStudents")
	public Object getStudents() throws Exception {
		PageData pd = this.getPageData();
		List<PageData> stuids = schoolArrangeService.findByCourseid(pd);
		return stuids;
	}

	/*
	 * 获得列表消息数量
	 */
	@ResponseBody
	@RequestMapping(value = "/getListNum")
	public Object getListNum() throws Exception {
		PageData pd = this.getPageData();
		
		PageData result = new PageData();
		
		
		pd.put("user_id", "f0115a0b74b44d2ca81c7332d7802e39");
		List<PageData>	numList = webScheduleService.getListNum(pd);	//列出Leave列表

		result.put("numList", numList);
		
		return result;
	}
	// private Boolean testIfHasCourse(String courseid,String teacherid,Date
	// date){
	//
	// return false;
	// }

	@ResponseBody
	@RequestMapping(value = "/getreg")
	public PageData reg() {
		PageData pd = this.getPageData();
		PageData result = new PageData();
		String SCHEDULE_INPUTTIME = (String) pd.get("SCHEDULE_INPUTTIME");// 录入时间
		String ARRIVELEAVETIME = (String) pd.get("ARRIVELEAVETIME");// 到达时间
		String SUBJECT_ID = pd.getString("SUBJECT_ID");
		if (StringUtil.isEmpty(ARRIVELEAVETIME)) {
			ARRIVELEAVETIME = null;
		}
		String SCHEDULE_TASKTYPE = (String) pd.get("SCHEDULE_TASKTYPE");// 关联类型维护表
																		// 如：作业录入
																		// 作业验收
		String SCHEDULE_ADOPT = (String) pd.get("SCHEDULE_ADOPT");// 是否达标
		if (StringUtil.isEmpty(SCHEDULE_ADOPT)) {
			SCHEDULE_ADOPT = null;
		}
		String COURSES_ID = (String) pd.get("COURSES_ID");// 课程id
		String SCHEDULE_TIMEDIFF = (String) pd.get("SCHEDULE_TIMEDIFF");// 如果在校学习可以填时间：比如5分钟、、、、
																		// 如果在家学习可以填写（家）如果在校学习可以填时间：比如5分钟、、、、如果在家学习可以填写（家）
		String SCHEDULE_CONTENT = (String) pd.get("SCHEDULE_CONTENT");// 学习内容

		String STATE = pd.getString("STATE");
		String LESSON_ID=pd.getString("LESSONS_ID");
		
		PageData cousersubject = new PageData();
		cousersubject.put("COURSES_ID", COURSES_ID);
		try {
			cousersubject = schoolCourseService.findById(pd);
		} catch (Exception e1) {
			result.put("msg", "error");
			return result;
		}

		String stus = (String) pd.get("stus");
		String stuids[] = stus.split("\\|");
		List<PageData> schedules = new ArrayList<PageData>();
		for (int i = 0; i < stuids.length; i++) {
			PageData schedule = new PageData();
			schedule.put("SCHEDULE_ID", this.get32UUID());// 日程id
			schedule.put("STUDENT_ID", stuids[i]);// 学生id
			schedule.put("SCHEDULE_TASKTYPE", SCHEDULE_TASKTYPE);// 选择类型
			schedule.put("SCHEDULE_INPUTTIME", SCHEDULE_INPUTTIME);// SCHEDULE_INPUTTIME是SCHEDULE_DATETIME的值
			schedule.put("SCHEDULE_DATETIME", new Date());// 录入时间
			schedule.put("SUBJECT_ID", cousersubject.get("SUBJECT_ID"));// 添加科目id
			schedule.put("SCHEDULE_TIMEDIFF", SCHEDULE_TIMEDIFF);// 如果在校学习可以填时间：比如5分钟、、、、
																	// 如果在家学习可以填写（家）如果在校学习可以填时间：比如5分钟、、、、如果在家学习可以填写（家）
			schedule.put("ARRIVELEAVETIME", ARRIVELEAVETIME);// 到达时间
			schedule.put("SCHEDULE_CONTENT", SCHEDULE_CONTENT);// 学习内容
			schedule.put("SCHEDULE_ADOPT", SCHEDULE_ADOPT);// 是否达标
			schedule.put("SUBJECT_ID", SUBJECT_ID);
			schedule.put("CREATEBY", 1);
			schedule.put("COURSES_ID", COURSES_ID);
			schedule.put("CREATEDATE", new Date());
			schedule.put("STATE", STATE);
			schedule.put("LESSON_ID", LESSON_ID);
			try {
				
				webScheduleService.save(schedule);
			} catch (Exception e) {
				
				result.put("msg", "error");
				return result;
			}
			schedules.add(schedule);
		}

		/*
		 * for (int i = 0; i < schedules.size(); i++) { PageData study = new
		 * PageData(); study.put("STUDY_ID", this.get32UUID());
		 * //study.put("SCHEDULE_ID",schedules.get(i).get("SCHEDULE_ID"));
		 * //study.put("SUBJECT_ID",cousersubject.get("SUBJECT_ID") );
		 * //study.put("SCHEDULE_TIMEDIFF",SCHEDULE_TIMEDIFF );
		 * //study.put("SCHEDULE_CONTENT",SCHEDULE_CONTENT );
		 * //study.put("SCHEDULE_ADOPT",SCHEDULE_ADOPT ); study.put("CREATEBY",
		 * CREATEBY); study.put("CREATEDATE", new Date()); try {
		 * webStudyService.save(study); } catch (Exception e) {
		 * result.put("msg", "error"); return result; } }
		 */
		result.put("msg", "ok");
		return result;
	}

	/**
	 * ajax判断
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/stats")
	@ResponseBody
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
	@RequestMapping(value = "/addsub")
	@ResponseBody
	public Object addsub(Page page) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> teachCourseList = shcoolScheduleService.findByTeachAndDate(pd);

		return teachCourseList;

	}
	
	
	
	@RequestMapping(value="/listAll")
	@ResponseBody
	public Object listAll() throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		
		List<PageData>	varList = webScheduleService.findStats(pd);	//列出Leave列表
		return varList;
	}
	
	@RequestMapping(value="/findmydaily")
	@ResponseBody
	public Object findmydaily() throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		
		List<PageData>	varList = webScheduleService.findMydaily(pd);	//列出Leave列表
		return varList;
	}
	
	

	/**
	 * 根据openId获取判断用户是否是教师
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findTeacherOpenId")
	@ResponseBody
	public PageData findTeacherOpenId(HttpServletRequest request) throws Exception {
		PageData openID = (PageData) request.getSession().getAttribute("loginuser");
		PageData count = webUserService.findTeacherOpenId(openID);
		return count;
	}
	@RequestMapping(value = "/a")
	public Object a(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("system/teacherin/tea");
		return mv;
		
	}
}
