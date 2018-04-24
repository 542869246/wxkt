package com.flc.wx.util;

import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import javax.net.ssl.X509TrustManager;
/**
* 类名: MyX509TrustManager </br>
* 描述: 信任管理器 </br>
* 开发人员： souvc </br>
* 创建时间：  2015-9-30 </br>
* 发布版本：V1.0  </br>
 */
public class MyX509TrustManager implements X509TrustManager {

    public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
    }

    public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
    }

    public X509Certificate[] getAcceptedIssuers() {
        return null;
    }
}