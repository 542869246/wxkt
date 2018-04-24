package com.flc.service.system.dictionaries;

import java.util.List;
import java.util.Map;

import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.util.PageData;

/** 
 * 说明： 字典表接口
 * 创建人：FLC
 * 创建时间：2017-10-20
 * @version
 */
public interface DictionariesManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	/**
	 * 通过ID获取其子级列表
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public List<Dictionaries> listSubDictByParentId(String parentId) throws Exception;
	
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
	/**
	 * 根据编号查询数据
	 */
	public PageData findByBianmaId(PageData pd)throws Exception;
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**通过id获取数据集合
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findListById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
	/**
	 * 查询所有产品的所有模块产品
	 * @param pd
	 * @throws Exception
	 */
	public Map selectProperty(PageData pd) throws Exception;
	
	/**
	 * 查询产品下的背景图片
	 * @param pd
	 * @throws Exception
	 */
	public PageData selectPropertys(PageData pd) throws Exception;
	
	/**
	 * 查询所有产品的所有模块产品
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findProperty(PageData pd) throws Exception;
	
	/**
	 * 查询产品下的背景图片
	 * @param pd
	 * @throws Exception
	 */
	public PageData selectfindImgId(PageData pd) throws Exception;
	/**通过Dictid获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByDictId(PageData pd)throws Exception;
	/**
	 * 心愿值
	 */
	public PageData count() throws Exception;
}

