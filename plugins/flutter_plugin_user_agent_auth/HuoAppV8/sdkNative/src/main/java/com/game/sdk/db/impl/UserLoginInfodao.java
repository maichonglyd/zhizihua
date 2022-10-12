package com.game.sdk.db.impl;

import android.content.Context;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.text.TextUtils;

import com.game.sdk.db.DBHelper;
import com.game.sdk.domain.UserInfo;
import com.game.sdk.util.Des3;

import java.util.ArrayList;
import java.util.List;


public class UserLoginInfodao {

    public static final String TABLENAME = "userlogin";
    public static final String USERNAME = "username";
    public static final String PASSWORD = "password";
    // public static final String ISREPWD="isrepwd";//0已经修改过密码，1表示没有修改过密码
    private static final String TAG = "UserLoginInfodao";
    private static final String LOGIN_FLAG = "loginFlag";
    private String key = "huoshu";

    private DBHelper dbHelper = null;
    private static UserLoginInfodao userlogininfodao;

    private UserLoginInfodao(Context context) {
        //使用application防止内存泄漏
        dbHelper = new DBHelper(context.getApplicationContext(), null, DBHelper.DB_VERSION);
    }

    public static UserLoginInfodao getInstance(Context context) {
        if (null == userlogininfodao) {
            userlogininfodao = new UserLoginInfodao(context);
        }
        return userlogininfodao;
    }

    public static int getBindFlag(Context context, String user) {
        SharedPreferences sf = context.getSharedPreferences(user,
                Context.MODE_PRIVATE);
        return sf.getInt(LOGIN_FLAG, 0);
    }

    public static void saveBindFlag(Context context, String user, int flag) {
        SharedPreferences sf = context.getSharedPreferences(user,
                Context.MODE_PRIVATE);
        sf.edit().putInt(LOGIN_FLAG, flag).commit();
    }


