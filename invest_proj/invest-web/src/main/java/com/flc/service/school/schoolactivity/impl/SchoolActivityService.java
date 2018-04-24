package com.flc.service.school.schoolactivity.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.school.schoolactivity.SchoolActivityManager;

/** 
 * 说明： 活动资讯表
 * 创建人：FLC
 * 创建时间：2017-12-01
 * @version
 */
@Service("schoolactivityService")
public class SchoolActivityService implements SchoolActivityManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("SchoolActivityMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("SchoolActivityMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("SchoolActivityMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SchoolActivityMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SchoolActivityMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("SchoolActivityMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("SchoolActivityMapper.deleteAll", ArrayDATA_IDS);
	}

	/**
	 * 通过活动类型id查询活动
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findActivityTypeId(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("SchoolActivityMapper.findActivityTypeId", pd);
	}

	
/**
* 查询历史活动记录本周前
*/
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> findActivityTypeIdDate(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return(List<PageData>)dao.findForList("SchoolActivityMapper.findActivityTypeIdDate", pd);
	}
	
}

