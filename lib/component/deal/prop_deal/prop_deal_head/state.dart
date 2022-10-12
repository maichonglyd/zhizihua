import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';

class PropDealHeadState implements Cloneable<PropDealHeadState> {
  int stackIndex = 0;
  DealPropIndexData dealIndexData;

  @override
  PropDealHeadState clone() {
    print("IndexDealHeadState:clone()");
    return PropDealHeadState()
      ..stackIndex = LoginControl.isLogin() && dealIndexData != null ? 1 : 0
      ..dealIndexData = dealIndexData;
  }
}

PropDealHeadState initState(DealPropIndexData dealIndexData) {
  return PropDealHeadState()
    ..stackIndex = LoginControl.isLogin() && dealIndexData != null ? 1 : 0
    ..dealIndexData = dealIndexData;
}
