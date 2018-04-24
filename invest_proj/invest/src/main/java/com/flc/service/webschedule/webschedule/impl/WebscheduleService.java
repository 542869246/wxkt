package com.flc.service.webschedule.webschedule.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.webschedule.webschedule.WebscheduleManager;

/** 
 * 说明： 用户日程表
 * 创建人：FLC
 * 创建时间：2017-12-06
 * @version
 */
@Service("webscheduleService")
public class WebscheduleService implements WebscheduleManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("WebscheduleMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("WebscheduleMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public Object  edit(PageData pd)throws Exception{
		
		return dao.update("WebscheduleMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("WebscheduleMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("WebscheduleMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("WebscheduleMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("WebscheduleMapper.deleteAll", ArrayDATA_IDS);
	}
	
	
	@Override
	public void delete_pl(PageData pd) throws Exception {
		dao.delete("WebscheduleMapper.delete_pl", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> pl_list(Page page) throws Exception {
		return (List<PageData>)dao.findForList("WebscheduleMapper.pl_list", page);
	}
	
	@Override
	public void deletepl_All(String[] arrayDATA_IDS) throws Exception {
		dao.delete("WebscheduleMapper.deletepl_All", arrayDATA_IDS);
	}
	/**
	 * 根据学生ID查询学生的学习日程是否被查看  返回学生的家长
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findLookByStu(PageData pd)throws Exception {
		return (List<PageData>)dao.findForList("WebscheduleMapper.findLookByStu", pd);
	}
	/**
	 * 根据学生ID查询学生的学习日程是否被查看
	 * @param pageData2
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findSizeByStudent(PageData pd)throws Exception {
		return (List<PageData>)dao.findForList("WebscheduleMapper.findSizeByStudent", pd);
	}

	@Override
	public void editStates(PageData pd) throws Exception {
		dao.update("WebscheduleMapper.editStates", pd);
		
	}
	
}

