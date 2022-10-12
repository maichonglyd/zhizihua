import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DealItemTitleAction { action, selectType, updateType }

class DealItemTitleActionCreator {
  static Action onAction() {
    return const Action(DealItemTitleAction.action);
  }

  static Action updateType(int index) {
    return Action(DealItemTitleAction.updateType, payload: index);
  }

  static Action selectType() {
    return const Action(DealItemTitleAction.selectType);
  }
}
