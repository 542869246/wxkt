package com.flc.service.web.webstudy;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 科目信息反馈表接口
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
public interface WebStudyManager{

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
	 * 根据日程id查询科目反馈表
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findListByScheduleId(PageData pd)throws Exception;
	/**
	 * 根据日程id查询科目反馈表
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findListByScheduleIdAndCourseName(PageData pd)throws Exception;
}

