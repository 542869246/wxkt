package com.flc.service.web.webusers;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 用户表接口
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
public interface WebUsersManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**判断是否tea
	 * @param pd
	 * @throws Exception
	 */
	public PageData findisTeacher(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	/**
	 * 根据oppid查询学生
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUSER_OPPNID(PageData pd) throws Exception;
	/**
	 * 根据学生电话查询学生
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByphone(PageData pd) throws Exception;
	
	/**
	 * 通过openID获取是否是教师
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findTeacherOpenId(PageData pd) throws Exception;
	
}

