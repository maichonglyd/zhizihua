import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

class FindPasswordState implements Cloneable<FindPasswordState> {
  int step = 0; // 0-1-2  0 输入用户名/手机  1 获取验证码  2 输入密码
  String bindMobile;
  int countdownTime = 120;
  String verifyToken;

  TextEditingController userNameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController newPwController = TextEditingController();
  TextEditingController newPw2Controller = TextEditingController();

  @override
  FindPasswordState clone() {
    return FindPasswordState()
      ..step = step
      ..bindMobile = bindMobile
      ..verifyToken = verifyToken
      ..countdownTime = countdownTime
      ..userNameController = userNameController
      ..codeController = codeController
      ..newPwController = newPwController
      ..newPw2Controller = newPw2Controller;
  }
}

FindPasswordState initState(Map<String, dynamic> args) {
  return FindPasswordState()..step = 0;
}
