import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum NewActivityAction { action }

class NewActivityActionCreator {
  static Action onAction() {
    return const Action(NewActivityAction.action);
  }
}
