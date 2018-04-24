package com.flc.service.web.level.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.web.level.LevelManager;

/** 
 * 说明： 用户会员等级信息获取
 * 创建人：FLC
 * 创建时间：2017-10-20
 * @version
 */
@Service("levelService")
public class LevelService implements LevelManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("LevelMapper.findById", pd);
	}
	

	
}

