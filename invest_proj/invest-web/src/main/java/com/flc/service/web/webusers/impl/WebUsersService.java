package com.flc.service.web.webusers.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.service.web.webusers.WebUsersManager;
import com.flc.util.PageData;

/** 
 * 说明： 用户表
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
@Service("webusersService")
public class WebUsersService implements WebUsersManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("WebUsersMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("WebUsersMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("WebUsersMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("WebUsersMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("WebUsersMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("WebUsersMapper.findById", pd);
	}
	/**通过id获取是否是教师
	 * @param pd
	 * @throws Exception
	 */
	public PageData findisTeacher(PageData pd)throws Exception{
		return (PageData)dao.findForObject("WebUsersMapper.findisTeacher", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("WebUsersMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public PageData findByUSER_OPPNID(PageData pd) throws Exception {
		return (PageData)dao.findForObject("WebUsersMapper.findByUSER_OPPNID", pd);
	}

	@Override
	public PageData findByphone(PageData pd) throws Exception {
		return (PageData)dao.findForObject("WebUsersMapper.findByPhone", pd);
	}

	/**
	 * 通过openID获取是否是教师
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findTeacherOpenId(PageData pd) throws Exception {
		return (PageData) dao.findForObject("WebUsersMapper.findTeacherOpenId", pd);
	}
}

