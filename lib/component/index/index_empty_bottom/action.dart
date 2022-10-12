import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum IndexEmptyBottomAction { action }

class IndexEmptyBottomActionCreator {
  static Action onAction() {
    return const Action(IndexEmptyBottomAction.action);
  }
}
