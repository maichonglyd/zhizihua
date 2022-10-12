import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_details/page.dart';
import 'action.dart';
import 'state.dart';

Effect<PropDealItemState> buildEffect() {
  return combineEffects(<Object, Effect<PropDealItemState>>{
    PropDealItemAction.action: _onAction,
    PropDealItemAction.gotoDetails: _gotoDetails,
  });
}

void _onAction(Action action, Context<PropDealItemState> ctx) {}
void _gotoDetails(Action action, Context<PropDealItemState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PropDealDetailsPage.pageName,
      arguments: ctx.state.goods.goodsId);
}
