import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_order_list.dart';

//TODO replace with your own action
enum PropDealBuyRecordAction {
  action,
  getOrders,
  updateOrders,
  buy,
  gotoDetails,
}

class PropDealBuyRecordActionCreator {
  static Action onAction() {
    return const Action(PropDealBuyRecordAction.action);
  }

  static Action gotoDetails(String orderId) {
    return Action(PropDealBuyRecordAction.gotoDetails, payload: orderId);
  }

  static Action buy(Order order) {
    return Action(PropDealBuyRecordAction.buy, payload: order);
  }

  static Action updateOrders(List<Order> orders) {
    return Action(PropDealBuyRecordAction.updateOrders, payload: orders);
  }

  static Action getOrders(int page) {
    return Action(PropDealBuyRecordAction.getOrders, payload: page);
  }
}
