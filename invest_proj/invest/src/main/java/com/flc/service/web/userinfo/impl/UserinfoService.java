package com.flc.service.web.userinfo.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.util.PageData;
import com.flc.service.web.userinfo.UserinfoManager;

/** 
 * 说明： 前端用户注册保存
 * 创建人：FLC
 * 创建时间：2017-10-18
 * @version
 */
@Service("userinfoService")
public class UserinfoService implements UserinfoManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("UserinfoMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("UserinfoMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("UserinfoMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("UserinfoMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("UserinfoMapper.listAll", pd);
	}
	
	/**通过id获取用户信息
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("UserinfoMapper.findById", pd);
	}
	
	/**通过用户id获取购买产品品类分页
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findProdictsByUserId(Page page)throws Exception{
		return (List<PageData>)dao.findForList("UserinfoMapper.datalistPageFindProdictsByUserId", page);
	}
	
	/**通过用户id获取购买产品品类分页
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findProdictsByUserIdToAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("UserinfoMapper.findProdictsByUserIdToAll", pd);
	}
	
	
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("UserinfoMapper.deleteAll", ArrayDATA_IDS);
	}
	
	
	/**查询所有等级类型
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> userLevel(Page page)throws Exception{
		return (List<PageData>)dao.findForList("UserinfoMapper.userLevel", page);
	}
	
	
	/**
	 * 通过ID获取其子级列表
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Dictionaries> listSubDictByParentId(String parentId) throws Exception {
		return (List<Dictionaries>) dao.findForList("DictionariesMapper.listSubDictByParentId", parentId);
	}
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Dictionaries> listAllDict(String parentId) throws Exception {
		List<Dictionaries> dictList = this.listSubDictByParentId(parentId);
		for(Dictionaries dict : dictList){
			String parent_id = dict.getPARENT_ID();
			if("0".equals(parent_id) || null == parent_id){
				dict.setTreeurl("userinfo/list.do?USER_GROUPID= "+"&groupType="+dict.getDICTIONARIES_ID());
			}else{
				dict.setTreeurl("userinfo/list.do?USER_GROUPID="+dict.getDICTIONARIES_ID());
			}
			dict.setSubDict(this.listAllDict(dict.getDICTIONARIES_ID()));
			dict.setTarget("treeFrame");
		}
		return dictList;
	}
	

	/**逻辑删除用户购买产品
	 * @param pd
	 * @throws Exception
	 */
	public void delProducts(PageData pd)throws Exception{
		dao.update("UserinfoMapper.delProducts", pd);
	}
	
	/**
	 * 获得所有产品的父列表
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Dictionaries> findProducts(String parentId) throws Exception {
		return (List<Dictionaries>) dao.findForList("DictionariesMapper.listSubDictByParentId", parentId);
	}

	@Override
	public void saveUserInvest(PageData pd) throws Exception {
		dao.save("UserinfoMapper.saveUserInvest", pd);
	}
	
	/**
	 * 修改用户产品关联表信息
	 * @param pd
	 * @throws Exception 
	 */
	public void updateInvest(PageData pd) throws Exception{
		dao.update("UserinfoMapper.updateInvest",pd);
	}
	
	
	
	
	/**
	 * 修改用户产品关联表的产品类型 
	 * @param pd
	 * @throws Exception 
	 */
	public void updateEndDict(PageData pd) throws Exception{
		dao.update("UserinfoMapper.updateEndDict",pd);
	}

	public void batchSave(PageData pd) throws Exception {
		dao.save("UserinfoMapper.batchSave", pd);
	}
	
}

