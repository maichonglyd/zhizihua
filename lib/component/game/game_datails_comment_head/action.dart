import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameCommentHeadAction { action, gotoCommitComment }

class GameCommentHeadActionCreator {
  static Action onAction() {
    return const Action(GameCommentHeadAction.action);
  }

  static Action gotoCommitComment() {
    return const Action(GameCommentHeadAction.gotoCommitComment);
  }
}
