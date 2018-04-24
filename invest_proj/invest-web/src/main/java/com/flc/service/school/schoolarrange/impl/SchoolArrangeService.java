package com.flc.service.school.schoolarrange.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.school.schoolarrange.SchoolArrangeManager;

/** 
 * 说明： 学生课程安排表
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
@Service("schoolarrangeService")
public class SchoolArrangeService implements SchoolArrangeManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("SchoolArrangeMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("SchoolArrangeMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("SchoolArrangeMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SchoolArrangeMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SchoolArrangeMapper.listAll", pd);
	}
	
	/**Courseid
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findByICourseid(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SchoolArrangeMapper.findByICourseid", pd);
	}
	
	/**Courseid2
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findByICourseid2(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SchoolArrangeMapper.findByICourseid2", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("SchoolArrangeMapper.findById", pd);
	}

	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("SchoolArrangeMapper.deleteAll", ArrayDATA_IDS);
	}
	/**
	 * 根据学生id查询课程安排表
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByStudentId(PageData pd)throws Exception {
		return (List<PageData>) dao.findForList("SchoolArrangeMapper.findByStudentId", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByListStudentId(List<PageData> pd) throws Exception {
		return (List<PageData>) dao.findForList("SchoolArrangeMapper.findByListStudentId", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findStuId(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("SchoolArrangeMapper.findStuId", pd);
	}
	/**这个lessons没请假的学生请假列表(当前lessons)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> lessonsNoLeaveList(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SchoolArrangeMapper.lessonsNoLeaveList", pd);
	}
	
	/**这个lessons请假的学生(当前lessons)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> leaveList(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SchoolArrangeMapper.leaveList", pd);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByCourseid(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("SchoolArrangeMapper.findByCourseid", pd);
	}
	
	/**批量添加请假信息 
	 * @param pd
	 * @throws Exception
	 */
	public void saveAllLeave(PageData pd)throws Exception{
		dao.save("SchoolArrangeMapper.saveAllLeave", pd);
	}
	
	/**这节课评价的学生 
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> lessonsEvalList(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SchoolArrangeMapper.lessonsEvalList", pd);
	}
	
}

