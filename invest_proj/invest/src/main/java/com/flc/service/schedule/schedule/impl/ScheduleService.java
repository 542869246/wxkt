package com.flc.service.schedule.schedule.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.schedule.schedule.ScheduleManager;

/** 
 * 说明： 课表(老师)
 * 创建人：FLC
 * 创建时间：2017-12-05
 * @version
 */
@Service("scheduleService")
public class ScheduleService implements ScheduleManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ScheduleMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ScheduleMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ScheduleMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ScheduleMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ScheduleMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ScheduleMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ScheduleMapper.deleteAll", ArrayDATA_IDS);
	}
	
	/**
	 * 查询学生是否冲突
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> checkStudent(Page page) throws Exception {
		return (List<PageData>)dao.findForList("ScheduleMapper.checkStudent", page);
	}

	/**
	 * 根据日期查询老师今天的课程
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAllUserByTime(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("ScheduleMapper.listAllUserByTime", pd);
	}

	@SuppressWarnings("unchecked")
	public List<PageData> listScheByUser(PageData pd)throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("ScheduleMapper.listScheByUser", pd);
	}
	
	
	
	/**
	 * 查询今日课表下的课程
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listScheByTime(PageData pd) throws Exception{
		return (List<PageData>)dao.findForList("ScheduleMapper.listScheByTime", pd);
	}
	/**
	 * 查询今日有课的老师
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listTeacherByTime(PageData pd) throws Exception{
		return (List<PageData>)dao.findForList("ScheduleMapper.listTeacherByTime", pd);
	}
	
}

