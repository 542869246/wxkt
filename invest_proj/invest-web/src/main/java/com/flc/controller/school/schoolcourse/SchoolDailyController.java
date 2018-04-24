package com.flc.controller.school.schoolcourse;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flc.controller.base.BaseController;
import com.flc.service.school.schoolactivity.SchoolActivityManager;
import com.flc.service.school.schoolactivitycomment.SchoolActivityCommentManager;
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
 * 家长日报
 * 
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value = "/schoolDailyLoad")
public class SchoolDailyController extends BaseController {
	@Autowired
	private WebScheduleManager webSchedule;//用户日程表
	@Autowired
	private WebStudyManager webStudy;//科目信息反馈表
	@Autowired
	private WebUsersManager webUsers;//家长表
	@Autowired	
	private WebStuWebuserManager webStuUser;//用户和学生关联表
	@Autowired
	private WebStudentManager webStudent;//学生
	@Resource
	private WebAbilityManager webAbilityManager;//能力表
	@Resource
	private WebScoreManager webScoreManager;//积分兑换表
	@Autowired
	private DictionariesManager dictionariesManager;
	@Autowired
	private UserManager wm;//老师（后台用户）
	
	@ResponseBody
	@RequestMapping(value="/dailyconnent")
	public PageData dailyConnent(HttpServletRequest request,HttpServletResponse response)throws Exception{
		PageData pd=new PageData();
		pd=this.getPageData();
		//获取前端页面传递过来的页数
		int page = Integer.parseInt(pd.getString("page"));
		//根据用户Id查询用户信息
		PageData users = (PageData) request.getSession().getAttribute("loginuser");
		//获取学生的默认Id
		if(users==null||users.equals("")){
			pd.put("prompt","您还没有孩子报名我们学鹿教育");
			pd.put("stateCode","100");
			return pd;
		}
		String stuid = users.getString("STUDENT_ID");
		//当有默认学生的时候，查询该学生的信息，否则查询关联表所对应的所有学生的集合
		if(stuid==null||stuid==""){
			//通过关联表查询家长对应的学生的集合数据
			List<PageData> studentList = webStuUser.findListByUsersId(pd);
			if(studentList.size()==0){
				pd.put("prompt","请联系老师，让其给您的孩子添加您的信息");
				pd.put("stateCode","100");
				return pd;
			}
			pd= webStudent.findByIdOrderTime(studentList);
		}else{
			pd=users;
		}
		int start=(page*6);
		//压入每次分页的查询条数
		pd.put("start", start);
		PageData student = webStudent.findById(pd);
		//根据学生的Id和分页条件来查询学生的能力类型和值集合
		List<PageData> abilityList = webAbilityManager.findAndAbilityTypeList(pd);
		pd.put("abilityList", abilityList);
		pd.put("student",student);
		return pd;
	}
	
	@ResponseBody
	@RequestMapping(value="/dailyTypeConnent")
	public PageData dailyTypeConnent(HttpServletRequest request,HttpServletResponse response)throws Exception{
		PageData pd=new PageData();
		pd=this.getPageData();
		//能力类型id
		pd.put("PARENT_ID", "e6f62d095964410593593e58470ab234");
		PageData users = (PageData) request.getSession().getAttribute("3c859994936b412e86385e41feb14ce9");
		
		//=============
		PageData pd2 = new PageData();
		pd2.put("USERS_ID", "66cas171qw234e167c07bejf3g0cfbdv");
		users=(PageData)webUsers.findById(pd2);
		//=============
		
		if(users==null||users.equals("")){
			pd.put("stateCode","100");
			return pd;
		}
		List<PageData> abilityTypeList = dictionariesManager.listAll(pd);
		System.out.println(abilityTypeList);
		if(abilityTypeList.size()==0){
			return pd;
		}
		String stuid = users.getString("STUDENT_ID");
		//当有默认学生的时候，查询该学生的信息，否则查询关联表所对应的所有学生的集合 
		if(stuid==null||stuid==""){
			//通过关联表查询家长对应的学生的集合数据
			List<PageData> studentList = webStuUser.findListByUsersId(pd);
			if(studentList.size()==0){
				pd.put("stateCode","100");
				return pd;
			}
			pd= webStudent.findByIdOrderTime(studentList);
		}else{
			pd=users;
		}
		List<PageData> abilityValueList = webAbilityManager.findTotaAbilityValueByStu(pd);
		pd.put("abilityValueList", abilityValueList);
		pd.put("abilityTypeList", abilityTypeList);
		return pd;
	}
}
