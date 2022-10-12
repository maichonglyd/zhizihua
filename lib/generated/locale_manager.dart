import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/common/util/sp_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:intl/intl.dart';

class LocaleManager {
  static Locale nowLanguage = Locale.fromSubtags(languageCode: 'en');
  static bool isSupport = true;
  static Map<String, dynamic> languageMap;

  /// 保存用户选择的语言代码，格式zh-cn
  static void saveLocale(String locale) {
    SpUtil.prefs.setString(SpUtil.SAVE_LOCAL, locale);
  }

  /// 获取用户选择的语言代码
  static String getSaveLocale() {
    try {
      return SpUtil.prefs.getString(SpUtil.SAVE_LOCAL);
    } catch (e) {
      return '';
    }
  }

  /// 获取用户选择的语言
  static Locale getLocaleType() {
    String saveLocale = getSaveLocale();
    if (null == saveLocale || saveLocale.isEmpty) {
      return null;
    } else {
      if (saveLocale.contains("-")) {
        List<String> strList = saveLocale.split("-");
        return Locale(strList[0], strList[1].toUpperCase());
      } else {
        return Locale(saveLocale);
      }
    }
  }

  /// 从服务端获取语言包，并返回获取结果
  /// 若能从服务端获取语言包，则保存到Map，方便后续读取
  static Future<bool> requestLanguageJson(String url) async {
    BaseOptions options = new BaseOptions(
        baseUrl: url,
        connectTimeout: 30000,
        receiveTimeout: 30000,
        contentType: "application/x-www-form-urlencoded",
        headers: RequestUtil.getCommonHeader());

    Dio dio = new Dio(options)
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    Response<String> response = await dio.get("");
    if (200 == response.statusCode) {
      languageMap = json.decode(response.data);
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  /// 保存当前APP获取到的语言，并检查是否本地已经支持了该语言
  static bool saveNowLanguage(Locale locale) {
    nowLanguage = locale;
    if (locale != null) {
      for (var supportedLocale in S.delegate.supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return isSupport = true;
        }
      }
    }
    return isSupport = false;
  }

  /// 获取当前APP的语言代码
  /// 用户设置了语言，则返回用户选择的语言代码
  /// 否则返回跟随系统的语言代码
  static String getNowLocaleString() {
    String saveLocale = getSaveLocale();
    if (null == saveLocale || saveLocale.isEmpty) {
      String str = nowLanguage.languageCode;
      if (null != nowLanguage.countryCode && nowLanguage.countryCode.isNotEmpty) {
        str += '-${nowLanguage.countryCode.toLowerCase()}';
      }
      return str;
    } else {
      return saveLocale;
    }
  }
}

/// 该方法用于获取文本，首先判断本地是否支持用户选择的语言，若支持则读取本地的语言包
/// 若不支持，则看服务器是否有该语言的语言包，有的话则读取服务器的语言包。
/// 默认读取本地的语言包，默认语言包是英文
String getText({
  @required String name,
  List<Object> args,
}) {
  if (!LocaleManager.isSupport) {
    if (null != LocaleManager.languageMap &&
        LocaleManager.languageMap.containsKey(name)) {
      String text = LocaleManager.languageMap[name];
      if (null != args && args.length > 0) {
        for (int i = 0; i < args.length; i++) {
          text = text.replaceFirst('{param${i + 1}}', args[i].toString());
        }
      }
      if (null != text && text.isNotEmpty) return text;
    }
  }

  return Intl.message(
    'null',
    name: name,
    args: args,
  );
}
