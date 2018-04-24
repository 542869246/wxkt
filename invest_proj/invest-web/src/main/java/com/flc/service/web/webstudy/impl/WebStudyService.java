package com.flc.service.web.webstudy.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.web.webstudy.WebStudyManager;

/** 
 * 说明： 科目信息反馈表
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
@Service("webstudyService")
public class WebStudyService implements WebStudyManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("WebStudyMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("WebStudyMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("WebStudyMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("WebStudyMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("WebStudyMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("WebStudyMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("WebStudyMapper.deleteAll", ArrayDATA_IDS);
	}
	/**
	 * 根据日程id查询科目集合
	 */
	@Override
	public List<PageData> findListByScheduleId(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("WebStudyMapper.findListByScheduleId", pd);
	}
	/**
	 * 根据日程id查询科目集合和返回课程姓名
	 */
	@Override
	public List<PageData> findListByScheduleIdAndCourseName(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("WebStudyMapper.findListByScheduleIdAndCourseName", pd);
	}
}

