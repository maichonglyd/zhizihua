//
// Created by liu hong liang on 2016/11/11.
//

#ifndef HUOSUSO_COMMON_H
#define HUOSUSO_COMMON_H

#include <jni.h>
#include <string>
#include <android/log.h>
#include <sys/time.h>
#include <string.h>
#include "hs_constant.h"

#define   LOG_TAG    "JNI_LOG"
#define DEBUG 0
#if(DEBUG)
#define   LOGE(...)  __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)
#define   LOGD(...)  __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)
#else
#define   LOGE(...)  __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)
#define   LOGD(JNI_LOG, ...)
#endif

//常量值
static jint GET_META_DATA = 128;
static char *RSA_PUBLIC_KEY = "RSA_PUBLIC_KEY";

static char *HS_APPID = "HS_APPID";
static char *HS_CLIENTID = "HS_CLIENTID";
static char *HS_APPKEY = "HS_APPKEY";
static char *HS_AGENT = "HS_AGENT";
static char *HS_CLIENTKEY = "HS_CLIENTKEY";
static char *BASE_URL = "BASE_URL";
static char *BASE_SUFFIX_URL = "BASE_SUFFIX_URL";
static char *BASE_IP = "BASE_IP";
static char *PROJECT_CODE = "PROJECT_CODE";
static char *USE_URL_TYPE = "USE_URL_TYPE";

static char *APP_PACKAGENAME = "APP_PACKAGENAME";//app包名


static char *mHsClientId;//initLocalBySp中获得hsClientId,给后面的联网方法用
static char *charHsAgent;//initLocalBySp中获得hsAgent,给后面的联网方法用

//存下回调监听
jobject mNativeListener;
//是否已经回调过java层了，每次调用只回调一次，避免回调多次
bool alreadyNotification = false;

/**
 * 通知java层native操作成功
 */
void onNativeSuccess(JNIEnv *env, jobject nativeListener) {
    if (!alreadyNotification) {//避免重复通知
        alreadyNotification = true;
        jclass jNativeListenerClass = env->GetObjectClass(nativeListener);
        jmethodID mOnSuccessID = env->GetMethodID(jNativeListenerClass, "onSuccess", "()V");
        env->CallVoidMethod(nativeListener, mOnSuccessID);
    }
}


/**
 * 通知联网操作失败
 * count 为联网的次数，如果联网失败了
 */
void onNativeFail(JNIEnv *env, jobject nativeListener, int code, char *msg) {
    if (!alreadyNotification) {//避免重复通知
        alreadyNotification = true;
        jclass jNativeListenerClass = env->GetObjectClass(nativeListener);
        jmethodID mOnSuccessID = env->GetMethodID(jNativeListenerClass, "onFail",
                                                  "(ILjava/lang/String;)V");
        env->CallVoidMethod(nativeListener, mOnSuccessID, code, env->NewStringUTF(msg));
    }
}

/**
 * java UrlEncode.encode调用 url编码
 */
jstring urlEncode(JNIEnv *env, jstring value) {
    jclass jUrlEncoderClass = env->FindClass("java/net/URLEncoder");
    jmethodID jEncodeId = env->GetStaticMethodID(jUrlEncoderClass, "encode",
                                                 "(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;");
    return static_cast<jstring>(env->CallStaticObjectMethod(jUrlEncoderClass, jEncodeId, value,
                                                            env->NewStringUTF("utf-8")));
}

/**
 * java URLDecoder.decode调用 url解码
 */
jstring urlDecode(JNIEnv *env, jstring value) {
    jclass jUrlDecoderClass = env->FindClass("java/net/URLDecoder");
    jmethodID jDecodeId = env->GetStaticMethodID(jUrlDecoderClass, "dncode",
                                                 "(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;");
    return static_cast<jstring>(env->CallStaticObjectMethod(jUrlDecoderClass, jDecodeId, value,
                                                            env->NewStringUTF("utf-8")));
}
bool isEmpty(JNIEnv *env,jstring data){
    if(data==NULL||(env)->GetStringLength(data)==0){
        return true;
    }
    return false;
}
/**
 * java new Gson().toJson(Object) 方法生成json
 */
jstring toJson(JNIEnv *env, jobject jObject) {
    jclass jGsonClass = env->FindClass("com/google/gson/Gson");
    jmethodID mGsonId = env->GetMethodID(jGsonClass, "<init>", "()V");
    jobject jGson = env->NewObject(jGsonClass, mGsonId);
    jmethodID mToJsonId = env->GetMethodID(jGsonClass, "toJson",
                                           "(Ljava/lang/Object;)Ljava/lang/String;");
    return static_cast<jstring>(env->CallObjectMethod(jGson, mToJsonId, jObject));
}

