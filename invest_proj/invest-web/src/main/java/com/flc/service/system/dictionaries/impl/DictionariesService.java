package com.flc.service.system.dictionaries.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.util.PageData;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.web.productsinfo.impl.ProductsinfoService;

/** 
 * 说明： 字典表
 * 创建人：FLC
 * 创建时间：2017-10-20
 * @version
 */
@Service("dictionariesService")
public class DictionariesService implements DictionariesManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	@Resource(name="productsinfoService")
	private ProductsinfoService productsinfoService;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("DictionariesMapper.save", pd);
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
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("DictionariesMapper.listAll", pd);
	}
	/**
	 * 通过编号获取数据
	 */
	@Override
	public PageData findByBianmaId(PageData pd) throws Exception {
		return (PageData)dao.findForObject("DictionariesMapper.findByBianmaId", pd);
	}
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DictionariesMapper.findById", pd);
	}
	
	/**通过id获取数据集合
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findListById(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("DictionariesMapper.findByIdAndNow", pd);
	}
	
	
	/**通过Dictid获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByDictId(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DictionariesMapper.findByDictId", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("DictionariesMapper.deleteAll", ArrayDATA_IDS);
	}

	/**
	 * 查询模块下的子模块
	 */
	@SuppressWarnings("unchecked")
	public Map selectProperty(PageData pd) throws Exception {
		List<PageData> varList = (List<PageData>)dao.findForList("DictionariesMapper.selectProperty",pd);
		List<PageData> proList  = null;
		Map map = new HashMap<>();
		for (PageData p : varList) {
			PageData data = new PageData();
			data.put("PRODUCTS_TYPE1_ID", p.get("DICTIONARIES_ID"));
			// 查询所有模块的详情信息
			proList = productsinfoService.listAll(data);
			map.put( p.get("DICTIONARIES_ID"), proList);
		}
		map.put("varList", varList);
		return map;	
	}
	/**
	 *  查询产品的A模块
	 * @return
	 * @throws Exception 
	 */
	public List<PageData> findProperty(PageData pd) throws Exception{
		return (List<PageData>)dao.findForList("DictionariesMapper.selectPropertyCope",pd);
	}
	/**
	 * 查询产品下的背景图片
	 */
	public PageData selectPropertys(PageData pd) throws Exception {
		return (PageData)dao.findForObject("DictionariesMapper.selectPropertys",pd);
	}
	
	/**
	 * 查询产品下的背景图片
	 */
	public PageData selectfindImgId(PageData pd) throws Exception {
		return(PageData)dao.findForObject("DictionariesMapper.selectfindImgId",pd);
	}

	/**
	 * 心愿值
	 */
	public PageData count() throws Exception {
		
		return (PageData) dao.findForObject("DictionariesMapper.count",null);
	}
}

