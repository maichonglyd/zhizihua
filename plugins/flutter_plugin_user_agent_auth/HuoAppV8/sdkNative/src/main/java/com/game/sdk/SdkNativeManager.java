package com.game.sdk;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.util.Log;
import android.widget.Toast;

import com.game.sdk.so.NativeListener;
import com.game.sdk.so.SdkNative;
import com.blankj.utilcode.util.LogUtils;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by hongliang on 2018/3/22.
 */

public class SdkNativeManager {
    private ExecutorService mSoExecutor = Executors.newCachedThreadPool();
    public static SdkNativeManager getInstance() {
        return SdkNativeManager.SingletonHolder.instance;
    }
    private static class SingletonHolder{
        public static final SdkNativeManager instance=new SdkNativeManager();
    }
    private SdkNativeManager(){
    }
    private Context appContext;

    public void init(Context applicationContext,int type, NativeListener nativeListener) {
        this.appContext=applicationContext;
        SdkNative.soInit(applicationContext,type, nativeListener);
    }

    public Context getAppContext() {
        return appContext;
    }

    public void setAppContext(Context appContext) {
        this.appContext = appContext;
    }

    public void execute(Runnable runnable){
        mSoExecutor.execute(runnable);
    }
}
