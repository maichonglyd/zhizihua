import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class UpdateMobileState implements Cloneable<UpdateMobileState> {
  String bindMobile;
  int countdownTime = 120;

  TextEditingController codeController = TextEditingController();

  @override
  UpdateMobileState clone() {
    return UpdateMobileState()
      ..bindMobile = bindMobile
      ..countdownTime = countdownTime
      ..codeController = codeController;
  }
}

UpdateMobileState initState(String mobile) {
  print("mobile:" + mobile);
  return UpdateMobileState()..bindMobile = mobile;
}
