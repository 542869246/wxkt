package com.flc.service.arrange.arrange.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.arrange.arrange.ArrangeManager;

/** 
 * 说明： 课程安排表
 * 创建人：FLC
 * 创建时间：2017-12-02
 * @version
 */
@Service("arrangeService")
public class ArrangeService implements ArrangeManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ArrangeMapper.save", pd);
	}
	
	/**批量添加请假信息 
	 * @param pd
	 * @throws Exception
	 */
	public void saveAllLeave(PageData pd)throws Exception{
		dao.save("ArrangeMapper.saveAllLeave", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ArrangeMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ArrangeMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ArrangeMapper.datalistPage", page);
	}
	
	/**请假列表(当前lessons)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> lessonsNoLeaveList(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ArrangeMapper.lessonsNoLeaveList", pd);
	}
	
	/**这个lessons没请假的学生(当前lessons)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> leaveList(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ArrangeMapper.leaveList", pd);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ArrangeMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ArrangeMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ArrangeMapper.deleteAll", ArrayDATA_IDS);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<String> findStudentByArrangeId(String[] arrayDATA_IDS) throws Exception {
		return (List<String>) dao.findForList("ArrangeMapper.findStudentByArrangeId", arrayDATA_IDS);
	}
	/**
	 * 根据学生ID删除关联表
	 */
	@Override
	public void deleteByStu(PageData pd) throws Exception {
		dao.delete("ArrangeMapper.deleteByStu", pd);
	}
	/**
	 * 根据课程ID查询课程下的学生
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> listStuById(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("ArrangeMapper.listStuById", pd);
	}
}

