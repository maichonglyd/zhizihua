import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/base/BaseState.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_order_details.dart';

class PropDealOrderDetailsState extends BaseState
    implements Cloneable<PropDealOrderDetailsState> {
  String orderId;
  DealPropOrderDetailsData dealPropOrderDetailsData;

  @override
  PropDealOrderDetailsState clone() {
    return PropDealOrderDetailsState()
      ..orderId = orderId
      ..dealPropOrderDetailsData = dealPropOrderDetailsData;
  }
}

PropDealOrderDetailsState initState(Map<String, dynamic> args) {
  return PropDealOrderDetailsState()..orderId = args["orderId"];
}
