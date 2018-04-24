package com.flc.service.web.invest.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.web.invest.InvestManager;

/** 
 * 说明： 产品信息分组信息用户信息关联表
 * 创建人：FLC
 * 创建时间：2017-10-25
 * @version
 */
@Service("investService")
public class InvestService implements InvestManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("InvestMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("InvestMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("InvestMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("InvestMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("InvestMapper.listAll", pd);
	}
	
	/**查询用户是否购买产品
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("InvestMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("InvestMapper.deleteAll", ArrayDATA_IDS);
	}
	
	/**
	 * 用户按照分组数据查询
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findByUidGroupBY(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("InvestMapper.findByUidGroupBY", pd);
	}
	
	/**
	 * 根据用户和分组信息查询每个人的产品信息
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByInvestId(Page page) throws Exception {
		return (List<PageData>) dao.findForList("InvestMapper.findByInvestId", page);
	}
}

