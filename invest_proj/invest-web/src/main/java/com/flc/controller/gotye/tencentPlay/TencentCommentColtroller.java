package com.flc.controller.gotye.tencentPlay;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flc.controller.base.BaseController;
import com.flc.service.gotye.tencentcomment.impl.TencentCommentService;
import com.flc.service.web.webusers.WebUsersManager;
import com.flc.service.web.webusers.impl.WebUsersService;
import com.flc.util.PageData;
import com.flc.util.UuidUtil;
@Controller
@RequestMapping("Comment")
public class TencentCommentColtroller extends BaseController {
	@Autowired
	TencentCommentService tencentCommentService;//评论表
	@Autowired
	WebUsersService webUsersService;//用户表 
	@ResponseBody
	@RequestMapping("ListComment") 
	public PageData ListComment(){
		PageData pd=new PageData();
		pd=this.getPageData();
		try {
			List<PageData> list = tencentCommentService.listAll(pd);
			PageData WebUser=null; 
  			for (PageData pageData : list) {
  				pd.put("USERS_ID", pageData.get("WEBUSERID"));
 				WebUser=webUsersService.findById(pd);
   				pageData.put("USERS_WECHAT_NICKNAME", WebUser.get("USERS_WECHAT_NICKNAME"));
			}
			pd.put("commentList", list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pd;
	}
	@ResponseBody
	@RequestMapping("AddComment")
	public PageData AddComment(){
		PageData pd=new PageData();
		pd=this.getPageData();
		try {
			pd.put("TENCENTCOMMENT_ID", UuidUtil.get32UUID());
			pd.put("CREATEDATE", new Date());
			pd.put("COMMENTTIME", new Date());
			pd.put("CREATEBY", pd.get("WEBUSERID"));
			tencentCommentService.save(pd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pd;
	}
}
