package com.flc.service.webuser.webuser;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 家长和学生的关联表接口
 * 创建人：FLC
 * 创建时间：2017-12-01
 * @version
 */
public interface WebuserManager{

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
	 * 通过用户ID查询用户（也可以通过学生ID查询学生）
	 * @param pd
	 * @return
	 */
	public PageData findByUsersId(PageData pd)throws Exception;
	/**
	 * 通过用户ID修改用户是否是会员
	 * @param string
	 * @throws Exception
	 */
	public void updateUsers_ismember(PageData pd)throws Exception;
	
}

