import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_filter/action.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_sell_edit/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/action.dart';
import 'action.dart';
import 'state.dart';

Effect<PropDealFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<PropDealFragmentState>>{
    Lifecycle.initState: _init,
    PropDealFragmentAction.onGotoSellEdit: _onGotoSellEdit,
    PropDealFragmentAction.getGoods: _getGoods,
    PropDealFragmentAction.getIndexData: _getIndexData,
    LoginAction.loginOK: _loginOK,
  });
}

void _init(Action action, Context<PropDealFragmentState> ctx) {
  ctx.dispatch(PropDealFragmentActionCreator.getIndexData());
}

void _loginOK(Action action, Context<PropDealFragmentState> ctx) {
  print("收到登录成功了");
  ctx.dispatch(PropDealFragmentActionCreator.getIndexData());
}

void _getIndexData(Action action, Context<PropDealFragmentState> ctx) {
  DealService.getMaterialDealIndex().then((data) {
    if (data.code == CommonDio.SUCCESS_CODE) {
      ctx.dispatch(PropDealFragmentActionCreator.updateIndexData(data));
    }
  });
  ctx.dispatch(PropDealFragmentActionCreator.getGoods(1));
}

void _getGoods(Action action, Context<PropDealFragmentState> ctx) {
  var gameId = ctx.state.propDealFilterState.playedGame != null
      ? ctx.state.propDealFilterState.playedGame.gameId
      : null;
  var sortType = ctx.state.propDealFilterState.sortType;
  var serverId = ctx.state.propDealFilterState.curServer != null
      ? ctx.state.propDealFilterState.curServer.serverId
      : null;

  DealService.getMaterialGoodsList(action.payload,
          state: 2, gameId: gameId, sortType: sortType, serverId: serverId)
      .then((data) {
    if (data.code == CommonDio.SUCCESS_CODE) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.goodsList, action.payload);
      ctx.state.refreshHelperController.setNotEmpty();
      ctx.dispatch(PropDealFragmentActionCreator.updateGoods(newData));
    }
  });
}

void _onGotoSellEdit(Action action, Context<PropDealFragmentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PropDealSellEditPage.pageName);
}
