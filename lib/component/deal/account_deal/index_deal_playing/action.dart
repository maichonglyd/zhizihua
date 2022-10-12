import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';

//TODO replace with your own action
enum DealPlayingAction { action, gotoAllPlayingPage, gotoDealShopList }

class DealPlayingActionCreator {
  static Action onAction() {
    return const Action(DealPlayingAction.action);
  }

  static Action gotoAllPlayingPage() {
    return const Action(DealPlayingAction.gotoAllPlayingPage);
  }

  static Action gotoDealShopList(PlayedGame playedGame) {
    return Action(DealPlayingAction.gotoDealShopList, payload: playedGame);
  }
}
