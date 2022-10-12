import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DealSellListAction { action }

class DealSellListActionCreator {
  static Action onAction() {
    return const Action(DealSellListAction.action);
  }
}
