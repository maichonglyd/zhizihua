import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/vip_service.dart';
import 'action.dart';
import 'state.dart';

Effect<OpenRecordState> buildEffect() {
  return combineEffects(<Object, Effect<OpenRecordState>>{
    OpenRecordAction.action: _onAction,
    OpenRecordAction.getRecordList: _getRecordList,
    Lifecycle.initState: _init
  });
}

void _init(Action action, Context<OpenRecordState> ctx) {
  VIPService.getRecordList(1, 10).then((data) {
    ctx.dispatch(OpenRecordActionCreator.updateRecordList(data.data.list));
  });
}

void _getRecordList(Action action, Context<OpenRecordState> ctx) {
  VIPService.getRecordList(action.payload, 10).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.recordList, action.payload);
      ctx.dispatch(OpenRecordActionCreator.updateRecordList(newData));
    }
  });
}

void _onAction(Action action, Context<OpenRecordState> ctx) {}
