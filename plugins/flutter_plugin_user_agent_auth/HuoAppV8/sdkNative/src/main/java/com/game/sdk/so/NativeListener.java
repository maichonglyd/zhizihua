package com.game.sdk.so;


import com.game.sdk.util.NotProguard;

/**
 * Created by liu hong liang on 2016/11/11.
 */
public interface NativeListener {
    void onSuccess();
    void onFail(int code, String msg);
}
