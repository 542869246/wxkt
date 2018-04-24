package com.flc.service.system.invest.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.system.invest.InvestManager;

/** 
 * 说明： 产品信息关联表
 * 创建人：FLC
 * 创建时间：2017-10-31
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
	
	/**通过id获取数据
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
	 * 没有购买产品的用户列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findUser(Page page) throws Exception {
		return (List<PageData>)dao.findForList("InvestMapper.findUser", page);
	}
	
	/**
	 * 产品关联用户
	 */
	public void guanlianUser(PageData pd) throws Exception {
		dao.save("InvestMapper.guanlianUser", pd);
	}
	
	/**
	 *  修改关联状态  (删除) 
	 * @param pd
	 */
	public void delInvestUser(PageData pd) throws Exception {
		dao.update("InvestMapper.delInvestUser", pd);
	}
}

