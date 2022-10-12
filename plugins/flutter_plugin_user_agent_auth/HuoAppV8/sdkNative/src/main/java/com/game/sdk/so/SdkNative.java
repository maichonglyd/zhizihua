package com.game.sdk.so;

import android.content.Context;
import android.content.SharedPreferences;
import android.text.TextUtils;
import android.util.Log;

import com.game.sdk.SdkNativeConstant;
import com.game.sdk.SdkNativeManager;
import com.game.sdk.db.impl.AgentDbDao;
import com.game.sdk.domain.InstallDbBean;
import com.game.sdk.util.DeviceUtil;
import com.blankj.utilcode.util.LogUtils;
import com.game.sdk.util.NotProguard;

import java.lang.annotation.Native;


/**
 * Created by Liuhongliangsdk on 2016/11/6.
 */
@NotProguard
public class SdkNative {
    public final static int TYPE_APP = 1;
    public final static int TYPE_SDK = 2;
    private final static boolean isJarDebug = false;

    static {
        System.loadLibrary("hs_sdk-lib");
    }

    /**
     * A native method that is implemented by the 'native-lib' native library,
     * which is packaged with this application.
     * count 为请求次数，会根据count 进行切换地址
     * 网络初始化
     */
    public static synchronized native void initNetConfig(Context context, NativeListener listener);

    /**
     * 本地初始化
     *
     * @param context
     * @param apkType apk类型，1为app,2为sdk
     * @return true：需要网络初始化，false:不需要网络初始化了
     */
    public static synchronized native boolean initLocalConfig(Context context, int apkType);

    /**
     * 获取是否开启调试模式
     *
     * @return
     */
    public static native boolean isDebug();

    /**
     * 保存install结果
     *
     * @param rsa_code
     * @param url
     * @return
     */
    public static void saveInstallResult(String rsa_code, String url) {
        if (!TextUtils.isEmpty(url)) {
            AgentDbDao.getInstance(SdkNativeManager.getInstance().getAppContext()).updateOrAddInstallDb(rsa_code, url);
        }
    }

    public static int addInstallOpenCnt(Context context) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(SdkNativeConstant.SP_RSA_PUBLIC_KEY, Context.MODE_PRIVATE);
        int openCnt = sharedPreferences.getInt(SdkNativeConstant.SP_OPEN_CNT, 0);
        if (openCnt + 1 == Integer.MAX_VALUE - 100) {//达到最大值
            openCnt = 0;
        }
        sharedPreferences.edit().putInt(SdkNativeConstant.SP_OPEN_CNT, openCnt + 1).commit();
        return openCnt + 1;
    }

    public static void resetInstall(Context context) {
        AgentDbDao.getInstance(SdkNativeManager.getInstance().getAppContext()).deleteInstallDb();
    }

    public static String getInstallDbRsa() {
        InstallDbBean installDb = AgentDbDao.getInstance(SdkNativeManager.getInstance().getAppContext()).getInstallDb();
        if (installDb != null) {
            return installDb.getRsa_code();
        }
        return null;
    }

    public static String getInstallDbUrl() {
        InstallDbBean installDb = AgentDbDao.getInstance(SdkNativeManager.getInstance().getAppContext()).getInstallDb();
        if (installDb != null) {
            return installDb.getUrl();
        }
        return null;
    }

    public static void soInit(final Context context, int type, final NativeListener nativeListener) {
        if(SdkNativeConstant.deviceBean==null){
            //初始化设备信息
            SdkNativeConstant.deviceBean = DeviceUtil.getDeviceBean(context);
        }
        SdkNativeConstant.packageName = context.getPackageName();
        if (initLocalConfig(context, type)) {
            SdkNativeManager.getInstance().execute(new Runnable() {
                @Override
                public void run() {
                    SdkNative.initNetConfig(context, nativeListener);
                }
            });
        } else {
            nativeListener.onSuccess();
        }
    }
}
