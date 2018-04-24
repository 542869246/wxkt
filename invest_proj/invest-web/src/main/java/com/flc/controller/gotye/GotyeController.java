package com.flc.controller.gotye;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.service.gotyeBackstage.gotyebackstage.GotyeBackstageManager;
import com.flc.service.school.schoolarrange.SchoolArrangeManager;
import com.flc.service.school.schoolclassroom.SchoolClassRoomManager;
import com.flc.service.school.shcoolschedule.ShcoolScheduleManager;
import com.flc.service.web.webstudent.WebStudentManager;
import com.flc.service.web.webstuwebuser.WebStuWebuserManager;
import com.flc.service.web.webusers.WebUsersManager;
import com.flc.util.DateUtil;
import com.flc.util.PageData;

@Controller
@RequestMapping("gotye")
public class GotyeController extends BaseController{
	//出现错误是跳转的页面
	private static final String USERNULLURL="forward:/activity/goActivity";
	@Autowired
	private WebStudentManager webStudent;
	//直播连接地址
	private static String url="/live/";
	//课表
	@Autowired
	private ShcoolScheduleManager ssm;
	@Autowired//教室
	private SchoolClassRoomManager scrm; 
	//课程安排表
	@Autowired
	private SchoolArrangeManager sam;
	//账号
	@Autowired
	private GotyeBackstageManager gbs;
	//学生家长
		@Autowired
	private WebUsersManager wum;
	@Autowired	
	private WebStuWebuserManager webStuUser;//用户和学生关联表
	
	//获取房间号
	@ResponseBody
	@RequestMapping("goGotyeLive") 
	public PageData findGotyeUrl(){
		HttpServletRequest request=this.getRequest();
 		PageData pd=new PageData();
		pd=this.getPageData();
		List<PageData> roomList=new ArrayList<PageData>();
 		try {
			PageData web_users = (PageData) request.getSession().getAttribute("loginuser");//获取登录用户(家长)默认学生Id
			if (web_users == null || "".equals(web_users)) {//理论是不会执行
				pd.put("message", "查看直播时，登陆用户名为空");
				pd.put("status","1");
				return pd;
			}
			web_users=wum.findById(web_users);
			Object USERS_WHETHER = web_users.get("USERS_WHETHER");
			Integer whether = (Integer)USERS_WHETHER;
			if(whether==null){
				whether=0;
			}
			List<PageData> page = webStuUser.findListByUsersId(web_users);//获取学生集合
			if(whether==0){
				if (page.size()==0) {
					pd.put("message", "请联系老师，让其给您的孩子添加您的信息");
					pd.put("state","1");
					return pd;
				}
			}
			if(page.size()!=0){
					List<PageData> student=webStudent.findByIdList(page);//如果有多个学生则根据学生创建时间获取最新的学生，返回一条数据
					List<PageData> studentpd = null;
					try {
						studentpd = sam.findByListStudentId(student);
					} catch (Exception e) {
					}
					if(studentpd.size()!=0){
						List<PageData> wsmdb = ssm.findListByCourseId(studentpd);//根据课程Id查询课表
						Date currentDate=new Date();
						Date start=null;
						Date endtime=null; 
						PageData roompd=null;
						boolean is=false;
						for (PageData pageData : wsmdb) {
							start=(Date) pageData.get("LESSON_STARTTIME");
							endtime=(Date) pageData.get("LESSON_ENDTIME");
							if (DateUtil.belongCalendar(currentDate,start,endtime)) {
								roompd= scrm.findById(pageData);//根据教室id查询教室
								if(roompd!=null&&!"".equals(roompd)){
									roompd.put("starttime", start);
									roompd.put("endtime", endtime);//结束时间
									roompd.put("whether", 0);
									roomList.add(roompd);
								}
								break;
							}
						}
					}
			}
			if(whether==0){
				pd.put("roomList", roomList);
				return pd;
			}
				String roomStr=web_users.getString("USERS_CLASSROOM");//获取房间号
				String[] room=roomStr.split(",");
				for (String string : room) {
					Boolean falg=false;
					PageData rp=new PageData();
					rp.put("CLASSROOM_ID", string);
					for (PageData  item: roomList) {
						if(item.getString("CLASSROOM_ID").equals(string)){
							falg=true;
							break;
						}
					}
					if(falg){
						continue;
					}
					PageData rooms=scrm.findById(rp);
					if(rooms==null){
						pd.put("roomList", roomList);
						return pd;
					}
					if(whether==2){
						 Date users_endtime = (Date)web_users.get("USERS_ENDTIME");
						 Date current=new Date();
						 if(users_endtime.getTime()<=current.getTime()){
							 continue;
						 }
						rooms.put("starttime", web_users.get("USERS_STARTTIME"));
						rooms.put("endtime", web_users.get("USERS_ENDTIME"));
					}
					rooms.put("whether", whether);
					roomList.add(rooms);
				}
				pd.put("roomList", roomList);
		} catch (Exception e) {
			System.out.println("error");
		}
			return pd;
	}
	@ResponseBody
	@RequestMapping(value="getBackstage")
	public PageData getBackstage() throws Exception{
		PageData pd=gbs.findByOne();
		return pd;
	}
	/**
	 * 实时查看密码验证
	 * url：gotye/findGotyeUrl
	 */
	@RequestMapping(value="passwordVali")
	@ResponseBody
	public PageData passwordVali(){
		HttpServletRequest request=this.getRequest();
		PageData pd=new PageData();
		pd=this.getPageData();
		PageData roompd=null;
		try {
			roompd = scrm.findById(pd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace(); 
		}
		if (!(pd.getString("BACKSTAGE_PASSWORD")==null?"":pd.getString("BACKSTAGE_PASSWORD")).equals(roompd.getString("BACKSTAGE_PASSWORD"))) {
			pd.put("message", "直播密码输入错误");
			pd.put("state", "1");
			return pd;
		}else{
			pd.put("state", "0");
			return pd;
		}
	}
	//跳转页面
	@RequestMapping("findGotyeUrl") 
	public ModelAndView goGotyeLive(){
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		if(null!=pd.get("CHECK_TYPE")){
			Object check_type=pd.get("CHECK_TYPE");
			System.out.println(check_type);
			if ("0".equals(check_type)) {//亲加直播跳转
				mv.setViewName("myDaily/live");
			}else{
				mv.setViewName("myDaily/tencentPlay");//腾讯直播
			}
		}else{
			try {
	 			if (0==(Integer)getBackstage().get("CHECK_TYPE")) {//亲加直播跳转
					mv.setViewName("myDaily/live");
				}else{
					mv.setViewName("myDaily/tencentPlay");//腾讯直播
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block`
				e.printStackTrace();
			}
		}
		return mv;
	}
	@ResponseBody
	@RequestMapping(value="updateGotype")
	public PageData updateGotype(){
		PageData pd=new PageData();
		pd=this.getPageData();
		int GOODCOUNT=0;
		try {
			PageData roomPd=scrm.findById(pd);
			Object GOODCOUNTObj= roomPd.get("GOODCOUNT");
			if(GOODCOUNTObj==null){
				GOODCOUNTObj=0;
			}
			GOODCOUNT=(Integer) GOODCOUNTObj;
			GOODCOUNT=GOODCOUNT+1;
			roomPd.put("GOODCOUNT", GOODCOUNT);
			scrm.edit(roomPd);
 		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		pd.put("GOODCOUNT", GOODCOUNT);
		return pd;
	}
	
}