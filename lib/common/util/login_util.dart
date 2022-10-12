import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/sp_util.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/ptz_recharge/page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginControl {
  static final String KEY_IS_LOGIN = "KEY_IS_LOGIN";
  //是否是注册类型,首页优惠券弹窗用到
  static final String KEY_IS_REGISTER = "KEY_IS_REGISTER";
  static final String KEY_TOKEN = "KEY_TOKEN";
  static final String KEY_USER_INFO = "KEY_USER_INFO";
  static final String KEY_USER_PW = "KEY_USER_PW";
  static final String KEY_USER_NAME = "KEY_USER_NAME";
  static final String KEY_FIRST_ENTER = "KEY_FIRST_ENTER";
  static final String KEY_INDEX = "KEY_INDEX";
  static final String KEY_TAB_TYPE = "KEY_TAB_TYPE";



  static bool isLogin() {
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.getBool(KEY_IS_LOGIN) == null
          ? false
          : SpUtil.prefs.getBool(KEY_IS_LOGIN);
    } else {
      return false;
    }
  }

  static Future saveTabType(String type) async {
    SpUtil.prefs.setString(KEY_TAB_TYPE, type);
  }

  static String getTabType(){
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.getString(KEY_TAB_TYPE) == null
          ? 0
          : SpUtil.prefs.getString(KEY_TAB_TYPE);
    } else {
      return "";
    }
  }


  static Future saveIndex(int index) async {
    SpUtil.prefs.setInt(KEY_INDEX, index);
  }

  static int getIndex(){
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.getInt(KEY_INDEX) == null
          ? 0
          : SpUtil.prefs.getInt(KEY_INDEX);
    } else {
      return 0;
    }
  }

  static Future saveRegister(bool isRegister) async {
    SpUtil.prefs.setBool(KEY_IS_REGISTER, isRegister);
  }

  static bool isRegister() {
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.getBool(KEY_IS_REGISTER) == null
          ? false
          : SpUtil.prefs.getBool(KEY_IS_REGISTER);
    } else {
      return false;
    }
  }

  static Future saveLogin(bool isLogin) async {
    SpUtil.prefs.setBool(KEY_IS_LOGIN, isLogin);
    if (!isLogin) {
      LoginControl.saveUserInfo("");
    }
  }

  static Future saveIsFirstEnter(bool isLogin) async {
    SpUtil.prefs.setBool(KEY_FIRST_ENTER, isLogin);
  }

  static bool IsFirstEnter() {
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.getBool(KEY_FIRST_ENTER) == null
          ? false
          : SpUtil.prefs.getBool(KEY_FIRST_ENTER);
    } else {
      return false;
    }
  }



  static Future saveToken(String token) async {
    SpUtil.prefs.setString(KEY_TOKEN, token);
  }

  static Future saveLoginPW(String password) async {
    SpUtil.prefs.setString(KEY_USER_PW, password);
  }

  static Future saveLoginUserName(String userName) async {
    SpUtil.prefs.setString(KEY_USER_NAME, userName);
  }


  static String getUserName(){
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.getString(KEY_USER_NAME) == null
          ? ""
          : SpUtil.prefs.getString(KEY_USER_NAME);
    } else {
      return "";
    }
  }

  static String getPW(){
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.getString(KEY_USER_PW) == null
          ? ""
          : SpUtil.prefs.getString(KEY_USER_PW);
    } else {
      return "";
    }
  }

  static String getToken() {
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.getString(KEY_TOKEN) == null
          ? ""
          : SpUtil.prefs.getString(KEY_TOKEN);
    } else {
      return "";
    }
  }

  static void saveUserInfo(String userInfo) {
    SpUtil.prefs.setString(KEY_USER_INFO, userInfo);
  }

  static UserInfo getUserInfo() {
    String userInfoJson = SpUtil.prefs.getString(KEY_USER_INFO);
    if (userInfoJson==null||userInfoJson.isEmpty) {
      return null;
    }
    return UserInfo.fromJson(json.decode(userInfoJson));
  }
}
