package com.flc.controller.school.schoolcourse;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.service.web.webstudent.WebStudentManager;
import com.flc.service.web.webstuwebuser.WebStuWebuserManager;
import com.flc.service.web.webusers.WebUsersManager;
import com.flc.util.PageData;
@Controller
@RequestMapping("schoolGetStudent")
public class SchoolGetStudent extends BaseController {
	@Autowired
	private WebUsersManager webUsers;//家长表
	@Autowired
	private WebStudentManager webStudent;//学生
	@Autowired	
	private WebStuWebuserManager webStuUser;//用户和学生关联表
	@RequestMapping("findStudent")
	@ResponseBody
	public PageData findStudent(HttpServletRequest request){//遍历学生
		PageData pd=new PageData();
		pd=this.getPageData();
		PageData web_users = (PageData) request.getSession().getAttribute("loginuser");//获取登录用户(家长)默认学生Id
		if (web_users==null) {
			String studentId=web_users.getString("STUDENT_ID");//根据用户获取默认学生
			List<PageData> page;//根据家长id获取学生集合
			try {
				page = webStuUser.findListByUsersId(web_users);
				if (page.size()==0) {
					return pd;
				}
				if (studentId ==null || "".equals(studentId)) {
					try {
					PageData student = webStudent.findByIdOrderTime(page);
					web_users.put("STUDENT_ID", student.getString("STUDENT_ID"));
					request.getSession().setAttribute("loginuser", web_users);//再次赋值
					} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					}//如果有多个学生则根据学生创建时间获取最新的学生，返回一条数据
				}
				pd.clear();
				page=webStudent.findByIdList(page);
				pd.put("students",page);
			} catch (Exception e) {
				e.printStackTrace();
			}//获取学生集合
		}
		
		return pd;
	}
	@RequestMapping("/updateDefalutStudent")
	public ModelAndView updateDefaultStudentId(HttpServletRequest request){//修改默认学生
		ModelAndView mv=this.getModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		System.out.println(pd);
		PageData web_users = (PageData) request.getSession().getAttribute("loginuser");//获取登录用户(家长)默认学生Id
		String studentId=pd.getString("STUDENT_ID");
		if (web_users!=null) {
			web_users.put("STUDENT_ID", studentId);
			try {
				webUsers.edit(web_users);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.getSession().setAttribute("loginuser", web_users);//再次赋值
		}
		mv.setViewName("redirect:"+pd.getString("currenturl"));
		return mv;
	} 
}
