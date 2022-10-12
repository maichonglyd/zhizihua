import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_order_details.dart';

//TODO replace with your own action
enum PropDealOrderDetailsAction {
  action,
  getOrderDetails,
  updateOrderDetails,
  init,
}

class PropDealOrderDetailsActionCreator {
  static Action onAction() {
    return const Action(PropDealOrderDetailsAction.action);
  }

  static Action init() {
    return const Action(PropDealOrderDetailsAction.init);
  }

  static Action getOrderDetails() {
    return const Action(PropDealOrderDetailsAction.getOrderDetails);
  }

  static Action updateOrderDetails(
      DealPropOrderDetailsData dealPropOrderDetailsData) {
    return Action(PropDealOrderDetailsAction.updateOrderDetails,
        payload: dealPropOrderDetailsData);
  }
}
