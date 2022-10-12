import 'package:fish_redux/fish_redux.dart';

import 'package:flutter_huoshu_app/model/user/goods_details_data.dart'
    as goods_details_data;

//TODO replace with your own action
enum IntegralShopDetailsAction {
  action,
  update,
  exchangeGoods,
  init,
  err,
}

class IntegralShopDetailsActionCreator {
  static Action onAction() {
    return const Action(IntegralShopDetailsAction.action);
  }

  static Action update(goods_details_data.Data data) {
    return Action(IntegralShopDetailsAction.update, payload: data);
  }

  static Action exchangeGoods() {
    return Action(IntegralShopDetailsAction.exchangeGoods);
  }

  static Action init() {
    return Action(IntegralShopDetailsAction.init);
  }

  static Action err() {
    return Action(IntegralShopDetailsAction.err);
  }
}
