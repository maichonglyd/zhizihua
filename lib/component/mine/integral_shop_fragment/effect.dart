import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'action.dart';
import 'state.dart';

Effect<IntegralShopFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<IntegralShopFragmentState>>{
    IntegralShopFragmentAction.action: _onAction,
    IntegralShopFragmentAction.getIntegralGoods: _getIntegralGoods,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<IntegralShopFragmentState> ctx) {}

void _getIntegralGoods(Action action, Context<IntegralShopFragmentState> ctx) {
  UserService.getGoods(action.payload, 10, ctx.state.isReal).then((data) {
    var newData = ctx.state.refreshHelperController
        .controllerRefresh(data.data.list, ctx.state.goodsList, action.payload);
    ctx.dispatch(IntegralShopFragmentActionCreator.updateGoods(newData));
  });
}

void _init(Action action, Context<IntegralShopFragmentState> ctx) {
  ctx.dispatch(IntegralShopFragmentActionCreator.getIntegralGoods(1));
}
