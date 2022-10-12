package com.huosdk.flutter_download_plugin;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;

import androidx.core.content.FileProvider;

import java.io.File;

public class AppUtils {
    public static void installApk(Context context, File file) {
        Intent intent = new Intent();
        intent.setAction("android.intent.action.VIEW");
        intent.addCategory("android.intent.category.DEFAULT");
//        判断是否是AndroidN以及更高的版本
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            Uri contentUri = FileProvider.getUriForFile(context,  context.getPackageName() + ".fileprovider", file);
            intent.setDataAndType(contentUri, "application/vnd.android.package-archive");
        } else {
            intent.setDataAndType(Uri.fromFile(file), "application/vnd.android.package-archive");
        }
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(intent);
    }


    public static int getVersionCodeFromApkFile(Context context, String apkFile) {
        try {
            PackageManager packageManager = context.getPackageManager();
            PackageInfo packageInfo = packageManager.getPackageArchiveInfo(apkFile, 1);
            return packageInfo.versionCode;
        } catch (Exception var4) {
            var4.printStackTrace();
            return 0;
        }
    }
    //获取apk名字
    public static String getPackageNameByApkFile(Context context, String apkFilePath) {
        PackageManager pm = context.getPackageManager();
        PackageInfo info = pm.getPackageArchiveInfo(apkFilePath, 1);
        ApplicationInfo appInfo = null;
        if(info != null) {
            appInfo = info.applicationInfo;
            String packageName = appInfo.packageName;
            return packageName;
        } else {
            return "";
        }
    }

    public static boolean openAppByPackageName(Context context, String packageName) {
        Intent intent = getIntentByPackageName(context, packageName);
        if(intent != null) {
            intent.addFlags(268435456);
            context.startActivity(intent);
            return true;
        } else {
            return false;
        }
    }

    private static Intent getIntentByPackageName(Context context, String packageName) {
        return context.getPackageManager().getLaunchIntentForPackage(packageName);
    }

    public static String getAppAgent(Context context) {
        SharedPreferences sp = context.getSharedPreferences("agent.sp", Context.MODE_PRIVATE);
        return sp.getString("agent", null);
    }
}
