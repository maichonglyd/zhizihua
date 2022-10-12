import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart' as user_info;

class AccountManageState implements Cloneable<AccountManageState> {
  user_info.Data userInfo;
  TextEditingController nicknameEditController = new TextEditingController();

  @override
  AccountManageState clone() {
    return AccountManageState()
      ..userInfo = userInfo
      ..nicknameEditController = nicknameEditController;
  }
}

AccountManageState initState(Map<String, dynamic> args) {
  return AccountManageState();
}
