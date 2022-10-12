import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/vip_service.dart';
import 'package:flutter_huoshu_app/common/pay/pay.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment_up/action.dart';
import 'package:flutter_huoshu_app/component/video/event_bus_manager.dart';
import 'package:flutter_huoshu_app/event/event.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/vip/vip_record_list.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';
import 'package:flutter_huoshu_app/utils/CheckAppAvailability.dart';
import 'package:flutter_huoshu_app/widget/dialog/ConfirmPayDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/SelectPayTypeDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/TakeSuccessDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/VipRecordDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

Effect<VipOpenState> buildEffect() {
  return combineEffects(<Object, Effect<VipOpenState>>{
    VipOpenAction.action: _onAction,
    VipOpenAction.showPayTypeDialog: _showPayTypeDialog,
    VipOpenAction.getRecordList: _getRecordList,
    VipOpenAction.getVipList: _getVipList,
    VipOpenAction.showRecordDialog: _showRecordDialog,
    VipOpenAction.getMemInfo: _getMemInfo,
    VipOpenAction.reward: _reward,
    Lifecycle.initState: _init,
    Lifecycle.didChangeDependencies: _didChangeDependencies,
    Lifecycle.dispose: _dispose,
  });
}

List<VIPMod> vipModlist = List();
List<PayWayMod> payWayModList = List();
StreamSubscription _pauseSubscription;

void _init(Action action, Context<VipOpenState> ctx) {
  ctx.dispatch(VipOpenActionCreator.getMemInfo());
  //获取记录
  ctx.dispatch(VipOpenActionCreator.getRecordList());
  ctx.dispatch(VipOpenActionCreator.getVipList());

//  EventBus eventBus = EventBusManager.getEventBus();
//  _pauseSubscription = eventBus.on<Event>().listen((event) {
//    if (event.tag == "onResume") {
//      showToast("onResume");
//      _refreshData(action, ctx);
//    }
//  });
}

void _getVipList(Action action, Context<VipOpenState> ctx) {
  vipModlist.clear();
  payWayModList.clear();
  VIPService.getVipList(1).then((data) {
    if (data.code == 200) {
      if (data.data.list != null && data.data.list.length > 0) {
        for (VIPMod mod in data.data.list) {
          vipModlist.add(mod);
        }
      }
      if (data.data.payWays != null && data.data.payWays.length > 0) {
        for (PayWayMod mod in data.data.payWays) {
          payWayModList.add(mod);
        }
      }
    }
    ctx.dispatch(VipOpenActionCreator.updateVipList(vipModlist, payWayModList));
  });
}

void _getRecordList(Action action, Context<VipOpenState> ctx) {
  VIPService.getRecordList(action.payload, 200).then((data) {
    if (data.code == 200) {
      ctx.dispatch(VipOpenActionCreator.updateRecordList(data.data.list));
    }
  });
}

void _showRewardDialog(Action action, Context<VipOpenState> ctx) {
  //获取vip用户信息
  showDialog<Null>(
      context: ctx.context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return RewardSuccessDialog(getText(name: 'textReceivingSuccessful'), "${2}", () {});
          },
        );
      });
}

//领取奖励
void _reward(Action action, Context<VipOpenState> ctx) {
  //获取vip用户信息
  VIPService.reward().then((data) {
    if (data.code == 200) {
      _refreshData(action, ctx);
      showDialog<Null>(
          context: ctx.context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, state) {
                return RewardSuccessDialog(
                    getText(name: 'textReceivingSuccessful'), "${data.data.ptbCnt}", () {});
              },
            );
          });
    }
  });
}

void _getMemInfo(Action action, Context<VipOpenState> ctx) {
  //获取vip用户信息
  VIPService.getMemInfo().then((data) {
    if (data.code == 200) {
      ctx.dispatch(VipOpenActionCreator.updateMemberData(data.data));
    }
  });
}

void _refreshData(Action action, Context<VipOpenState> ctx) {
  ctx.dispatch(VipOpenActionCreator.getMemInfo());
  //获取记录
  ctx.dispatch(VipOpenActionCreator.getRecordList());
  ctx.dispatch(VipOpenActionCreator.getVipList());
}

