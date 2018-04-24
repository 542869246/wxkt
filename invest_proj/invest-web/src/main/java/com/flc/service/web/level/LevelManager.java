package com.flc.service.web.level;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 用户会员等级信息获取接口
 * 创建人：FLC
 * 创建时间：2017-10-20
 * @version
 */
public interface LevelManager{

	
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	
}

