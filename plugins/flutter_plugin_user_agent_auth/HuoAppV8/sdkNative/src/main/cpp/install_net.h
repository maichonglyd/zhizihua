//
// Created by liu hong liang on 2016/11/11.
//

#ifndef HUOSUSO_INSTALL_NET_H
#define HUOSUSO_INSTALL_NET_H

#include <jni.h>
#include <string>
#include <android/log.h>
#include <sys/time.h>
#include "common.h"

jstring jStrAuthCode; //记录联网请求的authcode，给下面联网回来解密数据用的



/**
 * 通知联网操作失败
 * count 为联网的次数，如果联网失败了
 */
void onNetFail(JNIEnv *env, jobject nativeListener, int code, char *msg, int count) {
    if (count == 1) {//第一次联网失败,考虑切换到备用认证服务器
//        getRsaPublicKeyByNet()
    } else if (count == 2) {//第二次失败

    } else { //第三次失败

    }
}


/**
 * 添加第一次安装联网参数
 */
jbyteArray getInstallParamsData(JNIEnv *env, char *mHsClientId, char *rsa_hs_public_key) {
    //生成rand16
    jclass jHttpParamsBuildClass = env->FindClass("com/game/sdk/http/HttpParamsBuild");
    jmethodID jGetRandChId = env->GetStaticMethodID(jHttpParamsBuildClass, "getRandCh",
                                                    "(I)Ljava/lang/String;");
    jstring jRandCh16 = static_cast<jstring>(env->CallStaticObjectMethod(jHttpParamsBuildClass,
                                                                         jGetRandChId, 16));
    LOGD("initNetConfigsdk: randch16=%s", jstringTostring(env, jRandCh16));
    //生成联网用的key
    char keyBuff[100];
    sprintf(keyBuff, "%s_%ld_%s", mHsClientId, time((time_t *) NULL),
            jstringTostring(env, jRandCh16));
    LOGD("initNetConfigsdk: key=%s size=%d", keyBuff, strlen(keyBuff));
    jStrAuthCode = env->NewStringUTF(keyBuff);
    //调用rsa公钥加密
    jstring jStrKeyRsaData = rsaEncryptByPublicKey(env, env->NewStringUTF(keyBuff),
                                                   env->NewStringUTF(rsa_hs_public_key));
    if (jStrKeyRsaData == NULL) {
        return NULL;
    }
    LOGD("initNetConfigsdk: jStrKeyRsaData=%s", jstringTostring(env, jStrKeyRsaData));

    jstring jStrKeyRsaUrlEncodeData = urlEncode(env, jStrKeyRsaData);
    LOGD("initNetConfigsdk: jStrKeyRsaUrlEncodeData=%s",
         jstringTostring(env, jStrKeyRsaUrlEncodeData));
    //生成数据
    jclass jInstallBeanClass = env->FindClass("com/game/sdk/domain/InstallBean");
    jmethodID mInstallBeanCu = env->GetMethodID(jInstallBeanClass, "<init>", "()V");
    jobject jInstallBean = env->NewObject(jInstallBeanClass, mInstallBeanCu);
//    void setChannel_url(String channel_url)
    jmethodID mSetChannel_urlId = env->GetMethodID(jInstallBeanClass, "setChannel_url",
                                                   "(Ljava/lang/String;)V");
    if (strcmp(config_use_url_type, "1") == 0) {
        env->CallVoidMethod(jInstallBean, mSetChannel_urlId, env->NewStringUTF(config_url));
    } else {
        env->CallVoidMethod(jInstallBean, mSetChannel_urlId, env->NewStringUTF(config_ip));
    }
    //数据toJson
    jstring jStrDataJson = toJson(env, jInstallBean);
    LOGD("initNetConfigsdk: authCode=  %s", jstringTostring(env, jStrAuthCode));
    LOGD("initNetConfigsdk: jStrDataJson=  %s", jstringTostring(env, jStrDataJson));
    //数据auth对称加密
    jstring jStrDataJsonAuthCode = authcodeEncode(env, jStrDataJson, jStrAuthCode);
    LOGD("initNetConfigsdk: jStrDataJsonAuthCode=  %s", jstringTostring(env, jStrDataJsonAuthCode));

    //数据UrlEncode
    jstring jStrDataJsonAuthCodeUrlEncode = urlEncode(env, jStrDataJsonAuthCode);
    LOGD("initNetConfigsdk: jStrDataJsonAuthCodeUrlEncode=  %s",
         jstringTostring(env, jStrDataJsonAuthCodeUrlEncode));
    //数据最后拼接成参数
    jstring jStrParamBuffer = jstringConCat(env, env->NewStringUTF("key="),
                                            jStrKeyRsaUrlEncodeData);
    jStrParamBuffer = jstringConCat(env, jStrParamBuffer, env->NewStringUTF("&data="));
    jStrParamBuffer = jstringConCat(env, jStrParamBuffer, jStrDataJsonAuthCodeUrlEncode);
    LOGD("initNetConfigsdk: installer联网参数=  %s", jstringTostring(env, jStrParamBuffer));
    jbyteArray jParamsByteArr = jstringToJbyteArray(env, jStrParamBuffer);
    return jParamsByteArr;
}

