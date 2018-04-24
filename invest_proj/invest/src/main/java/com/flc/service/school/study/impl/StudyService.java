package com.flc.service.school.study.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.school.study.StudyManager;

/** 
 * 说明： 学生信息反馈
 * 创建人：FLC
 * 创建时间：2017-12-07
 * @version
 */
@Service("studyService")
public class StudyService implements StudyManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("StudyMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("StudyMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("StudyMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("StudyMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("StudyMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("StudyMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("StudyMapper.deleteAll", ArrayDATA_IDS);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> searchStudy(Page page) throws Exception {
		return (List<PageData>)dao.findForList("StudyMapper.searchStudy",page);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<String> seachStudyId(String[] s) throws Exception {
		return (List<String>)dao.findForList("StudyMapper.searchStudyId", s);
	}
	/**
	 * 批量修改
	 */
	@Override
	public PageData findByUpdate(PageData pd) throws Exception {
		return (PageData)dao.findForObject("StudyMapper.findByUpdate", pd);
	}
	/**
	 * 批量修改
	 */
	@Override
	public void edit_pl(PageData pd) throws Exception {
		dao.update("StudyMapper.edit_pl", pd);
	}
	/**
	 * 批量删除
	 */
	@Override
	public void delete_pl(PageData pd) throws Exception {
		dao.delete("StudyMapper.delete_pl", pd);
		
	}
}

