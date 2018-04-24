package com.flc.service.web.read.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.web.read.ReadManager;

/** 
 * 说明： 用户阅读系统消息
 * 创建人：FLC
 * 创建时间：2017-10-21
 * @version
 */
@Service("readService")
public class ReadService implements ReadManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ReadMapper.save", pd);
	}
	/**
	 * 根据存续ID  查询用户有没有阅读
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData selectByMessageInfoID(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ReadMapper.selectByMessinfoId", pd);
	}
}

