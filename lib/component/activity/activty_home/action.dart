import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ActivityHomeAction { action }

class ActivityHomeActionCreator {
  static Action onAction() {
    return const Action(ActivityHomeAction.action);
  }
}
