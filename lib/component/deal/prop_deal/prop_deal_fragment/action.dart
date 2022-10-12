import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';

//TODO replace with your own action
enum PropDealFragmentAction {
  action,
  onGotoSellEdit,
  getIndexData,
  updateIndexData,
  getGoods,
  updateGoods,
}

class PropDealFragmentActionCreator {
  static Action onAction() {
    return const Action(PropDealFragmentAction.action);
  }

  static Action onGotoSellEdit() {
    return const Action(PropDealFragmentAction.onGotoSellEdit);
  }

  static Action getIndexData() {
    return const Action(PropDealFragmentAction.getIndexData);
  }

  static Action updateIndexData(DealPropIndexData dealPropIndexData) {
    return Action(PropDealFragmentAction.updateIndexData,
        payload: dealPropIndexData);
  }

  static Action getGoods(int page) {
    return Action(PropDealFragmentAction.getGoods, payload: page);
  }

  static Action updateGoods(List<Goods> goodsList) {
    return Action(PropDealFragmentAction.updateGoods, payload: goodsList);
  }
}
