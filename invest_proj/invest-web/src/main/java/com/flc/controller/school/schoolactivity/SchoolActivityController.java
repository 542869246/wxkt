package com.flc.controller.school.schoolactivity;


import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.service.school.schoolactivity.SchoolActivityManager;
import com.flc.service.school.schoolactivitycomment.SchoolActivityCommentManager;
import com.flc.service.web.webusers.WebUsersManager;
import com.flc.util.PageData;
import com.flc.util.UuidUtil;


/** 
 * 说明：活动资讯表
 * 创建人：FLC
 * 创建时间：2017-12-01
 */
@Controller
@RequestMapping(value="/schoolactivity")
public class SchoolActivityController extends BaseController {
	//趣味英语
	private final String QWYY="6d49a32305ac41feaa5cead957553723";
	//一周体验
	private final String YZTY="2f8c64dba452400aa371a29686258126";
	//活动预告
	private final String HDYG="9464d96fde4644d09260e8febd9a423d";
	//活动表
	@Resource
	private SchoolActivityManager schoolActivityManager;
	//活动评论表
	@Resource
	private SchoolActivityCommentManager  schoolActivityCommentManager; 
	//用户表
	@Resource
	private WebUsersManager webUsersManager;
	@Value("${uploadfPath}")
	private String uploadfPath;
	/**
	 * 获取活动
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/activity")
	@ResponseBody
	public PageData activity() throws Exception{
		PageData pd=this.getPageData();
		//获取页面传过来的页面数
		int nextPage=Integer.parseInt(pd.getString("next"));
		//起始页
		int start=(nextPage-1)*6;
		pd.put("start", start);
		pd.put("uploadfPath", uploadfPath);
		//获取活动类型id
		String id = pd.getString("activity_type_id");
		List<PageData> pageDatas=null;
		
		//如果为空全查(活动集锦)
		if(id.equals("")){
			pageDatas=schoolActivityManager.findActivityTypeId(pd);
			
		}
		//查询趣味英语
		else if(id.equals("0")){
			pd.put("activity_type_id", QWYY);
			pageDatas=schoolActivityManager.findActivityTypeId(pd);
		}
		//查询一周体验
		else if(id.equals("1")){
			pd.put("activity_type_id", YZTY);
			pageDatas=schoolActivityManager.findActivityTypeId(pd);
		}
		//查询活动预告
		else if(id.equals("2")){
			pd.put("activity_type_id", HDYG);
			pageDatas=schoolActivityManager.findActivityTypeId(pd);
		}
		//查询历史记录
		else if(id.equals("3")){
			pd.put("activity_type_id", HDYG); 
			pd.put("create",pd.getString("create"));
			pageDatas=schoolActivityManager.findActivityTypeIdDate(pd);
		}
		pd.put("pageDatas", pageDatas);
		return pd;
	}
	/**
	 * 获取活动详情
	 * @return
	 * @throws Exception
	 * 
	 */
	
	
	@RequestMapping(value="/goActivityDetails")
	@ResponseBody
	public PageData goActivityDetails() throws Exception{
		PageData pd=new PageData();
		pd=this.getPageData();
		//获取页面传过来的页面数
		int nextPage=Integer.parseInt(pd.getString("next"));
		//起始页
		int start=(nextPage-1)*6;
		pd.put("start", start);
		pd.put("ACTIVITY_ID",pd.get("activity_id"));
		//获取详情
		PageData pdActivity = schoolActivityManager.findById(pd);
		//获取评论内容
		List<PageData> pdComment = schoolActivityCommentManager.findlist(pd);
		//获取评论人
		for (PageData pageData : pdComment) {
			pd.put("USERS_ID",pageData.get("CRITICISM_ID"));
			PageData pduser = webUsersManager.findById(pd);
			
			pageData.put("pduser", pduser);
		}
		pd.put("pdActivity", pdActivity);
		pd.put("pdComment", pdComment);
		return pd;
	}
	/**
	 * 保存评论内容
	 */
	@RequestMapping("/saveComment")
	@ResponseBody
	public PageData saveComment(HttpServletRequest request)throws Exception{
		PageData pd=new PageData();
		pd=this.getPageData();
		PageData users = (PageData)request.getSession().getAttribute("loginuser");
		pd.put("pduser", users);
		pd.put("COMMENT_ID",UuidUtil.get32UUID());
		pd.put("CRITICISM_ID",users.get("USERS_ID"));
		pd.put("CRITICISM_TIME",new Date());
		schoolActivityCommentManager.save(pd);
		return pd;
	}
	/**
	 * 判断用户是否注册登录
	 * @return 
	 */
	@RequestMapping("/isLogin")
	@ResponseBody
	public String isLogin(HttpServletRequest request)throws Exception{
		PageData webuser=(PageData) request.getSession().getAttribute("loginuser");
		if(webuser==null||"".equals(webuser)){
			return "error";
		}
		return "ok";
	}
	
	
}
