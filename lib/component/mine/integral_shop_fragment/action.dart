import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/goods_list_data.dart';

//TODO replace with your own action
enum IntegralShopFragmentAction {
  action,
  updateGoods,
  getIntegralGoods,
}

class IntegralShopFragmentActionCreator {
  static Action onAction() {
    return const Action(IntegralShopFragmentAction.action);
  }

  static Action getIntegralGoods(int page) {
    return Action(IntegralShopFragmentAction.getIntegralGoods, payload: page);
  }

  static Action updateGoods(List<Goods> goodsList) {
    return Action(IntegralShopFragmentAction.updateGoods, payload: goodsList);
  }
}
