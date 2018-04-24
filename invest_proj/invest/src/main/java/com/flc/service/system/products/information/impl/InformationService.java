package com.flc.service.system.products.information.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.service.system.products.information.InformationManager;
import com.flc.util.PageData;

/** 
 * 说明： 产品存蓄信息
 * 创建人：FLC
 * 创建时间：2017-10-26
 * @version
 */
@Service("informationService")
public class InformationService implements InformationManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("InformationMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("InformationMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("InformationMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("InformationMapper.datalistPage", page);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list1(Page page)throws Exception{
		return (List<PageData>)dao.findForList("InformationMapper.datalistPageMess", page);
	}
	
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("InformationMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("InformationMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("InformationMapper.deleteAll", ArrayDATA_IDS);
	}
	

	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> listAllDict(String parentId) throws Exception {
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		this.listChildDict(list,parentId);
		return list;
	}
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> listChildDict(List<Map<String,Object>> list,String parentId) throws Exception {
		List<Dictionaries> dictList = this.listSubDictByParentId(parentId);
		Map<String,Object> map = null;
		for(Dictionaries dict : dictList){
			map = new HashMap<String,Object>();
			map.put("id", dict.getDICTIONARIES_ID());
			map.put("pId", dict.getPARENT_ID());
			map.put("name", dict.getNAME());
			//map.put("url", "information/groupList.do?groupid="+dict.getDICTIONARIES_ID());
			list.add(map);
			this.listChildDict(list,dict.getDICTIONARIES_ID());
		}
		return list;
	}
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Dictionaries> listAllDict1(String parentId) throws Exception {
		List<Dictionaries> dictList = this.listSubDictByParentId(parentId);
		for(Dictionaries dict : dictList){
			dict.setTreeurl("productsinfo/list.do?ATTR_TYPEID="+dict.getDICTIONARIES_ID()+"&flag=1");
			dict.setSubDict(this.listAllDict1(dict.getDICTIONARIES_ID()));
			dict.setTarget("treeFrame");
		}
		return dictList;
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
	 * 放入默认组
	 * @param 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void groupUser(PageData pd) throws Exception {
		dao.save("InformationMapper.saveGroupUser", pd);
	}
	
	/**
	 * 修改分组
	 */
	@SuppressWarnings("unchecked")
	public void editGroupUser(PageData pd) throws Exception {
		dao.update("InformationMapper.editGroupUser", pd);
	}
	
	@SuppressWarnings("unchecked")
	public void delGroup(PageData pd) throws Exception {
		dao.delete("InformationMapper.delGroup", pd);
		
	}
}

