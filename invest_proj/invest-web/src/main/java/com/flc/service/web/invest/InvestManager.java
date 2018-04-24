package com.flc.service.web.invest;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 产品信息分组信息用户信息关联表接口
 * 创建人：FLC
 * 创建时间：2017-10-25
 * @version
 */
public interface InvestManager{

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
	
	/**查询用户是否购买产品
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
	 * 用户按照分组数据查询
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findByUidGroupBY(PageData pd)throws Exception;
	
	/**
	 * 根据用户和分组信息查询每个人的产品信息
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findByInvestId(Page page) throws Exception;
	
}

