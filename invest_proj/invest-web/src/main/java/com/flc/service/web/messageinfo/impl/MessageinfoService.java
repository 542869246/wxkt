package com.flc.service.web.messageinfo.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.service.web.messageinfo.MessageinfoManager;
import com.flc.util.PageData;

/** 
 * 说明： 存续消息展示
 * 创建人：FLC
 * 创建时间：2017-10-22
 * @version
 */
@Service("messageinfoService")
public class MessageinfoService implements MessageinfoManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("MessageinfoMapper.datalistPage", page);
	}
	/**
	 * 查询用户消息总数量
	 */
	@Override
	public int getTotalResult(PageData pd) throws Exception {
		return (int) dao.findForObject("MessageinfoMapper.getTotalResult", pd);
	}
	/**
	 * 查询用户消息
	 */
	@Override
	public List<PageData> selectAll(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("UserinfoMapper.selectAllMessage", pd);
	}
	/**
	 * 查询所有消息
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<PageData> selectall() throws Exception {
		return (List<PageData>) dao.findForList("MessageinfoMapper.selectall", null);
	}
	@Override
	public PageData findinformationbyid(String id) throws Exception {
		return (PageData)dao.findForObject("MessageinfoMapper.findinformationbyid", id);
	}
	@Override
	public PageData findmessageinfobyid(String id) throws Exception {
		return (PageData)dao.findForObject("MessageinfoMapper.findmessageinfobyid", id);
	}
	
}

