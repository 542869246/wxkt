package com.flc.wx.pojo;

import java.util.List;
/**
* 类名: SNSUserInfo </br>
* 描述: 通过网页授权获取的用户信息 </br>
* 开发人员： souvc </br>
* 创建时间：  2015-11-27 </br>
* 发布版本：V1.0  </br>
 */
public class SNSUserInfo {
    private String openId;
    private String nickname;
    private int sex;
    private String country;
    private String province;
    private String city;
    private String headImgUrl;
    private List<String> privilegeList;

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getHeadImgUrl() {
        return headImgUrl;
    }

    public void setHeadImgUrl(String headImgUrl) {
        this.headImgUrl = headImgUrl;
    }

    public List<String> getPrivilegeList() {
        return privilegeList;
    }

    public void setPrivilegeList(List<String> privilegeList) {
        this.privilegeList = privilegeList;
    }

	@Override
	public String toString() {
		return "SNSUserInfo [openId=" + openId + ", nickname=" + nickname + ", sex=" + sex + ", country=" + country
				+ ", province=" + province + ", city=" + city + ", headImgUrl=" + headImgUrl + ", privilegeList="
				+ privilegeList + "]";
	}
}