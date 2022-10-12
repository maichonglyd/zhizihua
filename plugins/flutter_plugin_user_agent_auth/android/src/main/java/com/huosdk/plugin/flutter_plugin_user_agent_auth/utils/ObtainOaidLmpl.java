package com.huosdk.plugin.flutter_plugin_user_agent_auth.utils;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import java.util.Date;

import io.flutter.plugin.common.MethodChannel;

public class ObtainOaidLmpl extends IHuoOaid {

    private static final String TAG = ObtainOaidLmpl.class.getSimpleName();

    private static final String SP_NAME = "SharedPreferences_OAID";
    private static final String SP_OAID = "sp_oaid";
    private static final String SP_HAS_GET_OAID = "sp_has_get_oaid";
    private static final String PREF_OAID_GET_TIME = "pref_oaid_get_time";

    private boolean hasCallback = false;

    @Override
    public void getOaid(final Context context, final MethodChannel.Result result) {
        if (getSpHasGetOaid(context)) {
            callbackResult(result, getSpOaid(context));
        } else {
            final String[] OAID = {""};
            setOaidGetTime(context, new Date().getTime());
            int responseCode = new MittUtils().getDeviceIds(context, new MittUtils.AppIdsUpdater() {
                @Override
                public void OnIdsAvailed(boolean isSupport, String oaid) {
                    if (!isSupport) {
                        setSpOaid(context, "");
                        setSpHasGetOaid(context, true);
                        callbackResult(result, "");
                        return;
                    }
                    OAID[0] = oaid;
                    setSpOaid(context, oaid);
                    setSpHasGetOaid(context, true);
                    callbackResult(result, oaid);
                }
            });

            // 有些机型获取不到OAID并上面的回调也没有执行，或者获取OAID的时间过长，需要三秒内返回结果
            long time = new Date().getTime();
    //        Log.d("HuoApp", "getOaid: getTime = " + getOaidGetTime(context));
            while (!getSpHasGetOaid(context) && 2500 > time - getOaidGetTime(context)) {
                time = new Date().getTime();
    //            Log.d("HuoApp", "getOaid: time = " + time);
            }
            callbackResult(result, getSpOaid(context));
        }
    }

    private void callbackResult(final MethodChannel.Result result, final String oaid) {
        if (hasCallback) return;

        try {
            hasCallback = true;
            Handler handler = new Handler(Looper.getMainLooper());
            handler.post(new Runnable() {
                @Override
                public void run() {
                    result.success(oaid);
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static SharedPreferences getSharedPreferences(Context context) {
        return context.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
    }

    public void setSpHasGetOaid(Context context, boolean has) {
        SharedPreferences sharedPreferences = getSharedPreferences(context);
        sharedPreferences.edit().putBoolean(SP_HAS_GET_OAID, has).apply();
    }

    public boolean getSpHasGetOaid(Context context) {
        SharedPreferences sharedPreferences = getSharedPreferences(context);
        return sharedPreferences.getBoolean(SP_HAS_GET_OAID, false);
    }

    public void setSpOaid(Context context, String oaid) {
        SharedPreferences sharedPreferences = getSharedPreferences(context);
        sharedPreferences.edit().putString(SP_OAID, oaid).apply();
    }

    public String getSpOaid(Context context) {
        SharedPreferences sharedPreferences = getSharedPreferences(context);
        return sharedPreferences.getString(SP_OAID, "");
    }

    public void setOaidGetTime(Context context, long time) {
        SharedPreferences sharedPreferences = getSharedPreferences(context);
        sharedPreferences.edit().putLong(PREF_OAID_GET_TIME, time).apply();
    }

    public long getOaidGetTime(Context context) {
        SharedPreferences sharedPreferences = getSharedPreferences(context);
        return sharedPreferences.getLong(PREF_OAID_GET_TIME, 0);
    }

}
