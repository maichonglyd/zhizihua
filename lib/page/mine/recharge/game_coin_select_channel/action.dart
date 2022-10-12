import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameCoinSelectChannelAction { action }

class GameCoinSelectChannelActionCreator {
  static Action onAction() {
    return const Action(GameCoinSelectChannelAction.action);
  }
}
