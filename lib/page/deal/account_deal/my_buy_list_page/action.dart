import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_my_order_list_data.dart';

//TODO replace with your own action
enum MyBuyListAction { action, update, onGetData, onGotoDealDetails, pay }

class MyBuyListActionCreator {
  static Action onAction() {
    return const Action(MyBuyListAction.action);
  }

  static Action pay(int index) {
    return Action(MyBuyListAction.pay, payload: index);
  }

  static Action update(List<Order> orders) {
    return Action(MyBuyListAction.update, payload: orders);
  }

  static Action onGetData(int page) {
    return Action(MyBuyListAction.onGetData, payload: page);
  }

  static Action onGotoDealDetails(int goodsId) {
    return Action(MyBuyListAction.onGotoDealDetails, payload: goodsId);
  }
}