jstring parseInstallNetResult(JNIEnv *env, jstring jData) {
    LOGD("initNetConfigsdk:联网数据 %s", jstringTostring(env, jData));
//拿到数据后
    if (jData != NULL && (env)->GetStringLength(jData) != 0) {
        LOGD("initNetConfigsdk:联网数据 %s", jstringTostring(env, jData));
        //解密数据
        jstring jCodeStr = getValueByKeyByJsonStr(env, jData, "code");
        if (isEmpty(env, jCodeStr)) {
            jCodeStr = env->NewStringUTF("500");
        }
        jstring jMsgStr = getValueByKeyByJsonStr(env, jData, "msg");
        if (isEmpty(env, jMsgStr) == 0) {
            jMsgStr = env->NewStringUTF("数据异常，请稍后再试");
        }
        jstring jDataStr = getValueByKeyByJsonStr(env, jData, "data");

        if (jData != NULL && (env)->GetStringLength(jData) != 0) {
            if (jstringEquals(env, jCodeStr, env->NewStringUTF("200"))) {
                jstring jStrDataAuthDecode = authcodeDecode(env, jDataStr, jStrAuthCode);
                if (jStrDataAuthDecode != NULL && (env)->GetStringLength(jStrDataAuthDecode) != 0) {
                    LOGD("initNetConfigsdk:联网解密数据 %s", jstringTostring(env, jStrDataAuthDecode));
                    //获取签名，验证签名
                    jstring jStrResponseData = getValueByKeyByJsonStr(env, jStrDataAuthDecode,
                                                                      "responcedata");
                    jstring jStrSign = getValueByKeyByJsonStr(env, jStrDataAuthDecode, "sign");
                    jboolean jSignResult = rsaVerify(env, jStrResponseData,
                                                     env->NewStringUTF(RSA_HS_PUBLIC_KEY),
                                                     jStrSign);
                    if (jSignResult) {
                        LOGD("initNetConfigsdk:签名验证通过 %s", jstringTostring(env, jStrResponseData));
                        jstring jStrRsapub = getValueByKeyByJsonStr(env, jStrResponseData,
                                                                    "rsapub");
                        jstring jStrUrl = getValueByKeyByJsonStr(env, jStrResponseData, "url");
                        //注入sdk请求地址
                        if (jStrUrl != NULL && (env)->GetStringLength(jStrUrl) != 0) {
                            LOGD("initNetConfigsdk:获取到的url数据 %s", jstringTostring(env, jStrUrl));
                            if (!DEBUG) {
                                setSdkConstantField(env, BASE_URL, jStrUrl);
                            }
                        }
                        //缓存到数据库中
                        if (jStrRsapub != NULL &&
                            (env)->GetStringLength(jStrRsapub) != 0) {//联网获取到了，保存到sp中，避免下次再次联网
                            saveInstallResult(env, jStrRsapub, jStrUrl);
                        }
                        return jStrRsapub;
                    } else {
                        LOGE("initNetConfigsdk: 安全校验不通过 %s", jstringTostring(env, jData));
                        return NULL;
                    }

                } else {
                    LOGE("initNetConfigsdk: 授权数据为null %s", jstringTostring(env, jData));
                    return NULL;
                }
            } else {
                LOGE("initNetConfigsdk: 授权失败 %s", jstringTostring(env, jData));
                return NULL;
            }
        }
    } else {
        LOGE("initNetConfigsdk:联网数据 %s", "为null");
    }
    return NULL;
}

