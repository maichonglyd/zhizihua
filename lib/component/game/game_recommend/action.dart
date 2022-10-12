import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameRecommendAction { action }

class GameRecommendActionCreator {
  static Action onAction() {
    return const Action(GameRecommendAction.action);
  }
}
