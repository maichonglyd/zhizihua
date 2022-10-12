import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_comments.dart';

//TODO replace with your own action
enum GameCommentResponseAction {
  action,
  getData,
  updateData,
  clickLike,
  addComment,
}

class GameCommentResponseActionCreator {
  static Action onAction() {
    return const Action(GameCommentResponseAction.action);
  }

  static Action getData(int page) {
    return Action(GameCommentResponseAction.getData, payload: page);
  }

  static Action updateData(List<Comment> list) {
    return Action(GameCommentResponseAction.updateData, payload: list);
  }

  static Action clickLike() {
    return Action(GameCommentResponseAction.clickLike);
  }

  static Action addComment() {
    return Action(GameCommentResponseAction.addComment);
  }
}
