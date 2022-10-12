import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';

//TODO replace with your own action
enum GameDetailsGiftFragmentAction { action, getGift, updateGifts }

class GameDetailsGiftFragmentActionCreator {
  static Action onAction() {
    return const Action(GameDetailsGiftFragmentAction.action);
  }

  static Action getGift(int page) {
    return Action(GameDetailsGiftFragmentAction.getGift, payload: page);
  }

  static Action updateGifts(List<Gift> gifts) {
    return Action(GameDetailsGiftFragmentAction.updateGifts, payload: gifts);
  }
}
