package com.flc.service.school.shcoolschedule;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 课表接口
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
public interface ShcoolScheduleManager{

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
	
	
	/** 通过教师和当天日期获取课程 */
	public List<PageData> findByTeachAndDateTset(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByIdMore(PageData pd)throws Exception;
	
	/**通过教师和当天日期获取数据 
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findByTeachAndDate(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	/**
	 * 根据课程id查询课表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findListByCourseId(List<PageData> pd)throws Exception;
	
	/**
	 * 根据时间查询课表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findListByTime(PageData pd)throws Exception;
	/**
	 * 根据老师id和时间查询当日课程
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findByUserIdAndTime(PageData pd)throws Exception;
	
	
}

