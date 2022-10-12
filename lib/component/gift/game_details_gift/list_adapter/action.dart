import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GiftListAction { action }

class GiftListActionCreator {
  static Action onAction() {
    return const Action(GiftListAction.action);
  }
}
