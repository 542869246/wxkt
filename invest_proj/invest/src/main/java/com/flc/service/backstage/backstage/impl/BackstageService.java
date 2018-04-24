package com.flc.service.backstage.backstage.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.flc.dao.DaoSupport;
import com.flc.entity.Page;
import com.flc.util.PageData;
import com.flc.service.backstage.backstage.BackstageManager;

/** 
 * 说明： 亲加后台表
 * 创建人：FLC
 * 创建时间：2017-12-06
 * @version
 */
@Service("backstageService")
public class BackstageService implements BackstageManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("BackstageMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("BackstageMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("BackstageMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("BackstageMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("BackstageMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("BackstageMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("BackstageMapper.deleteAll", ArrayDATA_IDS);
	}
	/**
	 * 当直播平台变动时  把所有的教室房间的直播平台也给变动
	 */
	@Override
	public void toUpdateAllType(PageData pd) throws Exception {
		dao.update("BackstageMapper.toUpdateAllType", pd);
	}
	/**
	 * 当账号表其他数据修改时，修改全部表数据
	 */
	@Override
	public void editAllNotTencecnt(PageData pd) throws Exception {
		dao.update("BackstageMapper.editAllNotTencecnt", pd);
	}
	/**
	 * 修改其他数据的默认值为0
	 */
	@Override
	public void toUpdateAllTencent(PageData pd) throws Exception {
		dao.update("BackstageMapper.toUpdateAllTencent", pd);
	}
	/**
	 *通过腾讯默认值获取数据
	 */
	@Override
	public PageData findBySecretid(PageData pd) throws Exception {
		return (PageData)dao.findForObject("BackstageMapper.findBySecretid", pd);
	}
	/**
	 * 通过腾讯账号类型获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Override
	public PageData findByTencent(PageData pd) throws Exception {
		return (PageData)dao.findForObject("BackstageMapper.findByTencent", pd);
	}
	
}

