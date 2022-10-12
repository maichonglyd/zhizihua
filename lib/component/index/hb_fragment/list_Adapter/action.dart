import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HbListAdapterAction { action }

class HbListAdapterActionCreator {
  static Action onAction() {
    return const Action(HbListAdapterAction.action);
  }
}
