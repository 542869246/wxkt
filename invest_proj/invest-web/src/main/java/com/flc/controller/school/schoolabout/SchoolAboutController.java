package com.flc.controller.school.schoolabout;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.service.school.schoolbrand.SchoolBrandManager;
import com.flc.service.school.schoolinfo.SchoolInfoManager;
import com.flc.util.PageData;

/**
 * 关于我们和联系我们还有品牌入驻
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/schoolabout")
public class SchoolAboutController extends BaseController {
	
	@Resource(name="schoolinfoService")
	private SchoolInfoManager schoolinfoService;
	@Resource
	private SchoolBrandManager schoolBrandService;
	
	/**联系学校
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goContent")
	@ResponseBody
	public PageData findSchoolInfoById() throws Exception{
		PageData obj = schoolinfoService.findByOne();
		return obj;
	}
	//关于我们
	@RequestMapping(value="/goAbout")
	@ResponseBody
	public PageData findSchool_readme() throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String type=pd.getString("type");
		PageData obj=null;
		if ("0".equals(type)) {
			obj = schoolinfoService.findByOne();
		}else{
			obj=schoolBrandService.findByOne();
		}
		return obj;
	}
	
}
