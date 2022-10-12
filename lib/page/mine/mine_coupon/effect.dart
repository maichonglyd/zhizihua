import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<MineCouponState> buildEffect() {
  return combineEffects(<Object, Effect<MineCouponState>>{
    DownLoadManageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<MineCouponState> ctx) {}
