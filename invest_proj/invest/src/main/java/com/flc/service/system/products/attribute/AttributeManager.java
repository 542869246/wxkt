package com.flc.service.system.products.attribute;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 产品属性详细信息接口
 * 创建人：FLC
 * 创建时间：2017-10-20
 * @version
 */
public interface AttributeManager{

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

	public List<PageData> listMoreTable(Page page)throws Exception;
	/**
	 * 通过类型名称查询ID
	 * @param object
	 * @return
	 * @throws Exception
	 */
	public PageData findTypeByName(PageData pd)throws Exception;

	/**
	 * 通过产品ID查询属性
	 * @param pd
	 * @return
	 */
	public List<PageData> findAttrByProid(PageData pd)throws Exception;
	/**
	 * 修改属性默认值
	 * @param pd
	 * @throws Exception
	 */
	public void editVal(PageData pd)throws Exception;

	/**
	 * ajax 修改
	 * @param pd
	 * @throws Exception
	 */
	public void ajaxEdit(PageData pd)throws Exception;

	/**
	 * 删除产品属性关系
	 * @param pd
	 * @throws Exception
	 */
	public void deleteGuanxi(PageData pd)throws Exception;

	/**
	 *获取属性默认值
	 */
	public PageData findAttrValue(PageData pd)throws Exception;

	/**
	 * 新增关系
	 * @param pd
	 * @throws Exception
	 */
	public void saveGuanxi(PageData pd)throws Exception;
	
}

