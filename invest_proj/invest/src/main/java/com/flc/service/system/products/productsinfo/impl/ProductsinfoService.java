package com.flc.service.system.products.productsinfo.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.system.products.productsinfo.ProductsinfoManager;

/** 
 * 说明： 产品管理
 * 创建人：FLC
 * 创建时间：2017-10-24
 * @version
 */
@Service("productsinfoService")
public class ProductsinfoService implements ProductsinfoManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ProductsinfoMapper.save", pd);
	}
	
	/**删除产品相关的所有信息
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ProductsinfoMapper.delete", pd);
		dao.delete("ProductsinfoMapper.delProMartion", pd);
		dao.delete("ProductsinfoMapper.delProGroupMartion", pd);
		dao.delete("ProductsinfoMapper.delProDetails", pd);
		dao.delete("ProductsinfoMapper.delProNews", pd);
		dao.delete("ProductsinfoMapper.delProAttr", pd);
		dao.update("ProductsinfoMapper.delProUser", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ProductsinfoMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ProductsinfoMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProductsinfoMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProductsinfoMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ProductsinfoMapper.deleteAll", ArrayDATA_IDS);
	}
	
	@Override
	public List<PageData> findProductByType(Page page) throws Exception {
		return (List<PageData>)dao.findForList("ProductsinfoMapper.findProductByTypeId", page);
	}
	/**
	 *查询所有产品信息  不分页 
	 */
	@Override
	public List<PageData> selectAllProducts() throws Exception {
		return (List<PageData>) dao.findForList("ProductsinfoMapper.selectAllProducts", null);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findAttrById(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("ProductsinfoMapper.findAttrById", pd);
	}
	
}

