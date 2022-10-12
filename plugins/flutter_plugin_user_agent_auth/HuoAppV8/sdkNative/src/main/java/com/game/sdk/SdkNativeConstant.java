package com.game.sdk;

import com.game.sdk.domain.DeviceBean;
import com.game.sdk.util.NotProguard;

/**
 * Created by liu hong liang on 2016/11/7.
 * sdk常量
 *
 */
@NotProguard
public class SdkNativeConstant {

    //nativie自动注入常量
    public static String HS_APPID="";
    public static String HS_CLIENTID="";//
    public static String HS_CLIENTKEY="";
    public static String HS_APPKEY="";
    public static String HS_AGENT="";
    public static String FROM="3";//1-WEB、2-WAP、3-Android、4-IOS、5-WP

    //地址信息
    public static String BASE_URL="";//域名
    public static String BASE_SUFFIX_URL="";//后缀
    public static String BASE_IP;
    //渠道编号
    public static String PROJECT_CODE;
    //使用地址方式
    public static String USE_URL_TYPE;//1域名，2ip

    public static String APP_PACKAGENAME;//app包名

    public  static String packageName="";//包名
    //rsa密钥
    public static String RSA_PUBLIC_KEY;
//    ="MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOvTgQeOuMIop6psK0Mk58fHur" +
//            "Sbx4pKye3reS5a6Lax3IrLazLGKQEnd+S+1q5BBVwc+JCJi/AUdbJeDkx+cCfE0M" +
//            "LbNt5DiZeKBN/hV4C+pOm0AjEkWQmJfIzsgfVpcifn1R5KsgZ0FtbfO7MOFAcYox" +
//            "HCYZduX4jhIZbgxrmwIDAQAB";
//sp中保存的rsa密钥
    public static String SP_RSA_PUBLIC_KEY="sp_rsa_public_key";
    public final static String SP_VERSION_CODE="versionCode";
    public final static String SP_OPEN_CNT="sp_openCnt";
    public static DeviceBean deviceBean;
}
