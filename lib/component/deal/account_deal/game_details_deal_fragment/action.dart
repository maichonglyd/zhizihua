import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';

//TODO replace with your own action
enum GameDetailsDealFragmentAction {
  action,
  getDealGoods,
  update,
}

class GameDetailsDealFragmentActionCreator {
  static Action onAction() {
    return const Action(GameDetailsDealFragmentAction.action);
  }

  static Action update(List<DealGoods> dealGoods) {
    return Action(GameDetailsDealFragmentAction.update, payload: dealGoods);
  }

  static Action getDealGoods(int page) {
    return Action(GameDetailsDealFragmentAction.getDealGoods, payload: page);
  }
}
