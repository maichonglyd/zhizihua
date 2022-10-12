import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

///根据需求封装土司,弹出的位置,大小,透明度
///@author ailibin
class ToastUtil {
  static void showSelfToast(
    String msg, {
    ToastPosition position = ToastPosition.bottom,
    double padding = 10,
    Color backgroundColor,
  }) {
    showToast(msg,
        position: position,
        textPadding: EdgeInsets.all(padding),
        backgroundColor:
            backgroundColor == null ? Color(0xb2000000) : backgroundColor);
  }
}

// enum ToastPosition { bottom, center, top }
