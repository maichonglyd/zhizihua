import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';

//TODO replace with your own action
enum DealSellListAction { action, update, onLoadData }

class DealSellListActionCreator {
  static Action onAction() {
    return const Action(DealSellListAction.action);
  }

  static Action update(List<DealGoods> dealGoodsList, int type) {
    return Action(DealSellListAction.update,
        payload: {"list": dealGoodsList, "type": type});
  }

  static Action onLoadData(int page) {
    return Action(DealSellListAction.onLoadData, payload: page);
  }
}
