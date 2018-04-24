package com.flc.service.system.leave.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.service.system.leave.LeaveManager;
import com.flc.util.PageData;

/** 
 * 说明： 请假表
 * 创建人：FLC
 * 创建时间：2018-03-26
 * @version
 */
@Service("leaveService")
public class LeaveService implements LeaveManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public int save(PageData pd)throws Exception{
		return (int) dao.save("LeaveMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public int delete(PageData pd)throws Exception{
		return (int) dao.delete("LeaveMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("LeaveMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("LeaveMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("LeaveMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("LeaveMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public int deleteAll(PageData pd)throws Exception{
		return (int) dao.delete("LeaveMapper.deleteAll", pd);
	}
	
	/**批量添加请假信息 
	 * @param pd
	 * @throws Exception
	 */
	public void saveAllLeave(PageData pd)throws Exception{
		dao.save("LeaveMapper.saveAllLeave", pd);
	}

	/**根据user_id获取学生信息
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findByUserId(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("LeaveMapper.findByUserId", pd);
	}

	/**根据时间和学生获取科目信息
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findByTimeAndId(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("LeaveMapper.findByTimeAndId", pd);
	}

	/**根据时间和学生id,教师id获取数量
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> selByIdTime(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("LeaveMapper.selByIdTime", pd);
	}
	
}

