package com.game.sdk.domain;


import android.content.ContentValues;

/**
 * Created by liu hong liang on 2016/9/29.
 * 存储数据库tinstall 信息的java ben
 */

public class InstallDbBean {

    public static final String RSA_CODE="rsa_code";
    public static final String URL="url";
    private String rsa_code;
    private String url;

    public InstallDbBean(String rsa_code, String url) {
        this.rsa_code = rsa_code;
        this.url = url;
    }

    public InstallDbBean() {
    }

    public String getRsa_code() {
        return rsa_code;
    }

    public void setRsa_code(String rsa_code) {
        this.rsa_code = rsa_code;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public ContentValues toContentValues() {
        ContentValues cv = new ContentValues();
        cv.put(RSA_CODE, rsa_code);
        cv.put(URL, url);
        return cv;
    }

    @Override
    public String toString() {
        return "InstallDbBean{" +
                "rsa_code='" + rsa_code + '\'' +
                ", url=" + url +
                '}';
    }
}
