import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'action.dart';
import 'state.dart';

Effect<IntegralExpendState> buildEffect() {
  return combineEffects(<Object, Effect<IntegralExpendState>>{
    IntegralExpendAction.action: _onAction,
    Lifecycle.initState: _init,
    IntegralExpendAction.getGoldRecord: _getGoldRecord
  });
}

void _onAction(Action action, Context<IntegralExpendState> ctx) {}
void _init(Action action, Context<IntegralExpendState> ctx) {
  ctx.dispatch(IntegralExpendActionCreator.getGoldRecord(1));
}

void _getGoldRecord(Action action, Context<IntegralExpendState> ctx) {
  int page = action.payload;

  UserService.getGoldRecord(page, 10, 2).then((data) {
    if (data.code == 200) {
      List newData = ctx.state.controller
          .controllerRefresh(data.data.list, ctx.state.goldRecords, page);
      ctx.dispatch(
          IntegralExpendActionCreator.updateData(action.payload, newData));
    } else {}
  });
}
