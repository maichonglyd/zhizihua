import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_fragment/action.dart';
import 'package:flutter_huoshu_app/widget/dialog/SelectDealTypeDialog.dart';
import 'action.dart';
import 'state.dart';

Effect<DealItemTitleState> buildEffect() {
  return combineEffects(<Object, Effect<DealItemTitleState>>{
    DealItemTitleAction.action: _onAction,
    DealItemTitleAction.selectType: _selectType,
  });
}

void _onAction(Action action, Context<DealItemTitleState> ctx) {}

void _selectType(Action action, Context<DealItemTitleState> ctx) {
  showModalBottomSheet(
      context: ctx.context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SelectDealTypeDialog(ctx.state.types, (type, index) {
          //更新界面。。
          ctx.dispatch(DealItemTitleActionCreator.updateType(index));
          //更新请求。。
          ctx.dispatch(IndexDealFragmentActionCreator.getDealGoods(1));
        });
      });
}
