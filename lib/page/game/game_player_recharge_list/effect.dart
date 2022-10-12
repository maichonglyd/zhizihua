import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'action.dart';
import 'state.dart';

Effect<GamePlayerRechargeListState> buildEffect() {
  return combineEffects(<Object, Effect<GamePlayerRechargeListState>>{
    Lifecycle.initState: _init,
    GamePlayerRechargeListAction.action: _onAction,
    GamePlayerRechargeListAction.getData: _getData,
  });
}

void _onAction(Action action, Context<GamePlayerRechargeListState> ctx) {
}

void _init(Action action, Context<GamePlayerRechargeListState> ctx) {
  ctx.dispatch(GamePlayerRechargeListActionCreator.getData(1));
}

void _getData(Action action, Context<GamePlayerRechargeListState> ctx) {
  int page = action.payload;
  UserService.cplMemRank(page, 100).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(data.data.list, ctx.state.rankList, page);
      ctx.dispatch(GamePlayerRechargeListActionCreator.updateData(newData));
    }
  });
}