void _didChangeDependencies(Action action, Context<VipOpenState> ctx) {
//  print("effect__didChangeAppLifecycleState");
//  var bool = ModalRoute.of(ctx.context).isCurrent;
//  if (bool) {
//    if (ctx.state.vipPayInfoData != null) {
//      queryOrder(ctx.state.vipPayInfoData.data.orderId, ctx);
//    }
//  }
}

void _dispose(Action action, Context<VipOpenState> ctx) {
//  _pauseSubscription.cancel();
}

bool queryOrder(String orderId, Context<VipOpenState> ctx) {
  VIPService.queryOrder(orderId).then((data) {
    if (data['code'] == 200 && data['data']['status'] == 2) {
      //跳转支付成功页面
      showToast(getText(name: 'textPaySuccessful'));
//      Navigator.of(ctx.context).pop();
      //通知个人中心刷新
      ctx.broadcast(MineFragmentActionCreator.getMemInfo());
      ctx.dispatch(VipOpenActionCreator.getMemInfo());
      ctx.dispatch(VipOpenActionCreator.getRecordList());
      ctx.dispatch(VipOpenActionCreator.getVipList());
      return true;
    } else {
      //支付失败
//      showToast("支付失败，请重试");
      return false;
    }
  });
}

void _onAction(Action action, Context<VipOpenState> ctx) {}

void _showRecordDialog(Action action, Context<VipOpenState> ctx) {
//  List<RecordMod> recordList = action.payload;
  showDialog<Null>(
      context: ctx.context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return VipRecordDialog(ctx.state.recordList, () {});
          },
        );
      });
}

void _showPayTypeDialog(Action action, Context<VipOpenState> ctx) {
  List<PayWayMod> payWayMods = action.payload["payWayMods"];
  VIPMod vipMod = action.payload["vipMod"];
  showDialog<Null>(
      context: ctx.context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return SelectPayTypeDialog(payWayMods, vipMod.realAmount,
                (payWayMod) {
              VIPService.openVip(vipMod.id, payWayMod.payWay).then((data) {
                ctx.dispatch(VipOpenActionCreator.updatePayInfoData(data));
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
                      CheckAppAvailability.checkAvailability(AppPlatform.WeChat, () {
                        launch(data.data.token);
                      });
                    } else {
                      AppUtil.gotoH5Web(ctx.context, data.data.token,
                              title: getText(name: 'textPay'), noHttpParam: true)
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
                //开始延时弹窗用户是否支付成功,延迟三秒
                Future.delayed(Duration(seconds: 3), () {
                  showDialog<Null>(
                      context: ctx.context, //BuildContext对象
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, state) {
                            return ConfirmPayDialog(payWayMod.payWay, (payWay) {
                              //获取vip用户信息
                              VIPService.getMemInfo().then((data) {
                                if (data.code == 200) {
                                  ctx.dispatch(
                                      VipOpenActionCreator.updateMemberData(
                                          data.data));
                                  if (ctx.state.memInfoData != null &&
                                      ctx.state.memInfoData.vipId > 0) {
                                    //已经开通了,后台这个接口会变
                                    _refreshData(action, ctx);
                                    Navigator.pop(context);
                                  } else {
                                    toPay(vipMod, payWayMod, ctx, action);
                                  }
                                } else {
                                  toPay(vipMod, payWayMod, ctx, action);
                                }
                              });
                            }, () {
                              //支付成功回调
                              _refreshData(action, ctx);
                            });
                          },
                        );
                      });
                });
              });
            });
          },
        );
      });
}

void toPay(VIPMod vipMod, PayWayMod payWayMod, Context<VipOpenState> ctx,
    Action action) {
  VIPService.openVip(vipMod.id, payWayMod.payWay).then((data) {
    ctx.dispatch(VipOpenActionCreator.updatePayInfoData(data));
    _refreshData(action, ctx);
    //继续支付
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
          launch(data.data.token).then((value) {
            //页面返回的时候
            print("支付成功");
            //           queryOrder(data.data.orderId, ctx);
          });
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
          AppUtil.gotoH5Web(ctx.context, data.data.token, title: getText(name: 'textPay'), noHttpParam: true)
              .then((d) {
            queryOrder(data.data.orderId, ctx);
          });
        }
      } else {
        WxPayImpl().startPay(data.data.token).then((payInfo) {
          print("wxpay----------------------");
          queryOrder(data.data.orderId, ctx);
        });
      }
    }
  });
}
