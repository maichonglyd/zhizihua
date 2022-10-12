import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'action.dart';
import 'state.dart';

Effect<ActivityListState> buildEffect() {
  return combineEffects(<Object, Effect<ActivityListState>>{
    ActivityListAction.action: _onAction,
    ActivityListAction.getData: _getData,
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<ActivityListState> ctx) {
  ctx.dispatch(ActivityListActionCreator.getData(1));
}

void _onAction(Action action, Context<ActivityListState> ctx) {}

void _getData(Action action, Context<ActivityListState> ctx) {
  GameService.getNewList(ctx.state.type, action.payload, 10).then((data) {
    var newData = ctx.state.refreshHelperController
        .controllerRefresh(data.data.list, ctx.state.dataList, action.payload);
    ctx.dispatch(ActivityListActionCreator.updateData(newData));
  });
}
