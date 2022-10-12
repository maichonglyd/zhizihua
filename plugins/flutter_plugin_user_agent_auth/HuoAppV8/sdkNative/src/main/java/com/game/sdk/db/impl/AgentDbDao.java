package com.game.sdk.db.impl;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;
import android.text.TextUtils;
import android.util.Log;

import com.game.sdk.SdkNativeConstant;
import com.game.sdk.db.DBHelper;
import com.game.sdk.domain.AgentDbBean;
import com.game.sdk.domain.InstallDbBean;
import com.blankj.utilcode.util.LogUtils;


/**
 * Created by liu hong liang on 2016/9/29.
 */

public class AgentDbDao {
    public static final String AGENT_TABLE_NAME = "tagent";
    public static final String INSTALL_TABLE_NAME = "tinstall";


    private static AgentDbDao agentDbDao;
    private DBHelper dbHelper;
    private Context mContext;

    private AgentDbDao(Context context) {
        mContext = context;
        dbHelper = new DBHelper(context.getApplicationContext(), null, DBHelper.DB_VERSION);
    }

    public synchronized static AgentDbDao getInstance(Context context) {
        if (agentDbDao == null) {
            agentDbDao = new AgentDbDao(context);
        }
        return agentDbDao;
    }

    public void addOrUpdate(AgentDbBean agentDbBean) {
        try {
            SQLiteDatabase writableDatabase = dbHelper.getWritableDatabase();
            Cursor cursor = writableDatabase.rawQuery("select * from " + AGENT_TABLE_NAME + " where packageName=?", new String[]{agentDbBean.getPackageName()});
            AgentDbBean oldAgentDbBean = null;
            while (cursor.moveToNext()) {
                oldAgentDbBean = new AgentDbBean();
                oldAgentDbBean.setPackageName(cursor.getString(cursor.getColumnIndex(AgentDbBean.PACKAGE_NAME)));
                oldAgentDbBean.setInstallCode(cursor.getString(cursor.getColumnIndex(AgentDbBean.INSTALL_CODE)));
                if (oldAgentDbBean.getInstallCode() == null) {
                    oldAgentDbBean.setInstallCode("1_0");
                }
                oldAgentDbBean.setAgent(cursor.getString(cursor.getColumnIndex(AgentDbBean.AGENT)));
                LogUtils.d("AgentDbDao", "存在agent-->" + oldAgentDbBean.toString());
            }

            if (oldAgentDbBean != null) {
                LogUtils.d("AgentDbDao", "更新老的agent-->" + oldAgentDbBean.toString());
                oldAgentDbBean.setAgent(agentDbBean.getAgent());
                oldAgentDbBean.setInstallCode(agentDbBean.getInstallCode());
                int update = writableDatabase.update(AGENT_TABLE_NAME, oldAgentDbBean.toContentValues(), AgentDbBean.PACKAGE_NAME + "=?", new String[]{oldAgentDbBean.getPackageName()});
                LogUtils.d("AgentDbDao", "更新agent-->" + oldAgentDbBean.toString() + " count=" + update);
            } else {
                long insert = writableDatabase.insert(AGENT_TABLE_NAME, null, agentDbBean.toContentValues());
                LogUtils.d("AgentDbDao", "存入agent-->" + agentDbBean.toString() + " count=" + insert);
            }
            cursor.close();
            writableDatabase.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 更新为已经使用
     *
     * @param packageName
     * @param installCode
     */
    public void useInstallCode(String packageName, String installCode) {
        try {
            SQLiteDatabase writableDatabase = dbHelper.getWritableDatabase();
            ContentValues cv = new ContentValues();
            cv.put(AgentDbBean.INSTALL_CODE, installCode);
            int update = writableDatabase.update(AGENT_TABLE_NAME, cv, "packageName=?", new String[]{packageName});
            writableDatabase.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateAllAgent(String agent) {
        try {
            if (agent == null) agent = "";
            //先取出一个查看是否和要更新的agent是否相同
            SQLiteDatabase writableDatabase = dbHelper.getWritableDatabase();
            Cursor cursor = writableDatabase.rawQuery("select * from " + AGENT_TABLE_NAME + " limit 1", null);
            AgentDbBean oldAgentDbBean = null;
            while (cursor.moveToNext()) {
                oldAgentDbBean = new AgentDbBean();
                oldAgentDbBean.setPackageName(cursor.getString(cursor.getColumnIndex(AgentDbBean.PACKAGE_NAME)));
                oldAgentDbBean.setInstallCode(cursor.getString(cursor.getColumnIndex(AgentDbBean.INSTALL_CODE)));
                if (oldAgentDbBean.getInstallCode() == null) {
                    oldAgentDbBean.setInstallCode("1_0");
                }
                oldAgentDbBean.setAgent(cursor.getString(cursor.getColumnIndex(AgentDbBean.AGENT)));
            }
            if (oldAgentDbBean != null && !agent.equals(oldAgentDbBean.getAgent())) {//有并且不一样
                ContentValues cv = new ContentValues();
                cv.put(AgentDbBean.AGENT, agent);
                int update = writableDatabase.update(AGENT_TABLE_NAME, cv, null, null);
                LogUtils.d("AgentDbDao", "更新了所有的agent--> count=" + update + "  agent=" + agent + " packageName=" + oldAgentDbBean.getPackageName());
            } else {
                LogUtils.d("AgentDbDao", "无需更新--> agent=" + agent);
            }
            cursor.close();
            writableDatabase.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 从app提供的contentProvider中获取agent数据，本地数据库在没有获取存储权限时无法使用
     *
     * @param packageName
     * @return
     */
    public AgentDbBean getAgengByPackageNameForProvider(String packageName) {
        AgentDbBean oldAgentDbBean = null;
        try {
            Uri uri = Uri.parse("content://" + SdkNativeConstant.APP_PACKAGENAME + ".appprovider/agent");
            Cursor cursor = mContext.getContentResolver().query(uri, null, null, new String[]{packageName}, null);
            if (cursor != null) {
                while (cursor.moveToNext()) {
                    oldAgentDbBean = new AgentDbBean();
                    oldAgentDbBean.setPackageName(cursor.getString(cursor.getColumnIndex(AgentDbBean.PACKAGE_NAME)));
                    oldAgentDbBean.setInstallCode(cursor.getString(cursor.getColumnIndex(AgentDbBean.INSTALL_CODE)));
                    if (oldAgentDbBean.getInstallCode() == null) {
                        oldAgentDbBean.setInstallCode("1_0");
                    }
                    oldAgentDbBean.setAgent(cursor.getString(cursor.getColumnIndex(AgentDbBean.AGENT)));
                }
                cursor.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return oldAgentDbBean;
    }

    public AgentDbBean getAgengDbBeanByPackageName(String packageName) {
        AgentDbBean oldAgentDbBean = null;
        try {
            SQLiteDatabase readableDatabase = dbHelper.getReadableDatabase();
            Cursor cursor = readableDatabase.rawQuery("select * from " + AGENT_TABLE_NAME + " where packageName=?", new String[]{packageName});

            while (cursor.moveToNext()) {
                oldAgentDbBean = new AgentDbBean();
                oldAgentDbBean.setPackageName(cursor.getString(cursor.getColumnIndex(AgentDbBean.PACKAGE_NAME)));
                oldAgentDbBean.setInstallCode(cursor.getString(cursor.getColumnIndex(AgentDbBean.INSTALL_CODE)));
                if (oldAgentDbBean.getInstallCode() == null) {
                    oldAgentDbBean.setInstallCode("1_0");
                }
                oldAgentDbBean.setAgent(cursor.getString(cursor.getColumnIndex(AgentDbBean.AGENT)));
            }
            cursor.close();
            readableDatabase.close();
        } catch (Exception e) {
            e.printStackTrace();
            //用于错误升级数据库后崩溃时删除外部数据库
            dbHelper.deleteOutDbFile();
        }
        return oldAgentDbBean;
    }

    public void deleteAgentDbBeanByPackageName(String packageName) {
        try {
            SQLiteDatabase writableDatabase = dbHelper.getWritableDatabase();
            int delete = writableDatabase.delete(AGENT_TABLE_NAME, "packageName=?", new String[]{packageName});
            writableDatabase.close();
            LogUtils.e("AgentDbDao", "删除" + packageName + " count=" + delete);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除所有的数据
     */
    public void deleteAgentDb() {
        try {
            SQLiteDatabase writableDatabase = dbHelper.getWritableDatabase();
            int delete = writableDatabase.delete(AGENT_TABLE_NAME, null, null);
            writableDatabase.close();
            LogUtils.d("AgentDbDao", "删除" + " count=" + delete);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取认证信息
     *
     * @return
     */
    public InstallDbBean getInstallDb() {
        try {
            SQLiteDatabase readableDatabase = dbHelper.getReadableDatabase();
            Cursor cursor = readableDatabase.rawQuery("select * from " + INSTALL_TABLE_NAME, new String[]{});
            InstallDbBean installDbBean = null;
            while (cursor.moveToNext()) {
                installDbBean = new InstallDbBean();
                installDbBean.setRsa_code(cursor.getString(cursor.getColumnIndex(InstallDbBean.RSA_CODE)));
                installDbBean.setUrl(cursor.getString(cursor.getColumnIndex(InstallDbBean.URL)));
            }
            cursor.close();
            readableDatabase.close();
            return installDbBean;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 更新或者添加认证信息
     *
     * @param rsa_code
     * @param url
     */
    public void updateOrAddInstallDb(String rsa_code, String url) {
        try {
            if (TextUtils.isEmpty(rsa_code) || TextUtils.isEmpty(url)) {
                return;
            }
            InstallDbBean installDb = getInstallDb();
            SQLiteDatabase writableDatabase = dbHelper.getWritableDatabase();
            if (installDb != null) {
                writableDatabase.delete(INSTALL_TABLE_NAME, null, new String[]{});
            }
            InstallDbBean installDbBean = new InstallDbBean(rsa_code, url);
            long insert = writableDatabase.insert(INSTALL_TABLE_NAME, null, installDbBean.toContentValues());
            LogUtils.e("AgentDbDao", "updateOrAddInstallDb insert：" + insert);
            writableDatabase.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除安装数据
     */
    public void deleteInstallDb() {
        try {
            SQLiteDatabase writableDatabase = dbHelper.getWritableDatabase();
            int delete = writableDatabase.delete(INSTALL_TABLE_NAME, null, null);
            writableDatabase.close();
            LogUtils.e("AgentDbDao", "deleteInstallDb删除" + " count=" + delete);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Cursor getAgengCursorByPackageName(String packageName) {
        Cursor cursor = null;
        try {
            SQLiteDatabase readableDatabase = dbHelper.getReadableDatabase();
            cursor = readableDatabase.rawQuery("select * from " + AGENT_TABLE_NAME + " where packageName=?", new String[]{packageName});
        } catch (Exception e) {
            e.printStackTrace();
            //用于错误升级数据库后崩溃时删除外部数据库
            dbHelper.deleteOutDbFile();
        }
        return cursor;
    }
}
