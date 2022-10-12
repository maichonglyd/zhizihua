import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/coupon_service.dart';
import 'package:flutter_huoshu_app/api/game_currency_service.dart';
import 'package:flutter_huoshu_app/repository/game_download_repository.dart';
import 'action.dart';
import 'state.dart';

Effect<CurrRecordListState> buildEffect() {
  return combineEffects(<Object, Effect<CurrRecordListState>>{
    CouponListAction.action: _onAction,
    CouponListAction.getCouponList: _getCouponList,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<CurrRecordListState> ctx) {}

void _getCouponList(Action action, Context<CurrRecordListState> ctx) {
  print("_getCouponList");
  if (ctx.state.status == 1) {
    //充值
    GameCurrService.getRechargeList(action.payload, ctx.state.gameId)
        .then((data) {
      var recordList = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.recordList, action.payload);
      ctx.dispatch(CouponListActionCreator.updateRecordList(recordList));
    }).catchError((data) {
      ctx.state.refreshHelperController.finishRefresh();
      ctx.state.refreshHelperController.finishLoad();
    });
  } else {
    GameCurrService.getConsumeList(action.payload, ctx.state.gameId)
        .then((data) {
      var recordList = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.recordList, action.payload);
      ctx.dispatch(CouponListActionCreator.updateRecordList(recordList));
    });
  }
}

void _init(Action action, Context<CurrRecordListState> ctx) {
  if (ctx.state.status == 1) {
    //充值
    GameCurrService.getRechargeList(1, ctx.state.gameId).then((data) {
      ctx.dispatch(CouponListActionCreator.updateRecordList(data.data.list));
    });
  } else {
    GameCurrService.getConsumeList(1, ctx.state.gameId).then((data) {
      ctx.dispatch(CouponListActionCreator.updateRecordList(data.data.list));
    });
  }
}
