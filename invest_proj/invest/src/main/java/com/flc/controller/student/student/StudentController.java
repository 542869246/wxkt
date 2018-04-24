package com.flc.controller.student.student;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.session.Session;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;
import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.entity.system.User;
import com.flc.util.AppUtil;
import com.flc.util.Const;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;
import com.flc.util.Jurisdiction;
import com.flc.util.Tools;
import com.google.gson.Gson;

import net.sf.json.JSONArray;

import com.flc.service.arrange.arrange.ArrangeManager;
import com.flc.service.school.courses.CoursesManager;
import com.flc.service.student.student.StudentManager;
import com.flc.service.system.dictionaries.DictionariesManager;

/** 
 * 说明：学生
 * 创建人：FLC
 * 创建时间：2017-12-01
 */
@Controller
@RequestMapping(value="/student")
public class StudentController extends BaseController {
	
	String menuUrl = "student/list.do"; //菜单地址(权限用)
	@Resource(name="studentService")
	private StudentManager studentService;
	@Resource(name="arrangeService")
	private ArrangeManager arrangeService;
	@Resource
	private CoursesManager coursesService;
	
	@Resource
	private DictionariesManager dictionariesService;
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Student");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("STUDENT_ID", this.get32UUID());	//主键
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		pd.put("CREATEBY", user.getUSER_ID());//创建人
		pd.put("CREATEDATE", new Date());//创建时间
		pd.put("MODIFYBY", user.getUSER_ID());//修改人
		pd.put("MODIFYDATE", new Date());//修改时间
		studentService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Student");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		studentService.delete(pd);
		arrangeService.deleteByStu(pd);//根据学生ID删除关联表
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Student");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		pd.put("CREATEBY", user.getUSER_ID());//创建人
		pd.put("CREATEDATE", new Date());//创建时间
		pd.put("MODIFYBY", user.getUSER_ID());//修改人
		pd.put("MODIFYDATE", new Date());//修改时间
		studentService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	//加载产品类型ztree数据
		public void JzZtree(Model model){
			try{
				PageData pd = new PageData();
				pd = this.getPageData();
				List<PageData> list = coursesService.listAll(pd);
				//获取下拉列表
				Gson gson = new Gson();
				String json = gson.toJson(list);
//				json.replaceAll("pname", "nodes");
				model.addAttribute("zTreeNodes", json);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
		}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page,Model model) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Student");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		String ATTR_TYPEID = pd.getString("ATTR_TYPEID");
		if(null != ATTR_TYPEID && !"".equals(ATTR_TYPEID)){
			pd.put("ATTR_TYPEID", ATTR_TYPEID.trim());
		}
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = studentService.list(page);	//列出Student列表
		JzZtree(model);//调用JzZtree方法
		mv.setViewName("student/student/student_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("student/student/student_update");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String whereTo=pd.getString("whereTo");
		String COURSES_ID=pd.getString("COURSES_ID");
		pd = studentService.findById(pd);	//根据ID读取
//		pd.put("STUDENT_ID", STUDENT_ID);
//		getRequest().getSession().setAttribute("STUDENT_ID", pd.get("STUDENT_ID"));//将学生id存入session中
		pd.put("whereTo", whereTo);
		pd.put("COURSES_ID", COURSES_ID);
		mv.setViewName("student/student/student_update");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Student");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			studentService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Student到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("学生id");	//1
		titles.add("学生姓名");	//2
		titles.add("手机号");	//3
		titles.add("头像");	//4
		titles.add("描述");	//5
		titles.add("修改人");	//6
		titles.add("修改时间");	//7
		titles.add("创建人");	//8
		titles.add("创建时间");	//9
		dataMap.put("titles", titles);
		List<PageData> varOList = studentService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("STUDENT_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("STUDENT_NAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("PHONE"));	    //3
			vpd.put("var4", varOList.get(i).getString("IMG_ID"));	    //4
			vpd.put("var5", varOList.get(i).getString("STUDENT_COMMENTS"));	    //5
			vpd.put("var6", varOList.get(i).getString("MODIFYBY"));	    //6
			vpd.put("var7", varOList.get(i).getString("MODIFYDATE"));	    //7
			vpd.put("var8", varOList.get(i).getString("CREATEBY"));	    //8
			vpd.put("var9", varOList.get(i).getString("CREATEDATE"));	    //9
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	/**
	 *图片上传
	 * @param request
	 * @param response
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("/upload")
	@ResponseBody
	public String addFile(HttpServletRequest request,HttpServletResponse response)
			throws IllegalStateException, IOException {
		String src="";
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		if (multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			Iterator<String> iter = multiRequest.getFileNames();
			while (iter.hasNext()) {
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					String myFileName = file.getOriginalFilename();
					//System.out.println(myFileName);
					if (myFileName.trim() != "") {
						String fileName = file.getOriginalFilename();
						String fileExt = fileName.substring(
								fileName.lastIndexOf(".") + 1).toLowerCase();
						SimpleDateFormat df = new SimpleDateFormat(
								"yyyyMMddHHmmss");
						String newFileName = df.format(new Date());
						String fileNames = newFileName
								+ new Random().nextInt(1000) + "." + fileExt;
						String  path =
								 request.getSession().getServletContext()
								 .getRealPath("static"+File.separator+"login"+File.separator+"upload")
								 + File.separator + fileNames;
						File localFile = new File(path);
						if (!localFile.exists()) {
							localFile.mkdirs();
						}
						file.transferTo(localFile);
						src="/static/login/upload/"+fileNames;
					}
				}
			}
			
		}
		return src;
	}
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
