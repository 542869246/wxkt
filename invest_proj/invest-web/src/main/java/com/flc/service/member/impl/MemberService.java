package com.flc.service.member.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.enums.ExEnum;
import com.flc.exception.NjmsException;
import com.flc.util.PageData;
import com.flc.util.UuidUtil;
import com.flc.service.member.MemberManager;

/** 
 * 说明： 学员
 * 创建人：FLC
 * 创建时间：2017-08-16
 * @version
 */
@Service("memberService")
public class MemberService implements MemberManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("MemberMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("MemberMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("MemberMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("MemberMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("MemberMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MemberMapper.findById", pd);
	}
	/**通过id获取数据锁行
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByIdLock(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MemberMapper.findByIdLock", pd);
	}
	
	/** 验证新电话
	 * @param pd
	 * @throws Exception
	 */
	public PageData findTel(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MemberMapper.findTel", pd);
	}
	
	/** 验证新电话
	 * @param pd
	 * @throws Exception
	 */
	public PageData findShou(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MemberMapper.findShou", pd);
	}
	
	/** 验证旧电话
	 * @param pd
	 * @throws Exception
	 */
	public PageData findJiu(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MemberMapper.findJiu", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("MemberMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public PageData find(PageData pd) throws Exception {
		return (PageData) dao.findForObject("MemberMapper.find", pd);
	}

	@Override
	public PageData findByIdOnly(PageData pd) throws Exception {
		return (PageData) dao.findForObject("MemberMapper.findByIdOnly", pd);
	}
	
	/**
	 * 生成socket
	 */
	@Override
	public void createSocket(PageData seachMemberPd) throws Exception  {
		if(null==seachMemberPd){
			throw new NjmsException(ExEnum.EX_SYSTEM_NULL);
		}
		String socket = UuidUtil.get32UUID();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		seachMemberPd.put("SOCKET", socket);
		seachMemberPd.put("UPDATE_TIME", df.format(new Date()));
		dao.update("MemberMapper.edit", seachMemberPd);
	}
	@Override
	public void editZy(PageData pd) throws Exception {
		dao.update("MemberMapper.edit", pd);
	}
}

