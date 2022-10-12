import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DealSellSelectGameAction { action }

class DealSellSelectGameActionCreator {
  static Action onAction() {
    return const Action(DealSellSelectGameAction.action);
  }
}
