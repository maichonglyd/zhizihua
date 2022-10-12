import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record_details/page.dart';
import 'action.dart';
import 'state.dart';

Effect<ExchangeRecordState> buildEffect() {
  return combineEffects(<Object, Effect<ExchangeRecordState>>{
    ExchangeRecordAction.action: _onAction,
    Lifecycle.initState: _init,
    ExchangeRecordAction.getRecordData: _getRecordData,
    ExchangeRecordAction.gotoDetails: _gotoDetails,
  });
}

void _onAction(Action action, Context<ExchangeRecordState> ctx) {}
void _init(Action action, Context<ExchangeRecordState> ctx) {
  ctx.dispatch(ExchangeRecordActionCreator.getRecordData(1));
}

void _getRecordData(Action action, Context<ExchangeRecordState> ctx) {
  UserService.getExchangeRecordList(action.payload, 10).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.list, action.payload);
      ctx.dispatch(ExchangeRecordActionCreator.updateData(newData));
    }
  });
}

void _gotoDetails(Action action, Context<ExchangeRecordState> ctx) {
  AppUtil.gotoPageByName(ctx.context, ExchangeRecordDetailsPage.pageName,
      arguments: action.payload);
}
