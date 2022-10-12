// Created by liu hong liang on 2016/11/11.
//
#include <jni.h>
#include <string>
#include <stdlib.h>
#include <android/log.h>
#include <sys/time.h>
#include "common.h"
#include "install_net.h"
/**
 * 初始化SdkConstant常量，并返回hs_agent
 */
jstring initConstants(JNIEnv *env,jobject context,jint apkType){
    //注入客户ip和url
    if(strcmp(config_use_url_type,"1")==0){
//        char*  pc=(char*)malloc(10);
        char *keyBuff=(char*)malloc(strlen(schema)+strlen(config_pre_url)+strlen(config_url)+1);
        sprintf(keyBuff,"%s%s%s",schema,config_pre_url,config_url);
        setSdkConstantField(env,BASE_URL,env->NewStringUTF(keyBuff));
    }else{
        char *keyBuff=(char*)malloc(strlen(schema)+strlen(config_ip)+1);
        sprintf(keyBuff,"%s%s",schema,config_ip);
        setSdkConstantField(env,BASE_URL,env->NewStringUTF(keyBuff));
    }
    setSdkConstantField(env,BASE_SUFFIX_URL,env->NewStringUTF(config_suffix_url));
    setSdkConstantField(env,BASE_IP,env->NewStringUTF(config_ip));
    setSdkConstantField(env,PROJECT_CODE,env->NewStringUTF(config_project_code));
    setSdkConstantField(env,USE_URL_TYPE,env->NewStringUTF(config_use_url_type));
    setSdkConstantField(env,APP_PACKAGENAME,env->NewStringUTF(appPackageName));//注入app包名

    LOGD("initNetConfigsdk: 注入了url=%s  ip=%s  projectCode=%s  useUrlType=%s",config_url,config_ip,config_project_code,config_use_url_type);
    //读取火速清单文件配置信息
    jobject metaDataBundle = getMetaDataBundle(env, context);
    if(metaDataBundle==NULL){
        return NULL;
    }
    jstring hs_appid = getMetaDataByName(env, metaDataBundle, HS_APPID);

    jstring hs_clientid = getMetaDataByName(env, metaDataBundle, HS_CLIENTID);
    jstring hs_clientkey = getMetaDataByName(env, metaDataBundle, HS_CLIENTKEY);
    jstring hs_appkey = getMetaDataByName(env, metaDataBundle, HS_APPKEY);
    jstring hs_agent = NULL;//不在读取清单文件里面的agent
    setSdkConstantField(env,HS_APPID,hs_appid);
    setSdkConstantField(env,HS_CLIENTID,hs_clientid);
    setSdkConstantField(env,HS_APPKEY,hs_appkey);
    setSdkConstantField(env,HS_CLIENTKEY,hs_clientkey);
    if(hs_clientid!=NULL&&(env)->GetStringLength(hs_clientid)!=0){//获取到mHsClientId，存下来给下面的联网用
        mHsClientId=jstringTostring(env,hs_clientid);
    }else{//没有则置""
        mHsClientId="";
    }
    //从apk里面读取agent
    jclass jChannelUtilClass = env->FindClass("com/game/sdk/util/ChannelNewUtil");
    jmethodID jMGetChannel = env->GetStaticMethodID(jChannelUtilClass, "getChannel", "(Landroid/content/Context;)Ljava/lang/String;");
    jstring apkAgent = static_cast<jstring>(env->CallStaticObjectMethod(jChannelUtilClass, jMGetChannel, context));
    if(apkAgent==NULL||(env)->GetStringLength(apkAgent)==0){
        LOGD("initNetConfigsdk: %s", "apkAgent是null的");
    }else{
        hs_agent=apkAgent;
        LOGD("initNetConfigsdk: %s %s", "apkAgent不是null的:",jstringTostring(env,hs_agent));
    }
    if(apkType==1){//1app,2sdk

        if(hs_agent==NULL||(env)->GetStringLength(hs_agent)==0) { //没有找到，直接返回
            LOGD("initNetConfigsdk: %s", "app_agent 是null的");
            return hs_agent;
        }else{//找到了，更新sdk的agent,保存到本地
            LOGD("initNetConfigsdk: app_agent=%s", jstringTostring(env,hs_agent));
            jmethodID jMSaveAgent = env->GetStaticMethodID(jChannelUtilClass, "saveAgentAndUpdateSdkAgent", "(Landroid/content/Context;Ljava/lang/String;)V");
            env->CallStaticVoidMethod(jChannelUtilClass,jMSaveAgent,context,hs_agent);
        }
    }else{
        if(hs_agent==NULL||(env)->GetStringLength(hs_agent)==0){ //都没有尝试从外部app读取
            LOGD("initNetConfigsdk: %s", "agent 是null的");
            jmethodID jMgetAgent = env->GetStaticMethodID(jChannelUtilClass, "getChannelByApp", "(Landroid/content/Context;)Ljava/lang/String;");
            jstring jOutAgent = static_cast<jstring>(env->CallStaticObjectMethod(jChannelUtilClass, jMgetAgent, context));

            if(jOutAgent!=NULL&&(env)->GetStringLength(jOutAgent)!=0){//外部有
                hs_agent= jOutAgent;
            }else{
                LOGD("initNetConfigsdk: %s", "外部agent 是null的");
            }
        }else{//apk里面或者清单文件里面读到agent后存入本地sp
            LOGD("initNetConfigsdk: agent=%s", jstringTostring(env,hs_agent));
            jmethodID jMSaveAgent = env->GetStaticMethodID(jChannelUtilClass, "saveAgentToSp", "(Landroid/content/Context;Ljava/lang/String;)V");
            env->CallStaticVoidMethod(jChannelUtilClass,jMSaveAgent,context,hs_agent);
        }
    }
    return hs_agent;
}
extern "C"
JNIEXPORT jboolean JNICALL
Java_com_game_sdk_so_SdkNative_isDebug(JNIEnv *env, jclass type) {
    if(DEBUG){
        return  true;
    }else{
        return false;
    }
}
/**
 * 初始化，
 * 读取火速配置信息，设置到SdkConstant对应的变量中
 * apkType 为apk类型，1为app，2为sdk
 */
