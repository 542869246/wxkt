package com.flc.service.school.schoolarrange;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 学生课程安排表接口
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
public interface SchoolArrangeManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	/**
	 * 根据学生id查询课程安排表
	 */
	List<PageData> findByStudentId(PageData pd)throws Exception;
	/**
	 * 根据学生集合id查询课程安排表
	 */
	List<PageData> findByListStudentId(List<PageData> pd)throws Exception;

	public List<PageData> findStuId(PageData pd) throws Exception;

	public List<PageData> findByICourseid(PageData pd) throws Exception;
	public List<PageData> findByCourseid(PageData pd) throws Exception;
	public List<PageData> findByICourseid2(PageData pd) throws Exception;

	
	/**请假列表(当前lessons)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> leaveList(PageData pd)throws Exception;
	
	/**这个lessons没请假的学生(当前lessons)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> lessonsNoLeaveList(PageData pd)throws Exception;
	
	/**批量添加请假信息 
	 * @param pd
	 * @throws Exception
	 */
	public void saveAllLeave(PageData pd)throws Exception;
	
	/**这节课评价的学生 
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> lessonsEvalList(PageData pd)throws Exception;
}

