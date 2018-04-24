package com.flc.service.webuser.webuser.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.webuser.webuser.WebuserManager;

/** 
 * 说明： 家长和学生的关联表
 * 创建人：FLC
 * 创建时间：2017-12-01
 * @version
 */
@Service("webuserService")
public class WebuserService implements WebuserManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("WebuserMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("WebuserMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("WebuserMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("WebuserMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("WebuserMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("WebuserMapper.findById", pd);
	}
	/**
	 * 根据用户ID查询用户信息
	 */
	@Override
	public PageData findByUsersId(PageData pd)throws Exception{
		
		return (PageData)dao.findForObject("WebuserMapper.findByUsersId", pd);
	}
	/**
	 * 根据用户ID修改用户是否会员
	 */
	@Override
	public void updateUsers_ismember(PageData pd) throws Exception {
		
		dao.update("WebuserMapper.updateUsers_ismember", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("WebuserMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

