import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameHotThisWeekendAction { action }

class GameHotThisWeekendActionCreator {
  static Action onAction() {
    return const Action(GameHotThisWeekendAction.action);
  }
}
