package com.flc.service.system.products.information;

import java.util.List;
import java.util.Map;

import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.util.PageData;

/** 
 * 说明： 产品存蓄信息接口
 * 创建人：FLC
 * 创建时间：2017-10-26
 * @version
 */
public interface InformationManager{

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
	
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list1(Page page)throws Exception;
	
	
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
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> listAllDict(String parentId) throws Exception;
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Dictionaries> listAllDict1(String parentId) throws Exception;

	/**
	 * 放入默认组
	 * @param pd
	 * @throws Exception
	 */
	public void groupUser(PageData pd)throws Exception;

	/**
	 * 修改分组
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void editGroupUser(PageData pd)throws Exception;

	public void delGroup(PageData pd)throws Exception;
	
}

