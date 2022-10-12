import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class BindMobileState implements Cloneable<BindMobileState> {
  String bindMobile;
  int countdownTime = 120;

  TextEditingController codeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  BindMobileState clone() {
    return BindMobileState()
      ..bindMobile = bindMobile
      ..countdownTime = countdownTime
      ..codeController = codeController
      ..mobileController = mobileController;
  }
}

BindMobileState initState(Map<String, dynamic> args) {
  return BindMobileState();
}
