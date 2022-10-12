import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_filter/popup/serverPopup.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_fragment/action.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_select_game/page.dart';
import 'action.dart';
import 'state.dart';

Effect<PropDealFilterState> buildEffect() {
  return combineEffects(<Object, Effect<PropDealFilterState>>{
    PropDealFilterAction.action: _onAction,
    PropDealFilterAction.gotoSelectGame: _gotoSelectGame,
    PropDealFilterAction.showServers: _showServers,
    PropDealFilterAction.selectSortType: _selectSortType,
    PropDealFilterAction.updateGameList: _updateGameList,
  });
}

void _onAction(Action action, Context<PropDealFilterState> ctx) {
  print("logcat: line 24");
}

void _showServers(Action action, Context<PropDealFilterState> ctx) {
  Navigator.push(
      ctx.context,
      ServerPopupRoute(
          MaterialLocalizations.of(ctx.context).modalBarrierDismissLabel,
          ctx.state.servers,
          ctx.state.anchorKey, (server) {
        Navigator.pop(ctx.context);
        ctx.dispatch(PropDealFilterActionCreator.selectServer(server));
        ctx.dispatch(PropDealFragmentActionCreator.getGoods(1));
      }));
}

void _selectSortType(Action action, Context<PropDealFilterState> ctx) {
  //主页更新商品
  ctx.dispatch(PropDealFragmentActionCreator.getGoods(1));
}

void _gotoSelectGame(Action action, Context<PropDealFilterState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PropDealSelectGamePage.pageName)
      .then((playedGame) {
    //标识已经选择游戏
    //刷新界面
    if (playedGame != null) {
      ctx.dispatch(PropDealFilterActionCreator.updateGame(playedGame));
      var game = playedGame as PlayedGame;
      //主页更新商品
      ctx.dispatch(PropDealFragmentActionCreator.getGoods(1));
      //请求区服列表
      DealService.getMaterialServices(game.gameId, 1).then((data) {
        if (data.code == CommonDio.SUCCESS_CODE) {
          ctx.state.servers = data.data.list;
        }
      });
    }
  });
}

void _updateGameList(Action action, Context<PropDealFilterState> ctx) {
  ctx.broadcast(PropDealFragmentActionCreator.getIndexData());
}
