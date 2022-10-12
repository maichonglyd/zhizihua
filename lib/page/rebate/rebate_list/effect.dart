import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/rebate_service.dart';
import 'action.dart';
import 'state.dart';

Effect<RebateRecordListState> buildEffect() {
  return combineEffects(<Object, Effect<RebateRecordListState>>{
    RebateRecordListAction.action: _onAction,
    RebateRecordListAction.getRecords: _getRecords,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<RebateRecordListState> ctx) {}
void _getRecords(Action action, Context<RebateRecordListState> ctx) {
  RebateService.getRebateRecordList(action.payload, 10).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.records, action.payload);
      ctx.dispatch(RebateRecordListActionCreator.updateRecords(newData));
    }
  });
}

void _init(Action action, Context<RebateRecordListState> ctx) {
  ctx.dispatch(RebateRecordListActionCreator.getRecords(1));
}
