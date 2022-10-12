import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/lottery_service.dart';

import 'action.dart';
import 'state.dart';

Effect<RewardDetailState> buildEffect() {
  return combineEffects(<Object, Effect<RewardDetailState>>{
    Lifecycle.initState: _init,
    RewardDetailAction.action: _onAction,
    RewardDetailAction.getData: _getData,
  });
}

void _onAction(Action action, Context<RewardDetailState> ctx) {}

void _init(Action action, Context<RewardDetailState> ctx) {
  ctx.dispatch(RewardDetailActionCreator.getData());
}

void _getData(Action action, Context<RewardDetailState> ctx) {
  LotteryService.getRewardDetail(ctx.state.orderId).then((data) {
    if (200 == data.code) {
      ctx.state.refreshHelperController
          .finishRefresh(success: true, noMore: true);
      ctx.dispatch(RewardDetailActionCreator.updateData(data.data));
    }
  });
}
