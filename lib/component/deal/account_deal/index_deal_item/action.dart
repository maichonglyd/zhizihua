import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum IndexDealItemAction { action, gotoDealDetails }

class IndexDealItemActionCreator {
  static Action onAction() {
    return const Action(IndexDealItemAction.action);
  }

  static Action gotoDealDetails() {
    return const Action(IndexDealItemAction.gotoDealDetails);
  }
}
