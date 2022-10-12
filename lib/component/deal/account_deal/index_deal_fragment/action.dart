import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';

//TODO replace with your own action
enum IndexDealFragmentAction {
  action,
  onGotoSellEdit,
  getDealGoods,
  getDealIndex,
  updateDealGoods,
  updateDealIndex,
  onCancel,
  onCancelOK,
}

class IndexDealFragmentActionCreator {
  static Action onAction() {
    return const Action(IndexDealFragmentAction.action);
  }

  static Action getDealGoods(int page) {
    return Action(IndexDealFragmentAction.getDealGoods, payload: page);
  }

  static Action getDealIndex() {
    return const Action(IndexDealFragmentAction.getDealIndex);
  }

  static Action updateDealGoods(List<DealGoods> dealGoods) {
    return Action(IndexDealFragmentAction.updateDealGoods, payload: dealGoods);
  }

  static Action updateDealIndex(DealIndexData dealIndexData) {
    return Action(IndexDealFragmentAction.updateDealIndex,
        payload: dealIndexData);
  }

  static Action onGotoSellEdit(int goodsId, int status) {
    return Action(IndexDealFragmentAction.onGotoSellEdit,
        payload: {"goodsId": goodsId, "status": status});
  }

  static Action onCancel(int goodsId, int status) {
    return Action(IndexDealFragmentAction.onCancel,
        payload: {"goodsId": goodsId, "status": status});
  }

  static Action onCancelOK(int goodsId) {
    return Action(IndexDealFragmentAction.onCancelOK, payload: goodsId);
  }
}
