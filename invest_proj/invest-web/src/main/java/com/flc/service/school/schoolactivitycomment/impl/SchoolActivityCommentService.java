package com.flc.service.school.schoolactivitycomment.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.school.schoolactivitycomment.SchoolActivityCommentManager;

/** 
 * 说明： 活动评论表
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
@Service("schoolactivitycommentService")
public class SchoolActivityCommentService implements SchoolActivityCommentManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("SchoolActivityCommentMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("SchoolActivityCommentMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("SchoolActivityCommentMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SchoolActivityCommentMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SchoolActivityCommentMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("SchoolActivityCommentMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("SchoolActivityCommentMapper.deleteAll", ArrayDATA_IDS);
	}

	/**
	 * 根据活动资讯id查询
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findlist(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("SchoolActivityCommentMapper.findlist",pd);
	}
	
}

