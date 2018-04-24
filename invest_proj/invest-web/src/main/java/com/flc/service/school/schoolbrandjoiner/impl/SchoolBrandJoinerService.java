package com.flc.service.school.schoolbrandjoiner.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.service.school.schoolbrandjoiner.SchoolBrandJoinerManager;
import com.flc.util.PageData;

/** 
 * 说明： 品牌入驻的报名
 * 创建人：FLC
 * 创建时间：2017-12-19
 * @version
 */
@Service("schoolbrandjoinerService")
public class SchoolBrandJoinerService implements SchoolBrandJoinerManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("SchoolBrandJoinerMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("SchoolBrandJoinerMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("SchoolBrandJoinerMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SchoolBrandJoinerMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SchoolBrandJoinerMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("SchoolBrandJoinerMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("SchoolBrandJoinerMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public PageData findUser(PageData joiner) throws Exception {
		return (PageData)dao.findForObject("SchoolBrandJoinerMapper.findUser", joiner);
	}
	
}