jstring getValueByKeyByJsonStr(JNIEnv *env, jstring jStrDataJson, char *key) {
//    JSONObject jsonObject=new JSONObject("");
    jclass jJSONObjectclass = env->FindClass("org/json/JSONObject");
    jmethodID mJSONObjectCuID = env->GetMethodID(jJSONObjectclass, "<init>",
                                                 "(Ljava/lang/String;)V");
    jobject jJSONObjectObject = env->NewObject(jJSONObjectclass, mJSONObjectCuID, jStrDataJson);
    if (env->ExceptionCheck()) {
        env->ExceptionClear();
        return NULL;
    }
//    jsonObject.optString();
    jmethodID mOptStringId = env->GetMethodID(jJSONObjectclass, "optString",
                                              "(Ljava/lang/String;)Ljava/lang/String;");
    return static_cast<jstring>(env->CallObjectMethod(jJSONObjectObject, mOptStringId,
                                                      env->NewStringUTF(key)));
}


/**
 * java String.getBytes 方法获取byte数组
 */
jbyteArray jstringToJbyteArray(JNIEnv *env, jstring data) {
    jmethodID mGetBytesId = env->GetMethodID(env->GetObjectClass(data), "getBytes", "()[B");
    return (jbyteArray) env->CallObjectMethod(data, mGetBytesId);
}

/**
 * java byte数组转String
 */
jstring jbyteArrayToJstring(JNIEnv *env, jbyteArray dataByteArray) {
    jclass jStringClass = env->FindClass("java/lang/String");
    jmethodID mNewStringId = env->GetMethodID(jStringClass, "<init>", "([BLjava/lang/String;)V");
    return static_cast<jstring>( env->NewObject(jStringClass, mNewStringId, dataByteArray,
                                                env->NewStringUTF("utf-8")));
}

jboolean jstringEquals(JNIEnv *env, jstring jdata1, jstring jdata2) {
    jmethodID mEqualsId = env->GetMethodID(env->GetObjectClass(jdata1), "equals",
                                           "(Ljava/lang/Object;)Z");
    return env->CallBooleanMethod(jdata1, mEqualsId, jdata2);
}


/**
 * rsa用公钥加密
 */
jstring rsaEncryptByPublicKey(JNIEnv *env, jstring data, jstring rsa_public_key) {
    jclass jRSAUtilsClass = env->FindClass("com/game/sdk/util/RSAUtils");
//    byte[] encryptByPublicKey(byte[] data, String publicKey)
    jmethodID mEncryptByPublicKeyID = env->GetStaticMethodID(jRSAUtilsClass, "encryptByPublicKey",
                                                             "([BLjava/lang/String;)[B");
    jbyteArray dataByteArray = jstringToJbyteArray(env, data);
    jbyteArray dataRsaEncryptByte = (jbyteArray) env->
            CallStaticObjectMethod(jRSAUtilsClass, mEncryptByPublicKeyID, dataByteArray,
                                   rsa_public_key);
    if (dataRsaEncryptByte != NULL) {
        return jbyteArrayToJstring(env, dataRsaEncryptByte);
    }
    return NULL;
}

/**
 * rsa用公钥加密
 * static byte[] decryptByPublicKey(byte[] encryptedData, String publicKey)
 */
jstring rsaDecryptByPublicKey(JNIEnv *env, jstring data, jstring rsa_public_key) {
    jclass jRSAUtilsClass = env->FindClass("com/game/sdk/util/RSAUtils");
    jmethodID mDecryptByPublicKeyID = env->GetStaticMethodID(jRSAUtilsClass, "decryptByPublicKey",
                                                             "([BLjava/lang/String;)[B");
    jbyteArray dataByteArray = jstringToJbyteArray(env, data);
    jbyteArray dataRsaEncryptByte = (jbyteArray) env->
            CallStaticObjectMethod(jRSAUtilsClass, mDecryptByPublicKeyID, dataByteArray,
                                   rsa_public_key);
    if (dataRsaEncryptByte != NULL) {
        return jbyteArrayToJstring(env, dataRsaEncryptByte);
    }
    return NULL;
}


