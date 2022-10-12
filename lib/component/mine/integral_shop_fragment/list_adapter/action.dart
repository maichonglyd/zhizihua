import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum IntegralShopListAction { action }

class IntegralShopListActionCreator {
  static Action onAction() {
    return const Action(IntegralShopListAction.action);
  }
}
