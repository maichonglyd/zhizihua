import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_sell_edit/page.dart';
import 'action.dart';
import 'state.dart';

Effect<PropDealSellRecordState> buildEffect() {
  return combineEffects(<Object, Effect<PropDealSellRecordState>>{
    PropDealSellRecordAction.action: _onAction,
    PropDealSellRecordAction.getSellRecord: _getSellRecord,
    PropDealSellRecordAction.gotoEdit: _gotoEdit,
    PropDealSellRecordAction.cancelGoods: _cancelGoods,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<PropDealSellRecordState> ctx) {}
void _cancelGoods(Action action, Context<PropDealSellRecordState> ctx) {
  DealService.cancelMaterialGoods(action.payload).then((data) {
    if (data.code == CommonDio.SUCCESS_CODE) {
      ctx.dispatch(PropDealSellRecordActionCreator.getSellRecord(1));
    }
  });
}

void _gotoEdit(Action action, Context<PropDealSellRecordState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PropDealSellEditPage.pageName,
      arguments: {"goodsId": action.payload}).then((data) {
    ctx.dispatch(PropDealSellRecordActionCreator.getSellRecord(1));
  });
}

void _init(Action action, Context<PropDealSellRecordState> ctx) {
  ctx.dispatch(PropDealSellRecordActionCreator.getSellRecord(1));
}

void _getSellRecord(Action action, Context<PropDealSellRecordState> ctx) {
  DealService.getMaterialGoodsList(action.payload, isMeSell: 2).then((data) {
    if (data.code == CommonDio.SUCCESS_CODE) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.goodsList, action.payload);
      ctx.dispatch(PropDealSellRecordActionCreator.updateSellRecord(newData));
    }
  });
}
