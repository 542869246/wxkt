package com.flc.wx.util;

import com.flc.wx.pojo.SNSUserInfo;

import net.sf.json.JSONObject;

public class GetUserInfos {
    @SuppressWarnings( { "deprecation", "unchecked" })
    public static SNSUserInfo getSNSUserInfo(String accessToken, String openId) {
        SNSUserInfo snsUserInfo = null;
        String requestUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID";
        requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken).replace("OPENID", openId);
        JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "GET", null);

        if (null != jsonObject) {
            try {
                snsUserInfo = new SNSUserInfo();
                snsUserInfo.setOpenId(jsonObject.getString("openid"));
                snsUserInfo.setNickname(jsonObject.getString("nickname"));
                snsUserInfo.setSex(jsonObject.getInt("sex"));
                snsUserInfo.setCountry(jsonObject.getString("country"));
                snsUserInfo.setProvince(jsonObject.getString("province"));
                snsUserInfo.setCity(jsonObject.getString("city"));
                snsUserInfo.setHeadImgUrl(jsonObject.getString("headimgurl"));
               //snsUserInfo.setPrivilegeList(JSONArray.toList(jsonObject.getJSONArray("privilege"), List.class));
            } catch (Exception e) {
                snsUserInfo = null;
                int errorCode = jsonObject.getInt("errcode");
                String errorMsg = jsonObject.getString("errmsg");
                System.out.println("获取用户信息失败 errcode:{} errmsg:{}  "+"errorCode:  "+errorCode +"errorMsg:  "+ errorMsg);
            }
        }
        return snsUserInfo;
    }
}
