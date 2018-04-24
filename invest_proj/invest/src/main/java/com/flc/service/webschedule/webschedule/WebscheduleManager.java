package com.flc.service.webschedule.webschedule;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 用户日程表接口
 * 创建人：FLC
 * 创建时间：2017-12-06
 * @version
 */
public interface WebscheduleManager{

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
	 * @return 
	 * @throws Exception
	 */
	public Object edit(PageData pd)throws Exception;
	
	/**修改状态
	 * @param pd
	 * @throws Exception
	 */
	public void editStates(PageData pd)throws Exception;
	
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

	public void delete_pl(PageData pd)throws Exception;

	public List<PageData> pl_list(Page page)throws Exception;

	public void deletepl_All(String[] arrayDATA_IDS)throws Exception;
	
	/**
	 * 通过学生ID查询  学生的学习日程是否被查看
	 * @param pageData
	 * @return
	 */
	public List<PageData> findLookByStu(PageData pageData)throws Exception;
	
}

