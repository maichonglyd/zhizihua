import 'package:fish_redux/fish_redux.dart';
import '../state.dart';
import 'action.dart';

Effect<CouponListState> buildEffect() {
  return combineEffects(<Object, Effect<CouponListState>>{
    CouponListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CouponListState> ctx) {}
