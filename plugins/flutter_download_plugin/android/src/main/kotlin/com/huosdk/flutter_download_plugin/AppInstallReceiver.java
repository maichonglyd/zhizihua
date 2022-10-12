package com.huosdk.flutter_download_plugin;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;


import java.io.File;
import java.util.Set;

/**
 *
 * @author liuhongliang
 * @date 2018/9/5
 */

public class AppInstallReceiver extends BroadcastReceiver implements ReceiverManager.IReceiver{
    private static final String TAG = "AppInstallReceiver";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (Intent.ACTION_PACKAGE_ADDED.equals(intent.getAction())) {
            //package:com.xiaocaohy.huosuapp
            String packageName = intent.getDataString().substring(8);

            Log.e("abner","AppInstallReceiver:"+packageName);
            FlutterDownloadPlugin.getInstance().installSucCallback(packageName);

//            InstallApkRecord installApkRecord = new InstallApkRecord(1,1);
//            if (installApkRecord == null) {
//                //LogUtils.i(TAG, "安装成功：" + packageName + "  但不是app盒子安装的");
//                return;
//            }
//            if (System.currentTimeMillis() - installApkRecord.getInstallTime() <= 1000 * 60 * 60) {
//                TasksManagerModel taskModelByKeyVal = TasksManager.getImpl().getTaskModelByKeyVal(TasksManagerModel.PACKAGE_NAME, packageName);
//                if (taskModelByKeyVal != null) {
//                    taskModelByKeyVal.setInstalled(1);
//                    TasksManager.getImpl().updateTask(taskModelByKeyVal);
//                    //通知对应的界面展示启动
//                    Set<ApklDownloadListener> fileDownloadListenerList = TasksManager.getImpl().getDownListenerMap().get(taskModelByKeyVal.getGameId());
//                    if (fileDownloadListenerList != null) {
//                        for (ApklDownloadListener apklDownloadListener : fileDownloadListenerList) {
//                            apklDownloadListener.installSuccess();
//                        }
//                    }
//                    //通知下载管理更新显示
////                    EventBus.getDefault().post(new DownInstallSuccessEvent(taskModelByKeyVal));
////                    LogUtils.d(TAG, "更新数据库安装成功记录：" + taskModelByKeyVal.getGameName());
//                    //是否需要删除安装包
//                    boolean installDel = SPUtils.getInstance().getBoolean(SdkConstant.SP_INSTALL_DEL, true);
//                    if (installDel) {
//                        File file = new File(taskModelByKeyVal.getPath());
//                        if (file.isFile() && file.exists()) {
//                            file.delete();
//                        }
//                    }
//                }
//            } else {
////                LogUtils.i(TAG, "安装成功：" + packageName + "  超时安装的，不做记录");
//            }
        }
    }
    /**
     * 动态注册广播
     * @param context
     */
    @Override
    public void register(Context context){
        //动态注册广播
        IntentFilter intentFilter=new IntentFilter();
        intentFilter.setPriority(1000);
        intentFilter.addDataScheme("package");
        intentFilter.addAction(Intent.ACTION_PACKAGE_ADDED);
        intentFilter.addAction(Intent.ACTION_PACKAGE_REPLACED);
        intentFilter.addAction(Intent.ACTION_PACKAGE_REMOVED);
        context.registerReceiver(this,intentFilter);
    }

    /**
     * 解除注册的广播
     * @param context
     */
    @Override
    public void unRegister(Context context){
        context.unregisterReceiver(this);
    }
}
