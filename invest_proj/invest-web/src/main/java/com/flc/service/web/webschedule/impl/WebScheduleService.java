package com.flc.service.web.webschedule.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.web.webschedule.WebScheduleManager;

/**
 * 说明： 学生日程表 创建人：FLC 创建时间：2017-12-03
 * 
 * @version
 */
@Service("webscheduleService")
public class WebScheduleService implements WebScheduleManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception {
		dao.save("WebScheduleMapper.save", pd);
	}
	
	/**
	 * 根据日报类型和lesson_id修改日报
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editByTypeAndLes(PageData pd) throws Exception {
		 dao.update("WebScheduleMapper.editByTypeAndLes", pd);
	}
	

	/**
	 * 根据日报类型和lesson_id得到数量
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getListByTypeAndLes(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("WebScheduleMapper.getListByTypeAndLes", pd);
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception {
		dao.delete("WebScheduleMapper.delete", pd);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editByISLook(PageData pd) throws Exception {
		dao.update("WebScheduleMapper.editByISLook", pd);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public Object edit(PageData pd) throws Exception {
		return dao.update("WebScheduleMapper.edit", pd);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList("WebScheduleMapper.datalistPage", page);
	}

	/**
	 * 列表(全部)
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("WebScheduleMapper.listAll", pd);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("WebScheduleMapper.findById", pd);
	}

	/**
	 * 批量删除
	 * 
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS) throws Exception {
		dao.delete("WebScheduleMapper.deleteAll", ArrayDATA_IDS);
	}

	/**
	 * 根据学生id查询科目信息反馈表
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByStudentList(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("WebScheduleMapper.findByStudentList", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findStats(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("WebScheduleMapper.findStats", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> CoursekelistPage(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("WebScheduleMapper.Coursekelist", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getListNum(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("WebScheduleMapper.getListNum", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> subjectlist(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("WebScheduleMapper.subjectlist", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> getListNumAll(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("WebScheduleMapper.getListNumAll", pd);
	}


	/**
	 * 根据学生COURSE_ID获取学生
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByCouseid(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("WebScheduleMapper.findByCouseid", pd);
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findMydaily(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("WebScheduleMapper.findMydaily", pd);
	}
}