/**
 * 当联网异常时从缓存中获取认证信息,并注入url
 * @param env
 * @return
 */
jstring backRsaFromDb(JNIEnv *env) {
    jstring rsacode = getInstallRsaForDb(env);
    if (rsacode == NULL || (env)->GetStringLength(rsacode) == 0) {
        LOGD("backRsaFromDb: %s", "rsacode是null的");
        return NULL;
    } else {
        LOGD("backRsaFromDb rsacode= %s", jstringTostring(env, rsacode));
        //处理url
        jstring url = getInstallUrlForDb(env);
        //注入sdk请求地址
        if (url != NULL && (env)->GetStringLength(url) != 0) {
            LOGD("backRsaFromDb:获取到的url数据 %s", jstringTostring(env, url));
            if (!DEBUG) {
                setSdkConstantField(env, BASE_URL, url);
            }
        }
        return rsacode;
    }
    return NULL;
}


/**
 * 从服务器联网获取RsaPublicKey
 * count 为联网次数
 */
jstring getRsaPublicKeyByNet(JNIEnv *env, jobject context, jint count) {
    if (count > 3) {
        return NULL;
    }
    jclass jUrlClass = env->FindClass("java/net/URL");
    jmethodID mUrlCu = env->GetMethodID(jUrlClass, "<init>", "(Ljava/lang/String;)V");
    jstring jRequestUrl = NULL;
    if (count == 1) {//第一次联网
        jRequestUrl = env->NewStringUTF(HS_URL_INSTALL);
    } else if (count == 2) {//第二次联网
        jRequestUrl = env->NewStringUTF(HS_URL_INSTALL2);
    } else {//第三次联网
        jRequestUrl = env->NewStringUTF(HS_URL_INSTALL);
    }
    jobject jUrl = env->NewObject(jUrlClass, mUrlCu, jRequestUrl);
    if (env->ExceptionCheck()) {//new URL(url);可能有异常
        env->ExceptionClear();
        LOGE("huosdk:native net fail count=%d  msg=%s", count, "url 解析失败！");
//        env->ThrowNew(env->FindClass("java/lang/Exception"),"连接失败！");
        return NULL;
    }
    jmethodID mUrlConnection = env->GetMethodID(jUrlClass, "openConnection",
                                                "()Ljava/net/URLConnection;");
    jobject jUrlConnection = env->CallObjectMethod(jUrl, mUrlConnection);// openConnection();可能有io异常
    if (env->ExceptionCheck()) {//openConnection();可能有io异常
        env->ExceptionClear();
        LOGE("huosdk:native net fail count=%d  msg=%s", count, "io connect fail");
//        env->ThrowNew(env->FindClass("java/lang/Exception"),"连接失败！");
        return NULL;
    }
    //设置HttpUrlConnection参数
    jclass jUrlConnectionClass = env->GetObjectClass(jUrlConnection);
    jmethodID mSetRequestMethodId = env->GetMethodID(jUrlConnectionClass, "setRequestMethod",
                                                     "(Ljava/lang/String;)V");

    env->CallVoidMethod(jUrlConnection, mSetRequestMethodId, env->NewStringUTF("POST"));
    //新加捕获异常1
    if(env->ExceptionCheck()){//openConnection();可能有io异常
        env->ExceptionClear();
        env->ThrowNew(env->FindClass("java/lang/Exception"),"连接失败！");
        return NULL;
    }

    jmethodID pConnectTimeoutID = env->GetMethodID(jUrlConnectionClass, "setConnectTimeout",
                                                   "(I)V");
    env->CallVoidMethod(jUrlConnection, pConnectTimeoutID, 5 * 1000);
    jmethodID pReadTimeout = env->GetMethodID(jUrlConnectionClass, "setReadTimeout", "(I)V");
    env->CallVoidMethod(jUrlConnection, pReadTimeout, 3 * 1000);
    jmethodID pDoOutput = env->GetMethodID(jUrlConnectionClass, "setDoOutput", "(Z)V");
    env->CallVoidMethod(jUrlConnection, pDoOutput, true);
    jmethodID pDoInput = env->GetMethodID(jUrlConnectionClass, "setDoInput", "(Z)V");
    env->CallVoidMethod(jUrlConnection, pDoInput, true);
    //写入参数
    jmethodID pOutputStreamId = env->GetMethodID(jUrlConnectionClass, "getOutputStream",
                                                 "()Ljava/io/OutputStream;");
    jobject jOutputStream = env->CallObjectMethod(jUrlConnection, pOutputStreamId);
    if (env->ExceptionCheck()) {//getOutputStream();可能有io异常
        env->ExceptionClear();
        LOGE("huosdk:native net fail  count=%d  msg=%s", count, "io write output fail");
        return NULL;
    }
    jclass jOutputStreamClass = env->GetObjectClass(jOutputStream);
    jmethodID mWriteId = env->GetMethodID(jOutputStreamClass, "write", "([B)V");
    //生成联网参数
    jbyteArray paramsData = getInstallParamsData(env, mHsClientId, RSA_HS_PUBLIC_KEY);
    env->CallVoidMethod(jOutputStream, mWriteId, paramsData);

    //新加捕获异常2
    if(env->ExceptionCheck()){//openConnection();可能有io异常
        env->ExceptionClear();
        env->ThrowNew(env->FindClass("java/lang/Exception"),"连接失败！");
        return NULL;
    }

    //开始联网
    jmethodID mResponseCodeId = env->GetMethodID(jUrlConnectionClass, "getResponseCode", "()I");
    jint code = env->CallIntMethod(jUrlConnection, mResponseCodeId);
    if(env->ExceptionCheck()){//getResponseCode();可能有io异常
        env->ExceptionClear();
        LOGE("huosdk:native net fail  count=%d  msg=%s",count,"get response code fail");
        return NULL;
    }
    LOGD("huosdk:native net code =%d", code);
    if (code == 200) {//连接成功
        jmethodID mInputStreamId = env->GetMethodID(jUrlConnectionClass, "getInputStream",
                                                    "()Ljava/io/InputStream;");
        jobject jInputStream = env->CallObjectMethod(jUrlConnection, mInputStreamId);
        if (env->ExceptionCheck()) {//getInputStream();可能有io异常
            env->ExceptionClear();
            LOGE("huosdk:native net 200 fail  count=%d  msg=%s", count, "io read input fail");
            return NULL;
        }
        jclass jIoUtilclass = env->FindClass("com/game/sdk/http/IoUtil");
        jmethodID jReadStringID = env->GetStaticMethodID(jIoUtilclass, "readString",
                                                         "(Ljava/io/InputStream;)Ljava/lang/String;");
        //todo 这里直接调用java层的流读取数据方法，后期可以改为jni间接调用流操作数据，更安全
        jstring jData = static_cast<jstring>(env->CallStaticObjectMethod(jIoUtilclass,
                                                                         jReadStringID,
                                                                         jInputStream));
        jstring jStrNetRsaPublicKey = parseInstallNetResult(env, jData);
        return jStrNetRsaPublicKey;
    } else {//联网失败，尝试使用本地缓存
        LOGE("huosdk:native net fail  count=%d  msg=%d", count, code);
        return NULL;
    }
    return NULL;
}

#endif //HUOSUSO_INSTALL_NET_H
