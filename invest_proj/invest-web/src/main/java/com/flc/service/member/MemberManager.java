package com.flc.service.member;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 学员接口
 * 创建人：FLC
 * 创建时间：2017-08-16
 * @version
 */
public interface MemberManager{

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
	
	/**通过id获取数据锁行
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByIdLock(PageData pd)throws Exception;
	
	/**通过条件获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData find(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;

	/**
	 * 生成socket
	 * @param seachMemberPd
	 */
	public void createSocket(PageData seachMemberPd)throws Exception;
	
	//验证新手机号
	public PageData findTel(PageData pd)throws Exception;
	//验证旧手机号
	public PageData findJiu(PageData pd)throws Exception;
	
	public void editZy(PageData pd)throws Exception;
	
	//验证新手机号
	public PageData findShou(PageData pd)throws Exception;
	
	public PageData findByIdOnly(PageData pd) throws Exception;
}

