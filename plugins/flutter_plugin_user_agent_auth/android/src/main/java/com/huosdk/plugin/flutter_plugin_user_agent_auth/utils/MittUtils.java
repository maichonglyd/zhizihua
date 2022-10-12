package com.huosdk.plugin.flutter_plugin_user_agent_auth.utils;

import android.content.Context;

import com.bun.miitmdid.core.ErrorCode;
import com.bun.miitmdid.core.MdidSdkHelper;
import com.bun.miitmdid.interfaces.IIdentifierListener;
import com.bun.miitmdid.interfaces.IdSupplier;

public class MittUtils implements IIdentifierListener {

    private AppIdsUpdater listener;

    public MittUtils() {
    }

    public int getDeviceIds(Context context, AppIdsUpdater listener) {
        this.listener = listener;
        //方法调用
        int responseCode = CallFromReflect(context);
        switch (responseCode) {
            case ErrorCode.INIT_ERROR_DEVICE_NOSUPPORT://不支持的设备
            case ErrorCode.INIT_ERROR_LOAD_CONFIGFILE://加载配置文件出错
            case ErrorCode.INIT_ERROR_MANUFACTURER_NOSUPPORT://不支持的设备厂商
//            case ErrorCode.INIT_ERROR_RESULT_DELAY://获取接口是异步的，结果会在回调中返回，回调执行的回调可能在工作线程
            case ErrorCode.INIT_HELPER_CALL_ERROR://反射调用出错
                if (listener != null) {
                    listener.OnIdsAvailed(false, null);
                    listener = null;
                }
                break;
        }
        return responseCode;
    }

    /**
     * 方法调用
     *
     * @param cxt
     * @return
     */
    private int CallFromReflect(Context cxt) {
        return MdidSdkHelper.InitSdk(cxt, true, this);
    }


    @Override
    public void OnSupport(boolean isSupport, IdSupplier idSupplier) {
        if (idSupplier == null) {
            if (listener != null) {
                listener.OnIdsAvailed(isSupport, null);
            }
            return;
        }
        String oaid = idSupplier.getOAID();
        if (listener != null) {
            listener.OnIdsAvailed(isSupport, oaid);
        }
    }

    public interface AppIdsUpdater {
        void OnIdsAvailed(boolean isSupport, String oaid);
    }

}
