import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';

class IndexDealHeadState implements Cloneable<IndexDealHeadState> {
  int stackIndex = 0;
  DealIndexData dealIndexData;

  @override
  IndexDealHeadState clone() {
    print("IndexDealHeadState:clone()");
    return IndexDealHeadState()
      ..stackIndex = LoginControl.isLogin() && dealIndexData != null ? 1 : 0
      ..dealIndexData = dealIndexData;
  }
}

IndexDealHeadState initState(DealIndexData dealIndexData) {
  return IndexDealHeadState()
    ..stackIndex = LoginControl.isLogin() && dealIndexData != null ? 1 : 0
    ..dealIndexData = dealIndexData;
}
