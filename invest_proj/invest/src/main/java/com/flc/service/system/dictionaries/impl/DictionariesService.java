package com.flc.service.system.dictionaries.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.util.PageData;

/** 
 * 说明： 数据字典
 * 创建人：FLC
 * 创建时间：2015-12-16
 * @version
 */
@Service("dictionariesService")
public class DictionariesService implements DictionariesManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("DictionariesMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("DictionariesMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("DictionariesMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("DictionariesMapper.datalistPage", page);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DictionariesMapper.findById", pd);
	}
	
	/**通过编码获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByBianma(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DictionariesMapper.findByBianma", pd);
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
			dict.setTreeurl("dictionaries/list.do?DICTIONARIES_ID="+dict.getDICTIONARIES_ID());
			dict.setSubDict(this.listAllDict(dict.getDICTIONARIES_ID()));
			dict.setTarget("treeFrame");
		}
		return dictList;
	}
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)zjt
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Dictionaries> listAllDictInfo(String parentId) throws Exception {
		List<Dictionaries> dictList = this.listSubDictByParentId(parentId);
		for(Dictionaries dict : dictList){
			//dict.setTreeurl("dictionaries/list.do?DICTIONARIES_ID="+dict.getDICTIONARIES_ID());
			dict.setSubDict(this.listAllDict(dict.getDICTIONARIES_ID()));
			dict.setTarget("treeFrame");
		}
		return dictList;
	}
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> listAllDictForAttr(String parentId) throws Exception {
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		this.listChildDictForAttr(list,parentId);
		return list;
	}
	
	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> listChildDictForAttr(List<Map<String,Object>> list,String parentId) throws Exception {
		List<Dictionaries> dictList = this.listSubDictByParentId(parentId);
		Map<String,Object> map = null;
		for(Dictionaries dict : dictList){
			map = new HashMap<String,Object>();
			map.put("id", dict.getDICTIONARIES_ID());
			map.put("pId", dict.getPARENT_ID());
			map.put("name", dict.getNAME());
			//map.put("url", "productsinfo/list.do?product_type="+dict.getDICTIONARIES_ID());
			list.add(map);
			this.listChildDictForAttr(list,dict.getDICTIONARIES_ID());
		}
		return list;
	}
	
	
	/**排查表检查是否被占用
	 * @param pd
	 * @throws Exception
	 */
	public PageData findFromTbs(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DictionariesMapper.findFromTbs", pd);
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
			dict.setTreeurl("productsinfo/list.do?ATTR_TYPEID="+dict.getDICTIONARIES_ID());
			dict.setSubDict(this.listAllDict1(dict.getDICTIONARIES_ID()));
			dict.setTarget("treeFrame");
		}
		return dictList;
	}
	public List<Dictionaries> listAllDict2(String parentId) throws Exception {
		List<Dictionaries> dictList = this.listSubDictByParentId(parentId);
		for(Dictionaries dict : dictList){
			dict.setTreeurl("productsinfo/listMess.do?ATTR_TYPEID="+dict.getDICTIONARIES_ID());
			dict.setSubDict(this.listAllDict2(dict.getDICTIONARIES_ID()));
			dict.setTarget("treeFrame");
		}
		return dictList;
	}
	
	public List<Dictionaries> listAllDict3(String parentId) throws Exception {
		List<Dictionaries> dictList = this.listSubDictByParentId(parentId);
		for(Dictionaries dict : dictList){
			dict.setTreeurl("information/groupList.do?groupid="+dict.getDICTIONARIES_ID());
			dict.setSubDict(this.listAllDict1(dict.getDICTIONARIES_ID()));
			dict.setTarget("treeFrame");
		}
		return dictList;
	}
	/**
	 * 查询所有产品类型
	 */
	@Override
	public List<PageData> findallimgtype(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("DictionariesMapper.findallimgtype", null);
	}
	/**
	 * 根据类型维护名称查询  记录
	 */
	@Override
	public PageData findByName(PageData pd) throws Exception {
		return (PageData)dao.findForObject("DictionariesMapper.findByName", pd);
	}
	/**
	 * 更新这条记录的编码
	 */
	@Override
	public void update(PageData pd) throws Exception {
		dao.update("DictionariesMapper.update", pd);
	}
}

