package com.huosdk.plugin.flutter_plugin_user_agent_auth.utils;

import android.content.Context;

import io.flutter.plugin.common.MethodChannel;

/**
 * @author zhy.
 * @time 2020/3/20.
 */
public class OaidUtils {

    /**
     * 获取oaid
     */
    public static void getOaid (Context context, MethodChannel.Result result) {
        try {
            IHuoOaid iHuoOaid = new ObtainOaidLmpl();
            iHuoOaid.getOaid(context, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
