import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_fragment/action.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_sell_edit_page/action.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_sell_edit_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<DealSellListState> buildEffect() {
  return combineEffects(<Object, Effect<DealSellListState>>{
    DealSellListAction.action: _onAction,
    Lifecycle.initState: _init,
    DealSellListAction.onLoadData: _onLoadData,
    DealSellEditAction.onEditOK: _onEditOK,
    IndexDealFragmentAction.onCancelOK: _onCancelOK,
  });
}

void _onAction(Action action, Context<DealSellListState> ctx) {}

void _init(Action action, Context<DealSellListState> ctx) {
  ctx.dispatch(DealSellListActionCreator.onLoadData(1));
}

void _onLoadData(Action action, Context<DealSellListState> ctx) {
  int status = 0; //status	状态 0所有 1审核中 2已上架 3已下架 4已出售 5审核不通过
  switch (ctx.state.type) {
    case 0:
      {
        //全部
        status = 0;
        break;
      }
    case 1:
      {
        //正在出售
        status = 2;
        break;
      }
    case 2:
      {
        //已经出售
        status = 4;
        break;
      }
  }
  DealService.getMyDealGoods(action.payload, 10, status).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.dealGoodsList, action.payload);
      ctx.dispatch(DealSellListActionCreator.update(newData, ctx.state.type));
    }
  });
}

void _onEditOK(Action action, Context<DealSellListState> ctx) {
  ctx.dispatch(DealSellListActionCreator.onLoadData(1));
}

void _onCancelOK(Action action, Context<DealSellListState> ctx) {
  ctx.dispatch(DealSellListActionCreator.onLoadData(1));
}
