import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/api/vip_service.dart';
import 'package:flutter_huoshu_app/common/pay/pay.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';
import 'package:flutter_huoshu_app/page/vip/member_center/action.dart';
import 'package:flutter_huoshu_app/page/vip/open_record/page.dart';
import 'package:flutter_huoshu_app/page/vip/pay_success/page.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

Effect<OpenVipState> buildEffect() {
  return combineEffects(<Object, Effect<OpenVipState>>{
    OpenVipAction.action: _onAction,
    Lifecycle.initState: _init,
    OpenVipAction.selectPayType: _selectPayType,
    OpenVipAction.selectVipType: _selectVipType,
    OpenVipAction.gotoPaySuccess: _gotoPaySuccess,
    OpenVipAction.gotoPay: _gotoPay,
    OpenVipAction.gotoOpenRecordList: _gotoOpenRecordList,
    Lifecycle.didChangeAppLifecycleState: _didChangeAppLifecycleState,
  });
}

//开通vip
void _gotoPay(Action action, Context<OpenVipState> ctx) {
  VIPService.openVip(ctx.state.selectedVipId, ctx.state.payType).then((data) {
    ctx.dispatch(OpenVipActionCreator.updatePayInfoData(data));
    //调用三方支付
    if (data.code == 200) {
      print(data.data.token);
      if (data.data.payType == "alipay") {
        //支付宝
        AliPayImpl().startPay(data.data.token).then((payInfo) {
          queryOrder(data.data.orderId, ctx);
        });
      } else if (data.data.payType == "wxpayh5") {
        print("wxpayh5-------------");
        if (!data.data.token.startsWith("http")) {
          //走协议跳url
//          launch(data.data.token);
          launch(data.data.token).then((value) {
            //页面返回的时候
//            showToast("支付成功");
            print("支付成功");
            queryOrder(data.data.orderId, ctx);
          });
        } else {
          AppUtil.gotoH5Web(ctx.context, data.data.token, title: getText(name: 'textPay'), noHttpParam: true)
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
        launch(data.data.token).then((value) {
          queryOrder(data.data.orderId, ctx);
        });
      } else {
        WxPayImpl().startPay(data.data.token).then((payInfo) {
          print("wxpay----------------------");
          queryOrder(data.data.orderId, ctx);
        });
      }
    }
  });
}

void _onAction(Action action, Context<OpenVipState> ctx) {}

void _gotoOpenRecordList(Action action, Context<OpenVipState> ctx) {
  AppUtil.gotoPageByName(ctx.context, OpenRecordPage.pageName, arguments: null);
}

void _gotoPaySuccess(Action action, Context<OpenVipState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PaySuccessPage.pageName, arguments: null);
}

List<VIPMod> vipModlist = List();
List<PayWayMod> payWayModList = List();

void _init(Action action, Context<OpenVipState> ctx) {
  vipModlist.clear();
  payWayModList.clear();

  VIPService.getVipList(1).then((data) {
    if (data.code == 200) {
      int i = 0;
      int k = 0;
      if (data.data.list != null && data.data.list.length > 0) {
        for (VIPMod mod in data.data.list) {
          if (i == 0) {
            mod.isSelected = true;
          } else {
            mod.isSelected = false;
          }
          vipModlist.add(mod);
          i++;
        }
      }
      if (data.data.payWays != null && data.data.payWays.length > 0) {
        for (PayWayMod mod in data.data.payWays) {
          if (k == 0) {
            mod.isSelected = true;
          } else {
            mod.isSelected = false;
          }
          payWayModList.add(mod);
          k++;
        }
      }
      ctx.dispatch(
          OpenVipActionCreator.updateVipList(vipModlist, payWayModList));
      //默认选中第一个
      if (data.data.list.length > 0 && data.data.payWays.length > 0) {
        ctx.dispatch(OpenVipActionCreator.updateVipId(data.data.list[0].id));
        ctx.dispatch(
            OpenVipActionCreator.updatePayType(data.data.payWays[0].payWay));
      }
    }
  });
}

void queryOrder(String orderId, Context<OpenVipState> ctx) {
  VIPService.queryOrder(orderId).then((data) {
    if (data['code'] == 200 && data['data']['status'] == 2) {
      //跳转支付成功页面
      showToast(getText(name: 'textPaySuccessful'));
      ctx.dispatch(OpenVipActionCreator.gotoPaySuccess());
//      AppUtil.gotoPageByName(ctx.context, PaySuccessPage.pageName, arguments: null);
      //开通成功之后,通知vip中心更新
      ctx.broadcast(MemberCenterActionCreator.getData());
      Navigator.of(ctx.context).pop();
    } else {
      //支付失败
      showToast(getText(name: 'textAppointmentFailed'));
    }
    //通知个人中心刷新
    ctx.broadcast(MineFragmentActionCreator.getMemInfo());
  });
}

void _queryOrder(Action action, Context<OpenVipState> ctx) {
  if (ctx.state.vipPayInfoData != null) {
    print("effect queryOrder");
    queryOrder(ctx.state.vipPayInfoData.data.orderId, ctx);
  }
}

void _didChangeAppLifecycleState(Action action, Context<OpenVipState> ctx) {
  print("effect__didChangeAppLifecycleState");
  var bool = ModalRoute.of(ctx.context).isCurrent;
  if (bool) {
    if (ctx.state.vipPayInfoData != null) {
      queryOrder(ctx.state.vipPayInfoData.data.orderId, ctx);
    }
  }
}

void _selectPayType(Action action, Context<OpenVipState> ctx) {
  int index = action.payload;
  int i = 0;
  String payType;
  List<PayWayMod> dataList = List();
  if (ctx.state.payWayMods != null && ctx.state.payWayMods.length > 0) {
    for (PayWayMod mod in ctx.state.payWayMods) {
      if (index == i) {
        mod.isSelected = true;
        payType = mod.payWay;
      } else {
        mod.isSelected = false;
      }
      dataList.add(mod);
      i++;
    }
  }
  ctx.dispatch(OpenVipActionCreator.updateVipList(ctx.state.vipMods, dataList));
  ctx.dispatch(OpenVipActionCreator.updatePayType(payType));
}

void _selectVipType(Action action, Context<OpenVipState> ctx) {
  int index = action.payload;
  int i = 0;
  int selectedVipId = 0;
  List<VIPMod> dataList = List();
  if (ctx.state.vipMods != null && ctx.state.vipMods.length > 0) {
    for (VIPMod mod in ctx.state.vipMods) {
      if (index == i) {
        mod.isSelected = true;
        selectedVipId = mod.id;
      } else {
        mod.isSelected = false;
      }
      dataList.add(mod);
      i++;
    }
  }
  ctx.dispatch(
      OpenVipActionCreator.updateVipList(dataList, ctx.state.payWayMods));
  ctx.dispatch(OpenVipActionCreator.updateVipId(selectedVipId));
}
