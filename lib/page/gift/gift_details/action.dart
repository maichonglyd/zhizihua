import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';

//TODO replace with your own action
enum GiftDetailsAction { action, addGift, getGift, updateData }

class GiftDetailsActionCreator {
  static Action onAction() {
    return const Action(GiftDetailsAction.action);
  }

  static Action addGift() {
    return const Action(GiftDetailsAction.addGift);
  }

  static Action getGift() {
    return const Action(GiftDetailsAction.getGift);
  }

  static Action updateData(Gift gift) {
    return Action(GiftDetailsAction.updateData, payload: gift);
  }
}
