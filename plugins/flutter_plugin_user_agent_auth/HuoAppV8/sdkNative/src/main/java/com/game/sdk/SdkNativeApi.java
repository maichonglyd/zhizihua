package com.game.sdk;

import android.content.Context;

import com.game.sdk.so.NativeListener;
import com.game.sdk.util.DeviceUtil;
import com.game.sdk.util.NotProguard;

/**
 * Created by hongliang on 2018/3/22.
 * 火速sdk v8本地c操作api
 */
public class SdkNativeApi {
    /**
     * native 安全初始化
     */
    @NotProguard
    public static void init(Context applicationContext, int type, NativeListener nativeListener) {
        SdkNativeManager.getInstance().init(applicationContext, type, nativeListener);
    }

    /**
     * 更新设备信息，用户申请完权限后获得
     */
    @NotProguard
    public static void updateDeviceInfo(Context context) {
        //初始化设备信息
        SdkNativeConstant.deviceBean = DeviceUtil.getDeviceBean(context);
    }

}
