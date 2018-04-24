package com.flc.service.web.webschedule;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 学生日程表接口
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
public interface WebScheduleManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**根据日报类型和lesson_id得到数量
	 * @param pd
	 * @throws Exception
	 */
	public void editByTypeAndLes(PageData pd)throws Exception;
	
	/**根据日报类型和lesson_id修改日报
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> getListByTypeAndLes(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @return 
	 * @throws Exception
	 */
	public Object edit(PageData pd)throws Exception;
	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editByISLook(PageData pd) throws Exception;
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**获得列表消息数量
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> getListNum(PageData pd)throws Exception;
	
	/**获得所有列表消息数量
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> getListNumAll(PageData pd)throws Exception;
	
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**查询出这个老师下的科目
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData>  subjectlist(PageData pd)throws Exception;
	
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	 
	 /**通过id获取需要自己审核日报
		 * @param pd
		 * @throws Exception
		 */
		public List<PageData> findStats(PageData pd)throws Exception;
		
		 /**通过id获取自己的日报
		 * @param pd
		 * @throws Exception
		 */
		public List<PageData> findMydaily(PageData pd)throws Exception;
		
		
		 /**通过学生id获取学生班级
		 * @param pd
		 * @throws Exception
		 */
		public List<PageData> CoursekelistPage(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;

	/**
	 * 根据学生id查询日程表
	 */
	public List<PageData> findByStudentList(PageData pd)throws Exception;
	
	/**
	 * 根据学生COURSE_ID获取学生
	 */
	public List<PageData> findByCouseid(PageData pd)throws Exception;
}