extern "C"
JNIEXPORT jboolean JNICALL
Java_com_game_sdk_so_SdkNative_initLocalConfig(JNIEnv *env, jclass type, jobject context,jint apkType) {
    //初始化java层配置参数
    jstring jHsAgent = initConstants(env, context,apkType);
    if(jHsAgent!=NULL&&(env)->GetStringLength(jHsAgent)!=0) {
        charHsAgent=jstringTostring(env,jHsAgent);//保存hsAgent供后面联网时进行解密
    }
    return true;//还需要联网
}





/**
 * 初始化，
 * 根据auth_type联网授权
 */
extern "C"
JNIEXPORT void JNICALL
Java_com_game_sdk_so_SdkNative_initNetConfig(JNIEnv *env, jclass type, jobject context,jobject nativeListener) {
    mNativeListener=nativeListener;
    alreadyNotification= false;//重置为没有通知过
    jstring jRsaPublicKey=NULL;
    LOGD("initNetConfigsdk: %s",auth_type);
    if(strcmp("1",auth_type)==0){//不认证
        //使用本地客户rsa
        LOGD("initNetConfigsdk: 准备使用本地rsa");
        jRsaPublicKey= env->NewStringUTF(RSA_CUSTOM_PUBLIC_KEY);

    }else if(strcmp("2",auth_type)==0){//不强制认证
        LOGD("initNetConfigsdk: 不强制认证模式");
        //请求一次，如果失败直接使用客户端本地key
        jRsaPublicKey = getRsaPublicKeyByNet(env, context,1);
        if(jRsaPublicKey==NULL||env->GetStringLength(jRsaPublicKey)==0){//第一次联网失败了
            jRsaPublicKey = getRsaPublicKeyByNet(env, context,2);//第二次联网
            if(jRsaPublicKey==NULL||env->GetStringLength(jRsaPublicKey)==0){//第二次联网失败了
                //使用缓存rsa，没有缓存则本地客户rsa
                jRsaPublicKey = backRsaFromDb(env);
                if(jRsaPublicKey==NULL||env->GetStringLength(jRsaPublicKey)==0){//没有缓存
                    jRsaPublicKey= env->NewStringUTF(RSA_CUSTOM_PUBLIC_KEY);
                }
            }
        }
    }else{
        LOGD("initNetConfigsdk: 强制认证模式");
        //请求三次
        jRsaPublicKey = getRsaPublicKeyByNet(env, context,1);
        if(jRsaPublicKey==NULL||env->GetStringLength(jRsaPublicKey)==0){//第一次联网失败了
            jRsaPublicKey = getRsaPublicKeyByNet(env, context,2);//第二次联网
            if(jRsaPublicKey==NULL||env->GetStringLength(jRsaPublicKey)==0){//第二次联网失败了
                jRsaPublicKey = getRsaPublicKeyByNet(env, context,3);//第三次联网
                if(jRsaPublicKey==NULL||env->GetStringLength(jRsaPublicKey)==0) {//第三次联网失败了
                    //使用缓存rsa，没有缓存，不让通过
                    jRsaPublicKey = backRsaFromDb(env);
                }
            }
        }
    }
    if(jRsaPublicKey!=NULL&&env->GetStringLength(jRsaPublicKey)>0) {//联网获得结果了
        //注入到SdkConstant中
        setSdkConstantField(env,RSA_PUBLIC_KEY,jRsaPublicKey);
        if(charHsAgent!=NULL&&strlen(charHsAgent)>0) {
            jstring jHsAgent = env->NewStringUTF(charHsAgent);
            if(jHsAgent!=NULL&&(env)->GetStringLength(jHsAgent)!=0){//去解密agent
                LOGD("initNetConfigsdk: 联网获得rsa_public_key：%s", jstringTostring(env,jRsaPublicKey));
                LOGD("initNetConfigsdk: 准备解密的agent：%s", jstringTostring(env,jHsAgent));
                //解密渠道信息
                jstring jStrHsAgentRsaDecrypt = rsaDecryptByPublicKey(env, jHsAgent, jRsaPublicKey);
                if(jStrHsAgentRsaDecrypt!=NULL&&(env)->GetStringLength(jStrHsAgentRsaDecrypt)!=0){
                    //注入到SdkConstant常量中
                    setSdkConstantField(env,HS_AGENT,jStrHsAgentRsaDecrypt);
                    LOGD("initNetConfigsdk: 注入解密后的agent：%s", jstringTostring(env,jStrHsAgentRsaDecrypt));
                }
            }
        }else{
            LOGD("initNetConfigsdk: 没有获得agent：%s","");
        }
        onNativeSuccess(env,mNativeListener);
    }else{
        LOGE("initNetConfigsdk: 获取密钥失败,请查看error日志");
        onNativeFail(env,nativeListener,-1,"获取密钥失败,请查看error日志");
    }
}



