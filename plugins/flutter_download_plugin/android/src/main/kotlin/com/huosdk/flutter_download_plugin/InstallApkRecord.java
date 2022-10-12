package com.huosdk.flutter_download_plugin;

/**
 * Created by liu hong liang on 2016/12/19.
 */

public class InstallApkRecord {
    private int versionCode;
    private long installTime;

    public InstallApkRecord(int versionCode, long installTime) {
        this.versionCode = versionCode;
        this.installTime = installTime;
    }

    public int getVersionCode() {
        return versionCode;
    }

    public void setVersionCode(int versionCode) {
        this.versionCode = versionCode;
    }

    public long getInstallTime() {
        return installTime;
    }

    public void setInstallTime(long installTime) {
        this.installTime = installTime;
    }
}
