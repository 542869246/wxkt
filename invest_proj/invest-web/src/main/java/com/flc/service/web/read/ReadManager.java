package com.flc.service.web.read;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 用户阅读系统消息接口
 * 创建人：FLC
 * 创建时间：2017-10-21
 * @version
 */
public interface ReadManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**
	 * 根据存续ID  查询用户有没有阅读
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData selectByMessageInfoID(PageData pd) throws Exception;
	
}

