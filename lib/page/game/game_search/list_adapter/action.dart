import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ListAdapterAction { action }

class ListAdapterActionCreator {
  static Action onAction() {
    return const Action(ListAdapterAction.action);
  }
}
