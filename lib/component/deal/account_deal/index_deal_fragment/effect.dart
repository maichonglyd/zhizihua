import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_notice_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_search/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_sell_edit_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/action.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/TipDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<IndexDealFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<IndexDealFragmentState>>{
    IndexDealFragmentAction.action: _onAction,
    IndexDealFragmentAction.getDealGoods: _getDealGoods,
    Lifecycle.initState: _init,
    IndexDealFragmentAction.onGotoSellEdit: _gotoSellEdit,
    IndexDealFragmentAction.onCancel: _onCancel,
    IndexDealFragmentAction.onCancelOK: _onCancelOK,
    LoginAction.loginOK: _loginOK,
  });
}

void _onAction(Action action, Context<IndexDealFragmentState> ctx) {}

void _loginOK(Action action, Context<IndexDealFragmentState> ctx) {
  print("收到登录成功了");
  ctx.dispatch(IndexDealFragmentActionCreator.getDealGoods(1));
}

void _getDealGoods(Action action, Context<IndexDealFragmentState> ctx) {
  if (action.payload == 1) {
    DealService.getDealIndex().then((data) {
      if (data.code == 200) {
        ctx.dispatch(IndexDealFragmentActionCreator.updateDealIndex(data));
      }
    });
  }
  DealService.getDealGoods(
          action.payload, 10, ctx.state.dealItemTitleState.typeIndex + 1)
      .then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.dealGoods, action.payload);
      ctx.state.refreshHelperController.setNotEmpty();
      ctx.dispatch(IndexDealFragmentActionCreator.updateDealGoods(newData));
    }
  });
}

void _init(Action action, Context<IndexDealFragmentState> ctx) {
  ctx.dispatch(IndexDealFragmentActionCreator.getDealGoods(1));
}

void _gotoSellEdit(Action action, Context<IndexDealFragmentState> ctx) {
  int goodsId = action.payload['goodsId'];
  int status = action.payload['status'];
  if (status != null && status == 6) {
    showToast(getText(name: 'toastAccountDealing'));
    return;
  }
  AppUtil.gotoPageByName(ctx.context, DealSellEditPage.pageName,
      arguments: {"goodsId": goodsId});
}

void _onCancel(Action action, Context<IndexDealFragmentState> ctx) {
  int goodsId = action.payload['goodsId'];
  int status = action.payload['status'];
  if (status == 6) {
    showToast(getText(name: 'toastAccountDealing'));
    return;
  }
  showDialog<Null>(
      context: ctx.context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return TipDialog(
          getText(name: 'textConfirmCancelAccountDeal'),
          hint: getText(name: 'textCancelAccountDeal'),
          confirmCallback: () {
            DealService.dealGoodsCancel(goodsId).then((data) {
              if (data.code == CommonDio.SUCCESS_CODE) {
                ctx.broadcast(
                    IndexDealFragmentActionCreator.onCancelOK(goodsId));
              }
            });
          },
        );
      });
}

void _onCancelOK(Action action, Context<IndexDealFragmentState> ctx) {
  //更新请求。。
  ctx.dispatch(IndexDealFragmentActionCreator.getDealGoods(1));
}
