package com.flc.controller.school.schoolcourse;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flc.controller.base.BaseController;
import com.flc.service.school.schoolsubject.SchoolSubjectManager;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.system.user.UserManager;
import com.flc.service.web.webability.WebAbilityManager;
import com.flc.service.web.webschedule.WebScheduleManager;
import com.flc.service.web.webscore.WebScoreManager;
import com.flc.service.web.webstudent.WebStudentManager;
import com.flc.service.web.webstudy.WebStudyManager;
import com.flc.service.web.webstuwebuser.WebStuWebuserManager;
import com.flc.service.web.webusers.WebUsersManager;
import com.flc.util.PageData;

/** 
 * 说明：今日课程
 * 创建人：FLC
 * 创建时间：2017-12-03
 */
@Controller
@RequestMapping(value="/schoolcourse")
public class SchoolCourseController extends BaseController {
	@Autowired
	private WebScheduleManager webSchedule;//用户日程表
	@Autowired	
	private WebStuWebuserManager webStuUser;//用户和学生关联表
	@Autowired
	private WebStudentManager webStudent;//学生
	@Resource
	private WebAbilityManager webAbilityManager;//能力表
	@Resource
	private WebScoreManager webScoreManager;//积分兑换表
	@Resource
	private WebUsersManager webUsers;
	@Autowired
	private DictionariesManager dictionariesManager;//类型维护
	@Autowired
	private SchoolSubjectManager schoolSubjectManager;//查询科目信息
	@Autowired
	private UserManager wm;//老师（后台用户）
	@RequestMapping("/goDaily")
	@ResponseBody
	public List<PageData>  Daily(HttpServletRequest request,HttpServletResponse response) throws Exception{
		List<PageData> pdList=new ArrayList<PageData>();
		PageData pd=new PageData();
		pd=this.getPageData();
		PageData web_users = (PageData) request.getSession().getAttribute("loginuser");//获取登录用户(家长)默认学生Id
		PageData error=new PageData();
		if (web_users == null || "".equals(web_users)) {
			error.put("state", 1);
			pdList.add(error);
			return pdList;
		}
		String studentId=web_users.getString("STUDENT_ID");//根据用户获取默认学生
		if (studentId == null || "".equals(studentId)) {//判断是否有默认学生，如果没有默认学生则遍历关系表
				List<PageData> page = webStuUser.findListByUsersId(web_users);//获取学生集合
				if (page.size()==0) {
					error.put("message","请联系老师，让其给您的孩子添加您的信息");
					error.put("state", 1);
					pdList.add(error);
					return pdList;
				}
					PageData student=webStudent.findByIdOrderTime(page);//如果有多个学生则根据学生创建时间获取最新的学生，返回一条数据
					studentId=student.getString("STUDENT_ID");
				web_users.put("STUDENT_ID", studentId);
		}
		//pd.put("CREATEDATE", "2017-12-07");//测试日期
		if (pd.getString("SCHEDULE_DATETIME") == null || "".equals(pd.getString("SCHEDULE_DATETIME"))) {//如果获取的时间是空
			pd.put("SCHEDULE_DATETIME", new Date());//则把当前时间赋值给他
		}
		pd.put("STUDENT_ID", studentId);
		pd.put("ISLOOK", 1);
		webSchedule.editByISLook(pd);
		PageData student=webStudent.findById(pd);
		student.put("type", "student");
		 pdList = webSchedule.findByStudentList(pd);//查询学生所有日程
		 if (pdList.size()==0) {
				error.put("message","您的孩子，当天没有学习日程");
				error.put("state", 1);
				pdList.add(error);
				return pdList;
		}
		 
		//根据日程查询科目信息反馈表   
		for (PageData item : pdList) {
			PageData typePd=new PageData();
			typePd.put("BIANMA", item.get("SCHEDULE_TASKTYPE"));//根据类型id获取DICTIONARIES_ID
			typePd.put("DICTIONARIES_ID",item.get("SCHEDULE_TASKTYPE"));
			PageData dictionarpd=null;
			dictionarpd=dictionariesManager.findByDictId(typePd);
			if(dictionarpd==null){
				dictionarpd = dictionariesManager.findByBianmaId(typePd);	
			}else{
				item.put("SCHEDULE_TASKTYPE", dictionarpd.getString("BIANMA"));
				webSchedule.edit(item);
			}
			if(dictionarpd!=null){
				item.put("dictionarpd",dictionarpd);//获取类型
			}
			//List<PageData> studyList=webStudy.findListByScheduleIdAndCourseName(item);//获取科目反馈表和科目
			//item.put("study", studyList);//加入科目反馈表集合
			PageData subject=schoolSubjectManager.findById(item);
			if(subject!=null){
				item.put("SUBJECTNAME", subject.get("SUBJECT_NAME"));
			}
			pd.put("USER_ID", item.get("CREATEBY"));//根据创建人返回老师id
			PageData user = wm.findById(pd);
			item.put("sys_users_name", user==null?"":user.get("NAME"));//加入老师
		}
	pdList.add(student);
	return pdList;
	}
	
