package com.flc.controller.web.inormation;

import java.awt.Color;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.flc.controller.base.BaseController;
import com.flc.controller.web.messageinfo.MessageinfoController;
import com.flc.entity.Page;
import com.flc.util.AppUtil;
import com.flc.util.DowenLoadUtil;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;
import com.flc.util.Tools;
import com.lowagie.text.Element;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfGState;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.flc.service.web.inormation.InormationManager;

/** 
 * 说明：产品存蓄
 * 创建人：FLC
 * 创建时间：2017-10-24
 */
@Controller
@RequestMapping(value="/inormation")
public class InormationController extends BaseController {
	
	//String menuUrl = "inormation/list.do"; //菜单地址(权限用)
	@Resource(name="inormationService")
	private InormationManager inormationService;

	@Value("${uploadfPath}")
	private String uploadfPath;
	
	@Value("${managerProjPath}")
	private String managerProjPath;
	
	
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增Inormation");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("INORMATION_ID", this.get32UUID());	//主键
		inormationService.save(pd);
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
		logBefore(logger, "删除Inormation");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		inormationService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, "修改Inormation");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		inormationService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, "列表Inormation");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = inormationService.list(page);	//列出Inormation列表
		mv.setViewName("web/inormation/inormation_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		//mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
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
		mv.setViewName("web/inormation/inormation_edit");
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
		pd = inormationService.findById(pd);	//根据ID读取
		mv.setViewName("web/inormation/inormation_edit");
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
		logBefore(logger, "批量删除Inormation");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			inormationService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	/**
	 *  根据产品模块查询所有信息模块
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/findAll")
	@ResponseBody
	public PageData findByProIdAll(HttpSession session) throws Exception{
		PageData pd = new PageData();
		PageData pb = (PageData) session.getAttribute("obj");
		pd.put("PRODUCTSINFO_ID", pb.get("PRODUCTSINFO_ID"));
		//查询全部信息
		List list = inormationService.listAll(pd);
		//查询时间信息
		List dateList = inormationService.findproListDate(pd);
		//存续信息查询
		pd.put("list", list);
		//时间查询
		pd.put("dateList", dateList);
		//拿到每个产品信息
		pd.put("pb", pb);
		return pd;
	}
	
	/**
	 * pdf跳转文件显示页面不加水印
	 */
	@RequestMapping("/toshowpdf")
	public ModelAndView toshowpdf() throws Exception{
		ModelAndView view = this.getModelAndView();
		PageData pd = this.getPageData();
		view.setViewName("pdf/showjsp");
		view.addObject("from","toshowpdf");
		view.addObject("pd", pd);
		return view;
	}
	
	/**
	 * pdf跳转文件显示页面加水印
	 */
	@RequestMapping("/toshowpdfshuiying")
	public ModelAndView toshowpdfshuiying() throws Exception{
		ModelAndView view = this.getModelAndView();
		PageData pd = this.getPageData();
		view.setViewName("pdf/showjsp");
		view.addObject("from","toshowpdfshuiying");
		view.addObject("pd", pd);
		return view;
	}
	
	/**
	 * 存储信息读取pdf
	 * @param id
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/getFile")
	public String openPdfFileAndprocess(HttpServletResponse response,HttpSession session,HttpServletRequest request) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			response.setContentType("multipart/form-data");  
			response.setContentType("application/pdf");
	        response.setCharacterEncoding("UTF-8");  
	        response.setHeader("Content-Disposition", "inline; filename="+"aaaa"+".pdf");
	        pd.put("INFORMATION_ID", pd.get("DETAILS_ID"));
	        String filename = inormationService.findById(pd).getString("INFORMATION_PDFURL");
			String url = uploadfPath+filename;
			ServletOutputStream out= response.getOutputStream();
				
			Rectangle pageRect = null;
	        long time=new Date().getTime();
	        String newname="/static/login/pdf/";
	        String path = MessageinfoController.class.getResource("/").getPath() +"/SIMSUN.TTC,1";
	        File file1=new File(newname);
	        if(!file1.exists()){
	        	file1.mkdirs();
	        }
	        File file2=new File(newname+time+".pdf");
	        PdfReader reader = new PdfReader(url);
	        // 加完水印的文件  
	        PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(file2));  
	        int total = reader.getNumberOfPages() + 1;  
	        PdfContentByte content;  
	        // 设置字体  
	        BaseFont base = BaseFont.createFont(path ,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
	        //从session获取用户昵称手机号码
	        PageData message=(PageData) session.getAttribute("loginuser");
	        // 水印文字  
	        String waterMarkName = "姓名:"+message.getString("USER_NICKNAME")+",手机:"+message.getString("USER_PHONE");
	     // 循环对每页插入水印  
			for (int i = 1; i < total; i++) { 
				pageRect = stamper.getReader().getPageSizeWithRotation(i);
				 // 计算水印X,Y坐标
		         float x = 0;
		         float y = 0;
		         //控制循环每行个数    多少列
				for(int j=1;j<4;j++){
					for(int k=1;k<6;k++){
				        x=pageRect.getWidth()-150*j;
				        y=pageRect.getHeight()-150*k;
					    // 水印的起始  
					    //content = stamper.getUnderContent(i);  
					    content = stamper.getOverContent(i);
					    content.saveState();
					    // 开始  
					    content.beginText();  
					    // 设置颜色  
					    content.setColorFill(Color.GRAY);  
					    // 设置字体及字号  
					    content.setFontAndSize(base, 14);
					    // 设置起始位置   
					    PdfGState gs = new PdfGState();
			            // 设置透明度为0.2
			            gs.setFillOpacity(1.f);
			            content.setGState(gs);
					    // 水印文字成45度角倾斜
					    content.showTextAligned(Element.ALIGN_CENTER
			                    , waterMarkName, x,
			                    y, 55);
					    content.endText();  
					    content.setLineWidth(1f);
					    content.stroke();
					}
				}
			}  
	        stamper.close();
	        //File file=new File(newname);
			FileInputStream inputStream = new FileInputStream(file2);  
			byte[] b=new byte[(int)file2.length()];
	        inputStream.read(b);
	        out.write(b);
			inputStream.close();  
			file2.delete();
			out.flush();  
			out.close();
			
		} catch (FileNotFoundException e) {
			// 
			e.printStackTrace();
		} catch (IOException e) {
			// 
			e.printStackTrace();
		}  
		return null;
	}
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
