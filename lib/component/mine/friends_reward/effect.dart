import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'action.dart';
import 'state.dart';

Effect<FriendRewardState> buildEffect() {
  return combineEffects(<Object, Effect<FriendRewardState>>{
    FriendRewardAction.action: _onAction,
    FriendRewardAction.getData: _getData,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<FriendRewardState> ctx) {}

void _init(Action action, Context<FriendRewardState> ctx) {
  ctx.dispatch(FriendRewardActionCreator.getData(1));
}

void _getData(Action action, Context<FriendRewardState> ctx) {
  UserService.getUserShareSubactlist(action.payload).then((data) {
    if (data.code == 200) {
      ctx.dispatch(FriendRewardActionCreator.updateData(data.data.list));
    }
  });
}
