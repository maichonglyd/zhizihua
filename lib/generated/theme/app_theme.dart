import 'dart:convert';
import 'package:flutter_huoshu_app/generated/theme/colors.dart';
import 'package:flutter_huoshu_app/generated/theme/images.dart';
import 'package:flutter_huoshu_app/generated/theme/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemes {
  static const String defaultTheme = "app";

  ///需要自动生成
  static const String orangeTheme = "orange";

  static Set<String> get allThemeName {
    Set set = Set();
    set.add(orangeTheme);
    set.add(defaultTheme);
    return set;
  }

}

class AppTheme {
  static AppColor colors = new AppColor();
  static AppImage images = new AppImage();
  static AppSize sizes = new AppSize();
  static final String _spPre = "AppTheme";
  static final String _spCurrentThemeName = "CurrentThemeName";
  static String themeName;

  ///加载上一次的保存的主题
  static Future init() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String themeName = sp.get(_spCurrentThemeName);
    changeTheme(themeName);
  }

  static Future<bool> addTheme(String name, String json) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(_spPre + name, json);
  }

  static Future<bool> supportTheme(String name) async {
    if (AppThemes.allThemeName.contains(name)) {
      return true;
    }
    AppThemes();
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.containsKey(name);
  }

  ///改变主题通过名字
  static Future<bool> changeTheme(String name) async {
    if (name == themeName) {
      return false;
    }
    SharedPreferences sp = await SharedPreferences.getInstance();
    AppColor newColors;
    switch (name) {
      case AppThemes.defaultTheme:
        newColors = AppColor();
        images = AppImage();
        break;
      case AppThemes.orangeTheme:
        newColors = OrangeColor();
        images = OrangeImage();
        break;
    }

    String colorJson = sp.get(_spPre + name);
    if (colorJson != null) {
      try {
//        newColors = AppColor.fromJson(json.decode(colorJson));
      } catch (e) {
        print('theme color json parse fail: $e');
      }
    }
    if (newColors != null) {
      colors = newColors;
      sp.setString(_spCurrentThemeName, themeName);
      return true;
    }
    return false;
  }
}

class RedTheme extends AppTheme {
  static AppColor colors = new OrangeColor();
  static AppImage images = new AppImage();
  static AppSize sizes = new AppSize();
  static String themeName = "red";
}


class OrangeTheme extends RedTheme {
  static AppColor colors = new OrangeColor();
  static AppImage images = new AppImage();
  static AppSize sizes = new AppSize();
  static String themeName = "orange";
}
