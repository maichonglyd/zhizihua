import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'action.dart';
import 'state.dart';

Effect<JpFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<JpFragmentState>>{
    JpFragmentAction.action: _onAction,
    Lifecycle.initState: _init,
    JpFragmentAction.getHomeByJp: _getHomeByJp,
  });
}

void _onAction(Action action, Context<JpFragmentState> ctx) {}

void _getHomeByJp(Action action, Context<JpFragmentState> ctx) {
  GameService.getHomeByJp(action.payload, 6).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list,
          ctx.state.jpGameStates.map((states) => states.game).toList(),
          action.payload);
      ctx.dispatch(JpFragmentActionCreator.update(newData));
    }
  });
}

void _init(Action action, Context<JpFragmentState> ctx) {
  ctx.dispatch(JpFragmentActionCreator.getHomeByJp(1));
}
