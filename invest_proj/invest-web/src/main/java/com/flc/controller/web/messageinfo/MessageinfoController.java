package com.flc.controller.web.messageinfo;

import java.awt.Color;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.service.web.message.MessageManager;
import com.flc.service.web.messageinfo.MessageinfoManager;
import com.flc.service.web.read.ReadManager;
import com.flc.service.web.userinfo.UserinfoManager;
import com.flc.util.PageData;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfGState;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;

/** 
 * 说明：存续消息展示
 * 创建人：FLC
 * 创建时间：2017-10-22
 */
@Controller
@RequestMapping(value="/messageinfo")
public class MessageinfoController extends BaseController {
	
	String menuUrl = "messageinfo/list.do"; //菜单地址(权限用)
	@Resource(name="messageinfoService")
	private MessageinfoManager messageinfoService;
	@Resource(name="readService")
	private ReadManager readService;
	@Resource(name="messageService")
	private MessageManager  messageService;
	@Value("${uploadfPath}")
	private String uploadfPath;
	@Resource(name="userinfoService")
	private UserinfoManager userinfoService;
	
	/**
	 * 查询系统存续信息
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	public PageData list(Page page,HttpSession session) throws Exception{
		logBefore(logger, "列表Messageinfo");
		PageData pd = new PageData();
		//获取传过来的参数
		pd = this.getPageData();
		PageData param=(PageData) session.getAttribute("loginuser");
		pd.put("READ_USER_ID", param.get("USERINFO_ID"));
		pd.put("USER_GROUPID", param.get("USER_GROUPID"));
		page.setPd(pd);
		page.setTotalResult(messageinfoService.getTotalResult(pd));
		List<PageData>	varList = messageinfoService.list(page);	//列出Messageinfo列表
		//创建pagedata向前台传数据
		PageData data = new PageData();
		data.put("page", page);
		data.put("varList", varList);
		return data;
	}
	/**
	 * 
	 * @return
	 */
	@RequestMapping("/toxtpdfmess")
	public ModelAndView toxtpdfmess(){
		ModelAndView view = this.getModelAndView();
		view.addObject("from", "toxtpdfmess");
		view.addObject("pd", this.getPageData());
		view.setViewName("pdf/showjsp");
		return view;
	}
	
	@RequestMapping("/toxtpdfinfo")
	public ModelAndView toxtpdfinfo(){
		ModelAndView view = this.getModelAndView();
		view.addObject("from", "toxtpdfinfo");
		view.addObject("pd", this.getPageData());
		view.setViewName("pdf/showjsp");
		return view;
	}
	
	
	
	/**
	 * 打开pdf
	 * 判断数据是否要插入已读表
	 * @param id
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="getPdfFile")
	public String openPdfFileAndprocess(HttpServletResponse response,HttpSession session) throws Exception{
		try {
			response.setContentType("multipart/form-data");  
			response.setContentType("application/pdf");
	        response.setCharacterEncoding("UTF-8");
	        response.setHeader("Content-Disposition", "inline; filename="+"aaa"+".pdf");
	        ServletOutputStream out= response.getOutputStream();
	        PageData pd = new PageData();
	        pd=this.getPageData();
	        PageData user=(PageData) session.getAttribute("loginuser");
	        pd.put("READ_USER_ID", user.get("USERINFO_ID"));
	        if(pd.getString("READ_MESSAGEINFO_ID")!=null && pd.getString("READ_MESSAGEINFO_ID")!=""){
	        	PageData messageinfo=readService.selectByMessageInfoID(pd);
	        	if(messageinfo==null){
		    		pd.put("READ_USER_ID", user.get("USERINFO_ID"));
		    		pd.put("READ_ID", this.get32UUID());	//主键
		    		readService.save(pd);
	        	}
	        }
	        Rectangle pageRect = null;
	        long time=new Date().getTime();
	        String newname="/static/login/pdf/";
	        String id=pd.getString("MESSAGEINFO_ID");
	        if("".equals(id)||null==id){
	        	id=pd.getString("INFORMATION_ID");
	        	id=messageinfoService.findinformationbyid(id).getString("INFORMATION_PDFURL");
	        }else{
	        	id=messageinfoService.findmessageinfobyid(id).getString("MESSAGEINFO_URL");
	        }
	        String path = MessageinfoController.class.getResource("/").getPath() +"/SIMSUN.TTC,1";
	        File file1=new File(newname);
	        if(!file1.exists()){
	        	file1.mkdirs();
	        }
	        File file2=new File(newname+time+".pdf");
	        PdfReader reader = new PdfReader(uploadfPath+id);
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
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}  
		return null;
	}
	/**
	 * 查询所有的系统消息和所有的存续消息
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectall")
	@ResponseBody
	public PageData selectall(HttpSession session) throws Exception{
		logBefore(logger, "列表Messageinfo");
		//获取session中的用户详细信息
		PageData pd=(PageData) session.getAttribute("loginuser");
		System.out.println(pd);
		PageData result=new PageData();
		result.put("READ_USER_ID", pd.get("USERINFO_ID"));
		result.put("USER_GROUPID", pd.get("USER_GROUPID"));
		List<PageData> data=messageinfoService.selectAll(result);
		List<PageData> sysdata=messageService.selectAllSys(result);
		PageData pd1=(PageData)this.getRequest().getSession().getAttribute("loginuser");
		PageData loginuser =(PageData)userinfoService.findById(pd1);
		pd.put("varList", data);
		pd.put("sysdata", sysdata);
		pd.put("loginuser", loginuser);
		return pd;
	}
	
	/**
	 * 根据存续id查询单个产品存续
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/single")
	@ResponseBody
	public PageData findById() throws Exception{
		logBefore(logger, "列表Messageinfo");
		PageData pd= this.getPageData();
		List<PageData> data=messageinfoService.selectall();
		pd.put("info", data);
		return pd;
	}
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
