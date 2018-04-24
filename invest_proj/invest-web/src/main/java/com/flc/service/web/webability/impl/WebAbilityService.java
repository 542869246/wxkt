package com.flc.service.web.webability.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.web.webability.WebAbilityManager;

/** 
 * 说明： 学生能力表
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
@Service("webabilityService")
public class WebAbilityService implements WebAbilityManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public int save(PageData pd)throws Exception{
		return (int) dao.save("WebAbilityMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("WebAbilityMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("WebAbilityMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("WebAbilityMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("WebAbilityMapper.listAll", pd);
	}
	
	/**一个学生的批次信息
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findByStu(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("WebAbilityMapper.findByStu", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("WebAbilityMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("WebAbilityMapper.deleteAll", ArrayDATA_IDS);
	}

	/**
	 * 通过学生id查询总积分
	 */
	public PageData findStudentById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("WebAbilityMapper.findStudentById", pd);
	}
	

	/**
	 * 通过学生id查询能力集合
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findList(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("WebAbilityMapper.findList", pd);
	}
	
	/**
	 * 通过学生Id查询能力集合和能力类型
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findAndAbilityTypeList(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("WebAbilityMapper.findAndAbilityTypeList",pd);
	}

	@SuppressWarnings("unchecked")
	public List<PageData> findTotaAbilityValueByStu(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("WebAbilityMapper.findTotaAbilityValueByStu",pd);
	}

	/**
	 * 根据学生id，课程id和时间段查询能力值列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByIdAndTime(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("WebAbilityMapper.findByIdAndTime",pd);
	}

	/**能力值部分修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public int editvalue(PageData pd) throws Exception {
		return (int) dao.update("WebAbilityMapper.editvalue", pd);
	}

	

	
}

