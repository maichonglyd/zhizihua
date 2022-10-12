import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'action.dart';
import 'state.dart';

Effect<PtzIncomeState> buildEffect() {
  return combineEffects(<Object, Effect<PtzIncomeState>>{
    PtzIncomeAction.action: _onAction,
    PtzIncomeAction.getData: _getData,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<PtzIncomeState> ctx) {}
void _init(Action action, Context<PtzIncomeState> ctx) {
  ctx.dispatch(PtzIncomeActionCreator.getData(1));
}

void _getData(Action action, Context<PtzIncomeState> ctx) {
  UserService.ptbRechargeRecord(action.payload, 10).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.records, action.payload);
      ctx.dispatch(PtzIncomeActionCreator.updateData(newData));
    }
  });
}
