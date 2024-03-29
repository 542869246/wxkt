package com.flc.service.school.schoolref.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.service.school.schoolref.SchoolRefManager;
import com.flc.util.PageData;


/** 
 * 说明： 课程表
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
@Service("schoolrefService")
public class SchoolRefService implements SchoolRefManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("SchoolRefMapper.save", pd);
	}

	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("SchoolRefMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("SchoolRefMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SchoolRefMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SchoolRefMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("SchoolRefMapper.findById", pd);
	}
	
	
	
	/**通过teacherid获取数据
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findByTeacherid(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SchoolRefMapper.findByTeacherid", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("SchoolRefMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

