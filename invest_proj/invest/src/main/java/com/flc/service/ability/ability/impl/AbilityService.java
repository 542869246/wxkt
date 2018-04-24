package com.flc.service.ability.ability.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.ability.ability.AbilityManager;

/** 
 * 说明： 学生能力积分值
 * 创建人：FLC
 * 创建时间：2017-12-01
 * @version
 */
@Service("abilityService")
public class AbilityService implements AbilityManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("AbilityMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("AbilityMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("AbilityMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("AbilityMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AbilityMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AbilityMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("AbilityMapper.deleteAll", ArrayDATA_IDS);
	}

	/**
	 * 通过学生id查找对应的能力值
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findByStudentId(String STUDENT_ID) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("AbilityMapper.findByStudentId", STUDENT_ID);
	}
	/**
	 * 通过学生ID  计算此学生的能力积分值
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> sumCode(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("AbilityMapper.sumCode", pd);
	}
	/**
	 * 计算学生的各项能力值的总值
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> searchAbili(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("AbilityMapper.searchAbili", pd);
	}
	
}

