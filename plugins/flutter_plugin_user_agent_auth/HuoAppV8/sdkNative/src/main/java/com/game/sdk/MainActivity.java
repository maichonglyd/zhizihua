package com.game.sdk;

import android.app.Activity;
import android.os.Bundle;

import com.game.sdk.so.NativeListener;
import com.game.sdk.so.SdkNative;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        SdkNativeApi.init(this, SdkNative.TYPE_SDK, new NativeListener() {
            @Override
            public void onSuccess() {

            }

            @Override
            public void onFail(int code, String msg) {

            }
        });
    }
}
