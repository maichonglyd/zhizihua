import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameCommitCommentAction { action, commitComment, changeNum }

class GameCommitCommentActionCreator {
  static Action onAction() {
    return const Action(GameCommitCommentAction.action);
  }

  static Action changeNum(int index) {
    return Action(GameCommitCommentAction.changeNum, payload: index);
  }

  static Action commitComment() {
    return const Action(GameCommitCommentAction.commitComment);
  }
}
