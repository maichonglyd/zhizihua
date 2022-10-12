package com.huosdk.flutter_download_plugin;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.wifi.WifiManager;

/**
 * @author liuhongliang
 */
public class ConnectionChangeReceiver extends BroadcastReceiver implements ReceiverManager.IReceiver {
    private static final String TAG = ConnectionChangeReceiver.class.getSimpleName();

    @Override
    public void onReceive(final Context context, Intent intent) {
        //在此监听wifi有无
        if (WifiManager.WIFI_STATE_CHANGED_ACTION.equals(intent.getAction())) {
            int wifiState = intent.getIntExtra(WifiManager.EXTRA_WIFI_STATE, 0);
            switch (wifiState) {
                case WifiManager.WIFI_STATE_DISABLED:
//                    EventBus.getDefault().post(new NetConnectEvent(NetConnectEvent.TYPE_STOP));
                    break;
                case WifiManager.WIFI_STATE_DISABLING:
                    break;
                case WifiManager.WIFI_STATE_ENABLED:
                    break;
                case WifiManager.WIFI_STATE_ENABLING:
                    break;

                case WifiManager.WIFI_STATE_UNKNOWN:
                    break;
                default:
                    break;
            }
        }
//        if (ConnectivityManager.CONNECTIVITY_ACTION.equals(intent.getAction())) {
//            //连接到网络
//            if (NetworkUtils.isConnected()) {
//                //没有初始化成功时，进行初始化操作
//                if (!HuoSdkManager.getInstance().isInitOK()) {
//                    context.startService(new Intent(context, HuoSdkService.class));
//                }
//                Log.e(TAG, "net restart，startup again!");
//                //恢复被动暂停的下载
//                TasksManager.getImpl().netRecover();
//            }
//        }
//        if (!NetworkUtils.isWifiConnected()) {
//            Log.e(TAG, "wifi is not available!");
//            TasksManager.getImpl().wifiOff();
//        }
    }

    /**
     * 动态注册广播
     *
     * @param context
     */
    @Override
    public void register(Context context) {
        //动态注册广播
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.setPriority(1000);
        intentFilter.addAction("android.net.conn.CONNECTIVITY_CHANGE");
        intentFilter.addAction("android.net.wifi.WIFI_STATE_CHANGED");
        intentFilter.addAction("android.net.wifi.STATE_CHANGE");
        intentFilter.addCategory("android.intent.category.DEFAULT");
        context.registerReceiver(this, intentFilter);
    }

    /**
     * 解除注册的广播
     *
     * @param context
     */
    @Override
    public void unRegister(Context context) {
        context.unregisterReceiver(this);
    }
}