import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';

//TODO replace with your own action
enum DealShopListPageAction { action, update, onGetData }

class DealShopListPageActionCreator {
  static Action onAction() {
    return const Action(DealShopListPageAction.action);
  }

  static Action update(List<DealGoods> dealGoodsList) {
    return Action(DealShopListPageAction.update, payload: dealGoodsList);
  }

  static Action onGetData(int page) {
    return Action(DealShopListPageAction.onGetData, payload: page);
  }
}
