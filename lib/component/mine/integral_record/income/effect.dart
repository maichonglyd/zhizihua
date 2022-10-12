import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'action.dart';
import 'state.dart';

Effect<IntegralIncomeState> buildEffect() {
  return combineEffects(<Object, Effect<IntegralIncomeState>>{
    IntegralIncomeAction.action: _onAction,
    IntegralIncomeAction.getGoldRecord: _getGoldRecord,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<IntegralIncomeState> ctx) {}
void _init(Action action, Context<IntegralIncomeState> ctx) {
  ctx.dispatch(IntegralIncomeActionCreator.getGoldRecord(1));
}

void _getGoldRecord(Action action, Context<IntegralIncomeState> ctx) {
  int page = action.payload;
  UserService.getGoldRecord(page, 10, 1).then((data) {
    if (data.code == 200) {
      List newData = ctx.state.controller
          .controllerRefresh(data.data.list, ctx.state.goldRecords, page);
      ctx.dispatch(
          IntegralIncomeActionCreator.updateData(action.payload, newData));
    } else {}
  });
}
