package com.flc.service.system.products.attribute.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.service.system.products.attribute.AttributeManager;
import com.flc.util.PageData;

/** 
 * 说明： 产品属性详细信息
 * 创建人：FLC
 * 创建时间：2017-10-20
 * @version
 */
@Service("attributeService")
public class AttributeService implements AttributeManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("AttributeMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("AttributeMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("AttributeMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("AttributeMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AttributeMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AttributeMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("AttributeMapper.deleteAll", ArrayDATA_IDS);
	}

	@SuppressWarnings("unchecked")
	public List<PageData> listMoreTable(Page page) throws Exception {
		return (List<PageData>)dao.findForList("AttributeMapper.findMoreTable", page);
	}
	/**
	 * 通过类型名称查询ID
	 * @param object
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public PageData findTypeByName(PageData pd) throws Exception {
		return (PageData)dao.findForObject("AttributeMapper.findTypeIdByName", pd);
	}
	
	/**
	 * 根据产品ID查询产品属性
	 */
	public List<PageData> findAttrByProid(PageData pd) throws Exception{
		return (List<PageData>)dao.findForList("AttributeMapper.findAttrByProId", pd);
	}
	/**
	 * 修改属性默认值
	 */
	public void editVal(PageData pd) throws Exception {
		dao.update("AttributeMapper.editVal", pd);
		
	}
	
	/**
	 * ajax 修改
	 */
	public void ajaxEdit(PageData pd) throws Exception {
		dao.update("AttributeMapper.ajaxEdit", pd);
	}
	/**
	 * 删除产品属性关系
	 */
	public void deleteGuanxi(PageData pd) throws Exception {
		dao.delete("AttributeMapper.deleteGuanxi", pd);
	}
	/**
	 * 根据属性id查询默认值
	 */
	
	public PageData findAttrValue(PageData pd) throws Exception {
		return (PageData)dao.findForObject("AttributeMapper.findAttrValue", pd);
	}
	
	/**
	 * 新增关系
	 */
	public void saveGuanxi(PageData pd) throws Exception {
		dao.save("AttributeMapper.saveGuanxi", pd);
	}
}

