import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';

//TODO replace with your own action
enum GiftListFragmentAction {
  action,
  getData,
  updateData,
  gotoGiftDetails,
  addGift
}

class GiftListFragmentActionCreator {
  static Action onAction() {
    return const Action(GiftListFragmentAction.action);
  }

  static Action getData(int page) {
    return Action(GiftListFragmentAction.getData, payload: page);
  }

  static Action updateData(List<Gift> gifts) {
    return Action(GiftListFragmentAction.updateData, payload: gifts);
  }

  static Action gotoGiftDetails(Gift gift) {
    return Action(GiftListFragmentAction.gotoGiftDetails, payload: gift);
  }

  static Action addGift(Gift gift) {
    return Action(GiftListFragmentAction.addGift, payload: gift);
  }
}
