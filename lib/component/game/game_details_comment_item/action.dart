import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameCommentItemAction { action, clickLike, }

class GameCommentItemActionCreator {
  static Action onAction() {
    return const Action(GameCommentItemAction.action);
  }

  static Action clickLike(num id, num type) {
    return Action(GameCommentItemAction.clickLike, payload: {'id': id, 'type': type});
  }
}
