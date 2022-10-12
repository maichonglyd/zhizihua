import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/user/recycle_pro_order.dart';

class AccountRecyclePaybackState
    implements Cloneable<AccountRecyclePaybackState> {
  int payIndex = 0;
  RecycleProOrder recycleProOrder;
  DealPayInfoData dealPayInfoData;

  @override
  AccountRecyclePaybackState clone() {
    return AccountRecyclePaybackState()
      ..payIndex = payIndex
      ..dealPayInfoData = dealPayInfoData
      ..recycleProOrder = recycleProOrder;
  }
}

AccountRecyclePaybackState initState(RecycleProOrder recycleProOrder) {
  return AccountRecyclePaybackState()..recycleProOrder = recycleProOrder;
}
