package com.huosdk.flutter_download_plugin;

import android.content.Context;

import java.util.ArrayList;
import java.util.List;

/**
 * @author hongliang
 * 广播接收管理
 */
public class ReceiverManager {
    private static class SingletonHolder {
        private static ReceiverManager instance = new ReceiverManager();
    }

    public static ReceiverManager getInstance() {
        return SingletonHolder.instance;
    }

    List<IReceiver> receiverList = new ArrayList();

    private ReceiverManager() {
        receiverList.add(new AppInstallReceiver());
        receiverList.add(new ConnectionChangeReceiver());
    }

    public void register(Context context) {
        for (IReceiver iReceiver : receiverList) {
            iReceiver.register(context);
        }
    }

    public void unRegister(Context context) {
        for (IReceiver iReceiver : receiverList) {
            try {
                iReceiver.unRegister(context);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }


    /**
     * 广播接收器通用管理接口
     */
    public interface IReceiver {
        void register(Context context);

        void unRegister(Context context);
    }
}
