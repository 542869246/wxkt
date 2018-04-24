package com.flc.service.web.webability;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 学生能力表接口
 * 创建人：FLC
 * 创建时间：2017-12-03
 * @version
 */
public interface WebAbilityManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public int save(PageData pd)throws Exception;
	
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
	
	/**能力值部分修改
	 * @param pd
	 * @throws Exception
	 */
	public int editvalue(PageData pd)throws Exception;
	
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
	/**单个学生的批次信息
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findByStu(PageData pd)throws Exception;
	
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
	 * 通过学生id查询总积分
	 */
	public PageData findStudentById(PageData pd)throws Exception;
	
	/**
	 * 通过学生id查询能力集合
	 */
	public List<PageData> findList(PageData pd) throws Exception;
	
	/**
	 * 通过学生Id查询能力集合和能力类型
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findAndAbilityTypeList(PageData pd) throws Exception;
	
	/**
	 * 根据学生的ID查询一个批次各个能力值的总分值
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findTotaAbilityValueByStu(PageData pd)throws Exception;
	
	/**
	 * 根据学生id，课程id和时间段查询能力值列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findByIdAndTime(PageData pd)throws Exception;
}

