import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;

class RegisterPageState implements Cloneable<RegisterPageState> {
  bool isPhone = true; //手机号注册/账号注册
  int countdownTime = 120;

  var mobileController = new TextEditingController();
  var userNameController = new TextEditingController();
  var authcodeController = new TextEditingController();
  var passwordController = new TextEditingController();

  @override
  RegisterPageState clone() {
    return RegisterPageState()
      ..isPhone = isPhone
      ..mobileController = mobileController
      ..userNameController = userNameController
      ..authcodeController = authcodeController
      ..passwordController = passwordController;
  }
}

RegisterPageState initState(Map<String, dynamic> args) {
  return RegisterPageState()..isPhone = true;
}
