import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';

class MyWalletState implements Cloneable<MyWalletState> {
  double ptbCnt;
  @override
  MyWalletState clone() {
    return MyWalletState()..ptbCnt = ptbCnt;
  }
}

MyWalletState initState(Map<String, dynamic> args) {
  return MyWalletState()..ptbCnt = LoginControl.getUserInfo().data.ptbCnt;
}
