import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class UpdatePasswordState implements Cloneable<UpdatePasswordState> {
  var oldPwdController = new TextEditingController();
  var newPwd1Controller = new TextEditingController();
  var newPwd2Controller = new TextEditingController();

  @override
  UpdatePasswordState clone() {
    return UpdatePasswordState();
  }
}

UpdatePasswordState initState(Map<String, dynamic> args) {
  return UpdatePasswordState();
}
