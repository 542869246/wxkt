package com.flc.service.school.shcoolschedule.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.school.shcoolschedule.ShcoolScheduleManager;

/** 
 * 说明： 课表
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
@Service("shcoolscheduleService")
public class ShcoolScheduleService implements ShcoolScheduleManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ShcoolScheduleMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ShcoolScheduleMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ShcoolScheduleMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ShcoolScheduleMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ShcoolScheduleMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ShcoolScheduleMapper.findById", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByIdMore(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ShcoolScheduleMapper.findByIdMore", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ShcoolScheduleMapper.deleteAll", ArrayDATA_IDS);
	}
	/**
	 * 根据课程id查询课表
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findListByCourseId(List<PageData> pd) throws Exception {
		return (List<PageData>) dao.findForList("ShcoolScheduleMapper.findListByCourseId", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findListByTime(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ShcoolScheduleMapper.findListByTime", pd);
	}

/**
 * 通过教师和当天日期获取数据 
 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByTeachAndDate(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ShcoolScheduleMapper.findByTeachAndDate", pd);
	}

	/**根据老师id和时间查询当日课程
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByUserIdAndTime(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ShcoolScheduleMapper.findByUserIdAndTime", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByTeachAndDateTset(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ShcoolScheduleMapper.findByTeachAndDateTset", pd);
	}
	
}

