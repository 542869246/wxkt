package com.flc.service.system.leave;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 请假表接口
 * 创建人：FLC
 * 创建时间：2018-03-26
 * @version
 */
public interface LeaveManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public int save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public int delete(PageData pd)throws Exception;
	
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
	
	/**删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public int deleteAll(PageData pd)throws Exception;
	
	/**批量添加请假信息 
	 * @param pd
	 * @throws Exception
	 */
	public void saveAllLeave(PageData pd)throws Exception;
	
	/**根据user_id获取学生信息
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findByUserId(PageData pd)throws Exception;
	
	/**根据时间和学生获取科目信息
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findByTimeAndId(PageData pd)throws Exception;
	
	
	/**根据时间和学生id,教师id获取数量
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> selByIdTime(PageData pd)throws Exception;
}

