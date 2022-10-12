import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/gift_service.dart';
import 'action.dart';
import 'state.dart';

Effect<GameDetailsGiftFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<GameDetailsGiftFragmentState>>{
    GameDetailsGiftFragmentAction.action: _onAction,
    GameDetailsGiftFragmentAction.getGift: _getGift,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<GameDetailsGiftFragmentState> ctx) {}

void _init(Action action, Context<GameDetailsGiftFragmentState> ctx) {
  ctx.dispatch(GameDetailsGiftFragmentActionCreator.getGift(1));
}

void _getGift(Action action, Context<GameDetailsGiftFragmentState> ctx) {
  GiftService.getGiftsById(ctx.state.gameId, action.payload, 10).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.gifts, action.payload);
      ctx.state.refreshHelperController.setNotEmpty();
      ctx.dispatch(GameDetailsGiftFragmentActionCreator.updateGifts(newData));
    } else {}
  });
}
