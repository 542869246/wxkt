package com.flc.service.web.message;

import java.util.List;

import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 系统消息页面展示接口
 * 创建人：FLC
 * 创建时间：2017-10-20
 * @version
 */
public interface MessageManager{
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(Page page)throws Exception;
	
	
	/**
	 * 查询系统消息总记录数
	 */
	public int getTotalRTesult()throws Exception;
	
	/**
	 * 根据消息ID查询信息
	 * @param pd
	 * 
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	/**
	 * 查询系统消息所有信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> selectAllSys(PageData pd)throws Exception;
}

