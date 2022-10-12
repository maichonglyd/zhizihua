package com.game.sdk.db;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.content.UriMatcher;
import android.database.Cursor;
import android.net.Uri;

import android.util.Log;

import com.blankj.utilcode.util.Utils;
import com.game.sdk.db.impl.AgentDbDao;
import com.game.sdk.db.impl.UserLoginInfodao;
import com.game.sdk.domain.AgentDbBean;
import com.game.sdk.so.SdkNative;
import com.game.sdk.util.Des3;

public class AppContentProvider extends ContentProvider {
    private static final String TAG = AppContentProvider.class.getSimpleName();
    //这里的AUTHORITY就是我们在AndroidManifest.xml中配置的authorities，这里的authorities可以随便写
    private static String AUTHORITY;
    //匹配成功后的匹配码
    private static final int MATCH_ACCOUNT_CODE = 100;
    private static final int MATCH_ONE_AGENT_CODE = 102;
    private static UriMatcher uriMatcher;
    private AgentDbDao agentDbDao;
    private UserLoginInfodao userLoginInfodao;

    @Override
    public boolean onCreate() {
        //注意ContentProvider 的onCreate会在Application的onCreate之前执行，此时，可能部分需要初始化的功能还未ok!
        Utils.init(getContext());
        SdkNative.initLocalConfig(getContext(), SdkNative.TYPE_APP);
        if (uriMatcher == null) {
            AUTHORITY = getContext().getPackageName() + ".appprovider";
            //匹配不成功返回NO_MATCH(-1)
            uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
            /**
             * uriMatcher.addURI(authority, path, code); 其中
             * authority：主机名(用于唯一标示一个ContentProvider,这个需要和清单文件中的authorities属性相同)
             * path:路径路径(可以用来表示我们要操作的数据，路径的构建应根据业务而定)
             * code:返回值(用于匹配uri的时候，作为匹配成功的返回值)
             */
            uriMatcher.addURI(AUTHORITY, "account", MATCH_ACCOUNT_CODE);// 匹配账号记录集合
            uriMatcher.addURI(AUTHORITY, "agent", MATCH_ONE_AGENT_CODE);// 匹配渠道单条记录
        }
        agentDbDao = AgentDbDao.getInstance(getContext());
        userLoginInfodao = UserLoginInfodao.getInstance(getContext());
        return true;
    }

    @Override
    public Cursor query(Uri uri, String[] projection, String selection, String[] args, String sortOrder) {
        Log.d(TAG, "query uri=" + uri + " selection=" + selection + " args");
        int flag = uriMatcher.match(uri);
        switch (flag) {
            case MATCH_ONE_AGENT_CODE:
                if (args != null && args.length > 0) {
                    return agentDbDao.getAgengCursorByPackageName(args[0]);
                }
                break;
            case MATCH_ACCOUNT_CODE:
                return userLoginInfodao.getAccountInfo(projection, selection, args, sortOrder);
        }
        return null;
    }

    @Override
    public String getType(Uri uri) {
        int flag = uriMatcher.match(uri);
        String type = null;
        switch (flag) {
            case MATCH_ONE_AGENT_CODE:
                type = "vnd.android.cursor.item/agent";
                Log.i(TAG, "----->>getType return item agent");
                break;
            case MATCH_ACCOUNT_CODE:
                type = "vnd.android.cursor.dir/accounts";
                Log.i(TAG, "----->>getType return dir accounts");
                break;
        }
        return type;
    }

    @Override
    public Uri insert(Uri uri, ContentValues contentValues) {
        int flag = uriMatcher.match(uri);
        switch (flag) {
            case MATCH_ACCOUNT_CODE:
                String username = contentValues.getAsString(UserLoginInfodao.USERNAME);
                String password = contentValues.getAsString(UserLoginInfodao.PASSWORD);
                //传入的是加密的，需要先解密
                username = Des3.decode(username);
                password = Des3.decode(password);
                userLoginInfodao.saveUserLoginInfo(username, password);
                break;
        }
        return null;
    }

    @Override
    public int delete(Uri uri, String s, String[] args) {
        Log.d(TAG, "delete uri=" + uri + " selection=" + s + " args" + args);
        int flag = uriMatcher.match(uri);
        switch (flag) {
            case MATCH_ACCOUNT_CODE:
                if (args != null && args.length > 0) {
                    String username = Des3.decode(args[0]);
                    Log.d(TAG, "准备删除用户：" + username);
                    userLoginInfodao.deleteUserLoginByName(username);
                }
                break;
            case MATCH_ONE_AGENT_CODE:
                Log.d(TAG, "delete agent db");
                agentDbDao.deleteAgentDb();
                break;
        }
        return 0;
    }

    @Override
    public int update(Uri uri, ContentValues contentValues, String selection, String[] args) {
        Log.d(TAG, "update uri=" + uri + " selection=" + selection + " args" + args);
        int flag = uriMatcher.match(uri);
        switch (flag) {
            case MATCH_ONE_AGENT_CODE:
                if (args != null && args.length > 0) {
                    String packageName = args[0];
                    agentDbDao.useInstallCode(packageName, contentValues.getAsString(AgentDbBean.INSTALL_CODE));
                }
                break;
        }
        return 0;
    }
}