	    @Value("${uploadfPath}")
	    private String uploadfPath;
	    /**
	     * 获取我的积分
	     * @param request
	     * @return
	     * @throws Exception
	     */
		@RequestMapping(value="/integral")
		@ResponseBody
		public PageData integral(HttpServletRequest request) throws Exception{
			PageData pd=this.getPageData();
			//获取页面传过来的页面数
			int nextPage=Integer.parseInt(pd.getString("next"));
			//获取用户
			PageData loginUser = (PageData) request.getSession().getAttribute("loginuser");
			//pd.put("USERS_ID","8ca7b86e12404f5ab4a0f67dffd6c9e5");//测试数据
			//PageData loginUser = webUsers.findById(pd);
			if(loginUser==null||loginUser.equals("")){
				pd.put("prompt","您还没有孩子报名我们学鹿教育");
				pd.put("stateCode","100");
				return pd;
			}
			//获取家长表的默认学生id
			String stuid = loginUser.getString("STUDENT_ID");
			//如果有默认学生
			if(stuid!=null){
			    //获取学生
				pd=loginUser;
			}
			//没有默认学生
			else{
				//查询关联表获取学生集合
				List<PageData> stuList = webStuUser.findListByUsersId(loginUser);
				if(stuList.size()==0){
					pd.put("mes","请联系老师，让其给您的孩子添加您的信息");
					pd.put("state", 1);
				    return pd;	
				}
				//如果有多个学生则通过学生创建时间获取最新的学生
				pd = webStudent.findByIdOrderTime(stuList);
				
			}
			pd.put("uploadfPath", uploadfPath);
			 //获取学生
			  PageData student = webStudent.findById(pd);
			 //起始页
			  int start=(nextPage-1)*6;
			  pd.put("start", start);
			 //根据学生id获取能力集合
			 List<PageData> listAbility = webAbilityManager.findList(pd);
			 pd.put("listAbility", listAbility);
			 pd.put("student",student);
			 //根据学生id获取积分
			 PageData ability = webAbilityManager.findStudentById(pd);
			 if(ability==null||"".equals(ability)){
				 return pd;
			 }
			 //学生总积分
			 int stuScore = ((BigDecimal)ability.get("VALUE")).intValue();
			 //根据学生id获取消耗积分
			 PageData score = webScoreManager.findScoreById(pd);
 			 if(score==null||"".equals(score)){
				 pd.put("currentScore", stuScore);
				 return pd;
			 }
			 //学生消耗总积分
			 int stuExpends =  ((BigDecimal)score.get("EXPENDS")).intValue();
			 //学生总积分减去消耗积分
			 int currentScore=stuScore-stuExpends;
			 pd.put("currentScore", currentScore);
			 return pd;
		}
}
