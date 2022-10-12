import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/pay/pay.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';
import 'package:flutter_huoshu_app/utils/CheckAppAvailability.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

Effect<PtzRechargeState> buildEffect() {
  return combineEffects(<Object, Effect<PtzRechargeState>>{
    PtzRechargeAction.action: _onAction,
    Lifecycle.initState: _init,
    PtzRechargeAction.selectPrice: _selectPrice,
    PtzRechargeAction.selectPayType: _selectPayType,
    PtzRechargeAction.selectPayTypeList: _selectPayTypeList,
    PtzRechargeAction.ptzPay: _ptzPay,
    PtzRechargeAction.queryOrder: _queryOrder,
    Lifecycle.didChangeAppLifecycleState: _didChangeAppLifecycleState,
  });
}

void _onAction(Action action, Context<PtzRechargeState> ctx) {}

void _init(Action action, Context<PtzRechargeState> ctx) {
  print("effect__init");
  ctx.state.priceController.addListener(() {
    ctx.dispatch(PtzRechargeActionCreator.updatePrice(
        int.parse(ctx.state.priceController.text)));
  });
  initPayWays(ctx);
}

void initPayWays(Context<PtzRechargeState> ctx) {
  List<PayWayMod> list = List();
  list.clear();
  List<String> icons = ["images/pic_n_zhifubao.png", "images/pic_n_wechat.png"];
  List<String> names = [getText(name: 'textAliPay'), getText(name: 'textWx')];
  for (int i = 0; i < names.length; i++) {
    if (i == 0) {
      list.add(new PayWayMod(names[i], names[i], icons[i], true));
    } else {
      list.add(new PayWayMod(names[i], names[i], icons[i], false));
    }
  }
  ctx.dispatch(PtzRechargeActionCreator.updatePayWayList(list));
}

void _ptzPay(Action action, Context<PtzRechargeState> ctx) {
  UserService.ptbPay(
          ctx.state.payType == 1 ? "wxpay" : "alipay", ctx.state.money)
      .then((data) {
    ctx.dispatch(PtzRechargeActionCreator.updatePayInfoData(data));
    //调用三方支付
    if (data.code == 200) {
      //支付宝/微信
      if (data.data.payType == 'alipay') {
        AliPayImpl().startPay(data.data.token).then((payData) {
          print(payData);
          //查询订单
          queryOrder(data.data.orderId, ctx);
        });
      } else if (data.data.payType == 'wxpay') {
        //微信支付
        WxPayImpl().startPay(data.data.token).then((payInfo) {});
      } else if (data.data.payType == 'wxpayh5') {
        if (!data.data.token.startsWith("http")) {
          //跳微信协议
          CheckAppAvailability.checkAvailability(AppPlatform.WeChat, () {
            launch(data.data.token);
          });
        } else {
          AppUtil.gotoH5Web(ctx.context, data.data.token, title: getText(name: 'textRecharge'), noHttpParam: true)
              .then((d) {
            queryOrder(data.data.orderId, ctx);
          });
        }
      } else if (data.data.payType == 'pattern_url') {
        // url来拉起支付
        AppUtil.gotoH5Web(ctx.context, data.data.token, title: getText(name: 'textPay'), noHttpParam: true)
            .then((d) {
          queryOrder(data.data.orderId, ctx);
        });
      } else if (data.data.payType == 'pattern_protocol') {
        // 协议来拉起支付
        launch(data.data.token);
      }
    }
  });
}

void queryOrder(String orderId, Context<PtzRechargeState> ctx) {
  UserService.queryOrder(orderId).then((data) {
    if (data['code'] == 200 && data['data']['status'] == 2) {
      //支付成功
      showToast(getText(name: 'textPaySuccessful'));
      Navigator.of(ctx.context).pop();
    } else {
      //支付失败
      showToast(getText(name: 'textPayFailed'));
//      Navigator.of(ctx.context).pop();
    }
    ctx.broadcast(MineFragmentActionCreator.getUserInfo());
  });
}

void _queryOrder(Action action, Context<PtzRechargeState> ctx) {
  if (ctx.state.dealPayInfoData != null) {
    print("effect queryOrder");
    queryOrder(ctx.state.dealPayInfoData.data.orderId, ctx);
  }
}

void _didChangeAppLifecycleState(Action action, Context<PtzRechargeState> ctx) {
  print("effect__didChangeAppLifecycleState");
  AppLifecycleState state = action.payload;
  if(AppLifecycleState.resumed != state) {
    return;
  }
  if (ctx.state.payType == 1 && null != ctx.state.dealPayInfoData
      && ctx.state.dealPayInfoData.data.payType == "wxpayh5"
      && !ctx.state.dealPayInfoData.data.token.startsWith("http")) {
    var bool = ModalRoute.of(ctx.context).isCurrent;
    if (bool) {
      if (ctx.state.dealPayInfoData != null) {
        queryOrder(ctx.state.dealPayInfoData.data.orderId, ctx);
      }
    }
  }
}

void _selectPrice(Action action, Context<PtzRechargeState> ctx) {
  ctx.state.priceController.text = "";
  ctx.dispatch(PtzRechargeActionCreator.updatePrice(
      ctx.state.defaultMoneys[action.payload]));
}

void _selectPayType(Action action, Context<PtzRechargeState> ctx) {
  ctx.dispatch(PtzRechargeActionCreator.updatePrice(action.payload));
}

void _selectPayTypeList(Action action, Context<PtzRechargeState> ctx) {
  int index = action.payload;
  int i = 0;
  int payType;
  List<PayWayMod> dataList = List();
  if (ctx.state.payWayMods != null && ctx.state.payWayMods.length > 0) {
    for (PayWayMod mod in ctx.state.payWayMods) {
      if (index == i) {
        mod.isSelected = true;
        payType = i;
      } else {
        mod.isSelected = false;
      }
      dataList.add(mod);
      i++;
    }
  }
//  dataList= ctx.state.payWayMods.where((data)=>data.isSelected).toList();
  ctx.dispatch(PtzRechargeActionCreator.updatePayWayList(dataList));
  ctx.dispatch(PtzRechargeActionCreator.updatePayType(payType));
}