//static boolean verify(byte[] data, String publicKey, String sign)
jboolean rsaVerify(JNIEnv *env, jstring jStrData, jstring rsa_public_key, jstring sign) {
    jclass jRSAUtilsClass = env->FindClass("com/game/sdk/util/RSAUtils");
//    byte[] encryptByPublicKey(byte[] data, String publicKey)
    jmethodID mVerifyID = env->GetStaticMethodID(jRSAUtilsClass, "verify",
                                                 "([BLjava/lang/String;Ljava/lang/String;)Z");
    jbyteArray dataByteArray = jstringToJbyteArray(env, jStrData);
    return env->CallStaticBooleanMethod(jRSAUtilsClass, mVerifyID, dataByteArray, rsa_public_key,
                                        sign);
}


/**
 * AuthCode对称加密
 */
jstring authcodeEncode(JNIEnv *env, jstring jStrData, jstring jStrAuthkey) {
    jclass jAuthCodeUtilClass = env->FindClass("com/game/sdk/util/AuthCodeUtil");
    jmethodID mAuthcodeEncodeId = env->GetStaticMethodID(jAuthCodeUtilClass, "authcodeEncode",
                                                         "(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;");
    return static_cast<jstring>(env->CallStaticObjectMethod(jAuthCodeUtilClass, mAuthcodeEncodeId,
                                                            jStrData, jStrAuthkey));
}

/**
 * AuthCode对称解密
 */
jstring authcodeDecode(JNIEnv *env, jstring jStrData, jstring jStrAuthkey) {
    jclass jAuthCodeUtilClass = env->FindClass("com/game/sdk/util/AuthCodeUtil");
    jmethodID mAuthcodeEncodeId = env->GetStaticMethodID(jAuthCodeUtilClass, "authcodeDecode",
                                                         "(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;");
    return static_cast<jstring>(env->CallStaticObjectMethod(jAuthCodeUtilClass, mAuthcodeEncodeId,
                                                            jStrData, jStrAuthkey));
}

/**
 * jstring 通过StringBuffer完成拼接
 */
jstring jstringConCat(JNIEnv *env, jstring jStrData, jstring jStrAppendData) {
    jclass jStringBufferClass = env->FindClass("java/lang/StringBuffer");
    jmethodID mStringBufferCu = env->GetMethodID(jStringBufferClass, "<init>",
                                                 "(Ljava/lang/String;)V");
    jobject jStringBuffer = env->NewObject(jStringBufferClass, mStringBufferCu, jStrData);
    jmethodID mAppendID = env->GetMethodID(jStringBufferClass, "append",
                                           "(Ljava/lang/String;)Ljava/lang/StringBuffer;");
    jStringBuffer = env->CallObjectMethod(jStringBuffer, mAppendID, jStrAppendData);
    jmethodID mToStringID = env->GetMethodID(jStringBufferClass, "toString",
                                             "()Ljava/lang/String;");
    return static_cast<jstring>(env->CallObjectMethod(jStringBuffer, mToStringID));
}

char *jstringTostring(JNIEnv *env, jstring jstr) {
    char *rtn = NULL;
    jclass clsstring = env->FindClass("java/lang/String");
    jstring strencode = env->NewStringUTF("utf-8");
    jmethodID mid = env->GetMethodID(clsstring, "getBytes", "(Ljava/lang/String;)[B");
    jbyteArray barr = (jbyteArray) env->CallObjectMethod(jstr, mid, strencode);
    jsize alen = env->GetArrayLength(barr);
    jbyte *ba = env->GetByteArrayElements(barr, JNI_FALSE);
    if (alen > 0) {
        rtn = (char *) malloc(alen + 1);

        memcpy(rtn, ba, alen);
        rtn[alen] = 0;
    }
    env->ReleaseByteArrayElements(barr, ba, 0);
    return rtn;
}

/**
 * 获取包名
 */
jstring getPackageName(JNIEnv *env, jobject context) {
    jclass native_class = env->GetObjectClass(context);
    jmethodID mId = env->GetMethodID(native_class, "getPackageName", "()Ljava/lang/String;");
    jstring packName = static_cast<jstring>(env->CallObjectMethod(context, mId));
    return packName;
}

/**
 * 获取MetaDataBundle
 */
