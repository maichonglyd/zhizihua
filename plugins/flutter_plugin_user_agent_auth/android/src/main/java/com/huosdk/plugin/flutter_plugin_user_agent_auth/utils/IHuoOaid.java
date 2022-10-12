package com.huosdk.plugin.flutter_plugin_user_agent_auth.utils;

import android.content.Context;

import io.flutter.plugin.common.MethodChannel;

public abstract class IHuoOaid {

    public abstract void getOaid(Context context, MethodChannel.Result result);

}
