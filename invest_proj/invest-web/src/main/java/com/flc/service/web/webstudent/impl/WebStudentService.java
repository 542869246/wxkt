package com.flc.service.web.webstudent.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.web.webstudent.WebStudentManager;

/** 
 * 说明： 学生表
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
@Service("webstudentService")
public class WebStudentService implements WebStudentManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("WebStudentMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("WebStudentMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("WebStudentMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("WebStudentMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("WebStudentMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("WebStudentMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("WebStudentMapper.deleteAll", ArrayDATA_IDS);
	}
	/**
	 * 根据家长手机号获取学生
	 * @param pd
	 * @return pageData
	 * @throws Exception
	 */
	@Override
	public PageData findByPhone(PageData pd) throws Exception {
		return (PageData) dao.findForObject("WebStudentMapper.findByPhone", pd);
	}

	@Override
	public PageData findByIdOrderTime(List<PageData> pd) throws Exception {
		return (PageData)dao.findForObject("WebStudentMapper.findByIdOrderTime", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findByIdList(List<PageData> pd) throws Exception {
		return (List<PageData>)dao.findForList("WebStudentMapper.findByIdList", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findListByPhone(PageData stupd) throws Exception {
		return (List<PageData>)dao.findForList("WebStudentMapper.findListByPhone", stupd);
	}

	/**
	 * 根据科目id和老师id、上课时间获取学生信息
	 * @param pd
	 * @return pageData
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findBySubAndUser(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("WebStudentMapper.findBySubAndUser", pd);
	}

	/**根据科目id和老师id、上课时间获取未添加能力值学生信息
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> findUnValue(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("WebStudentMapper.findUnValue", pd);
	}
	
}

