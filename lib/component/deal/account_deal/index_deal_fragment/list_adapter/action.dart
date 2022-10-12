import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum IndexDealAction { action }

class IndexDealActionCreator {
  static Action onAction() {
    return const Action(IndexDealAction.action);
  }
}
