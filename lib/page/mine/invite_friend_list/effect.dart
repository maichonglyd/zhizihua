import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'action.dart';
import 'state.dart';

Effect<InviteListState> buildEffect() {
  return combineEffects(<Object, Effect<InviteListState>>{
    InviteListAction.action: _onAction,
    InviteListAction.getShareMemList: _getShareMemList,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<InviteListState> ctx) {}

void _getShareMemList(Action action, Context<InviteListState> ctx) {
  UserService.getShareMemlist(action.payload, 10).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.mems, action.payload);
      ctx.dispatch(InviteListActionCreator.update(newData));
    }
  });
}

void _init(Action action, Context<InviteListState> ctx) {
  ctx.dispatch(InviteListActionCreator.getShareMemList(1));
}
