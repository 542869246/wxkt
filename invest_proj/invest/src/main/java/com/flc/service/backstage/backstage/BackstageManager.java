package com.flc.service.backstage.backstage;

import java.util.List;
import com.flc.entity.Page;
import com.flc.util.PageData;

/** 
 * 说明： 亲加后台表接口
 * 创建人：FLC
 * 创建时间：2017-12-06
 * @version
 */
public interface BackstageManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	/**
	 * 当直播平台变动时  把所有的教室房间的直播平台也给变动
	 */
	public void toUpdateAllType(PageData pd)throws Exception;
	/**
	 * 当账号表其他数据修改时，修改全部表数据
	 */
	public void editAllNotTencecnt(PageData pd)throws Exception;
	/**
	 * 修改其他数据的默认值为0
	 */
	public void toUpdateAllTencent(PageData pd)throws Exception;
	/**
	 * 通过腾讯默认值获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findBySecretid(PageData pd)throws Exception;
	/**
	 * 通过腾讯账号类型获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByTencent(PageData pd)throws Exception;
}

