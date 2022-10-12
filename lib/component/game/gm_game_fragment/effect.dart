import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'action.dart';
import 'state.dart';

Effect<GMGameFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<GMGameFragmentState>>{
    GMGameFragmentAction.action: _onAction,
    Lifecycle.initState: _initState,
    GMGameFragmentAction.getGmGameData: _getGmGameData,
  });
}

void _onAction(Action action, Context<GMGameFragmentState> ctx) {}

void _initState(Action action, Context<GMGameFragmentState> ctx) {
  ctx.dispatch(GMGameFragmentActionCreator.getGmGameData(1));
}

void _getGmGameData(Action action, Context<GMGameFragmentState> ctx) {
  if (ctx.state.type == 1) {
    GameService.getGameListByGmMy(action.payload, 10).then((data) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.gameList, action.payload);
      ctx.dispatch(GMGameFragmentActionCreator.updateGmGameList(newData));
    });
  } else {
    GameService.getGameListByGmHome(action.payload, 10).then((data) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.gameList, action.payload);
      ctx.dispatch(GMGameFragmentActionCreator.updateGmGameList(newData));
    });
  }
}
