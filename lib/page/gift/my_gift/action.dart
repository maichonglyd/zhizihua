import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';

//TODO replace with your own action
enum MyGiftAction { action, update, getGifts }

class MyGiftActionCreator {
  static Action onAction() {
    return const Action(MyGiftAction.action);
  }

  static Action update(List<Gift> gifts) {
    return Action(MyGiftAction.update, payload: gifts);
  }

  static Action getGifts(int page) {
    return Action(MyGiftAction.getGifts, payload: page);
  }
}
