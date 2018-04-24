package com.flc.service.web.messageinfo;

import java.util.List;

import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 存续消息展示接口
 * 创建人：FLC
 * 创建时间：2017-10-22
 * @version
 */
public interface MessageinfoManager{
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**
	 * 查询总记录数
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int getTotalResult(PageData pd)throws Exception;
	
	/**
	 * 查询用户全部消息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> selectAll(PageData pd)throws Exception;
	
	/**
	 * 根据ID查询产品信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> selectall()throws Exception;
	
	/**
	 * 根据id查询产品
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findinformationbyid(String id)throws Exception;
	
	
	/**
	 * 根据id查询系统信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findmessageinfobyid(String id)throws Exception;
	
}

