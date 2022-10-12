import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/index/index_fragment/state.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/generated/theme/colors.dart';
import 'package:flutter_huoshu_app/global_store/state.dart';
import 'package:flutter_huoshu_app/model/home_tab_vo.dart';
import 'package:flutter_plugin_user_agent_auth/flutter_plugin_user_agent_auth.dart';

class LoginState with GlobalBaseState<LoginState> {
  var mobileController = new TextEditingController();
  var passwordController = new TextEditingController();
  AppColors loginColor;

  @override
  LoginState clone() {
    return LoginState()
      ..copyGlobalFrom(this)
      ..mobileController = mobileController
      ..loginColor = loginColor
      ..passwordController = passwordController;
  }
}

LoginState initState(Map<String, dynamic> args) {
  //just demo, do nothing here...
  return LoginState()
    ..loginColor = AppColors.themeColor
    ..mobileController.text = LoginControl.getUserName()
    ..passwordController.text = LoginControl.getPW();
}
