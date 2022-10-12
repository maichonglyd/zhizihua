import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum IndexPlayedItemAction { action }

class IndexPlayedItemActionCreator {
  static Action onAction() {
    return const Action(IndexPlayedItemAction.action);
  }
}
