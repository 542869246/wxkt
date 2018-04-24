package com.flc.service.system.invest;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 产品信息关联表接口
 * 创建人：FLC
 * 创建时间：2017-10-31
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
	 * 去没有购买该产品的用户页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findUser(Page page)throws Exception;

	/**
	 * 产品关联用户
	 * @param pd
	 * @throws Exception
	 */
	public void guanlianUser(PageData pd)throws Exception;

	/**
	 *  修改关联状态  (删除) 
	 * @param pd
	 */
	public void delInvestUser(PageData pd)throws Exception;
	
}

