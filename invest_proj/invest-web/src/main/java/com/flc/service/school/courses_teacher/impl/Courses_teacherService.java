package com.flc.service.school.courses_teacher.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.school.courses_teacher.Courses_teacherManager;

/** 
 * 说明： 老师和课程的关联
 * 创建人：FLC
 * 创建时间：2018-03-05
 * @version
 */
@Service("courses_teacherService")
public class Courses_teacherService implements Courses_teacherManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("Courses_teacherMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("Courses_teacherMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("Courses_teacherMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Courses_teacherMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Courses_teacherMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Courses_teacherMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("Courses_teacherMapper.deleteAll", ArrayDATA_IDS);
	}
	/**
	 * 根据老师id查询课程
	 */
	@Override
	public List<PageData> listAllByUserId(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("Courses_teacherMapper.listAllByUserId", pd);
	}

	@Override
	public PageData findByName(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("Courses_teacherMapper.findByName", pd);
	}
}

