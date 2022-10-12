import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/gift/gift_list/state.dart';
import 'package:flutter_huoshu_app/component/gift/gift_list/state.dart'
    as gift_list;

class GameGiftState implements Cloneable<GameGiftState> {
  int gameId = 0;
  String gameName = '';
  GiftListFragmentState giftListFragmentState;

  @override
  GameGiftState clone() {
    return GameGiftState()
      ..gameId = gameId
      ..gameName = gameName
      ..giftListFragmentState = giftListFragmentState;
  }
}

GameGiftState initState(Map<String, dynamic> args) {
  return GameGiftState()
    ..gameId = args['gameId']
    ..gameName = args['gameName']
    ..giftListFragmentState = gift_list.initState({'gameId': args['gameId']});
}

class GiftListConnector extends ConnOp<GameGiftState, GiftListFragmentState> {
  @override
  void set(GameGiftState state, GiftListFragmentState subState) {
//    super.set(state, subState);
    state.giftListFragmentState = subState;
  }

  @override
  GiftListFragmentState get(GameGiftState state) {
    return state.giftListFragmentState;
  }
}
