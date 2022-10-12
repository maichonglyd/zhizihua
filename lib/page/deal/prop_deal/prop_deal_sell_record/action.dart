import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';

//TODO replace with your own action
enum PropDealSellRecordAction {
  action,
  getSellRecord,
  updateSellRecord,
  gotoEdit,
  cancelGoods
}

class PropDealSellRecordActionCreator {
  static Action onAction() {
    return const Action(PropDealSellRecordAction.action);
  }

  static Action cancelGoods(int goodsId) {
    return Action(PropDealSellRecordAction.cancelGoods, payload: goodsId);
  }

  static Action gotoEdit(int goodsId) {
    return Action(PropDealSellRecordAction.gotoEdit, payload: goodsId);
  }

  static Action getSellRecord(int page) {
    return Action(PropDealSellRecordAction.getSellRecord, payload: page);
  }

  static Action updateSellRecord(List<Goods> goodsList) {
    return Action(PropDealSellRecordAction.updateSellRecord,
        payload: goodsList);
  }
}