jobject getMetaDataBundle(JNIEnv *env, jobject context) {
    jclass jContextClass = env->GetObjectClass(context);
    jmethodID mPmId = env->GetMethodID(jContextClass, "getPackageManager",
                                       "()Landroid/content/pm/PackageManager;");
    jobject jPackageManager = env->CallObjectMethod(context, mPmId);
    jclass jPackageManagerClass = env->GetObjectClass(jPackageManager);
    // 得到 getApplicationInfo 方法的 ID
    jmethodID mAppInfoId = env->GetMethodID(jPackageManagerClass,
                                            "getApplicationInfo",
                                            "(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;");
    //包名参数
    jstring jPackageName = getPackageName(env, context);
    //得到AppInfo实例
    jobject jAppInfo = env->CallObjectMethod(jPackageManager, mAppInfoId, jPackageName,
                                             GET_META_DATA);
    jclass jAppInfoClass = env->GetObjectClass(jAppInfo);
    jfieldID fMetaDataId = env->GetFieldID(jAppInfoClass, "metaData", "Landroid/os/Bundle;");
    if (fMetaDataId == NULL) {
        LOGE("signsture: %s", "fMetaDataId是null的");
        return NULL;
    }
    //得到AppInfo实例
    jobject jBundle = env->GetObjectField(jAppInfo, fMetaDataId);
    if (jBundle == NULL) {
        LOGE("signsture: %s", "jBundle是null的");
        return NULL;
    }
    return jBundle;
}

/**
 * 获取清单文件属性
 */
jstring getMetaDataByName(JNIEnv *env, jobject metaDataBundle, char *name) {
    jclass jBundleClass = env->GetObjectClass(metaDataBundle);
    jmethodID mGetId = env->GetMethodID(jBundleClass, "get", "(Ljava/lang/String;)Ljava/lang/Object;");
    jstring hs_valueObj = NULL;
    if (mGetId == NULL) {
        LOGE("initNetConfigsdk %s = %s", name, "mGetId是null的");
    } else {
        jobject pJobject = env->CallObjectMethod(metaDataBundle, mGetId, env->NewStringUTF(name));
        if (pJobject != NULL) {
            jmethodID pMID = env->GetMethodID(env->GetObjectClass(pJobject), "toString", "()Ljava/lang/String;");
            hs_valueObj = static_cast<jstring>(env->CallObjectMethod(pJobject, pMID));
        }
    }
    return hs_valueObj;
}

/**
 * 往SdkConstant赋值常量
 */
void setSdkConstantField(JNIEnv *env, char *name, jobject value) {
    if (value == NULL) {
        return;
    }
    jclass jConstantClass = env->FindClass("com/game/sdk/SdkNativeConstant");
    if (jConstantClass == NULL) {
        LOGE("signsture: %s", "jConstantClass是null的");
        return;
    }
    jfieldID pID = env->GetStaticFieldID(jConstantClass, name, "Ljava/lang/String;");
    env->SetStaticObjectField(jConstantClass, pID, value);
}


/**
 * 保存rsaPublicKey到数据库中         public static void saveInstallResult(String rsa_code,String url){
 */
void saveInstallResult(JNIEnv *env, jstring rsa_code, jstring url) {
    //对rsakey 进行加密存储，防止被破译
    rsa_code = authcodeEncode(env, rsa_code, env->NewStringUTF(RSA_HS_PUBLIC_KEY));
    jclass jSdkNativeClass = env->FindClass("com/game/sdk/so/SdkNative");
    jmethodID jMGetInstallResult = env->GetStaticMethodID(jSdkNativeClass, "saveInstallResult",
                                                          "(Ljava/lang/String;Ljava/lang/String;)V");
    (env->CallStaticVoidMethod(jSdkNativeClass, jMGetInstallResult, rsa_code, url));
}
/**
 * 获取上一次的rsaKey
 * @param env
 * @return
 */
jstring getInstallRsaForDb(JNIEnv *env) {
    //对rsakey 进行解密
    jclass jSdkNativeClass = env->FindClass("com/game/sdk/so/SdkNative");
    jmethodID jMGetRsa = env->GetStaticMethodID(jSdkNativeClass, "getInstallDbRsa",
                                                "()Ljava/lang/String;");
    jstring rsa_code = static_cast<jstring>(env->CallStaticObjectMethod(jSdkNativeClass, jMGetRsa));
    rsa_code = authcodeDecode(env, rsa_code, env->NewStringUTF(RSA_HS_PUBLIC_KEY));
    return rsa_code;
}
/**
 * 获取上一次的baseUrl
 * @param env
 * @return
 */
jstring getInstallUrlForDb(JNIEnv *env) {
    //对rsakey 进行解密
    jclass jSdkNativeClass = env->FindClass("com/game/sdk/so/SdkNative");
    jmethodID jMGetUrl = env->GetStaticMethodID(jSdkNativeClass, "getInstallDbUrl",
                                                "()Ljava/lang/String;");
    jstring url = static_cast<jstring>(env->CallStaticObjectMethod(jSdkNativeClass, jMGetUrl));
    return url;
}

#endif //HUOSUSO_COMMON_H


