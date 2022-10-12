import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'action.dart';
import 'state.dart';

Effect<PropDealOrderDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<PropDealOrderDetailsState>>{
    PropDealOrderDetailsAction.action: _onAction,
    PropDealOrderDetailsAction.getOrderDetails: _getOrderDetails,
    PropDealOrderDetailsAction.init: _init,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<PropDealOrderDetailsState> ctx) {}

void _init(Action action, Context<PropDealOrderDetailsState> ctx) {
  ctx.dispatch(PropDealOrderDetailsActionCreator.getOrderDetails());
}

void _getOrderDetails(Action action, Context<PropDealOrderDetailsState> ctx) {
  DealService.getMaterialOrderDetails(ctx.state.orderId).then((data) {
    if (data.code == CommonDio.SUCCESS_CODE) {
      ctx.dispatch(PropDealOrderDetailsActionCreator.updateOrderDetails(data));
    }
  });
}
