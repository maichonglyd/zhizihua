import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'action.dart';
import 'state.dart';

Effect<GameDetailsDealFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<GameDetailsDealFragmentState>>{
    GameDetailsDealFragmentAction.action: _onAction,
    GameDetailsDealFragmentAction.getDealGoods: _getDealGoods,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<GameDetailsDealFragmentState> ctx) {}
void _init(Action action, Context<GameDetailsDealFragmentState> ctx) {
  ctx.dispatch(GameDetailsDealFragmentActionCreator.getDealGoods(1));
}

void _getDealGoods(Action action, Context<GameDetailsDealFragmentState> ctx) {
  DealService.getDealGoodsById(action.payload, 10, ctx.state.gameId)
      .then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.dealGoods, action.payload);
      ctx.state.refreshHelperController.setNotEmpty();
      ctx.dispatch(GameDetailsDealFragmentActionCreator.update(newData));
    }
  });
}
