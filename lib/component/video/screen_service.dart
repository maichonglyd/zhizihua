import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui show window;

import 'package:flutter_huoshu_app/common/auto_size/auto_size_config.dart';

class ScreenService {
  static double get width {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.width;
  }

  static double get height {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.height;
  }

  static double get scale {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.devicePixelRatio;
  }

  static double get textScaleFactor {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.textScaleFactor;
  }

  static double get navigationBarHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top + kToolbarHeight;
  }

  static double get topSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top;
  }

  static double get bottomSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.bottom;
  }

  static updateStatusBarStyle(SystemUiOverlayStyle style) {
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  // 获取手机屏幕的高宽比
  static double get windowAspectRatio {
    return height / width;
  }

  // 获取底部导航栏位置的Y轴值，屏幕的高 - 屏幕的底部安全区域的高 - 底部导航栏的高
  static double get bottomBarOffsetY {
    return (AutoSizeConfig.designWidth * windowAspectRatio) - bottomSafeHeight - 50;
  }

  // 获取浮点的宽度
  static double get floatPointWidth {
    return 65;
  }

  // 获取浮点的高度
  static double get floatPointHeight {
    return 65;
  }

  // 获取浮点可达到最大的X轴值，手机屏幕的宽 - 浮点的高
  static double get floatPointMaxX {
    return AutoSizeConfig.designWidth - floatPointWidth;
  }

  // 获取浮点可达到最大的Y轴值，底部导航栏位置的Y轴值 - 浮点的宽
  static double get floatPointMaxY {
    return bottomBarOffsetY - floatPointHeight;
  }

  // 获取浮点的初始位置
  static Offset get floatPointOffset {
    // 浮点的X轴值，浮点可达到最大的X轴值 - 右边距
    double floatPointX = floatPointMaxX - 9;
    // 浮点的Y轴值，浮点可达到最大的X轴值 - 底部边距
    double floatPointY = floatPointMaxY - 60;
    return Offset(floatPointX, floatPointY);
  }

  static double get halfHeight {
    return (AutoSizeConfig.designWidth * windowAspectRatio) / 2;
  }
}
