package com.flc.service.web.userinfo;

import java.util.List;
import java.util.Map;

import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.util.PageData;

/** 
 * 说明： 前端用户注册保存接口
 * 创建人：FLC
 * 创建时间：2017-10-18
 * @version
 */
public interface UserinfoManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**新增用户产品关联信息
	 * @param pd
	 * @throws Exception
	 */
	public void saveUserInvest(PageData pd)throws Exception;
	
	
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
	
	/**通过用户id获取购买产品品类分页
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findProdictsByUserId(Page page)throws Exception;
	
	/**通过用户id获取购买产品品类所有
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findProdictsByUserIdToAll(PageData pd)throws Exception;
	
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
	
	/**查询所有等级类型
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> userLevel(Page page)throws Exception;
	
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Dictionaries> listAllDict(String parentId) throws Exception;
	
	
	/**逻辑删除用户购买产品
	 * @param pd
	 * @throws Exception
	 */
	public void delProducts(PageData pd)throws Exception;
	
	
	/**
	 * 获得所有产品的父列表
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public List<Dictionaries> findProducts(String parentId) throws Exception;
	

	/**
	 * 修改用户产品关联表信息
	 * @param pd
	 * @throws Exception 
	 */
	public void updateInvest(PageData pd) throws Exception;
	

	/**
	 * 修改用户产品关联表的产品类型 
	 * @param pd
	 * @throws Exception 
	 */
	public void updateEndDict(PageData pd) throws Exception;
	
	/**
	 * 批量新增用户购买产品
	 * @param map
	 * @throws Exception
	 */
	public void batchSave(PageData pd) throws Exception;
}

