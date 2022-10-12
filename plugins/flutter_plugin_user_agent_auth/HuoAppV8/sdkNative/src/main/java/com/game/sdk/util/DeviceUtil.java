package com.game.sdk.util;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.graphics.Point;
import android.net.NetworkInfo;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Environment;
import android.os.Looper;
import android.os.StatFs;
import android.os.SystemClock;
import android.provider.Settings;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.view.WindowManager;
import android.webkit.WebSettings;
import android.webkit.WebView;

import com.blankj.utilcode.util.DeviceUtils;
import com.blankj.utilcode.util.NetworkUtils;
import com.blankj.utilcode.util.PhoneUtils;
import com.blankj.utilcode.util.SizeUtils;
import com.game.sdk.domain.DeviceBean;
import com.blankj.utilcode.util.LogUtils;
import com.game.sdk.util.NotProguard;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.net.Inet6Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;
import java.util.List;
import java.util.UUID;

/**
 * Created by liu hong liang on 2016/11/11.
 */
@NotProguard
public class DeviceUtil {
    public static String userAgent;

    @SuppressLint("MissingPermission")
    public static DeviceBean getDeviceBean(Context context) {
        // 设备管理器
//        TelephonyManager telephonyManager = (TelephonyManager) context
//                .getSystemService(Context.TELEPHONY_SERVICE);
        DeviceBean deviceBean = new DeviceBean();
        deviceBean.setDevice_id(getDeviceId(context));
        deviceBean.setImei(getImei());
        deviceBean.setIdfv(getAndroidId(context));
        deviceBean.setMac(getLocalMac(context));
        deviceBean.setIp(getHostIP());
        deviceBean.setBrand(Build.BRAND);
        deviceBean.setModel(Build.MODEL);
        deviceBean.setOs_version(Build.VERSION.RELEASE);
        deviceBean.setScreen(getResolution(context));
        deviceBean.setNet(getNetworkType());
        if (TextUtils.isEmpty(userAgent)) {
            userAgent = getUserUa(context);
        }
        deviceBean.setUserua(userAgent);
        try {
            deviceBean.setImsi(PhoneUtils.getIMSI());
        } catch (Exception e) {
            e.printStackTrace();
        }
        deviceBean.setDisk_space(getDiskState());
        deviceBean.setOpen_time(getOpenTime() + "");
        try {
            deviceBean.setHas_sim(PhoneUtils.isSimCardReady() ? "2" : "1");
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            deviceBean.setIs_break(DeviceUtils.isDeviceRooted() ? "1" : "2");
        } catch (Exception e) {
            e.printStackTrace();
        }
        deviceBean.setDeviceinfo(getPhoneNum(context) + "||android" + Build.VERSION.RELEASE);
        deviceBean.setLocal_ip(getHostIP());
        return deviceBean;
    }


