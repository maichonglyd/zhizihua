import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'action.dart';
import 'state.dart';

Effect<PtbExpenseState> buildEffect() {
  return combineEffects(<Object, Effect<PtbExpenseState>>{
    PtbExpenseAction.action: _onAction,
    PtbExpenseAction.getData: _getData,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<PtbExpenseState> ctx) {}

void _init(Action action, Context<PtbExpenseState> ctx) {
  ctx.dispatch(PtbExpenseActionCreator.getData(1));
}

void _getData(Action action, Context<PtbExpenseState> ctx) {
  UserService.ptbConsumeRecord(action.payload, 10).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.consumes, action.payload);
      ctx.dispatch(PtbExpenseActionCreator.update(newData));
    }
  });
}
