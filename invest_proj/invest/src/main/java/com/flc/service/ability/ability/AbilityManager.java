package com.flc.service.ability.ability;

import java.util.List;
import java.util.Map;

import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 学生能力积分值接口
 * 创建人：FLC
 * 创建时间：2017-12-01
 * @version
 */
public interface AbilityManager{

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
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
	/**
	 * 通过学生id查找对应的能力值
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findByStudentId(String STUDENT_ID)throws Exception;
	/**
	 * 计算总积分
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> sumCode(PageData pd)throws Exception;
	/**
	 * 计算能力值各项总值
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> searchAbili(PageData pd)throws Exception;
	
}

