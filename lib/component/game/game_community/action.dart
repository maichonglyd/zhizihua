import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_comments.dart';

//TODO replace with your own action
enum GameCommunityAction {
  action,
  getComment,
  updateComment,
  clickLike,
}

class GameCommunityActionCreator {
  static Action onAction() {
    return const Action(GameCommunityAction.action);
  }

  static Action getComment() {
    return const Action(GameCommunityAction.getComment);
  }

  static Action updateComment(List<Comment> list) {
    return Action(GameCommunityAction.updateComment, payload: list);
  }

  static Action clickLike(num id, num type) {
    return Action(GameCommunityAction.clickLike,
        payload: {'id': id, 'type': type});
  }
}
