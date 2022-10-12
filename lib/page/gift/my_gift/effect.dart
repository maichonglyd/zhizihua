import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/gift_service.dart';
import 'action.dart';
import 'state.dart';

Effect<MyGiftState> buildEffect() {
  return combineEffects(<Object, Effect<MyGiftState>>{
    MyGiftAction.action: _onAction,
    MyGiftAction.getGifts: _getGifts,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<MyGiftState> ctx) {}

void _getGifts(Action action, Context<MyGiftState> ctx) {
  GiftService.getMyGifts(action.payload, 10).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.gifts, action.payload);
      ctx.dispatch(MyGiftActionCreator.update(newData));
    }
  });
}

void _init(Action action, Context<MyGiftState> ctx) {
  ctx.dispatch(MyGiftActionCreator.getGifts(1));
}
