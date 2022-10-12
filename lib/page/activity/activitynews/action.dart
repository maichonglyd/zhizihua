import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ActivityNewsAction { action }

class ActivityNewsActionCreator {
  static Action onAction() {
    return const Action(ActivityNewsAction.action);
  }
}
