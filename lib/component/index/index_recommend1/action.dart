import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum IndexRecommendAction { action, gotoGameDetails }

class IndexRecommendActionCreator {
  static Action onAction() {
    return const Action(IndexRecommendAction.action);
  }

  static Action gotoGameDetails(int gameId) {
    return Action(IndexRecommendAction.gotoGameDetails, payload: gameId);
  }
}
