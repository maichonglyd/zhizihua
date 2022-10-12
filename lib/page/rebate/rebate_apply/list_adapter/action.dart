import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum RebateGameListAction { action }

class RebateGameListActionCreator {
  static Action onAction() {
    return const Action(RebateGameListAction.action);
  }
}
