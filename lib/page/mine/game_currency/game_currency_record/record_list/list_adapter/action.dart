import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CouponListAction { action }

class CouponListActionCreator {
  static Action onAction() {
    return const Action(CouponListAction.action);
  }
}
