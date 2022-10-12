import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'action.dart';
import 'state.dart';

Effect<DealShopListPageState> buildEffect() {
  return combineEffects(<Object, Effect<DealShopListPageState>>{
    DealShopListPageAction.action: _onAction,
    Lifecycle.initState: _init,
    DealShopListPageAction.onGetData: _onGetData,
  });
}

void _onAction(Action action, Context<DealShopListPageState> ctx) {}

void _init(Action action, Context<DealShopListPageState> ctx) {
  _onGetData(action, ctx);
}

void _onGetData(Action action, Context<DealShopListPageState> ctx) {
  DealService.getDealGoodsById(action.payload, 10, ctx.state.playedGame.gameId)
      .then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.dealGoodsList, action.payload);
      ctx.dispatch(DealShopListPageActionCreator.update(newData));
    }
  });
}
