import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/page/game/game_new_tour_list/action.dart';
import 'action.dart';
import 'state.dart';

Effect<GameNewRoundListState> buildEffect() {
  return combineEffects(<Object, Effect<GameNewRoundListState>>{
    Lifecycle.initState: _init,
    GameNewRoundListAction.action: _onAction,
    GameNewRoundListAction.getData: _getData,
  });
}

void _onAction(Action action, Context<GameNewRoundListState> ctx) {
}

void _init(Action action, Context<GameNewRoundListState> ctx) {
  ctx.dispatch(GameNewRoundListActionCreator.getData(1));
}

void _getData(Action action, Context<GameNewRoundListState> ctx) {
  int page = action.payload;
  GameService.getGameTop(ctx.state.type, page, 20).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(data.data.list, ctx.state.gameList, page);
      ctx.dispatch(GameNewTourListActionCreator.updateData(ctx.state.type, newData));
      ctx.dispatch(GameNewRoundListActionCreator.updateData(newData));
    }
  });
}