    /**
     * @return
     */
    public List<UserInfo> getUserLoginInfo() {
        List<UserInfo> userLogininfos = new ArrayList<>();
        try {
            SQLiteDatabase r_db = dbHelper.getReadableDatabase();
            if (r_db.isOpen()) {
                Cursor cursor = r_db.rawQuery("select * from " + TABLENAME, null);
                userLogininfos = new ArrayList<UserInfo>();
                UserInfo ulinfo = null;

                String username;
                String pwd;
                try {
                    if (cursor.moveToLast()) {
                        ulinfo = new UserInfo();
                        username = cursor
                                .getString(cursor.getColumnIndex(USERNAME));
                        pwd = cursor.getString(cursor.getColumnIndex(PASSWORD));

                        ulinfo.username = username;
                        ulinfo.password = pwd;
                        ulinfo.password = ulinfo.password.substring(1,
                                ulinfo.password.length());// "0000123 变成123问题"
                        ulinfo.username = Des3.decode(ulinfo.username);
                        ulinfo.password = Des3.decode(ulinfo.password);
                        userLogininfos.add(ulinfo);
                    }
                } catch (Exception e) {

                }

                while (cursor.moveToPrevious()) {
                    ulinfo = new UserInfo();
                    username = cursor.getString(cursor.getColumnIndex(USERNAME));
                    pwd = cursor.getString(cursor.getColumnIndex(PASSWORD));
                    // isrepwd=cursor.getInt(cursor.getColumnIndex(ISREPWD));
                    ulinfo.username = username;
                    ulinfo.password = pwd;
                    ulinfo.password = ulinfo.password.substring(1,
                            ulinfo.password.length());// "0000123 变成123问题"
                    // ulinfo.isrpwd=isrepwd;
                    ulinfo.username = Des3.decode(ulinfo.username);
                    ulinfo.password = Des3.decode(ulinfo.password);
                    userLogininfos.add(ulinfo);
                }
                cursor.close();
            }
            r_db.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userLogininfos;
    }

    /**
     * @param username
     * @param pwd
     */
    public void saveUserLoginInfo(String username, String pwd) {
        if (TextUtils.isEmpty(username)) {
            return;
        }
        try {
            deleteUserLoginByName(username);
            username = username.trim();
            username = Des3.encode(username);
            pwd = Des3.encode(pwd);
            SQLiteDatabase w_db = dbHelper.getWritableDatabase();
            if (w_db.isOpen()) {
                w_db.execSQL("insert into " + TABLENAME + "(" + USERNAME + ","
                        + PASSWORD + ") values(?,?)", new Object[]{username,
                        "@" + pwd});
            }
            w_db.close();
            w_db = null;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * @param username
     * @return true
     */
    public boolean findUserLoginInfoByName(String username) {
        try {
            username = Des3.encode(username);
            boolean flag = false;
            ;
            SQLiteDatabase r_db = dbHelper.getReadableDatabase();
            if (r_db.isOpen()) {
                Cursor cursor = r_db.rawQuery("select * from " + TABLENAME
                        + " where " + USERNAME + "=?", new String[]{username});
                if (cursor.moveToNext()) {
                    flag = true;
                }
                cursor.close();
                cursor = null;
            }
            r_db.close();
            r_db = null;
            return flag;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * @param username
     */
    public void deleteUserLoginByName(String username) {
        try {
            username = Des3.encode(username);
            SQLiteDatabase w_db = dbHelper.getWritableDatabase();
            if (w_db.isOpen()) {
                w_db.execSQL("delete from " + TABLENAME + " where " + USERNAME
                        + "=?", new String[]{username});
            }
            w_db.close();
            w_db = null;
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 根据用户用去更新密码
     *
     * @param username
     * @param pwd
     */
    /*
     * public void updateUserLoginByName(String username,String pwd,int
     * isrepwd){ SQLiteDatabase w_db=dbHelper.getWritableDatabase();
     * if(w_db.isOpen()){
     * w_db.execSQL("update "+TABLENAME+" set "+ISREPWD+"=?,"+
     * PASSWORD+"=? where "+USERNAME+"=?",new Object[]{isrepwd,pwd,username});
     * Logger.msg(
     * "update "+TABLENAME+" set "+ISREPWD+"=? ,"+PASSWORD+"=? where "
     * +USERNAME+"=?"); } w_db.close(); w_db=null; }
     */

    /**
     * 根据用户名获取密码
     *
     * @param username
     * @return
     */
    public String getPwdByUsername(String username) {
        try {
            username = Des3.encode(username);
            SQLiteDatabase r_db = dbHelper.getReadableDatabase();
            String pwd = "";
            if (r_db.isOpen()) {
                Cursor cursor = r_db.rawQuery("select * from " + TABLENAME
                        + " where " + USERNAME + " =?", new String[]{username});
                if (cursor.moveToNext()) {
                    pwd = cursor.getString(cursor.getColumnIndex(PASSWORD));
                    pwd = pwd.substring(1, pwd.length());// "0000123 变成123问题"
                }
                cursor.close();
                cursor = null;
            }
            r_db.close();
            r_db = null;
            return Des3.decode(pwd);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    /**
     * 获取上次登录成功的用户信息
     *
     * @return
     */
    public UserInfo getUserInfoLast() {
        UserInfo ulinfo = new UserInfo();
        try {
            SQLiteDatabase r_db = dbHelper.getReadableDatabase();
            if (r_db.isOpen()) {
                Cursor cursor = r_db.rawQuery("select * from  " + TABLENAME, null);
                if (cursor.moveToLast()) {
                    String username = cursor.getString(cursor
                            .getColumnIndex(USERNAME));
                    String pwd = cursor.getString(cursor.getColumnIndex(PASSWORD));
                    // int isrepwd=cursor.getInt(cursor.getColumnIndex(ISREPWD));


                    ulinfo.username = username;
                    ulinfo.password = pwd;
                    ulinfo.password = ulinfo.password.substring(1,
                            ulinfo.password.length());// "0000123 变成123问题"
                    // ulinfo.isrpwd=isrepwd;
                    ulinfo.username = Des3.decode(ulinfo.username);
                    ulinfo.password = Des3.decode(ulinfo.password);
                }
                cursor.close();
                cursor = null;
            }
            r_db.close();
            r_db = null;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ulinfo;
    }

    /**
     * 获取用户信息
     *
     * @param selection
     * @param selectionArgs
     * @return
     */
    public Cursor getAccountInfo(String projection[], String selection, String[] selectionArgs, String sortOrder) {
        Cursor cursor = null;
        try {
            SQLiteDatabase r_db = dbHelper.getReadableDatabase();
            if (r_db.isOpen()) {
                cursor = r_db.query(TABLENAME, projection, selection, selectionArgs, null, null, sortOrder, "1");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cursor;
    }
}