    /**
     * Return type of network.
     * <p>Must hold {@code <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />}</p>
     */
    public static String getNetworkType() {
        NetworkUtils.NetworkType networkType = null;
        try {
            networkType = NetworkUtils.getNetworkType();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(networkType==null){
            return "UNKNOWN";
        }
        switch (networkType) {
            case NETWORK_2G:
                return "2G";
            case NETWORK_3G:
                return "3G";
            case NETWORK_4G:
                return "4G";
            case NETWORK_WIFI:
                return "WIFI";
            case NETWORK_NO:
                return "NO";
            case NETWORK_UNKNOWN:
                return "UNKNOWN";
        }
        return "UNKNOWN";
    }

    /**
     * @return 总容量-已用
     */
    public static String getDiskState() {
        try {
            File root = Environment.getRootDirectory();
            StatFs sf = new StatFs(root.getPath());
            long blockSize = sf.getBlockSize();
            long blockCount = sf.getBlockCount();
            long availCount = sf.getFreeBlocks();
            return (blockCount * blockSize) + "-" + (availCount * blockSize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "none";
    }

    /**
     * 系统开机至今的时长，单位秒
     *
     * @return
     */
    public static long getOpenTime() {
        return SystemClock.elapsedRealtime() / 1000;
    }

    /**
     * Return the width of screen, in pixel.
     *
     * @return the width of screen, in pixel
     */
    public static int getScreenWidth(Context context) {
        WindowManager wm = (WindowManager) context.getApplicationContext().getSystemService(Context.WINDOW_SERVICE);
        if (wm == null) return -1;
        Point point = new Point();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            wm.getDefaultDisplay().getRealSize(point);
        } else {
            wm.getDefaultDisplay().getSize(point);
        }
        return point.x;
    }

    /**
     * Return the height of screen, in pixel.
     *
     * @return the height of screen, in pixel
     */
    public static int getScreenHeight(Context context) {
        WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
        if (wm == null) return -1;
        Point point = new Point();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            wm.getDefaultDisplay().getRealSize(point);
        } else {
            wm.getDefaultDisplay().getSize(point);
        }
        return point.y;
    }

    /**
     * 获取手机分辨率
     *
     * @return 分辨率 如：2560*1600
     */
    public static String getResolution(Context context) {
        return getScreenWidth(context) + "*" + getScreenHeight(context);
    }

    @SuppressLint("MissingPermission")
    public static String getPhoneNum(Context context) {
        TelephonyManager telephonyManager = (TelephonyManager) context
                .getSystemService(Context.TELEPHONY_SERVICE);
        String phoneNum = null;
        try {
            phoneNum = telephonyManager.getLine1Number();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (TextUtils.isEmpty(phoneNum)) {
            return "null";
        } else {
            return phoneNum;
        }
    }

    @SuppressLint("MissingPermission")
    public static String getImei() {
        try {
            return PhoneUtils.getIMEI();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    /**
     * 获取设备ID
     *
     * @param context
     * @return
     */
    @SuppressLint("MissingPermission")
    public static String getDeviceId(Context context) {
        String deviceId = "";
        TelephonyManager telephony = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
        try {
            deviceId = telephony.getDeviceId();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (TextUtils.isEmpty(deviceId)) {
            deviceId = Settings.Secure.getString(context.getContentResolver(), "android_id");
        }
        if (!TextUtils.isEmpty(deviceId)) {
            return deviceId;
        }
        //使用mac地址
        try {
            deviceId = getLocalMac(context).replace(":", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (!TextUtils.isEmpty(deviceId)) {
            return deviceId;
        }
        //使用UUID
        UUID uuid = UUID.randomUUID();
        deviceId = uuid.toString().replace("-", "");
        return deviceId;
    }

    public static boolean isPhone(Context context) {
        TelephonyManager telephony = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
        int type = telephony.getPhoneType();
        if (type == 0) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 获取ua信息
     *
     * @throws UnsupportedEncodingException
     */
    public static String getUserUa(Context context) {
        try {
            if (Build.VERSION.SDK_INT < 19) {
                WebView webview = new WebView(context);
                WebSettings settings = webview.getSettings();
                return settings.getUserAgentString();
            } else {
                return WebSettings.getDefaultUserAgent(context);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public static boolean isMainThread() {
        return Looper.getMainLooper() == Looper.myLooper();
    }

    /**
     * 获取ip地址
     *
     * @return
     */
    public static String getHostIP() {
        String hostIp = null;
        try {
            Enumeration nis = NetworkInterface.getNetworkInterfaces();
            InetAddress ia = null;
            while (nis.hasMoreElements()) {
                NetworkInterface ni = (NetworkInterface) nis.nextElement();
                Enumeration<InetAddress> ias = ni.getInetAddresses();
                while (ias.hasMoreElements()) {
                    ia = ias.nextElement();
                    if (ia instanceof Inet6Address) {
                        continue;// skip ipv6
                    }
                    String ip = ia.getHostAddress();
                    if (!"127.0.0.1".equals(ip)) {
                        hostIp = ia.getHostAddress();
                        break;
                    }
                }
            }
        } catch (SocketException e) {
            e.printStackTrace();
        }
        return hostIp;
    }

    // IMEI码
    private static String getIMIEStatus(Context context) {
        try {
            TelephonyManager tm = (TelephonyManager) context
                    .getSystemService(Context.TELEPHONY_SERVICE);
            @SuppressLint("MissingPermission") String deviceId = tm.getDeviceId();
            return deviceId;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    // Mac地址
    private static String getLocalMac(Context context) {
        try {
            WifiManager wifi = (WifiManager) context
                    .getSystemService(Context.WIFI_SERVICE);
            WifiInfo info = wifi.getConnectionInfo();
            return info.getMacAddress();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    // Android Id
    private static String getAndroidId(Context context) {
        String androidId = Settings.Secure.getString(
                context.getContentResolver(), Settings.Secure.ANDROID_ID);
        return androidId;
    }


    /**
     * 打开权限设置界面
     */
    public static void openSettingPermission(Context context) {
//        try {
//            if(MiuiDeviceUtil.isMiui()){
//                MiuiDeviceUtil.openMiuiPermissionActivity(context);
//            }else{
//                Intent intent1 = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
//                Uri uri = Uri.fromParts("package", context.getPackageName(), null);
//                intent1.setData(uri);
//                context.startActivity(intent1);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }

    /**
     * 获取当前应用程序的版本号
     *
     * @return
     * @author wangjie
     */
    public static int getAppVersionCode(Context context) {
        int version = 1;
        try {
            version = context.getPackageManager().getPackageInfo(context.getPackageName(), 0).versionCode;
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        return version;
    }

    /**
     * 判断是魅族操作系统
     * <h3>Version</h3> 1.0
     * <h3>CreateTime</h3> 2016/6/18,9:43
     * <h3>UpdateTime</h3> 2016/6/18,9:43
     * <h3>CreateAuthor</h3> vera
     * <h3>UpdateAuthor</h3>
     * <h3>UpdateInfo</h3> (此处输入修改内容,若无修改可不写.)
     *
     * @return true 为魅族系统 否则不是
     */
    public static boolean isMeizuFlymeOS() {
        /* 获取魅族系统操作版本标识*/
        String meizuFlymeOSFlag = getSystemProperty("ro.build.display.id", "");
        if (TextUtils.isEmpty(meizuFlymeOSFlag)) {
            return false;
        } else if (meizuFlymeOSFlag.contains("flyme") || meizuFlymeOSFlag.toLowerCase().contains("flyme")) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 获取系统属性
     * <h3>Version</h3> 1.0
     * <h3>CreateTime</h3> 2016/6/18,9:35
     * <h3>UpdateTime</h3> 2016/6/18,9:35
     * <h3>CreateAuthor</h3> vera
     * <h3>UpdateAuthor</h3>
     * <h3>UpdateInfo</h3> (此处输入修改内容,若无修改可不写.)
     *
     * @param key          ro.build.display.id
     * @param defaultValue 默认值
     * @return 系统操作版本标识
     */
    private static String getSystemProperty(String key, String defaultValue) {
        try {
            Class<?> clz = Class.forName("android.os.SystemProperties");
            Method get = clz.getMethod("get", String.class, String.class);
            return (String) get.invoke(clz, key, defaultValue);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static int isInstallApplication(Context context, String packageName) {
        final PackageManager packageManager = context.getPackageManager();// 获取packagemanager
        List<PackageInfo> pinfo = packageManager.getInstalledPackages(0);// 获取所有已安装程序的包信息
        if (pinfo == null || pinfo.size() == 0) {//防止部分手机获取不到应用程序列表时提示未安装
            return -1;
        }
        if (pinfo != null) {
            for (int i = 0; i < pinfo.size(); i++) {
                String pn = pinfo.get(i).packageName;
                if (pn.equals(packageName)) {
                    return 1;
                }
            }
        }
        return 0;
    }
}
