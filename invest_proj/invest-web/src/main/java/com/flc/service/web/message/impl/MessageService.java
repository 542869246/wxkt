package com.flc.service.web.message.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.web.message.MessageManager;

/** 
 * 说明： 系统消息页面展示
 * 创建人：FLC
 * 创建时间：2017-10-20
 * @version
 */
@Service("messageService")
public class MessageService implements MessageManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(Page page)throws Exception{
		return (List<PageData>)dao.findForList("MessageMapper.datalistPage", page);
	}

	@Override
	public int getTotalRTesult() throws Exception {
		return Integer.parseInt(dao.findForObject("MessageMapper.getTotalResult", null).toString());
	}

	@Override
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("MessageMapper.findById", pd);
	}

	@Override
	public List<PageData> selectAllSys(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("UserinfoMapper.selectAllSys", pd);
	}
}

