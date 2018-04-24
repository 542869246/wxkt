package com.flc.service.web.about.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.web.about.AboutManager;

/** 
 * 说明： 关于我们页面信息展示
 * 创建人：FLC
 * 创建时间：2017-10-19
 * @version
 */
@Service("aboutService")
public class AboutService implements AboutManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**查询
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public PageData findAll()throws Exception{
		return (PageData)dao.findForObject("AboutMapper.listAll", null);
	}
	
}

