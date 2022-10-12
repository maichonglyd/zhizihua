package com.huosdk.plugin.flutter_plugin_user_agent_auth;

import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Handler;
import android.os.Build;
import android.os.Build.VERSION_CODES;
import android.webkit.WebSettings;
import android.webkit.WebView;

import com.blankj.utilcode.util.LogUtils;
import com.blankj.utilcode.util.Utils;
//import com.bun.miitmdid.core.JLibrary;
import com.game.sdk.SdkNativeApi;
import com.game.sdk.SdkNativeConstant;
import com.game.sdk.db.impl.AgentDbDao;
import com.game.sdk.db.impl.UserLoginInfodao;
import com.game.sdk.domain.AgentDbBean;
import com.game.sdk.domain.UserInfo;
import com.game.sdk.so.NativeListener;
import com.game.sdk.so.SdkNative;
import com.game.sdk.util.ChannelNewUtil;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.huosdk.plugin.flutter_plugin_user_agent_auth.utils.OaidUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterPluginUserAgentAuthPlugin
 */
public class FlutterPluginUserAgentAuthPlugin implements MethodCallHandler {
    private Context context;
    private MethodChannel methodChannel;
    private static Activity activity;

    public FlutterPluginUserAgentAuthPlugin(Context context, MethodChannel methodChannel) {
        this.context = context;
        this.methodChannel = methodChannel;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(final Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_plugin_user_agent_auth");
        channel.setMethodCallHandler(new FlutterPluginUserAgentAuthPlugin(registrar.context(), channel));
        Utils.init(registrar.context());
        final Handler handler = new Handler();
        activity = registrar.activity();
//        SdkNativeApi.updateDeviceInfo(registrar.context());
        final Gson gson = new GsonBuilder().serializeNulls().create();
        channel.invokeMethod("initDeviceInfo", gson.toJson(SdkNativeConstant.deviceBean));
        SdkNativeApi.init(registrar.context(), SdkNative.TYPE_APP, new NativeListener() {
            @Override
            public void onSuccess() {
                LogUtils.e("native init ok!");
                handler.post(new Runnable() {
                    @Override
                    public void run() {
                        channel.invokeMethod("nativeInitOK", gson.toJson(new HuoInitInfo()));
                        AgentDbDao.getInstance(registrar.context()).getAgengByPackageNameForProvider(registrar.context().getPackageName());
                    }
                });
            }

            @Override
            public void onFail(int code, String msg) {
                LogUtils.e("native init fail!");
                handler.post(new Runnable() {
                    @Override
                    public void run() {
                        channel.invokeMethod("nativeInitFail", gson.toJson(new HuoInitInfo()));
                    }
                });
            }
        });

//        try {
//            JLibrary.InitEntry(registrar.context());
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getDeviceInfo")) {
            SdkNativeApi.updateDeviceInfo(context);
            result.success(new GsonBuilder().serializeNulls().create().toJson(SdkNativeConstant.deviceBean));
        } else if (call.method.equals("getUserLoginInfo")) {
            List<UserInfo> userLoginInfo = UserLoginInfodao.getInstance(context).getUserLoginInfo();
            result.success(new Gson().toJson(userLoginInfo));
        } else if (call.method.equals("getUserInfoLast")) {
            UserInfo userInfoLast = UserLoginInfodao.getInstance(context).getUserInfoLast();
            result.success(new Gson().toJson(userInfoLast));
        } else if (call.method.equals("saveUserLoginInfo")) {
            String username = call.argument("username");
            String password = call.argument("password");
            UserLoginInfodao.getInstance(context).saveUserLoginInfo(username, password);
            result.success(true);
        } else if (call.method.equals("deleteUserLoginByName")) {
            String username = call.argument("username");
            UserLoginInfodao.getInstance(context).deleteUserLoginByName(username);
            result.success(true);
        } else if (call.method.equals("addOrUpdateAgent")) {
            String packageName = call.argument("packageName");
            String installCode = call.argument("installCode");
//            String agent = call.argument("agent");
            AgentDbBean agentDbBean = new AgentDbBean(packageName, installCode, ChannelNewUtil.getEncryptAgentBySp(context));
            AgentDbDao.getInstance(context).addOrUpdate(agentDbBean);
            result.success(true);
        } else if (call.method.equals("getOaid")) {
            OaidUtils.getOaid(context, result);
        } else if (call.method.equals("getAppInstall")) {
            String uriSchema = call.argument("uri").toString();
            checkAvailability(uriSchema, result);
        } else if (call.method.equals("finishApp")) {
            finishApp(result);
        } else if (call.method.equals("getWebViewUserAgent")) {
            String webViewUserAgent = getWebViewUserAgent();
            result.success(webViewUserAgent);
        } else {
            result.notImplemented();
        }
    }

    private void checkAvailability(String uri, Result result) {
        PackageInfo info = getAppPackageInfo(uri);

        if(info != null) {
            result.success(this.convertNullInfoToJson(true));
            return;
        }
        result.success(this.convertNullInfoToJson(false));
    }

    private PackageInfo getAppPackageInfo(String uri) {
        Context ctx = context.getApplicationContext();
        final PackageManager pm = ctx.getPackageManager();

        try {
            return pm.getPackageInfo(uri, PackageManager.GET_ACTIVITIES);
        } catch(PackageManager.NameNotFoundException e) {

        }

        return null;
    }

    private Map<String, Object> convertNullInfoToJson(boolean result) {
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        return map;
    }

    private void finishApp(Result result) {
        result.success(true);
        activity.finishAffinity();
        System.exit(0);
    }

    private String getWebViewUserAgent() {
        if (Build.VERSION.SDK_INT >= VERSION_CODES.JELLY_BEAN_MR1) {
            return WebSettings.getDefaultUserAgent(context);
        }

        WebView webView = new WebView(context);
        String userAgentString = webView.getSettings().getUserAgentString();

        destroyWebView(webView);

        return userAgentString;
    }

    private void destroyWebView(WebView webView) {
        webView.loadUrl("about:blank");
        webView.stopLoading();

        webView.clearHistory();
        webView.removeAllViews();
        webView.destroyDrawingCache();

        // NOTE: This can occasionally cause a segfault below API 17 (4.2)
        webView.destroy();
    }

    static class HuoInitInfo {
        public String hs_appid = "";
        public String hs_clientid = "";
        public String hs_clientkey = "";
        public String hs_appkey = "";
        public String hs_agent = "";
        public String from = "3";
        public String base_url = "";
        public String base_suffix_url = "";
        public String base_ip;
        public String project_code;
        public String use_url_type;
        public String app_packagename;
        public String packagename = "";
        public String rsa_public_key;

        public HuoInitInfo() {
            this.hs_appid = SdkNativeConstant.HS_APPID;
            this.hs_clientid = SdkNativeConstant.HS_CLIENTID;
            this.hs_clientkey = SdkNativeConstant.HS_CLIENTKEY;
            this.hs_agent = SdkNativeConstant.HS_AGENT;
            this.from = SdkNativeConstant.FROM;
            this.base_url = SdkNativeConstant.BASE_URL;
            this.base_suffix_url = SdkNativeConstant.BASE_SUFFIX_URL;
            this.base_ip = SdkNativeConstant.BASE_IP;
            this.project_code = SdkNativeConstant.PROJECT_CODE;
            this.use_url_type = SdkNativeConstant.USE_URL_TYPE;
            this.app_packagename = SdkNativeConstant.APP_PACKAGENAME;
            this.rsa_public_key = SdkNativeConstant.RSA_PUBLIC_KEY;
            this.packagename = SdkNativeConstant.packageName;
        }
    }
}
