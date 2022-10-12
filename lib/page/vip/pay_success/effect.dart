import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/vip/member_center/page.dart';
import 'package:flutter_huoshu_app/page/vip/pay_success/page.dart';
import 'action.dart';
import 'state.dart';

Effect<PaySuccessState> buildEffect() {
  return combineEffects(<Object, Effect<PaySuccessState>>{
    PaySuccessAction.action: _onAction,
    PaySuccessAction.gotoMemberCenter: _gotoMemberCenter,
  });
}

void _gotoMemberCenter(Action action, Context<PaySuccessState> ctx) {
  AppUtil.gotoPageByName(ctx.context, MemberCenterPage.pageName,
      arguments: null);
}

void _onAction(Action action, Context<PaySuccessState> ctx) {}
