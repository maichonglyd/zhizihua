import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/goods_list_data.dart';

//TODO replace with your own action
enum IntegralShopItemAction { action, exchangeGoods, gotoShopDetails }

class IntegralShopItemActionCreator {
  static Action onAction() {
    return const Action(IntegralShopItemAction.action);
  }

  static Action exchangeGoods() {
    return const Action(IntegralShopItemAction.exchangeGoods);
  }

  static Action gotoShopDetails() {
    return Action(IntegralShopItemAction.gotoShopDetails);
  }
}
