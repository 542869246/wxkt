package com.flc.service.web.about;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 关于我们页面信息展示接口
 * 创建人：FLC
 * 创建时间：2017-10-19
 * @version
 */
public interface AboutManager{
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public PageData findAll()throws Exception;
	
}

