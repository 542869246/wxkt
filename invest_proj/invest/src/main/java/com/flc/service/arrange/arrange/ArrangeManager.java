package com.flc.service.arrange.arrange;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 课程安排表接口
 * 创建人：FLC
 * 创建时间：2017-12-02
 * @version
 */
public interface ArrangeManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**批量添加请假信息 
	 * @param pd
	 * @throws Exception
	 */
	public void saveAllLeave(PageData pd)throws Exception;
	
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
	 * 根据ID查询 学生
	 * @param arrayDATA_IDS
	 * @return
	 * @throws Exception
	 */
	public List<String> findStudentByArrangeId(String[] arrayDATA_IDS)throws Exception;
	/**
	 * 根据学生ID删除关联表
	 * @param pd
	 * @throws Exception
	 */
	public void deleteByStu(PageData pd)throws Exception;
	/**
	 * 根据课程ID查询课程下的学生
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listStuById(PageData pd)throws Exception;

}

